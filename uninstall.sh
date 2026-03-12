#!/bin/bash
# OpenClaw Gateway Heartbeat Uninstaller

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SERVICE_NAME="openclaw-gateway"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

echo -e "${YELLOW}OpenClaw Gateway Heartbeat Uninstaller${NC}"
echo "========================================"
echo

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Error: Do not run this script as root or with sudo${NC}"
    echo "The script will prompt for sudo when needed"
    exit 1
fi

# Check if service exists
if [ ! -f "$SERVICE_FILE" ]; then
    echo -e "${RED}Error: Service not found${NC}"
    echo "Nothing to uninstall"
    exit 1
fi

# Confirm uninstallation
read -p "Are you sure you want to uninstall the gateway heartbeat? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstallation cancelled"
    exit 0
fi

# Stop service
echo "Stopping service..."
sudo systemctl stop ${SERVICE_NAME} 2>/dev/null || true
echo -e "${GREEN}✓${NC} Service stopped"

# Disable service
echo "Disabling service..."
sudo systemctl disable ${SERVICE_NAME} 2>/dev/null || true
echo -e "${GREEN}✓${NC} Service disabled"

# Remove service file
echo "Removing service file..."
sudo rm -f "$SERVICE_FILE"
echo -e "${GREEN}✓${NC} Service file removed"

# Reload systemd
echo "Reloading systemd..."
sudo systemctl daemon-reload
echo -e "${GREEN}✓${NC} Systemd reloaded"

echo
echo -e "${GREEN}Uninstallation complete!${NC}"
echo "The gateway will no longer auto-restart or start on boot."
