'' examples/manual/proguide/multithreading/criticalsectionfaq5bis.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Type UDT
	Dim As Integer number
	Dim As Integer tempo
	Dim As Any Ptr pThread
	Dim As ULongInt count
	Dim As Any Ptr img
	Static As Integer numberMax
	Static As Integer quit
End Type
Dim As Integer UDT.numberMax
Dim As Integer UDT.quit

Const As String prompt = "Enter ""quit"" for exit"
Dim As String s

Sub Counter (ByVal pt As UDT Ptr)  ' for a graphic character size 8x16
	With *pt
		Line .img, (0, 0)-(20 * 8 - 1, 16 - 1), 0, BF            ' clearing the image buffer
		Sleep 5, 1
		.count += 1
		Draw String .img, (0, 0), Str(.count)                    ' drawing in the image buffer
		Put ((.number - 1) * 8, (.number - 1) * 16), .img, PSet  ' copying the image buffer to screen
	End With
End Sub

Sub Thread (ByVal p As Any Ptr)    ' for a graphic character size 8x16
	Dim As UDT Ptr pUDT = p
	With *pUDT
		.img = ImageCreate(20 * 8, 16)  ' using an image buffer to avoid flickering
		Do
			Counter(pUDT)
			Sleep .tempo, 1
		Loop Until .quit = 1
		ImageDestroy .img  ' destroying the image buffer
	End With
End Sub


Screen 12
UDT.numberMax = 6

Dim As UDT u(0 To UDT.numberMax)
For I As Integer = 0 To UDT.numberMax
	u(I).number = i
	u(I).tempo = 100 + 15 * I - 95 * Sgn(I)
Next I

Dim As Single t = Timer
For I As Integer = 1 To UDT.numberMax
	u(I).pThread = ThreadCreate(@Thread, @u(I))
Next I

Do
	Locate 8, 1, 0
	Line Input; prompt; s
	Locate , Len(prompt) + 3
	Print Space(Len(s));
Loop Until LCase(s) = "quit"
UDT.quit = 1

For I As Integer = 1 To UDT.numberMax
	ThreadWait(u(I).pThread)
Next I
t = Timer - t

Dim As ULongInt c
For I As Integer = 1 To UDT.numberMax
	c += u(I).count
Next I
Locate UDT.numberMax + 4, 1
Print CULngInt(c / t) & " increments per second"

Sleep
				
