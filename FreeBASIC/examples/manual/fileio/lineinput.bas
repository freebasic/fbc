'' examples/manual/fileio/lineinput.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLineinputPp
'' --------

' compile with -lang qb

'$lang: "qb"

Dim Filehandle As Integer
Dim txt As String
	
On Error Goto HandleErrors
	
Filehandle = FreeFile
Open "test_text_file.txt" For Input As #filehandle

If LOF(filehandle) > 0 Then
	    Line Input #filehandle, txt
Else
	    Goto HandleErrors
End If

Close #filehandle
Print "The first line of test_text_file.txt is:"
Print txt
	
HandleErrors:
Print "Error."
Resume Next

