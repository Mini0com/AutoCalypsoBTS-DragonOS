#!/bin/bash

# Color Codes
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

echo -e "${RED}"
echo "########################################################"
echo "#              Installing AutoCalypsoBTS.V2            #"
echo "########################################################"
echo -e "${NC}"
sleep 2

echo -e "${BLUE}Installing required packages...${NC}"
sudo apt install gnome-terminal -y
sudo python3 -m pip install PyQt5
(pip3 install pyautogui >/dev/null 2>&1) & spinner
echo -e "${GREEN}✓ pyautogui installed${NC}"
sleep 1

echo -e "${BLUE}Copying system files...${NC}"
for file in msisdn_changer.py smpp.py sms_attack.py ussd.py smS.py sub.py; do
    sudo cp "$file" /usr/src/CalypsoBTS
done
echo -e "${GREEN}✓ Files copied to /usr/src/CalypsoBTS${NC}"
sleep 1

echo -e "${BLUE}Setting executable permissions...${NC}"
sudo chmod 777 autocalypsobts/*.sh autocalypsobts/autobts.py
echo -e "${GREEN}✓ Permissions set${NC}"
sleep 1

echo -e "${GREEN}"
echo "========================================================"
echo "         AutoCalypsoBTS.V2 Installation Complete!       "
echo "========================================================"
echo -e "${NC}"
echo -e "${YELLOW}"
echo    "To start AutoCalypsoBTS.V2:"
echo -e "${NC}cd autocalypsobts && sudo python3 autobts.py"
echo
echo -e "${YELLOW}Just leave me here, I'm just a Mini0com ¯\_(ツ)_/¯${NC}"
