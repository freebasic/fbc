'' examples/manual/udt/field.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgField
'' --------

Type bitmap_header Field = 1
	bfType          As UShort
	bfsize          As UInteger
	bfReserved1     As UShort
	bfReserved2     As UShort
	bfOffBits       As UInteger
	biSize          As UInteger
	biWidth         As UInteger
	biHeight        As UInteger
	biPlanes        As UShort
	biBitCount      As UShort
	biCompression   As UInteger
	biSizeImage     As UInteger
	biXPelsPerMeter As UInteger
	biYPelsPerMeter As UInteger
	biClrUsed       As UInteger
	biClrImportant  As UInteger
End Type

Dim bmp_header As bitmap_header

'Open up bmp.bmp and get its header data:
'Note: Will not work without a bmp.bmp to load . . .
Open "bmp.bmp" For Binary As #1

	Get #1, , bmp_header
	
Close #1

Print bmp_header.biWidth, bmp_header.biHeight

Sleep

