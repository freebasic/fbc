'' examples/manual/proguide/callback/callback1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Callback'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCallback
'' --------

Type MathFunction As Function( ByVal x As Double ) As Double

Function Linear( ByVal x As Double ) As Double
	Return x
End Function

Function Quadratic( ByVal x As Double ) As Double
	Return x * x
End Function

Function Sinusoidal( ByVal x As Double ) As Double
	Return Sin(x)
End Function

Sub PlotF( ByVal f As MathFunction )
	PSet( -15, f(-15) )
	For x As Double = -15 To 15 Step 0.1
		Line -( x, f(x) )
	Next
End Sub

Screen 19
Window (-15,-10)-(15,10)

PlotF( @Linear )
PlotF( @Sinusoidal )
PlotF( @Quadratic )

Sleep
		
