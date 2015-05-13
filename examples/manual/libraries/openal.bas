'' examples/manual/libraries/openal.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ExtLibal
'' --------

'' OpenAL-based .wav player example

#include "AL/al.bi"
#include "AL/alut.bi"

Const SOUND_FILE = "test.wav"

'' Initialize OpenAL
alutInit(0, 0)

''
'' Load the .wav into an OpenAL buffer
''
Dim As ALuint buffer
alGenBuffers(1, @buffer)

Dim As ALenum wavFormat
Dim As ALsizei wavSize
Dim As ALsizei wavFreq
Dim As Any Ptr wavData
Dim As ALboolean wavLoop
alutLoadWAVFile(SOUND_FILE, @wavFormat, @wavData, @wavSize, @wavFreq, @wavLoop)
alBufferData(buffer, wavFormat, wavData, wavSize, wavFreq)
alutUnloadWAV(wavFormat, wavData, wavSize, wavFreq)

If (alGetError() <> AL_NO_ERROR) Then
	Print "Error: Loading the .wav failed!"
End If

''
'' Setup sound sources -- each one can have a 3D position & velocity.
''
Dim As ALuint source
alGenSources(1, @source)

Dim As ALfloat SourcePos(0 To 2) = {0.0, 0.0, 0.0}
Dim As ALfloat SourceVel(0 To 2) = {0.0, 0.0, 0.0}

alSourcei(source, AL_BUFFER, buffer)
alSourcef(source, AL_PITCH, 1.0)
alSourcef(source, AL_GAIN, 1.0)
alSourcefv(source, AL_POSITION, @SourcePos(0))
alSourcefv(source, AL_VELOCITY, @SourceVel(0))

''
'' Setup the listener's 3D position etc.
''
Dim As ALfloat listener_position(0 To 2) = {0.0, 0.0, 0.0}
Dim As ALfloat listener_velocity(0 To 2) = {0.0, 0.0, 0.0}
Dim As ALfloat listener_orientation(0 To 5) = {0.0, 0.0, -1.0, _ '' look at
	                                           0.0, 0.0, 1.0}    '' up vector
alListenerfv(AL_POSITION, @listener_position(0))
alListenerfv(AL_VELOCITY, @listener_velocity(0))
alListenerfv(AL_ORIENTATION, @listener_orientation(0))

''
'' Play the sound (change to AL_FALSE to disable looping)
''
alSourcei(source, AL_LOOPING, AL_TRUE)
alSourcePlay(source)

Print "Sound is playing, press ESC to exit and anything else to pause..."
Dim As String key
Dim As Integer active = -1
Do
	key = Inkey()
	If (Len(key) > 0) Then
		If (key = Chr(27)) Then
			Exit Do
		End If

		If (active) Then
			alSourcePause(source)
			active = 0
		Else
			alSourcePlay(source)
			active = -1
		End If
	End If
Loop

alSourceStop(source)

''
'' Clean up
''
alDeleteBuffers(1, @buffer)
alDeleteSources(1, @source)
alutExit()
