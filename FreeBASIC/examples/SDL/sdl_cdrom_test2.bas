' SDL_cdrom example written by Edmond Leung (leung.edmond@gmail.com)
'
' Provides a small example for coding a very basic CD player with a number of
' standard features such as play, stop, cd eject, pause, and track selection.

dim shared errorMsg as string

'$include: "SDL\SDL.bi"

	dim status as CDstatus
	dim cdrom as SDL_CD ptr
	dim curtrack as integer

	' initiate SDL with cdrom support
	if (SDL_Init(SDL_INIT_CDROM) < 0) then
   		errorMsg = *SDL_GetError()
   		print "Unable to initialise SDL: "; errorMsg
   		end 1
	end if

	' opens the default cdrom drive
	cdrom = SDL_CDOpen(0)
	if (cdrom = 0) then
   		errorMsg = *SDL_GetError()
   		print "Unable to open CDROM drive: "; errorMsg
   		end 1
	end if

	screen 13

	dim done as integer
	do while (done = 0)
   		dim event as SDL_Event   
   
   		' check the status of the cdrom drive
   		status = SDL_CDStatus(cdrom)
   
   		do while (SDL_PollEvent(@event) and status >= CD_STOPPED)
      		select case (event.type)
      		case SDL_QUIT_
         		' stop the cd being played before quitting
         		if (CD_INDRIVE(status)) then SDL_CDStop(cdrom)
         		done = 1
      
      		case SDL_KEYDOWN:
         		' quit when the user presses escape
         		if (event.key.keysym.sym = SDLK_ESCAPE) then
            		' stop the cd being played before quitting
            		if (CD_INDRIVE(status)) then SDL_CDStop(cdrom)
            		done = 1
         		end if
      		
      		case SDL_KEYUP
         		dim changetrack as ubyte
         		changetrack = 0
         
         		' check which option the user has selected
         		select case (event.key.keysym.sym)
         		case SDLK_1
            		select case (status)
            		case CD_PAUSED:
               			SDL_CDResume(cdrom)
            		case CD_STOPPED:
               			SDL_CDPlayTracks(cdrom, curtrack, 0, 0, 0)
            		case CD_PLAYING:
               			SDL_CDPause(cdrom)
            		end select
         		
         		case SDLK_2
            		select case (status)
            		case CD_PAUSED, CD_PLAYING:
               			SDL_CDStop(cdrom)
            		case CD_STOPPED:
               			SDL_CDEject(cdrom)
            		end select
         
         		case SDLK_3
            		' change the track to the previous track
            		curtrack = curtrack - 1
            		if (curtrack < 0) then curtrack = cdrom->numtracks - 1
            		changetrack = 1
         
         		case SDLK_4
            		' change the track to the next track
            		curtrack = curtrack + 1
            		if (curtrack >= cdrom->numtracks) then curtrack = 0
            		changetrack = 1
         		end select
         
         		' if the user wants to change track then play the newly selected track
         		if (status <> CD_STOPPED and changetrack = 1) then            
            		SDL_CDResume(cdrom)
            		SDL_CDPlayTracks(cdrom, curtrack, 0, 0, 0)
         		end if
      		end select
   		loop
   
   		locate 2, 2
   
   		' display info based on the current status of the cdrom drive
   		select case (status)
   		case CD_TRAYEMPTY
      		print "Please insert a CD"
   		case CD_ERROR
      		print "Error occured"
   		case else:
      		' print the track id/name
      		print "Track "; cdrom->track(curtrack).id
      
      		locate 3, 2
      
      		select case (status)
      		case CD_STOPPED:
         		print "Stopped"
         
         		locate 5, 2: print "1. Play"
         		locate 6, 2: print "2. Eject"         
      
      		case CD_PLAYING, CD_PAUSED:
         		curtrack = cdrom->cur_track
         		dim m, s, f as integer
         		FRAMES_TO_MSF cdrom->cur_frame, @m, @s, @f 
         
         		' make it blink if the cd is paused
         		if (SDL_GetTicks() mod 1000 < 500 and status = CD_PAUSED) then
         		else
            		' print the track time
            		print trim(str(m)); ":"; string(2 - len(str(s)), "0"); trim(str(s))
         		end if
         
         		' options change according to the status of the cdrom drive
         		if (status = CD_PAUSED) then
            		locate 5, 2: print "1. Play"
         		else
            		locate 5, 2: print "1. Pause"
         		end if
         
         		locate 6, 2: print "2. Stop"
      		end select
      
      		locate 7, 2: print "3. Previous Track"
      		locate 8, 2: print "4. Next Track" 
   		end select
   
   		flip
   		cls
	loop

	SDL_Quit