#ifndef MMSYSTEM_BI
#define MMSYSTEM_BI
'--------
'MMSYSTEM.BI
'--------
'
'This header defines every obtainable winmm Function and related data types and structures.

'VERSION: 1.02

'Changelog:
'  1.02: file name changed to map the C one (from winmm.bi to mmsystem.bi)
'        more constants added (SND_* etc)
'  1.01: STRING types changed to BYTE PTR for structs fields (v1ctor)


'$include: 'win\winbase.bi'

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

#define MM_JOY1MOVE  &h3A0
#define MM_JOY2MOVE  &h3A1
#define MM_JOY1ZMOVE  &h3A2
#define MM_JOY2ZMOVE  &h3A3
#define MM_JOY1BUTTONDOWN  &h3B5
#define MM_JOY2BUTTONDOWN  &h3B6
#define MM_JOY1BUTTONUP  &h3B7
#define MM_JOY2BUTTONUP  &h3B8
#define MM_MCINOTIFY  &h3B9
#define MM_WOM_OPEN  &h3BB
#define MM_WOM_CLOSE  &h3BC
#define MM_WOM_DONE  &h3BD
#define MM_WIM_OPEN  &h3BE
#define MM_WIM_CLOSE  &h3BF
#define MM_WIM_DATA  &h3C0
#define MM_MIM_OPEN  &h3C1
#define MM_MIM_CLOSE  &h3C2
#define MM_MIM_DATA  &h3C3
#define MM_MIM_LONGDATA  &h3C4
#define MM_MIM_ERROR  &h3C5
#define MM_MIM_LONGERROR  &h3C6
#define MM_MOM_OPEN  &h3C7
#define MM_MOM_CLOSE  &h3C8
#define MM_MOM_DONE  &h3C9
#define MM_DRVM_OPEN  &h3D0
#define MM_DRVM_CLOSE  &h3D1
#define MM_DRVM_DATA  &h3D2
#define MM_DRVM_ERROR  &h3D3
#define MM_STREAM_OPEN  &h3D4
#define MM_STREAM_CLOSE  &h3D5
#define MM_STREAM_DONE  &h3D6
#define MM_STREAM_ERROR  &h3D7
#define MM_MOM_POSITIONCB  &h3CA
#define MM_MCISIGNAL  &h3CB
#define MM_MIM_MOREDATA  &h3CC
#define MM_MIXM_LINE_CHANGE  &h3D0
#define MM_MIXM_CONTROL_CHANGE  &h3D1
#define MMSYSERR_BASE  0
#define WAVERR_BASE  32
#define MIDIERR_BASE  64
#define TIMERR_BASE  96
#define JOYERR_BASE  160
#define MCIERR_BASE  256
#define MIXERR_BASE  1024
#define MCI_STRING_OFFSET  512
#define MCI_VD_OFFSET  1024
#define MCI_CD_OFFSET  1088
#define MCI_WAVE_OFFSET  1152
#define MCI_SEQ_OFFSET  1216

#define MMSYSERR_ALLOCATED  (MMSYSERR_BASE + 4)  ' device already allocated
#define MMSYSERR_BADDEVICEID  (MMSYSERR_BASE + 2)  ' device ID out of range
#define MMSYSERR_BADERRNUM  (MMSYSERR_BASE + 9)  ' error value out of range
#define MMSYSERR_ERROR  (MMSYSERR_BASE + 1)  ' unspecified error
#define MMSYSERR_HANDLEBUSY  (MMSYSERR_BASE + 12) ' handle being used
#define MMSYSERR_INVALFLAG  (MMSYSERR_BASE + 10) ' invalid flag passed
#define MMSYSERR_INVALHANDLE  (MMSYSERR_BASE + 5)  ' device handle is invalid
#define MMSYSERR_INVALIDALIAS  (MMSYSERR_BASE + 13) ' "Specified alias not found in WIN.INI
#define MMSYSERR_INVALPARAM  (MMSYSERR_BASE + 11) ' invalid parameter passed
#define MMSYSERR_LASTERROR  (MMSYSERR_BASE + 13) ' last error in range
#define MMSYSERR_NODRIVER  (MMSYSERR_BASE + 6)  ' no device driver present
#define MMSYSERR_NOERROR  0                    ' no error
#define MMSYSERR_NOMEM  (MMSYSERR_BASE + 7)  ' memory allocation error
#define MMSYSERR_NOTENABLED  (MMSYSERR_BASE + 3)  ' driver failed enable
#define MMSYSERR_NOTSUPPORTED  (MMSYSERR_BASE + 8)  ' function isn't supported

#define MAXPNAMELEN  32 ' max product name length (including NULL)

