# Adding users to your RStudio Server

```
./create_users.sh [group] $(cat userlist)
```

Remember to change `[group]` to something better, e.g., `cohort01`.

# Copying a folder to each user in a group:

```
./group_add_dir.sh -g [group] -d [materials_folder] -n [materials_folder_newname]
```

This will not overwrite existing files. Therefore, can be run many times to add additional files.

Example:

```
./group_add_dir.sh -g cohort01 -d participant_copy -n Training
```

Tested on Debian and Ubuntu.
