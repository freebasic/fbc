'' examples/manual/proguide/udt/properties2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Properties'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProperties
'' --------

Type Window
	Declare Property title(ByRef s As String)
Private:
	As String title_
End Type

Property Window.title(ByRef s As String)
	this.title_ = s
End Property

Dim As Window w
w.title = "My Window"
