'' examples/manual/proguide/shared-lib/mytest.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgSharedLibraries
'' --------

'' mytest.bas
'' compile with: fbc mytest.bas
#include Once "mylib.bi"
Print Add2(1,2)
