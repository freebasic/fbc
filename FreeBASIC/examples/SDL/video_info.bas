'
' SDL_video example
'

'$include: "SDL\SDL.bi"

	Dim Video As SDL_VideoInfo Ptr

	Dim errorMsg As String

	' Startup SDL
	If ( SDL_Init( SDL_INIT_VIDEO ) = -1) Then
		errorMsg = *SDL_GetError()
		Print "SDL_Init: "; errorMsg
   	End 1
	End If

	Video = SDL_GetVideoInfo

	If Video <> 0 Then

		dim NameBuffer as string * 256

		SDL_VideoDriverName @NameBuffer, len( NameBuffer )

		Print "Device: "; NameBuffer
		Print Using "VRAM: ###,### KB"; Video->video_mem

		If ( Video->flagBits And SDL_HW_AVAILABLE ) Then Print "  + Hardware surfaces available"
		If ( Video->flagBits And SDL_WM_AVAILABLE ) Then Print "  + Window manager available"
		If ( Video->flagBits And SDL_BLIT_HW      ) Then Print "  + Hardware to hardware blits accelerated"
		If ( Video->flagBits And SDL_BLIT_HW_CC   ) Then Print "  + Hardware to hardware colorkey blits accelerated"
		If ( Video->flagBits And SDL_BLIT_HW_A    ) Then Print "  + Hardware to hardware alpha blits accelerated"
		If ( Video->flagBits And SDL_BLIT_SW      ) Then Print "  + Software to hardware blits accelerated"
		If ( Video->flagBits And SDL_BLIT_SW_CC   ) Then Print "  + Software to hardware colorkey blits accelerated"
		If ( Video->flagBits And SDL_BLIT_SW_A    ) Then Print "  + Software to hardware alpha blits accelerated"
		If ( Video->flagBits And SDL_BLIT_FILL    ) Then Print "  + Color fills accelerated"

	End If

	' shutdown SDL
	SDL_Quit

	sleep