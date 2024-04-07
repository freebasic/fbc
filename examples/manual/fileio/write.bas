'' examples/manual/fileio/write.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WRITE #'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWritePp
'' --------

Const filename As String = "file.txt"

Dim filenum As Integer = FreeFile()
If 0 <> Open(filename, For Output, As filenum) Then
	Print "error opening " & filename & " for output."
	End -1
End If

Dim i As Integer = 10
Dim d As Double = 123.456
Dim s As String = "text"

Write #filenum, 123, "text", -.45600
Write #filenum,
Write #filenum, i, d, s
