#!/bin/sh

export XDG_RUNTIME_DIR=/var/run/user/0
export WAYLAND_DISPLAY=wayland-1

PLATFORM="none"
CSI0_DEV="none"
CSI1_DEV="none"

show_usage() {
    echo "Usage:"
    echo "  $0 <csi_selector>"
    echo ""
    echo "csi_selector:"
    echo "  0    CSI0 interface"
    echo "  1    CSI1 interface"
}

get_csi_selector() {
    case "$ARG" in
        0)
            CSI_SEL="CSI0"
            ;;
        1)
            CSI_SEL="CSI1"
            ;;
        *)
            echo "Invalid CSI interface selected!"
            show_usage
            exit 1
            ;;
    esac
}

get_video_devices() {
    eval "$(v4l2-ctl --list-devices | awk '
        BEGIN {
            found = ""
        }
        /vvcam-video\.0\.0 \(platform:vvcam-video\.0\.0\):/ {
            found = "CSI0"
            next
        }
        /vvcam-video\.0\.4 \(platform:vvcam-video\.0\.4\):/ {
            found = "CSI1"
            next
        }
        /^[[:space:]]*\/dev\/video[0-9]+/ {
            if (found == "CSI0") {
                print "CSI0_DEV=" $1
                found = ""
            } else if (found == "CSI1") {
                print "CSI1_DEV=" $1
                found = ""
            }
        }
    ')"
}

get_platform() {
    local HOSTNAME
    HOSTNAME=$(uname -n)

    case "$HOSTNAME" in
        *-evb)
            PLATFORM="EVB"
            ;;
        *-ada)
            PLATFORM="ADA"
            ;;
        *)
            PLATFORM="none"
            ;;
    esac
}

start_pipeline() {
    local VIDEO_DEV

    if [ "$CSI_SEL" = "CSI0" ]; then
        VIDEO_DEV=$CSI0_DEV
    else
        VIDEO_DEV=$CSI1_DEV
    fi

    if [ "$VIDEO_DEV" = "none" ]; then
        echo "Video device not available - cannot start pipeline"
        exit 1
    fi

    gst-launch-1.0 v4l2src device=$VIDEO_DEV ! 'video/x-raw, format=(string)NV12, width=(int)640, height=(int)480, framerate=(fraction)30/1' ! waylandsink
}

enable_sensor() {
    local LED_GPIO
    local PWR_GPIO
    local EN_STATE
    local DO_ENABLE="false"

    case "$PLATFORM" in
        ADA)
            if [ "$CSI_SEL" = "CSI0" ]; then
                LED_GPIO="GPIO_CSI0"
                PWR_GPIO="PWR_ON_CSI0"
            else
                LED_GPIO="GPIO_CSI1"
                PWR_GPIO="PWR_ON_CSI1"
            fi

            EN_STATE="1"
            DO_ENABLE="true"
            ;;
        EVB)
            if [ "$CSI_SEL" = "CSI0" ]; then
                LED_GPIO="LED_ENn"
                PWR_GPIO="PWR_ENn"
                DO_ENABLE="true"
            fi

            EN_STATE="0"
            ;;
        *)
            echo "Unknown platform - cannot enable sensor"
            exit 1
            ;;
    esac

    if [ "$DO_ENABLE" = "true" ]; then
        gpioset `gpiofind $PWR_GPIO`=$EN_STATE
        gpioset `gpiofind $LED_GPIO`=$EN_STATE
    fi
}

ARG=$1

if [ -z $ARG ]; then
    show_usage
    exit 1
fi

get_csi_selector
get_video_devices
get_platform

echo "PLATFORM=$PLATFORM"
echo "CSI0_DEV=$CSI0_DEV"
echo "CSI1_DEV=$CSI1_DEV"
echo "CSI_SEL=$CSI_SEL"

enable_sensor
start_pipeline

