'' examples/manual/faq/gfxlib2/image-header.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GET/PUT image header example'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=FaqPggetputstructure
'' --------

'' fbgfx.bi contains the necessary structures and constants for working
'' directly with image headers
#include "fbgfx.bi"

'' in lang fb, structures and constants are contained in the FB namespace
#if __FB_LANG__ = "fb"
Using FB
#endif


'' function to show info on an image
Sub show_image_info( ByVal img As Any Ptr )
	Dim As PUT_HEADER Ptr header ' IMAGE can also be use instead of PUT_HEADER
	Dim As Integer w, h, bpp, pitch

	header = img
	If( header->Type = PUT_HEADER_NEW ) Then

		Print "New style header"

		w = header->Width
		h = header->height
		bpp = header->bpp
		pitch = header->pitch

	Else

		Print "Old style header"

		w = header->old.width
		h = header->old.height
		bpp = header->old.bpp
		pitch = w * bpp

	End If

	Print "Image dimensions are " & w & "*" & h
	Print "Image uses " & bpp & " bytes for each pixel"
	Print "A row of image pixels takes " & pitch & " bytes"

End Sub


Dim As Any Ptr picture

ScreenRes 320, 200, 32

picture = ImageCreate( 10, 10, RGB(128, 192, 255) )

Put( 40, 40 ), picture, PSet

show_image_info( picture )

ImageDestroy picture

Sleep
