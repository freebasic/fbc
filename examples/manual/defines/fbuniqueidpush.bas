'' examples/manual/defines/fbuniqueidpush.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_UNIQUEID_PUSH__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbuniqueidpush
'' --------

' As the "unique identifiers" (used as jump labels) are successively pushed on to a stack,
' the jump-code bodies must be defined in the reversed order than the jump calls.

#macro go
	__FB_UNIQUEID_PUSH__( stk )
	Goto __FB_UNIQUEID__( stk )
	End If
#endmacro

#macro end_go
	__FB_UNIQUEID__( stk ):
	__FB_UNIQUEID_POP__( stk )
#endmacro
	
Dim As Integer N

Do
	Input "Enter a value between 1 and 4 (0 or empty input for exit) ? ", N
	
	If N = 0 Then go
	If N = 1 Then go
	If N = 2 Then go
	If N = 3 Then go
	If N = 4 Then go
	Continue Do
	
	end_go
		Print "You entered 4" : Continue Do
	end_go
		Print "You entered 3" : Continue Do
	end_go
		Print "You entered 2" : Continue Do
	end_go
		Print "You entered 1" : Continue Do
	end_go
		Print "End"           : Exit Do
Loop

Sleep
	
