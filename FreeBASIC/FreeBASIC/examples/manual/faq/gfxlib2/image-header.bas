'' examples/manual/faq/gfxlib2/image-header.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=FaqPggetputstructure
'' --------

'' here we define the image buffer header structure
Type _OLD_HEADER Field = 1
	bpp : 3 As UShort
	Width : 13 As UShort
	height As UShort
End Type

Type PUT_HEADER Field = 1
	Union
		old As _OLD_HEADER
		Type As UInteger
	End Union
	bpp As Integer
	Width As UInteger
	height As UInteger
	pitch As UInteger
	_reserved( 1 To 12 ) As UByte
End Type

#define PUT_HEADER_NEW		&h7


'' function to show info on an image
Sub show_image_info( ByVal image As Any Ptr )
	Dim As PUT_HEADER Ptr header

	header = image
	If( header->Type = PUT_HEADER_NEW ) Then
		Print "New style header"
		Print "Image is " & header->Width & "x" & header->height
		Print "Image uses " & header->bpp & " bytes for each pixel"
		Print "A row of image pixels takes " & header->pitch & " bytes"
	Else
		Print "Old style header"
		Print "Image is " & header->old.width & "x" & header->old.height
		Print "Image uses " & header->old.bpp & " bytes for each pixel"
	End If
End Sub


Dim As Any Ptr picture

Screen 17, 32

picture = ImageCreate( 10, 10, 7 )

Put( 40, 40 ), picture

show_image_info( picture )
 
Sleep
