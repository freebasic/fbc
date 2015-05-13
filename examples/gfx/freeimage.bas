''
'' example using FreeImage to load an image of any type and SDL to show it
''
'' use the arrow keys to move the image, esc to quit
''

#include "FreeImage.bi"
#include "SDL/SDL.bi"

const SCR_WIDTH = 800
const SCR_HEIGHT= 600
const SCR_BPP   = 16

declare sub blitImage (byval img as SDL_Surface ptr, byval x as integer, byval y as integer)
declare function fibitmap2sdlsurface( byval dib as FIBITMAP Ptr ) as SDL_Surface ptr

	dim dib As FIBITMAP Ptr
	dim fiVersion As String
	dim fiType As FREE_IMAGE_FORMAT
	dim filename as string
	
	filename = Command	
	if( filename = "" )Then
	  	print "usage: freeimage.exe filename.ext"
	  	sleep
      	end 1
	end if

	if( left( filename, 1 ) = !"\"" ) then
		filename = mid( filename, 2 )
	end if

	if( right( filename, 1 ) = !"\"" ) then
		filename = left( filename, len( filename ) - 1 )
	end if
	
	
	' get file type
   	fiType = FreeImage_GetFileType( filename )

   	If fiType = FIF_UNKNOWN Then
      Print
      Print "Unknown image format or file not found"
      End -1
   	End If

	fiVersion = *FreeImage_GetVersion

   	print
   	Print "FreeImage v"; fiVersion
   	Print "Opening: "; filename
   	
   	Print "Format: ";
   	Select Case as const fiType
      Case FIF_BMP:     Print "OS/2 Bitmap (bmp)"
      Case FIF_ICO:     Print "Icon (ico)"
      Case FIF_JPEG:    Print "JPEG - JFIF Compliant (jif/jpg/jpeg)"
      Case FIF_JNG:     Print "JNG (jng)"
      Case FIF_KOALA:   Print "Koala (?)"
      Case FIF_LBM:     Print "Deluxe Paint (lbm) or Amiga (iff)"
      Case FIF_MNG:     Print "? (mng)"
      Case FIF_PBM:     Print "Portable Bitmap (pbm)"
      Case FIF_PBMRAW:  Print "Raw Portable Bitmap (pbm?)"
      Case FIF_PCD:     Print "Kodak Photo CD (pcd)"
      Case FIF_PCX:     Print "Zsoft Painbrush (pcx)"
      Case FIF_PGM:     Print "Portable Greymap (pgm)"
      Case FIF_PGMRAW:  Print "Raw Portable Greymap (pgm?)"
      Case FIF_PNG:     Print "Portable Network Graphics (png)"
      Case FIF_PPM:     Print "Portable Pixelmap (ppm)"
      Case FIF_PPMRAW:  Print "Raw Portable Pixelmap (ppm?)"
      Case FIF_RAS:     Print "Sun Raster Image (ras)"
      Case FIF_TARGA:   Print "Truevision Targa (tga)"
      Case FIF_TIFF:    Print "Tagged Image File Format (tif/tiff)"
      Case FIF_WBMP:    Print "Windows Bitmap (bmp)"
      Case FIF_PSD:     Print "Photoshop (psd)"
      Case FIF_CUT:     Print "Dr. Halo (cut)"
      Case FIF_XBM:     Print "? (xbm)"
      Case FIF_XPM:     Print "? (xpm)"
      Case FIF_DDS:     Print "? (dds)"
      Case FIF_GIF:     Print "CompuServe Graphics Interchange (gif)"
	End Select


	' initialise sdl with video support
	if (SDL_Init(SDL_INIT_VIDEO) < 0) then
   		print "Couldn't initialise SDL"
   		end 1
	end if
	
	' load image
	dib = FreeImage_Load( fiType, filename )
	
	'' image is upside-down, flip
	FreeImage_FlipVertical( dib )

	'' create a SDL surface from the bitmap
	dim shared video as SDL_Surface ptr
	dim srcimg as SDL_Surface ptr

	srcimg = fibitmap2sdlsurface( dib )

	if( srcimg = NULL ) then
   		print "Couldn't create surface"
   		end 1
	end if

	' set the video mode
	video = SDL_SetVideoMode( SCR_WIDTH, SCR_HEIGHT, SCR_BPP, SDL_HWSURFACE or SDL_ANYFORMAT )
	if( video = NULL ) then
   		print "Couldn't set video mode"
   		end 1
	end if
	
	'' blip and wait for any input
	dim x as integer, y as integer
	
	x = SCR_WIDTH\2 - srcimg->w\2
	y = SCR_HEIGHT\2 - srcimg->h\2
	
	dim doexit as integer, doupdate as integer
	dim event as SDL_Event
	doexit = 0
	
	' key repeat so we don't have to keep pressing over and over...
	SDL_EnableKeyRepeat(1, 1)
	
	' redraws if needed, quits on keypress or quit event
	do while(doexit = 0 and SDL_WaitEvent( @event ) <> -1)
   		   
      	doupdate = 0
      	select case event.type 
      	'' key pressed
      	case SDL_KEYDOWN
        	select case event.key.keysym.sym
        	case SDLK_ESCAPE 
        		doexit = -1 
        	case SDLK_UP
         		y = y - 8
         		doupdate = -1
         	case SDLK_DOWN
         		y = y + 8
         		doupdate = -1
         	case SDLK_LEFT
         		x = x - 8
         		doupdate = -1
         	case SDLK_RIGHT
         		x = x + 8
         		doupdate = -1
         	end select
   
      	'' mouse button pressed
      	case SDL_MOUSEBUTTONDOWN
      		SDL_GetMouseState( @x, @y )
      		x = x - srcimg->w\2
      		y = y - srcimg->h\2
      		doupdate = -1
      		
      	'' user closed the window
      	case SDL_QUIT_
      		doexit = -1
      			
      	'' window opened or was resized
      	case SDL_VIDEOEXPOSE, SDL_VIDEORESIZE
      		doupdate = -1
   		end select

		'' only redraw if needed
		if( doupdate ) then
   			' clear the screen
   			SDL_FillRect( video, NULL, SDL_MapRGB(video->format, 255, 255, 255) )
   			' draw the image
   			blitImage srcimg, x, y
   			'' show it
   			SDL_Flip( video )
   		end if

   	loop
   
	SDL_Quit
   
   	' Unload the dib
   	FreeImage_Unload dib

   
