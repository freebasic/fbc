''
'' GD library test
''

#include once "gd.bi"

enum
	FORMAT_GIF
	FORMAT_PNG
	FORMAT_JPEG
end enum

function saveImageAs _
	( _
		byval img as gdImagePtr, _
		byref filename as string, _
		byval imageformat as integer _
	) as integer

	dim as FILE ptr f = fopen( filename, "wb" )
	if( f = 0 ) then
		return 0
	end if

	select case( imageformat )
	case FORMAT_GIF
		gdImageGif( img, f )
	case FORMAT_PNG
		gdImagePng( img, f )
	case FORMAT_JPEG
		gdImageJpeg( img, f, 50 )
	end select

	fclose( f )
	return -1
end function

const IMG_WIDTH = 320
const IMG_HEIGHT = 200

'' create image
dim as gdImagePtr img = gdImageCreateTrueColor( IMG_WIDTH, IMG_HEIGHT )

'' draw on it
print "creating example image..."
randomize( timer() )
for i as integer = 1 to 1000
	dim as integer x1 = rnd * (IMG_WIDTH-1)
	dim as integer y1 = rnd * (IMG_HEIGHT-1)
	dim as integer x2 = rnd * (IMG_WIDTH-1)
	dim as integer y2 = rnd * (IMG_HEIGHT-1)
	dim as uinteger col = rgba( rnd * 255, rnd * 255, rnd * 255, 0 )
	gdImageLine( img, x1, y1, x2, y2, col )
next

'' save to files
print "saving it as test.gif, test.png and test.jpg in " & curdir( )
saveImageAs( img, "test.gif", FORMAT_GIF )
saveImageAs( img, "test.png", FORMAT_PNG )
saveImageAs( img, "test.jpg", FORMAT_JPEG )
