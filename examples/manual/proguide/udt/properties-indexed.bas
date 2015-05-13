'' examples/manual/proguide/udt/properties-indexed.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgProperties
'' --------

Type IntArray
	'' setters
	Declare Property value(index As Integer, value As Integer)
	Declare Property value(index As String, value As Integer)
	Declare Property value(index As Integer, value As String)
	Declare Property value(index As String, value As String)

	'' getters
	Declare Property value(index As Integer) As Integer
	Declare Property value(index As String) As Integer

Private:
	Dim As Integer data_(0 To 9)
End Type

Property IntArray.value(index As Integer) As Integer
	Return this.data_(index)
End Property

Property IntArray.value(index As String) As Integer
	Return this.data_(CInt(index))
End Property

Property IntArray.value(index As Integer, value As Integer)
	this.data_(index) = value
End Property

Property IntArray.value(index As String, value As Integer)
	this.data_(CInt(index)) = value
End Property

Property IntArray.value(index As Integer, value As String)
	this.data_(index) = CInt(value)
End Property

Property IntArray.value(index As String, value As String)
	this.data_(CInt(index)) = CInt(value)
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
