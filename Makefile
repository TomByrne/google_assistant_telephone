PI_IP_ADDRESS=10.0.0.10
PI_USERNAME=pi


.PHONY: copy
copy:
	@rsync -a $(shell pwd) --exclude env $(PI_USERNAME)@$(PI_IP_ADDRESS):/home/$(PI_USERNAME) 

.PHONY: install
install:
	@cd deployment && bash install.sh

.PHONY: run
run:
	@. env/bin/activate && cd src && python app.py

.PHONY: test
test:
	@echo "Say Something for the next 5 seconds"
	@arecord --device=hw:1,0 --format=S16_LE --rate=44100 --duration=5 -c1 -V mono test.wav
	@echo "You should hear your voice back"
	@aplay -D plughw:1,0 test.wav
	@rm -rf test.wav
	@echo "You should hear your voice back"

.PHONY: shell
shell:
	@ssh $(PI_USERNAME)@$(PI_IP_ADDRESS)

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
