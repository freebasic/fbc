'' examples/manual/proguide/graphics/regulateLite_testCode3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Lite regulation function to be integrated into user loop for FPS control'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgLiteRegulate
'' --------

#include "regulateLite.bi"

#if defined(__FB_WIN32__)
Declare Function _setTimer Lib "winmm" Alias "timeBeginPeriod"(ByVal As ULong = 1) As Long
Declare Function _resetTimer Lib "winmm" Alias "timeEndPeriod"(ByVal As ULong = 1) As Long
#endif

Screen 12, , 2
ScreenSet 1, 0

Dim As ULongInt MyFps = 100
	
Dim As String res = "N"
Dim As Boolean SkipImage = True
Dim As Boolean Restart = False
Dim As Boolean RemoveImageSkipped = False

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
	Static As Boolean ImageSkipped
	Static As Long ist = 0
	Static As Long mist = 0
	Dim As Double t1
	Dim As Double t2
	If (RemoveImageSkipped = False) Or (ImageSkipped = False) Then
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
		Print " Procedure : regulateLite( "; MyFPS & " [, " & SkipImage & " ])";
		If SkipImage = True Then
			Select Case RemoveImageSkipped
			Case True
				Print "      Images skipped : Removing"
			Case False
				Print "      Images skipped : Scrolling"
			End Select
		Else
				Print "     No image skipping"
		End If
		Print
		Color 11
		If mist = 0 Then
			Print Using " Applied true FPS     : ###         (average : ###)"; fps; averageFps
			Print Using "    Applied delay     : ###.### ms  (average : ###.### ms)"; dt; averageDelay;
		Else
			Print Using " Applied apparent FPS : ###         (average : ###)"; fps; averageFps
			Print Using "    Applied delay     : ###.### ms  (average : ###.### ms)"; dt; averageDelay;
		End If
		If SkipImage = True Then
			Print "  (not skipped image)"
		Else
			Print
		End If
		If SkipImage = True Then
			Select Case RemoveImageSkipped
			Case True
				Print "    Images removed    :  " & IIf(mist > 0, Str(mist) & "/" & Str(mist + 1), "0")
			Case False
				Print "    Images scrolled   :  " & IIf(mist > 0, Str(mist) & "/" & Str(mist + 1), "0")
			End Select
		Else
				Print "    No image skipped"
		End If
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
		Print "    <t> or <T> : True for image skipping"
		If SkipImage = True Then
			Print "        <r> or <R> : Remove image skipped"
			Print "        <s> or <S> : Scroll image skipped"
		End If
		Print "    <f> or <F> : False for image skipping"
		Print "    <c> or <C> : Calibration phase"
		Print
		Print " <escape>   : Quit"
		Line (8, 144)-(631, 160), 7, B
		Line (8, 144)-(8 + l, 160), 7, BF
		Do
		#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
			t2 = Timer
			If t2 < t Then t -= 24 * 60 * 60
		Loop Until t2 >= t + 0.002
		#else
		Loop Until Timer >= t + 0.002
		#endif
		ScreenCopy
	End If
	l = (l + 1) Mod 624
	Dim As String s = UCase(Inkey)
	Select Case s
	Case "+"
		If MyFPS < 500 Then MyFPS += 1
	Case "-"
		If MyFPS > 10 Then MyFPS -= 1
	Case "T"
		SkipImage = True
	Case "F"
		SkipImage = False
	#if defined(__FB_WIN32__)
	Case "N"
		If res = "H" Then
			Restart = True
			res = "N"
		End If
	Case "H"
		If res = "N" Then
			Restart = True
			res = "H"
		End If
	#endif
	Case "C"
		Restart = True
	Case "R"
		If SkipImage = True Then RemoveImageSkipped = True
	Case "S"
		If SkipImage = True Then RemoveImageSkipped = False
	Case Chr(27)
		Exit Do
	End Select
	sumFps += fps
	sumDelay += dt
	N += 1
	If N >= fps / 2 Then
		averageFps = sumFps / N
		averageDelay = sumDelay / N
		N = 0
		sumFps = 0
		sumDelay = 0
	End If
	#if defined(__FB_WIN32__)
	If res = "H" Then
		_setTimer()
	End If
	#endif
	t1 = Timer
	fps = regulateLite(MyFPS, SkipImage, Restart, ImageSkipped)
	If ImageSkipped = False Then
		t2 = Timer
		#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
		If t2 < t1 Then t1 -= 24 * 60 * 60
		#endif
		dt = (t2 - t1) * 1000
	End If
	#if defined(__FB_WIN32__)
	If res = "H" Then
		_resetTimer()
	End If
	#endif
	Restart = False
	If ImageSkipped = True Then
		ist += 1
	Else
		mist = ist
		ist = 0
	End If
Loop
