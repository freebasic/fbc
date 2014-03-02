'' This example works with both fb and fblite dialects
'#lang "fblite"

#include once "fbgfx.bi"
#include once "jpeglib.bi"
#include once "crt.bi"

const SCR_W = 640
const SCR_H = 480
const SCR_BPP = 32

declare function imageread_jpg _
	( _
		byref filename as string, _
		byval bpp as integer _
	) as any ptr


	screenres SCR_W, SCR_H, SCR_BPP

	#if SCR_BPP <= 8
		'' With 8bpp or less screen, a palette is used, instead of RGB colors.
		'' We need to have a palette that matches the colors used in the images
		'' that we want to load in this case.

		'' Set global palette to 0..255 grayscale, matching the
		'' grayscale fblogo.jpg:
		for i as integer = 0 to 255
			palette i, i, i, i
		next

		dim as any ptr img1
		img1 = imageread_jpg( exepath( ) & "/../../fblogo.jpg", SCR_BPP )

		put (0,0), img1, pset

		sleep

		imagedestroy( img1 )
	#else
		dim as any ptr img1, img2

		img1 = imageread_jpg( exepath( ) & "/../../fblogo.jpg", SCR_BPP )
		img2 = imageread_jpg( exepath( ) & "/color.jpg", SCR_BPP )

		put (0,0), img1, pset
		put (320,0), img2, pset

		sleep

		imagedestroy( img2 )
		imagedestroy( img1 )
	#endif


function imageread_jpg _
	( _
		byref filename as string, _
		byval bpp as integer _
	) as any ptr

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

	dim rowbytes as integer
	rowbytes = jinfo.output_width * jinfo.output_components

	'' Allocate an array of rows (but with only 1 row, since we're going to
	'' read only one at a time)
	dim rows as JSAMPARRAY
	dim src as ubyte ptr
	rows = callocate( sizeof( ubyte ptr ) )
	rows[0] = callocate( rowbytes )
	src = rows[0]

#if __FB_LANG__ = "fb"
	dim img as FB.IMAGE ptr
	img = imagecreate( jinfo.output_width, jinfo.output_height )

	dim pitch as integer = img->pitch
	dim as ubyte ptr dst = cast( ubyte ptr, img + 1 )
#else
	dim img as byte ptr
	img = imagecreate( jinfo.output_width, jinfo.output_height )

	dim pitch as integer
	imageinfo img, , , , pitch

	dim as ubyte ptr dst = cast( ubyte ptr, img + 4 )
#endif

	while( jinfo.output_scanline < jinfo.output_height )
		jpeg_read_scanlines( @jinfo, rows, 1 )

		select case( jinfo.out_color_space )
		case JCS_GRAYSCALE
			dim i as integer
			select case( bpp )
			case 24, 32
				for i = 0 to rowbytes-1
					*cptr( ulong ptr, dst ) = rgb( src[i], src[i], src[i] )
					dst += 4
				next
			case 15, 16
				for i = 0 to rowbytes-1
					pset img, (i, jinfo.output_scanline-1), rgb( src[i], src[i], src[i] )
				next
			case else
				'' 8 bpp and less require a proper global palette,
				'' which contains the colors used in the image
				'for i = 0 to rowbytes-1
				'	pset img, (i, jinfo.output_scanline-1), src[i]
				'next
				memcpy( dst, src, rowbytes )
				dst += pitch
			end select

		case JCS_RGB
			imageconvertrow( src, 24, dst, bpp, jinfo.output_width )
			dst += pitch
		end select
	wend

	deallocate( rows[0] )
	deallocate( rows )

	jpeg_finish_decompress( @jinfo )
	jpeg_destroy_decompress( @jinfo )
	fclose( fp )

	function = img
end function
