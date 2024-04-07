'' examples/manual/proguide/callback/callback2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Callback'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCallback
'' --------

#include "fbthread.bi"

Type MathFunction As Function( ByVal x As Double ) As Double

Sub ThreadPlot( ByVal p As Any Ptr )
	Sleep 1500, 1  '' sleep added only to check the asynchronous way of the callback
	Dim f As MathFunction = p
	Window (-15,-10)-(15,10)
	PSet( -15, f(-15) )
	For x As Double = -15 To 15 Step 0.1
		Line -( x, f(x) )
	Next
End Sub

Function PlotF( ByVal f As MathFunction ) As String
	Print "Plotting requested"
	ThreadDetach( ThreadCreate( @ThreadPlot, f ) )
	Return "Plotting request taken into account"
End Function

Function Linear( ByVal x As Double ) As Double
	Return x
End Function

Function Quadratic( ByVal x As Double ) As Double
	Return x * x
End Function

Function Sinusoidal( ByVal x As Double ) As Double
	Return Sin(x)
End Function

Screen 19

Print PlotF( @Linear )
Print PlotF( @Sinusoidal )
Print PlotF( @Quadratic )

'' following code added only to check the asynchronous way of callbacks
Print "Main program continues ";
For I As Integer = 1 To 15
	Print ".";
	Sleep 200, 1
Next I
Print
Print "Main program finished"

Sleep
		
