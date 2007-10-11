'' examples/manual/proguide/init/udtarray.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgInitialization
'' --------

Type mytype
	var1 As Double
	var2 As Integer
	var3 As ZString Ptr
End Type

Dim MyVar(2) As mytype => _
	{ _
		(1.0, 1, @"Hello"), _
		(2.0, 2, @"GoodBye") _
	}
