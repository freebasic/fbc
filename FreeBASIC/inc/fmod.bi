'
' FMOD FB Module
'

' FB header converted from fmod.bas for VB by Plasma  [11-16-2004]
' Mostly untested, so don't be surprised if something doesn't work :P

'$inclib: "fmod"

Const FMOD_VERSION! = 3.74


' FMOD_ERRORS
' On failure of commands in FMOD, use FSOUND_GetError to attain what happened.
'
Enum FMOD_ERRORS
    FMOD_ERR_NONE             ' No errors
    FMOD_ERR_BUSY             ' Cannot call this command after FSOUND_Init.  Call FSOUND_Close first.
    FMOD_ERR_UNINITIALIZED    ' This command failed because FSOUND_Init was not called
    FMOD_ERR_INIT             ' Error initializing output device.
    FMOD_ERR_ALLOCATED        ' Error initializing output device, but more specifically, the output device is already in use and cannot be reused.
    FMOD_ERR_PLAY             ' Playing the sound failed.
    FMOD_ERR_OUTPUT_FORMAT    ' Soundcard does not support the features needed for this soundsystem (16bit stereo output)
    FMOD_ERR_COOPERATIVELEVEL ' Error setting cooperative level for hardware.
    FMOD_ERR_CREATEBUFFER     ' Error creating hardware sound buffer.
    FMOD_ERR_FILE_NOTFOUND    ' File not found
    FMOD_ERR_FILE_FORMAT      ' Unknown file format
    FMOD_ERR_FILE_BAD         ' Error loading file
    FMOD_ERR_MEMORY           ' Not enough memory
    FMOD_ERR_VERSION          ' The version number of this file format is not supported
    FMOD_ERR_INVALID_PARAM    ' An invalid parameter was passed to this function
    FMOD_ERR_NO_EAX           ' Tried to use an EAX command on a non EAX enabled channel or output.
    FMOD_ERR_CHANNEL_ALLOC    ' Failed to allocate a new channel
    FMOD_ERR_RECORD           ' Recording is not supported on this machine
    FMOD_ERR_MEDIAPLAYER      ' Windows Media Player not installed so cannot play wma or use internet streaming.
    FMOD_ERR_CDDEVICE         ' An error occured trying to open the specified CD device
End Enum


' FSOUND_OUTPUTTYPES
' These output types are used with FSOUND_SetOutput, to choose which output driver to use.
' FSOUND_OUTPUT_DSOUND will not support hardware 3d acceleration if the sound card driver
' does not support DirectX 6 Voice Manager Extensions.
' FSOUND_OUTPUT_WINMM is recommended for NT and CE.
'
Enum FSOUND_OUTPUTTYPES
    FSOUND_OUTPUT_NOSOUND   ' NoSound driver, all calls to this succeed but do nothing.
    FSOUND_OUTPUT_WINMM     ' Windows Multimedia driver.
    FSOUND_OUTPUT_DSOUND    ' DirectSound driver.  You need this to get EAX2 or EAX3 support, or FX api support.
    FSOUND_OUTPUT_A3D       ' A3D driver.

    FSOUND_OUTPUT_OSS       ' Linux/Unix OSS (Open Sound System) driver, i.e. the kernel sound drivers.
    FSOUND_OUTPUT_ESD       ' Linux/Unix ESD (Enlightment Sound Daemon) driver.
    FSOUND_OUTPUT_ALSA      ' Linux Alsa driver.

    FSOUND_OUTPUT_ASIO      ' Low latency ASIO driver
    FSOUND_OUTPUT_XBOX      ' Xbox driver
    FSOUND_OUTPUT_PS2       ' PlayStation 2 driver
    FSOUND_OUTPUT_MAC       ' Mac SoundMager driver
    FSOUND_OUTPUT_GC        ' Gamecube driver

    FSOUND_OUTPUT_NOSOUND_NONREALTIME  ' This is the same as nosound, but the sound generation is driven by FSOUND_Update
End Enum


' FSOUND_MIXERTYPES
' These mixer types are used with FSOUND_SetMixer, to choose which mixer to use, or to act
' upon for other reasons using FSOUND_GetMixer.
' It is not nescessary to set the mixer.  FMOD will autodetect the best mixer for you.
'
Enum FSOUND_MIXERTYPES
    FSOUND_MIXER_AUTODETECT         ' CE/PS2 Only - Non interpolating/low quality mixer
    FSOUND_MIXER_BLENDMODE          ' removed / obsolete.
    FSOUND_MIXER_MMXP5              ' removed / obsolete.
    FSOUND_MIXER_MMXP6              ' removed / obsolete.

    FSOUND_MIXER_QUALITY_AUTODETECT ' All platforms - Autodetect the fastest quality mixer based on your cpu.
    FSOUND_MIXER_QUALITY_FPU        ' Win32/Linux only - Interpolating/volume ramping FPU mixer.
    FSOUND_MIXER_QUALITY_MMXP5      ' Win32/Linux only - Interpolating/volume ramping FPU mixer.
    FSOUND_MIXER_QUALITY_MMXP6      ' Win32/Linux only - Interpolating/volume ramping ppro+ MMX mixer.
    
    FSOUND_MIXER_MONO               ' CE/PS2 only - MONO non interpolating/low quality mixer. For speed
    FSOUND_MIXER_QUALITY_MONO       ' CE/PS2 only - MONO Interpolating mixer.  For speed
End Enum


' FMUSIC_TYPES
' These definitions describe the type of song being played.
' See FMUSIC_GetType
'
Enum FMUSIC_TYPES
    FMUSIC_TYPE_NONE
    FMUSIC_TYPE_MOD         'Protracker / Fasttracker
    FMUSIC_TYPE_S3M         'ScreamTracker 3
    FMUSIC_TYPE_XM          'FastTracker 2
    FMUSIC_TYPE_IT          'Impulse Tracker.
    FMUSIC_TYPE_MIDI        'MIDI file
    FMUSIC_TYPE_FSB         'FMOD Sample Bank file
End Enum


' FSOUND_DSP_PRIORITIES
' These default priorities are used by FMOD internal system DSP units.  They describe the
' position of the DSP chain, and the order of how audio processing is executed.
' You can actually through the use of FSOUND_DSP_GetxxxUnit (where xxx is the name of the DSP
' unit), disable or even change the priority of a DSP unit.
'
Enum FSOUND_DSP_PRIORITIES
    FSOUND_DSP_DEFAULTPRIORITY_CLEARUNIT = 0           'DSP CLEAR unit - done first
    FSOUND_DSP_DEFAULTPRIORITY_SFXUNIT = 100           'DSP SFX unit - done second
    FSOUND_DSP_DEFAULTPRIORITY_MUSICUNIT = 200         'DSP MUSIC unit - done third
    FSOUND_DSP_DEFAULTPRIORITY_USER = 300              'User priority, use this as reference for your own dsp units
    FSOUND_DSP_DEFAULTPRIORITY_FFTUNIT = 900           'This reads data for FSOUND_DSP_GetSpectrum, so it comes after user units
    FSOUND_DSP_DEFAULTPRIORITY_CLIPANDCOPYUNIT = 1000  'DSP CLIP AND COPY unit - last
End Enum


' FSOUND_CAPS
' Driver description bitfields.  Use FSOUND_Driver_GetCaps to determine if a driver enumerated
' has the settings you are after.  The enumerated driver depends on the output mode, see
' FSOUND_OUTPUTTYPES
'
Enum FSOUND_CAPS
    FSOUND_CAPS_HARDWARE = &H1       ' This driver supports hardware accelerated 3d sound.
    FSOUND_CAPS_EAX2 = &H2           ' This driver supports EAX 2 reverb
    FSOUND_CAPS_EAX3 = &H10          ' This driver supports EAX 3 reverb
End Enum


