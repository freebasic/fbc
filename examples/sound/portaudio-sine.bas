''
'' PortAudio Sine wave example
''
'' Requires libportaudio2

#include "portaudio.bi"

Const Pi as Double = 3.14159265358979323846
Const SampleRate as Integer = 44100
Const SineSamples as Integer = SampleRate / 10

Type PlayPayload
    frequency As Single
End Type

Function PlayCallback cdecl (InputBuff as Const Any Ptr, OutputBuff as Any Ptr, _
                    FrameCount as CUlong, TimeInfo as Const PaStreamCallbackTimeInfo Ptr, _
                    StatusFlags as PaStreamCallbackFlags, UserData as Any ptr) as Long

    Dim as Long Ptr outBuff = OutputBuff
    Dim as PlayPayload Ptr payload = UserData
    Dim as Single frequency = payload->frequency
    For i as Integer = 0 To FrameCount - 1
        outBuff[i] = CLng(&h7FFFFFFF * 0.5 * Sin(2 * Pi * frequency * i / SampleRate))
    Next
    Function = paContinue
End Function

Sub Play(Frequency as Single, Duration as Single)
    Dim as PaError pe
    Dim as PaStream Ptr stream

    Dim as PlayPayload payload
    payload.frequency = Frequency

    pe = Pa_OpenDefaultStream(@stream, 0, 1, paInt32, SampleRate, SineSamples, @PlayCallback, @payload)
    If pe <> paNoError Then
        Print "Error: "; *Pa_GetErrorText(pe)
        End 1
    End If

    Print "Playing "; Frequency; "Hz for "; Duration; "ms"
    pe = Pa_StartStream(stream)
    If pe <> paNoError Then
        Print "Error: "; *Pa_GetErrorText(pe)
        End 1
    End If

    'Sleep 2
    Pa_Sleep(Duration)

    pe = Pa_StopStream(stream)
    If pe <> paNoError Then
        Print "Error: "; *Pa_GetErrorText(pe)
        End 1
    End If

    pe = Pa_CloseStream(stream)
    If pe <> paNoError Then
        Print "Error: "; *Pa_GetErrorText(pe)
        End 1
    End If
End Sub

Dim as PaError pe
Print "Initialize PortAudio ("; *Pa_GetVersionText(); ")"

pe = Pa_Initialize()
If pe <> paNoError Then
    Print "Error: "; *Pa_GetErrorText(pe)
    End 1
End If

Dim defdevice as Integer = Pa_GetDefaultOutputDevice()
If defdevice = paNoDevice Then
    Print "Error: no default output device"
    End 1
End If

Dim devinfo as const PaDeviceInfo Ptr = Pa_GetDeviceInfo(defdevice)
Dim apiinfo as const PaHostApiInfo Ptr = Pa_GetHostApiInfo(Pa_GetDefaultHostApi())
Print "Using "; *apiinfo->name; " api on default output device: "; *devinfo->name

'' Play from A4 (440Hz) for 440ms until A3 (220Hz) for 220ms
For i as Integer = 440 to 220 Step -110
    Play(i, i)
Next

Print "Shutdown PortAudio"
Pa_Terminate()

End 0
