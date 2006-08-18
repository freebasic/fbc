''
'' gif_lib example, by jofers
''



#include once "gif_lib.bi"

const SCR_W = 640
const SCR_H = 480
const SCR_BPP = 32

declare function imageread_gif( byval filename as zstring ptr, _
					    		byval bpp as integer ) as any ptr

	screenres SCR_W, SCR_H, SCR_BPP
	
	dim as any ptr img = imageread_gif( "test.gif", SCR_BPP )
	
	if( img = 0 ) then
		end 1
	end if
	
	put (0,0), img, pset
	
	sleep
	
	imagedestroy( img )

function imageread_gif( byval filename as zstring ptr, _
					    byval bpp as integer ) as any ptr

	dim ft as GifFileType ptr = DGifOpenFileName( filename )
	if( ft = NULL ) then
		return NULL
	end if
    
    DGifSlurp( ft )
    
    dim as integer w, h, wt, ht, c
    dim as byte ptr src
    dim as GifColorType ptr pal
    
    w = ft->SavedImages[0].ImageDesc.Width
    h = ft->SavedImages[0].ImageDesc.Height
    
    dim as any ptr img = imagecreate( w, h )
    
    pal = ft->sColorMap->Colors
    src = ft->SavedImages[0].RasterBits

    if( bpp = 8 ) Then
    	for c = 0 To ft->sColorMap->ColorCount - 1
        	palette c, pal[c].Red, pal[c].Green, pal[c].Blue
    	next
        
        memcpy( cast( byte ptr, img ) + 4, src, w * h )
    
    else
        for ht = 0 to h-1
            for wt = 0 to w-1
                c = *src
                src += 1
                pset img, (wt, ht), Rgb(pal[c].Red, pal[c].Green, pal[c].Blue)
            next
        next
    end if
    
    DGifCloseFile( ft )
    
    function = img
        
end function

