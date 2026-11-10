@echo off
rem Push the game to GitHub Pages (https://jinchaejapchae.github.io/mallang-blocks/).
cd /d "%~dp0"
git add -A
git diff --cached --quiet || git commit -q -m "update %date%"
git push -u origin main || goto :fail
echo.
echo OK: pushed. GitHub Pages updates in 1-2 minutes.
goto :end
:fail
echo.
echo FAILED - see messages above.
:end
pause
