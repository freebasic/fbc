'' examples/manual/proguide/graphics/delay_regulate_framerate.bi
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Fine-grain procedure for waiting and in-loop procedure for fine-regulating FPS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgDelayRegulate
'' --------

'  delay_regulate_framerate.bi

#if defined(__FB_WIN32__)
Declare Sub delay(ByVal amount As Single, ByVal threshold As ULong = 2 * 16)
Declare Function regulate(ByVal MyFps As ULong, ByVal threshold As ULong = 2 * 16) As Single
Declare Function _setTimer Lib "winmm" Alias "timeBeginPeriod"(ByVal As ULong = 1) As Long
Declare Function _resetTimer Lib "winmm" Alias "timeEndPeriod"(ByVal As ULong = 1) As Long
Declare Sub delayHR(ByVal amount As Single, ByVal threshold As ULong = 2 * 1)
Declare Function regulateHR(ByVal MyFps As ULong, ByVal threshold As ULong = 2 * 1) As Single
Sub delayHR(ByVal amount As Single, ByVal threshold As ULong)
	'' 'amount'  : requested temporisation to apply, in milliseconds
	'' 'thresold' : fixing threshold for fine-grain temporisation (by waiting loop), in milliseconds
	Dim As Double t1 = Timer
	Dim As Double t2
	Dim As Double t3 = t1 + amount / 1000
	If amount > threshold + 0.5 Then
		_setTimer()
		Sleep amount - threshold, 1
		_resetTimer()
	End If
	Do
	#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
		t2 = Timer
		If t2 < t1 Then t1 -= 24 * 60 * 60 : t3 -= 24 * 60 * 60
	Loop Until t2 >= t3
	#else
	Loop Until Timer >= t3
	#endif
End Sub
Function regulateHR(ByVal MyFps As ULong, ByVal threshold As ULong) As Single
	'' 'MyFps' : requested FPS value, in frames per second
	'' function return : applied delay (for debug), in milliseconds
	'' 'thresold' : fixing threshold for fine-grain temporisation (by waiting loop), in milliseconds
	Static As Double t1
	Dim As Single tf = 1 / MyFps
	Dim As Double t2 = Timer
	#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
	If t2 < t1 Then t1 -= 24 * 60 * 60
	#endif
	Dim As Single dt = (tf - (t2 - t1)) * 1000
	delayHR(dt, threshold)
	t1 = Timer
	Return dt
End Function
#elseif defined(__FB_LINUX__)
Declare Sub delay(ByVal amount As Single, ByVal threshold As ULong = 2 * 10)
Declare Function regulate(ByVal MyFps As ULong, ByVal threshold As ULong = 2 * 10) As Single
#elseif defined(__FB_DOS__)
Declare Sub delay(ByVal amount As Single, ByVal threshold As ULong = 2 * 55)
Declare Function regulate(ByVal MyFps As ULong, ByVal threshold As ULong = 2 * 55) As Single
#else
Declare Sub delay(ByVal amount As Single, ByVal threshold As ULong = 2 * 16)
Declare Function regulate(ByVal MyFps As ULong, ByVal ULong As Single = 2 * 16) As Single
#endif

Declare Function framerate() As ULong

'------------------------------------------------------------------------------

Sub delay(ByVal amount As Single, ByVal threshold As ULong)
	'' 'amount'  : requested temporisation to apply, in milliseconds
	'' 'thresold' : fixing threshold for fine-grain temporisation (by waiting loop), in milliseconds
	Dim As Double t1 = Timer
	Dim As Double t2
	Dim As Double t3 = t1 + amount / 1000
	If amount > threshold + 0.5 Then Sleep amount - threshold, 1
	Do
	#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
		t2 = Timer
		If t2 < t1 Then t1 -= 24 * 60 * 60 : t3 -= 24 * 60 * 60
	Loop Until t2 >= t3
	#else
	Loop Until Timer >= t3
	#endif
End Sub

Function regulate(ByVal MyFps As ULong, ByVal threshold As ULong) As Single
	'' 'MyFps' : requested FPS value, in frames per second
	'' function return : applied delay (for debug), in milliseconds
	'' 'thresold' : fixing threshold for fine-grain temporisation (by waiting loop), in milliseconds
	Static As Double t1
	Dim As Single tf = 1 / MyFps
	Dim As Double t2 = Timer
	#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
	If t2 < t1 Then t1 -= 24 * 60 * 60
	#endif
	Dim As Single dt = (tf - (t2 - t1)) * 1000
	delay(dt, threshold)
	t1 = Timer
	Return dt
End Function

Function framerate() As ULong
	'' function return : measured FPS value (for debug), in frames per second
	Static As Double t1
	Dim As Double t2 = Timer
	#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
	If t2 < t1 Then t1 -= 24 * 60 * 60
	#endif
	Dim As ULong tf = 1 / (t2 - t1)
	t1 = t2
	Return tf
End Function
