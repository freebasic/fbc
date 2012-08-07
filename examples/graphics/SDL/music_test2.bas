
' SDL_music example adapted to freeBasic from:
' http://www.kekkai.org/roger/sdl/mixer/
'
' phaser.wav is phaser noise which comes with the OpenAL library.
'
' Press any to start/stop the wav file, ESC to exit.

#include  "SDL\SDL.bi"
#include  "SDL\SDL_mixer.bi"

	' Mix_Chunk is like Mix_Music, only it's for ordinary sounds.
	dim shared phaser as Mix_Chunk ptr
	phaser = NULL

	' Every sound that gets played is assigned to a channel.  Note that
	' this is different from the number of channels you request when you
	' open the audio device; a channel in SDL_mixer holds information
	' about a sound sample that is playing, while the number of channels
	' you request when opening the device is dependant on what sort of
	' sound you want (1 channel = mono, 2 = stereo, etc)
	dim shared phaserChannel as integer
	phaserChannel = -1

declare sub handleKey(byval key as SDL_KeyboardEvent ptr)

	dim video as SDL_Surface ptr
	dim event as SDL_Event
	dim done as integer
	done = 0

	' Same setup as before
	dim audio_rate as integer
	dim audio_format as Uint16
	dim audio_channels as integer
	dim audio_buffers as integer
	audio_rate = 22050
	audio_format = AUDIO_S16
	audio_channels = 2
	audio_buffers = 4096

	SDL_Init(SDL_INIT_VIDEO or SDL_INIT_AUDIO)

	if(Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_buffers)) then
   		print "Unable to open audio!"
   		end 1
	end if

	' We're going to pre-load the sound effects that we need right here
	phaser = Mix_LoadWAV("data/phaser.wav")

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
   
   		SDL_Delay(50)
   
	loop

	Mix_CloseAudio
	SDL_Quit

sub handleKey (byval key as SDL_KeyboardEvent ptr)
   	dim keyEvent as SDL_KeyboardEvent
   	keyEvent = *key
   
    if (phaserChannel < 0) then
         
		' Mix_PlayChannel takes, as its arguments, the channel that
        ' the given sound should be played on, the sound itself, and
        ' the number of times it should be looped.  If you don't care
        ' what channel the sound plays on, just pass in -1.  Looping
        ' works like Mix_PlayMusic. This function returns the channel
        ' that the sound was assigned to, which you'll need later.
        phaserChannel = Mix_PlayChannel(-1, phaser, -1)
         
	else
        'Mix_HaltChannel stops a certain channel from playing - this
        'is one of the reasons we kept track of which channel the
        'phaser had been assigned to 
        Mix_HaltChannel(phaserChannel)
            
        phaserChannel = -1
	end if

end sub
