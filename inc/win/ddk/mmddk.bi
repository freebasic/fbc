
/'**************************************************************************'/
/'                                                                          '/
/'      MMDDK.BI - Include file for Multimedia Device Development Kit       '/
/'                                                                          '/
/'      Note: You must include the WINDOWS.bi and MMSYSTEM.bi header files  '/
/'            before including this file.                                   '/
/'                                                                          '/
/'      Copyright (c) Microsoft Corp.  All rights reserved.                 '/
/'                                                                          '/
/'**************************************************************************'/
 
#ifndef __MMDDK_BI__
#define __MMDDK_BI__

/'    If defined, the following flags inhibit inclusion
 *    of the indicated items:
 *
 *        MMNOMIDIDEV         - MIDI support
 *        MMNOWAVEDEV         - Waveform support
 *        MMNOAUXDEV          - Auxiliary output support
 *        MMNOMIXERDEV        - Mixer support
 *        MMNOTIMERDEV        - Timer support
 *        MMNOJOYDEV          - Joystick support
 *        MMNOMCIDEV          - MCI support
 *        MMNOTASKDEV         - Task support
 '/
#ifdef MMNOTIMER
  #define MMNOTIMERDEV
#endif
#ifdef MMNOWAVE
  #define MMNOWAVEDEV
#endif
#ifdef MMNOMIDI
  #define MMNOMIDIDEV
#endif
#ifdef MMNOAUX
  #define MMNOAUXDEV
#endif
#ifdef MMNOJOY
  #define MMNOJOYDEV
#endif
#ifdef MMNOMMIO
  #define MMNOMMIODEV
#endif
#ifdef MMNOMCI
  #define MMNOMCIDEV
#endif
 
 
/'**************************************************************************
                       Helper functions for drivers
**************************************************************************'/
#ifndef NODRIVERS
#ifndef DRV_LOAD
#  define DRV_LOAD               &H0001
#  define DRV_ENABLE             &H0002
#  define DRV_OPEN               &H0003
#  define DRV_CLOSE              &H0004
#  define DRV_DISABLE            &H0005
#  define DRV_FREE               &H0006
#  define DRV_CONFIGURE          &H0007
#  define DRV_QUERYCONFIGURE     &H0008
#  define DRV_INSTALL            &H0009
#  define DRV_REMOVE             &H000A

#  define DRV_RESERVED           &H0800
#  define DRV_USER               &H4000
 
#  define DRIVERS_SECTION  "DRIVERS32"     ' Section name for installed drivers
#  define MCI_SECTION      "MCI32"         ' Section name for installed MCI drivers
# endif
#endif
 
#define DCB_NOSWITCH   &H0008           ' don't switch stacks for callback
#define DCB_TYPEMASK   &H0007           ' callback type mask
#define DCB_NULL       &H0000           ' unknown callback type
 
' flags for wFlags parameter of DriverCallback()
#define DCB_WINDOW     &H0001           ' dwCallback is a HWND
#define DCB_TASK       &H0002           ' dwCallback is a HTASK
#define DCB_FUNCTION   &H0003           ' dwCallback is a FARPROC
#define DCB_EVENT      &H0005           ' dwCallback is an EVENT
 
' BOOL APIENTRY DriverCallback(DWORD_PTR dwCallback, DWORD dwFlags, HDRVR hDevice, DWORD dwMsg, DWORD_PTR dwUser, DWORD_PTR dwParam1, DWORD_PTR dwParam2)
 
' generic prototype for audio device driver entry-point functions
' midMessage(), modMessage(), widMessage(), wodMessage(), auxMessage()
'typedef DWORD (SOUNDDEVMSGPROC)(WORD, WORD, DWORD, DWORD, DWORD);
'typedef SOUNDDEVMSGPROC FAR *LPSOUNDDEVMSGPROC;
 
