'' examples/manual/proguide/udt/properties5-counter-example.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Properties'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProperties
'' --------

Type Window
	Declare Sub set_title(ByRef s As String)
	Declare Sub set_title(ByVal i As Integer)
	Declare Function get_title() As String
Private:
	As String title
End Type

Sub Window.set_title(ByRef s As String)
	this.title = s
End Sub

Sub Window.set_title(ByVal i As Integer)
	this.title = "Number: " & i
End Sub

Function Window.get_title() As String
	Return this.title
End Function

Dim As Window w
w.set_title("My Window")
Print w.get_title()
w.set_title(5)
Print w.get_title()
