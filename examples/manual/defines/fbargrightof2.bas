'' examples/manual/defines/fbargrightof2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ARG_RIGHTOF__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargrightof
'' --------

#macro count( range )
	Scope
		Dim x As Integer = __FB_ARG_LEFTOF__( range, To )
		Dim y As Integer = __FB_ARG_RIGHTOF__( range, To )
		Dim s As Integer = Sgn(y - x)
		Print "Counting " & #range
		For i As Integer = x To y Step s
			Print i
		Next i
	End Scope

#endmacro

count( 4 To 10 )
count( 7 To 2 )

Sleep

/' Output:
Counting 4 to 10
 4
 5
 6
 7
 8
 9
 10
Counting 7 to 2
 7
 6
 5
 4
 3
 2
'/
