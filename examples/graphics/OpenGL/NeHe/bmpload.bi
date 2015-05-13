
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


declare function LoadBMP(byref Filename as string) as BITMAP_RGBImageRec ptr

'' Loads A Bitmap Image. Only uncompressed 8 or 24 bit BITMAP immages supported
private function LoadBMP(byref Filename as string) as BITMAP_RGBImageRec ptr
  dim bitmapfileheader as BITMAPFILEHEADER '' this contains the bitmapfile header
  dim bitmapinfoheader as BITMAPINFOHEADER '' this is all the info including the palette
  dim bmpalette(256) as PALETTEENTRY       '' we will store the palette here

  dim index as integer
  dim noofpixels as integer
  dim p as ubyte ptr
  dim r as ubyte, g as ubyte, b as ubyte
  dim pbmpdata as BITMAP_RGBImageRec ptr
  dim f as integer
  f = freefile
  
  if (open (Filename, for binary, as #f) = 0) then             '' Does The File Exist?
  
    get #f, , bitmapfileheader
    if bitmapfileheader.bfType <> BITMAP_ID then
      close #f
      return 0
    end if

    get #f, , bitmapinfoheader

    if bitmapinfoheader.biBitCount=8 or bitmapinfoheader.biBitCount=24 then

      if bitmapinfoheader.biBitCount = 8 then
        for index = 0 to 255
          get #f, , bmpalette(index)
        next
      end if

      noofpixels = bitmapinfoheader.biWidth*bitmapinfoheader.biHeight

      '' allocate the memory for the image (24 bit memory image)
      pbmpdata = allocate(len(BITMAP_RGBImageRec))
      if pbmpdata = 0 then
        '' close the file
        close #f
        return 0
      end if
      pbmpdata->sizeX  = bitmapinfoheader.biWidth
      pbmpdata->sizeY  = bitmapinfoheader.biHeight
      pbmpdata->buffer = allocate(noofpixels*3)
      if pbmpdata->buffer = 0 then
        '' close the file
        close #f
        deallocate (pbmpdata)
        return 0
      end if

      '' now read it in
      p = pbmpdata->buffer
      if bitmapinfoheader.biBitCount=24 then
        for index = 0 to noofpixels -1
          '' Change from BGR to RGB format
          get #f, , b
          get #f, , g
          get #f, , r
          *p = r : p += 1
          *p = g : p += 1
          *p = b : p += 1
        next
      else
        for index = 0 to noofpixels -1
          '' Change from BGR to RGB format while converting to 24 bit
          get #f, , b
          *p = bmpalette(b).peBlue  : p += 1
          *p = bmpalette(b).peGreen : p += 1
          *p = bmpalette(b).peRed   : p += 1
        next
      end if
    else
      close #f
      return 0
    end if
    '' Success!
    close #f
    return pbmpdata
  end if

  return 0                      '' If Load Failed Return FALSE (NULL)
end function

