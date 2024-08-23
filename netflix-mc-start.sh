#!/bin/bash

if [ ${EUID} -ne 0 ]
then
  ehco "Error : This file is meant to be run as root."
	exit 1 # this is meant to be run as root
fi

#Bind the server and run it as a linux service
source venv/bin/activate
python app.py

