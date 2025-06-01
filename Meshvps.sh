#!/bin/bash

# Script Info
NAME="MESHACK DANIEL"
TELEGRAM="t.me/smeshtech"
WHATSAPP="+254745283930"
EMAIL="meshackswibe@gmail.com"
SCRIPT_EXPIRY="2035-06-01"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check Expiry
today=$(date +%F)
if [[ "$today" > "$SCRIPT_EXPIRY" ]]; then
  echo -e "${RED}[!] Script expired on $SCRIPT_EXPIRY${NC}"
  exit 1
fi

# Welcome message
echo -e "${GREEN}=============================="
echo "     MESH VPS INSTALLER"
echo "=============================="
echo " Author  : $NAME"
echo " Email   : $EMAIL"
echo " Telegram: $TELEGRAM"
echo " WhatsApp: $WHATSAPP"
echo " Expiry  : $SCRIPT_EXPIRY"
echo -e "==============================${NC}"

# Update system
apt update -y && apt upgrade -y || yum update -y

# Install dependencies
apt install -y curl wget git unzip sudo || yum install -y curl wget git unzip sudo

# Allow port 1935
iptables -I INPUT -p tcp --dport 1935 -j ACCEPT
iptables-save > /etc/iptables/rules.v4

# Install Caddy with WARP
bash <(curl -sSL https://raw.githubusercontent.com/fscarmen/warp/main/menu.sh) || echo "WARP installation skipped or failed."
curl -fsSL https://get.caddyserver.com | bash

# Success
echo -e "${GREEN}[✔] MeshVPS Setup Complete!${NC}"
