#!/bin/bash

echo "------------------------------------------"
echo "Select an option:"
echo "0) Create Docker volume"
echo "1) Run local (ARM64, Alpine)"
echo "2) Run local (AMD64, Ubuntu)"
echo "------------------------------------------"
echo "3) Run pulled version (ARM64, Alpine)"
echo "4) Run pulled version (AMD64, Ubuntu)"
echo "------------------------------------------"
echo "5) Exit"

# Read user input
read -p "Enter your choice [0-5]: " choice

case $choice in
    0)
        echo "Creating Docker volume: actual-budget-data"
        docker volume create actual-budget-data
        ;;
    1)
        docker run --pull=never --restart=unless-stopped -d \
          -p 5006:5006 \
          --mount source=actual-budget-data,target=/data \
          --name actual-budget-athos-arm64 \
          athos9204/actual-budget-athos-arm64:latest
        ;;
    2)
        docker run --pull=never --restart=unless-stopped -d \
          -p 5006:5006 \
          --mount source=actual-budget-data,target=/data \
          --name actual-budget-athos-amd64 \
          athos9204/actual-budget-athos-amd64:latest
        ;;
    3)
        docker run --restart=unless-stopped -d \
          -p 5006:5006 \
          --mount source=actual-budget-data,target=/data \
          --name actual-budget-athos-arm64 \
          athos9204/actual-budget-athos-arm64:latest
        ;;
    4)
        docker run --restart=unless-stopped -d \
          -p 5006:5006 \
          --mount source=actual-budget-data,target=/data \
          --name actual-budget-athos-amd64 \
          athos9204/actual-budget-athos-amd64:latest
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Please enter a number between 0 and 5."
        ;;
esac
