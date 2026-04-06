# Cinema Online Ticket Reservation System

## Overview

Cinema booking app with a Python backend, SQLite database, and a static HTML/CSS/JS frontend.

## Team Details

| Name | Student ID | GitHub Username |
|---|---:|---|
| Ziad Hatem Wahba | 220513665 | OZORES7 |
| Habibe Hasanoglu | 230513532 | HabiHas |
| Abdulrahman Bahraq | 220513559 | SaBo10K |
| Hasan Albehadili | 210513486 | H190K |
| Zein Alabdin Nashaat | 220513072 | izeinnn |

## Project Introduction

The system is designed to make movie ticket booking easier and more efficient. It helps reduce queues and gives cinema management a simple way to manage reservations and schedules.

## Project Layout

- `source code/` contains the application code, assets, and launch scripts.
- Root folder contains the main documentation files.
- `source code/cinema_home.db` is the local SQLite database file used by the API.

## Setup

1. Open a terminal in the repo root.
2. Go into the application folder:

```bash
cd "source code"
```

3. Install dependencies:

```bash
pip install -r requirements.txt
```

## Run

Use the launcher that matches your OS:

- Windows: `run_app.bat`
- macOS/Linux: `run_app.sh`

These scripts start:

- the FastAPI backend on `http://127.0.0.1:8000`
- a static frontend server on `http://127.0.0.1:3000`

If you prefer to start things manually:

```bash
python -m uvicorn api:app --host 127.0.0.1 --port 8000
python -m http.server 3000 --bind 127.0.0.1
```

## Notes

- The API creates `cinema_home.db` in `source code/` if it does not already exist.
- The seat booking page loads the selected movie poster in the background and falls back to the default booking background if needed.
- The payment flow uses a local sandbox gateway for booking confirmation tests.

## Test User

The backend seeds a default test account:

- Username: `test`
- Password: `test123`
- Email: `test@example.com`

## Architecture

See [ARCHITECTURE.md](/ARCHITECTURE.md) for the short architecture summary.
