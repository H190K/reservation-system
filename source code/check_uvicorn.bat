@echo off
setlocal

echo ================================================
echo Cinema Home - Uvicorn Diagnostic Tool
echo ================================================
echo.

cd /d "%~dp0"

echo [1] Checking Python installation...
python --version
if errorlevel 1 (
    echo [FAIL] Python command not found!
    echo Please install Python from https://www.python.org/downloads/
    pause
    exit /b 1
)
echo [OK] Python is installed
echo.

echo [2] Checking Python path...
where python
echo.

echo [3] Checking if pip is available...
python -m pip --version
if errorlevel 1 (
    echo [FAIL] pip is not available!
    pause
    exit /b 1
)
echo [OK] pip is available
echo.

echo [4] Checking installed packages...
echo Checking for fastapi...
python -m pip show fastapi
if errorlevel 1 (
    echo [WARN] fastapi is NOT installed
) else (
    echo [OK] fastapi is installed
)
echo.

echo Checking for uvicorn...
python -m pip show uvicorn
if errorlevel 1 (
    echo [WARN] uvicorn is NOT installed
) else (
    echo [OK] uvicorn is installed
)
echo.

echo [5] Checking requirements.txt...
if exist requirements.txt (
    echo [OK] requirements.txt found
    type requirements.txt
) else (
    echo [WARN] requirements.txt not found!
)
echo.

echo [6] Attempting to import modules...
echo Testing fastapi import...
python -c "import fastapi; print('[OK] fastapi version:', fastapi.__version__)"
if errorlevel 1 (
    echo [FAIL] Cannot import fastapi
)
echo.

echo Testing uvicorn import...
python -c "import uvicorn; print('[OK] uvicorn version:', uvicorn.__version__)"
if errorlevel 1 (
    echo [FAIL] Cannot import uvicorn
)
echo.

echo [7] Testing API module import...
python -c "import api; print('[OK] api module loaded successfully')"
if errorlevel 1 (
    echo [FAIL] Cannot import api module - check api.py for errors
    echo.
    echo Common issues:
    echo   - Missing dependencies (run: pip install -r requirements.txt)
    echo   - Syntax errors in api.py
    echo   - Missing payment_gateway module
)
echo.

echo [8] Checking port availability...
netstat -ano | findstr ":8000"
if errorlevel 1 (
    echo [OK] Port 8000 appears free
) else (
    echo [WARN] Port 8000 is in use - may need to kill existing process
    netstat -ano | findstr ":8000" | findstr "LISTENING"
)
echo.

echo [9] Testing uvicorn directly (dry run)...
echo This simulates what run_app.bat does...
echo Command: python -m uvicorn api:app --host 127.0.0.1 --port 8000 --limit-keepalive-time 5
echo.
echo Press Ctrl+C after 5 seconds to stop the test.
echo.
pause
python -m uvicorn api:app --host 127.0.0.1 --port 8000 --limit-keepalive-time 5

echo.
echo ================================================
echo Diagnostic complete!
echo ================================================
pause