'' examples/manual/module/extern1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'EXTERN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExtern
'' --------

'' extern1.bas

Extern Foo Alias "foo" As Integer

Sub SetFoo
	foo = 1234
End Sub
