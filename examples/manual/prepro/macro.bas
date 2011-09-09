'' examples/manual/prepro/macro.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpmacro
'' --------

'' macro as an expression value
#macro Print1( a, b )
  a + b
#endmacro

Print Print1( "Hello", "World" )

'' Output :
'' Hello World!
