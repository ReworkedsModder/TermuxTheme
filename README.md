# 🐉 Kali Linux Termux Theme

แปลงโฉมหน้าตา Termux บน Android ให้กลายเป็นสไตล์ **Hacker / Kali Linux** สวย คม ลื่นไหล และตัวหนังสือไม่ตกขอบจอมือถือ!

## 📸 ฟีเจอร์เด่น
- **Kali Two-Line Prompt:** `┌──(kali㉿termux)-[~]` และ `└─$ ` (ถ้ารันคำสั่ง Error กรอบจะเปลี่ยนเป็นสีแดงเหมือนบน Kali แท้)
- **Nerd Font:** รองรับ Glyphs, สัญลักษณ์ และไอคอน
- **Zsh Plugins ในตัว:**
  - `zsh-autosuggestions` (ระบบเดาคำสั่งตามประวัติที่เคยพิมพ์)
  - `zsh-syntax-highlighting` (ไฮไลต์สีคำสั่งถูก/ผิดแบบ Realtime)
- **Compact Hacker Banner:** แบนเนอร์แสดงสถานะเครื่อง, รุ่นมือถือ, วันเวลา และสโลแกน Kali ที่พอดีกับจอมือถือแนวตั้ง

---

## 🚀 วิธีติดตั้ง (One-Line Installer)

เปิด Termux ขึ้นมา แล้วคัดลอกคำสั่งนี้ไปวางแล้วกด Enter:

```bash
pkg install curl -y && curl -fsSL https://raw.githubusercontent.com/<YOUR-GITHUB-USERNAME>/<YOUR-REPO-NAME>/main/install.sh | bash
