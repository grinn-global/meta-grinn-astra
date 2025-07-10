#!/bin/sh

export XDG_RUNTIME_DIR=/var/run/user/0
export WAYLAND_DISPLAY=wayland-1

PLATFORM="none"
CSI0_DEV="none"
CSI1_DEV="none"

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

    case "$PLATFORM" in
        ADA)
            VIDEO_DEV=$CSI1_DEV
            ;;
        EVB)
            VIDEO_DEV=$CSI0_DEV
            ;;
        *)
            echo "Unknown platform - cannot start pipeline"
            exit 1
            ;;
    esac

    if [ "$VIDEO_DEV" = "none" ]; then
        echo "No video device detected - cannot start pipeline"
        exit 1
    fi

    gst-launch-1.0 v4l2src device=$VIDEO_DEV ! 'video/x-raw, format=(string)NV12, width=(int)640, height=(int)480, framerate=(fraction)30/1' ! waylandsink
}

enable_sensor() {
    local LED_GPIO
    local PWR_GPIO
    local EN_STATE

    case "$PLATFORM" in
        ADA)
            LED_GPIO="GPIO_CSI1"
            PWR_GPIO="PWR_ON_CSI1"
            EN_STATE="1"
            ;;
        EVB)
            LED_GPIO="LED_ENn"
            PWR_GPIO="PWR_ENn"
            EN_STATE="0"
            ;;
        *)
            echo "Unknown platform - cannot enable sensor"
            exit 1
            ;;
    esac

    gpioset `gpiofind $PWR_GPIO`=$EN_STATE
    gpioset `gpiofind $LED_GPIO`=$EN_STATE
}

get_video_devices
get_platform

echo "PLATFORM=$PLATFORM"
echo "CSI0_DEV=$CSI0_DEV"
echo "CSI1_DEV=$CSI1_DEV"

enable_sensor
start_pipeline

