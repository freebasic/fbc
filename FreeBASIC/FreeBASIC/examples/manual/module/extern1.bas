'' examples/manual/module/extern1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExtern
'' --------

'' extern1.bas

Extern Foo Alias "foo" As Integer

Sub SetFoo
	foo = 1234
End Sub
