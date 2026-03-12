#!/bin/bash
# OpenClaw Gateway Heartbeat Installer
# Auto-configures systemd service for OpenClaw Gateway with auto-restart

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SERVICE_NAME="openclaw-gateway"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

echo -e "${GREEN}OpenClaw Gateway Heartbeat Installer${NC}"
echo "======================================"
echo

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Error: Do not run this script as root or with sudo${NC}"
    echo "The script will prompt for sudo when needed"
    exit 1
fi

# Check if systemd is available
if ! command -v systemctl &> /dev/null; then
    echo -e "${RED}Error: systemd not found${NC}"
    echo "This script requires systemd to be available"
    exit 1
fi

# Check if openclaw command exists
if ! command -v openclaw &> /dev/null; then
    echo -e "${RED}Error: openclaw command not found${NC}"
    echo "Please install OpenClaw first"
    exit 1
fi

# Get openclaw binary path
OPENCLAW_BIN=$(which openclaw)
echo -e "Found OpenClaw at: ${GREEN}${OPENCLAW_BIN}${NC}"

# Get current user
CURRENT_USER=$(whoami)
echo -e "Current user: ${GREEN}${CURRENT_USER}${NC}"

# Get user's home directory
USER_HOME=$(eval echo ~${CURRENT_USER})
echo -e "Home directory: ${GREEN}${USER_HOME}${NC}"
echo

# Check if service already exists
if [ -f "$SERVICE_FILE" ]; then
    echo -e "${YELLOW}Warning: Service already exists${NC}"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled"
        exit 0
    fi
    echo "Stopping existing service..."
    sudo systemctl stop ${SERVICE_NAME} 2>/dev/null || true
fi

# Create systemd service file
echo "Creating systemd service..."
sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=OpenClaw Gateway with Auto-Restart
After=network.target

[Service]
Type=simple
User=${CURRENT_USER}
WorkingDirectory=${USER_HOME}
ExecStart=${OPENCLAW_BIN} gateway start
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

echo -e "${GREEN}✓${NC} Service file created"

# Reload systemd
echo "Reloading systemd..."
sudo systemctl daemon-reload
echo -e "${GREEN}✓${NC} Systemd reloaded"

# Enable service
echo "Enabling service..."
sudo systemctl enable ${SERVICE_NAME}
echo -e "${GREEN}✓${NC} Service enabled (will start on boot)"

# Start service
echo "Starting service..."
sudo systemctl start ${SERVICE_NAME}
echo -e "${GREEN}✓${NC} Service started"

echo
echo -e "${GREEN}Installation complete!${NC}"
echo
echo "Useful commands:"
echo "  Check status:    sudo systemctl status ${SERVICE_NAME}"
echo "  View logs:       sudo journalctl -u ${SERVICE_NAME} -f"
echo "  Stop service:    sudo systemctl stop ${SERVICE_NAME}"
echo "  Restart service: sudo systemctl restart ${SERVICE_NAME}"
echo "  Disable service: sudo systemctl disable ${SERVICE_NAME}"
echo
echo "The gateway will now automatically restart if it crashes."
