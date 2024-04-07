'' examples/manual/proguide/udt/properties-tui.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Properties'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProperties
'' --------

Namespace tui
	Type Point
		Dim As Integer x, y
	End Type

	Type char
		Dim As UByte value
		Dim As UByte Color
	End Type

	Type Window
		'' public
		Declare Constructor _
			( _
				x As Integer = 1, y As Integer = 1, _
				w As Integer = 20, h As Integer = 5, _
				title As ZString Ptr = 0 _
			)
		
		Declare Destructor

		Declare Sub show

		'' title property
		Declare Property title As String
		Declare Property title( new_title As String )

		'' position properties
		Declare Property x As Integer
		Declare Property x( new_x As Integer )

		Declare Property y As Integer
		Declare Property y( new_y As Integer )

	Private:
		Declare Sub redraw
		Declare Sub remove
		Declare Sub drawtitle

		Dim As String p_title
		Dim As Point Pos
		Dim As Point siz
	End Type

	Constructor Window _
		( _
			x_ As Integer, y_ As Integer, _
			w_ As Integer, h_ As Integer, _
			title_ As ZString Ptr _
		)

		pos.x = x_
		pos.y = y_
		siz.x = w_
		siz.y = h_

		If( title_ = 0 ) Then
			title_ = @"untitled"
		End If

		p_title = *title_
	End Constructor

	Destructor Window
		Color 7, 0
		Cls
	End Destructor

	Property window.title As String
		title = p_title
	End Property

	Property window.title( new_title As String )
		p_title = new_title
		drawtitle
	End Property

	Property window.x As Integer
		Return pos.x
	End Property

	Property window.x( new_x As Integer )
		remove
		pos.x = new_x
		redraw
	End Property

	Property window.y As Integer
		Property = pos.y
	End Property

	Property window.y( new_y As Integer )
		remove
		pos.y = new_y
		redraw
	End Property

	Sub window.show
		redraw
	End Sub

	Sub window.drawtitle
		Locate pos.y, pos.x
		Color 15, 1
		Print Space( siz.x );
		Locate pos.y, pos.x + (siz.x \ 2) - (Len( p_title ) \ 2)
		Print p_title;
	End Sub

	Sub window.remove
		Color 0, 0
		Var sp = Space( siz.x )
		For i As Integer = pos.y To pos.y + siz.y - 1
			Locate i, pos.x
			Print sp;
		Next
	End Sub

	Sub window.redraw
		drawtitle
		Color 8, 7
		Var sp = Space( siz.x )
		For i As Integer = pos.y + 1 To pos.y + siz.y - 1
			Locate i, pos.x
			Print sp;
		Next
	End Sub
End Namespace

Dim win As tui.window = tui.window( 3, 5, 50, 15 )

win.show
Sleep 500

win.title = "Window 1"
Sleep 250
win.x = win.x + 10
Sleep 250

win.title = "Window 2"
Sleep 250
win.y = win.y - 2
Sleep 250

Locate 25, 1
Color 7, 0
Print "Press any key...";

Sleep
