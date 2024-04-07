'' examples/manual/gfx/bsave2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BSAVE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBsave
'' --------

'set graphics screen 640 x 480 pixels, 32 bit colors
Const W = 640, H = 480 'width & hight
ScreenRes W, H, 32
'draw a smiley at screen center
Circle (W \ 2, H \ 2), 180, &h00ffff00, , , , f 'yellow circle
Circle (W \ 2 - 55, H \ 2 - 70), 35, &h00000000, , , 1.5, f 'left eye
Circle (W \ 2 + 55, H \ 2 - 60), 35, &h00000000, , , 1.5, f 'right eye
Circle (W \ 2, H \ 2 + 80), 70, &h00000000, , , 0.4, f 'mouth
'allocate memory for image buffer
Dim As Any Ptr pImageBuffer = ImageCreate(250, 250)
'copy screen section to buffer
Get (W \ 2 - 125, H \ 2 - 125)-Step(250 - 1, 250 - 1), pImageBuffer
'save image buffer to file
Dim As String fileName = "Smiley.bmp"
If BSave(fileName, pImageBuffer) = 0 Then
	Print "Saved succesful: " + fileName
Else
	Print "Error saving: " + fileName
End If
'free memory for image buffer
ImageDestroy(pImageBuffer)
'keep graphics screen open until key press
Sleep