#define DRV_LOAD  1
#define DRV_ENABLE  2
#define DRV_OPEN  3
#define DRV_CLOSE  4
#define DRV_DISABLE  5
#define DRV_FREE  6
#define DRV_CONFIGURE  7
#define DRV_QUERYCONFIGURE  8
#define DRV_INSTALL  9
#define DRV_REMOVE  10
#define DRV_EXITSESSION  11
#define DRV_POWER  15
#define DRV_RESERVED  &h800
#define DRV_USER  &h4000
#define DRVCNF_CANCEL  0
#define DRVCNF_OK  1
#define DRVCNF_RESTART  2
#define DRV_CANCEL  DRVCNF_CANCEL
#define DRV_OK  DRVCNF_OK
#define DRV_RESTART  DRVCNF_RESTART
#define DRV_MCI_FIRST  DRV_RESERVED
#define DRV_MCI_LAST  (DRV_RESERVED+&hFFF)
#define CALLBACK_TYPEMASK  &h70000
#define CALLBACK_NULL  0
#define CALLBACK_WINDOW  &h10000
#define CALLBACK_TASK  &h20000
#define CALLBACK_FUNCTION  &h30000
#define CALLBACK_THREAD  CALLBACK_TASK
#define CALLBACK_EVENT  &h50000
#define SND_SYNC  0
#define SND_ASYNC  1
#define SND_NODEFAULT  2
#define SND_MEMORY  4
#define SND_LOOP  8
#define SND_NOSTOP  16
#define SND_NOWAIT  &h2000
#define SND_ALIAS  &h10000
#define SND_ALIAS_ID  &h110000
#define SND_FILENAME  &h20000
#define SND_RESOURCE  &h40004
#define SND_PURGE  &h40
#define SND_APPLICATION  &h80

#define JOYERR_NOCANDO  (JOYERR_BASE + 6) ' request not completed
#define JOYERR_NOERROR  0                 ' no error
#define JOYERR_PARMS  (JOYERR_BASE + 5) ' bad parameters
#define JOYERR_UNPLUGGED  (JOYERR_BASE + 7) ' joystick is unplugged
#define JOYSTICKID1  0
#define JOYSTICKID2  1


#define JOY_BUTTON1CHG  &H100
#define JOY_BUTTON2CHG  &H200
#define JOY_BUTTON3CHG  &H400
#define JOY_BUTTON4CHG  &H800
#define JOY_BUTTON1  &H1
#define JOY_BUTTON2  &H2
#define JOY_BUTTON3  &H4
#define JOY_BUTTON4  &H8
#define JOY_BUTTON5  &H10&
#define JOY_BUTTON6  &H20&
#define JOY_BUTTON7  &H40&
#define JOY_BUTTON8  &H80&
#define JOY_BUTTON9  &H100&
#define JOY_BUTTON10  &H200&
#define JOY_BUTTON11  &H400&
#define JOY_BUTTON12  &H800&
#define JOY_BUTTON13  &H1000&
#define JOY_BUTTON14  &H2000&
#define JOY_BUTTON15  &H4000&
#define JOY_BUTTON16  &H8000&
#define JOY_BUTTON17  &H10000
#define JOY_BUTTON18  &H20000
#define JOY_BUTTON19  &H40000
#define JOY_BUTTON20  &H80000
#define JOY_BUTTON21  &H100000
#define JOY_BUTTON22  &H200000
#define JOY_BUTTON23  &H400000
#define JOY_BUTTON24  &H800000
#define JOY_BUTTON25  &H1000000
#define JOY_BUTTON26  &H2000000
#define JOY_BUTTON27  &H4000000
#define JOY_BUTTON28  &H8000000
#define JOY_BUTTON29  &H10000000
#define JOY_BUTTON30  &H20000000
#define JOY_BUTTON31  &H40000000
#define JOY_BUTTON32  &H80000000
#define JOY_POVBACKWARD  18000
#define JOY_POVCENTERED  -1
#define JOY_POVFORWARD  0
#define JOY_POVLEFT  27000
#define JOY_POVRIGHT  9000
#define JOY_CAL_READ3  &H40000
#define JOY_CAL_READ4  &H80000
#define JOY_CAL_READ5  &H400000
#define JOY_CAL_READ6  &H800000
#define JOY_CAL_READALWAYS  &H10000
#define JOY_CAL_READRONLY  &H2000000
#define JOY_CAL_READUONLY  &H4000000
#define JOY_CAL_READVONLY  &H8000000
#define JOY_CAL_READXONLY  &H100000
#define JOY_CAL_READXYONLY  &H20000
#define JOY_CAL_READYONLY  &H200000
#define JOY_CAL_READZONLY  &H1000000
#define JOY_RETURNBUTTONS  &H80&
#define JOY_RETURNCENTERED  &H400&
#define JOY_RETURNPOV  &H40&
#define JOY_RETURNPOVCTS  &H200&
#define JOY_RETURNR  &H8&
#define JOY_RETURNU  &H10 ' axis 5
#define JOY_RETURNV  &H20 ' axis 6
#define JOY_RETURNX  &H1&
#define JOY_RETURNY  &H2&
#define JOY_RETURNZ  &H4&
#define JOY_USEDEADZONE  &H800&
#define JOY_RETURNALL  (JOY_RETURNX Or JOY_RETURNY Or JOY_RETURNZ Or JOY_RETURNR Or JOY_RETURNU Or JOY_RETURNV Or JOY_RETURNPOV Or JOY_RETURNBUTTONS)

