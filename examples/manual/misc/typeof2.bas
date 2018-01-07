'' examples/manual/misc/typeof2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
