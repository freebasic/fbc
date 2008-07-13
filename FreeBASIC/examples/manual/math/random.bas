'' examples/manual/math/random.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRandom
'' --------

Type UDT
	slen As Byte
	sdata As String * 10
End Type

Dim i As Integer
Dim s As String
Dim u As UDT

Dim ff As UByte
Dim fpos As Integer

ff = FreeFile
fpos = 10

Open "testfile" For Random As #ff Len=SizeOf(UDT)
For i = 1 To 9
	Read s
	u = Type( Len(s), s )
	Put #ff, i, u
Next

Do
	Input "Record number: ", i
	If i < 1 Or i > 9 Then Exit Do
	Get #1, i, u
	Print i & ": " & Left( u.sdata, u.slen )
	Print
Loop

Close #ff
End 0

Data ".,-?!'@:", "abc",      "def"
Data "ghi",      "jkl",      "mno"
Data "pqrs",     "tuv",      "wxyz"
