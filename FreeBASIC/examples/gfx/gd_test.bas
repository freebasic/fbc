''
'' GD library test
''

option explicit

#include once "gd/gd.bi"

const IMG_WIDTH = 320
const IMG_HEIGHT = 200

declare function saveImgToGIF( byval img as gdImagePtr, filename as string ) as integer

'':::::
	
	dim img as gdImagePtr
	
	'' create image
	img = gdImageCreateTrueColor( IMG_WIDTH, IMG_HEIGHT )
	
	'' draw on it
	dim as integer i, x1, y1, x2, y2
	
	randomize timer
	
	for i = 1 to 1000
		x1 = rnd * (IMG_WIDTH-1)
		y1 = rnd * (IMG_HEIGHT-1)
		x2 = rnd * (IMG_WIDTH-1)
		y2 = rnd * (IMG_HEIGHT-1)
	
		gdImageLine img, x1, y1, x2, y2, rgb( rnd * 256, rnd * 256, rnd * 256 )
	next i

	'' save to file
	saveImgToGIF( img, "test.gif" )
	
	
	
'':::::	
function saveImgToGIF( byval img as gdImagePtr, filename as string ) as integer
	dim outf as FILE ptr
	
	saveImgToGIF = 0
	
	outf = fopen( filename, "wb" )
	if( outf = 0 ) then
		exit function
	end if
	
	gdImageGif( img, outf )
	
	fclose( outf )
	
	saveImgToGIF = -1
	
end function