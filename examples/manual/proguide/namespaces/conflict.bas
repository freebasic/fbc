'' examples/manual/proguide/namespaces/conflict.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Namespaces'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNamespaces
'' --------

Namespace A
	Dim As Integer i  ' Declare A.i
	Dim As Integer j  ' Declare A.j
End Namespace

Namespace B
	Dim As Integer i  ' Declare B.i
	Dim As Integer j  ' Declare B.j
	Using A           ' A.i/j and B.i/j are in conflict, but no error is given
End Namespace

Dim As Integer j  ' Declare also j the global scope

Using B
'i = 1   ' error: Ambiguous symbol access, explicit scope resolution required (between B.i and A.i)
B.i = 1  ' ambiguity resolution solved by using full name
j = 2    ' ambiguity (between .j, B.j, A.j) solved by compiler, by choosing override .j in the global scope
