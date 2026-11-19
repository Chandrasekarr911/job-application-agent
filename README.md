# Generic AI-Powered Resume-Based Job Application Agent

A complete, locally hosted, domain-agnostic AI job application automation system built with Python 3.11+, Streamlit, Playwright, SQLite, PyMuPDF, python-docx, OpenPyXL, and APScheduler.

## Key Capabilities
- **Dynamic Resume Intelligence (`src/resume_parser.py`)**: Parses any PDF or DOCX resume across any profession or industry without hardcoded designations, skills, or domains.
- **Dynamic Job Discovery (`src/job_discovery.py`)**: Automatically derives search queries from the candidate's actual resume profile and preferences, queries authorized sources, and deduplicates listings in SQLite.
- **Semantic AI Matching (`src/job_matcher.py`)**: Evaluates 7 compatibility dimensions (skills, experience, qualifications, industry, responsibilities, designation, location), scores 0–100 with explanations, and excludes fundamentally incompatible jobs.
- **Compliant Application Automation (`src/application_automator.py`)**: Answers screening questions strictly from verified candidate profile data, never invents answers, never submits with unanswered mandatory questions, and never bypasses CAPTCHA, OTP, MFA, bot detection, or login protections.
- **Dedicated Naukri Integration (`src/naukri_integration.py`)**: Fernet-encrypted local credential storage, private Playwright browser profile, duplicate prevention, and zero credential exposure to AI models.
- **Automated Daily Execution (`src/scheduler.py`, `run_daily.py`)**: Runs the 11-step pipeline daily at **9:00 AM IST** (`Asia/Kolkata`) via APScheduler or Windows Task Scheduler, independent of the dashboard.
- **Excel Reporting (`src/excel_reporter.py`)**: Generates `reports/Job_Application_Tracker.xlsx` with all 18 tracking columns plus Daily, Weekly, and Monthly summary sheets.
- **10-Page Local Streamlit Dashboard (`src/ui/pages.py`)**: Bound strictly to `127.0.0.1:8501`.

## Quick Start (Windows)
1. Run `install.bat` to create `.venv`, install dependencies, install Playwright Chromium, initialize `.env`, and run tests.
2. Run `start.bat` to start the background scheduler and open the dashboard at `http://127.0.0.1:8501`.
3. (Optional) Run `setup_task_scheduler.bat` as Administrator to register the 9:00 AM Windows Task Scheduler job.
4. Run `stop.bat` to stop all background services.

## Local & Cloud LLM Support
Configure `.env`:
- **Local Ollama (default)**: `JAA_LLM_PROVIDER=auto` with Ollama running at `http://127.0.0.1:11434/v1`.
- **OpenAI-compatible API**: Set `JAA_LLM_PROVIDER=openai` and `JAA_LLM_API_KEY=...`.
- **Offline Heuristic Mode**: Works with zero external AI calls (`JAA_LLM_PROVIDER=heuristic`).

## Running Tests
```bash
python -m unittest discover -s tests -v
```