' FSOUND_MODES
' Sample description bitfields, OR them together for loading and describing samples.
' NOTE.  If the file format being loaded already has a defined format, such as WAV or MP3, then
' trying to override the pre-defined format with a new set of format flags will not work.  For
' example, an 8 bit WAV file will not load as 16bit if you specify FSOUND_16BITS.  It will just
' ignore the flag and go ahead loading it as 8bits.  For these type of formats the only flags
' you can specify that will really alter the behaviour of how it is loaded, are the following.
'
' Looping behaviour - FSOUND_LOOP_OFF, FSOUND_LOOP_NORMAL, FSOUND_LOOP_BIDI 
' Load destination - FSOUND_HW3D, FSOUND_HW2D, FSOUND_2D
' Loading behaviour - FSOUND_NONBLOCKING, FSOUND_LOADMEMORY, FSOUND_LOADRAW, FSOUND_MPEGACCURATE, FSOUND_MPEGHALFRATE, FSOUND_FORCEMONO
' Playback behaviour - FSOUND_STREAMABLE, FSOUND_ENABLEFX
' PlayStation 2 only - FSOUND_USECORE0, FSOUND_USECORE1, FSOUND_LOADMEMORYIOP    
'
' See flag descriptions for what these do.
'
Enum FSOUND_MODES
    FSOUND_LOOP_OFF = &H1             ' For non looping samples.
    FSOUND_LOOP_NORMAL = &H2          ' For forward looping samples.
    FSOUND_LOOP_BIDI = &H4            ' For bidirectional looping samples.  (no effect if in hardware).
    FSOUND_8BITS = &H8                ' For 8 bit samples.
    FSOUND_16BITS = &H10              ' For 16 bit samples.
    FSOUND_MONO = &H20                ' For mono samples.
    FSOUND_STEREO = &H40              ' For stereo samples.
    FSOUND_UNSIGNED = &H80            ' For source data containing unsigned samples.
    FSOUND_SIGNED = &H100             ' For source data containing signed data.
    FSOUND_DELTA = &H200              ' For source data stored as delta values.
    FSOUND_IT214 = &H400              ' For source data stored using IT214 compression.
    FSOUND_IT215 = &H800              ' For source data stored using IT215 compression.
    FSOUND_HW3D = &H1000              ' Attempts to make samples use 3d hardware acceleration. (if the card supports it)
    FSOUND_2D = &H2000                ' Ignores any 3d processing.  overrides FSOUND_HW3D.  Located in software.
    FSOUND_STREAMABLE = &H4000        ' For realtime streamable samples.  If you dont supply this sound may come out corrupted.
    FSOUND_LOADMEMORY = &H8000        ' For FSOUND_Sample_Load - name will be interpreted as a pointer to data
    FSOUND_LOADRAW = &H10000          ' For FSOUND_Sample_Load/FSOUND_Stream_Open - will ignore file format and treat as raw pcm.
    FSOUND_MPEGACCURATE = &H20000     ' For FSOUND_Stream_Open - scans MP2/MP3 (VBR also) for accurate FSOUND_Stream_GetLengthMs/FSOUND_Stream_SetTime.
    FSOUND_FORCEMONO = &H40000        ' For forcing stereo streams and samples to be mono - needed with FSOUND_HW3D - incurs speed hit
    FSOUND_HW2D = &H80000             ' 2d hardware sounds.  allows hardware specific effects
    FSOUND_ENABLEFX = &H100000        ' Allows DX8 FX to be played back on a sound.  Requires DirectX 8 - Note these sounds cant be played more than once, or have a changing frequency
    FSOUND_MPEGHALFRATE = &H200000    ' For FMODCE only - decodes mpeg streams using a lower quality decode, but faster execution
    FSOUND_XADPCM = &H400000          ' For XBOX only - Describes a user sample that its contents are compressed as XADPCM
    FSOUND_VAG = &H800000             ' For PS2 only - Describes a user sample that its contents are compressed as Sony VAG format.
    FSOUND_NONBLOCKING = &H1000000    ' For FSOUND_Stream_Open - Causes stream to open in the background and not block the foreground app - stream plays only when ready.
    FSOUND_GCADPCM = &H2000000        ' For Gamecube only - Contents are compressed as Gamecube DSP-ADPCM format
    FSOUND_MULTICHANNEL = &H4000000   ' For PS2 only - Contents are interleaved into a multi-channel (more than stereo) format
    FSOUND_USECORE0 = &H8000000       ' For PS2 only - Sample/Stream is forced to use hardware voices 00-23
    FSOUND_USECORE1 = &H10000000      ' For PS2 only - Sample/Stream is forced to use hardware voices 24-47
    FSOUND_LOADMEMORYIOP = &H20000000 ' For PS2 only - "name" will be interpreted as a pointer to data for streaming and samples.  The address provided will be an IOP address
    FSOUND_STREAM_NET = &H80000000    ' Specifies an internet stream
    
    FSOUND_NORMAL = FSOUND_16BITS Or FSOUND_SIGNED Or FSOUND_MONO
End Enum


' FSOUND_CDPLAYMODES
' Playback method for a CD Audio track, with FSOUND_CD_SetPlayMode
'
Enum FSOUND_CDPLAYMODES
    FSOUND_CD_PLAYCONTINUOUS         'Starts from the current track and plays to end of CD.
    FSOUND_CD_PLAYONCE               'Plays the specified track then stops.
    FSOUND_CD_PLAYLOOPED             'Plays the specified track looped, forever until stopped manually.
    FSOUND_CD_PLAYRANDOM             'Plays tracks in random order
End Enum


' FSOUND_CHANNELSAMPLEMODE
' Miscellaneous values for FMOD functions.
' FSOUND_PlaySound, FSOUND_PlaySoundEx, FSOUND_Sample_Alloc, FSOUND_Sample_Load, FSOUND_SetPan
'
Enum FSOUND_CHANNELSAMPLEMODE
    FSOUND_FREE = -1                 ' definition for dynamically allocated channel or sample
    FSOUND_UNMANAGED = -2            ' definition for allocating a sample that is NOT managed by fsound
    FSOUND_ALL = -3                  ' for a channel index or sample index, this flag affects ALL channels or samples available!  Not supported by all functions.
    FSOUND_STEREOPAN = -1            ' definition for full middle stereo volume on both channels
    FSOUND_SYSTEMCHANNEL = -1000     ' special channel ID for channel based functions that want to alter the global FSOUND software mixing output channel
    FSOUND_SYSTEMSAMPLE = -1000      ' special sample ID for all sample based functions that want to alter the global FSOUND software mixing output sample
End Enum


' FSOUND_REVERB_PROPERTIES
' FSOUND_Reverb_SetProperties, FSOUND_Reverb_GetProperties, FSOUND_REVERB_PROPERTYFLAGS
'
Type FSOUND_REVERB_PROPERTIES
                                    ' MIN     MAX    DEFAULT DESCRIPTION
    Environment         As Integer     ' 0       25     0       sets all listener properties
    EnvSize             As Single   ' 1.0     100.0  7.5     environment size in meters
    EnvDiffusion        As Single   ' 0.0     1.0    1.0     environment diffusion
    Room                As Integer     ' -10000  0      -1000   room effect level (at mid frequencies)
    RoomHF              As Integer     ' -10000  0      -100    relative room effect level at high frequencies
    RoomLF              As Integer     ' -10000  0      0       relative room effect level at low frequencies
    DecayTime           As Single   ' 0.1     20.0   1.49    reverberation decay time at mid frequencies
    DecayHFRatio        As Single   ' 0.1     2.0    0.83    high-frequency to mid-frequency decay time ratio
    DecayLFRatio        As Single   ' 0.1     2.0    1.0     low-frequency to mid-frequency decay time ratio
    Reflections         As Integer     ' -10000  1000   -2602   early reflections level relative to room effect
    ReflectionsDelay    As Single   ' 0.0     0.3    0.007   initial reflection delay time
    ReflectionsPan(3)   As Single   '                0,0,0   early reflections panning vector
    Reverb              As Integer     ' -1000   2000   200     late reverberation level relative to room effect
    ReverbDelay         As Single   ' 0.0     0.1    0.011   late reverberation delay time relative to initial reflection
    ReverbPan(3)        As Single   '                0,0,0   late reverberation panning vector
    EchoTime            As Single   ' .075    0.25   0.25    echo time
    EchoDepth           As Single   ' 0.0     1.0    0.0     echo depth
    ModulationTime      As Single   ' 0.04    4.0    0.25    modulation time
    ModulationDepth     As Single   ' 0.0     1.0    0.0     modulation depth
    AirAbsorptionHF     As Single   ' -100    0.0    -5.0    change in level per meter at high frequencies
    HFReference         As Single   ' 1000.0  20000  5000.0  reference high frequency (hz)
    LFReference         As Single   ' 20.0    1000.0 250.0   reference low frequency (hz)
    RoomRolloffFactor   As Single   ' 0.0     10.0   0.0     like FSOUND_3D_SetRolloffFactor but for room effect
    Diffusion           As Single   ' 0.0     100.0  100.0   Value that controls the echo density in the late reverberation decay. (xbox only)
    Density             As Single   ' 0.0     100.0  100.0   Value that controls the modal density in the late reverberation decay (xbox only)
    flags               As Integer     '                        modifies the behavior of above properties
End Type


' FSOUND_REVERB_FLAGS
' Values for the Flags member of the FSOUND_REVERB_PROPERTIES structure.
'
Enum FSOUND_REVERB_PROPERTYFLAGS
    FSOUND_REVERBFLAGS_DECAYTIMESCALE = &H1          ' EnvironmentSize affects reverberation decay time
    FSOUND_REVERBFLAGS_REFLECTIONSSCALE = &H2        ' EnvironmentSize affects reflection level
    FSOUND_REVERBFLAGS_REFLECTIONSDELAYSCALE = &H4   ' EnvironmentSize affects initial reflection delay time
    FSOUND_REVERBFLAGS_REVERBSCALE = &H8             ' EnvironmentSize affects reflections level
    FSOUND_REVERBFLAGS_REVERBDELAYSCALE = &H10       ' EnvironmentSize affects late reverberation delay time
    FSOUND_REVERBFLAGS_DECAYHFLIMIT = &H20           ' AirAbsorptionHF affects DecayHFRatio
    FSOUND_REVERBFLAGS_ECHOTIMESCALE = &H40          ' EnvironmentSize affects echo time
    FSOUND_REVERBFLAGS_MODULATIONTIMESCALE = &H80    ' EnvironmentSize affects modulation time
    FSOUND_REVERB_FLAGS_CORE0 = &H100                ' PS2 Only - Reverb is applied to CORE0 (hw voices 0-23)
    FSOUND_REVERB_FLAGS_CORE1 = &H200                ' PS2 Only - Reverb is applied to CORE1 (hw voices 24-47)
    FSOUND_REVERBFLAGS_DEFAULT = FSOUND_REVERBFLAGS_DECAYTIMESCALE Or FSOUND_REVERBFLAGS_REFLECTIONSSCALE Or FSOUND_REVERBFLAGS_REFLECTIONSDELAYSCALE Or FSOUND_REVERBFLAGS_REVERBSCALE Or FSOUND_REVERBFLAGS_REVERBDELAYSCALE Or FSOUND_REVERBFLAGS_DECAYHFLIMIT Or FSOUND_REVERB_FLAGS_CORE0 Or FSOUND_REVERB_FLAGS_CORE1