#define MIXER_SHORT_NAME_CHARS  16&
#define MIXER_LONG_NAME_CHARS  64&

'------------------
'| REQUIRED TYPES |
'------------------

Type JOYCAPS Field = 1
  wMid        As Short
  wPid        As Short
  szPname     As String * MAXPNAMELEN-1
  wXmin       As Short
  wXmax       As Short
  wYmin       As Short
  wYmax       As Short
  wZmin       As Short
  wZmax       As Short
  wNumButtons As Short
  wPeriodMin  As Short
  wPeriodMax  As Short
End Type

Type JOYINFO
  wXpos    As Integer
  wYpos    As Integer
  wZpos    As Integer
  wButtons As Integer
End Type

Type JOYINFOEX
  dwSize         As Integer ' size of structure
  dwFlags        As Integer ' flags to indicate what to return
  dwXpos         As Integer ' x position
  dwYpos         As Integer ' y position
  dwZpos         As Integer ' z position
  dwRpos         As Integer ' rudder/4th axis position
  dwUpos         As Integer ' 5th axis position
  dwVpos         As Integer ' 6th axis position
  dwButtons      As Integer ' button states
  dwButtonNumber As Integer ' current button number pressed
  dwPOV          As Integer ' point of view state
  dwReserved1    As Integer ' reserved for communication between winmm driver
  dwReserved2    As Integer ' reserved for future expansion
End Type

Type AUXCAPS Field = 1
  wMid           As Short
  wPid           As Short
  vDriverVersion As Integer
  szPname        As String * MAXPNAMELEN-1
  wTechnology    As Short
  dwSupport      As Integer
End Type

Type MIDIHDR Field = 1
  lpData          As byte ptr
  dwBufferLength  As Integer
  dwBytesRecorded As Integer
  dwUser          As Integer
  dwFlags         As Integer
  lpNext          As Integer
  Reserved        As Integer
End Type

Type MIDIINCAPS Field = 1
  wMid           As Short
  wPid           As Short
  vDriverVersion As Integer
  szPname        As String * MAXPNAMELEN-1
End Type

Type MIDIOUTCAPS Field = 1
  wMid           As Short
  wPid           As Short
  vDriverVersion As Integer
  szPname        As String * MAXPNAMELEN-1
  wTechnology    As Short
  wVoices        As Short
  wNotes         As Short
  wChannelMask   As Short
  dwSupport      As Integer
End Type

Type MMTIME
  wType As Integer
  u     As Integer
End Type

Type MIXERCONTROLDETAILS
  cbStruct    As Integer ' size Byte of MIXERCONTROLDETAILS
  dwControlID As Integer ' control id to get/set details on
  cChannels   As Integer ' number of channels paDetails array
  item        As Integer ' hwndOwner or cMultipleItems
  cbDetails   As Integer ' size of _one_ details_XX struct
  paDetails   As Integer ' pointer to array of details_XX structs
End Type

Type MIXERCAPS Field = 1
  wMid           As Short                ' manufacturer id
  wPid           As Short                ' product id
  vDriverVersion As Integer              ' version of the driver
  szPname        As String * MAXPNAMELEN-1 ' product name
  fdwSupport     As Integer              ' misc. support bits
  cDestinations  As Integer              ' count of destinations
End Type

Type MIXERCONTROL Field = 1
  cbStruct       As Integer ' size Byte of MIXERCONTROL
  dwControlID    As Integer ' unique control id for mixer device
  dwControlType  As Integer ' MIXERCONTROL_CONTROLTYPE_xxx
  fdwControl     As Integer ' MIXERCONTROL_CONTROLF_xxx
  cMultipleItems As Integer ' if MIXERCONTROL_CONTROLF_MULTIPLE set
  szShortName    As String * MIXER_SHORT_NAME_CHARS-1
  szName         As String * MIXER_LONG_NAME_CHARS-1
  Bounds         As Double
  Metrics        As Integer
End Type

Type MIXERLINECONTROLS Field = 1
  cbStruct  As Integer      ' size Byte of MIXERLINECONTROLS
  dwLineID  As Integer      ' line id (from MIXERLINE.dwLineID)
                            ' MIXER_GETLINECONTROLSF_ONEBYID or
  dwControl As Integer      ' MIXER_GETLINECONTROLSF_ONEBYTYPE
  cControls As Integer      ' count of controls pmxctrl points to
  cbmxctrl  As Integer      ' size Byte of _one_ MIXERCONTROL
  pamxctrl  As MIXERCONTROL ' pointer to first MIXERCONTROL array
End Type

Type MIXER_TARGET Field = 1
  dwType         As Integer ' MIXERLINE_TARGETTYPE_xxxx
  dwDeviceID     As Integer ' target device ID of device type
  wMid           As Short   ' of target device
  wPid           As Short   ' "
  vDriverVersion As Integer ' "
  szPname        As String * MAXPNAMELEN-1
End Type

