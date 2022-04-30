'' examples/manual/proguide/udt/properties-indexed.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Properties'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProperties
'' --------

Type IntArray
	'' setters
	Declare Property value(index As Integer, v As Integer)
	Declare Property value(index As String, v As Integer)
	Declare Property value(index As Integer, v As String)
	Declare Property value(index As String, v As String)

	'' getters
	Declare Property value(index As Integer) As Integer
	Declare Property value(index As String) As Integer

Private:
	Dim As Integer data_(0 To 9)
End Type

Property IntArray.value(index As Integer) As Integer
	Return This.data_(index)
End Property

Property IntArray.value(index As String) As Integer
	Return This.data_(CInt(index))
End Property

Property IntArray.value(index As Integer, v As Integer)
	This.data_(index) = v
End Property

Property IntArray.value(index As String, v As Integer)
	This.data_(CInt(index)) = v
End Property

Property IntArray.value(index As Integer, v As String)
	This.data_(index) = CInt(v)
End Property

Property IntArray.value(index As String, v As String)
	This.data_(CInt(index)) = CInt(v)
End Property

Dim a As IntArray

a.value(0) = 1234
a.value("1") = 5678
a.value(2) = "-1234"
a.value("3") = "-5678"

Print a.value(0)
Print a.value("1")
Print a.value(2)
Print a.value("3")

Sleep
