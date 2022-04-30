'' examples/manual/procs/lib.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LIB'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLib
'' --------

Declare Function GetValue Lib "mydll" () As Integer

Print "GetValue = &h"; Hex(GetValue())

' Expected Output :
' GetValue = &h1234
