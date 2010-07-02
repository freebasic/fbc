' SDL_mouse example written by Edmond Leung (leung.edmond@gmail.com)
'
' Hover over the white box to change the cursor and left or right click on the
' box to change the box's colour.

#include  "SDL\SDL.bi"

' function used to setup a cursor with a given array of image data
declare function loadCursor _
   (image() as ubyte, byval w as integer, byval h as integer, _
   byval hotx as integer, byval hoty as integer) as SDL_Cursor ptr

	dim as SDL_Surface ptr video 
	dim as ubyte hand(31, 31), arrow(31, 31) 
	dim as integer x, y 
	
	' obtain the image used for the hand cursor
	for y = 0 to 31
	   for x = 0 to 31
	      read hand(x, y)
	   next
	next
	
	' obtain the image used for the arrow cursor
	for y = 0 to 31
	   for x = 0 to 31
	      read arrow(x, y)
	   next
	next
	
	' initialise SDL with video support
	if (SDL_Init(SDL_INIT_VIDEO) < 0) then
	   print "Couldn't initialise SDL: "; *SDL_GetError()
	   end 1
	end if
	
	' set the video mode to 640x480x32bpp
	video = SDL_SetVideoMode(640, 480, 32, SDL_HWSURFACE or SDL_DOUBLEBUF)
	if (video = 0) then
	   print "Couldn't set the video mode: "; *SDL_GetError()
	   end 1
	end if
	
	dim handCursor as SDL_Cursor ptr, arrowCursor as SDL_Cursor ptr
	
	' obtain cursors corresponding to the hand and arrow images
	handCursor = loadCursor(hand(), 32, 32, 4, 0)
	arrowCursor = loadCursor(arrow(), 32, 32, 4, 0)
	
	dim done as integer
	done = 0
	
	' setup the colour of the box to be clicked on as white
	dim boxColour as Uint32
	boxColour = SDL_MapRGB(video->format, 255, 255, 255)
	
	' setup the position of the box
	dim boxRect as SDL_Rect
	boxRect.x = 40
	boxRect.y = 40
	boxRect.w = 200
	boxRect.h = 200
	
	do while (done = 0)
	   dim event as SDL_Event
	   
	   do while (SDL_PollEvent(@event))
	      if (event.type = SDL_QUIT_) then done = 1
	      if (event.type = SDL_KEYDOWN) then
	         if (event.key.keysym.sym = SDLK_ESCAPE) then done = 1      
	      end if
	   loop
	   
	   ' default cursor is the arrow cursor
	   SDL_SetCursor(arrowCursor)
	   
	   dim mx as integer, my as integer
	   
	   ' get the x,y position of the mouse cursor
	   SDL_GetMouseState(@mx, @my)
	   ' check to see if it's within the box
	   if (mx >= boxRect.x and my >= boxRect.y) then
	      if (mx <= boxRect.x + boxRect.w and my <= boxRect.y + boxRect.h) then         
	         boxColour = SDL_MapRGB(video->format, 255, 255, 255)
	         
	         ' get the state of the buttons of the mouse
	         dim buttonState as ubyte
	         buttonState = SDL_GetMouseState(NULL, NULL)
	         
	         ' change the colour of the box depending on which button is pressed
	         if (buttonState and SDL_BUTTON(SDL_BUTTON_LEFT)) then
	            boxColour = SDL_MapRGB(video->format, 255, 0, 255)
	         end if
	         if (buttonState and SDL_BUTTON(SDL_BUTTON_RIGHT)) then
	            boxColour = SDL_MapRGB(video->format, 0, 255, 255)
	         end if
	         
	         ' since we are in the box, change the cursor to a pointing hand
	         SDL_SetCursor(handCursor)
	      end if
	   end if
	   
	   ' draw the box
	   SDL_FillRect(video, @boxRect, boxColour)
	   
	   SDL_Flip(video)
	loop
	
	SDL_FreeCursor(arrowCursor)
	SDL_FreeCursor(handCursor)
	SDL_Quit

function loadCursor _
   (image() as ubyte, byval w as integer, byval h as integer, _
   byval hotx as integer, byval hoty as integer) as SDL_Cursor ptr
   dim as integer i, row, col 
   dim as ubyte dat(w * h / 8) 
   dim as ubyte mas(w * h / 8)
   
   ' convert the image data so that it can be used to create a cursor
   i = -1
   for row = 0 to w - 1
      for col = 0 to h - 1
         if (col mod 8) then
            dat(i) = dat(i) shl 1
            mas(i) = mas(i) shl 1
         else
            i = i + 1
            dat(i) = 0
            mas(i) = 0
         end if
         select case (image(col, row))
         case 1:
            dat(i) = dat(i) or &h01
            mas(i) = mas(i) or &h01
         case 2:
            mas(i) = mas(i) or &h01
         end select
      next
   next
   
   loadCursor = SDL_CreateCursor(@dat(0), @mas(0), w, h, hotx, hoty)
end function

' data for hand cursor
data 0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,1,2,2,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,1,2,2,1,2,2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,1,2,2,1,2,2,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,1,1,0,1,2,2,1,2,2,1,2,2,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,1,1,2,2,2,2,2,2,2,2,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,1,2,2,1,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,1,2,1,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,1,2,2,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,1,2,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,1,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,1,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,1,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,1,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

' data for arrow cursor
data 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,2,2,2,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,2,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,2,1,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,1,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 1,0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
