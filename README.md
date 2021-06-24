# Google Assistant Rotary Phone

- For running no-hail Google Assistant from an old rotary phone, according to [these instructions](https://www.tomshardware.com/how-to/turn-a-rotary-phone-into-google-assistant-with-raspberry-pi).
- Forked and modified because I couldn't get it working per https://github.com/googlesamples/assistant-sdk-python/issues/267 and the 'Illegal instruction' result of manually compiling the grpcio package (current at v1.38.1). Instead, pinned the grpcio version at v1.11.0 in `deployment/install.sh` and using pre-compiled binaries.
- Pi 3 can fit in a 1972 Bell 500 under the rotary dial, you just have to remove it temporarily to get it in there. But USB will peripheral will stick out too much, so using with a Pi 0W
- This was also a helpful resource for getting the speaker and mic working with an external USB audio interface: https://raspberrypi.stackexchange.com/questions/80072/how-can-i-use-an-external-usb-sound-card-and-set-it-as-default. Just skip the creation of `./asoundrc` to avoid sample rate issues

