# MIT License

# Copyright (c) [2023] [Dave Vermeulen]

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


#!/bin/bash

# Clear the terminal
clear

# Download the SDRplay API
api_file="SDRplay_RSP_API-Linux-3.07.1.run"
api_url="https://www.sdrplay.com/software/$api_file"

echo "Downloading $api_file..."
wget "$api_url"

# Change permissions for the run file
chmod 755 "./$api_file"

# Execute the API installer
echo "Running $api_file..."
./"$api_file"

# Clear the terminal
clear

echo "SDRplay script to download, build, and install RSPTCPServer"

# Set the installation directory
INSTALL_DIR=~/Dev/RSPTCPServer

# Set required packages
REQUIRED_PACKAGES="git cmake build-essential"

# Check if required packages are already installed
echo "Checking required packages..."
MISSING_PACKAGES=()
for package in $REQUIRED_PACKAGES; do
    if ! dpkg -s "$package" >/dev/null 2>&1; then
        MISSING_PACKAGES+=("$package")
    fi
done

# Install missing packages if any
if [[ ${#MISSING_PACKAGES[@]} -gt 0 ]]; then
    echo "Installing missing packages: ${MISSING_PACKAGES[*]}"
    sudo apt-get update
    sudo apt-get install -y "${MISSING_PACKAGES[@]}"
else
    echo "All required packages are already installed."
fi

# Create the installation directory
echo "Creating installation directory: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

# Change to the installation directory
cd "$INSTALL_DIR" || exit

# Remove any previous RSPTCPServer folder
echo "Removing previous RSPTCPServer folder..."
rm -rf "$INSTALL_DIR/RSPTCPServer"

# Clone RSPTCPServer repository
echo "Cloning RSPTCPServer repository..."
git clone https://github.com/SDRplay/RSPTCPServer

# Change to the RSPTCPServer directory
cd "$INSTALL_DIR/RSPTCPServer" || exit

# Create the build folder
echo "Creating build folder..."
mkdir -p build

# Change to the build folder
cd build || exit

# Use cmake to create the build files
echo "Running CMake..."
cmake ..

# Start the compilation
echo "Compiling RSPTCPServer..."
make

# Install RSPTCPServer into the system folders
echo "Installing RSPTCPServer..."
sudo make install

# Refresh the library path variable
echo "Refreshing library path..."
sudo ldconfig

echo " "
echo "Installation complete."

# Clear the terminal
clear

echo "Installing rsp_tcp systemd service"

# Set the path to the rsp_tcp executable
RSP_TCP_PATH="/usr/local/bin/rsp_tcp"

# Get the IP address of the system
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Set the name of the service unit file
SERVICE_UNIT_FILE="rsp_tcp.service"

# Create the service unit file
echo "Creating the service unit file..."
cat > "$SERVICE_UNIT_FILE" <<EOF
[Unit]
Description=Auto-Restart for rsp_tcp Service
After=network.target

[Service]
ExecStart=$RSP_TCP_PATH -a $IP_ADDRESS
Restart=always
RestartSec=10s

[Install]
WantedBy=default.target
EOF

# Move the service unit file to the systemd directory
echo "Moving the service unit file to the systemd directory..."
sudo mv "$SERVICE_UNIT_FILE" /etc/systemd/system/

# Reload systemd daemon
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable and start the service
echo "Enabling and starting the rsp_tcp service..."
sudo systemctl enable "$SERVICE_UNIT_FILE"
sudo systemctl start "$SERVICE_UNIT_FILE"

echo " "
echo "Installation complete."

# Prompt the user to reboot the system
echo -n "Do you want to reboot the system now? (y/n): "
read -r reboot_answer

if [[ $reboot_answer =~ ^[Yy]$ ]]; then
    echo "Rebooting the system..."
    sudo reboot
else
    echo "Please make sure to reboot the system before using the rsp_tcp service."
fi

#Please be sure to check out my youtube channel Thanks! 73's Dave ZR6LSD


