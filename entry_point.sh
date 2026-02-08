#!/bin/bash
# entry_point.sh - Entry point for BettaFish Docker container
# This script starts the Flask server which manages all Streamlit agents

set -e

echo "=== BettaFish Docker Container Entry Point ==="
echo "Starting at: $(date)"

# Set environment variables
export PYTHONUNBUFFERED=1
export STREAMLIT_SERVER_ENABLE_FILE_WATCHER=false

# Ensure runtime directories exist
mkdir -p /app/logs /app/final_reports
mkdir -p /app/insight_engine_streamlit_reports
mkdir -p /app/media_engine_streamlit_reports
mkdir -p /app/query_engine_streamlit_reports
mkdir -p /ms-playwright

# Initialize database if needed
cd /app
python -c "from MindSpider.main import MindSpider; spider = MindSpider(); spider.initialize_database()" 2>/dev/null || echo "Database initialization skipped"

# Start the Flask main application
# This will also start the Streamlit agents and ForumEngine
echo "Starting BettaFish Flask server on port 5000..."
echo "Container started at: $(date)"

exec python /app/app.py
