#!/bin/sh

export XDG_RUNTIME_DIR=/var/run/user/0
export WAYLAND_DISPLAY=wayland-1

HDMI_RX_DEV="none"

get_hdmi_rx_device() {
    eval "$(v4l2-ctl --list-devices | awk '
        /^synaptics-hrx \(platform: syna-hrx\):$/ {
            getline
            if ($1 ~ /^\/dev\/video[0-9]+$/) {
                print "HDMI_RX_DEV=" $1
            }
        }
    ')"
}

start_pipeline() {
    if [ "$HDMI_RX_DEV" = "none" ]; then
        echo "HDMI RX device not available - cannot start pipeline"
        exit 1
    fi

    gst-launch-1.0 v4l2src device=$HDMI_RX_DEV ! video/x-raw,width=1920,height=1080,fps=30,format=NV12 ! waylandsink fullscreen=true
}

get_hdmi_rx_device

echo "HDMI_RX_DEV=$HDMI_RX_DEV"

start_pipeline

