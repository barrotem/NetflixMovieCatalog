#!/bin/bash

#According to NetflixMovieCatalog's CD workflow, this script will be run from the home directory on the ubuntu machine.
#Verify venv and requirements installations and restart the server according to the new application code.

cd ~/app/
if [[ -d venv ]]
then
  #If the venv directory exists under the App's repo, verify requirements
  source venv/bin/activate #Active venv
  #Issue pip freeze to list all installed packages with regards to requirements file.
  #Redirect stderror to stdout (terminal), redirect stdout to /dev/null.
  #Pass stderror (now stdout) of pip freeze to grep, looking for missing packages errors.
  unsatisfied_req=$(pip freeze -r requirements.txt 2>&1 1>/dev/null | grep -q "WARNING")
  if [[ $unsatisfied_req -eq 0 ]]
  then
    echo "[$PWD/deploy.sh:ERROR]: Unsatisfied requirements for running NetflixMovieCatalog. Installing requirements."
    #Some packages are missing, install requirements
    pip install -r requirements.txt
  else
    echo "[$PWD/deploy.sh:SUCCESS]: All requirements already satisfied. Preparing to run Netflix-MC"
  fi
else
  #The venv directory doesn't exist. Perform full requirements installation according to README.md
  #Create a python virtualenv and activate it
  echo "[$PWD/deploy.sh:ERROR]: Python venv was not found for NetflixMovieCatalog. Installing requirements."
  python3 -m venv venv
  source venv/bin/activate
  pip install -r requirements.txt
fi
#We are done checking requirements, restart the netflix-movie-catalog service in order to host the new server configuration.
#Make sure to reload daemons, for the netflix-mc.service might have changed
sudo systemctl daemon-reload
sudo systemctl restart netflix-mc.service
if [[ -e mykey.pem ]]
then
  #Remove erroneous file, copied due to scp's recurse
  rm mykey.pem
fi
