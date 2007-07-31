'' examples/manual/fileio/get-file.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetfileio
'' --------

' Load a small text file to a string

Function LoadFile(f As String) As String
  Dim h As Integer
  Dim txt As String
  h = FreeFile
  Open f For Binary Access Read As #h
  If LOF(h) > 0 Then
	txt = String(LOF(h),0)
	Get #h,,txt
  End If
  Close #h
  Return txt
End Function

Dim ExampleStr As String
ExampleStr = LoadFile("smallfile.txt")
Print ExampleStr
