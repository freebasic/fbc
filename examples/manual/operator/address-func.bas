'' examples/manual/operator/address-func.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator @ (Address of)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpAt
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
