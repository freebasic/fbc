'' examples/manual/proguide/udt/properties3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Properties'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProperties
'' --------

Type Window
	'' setter
	Declare Property title(ByRef s As String)
	'' getter
	Declare Property title() As String
Private:
	As String title_
End Type

'' setter
Property Window.title(ByRef s As String)
	this.title_ = s
End Property

'' getter
Property Window.title() As String
	Return this.title_
End Property

Dim As Window w
w.title = "My Window"
Print w.title
