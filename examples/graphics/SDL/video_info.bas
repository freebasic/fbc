'
' SDL_video example
'

#include  "SDL\SDL.bi"

	Dim Video As const SDL_VideoInfo Ptr

	' Startup SDL
	If ( SDL_Init( SDL_INIT_VIDEO ) = -1) Then
		Print "SDL_Init: "; *SDL_GetError()
   		End 1
	End If

	Video = SDL_GetVideoInfo

	If Video <> 0 Then

		dim NameBuffer as string * 256

		Print "Device: "; *SDL_VideoDriverName( NameBuffer, len( NameBuffer ) )
		
		Print Using "VRAM: ###,### KB"; Video->video_mem

		If ( Video->hw_available ) Then Print "  + Hardware surfaces available"
		If ( Video->wm_available ) Then Print "  + Window manager available"
		If ( Video->blit_hw      ) Then Print "  + Hardware to hardware blits accelerated"
		If ( Video->blit_hw_CC   ) Then Print "  + Hardware to hardware colorkey blits accelerated"
		If ( Video->blit_hw_A    ) Then Print "  + Hardware to hardware alpha blits accelerated"
		If ( Video->blit_sw      ) Then Print "  + Software to hardware blits accelerated"
		If ( Video->blit_sw_CC   ) Then Print "  + Software to hardware colorkey blits accelerated"
		If ( Video->blit_sw_A    ) Then Print "  + Software to hardware alpha blits accelerated"
		If ( Video->blit_fill    ) Then Print "  + Color fills accelerated"

	End If

	' shutdown SDL
	SDL_Quit

	sleep
