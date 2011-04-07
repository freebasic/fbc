'' Simple libpng example that loads 24-bit RGB PNGs
#include once "png.bi"

const SCR_W = 640
const SCR_H = 480
const SCR_BPP = 32

declare function imageread_png( byval filename as zstring ptr, _
                                byval bpp as integer ) as any ptr

	screenres SCR_W, SCR_H, SCR_BPP

	dim as any ptr img = imageread_png( "test.png", SCR_BPP )

	if( img = 0 ) then
		end 1
	end if

	put (16, 16), img, pset

	sleep

	imagedestroy( img )


'':::::
function imageread_png( byval filename as zstring ptr, _
                        byval bpp as integer ) as any ptr

	dim as byte header(0 to 7)

	dim as FILE ptr fp = fopen( filename, "rb" )
	if( fp = NULL ) then
		return NULL
	end if

	if( fread( @header(0), 1, 8, fp ) <> 8 ) then
		fclose( fp )
		return NULL
	end if
	
	if( png_sig_cmp( @header(0), 0, 8 ) ) then
		fclose( fp )
		return NULL
	end if

	dim as png_structp png = png_create_read_struct( PNG_LIBPNG_VER_STRING, NULL, NULL, NULL )
	if( png = NULL ) then
		fclose( fp )
		return NULL
	end if

	dim as png_infop info = png_create_info_struct( png )
	if( info = NULL ) then
		fclose( fp )
		return NULL
	end if

	setjmp( png_jmpbuf( png ) )

	png_init_io( png, fp )
	png_set_sig_bytes( png, 8 )

	png_read_info( png, info )

	dim as any ptr img = imagecreate( info->width, info->height )
	dim as byte ptr dst
	dim as integer dst_pitch

	imageinfo( img, , , , dst_pitch, dst )

	png_set_interlace_handling( png )
	png_read_update_info( png, info)

	setjmp( png_jmpbuf( png ) )

	dim as byte ptr row = allocate( info->rowbytes )

	for y as integer = 0 to info->height-1
		png_read_row( png, row, NULL )
		imageconvertrow( row, info->pixel_depth, dst, bpp, info->width )
		dst += dst_pitch
	next

	deallocate( row )

	png_read_end( png, info )
	png_read_destroy( png, info, 0 )
	fclose( fp )

	function = img

end function
