'' examples/manual/fileio/encoding.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ENCODING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgEncoding
'' --------

'' This example will:
'' 1) Write a string to a text file with utf-16 encoding
'' 2) Display the byte contents of the file
'' 3) Read the text back from the file
''
'' WSTRING's will work as well but STRING has been
'' used in this example since not all consoles support
'' printing WSTRING's.

'' The name of the file to use in this example
Dim f As String
f = "sample.txt"

''
Scope
  Dim s As String
  s = "FreeBASIC"

  Print "Text to write to " + f + ":"
  Print s
  Print

  '' open a file for output using utf-16 encoding
  '' and print a short message
  Open f For Output Encoding "utf-16" As #1

  '' The ascii string is converted to utf-16
  Print #1, s
  Close #1
End Scope

''
Scope
  Dim s As String, n As LongInt

  '' open the same file for binary and read all the bytes
  Open f For Binary As #1
  n = LOF(1)
  s = Space( n )
  Get #1,,s
  Close #1
  
  Print "Binary contents of " + f + ":"
  For i As Integer = 1 To n
	Print Hex( Asc( Mid( s, i, 1 )), 2); " ";
  Next
  Print
  Print

End Scope

''
Scope
  Dim s As String
  
  '' open a file for input using utf-16 encoding
  '' and read back the message
  Open f For Input Encoding "utf-16" As #1

  '' The ascii string is converted from utf-16
  Line Input #1, s
  Close #1

  '' Display the text
  Print "Text read from " + f + ":"
  Print s
  Print
End Scope
