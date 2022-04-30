'' examples/manual/operator/not-logical.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Not (Complement)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNot
'' --------

' Using the NOT operator on conditional expressions
Dim As UByte numeric_value1, numeric_value2
numeric_value1 = 15
numeric_value2 = 25

If Not numeric_value1 = 10 Then Print "Numeric_Value1 is not equal to 10"
If Not numeric_value2 = 25 Then Print "Numeric_Value2 is not equal to 25"

' This will output "Numeric_Value1 is not equal to 10" because
' the first IF statement is false.
' It will not output the result of the second IF statement because the
' condition is true. 
