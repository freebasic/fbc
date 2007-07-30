'' examples/manual/gfx/rgba.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRgba
'' --------

ScreenRes 640,480,32

Dim As Any Ptr img
Dim As Integer x,y

'make an image that varies in transparency and color
img = ImageCreate(128,128,0)
For x = 0 To 127
  For y = 0 To 127
	PSet img,(x,y),RGBA(x*2,0,y*2,x+y)
  Next y
Next x
Circle img,(64,64),50,RGBA(0,127,192,192),,,,f
Line img,(50,40)-(78,88),RGBA(255,255,255,0),bf

'draw a background
For x=-480 To 639 Step 20
  Line (x,0)-(x+480,480),RGB(255,255,255)
Next
Line (10,10)-(630,86),RGB(127,0,0),bf
Line (10,290)-(630,438),RGB(0,127,0),bf

'draw the image and some text with PSET
Draw String(96,64),"PUT AN IMAGE WITH PSET"
Put(96,96),img,PSet
Put(96,300),img,PSet

'draw the image and some text with ALPHA
Draw String (416,64),"PUT AN IMAGE WITH ALPHA"

Put(416,96),img,Alpha
Put(416,300),img,Alpha

Sleep

ImageDestroy img
