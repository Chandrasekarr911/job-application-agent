"""Standalone CLI runner for Windows Task Scheduler, background daemon, or manual execution."""

from __future__ import annotations

import argparse
import sys

from src.config import Settings
from src.logger import setup_logging
from src.pipeline import DailyJobPipeline
from src.scheduler import AgentScheduler


def main() -> int:
    parser = argparse.ArgumentParser(description="Generic AI Job Application Agent Runner")
    parser.add_argument(
        "--daemon",
        action="store_true",
        help="Run persistent background scheduler (default 09:00 AM IST daily).",
    )
    parser.add_argument(
        "--auto-submit",
        action="store_true",
        help="Override auto-submit setting for this run.",
    )
    args = parser.parse_args()

    settings = Settings()
    setup_logging(settings.logs_dir)

    if args.daemon:
        scheduler = AgentScheduler(settings)
        scheduler.start_blocking()
        return 0

    pipeline = DailyJobPipeline(settings)
    summary = pipeline.run(auto_submit_override=True if args.auto_submit else None)
    print(f"Run ID: {summary.run_id} | Status: {summary.status}")
    print(
        f"Discovered: {summary.jobs_discovered} | Evaluated: {summary.jobs_evaluated} | "
        f"Submitted: {summary.applications_submitted} | Stopped: {summary.applications_stopped}"
    )
    if summary.excel_report_path:
        print(f"Excel Report: {summary.excel_report_path}")
    if summary.error_message:
        print(f"Error: {summary.error_message}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
