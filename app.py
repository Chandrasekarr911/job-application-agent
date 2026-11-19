"""Main entry point for the Streamlit local dashboard."""

from src.config import Settings
from src.logger import setup_logging
from src.ui.pages import render_app

if __name__ == "__main__":
    settings = Settings()
    setup_logging(settings.logs_dir)
    render_app()
