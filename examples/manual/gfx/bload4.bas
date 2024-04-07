'' examples/manual/gfx/bload4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BLOAD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBload
'' --------

'' A function that creates an image buffer with the same 
'' dimensions as a BMP image, and loads a file into it.

Const NULL As Any Ptr = 0

Function bmp_load( ByRef filename As Const String ) As Any Ptr

	Dim As Long filenum, bmpwidth, bmpheight
	Dim As Any Ptr img

	'' open BMP file
	filenum = FreeFile()
	If Open( filename For Binary Access Read As #filenum ) <> 0 Then Return NULL

		'' retrieve BMP dimensions
		Get #filenum, 19, bmpwidth
		Get #filenum, 23, bmpheight

	Close #filenum

	'' create image with BMP dimensions
	img = ImageCreate( bmpwidth, Abs(bmpheight) )

	If img = NULL Then Return NULL

	'' load BMP file into image buffer
	If BLoad( filename, img ) <> 0 Then ImageDestroy( img ): Return NULL

	Return img

End Function



Dim As Any Ptr img

ScreenRes 640, 480, 32

img = bmp_load( "picture.bmp" )

If img = NULL Then
	Print "bmp_load failed"

Else

	Put (10, 10), img

	ImageDestroy( img )

End If

Sleep