#define DRVM_INIT               100
#define DRVM_EXIT               101
#define DRVM_DISABLE            102
#define DRVM_ENABLE             103
 
 
' message base for driver specific messages.
'
#define DRVM_MAPPER                     &H2000
#define DRVM_USER                       &H4000
#define DRVM_MAPPER_STATUS              (DRVM_MAPPER+0)
#define DRVM_MAPPER_RECONFIGURE         (DRVM_MAPPER+1)
#define DRVM_MAPPER_PREFERRED_GET       (DRVM_MAPPER+21)
#define DRVM_MAPPER_CONSOLEVOICECOM_GET (DRVM_MAPPER+23)
#define DRV_QUERYMODULE                 (DRV_RESERVED + 9)
#define DRV_PNPINSTALL                  (DRV_RESERVED + 11)
#define DRV_QUERYSTRINGID               (DRV_RESERVED + 14)
#define DRV_QUERYSTRINGIDSIZE           (DRV_RESERVED + 15)
#define DRV_QUERYIDFROMSTRINGID         (DRV_RESERVED + 16)

'
' DRVM_MAPPER_PREFERRED_GET flags
'
#define DRVM_MAPPER_PREFERRED_FLAGS_PREFERREDONLY   &H00000001

'
' messages that have IOCTL format
'    dw1 = NULL or handle
'    dw2 = NULL or ptr to DRVM_IOCTL_DATA
'    return is MMRESULT
'
#define DRVM_IOCTL       &H100
#define DRVM_ADD_THRU    (DRVM_IOCTL+1)
#define DRVM_REMOVE_THRU (DRVM_IOCTL+2)
#define DRVM_IOCTL_LAST  (DRVM_IOCTL+5)
 
type DRVM_IOCTL_DATA field=1
  as DWORD  dwSize ' size of this structure (inclusive)
  as DWORD  dwCmd  ' IOCTL command code, &H80000000 and above reserved for system
end type
type LPDRVM_IOCTL_DATA as DRVM_IOCTL_DATA ptr

' command code ranges for dwCmd field of DRVM_IOCTL message
' codes from 0 to &H7FFFFFFF are user defined
' codes from &H80000000 to &HFFFFFFFF are reserved for future
' definition by microsoft
#define DRVM_IOCTL_CMD_USER   &H00000000L
#define DRVM_IOCTL_CMD_SYSTEM &H80000000L
 
' device ID for 386 AUTODMA VxD
#define VADMAD_Device_ID    &H0444
 
/' PnP version of media device caps '/
type MDEVICECAPSEX field=1
  as DWORD   cbSize
  as any ptr pCaps
end type
 
#ifndef MMNOWAVEDEV
/'***************************************************************************
                       Waveform device driver support
***************************************************************************'/
#define WODM_INIT DRVM_INIT
#define WIDM_INIT DRVM_INIT
 
' waveform input and output device open information structure
type WAVEOPENDESC field=1
  as HWAVE        hWave           ' handle
  as LPWAVEFORMAT lpFormat        ' format of wave data
  as DWORD_PTR    dwCallback      ' callback
  as DWORD_PTR    dwInstance      ' app's private instance information
  as UINT         uMappedDeviceID ' device to map to if WAVE_MAPPED set
  as DWORD_PTR    dnDevNode       ' if device is PnP
end type
type LPWAVEOPENDESC as WAVEOPENDESC ptr
 
' messages sent to wodMessage() entry-point function
#define WODM_GETNUMDEVS       3
#define WODM_GETDEVCAPS       4
#define WODM_OPEN             5
#define WODM_CLOSE            6
#define WODM_PREPARE          7
#define WODM_UNPREPARE        8
#define WODM_WRITE            9
#define WODM_PAUSE            10
#define WODM_RESTART          11
#define WODM_RESET            12
#define WODM_GETPOS           13
#define WODM_GETPITCH         14
#define WODM_SETPITCH         15
#define WODM_GETVOLUME        16
#define WODM_SETVOLUME        17
#define WODM_GETPLAYBACKRATE  18
#define WODM_SETPLAYBACKRATE  19
#define WODM_BREAKLOOP        20
#define WODM_PREFERRED        21

#define WODM_MAPPER_STATUS           (DRVM_MAPPER_STATUS + 0)
#define WAVEOUT_MAPPER_STATUS_DEVICE 0
#define WAVEOUT_MAPPER_STATUS_MAPPED 1
#define WAVEOUT_MAPPER_STATUS_FORMAT 2

#define WODM_BUSY             21
 
' messages sent to widMessage() entry-point function
#define WIDM_GETNUMDEVS 50
#define WIDM_GETDEVCAPS 51
#define WIDM_OPEN       52
#define WIDM_CLOSE      53
#define WIDM_PREPARE    54
#define WIDM_UNPREPARE  55
#define WIDM_ADDBUFFER  56
#define WIDM_START      57
#define WIDM_STOP       58
#define WIDM_RESET      59
#define WIDM_GETPOS     60
#define WIDM_PREFERRED  61

