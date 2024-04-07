'' examples/manual/operator/xor-logical.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator XOR (Exclusive Disjunction)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpXor
'' --------

' Using the XOR operator on two conditional expressions
Dim As UByte numeric_value1, numeric_value2
numeric_value1 = 10
numeric_value2 = 15

If numeric_value1 = 10 Xor numeric_value2 = 20 Then Print "Numeric_Value1 equals 10 or Numeric_Value2 equals 20"
Sleep

' This will output "Numeric_Value1 equals 10 or Numeric_Value2 equals 20"
' because only the first condition of the IF statement is true
