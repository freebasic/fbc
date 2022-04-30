'' examples/manual/math/random1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RANDOM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRandom
'' --------

'' This example generates a test file and then lets you view random records
'' that are read live from the file.

Type Entry
	slen As Byte
	sdata As String * 10
End Type

Dim u As Entry
Dim s As String

Open "testfile" For Random As #1 Len = SizeOf(Entry)

'' Write out 9 records with predefined data
For i As Integer = 1 To 9
	Read s
	u = Type( Len(s), s )
	Put #1, i, u
Next

Data ".,-?!'@:", "abc",      "def"
Data "ghi",      "jkl",      "mno"
Data "pqrs",     "tuv",      "wxyz"

'' Let the user view records by specifying their index number
Do
	Dim i As Integer
	Input "Record number: ", i
	If i < 1 Or i > 9 Then Exit Do

	Get #1, i, u
	Print i & ": " & Left( u.sdata, u.slen )
	Print
Loop

Close #1