#define WIDM_MAPPER_STATUS          (DRVM_MAPPER_STATUS + 0)
#define WAVEIN_MAPPER_STATUS_DEVICE 0
#define WAVEIN_MAPPER_STATUS_MAPPED 1
#define WAVEIN_MAPPER_STATUS_FORMAT 2

#endif ' ifndef MMNOWAVEDEV


#ifndef MMNOMIDIDEV
/'***************************************************************************
                          MIDI device driver support
***************************************************************************'/
#define MODM_USER   DRVM_USER
#define MIDM_USER   DRVM_USER
#define MODM_MAPPER DRVM_MAPPER
#define MIDM_MAPPER DRVM_MAPPER
 
#define MODM_INIT   DRVM_INIT
#define MIDM_INIT   DRVM_INIT
 
#ifndef MMNOMIDI   ' This protects the definition of HMIDI in WINMM.bi
type MIDIOPENSTRMID field=1
  as DWORD          dwStreamID
  as UINT           uDeviceID
end type
' MIDI input and output device open information structure
type MIDIOPENDESC field=1
  as HMIDI          hMidi             ' handle
  as DWORD_PTR      dwCallback        ' callback
  as DWORD_PTR      dwInstance        ' app's private instance information
  as DWORD_PTR      dnDevNode         ' DevNode
  as DWORD          cIds              ' If stream open, # stream ids
  as MIDIOPENSTRMID rgIds(1-1)        ' Array of device ID's (actually [cIds])
end type
type  PMIDIOPENDESC as MIDIOPENDESC ptr
type LPMIDIOPENDESC as MIDIOPENDESC ptr
#endif ' MMNOMIDI
 
 
/' Flags for MODM_OPEN '/
#define MIDI_IO_PACKED      &H00000000L     /' Compatibility mode '/
#define MIDI_IO_COOKED      &H00000002L
 
' messages sent to modMessage() entry-point function
#define MODM_GETNUMDEVS     1
#define MODM_GETDEVCAPS     2
#define MODM_OPEN           3
#define MODM_CLOSE          4
#define MODM_PREPARE        5
#define MODM_UNPREPARE      6
#define MODM_DATA           7
#define MODM_LONGDATA       8
#define MODM_RESET          9
#define MODM_GETVOLUME      10
#define MODM_SETVOLUME      11
#define MODM_CACHEPATCHES       12
#define MODM_CACHEDRUMPATCHES   13

#define MODM_STRMDATA               14
#define MODM_GETPOS                 17
#define MODM_PAUSE                  18
#define MODM_RESTART                19
#define MODM_STOP                   20
#define MODM_PROPERTIES             21
#define MODM_PREFERRED              22
#define MODM_RECONFIGURE            (MODM_USER+&H0768)
 
 
' messages sent to midMessage() entry-point function
#define MIDM_GETNUMDEVS  53
#define MIDM_GETDEVCAPS  54
#define MIDM_OPEN        55
#define MIDM_CLOSE       56
#define MIDM_PREPARE     57
#define MIDM_UNPREPARE   58
#define MIDM_ADDBUFFER   59
#define MIDM_START       60
#define MIDM_STOP        61
#define MIDM_RESET       62
 
#endif ' ifndef MMNOMIDIDEV
 
 
#ifndef MMNOAUXDEV
/'***************************************************************************
                    Auxiliary audio device driver support
***************************************************************************'/
 
#define AUXM_INIT      DRVM_INIT
 
' messages sent to auxMessage() entry-point function
#define AUXDM_GETNUMDEVS    3
#define AUXDM_GETDEVCAPS    4
#define AUXDM_GETVOLUME     5
#define AUXDM_SETVOLUME     6
 
#endif ' ifndef MMNOAUXDEV
 

#ifndef MMNOMIXERDEV
'
'  mixer device open information structure
'
type MIXEROPENDESC field=1
  as HMIXER          hmx            ' handle that will be used
  as LPVOID          pReserved0     ' reserved--driver should ignore
  as DWORD_PTR       dwCallback     ' callback
  as DWORD_PTR       dwInstance     ' app's private instance information
  as DWORD_PTR       dnDevNode      ' if device is PnP
