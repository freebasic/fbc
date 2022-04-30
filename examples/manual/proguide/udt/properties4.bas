'' examples/manual/proguide/udt/properties4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Properties'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProperties
'' --------

Type Window
	Declare Property title(ByRef s As String)
	Declare Property title(ByVal i As Integer)
	Declare Property title() As String
Private:
	As String title_
End Type

Property Window.title(ByRef s As String)
	this.title_ = s
End Property

Property Window.title(ByVal i As Integer)
	this.title_ = "Number: " & i
End Property

Property Window.title() As String
	Return this.title_
End Property

Dim As Window w
w.title = "My Window"
Print w.title
w.title = 5
Print w.title
