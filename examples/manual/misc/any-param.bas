'' examples/manual/misc/any-param.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAny
'' --------

'Example of ANY disabling the variable type checking
Declare Sub echo (ByRef a As Any) '' ANY disables the checking for the type of data passed to the function

Dim x As Single
x = -15
echo x                  '' Passing a single to a function that expects an integer. The compiler does not complain!!             
Sleep

Sub echo (ByRef a As Integer)
  Print Hex(a)         
End Sub

