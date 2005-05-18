
const BITMAP_ID = &H4D42

type BITMAPINFOHEADER Field = 1
  biSize          as integer
  biWidth         as integer
  biHeight        as integer
  biPlanes        as short
  biBitCount      as short
  biCompression   as integer
  biSizeImage     as integer
  biXPelsPerMeter as integer
  biYPelsPerMeter as integer
  biClrUsed       as integer
  biClrImportant  as integer
end type

type PALETTEENTRY Field = 1
  peRed   as byte
  peGreen as byte
  peBlue  as byte
  peFlags as byte
end type

type BITMAPFILEHEADER FIELD = 1
  bfType as short
  bfSize as integer
  bfReserved1 as short
  bfReserved2 as short
  bfOffBits as integer
end type

'This is a replacement for AUX_RGBImageRec because GLAUX lib is not part of
'the freebasic install (perhaps not worth having for only one useful function).
type BITMAP_RGBImageRec FIELD = 1
  sizeX as integer
  sizeY as integer
  buffer as ubyte ptr
end type


declare function LoadBMP(Filename as string) as BITMAP_RGBImageRec ptr
