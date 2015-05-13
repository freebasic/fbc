' SDL_timer example adapted to freeBasic from:
' http://www.lugod.org/presentations/sdl-talk-2/18.html 

#include  "SDL\SDL.bi"

	dim shared flag as integer

' callback function used by the SDL_SetTimer function
' note the use of SDLCALL (or cdecl) here, if not in place, the code may crash
' always check the SDL header files to see if SDLCALL is required for other
' any callback function used by SDL
function setflag SDLCALL (byval interval as Uint32) as Uint32
	flag = 1
	setflag = interval \ 2
end function

	dim i as integer

	' initialise SDL with timer support on
	SDL_Init(SDL_INIT_TIMER)

	flag = 0
	' setup a new timer that runs every 10000 milli seconds
	' note the use of the function pointer pointing to the setflag function defined
	' above
	SDL_SetTimer(10000, @setflag)

	' a little 5-second loop
	for i = 0 to 4
   		' show a countdown
   		print 5 - i
   
   		' show if the flag was set during the last second (clear it, too)
   		if (flag = 1) then
      		print "Flag was set!"
      		flag = 0
   		end if
   
   		SDL_Delay(1000)
	next

	' close up and quit
	SDL_Quit
