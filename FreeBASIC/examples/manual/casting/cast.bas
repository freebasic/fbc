'' examples/manual/casting/cast.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCast
'' --------

'' will print -128 because the integer literal will be converted to a signed byte
Print Cast( Byte, &h0080 )
