'' examples/manual/defines/fbargrightof.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargrightof
'' --------

#macro m( arg )
	Scope
		Var v = __FB_ARG_RIGHTOF__( arg, versus, "Not found 'versus'" )
		Print v
	End Scope
#endmacro

m(1 versus 2)
m("left-side" versus "right-side")
m(pi verso 3.14)

Sleep

/' Output:
 2
right-side
Not found 'versus'
'/
 	
