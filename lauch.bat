@echo off
setlocal
cd /d "%~dp0"

set "ORIGIN_URL=https://github.com/Aksl-Ushindi/anaconda.git"
set "BRANCH=main"

echo =====================================
echo RESET + REDEPLOY (FORCE) vers GitHub
echo Repo: %ORIGIN_URL%
echo =====================================

if exist ".git" rmdir /s /q ".git"

git init
git branch -M %BRANCH%
git remote add origin "%ORIGIN_URL%"

if not exist "index.html" (
  for %%F in (*.html) do (
    echo [INFO] index.html absent, renommage de %%F en index.html
    ren "%%F" "index.html"
    goto :doneindex
  )
)
:doneindex

git add .
git commit -m "redeploy"

REM >>> LE TRUC IMPORTANT ICI <<<
git push -u origin %BRANCH% --force

pause