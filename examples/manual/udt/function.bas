'' examples/manual/udt/function.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FUNCTION (Member)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMemberFunction
'' --------

#include "vbcompat.bi"

Type Date

  value As Double

  Declare Static Function Today() As Date

  Declare Function Year() As Integer
  Declare Function Month() As Integer
  Declare Function Day() As Integer

End Type

Function Date.Today() As Date
  Return Type(Now())
End Function

Function Date.Year() As Integer
  Return ..Year(value)
End Function

Function Date.Month() As Integer
  Return ..Month(value)
End Function

Function Date.Day() As Integer
  Return ..Day(value)
End Function

Dim d As Date = Date.Today

Print "Year  = "; d.Year
Print "Month = "; d.Month
Print "Day   = "; d.Day

