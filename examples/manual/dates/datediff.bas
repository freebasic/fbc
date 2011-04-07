'' examples/manual/dates/datediff.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDateDiff
'' --------

#include "vbcompat.bi"

Dim s As String, d1 As Double, d2 As Double

Line Input "Enter your birthday: ", s

If IsDate( s ) Then
  d1 = DateValue( s )
  d2 = Now()

  Print "You are " & DateDiff( "yyyy", d1, d2 ) & " years old."
  Print "You are " & DateDiff( "d", d1, d2 ) & " days old."
  Print "You are " & DateDiff( "s", d1, d2 ) & " seconds old."

Else
  Print "Invalid date"

End If
