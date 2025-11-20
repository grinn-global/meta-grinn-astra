#!/bin/sh

DMIC_HW="none"
HDMI_HW="none"
REC_FILE_NAME="dmic_rec"

show_usage() {
    echo "Usage:"
    echo "  $0 <sink_selector>"
    echo ""
    echo "sink_selector:"
    echo "  file  Store DMIC stream to a file"
    echo "  hdmi  Pass DMIC stream to the HDMI output"
}

get_sink_selector() {
    case "$ARG" in
        file)
            SINK="FILE"
            ;;
        hdmi)
            SINK="HDMI"
            ;;
        *)
            echo "Invalid DMIC sink selected!"
            show_usage
            exit 1
            ;;
    esac
}

get_dmic_hw() {
    DMIC_HW=`arecord -l | sed -n 's/^card \([0-9]\+\):.*device \([0-9]\+\):.*soc-dmic.*/\1,\2/p'`
}

get_hdmi_hw() {
    HDMI_HW=`aplay -l | sed -n 's/^card \([0-9]\+\):.*device \([0-9]\+\):.*soc-hdmio.*/\1,\2/p'`
}

start_file_pipeline() {
    echo ""
    echo "Storing DMIC to a file:"
    echo "`pwd`/${REC_FILE_NAME}.aac"
    echo ""
    gst-launch-1.0 -e \
        alsasrc device=hw:$DMIC_HW ! \
        audioconvert ! \
        audio/x-raw,format=S16LE,rate=48000,channels=2 ! \
        fdkaacenc afterburner=1 bitrate=192000 ! \
        aacparse ! \
        audio/mpeg,mpegversion=4,stream-format=adts ! \
        filesink location=${REC_FILE_NAME}.aac
}

start_hdmi_pipeline() {
    echo ""
    echo "Streaming DMIC to HDMI..."
    echo ""
    gst-launch-1.0 -e \
        alsasrc device=hw:$DMIC_HW ! \
        audio/x-raw,format=S32LE,rate=48000,channels=2 ! \
        alsasink device=hw:$HDMI_HW sync=false async=false buffer-time=40000 latency-time=10000
}

ARG=$1

if [ -z $ARG ]; then
    show_usage
    exit 1
fi

get_sink_selector
echo "SINK: $SINK"

get_dmic_hw
echo "DMIC HW: $DMIC_HW"

if [ "$DMIC_HW" == "none" ]; then
    echo "DMIC HW is not available!"
    exit 1
fi

if [ "$SINK" == "FILE" ]; then
    start_file_pipeline
else
    get_hdmi_hw
    echo "HDMI HW: $HDMI_HW"

    if [ "$HDMI_HW" == "none" ]; then
        echo "HDMI HW is not available!"
        exit 1
    fi

    start_hdmi_pipeline
fi
