'Simple FMOD test for FB
'by Plasma  [11-16-2004]

DefInt A-Z
'$Include: 'fmod.bi'

Declare Sub ErrorQuit (Message$)

Const FALSE = 0
Const MusicFile = "dne_trtn.mod"
	Dim Shared Handle As Long


	If FSOUND_GetVersion <= FMOD_VERSION Then
  		ErrorQuit "FMOD version " + STR$(FMOD_VERSION) + " or greater required"
	End If

	If FSOUND_Init(44100, 32, 0) = FALSE Then
  		ErrorQuit "Can't initialize FMOD"
	End If

	Handle = FMUSIC_LoadSong(MusicFile)
	If Handle = FALSE Then
  		ErrorQuit "Can't load music file " + CHR$(34) + MusicFile + CHR$(34)
	End if

	FMUSIC_PlaySong(Handle)

	Print "FMOD test for freeBASIC"
	Print
	Print "(press any key to quit)"

	Sleep

	FMUSIC_FreeSong(Handle)
	FSOUND_Close

	End


Sub ErrorQuit (Message$)

  print "ERROR: "; Message$
  FMUSIC_FreeSong(Handle)
  FSOUND_Close
  End 1

End Sub

