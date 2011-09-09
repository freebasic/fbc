'' examples/manual/module/dylibload.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDylibload
'' --------

Dim hndl As Any Ptr

hndl=DyLibLoad("MYLIB.DLL")
