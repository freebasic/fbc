'' examples/manual/fileio/print-using.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPrintusingPp
'' --------

Const filename As String = "file.txt"

Dim filenum As Integer = FreeFile()
If 0 <> Open(filename, For Output, As filenum) Then
	Print "error opening " & filename & " for output."
	End -1
End If

Print #filenum, Using "This file is called '&'"; filename

Print #filenum, "Some numerical values are:"
Print #filenum, Using "'###', '+###.###'"; 123.456, -123.456

Close(filenum)
