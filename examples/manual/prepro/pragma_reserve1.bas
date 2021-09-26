'' examples/manual/prepro/pragma_reserve1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpPragmaReserve
'' --------

Dim As Integer variable1 = 1

Scope
	#pragma reserve variable1
	Print variable1
	Dim As Integer variable1 = 2  '' error: Duplicated definition, variable1 in .....
End Scope

Dim Shared As Integer variable2 = 3

Sub s()
	#pragma reserve variable2
	Print variable2
	Dim As Integer variable2 = 4  '' error: Duplicated definition, variable2 in .....
End Sub

Print variable1
s()
Print variable2

Sleep
		
