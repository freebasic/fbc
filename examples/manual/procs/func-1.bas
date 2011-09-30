'' examples/manual/procs/func-1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunction
'' --------

'' This program demonstrates the declaration of a function 
'' and returning a value using Return command

Declare Function ReturnTen () As Integer

Print ReturnTen () '' ReturnTen returns an integer by default.

Function ReturnTen() As Integer
	Return 10
End Function