Type MIXERLINE Field = 1
  cbStruct        As Integer ' size of MIXERLINE structure
  dwDestination   As Integer ' zero based destinationdex
  dwSource        As Integer ' zero based sourcedex (if source)
  dwLineID        As Integer ' unique line id for mixer device
  fdwLine         As Integer ' state/information about line
  dwUser          As Integer ' driver specificformation
  dwComponentType As Integer ' component type line connects to
  cChannels       As Integer ' number of channels line supports
  cConnections    As Integer ' number of connections (possible)
  cControls       As Integer ' number of controls at this line
  szShortName     As String * MIXER_SHORT_NAME_CHARS-1
  szName          As String * MIXER_LONG_NAME_CHARS-1
  lpTarget        As MIXER_TARGET
End Type

Type MMIOINFO Field = 1
  dwFlags     As Integer
  fccIOProc   As Integer
  pIOProc     As Integer
  wErrorRet   As Integer
  htask       As Integer
  cchBuffer   As Integer
  pchBuffer   As byte ptr
  pchNext     As byte ptr
  pchEndRead  As byte ptr
  pchEndWrite As byte ptr
  lBufOffset  As Integer
  lDiskOffset As Integer
  adwInfo(4)  As Integer
  dwReserved1 As Integer
  dwReserved2 As Integer
  hmmio       As Integer
End Type

Type MMCKINFO
  ckid         As Integer
  ckSize       As Integer
  fccType      As Integer
  dwDataOffset As Integer
  dwFlags      As Integer
End Type

Type TIMECAPS
  wPeriodMin As Integer
  wPeriodMax As Integer
End Type

Type WAVEHDR Field = 1
  lpData          As byte ptr
  dwBufferLength  As Integer
  dwBytesRecorded As Integer
  dwUser          As Integer
  dwFlags         As Integer
  dwLoops         As Integer
  lpNext          As Integer
  Reserved        As Integer
End Type

Type WAVEINCAPS Field = 1
  wMid           As Short
  wPid           As Short
  vDriverVersion As Integer
  szPname        As String * MAXPNAMELEN-1
  dwFormats      As Integer
  wChannels      As Short
End Type

Type WAVEFORMAT Field = 1
  wFormatTag      As Short
  nChannels       As Short
  nSamplesPerSec  As Integer
  nAvgBytesPerSec As Integer
  nBlockAlign     As Short
End Type

Type WAVEOUTCAPS Field = 1
  wMid           As Short
  wPid           As Short
  vDriverVersion As Integer
  szPname        As String * MAXPNAMELEN-1
  dwFormats      As Integer
  wChannels      As Short
  dwSupport      As Integer
End Type

'-----------------
'| API FUNCTIONS |
'-----------------

