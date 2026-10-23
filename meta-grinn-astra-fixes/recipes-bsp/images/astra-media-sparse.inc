# The SL1680 USB boot images of astra-update (up to v2.0.4) use U-Boot 2019.10.
# Its sparse image writer computes the chunk size as blk_sz * chunk_sz in
# 32 bits, so a chunk of 4 GiB or more wraps around. Every 300 MiB part of the
# split rootfs starts with a DONT_CARE chunk over the data of the previous
# parts. When the rootfs data grows past 4 GiB, the data of the next parts is
# written 4 GiB too low, over the start of the filesystem. Split the DONT_CARE
# and FILL chunks into chunks of at most 2 GiB. Only the chunk headers change,
# the written data is the same.
SPARSE_MAX_CHUNK_SIZE = "2147483648"

def sparse_split_chunks(path, max_chunk_size):
    import os
    import struct

    SPARSE_HEADER = "<IHHHHIIII"
    CHUNK_HEADER = "<HHII"
    CHUNK_TYPE_FILL = 0xCAC2
    CHUNK_TYPE_DONT_CARE = 0xCAC3

    with open(path, "rb") as src:
        header = list(struct.unpack(SPARSE_HEADER, src.read(struct.calcsize(SPARSE_HEADER))))
        magic, _, _, file_hdr_sz, chunk_hdr_sz, blk_sz, total_blks, total_chunks, _ = header
        if magic != 0xED26FF3A:
            bb.fatal("%s: not a sparse image" % path)
        if file_hdr_sz != struct.calcsize(SPARSE_HEADER) or chunk_hdr_sz != struct.calcsize(CHUNK_HEADER):
            bb.fatal("%s: unsupported sparse header size" % path)

        max_blks = max_chunk_size // blk_sz
        chunks = []
        blks = 0
        split = 0
        for _ in range(total_chunks):
            chunk_type, _, chunk_sz, total_sz = struct.unpack(CHUNK_HEADER, src.read(chunk_hdr_sz))
            chunks.append((chunk_type, chunk_sz, total_sz, src.tell()))
            src.seek(total_sz - chunk_hdr_sz, os.SEEK_CUR)
            blks += chunk_sz
            if chunk_sz > max_blks:
                if chunk_type not in (CHUNK_TYPE_FILL, CHUNK_TYPE_DONT_CARE):
                    bb.fatal("%s: data chunk larger than %d bytes" % (path, max_chunk_size))
                split += 1
        if blks != total_blks:
            bb.fatal("%s: chunks cover %d blocks, header says %d" % (path, blks, total_blks))
        if not split:
            return 0

        tmp = path + ".tmp"
        with open(tmp, "wb") as dst:
            dst.write(struct.pack(SPARSE_HEADER, *header))
            new_chunks = 0
            for chunk_type, chunk_sz, total_sz, data_offset in chunks:
                src.seek(data_offset)
                if chunk_sz <= max_blks:
                    dst.write(struct.pack(CHUNK_HEADER, chunk_type, 0, chunk_sz, total_sz))
                    remaining = total_sz - chunk_hdr_sz
                    while remaining:
                        data = src.read(min(remaining, 8 << 20))
                        dst.write(data)
                        remaining -= len(data)
                    new_chunks += 1
                    continue

                payload = src.read(total_sz - chunk_hdr_sz)
                while chunk_sz:
                    part = min(chunk_sz, max_blks)
                    dst.write(struct.pack(CHUNK_HEADER, chunk_type, 0, part, total_sz))
                    dst.write(payload)
                    chunk_sz -= part
                    new_chunks += 1

            header[7] = new_chunks
            dst.seek(0)
            dst.write(struct.pack(SPARSE_HEADER, *header))

    os.replace(tmp, path)
    return split

python synaimg_split_sparse_chunks () {
    import glob
    import os

    synaimg_dir = os.path.join(d.getVar("DEPLOY_DIR_IMAGE"), d.getVar("SYNAIMG_DEPLOY_SUBDIR"))
    max_chunk_size = int(d.getVar("SPARSE_MAX_CHUNK_SIZE"))

    for path in sorted(glob.glob(os.path.join(synaimg_dir, "*_s.subimg*"))):
        split = sparse_split_chunks(path, max_chunk_size)
        if split:
            bb.note("%s: split %d sparse chunks" % (os.path.basename(path), split))
}

python () {
    if "grinn-astra-1680-platform" not in d.getVar("MACHINEOVERRIDES").split(":"):
        return

    d.appendVarFlag("do_image_synaimg", "postfuncs", " synaimg_split_sparse_chunks")
}
