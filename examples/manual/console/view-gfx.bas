'' examples/manual/console/view-gfx.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'VIEW PRINT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgViewtext
'' --------

Screen 12
Dim As Integer R,Y,x,y1
Dim As Single y2
View Print 20 To 27
Line (0,0)-(639,300),1,BF
Line (100,50)-(540,200),0,BF
Do
 r = (r + 1) And 15
 For y = 1 To 99
   y1 = ((1190 \ y + r) And 15)
   y2 = 6 / y
   For x = 100 To 540
	PSet (x, y + 100), CInt((319 - x) * y2) And 15 Xor y1 
  Next x,y
 If r=0 Then Color Int(Rnd*16): Print "blah"
Loop Until Len(Inkey)
