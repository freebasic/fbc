' SDL_events example adapted to freeBasic from:
' http://www.libsdl.org/cgi/docwiki.cgi/Event_20Examples
'
' Demonstrates the filtering and handling of events.

#include  "SDL\SDL.bi"

' This function may run in a separate event thread 
' note the use of SDLCALL (or cdecl) for this callback function
function FilterEvents SDLCALL (byval event as const SDL_Event ptr) as long
	static boycott as integer
   
   	' This quit event signals the closing of the window    
   	if ((event->type = SDL_QUIT_) and boycott = 0) then
		print "Quit event filtered out -- try again."
      	boycott = 1
      	FilterEvents = 0
      	exit function
   	end if
   	if (event->type = SDL_MOUSEMOTION) then
		print "Mouse moved to ("; event->motion.x; ","; event->motion.y; ")"
      	FilterEvents = 0
      	exit function
   	end if
   	FilterEvents = 1
end function

	dim event as SDL_Event

	' Initialize the SDL library (starts the event loop)
	if (SDL_Init(SDL_INIT_VIDEO) < 0) then
   		print "Couldn't initialize SDL: "; *SDL_GetError()
   		end 1
	end if

	' Ignore key events
	SDL_EventState(SDL_KEYDOWN, SDL_IGNORE)
	SDL_EventState(SDL_KEYUP, SDL_IGNORE)

	' Filter quit and mouse motion events 
	' note the function pointer pointing to the function FilterEvents
	SDL_SetEventFilter(@FilterEvents)

	' The mouse isn't much use unless we have a display for reference 
	if (SDL_SetVideoMode(320, 240, 8, 0) = NULL) then
   		print "Couldn't set 320x240x8 video mode: "; *SDL_GetError()
   		end 1
	end if

	' Loop waiting for ESC+Mouse_Button 
	do while (SDL_WaitEvent(@event) >= 0)
   		select case (event.type)
   		case SDL_ACTIVEEVENT:
      		if (event.active.state and SDL_APPACTIVE) then
         		if (event.active.gain) then
            		print "App activated"
         		else
            		print "App iconified"
         		end if
      		end if
   		
   		case SDL_MOUSEBUTTONDOWN:
      		dim keys as Uint8 ptr
      
      		keys = SDL_GetKeyState(NULL) + SDLK_ESCAPE
      		if (keys = SDL_PRESSED) then
         		print "Bye bye..."
         		end 0
      		end if
      		print "Mouse button pressed"
   
   		case SDL_QUIT_:
      		print "Quit requested, quitting."
      		end 0
   		end select
	loop

	' This should never happen 
	print "SDL_WaitEvent error: "; *SDL_GetError()
