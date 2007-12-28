'' examples/manual/meta/static.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMetaStatic
'' --------

' compile with -lang deprecated or qb
Option Dynamic
Dim a(100)   '<<this array will be dynamic
Option Static
Dim b(100)   '<<this array will be static
