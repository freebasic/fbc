'' examples/manual/proguide/typalias/fwd_2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Type list As list_

Type listnode
  parent As list Ptr
  text As String
End Type

Type list_
  first As listnode Ptr
  count As Integer
End Type
	
