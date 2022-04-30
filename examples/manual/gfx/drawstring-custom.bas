'' examples/manual/gfx/drawstring-custom.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DRAW STRING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDrawString
'' --------

'' Define character range
Const FIRSTCHAR = 32, LASTCHAR = 127

Const NUMCHARS = (LASTCHAR - FIRSTCHAR) + 1
Dim As UByte Ptr p, myFont
Dim As Integer i

'' Open a 256 color graphics screen (320*200)
ScreenRes 320, 200, 8

'' Create custom font into PUT buffer

myFont = ImageCreate(NUMCHARS * 8, 9)

 '' Put font header at start of pixel data

#ifndef ImageInfo '' older versions of FB don't have the ImageInfo feature
p = myFont + IIf(myFont[0] = 7, 32, 4)
#else
ImageInfo( myFont, , , , , p )
#endif

p[0] = 0
p[1] = FIRSTCHAR
p[2] = LASTCHAR

 '' PUT each character into the font and update width information
For i = FIRSTCHAR To LASTCHAR
	
	'' Here we could define a custom width for each letter, but for simplicity we use
	'' a fixed width of 8 since we are reusing the default font glyphs
	p[3 + i - FIRSTCHAR] = 8
	
	'' Create character onto custom font buffer by drawing using default font
	Draw String myFont, ((i - FIRSTCHAR) * 8, 1), Chr(i), 32 + (i Mod 24) + 24
	
Next i

'' Now the font buffer is ready; we could save it using BSAVE for later use
Rem BSave "myfont.bmp", myFont

'' Here we draw a string using the custom font
Draw String (10, 10), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", , myFont
Draw String (10, 26), "abcdefghijklmnopqrstuvwxyz", , myFont
Draw String (66, 58), "Hello world!", , myFont

'' Free the font from memory, now we are done with it
ImageDestroy myFont

Sleep
