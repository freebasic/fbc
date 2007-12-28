@echo off

set _defpath_=lib\win32\def

rem
rem create the import-libraries
rem

if not exist %_defpath_%\genimplibs.exe goto deferr

cd %_defpath_%
genimplibs.exe
goto defend

rem ----------------
:deferr
echo.
echo.ERROR: %_defpath_%\genimplibs.exe not found.
echo.
goto batexit

rem ----------------
:defend
goto batend

rem ----------------
:batend
echo.
echo.Installation completed.
echo.

rem ----------------
:batexit
pause

set _defpath_=