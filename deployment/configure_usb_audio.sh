#!/bin/bash
# configure_usb_audio.sh
# Configures the pi zero to use the USB audio card as a default

echo "Listing audio cards"
aplay -l

CONFIG_PATH=/usr/share/alsa/alsa.conf
sudo cp $CONFIG_PATH $CONFIG_PATH.bak

echo "Setting output defaults for pi: $USB_SOUND_CARD"
sudo sed -i "s/defaults.ctl.card [0-9]/defaults.ctl.card $USB_SOUND_CARD/g" $CONFIG_PATH
sudo sed -i "s/defaults.pcm.card [0-9]/defaults.pcm.card $USB_SOUND_CARD/g" $CONFIG_PATH

echo "Setting volumes"
amixer sset Master 75%
amixer sset Capture 75%

echo "Configure volumes with command: alsamixer"
