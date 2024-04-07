'' examples/manual/defines/fbargrightof.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ARG_RIGHTOF__'
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
