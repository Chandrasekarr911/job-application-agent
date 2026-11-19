@echo off
setlocal

if not exist ".venv\Scripts\activate.bat" (
    echo [ERROR] Virtual environment not found. Run install.bat first.
    exit /b 1
)

call .venv\Scripts\activate.bat

echo Starting background daily scheduler (9:00 AM IST)...
start "JobAgentScheduler" /B .venv\Scripts\python.exe run_daily.py --daemon

echo Starting local Streamlit dashboard on http://127.0.0.1:8501 ...
start "JobAgentDashboard" /B .venv\Scripts\streamlit.exe run app.py --server.address 127.0.0.1 --server.port 8501 --server.headless true

echo Job Application Agent is running locally at http://127.0.0.1:8501
