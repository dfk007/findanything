
# 🚀 FindAnything

**FindAnything** is a fast, modern CLI search tool that makes it easy to:
- 🔍 **Find any file or folder by name** across your entire system
- 📂 **Search file contents** quickly
- 🚀 Run an interactive **TUI** (Text-based User Interface) to browse results

Built using `fd`, `fzf`, `gawk` and portable shell functions for **Bash** and **Fish**.

---

## ✅ One-line Installation (recommended)

Automatically installs all required packages on **Arch / Manjaro**, **Ubuntu / Debian**, or **Fedora / RHEL**, then sets up FindAnything for both Bash and Fish:

```bash
curl -fsSL https://raw.githubusercontent.com/dfk007/findanything/main/bootstrap.sh | bash
```

Then just open a new terminal, or run:

```bash
source ~/.bashrc
```

---

## 🚀 Usage

**To search by file name or partial name:**

```bash
findany yourfile.ext
```

It prints the best match + other candidates.

**To run the TUI to explore all matches:**

```bash
findanything "partialname"
```

Navigate with the arrow keys and press `Enter` to open the file path.

---

## 🎥 Demo

[![asciinema demo](https://asciinema.org/a/627993.svg)](https://asciinema.org/a/627993)

(Or if you prefer, embed a small GIF in your repo and link here).

---

## ⚙️ Manual install

```bash
git clone https://github.com/dfk007/findanything.git
cd findanything
bash install.sh
```

---

## 💻 Dependencies

- [fd](https://github.com/sharkdp/fd) — blazing fast file search
- [fzf](https://github.com/junegunn/fzf) — fuzzy finder
- gawk
- bash / fish shells

The installer will handle all of this automatically for your distro.

---

## 📜 License

MIT — free to use, modify, and distribute. Enjoy!
