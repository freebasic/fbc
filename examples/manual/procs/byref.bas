'' examples/manual/procs/byref.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByref
'' --------

Dim MyVar As Integer

Sub ChangeVar(ByRef AVar As Integer)
	AVar = AVar + 1
End Sub

MyVar = 1
Print "MyVar: "; MyVar 'output = 1
ChangeVar MyVar
Print "MyVar: "; MyVar 'output = 2
Sleep
End
