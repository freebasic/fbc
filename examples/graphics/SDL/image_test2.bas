' SDL_image example adapted to freeBasic from:
' http://jcatki.no-ip.org/SDL_image/demos/viewimage-fade.c
'
' basic.gif is taken from the official freeBasic website.
'
' Press cursor up/down to alter the fade amount.

#include  "SDL\SDL.bi"
#include  "SDL\SDL_image.bi"

sub fade _
   (byval video as SDL_Surface ptr, byval rgb_ as Uint32, byval a as Uint8)
   dim tmp as SDL_Surface ptr
	tmp = SDL_DisplayFormat(video)
   	SDL_FillRect(tmp, 0, rgb_)
   	SDL_SetAlpha(tmp, SDL_SRCALPHA, a)
   	SDL_BlitSurface(tmp, 0, video, 0)
   	SDL_FreeSurface(tmp)
end sub

	dim video as SDL_Surface ptr
	dim image as SDL_Surface ptr
	dim event as SDL_Event
	dim done as integer
	dim a as integer
	dim filename as string
	done = 0
	a = 128
	filename = "data/basic.gif"

	' startup SDL
	if (SDL_Init(SDL_INIT_VIDEO) = -1) then
   		print "SDL_Init: "; *SDL_GetError()
   		end 1
	end if

	' load the image
	image = IMG_Load(filename)
	if (image = 0) then
   		print "IMG_Load: "; *IMG_GetError()
   		SDL_Quit
   		end 1
	end if

	' print some info about the image
	print "loaded "; filename; ":"; image->w; "x"; trim(str(image->h)); ""; _
   	image->format->BitsPerPixel; "bpp"

	' open the screen for displaying the image
	' try to match the image size and depth 
	video = SDL_SetVideoMode(image->w, image->h, image->format->BitsPerPixel, SDL_ANYFORMAT)
	if (video = 0) then
   		print "SDL_SetVideoMode: "; *SDL_GetError()
   		SDL_Quit
   		end 1
	end if

	' set the window title to the filename
	SDL_WM_SetCaption filename, filename 

	' print some info about the obtained screen
	print "screen is"; video->w; "x"; trim(str(video->h)); ""; video->format->BitsPerPixel; "bpp"
	print "press cursor up/down to alter the fade amount."
	print "fade = "; a

	' do the initial image display
	SDL_BlitSurface(image, 0, video, 0)
	fade video, SDL_MapRGB(video->format, 0, 0, 0), a 
	SDL_Flip(video)

	' key repeat so we don't have to keep pressing over and over...
	SDL_EnableKeyRepeat(1, 1)

	' the event loop, redraws if needed, quits on keypress or quit event
	do while (done = 0 and SDL_WaitEvent(@event) <> -1)
   		select case (event.type)
   		case SDL_KEYDOWN:
      		dim handled as integer
      		handled = 0
      		select case (event.key.keysym.sym)
      		case SDLK_UP:
         		a = a - 1
         		if (a < 0) then a = 0
         		handled = 1
      		case SDLK_DOWN:
         		a = a + 1
         		if (a > 255) then a = 255
         		handled = 1
      		case SDLK_ESCAPE:
         		done = 1
      		end select
      		if (handled) then
         		print "fade = "; a
         		SDL_BlitSurface(image, 0, video, 0)
         		fade video, SDL_MapRGB(video->format, 0, 0, 0), a 
         		SDL_Flip(video)
      		end if
   		
   		case SDL_QUIT_:
      		' quit events, exit the event loop
      		done = 1
   		
   		case SDL_VIDEOEXPOSE:
      		' need a redraw, we just redraw the whole screen for simplicity 
      		SDL_BlitSurface(image, 0, video, 0)
      		fade video, SDL_MapRGB(video->format, 0, 0, 0), a 
      		SDL_Flip(video)
   		end select
	loop

	' free the loaded image
	SDL_FreeSurface(image)

	' shutdown SDL
	SDL_Quit
