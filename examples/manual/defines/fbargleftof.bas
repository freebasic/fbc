'' examples/manual/defines/fbargleftof.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ARG_LEFTOF__'
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
