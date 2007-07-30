'' examples/manual/operator/or-logical.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpOr
'' --------

' Using the OR operator on two conditional expressions
Dim As UByte numeric_value
numeric_value = 10

If numeric_value = 5 Or numeric_value = 10 Then Print "Numeric_Value equals 5 or 10"
Sleep

' This will output "Numeric_Value equals 5 or 10" because
' while the first condition of the first IF statement is false, the second is true
