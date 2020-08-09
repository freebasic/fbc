'' gif_lib example, by jofers

#include once "gif_lib.bi"
#define NULL 0

const SCR_W = 640
const SCR_H = 480
const SCR_BPP = 32

declare function imageread_gif( byval filename as zstring ptr, byval bpp as integer ) as any ptr

	screenres SCR_W, SCR_H, SCR_BPP

	dim as string filename = exepath() & "/../../fblogo.gif"
	dim as any ptr img = imageread_gif( filename, SCR_BPP )
	if( img = 0 ) then
		print "error loading .gif file '" & filename & "'" : sleep : end 1
	end if

	put (0,0), img, pset

	sleep

	imagedestroy( img )

function imageread_gif( byval filename as zstring ptr, byval bpp as integer ) as any ptr
	#if __GIFLIB_VER__ <= 4
		dim ft as GifFileType ptr = DGifOpenFileName( filename )
	#else
		dim ft as GifFileType ptr = DGifOpenFileName( filename, NULL )
	#endif
	if( ft = NULL ) then
		return NULL
	end if

	if( DGifSlurp( ft ) <> GIF_OK ) then
		return NULL
	end if

	if( ft->ImageCount <= 0 ) then
		return NULL
	end if

	dim as integer w = ft->SavedImages[0].ImageDesc.Width
	dim as integer h = ft->SavedImages[0].ImageDesc.Height

	dim as any ptr img = imagecreate( w, h )
	if( img = NULL ) then
		return NULL
	end if

	dim as GifColorType ptr pal = ft->sColorMap->Colors
	dim as ubyte ptr src = ft->SavedImages[0].RasterBits

	if( bpp = 8 ) Then
		for c as integer = 0 To ft->sColorMap->ColorCount - 1
			palette c, pal[c].Red, pal[c].Green, pal[c].Blue
		next

		for ht as integer = 0 to h-1
			for wt as integer = 0 to w-1
				pset img, (wt, ht), *src
				src += 1
			next
		next
	else
		for ht as integer = 0 to h-1
			for wt as integer = 0 to w-1
				pset img, (wt, ht), Rgb(pal[*src].Red, pal[*src].Green, pal[*src].Blue)
				src += 1
			next
		next
	end if

	#if __GIFLIB_VER__ <= 4
		DGifCloseFile( ft )
	#else
		DGifCloseFile( ft, NULL )
	#endif

	function = img
end function
