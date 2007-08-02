'' examples/manual/module/extern2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExtern
'' --------

'' extern2.bas

Declare Sub SetFoo

Extern Foo Alias "foo" As Integer

Dim foo As Integer = 0

SetFoo

Print Foo
