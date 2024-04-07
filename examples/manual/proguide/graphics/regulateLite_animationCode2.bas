'' examples/manual/proguide/graphics/regulateLite_animationCode2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Lite regulation function to be integrated into user loop for FPS control'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgLiteRegulate
'' --------

'' Graphic animation from dodicat (https://www.freebasic.net/forum/viewtopic.php?p=195122#p195122)

#include "regulateLite.bi"

Sub Thing(ByVal w As Integer=700, _
	ByVal h As Integer=600, _
	ByVal posx As Integer=400, _
	ByVal posy As Integer=300, _
	ByVal morph As Single=24, _
	ByVal aspect As Single=3, _
	ByVal grade As Single=6, _
	ByVal col As UInteger=RGBA(255,255,255,0))
		  
	Dim As Single XStep = 1
	Dim As Single YStep = 1
	Dim As Single b=w*w
	Dim As Single y,m,n
	For x As Single = 0 To w Step XStep
		Dim As Single s=x*x
		Dim As Single p=Sqr(b-s)
		For i As Single = -P To P Step grade*YStep
			Dim As Single r = Sqr(s+i*i)/w
			Dim As Single Q = (R - 1) * Sin(morph*r)
			y=i/aspect+q*h
			If i = -p Then m=y:n=y
			If y > m Then m = y
			If y < n Then n = y
			If m=y OrElse n=y Then
				PSet(x/2+posx,-Y/2+posy),col/i 
				PSet(-x/2+posx,-Y/2+posy),col/i
			End If
		Next
	Next
End Sub

'===========================================================

ScreenRes 800, 640, 32, 2
Width 800 \ 8, 640 \ 16
Color,RGB(0,0,50)
ScreenSet 1,0

Dim As Single Morph=0,k=1
Dim As Single aspect,counter,pi2=8*Atn(1)
Dim As Long fps=80,rfps
Dim As Boolean skipping=False,remove=False,skipped
Dim As Long ist,mist
Dim As ULong averageFps
Dim As Double sumFps
Dim As Long N

Do
	counter+=.1
	If counter>=pi2 Then counter=0
	aspect=3+Sin(counter)
	Morph+=.1*k
	If Morph>35 Then k=-k
	If Morph<-35 Then k=-k
	If (remove = False) Or (skipped = False) Then
		Cls
		Thing(800,500,400,300,Morph,aspect) 
		Draw String (16,16),"Requested FPS = " & Right("  " & fps, 3)
		Draw String (16,32),"Applied FPS   = " & Right("  " & rfps, 3) & "   (average = " & Right("  " & averageFps, 3) & ")"
		Draw String (16,48),"Status : " & _
			IIf(skipping = True, "Image skipping activation = true, with " & _
			IIf(remove = True, "removing images skipped = " & IIf(mist > 0, Str(mist) & "/" & Str(mist + 1), "0"), _
			"scrolling images skipped = " & IIf(mist > 0, Str(mist) & "/" & Str(mist + 1), "0")), _
			"Image skipping activation = false")
		Draw String (16,80),"<+> : Increase FPS"
		Draw String (16,96),"<-> : Decrease FPS"
		Draw String (16,128),"<t> or <T> : True for image skipping activation"
		If Skipping = True Then
			Draw String (16,144),"   <s> or <S> : Scroll image skipped"
			Draw String (16,160),"   <r> or <R> : Remove image skipped"
			Draw String (16,176),"<f> or <F> : False for image skipping activation"
			Draw String (16,208),"<escape> : Quit"
		Else
			Draw String (16,144),"<f> or <F> : False for image skipping activation"
			Draw String (16,176),"<escape> : Quit"
		End If
		Draw String (544,608),"Graphic animation from dodicat"
		Flip
	End If
	rfps = regulateLite(fps,skipping, ,skipped)
	If skipped = True Then
		ist += 1
	Else
		mist = ist
		ist = 0
	End If
	sumFps += rfps
	N += 1
	If N >= rfps / 2 Then
		averageFps = sumFps / N
		N = 0
		sumFps = 0
	End If
	Dim As String s = UCase(Inkey)
	Select Case s
	Case "+"
		If fps < 600 Then fps += 1
	Case "-"
		If fps > 10 Then fps -= 1
	Case "T"
		skipping = True
	Case "F"
		skipping = False
	Case "S"
		If skipping = True Then remove = False
	Case "R"
		If skipping = True Then remove = True
	Case Chr(27)
		Exit Do
	End Select
Loop
