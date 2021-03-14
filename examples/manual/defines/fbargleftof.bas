'' examples/manual/defines/fbargleftof.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargleftof
'' --------

#macro m( arg )
	Scope
		Var v = __FB_ARG_LEFTOF__( arg, versus, "Not found 'versus'" )
		Print v
	End Scope
#endmacro

m(1 versus 2)
m("left-side" versus "right-side")
m(3.14 verso pi)

Sleep

/' Output:
 1
left-side
Not found 'versus'
'/
	
