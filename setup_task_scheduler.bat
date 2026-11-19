@echo off
setlocal

set SCRIPT_DIR=%~dp0
set PYTHON_EXE=%SCRIPT_DIR%.venv\Scripts\python.exe
set RUN_SCRIPT=%SCRIPT_DIR%run_daily.py

echo Registering Windows Task Scheduler job: GenericJobAgentDailyRun (09:00 AM daily)...
schtasks /Create /TN "GenericJobAgentDailyRun" /TR "\"%PYTHON_EXE%\" \"%RUN_SCRIPT%\"" /SC DAILY /ST 09:00 /F

if errorlevel 1 (
    echo [ERROR] Failed to register scheduled task. Try running as Administrator.
    exit /b 1
)

echo Scheduled task GenericJobAgentDailyRun registered for 09:00 daily.
pause
