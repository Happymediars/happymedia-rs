@echo off
REM Auto commit + push — samo dvoklik
cd /d "%~dp0"

echo === Happy Media - auto commit + push ===
echo.

REM Clean stale lock
if exist .git\index.lock del .git\index.lock >nul 2>&1

git add .
git commit -m "Fix nav CTA button hover + visibility"

echo.
echo === Push na GitHub ===
git push origin main

if %errorlevel% neq 0 (
    echo.
    echo === GRESKA pri push-u ===
    echo Mozda treba login. Pokreni ponovo nakon git login prompta.
    pause
    exit /b 1
)

echo.
echo === USPEH ===
echo Sajt se redeploy-uje na Vercel u narednih 30s.
echo.
timeout /t 5