End Enum


' FSOUND_REVERB_CHANNELPROPERTIES
' Structure defining the properties for a reverb source, related to a FSOUND channel.
' FSOUND_Reverb_SetEnvironment, FSOUND_Reverb_SetEnvironmentAdvanced
'
Type FSOUND_REVERB_CHANNELPROPERTIES
    Direct               As Integer     ' direct path level (at low and mid frequencies)
    DirectHF             As Integer     ' relative direct path level at high frequencies
    Room                 As Integer     ' room effect level (at low and mid frequencies)
    RoomHF               As Integer     ' relative room effect level at high frequencies
    Obstruction          As Integer     ' main obstruction control (attenuation at high frequencies)
    ObstructionLFRatio   As Single   ' obstruction low-frequency level re. main control
    Occlusion            As Integer     ' main occlusion control (attenuation at high frequencies)
    OcclustionLFRatio    As Single   ' occlusion low-frequency level re. main control
    OcclusionRoomRatio   As Single   ' relative occlusion control for room effect
    OcclusionDirectRatio As Single   ' relative occlusion control for direct path
    Exclusion            As Integer     ' main exlusion control (attenuation at high frequencies)
    ExclusionLFRatio     As Single   ' exclusion low-frequency level re. main control
    OutsideVolumeHF      As Integer     ' outside sound cone level at high frequencies
    DopplerFactor        As Single   ' like DS3D flDopplerFactor but per source
    RolloffFactor        As Single   ' like DS3D flRolloffFactor but per source
    RoomRolloffFactor    As Single   ' like DS3D flRolloffFactor but for room effect
    AirAbsorptionFactor  As Single   ' multiplies AirAbsorptionHF member of FSOUND_REVERB_PROPERTIES
    flags                As Integer     ' modifies the behavior of properties
End Type


' FSOUND_REVERB_CHANNELFLAGS
' Values for the Flags member of the FSOUND_REVERB_CHANNELPROPERTIES structure.
'
Enum FSOUND_REVERB_CHANNELFLAGS
    FSOUND_REVERB_CHANNELFLAGS_DIRECTHFAUTO = &H1   ' Automatic setting of Direct due to distance from listener
    FSOUND_REVERB_CHANNELFLAGS_ROOMAUTO = &H2       ' Automatic setting of Room due to distance from listener
    FSOUND_REVERB_CHANNELFLAGS_ROOMHFAUTO = &H4     ' Automatic setting of RoomHF due to distance from listener
    FSOUND_REVERB_CHANNELFLAGS_DEFAULT = FSOUND_REVERB_CHANNELFLAGS_DIRECTHFAUTO Or FSOUND_REVERB_CHANNELFLAGS_ROOMAUTO Or FSOUND_REVERB_CHANNELFLAGS_ROOMHFAUTO
End Enum


' FSOUND_FX_MODES
' These values are used with FSOUND_FX_Enable to enable DirectX 8 FX for a channel.
'
Enum FSOUND_FX_MODES
    FSOUND_FX_CHORUS
    FSOUND_FX_COMPRESSOR
    FSOUND_FX_DISTORTION
    FSOUND_FX_ECHO
    FSOUND_FX_FLANGER
    FSOUND_FX_GARGLE
    FSOUND_FX_I3DL2REVERB
    FSOUND_FX_PARAMEQ
    FSOUND_FX_WAVES_REVERB
End Enum


'FSOUND_SPEAKERMODES
'These are speaker types defined for use with the FSOUND_SetSpeakerMode command.
'Note - Only reliably works with FSOUND_OUTPUT_DSOUND or FSOUND_OUTPUT_XBOX output modes.  Other output modes will only
'interpret FSOUND_SPEAKERMODE_MONO and set everything else to be stereo.
'Using either DolbyDigital or DTS will use whatever 5.1 digital mode is available if destination hardware is unsure.
'
Enum FSOUND_SPEAKERMODES
    FSOUND_SPEAKERMODE_DOLBYDIGITAL  ' The audio is played through a speaker arrangement of surround speakers with a subwoofer.
    FSOUND_SPEAKERMODE_HEADPHONE     ' The speakers are headphones.
    FSOUND_SPEAKERMODE_MONO          ' The speakers are monaural.
    FSOUND_SPEAKERMODE_QUAD          ' The speakers are quadraphonic.
    FSOUND_SPEAKERMODE_STEREO        ' The speakers are stereo (default value).
    FSOUND_SPEAKERMODE_SURROUND      ' The speakers are surround sound.
    FSOUND_SPEAKERMODE_DTS           ' The audio is played through a speaker arrangement of surround speakers with a subwoofer.
    FSOUND_SPEAKERMODE_PROLOGIC2     ' Dolby Prologic 2.  Playstation 2 and Gamecube only
End Enum


' FSOUND_INIT_FLAGS
' Initialization flags.  Use them with FSOUND_Init in the flags parameter to change various behaviour.
' FSOUND_INIT_ENABLESYSTEMCHANNELFX Is an init mode which enables the FSOUND mixer buffer to be affected by DirectX 8 effects.
' Note that due to limitations of DirectSound, FSOUND_Init may fail if this is enabled because the buffersize is too small.
' This can be fixed with FSOUND_SetBufferSize.  Increase the BufferSize until it works.
' When it is enabled you can use the FSOUND_FX api, and use FSOUND_SYSTEMCHANNEL as the channel id when setting parameters.
'
Enum FSOUND_INITMODES
    FSOUND_INIT_USEDEFAULTMIDISYNTH = &H1       'Causes MIDI playback to force software decoding.
    FSOUND_INIT_GLOBALFOCUS = &H2               'For DirectSound output - sound is not muted when window is out of focus.
    FSOUND_INIT_ENABLESYSTEMCHANNELFX = &H4     'For DirectSound output - Allows FSOUND_FX api to be used on global software mixer output!
    FSOUND_INIT_ACCURATEVULEVELS = &H8          'This latency adjusts FSOUND_GetCurrentLevels, but incurs a small cpu and memory hit
    FSOUND_INIT_PS2_DISABLECORE0REVERB = &H10   'PS2 only - Disable reverb on CORE 0 to regain SRAM
    FSOUND_INIT_PS2_DISABLECORE1REVERB = &H20   'PS2 only - Disable reverb on CORE 1 to regain SRAM
    FSOUND_INIT_PS2_SWAPDMACORES = &H40         'PS2 only - By default FMOD uses DMA CH0 for mixing, CH1 for uploads, this flag swaps them around
    FSOUND_INIT_DONTLATENCYADJUST = &H80        'Callbacks are not latency adjusted, and are called at mix time.  Also information functions are immediate
    FSOUND_INIT_GC_INITLIBS = &H100             'Gamecube only - Initializes GC audio libraries
    FSOUND_INIT_STREAM_FROM_MAIN_THREAD = &H200 'Turns off fmod streamer thread, and makes streaming update from FSOUND_Update called by the user
End Enum


' FSOUND_STREAM_NET_STATUS
' Status values for internet streams. Use FSOUND_Stream_Net_GetStatus to get the current status of an internet stream.
'
Enum FSOUND_STREAM_NET_STATUS
    FSOUND_STREAM_NET_NOTCONNECTED         ' Stream hasn't connected yet
    FSOUND_STREAM_NET_CONNECTING           ' Stream is connecting to remote host
    FSOUND_STREAM_NET_BUFFERING            ' Stream is buffering data
    FSOUND_STREAM_NET_READY                ' Stream is ready to play
    FSOUND_STREAM_NET_ERROR                ' Stream has suffered a fatal error
End Enum


' FSOUND_TAGFIELD_TYPE
' Describes the type of a particular tag field.
' See FSOUND_Stream_GetNumTagFields, FSOUND_Stream_GetTagField, FSOUND_Stream_FindTagField
'
Enum FSOUND_TAGFIELD_TYPE
    FSOUND_TAGFIELD_VORBISCOMMENT = 0     ' A vorbis comment
    FSOUND_TAGFIELD_ID3V1                 ' Part of an ID3v1 tag
    FSOUND_TAGFIELD_ID3V2                 ' An ID3v2 frame
    FSOUND_TAGFIELD_SHOUTCAST             ' A SHOUTcast header line
    FSOUND_TAGFIELD_ICECAST               ' An Icecast header line
    FSOUND_TAGFIELD_ASF                   ' An Advanced Streaming Format header line
End Enum


' FSOUND_STATUS_FLAGS
' These values describe the protocol and format of an internet stream. Use FSOUND_Stream_Net_GetStatus to retrieve this information for an open internet stream.
'
Enum FSOUND_STATUS_FLAGS
    FSOUND_PROTOCOL_SHOUTCAST = &H1
    FSOUND_PROTOCOL_ICECAST = &H2
    FSOUND_PROTOCOL_HTTP = &H4
    FSOUND_FORMAT_MPEG = &H10000
    FSOUND_FORMAT_OGGVORBIS = &H20000
