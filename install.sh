#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
#  Project: Termux Kali Hacker Theme
#  Author: Your Name / GitHub Username
#  Description: Transform Termux into an authentic Kali Linux Terminal
# ==============================================================================

# ANSI Color Codes
CYAN='\033[1;36m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
WHITE='\033[1;37m'
RESET='\033[0m'

clear
echo -e "${BLUE}"
cat << "EOF"
  ███████╗████████╗███████╗██████╗ 
  ██╔════╝╚══██╔══╝██╔════╝██╔══██╗
  ███████╗   ██║   ███████╗██████╔╝
  ╚════██║   ██║   ╚════██║██╔═══╝ 
  ███████║   ██║   ███████║██║     
  ╚══════╝   ╚═╝   ╚══════╝╚═╝     
EOF
echo -e "${CYAN}───[ KALI LINUX TERMUX CUSTOMIZER ]───${RESET}"
echo -e "${WHITE}กำลังเริ่มติดตั้งระบบธีม Kali Hacker...${RESET}\n"
sleep 1.5

# 1. ติดตั้ง Packages ที่จำเป็น
echo -e "${BLUE}[*]${RESET} กำลังอัปเดตระบบและติดตั้งแพ็กเกจที่จำเป็น..."
pkg update -y -o Dpkg::Options::="--force-confold"
pkg install -y zsh curl wget git ncurses-utils

# 2. ปิดข้อความต้อนรับเดิมของ Termux
touch ~/.hushlogin

# 3. ติดตั้ง Zsh Plugins (Autosuggestions & Syntax Highlighting)
echo -e "${BLUE}[*]${RESET} กำลังติดตั้ง Zsh Plugins (คำสั่งจำลอง & ตรวจไวยากรณ์)..."
mkdir -p ~/.zsh
rm -rf ~/.zsh/zsh-autosuggestions ~/.zsh/zsh-syntax-highlighting

git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# 4. ดาวน์โหลดฟอนต์ Hacker Nerd Font (MesloLGS NF - รองรับสัญลักษณ์และ Glyphs)
echo -e "${BLUE}[*]${RESET} กำลังติดตั้ง Font Hacker (MesloLGS Nerd Font)..."
mkdir -p ~/.termux
curl -fsSL -o ~/.termux/font.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

# 5. ตั้งค่าโทนสี Kali Linux (Dark Palette)
echo -e "${BLUE}[*]${RESET} กำลังตั้งค่าชุดสีธีม Kali Linux..."
cat << 'EOF' > ~/.termux/colors.properties
# Kali Linux Color Palette for Termux
background=#0d1117
foreground=#c5c8c6
cursor=#00f0ff
color0=#1c2024
color1=#f43753
color2=#36b566
color3=#f39c12
color4=#268bd2
color5=#b354e0
color6=#00bcd4
color7=#ffffff
color8=#586e75
color9=#dc322f
color10=#859900
color11=#b58900
color12=#268bd2
color13=#d33682
color14=#2aa198
color15=#eee8d5
EOF

# 6. สร้างไฟล์ .zshrc พร้อม Prompt แบบ Kali เป๊ะ ๆ และ Banner สวย ๆ
echo -e "${BLUE}[*]${RESET} กำลังสร้างการตั้งค่า Shell (.zshrc)..."
cat << 'EOF' > ~/.zshrc
# ==========================================
# KALI TERMUX ENVIRONMENT CONFIG
# ==========================================

# ระบบสีและการแสดงผล
autoload -U colors && colors
setopt PROMPT_SUBST

# แสดงกิ่ง Git อัตโนมัติถ้าอยู่ใน Git Repository
git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "%F{245}(%F{196}${ref#refs/heads/}%F{245})%f"
}

# Prompt แบบ Kali Linux แท้:
# ถ้าคำสั่งก่อนหน้าสำเร็จ เครื่องหมายจะเป็นสีฟ้า (33) ถ้า Error จะเปลี่ยนเป็นสีแดง (196)
PROMPT='%(?.%F{33}.%F{196})┌──(%F{15}%n㉿kali%F{33})-[%F{15}%~%F{33}]$(git_prompt_info)
%(?.%F{33}.%F{196})└─%F{15}%#%f '

# ประวัติคำสั่ง (History Settings)
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups

# Tab Completion สีสวย
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Plugins
[[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# สีข้อความแนะนำ Auto-suggestions (เทาหม่น)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

# Shortcut Aliases สไตล์ Hacker
alias c='clear && kali_banner'
alias cls='clear && kali_banner'
alias update='pkg update -y && pkg upgrade -y'
alias myip='curl -s ifconfig.me && echo ""'
alias ports='netstat -tuln 2>/dev/null || ss -tuln'
alias ll='ls -la --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias kali='kali_banner'

# Kali Hacker Banner ตอนเปิดเครื่อง (กะทัดรัดพอดีจอมือถือ)
kali_banner() {
    clear
    echo -e "\033[38;5;33m       .---.        \033[38;5;51m _  __     _ _ \033[0m"
    echo -e "\033[38;5;33m      /     \       \033[38;5;51m| |/ /__ _| (_)\033[0m"
    echo -e "\033[38;5;33m     (( (.) (.) ))  \033[38;5;51m| ' </ _\` | | |\033[0m"
    echo -e "\033[38;5;33m      \  (_)  /     \033[38;5;51m|_|\_\\__,_|_|_|\033[0m"
    echo -e "\033[38;5;33m       '-----'      \033[38;5;244m[Termux Edition]\033[0m"
    echo -e "\033[38;5;33m  ──────────────────────────────────────\033[0m"
    echo -e "  \033[38;5;46m[+] User    :\033[0m $(whoami)@kali"
    echo -e "  \033[38;5;46m[+] Device  :\033[0m $(getprop ro.product.model 2>/dev/null || uname -m)"
    echo -e "  \033[38;5;46m[+] System  :\033[0m Android $(getprop ro.build.version.release 2>/dev/null || echo "") / $(uname -m)"
    echo -e "  \033[38;5;46m[+] Status  :\033[0m \033[38;5;51mSTEALTH MODE\033[0m"
    echo -e "\033[38;5;33m  ──────────────────────────────────────\033[0m"
    echo -e "  \033[38;5;245m\"The quieter you become, the more you are able to hear.\"\033[0m\n"
}

# รันแบนเนอร์อัตโนมัติ
kali_banner
EOF

# 7. รีโหลดการตั้งค่าหน้าจอและเปลี่ยน Default Shell เป็น zsh
termux-reload-settings
chsh -s zsh

echo -e "\n${GREEN}[✓] ติดตั้งเสร็จสมบูรณ์ 100%!${RESET}"
echo -e "${CYAN}กำลังเข้าสู่ระบบ Kali Zsh...${RESET}\n"
sleep 1

# เริ่ม Zsh ทันที
exec zsh
