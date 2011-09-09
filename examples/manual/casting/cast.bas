'' examples/manual/casting/cast.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCast
'' --------

'' will print -128 because the integer literal will be converted to a signed Byte
'' (this Casting operation is equivalent to using CByte)
Print Cast( Byte, &h0080 )

'' will print 3 because the floating-point value will be converted to an Integer
'' (this Casting operator is equivalent to using CInt)
Print Cast( Integer, 3.1 )