End Enum

' FSOUND_TOC_TAG
' FSOUND_Stream_Open, FSOUND_Stream_FindTagField
'
Type FSOUND_TOC_TAG
    TagName(3)      As Byte         ' The string "TOC" (4th character is 0), just in case this structure is accidentally treated as a string.
    NumTracks       As Integer         ' The number of tracks on the CD.
    Min(99)         As Integer         ' The start offset of each track in minutes.
    Sec(99)         As Integer         ' The start offset of each track in seconds.
    Frame(99)       As Integer         ' The start offset of each track in frames.
End Type


'/* ================================== */
'/* Initialization / Global functions. */
'/* ================================== */


' PRE - FSOUND_Init functions. These cant be called after FSOUND_Init is
' called (they will fail). They set up FMOD system functionality.


Declare Function FSOUND_SetOutput Alias "FSOUND_SetOutput" (ByVal outputtype As FSOUND_OUTPUTTYPES) As Byte
Declare Function FSOUND_SetDriver Alias "FSOUND_SetDriver" (ByVal driver As Integer) As Byte
Declare Function FSOUND_SetMixer Alias "FSOUND_SetMixer" (ByVal mixer As FSOUND_MIXERTYPES) As Byte
Declare Function FSOUND_SetBufferSize Alias "FSOUND_SetBufferSize" (ByVal lenms As Integer) As Byte
Declare Function FSOUND_SetHWND Alias "FSOUND_SetHWND" (ByVal hwnd As Integer) As Byte
Declare Function FSOUND_SetMinHardwareChannels Alias "FSOUND_SetMinHardwareChannels" (ByVal min As short) As Byte
Declare Function FSOUND_SetMaxHardwareChannels Alias "FSOUND_SetMaxHardwareChannels" (ByVal min As short) As Byte
Declare Function FSOUND_SetMemorySystem Alias "FSOUND_SetMemorySystem" (ByVal pool As Integer, ByVal poollen As Integer, ByVal useralloc As Integer, ByVal userrealloc As Integer, ByVal userfree As Integer) As Byte

'
'   Main initialization / closedown functions.
'   Note : Use FSOUND_INIT_USEDEFAULTMIDISYNTH with FSOUND_Init for software override
'          with MIDI playback.
'        : Use FSOUND_INIT_GLOBALFOCUS with FSOUND_Init to make sound audible no matter
'          which window is in focus. (FSOUND_OUTPUT_DSOUND only)
'

Declare Function FSOUND_Init Alias "FSOUND_Init" (ByVal mixrate As Integer, ByVal maxchannels As Integer, ByVal flags As FSOUND_INITMODES) As Byte
Declare Function FSOUND_Close Alias "FSOUND_Close" () As Integer

'
'   Runtime system level functions
'

Declare Function FSOUND_Update Alias "FSOUND_Update" () As Integer

Declare Function FSOUND_SetSpeakerMode Alias "FSOUND_SetSpeakerMode" (ByVal speakermode As FSOUND_SPEAKERMODES) As Integer
Declare Function FSOUND_SetSFXMasterVolume Alias "FSOUND_SetSFXMasterVolume" (ByVal volume As Integer) As Integer
Declare Function FSOUND_SetPanSeperation Alias "FSOUND_SetPanSeperation" (ByVal pansep As Single) As Integer
Declare Function FSOUND_File_SetCallbacks Alias "FSOUND_File_SetCallbacks" (ByVal OpenCallback As Integer, ByVal CloseCallback As Integer, ByVal ReadCallback As Integer, ByVal SeekCallback As Integer, ByVal TellCallback As Integer) As Integer

'
' System information functions.
'

Declare Function FSOUND_GetError Alias "FSOUND_GetError" () As FMOD_ERRORS
Declare Function FSOUND_GetVersion Alias "FSOUND_GetVersion" () As Single
Declare Function FSOUND_GetOutput Alias "FSOUND_GetOutput" () As FSOUND_OUTPUTTYPES
Declare Function FSOUND_GetOutputHandle Alias "FSOUND_GetOutputHandle" () As Integer
Declare Function FSOUND_GetDriver Alias "FSOUND_GetDriver" () as zstring ptr
Declare Function FSOUND_GetMixer Alias "FSOUND_GetMixer" () As FSOUND_MIXERTYPES
Declare Function FSOUND_GetNumDrivers Alias "FSOUND_GetNumDrivers" () As Integer
Declare Function FSOUND_GetDriverName Alias "FSOUND_GetDriverName" (ByVal id As Integer) As Integer
Declare Function FSOUND_GetDriverCaps Alias "FSOUND_GetDriverCaps" (ByVal id As Integer, Byval caps As Integer ptr) As Byte
Declare Function FSOUND_GetOutputRate Alias "FSOUND_GetOutputRate" () As Integer
Declare Function FSOUND_GetMaxChannels Alias "FSOUND_GetMaxChannels" () As Integer
Declare Function FSOUND_GetMaxSamples Alias "FSOUND_GetMaxSamples" () As Integer
Declare Function FSOUND_GetSFXMasterVolume Alias "FSOUND_GetSFXMasterVolume" () As Integer
Declare Function FSOUND_GetNumHWChannels Alias "FSOUND_GetNumHWChannels" (Byval num2d As Integer ptr, Byval num3d As Integer ptr, Byval total As Integer ptr)
Declare Function FSOUND_GetChannelsPlaying Alias "FSOUND_GetChannelsPlaying" () As Integer
Declare Function FSOUND_GetCPUUsage Alias "FSOUND_GetCPUUsage" () As Single
Declare Sub FSOUND_GetMemoryStats Alias "FSOUND_GetMemoryStats" (Byval currentalloced As Integer ptr, Byval maxalloced As Integer ptr)

'/* =================================== */
'/* Sample management / load functions. */
'/* =================================== */


'   Sample creation and management functions
'   Note : Use FSOUND_LOADMEMORY   flag with FSOUND_Sample_Load to load from memory.
'          Use FSOUND_LOADRAW      flag with FSOUND_Sample_Load to treat as as raw pcm data.


Declare Function FSOUND_Sample_Load Alias "FSOUND_Sample_Load" (ByVal index As Integer, ByVal name As String, ByVal mode As FSOUND_MODES, ByVal offset As Integer, ByVal length As Integer) As Integer
Declare Function FSOUND_Sample_Alloc Alias "FSOUND_Sample_Alloc" (ByVal index As Integer, ByVal length As Integer, ByVal mode As Integer, ByVal deffreq As Integer, ByVal defvol As Integer, ByVal defpan As Integer, ByVal defpri As Integer) As Integer
Declare Function FSOUND_Sample_Free Alias "FSOUND_Sample_Free" (ByVal sptr As Integer) As Integer
Declare Function FSOUND_Sample_Upload Alias "FSOUND_Sample_Upload" (ByVal sptr As Integer, Byval srcdata As Integer ptr, ByVal mode As Integer) As Byte
Declare Function FSOUND_Sample_Lock Alias "FSOUND_Sample_Lock" (ByVal sptr As Integer, ByVal offset As Integer, ByVal length As Integer, Byval ptr1 As Integer ptr ptr, Byval ptr2 As Integer ptr ptr, Byval len1 As Integer ptr, Byval len2 As Integer ptr) As Byte
Declare Function FSOUND_Sample_Unlock Alias "FSOUND_Sample_Unlock" (ByVal sptr As Integer, ByVal sptr1 As Integer, ByVal sptr2 As Integer, ByVal len1 As Integer, ByVal len2 As Integer) As Byte


'   Sample control functions


Declare Function FSOUND_Sample_SetMode Alias "FSOUND_Sample_SetMode" (ByVal sptr As Integer, ByVal mode As FSOUND_MODES) As Byte
Declare Function FSOUND_Sample_SetLoopPoints Alias "FSOUND_Sample_SetLoopPoints" (ByVal sptr As Integer, ByVal loopstart As Integer, ByVal loopend As Integer) As Byte
Declare Function FSOUND_Sample_SetDefaults Alias "FSOUND_Sample_SetDefaults" (ByVal sptr As Integer, ByVal deffreq As Integer, ByVal defvol As Integer, ByVal defpan As Integer, ByVal defpri As Integer) As Byte
Declare Function FSOUND_Sample_SetDefaultsEx Alias "FSOUND_Sample_SetDefaultsEx" (ByVal sptr As Integer, ByVal deffreq As Integer, ByVal defvol As Integer, ByVal defpan As Integer, ByVal defpri As Integer, ByVal varfreq As Integer, ByVal varvol As Integer, ByVal varpan As Integer) As Byte
Declare Function FSOUND_Sample_SetMinMaxDistance Alias "FSOUND_Sample_SetMinMaxDistance" (ByVal sptr As Integer, ByVal min As Single, ByVal max As Single) As Byte
Declare Function FSOUND_Sample_SetMaxPlaybacks Alias "FSOUND_Sample_SetMaxPlaybacks" (ByVal sptr As Integer, ByVal max As Integer) As Byte


'   Sample information functions


