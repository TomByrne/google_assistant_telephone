#!/bin/bash
# install.sh

cd ../
sudo apt-get update
sudo apt-get install -y \
        python3-pip \
        libffi-dev \
        libssl-dev \
        portaudio19-dev
python3 -m pip install virtualenv
python3 -m virtualenv -p python3 env
. env/bin/activate

pip install --upgrade pip
pip install grpcio -Iv grpcio==1.11.0

pip install -r src/requirements.txt
