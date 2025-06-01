#!/bin/bash

Script Info

NAME="MESHACK DANIEL" TELEGRAM="t.me/smeshtech" WHATSAPP="+254745283930" EMAIL="meshackswibe@gmail.com" LOGO_URL="https://vip.meshgroups.website/logo.png" SCRIPT_EXPIRY="2035-06-01"

Color codes

RED='\033[0;31m' GREEN='\033[0;32m' NC='\033[0m' # No Color

Check script expiry

today=$(date +%F) if [[ "$today" > "$SCRIPT_EXPIRY" ]]; then echo -e "${RED}[!] Script expired on $SCRIPT_EXPIRY${NC}" exit 1 fi

Display banner

clear echo -e "${GREEN}╔══════════════════════════════════╗" echo -e "║   INSTALLING XRAY + CADDY + WARP║" echo -e "╚══════════════════════════════════╝${NC}" echo -e "By: $NAME" echo -e "Telegram: $TELEGRAM" echo -e "WhatsApp: $WHATSAPP" echo -e "Email: $EMAIL" echo -e "Logo: $LOGO_URL"

System update

apt update && apt upgrade -y

Install dependencies

apt install -y curl wget unzip socat net-tools cron iptables iptables-persistent gnupg2 ca-certificates lsb-release debian-archive-keyring

Enable IP forwarding

echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/99-sysctl.conf sysctl --system

Install Xray

bash <(curl -Ls https://raw.githubusercontent.com/XTLS/Xray-install/main/install-release.sh)

Configure firewall

ufw allow 22 ufw allow 80 ufw allow 443 ufw allow 1935 ufw --force enable

Create self-signed certs (if needed)

mkdir -p /etc/ssl/xray/ openssl req -x509 -nodes -days 365 -newkey rsa:2048 
-keyout /etc/ssl/xray/xray.key 
-out /etc/ssl/xray/xray.crt 
-subj "/CN=vip.meshgroups.website"

Install Caddy

apt install -y debian-keyring debian-archive-keyring apt-transport-https curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg echo "deb [signed-by=/usr/share/keyrings/caddy-stable-archive-keyring.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb/debian all main" | tee /etc/apt/sources.list.d/caddy-stable.list apt update apt install caddy -y

Caddyfile setup

cat > /etc/caddy/Caddyfile <<EOF vip.meshgroups.website { encode gzip tls /etc/ssl/xray/xray.crt /etc/ssl/xray/xray.key reverse_proxy /vless 127.0.0.1:10001 reverse_proxy /vmess 127.0.0.1:10002 reverse_proxy /trojan-ws 127.0.0.1:10003 reverse_proxy /ss-ws 127.0.0.1:10004 reverse_proxy / 127.0.0.1:10000 } EOF

systemctl restart caddy

Install WARP

wget -N https://git.io/warp.sh && bash warp.sh

Add cron for reboot and logs

(crontab -l; echo "@reboot systemctl restart xray && systemctl restart caddy") | crontab -

Display success

clear echo -e "${GREEN}✔ XRAY + CADDY + WARP installed successfully!${NC}" echo -e "Your server is now configured for ports 80, 443, 1935" echo -e "${GREEN}Enjoy your secure tunnel!${NC}" echo -e "By: $NAME" echo -e "Telegram: $TELEGRAM" echo -e "WhatsApp: $WHATSAPP" echo -e "Email: $EMAIL" echo -e "Logo: $LOGO_URL"

