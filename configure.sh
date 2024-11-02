#!/bin/bash


VIRTUALENV="$(pwd -P)/.venv"
PYTHON="${PYTHON:-python3}"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Verify if curl is installed
COMMAND="curl --version | grep -oP 'curl.?\d+\.?\d+\.?\d+'"
eval $COMMAND || {
    echo -e "$RED ERROR: can not continue with localstack instalation$NC"
    echo -e "$RED Unable to find 'curl' installed$NC"
}

# Creating local stack base folder
if [ -d "$(pwd -P)/localstack" ]; then
    COMMAND="rm -rf ./localstack"
    echo -e "$GREEN Removing old localstack folder$NC"
    eval $COMMAND
fi

COMMAND="mkdir $(pwd -P)/localstack"
echo -e "$GREEN Creating localstack base folder$NC"
eval $COMMAND || exit 1

# Download localstack CLI
echo -e "$GREEN Downloading localstack...$NC"
curl --output $(pwd -P)/localstack/localstack-cli-3.8.0-linux-amd64-onefile.tar.gz \
    --location https://github.com/localstack/localstack-cli/releases/download/v3.8.0/localstack-cli-3.8.0-linux-amd64-onefile.tar.gz


#Install localstack binary
COMMAND="cd $(pwd -P)/localstack"
eval $COMMAND

COMMAND="sudo tar xvzf $(pwd -P)/localstack-cli-3.8.0-linux-*-onefile.tar.gz -C /usr/local/bin"
eval $COMMAND || exit 1
eval "cd .."

#Cleanup installation
COMMAND="rm -rf $(pwd -P)/localstack"
echo -e "$GREEN Removing localstack base folder$NC"
eval $COMMAND


# Create a new virtual environment
COMMAND="${PYTHON} -m venv \"${VIRTUALENV}\""
echo -e "$GREEN Creating a new virtual environment at ${VIRTUALENV} ...$NC"
eval $COMMAND || {
  echo "--------------------------------------------------------------------"
  echo "ERROR: Failed to create the virtual environment. Check that you have"
  echo "the required system packages installed and the following path is"
  echo "writable: ${VIRTUALENV}"
  echo "--------------------------------------------------------------------"
  exit 1
}

# Activate the virtual environment
source "${VIRTUALENV}/bin/activate"

# Upgrade pip
COMMAND="pip install --upgrade pip"
echo -e "$GREEN Updating pip ($COMMAND)...$NC"
eval $COMMAND || exit 1
pip -V

# Installing awscli-local
COMMAND="pip install \"awscli-local[ver1]\""
echo -e "$GREEN Installing awscli-local...$NC"
eval $COMMAND || exit 1
