'' examples/manual/proguide/graphics/use_regulate_framerate_2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Fine-grain procedure for waiting and in-loop procedure for fine-regulating FPS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgDelayRegulate
'' --------

#include "delay_regulate_framerate.bi"

Screen 12, , 2
ScreenSet 1, 0

Dim As ULongInt MyFps = 100
	
Dim As String res = "N"
Dim As ULong thresholdNR = 32
Dim As ULong thresholdHR = 2

Do
	Static As ULongInt l
	Static As Double dt
	Static As ULong fps
	Static As Double t
	Static As ULong averageFps
	Static As Double sumFps
	Static As Double averageDelay
	Static As Double sumDelay
	Static As Long N
	Static As ULong fpsE
	Dim As Double t1
	Dim As Double t2
	t = Timer
	Cls
	Print
	Color 15
	Select Case res
	Case "N"
		Print "                      NORMAL RESOLUTION"
	Case "H"
		Print "                      HIGH RESOLUTION (for Windows only)"
	End Select
	Print
	Select Case res
	Case "N"
		Print " Procedure : regulate( " & MyFPS & " [, " & thresholdNR & " ])"
	Case "H"
		Print " Procedure : regulateHR( " & MyFPS & " [, " & thresholdHR & " ])"
	End Select
	Print
	Color 11
	Print Using " Measured FPS  : ###          (average : ###)"; fpsE; averageFps
	Print Using " Applied delay : ###.### ms   (average : ###.### ms)"; dt; averageDelay
	Print
	Print
	Print
	Color 14
	#if defined(__FB_WIN32__)
	Print " <n> or <N> : Normal resolution"
	Print " <h> or <H> : High resolutiion"
	Print
	#endif
	Print " <+>        : Increase FPS"
	Print " <->        : Decrease FPS"
	Print
	Print " Optional parameter :"
	Select Case res
	Case "N"
		Print "    <i> or <I> : Increase NR threshold"
		Print "    <d> or <D> : Decrease NR threasold"
		Draw String (320, 280), "(optimal value : 32)"
	Case "H"
		Print "    <i> or <I> : Increase HR threshold"
		Print "    <d> or <D> : Decrease HR threasold"
		Draw String (320, 280), "(optimal value : 2)"
	End Select
	Print
	Print " <escape>   : Quit"
	Line (8, 128)-(631, 144), 7, B
	Line (8, 128)-(8 + l, 144), 7, BF
	Do
	#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
		t2 = Timer
		If t2 < t Then t -= 24 * 60 * 60
	Loop Until t2 >= t + 0.002
	#else
	Loop Until Timer >= t + 0.002
	#endif
	ScreenCopy
	l = (l + 1) Mod 624
	Dim As String s = UCase(Inkey)
	Select Case s
	Case "+"
		If MyFPS < 500 Then MyFPS += 1
	Case "-"
		If MyFPS > 10 Then MyFPS -= 1
	#if defined(__FB_WIN32__)
	Case "N"
		If res = "H" Then
			res = "N"
		End If
	Case "H"
		If res = "N" Then
			res = "H"
		End If
	#endif
	Case "I"
		Select Case res
		Case "N"
			If thresholdNR < 64 Then thresholdNR += 16
		Case "H"
			If thresholdHR < 4 Then thresholdHR += 1
		End Select
	Case "D"
		Select Case res
		Case "N"
			If thresholdNR > 0 Then thresholdNR -= 16
		Case "H"
			If thresholdHR > 0 Then thresholdHR -= 1
		End Select
	Case Chr(27)
		Exit Do
	End Select
	sumFps += fpsE
	sumDelay += dt
	N += 1
	If N >= MyFps / 2 Then
		averageFps = sumFps / N
		averageDelay = sumDelay / N
		N = 0
		sumFps = 0
		sumDelay = 0
	End If
	Select Case res
	Case "N"
		dt = regulate(MyFps, thresholdNR) 
	#if defined(__FB_WIN32__)
	Case "H"
		dt = regulateHR(MyFps, thresholdHR)
	#endif
	End Select
	fpsE = framerate()
Loop
