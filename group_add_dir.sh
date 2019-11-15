#!/bin/bash

# Process command line arguments
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -g|--group)
    GROUP="$2"
    shift # past argument
    ;;
    -d|--dir)
    DIR="$2"
    shift # past argument
    ;;
    -n|--new_name)
    DIR_NAME="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

if [ -z "$GROUP" ]; then
  echo "Please specify the group using argument: -g <group name>"
  exit 1
fi

if [ -z "$DIR" ]; then
  echo "Please specify the directory to copy using argument -d <directory>"
  exit 1
elif [ ! -d "$DIR" ]; then
  echo "\"$DIR\" does not exist or is not a directory"
  exit 1
fi

# Iterate over all users in the group
getent group $GROUP | awk -F: '{print $4}' | sed -n 1'p' | tr ',' '\n' | while read USER; do
  echo "Copying directory \"$DIR\" to home directory of user \"$USER\""
  # Find the user's home directory
  USER_HOME=$(awk -F: -v v="$USER" '{if ($1==v) print $6}' /etc/passwd)
  # Copy to the user's home directory
  TARGET_DIR=$USER_HOME/$DIR_NAME
  echo $TARGET_DIR
  sudo mkdir $TARGET_DIR
  sudo cp -r -n $DIR/* $TARGET_DIR
  # Change the permissions of the copied directory
  sudo chown -R $USER:$USER $TARGET_DIR
done