'':::::
sub blitImage (byval img as SDL_Surface ptr, byval x as integer, byval y as integer)
	dim dest as SDL_Rect
   	dest.x = x
   	dest.y = y
   	SDL_BlitSurface( img, 0, video, @dest )
end sub

'':::::
sub fipal2sdlpal( byval dib as FIBITMAP Ptr, byval surface as SDL_Surface ptr )
	dim pal as RGBQUAD ptr
	dim colors as integer
	dim intpal(0 to 255) as SDL_Color
	dim i as integer
	
	pal = FreeImage_GetPalette( dib )
	colors = FreeImage_GetColorsUsed( dib )
	
	for i = 0 to colors-1
		intpal(i).r = pal->rgbRed
		intpal(i).g = pal->rgbGreen
		intpal(i).b = pal->rgbBlue
		pal += 1
	next i
		
	SDL_SetColors( surface, @intpal(0), 0, colors )
	
end sub

'':::::
function fibitmap2sdlsurface( byval dib as FIBITMAP Ptr ) as SDL_Surface ptr
	dim surface as SDL_Surface ptr
	
	surface = SDL_CreateRGBSurfaceFrom( FreeImage_GetBits( dib ), _
										FreeImage_GetWidth( dib ), FreeImage_GetHeight( dib ), _
										FreeImage_GetBPP( dib ), _
										FreeImage_GetPitch( dib ), _
										FreeImage_GetRedMask( dib ), FreeImage_GetGreenMask( dib ), FreeImage_GetBlueMask( dib ), 0 )

	
	if( surface <> NULL ) then
		if( FreeImage_GetPalette( dib ) <> NULL ) then
			fipal2sdlpal dib, surface
		end if
	end if

	fibitmap2sdlsurface = surface

end function
