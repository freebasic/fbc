'' examples/manual/proguide/typeunion/nested_type_union_2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type (UDT/Alias/Temporary) and Union'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeUnion
'' --------

'' example of two dependent types, with a type alias and a forward referencing:
'
'Type list As list_
'
'Type listnode
'    text As String
'    parent As list Ptr
'End Type
'
'Type list_
'    first As listnode Ptr
'    count As Integer
'End Type



'' same example of two dependent types, but with simply one of them a Nested Named Type: 

Type list
	count As Integer
	Type listnode
		text As String
		parent As list Ptr
	End Type
	first As listnode Ptr
End Type
