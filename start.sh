#!/bin/bash
if [[ ! -f './pass.txt' ]] || [[ $1 == '-n' ]]; then
    read -p "Enter a password for the user> " pass
    echo $pass > pass.txt && echo "Password saved in pass.txt. Don't forget to delete later"
else
    pass=$(<pass.txt)
fi

PASSWORD=$pass docker compose up --build && echo $PASSWORD && unset PASSWORD