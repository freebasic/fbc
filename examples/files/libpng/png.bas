#include once "png.bi"
#include once "fbgfx.bi"
#include once "crt/errno.bi"
#include once "crt/string.bi"

const SCR_W = 640
const SCR_H = 480
const SCR_BPP = 32

declare function imageread_png _
	( _
		byref path as string, _
		byref filename as string, _
		byval bpp as integer _
	) as FB.IMAGE ptr

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

		dim as FB.IMAGE ptr img1
		dim as string path = exepath( ) & "/"

		img1 = imageread_png( path, "../../fblogo.png", SCR_BPP )
		if( img1 = NULL ) then
			sleep : end 1
		end if

		put (0,100), img1, pset

		sleep

		imagedestroy( img1 )
	#else
		dim as FB.IMAGE ptr img1, img2, img3
		dim as string path = exepath( ) & "/"

		img1 = imageread_png( path, "../../fblogo.png", SCR_BPP )
		img2 = imageread_png( path, "color.png", SCR_BPP )
		img3 = imageread_png( path, "alpha.png", SCR_BPP )
		if( (img1 = NULL) or (img2 = NULL) or (img3 = NULL) ) then
			sleep : end 1
		end if

		put (0,100), img1, alpha
		put (320,100), img2, alpha
		put (200,200), img3, alpha

		sleep

		imagedestroy( img3 )
		imagedestroy( img2 )
		imagedestroy( img1 )
	#endif


private sub libpng_error_callback cdecl _
	( _
		byval png as png_structp, _
		byval p as png_const_charp _
	)

	print "libpng failed to load the image (" & *p & ")"
	sleep
	end 1

end sub

function imageread_png _
	( _
		byref path as string, _
		byref filename as string, _
		byval bpp as integer _
	) as FB.IMAGE ptr

	dim as ubyte header(0 to 7)

	dim as FILE ptr fp = fopen( path + filename, "rb" )
	if( fp = NULL ) then
		print "could not open image file " & filename
		return NULL
	end if

	if( fread( @header(0), 1, 8, fp ) <> 8 ) then
		print "couldn't read header"
		fclose( fp )
		return NULL
	end if

	if( png_sig_cmp( @header(0), 0, 8 ) ) then
		print "png_sig_cmp() failed"
		fclose( fp )
		return NULL
	end if

	dim as png_structp png = png_create_read_struct( PNG_LIBPNG_VER_STRING, NULL, @libpng_error_callback, NULL )
	if( png = NULL ) then
		print "png_create_read_struct() failed"
		fclose( fp )
		return NULL
	end if

	dim as png_infop info = png_create_info_struct( png )
	if( info = NULL ) then
		print "png_create_info_struct() failed"
		fclose( fp )
		return NULL
	end if

	png_init_io( png, fp )
	png_set_sig_bytes( png, 8 )

	png_read_info( png, info )

	dim as integer w, h, bitdepth, channels, pixdepth, colortype, rowbytes
	w = png_get_image_width( png, info )
	h = png_get_image_height( png, info )
	bitdepth = png_get_bit_depth( png, info )
	channels = png_get_channels( png, info )
	pixdepth = bitdepth * channels
	colortype = png_get_color_type( png, info )

	print filename & ": " & w & "x" & h & " bitdepth=" & bitdepth & " pixdepth=" & pixdepth & " channels=" & channels & " ";

	select case( colortype )
	case PNG_COLOR_TYPE_RGB
		print "rgb"
	case PNG_COLOR_TYPE_RGB_ALPHA
		print "rgba"
	case PNG_COLOR_TYPE_GRAY
		print "grayscale"
	case else
		print "unsupported color type"
		return NULL
	end select

	dim as FB.IMAGE ptr img = imagecreate( w, h )
	dim as ubyte ptr dst = cptr( ubyte ptr, img + 1 )

	png_set_interlace_handling( png )
	png_read_update_info( png, info )

	rowbytes = png_get_rowbytes( png, info )
	dim as ubyte ptr src = callocate( rowbytes )

	for y as integer = 0 to h-1
		png_read_row( png, src, NULL )

		select case( colortype )
		case PNG_COLOR_TYPE_RGB
			imageconvertrow( src, 24, dst, bpp, w )
			dst += img->pitch
		case PNG_COLOR_TYPE_RGB_ALPHA
			select case( bpp )
			case 24, 32
				for i as integer = 0 to rowbytes-1 step 4
					'' FB wants: &hAARRGGBB, that is
					'' &hBB &hGG &hRR &hAA (little endian)
					''
					'' libpng provides &hAABBGGRR, that is
					'' &hRR &hGG &hBB &hAA (little endian)
					''
					'' so we need to copy AA/GG as-is, and
					'' swap RR/BB
					dst[0] = src[i+2]
					dst[1] = src[i+1]
					dst[2] = src[i+0]
					dst[3] = src[i+3]
					dst += 4
				next

			case 15, 16
				'' No alpha supported, only RGB will be used
				imageconvertrow( src, 32, dst, bpp, w )
				dst += img->pitch
			end select

		case PNG_COLOR_TYPE_GRAY
			select case( bpp )
			case 24, 32
				for i as integer = 0 to rowbytes-1
					*cptr( ulong ptr, dst ) = rgb( src[i], src[i], src[i] )
					dst += 4
				next
			case 15, 16
				for i as integer = 0 to rowbytes-1
					pset img, (i, y), rgb( src[i], src[i], src[i] )
				next
			case else
				'' 8 bpp and less require a proper global palette,
				'' which contains the colors used in the image
				'for i as integer = 0 to rowbytes-1
				'	pset img, (i, jinfo.output_scanline-1), src[i]
				'next
				memcpy( dst, src, rowbytes )
				dst += img->pitch
			end select
		end select
	next

	deallocate( src )

	png_read_end( png, info )
	png_destroy_read_struct( @png, @info, 0 )
	fclose( fp )

	function = img
end function
