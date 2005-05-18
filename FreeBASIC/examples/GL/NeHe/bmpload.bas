#include once "bmpload.bi"

''------------------------------------------------------------------------------
'' Loads A Bitmap Image. Only uncompressed 8 or 24 bit BITMAP immages supported
'' NOTE: This is a replacement for a GLAUX Lib function
function LoadBMP(Filename as string) as BITMAP_RGBImageRec ptr
  dim bitmapfileheader as BITMAPFILEHEADER '' this contains the bitmapfile header
  dim bitmapinfoheader as BITMAPINFOHEADER '' this is all the info including the palette
  dim bmpalette(256) as PALETTEENTRY       '' we will store the palette here

  dim index as integer
  dim noofpixels as integer
  dim p as ubyte ptr
  dim r as ubyte, g as ubyte, b as ubyte
  dim pbmpdata as BITMAP_RGBImageRec ptr

  if (open (Filename, for binary, as #1) = 0) then             '' Does The File Exist?

    get #1, , bitmapfileheader
    if bitmapfileheader.bfType <> BITMAP_ID then
      close #1
      return FALSE
    end if

    get #1, , bitmapinfoheader

    if bitmapinfoheader.biBitCount=8 or bitmapinfoheader.biBitCount=24 then

      if bitmapinfoheader.biBitCount = 8 then
        for index = 0 to 255
          get #1, , bmpalette(index)
        next
      end if

      noofpixels = bitmapinfoheader.biWidth*bitmapinfoheader.biHeight

      '' allocate the memory for the image (24 bit memory image)
      pbmpdata = allocate(len(BITMAP_RGBImageRec))
      if pbmpdata = 0 then
        '' close the file
        close #1
        return FALSE
      end if
      pbmpdata->sizeX  = bitmapinfoheader.biWidth
      pbmpdata->sizeY  = bitmapinfoheader.biHeight
      pbmpdata->buffer = allocate(noofpixels*3)
      if pbmpdata->buffer = 0 then
        '' close the file
        close #1
        deallocate (pbmpdata)
        return FALSE
      end if

      '' now read it in
      p = pbmpdata->buffer
      if bitmapinfoheader.biBitCount=24 then
        for index = 0 to noofpixels -1
          '' Change from BGR to RGB format
          get #1, , b
          get #1, , g
          get #1, , r
          *p = r : p = p + 1
          *p = g : p = p + 1
          *p = b : p = p + 1
        next
      else
        for index = 0 to noofpixels -1
          '' Change from BGR to RGB format while converting to 24 bit
          get #1, , b
          *p = bmpalette(b).peBlue  : p = p + 1
          *p = bmpalette(b).peGreen : p = p + 1
          *p = bmpalette(b).peRed   : p = p + 1
        next
      end if
    else
      close #1
      return FALSE
    end if
    '' Success!
    close #1
    return pbmpdata
  end if

  return FALSE                      '' If Load Failed Return FALSE (NULL)
end function

