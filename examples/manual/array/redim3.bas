'' examples/manual/array/redim3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRedim
'' --------

'' Define a variable-length array as UDT field
Type UDT
   Dim As Integer array(Any)
End Type

Dim As UDT u(0 To 3)

'' For use of Redim with a complex array expression
'' (especially if the array expression itself contains parentheses),
'' the array expression must be enclosed in parentheses
'' in order to solve the parsing ambiguity:
''    Redim u(0).array(0 To 9)
''    induces error 4: Duplicated definition, u in 'Redim u(0).array(0 To 9)'
ReDim (u(0).array)(0 To 9)
