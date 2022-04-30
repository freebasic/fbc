'' examples/manual/defines/fbuniqueidpop.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_UNIQUEID_POP__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbuniqueidpop
'' --------

#macro repeat ? ( count )  '' with user named variable
	Scope
		Dim __counter__ As UInteger = count
		While( __counter__)
#endmacro

#macro end_repeat  '' with user named variable
			__counter__ -= 1
		Wend
	End Scope   
#endmacro

Print "With user named variable:"
repeat 3
	Print "   outer"
	repeat 2
		Print "   --- inner"
	end_repeat
end_repeat
Print


#undef repeat
#undef end_repeat

#macro repeat ? ( count )  '' with "unique identifier" variable
	__FB_UNIQUEID_PUSH__( ctx )
	Dim __FB_UNIQUEID__( ctx ) As UInteger = count
	While( __FB_UNIQUEID__( ctx ) )
#endmacro

#macro end_repeat  '' with "unique identifier" variable
		__FB_UNIQUEID__( ctx ) -= 1
	Wend
	__FB_UNIQUEID_POP__( ctx )
#endmacro

Print "With ""unique identifier"" variable:"
repeat 3
	Print "   outer"
	repeat 2
		Print "   --- inner"
	end_repeat
end_repeat

Sleep

/' Output:
With user named variable:
   outer
   --- inner
   --- inner
   outer
   --- inner
   --- inner
   outer
   --- inner
   --- inner

With "unique identifier" variable:
   outer
   --- inner
   --- inner
   outer
   --- inner
   --- inner
   outer
   --- inner
   --- inner
'/
	
