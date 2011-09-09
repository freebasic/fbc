'' examples/manual/procs/func-3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunction
'' --------

'' This program demonstrates function overloading.

'' The overloaded functions must be FIRST.
Declare Function ReturnTen Overload (a As Single) As Integer
Declare Function ReturnTen Overload (a As String) As Integer
Declare Function ReturnTen (a As Integer) As Integer

Print ReturnTen (10.000!) '' ReturnTen will take a single and return an integer
Print ReturnTen (10)      '' ReturnTen will take an integer and return an integer
Print ReturnTen ("10")    '' ReturnTen will take a string and return an integer

Function ReturnTen Overload (a As Single) As Integer
	Return Int(a)
End Function

Function ReturnTen Overload (a As String) As Integer
	Return Val(a)
End Function

Function ReturnTen (a As Integer) As Integer
	Return a
End Function