end type
type  PMIXEROPENDESC as MIXEROPENDESC ptr
type LPMIXEROPENDESC as MIXEROPENDESC ptr

#define MXDM_INIT                   100
#define MXDM_USER                   DRV_USER

#define MXDM_BASE                   (1)
#define MXDM_GETNUMDEVS             (MXDM_BASE + 0)
#define MXDM_GETDEVCAPS             (MXDM_BASE + 1)
#define MXDM_OPEN                   (MXDM_BASE + 2)
#define MXDM_CLOSE                  (MXDM_BASE + 3)
#define MXDM_GETLINEINFO            (MXDM_BASE + 4)
#define MXDM_GETLINECONTROLS        (MXDM_BASE + 5)
#define MXDM_GETCONTROLDETAILS      (MXDM_BASE + 6)
#define MXDM_SETCONTROLDETAILS      (MXDM_BASE + 7)

#endif ' MMNOMIXERDEV

 
#ifndef MMNOTIMERDEV
/'***************************************************************************
 
                        Timer device driver support
 
***************************************************************************'/

type TIMEREVENT field=1
  as  WORD                wDelay         ' delay required
  as  WORD                wResolution    ' resolution required
  as  LPTIMECALLBACK      lpFunction     ' ptr to callback function
  as  DWORD               dwUser         ' user DWORD
  as  WORD                wFlags         ' defines how to program event
  as  WORD                wReserved1     ' structure packing
end type
type LPTIMEREVENT as TIMEREVENT ptr
 
' messages sent to tddMessage() function
#define TDD_KILLTIMEREVENT  (DRV_RESERVED+0)  ' indices into a table of
#define TDD_SETTIMEREVENT   (DRV_RESERVED+4)  ' functions; thus offset by
#define TDD_GETSYSTEMTIME   (DRV_RESERVED+8)  ' four each time...
#define TDD_GETDEVCAPS      (DRV_RESERVED+12) ' room for future expansion
#define TDD_BEGINMINPERIOD  (DRV_RESERVED+16) ' room for future expansion
#define TDD_ENDMINPERIOD    (DRV_RESERVED+20) ' room for future expansion
 
#endif ' ifndef MMNOTIMERDEV
 
 
#ifndef MMNOJOYDEV
/'***************************************************************************
 
                       Joystick device driver support
 
***************************************************************************'/
 
/' RegisterWindowMessage with this to get msg id of config changes '/
#define JOY_CONFIGCHANGED_MSGSTRING     "MSJSTICK_VJOYD_MSGSTR"
 
/' pre-defined joystick types '/
#define JOY_HW_NONE                     0
#define JOY_HW_CUSTOM                   1
#define JOY_HW_2A_2B_GENERIC            2
#define JOY_HW_2A_4B_GENERIC            3
#define JOY_HW_2B_GAMEPAD               4
#define JOY_HW_2B_FLIGHTYOKE            5
#define JOY_HW_2B_FLIGHTYOKETHROTTLE    6
#define JOY_HW_3A_2B_GENERIC            7
#define JOY_HW_3A_4B_GENERIC            8
#define JOY_HW_4B_GAMEPAD               9
#define JOY_HW_4B_FLIGHTYOKE            10
#define JOY_HW_4B_FLIGHTYOKETHROTTLE    11
#define JOY_HW_LASTENTRY                12
 
/' calibration flags '/
#define JOY_ISCAL_XY            &H00000001l     /' XY are calibrated '/
#define JOY_ISCAL_Z             &H00000002l     /' Z is calibrated '/
#define JOY_ISCAL_R             &H00000004l     /' R is calibrated '/
#define JOY_ISCAL_U             &H00000008l     /' U is calibrated '/
#define JOY_ISCAL_V             &H00000010l     /' V is calibrated '/
#define JOY_ISCAL_POV           &H00000020l     /' POV is calibrated '/
 
/' point of view constants '/
#define JOY_POV_NUMDIRS          4
#define JOY_POVVAL_FORWARD       0
#define JOY_POVVAL_BACKWARD      1
#define JOY_POVVAL_LEFT          2
#define JOY_POVVAL_RIGHT         3
 
