'' examples/manual/extras/freeimage.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FreeImage'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibfreeimage
'' --------

'' Code example for loading all common image types using FreeImage.
'' The example loads an image passed as a command line argument.

'' The function FI_Load returns a null pointer (0) if there was an error during
'' loading.  Otherwise it returns a 32-bit PUT compatible buffer.

#include "FreeImage.bi"
#include "crt.bi"
#include "fbgfx.bi"

Function FI_Load(filename As String) As Any Ptr
	If Len(filename) = 0 Then
		Return NULL
	End If

	'' Find out the image format
	Dim As FREE_IMAGE_FORMAT form = FreeImage_GetFileType(StrPtr(filename), 0)
	If form = FIF_UNKNOWN Then
		form = FreeImage_GetFIFFromFilename(StrPtr(filename))
	End If

	'' Exit if unknown
	If form = FIF_UNKNOWN Then
		Return NULL
	End If

	'' Always load jpegs accurately
	Dim As UInteger flags = 0
	If form = FIF_JPEG Then
		flags = JPEG_ACCURATE
	End If

	'' Load the image into memory
	Dim As FIBITMAP Ptr image = FreeImage_Load(form, StrPtr(filename), flags)
	If image = NULL Then
		'' FreeImage failed to read in the image
		Return NULL
	End If

	'' Flip the image so it matches FB's coordinate system
	FreeImage_FlipVertical(image)

	'' Convert to 32 bits per pixel
	Dim As FIBITMAP Ptr image32 = FreeImage_ConvertTo32Bits(image)

	'' Get the image's size
	Dim As UInteger w = FreeImage_GetWidth(image)
	Dim As UInteger h = FreeImage_GetHeight(image)

	'' Create an FB image of the same size
	Dim As fb.Image Ptr sprite = ImageCreate(w, h)

	Dim As Byte Ptr target = CPtr(Byte Ptr, sprite + 1)
	Dim As Integer target_pitch = sprite->pitch

	Dim As Any Ptr source = FreeImage_GetBits(image32)
	Dim As Integer source_pitch = FreeImage_GetPitch(image32)

	'' And copy over the pixels, row by row
	For y As Integer = 0 To (h - 1)
		memcpy(target + (y * target_pitch), _
			   source + (y * source_pitch), _
			   w * 4)
	Next

	FreeImage_Unload(image32)
	FreeImage_Unload(image)

	Return sprite
End Function

ScreenRes 640, 480, 32

Dim As String filename = Command(1)

Dim As Any Ptr image = FI_Load(filename)
If image <> 0 Then
	Put (0, 0), image
	ImageDestroy(image)
Else
	Print "Problem while loading file : " & filename
End If

Sleep
