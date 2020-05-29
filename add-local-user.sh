#!/bin/bash

# Create a script that adds users to a Linux system.

# Variables

# Make sure that the user executing the script is superuser (root).
if [[ "${UID}" -ne 0 ]]
then
	echo 'Script must be run as superuser (root).'
	exit 1
fi

# Get the username of the account to be created.
read -p 'Enter the user name: ' USERNAME

# Get the name of the user the account is being created for.
read -p 'Enter the name of the user the account is being created for: ' COMMENT

# Get the password to set for the user account being created.
read -p 'Enter the password: ' PASSWORD

# Create user account
useradd -c "${COMMENT}" -m "${USERNAME}"

if [[ "${?}" -ne 0 ]]
then
	echo 'Unable to create user account.'
	exit 1
fi

echo "${PASSWORD}" | passwd --stdin "${USERNAME}"

if [[ "${?}" -ne 0 ]]
then
	echo 'The password for the account could not be set.'
fi

passwd -e "${USERNAME}"

echo
echo 'Account created successfully!'
echo '============================='
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Host: ${HOSTNAME}"

exit 0
