'' examples/manual/proguide/init/udtarray.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Variable Initializers'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgInitialization
'' --------

Type mytype
	var1 As Double
	var2 As Integer
	var3 As ZString Ptr
End Type

Dim MyVar(0 To 1) As mytype = _
	{ _
		(1.1, 1, @"Hello"), _
		(2.2, 2, @"GoodBye") _
	}

For I As Integer = 0 To 1
	Print MyVar(I).var1, MyVar(I).var2, *MyVar(I).var3
Next I

Sleep
		
