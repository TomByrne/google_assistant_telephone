export USB_SOUND_CARD=2

# Run this to set up dependencies
.PHONY: install
install:
	@cd deployment && bash install.sh

# Run the app itself
.PHONY: run
run:
	@. env/bin/activate && cd src && python app.py

# Test the speaker/mic connection
.PHONY: test
test:
	@echo "Say Something for the next 5 seconds"
	#@arecord --device=hw:$(USB_SOUND_CARD),0 --format=S16_LE --rate=44100 --duration=5 -c1 -V mono test.wav
	@arecord -D plughw:$(USB_SOUND_CARD),0 --duration=5 test.wav
	@echo "You should hear your voice back"
	#@aplay -D plughw:$(USB_SOUND_CARD),0 test.wav
	@aplay test.wav
	@rm -rf test.wav
	@echo "You should hear your voice back"

# Auth with google API
.PHONY: authenticate
authenticate:
	@. env/bin/activate && cd deployment && bash get_account_credentials.sh


.PHONY: configure-audio
configure-audio:
	@cd deployment && bash configure_usb_audio.sh

.PHONY: configure-on-boot
configure-on-boot:
	@echo "Configuring /etc/rc.local"
	@cd deployment && bash configure_on_boot.sh
