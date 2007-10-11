''
'' SDL pixel ploting example
''



#include  "SDL\SDL.bi"

const SCR_WIDTH  = 320*1
const SCR_HEIGHT = 240*1

declare sub doRender (byval video as SDL_Surface ptr)

	dim result as unsigned integer
	dim video as SDL_Surface ptr
	dim event as SDL_Event

	result = SDL_Init(SDL_INIT_EVERYTHING)
	if result <> 0 then
  		end 1
	end if

	video = SDL_SetVideoMode( SCR_WIDTH, SCR_HEIGHT, 32, 0 ) 'or SDL_FULLSCREEN
	if video = 0 then 
		SDL_Quit
		end 1
	end if
	
	do
	
  		doRender video
	
		SDL_Flip video
		
		SDL_PumpEvents
	loop until( (SDL_PollEvent( @event ) <> 0) and ((event.type = SDL_KEYDOWN) or (event.type = SDL_MOUSEBUTTONDOWN)) )

	SDL_Quit


sub doRender( byval video as SDL_Surface ptr )
	dim buffer as uinteger ptr
	dim x as integer, y as integer
	dim c as uinteger
	dim i as integer
	
	SDL_LockSurface( video )
	
	for i = 1 to 1000
		x = rnd * (SCR_WIDTH-1)
		y = rnd * (SCR_HEIGHT-1)
		c = (rnd * 256) shl 8 ' 2^24
	
		buffer = video->pixels + y * video->pitch + x * len( integer )
	
		*buffer = c
	next i
    
	SDL_UnlockSurface( video )
		
end sub

