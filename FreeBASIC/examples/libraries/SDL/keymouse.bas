''
'' SDL events test
'' by marzec
''

#include once "SDL/SDL.bi"

declare sub doInit ( )
declare sub doQuit ( )
declare sub doMain ( )
declare sub exitError ( byref msg as string )

dim shared video as SDL_Surface ptr

doInit
doMain
doQuit



sub doInit ( )

	if(SDL_Init( SDL_INIT_EVERYTHING )) then exitError "couldn't init SDL"
	
	video = SDL_SetVideoMode ( 320, 200, 24, SDL_HWSURFACE )
	if( video = 0 ) then exitError "couldn't init videomode"
	
end sub

sub doMain ( )
		
	dim quit as Integer
	dim event as SDL_Event		
	quit = 1

	print "-----------------------------------------------"
	print "                  SDL TEST"
	print "-----------------------------------------------"

	while( quit = 1)
	
		while( SDL_PollEvent ( @event ) ) 						
		  print "event happened, type:" + str(event.type)		
			select case event.type
				case SDL_KEYDOWN:
					print "key event, pressed key:" + str(event.key.keysym.sym)
					print 
				case SDL_MOUSEBUTTONDOWN:
					print "mousebutton pressed, quitting"
					quit = 0
			end select
	
		wend
		
	wend
	
	print "leaving doMain"
end sub

sub doQuit ( )

	print "quiting"
	SDL_Quit

end sub

sub exitError ( byref msg as string )
	print "error: " + msg
	SDL_Quit
	end
end sub
