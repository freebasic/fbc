'' examples/manual/control/select-speed.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SELECT CASE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSelectcase
'' --------

'' SELECT CASE vs. SELECT CASE AS CONST speed test

Const N = 50000000

Dim As Integer dummy = 0
Dim As Double t = Timer()

For i As Integer = 1 To N
	Select Case i
	Case 1, 3, 5, 7, 9
		dummy += 1
	Case 2, 4, 6, 8, 10
		dummy += 1
	Case 11 To 20
		dummy += 1
	Case 21 To 30
		dummy += 1
	Case 31
		dummy += 1
	Case 32
		dummy += 1
	Case 33
		dummy += 1
	Case Is >= 34
		dummy += 1
	Case Else
		Print "can't happen"
	End Select
Next

Print Using "SELECT CASE: ##.### seconds"; Timer() - t
t = Timer()

For i As Integer = 1 To N
	Select Case As Const i
	Case 1, 3, 5, 7, 9
		dummy += 1
	Case 2, 4, 6, 8, 10
		dummy += 1
	Case 11 To 20
		dummy += 1
	Case 21 To 30
		dummy += 1
	Case 31
		dummy += 1
	Case 32
		dummy += 1
	Case 33
		dummy += 1
	Case Else
		If( i >= 34 ) Then
			dummy += 1
		Else
			Print "can't happen"
		End If
	End Select
Next

Print Using "SELECT CASE AS CONST: ##.### seconds"; Timer() - t
Sleep
