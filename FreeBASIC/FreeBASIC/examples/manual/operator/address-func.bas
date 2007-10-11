'' examples/manual/operator/address-func.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpAt
'' --------

'This program demonstrates how the @ symbol can be used
'to create pointers to subroutines.

Declare Sub mySubroutine ()

Dim say_Hello As Sub() 

say_Hello = @mySubroutine   'We tell say_Hello to point to mySubroutine.
	                        'The sub() datatype acts as a pointer here.

say_Hello() 'Now we can run say_Hello just like mySubroutine.

Sub mySubroutine
	Print "hi"
End Sub
