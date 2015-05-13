''
'' GD library test
''



#include once "gd/gd.bi"

const IMG_WIDTH = 320
const IMG_HEIGHT = 200

declare function saveImgToGIF( byval img as gdImagePtr, byref filename as string ) as integer
declare function saveImgToPNG( byval img as gdImagePtr, byref filename as string ) as integer
declare function saveImgToJPEG( byval img as gdImagePtr, byref filename as string ) as integer

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
	
		gdImageLine img, x1, y1, x2, y2, rgba( rnd * 256, rnd * 256, rnd * 256, 0 )
	next i

	'' save to file
	saveImgToGIF( img, "test.gif" )
	
	saveImgToPNG( img, "test.png" )
	
	saveImgToJPEG( img, "test.jpg" )
	
	
	
'':::::	
function saveImgToGIF( byval img as gdImagePtr, byref filename as string ) as integer
	dim outf as FILE ptr
	
	function = 0
	
	outf = fopen( filename, "wb" )
	if( outf = 0 ) then
		exit function
	end if
	
	gdImageGif( img, outf )
	
	fclose( outf )
	
	function = -1
	
end function

'':::::	
function saveImgToPNG( byval img as gdImagePtr, byref filename as string ) as integer
	dim outf as FILE ptr
	
	function = 0
	
	outf = fopen( filename, "wb" )
	if( outf = 0 ) then
		exit function
	end if
	
	gdImagePng( img, outf )
	
	fclose( outf )
	
	function = -1
	
end function

'':::::	
function saveImgToJPEG( byval img as gdImagePtr, byref filename as string ) as integer
	dim outf as FILE ptr
	
	function = 0
	
	outf = fopen( filename, "wb" )
	if( outf = 0 ) then
		exit function
	end if
	
	gdImageJpeg( img, outf, 50 )
	
	fclose( outf )
	
	function = -1
	
end function
