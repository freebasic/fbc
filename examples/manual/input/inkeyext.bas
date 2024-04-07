'' examples/manual/input/inkeyext.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INKEY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInkey
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

#if __FB_LANG__ = "qb"
#define EXTCHAR Chr$(0)
#else
#define EXTCHAR Chr(255)
#endif

Dim k As String

Print "Press a key, or Escape to end"
Do

	k = Inkey$

	Select Case k

		Case "A" To "Z", "a" To "z": Print "Letter: " & k
		Case "1" To "9":             Print "Number: " & k

		Case Chr$(32): Print "Space"

		Case Chr$(27): Print "Escape"

		Case Chr$(9): Print "Tab"

		Case Chr$(8): Print "Backspace"

		Case Chr$(32) To Chr$(127)
			Print "Printable character: " & k

		Case EXTCHAR & "G": Print "Up Left / Home"
		Case EXTCHAR & "H": Print "Up"
		Case EXTCHAR & "I": Print "Up Right / PgUp"

		Case EXTCHAR & "K": Print "Left"
		Case EXTCHAR & "L": Print "Center"
		Case EXTCHAR & "M": Print "Right"

		Case EXTCHAR & "O": Print "Down Left / End"
		Case EXTCHAR & "P": Print "Down"
		Case EXTCHAR & "Q": Print "Down Right / PgDn"

		Case EXTCHAR & "R": Print "Insert"
		Case EXTCHAR & "S": Print "Delete"


		Case EXTCHAR & "k": Print "Close window / Alt-F4"

		Case EXTCHAR & Chr$(59) To EXTCHAR & Chr$(68)
			Print "Function key: F" & Asc(k, 2) - 58

		Case EXTCHAR & Chr$(133) To EXTCHAR & Chr$(134)
			Print "Function key: F" & Asc(k, 2) - 122

		Case Else
			If Len(k) = 2 Then
				Print Using "Extended character: chr$(###, ###)"; Asc(k, 1); Asc(k, 2)
			ElseIf Len(k) = 1 Then
				Print Using "Character chr$(###)"; Asc(k)
			End If

	End Select

	If k = Chr$(27) Then Exit Do

	Sleep 1, 1

Loop
