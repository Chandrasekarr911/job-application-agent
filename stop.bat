@echo off
setlocal

echo Stopping Job Application Agent services...

if exist "data\scheduler.pid" (
    set /p SCHED_PID=<data\scheduler.pid
    taskkill /PID %SCHED_PID% /F >nul 2>&1
    del /Q "data\scheduler.pid" >nul 2>&1
)

wmic process where "CommandLine like '%%run_daily.py --daemon%%'" call terminate >nul 2>&1
wmic process where "CommandLine like '%%streamlit%%app.py%%'" call terminate >nul 2>&1

echo Stopped background scheduler and Streamlit dashboard.