Declare Function CloseDriver Lib "winmm" (ByVal hDriver As Integer, ByVal lParam1 As Integer, ByVal lParam2 As Integer) As Integer
Declare Function DefDriverProc Lib "winmm" (ByVal dwDriverIdentifier As Integer, ByVal hdrvr As Integer, ByVal uMsg As Integer, ByVal lParam1 As Integer, ByVal lParam2 As Integer) As Integer
Declare Function DrvGetModuleHandle Lib "winmm" (ByVal hDriver As Integer) As Integer
Declare Function auxGetDevCaps Lib "winmm" Alias "auxGetDevCapsA" (ByVal uDeviceID As Integer, ByRef lpCaps As AUXCAPS, ByVal uSize As Integer) As Integer
Declare Function auxGetNumDevs Lib "winmm" () As Integer
Declare Function auxGetVolume Lib "winmm" (ByVal uDeviceID As Integer, ByRef lpdwVolume As Integer) As Integer
Declare Function auxOutMessage Lib "winmm" (ByVal uDeviceID As Integer, ByVal msg As Integer, ByVal dw1 As Integer, ByVal dw2 As Integer) As Integer
Declare Function auxSetVolume Lib "winmm" (ByVal uDeviceID As Integer, ByVal dwVolume As Integer) As Integer
Declare Function GetDriverModuleHandle Lib "winmm" (ByVal hDriver As Integer) As Integer
Declare Function joyGetDevCaps Lib "winmm" Alias "joyGetDevCapsA" (ByVal id As Integer, lpCaps As JOYCAPS, ByVal uSize As Integer) As Integer
Declare Function joyGetNumDevs Lib "winmm" Alias "joyGetNumDevs" () As Integer
Declare Function joyGetPos Lib "winmm" (ByVal uJoyID As Integer, pji As JOYINFO) As Integer
Declare Function joyGetPosEx Lib "winmm" (ByVal uJoyID As Integer, pji As JOYINFOEX) As Integer
Declare Function joyGetThreshold Lib "winmm" (ByVal id As Integer, lpuThreshold As Integer) As Integer
Declare Function joyReleaseCapture Lib "winmm" (ByVal id As Integer) As Integer
Declare Function joySetCapture Lib "winmm" (ByVal hwnd As Integer, ByVal uID As Integer, ByVal uPeriod As Integer, ByVal bChanged As Integer) As Integer
Declare Function joySetThreshold Lib "winmm" (ByVal id As Integer, ByVal uThreshold As Integer) As Integer
Declare Function mciExecute Lib "winmm" (ByVal lpstrCommand As String) As Integer
Declare Function mciGetCreatorTask Lib "winmm" (ByVal wDeviceID As Integer) As Integer
Declare Function mciGetDeviceID Lib "winmm" Alias "mciGetDeviceIDA" (ByVal lpstrName As String) As Integer
Declare Function mciGetDeviceIDFromElementID Lib "winmm" Alias "mciGetDeviceIDFromElementIDA" (ByVal dwElementID As Integer, ByVal lpstrType As String) As Integer
Declare Function mciGetErrorString Lib "winmm" Alias "mciGetErrorStringA" (ByVal dwError As Integer, ByVal lpstrBuffer As String, ByVal uLength As Integer) As Integer
Declare Function mciGetYieldProc Lib "winmm" (ByVal mciId As Integer, ByRef pdwYieldData As Integer) As Integer
Declare Function mciSendCommand Lib "winmm" Alias "mciSendCommandA" (ByVal wDeviceID As Integer, ByVal uMessage As Integer, ByVal dwParam1 As Integer, dwParam2 As Any) As Integer
Declare Function mciSendString Lib "winmm" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Integer, ByVal hwndCallback As Integer) As Integer
Declare Function mciSetYieldProc Lib "winmm" (ByVal mciId As Integer, ByVal fpYieldProc As Integer, ByVal dwYieldData As Integer) As Integer
Declare Function midiConnect Lib "winmm" (ByVal hmi As Integer, ByVal hmo As Integer, ByRef pReserved As Any) As Integer
Declare Function midiDisconnect Lib "winmm" (ByVal hmi As Integer, ByVal hmo As Integer, ByRef pReserved As Any) As Integer
Declare Function midiInAddBuffer Lib "winmm" (ByVal hMidiIn As Integer, ByRef lpMidiInHdr As MIDIHDR, ByVal uSize As Integer) As Integer
Declare Function midiInClose Lib "winmm" (ByVal hMidiIn As Integer) As Integer
Declare Function midiInGetDevCaps Lib "winmm" Alias "midiInGetDevCapsA" (ByVal uDeviceID As Integer, ByRef lpCaps As MIDIINCAPS, ByVal uSize As Integer) As Integer
Declare Function midiInGetErrorText Lib "winmm" Alias "midiInGetErrorTextA" (ByVal errno As Integer, ByVal lpText As String, ByVal uSize As Integer) As Integer
Declare Function midiInGetID Lib "winmm" (ByVal hMidiIn As Integer, ByRef lpuDeviceID As Integer) As Integer
Declare Function midiInGetNumDevs Lib "winmm" () As Integer
Declare Function midiInMessage Lib "winmm" (ByVal hMidiIn As Integer, ByVal msg As Integer, ByVal dw1 As Integer, ByVal dw2 As Integer) As Integer
Declare Function midiInOpen Lib "winmm" (ByRef lphMidiIn As Integer, ByVal uDeviceID As Integer, ByVal dwCallback As Integer, ByVal dwInstance As Integer, ByVal dwFlags As Integer) As Integer
Declare Function midiInPrepareHeader Lib "winmm" (ByVal hMidiIn As Integer, ByRef lpMidiInHdr As MIDIHDR, ByVal uSize As Integer) As Integer
Declare Function midiInReset Lib "winmm" (ByVal hMidiIn As Integer) As Integer
Declare Function midiInStart Lib "winmm" (ByVal hMidiIn As Integer) As Integer
Declare Function midiInStop Lib "winmm" (ByVal hMidiIn As Integer) As Integer
Declare Function midiInUnprepareHeader Lib "winmm" (ByVal hMidiIn As Integer, ByRef lpMidiInHdr As MIDIHDR, ByVal uSize As Integer) As Integer
Declare Function midiOutCacheDrumPatches Lib "winmm" (ByVal hMidiOut As Integer, ByVal uPatch As Integer, ByRef lpKeyArray As Integer, ByVal uFlags As Integer) As Integer
Declare Function midiOutCachePatches Lib "winmm" (ByVal hMidiOut As Integer, ByVal uBank As Integer, ByRef lpPatchArray As Integer, ByVal uFlags As Integer) As Integer
Declare Function midiOutClose Lib "winmm" (ByVal hMidiOut As Integer) As Integer
Declare Function midiOutGetDevCaps Lib "winmm" Alias "midiOutGetDevCapsA" (ByVal uDeviceID As Integer, ByRef lpCaps As MIDIOUTCAPS, ByVal uSize As Integer) As Integer
Declare Function midiOutGetErrorText Lib "winmm" Alias "midiOutGetErrorTextA" (ByVal errno As Integer, ByVal lpText As String, ByVal uSize As Integer) As Integer
Declare Function midiOutGetID Lib "winmm" (ByVal hMidiOut As Integer, ByRef lpuDeviceID As Integer) As Integer
Declare Function midiOutGetNumDevs Lib "winmm" () As Short
Declare Function midiOutGetVolume Lib "winmm" (ByVal uDeviceID As Integer, ByRef lpdwVolume As Integer) As Integer
Declare Function midiOutIntegerMsg Lib "winmm" (ByVal hMidiOut As Integer, ByRef lpMidiOutHdr As MIDIHDR, ByVal uSize As Integer) As Integer
Declare Function midiOutMessage Lib "winmm" (ByVal hMidiOut As Integer, ByVal msg As Integer, ByVal dw1 As Integer, ByVal dw2 As Integer) As Integer
Declare Function midiOutOpen Lib "winmm" (ByRef lphMidiOut As Integer, ByVal uDeviceID As Integer, ByVal dwCallback As Integer, ByVal dwInstance As Integer, ByVal dwFlags As Integer) As Integer
Declare Function midiOutPrepareHeader Lib "winmm" (ByVal hMidiOut As Integer, ByRef lpMidiOutHdr As MIDIHDR, ByVal uSize As Integer) As Integer
Declare Function midiOutReset Lib "winmm" (ByVal hMidiOut As Integer) As Integer
Declare Function midiOutSetVolume Lib "winmm" (ByVal uDeviceID As Integer, ByVal dwVolume As Integer) As Integer
Declare Function midiOutShortMsg Lib "winmm" (ByVal hMidiOut As Integer, ByVal dwMsg As Integer) As Integer
Declare Function midiOutUnprepareHeader Lib "winmm" (ByVal hMidiOut As Integer, ByRef lpMidiOutHdr As MIDIHDR, ByVal uSize As Integer) As Integer
Declare Function midiStreamClose Lib "winmm" (ByVal hms As Integer) As Integer
Declare Function midiStreamOpen Lib "winmm" (ByRef phms As Integer, ByRef puDeviceID As Integer, ByVal cMidi As Integer, ByVal dwCallback As Integer, ByVal dwInstance As Integer, ByVal fdwOpen As Integer) As Integer
Declare Function midiStreamOut Lib "winmm" (ByVal hms As Integer, ByRef pmh As MIDIHDR, ByVal cbmh As Integer) As Integer
Declare Function midiStreamPause Lib "winmm" (ByVal hms As Integer) As Integer
Declare Function midiStreamPosition Lib "winmm" (ByVal hms As Integer, ByRef lpmmt As MMTIME, ByVal cbmmt As Integer) As Integer
Declare Function midiStreamProperty Lib "winmm" (ByVal hms As Integer, ByRef lppropdata As Byte, ByVal dwProperty As Integer) As Integer
Declare Function midiStreamRestart Lib "winmm" (ByVal hms As Integer) As Integer
Declare Function midiStreamStop Lib "winmm" (ByVal hms As Integer) As Integer
Declare Function mixerClose Lib "winmm" (ByVal hmx As Integer) As Integer
Declare Function mixerGetControlDetails Lib "winmm" Alias "mixerGetControlDetailsA" (ByVal hmxobj As Integer, ByRef pmxcd As MIXERCONTROLDETAILS, ByVal fdwDetails As Integer) As Integer
Declare Function mixerGetDevCaps Lib "winmm" Alias "mixerGetDevCapsA" (ByVal uMxId As Integer, Byref pmxcaps As MIXERCAPS, ByVal cbmxcaps As Integer) As Integer
Declare Function mixerGetID Lib "winmm" (ByVal hmxobj As Integer, ByRef pumxID As Integer, ByVal fdwId As Integer) As Integer
Declare Function mixerGetLineControls Lib "winmm" Alias "mixerGetLineControlsA" (ByVal hmxobj As Integer, ByRef pmxlc As MIXERLINECONTROLS, ByVal fdwControls As Integer) As Integer
Declare Function mixerGetLineInfo Lib "winmm" Alias "mixerGetLineInfoA" (ByVal hmxobj As Integer, ByRef pmxl As MIXERLINE, ByVal fdwInfo As Integer) As Integer
Declare Function mixerGetNumDevs Lib "winmm" () As Integer
Declare Function mixerMessage Lib "winmm" (ByVal hmx As Integer, ByVal uMsg As Integer, ByVal dwParam1 As Integer, ByVal dwParam2 As Integer) As Integer
Declare Function mixerOpen Lib "winmm" (ByRef phmx As Integer, ByVal uMxId As Integer, ByVal dwCallback As Integer, ByVal dwInstance As Integer, ByVal fdwOpen As Integer) As Integer
Declare Function mixerSetControlDetails Lib "winmm" (ByVal hmxobj As Integer, ByRef pmxcd As MIXERCONTROLDETAILS, ByVal fdwDetails As Integer) As Integer
Declare Function mmioAdvance Lib "winmm" (ByVal hmmio As Integer, ByRef lpmmioinfo As MMIOINFO, ByVal uFlags As Integer) As Integer
Declare Function mmioAscend Lib "winmm" (ByVal hmmio As Integer, ByRef lpck As MMCKINFO, ByVal uFlags As Integer) As Integer
Declare Function mmioClose Lib "winmm" (ByVal hmmio As Integer, ByVal uFlags As Integer) As Integer
Declare Function mmioCreateChunk Lib "winmm" (ByVal hmmio As Integer, ByRef lpck As MMCKINFO, ByVal uFlags As Integer) As Integer
Declare Function mmioDescend Lib "winmm" (ByVal hmmio As Integer, ByRef lpck As MMCKINFO, ByRef lpckParent As MMCKINFO, ByVal uFlags As Integer) As Integer
Declare Function mmioFlush Lib "winmm" (ByVal hmmio As Integer, ByVal uFlags As Integer) As Integer
Declare Function mmioGetInfo Lib "winmm" (ByVal hmmio As Integer, ByRef lpmmioinfo As MMIOINFO, ByVal uFlags As Integer) As Integer
Declare Function mmioInstallIOProc Lib "winmm" Alias "mmioInstallIOProcA" (ByVal fccIOProc As Integer, ByVal pIOProc As Integer, ByVal dwFlags As Integer) As Integer
Declare Function mmioInstallIOProcA Lib "winmm" (ByVal fccIOProc As String, ByVal pIOProc As Integer, ByVal dwFlags As Integer) As Integer
Declare Function mmioOpen Lib "winmm" Alias "mmioOpenA" (ByVal szFileName As String, ByRef lpmmioinfo As MMIOINFO, ByVal dwOpenFlags As Integer) As Integer
Declare Function mmioRead Lib "winmm" (ByVal hmmio As Integer, ByVal pch As String, ByVal cch As Integer) As Integer
Declare Function mmioRename Lib "winmm" Alias "mmioRenameA" (ByVal szFileName As String, ByVal SzNewFileName As String, ByRef lpmmioinfo As MMIOINFO, ByVal dwRenameFlags As Integer) As Integer
Declare Function mmioSeek Lib "winmm" (ByVal hmmio As Integer, ByVal lOffset As Integer, ByVal iOrigin As Integer) As Integer
Declare Function mmioSendMessage Lib "winmm" (ByVal hmmio As Integer, ByVal uMsg As Integer, ByVal lParam1 As Integer, ByVal lParam2 As Integer) As Integer
Declare Function mmioSetBuffer Lib "winmm" (ByVal hmmio As Integer, ByVal pchBuffer As String, ByVal cchBuffer As Integer, ByVal uFlags As Integer) As Integer
Declare Function mmioSetInfo Lib "winmm" (ByVal hmmio As Integer, ByRef lpmmioinfo As MMIOINFO, ByVal uFlags As Integer) As Integer
Declare Function mmioStringToFOURCC Lib "winmm" Alias "mmioStringToFOURCCA" (ByVal sz As String, ByVal uFlags As Integer) As Integer
Declare Function mmioWrite Lib "winmm" (ByVal hmmio As Integer, ByVal pch As String, ByVal cch As Integer) As Integer
Declare Function mmsystemGetVersion Lib "winmm" () As Integer
Declare Function OpenDriver Lib "winmm" (ByVal szDriverName As String, ByVal szSectionName As String, ByVal lParam2 As Integer) As Integer
Declare Function PlaySound Lib "winmm" Alias "PlaySoundA" (ByVal lpszName As String, ByVal hModule As Integer, ByVal dwFlags As Integer) As Integer
Declare Function SendDriverMessage Lib "winmm" (ByVal hDriver As Integer, ByVal message As Integer, ByVal lParam1 As Integer, ByVal lParam2 As Integer) As Integer
Declare Function sndPlaySound Lib "winmm" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Integer) As Integer
Declare Function timeBeginPeriod Lib "winmm" (ByVal uPeriod As Integer) As Integer
Declare Function timeEndPeriod Lib "winmm" (ByVal uPeriod As Integer) As Integer
Declare Function timeGetDevCaps Lib "winmm" (ByRef lpTimeCaps As TIMECAPS, ByVal uSize As Integer) As Integer
Declare Function timeGetSystemTime Lib "winmm" (ByRef lpTime As MMTIME, ByVal uSize As Integer) As Integer
Declare Function timeGetTime Lib "winmm" () As Integer
Declare Function timeKillEvent Lib "winmm" (ByVal uID As Integer) As Integer
Declare Function timeSetEvent Lib "winmm" (ByVal uDelay As Integer, ByVal uResolution As Integer, ByVal lpFunction As Integer, ByVal dwUser As Integer, ByVal uFlags As Integer) As Integer
Declare Function waveInAddBuffer Lib "winmm" (ByVal hWaveIn As Integer, ByRef lpWaveInHdr As WAVEHDR, ByVal uSize As Integer) As Integer
Declare Function waveInClose Lib "winmm" (ByVal hWaveIn As Integer) As Integer
Declare Function waveInGetDevCaps Lib "winmm" Alias "waveInGetDevCapsA" (ByVal uDeviceID As Integer, ByRef lpCaps As WAVEINCAPS, ByVal uSize As Integer) As Integer
Declare Function waveInGetErrorText Lib "winmm" Alias "waveInGetErrorTextA" (ByVal errno As Integer, ByVal lpText As String, ByVal uSize As Integer) As Integer
Declare Function waveInGetID Lib "winmm" (ByVal hWaveIn As Integer, ByRef lpuDeviceID As Integer) As Integer
Declare Function waveInGetNumDevs Lib "winmm" () As Integer
Declare Function waveInGetPosition Lib "winmm" (ByVal hWaveIn As Integer, ByRef lpInfo As MMTIME, ByVal uSize As Integer) As Integer
Declare Function waveInMessage Lib "winmm" (ByVal hWaveIn As Integer, ByVal msg As Integer, ByVal dw1 As Integer, ByVal dw2 As Integer) As Integer
Declare Function waveInOpen Lib "winmm" (ByRef lphWaveIn As Integer, ByVal uDeviceID As Integer, ByRef lpFormat As WAVEFORMAT, ByVal dwCallback As Integer, ByVal dwInstance As Integer, ByVal dwFlags As Integer) As Integer
Declare Function waveInPrepareHeader Lib "winmm" (ByVal hWaveIn As Integer, ByRef lpWaveInHdr As WAVEHDR, ByVal uSize As Integer) As Integer
Declare Function waveInReset Lib "winmm" (ByVal hWaveIn As Integer) As Integer
Declare Function waveInStart Lib "winmm" (ByVal hWaveIn As Integer) As Integer
Declare Function waveInStop Lib "winmm" (ByVal hWaveIn As Integer) As Integer
Declare Function waveInUnprepareHeader Lib "winmm" (ByVal hWaveIn As Integer, ByRef lpWaveInHdr As WAVEHDR, ByVal uSize As Integer) As Integer
Declare Function waveOutBreakLoop Lib "winmm" (ByVal hWaveOut As Integer) As Integer
Declare Function waveOutClose Lib "winmm" (ByVal hWaveOut As Integer) As Integer
Declare Function waveOutGetDevCaps Lib "winmm" Alias "waveOutGetDevCapsA" (ByVal uDeviceID As Integer, ByRef lpCaps As WAVEOUTCAPS, ByVal uSize As Integer) As Integer
Declare Function waveOutGetErrorText Lib "winmm" Alias "waveOutGetErrorTextA" (ByVal errno As Integer, ByVal lpText As String, ByVal uSize As Integer) As Integer
Declare Function waveOutGetID Lib "winmm" (ByVal hWaveOut As Integer, ByRef lpuDeviceID As Integer) As Integer
Declare Function waveOutGetNumDevs Lib "winmm" () As Integer
Declare Function waveOutGetPitch Lib "winmm" (ByVal hWaveOut As Integer, ByRef lpdwPitch As Integer) As Integer
Declare Function waveOutGetPlaybackRate Lib "winmm" (ByVal hWaveOut As Integer, ByRef lpdwRate As Integer) As Integer
Declare Function waveOutGetPosition Lib "winmm" (ByVal hWaveOut As Integer, ByRef lpInfo As MMTIME, ByVal uSize As Integer) As Integer
Declare Function waveOutGetVolume Lib "winmm" (ByVal uDeviceID As Integer, ByRef lpdwVolume As Integer) As Integer
Declare Function waveOutMessage Lib "winmm" (ByVal hWaveOut As Integer, ByVal msg As Integer, ByVal dw1 As Integer, ByVal dw2 As Integer) As Integer
Declare Function waveOutOpen Lib "winmm" (ByRef lphWaveOut As Integer, ByVal uDeviceID As Integer, ByRef lpFormat As WAVEFORMAT, ByVal dwCallback As Integer, ByVal dwInstance As Integer, ByVal dwFlags As Integer) As Integer
Declare Function waveOutPause Lib "winmm" (ByVal hWaveOut As Integer) As Integer
Declare Function waveOutPrepareHeader Lib "winmm" (ByVal hWaveOut As Integer, ByRef lpWaveOutHdr As WAVEHDR, ByVal uSize As Integer) As Integer
Declare Function waveOutReset Lib "winmm" (ByVal hWaveOut As Integer) As Integer
Declare Function waveOutRestart Lib "winmm" (ByVal hWaveOut As Integer) As Integer
Declare Function waveOutSetPitch Lib "winmm" (ByVal hWaveOut As Integer, ByVal dwPitch As Integer) As Integer
Declare Function waveOutSetPlaybackRate Lib "winmm" (ByVal hWaveOut As Integer, ByVal dwRate As Integer) As Integer
Declare Function waveOutSetVolume Lib "winmm" (ByVal uDeviceID As Integer, ByVal dwVolume As Integer) As Integer
Declare Function waveOutUnprepareHeader Lib "winmm" (ByVal hWaveOut As Integer, ByRef lpWaveOutHdr As WAVEHDR, ByVal uSize As Integer) As Integer
Declare Function waveOutWrite Lib "winmm" (ByVal hWaveOut As Integer, ByRef lpWaveOutHdr As WAVEHDR, ByVal uSize As Integer) As Integer
#endif 'MMSYSTEM_BI