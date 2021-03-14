'' examples/manual/defines/fbargextract2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargextract
'' --------

'   In this example, the '__FB_EVAL__' is absolutely mandatory in this 'print_last' macro,
'   because the numeric expression '__FB_ARG_COUNT__( args ) - 1' must be fully evaluated
'   before being used as the index argument of '__FB_ARG_EXTRACT__'

#macro print_last( args... )
	#define last_arg_num __FB_EVAL__( __FB_ARG_COUNT__( args ) - 1 )
	#print __FB_ARG_EXTRACT__( last_arg_num, args )
#endmacro

print_last( 7, 89.78, "Postman" )

/' Compiler output:
Postman
'/
	
