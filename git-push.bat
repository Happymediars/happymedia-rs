@echo off
REM ==========================================================================
REM  Happy Media — git init + push na GitHub
REM  Uputstvo:
REM  1) Napravi prazan repo na GitHub-u: https://github.com/new
REM     - Name: happymedia-rs
REM     - OSTAVI PRAZAN (ne dodaj README, .gitignore, license)
REM  2) Otvori CMD u ovom folderu (ili pokreni ovaj .bat)
REM  3) Upisaćeš svoj GitHub username kad pita
REM ==========================================================================

setlocal enabledelayedexpansion

echo.
echo === Happy Media — Deploy na GitHub ===
echo.
set /p GH_USER="GitHub username (npr. markocovic): "
if "!GH_USER!"=="" (
    echo Nisi uneo username. Izlazim.
    exit /b 1
)

set /p GH_REPO="Naziv repo-a [happymedia-rs]: "
if "!GH_REPO!"=="" set GH_REPO=happymedia-rs

echo.
echo Remote URL ce biti: https://github.com/!GH_USER!/!GH_REPO!.git
echo.

REM Obrisati postojeci .git ako postoji (zbog Windows/sandbox konflikta)
if exist .git rmdir /s /q .git

git init -b main
git config user.email "marko@happymedia.rs"
git config user.name "Marko Covic"
git add .
git commit -m "Initial commit: happymedia.rs redesign 2026"
git remote add origin https://github.com/!GH_USER!/!GH_REPO!.git
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo === GRESKA pri push-u ===
    echo Najcesci uzroci:
    echo  1) Repo ne postoji na GitHub-u - napravi ga na https://github.com/new
    echo  2) Nisi ulogovan - pokreni "gh auth login" ili unesi token kad git pita
    echo  3) Username pogresno napisan
    exit /b 1
)

echo.
echo === USPEH ===
echo Repo dostupan na: https://github.com/!GH_USER!/!GH_REPO!
echo.
echo Sledeci korak - Vercel auto-deploy:
echo  1) Idi na https://vercel.com/new
echo  2) Import Git Repository - izaberi !GH_REPO!
echo  3) Deploy (Vercel automatski detektuje static site)
echo.
pause
