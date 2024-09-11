#!/bin/bash

# Ensure SSH agent is running and add the private key
eval "$(ssh-agent -s)"
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -

# Add GitHub to known hosts (to avoid SSH prompt during deployment)
mkdir -p ~/.ssh
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Continue with the regular build process
npm install --prefix smart-vote-app
npm run build --prefix smart-vote-app