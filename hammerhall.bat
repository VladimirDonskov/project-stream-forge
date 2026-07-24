@echo off
REM ============================================================
REM  Hammerhall CLI — обёртка-загрузчик для Windows.
REM  Логика та же, что в hammerhall: скачать при первом запуске,
REM  дальше просто запускать.
REM ============================================================
setlocal

set VERSION=0.1.0
set REPO=hammerhall/hammerhall-cli

set ROOT=%~dp0
set DIR=%ROOT%.hammerhall
set JAR=%DIR%\cli-%VERSION%.jar

where java >nul 2>nul
if errorlevel 1 (
    echo Нужна Java. Она же нужна, чтобы решать задачи — поставь JDK 25.
    exit /b 1
)

if not exist "%JAR%" (
    echo Загружаю клиент %VERSION%...
    if not exist "%DIR%" mkdir "%DIR%"
    set URL=https://github.com/%REPO%/releases/download/v%VERSION%/cli-%VERSION%.jar
    powershell -NoProfile -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%JAR%.part'" || exit /b 1
    move /y "%JAR%.part" "%JAR%" >nul
)

java -jar "%JAR%" %*
