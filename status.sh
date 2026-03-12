#!/bin/bash
# Check OpenClaw Gateway heartbeat status

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SERVICE_NAME="openclaw-gateway"

echo -e "${GREEN}OpenClaw Gateway Heartbeat Status${NC}"
echo "==================================="
echo

# Check if service file exists
if [ ! -f "/etc/systemd/system/${SERVICE_NAME}.service" ]; then
    echo -e "${RED}✗${NC} Heartbeat not installed"
    echo "Run install.sh to set up auto-restart"
    exit 1
fi

# Check service status
if systemctl is-active --quiet ${SERVICE_NAME}; then
    echo -e "${GREEN}✓${NC} Gateway is running"
else
    echo -e "${RED}✗${NC} Gateway is not running"
fi

# Check if enabled
if systemctl is-enabled --quiet ${SERVICE_NAME}; then
    echo -e "${GREEN}✓${NC} Auto-start on boot: enabled"
else
    echo -e "${YELLOW}!${NC} Auto-start on boot: disabled"
fi

echo
echo "Service details:"
systemctl status ${SERVICE_NAME} --no-pager -l

echo
echo "Recent logs (last 10 lines):"
sudo journalctl -u ${SERVICE_NAME} -n 10 --no-pager
