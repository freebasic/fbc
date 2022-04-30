'' examples/manual/misc/sizeof-udt.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SIZEOF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSizeof
'' --------

Type bar
	a As Integer
	b As Double
End Type
Dim foo As bar
Print SizeOf(foo)
	
