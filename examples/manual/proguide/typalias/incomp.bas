'' examples/manual/proguide/typalias/incomp.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type Aliases'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Type sometype As sometype_

'' Not allowed since size of sometype is unknown
'' TYPE incomplete
''   a AS sometype
'' END TYPE

'' Allowed since size of a pointer is known
Type complete
  a As sometype Ptr
End Type
Dim x As complete

'' Not allowed since size of sometype is still unknown
'' DIM size_sometype AS INTEGER = SIZEOF( sometype )

'' Complete the type
Type sometype_
  value As Integer
End Type

'' Allowed since the types are now completed
Dim size_sometype As Integer = SizeOf( sometype )

Type completed
  a As sometype
End Type

Dim size_completed As Integer = SizeOf( completed )
	
