@echo off
chcp 65001 >nul
title NogoChain Node

set SCRIPT_DIR=%~dp0
if "%SCRIPT_DIR:~-1%"=="\" set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%
set NOGO_DIR=%SCRIPT_DIR%\nogo
set NOGO_EXE=%NOGO_DIR%\nogo.exe

if not exist "%NOGO_EXE%" (
    echo ERROR: nogo.exe not found
    echo Expected: %NOGO_EXE%
    pause
    exit /b 1
)

set MINER_ADDRESS=NOGO002decc673afa34952603e3d4d2340b07d219baeac55f51a0baca83129bb730c3c6acb5dea
set NO_COLOR=1
set DATA_DIR=%NOGO_DIR%\blockchain_data

echo ========================================
echo   NogoChain Node Starting
echo ========================================
echo Script Directory: %SCRIPT_DIR%
echo Nogo Directory: %NOGO_DIR%
echo Miner Address: %MINER_ADDRESS%
echo Mining Mode: Enabled
echo ========================================
echo.
echo Starting node...
echo.

start "NogoChain Node" cmd /k "cd /d "%NOGO_DIR%" && title NogoChain Node && echo. && echo Node running... Press Ctrl+C to stop. && echo. && set NO_COLOR=1 && "%NOGO_EXE%" server %MINER_ADDRESS% mine --p2p-port=9090 --max-peers=50 --datadir=blockchain_data --metrics --sync.enable=true"

REM Wait for node to start
timeout /t 3 /nobreak >nul

REM Open explorer in browser
start http://localhost:8080/webwallet/

REM Auto-close this window
timeout /t 2 /nobreak >nul
exit
