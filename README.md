# OpenClaw Heartbeat 🫀

**心脏起搏器** - 让你的 OpenClaw Gateway 永不停歇

[English](#english) | [中文](#中文)

---

## 中文

### 它是什么？

OpenClaw Gateway 的心脏起搏器。安装后，你的 Gateway 将：
- 💓 **永不停歇** - 自动重启，无需人工干预
- 🚀 **开机即用** - 系统启动时自动运行
- 🛡️ **稳定可靠** - 后台守护，静默运行

### 快速安装

一行命令，搞定一切：

```bash
curl -fsSL https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/install.sh | bash
```

或手动下载安装：

```bash
wget https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/install.sh
bash install.sh
```

### 使用方法

**检查状态：**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/status.sh)
```

**卸载：**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/uninstall.sh)
```

**手动控制：**
```bash
sudo systemctl status openclaw-gateway      # 查看状态
sudo systemctl restart openclaw-gateway     # 重启服务
sudo systemctl stop openclaw-gateway        # 停止服务
sudo journalctl -u openclaw-gateway -f      # 查看实时日志
```

### 系统要求

- Linux 系统（支持 WSL2）
- 已安装 OpenClaw
- sudo 权限（安装时会提示）

### 常见问题

**如何查看服务是否正常运行？**
```bash
sudo systemctl status openclaw-gateway
```

**如何查看日志？**
```bash
sudo journalctl -u openclaw-gateway -n 50    # 最近 50 条
sudo journalctl -u openclaw-gateway -f       # 实时查看
```

**如何手动重启？**
```bash
sudo systemctl restart openclaw-gateway
```

### 注意事项

- 不要使用 sudo 运行安装脚本（脚本会在需要时自动提示）
- 卸载后服务将停止，不再自动启动
- 服务配置文件位置：`/etc/systemd/system/openclaw-gateway.service`

---

## English

### What Is It?

A heartbeat monitor for OpenClaw Gateway. Once installed, your Gateway will:
- 💓 **Never Stop** - Auto-restart without manual intervention
- 🚀 **Boot Ready** - Start automatically when system boots
- 🛡️ **Rock Solid** - Background daemon, silent operation

### Quick Install

One command, done:

```bash
curl -fsSL https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/install.sh | bash
```

Or download and install manually:

```bash
wget https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/install.sh
bash install.sh
```

### Usage

**Check status:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/status.sh)
```

**Uninstall:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/toller892/openclaw-heartbeat/main/uninstall.sh)
```

**Manual control:**
```bash
sudo systemctl status openclaw-gateway      # Check status
sudo systemctl restart openclaw-gateway     # Restart service
sudo systemctl stop openclaw-gateway        # Stop service
sudo journalctl -u openclaw-gateway -f      # View live logs
```

### Requirements

- Linux with systemd (WSL2 supported)
- OpenClaw installed
- sudo access (will prompt when needed)

### Troubleshooting

**Check if service is running:**
```bash
sudo systemctl status openclaw-gateway
```

**View logs:**
```bash
sudo journalctl -u openclaw-gateway -n 50    # Last 50 lines
sudo journalctl -u openclaw-gateway -f       # Live view
```

**Restart manually:**
```bash
sudo systemctl restart openclaw-gateway
```

### Notes

- Do NOT run install script with sudo (it will prompt when needed)
- After uninstall, service will stop and won't auto-start
- Service file location: `/etc/systemd/system/openclaw-gateway.service`

---

## License

MIT License - see [LICENSE](LICENSE) for details
