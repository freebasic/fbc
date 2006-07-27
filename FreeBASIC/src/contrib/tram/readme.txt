TRAM - Testing Release Archive Maker
(c) 2006 by v1ctor

o Usage:

tram -root=base_path [-mask=*.*]
     -date=yyyy/mm/dd [-time=hh:mm:ss]
     [-file=output_name] [-excl=dir_name]*


o Example:

tram -root=../../.. -date=2006/05/20 -excl=dos -excl=linux -file=FB-v0.17b-jul-27-testing-win32.zip
tram -root=../../.. -date=2006/05/20 -excl=win32 -excl=linux -file=FB-v0.17b-jul-27-testing-dos.zip
tram -root=../../.. -date=2006/05/20 -excl=dos -excl=win32 -file=FB-v0.17b-jul-27-testing-linux.tar.gz