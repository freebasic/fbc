'' examples/manual/proguide/libs/libs2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Using Prebuilt Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPrebuiltLibraries
'' --------

#include Once "crt/stdio.bi"
Dim f As FILE Ptr
f = fopen("somefile.txt", "w")
fprintf( f, "Hello File\n")
fclose( f )
