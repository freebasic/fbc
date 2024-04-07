'' examples/manual/operator/procptr2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator PROCPTR (Procedure pointer)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpProcptr
'' --------

Sub s Overload()
End Sub

Sub s( ByVal i As Integer )
End Sub

'----- since fbc 1.09.0, ProcPtr supports a second parameter (optional):
Var s1 = ProcPtr( s, Sub() )
Var s2 = ProcPtr( s, Sub( ByVal i As Integer ) )

'----- before fbc 1.09.0, it was only possible with:
'Dim s1 As Sub()
's1 = ProcPtr( s )
'Dim s2 As Sub( Byval i As Integer)
's2 = ProcPtr( s )
