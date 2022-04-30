'' examples/manual/udt/field.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FIELD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgField
'' --------

Type bitmap_header Field = 1
	bfType          As UShort
	bfsize          As ULong
	bfReserved1     As UShort
	bfReserved2     As UShort
	bfOffBits       As ULong
	biSize          As ULong
	biWidth         As ULong
	biHeight        As ULong
	biPlanes        As UShort
	biBitCount      As UShort
	biCompression   As ULong
	biSizeImage     As ULong
	biXPelsPerMeter As ULong
	biYPelsPerMeter As ULong
	biClrUsed       As ULong
	biClrImportant  As ULong
End Type

Dim bmp_header As bitmap_header

'Open up bmp.bmp and get its header data:
'Note: Will not work without a bmp.bmp to load . . .
Open "bmp.bmp" For Binary As #1

	Get #1, , bmp_header
	
Close #1

Print bmp_header.biWidth, bmp_header.biHeight

Sleep

