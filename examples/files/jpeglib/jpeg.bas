#include "fbgfx.bi"
#include "jpeglib.bi"

const SCR_W = 640
const SCR_H = 480
const SCR_BPP = 32

declare function imageread_jpg _
	( _
		byval filename as zstring ptr, _
		byval bpp as integer _
	) as FB.IMAGE ptr

	dim as FB.IMAGE ptr img1, img2

	screenres SCR_W, SCR_H, SCR_BPP

	img1 = imageread_jpg( exepath( ) & "/../../fblogo.jpg", SCR_BPP )
	img2 = imageread_jpg( exepath( ) & "/color.jpg", SCR_BPP )

	put (0,0), img1, pset
	put (320,0), img2, pset

	sleep

	imagedestroy( img2 )
	imagedestroy( img1 )


function imageread_jpg _
	( _
		byval filename as zstring ptr, _
		byval bpp as integer _
	) as FB.IMAGE ptr

	dim as FILE ptr fp = fopen( filename, "rb" )
	if( fp = NULL ) then
		print "could not open image file " & filename
		return NULL
	end if

	dim jinfo as jpeg_decompress_struct
	dim jerr as jpeg_error_mgr

	jinfo.err = jpeg_std_error( @jerr )
	jpeg_create_decompress( @jinfo )

	jpeg_stdio_src( @jinfo, fp )
	jpeg_read_header( @jinfo, 1 )
	jpeg_start_decompress( @jinfo )

	select case( jinfo.out_color_space )
	case JCS_GRAYSCALE
		if( (jinfo.output_components <> 1) or (jinfo.out_color_components <> 1) ) then
			'' grayscale, but not 1 byte per pixel (will this ever happen?)
			return NULL
		end if
	case JCS_RGB
		if( (jinfo.output_components <> 3) or (jinfo.out_color_components <> 3) ) then
			'' RGB, but not 3 bytes per pixel (will this ever happen?)
			return NULL
		end if
	case JCS_YCbCr
		print "jpeg image uses YCbCr color space, not implemented"
		return NULL
	case JCS_CMYK
		print "jpeg image uses CMYK color space, not implemented"
		return NULL
	case JCS_YCCK
		print "jpeg image uses YCCK color space, not implemented"
		return NULL
	case else
		print "jpeg image uses unknown color space"
		return NULL
	end select

	dim row_size as integer
	row_size = jinfo.output_width * jinfo.output_components

	'' Allocate an array of rows (but with only 1 row, since we're going to
	'' read only one at a time)
	dim rows as JSAMPARRAY
	dim src as ubyte ptr
	rows = callocate( sizeof( ubyte ptr ) )
	rows[0] = callocate( row_size )
	src = rows[0]

	dim img as FB.IMAGE ptr
	img = imagecreate( jinfo.output_width, jinfo.output_height )

	dim as ubyte ptr dst = cast( ubyte ptr, img + 1 )

	while( jinfo.output_scanline < jinfo.output_height )
		jpeg_read_scanlines( @jinfo, rows, 1 )

		select case( jinfo.out_color_space )
		case JCS_GRAYSCALE
			select case( bpp )
			case 32
				for i as integer = 0 to row_size-1
					*cptr( ulong ptr, dst ) = rgb( src[i], src[i], src[i] )
					dst += 4
				next
			case 24
				for i as integer = 0 to row_size-1
					dst[0] = src[i] : dst += 1
					dst[0] = src[i] : dst += 1
					dst[0] = src[i] : dst += 1
				next
			case else
				for i as integer = 0 to 255
					palette i, i, i, i
				next
				for i as integer = 0 to row_size-1
					pset img, (i, jinfo.output_scanline-1), src[i]
				next
			end select

		case JCS_RGB
			imageconvertrow( src, 24, dst, bpp, jinfo.output_width )
			dst += img->pitch
		end select
	wend

	deallocate( rows[0] )
	deallocate( rows )

	jpeg_finish_decompress( @jinfo )
	jpeg_destroy_decompress( @jinfo )
	fclose( fp )

	function = img
end function
