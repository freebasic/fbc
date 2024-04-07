'' examples/manual/gfx/rgba.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RGBA'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRgba
'' --------

'open a graphics screen (320 * 240, 32-bit)
ScreenRes 320, 240, 32

Dim As Any Ptr img
Dim As Integer x, y

'make an image that varies in transparency and color
img = ImageCreate(64, 64)
For x = 0 To 63
  For y = 0 To 63
	PSet img, (x, y), RGBA(x * 4, 0, y * 4, (x + y) * 2)
  Next y
Next x
Circle img, (31, 31), 25,      RGBA(0, 127, 192, 192), ,,, F 'semi-transparent blue circle
Line   img, (26, 20)-(38, 44), RGBA(255, 255, 255, 0),    BF 'transparent white rectangle

'draw a background (diagonal white lines)
For x = -240 To 319 Step 10
  Line (x, 0)-Step(240, 240), RGB(255, 255, 255)
Next

Line (10,  10)-(310,  37), RGB(127, 0, 0), BF 'red box for text
Line (10, 146)-(310, 229), RGB(0, 127, 0), BF 'green box for Putting onto

'draw the image and some text with PSET
Draw String(64, 20), "PSet"
Put(48,  48), img, PSet
Put(48, 156), img, PSet

'draw the image and some text with ALPHA
Draw String (220, 20), "Alpha"
Put(208,  48), img, Alpha
Put(208, 156), img, Alpha



'Free the image memory
ImageDestroy img

'Keep the window open until the user presses a key
Sleep
	
