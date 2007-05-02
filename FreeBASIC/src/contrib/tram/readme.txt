TRAM - Testing Release Archive Maker
(c) 2006 by v1ctor

o Usage:

tram -root=base_path [-mask=*.*]
     -date=yyyy/mm/dd [-time=hh:mm:ss]
     [-file=output_name] [-excl=dir_name]*


o Example:

tram -root=../../.. -date=2006/05/20 -excl=dos -excl=linux -file=FB-v0.17b-may-08-2007-testing-win32.zip
tram -root=../../.. -date=2006/05/20 -excl=win32 -excl=cygwin -excl=linux -file=FB-v0.17b-may-08-2007-testing-dos.zip
./tram -root=../../.. -date=2006/05/20 -excl=dos -excl=cygwin -excl=win32 -file=FB-v0.17b-may-08-2007-testing-linux.tar.gz