Declare Function FSOUND_Sample_Get Alias "FSOUND_Sample_Get" (ByVal sampno As Integer) As Integer
Declare Function FSOUND_Sample_GetName Alias "FSOUND_Sample_GetName" (ByVal sptr As Integer) as zstring ptr
Declare Function FSOUND_Sample_GetLength Alias "FSOUND_Sample_GetLength" (ByVal sptr As Integer) As Integer
Declare Function FSOUND_Sample_GetLoopPoints Alias "FSOUND_Sample_GetLoopPoints" (ByVal sptr As Integer, Byval loopstart As Integer ptr, Byval loopend As Integer ptr) As Byte
Declare Function FSOUND_Sample_GetDefaults Alias "FSOUND_Sample_GetDefaults" (ByVal sptr As Integer, Byval deffreq As Integer ptr, Byval defvol As Integer ptr, Byval defpan As Integer ptr, Byval defpri As Integer ptr) As Byte
Declare Function FSOUND_Sample_GetDefaultsEx Alias "FSOUND_Sample_GetDefaultsEx" (ByVal sptr As Integer, Byval deffreq As Integer ptr, Byval defvol As Integer ptr, Byval defpan As Integer ptr, Byval defpri As Integer ptr, Byval varfreq As Integer ptr, Byval varvol As Integer ptr, Byval varpan As Integer ptr) As Byte
Declare Function FSOUND_Sample_GetMode Alias "FSOUND_Sample_GetMode" (ByVal sptr As Integer) As Integer
Declare Function FSOUND_Sample_GetMinMaxDistance Alias "FSOUND_Sample_GetMinMaxDistance" (ByVal sptr As Integer, Byval min As Single ptr, Byval max As Single ptr) As Byte

'/* ============================ */
'/* Channel control functions.   */
'/* ============================ */


'   Playing and stopping sounds.
'   Note : Use FSOUND_FREE as the channel variable, to let FMOD pick a free channel for you.
'          Use FSOUND_ALL as the channel variable to control ALL channels with one function call!


Declare Function FSOUND_PlaySound Alias "FSOUND_PlaySound" (ByVal channel As Integer, ByVal sptr As Integer) As Integer
Declare Function FSOUND_PlaySoundEx Alias "FSOUND_PlaySoundEx" (ByVal channel As Integer, ByVal sptr As Integer, ByVal dsp As Integer, ByVal startpaused As Byte) As Integer
Declare Function FSOUND_StopSound Alias "FSOUND_StopSound" (ByVal channel As Integer) As Byte


'   Functions to control playback of a channel.
'   Note : FSOUND_ALL can be used on most of these functions as a channel value.


Declare Function FSOUND_SetFrequency Alias "FSOUND_SetFrequency" (ByVal channel As Integer, ByVal freq As Integer) As Byte
Declare Function FSOUND_SetVolume Alias "FSOUND_SetVolume" (ByVal channel As Integer, ByVal Vol As Integer) As Byte
Declare Function FSOUND_SetVolumeAbsolute Alias "FSOUND_SetVolumeAbsolute" (ByVal channel As Integer, ByVal Vol As Integer) As Byte
Declare Function FSOUND_SetPan Alias "FSOUND_SetPan" (ByVal channel As Integer, ByVal pan As Integer) As Byte
Declare Function FSOUND_SetSurround Alias "FSOUND_SetSurround" (ByVal channel As Integer, ByVal surround As Integer) As Byte
Declare Function FSOUND_SetMute Alias "FSOUND_SetMute" (ByVal channel As Integer, ByVal mute As Byte) As Byte
Declare Function FSOUND_SetPriority Alias "FSOUND_SetPriority" (ByVal channel As Integer, ByVal Priority As Integer) As Byte
Declare Function FSOUND_SetReserved Alias "FSOUND_SetReserved" (ByVal channel As Integer, ByVal reserved As Integer) As Byte
Declare Function FSOUND_SetPaused Alias "FSOUND_SetPaused" (ByVal channel As Integer, ByVal Paused As Byte) As Byte
Declare Function FSOUND_SetLoopMode Alias "FSOUND_SetLoopMode" (ByVal channel As Integer, ByVal loopmode As Integer) As Byte
Declare Function FSOUND_SetCurrentPosition Alias "FSOUND_SetCurrentPosition" (ByVal channel As Integer, ByVal offset As Integer) As Byte
Declare Function FSOUND_3D_SetAttributes Alias "FSOUND_3D_SetAttributes" (ByVal channel As Integer, Byval Pos As Single ptr, Byval vel As Single ptr) As Byte
Declare Function FSOUND_3D_SetMinMaxDistance Alias "FSOUND_3D_SetMinMaxDistance" (ByVal channel As Integer, ByVal min As Single, ByVal max As Single) As Byte

'
'   Channel information functions.
'

Declare Function FSOUND_IsPlaying Alias "FSOUND_IsPlaying" (ByVal channel As Integer) As Byte
Declare Function FSOUND_GetFrequency Alias "FSOUND_GetFrequency" (ByVal channel As Integer) As Integer
Declare Function FSOUND_GetVolume Alias "FSOUND_GetVolume" (ByVal channel As Integer) As Integer
Declare Function FSOUND_GetAmplitude Alias "FSOUND_GetAmplitude" (ByVal channel As Integer) As Integer
Declare Function FSOUND_GetPan Alias "FSOUND_GetPan" (ByVal channel As Integer) As Integer
Declare Function FSOUND_GetSurround Alias "FSOUND_GetSurround" (ByVal channel As Integer) As Byte
Declare Function FSOUND_GetMute Alias "FSOUND_GetMute" (ByVal channel As Integer) As Byte
Declare Function FSOUND_GetPriority Alias "FSOUND_GetPriority" (ByVal channel As Integer) As Integer
Declare Function FSOUND_GetReserved Alias "FSOUND_GetReserved" (ByVal channel As Integer) As Byte
Declare Function FSOUND_GetPaused Alias "FSOUND_GetPaused" (ByVal channel As Integer) As Byte
Declare Function FSOUND_GetLoopMode Alias "FSOUND_GetLoopMode" (ByVal channel As Integer) As Integer
Declare Function FSOUND_GetCurrentPosition Alias "FSOUND_GetCurrentPosition" (ByVal channel As Integer) As Integer
Declare Function FSOUND_GetCurrentSample Alias "FSOUND_GetCurrentSample" (ByVal channel As Integer) As Integer
Declare Function FSOUND_GetCurrentLevels Alias "FSOUND_GetCurrentLevels" (ByVal channel As Integer, Byval l As Single ptr, Byval r As Single ptr) As Byte
Declare Function FSOUND_GetNumSubChannels Alias "FSOUND_GetNumSubChannels" (ByVal channel As Integer) As Integer
Declare Function FSOUND_GetSubChannel Alias "FSOUND_GetSubChannel" (ByVal channel As Integer, ByVal subchannel As Integer) As Integer
Declare Function FSOUND_3D_GetAttributes Alias "FSOUND_3D_GetAttributes" (ByVal channel As Integer, Byval Pos As Single ptr, Byval vel As Single ptr) As Byte
Declare Function FSOUND_3D_GetMinMaxDistance Alias "FSOUND_3D_GetMinMaxDistance" (ByVal channel As Integer, Byval min As Single ptr, Byval max As Single ptr) As Byte

'/* ========================== */
'/* Global 3D sound functions. */
'/* ========================== */

'    See also 3d sample and channel based functions above.
'    Call FSOUND_Update once a frame to process 3d information.

Declare Function FSOUND_3D_Listener_SetCurrent Alias "FSOUND_3D_Listener_SetCurrent" (ByVal current As Integer) As Integer
Declare Function FSOUND_3D_Listener_SetAttributes Alias "FSOUND_3D_Listener_SetAttributes" (ByVal Pos As Single, ByVal vel As Single, ByVal fx As Single, ByVal fy As Single, ByVal fz As Single, ByVal tx As Single, ByVal ty As Single, ByVal tz As Single) As Integer
Declare Function FSOUND_3D_Listener_GetAttributes Alias "FSOUND_3D_Listener_GetAttributes" (Byval Pos As Single ptr, Byval vel As Single ptr, Byval fx As Single ptr, Byval fy As Single ptr, Byval fz As Single ptr, Byval tx As Single ptr, Byval ty As Single ptr, Byval tz As Single ptr) As Integer
Declare Function FSOUND_3D_SetDopplerFactor Alias "FSOUND_3D_SetDopplerFactor" (ByVal fscale As Single) As Integer
Declare Function FSOUND_3D_SetDistanceFactor Alias "FSOUND_3D_SetDistanceFactor" (ByVal fscale As Single) As Integer
Declare Function FSOUND_3D_SetRolloffFactor Alias "FSOUND_3D_SetRolloffFactor" (ByVal fscale As Single) As Integer

'/* =================== */
'/* FX functions.       */
'/* =================== */

 
'   Functions to control DX8 only effects processing.
'
'   - FX enabled samples can only be played once at a time, not multiple times at once.
'   - Sounds have to be created with FSOUND_HW2D or FSOUND_HW3D for this to work.
'   - FSOUND_INIT_ENABLESYSTEMCHANNELFX can be used to apply hardware effect processing to the
'     global mixed output of FMOD's software channels.
'   - FSOUND_FX_Enable returns an FX handle that you can use to alter fx parameters.
'   - FSOUND_FX_Enable can be called multiple times in a row, even on the same FX type,
'     it will return a unique handle for each FX.
'   - FSOUND_FX_Enable cannot be called if the sound is playing or locked.
'   - FSOUND_FX_Disable must be called to reset/clear the FX from a channel.


