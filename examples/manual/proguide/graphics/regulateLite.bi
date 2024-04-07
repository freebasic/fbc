'' examples/manual/proguide/graphics/regulateLite.bi
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Lite regulation function to be integrated into user loop for FPS control'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgLiteRegulate
'' --------

' regulateLite.bi

Function regulateLite(ByVal MyFps As ULong, ByVal SkipImage As Boolean = True, ByVal Restart As Boolean = False, ByRef ImageSkipped As Boolean = False) As ULong
	'' 'MyFps' : requested FPS value, in frames per second
	'' 'SkipImage' : optional parameter to activate the image skipping (True by default)
	'' 'Restart' : optional parameter to force the resolution acquisition, to reset to False on the next call (False by default)
	'' 'ImageSkipped' : optional parameter to inform the user that the image has been skipped (if image skipping is activated)
	'' function return : applied FPS value (true or apparent), in frames per second
	Static As Single tos
	Static As Single bias
	Static As Long count
	Static As Single sum
	' initialization calibration
	If tos = 0 Or Restart = True Then
		Dim As Double t = Timer
		For I As Integer = 1 To 10
			Sleep 1, 1
		Next I
		Dim As Double tt = Timer
		#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
		If tt < t Then t -= 24 * 60 * 60
		#endif
		tos = (tt - t) / 10 * 1000
		bias = 0
		count = 0
		sum = 0
	End If
	Static As Double t1
	Static As Long N = 1
	Static As ULong fps
	Static As Single tf
	' delay generation
	Dim As Double t2 = Timer
	#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
	If t2 < t1 Then t1 -= 24 * 60 * 60
	#endif
	Dim As Double t3 = t2
	Dim As Single dt = (N * tf - (t2 - t1)) * 1000 - bias
	If (dt >= 3 * tos / 2) Or (SkipImage = False) Or (N >= 20) Or (fps / N <= 10) Then
		If dt <= tos Then dt = tos / 2
		Sleep dt, 1
		t2 = Timer
		#if Not defined(__FB_WIN32__) And Not defined(__FB_LINUX__)
		If t2 < t1 Then t1 -= 24 * 60 * 60 : t3 -= 24 * 60 * 60
		#endif
		fps = N / (t2 - t1)
		tf = 1 / MyFps
		t1 = t2
		' automatic test and regulation
		Dim As Single delta = (t2 - t3) * 1000 - (dt + bias)
		If Abs(delta) > 3 * tos Then
			tos = 0
		Else
			bias += 0.1 * Sgn(delta)
		End If
		' automatic calibation
		If dt < tos Then
			If count = 100 Then
				tos = sum / 100 * 1000
				bias = 0
				sum = 0
				count = 0
			Else
				sum += (t2 - t3)
				count += 1
			End If
		End If
		ImageSkipped = False
		N = 1
	Else
		ImageSkipped = True
		N += 1
	End If
	Return fps
End Function
