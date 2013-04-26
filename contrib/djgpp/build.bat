rem @echo off

set DJDIR=C:\DJGPP

rem Compile the new _main.o (this requires DJGPP source headers from CVS)
gcc -Wall -O2 -c libc/crt0/_main.c -o _main.o

rem Copy DJGPP's libc.a and insert the updated _main.o
copy %DJDIR%\lib\libc.a .
ar rs libc.a _main.o

pause