Declare Function FSOUND_FX_Enable Alias "FSOUND_FX_Enable" (ByVal channel As Integer, ByVal fx As FSOUND_FX_MODES) As Integer
Declare Function FSOUND_FX_Disable Alias "FSOUND_FX_Disable" (ByVal channel As Integer) As Byte

Declare Function FSOUND_FX_SetChorus Alias "FSOUND_FX_SetChorus" (ByVal fxid As Integer, ByVal WetDryMix As Single, ByVal Depth As Single, ByVal Feedback As Single, ByVal Frequency As Single, ByVal Waveform As Integer, ByVal Delay As Single, ByVal Phase As Integer) As Byte
Declare Function FSOUND_FX_SetCompressor Alias "FSOUND_FX_SetCompressor" (ByVal fxid As Integer, ByVal Gain As Single, ByVal Attack As Single, ByVal Release As Single, ByVal Threshold As Single, ByVal Ratio As Single, ByVal Predelay As Single) As Byte
Declare Function FSOUND_FX_SetDistortion Alias "FSOUND_FX_SetDistortion" (ByVal fxid As Integer, ByVal Gain As Single, ByVal Edge As Single, ByVal PostEQCenterFrequency As Single, ByVal PostEQBandwidth As Single, ByVal PreLowpassCutoff As Single) As Byte
Declare Function FSOUND_FX_SetEcho Alias "FSOUND_FX_SetEcho" (ByVal fxid As Integer, ByVal WetDryMix As Single, ByVal Feedback As Single, ByVal LeftDelay As Single, ByVal RightDelay As Single, ByVal PanDelay As Integer) As Byte
Declare Function FSOUND_FX_SetFlanger Alias "FSOUND_FX_SetFlanger" (ByVal fxid As Integer, ByVal WetDryMix As Single, ByVal Depth As Single, ByVal Feedback As Single, ByVal Frequency As Single, ByVal Waveform As Integer, ByVal Delay As Single, ByVal Phase As Integer) As Byte
Declare Function FSOUND_FX_SetGargle Alias "FSOUND_FX_SetGargle" (ByVal fxid As Integer, ByVal RateHz As Integer, ByVal WaveShape As Integer) As Byte
Declare Function FSOUND_FX_SetI3DL2Reverb Alias "FSOUND_FX_SetI3DL2Reverb" (ByVal fxid As Integer, ByVal Room As Integer, ByVal RoomHF As Integer, ByVal RoomRolloffFactor As Single, ByVal DecayTime As Single, ByVal DecayHFRatio As Single, ByVal Reflections As Integer, ByVal ReflectionsDelay As Single, ByVal Reverb As Integer, ByVal ReverbDelay As Single, ByVal Diffusion As Single, ByVal Density As Single, ByVal HFReference As Single) As Byte
Declare Function FSOUND_FX_SetParamEQ Alias "FSOUND_FX_SetParamEQ" (ByVal fxid As Integer, ByVal Center As Single, ByVal Bandwidth As Single, ByVal Gain As Single) As Byte
Declare Function FSOUND_FX_SetWavesReverb Alias "FSOUND_FX_SetWavesReverb" (ByVal fxid As Integer, ByVal InGain As Single, ByVal ReverbMix As Single, ByVal ReverbTime As Single, ByVal HighFreqRTRatio As Single) As Byte

' ========================= */
' File Streaming functions. */
' ========================= */

'
'    Note : Use FSOUND_LOADMEMORY   flag with FSOUND_Stream_Open to stream from memory.
'           Use FSOUND_LOADRAW      flag with FSOUND_Stream_Open to treat stream as raw pcm data.
'           Use FSOUND_MPEGACCURATE flag with FSOUND_Stream_Open to open mpegs in 'accurate mode' for settime/gettime/getlengthms.
'           Use FSOUND_FREE as the 'channel' variable, to let FMOD pick a free channel for you.
'

Declare Function FSOUND_Stream_SetBufferSize Alias "FSOUND_Stream_SetBufferSize" (ByVal ms As Integer) As Byte

Declare Function FSOUND_Stream_Open Alias "FSOUND_Stream_Open" (ByVal filename As String, ByVal mode As FSOUND_MODES, ByVal offset As Integer, ByVal length As Integer) As Integer
Declare Function FSOUND_Stream_Open2 Alias "FSOUND_Stream_Open" (Byval fdata As Byte ptr, ByVal mode As FSOUND_MODES, ByVal offset As Integer, ByVal length As Integer) As Integer
Declare Function FSOUND_Stream_Create Alias "FSOUND_Stream_Create" (ByVal callback As Integer, ByVal length As Integer, ByVal mode As Integer, ByVal samplerate As Integer, ByVal userdata As Integer) As Integer
Declare Function FSOUND_Stream_Close Alias "FSOUND_Stream_Close" (ByVal stream As Integer) As Byte

Declare Function FSOUND_Stream_Play Alias "FSOUND_Stream_Play" (ByVal channel As Integer, ByVal stream As Integer) As Integer
Declare Function FSOUND_Stream_PlayEx Alias "FSOUND_Stream_PlayEx" (ByVal channel As Integer, ByVal stream As Integer, ByVal dsp As Integer, ByVal startpaused As Byte) As Integer
Declare Function FSOUND_Stream_Stop Alias "FSOUND_Stream_Stop" (ByVal stream As Integer) As Byte

Declare Function FSOUND_Stream_SetPosition Alias "FSOUND_Stream_SetPosition" (ByVal stream As Integer, ByVal positition As Integer) As Byte
Declare Function FSOUND_Stream_GetPosition Alias "FSOUND_Stream_GetPosition" (ByVal stream As Integer) As Integer
Declare Function FSOUND_Stream_SetTime Alias "FSOUND_Stream_SetTime" (ByVal stream As Integer, ByVal ms As Integer) As Byte
Declare Function FSOUND_Stream_GetTime Alias "FSOUND_Stream_GetTime" (ByVal stream As Integer) As Integer
Declare Function FSOUND_Stream_GetLength Alias "FSOUND_Stream_GetLength" (ByVal stream As Integer) As Integer
Declare Function FSOUND_Stream_GetLengthMs Alias "FSOUND_Stream_GetLengthMs" (ByVal stream As Integer) As Integer

Declare Function FSOUND_Stream_SetMode Alias "FSOUND_Stream_SetMode" (ByVal stream As Integer, ByVal mode As Integer) As Byte
Declare Function FSOUND_Stream_GetMode Alias "FSOUND_Stream_GetMode" (ByVal stream As Integer) As Integer
Declare Function FSOUND_Stream_SetLoopPoints Alias "FSOUND_Stream_SetLoopPoints" (ByVal stream As Integer, ByVal loopstartpcm As Integer, ByVal loopendpcm As Integer) As Byte
Declare Function FSOUND_Stream_SetLoopCount Alias "FSOUND_Stream_SetLoopCount" (ByVal stream As Integer, ByVal count As Integer) As Byte
Declare Function FSOUND_Stream_GetOpenState Alias "FSOUND_Stream_GetOpenState" (ByVal stream As Integer) As Integer
Declare Function FSOUND_Stream_GetSample Alias "FSOUND_Stream_GetSample" (ByVal stream As Integer) As Integer
Declare Function FSOUND_Stream_CreateDSP Alias "FSOUND_Stream_CreateDSP" (ByVal stream As Integer, ByVal callback As Integer, ByVal Priority As Integer, ByVal userdata As Integer) As Integer

Declare Function FSOUND_Stream_SetEndCallback Alias "FSOUND_Stream_SetEndCallback" (ByVal stream As Integer, ByVal callback As Integer, ByVal userdata As Integer) As Byte
Declare Function FSOUND_Stream_SetSyncCallback Alias "FSOUND_Stream_SetSyncCallback" (ByVal stream As Integer, ByVal callback As Integer, ByVal userdata As Integer) As Byte

Declare Function FSOUND_Stream_AddSyncPoint Alias "FSOUND_Stream_AddSyncPoint" (ByVal stream As Integer, ByVal pcmoffset As Integer, ByVal name As String) As Integer
Declare Function FSOUND_Stream_DeleteSyncPoint Alias "FSOUND_Stream_DeleteSyncPoint" (ByVal point As Integer) As Byte
Declare Function FSOUND_Stream_GetNumSyncPoints Alias "FSOUND_Stream_GetNumSyncPoints" (ByVal stream As Integer) As Integer
Declare Function FSOUND_Stream_GetSyncPoint Alias "FSOUND_Stream_GetSyncPoint" (ByVal stream As Integer, ByVal index As Integer) As Integer
Declare Function FSOUND_Stream_GetSyncPointInfo Alias "FSOUND_Stream_GetSyncPointInfo" (ByVal point As Integer, Byval pcmoffset As Integer ptr) as zstring ptr

Declare Function FSOUND_Stream_SetSubStream Alias "FSOUND_Stream_SetSubStream" (ByVal stream As Integer, ByVal index As Integer) As Byte
Declare Function FSOUND_Stream_GetNumSubStreams Alias "FSOUND_Stream_GetNumSubStreams" (ByVal stream As Integer) As Integer
Declare Function FSOUND_Stream_SetSubStreamSentence Alias "FSOUND_Stream_SetSubStreamSentence" (ByVal stream As Integer, Byval sentencelist As Integer ptr, ByVal numitems As Integer) As Byte

