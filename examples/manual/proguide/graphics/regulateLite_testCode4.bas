'' examples/manual/proguide/graphics/regulateLite_testCode4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Lite regulation function to be integrated into user loop for FPS control'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgLiteRegulate
'' --------

Dim As Integer tt = 10  ' (in milliseconds)
Dim As Integer tc =  5  ' (in milliseconds)

#include "regulateLite.bi"

Screen 12, , 2
ScreenSet 1, 0

Dim As ULongInt MyFps = 9999
	
Dim As String res = "N"
Dim As Boolean SkipImage = False
Dim As Boolean RemoveImageSkipped = False

Do
	Static As ULong fps
	Static As ULong averageFps
	Static As Double sumFps
	Static As Long N
	Static As Boolean ImageSkipped
	Static As Long ist = 0
	Static As Long mist = 0
	Static As ULongInt l
	Dim As Double t1
	Dim As Double t2
	If (RemoveImageSkipped = False) Or (ImageSkipped = False) Then
		t1 = Timer
		Cls
		Print
		Color 15
		Print "          MAXIMUM PERFORMANCE EMULATION of 'regulateLite()' regulation"
		Print
		Print
		Print Using " tt = ## ms   (execution time of the tracing task)"; tt
		Print Using " tc = ## ms   (execution time of the calculation task + other process)"; tc
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
		Print
		Color 11
		If mist = 0 Then
			Print Using " Applied true FPS max     :####         (average :####)"; fps; averageFps
		Else
			Print Using " Applied apparent FPS max :####         (average :####)"; fps; averageFps
		End If
		If SkipImage = True Then
			Select Case RemoveImageSkipped
			Case True
				Print "    Images removed        :  " & IIf(mist > 0, Str(mist) & "/" & Str(mist + 1), "0")
			Case False
				Print "    Images scrolled       :  " & IIf(mist > 0, Str(mist) & "/" & Str(mist + 1), "0")
			End Select
		Else
				Print "    No image skipped"
		End If
		Print
		Print
		Color 14
		Print " <+>        : Increment tt"
		Print " <->        : Decrement tt"
		Print
		Print " <i> or <I> : Increment tc"
		Print " <d> or <D> : Decrement tc"
		Print
		Print " Optional parameter :"
		Print "    <t> or <T> : True for image skipping"
		If SkipImage = True Then
			Print "        <r> or <R> : Remove image skipped"
			Print "        <s> or <S> : Scroll image skipped"
		End If
		Print "    <f> or <F> : False for image skipping"
		Print
		Print " <escape>   : Quit"
		Line (0, 197)-(639, 199), 3, B
		Line (0, 198)-(l, 198), 11
		Do
		#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
			t2 = Timer
			If t2 < t Then t -= 24 * 60 * 60
		Loop Until t2 >= t1 + tt / 1000
		#else
		Loop Until Timer >= t1 + tt / 1000
		#endif
		ScreenCopy
	End If
	t1 = Timer
	Dim As String s = UCase(Inkey)
	Select Case s
	Case "+"
		If tt < 30 Then tt += 1
	Case "-"
		If tt > 1 Then tt -= 1
	Case "I"
		If tc < 30 Then tc += 1
	Case "D"
		If tc > 1 Then tc -= 1
	Case "T"
		SkipImage = True
	Case "F"
		SkipImage = False
	Case "R"
		If SkipImage = True Then RemoveImageSkipped = True
	Case "S"
		If SkipImage = True Then RemoveImageSkipped = False
	Case Chr(27)
		Exit Do
	End Select
	sumFps += fps
	N += 1
	If N >= fps / 2 Then
		averageFps = sumFps / N
		N = 0
		sumFps = 0
	End If
	If ImageSkipped = True Then
		ist += 1
	Else
		mist = ist
		ist = 0
	End If
	l = (l + 1) Mod 640
	Do
	#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
		t2 = Timer
		If t2 < t Then t -= 24 * 60 * 60
	Loop Until t2 >= t1 + tc / 1000
	#else
	Loop Until Timer >= t1 + tc / 1000
	#endif
	fps = regulateLite(MyFPS, SkipImage, , ImageSkipped)
Loop
