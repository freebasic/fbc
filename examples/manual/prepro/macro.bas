'' examples/manual/prepro/macro.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#MACRO...#ENDMACRO'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpmacro
'' --------

' macro as an expression value

#macro Print1( a, b )
	a + b
#endmacro

Print Print1( "Hello ", "World!" )

/' Output :
Hello World!
'/
	
