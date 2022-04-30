'' examples/manual/module/extern2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'EXTERN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExtern
'' --------

'' extern2.bas

Declare Sub SetFoo

Extern Foo Alias "foo" As Integer

Dim foo As Integer = 0

SetFoo

Print Foo
