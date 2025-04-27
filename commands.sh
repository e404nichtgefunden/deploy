#!/bin/bash

echo "[*] Membuat direktori /root/telegram-bot"
sudo chmod 777 /root
sudo mkdir -p /root/telegram-bot

echo "[*] Memindahkan file..."
cd /workspace/code
sudo cp deploy3.py telegram-bot.service commands.sh /root/telegram-bot

echo "[*] Pindah ke folder bot..."
cd /root/telegram-bot || exit

echo "[*] Install Telebot..."
sudo rm -rf /usr/lib/python3/dist-packages/blinker* 
sudo rm -rf /usr/local/lib/python3.*/dist-packages/blinker* 
sudo rm -rf /usr/lib/python3.*/dist-packages/blinker* 
pip3 install --upgrade setuptools pip 
pip3 install --no-cache-dir flask python-telegram-bot==20.8
pip3 install --no-cache-dir telegram
pip3 install python-telegram-bot --upgrade
sudo chmod 777 /etc
sudo chmod 777 /etc/systemd
sudo chmod 777 /etc/systemd/system

echo "[*] Menyalin systemd service..."
sudo cp telegram-bot.service /etc/systemd/system

echo "[*] Menyesuaikan path di service file..."
sudo sed -i "s|/root/stx.py|/root/telegram-bot|g" /etc/systemd/system/telegram-bot.service
sudo sed -i "s|/root/stx.py|/root/telegram-bot/stx.py|g" /etc/systemd/system/telegram-bot.service

echo "[*] Reload systemd..."
sudo systemctl daemon-reload

echo "[*] Enable dan start bot..."
sudo systemctl enable telegram-bot
sudo systemctl start telegram-bot

echo "[✓] Bot berhasil diinstall, systemd aktif!"
