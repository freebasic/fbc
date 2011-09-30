'' examples/manual/module/using.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUsing
'' --------

Namespace Sample
	Type T
		x As Integer
	End Type
End Namespace

'' Just using the name T would not find the symbol,
'' because it is inside a namespace.
Dim SomeVariable As Sample.T

'' Now the whole namespace has been inherited into
'' the global namespace.
Using Sample

'' This statement is valid now, since T exists
'' without the "Sample." prefix.
Dim OtherVariable As T 