/' Specific settings for joystick hardware '/
#define JOY_HWS_HASZ            &H00000001l     /' has Z info? '/
#define JOY_HWS_HASPOV          &H00000002l     /' point of view hat present '/
#define JOY_HWS_POVISBUTTONCOMBOS &H00000004l   /' pov done through combo of buttons '/
#define JOY_HWS_POVISPOLL       &H00000008l     /' pov done through polling '/
#define JOY_HWS_ISYOKE          &H00000010l     /' joystick is a flight yoke '/
#define JOY_HWS_ISGAMEPAD       &H00000020l     /' joystick is a game pad '/
#define JOY_HWS_ISCARCTRL       &H00000040l     /' joystick is a car controller '/
/' X defaults to J1 X axis '/
#define JOY_HWS_XISJ1Y          &H00000080l     /' X is on J1 Y axis '/
#define JOY_HWS_XISJ2X          &H00000100l     /' X is on J2 X axis '/
#define JOY_HWS_XISJ2Y          &H00000200l     /' X is on J2 Y axis '/
/' Y defaults to J1 Y axis '/
#define JOY_HWS_YISJ1X          &H00000400l     /' Y is on J1 X axis '/
#define JOY_HWS_YISJ2X          &H00000800l     /' Y is on J2 X axis '/
#define JOY_HWS_YISJ2Y          &H00001000l     /' Y is on J2 Y axis '/
/' Z defaults to J2 Y axis '/
#define JOY_HWS_ZISJ1X          &H00002000l     /' Z is on J1 X axis '/
#define JOY_HWS_ZISJ1Y          &H00004000l     /' Z is on J1 Y axis '/
#define JOY_HWS_ZISJ2X          &H00008000l     /' Z is on J2 X axis '/
/' POV defaults to J2 Y axis, if it is not button based '/
#define JOY_HWS_POVISJ1X        &H00010000l     /' pov done through J1 X axis '/
#define JOY_HWS_POVISJ1Y        &H00020000l     /' pov done through J1 Y axis '/
#define JOY_HWS_POVISJ2X        &H00040000l     /' pov done through J2 X axis '/
/' R defaults to J2 X axis '/
#define JOY_HWS_HASR            &H00080000l     /' has R (4th axis) info '/
#define JOY_HWS_RISJ1X          &H00100000l     /' R done through J1 X axis '/
#define JOY_HWS_RISJ1Y          &H00200000l     /' R done through J1 Y axis '/
#define JOY_HWS_RISJ2Y          &H00400000l     /' R done through J2 X axis '/
/' U & V for future hardware '/
#define JOY_HWS_HASU            &H00800000l     /' has U (5th axis) info '/
#define JOY_HWS_HASV            &H01000000l     /' has V (6th axis) info '/
 
/' Usage settings '/
#define JOY_US_HASRUDDER        &H00000001l     /' joystick configured with rudder '/
#define JOY_US_PRESENT          &H00000002l     /' is joystick actually present? '/
#define JOY_US_ISOEM            &H00000004l     /' joystick is an OEM defined type '/
 
/' struct for storing x,y, z, and rudder values '/
type JOYPOS field=1
  as DWORD       dwX
  as DWORD       dwY
  as DWORD       dwZ
  as DWORD       dwR
  as DWORD       dwU
  as DWORD       dwV
end type
type LPJOYPOS as JOYPOS ptr
 
/' struct for storing ranges '/
type JOYRANGE field=1
  as JOYPOS      jpMin
  as JOYPOS      jpMax
  as JOYPOS      jpCenter
end type
type LPJOYRANGE as JOYRANGE ptr
 
type JOYREGUSERVALUES
  as DWORD       dwTimeOut      /' value at which to timeout joystick polling '/
  as JOYRANGE    jrvRanges      /' range of values app wants returned for axes '/
  as JOYPOS      jpDeadZone     /' area around center to be considered
                                   as "dead". specified as a percentage
                                   (0-100). Only X & Y handled by system driver '/
end type
type LPJOYREGUSERVALUES as JOYREGUSERVALUES ptr
 
type JOYREGHWSETTINGS field=1
  as DWORD       dwFlags
  as DWORD       dwNumButtons           /' number of buttons '/
end type
type LPJOYHWSETTINGS as JOYREGHWSETTINGS ptr
 
