#!/bin/bash

# Define the options
echo "Select a build option:"
echo "1) Build & load (ARM64, Alpine) - MAC"
echo "2) Build & load (AMD64, Ubuntu) - UBUNTU"
echo "------------------------------------------"
echo "3) Build & push (ARM64, Alpine) - MAC"
echo "4) Build & push (AMD64, Ubuntu) - UBUNTU"
echo "------------------------------------------"
echo "5) Exit"

# Read user input
read -p "Enter your choice [1-5]: " choice

case $choice in
    1)
        cp packages/sync-server/docker/stable-alpine.Dockerfile stable-alpine.Dockerfile
        docker buildx build --no-cache --platform linux/arm64 -f stable-alpine.Dockerfile -t athos9204/actual-budget-athos-arm64 --load .
        ;;
    2)
        cp packages/sync-server/docker/stable-ubuntu.Dockerfile stable-ubuntu.Dockerfile
        docker buildx build --no-cache --platform linux/amd64 -f stable-ubuntu.Dockerfile -t athos9204/actual-budget-athos-amd64 --load .
        ;;
    3)
        cp packages/sync-server/docker/stable-alpine.Dockerfile stable-alpine.Dockerfile
        docker buildx build --no-cache --platform linux/arm64 -f stable-alpine.Dockerfile -t athos9204/actual-budget-athos-arm64 --push .
        ;;
    4)
        cp packages/sync-server/docker/stable-ubuntu.Dockerfile stable-ubuntu.Dockerfile
        docker buildx build --no-cache --platform linux/amd64 -f stable-ubuntu.Dockerfile -t athos9204/actual-budget-athos-amd64 --push .
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Please enter a number between 1 and 5."
        ;;
esac
