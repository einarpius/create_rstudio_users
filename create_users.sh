#!/bin/bash

# Get the group from the first argument
GROUP=$1
# ignore first argument in future processing
shift
# The location where home directories are created
HOME_BASE='/home'

# Greate a new group if the desired group does not exist
[ $(getent group $GROUP) ] || sudo groupadd $GROUP

# iterate over the rest of arguments
while test ${#} -gt 0
do
  # Get the user name from the next argument
  USER=$1
  echo "Creating user $USER"
  # Create the user
  # -m creates the user's home directory if it does not exist.
  # -d specifies the home directory.
  # -G adds additional groups for the user.
  # The last argument is the new username.
  sudo useradd -m -d $HOME_BASE/$USER -G $GROUP,"rstudio-users" $USER
  # Set the user's initial password to the same as the username.
  echo "$USER:$USER" | sudo chpasswd
  shift
done
