'' examples/manual/proguide/udt/properties2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgProperties
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
