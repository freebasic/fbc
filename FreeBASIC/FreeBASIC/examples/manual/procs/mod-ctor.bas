'' examples/manual/procs/mod-ctor.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgModuleConstructor
'' --------

'' ConDesExample.bas : An example program that defines two sets of
'' constructors and destructors. Demonstrates when and in what order
'' they are called when linking a single module.

Sub Constructor1() Constructor
	Print "Constructor1() called"
End Sub

Sub Destructor1() Destructor
	Print "Destructor1() called"
End Sub

Sub Constructor2() Constructor
	Print "Constructor2() called"
End Sub

Sub Destructor2() Destructor
	Print "Destructor2() called"
End Sub

	'' ----------------------
	Print "module-level code"

	End 0
	'' ----------------------
