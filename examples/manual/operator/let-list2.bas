'' examples/manual/operator/let-list2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator LET() (Assignment)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpLetlist
'' --------

Type Parent
	Dim As Integer p1, p2
End Type

Type Child Extends Parent
	Dim As Integer c1, c2
End Type

Type GrandChild Extends Child
	Dim As Integer gc1, gc2
End Type

Dim As GrandChild gc = Type(1, 2, 3, 4, 5, 6)

Dim As Integer i1, i2
Dim As Integer j1, j2
Dim As Parent p
Dim As Child c

Let(c, i1, i2) = gc
Print c.p1, c.p2, c.c1, c.c2, i1, i2

Let(p, j1, j2) = gc
Print p.p1, p.p2, j1, j2
