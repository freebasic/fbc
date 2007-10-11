'' examples/manual/misc/typeof1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeof
'' --------

Dim As Integer foo
Dim As TypeOf(67.2) bar '' '67.2' is a literal double
Dim As TypeOf( foo + bar ) teh_double '' double + integer results in double
Print Len(teh_double)
