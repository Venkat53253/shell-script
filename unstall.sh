#!/bin/bash

userid=$(id -u)
if [ $userid -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

dnf remove -y mysql-server 
if [ $? -ne 0 ]; then
    echo "Failed to remove MySQL server"
    exit 10
fi

dnf remove -y nginx
if [ $? -ne 0 ]; then
    echo "Failed to remove Nginx"
    exit 20
fi


# Check if any usernames are provided as arguments
if [ -z "$@" ]; then
    echo "Usage: $0 <username1> [username2] ..."
    echo "Example: $0 venkat suresh ravi"
    exit 1
fi

# Loop through each provided username and add them
for username in "$@"; do
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists. Skipping."
    else
        echo "Adding user '$username'..."
        # Add the user.
        # -m creates the home directory if it doesn't exist.
        # -s /bin/bash sets the default shell to Bash.
        # -G users adds the user to the 'users' group (optional, but common).
        if useradd -m -s /bin/bash -G users "$username"; then
            echo "User '$username' added successfully."
            # You might want to set a default password or force password change on first login
            # For security, avoid hardcoding passwords in scripts.
            # You could prompt for passwords or use a temporary password
            # echo "$username:temporary_password" | chpasswd
            # passwd -e "$username" # Forces password change on first login
        else
            echo "Error: Failed to add user '$username'."
        fi
    fi
done

echo "Script finished."