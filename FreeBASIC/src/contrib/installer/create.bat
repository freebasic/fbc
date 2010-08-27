rem Compile the start-shell tool, which is only distributed in the installer.
..\..\..\fbc -exx start-shell.bas -x ..\..\..\start-shell.exe

rem makescript will put together the NSIS installer script based on the
rem template.nsi and the win32 manifest ../../../manifest/win32.lst.
..\..\..\fbc -exx makescript.bas
makescript.exe

rem Create the installer .exe...
C:\NSIS\makensis.exe -V2 ..\..\..\installer.nsi

rem Clean up
del makescript.exe ..\..\..\installer.nsi ..\..\..\start-shell.exe

pause
