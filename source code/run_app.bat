@echo off
setlocal

cd /d "%~dp0"

set "PYTHON=python"
set "FOUND_VENV=0"

if exist "%CD%\venv\Scripts\python.exe" (
    "%CD%\venv\Scripts\python.exe" -V >nul 2>&1
    if not errorlevel 1 (
        set "PYTHON=%CD%\venv\Scripts\python.exe"
        set "FOUND_VENV=1"
        echo [OK] Using virtual environment at venv\Scripts\python.exe
    ) else (
        echo [WARN] venv\Scripts\python.exe found but not working, using system python
    )
) else (
    echo [INFO] No virtual environment found at venv\Scripts\python.exe, using system python
)

echo.
echo Checking Python version...
"%PYTHON%" --version
if errorlevel 1 (
    echo [ERROR] Python not found or not working!
    echo Please install Python or activate your virtual environment.
    pause
    exit /b 1
)

echo.
echo Checking dependencies...
"%PYTHON%" -m pip show fastapi >nul 2>&1
if errorlevel 1 (
    echo [WARN] fastapi not installed. Installing from requirements.txt...
    "%PYTHON%" -m pip install -q -r requirements.txt
    if errorlevel 1 (
        echo [ERROR] Failed to install dependencies!
        pause
        exit /b 1
    )
    echo [OK] Dependencies installed
)

echo.
echo Checking if port 8000 is available...
netstat -ano | findstr :8000 >nul 2>&1
if not errorlevel 1 (
    echo [WARN] Port 8000 appears to be in use. Attempting to start anyway...
)

echo.
echo Starting Cinema Home API on http://127.0.0.1:8000
echo To debug, check for errors in this window.
echo If it fails immediately, press Ctrl+C and run from command line:
echo   python -m uvicorn api:app --host 127.0.0.1 --port 8000 --reload
echo.

start "Cinema Home API" cmd /k "cd /d "%~dp0" && "%PYTHON%" -m uvicorn api:app --host 127.0.0.1 --port 8000 --reload"

echo Waiting 3 seconds for API to start...
timeout /t 3 /nobreak >nul

echo.
echo Starting Cinema Home frontend on http://127.0.0.1:3000
start "Cinema Home Frontend" cmd /k "cd /d "%~dp0" && "%PYTHON%" -m http.server 3000 --bind 127.0.0.1"

echo.
echo ========================================
echo Frontend: http://127.0.0.1:3000
echo API:      http://127.0.0.1:8000
echo API Docs: http://127.0.0.1:8000/docs
echo ========================================
echo.
echo Close the spawned windows to stop the app.
pause
