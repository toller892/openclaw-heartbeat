# OpenClaw Heartbeat

🫀 Auto-restart and boot-time startup for OpenClaw Gateway using systemd.

## What It Does

Ensures your OpenClaw Gateway stays running 24/7 by:
- **Auto-restarting** when it crashes (10 second delay)
- **Starting on boot** automatically
- **Running as your user** (not root)

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/install.sh | bash
```

Or download and run manually:

```bash
wget https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/install.sh
bash install.sh
```

## Usage

**Check status:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/status.sh)
```

**Uninstall:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/uninstall.sh)
```

**Manual service control:**
```bash
sudo systemctl status openclaw-gateway
sudo systemctl restart openclaw-gateway
sudo systemctl stop openclaw-gateway
sudo journalctl -u openclaw-gateway -f  # View live logs
```

## Requirements

- Linux with systemd (WSL2 supported)
- OpenClaw installed and in PATH
- sudo access (script will prompt when needed)

## How It Works

The installer:
1. Detects your OpenClaw installation path
2. Creates a systemd service at `/etc/systemd/system/openclaw-gateway.service`
3. Configures automatic restart with 10-second delay
4. Enables the service to start on boot
5. Starts the service immediately

The service runs as your current user and logs to systemd journal.

## Troubleshooting

**Check if the service is running:**
```bash
sudo systemctl status openclaw-gateway
```

**View recent logs:**
```bash
sudo journalctl -u openclaw-gateway -n 50
```

**View live logs:**
```bash
sudo journalctl -u openclaw-gateway -f
```

**Restart manually:**
```bash
sudo systemctl restart openclaw-gateway
```

## Notes

- Do NOT run scripts with sudo - they will prompt when needed
- The gateway will restart automatically after crashes
- Uninstalling stops the service and removes auto-start
- Service file location: `/etc/systemd/system/openclaw-gateway.service`

## License

MIT
