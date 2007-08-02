'' examples/manual/incoming/KeyPgDim_6.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDim
'' --------

Type mytype
	var1 As Double
	var2 As Integer
End Type
		
Dim myvar(0 To 2) As mytype => {(1.0, 1), (2.0, 2)}