Declare Function FSOUND_Stream_GetNumTagFields Alias "FSOUND_Stream_GetNumTagFields" (ByVal stream As Integer, Byval num As Integer ptr) As Byte
Declare Function FSOUND_Stream_GetTagField Alias "FSOUND_Stream_GetTagField" (ByVal stream As Integer, ByVal num As Integer, Byval tagtype As Integer ptr, Byval name As byte ptr ptr, Byval value As byte ptr ptr, Byval length As Integer ptr) As Byte
Declare Function FSOUND_Stream_FindTagField Alias "FSOUND_Stream_FindTagField" (ByVal stream As Integer, ByVal tagtype As Integer, ByVal name As String, Byval value As any ptr ptr, Byval length As Integer ptr) As Byte

'
'   Internet streaming functions
'

Declare Function FSOUND_Stream_Net_SetProxy Alias "FSOUND_Stream_Net_SetProxy" (ByVal proxy As String) As Byte
Declare Function FSOUND_Stream_Net_GetLastServerStatus Alias "FSOUND_Stream_Net_GetLastServerStatus" () as zstring ptr
Declare Function FSOUND_Stream_Net_SetBufferProperties Alias "FSOUND_Stream_Net_SetBufferProperties" (ByVal buffersize As Integer, ByVal prebuffer_percent As Integer, ByVal rebuffer_percent As Integer) As Byte
Declare Function FSOUND_Stream_Net_GetBufferProperties Alias "FSOUND_Stream_Net_GetBufferProperties" (Byval buffersize As Integer ptr, Byval prebuffer_percent As Integer ptr, Byval rebuffer_percent As Integer ptr) As Byte
Declare Function FSOUND_Stream_Net_SetMetadataCallback Alias "FSOUND_Stream_Net_SetMetadataCallback" (ByVal stream As Integer, ByVal callback As Integer, ByVal userdata As Integer) As Byte
Declare Function FSOUND_Stream_Net_GetStatus Alias "FSOUND_Stream_Net_GetStatus" (ByVal stream As Integer, Byval status As Integer ptr, Byval bufferpercentused As Integer ptr, Byval bitrate As Integer ptr, Byval flags As Integer ptr) As Byte

'/* =================== */
'/* CD audio functions. */
'/* =================== */


'   Note : 0 = default cdrom.  Otherwise specify the drive letter, for example. 'D'.


Declare Function FSOUND_CD_Play Alias "FSOUND_CD_Play" (ByVal drive As Byte, ByVal Track As Integer) As Byte
Declare Function FSOUND_CD_SetPlayMode Alias "FSOUND_CD_SetPlayMode" (ByVal drive As Byte, ByVal mode As FSOUND_CDPLAYMODES) As Integer
Declare Function FSOUND_CD_Stop Alias "FSOUND_CD_Stop" (ByVal drive As Byte) As Byte
Declare Function FSOUND_CD_SetPaused Alias "FSOUND_CD_SetPaused" (ByVal drive As Byte, ByVal Paused As Byte) As Byte
Declare Function FSOUND_CD_SetVolume Alias "FSOUND_CD_SetVolume" (ByVal drive As Byte, ByVal volume As Integer) As Byte
Declare Function FSOUND_CD_SetTrackTime Alias "FSOUND_CD_SetTrackTime" (ByVal drive As Byte, ByVal ms As Integer) As Byte
Declare Function FSOUND_CD_OpenTray Alias "FSOUND_CD_OpenTray" (ByVal drive As Byte, ByVal openState As Byte) As Byte

Declare Function FSOUND_CD_GetPaused Alias "FSOUND_CD_GetPaused" (ByVal drive As Byte) As Byte
Declare Function FSOUND_CD_GetTrack Alias "FSOUND_CD_GetTrack" (ByVal drive As Byte) As Integer
Declare Function FSOUND_CD_GetNumTracks Alias "FSOUND_CD_GetNumTracks" (ByVal drive As Byte) As Integer
Declare Function FSOUND_CD_GetVolume Alias "FSOUND_CD_GetVolume" (ByVal drive As Byte) As Integer
Declare Function FSOUND_CD_GetTrackLength Alias "FSOUND_CD_GetTrackLength" (ByVal drive As Byte, ByVal Track As Integer) As Integer
Declare Function FSOUND_CD_GetTrackTime Alias "FSOUND_CD_GetTrackTime" (ByVal drive As Byte) As Integer

'/* ============== */
'/* DSP functions. */
'/* ============== */


'   DSP Unit control and information functions.
'   These functions allow you access to the mixed stream that FMOD uses to play back sound on.


Declare Function FSOUND_DSP_Create Alias "FSOUND_DSP_Create" (ByVal callback As Integer, ByVal Priority As Integer, ByVal param As Integer) As Integer
Declare Function FSOUND_DSP_Free Alias "FSOUND_DSP_Free" (ByVal unit As Integer) As Integer
Declare Function FSOUND_DSP_SetPriority Alias "FSOUND_DSP_SetPriority" (ByVal unit As Integer, ByVal Priority As Integer) As Integer
Declare Function FSOUND_DSP_GetPriority Alias "FSOUND_DSP_GetPriority" (ByVal unit As Integer) As Integer
Declare Function FSOUND_DSP_SetActive Alias "FSOUND_DSP_SetActive" (ByVal unit As Integer, ByVal active As short) As Integer
Declare Function FSOUND_DSP_GetActive Alias "FSOUND_DSP_GetActive" (ByVal unit As Integer) As Byte


'   Functions to get hold of FSOUND 'system DSP unit' handles


Declare Function FSOUND_DSP_GetClearUnit Alias "FSOUND_DSP_GetClearUnit" () As Integer
Declare Function FSOUND_DSP_GetSFXUnit Alias "FSOUND_DSP_GetSFXUnit" () As Integer
Declare Function FSOUND_DSP_GetMusicUnit Alias "FSOUND_DSP_GetMusicUnit" () As Integer
Declare Function FSOUND_DSP_GetFFTUnit Alias "FSOUND_DSP_GetFFTUnit" () As Integer
Declare Function FSOUND_DSP_GetClipAndCopyUnit Alias "FSOUND_DSP_GetClipAndCopyUnit" () As Integer


'   Miscellaneous DSP functions
'   Note for the spectrum analysis function to work, you have to enable the FFT DSP unit with
'   the following code FSOUND_DSP_SetActive(FSOUND_DSP_GetFFTUnit(), TRUE);
'   It is off by default to save cpu usage.


Declare Function FSOUND_DSP_MixBuffers Alias "FSOUND_DSP_MixBuffers" (ByVal destbuffer As Integer, ByVal srcbuffer As Integer, ByVal length As Integer, ByVal freq As Integer, ByVal Vol As Integer, ByVal pan As Integer, ByVal mode As Integer) As Byte
Declare Function FSOUND_DSP_ClearMixBuffer Alias "FSOUND_DSP_ClearMixBuffer" () As Integer
Declare Function FSOUND_DSP_GetBufferLength Alias "FSOUND_DSP_GetBufferLength" () As Integer
Declare Function FSOUND_DSP_GetBufferLengthTotal Alias "FSOUND_DSP_GetBufferLengthTotal" () As Integer
Declare Function FSOUND_DSP_GetSpectrum Alias "FSOUND_DSP_GetSpectrum" () As Integer

'/* =================================================================================== */
'/* Reverb functions. (eax2/eax3 reverb)  (ONLY SUPPORTED ON WIN32 W/ FSOUND_HW3D FLAG) */
'/* =================================================================================== */


'   See top of file for definitions and information on the reverb parameters.

'The FSOUND_REVERB_PRESETS have not been included in VB yet so they cannot yet be used here...
Declare Function FSOUND_Reverb_SetProperties Alias "FSOUND_Reverb_SetProperties" (Byval prop As FSOUND_REVERB_PROPERTIES ptr) As Byte
Declare Function FSOUND_Reverb_GetProperties Alias "FSOUND_Reverb_GetProperties" (Byval prop As FSOUND_REVERB_PROPERTIES ptr) As Byte
Declare Function FSOUND_Reverb_SetChannelProperties Alias "FSOUND_Reverb_SetChannelProperties" (ByVal channel As Integer, Byval prop As FSOUND_REVERB_CHANNELPROPERTIES ptr) As Byte
Declare Function FSOUND_Reverb_GetChannelProperties Alias "FSOUND_Reverb_GetChannelProperties" (ByVal channel As Integer, Byval prop As FSOUND_REVERB_CHANNELPROPERTIES ptr) As Byte

'/* ===================================================== */
'/* Recording functions  (ONLY SUPPORTED IN WIN32, WINCE) */
'/* ===================================================== */


'    Recording initialization functions


Declare Function FSOUND_Record_SetDriver Alias "FSOUND_Record_SetDriver" (ByVal outputtype As Integer) As Byte
Declare Function FSOUND_Record_GetNumDrivers Alias "FSOUND_Record_GetNumDrivers" () As Integer
Declare Function FSOUND_Record_GetDriverName Alias "FSOUND_Record_GetDriverName" (ByVal id As Integer) as zstring ptr
Declare Function FSOUND_Record_GetDriver Alias "FSOUND_Record_GetDriver" () As Integer


