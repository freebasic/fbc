'' examples/manual/procs/byval.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BYVAL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByval
'' --------

Sub MySub(ByVal value As Integer)
	value += 1
End Sub

Dim MyVar As Integer

MyVar = 1
Print "MyVar: "; MyVar 'output = 1
MySub MyVar
Print "MyVar: "; MyVar 'output = 1, because byval won't change the values passed into it globally.
Sleep
End
