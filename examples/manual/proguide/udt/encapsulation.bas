'' examples/manual/proguide/udt/encapsulation.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Member Access Rights and Encapsulation'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberAccessRights
'' --------

Type my_Time
	Public:
		Declare Sub set_Time (ByVal new_Hour As UByte, ByVal new_Minute As UByte, ByVal new_Second As UByte)
		Declare Sub get_Time (ByRef curr_Hour As UByte, ByRef curr_Minute As UByte, ByRef curr_Second As UByte)
		Declare Function get_Time () As String
		Declare Sub increment_Time ()
	Private:
		Dim As UByte Hour
		Dim As UByte Minute
		Dim As UByte Second
End Type

Sub my_Time.set_Time (ByVal new_Hour As UByte, ByVal new_Minute As UByte, ByVal new_Second As UByte)
	If new_Hour <= 23 And new_Minute <= 59 And New_Second <= 59 Then
		This.Hour = new_Hour
		This.Minute = new_Minute
		This.Second = new_Second
	End If
End Sub

Sub my_Time.get_Time (ByRef curr_Hour As UByte, ByRef curr_Minute As UByte, ByRef curr_Second As UByte)
	curr_Hour = This.Hour
	curr_Minute = This.Minute
	curr_Second = This.Second
End Sub

Function my_Time.get_Time () As String
	Return Right("0" & Str(This.Hour), 2) & ":" & Right("0" & Str(This.Minute), 2) & ":" & Right("0" & Str(This.second), 2)
End Function

Sub my_Time.increment_Time ()
	This.Second += 1
	If This.Second = 60 Then
		This.Second = 0
		This.Minute += 1
		If This.Minute = 60 Then
			This.Minute = 0
			This.Hour += 1
			If This.Hour = 24 Then
				This.Hour = 0
			End If
		End If
	End If
End Sub


Dim As my_Time my_T
Dim As UByte h, m, s
Input "Hour? ", h
Input "Minute? ", m
Input "Second? ", s
my_T.set_Time(h, m, s)

Print
Dim As Double Tr = Int(Timer)
Do
	If Tr <> Int(Timer) Then
		Tr = Int(Timer)
		my_T.increment_Time()
		Locate  , 1, 0
		Print my_T.get_Time;
	End If
	Sleep 100, 1
Loop Until Inkey <> ""
Print
			
