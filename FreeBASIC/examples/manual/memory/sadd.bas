'' examples/manual/memory/sadd.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSadd
'' --------

Dim s As String

Print SAdd(s)
s = "hello"
Print SAdd(s)
s = "abcdefg, 1234567, 54321"
Print SAdd(s)