'    Recording functionality.  Only one recording session will work at a time.


Declare Function FSOUND_Record_StartSample Alias "FSOUND_Record_StartSample" (ByVal sample As Integer, ByVal loopit As short) As Byte
Declare Function FSOUND_Record_Stop Alias "FSOUND_Record_Stop" () As Byte
Declare Function FSOUND_Record_GetPosition Alias "FSOUND_Record_GetPosition" () As Integer

'/* ========================================================================================== */
'/* FMUSIC API (MOD,S3M,XM,IT,MIDI PLAYBACK)                                                   */
'/* ========================================================================================== */


'   Song management / playback functions.


Declare Function FMUSIC_LoadSong Alias "FMUSIC_LoadSong" (ByVal name As String) As Integer
Declare Function FMUSIC_LoadSongEx Alias "FMUSIC_LoadSongEx" (ByVal name As String, ByVal offset As Integer, ByVal length As Integer, ByVal mode As FSOUND_MODES, Byval sentencelist As Integer ptr, ByVal numitems As Integer) As Integer
Declare Function FMUSIC_LoadSongEx2 Alias "FMUSIC_LoadSongEx" (Byval fdata As Byte ptr, ByVal offset As Integer, ByVal length As Integer, ByVal mode As FSOUND_MODES, Byval sentencelist As Integer ptr, ByVal numitems As Integer) As Integer
Declare Function FMUSIC_GetOpenState Alias "FMUSIC_GetOpenState" (ByVal module As Integer) As Integer

Declare Function FMUSIC_FreeSong Alias "FMUSIC_FreeSong" (ByVal module As Integer) As Byte
Declare Function FMUSIC_PlaySong Alias "FMUSIC_PlaySong" (ByVal module As Integer) As Byte
Declare Function FMUSIC_StopSong Alias "FMUSIC_StopSong" (ByVal module As Integer) As Byte
Declare Function FMUSIC_StopAllSongs Alias "FMUSIC_StopAllSongs" () As Integer

Declare Function FMUSIC_SetZxxCallback Alias "FMUSIC_SetZxxCallback" (ByVal module As Integer, ByVal callback As Integer) As Byte
Declare Function FMUSIC_SetRowCallback Alias "FMUSIC_SetRowCallback" (ByVal module As Integer, ByVal callback As Integer, ByVal rowstep As Integer) As Byte
Declare Function FMUSIC_SetOrderCallback Alias "FMUSIC_SetOrderCallback" (ByVal module As Integer, ByVal callback As Integer, ByVal rowstep As Integer) As Byte
Declare Function FMUSIC_SetInstCallback Alias "FMUSIC_SetInstCallback" (ByVal module As Integer, ByVal callback As Integer, ByVal instrument As Integer) As Byte

Declare Function FMUSIC_SetSample Alias "FMUSIC_SetSample" (ByVal module As Integer, ByVal sampno As Integer, ByVal sptr As Integer) As Byte
Declare Function FMUSIC_SetUserData Alias "FMUSIC_SetUserData" (ByVal module As Integer, ByVal userdata As Integer) As Byte
Declare Function FMUSIC_OptimizeChannels Alias "FMUSIC_OptimizeChannels" (ByVal module As Integer, ByVal maxchannels As Integer, ByVal minvolume As Integer) As Byte


'   Runtime song functions


Declare Function FMUSIC_SetReverb Alias "FMUSIC_SetReverb" (ByVal Reverb As Byte) As Byte
Declare Function FMUSIC_SetLooping Alias "FMUSIC_SetLooping" (ByVal module As Integer, ByVal looping As Byte) As Byte
Declare Function FMUSIC_SetOrder Alias "FMUSIC_SetOrder" (ByVal module As Integer, ByVal order As Integer) As Byte
Declare Function FMUSIC_SetPaused Alias "FMUSIC_SetPaused" (ByVal module As Integer, ByVal Pause As Byte) As Byte
Declare Function FMUSIC_SetMasterVolume Alias "FMUSIC_SetMasterVolume" (ByVal module As Integer, ByVal volume As Integer) As Byte
Declare Function FMUSIC_SetMasterSpeed Alias "FMUSIC_SetMasterSpeed" (ByVal module As Integer, ByVal speed As Single) As Byte
Declare Function FMUSIC_SetPanSeperation Alias "FMUSIC_SetPanSeperation" (ByVal module As Integer, ByVal pansep As Single) As Byte


'   Static song information functions


Declare Function FMUSIC_GetName Alias "FMUSIC_GetName" (ByVal module As Integer) as zstring ptr
Declare Function FMUSIC_GetType Alias "FMUSIC_GetType" (ByVal module As Integer) As FMUSIC_TYPES
Declare Function FMUSIC_GetNumOrders Alias "FMUSIC_GetNumOrders" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetNumPatterns Alias "FMUSIC_GetNumPatterns" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetNumInstruments Alias "FMUSIC_GetNumInstruments" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetNumSamples Alias "FMUSIC_GetNumSamples" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetNumChannels Alias "FMUSIC_GetNumChannels" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetSample Alias "FMUSIC_GetSample" (ByVal module As Integer, ByVal sampno As Integer) As Integer
Declare Function FMUSIC_GetPatternLength Alias "FMUSIC_GetPatternLength" (ByVal module As Integer, ByVal orderno As Integer) As Integer


'   Runtime song information


Declare Function FMUSIC_IsFinished Alias "FMUSIC_IsFinished" (ByVal module As Integer) As Byte
Declare Function FMUSIC_IsPlaying Alias "FMUSIC_IsPlaying" (ByVal module As Integer) As Byte
Declare Function FMUSIC_GetMasterVolume Alias "FMUSIC_GetMasterVolume" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetGlobalVolume Alias "FMUSIC_GetGlobalVolume" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetOrder Alias "FMUSIC_GetOrder" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetPattern Alias "FMUSIC_GetPattern" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetSpeed Alias "FMUSIC_GetSpeed" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetBPM Alias "FMUSIC_GetBPM" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetRow Alias "FMUSIC_GetRow" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetPaused Alias "FMUSIC_GetPaused" (ByVal module As Integer) As Byte
Declare Function FMUSIC_GetTime Alias "FMUSIC_GetTime" (ByVal module As Integer) As Integer
Declare Function FMUSIC_GetRealChannel Alias "FMUSIC_GetRealChannel" (ByVal module As Integer, ByVal modchannel As Integer) As Integer
Declare Function FMUSIC_GetUserData Alias "FMUSIC_GetUserData" (ByVal module As Integer) As Integer


'************
'* FUNCTIONS (Added by Adion)
'************
'Usage: myerrorstring = FSOUND_GetErrorString(FSOUND_GetError)
Private Function FSOUND_GetErrorString(ByVal errorcode As Integer) As String
    Select Case errorcode
        Case FMOD_ERR_NONE:             FSOUND_GetErrorString = "No errors"
        Case FMOD_ERR_BUSY:             FSOUND_GetErrorString = "Cannot call this command after FSOUND_Init.  Call FSOUND_Close first."
        Case FMOD_ERR_UNINITIALIZED:    FSOUND_GetErrorString = "This command failed because FSOUND_Init was not called"
        Case FMOD_ERR_PLAY:             FSOUND_GetErrorString = "Playing the sound failed."
        Case FMOD_ERR_INIT:             FSOUND_GetErrorString = "Error initializing output device."
        Case FMOD_ERR_ALLOCATED:        FSOUND_GetErrorString = "The output device is already in use and cannot be reused."
        Case FMOD_ERR_OUTPUT_FORMAT:    FSOUND_GetErrorString = "Soundcard does not support the features needed for this soundsystem (16bit stereo output)"
        Case FMOD_ERR_COOPERATIVELEVEL: FSOUND_GetErrorString = "Error setting cooperative level for hardware."
        Case FMOD_ERR_CREATEBUFFER:     FSOUND_GetErrorString = "Error creating hardware sound buffer."
        Case FMOD_ERR_FILE_NOTFOUND:    FSOUND_GetErrorString = "File not found"
        Case FMOD_ERR_FILE_FORMAT:      FSOUND_GetErrorString = "Unknown file format"
        Case FMOD_ERR_FILE_BAD:         FSOUND_GetErrorString = "Error loading file"
        Case FMOD_ERR_MEMORY:           FSOUND_GetErrorString = "Not enough memory "
        Case FMOD_ERR_VERSION:          FSOUND_GetErrorString = "The version number of this file format is not supported"
        Case FMOD_ERR_INVALID_PARAM:    FSOUND_GetErrorString = "An invalid parameter was passed to this function"
        Case FMOD_ERR_NO_EAX:           FSOUND_GetErrorString = "Tried to use an EAX command on a non EAX enabled channel or output."
        Case FMOD_ERR_CHANNEL_ALLOC:    FSOUND_GetErrorString = "Failed to allocate a new channel"
        Case FMOD_ERR_RECORD:           FSOUND_GetErrorString = "Recording is not supported on this machine"
        Case FMOD_ERR_MEDIAPLAYER:      FSOUND_GetErrorString = "Required Mediaplayer codec is not installed"
        Case FMOD_ERR_CDDEVICE:         FSOUND_GetErrorString = "An error occured trying to open the specified CD device"
        Case Else:                      FSOUND_GetErrorString = "Unknown error"
    End Select
End Function
