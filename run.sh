#!/bin/bash

echo "====== Package Updater ======"
echo "1. Install/Update All"
echo "2. Show Versions"
echo "3. Exit"

read -p "Choose option: " choice

if [ "$choice" == "1" ]; then
    sudo ./updater.sh
elif [ "$choice" == "2" ]; then
    java -version
    mvn -version
    python3 --version
    nginx -v
    git --version
else
    echo "Exiting..."
fi
