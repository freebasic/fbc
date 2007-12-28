'' examples/manual/control/select.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSelectcase
'' --------

Dim choice As Integer

Input "Choose a number between 1 and 10: "; choice

Select Case As Const choice
Case 1
	Print "number is 1"
Case 2
	Print "number is 2"
Case 3, 4
	Print "number is 3 or 4"
Case 5 To 10
	Print "number is in the range of 5 to 10"
Case Else
	Print "number is outside the 1-10 range"
End Select
