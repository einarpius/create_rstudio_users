# Adding users to your RStudio Server

```
./create_users.sh [group] $(cat userlist)
```

Remember to change `[group]` to something better, e.g., `cohort01`. The `userlist` file contains usernames for the new users. Passwords will be the same as the username. Get them to change after loging in by typing `passwd` into the Terminal.

# Copying a folder to each user in a group:

```
./group_add_dir.sh -g [group] -d [materials_folder] -n [materials_folder_newname]
```

This will not overwrite existing files. Therefore, can be run many times to add additional files.

Example:

```
./group_add_dir.sh -g cohort01 -d participant_copy -n Training
```

## Tested on Debian and Ubuntu.
