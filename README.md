# Ashen Mist - Event Planning Platform

Welcome to the **Ashen Mist** project! This guide will help you set up your development environment from scratch on a Windows machine.

## 📋 Prerequisites

Before you begin, ensure your Windows machine is ready.

### 1. Windows Features (WSL2 & Hyper-V)
Docker requires WSL2 (Windows Subsystem for Linux) or Hyper-V to run efficiently.
1.  Open **PowerShell** as Administrator.
2.  Run the following command to enable WSL:
    ```powershell
    wsl --install
    ```
3.  Restart your computer if prompted.

### 2. Install Required Tools
Download and install the following software:

*   **Git**: [Download Git for Windows](https://git-scm.com/download/win)
    *   *During installation, choose "Use Git from the Windows Command Prompt".*
*   **Node.js (LTS Version)**: [Download Node.js](https://nodejs.org/)
    *   *This includes `npm` (Node Package Manager).*
*   **Docker Desktop**: [Download Docker Desktop](https://www.docker.com/products/docker-desktop/)
    *   *Start Docker Desktop after installation and wait for the engine to start.*
*   **VS Code (Optional but Recommended)**: [Download VS Code](https://code.visualstudio.com/)

---

## 🚀 Installation

### 1. Clone the Repository
Open your terminal (PowerShell or Command Prompt) and run:

```bash
# Clone the repository
git clone https://github.com/aisheeray567-svg/ashen-mist.git

# Navigate into the project folder
cd ashen-mist
```

### 2. Install Dependencies
Install all project dependencies using `npm`:

```bash
npm install
```

---

## ⚙️ Configuration

### 1. Environment Variables
You need to set up environment variables for the database connection.

1.  Navigate to `packages/database`.
2.  Create a file named `.env`.
3.  Add the following content:

```env
# Connection string for local Docker database
DATABASE_URL="postgresql://admin:password123@localhost:5432/ashen_mist?schema=public"
```

---

## 🐘 Database Setup (Docker)

We use Docker to run the PostgreSQL database and Redis without installing them directly on your machine.

### 1. Start Database Containers
In the root directory of the project (`ashen-mist`), run:

```bash
docker-compose up -d
```
*   `-d` runs it in "detached" mode (in the background).
*   You can check if it's running with `docker ps`.

### 2. Initialize Database Schema
Once the database is running, push the schema to it:

```bash
# Run this from the root directory
npx prisma db push
```
*   *Note: This command might need to be run from `packages/database` if the root script isn't configured, but typically in a monorepo it's handled via scripts.*

---

## 🏃‍♂️ Running the Application

### Start Development Server
To start all applications (User App, Admin Panel, etc.) simultaneously:

```bash
npm run dev
```

*   **Web User App**: [http://localhost:3000](http://localhost:3000)
*   **Web Admin App**: [http://localhost:3001](http://localhost:3001) (Port may vary check terminal output)
*   **API**: [http://localhost:3002](http://localhost:3002)

---

## 🛠️ Troubleshooting

*   **"docker is not recognized"**: Make sure Docker Desktop is running and you have added Docker to your PATH (restart terminal after install).
*   **"git is not recognized"**: Add `C:\Program Files\Git\cmd` to your PATH environment variable.
*   **Database Connection Error**: Ensure the Docker container is running (`docker ps`) and the `.env` file in `packages/database` is correct.
