'' examples/manual/misc/typeof2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TYPEOF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeof
'' --------

Dim As String foo
#print TypeOf(foo)
#if TypeOf(foo) = TypeOf(Integer)
  #print "Never happened!"
#endif

#if TypeOf(foo) = TypeOf(String)
  #print "It's a String!"
#endif
		
