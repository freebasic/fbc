'' Example of using FreeImage to load an image of any type and SDL to show it.
'' The image file name is expected to be passed on the command line.
'' Use the arrow keys to move the image, ESC to quit.

#include "FreeImage.bi"
#include "SDL/SDL.bi"

const SCR_WIDTH = 800
const SCR_HEIGHT= 600
const SCR_BPP   = 16

dim shared video as SDL_Surface ptr

declare sub blitImage( byval img as SDL_Surface ptr, byval x as integer, byval y as integer )
declare function fibitmap2sdlsurface( byval dib as FIBITMAP Ptr ) as SDL_Surface ptr


	dim as string filename = command( )
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

	'' get file type
	dim fiType as FREE_IMAGE_FORMAT = FreeImage_GetFileType( filename )
	if fiType = FIF_UNKNOWN then
		print
		print "Unknown image format or file not found"
		sleep
		end -1
	end if

	print
	print "FreeImage v"; *FreeImage_GetVersion( )
	print "Opening: "; filename
	print "Format: ";
	select case as const fiType
	case FIF_BMP:     print "OS/2 Bitmap (bmp)"
	case FIF_ICO:     print "Icon (ico)"
	case FIF_JPEG:    print "JPEG - JFIF Compliant (jif/jpg/jpeg)"
	case FIF_JNG:     print "JNG (jng)"
	case FIF_KOALA:   print "Koala (?)"
	case FIF_LBM:     print "Deluxe Paint (lbm) or Amiga (iff)"
	case FIF_MNG:     print "? (mng)"
	case FIF_PBM:     print "Portable Bitmap (pbm)"
	case FIF_PBMRAW:  print "Raw Portable Bitmap (pbm?)"
	case FIF_PCD:     print "Kodak Photo CD (pcd)"
	case FIF_PCX:     print "Zsoft Painbrush (pcx)"
	case FIF_PGM:     print "Portable Greymap (pgm)"
	case FIF_PGMRAW:  print "Raw Portable Greymap (pgm?)"
	case FIF_PNG:     print "Portable Network Graphics (png)"
	case FIF_PPM:     print "Portable Pixelmap (ppm)"
	case FIF_PPMRAW:  print "Raw Portable Pixelmap (ppm?)"
	case FIF_RAS:     print "Sun Raster Image (ras)"
	case FIF_TARGA:   print "Truevision Targa (tga)"
	case FIF_TIFF:    print "Tagged Image File Format (tif/tiff)"
	case FIF_WBMP:    print "Windows Bitmap (bmp)"
	case FIF_PSD:     print "Photoshop (psd)"
	case FIF_CUT:     print "Dr. Halo (cut)"
	case FIF_XBM:     print "? (xbm)"
	case FIF_XPM:     print "? (xpm)"
	case FIF_DDS:     print "? (dds)"
	case FIF_GIF:     print "CompuServe Graphics Interchange (gif)"
	end select

	'' initialise sdl with video support
	if( SDL_Init( SDL_INIT_VIDEO ) < 0 ) then
		print "Couldn't initialise SDL"
		sleep
		end 1
	end if

	'' load image
	dim dib As FIBITMAP Ptr = FreeImage_Load( fiType, filename )

	'' image is upside-down, flip
	FreeImage_FlipVertical( dib )

	'' create a SDL surface from the bitmap
	dim srcimg as SDL_Surface ptr = fibitmap2sdlsurface( dib )
	if( srcimg = NULL ) then
		print "Couldn't create surface"
		sleep
		end 1
	end if

	'' set the video mode
	video = SDL_SetVideoMode( SCR_WIDTH, SCR_HEIGHT, SCR_BPP, SDL_HWSURFACE or SDL_ANYFORMAT )
	if( video = NULL ) then
		print "Couldn't set video mode"
		sleep
		end 1
	end if

	dim as integer x = SCR_WIDTH\2 - srcimg->w\2
	dim as integer y = SCR_HEIGHT\2 - srcimg->h\2

	dim doexit as integer, doupdate as integer
	dim event as SDL_Event

	'' key repeat so we don't have to keep pressing over and over...
	SDL_EnableKeyRepeat( 1, 1 )

	'' redraws if needed, quits on keypress or quit event
	do while( doexit = 0 and SDL_WaitEvent( @event ) <> -1 )
		doupdate = 0

		select case event.type 
		case SDL_KEYDOWN
			'' key pressed
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
   
		case SDL_MOUSEBUTTONDOWN
			'' mouse button pressed
			SDL_GetMouseState( @x, @y )
			x = x - srcimg->w\2
			y = y - srcimg->h\2
			doupdate = -1

		case SDL_QUIT_
			'' user closed the window
			doexit = -1

		case SDL_VIDEOEXPOSE, SDL_VIDEORESIZE
			'' window opened or was resized
			doupdate = -1

		end select

		'' only redraw if needed
		if( doupdate ) then
			' clear the screen
			SDL_FillRect( video, NULL, SDL_MapRGB(video->format, 255, 255, 255) )
			' draw the image
			blitImage( srcimg, x, y )
			'' show it
			SDL_Flip( video )
		end if

	loop

	SDL_Quit( )
	FreeImage_Unload( dib )

sub blitImage( byval img as SDL_Surface ptr, byval x as integer, byval y as integer )
	dim dest as SDL_Rect
	dest.x = x
	dest.y = y
	SDL_BlitSurface( img, 0, video, @dest )
end sub

'' Convert FreeImage palette to SDL palette
sub fipal2sdlpal( byval dib as FIBITMAP Ptr, byval surface as SDL_Surface ptr )
	dim intpal(0 to 255) as SDL_Color

	dim as RGBQUAD ptr pal = FreeImage_GetPalette( dib )
	dim as integer colors = FreeImage_GetColorsUsed( dib )

	for i as integer = 0 to colors-1
		intpal(i).r = pal->rgbRed
		intpal(i).g = pal->rgbGreen
		intpal(i).b = pal->rgbBlue
		pal += 1
	next

	SDL_SetColors( surface, @intpal(0), 0, colors )
end sub

'' Convert FreeImage bitmap to SDL surface
function fibitmap2sdlsurface( byval dib as FIBITMAP Ptr ) as SDL_Surface ptr
	dim surface as SDL_Surface ptr

	surface = SDL_CreateRGBSurfaceFrom( _
				FreeImage_GetBits( dib ), _
				FreeImage_GetWidth( dib ), _
				FreeImage_GetHeight( dib ), _
				FreeImage_GetBPP( dib ), _
				FreeImage_GetPitch( dib ), _
				FreeImage_GetRedMask( dib ), _
				FreeImage_GetGreenMask( dib ), _
				FreeImage_GetBlueMask( dib ), _
				0 )

	if( surface <> NULL ) then
		if( FreeImage_GetPalette( dib ) <> NULL ) then
			fipal2sdlpal( dib, surface )
		end if
	end if

	function = surface
end function
