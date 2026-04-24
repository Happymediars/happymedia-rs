@echo off
REM =============================================================
REM  PUSH SAJT — jedan klik, sve ide na live
REM  Dvoklikni ovaj fajl. Gotovo.
REM =============================================================

cd /d "%~dp0"
title Happy Media — Push na sajt

echo.
echo  ===========================================
echo    HAPPY MEDIA - PUSH NA LIVE SAJT
echo  ===========================================
echo.

REM Cisti stale lock (Windows/Git race condition fix)
if exist .git\index.lock del /f /q .git\index.lock >nul 2>&1

REM Proveri da li ima promena
git status --porcelain >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Ovaj folder nema git repo.
    pause
    exit /b 1
)

for /f %%A in ('git status --porcelain ^| find /c /v ""') do set COUNT=%%A

if "%COUNT%"=="0" (
    echo  [i] Nema novih izmena za slanje.
    echo  [i] Sve je vec na live sajtu.
    echo.
    timeout /t 4 >nul
    exit /b 0
)

echo  [*] Pronadjeno %COUNT% izmena
echo  [*] Pakujem i saljem na GitHub...
echo.

REM Auto commit sa datumom kao porukom
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set ldt=%%a
set DATE_STR=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2% %ldt:~8,2%:%ldt:~10,2%

git add . >nul 2>&1
git commit -m "Izmene sajta — %DATE_STR%" >nul 2>&1

echo  [*] Push na GitHub...
git push origin main

if %errorlevel% neq 0 (
    echo.
    echo  [X] GRESKA pri push-u.
    echo      Mozda treba GitHub login. Pokreni ponovo.
    echo.
    pause
    exit /b 1
)

echo.
echo  ===========================================
echo    USPEH! Vercel redeploy u narednih 30s.
echo    Osvezi sajt za minut.
echo  ===========================================
echo.
timeout /t 5 >nul