/' range of values returned by the hardware (filled in by calibration) '/
type JOYREGHWVALUES field=1
  as JOYRANGE    jrvHardware            /' values returned by hardware '/
  as DWORD       dwPOVValues(JOY_POV_NUMDIRS-1) /' POV values returned by hardware '/
  as DWORD       dwCalFlags             /' what has been calibrated '/
end type
type LPJOYREGHWVALUES as JOYREGHWVALUES ptr
 
/' hardware configuration '/
type JOYREGHWCONFIG field=1
  as JOYREGHWSETTINGS    hws             /' hardware settings '/
  as DWORD               dwUsageSettings /' usage settings '/
  as JOYREGHWVALUES      hwv             /' values returned by hardware '/
  as DWORD               dwType          /' type of joystick '/
  as DWORD               dwReserved      /' reserved for OEM drivers '/
end type
type LPJOYREGHWCONFIG as JOYREGHWCONFIG ptr
 
' joystick calibration info structure
type JOYCALIBRATE field=1
  as WORD    wXbase
  as WORD    wXdelta
  as WORD    wYbase
  as WORD    wYdelta
  as WORD    wZbase
  as WORD    wZdelta
end type
type LPJOYCALIBRATE as JOYCALIBRATE ptr
 
' prototype for joystick message function
type JOYDEVMSGPROC as function (as DWORD,as UINT,as LONG,as LONG) as DWORD
type LPJOYDEVMSGPROC as JOYDEVMSGPROC ptr
 
' messages sent to joystick driver's DriverProc() function
#define JDD_GETNUMDEVS          (DRV_RESERVED + &H0001)
#define JDD_GETDEVCAPS          (DRV_RESERVED + &H0002)
#define JDD_GETPOS              (DRV_RESERVED + &H0101)
#define JDD_SETCALIBRATION      (DRV_RESERVED + &H0102)
#define JDD_CONFIGCHANGED       (DRV_RESERVED + &H0103)
#define JDD_GETPOSEX            (DRV_RESERVED + &H0104)
 
#endif ' ifndef MMNOJOYDEV
 
#ifndef MAKELRESULT
#define MAKELRESULT(low, high)   (cast(LRESULT,MAKELONG(low, high)))
#endif
 
 
#ifndef MMNOMCIDEV
/'***************************************************************************
 
                        MCI device driver support
 
***************************************************************************'/
 
 
' internal MCI messages
#define MCI_OPEN_DRIVER             &H0801
#define MCI_CLOSE_DRIVER            &H0802
 
#define MAKEMCIRESOURCE(wRet, wRes) MAKELRESULT((wRet), (wRes))
 
' string return values only used with MAKEMCIRESOURCE
#define MCI_FALSE                       (MCI_STRING_OFFSET + 19)
#define MCI_TRUE                        (MCI_STRING_OFFSET + 20)
 
' resource string return values
#define MCI_FORMAT_RETURN_BASE          MCI_FORMAT_MILLISECONDS_S
#define MCI_FORMAT_MILLISECONDS_S       (MCI_STRING_OFFSET + 21)
#define MCI_FORMAT_HMS_S                (MCI_STRING_OFFSET + 22)
#define MCI_FORMAT_MSF_S                (MCI_STRING_OFFSET + 23)
#define MCI_FORMAT_FRAMES_S             (MCI_STRING_OFFSET + 24)
#define MCI_FORMAT_SMPTE_24_S           (MCI_STRING_OFFSET + 25)
#define MCI_FORMAT_SMPTE_25_S           (MCI_STRING_OFFSET + 26)
#define MCI_FORMAT_SMPTE_30_S           (MCI_STRING_OFFSET + 27)
#define MCI_FORMAT_SMPTE_30DROP_S       (MCI_STRING_OFFSET + 28)
#define MCI_FORMAT_BYTES_S              (MCI_STRING_OFFSET + 29)
#define MCI_FORMAT_SAMPLES_S            (MCI_STRING_OFFSET + 30)
#define MCI_FORMAT_TMSF_S               (MCI_STRING_OFFSET + 31)
 
#define MCI_VD_FORMAT_TRACK_S           (MCI_VD_OFFSET + 5)
 
#define WAVE_FORMAT_PCM_S               (MCI_WAVE_OFFSET + 0)
#define WAVE_MAPPER_S                   (MCI_WAVE_OFFSET + 1)
 
