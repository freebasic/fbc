' SDL_music example adapted to freeBasic from:
' http://www.kekkai.org/roger/sdl/mixer/
'
' music.ogg is a freely distributed song by "Honest Bob and the 
' Factory-to-Dealer Incentives" called "Another person you had sex with" for
' people who wanted an ogg file to test their programs with.
'
' Press any to start/stop the music, ESC to exit.

#include  "SDL\SDL.bi"
#include  "SDL\SDL_mixer.bi"

	' Mix_Music actually holds the music information.
	dim shared music as Mix_Music ptr

	music = NULL

declare sub handlekey(byval key as SDL_KeyboardEvent ptr)
declare sub musicDone cdecl ()

	dim video as SDL_Surface ptr
	dim event as SDL_Event
	dim done as integer
	done = 0

	dim audio_rate as integer
	dim audio_format as Uint16
	dim audio_channels as integer
	dim audio_buffers as integer

	' We're going to be requesting certain things from our audio
	' device, so we set them up beforehand
	audio_rate = 44100
	audio_format = AUDIO_S16
	audio_channels = 2
	audio_buffers = 4096

	SDL_Init(SDL_INIT_VIDEO or SDL_INIT_AUDIO)

	' This is where we open up our audio device.  Mix_OpenAudio takes
	' as its parameters the audio format we'd /like/ to have.
	if (Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_buffers)) then
   		print "Unable to open audio!"
   		end 1
	end if

	' If we actually care about what we got, we can ask here.  In this
	' program we don't, but I'm showing the function call here anyway
	' in case we'd want to know later.
	Mix_QuerySpec(@audio_rate, @audio_format, @audio_channels)

	' We're going to be using a window onscreen to register keypresses
	' in.  We don't really care what it has in it, since we're not
	' doing graphics, so we'll just throw something up there.

	video = SDL_SetVideoMode(320, 240, 0, 0)

	do while (done = 0)
   		do while (SDL_PollEvent(@event))
      		select case (event.type)
      		case SDL_QUIT_
         		done = 1
      		case SDL_KEYDOWN
         		if( event.key.keysym.sym = SDLK_ESCAPE ) then
         			done = -1
         		end if
         
         		handleKey @event.key
      		end select
   		loop

   		' So we don't hog the CPU
   		SDL_Delay(50)
	loop

	' This is the cleaning up part
	Mix_CloseAudio
	SDL_Quit

sub handleKey (byval key as SDL_KeyboardEvent ptr)
	dim keyEvent as SDL_KeyboardEvent
   	keyEvent = *key
   
    ' Here we're going to have the 'm' key toggle the music on and
    ' off.  When it's on, it'll be loaded and 'music' will point to
    ' something valid.  If it's off, music will be NULL.
      
    if (music = NULL) then
		' Actually loads up the music
        music = Mix_LoadMUS("data/music.ogg")            
         
        ' This begins playing the music - the first argument is a
        ' pointer to Mix_Music structure, and the second is how many
        ' times you want it to loop (use -1 for infinite, and 0 to
        ' have it just play once)
        Mix_PlayMusic(music, 0)            
         
        ' We want to know when our music has stopped playing so we
        ' can free it up and set 'music' back to NULL.  SDL_Mixer
        ' provides us with a callback routine we can use to do
        ' exactly that
        Mix_HookMusicFinished(@musicDone)     
    else
        ' Stop the music from playing
        Mix_HaltMusic
         
        ' Unload the music from memory, since we don't need it
        ' anymore
        Mix_FreeMusic(music)         
         
        music = NULL
    end if
      
end sub

' This is the function that we told SDL_Mixer to call when the music
' was finished. In our case, we're going to simply unload the music
' as though the player wanted it stopped.  In other applications, a
' different music file might be loaded and played.
sub musicDone cdecl ()
   	Mix_HaltMusic
   	Mix_FreeMusic(music)
   	music = NULL
end sub
