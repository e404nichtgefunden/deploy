#!/bin/bash

echo "[*] Membuat direktori /root/telegram-bot"
sudo chmod 777 /root
sudo mkdir -p /root/tele-bot

echo "[*] Memindahkan file..."
cd /workspace/code/b/deploy
sudo cp deploy3.py tele-bot.service commands.sh /root/tele-bot

echo "[*] Pindah ke folder bot..."
cd /root/tele-bot || exit

echo "[*] Install Telebot..."
sudo rm -rf /usr/lib/python3/dist-packages/blinker* 
sudo rm -rf /usr/local/lib/python3.*/dist-packages/blinker* 
sudo rm -rf /usr/lib/python3.*/dist-packages/blinker* 
pip3 install --upgrade setuptools pip 
pip3 install --no-cache-dir flask python-telegram-bot==20.8
pip3 install --no-cache-dir telegram psutil
pip3 install python-telegram-bot --upgrade
sudo chmod 777 /etc
sudo chmod 777 /etc/systemd
sudo chmod 777 /etc/systemd/system

echo "[*] Menyalin systemd service..."
sudo cp tele-bot.service /etc/systemd/system

echo "[*] Menyesuaikan path di service file..."
sudo sed -i "s|/root/stx.py|/root/tele-bot|g" /etc/systemd/system/tele-bot.service
sudo sed -i "s|/root/stx.py|/root/tele-bot/stx.py|g" /etc/systemd/system/tele-bot.service

echo "[*] Reload systemd..."
sudo systemctl daemon-reload

echo "[*] Enable dan start bot..."
sudo systemctl enable tele-bot
sudo systemctl start tele-bot

echo "[✓] Bot berhasil diinstall, systemd aktif!"
