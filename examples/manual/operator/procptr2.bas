'' examples/manual/operator/procptr2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpProcptr
'' --------

Sub s Overload()
End Sub

Sub s( ByVal i As Integer )
End Sub

'----- Previously (fbc version < 1.09.0) was only possible with:

'Dim s1 As Sub()
's1 = Procptr( s )

'Dim s2 As Sub( Byval i As Integer)
's2 = Procptr( s )

'----- Now (fbc version >= 1.09.0) is possible with:

Var s1 = ProcPtr( s, Sub() )
Var s2 = ProcPtr( s, Sub( ByVal i As Integer ) )
	
