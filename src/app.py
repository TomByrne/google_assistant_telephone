
import RPi.GPIO as GPIO
import time
import logging
import os
from os.path import dirname
from google_assistant import GoogleAssistant


assistant = GoogleAssistant()
logging.basicConfig(level=logging.INFO)


pin_number = 18


def phone_picked_up():
    """Called when the phone is picked up"""
    logging.info('Receiver picked up')
    root = dirname(os.getcwd())
    os.system('aplay {}/internal-ring.wav'.format(root))
    continue_assist = True
    while continue_assist:
        continue_assist = assistant.assist()
        if GPIO.input(pin_number) == 0:
            logging.info('Assistant responded, aborting due to hang up')
            continue_assist = False
        elif continue_assist:
            logging.info('Assistant responded, continuing conversation')
        else:
            logging.info('Assistant responded, conversation ended')


def phone_hung_up():
    """Called when the phone is hung up"""
    logging.info('Receiver hung up')


def listen_for_hook_state_change():
    """Continuously listens for pickup/hangup of the hook"""
    logging.info('Listening for hook changes')
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(pin_number, GPIO.IN, pull_up_down=GPIO.PUD_UP)

    # Assume we start in a hung-up state to avoid `phone_hung_up` getting called immediately
    pin_current = 0
    try:
        while True:
            # Wait for pin to change state
            while GPIO.input(pin_number) == pin_current:
                time.sleep(0.1)

            pin_current = GPIO.input(pin_number)
            if pin_current == 1:
                phone_picked_up()
            else:
                phone_hung_up()

    except KeyboardInterrupt:
        print('Exiting...')
        GPIO.cleanup()


if __name__ == "__main__":
    listen_for_hook_state_change()
