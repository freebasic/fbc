'' examples/manual/dates/isdate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgIsDate
'' --------

#include "vbcompat.bi"

Dim s As String, d As Integer

Do
  Print
  Print "Enter a date: "

  Line Input s

  If s = "" Then Exit Do

  If IsDate( s ) = 0 Then
	Print "'"; s; "' is not a valid date"
  Else
	d = DateValue( s )
	Print "year  = "; Year( d )
	Print "month = "; Month( d )
	Print "day   = "; Day( d )
  End If

Loop