#define MCI_SEQ_MAPPER_S                (MCI_SEQ_OFFSET + 5)
#define MCI_SEQ_FILE_S                  (MCI_SEQ_OFFSET + 6)
#define MCI_SEQ_MIDI_S                  (MCI_SEQ_OFFSET + 7)
#define MCI_SEQ_SMPTE_S                 (MCI_SEQ_OFFSET + 8)
#define MCI_SEQ_FORMAT_SONGPTR_S        (MCI_SEQ_OFFSET + 9)
#define MCI_SEQ_NONE_S                  (MCI_SEQ_OFFSET + 10)
#define MIDIMAPPER_S                    (MCI_SEQ_OFFSET + 11)
 
#define MCI_TABLE_NOT_PRESENT   ((UINT)-1)
' parameters for internal version of MCI_OPEN message sent from
' mciOpenDevice() to the driver
type MCI_OPEN_DRIVER_PARMS field=1
  as MCIDEVICEID wDeviceID             ' device ID
  as LPCWSTR     lpstrParams           ' parameter string for entry in SYSTEM.INI
  as UINT        wCustomCommandTable   ' custom command table ((-1) if none)
                                       ' filled in by the driver
  as UINT        wType                 ' driver type
                                       ' filled in by the driver
end type
type LPMCI_OPEN_DRIVER_PARMS as MCI_OPEN_DRIVER_PARMS ptr
 
' maximum length of an MCI device type
#define MCI_MAX_DEVICE_TYPE_LENGTH 80
 
' flags for mciSendCommandInternal() which direct mciSendString() how to
' interpret the return value
#define MCI_RESOURCE_RETURNED       &H00010000  ' resource ID
#define MCI_COLONIZED3_RETURN       &H00020000  ' colonized ID, 3 bytes data
#define MCI_COLONIZED4_RETURN       &H00040000  ' colonized ID, 4 bytes data
#define MCI_INTEGER_RETURNED        &H00080000  ' integer conversion needed
#define MCI_RESOURCE_DRIVER         &H00100000  ' driver owns returned resource
 
' invalid command table ID
#define MCI_NO_COMMAND_TABLE    (cuint(-1))
 
' command table information type tags
#define MCI_COMMAND_HEAD        0
#define MCI_STRING              1
#define MCI_INTEGER             2
#define MCI_END_COMMAND         3
#define MCI_RETURN              4
#define MCI_FLAG                5
#define MCI_END_COMMAND_LIST    6
#define MCI_RECT                7
#define MCI_CONSTANT            8
#define MCI_END_CONSTANT        9
#define MCI_HWND               10
#define MCI_HPAL               11
#define MCI_HDC                12
 
' function prototypes for MCI driver functions
type mciGetDriverData       as function (wDeviceID as MCIDEVICEID ) as DWORD_PTR
type mciSetDriverData       as function (wDeviceID as MCIDEVICEID, dwData as DWORD_PTR ) as BOOL
type mciDriverYield         as function (wDeviceID as MCIDEVICEID) as UINT
type mciDriverNotify        as function (hwndCallback as HANDLE , wDeviceID as MCIDEVICEID , uStatus as UINT) as UINT
type mciLoadCommandResource as function (hInstance as HANDLE ,lpResName as LPCWSTR, wType as UINT) as UINT
type mciFreeCommandResource as function (wTable as UINT) as BOOL
 
#endif ' ifndef MMNOMCIDEV
 
 
#ifndef MMNOTASKDEV
/'****************************************************************************
                               Task support
****************************************************************************'/
' error return values
#define TASKERR_NOTASKSUPPORT 1
#define TASKERR_OUTOFMEMORY   2
 
' task support function prototypes
type TASKCALLBACK     as sub (dwInst as DWORD_PTR)
type LPTASKCALLBACK   as TASKCALLBACK ptr
type mmTaskCreate     as function (lpfn as LPTASKCALLBACK,lph as HANDLE ptr, dwInst as DWORD_PTR) as UINT
type mmTaskBlock      as sub      (h as DWORD)
type mmTaskSignal     as function (h as DWORD) as BOOL
type mmTaskYield      as sub      ()
type mmGetCurrentTask as function () as DWORD
 
#endif ' endif MMNOTASKDEV


#endif /' __MMDDK_BI__ '/
 