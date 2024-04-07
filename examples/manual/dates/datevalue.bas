'' examples/manual/dates/datevalue.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DATEVALUE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDateValue
'' --------

#include "vbcompat.bi"

Dim As Long v1, v2
Dim As String  s1, s2

Print "Enter first date: ";
Line Input s1

If IsDate( s1 ) = 0 Then
  Print "not a date"
  End
End If

Print "Enter second date: ";
Line Input s2

If IsDate( s2 ) = 0 Then
  Print "not a date"
  End
End If

'' convert the strings to date serials
v1 = DateValue( s1 )
v2 = DateValue( s2 )

Print "Number of days between dates is " & Abs( v2 - v1 )
