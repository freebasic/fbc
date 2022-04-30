'' examples/manual/prepro/macro3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#MACRO...#ENDMACRO'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpmacro
'' --------

' macro with a variadic parameter

#macro test1( arg1, arg2... )
	Print arg1
	#if #arg2 = ""
		Print "2nd argument not passed"
	#else
		Print arg2
	#endif
#endmacro

test1( "1", "2" )
Print "-----------------------"
test1( "3" )
Print "-----------------------"
test1( 5, 6 )
Print "-----------------------"
test1( 7 )

/' Output :
1
2
-----------------------
3
2nd argument not passed
-----------------------
 5
 6
-----------------------
 7
2nd argument not passed
'/
	
