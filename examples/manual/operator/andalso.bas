'' examples/manual/operator/andalso.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpAndAlso
'' --------

' Using the ANDALSO operator on two numeric values
Dim As Integer numeric_value1, numeric_value2
numeric_value1 = 15
numeric_value2 = 30

'Result =  -1
Print numeric_value1 AndAlso numeric_value2
Sleep
