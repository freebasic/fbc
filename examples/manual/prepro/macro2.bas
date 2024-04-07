'' examples/manual/prepro/macro2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#MACRO...#ENDMACRO'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpmacro
'' --------

' macro as multiple statements

#macro Print2( a, b )
	Print a;
	Print " ";
	Print b;
	Print "!"
#endmacro

Print2( "Hello", "World" )

/' Output :
Hello World!
'/
	
