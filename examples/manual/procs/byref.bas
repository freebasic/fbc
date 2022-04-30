'' examples/manual/procs/byref.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BYREF (parameters)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByref
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
