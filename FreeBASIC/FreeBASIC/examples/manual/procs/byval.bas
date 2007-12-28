'' examples/manual/procs/byval.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByval
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
