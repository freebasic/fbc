
#include "fbgfx.bi"
#include "jpeglib.bi"

const SCR_W = 640
const SCR_H = 480
const SCR_BPP = 32

declare function imageread_jpg( byval filename as zstring ptr, _
                                byval bpp as integer ) as FB.IMAGE ptr

	if len( command ) = 0 then
		print "usage: jpeg_read filename.jpg"
		end 1
	end if

	screenres SCR_W, SCR_H, SCR_BPP
	
	dim as FB.IMAGE ptr img = imageread_jpg( command, SCR_BPP )
	
	if( img = 0 ) then
		end 1
	end if
	
	put (0,0), img, pset
	
	sleep
	
	imagedestroy( img )
	

'':::::
function imageread_jpg( byval filename as zstring ptr, _
                        byval bpp as integer ) as FB.IMAGE ptr
	
	dim as FILE ptr fp = fopen( filename, "rb" )
	if( fp = NULL ) then
		return NULL
	end if
	
	dim jinfo as jpeg_decompress_struct
	jpeg_create_decompress( @jinfo )
	
	dim jerr as jpeg_error_mgr
	jinfo.err = jpeg_std_error( @jerr )

	jpeg_stdio_src( @jinfo, fp )
	jpeg_read_header( @jinfo, TRUE )
	jpeg_start_decompress( @jinfo )
	
	dim row as JSAMPARRAY
	row = jinfo.mem->alloc_sarray( cast( j_common_ptr, @jinfo ), _
	                               JPOOL_IMAGE, _
	                               jinfo.output_width * jinfo.output_components, _
	                               1 )
	
	dim img as FB.IMAGE ptr
	img = imagecreate( jinfo.output_width, jinfo.output_height )
	
	dim as byte ptr dst = cast( byte ptr, img + 1 )
	
	do while jinfo.output_scanline < jinfo.output_height
		jpeg_read_scanlines( @jinfo, row, 1 )
		
		'' !!!FIXME!!! no grayscale support
		imageconvertrow( *row, 24, dst, bpp, jinfo.output_width )
		
		dst += img->pitch
	loop
	
	jinfo.mem->free_pool( cast( j_common_ptr, @jinfo ), JPOOL_IMAGE )
	
	jpeg_finish_decompress( @jinfo )
	jpeg_destroy_decompress( @jinfo )
	fclose( fp )
	
	function = img
	
end function
