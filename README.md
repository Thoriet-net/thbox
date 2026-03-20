# thbox

**Portable Docker runtime for running Python scripts in a consistent environment.**

thbox provides a clean, reproducible runtime with preinstalled Python modules and tools, eliminating “works on my machine” problems.

⚠️ **Not a development environment**

thbox is a **runtime-only environment**. It does not include Git and is not intended for development workflows.  
Your code stays on the host machine and is mounted into the container.

The goal is to provide a clean, reproducible execution layer — not a full dev setup.

---

## ⚡ Quickstart (30 seconds)

```bash
git clone https://github.com/Thoriet-net/thbox.git
cd thbox

docker build -t thbox .
sudo ln -sf "$(pwd)/bin/thrun" /usr/local/bin/thrun

cp .env.example .env
# edit .env and set THBOX_SCRIPTS_PATH

thrun
```

---

## ✨ Features

- 🐍 Preconfigured Python runtime
- 📦 Common libraries for automation, networking and data processing
- 🐚 Clean zsh shell environment
- 🔁 Consistent execution across machines
- 🚫 No local Python setup required

---

## 📦 Requirements

- Docker installed and running

---

## 🚀 Installation

### 1. Clone repository

```bash
git clone https://github.com/Thoriet-net/thbox.git
cd thbox
```

### 2. Build Docker image

```bash
docker build -t thbox .
```

### 3. Make `thrun` globally available

```bash
sudo ln -sf "$(pwd)/bin/thrun" /usr/local/bin/thrun
```

> 💡 **Tip:** If `/usr/local/bin` is not in your PATH, you can use a local bin directory:
>
> ```bash
> mkdir -p ~/bin
> ln -sf "$(pwd)/bin/thrun" ~/bin/thrun
> export PATH="$HOME/bin:$PATH"
> ```

---

---

## ⚙️ Configuration

Create a local `.env` file:

```bash
cp .env.example .env
```

Edit it:

```env
THBOX_SCRIPTS_PATH="/absolute/path/to/your/scripts"
```

This directory will be mounted as `/workspace` inside the container.

---

## 🧪 Usage

### Start interactive shell

```bash
thrun
```

### Run a script

```bash
thrun python script.py
```

### Run inline code

```bash
thrun python - <<EOF
print("hello from thbox")
EOF
```

---

## 🔐 SSH Support

thbox supports **SSH agent forwarding**, which allows scripts inside the container to use your local SSH identity.

This means:

- Your **private keys never leave your host machine**
- The container can authenticate to remote systems (servers, network devices, APIs)
- No need to copy or manage keys inside the container

Example test:

```bash
thrun ssh -T git@github.com
```

This only verifies authentication — Git is not part of the intended workflow.

---

## 📁 Project structure

```text
thbox/
  bin/thrun          # CLI launcher
  modules/           # Python dependencies
  Dockerfile         # Runtime definition
  .env.example       # Configuration template
```

---

## 🧠 Philosophy

thbox separates:

- **code** → lives in your local scripts directory  
- **runtime** → provided by Docker  

This ensures:
- reproducibility
- portability
- zero environment drift

---

## 🔧 Included tooling

Examples of included libraries:

- requests, pydantic, python-dotenv
- pandas, numpy
- paramiko, netmiko, napalm
- rich, click

---

## 📌 Notes

- No Git operations are performed inside the container
- The runtime is intentionally minimal and focused on execution
- Extend `modules/requirements.txt` to customize your environment
- SSH agent forwarding is supported, allowing scripts to authenticate using your local SSH keys without copying private keys into the container

---

## 🧭 Future ideas

- multiple runtime profiles (core / network / data)
- optional build variants
- remote execution support

---

## 🧑‍💻 Author

Built as a practical tool for consistent script execution across environments.

## 📄 License

MIT


