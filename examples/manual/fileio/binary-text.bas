'' examples/manual/fileio/binary-text.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BINARY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBinary
'' --------

'' Read entire contents of a file to a string
Dim txt As String

Open "myfile.txt" For Binary Access Read As #1
  If LOF(1) > 0 Then
	'' our string has as many characters as the file has in bytes
	txt = String(LOF(1), 0)
	'' size of txt is known.  entire string filled with file data
	Get #1, , txt
  End If
Close #1

Print txt
