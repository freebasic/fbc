'' examples/manual/proguide/typalias/fwd_2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type Aliases'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
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
	
