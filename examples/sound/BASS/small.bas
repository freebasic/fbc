' Source: http://www.freebasic-portal.de/porticula/8-1-sound-musikausgabe-1384.html

#Include "bass.bi"

' Initialize BASS
BASS_Init(-1, 44100, 0, 0, 0)

' Load soundeffects and example music
Dim As String musicname = ExePath() & "/../data/example1.ogg"
Dim As HSTREAM music = BASS_StreamCreateFile(0, StrPtr(musicname), 0, 0, 0)
Dim As String soundname = ExePath() & "/../data/example2.ogg"
Dim As HSAMPLE sound = BASS_SampleLoad(0, StrPtr(soundname), 0, 0, 16, 0)
Dim soundchannel As HCHANNEL = BASS_SampleGetChannel(sound, 0)

BASS_ChannelPlay(music, 0)                             ' Play music

Do
	If GetKey = 27 Then
		Exit Do                                ' ESC-Key
	End If

	BASS_ChannelPlay(soundchannel, 0)              ' Play soundeffects
Loop

BASS_Free()                                            ' Free allocated memory
