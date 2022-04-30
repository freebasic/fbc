'' examples/manual/proguide/udt/polymorphism-graph.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Inheritance Polymorphism'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPolymorphism
'' --------

Type GraphicPoint
	Public:  '' user interface
		Declare Constructor ()
		Declare Constructor (ByVal x0 As Integer = 0, ByVal y0 As Integer = 0)
		Declare Property x () As Integer          '' x-coordinate getter
		Declare Property x (ByVal x0 As Integer)  '' x-coordinate setter (control if inside open graphic window)
		Declare Property y () As Integer          '' y-coordinate getter
		Declare Property y (ByVal y0 As Integer)  '' y-coordinate setter (control if inside open graphic window)
	Private:  '' hidden members
		Dim As Integer _x, _y
		Declare Static Function xValid (ByVal x0 As Integer) As Integer  '' x-coordinate inside open graphic window?
		Declare Static Function yValid (ByVal y0 As Integer) As Integer  '' y-coordinate inside open graphic window?
End Type

Constructor GraphicPoint ()
End Constructor

Constructor GraphicPoint (ByVal x0 As Integer = 0, ByVal y0 As Integer = 0)
	This.x = x0
	This.y = y0
End Constructor

Property GraphicPoint.x () As Integer
	Return This._x
End Property

Property GraphicPoint.x (ByVal x0 As Integer)
	If GraphicPoint.xValid(x0) Then This._x = x0
End Property

Property GraphicPoint.y () As Integer
	Return This._y
End Property

Property GraphicPoint.y (ByVal y0 As Integer)
	If GraphicPoint.yValid(y0) Then This._y = y0
End Property

Static Function GraphicPoint.xValid (ByVal x0 As Integer) As Integer
	If ScreenPtr = 0 Then Return 0  '' no open graphic window
	Dim As Long w
	ScreenInfo(w)
	If x0 >= 0 And x0 <= w - 1 Then Return -1 Else Return 0
End Function

Static Function GraphicPoint.yValid (ByVal y0 As Integer) As Integer
	If ScreenPtr = 0 Then Return 0  '' no open graphic window
	Dim As Long h
	ScreenInfo( , h)
	If y0 >= 0 And y0 <= h - 1 Then Return -1 Else Return 0
End Function


Type GraphicForm2P Extends Object  '' abstract graphic form defined by two points
	Public:  '' user interface
		Dim As GraphicPoint pt1, pt2
		Dim As Integer col
		Declare Abstract Sub drawGraphicForm2P ()  '' request procedure implementation for instantiable derived type
		Declare Virtual Destructor ()              '' for polymorphic compatibility with any derived type
	Protected:  '' hidden members
		Declare Constructor ()
		Declare Constructor (ByRef p1 As GraphicPoint = Type(0, 0), ByRef p2 As GraphicPoint = Type(0, 0), ByVal col0 As Integer = 0)
End Type

Virtual Destructor GraphicForm2P ()
End Destructor

Constructor GraphicForm2P ()  '' implementation not absolutely necessary
End Constructor

Constructor GraphicForm2P (ByRef p1 As GraphicPoint = Type(0, 0), ByRef p2 As GraphicPoint = Type(0, 0), ByVal col0 As Integer = 0)
	This.pt1 = p1
	This.pt2 = p2
	This.col = col0
End Constructor


Type GraphicLine2P Extends GraphicForm2P  '' graphic line from point 1 to point 2
	Public:  '' user interface
		Declare Constructor (ByRef p1 As GraphicPoint = Type(0, 0), ByRef p2 As GraphicPoint = Type(0, 0), ByVal col0 As Integer = 0)
		Declare Sub drawGraphicForm2P () Override  '' overridden procedure
End Type

Constructor GraphicLine2P (ByRef p1 As GraphicPoint = Type(0, 0), ByRef p2 As GraphicPoint = Type(0, 0), ByVal col0 As Integer = 0)
	Base(p1, p2, col0)  '' call the base type constructor
End Constructor

Sub GraphicLine2P.drawGraphicForm2P ()
	If ScreenPtr <> 0 Then  '' open graphic window
		Line (This.pt1.x, This.pt1.y)-(This.pt2.x, This.pt2.y), This.col
	End If
End Sub


Type GraphicBox2P Extends GraphicForm2P  '' graphic box from point 1 to point 2
	Public:  '' user interface
		Declare Constructor (ByRef p1 As GraphicPoint = Type(0, 0), ByRef p2 As GraphicPoint = Type(0, 0), ByVal col0 As Integer = 0)
		Declare Sub drawGraphicForm2P () Override  '' overridden procedure
End Type

Constructor GraphicBox2P (ByRef p1 As GraphicPoint = Type(0, 0), ByRef p2 As GraphicPoint = Type(0, 0), ByVal col0 As Integer = 0)
	Base(p1, p2, col0)  '' call the base type constructor
End Constructor

Sub GraphicBox2P.drawGraphicForm2P ()
	If ScreenPtr <> 0 Then  '' open graphic window
		Line (This.pt1.x, This.pt1.y)-(This.pt2.x, This.pt2.y), This.col, B
	End If
End Sub


Type GraphicCircle2P Extends GraphicForm2P  '' graph circle centered on point1 and passing by point 2
	Public:  '' user interface
		Declare Constructor (ByRef p1 As GraphicPoint = Type(0, 0), ByRef p2 As GraphicPoint = Type(0, 0), ByVal col0 As Integer = 0)
		Declare Sub drawGraphicForm2P () Override  '' overridden procedure
End Type

Constructor GraphicCircle2P (ByRef p1 As GraphicPoint = Type(0, 0), ByRef p2 As GraphicPoint = Type(0, 0), ByVal col0 As Integer = 0)
	Base(p1, p2, col0)  '' call the base type constructor
End Constructor

Sub GraphicCircle2P.drawGraphicForm2P ()
	If ScreenPtr <> 0 Then  '' open graphic window
		Dim As Integer r = Sqr((This.pt2.x - This.pt1.x) * (This.pt2.x - This.pt1.x) + (This.pt2.y - This.pt1.y) * (This.pt2.y - This.pt1.y))
		Circle (This.pt1.x, This.pt1.y), r, This.col
	End If
End Sub


Screen 12  '' open graphic window

Dim As GraphicPoint p1 = GraphicPoint(320, 240)  '' to construct graphic point 1
Dim As GraphicPoint p2 = GraphicPoint(500, 350)  '' to construct graphic point 2
Dim As GraphicPoint p3 = GraphicPoint(280, 170)  '' to construct graphic point 2

'' array of base type pointer referring to instances of different derived types
Dim As GraphicForm2P Ptr pgf (...) = {New GraphicLine2P(p1, p2, 14), New GraphicBox2P(p1, p2, 13), New GraphicCircle2P(p1, p2, 12), _
									  New GraphicLine2P(p1, p3, 11), New GraphicBox2P(p1, p3, 10), New GraphicCircle2P(p1, p3, 09)}

For I As Integer = LBound(pgf) To UBound(pgf)
	pgf(I)->drawGraphicForm2P()  '' accessing dedicated overridden procedure by polymorphism
Next I

For I As Integer = LBound(pgf) To UBound(pgf)
	Delete pgf(I)  '' accessing dedicated overridden destructor (if necessary) by polymorphism
Next I

Sleep
			
