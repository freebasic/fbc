' SDL_mouse example written by Edmond Leung (leung.edmond@gmail.com)
'
' Press your mouse buttons to see if they can be detected, and move the mouse
' cursor across the screen to see its position changing. To center the position 
' of the mouse press 'c'.

'$include: "SDL\SDL.bi"

	screen 13

	do while (done = 0)
   		dim event as SDL_Event
   
   		dim mx as integer, my as integer
   		dim rx as integer, ry as integer
   		dim buttonState as ubyte
   
   		' obtain the position of the mouse and store it into the variables mx, my
   		SDL_GetMouseState(@mx, @my)
   
   		' also store its relative position as well
   		SDL_GetRelativeMouseState(@rx, @ry)
   
   		' print some info about the mouse
   		locate 2, 2: print "Press c to center the mouse position."   
   		locate 4, 2: print "Mouse position:"; mx; ","; my
   		locate 5, 2: print "Mouse relative position:"; rx; ","; ry
   
   		dim p as ubyte
   		p = 7
   
   		' now we check which buttons have been pressed
   		buttonState = SDL_GetMouseState(NULL, NULL)
   		if (buttonState and SDL_BUTTON(SDL_BUTTON_LEFT)) then    
      		locate p, 2: print "Left button pressed"
      		p = p + 1
   		end if
   		if (buttonState and SDL_BUTTON(SDL_BUTTON_RIGHT)) then
      		locate p, 2: print "Right button pressed"
      		p = p + 1
   		end if
   		if (buttonState and SDL_BUTTON(SDL_BUTTON_MIDDLE)) then
      		locate p, 2: print "Middle button pressed"
   		end if
   
   		do while (SDL_PollEvent(@event))
      		if (event.type = SDL_QUIT_) then done = 1
      		if (event.type = SDL_KEYDOWN) then
         		if (event.key.keysym.sym = SDLK_ESCAPE) then done = 1
         
         		' if the users presses c we move the mouse to the center of the screen
         		if (event.key.keysym.sym = SDLK_c) then SDL_WarpMouse 160, 100
      		end if
   		loop
   
   		sleep 50
   
   		flip
   		cls
	loop
