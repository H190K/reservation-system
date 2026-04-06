# Cinema Online Ticket Reservation System

## SOFTWARE ARCHITECTURE

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

![Altinbas University](https://img.shields.io/badge/Altinbas%20University-1B365D?style=for-the-badge)
![Project / Software Architecture / SWE 332](https://img.shields.io/badge/Project%20%2F%20Software%20Architecture%20%2F%20SWE%20332-6B7280?style=for-the-badge)

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
