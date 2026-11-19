@echo off
setlocal enabledelayedexpansion

echo ============================================================
echo  Generic AI-Powered Resume-Based Job Application Agent
echo  Windows Installer (Python 3.11+)
echo ============================================================

python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python 3.11+ is not installed or not in PATH.
    exit /b 1
)

if not exist ".venv" (
    echo Creating virtual environment...
    python -m venv .venv
)

call .venv\Scripts\activate.bat
python -m pip install --upgrade pip
pip install -r requirements.txt

echo Installing Playwright Chromium browser...
python -m playwright install chromium

if not exist ".env" (
    copy .env.example .env >nul
    echo Created .env from .env.example
)

if not exist "data" mkdir data
if not exist "logs" mkdir logs
if not exist "resumes" mkdir resumes
if not exist "reports" mkdir reports

echo Running automated verification tests...
python -m unittest discover -s tests -v

echo ============================================================
echo  Installation complete!
echo  Run start.bat to launch dashboard and background scheduler.
echo  Run setup_task_scheduler.bat as Admin for 9:00 AM IST task.
echo ============================================================
pause
