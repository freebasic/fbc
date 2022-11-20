'' examples/manual/proguide/typeunion/nested_declaration.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type (UDT/Alias/Temporary) and Union'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeUnion
'' --------

Type MemoryTable
	Private:
		'' private members visible within MemoryTable only
		Const default_alignment = 16
		m_bytes_per_node As UInteger = 0
		m_nodes_per_chunk As UInteger = 0
		Type Chunk
			m_owner As MemoryTable Ptr
			m_nodes As UInteger
			m_prevChunk As Chunk Ptr
			m_data As Any Ptr
		End Type
		Declare Sub allocChunk()
		m_headChunk As Chunk Ptr = 0
	Protected:
		'' protected members visible within MemoryTable and derived types
		Declare Constructor()
		Type Iterator
			Private:
				m_chunk As Chunk Ptr
				m_index As Integer
			Protected:
				Declare Constructor()
				Declare Constructor(ByVal table As MemoryTable Ptr)
				Declare Property item() As Any Ptr
			Public:
				Declare Property hasItem() As Boolean
				Declare Sub nextItem()
		End Type
		Declare Function newNode() As Any Ptr
	Public:
		'' public member visible from outside the type
		Declare Constructor(ByVal bytes As UInteger, nodes As UInteger)
		Declare Destructor()
End Type
