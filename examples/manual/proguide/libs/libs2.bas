'' examples/manual/proguide/libs/libs2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPrebuiltLibraries
'' --------

#include once "crt/stdio.bi"
Dim f As FILE Ptr
f = fopen("somefile.txt", "w")
fprintf( f, "Hello File\n")
fclose( f )
