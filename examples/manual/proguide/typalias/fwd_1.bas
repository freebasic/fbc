'' examples/manual/proguide/typalias/fwd_1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type Aliases'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Type foo As bar

Type sometype
  f   As foo Ptr
End Type

Type bar
  st  As sometype
  a   As Integer
End Type
	
