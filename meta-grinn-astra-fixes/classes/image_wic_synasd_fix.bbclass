#
# Copyright 2026 Grinn sp. z o.o.
#
# SPDX-License-Identifier: MIT
#
# Workaround for image_wic_synasd from meta-synaptics.
#
# synasdimg_generate_wks() decompresses SYNAIMG/<name>.subimg.gz to
# DEPLOY_DIR_IMAGE/<name>.subimg only when that file does not exist yet.
# image_synaimg writes the bl, boot and tzk images as bootloader,
# linux_bootimgs and tee, and synasdk-fastlogo deploys only
# fastlogo.subimg.gz. The copies from the first build are never updated,
# so later SD card images get an old bootloader, kernel, TEE and fastlogo.
#
# Decompress these images again before the wks file is generated. The
# file is replaced atomically, because DEPLOY_DIR_IMAGE is shared with
# the other images of the machine.

SYNASD_SUBIMGS ?= "bl.subimg boot.subimg tzk.subimg fastlogo.subimg"

do_write_wks_template[prefuncs] =+ "synasd_refresh_subimgs"

python synasd_refresh_subimgs () {
    import gzip
    import os
    import shutil

    deploydir = d.getVar('DEPLOY_DIR_IMAGE')
    synaimgdir = os.path.join(deploydir, d.getVar('SYNAIMG_DEPLOY_SUBDIR'))

    for name in (d.getVar('SYNASD_SUBIMGS') or '').split():
        src_path = os.path.join(synaimgdir, name + '.gz')
        if not os.path.exists(src_path):
            continue
        dst_path = os.path.join(deploydir, name)
        tmp_path = '%s.%s.tmp' % (dst_path, d.getVar('PN'))
        with gzip.open(src_path, 'rb') as f_in, open(tmp_path, 'wb') as f_out:
            shutil.copyfileobj(f_in, f_out)
        os.replace(tmp_path, dst_path)
}
