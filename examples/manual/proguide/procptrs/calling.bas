'' examples/manual/proguide/procptrs/calling.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

'' .. Add and pFunc as before ..
#include Once "pfunc.bi"

Print "3 + 4 = " & pFunc(3, 4)
