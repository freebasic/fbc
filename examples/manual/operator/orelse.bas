'' examples/manual/operator/orelse.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator ORELSE (Short Circuit Inclusive Disjunction)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpOrElse
'' --------

' Using the ORELSE operator on two numeric values
Dim As Integer numeric_value1, numeric_value2
numeric_value1 = 15
numeric_value2 = 30

'Result = -1
Print numeric_value1 OrElse numeric_value2
Sleep
