'' examples/manual/proguide/typalias/fwd_1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Type foo As bar

Type sometype
  f   As foo Ptr
End Type

Type bar
  st  As sometype
  a   As Integer
End Type
	
