'' examples/manual/operator/and-logical.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator AND (Conjunction)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpAnd
'' --------

' Using the AND operator on two conditional expressions
Dim As UByte numeric_value1, numeric_value2
numeric_value1 = 15
numeric_value2 = 25

If numeric_value1 > 10 And numeric_value1 < 20 Then Print "Numeric_Value1 is between 10 and 20"
If numeric_value2 > 10 And numeric_value2 < 20 Then Print "Numeric_Value2 is between 10 and 20"
Sleep

' This will output "Numeric_Value1 is between 10 and 20" because
' both conditions of the IF statement is true
' It will not output the result of the second IF statement because the first
' condition is true and the second is false.
