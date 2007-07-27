'' examples/manual/prepro/macro2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpmacro
'' --------

'' macro as multiple statements
#macro Print2( a, b )
  Print a;
  Print " ";
  Print b;
  Print "!"
#endmacro

Print2( "Hello", "World" )

'' Output :
'' Hello World!
