'' examples/manual/misc/typeof1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TYPEOF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeof
'' --------

Dim As Integer foo
Dim As TypeOf(67.2) bar '' '67.2' is a literal double
Dim As TypeOf( foo + bar ) teh_double '' double + integer results in double
Print SizeOf(teh_double)
		
