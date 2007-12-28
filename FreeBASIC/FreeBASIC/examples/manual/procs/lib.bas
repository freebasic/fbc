'' examples/manual/procs/lib.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLib
'' --------

Declare Function GetValue Lib "mydll" () As Integer

Print "GetValue = &h"; Hex(GetValue())

' Expected Output :
' GetValue = &h1234
