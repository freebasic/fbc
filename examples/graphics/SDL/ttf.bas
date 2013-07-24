''
'' SDL_ttf example
''

#include once "SDL/SDL.bi"
#include once "SDL/SDL_ttf.bi"

const SCR_WIDTH  = 320
const SCR_HEIGHT = 240
const SCR_BPP	 = 16

const FONTFILE 	 = "data/Vera.ttf"
const FONTSIZE	 = 36			'' in points
const FONTTEXT	 = "tff!"

declare sub drawtext _
	( _
		byval video as SDL_Surface ptr, _
		byval x as integer, _
		byval y as integer, _
		byval clr as SDL_Color, _
		byref text as string, _
		byval font as TTF_Font ptr _
	)

	dim video as SDL_Surface ptr
	dim event as SDL_Event
	dim clr as SDL_Color
	dim Font1 as TTF_Font ptr

	if( SDL_Init(SDL_INIT_VIDEO) <> 0 ) then
		print "SDL_Init() failed"
		end 1
	end if

	video = SDL_SetVideoMode( SCR_WIDTH, SCR_HEIGHT, SCR_BPP, 0 ) 'or SDL_FULLSCREEN
	if( video = 0 ) then
		print "SDL_SetVideoMode() failed"
		SDL_Quit
		end 1
	end if

	if( TTF_Init() < 0 ) then
		print "TTF_Init() failed"
		SDL_Quit
		end 1
	end if
   
	Font1 = TTF_OpenFont( FONTFILE, FONTSIZE )
	if( Font1 = 0 ) then
		print "TTF_OpenFont() failed"
		TTF_Quit
		SDL_Quit
		end 1
	end if
   
	dim w as integer, h as integer
	TTF_SizeText( Font1, FONTTEXT, @w, @h )

	do
		for i as integer = 1 to 25
			clr.r = rnd*256
			clr.g = rnd*256
			clr.b = rnd*256
			drawtext video, rnd*(SCR_WIDTH+w*2)-w, rnd*(SCR_HEIGHT+h*2)-h, clr, FONTTEXT, Font1
		next

		SDL_Flip video

		SDL_PumpEvents
	loop until( (SDL_PollEvent( @event ) <> 0) and ((event.type = SDL_KEYDOWN) or (event.type = SDL_MOUSEBUTTONDOWN)) )

	TTF_Quit
	SDL_Quit

sub BlitImage _
	( _
		byval video as SDL_Surface ptr, _
		byval x as integer, _
		byval y as integer, _
		byval surface As SDL_Surface ptr _
	) static

	dim rect As SDL_Rect

	rect.x = x
	rect.y = y
	rect.w = surface->w
	rect.h = surface->h

	SDL_BlitSurface( surface, 0, video, @rect )

end sub

sub drawtext _
	( _
		byval video as SDL_Surface ptr, _
		byval x as integer, _
		byval y as integer, _
		byval clr as SDL_Color, _
		byref text as string, _
		byval font as TTF_Font ptr _
	) static

	dim surface as SDL_Surface ptr
	dim rgbcolor as SDL_Color

	surface = TTF_RenderText_Solid( font, text, clr )
	BlitImage( video, x, y, surface )
	SDL_FreeSurface( surface )

end sub
