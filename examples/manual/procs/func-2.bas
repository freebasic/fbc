'' examples/manual/procs/func-2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FUNCTION'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunction
'' --------

'' This program demonstrates the declaration of a function 
'' and returning a value using assignment to function name

Declare Function ReturnTen () As Integer

Print ReturnTen () '' ReturnTen returns an integer by default.

Function ReturnTen() As Integer
	ReturnTen = 10
End Function
