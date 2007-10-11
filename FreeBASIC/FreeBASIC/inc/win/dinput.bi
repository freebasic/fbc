''
''
'' dinput -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dinput_bi__
#define __win_dinput_bi__

#define COM_NO_WINDOWS_H 1
#include once "win/objbase.bi"

#inclib "uuid"

#ifndef DIRECTINPUT_VERSION
#define DIRECTINPUT_VERSION &h0800
#endif

extern CLSID_DirectInput alias "CLSID_DirectInput" as GUID
extern CLSID_DirectInputDevice alias "CLSID_DirectInputDevice" as GUID
extern CLSID_DirectInput8 alias "CLSID_DirectInput8" as GUID
extern CLSID_DirectInputDevice8 alias "CLSID_DirectInputDevice8" as GUID
extern IID_IDirectInputA alias "IID_IDirectInputA" as GUID
extern IID_IDirectInputW alias "IID_IDirectInputW" as GUID
extern IID_IDirectInput2A alias "IID_IDirectInput2A" as GUID
extern IID_IDirectInput2W alias "IID_IDirectInput2W" as GUID
extern IID_IDirectInput7A alias "IID_IDirectInput7A" as GUID
extern IID_IDirectInput7W alias "IID_IDirectInput7W" as GUID
extern IID_IDirectInput8A alias "IID_IDirectInput8A" as GUID
extern IID_IDirectInput8W alias "IID_IDirectInput8W" as GUID
extern IID_IDirectInputDeviceA alias "IID_IDirectInputDeviceA" as GUID
extern IID_IDirectInputDeviceW alias "IID_IDirectInputDeviceW" as GUID
extern IID_IDirectInputDevice2A alias "IID_IDirectInputDevice2A" as GUID
extern IID_IDirectInputDevice2W alias "IID_IDirectInputDevice2W" as GUID
extern IID_IDirectInputDevice7A alias "IID_IDirectInputDevice7A" as GUID
extern IID_IDirectInputDevice7W alias "IID_IDirectInputDevice7W" as GUID
extern IID_IDirectInputDevice8A alias "IID_IDirectInputDevice8A" as GUID
extern IID_IDirectInputDevice8W alias "IID_IDirectInputDevice8W" as GUID
extern IID_IDirectInputEffect alias "IID_IDirectInputEffect" as GUID
extern GUID_XAxis alias "GUID_XAxis" as GUID
extern GUID_YAxis alias "GUID_YAxis" as GUID
extern GUID_ZAxis alias "GUID_ZAxis" as GUID
extern GUID_RxAxis alias "GUID_RxAxis" as GUID
extern GUID_RyAxis alias "GUID_RyAxis" as GUID
extern GUID_RzAxis alias "GUID_RzAxis" as GUID
extern GUID_Slider alias "GUID_Slider" as GUID
extern GUID_Button alias "GUID_Button" as GUID
extern GUID_Key alias "GUID_Key" as GUID
extern GUID_POV alias "GUID_POV" as GUID
extern GUID_Unknown alias "GUID_Unknown" as GUID
extern GUID_SysMouse alias "GUID_SysMouse" as GUID
extern GUID_SysKeyboard alias "GUID_SysKeyboard" as GUID
extern GUID_Joystick alias "GUID_Joystick" as GUID
extern GUID_SysMouseEm alias "GUID_SysMouseEm" as GUID
extern GUID_SysMouseEm2 alias "GUID_SysMouseEm2" as GUID
extern GUID_SysKeyboardEm alias "GUID_SysKeyboardEm" as GUID
extern GUID_SysKeyboardEm2 alias "GUID_SysKeyboardEm2" as GUID
extern GUID_ConstantForce alias "GUID_ConstantForce" as GUID
extern GUID_RampForce alias "GUID_RampForce" as GUID
extern GUID_Square alias "GUID_Square" as GUID
extern GUID_Sine alias "GUID_Sine" as GUID
extern GUID_Triangle alias "GUID_Triangle" as GUID
extern GUID_SawtoothUp alias "GUID_SawtoothUp" as GUID
extern GUID_SawtoothDown alias "GUID_SawtoothDown" as GUID
extern GUID_Spring alias "GUID_Spring" as GUID
extern GUID_Damper alias "GUID_Damper" as GUID
extern GUID_Inertia alias "GUID_Inertia" as GUID
extern GUID_Friction alias "GUID_Friction" as GUID
extern GUID_CustomForce alias "GUID_CustomForce" as GUID

#if DIRECTINPUT_VERSION >= &h0500

#define DIEFT_ALL &h00000000
#define DIEFT_CONSTANTFORCE &h00000001
#define DIEFT_RAMPFORCE &h00000002
#define DIEFT_PERIODIC &h00000003
#define DIEFT_CONDITION &h00000004
#define DIEFT_CUSTOMFORCE &h00000005
#define DIEFT_HARDWARE &h000000FF
#define DIEFT_FFATTACK &h00000200
#define DIEFT_FFFADE &h00000400
#define DIEFT_SATURATION &h00000800
#define DIEFT_POSNEGCOEFFICIENTS &h00001000
#define DIEFT_POSNEGSATURATION &h00002000
#define DIEFT_DEADBAND &h00004000
#define DIEFT_STARTDELAY &h00008000
#define DIEFT_GETTYPE(n)            LOBYTE(n)
#define DI_DEGREES 100
#define DI_FFNOMINALMAX 10000
#define DI_SECONDS 1000000

type DICONSTANTFORCE
	lMagnitude as LONG
end type

type LPDICONSTANTFORCE as DICONSTANTFORCE ptr
type LPCDICONSTANTFORCE as DICONSTANTFORCE ptr

type DIRAMPFORCE
	lStart as LONG
	lEnd as LONG
end type

type LPDIRAMPFORCE as DIRAMPFORCE ptr
type LPCDIRAMPFORCE as DIRAMPFORCE ptr

type DIPERIODIC
	dwMagnitude as DWORD
	lOffset as LONG
	dwPhase as DWORD
	dwPeriod as DWORD
end type

type LPDIPERIODIC as DIPERIODIC ptr
type LPCDIPERIODIC as DIPERIODIC ptr

type DICONDITION
	lOffset as LONG
	lPositiveCoefficient as LONG
	lNegativeCoefficient as LONG
	dwPositiveSaturation as DWORD
	dwNegativeSaturation as DWORD
	lDeadBand as LONG
end type

type LPDICONDITION as DICONDITION ptr
type LPCDICONDITION as DICONDITION ptr

type DICUSTOMFORCE
	cChannels as DWORD
	dwSamplePeriod as DWORD
	cSamples as DWORD
	rglForceData as LPLONG
end type

type LPDICUSTOMFORCE as DICUSTOMFORCE ptr
type LPCDICUSTOMFORCE as DICUSTOMFORCE ptr

type DIENVELOPE
	dwSize as DWORD
	dwAttackLevel as DWORD
	dwAttackTime as DWORD
	dwFadeLevel as DWORD
	dwFadeTime as DWORD
end type

type LPDIENVELOPE as DIENVELOPE ptr
type LPCDIENVELOPE as DIENVELOPE ptr

type DIEFFECT_DX5
	dwSize as DWORD
	dwFlags as DWORD
	dwDuration as DWORD
	dwSamplePeriod as DWORD
	dwGain as DWORD
	dwTriggerButton as DWORD
	dwTriggerRepeatInterval as DWORD
	cAxes as DWORD
	rgdwAxes as LPDWORD
	rglDirection as LPLONG
	lpEnvelope as LPDIENVELOPE
	cbTypeSpecificParams as DWORD
	lpvTypeSpecificParams as LPVOID
end type

type LPDIEFFECT_DX5 as DIEFFECT_DX5 ptr
type LPCDIEFFECT_DX5 as DIEFFECT_DX5 ptr

type DIEFFECT
	dwSize as DWORD
	dwFlags as DWORD
	dwDuration as DWORD
	dwSamplePeriod as DWORD
	dwGain as DWORD
	dwTriggerButton as DWORD
	dwTriggerRepeatInterval as DWORD
	cAxes as DWORD
	rgdwAxes as LPDWORD
	rglDirection as LPLONG
	lpEnvelope as LPDIENVELOPE
	cbTypeSpecificParams as DWORD
	lpvTypeSpecificParams as LPVOID
	dwStartDelay as DWORD
end type

type LPDIEFFECT as DIEFFECT ptr
type DIEFFECT_DX6 as DIEFFECT
type LPDIEFFECT_DX6 as LPDIEFFECT
type LPCDIEFFECT as DIEFFECT ptr

type DIFILEEFFECT
	dwSize as DWORD
	GuidEffect as GUID
	lpDiEffect as LPCDIEFFECT
	szFriendlyName as zstring * 260
end type

type LPDIFILEEFFECT as DIFILEEFFECT ptr
type LPCDIFILEEFFECT as DIFILEEFFECT ptr
type LPDIENUMEFFECTSINFILECALLBACK as function (byval as LPCDIFILEEFFECT, byval as LPVOID) as BOOL

#define DIEFF_OBJECTIDS &h00000001
#define DIEFF_OBJECTOFFSETS &h00000002
#define DIEFF_CARTESIAN &h00000010
#define DIEFF_POLAR &h00000020
#define DIEFF_SPHERICAL &h00000040
#define DIEP_DURATION &h00000001
#define DIEP_SAMPLEPERIOD &h00000002
#define DIEP_GAIN &h00000004
#define DIEP_TRIGGERBUTTON &h00000008
#define DIEP_TRIGGERREPEATINTERVAL &h00000010
#define DIEP_AXES &h00000020
#define DIEP_DIRECTION &h00000040
#define DIEP_ENVELOPE &h00000080
#define DIEP_TYPESPECIFICPARAMS &h00000100
#define DIEP_STARTDELAY &h00000200
#define DIEP_ALLPARAMS_DX5 &h000001FF
#define DIEP_ALLPARAMS &h000003FF
#define DIEP_START &h20000000
#define DIEP_NORESTART &h40000000
#define DIEP_NODOWNLOAD &h80000000
#define DIEB_NOTRIGGER &hFFFFFFFF
#define DIES_SOLO &h00000001
#define DIES_NODOWNLOAD &h80000000
#define DIEGES_PLAYING &h00000001
#define DIEGES_EMULATED &h00000002

type DIEFFESCAPE
	dwSize as DWORD
	dwCommand as DWORD
	lpvInBuffer as LPVOID
	cbInBuffer as DWORD
	lpvOutBuffer as LPVOID
	cbOutBuffer as DWORD
end type

type LPDIEFFESCAPE as DIEFFESCAPE ptr

type IDirectInputEffectVtbl_ as IDirectInputEffectVtbl

type IDirectInputEffect
	lpVtbl as IDirectInputEffectVtbl_ ptr
end type

type IDirectInputEffectVtbl
	QueryInterface as function (byval as IDirectInputEffect ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputEffect ptr) as ULONG
	Release as function (byval as IDirectInputEffect ptr) as ULONG
	Initialize as function (byval as IDirectInputEffect ptr, byval as HINSTANCE, byval as DWORD, byval as GUID ptr) as HRESULT
	GetEffectGuid as function (byval as IDirectInputEffect ptr, byval as LPGUID) as HRESULT
	GetParameters as function (byval as IDirectInputEffect ptr, byval as LPDIEFFECT, byval as DWORD) as HRESULT
	SetParameters as function (byval as IDirectInputEffect ptr, byval as LPCDIEFFECT, byval as DWORD) as HRESULT
	Start as function (byval as IDirectInputEffect ptr, byval as DWORD, byval as DWORD) as HRESULT
	Stop as function (byval as IDirectInputEffect ptr) as HRESULT
	GetEffectStatus as function (byval as IDirectInputEffect ptr, byval as LPDWORD) as HRESULT
	Download as function (byval as IDirectInputEffect ptr) as HRESULT
	Unload as function (byval as IDirectInputEffect ptr) as HRESULT
	Escape as function (byval as IDirectInputEffect ptr, byval as LPDIEFFESCAPE) as HRESULT
end type

#define IDirectInputEffect_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectInputEffect_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectInputEffect_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInputEffect_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectInputEffect_GetEffectGuid(p,a) (p)->lpVtbl->GetEffectGuid(p,a)
#define IDirectInputEffect_GetParameters(p,a,b) (p)->lpVtbl->GetParameters(p,a,b)
#define IDirectInputEffect_SetParameters(p,a,b) (p)->lpVtbl->SetParameters(p,a,b)
#define IDirectInputEffect_Start(p,a,b) (p)->lpVtbl->Start(p,a,b)
#define IDirectInputEffect_Stop(p) (p)->lpVtbl->Stop(p)
#define IDirectInputEffect_GetEffectStatus(p,a) (p)->lpVtbl->GetEffectStatus(p,a)
#define IDirectInputEffect_Download(p) (p)->lpVtbl->Download(p)
#define IDirectInputEffect_Unload(p) (p)->lpVtbl->Unload(p)
#define IDirectInputEffect_Escape(p,a) (p)->lpVtbl->Escape(p,a)

type LPDIRECTINPUTEFFECT as IDirectInputEffect ptr

#endif ''DIRECTINPUT_VERSION >= &h0500

#if DIRECTINPUT_VERSION <= &h700
#define DIDEVTYPE_DEVICE        1
#define DIDEVTYPE_MOUSE         2
#define DIDEVTYPE_KEYBOARD      3
#define DIDEVTYPE_JOYSTICK      4
#else
#define DI8DEVCLASS_ALL 0
#define DI8DEVCLASS_DEVICE 1
#define DI8DEVCLASS_POINTER 2
#define DI8DEVCLASS_KEYBOARD 3
#define DI8DEVCLASS_GAMECTRL 4
#define DI8DEVTYPE_DEVICE &h11
#define DI8DEVTYPE_MOUSE &h12
#define DI8DEVTYPE_KEYBOARD &h13
#define DI8DEVTYPE_JOYSTICK &h14
#define DI8DEVTYPE_GAMEPAD &h15
#define DI8DEVTYPE_DRIVING &h16
#define DI8DEVTYPE_FLIGHT &h17
#define DI8DEVTYPE_1STPERSON &h18
#define DI8DEVTYPE_DEVICECTRL &h19
#define DI8DEVTYPE_SCREENPOINTER &h1A
#define DI8DEVTYPE_REMOTE &h1B
#define DI8DEVTYPE_SUPPLEMENTAL &h1C
#endif

#if DIRECTINPUT_VERSION <= &h700
#define DIDEVTYPEMOUSE_UNKNOWN          1
#define DIDEVTYPEMOUSE_TRADITIONAL      2
#define DIDEVTYPEMOUSE_FINGERSTICK      3
#define DIDEVTYPEMOUSE_TOUCHPAD         4
#define DIDEVTYPEMOUSE_TRACKBALL        5
#define DIDEVTYPEKEYBOARD_UNKNOWN       0
#define DIDEVTYPEKEYBOARD_PCXT          1
#define DIDEVTYPEKEYBOARD_OLIVETTI      2
#define DIDEVTYPEKEYBOARD_PCAT          3
#define DIDEVTYPEKEYBOARD_PCENH         4
#define DIDEVTYPEKEYBOARD_NOKIA1050     5
#define DIDEVTYPEKEYBOARD_NOKIA9140     6
#define DIDEVTYPEKEYBOARD_NEC98         7
#define DIDEVTYPEKEYBOARD_NEC98LAPTOP   8
#define DIDEVTYPEKEYBOARD_NEC98106      9
#define DIDEVTYPEKEYBOARD_JAPAN106     10
#define DIDEVTYPEKEYBOARD_JAPANAX      11
#define DIDEVTYPEKEYBOARD_J3100        12
#define DIDEVTYPEJOYSTICK_UNKNOWN       1
#define DIDEVTYPEJOYSTICK_TRADITIONAL   2
#define DIDEVTYPEJOYSTICK_FLIGHTSTICK   3
#define DIDEVTYPEJOYSTICK_GAMEPAD       4
#define DIDEVTYPEJOYSTICK_RUDDER        5
#define DIDEVTYPEJOYSTICK_WHEEL         6
#define DIDEVTYPEJOYSTICK_HEADTRACKER   7
#else
#define DIDEVTYPE_HID &h00010000
#define DI8DEVTYPEMOUSE_UNKNOWN 1
#define DI8DEVTYPEMOUSE_TRADITIONAL 2
#define DI8DEVTYPEMOUSE_FINGERSTICK 3
#define DI8DEVTYPEMOUSE_TOUCHPAD 4
#define DI8DEVTYPEMOUSE_TRACKBALL 5
#define DI8DEVTYPEMOUSE_ABSOLUTE 6
#define DI8DEVTYPEKEYBOARD_UNKNOWN 0
#define DI8DEVTYPEKEYBOARD_PCXT 1
#define DI8DEVTYPEKEYBOARD_OLIVETTI 2
#define DI8DEVTYPEKEYBOARD_PCAT 3
#define DI8DEVTYPEKEYBOARD_PCENH 4
#define DI8DEVTYPEKEYBOARD_NOKIA1050 5
#define DI8DEVTYPEKEYBOARD_NOKIA9140 6
#define DI8DEVTYPEKEYBOARD_NEC98 7
#define DI8DEVTYPEKEYBOARD_NEC98LAPTOP 8
#define DI8DEVTYPEKEYBOARD_NEC98106 9
#define DI8DEVTYPEKEYBOARD_JAPAN106 10
#define DI8DEVTYPEKEYBOARD_JAPANAX 11
#define DI8DEVTYPEKEYBOARD_J3100 12
#define DI8DEVTYPE_LIMITEDGAMESUBTYPE 1
#define DI8DEVTYPEJOYSTICK_LIMITED 1
#define DI8DEVTYPEJOYSTICK_STANDARD 2
#define DI8DEVTYPEGAMEPAD_LIMITED 1
#define DI8DEVTYPEGAMEPAD_STANDARD 2
#define DI8DEVTYPEGAMEPAD_TILT 3
#define DI8DEVTYPEDRIVING_LIMITED 1
#define DI8DEVTYPEDRIVING_COMBINEDPEDALS 2
#define DI8DEVTYPEDRIVING_DUALPEDALS 3
#define DI8DEVTYPEDRIVING_THREEPEDALS 4
#define DI8DEVTYPEDRIVING_HANDHELD 5
#define DI8DEVTYPEFLIGHT_LIMITED 1
#define DI8DEVTYPEFLIGHT_STICK 2
#define DI8DEVTYPEFLIGHT_YOKE 3
#define DI8DEVTYPEFLIGHT_RC 4
#define DI8DEVTYPE1STPERSON_LIMITED 1
#define DI8DEVTYPE1STPERSON_UNKNOWN 2
#define DI8DEVTYPE1STPERSON_SIXDOF 3
#define DI8DEVTYPE1STPERSON_SHOOTER 4
#define DI8DEVTYPESCREENPTR_UNKNOWN 2
#define DI8DEVTYPESCREENPTR_LIGHTGUN 3
#define DI8DEVTYPESCREENPTR_LIGHTPEN 4
#define DI8DEVTYPESCREENPTR_TOUCH 5
#define DI8DEVTYPEREMOTE_UNKNOWN 2
#define DI8DEVTYPEDEVICECTRL_UNKNOWN 2
#define DI8DEVTYPEDEVICECTRL_COMMSSELECTION 3
#define DI8DEVTYPEDEVICECTRL_COMMSSELECTION_HARDWIRED 4
#define DI8DEVTYPESUPPLEMENTAL_UNKNOWN 2
#define DI8DEVTYPESUPPLEMENTAL_2NDHANDCONTROLLER 3
#define DI8DEVTYPESUPPLEMENTAL_HEADTRACKER 4
#define DI8DEVTYPESUPPLEMENTAL_HANDTRACKER 5
#define DI8DEVTYPESUPPLEMENTAL_SHIFTSTICKGATE 6
#define DI8DEVTYPESUPPLEMENTAL_SHIFTER 7
#define DI8DEVTYPESUPPLEMENTAL_THROTTLE 8
#define DI8DEVTYPESUPPLEMENTAL_SPLITTHROTTLE 9
#define DI8DEVTYPESUPPLEMENTAL_COMBINEDPEDALS 10
#define DI8DEVTYPESUPPLEMENTAL_DUALPEDALS 11
#define DI8DEVTYPESUPPLEMENTAL_THREEPEDALS 12
#define DI8DEVTYPESUPPLEMENTAL_RUDDERPEDALS 13
#endif

#define GET_DIDEVICE_TYPE(dwDevType)    LOBYTE(dwDevType)
#define GET_DIDEVICE_SUBTYPE(dwDevType) HIBYTE(dwDevType)

type DIDEVCAPS_DX3
	dwSize as DWORD
	dwFlags as DWORD
	dwDevType as DWORD
	dwAxes as DWORD
	dwButtons as DWORD
	dwPOVs as DWORD
end type

type LPDIDEVCAPS_DX3 as DIDEVCAPS_DX3 ptr

type DIDEVCAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwDevType as DWORD
	dwAxes as DWORD
	dwButtons as DWORD
	dwPOVs as DWORD
	dwFFSamplePeriod as DWORD
	dwFFMinTimeResolution as DWORD
	dwFirmwareRevision as DWORD
	dwHardwareRevision as DWORD
	dwFFDriverVersion as DWORD
end type

type LPDIDEVCAPS as DIDEVCAPS ptr

#define DIDC_ATTACHED &h00000001
#define DIDC_POLLEDDEVICE &h00000002
#define DIDC_EMULATED &h00000004
#define DIDC_POLLEDDATAFORMAT &h00000008
#define DIDC_FORCEFEEDBACK &h00000100
#define DIDC_FFATTACK &h00000200
#define DIDC_FFFADE &h00000400
#define DIDC_SATURATION &h00000800
#define DIDC_POSNEGCOEFFICIENTS &h00001000
#define DIDC_POSNEGSATURATION &h00002000
#define DIDC_DEADBAND &h00004000
#define DIDC_STARTDELAY &h00008000
#define DIDC_ALIAS &h00010000
#define DIDC_PHANTOM &h00020000
#define DIDC_HIDDEN &h00040000
#define DIDFT_ALL &h00000000
#define DIDFT_RELAXIS &h00000001
#define DIDFT_ABSAXIS &h00000002
#define DIDFT_AXIS &h00000003
#define DIDFT_PSHBUTTON &h00000004
#define DIDFT_TGLBUTTON &h00000008
#define DIDFT_BUTTON &h0000000C
#define DIDFT_POV &h00000010
#define DIDFT_COLLECTION &h00000040
#define DIDFT_NODATA &h00000080
#define DIDFT_ANYINSTANCE &h00FFFF00
#define DIDFT_MAKEINSTANCE(n) (cuint(n) shl 8)
#define DIDFT_GETTYPE(n)     LOBYTE(n)
#define DIDFT_GETINSTANCE(n) LOWORD((n) shr 8)
#define DIDFT_INSTANCEMASK &h00FFFF00
#define DIDFT_FFACTUATOR &h01000000
#define DIDFT_FFEFFECTTRIGGER &h02000000
#define DIDFT_OUTPUT &h10000000
#define DIDFT_VENDORDEFINED &h04000000
#define DIDFT_ALIAS &h08000000
#define DIDFT_OPTIONAL &h80000000
#define DIDFT_ENUMCOLLECTION(n) (cuint(n) shl 8)
#define DIDFT_NOCOLLECTION &h00FFFF00

type DIOBJECTDATAFORMAT
	pguid as GUID ptr
	dwOfs as DWORD
	dwType as DWORD
	dwFlags as DWORD
end type

type LPDIOBJECTDATAFORMAT as DIOBJECTDATAFORMAT ptr
type LPCDIOBJECTDATAFORMAT as DIOBJECTDATAFORMAT ptr

type DIDATAFORMAT
	dwSize as DWORD
	dwObjSize as DWORD
	dwFlags as DWORD
	dwDataSize as DWORD
	dwNumObjs as DWORD
	rgodf as LPDIOBJECTDATAFORMAT
end type

type LPDIDATAFORMAT as DIDATAFORMAT ptr
type LPCDIDATAFORMAT as DIDATAFORMAT ptr

#define DIDF_ABSAXIS &h00000001
#define DIDF_RELAXIS &h00000002

extern c_dfDIMouse alias "c_dfDIMouse" as DIDATAFORMAT
extern c_dfDIMouse2 alias "c_dfDIMouse2" as DIDATAFORMAT
extern c_dfDIKeyboard alias "c_dfDIKeyboard" as DIDATAFORMAT
extern c_dfDIJoystick alias "c_dfDIJoystick" as DIDATAFORMAT
extern c_dfDIJoystick2 alias "c_dfDIJoystick2" as DIDATAFORMAT

#ifndef UNICODE
type DIACTIONA
	uAppData as UINT_PTR
	dwSemantic as DWORD
	dwFlags as DWORD
	guidInstance as GUID
	dwObjID as DWORD
	dwHow as DWORD
end type

type LPDIACTIONA as DIACTIONA ptr
type DIACTION as DIACTIONA
type LPDIACTION as LPDIACTIONA

#else
type DIACTIONW
	uAppData as UINT_PTR
	dwSemantic as DWORD
	dwFlags as DWORD
	guidInstance as GUID
	dwObjID as DWORD
	dwHow as DWORD
end type

type LPDIACTIONW as DIACTIONW ptr
type DIACTION as DIACTIONW
type LPDIACTION as LPDIACTIONW

#endif

type LPCDIACTION as DIACTION ptr

#define DIA_FORCEFEEDBACK &h00000001
#define DIA_APPMAPPED &h00000002
#define DIA_APPNOMAP &h00000004
#define DIA_NORANGE &h00000008
#define DIA_APPFIXED &h00000010
#define DIAH_UNMAPPED &h00000000
#define DIAH_USERCONFIG &h00000001
#define DIAH_APPREQUESTED &h00000002
#define DIAH_HWAPP &h00000004
#define DIAH_HWDEFAULT &h00000008
#define DIAH_DEFAULT &h00000020
#define DIAH_ERROR &h80000000

#ifndef UNICODE
type DIACTIONFORMATA
	dwSize as DWORD
	dwActionSize as DWORD
	dwDataSize as DWORD
	dwNumActions as DWORD
	rgoAction as LPDIACTIONA
	guidActionMap as GUID
	dwGenre as DWORD
	dwBufferSize as DWORD
	lAxisMin as LONG
	lAxisMax as LONG
	hInstString as HINSTANCE
	ftTimeStamp as FILETIME
	dwCRC as DWORD
	tszActionMap as zstring * 260
end type

type LPDIACTIONFORMATA as DIACTIONFORMATA ptr

type DIACTIONFORMAT as DIACTIONFORMATA
type LPDIACTIONFORMAT as LPDIACTIONFORMATA
type LPCDIACTIONFORMATA as DIACTIONFORMATA ptr

#else
type DIACTIONFORMATW
	dwSize as DWORD
	dwActionSize as DWORD
	dwDataSize as DWORD
	dwNumActions as DWORD
	rgoAction as LPDIACTIONW
	guidActionMap as GUID
	dwGenre as DWORD
	dwBufferSize as DWORD
	lAxisMin as LONG
	lAxisMax as LONG
	hInstString as HINSTANCE
	ftTimeStamp as FILETIME
	dwCRC as DWORD
	tszActionMap as wstring * 260
end type

type LPDIACTIONFORMATW as DIACTIONFORMATW ptr

type DIACTIONFORMAT as DIACTIONFORMATW
type LPDIACTIONFORMAT as LPDIACTIONFORMATW
type LPCDIACTIONFORMATW as DIACTIONFORMATW ptr
#endif

type LPCDIACTIONFORMAT as DIACTIONFORMAT ptr

#define DIAFTS_NEWDEVICELOW &hFFFFFFFF
#define DIAFTS_NEWDEVICEHIGH &hFFFFFFFF
#define DIAFTS_UNUSEDDEVICELOW &h00000000
#define DIAFTS_UNUSEDDEVICEHIGH &h00000000
#define DIDBAM_DEFAULT &h00000000
#define DIDBAM_PRESERVE &h00000001
#define DIDBAM_INITIALIZE &h00000002
#define DIDBAM_HWDEFAULTS &h00000004
#define DIDSAM_DEFAULT &h00000000
#define DIDSAM_NOUSER &h00000001
#define DIDSAM_FORCESAVE &h00000002
#define DICD_DEFAULT &h00000000
#define DICD_EDIT &h00000001

type D3DCOLOR as DWORD

type DICOLORSET
	dwSize as DWORD
	cTextFore as D3DCOLOR
	cTextHighlight as D3DCOLOR
	cCalloutLine as D3DCOLOR
	cCalloutHighlight as D3DCOLOR
	cBorder as D3DCOLOR
	cControlFill as D3DCOLOR
	cHighlightFill as D3DCOLOR
	cAreaFill as D3DCOLOR
end type

type LPDICOLORSET as DICOLORSET ptr
type LPCDICOLORSET as DICOLORSET ptr

#ifndef UNICODE
type DICONFIGUREDEVICESPARAMSA
	dwSize as DWORD
	dwcUsers as DWORD
	lptszUserNames as LPSTR
	dwcFormats as DWORD
	lprgFormats as LPDIACTIONFORMATA
	hwnd as HWND
	dics as DICOLORSET
	lpUnkDDSTarget as IUnknown ptr
end type

type LPDICONFIGUREDEVICESPARAMSA as DICONFIGUREDEVICESPARAMSA ptr

type DICONFIGUREDEVICESPARAMS as DICONFIGUREDEVICESPARAMSA
type LPDICONFIGUREDEVICESPARAMS as LPDICONFIGUREDEVICESPARAMSA
type LPCDICONFIGUREDEVICESPARAMSA as DICONFIGUREDEVICESPARAMSA ptr

#else
type DICONFIGUREDEVICESPARAMSW
	dwSize as DWORD
	dwcUsers as DWORD
	lptszUserNames as LPWSTR
	dwcFormats as DWORD
	lprgFormats as LPDIACTIONFORMATW
	hwnd as HWND
	dics as DICOLORSET
	lpUnkDDSTarget as IUnknown ptr
end type

type LPDICONFIGUREDEVICESPARAMSW as DICONFIGUREDEVICESPARAMSW ptr

type DICONFIGUREDEVICESPARAMS as DICONFIGUREDEVICESPARAMSW
type LPDICONFIGUREDEVICESPARAMS as LPDICONFIGUREDEVICESPARAMSW
type LPCDICONFIGUREDEVICESPARAMSW as DICONFIGUREDEVICESPARAMSW ptr
#endif

type LPCDICONFIGUREDEVICESPARAMS as DICONFIGUREDEVICESPARAMS ptr

#define DIDIFT_CONFIGURATION &h00000001
#define DIDIFT_OVERLAY &h00000002
#define DIDAL_CENTERED &h00000000
#define DIDAL_LEFTALIGNED &h00000001
#define DIDAL_RIGHTALIGNED &h00000002
#define DIDAL_MIDDLE &h00000000
#define DIDAL_TOPALIGNED &h00000004
#define DIDAL_BOTTOMALIGNED &h00000008

#ifndef UNICODE
type DIDEVICEIMAGEINFOA
	tszImagePath as zstring * 260
	dwFlags as DWORD
	dwViewID as DWORD
	rcOverlay as RECT
	dwObjID as DWORD
	dwcValidPts as DWORD
	rgptCalloutLine(0 to 5-1) as POINT
	rcCalloutRect as RECT
	dwTextAlign as DWORD
end type

type LPDIDEVICEIMAGEINFOA as DIDEVICEIMAGEINFOA ptr

type DIDEVICEIMAGEINFO as DIDEVICEIMAGEINFOA
type LPDIDEVICEIMAGEINFO as LPDIDEVICEIMAGEINFOA
type LPCDIDEVICEIMAGEINFOA as DIDEVICEIMAGEINFOA ptr

type DIDEVICEIMAGEINFOHEADERA
	dwSize as DWORD
	dwSizeImageInfo as DWORD
	dwcViews as DWORD
	dwcButtons as DWORD
	dwcAxes as DWORD
	dwcPOVs as DWORD
	dwBufferSize as DWORD
	dwBufferUsed as DWORD
	lprgImageInfoArray as LPDIDEVICEIMAGEINFOA
end type

type LPDIDEVICEIMAGEINFOHEADERA as DIDEVICEIMAGEINFOHEADERA ptr
type LPCDIDEVICEIMAGEINFOHEADERA as DIDEVICEIMAGEINFOHEADERA ptr
type DIDEVICEIMAGEINFOHEADER as DIDEVICEIMAGEINFOHEADERA
type LPDIDEVICEIMAGEINFOHEADER as LPDIDEVICEIMAGEINFOHEADERA

#else
type DIDEVICEIMAGEINFOW
	tszImagePath as wstring * 260
	dwFlags as DWORD
	dwViewID as DWORD
	rcOverlay as RECT
	dwObjID as DWORD
	dwcValidPts as DWORD
	rgptCalloutLine(0 to 5-1) as POINT
	rcCalloutRect as RECT
	dwTextAlign as DWORD
end type

type LPDIDEVICEIMAGEINFOW as DIDEVICEIMAGEINFOW ptr

type DIDEVICEIMAGEINFO as DIDEVICEIMAGEINFOW
type LPDIDEVICEIMAGEINFO as LPDIDEVICEIMAGEINFOW
type LPCDIDEVICEIMAGEINFOW as DIDEVICEIMAGEINFOW ptr

type DIDEVICEIMAGEINFOHEADERW
	dwSize as DWORD
	dwSizeImageInfo as DWORD
	dwcViews as DWORD
	dwcButtons as DWORD
	dwcAxes as DWORD
	dwcPOVs as DWORD
	dwBufferSize as DWORD
	dwBufferUsed as DWORD
	lprgImageInfoArray as LPDIDEVICEIMAGEINFOW
end type

type LPDIDEVICEIMAGEINFOHEADERW as DIDEVICEIMAGEINFOHEADERW ptr
type LPCDIDEVICEIMAGEINFOHEADERW as DIDEVICEIMAGEINFOHEADERW ptr
type DIDEVICEIMAGEINFOHEADER as DIDEVICEIMAGEINFOHEADERW
type LPDIDEVICEIMAGEINFOHEADER as LPDIDEVICEIMAGEINFOHEADERW

#endif

type LPCDIDEVICEIMAGEINFO as DIDEVICEIMAGEINFO ptr
type LPCDIDEVICEIMAGEINFOHEADER as DIDEVICEIMAGEINFOHEADER ptr

#ifndef UNICODE
type DIDEVICEOBJECTINSTANCE_DX3A
	dwSize as DWORD
	guidType as GUID
	dwOfs as DWORD
	dwType as DWORD
	dwFlags as DWORD
	tszName as zstring * 260
end type

type LPDIDEVICEOBJECTINSTANCE_DX3A as DIDEVICEOBJECTINSTANCE_DX3A ptr
type LPCDIDEVICEOBJECTINSTANCE_DX3A as DIDEVICEOBJECTINSTANCE_DX3A ptr
type DIDEVICEOBJECTINSTANCE_DX3 as DIDEVICEOBJECTINSTANCE_DX3A
type LPDIDEVICEOBJECTINSTANCE_DX3 as LPDIDEVICEOBJECTINSTANCE_DX3A

#else
type DIDEVICEOBJECTINSTANCE_DX3W
	dwSize as DWORD
	guidType as GUID
	dwOfs as DWORD
	dwType as DWORD
	dwFlags as DWORD
	tszName as wstring * 260
end type

type LPDIDEVICEOBJECTINSTANCE_DX3W as DIDEVICEOBJECTINSTANCE_DX3W ptr
type LPCDIDEVICEOBJECTINSTANCE_DX3W as DIDEVICEOBJECTINSTANCE_DX3W ptr
type DIDEVICEOBJECTINSTANCE_DX3 as DIDEVICEOBJECTINSTANCE_DX3W
type LPDIDEVICEOBJECTINSTANCE_DX3 as LPDIDEVICEOBJECTINSTANCE_DX3W
#endif

type LPCDIDEVICEOBJECTINSTANCE_DX3 as DIDEVICEOBJECTINSTANCE_DX3 ptr

#ifndef UNICODE
type DIDEVICEOBJECTINSTANCEA
	dwSize as DWORD
	guidType as GUID
	dwOfs as DWORD
	dwType as DWORD
	dwFlags as DWORD
	tszName as zstring * 260
	dwFFMaxForce as DWORD
	dwFFForceResolution as DWORD
	wCollectionNumber as WORD
	wDesignatorIndex as WORD
	wUsagePage as WORD
	wUsage as WORD
	dwDimension as DWORD
	wExponent as WORD
	wReportId as WORD
end type

type LPDIDEVICEOBJECTINSTANCEA as DIDEVICEOBJECTINSTANCEA ptr
type LPCDIDEVICEOBJECTINSTANCEA as DIDEVICEOBJECTINSTANCEA ptr
type LPDIENUMDEVICEOBJECTSCALLBACKA as function (byval as LPCDIDEVICEOBJECTINSTANCEA, byval as LPVOID) as BOOL
type DIDEVICEOBJECTINSTANCE as DIDEVICEOBJECTINSTANCEA
type LPDIDEVICEOBJECTINSTANCE as LPDIDEVICEOBJECTINSTANCEA

#else
type DIDEVICEOBJECTINSTANCEW
	dwSize as DWORD
	guidType as GUID
	dwOfs as DWORD
	dwType as DWORD
	dwFlags as DWORD
	tszName as wstring * 260
	dwFFMaxForce as DWORD
	dwFFForceResolution as DWORD
	wCollectionNumber as WORD
	wDesignatorIndex as WORD
	wUsagePage as WORD
	wUsage as WORD
	dwDimension as DWORD
	wExponent as WORD
	wReportId as WORD
end type

type LPDIDEVICEOBJECTINSTANCEW as DIDEVICEOBJECTINSTANCEW ptr
type LPCDIDEVICEOBJECTINSTANCEW as DIDEVICEOBJECTINSTANCEW ptr
type LPDIENUMDEVICEOBJECTSCALLBACKW as function (byval as LPCDIDEVICEOBJECTINSTANCEW, byval as LPVOID) as BOOL
type DIDEVICEOBJECTINSTANCE as DIDEVICEOBJECTINSTANCEW
type LPDIDEVICEOBJECTINSTANCE as LPDIDEVICEOBJECTINSTANCEW
#endif

type LPCDIDEVICEOBJECTINSTANCE as DIDEVICEOBJECTINSTANCE ptr

#define DIDOI_FFACTUATOR &h00000001
#define DIDOI_FFEFFECTTRIGGER &h00000002
#define DIDOI_POLLED &h00008000
#define DIDOI_ASPECTPOSITION &h00000100
#define DIDOI_ASPECTVELOCITY &h00000200
#define DIDOI_ASPECTACCEL &h00000300
#define DIDOI_ASPECTFORCE &h00000400
#define DIDOI_ASPECTMASK &h00000F00
#define DIDOI_GUIDISUSAGE &h00010000

type DIPROPHEADER
	dwSize as DWORD
	dwHeaderSize as DWORD
	dwObj as DWORD
	dwHow as DWORD
end type

type LPDIPROPHEADER as DIPROPHEADER ptr
type LPCDIPROPHEADER as DIPROPHEADER ptr

#define DIPH_DEVICE 0
#define DIPH_BYOFFSET 1
#define DIPH_BYID 2
#define DIPH_BYUSAGE 3

type DIPROPDWORD
	diph as DIPROPHEADER
	dwData as DWORD
end type

type LPDIPROPDWORD as DIPROPDWORD ptr
type LPCDIPROPDWORD as DIPROPDWORD ptr

type DIPROPPOINTER
	diph as DIPROPHEADER
	uData as UINT_PTR
end type

type LPDIPROPPOINTER as DIPROPPOINTER ptr
type LPCDIPROPPOINTER as DIPROPPOINTER ptr

type DIPROPRANGE
	diph as DIPROPHEADER
	lMin as LONG
	lMax as LONG
end type

type LPDIPROPRANGE as DIPROPRANGE ptr
type LPCDIPROPRANGE as DIPROPRANGE ptr

type DIPROPCAL
	diph as DIPROPHEADER
	lMin as LONG
	lCenter as LONG
	lMax as LONG
end type

type LPDIPROPCAL as DIPROPCAL ptr
type LPCDIPROPCAL as DIPROPCAL ptr

type DIPROPCALPOV
	diph as DIPROPHEADER
	lMin(0 to 5-1) as LONG
	lMax(0 to 5-1) as LONG
end type

type LPDIPROPCALPOV as DIPROPCALPOV ptr
type LPCDIPROPCALPOV as DIPROPCALPOV ptr

type DIPROPGUIDANDPATH
	diph as DIPROPHEADER
	guidClass as GUID
	wszPath as wstring * 260
end type

type LPDIPROPGUIDANDPATH as DIPROPGUIDANDPATH ptr
type LPCDIPROPGUIDANDPATH as DIPROPGUIDANDPATH ptr

type DIPROPSTRING
	diph as DIPROPHEADER
	wsz as wstring * 260
end type

type LPDIPROPSTRING as DIPROPSTRING ptr
type LPCDIPROPSTRING as DIPROPSTRING ptr

#define MAXCPOINTSNUM 8

type CPOINT
	lP as LONG
	dwLog as DWORD
end type

type PCPOINT as CPOINT ptr

type DIPROPCPOINTS
	diph as DIPROPHEADER
	dwCPointsNum as DWORD
	cp(0 to 8-1) as CPOINT
end type

type LPDIPROPCPOINTS as DIPROPCPOINTS ptr
type LPCDIPROPCPOINTS as DIPROPCPOINTS ptr

#define MAKEDIPROP(prop) cast(REFGUID, prop)

#define DIPROP_BUFFERSIZE MAKEDIPROP(1)
#define DIPROP_AXISMODE MAKEDIPROP(2)
#define DIPROPAXISMODE_ABS      0
#define DIPROPAXISMODE_REL      1
#define DIPROP_GRANULARITY MAKEDIPROP(3)
#define DIPROP_RANGE MAKEDIPROP(4)
#define DIPROP_DEADZONE MAKEDIPROP(5)
#define DIPROP_SATURATION MAKEDIPROP(6)
#define DIPROP_FFGAIN MAKEDIPROP(7)
#define DIPROP_FFLOAD MAKEDIPROP(8)
#define DIPROP_AUTOCENTER MAKEDIPROP(9)
#define DIPROPAUTOCENTER_OFF    0
#define DIPROPAUTOCENTER_ON     1
#define DIPROP_CALIBRATIONMODE MAKEDIPROP(10)
#define DIPROPCALIBRATIONMODE_COOKED    0
#define DIPROPCALIBRATIONMODE_RAW       1
#define DIPROP_CALIBRATION MAKEDIPROP(11)
#define DIPROP_GUIDANDPATH MAKEDIPROP(12)
#define DIPROP_INSTANCENAME MAKEDIPROP(13)
#define DIPROP_PRODUCTNAME MAKEDIPROP(14)
#define DIPROP_JOYSTICKID MAKEDIPROP(15)
#define DIPROP_GETPORTDISPLAYNAME MAKEDIPROP(16)
#define DIPROP_PHYSICALRANGE MAKEDIPROP(18)
#define DIPROP_LOGICALRANGE MAKEDIPROP(19)
#define DIPROP_KEYNAME MAKEDIPROP(20)
#define DIPROP_CPOINTS MAKEDIPROP(21)
#define DIPROP_APPDATA MAKEDIPROP(22)
#define DIPROP_SCANCODE MAKEDIPROP(23)
#define DIPROP_VIDPID MAKEDIPROP(24)
#define DIPROP_USERNAME MAKEDIPROP(25)
#define DIPROP_TYPENAME MAKEDIPROP(26)

type DIDEVICEOBJECTDATA_DX3
	dwOfs as DWORD
	dwData as DWORD
	dwTimeStamp as DWORD
	dwSequence as DWORD
end type

type LPDIDEVICEOBJECTDATA_DX3 as DIDEVICEOBJECTDATA_DX3 ptr
type LPCDIDEVICEOBJECTDATA_DX as DIDEVICEOBJECTDATA_DX3 ptr

type DIDEVICEOBJECTDATA
	dwOfs as DWORD
	dwData as DWORD
	dwTimeStamp as DWORD
	dwSequence as DWORD
	uAppData as UINT_PTR
end type

type LPDIDEVICEOBJECTDATA as DIDEVICEOBJECTDATA ptr
type LPCDIDEVICEOBJECTDATA as DIDEVICEOBJECTDATA ptr

#define DIGDD_PEEK &h00000001
#define DISCL_EXCLUSIVE &h00000001
#define DISCL_NONEXCLUSIVE &h00000002
#define DISCL_FOREGROUND &h00000004
#define DISCL_BACKGROUND &h00000008
#define DISCL_NOWINKEY &h00000010

#ifndef UNICODE
type DIDEVICEINSTANCE_DX3A
	dwSize as DWORD
	guidInstance as GUID
	guidProduct as GUID
	dwDevType as DWORD
	tszInstanceName as zstring * MAX_PATH
	tszProductName as zstring * MAX_PATH
end type

type LPDIDEVICEINSTANCE_DX3A as DIDEVICEINSTANCE_DX3A ptr
type LPCDIDEVICEINSTANCE_DX3A as DIDEVICEINSTANCE_DX3A ptr
type DIDEVICEINSTANCE_DX3 as DIDEVICEINSTANCE_DX3A
type LPDIDEVICEINSTANCE_DX3 as LPDIDEVICEINSTANCE_DX3A

type DIDEVICEINSTANCEA
	dwSize as DWORD
	guidInstance as GUID
	guidProduct as GUID
	dwDevType as DWORD
	tszInstanceName as zstring * MAX_PATH
	tszProductName as zstring * MAX_PATH
	guidFFDriver as GUID
	wUsagePage as WORD
	wUsage as WORD
end type

type LPDIDEVICEINSTANCEA as DIDEVICEINSTANCEA ptr
type DIDEVICEINSTANCE as DIDEVICEINSTANCEA
type LPDIDEVICEINSTANCE as LPDIDEVICEINSTANCEA
type LPCDIDEVICEINSTANCEA as DIDEVICEINSTANCEA ptr
#define LPDIENUMEFFECTSCALLBACK  LPDIENUMEFFECTSCALLBACKA

#else
type DIDEVICEINSTANCE_DX3W
	dwSize as DWORD
	guidInstance as GUID
	guidProduct as GUID
	dwDevType as DWORD
	tszInstanceName as wstring * MAX_PATH
	tszProductName as wstring * MAX_PATH
end type

type LPDIDEVICEINSTANCE_DX3W as DIDEVICEINSTANCE_DX3W ptr
type LPCDIDEVICEINSTANCE_DX3W as DIDEVICEINSTANCE_DX3W ptr
type DIDEVICEINSTANCE_DX3 as DIDEVICEINSTANCE_DX3W
type LPDIDEVICEINSTANCE_DX3 as LPDIDEVICEINSTANCE_DX3W

type DIDEVICEINSTANCEW
	dwSize as DWORD
	guidInstance as GUID
	guidProduct as GUID
	dwDevType as DWORD
	tszInstanceName as wstring * MAX_PATH
	tszProductName as wstring * MAX_PATH
	guidFFDriver as GUID
	wUsagePage as WORD
	wUsage as WORD
end type

type LPDIDEVICEINSTANCEW as DIDEVICEINSTANCEW ptr
type DIDEVICEINSTANCE as DIDEVICEINSTANCEW
type LPDIDEVICEINSTANCE as LPDIDEVICEINSTANCEW
type LPCDIDEVICEINSTANCEW as DIDEVICEINSTANCEW ptr
#define LPDIENUMEFFECTSCALLBACK  LPDIENUMEFFECTSCALLBACKW
#endif

type LPCDIDEVICEINSTANCE_DX3 as DIDEVICEINSTANCE_DX3 ptr
type LPCDIDEVICEINSTANCE as DIDEVICEINSTANCE ptr

#ifdef UNICODE
type IDirectInputDeviceWVtbl_ as IDirectInputDeviceWVtbl

type IDirectInputDeviceW
	lpVtbl as IDirectInputDeviceWVtbl_ ptr
end type

type IDirectInputDeviceWVtbl
	QueryInterface as function (byval as IDirectInputDeviceW ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputDeviceW ptr) as ULONG
	Release as function (byval as IDirectInputDeviceW ptr) as ULONG
	GetCapabilities as function (byval as IDirectInputDeviceW ptr, byval as LPDIDEVCAPS) as HRESULT
	EnumObjects as function (byval as IDirectInputDeviceW ptr, byval as LPDIENUMDEVICEOBJECTSCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetProperty as function (byval as IDirectInputDeviceW ptr, byval as GUID ptr, byval as LPDIPROPHEADER) as HRESULT
	SetProperty as function (byval as IDirectInputDeviceW ptr, byval as GUID ptr, byval as LPCDIPROPHEADER) as HRESULT
	Acquire as function (byval as IDirectInputDeviceW ptr) as HRESULT
	Unacquire as function (byval as IDirectInputDeviceW ptr) as HRESULT
	GetDeviceState as function (byval as IDirectInputDeviceW ptr, byval as DWORD, byval as LPVOID) as HRESULT
	GetDeviceData as function (byval as IDirectInputDeviceW ptr, byval as DWORD, byval as LPDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	SetDataFormat as function (byval as IDirectInputDeviceW ptr, byval as LPCDIDATAFORMAT) as HRESULT
	SetEventNotification as function (byval as IDirectInputDeviceW ptr, byval as HANDLE) as HRESULT
	SetCooperativeLevel as function (byval as IDirectInputDeviceW ptr, byval as HWND, byval as DWORD) as HRESULT
	GetObjectInfo as function (byval as IDirectInputDeviceW ptr, byval as LPDIDEVICEOBJECTINSTANCEW, byval as DWORD, byval as DWORD) as HRESULT
	GetDeviceInfo as function (byval as IDirectInputDeviceW ptr, byval as LPDIDEVICEINSTANCEW) as HRESULT
	RunControlPanel as function (byval as IDirectInputDeviceW ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputDeviceW ptr, byval as HINSTANCE, byval as DWORD, byval as GUID ptr) as HRESULT
end type

type LPDIRECTINPUTDEVICEW as IDirectInputDeviceW ptr
type LPDIRECTINPUTDEVICE as IDirectInputDeviceW ptr
#define IID_IDirectInputDevice IID_IDirectInputDeviceW
#define IDirectInputDevice IDirectInputDeviceW
#define IDirectInputDeviceVtbl IDirectInputDeviceWVtbl

#else
type IDirectInputDeviceAVtbl_ as IDirectInputDeviceAVtbl

type IDirectInputDeviceA
	lpVtbl as IDirectInputDeviceAVtbl_ ptr
end type

type IDirectInputDeviceAVtbl
	QueryInterface as function (byval as IDirectInputDeviceA ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputDeviceA ptr) as ULONG
	Release as function (byval as IDirectInputDeviceA ptr) as ULONG
	GetCapabilities as function (byval as IDirectInputDeviceA ptr, byval as LPDIDEVCAPS) as HRESULT
	EnumObjects as function (byval as IDirectInputDeviceA ptr, byval as LPDIENUMDEVICEOBJECTSCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetProperty as function (byval as IDirectInputDeviceA ptr, byval as GUID ptr, byval as LPDIPROPHEADER) as HRESULT
	SetProperty as function (byval as IDirectInputDeviceA ptr, byval as GUID ptr, byval as LPCDIPROPHEADER) as HRESULT
	Acquire as function (byval as IDirectInputDeviceA ptr) as HRESULT
	Unacquire as function (byval as IDirectInputDeviceA ptr) as HRESULT
	GetDeviceState as function (byval as IDirectInputDeviceA ptr, byval as DWORD, byval as LPVOID) as HRESULT
	GetDeviceData as function (byval as IDirectInputDeviceA ptr, byval as DWORD, byval as LPDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	SetDataFormat as function (byval as IDirectInputDeviceA ptr, byval as LPCDIDATAFORMAT) as HRESULT
	SetEventNotification as function (byval as IDirectInputDeviceA ptr, byval as HANDLE) as HRESULT
	SetCooperativeLevel as function (byval as IDirectInputDeviceA ptr, byval as HWND, byval as DWORD) as HRESULT
	GetObjectInfo as function (byval as IDirectInputDeviceA ptr, byval as LPDIDEVICEOBJECTINSTANCEA, byval as DWORD, byval as DWORD) as HRESULT
	GetDeviceInfo as function (byval as IDirectInputDeviceA ptr, byval as LPDIDEVICEINSTANCEA) as HRESULT
	RunControlPanel as function (byval as IDirectInputDeviceA ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputDeviceA ptr, byval as HINSTANCE, byval as DWORD, byval as GUID ptr) as HRESULT
end type

type LPDIRECTINPUTDEVICEA as IDirectInputDeviceA ptr
type LPDIRECTINPUTDEVICE as IDirectInputDeviceA ptr
#define IID_IDirectInputDevice IID_IDirectInputDeviceA
#define IDirectInputDevice IDirectInputDeviceA
#define IDirectInputDeviceVtbl IDirectInputDeviceAVtbl
#endif

#define IDirectInputDevice_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectInputDevice_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectInputDevice_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInputDevice_GetCapabilities(p,a) (p)->lpVtbl->GetCapabilities(p,a)
#define IDirectInputDevice_EnumObjects(p,a,b,c) (p)->lpVtbl->EnumObjects(p,a,b,c)
#define IDirectInputDevice_GetProperty(p,a,b) (p)->lpVtbl->GetProperty(p,a,b)
#define IDirectInputDevice_SetProperty(p,a,b) (p)->lpVtbl->SetProperty(p,a,b)
#define IDirectInputDevice_Acquire(p) (p)->lpVtbl->Acquire(p)
#define IDirectInputDevice_Unacquire(p) (p)->lpVtbl->Unacquire(p)
#define IDirectInputDevice_GetDeviceState(p,a,b) (p)->lpVtbl->GetDeviceState(p,a,b)
#define IDirectInputDevice_GetDeviceData(p,a,b,c,d) (p)->lpVtbl->GetDeviceData(p,a,b,c,d)
#define IDirectInputDevice_SetDataFormat(p,a) (p)->lpVtbl->SetDataFormat(p,a)
#define IDirectInputDevice_SetEventNotification(p,a) (p)->lpVtbl->SetEventNotification(p,a)
#define IDirectInputDevice_SetCooperativeLevel(p,a,b) (p)->lpVtbl->SetCooperativeLevel(p,a,b)
#define IDirectInputDevice_GetObjectInfo(p,a,b,c) (p)->lpVtbl->GetObjectInfo(p,a,b,c)
#define IDirectInputDevice_GetDeviceInfo(p,a) (p)->lpVtbl->GetDeviceInfo(p,a)
#define IDirectInputDevice_RunControlPanel(p,a,b) (p)->lpVtbl->RunControlPanel(p,a,b)
#define IDirectInputDevice_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)

#define DISFFC_RESET &h00000001
#define DISFFC_STOPALL &h00000002
#define DISFFC_PAUSE &h00000004
#define DISFFC_CONTINUE &h00000008
#define DISFFC_SETACTUATORSON &h00000010
#define DISFFC_SETACTUATORSOFF &h00000020
#define DIGFFS_EMPTY &h00000001
#define DIGFFS_STOPPED &h00000002
#define DIGFFS_PAUSED &h00000004
#define DIGFFS_ACTUATORSON &h00000010
#define DIGFFS_ACTUATORSOFF &h00000020
#define DIGFFS_POWERON &h00000040
#define DIGFFS_POWEROFF &h00000080
#define DIGFFS_SAFETYSWITCHON &h00000100
#define DIGFFS_SAFETYSWITCHOFF &h00000200
#define DIGFFS_USERFFSWITCHON &h00000400
#define DIGFFS_USERFFSWITCHOFF &h00000800
#define DIGFFS_DEVICELOST &h80000000

#ifndef UNICODE
type DIEFFECTINFOA
	dwSize as DWORD
	guid as GUID
	dwEffType as DWORD
	dwStaticParams as DWORD
	dwDynamicParams as DWORD
	tszName as zstring * MAX_PATH
end type

type LPDIEFFECTINFOA as DIEFFECTINFOA ptr
type LPCDIEFFECTINFOA as DIEFFECTINFOA ptr
type DIEFFECTINFO as DIEFFECTINFOA
type LPDIEFFECTINFO as LPDIEFFECTINFOA
type LPDIENUMEFFECTSCALLBACKA as function (byval as LPCDIEFFECTINFOA, byval as LPVOID) as BOOL

#else
type DIEFFECTINFOW
	dwSize as DWORD
	guid as GUID
	dwEffType as DWORD
	dwStaticParams as DWORD
	dwDynamicParams as DWORD
	tszName as wstring * MAX_PATH
end type

type LPDIEFFECTINFOW as DIEFFECTINFOW ptr
type LPCDIEFFECTINFOW as DIEFFECTINFOW ptr
type DIEFFECTINFO as DIEFFECTINFOW
type LPDIEFFECTINFO as LPDIEFFECTINFOW
type LPDIENUMEFFECTSCALLBACKW as function (byval as LPCDIEFFECTINFOW, byval as LPVOID) as BOOL
#endif

type LPCDIEFFECTINFO as DIEFFECTINFO ptr

#define DISDD_CONTINUE &h00000001

type LPDIENUMCREATEDEFFECTOBJECTSCALLBACK as function (byval as LPDIRECTINPUTEFFECT, byval as LPVOID) as BOOL

#ifdef UNICODE
type IDirectInputDevice2WVtbl_ as IDirectInputDevice2WVtbl

type IDirectInputDevice2W
	lpVtbl as IDirectInputDevice2WVtbl_ ptr
end type

type IDirectInputDevice2WVtbl
	QueryInterface as function (byval as IDirectInputDevice2W ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputDevice2W ptr) as ULONG
	Release as function (byval as IDirectInputDevice2W ptr) as ULONG
	GetCapabilities as function (byval as IDirectInputDevice2W ptr, byval as LPDIDEVCAPS) as HRESULT
	EnumObjects as function (byval as IDirectInputDevice2W ptr, byval as LPDIENUMDEVICEOBJECTSCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetProperty as function (byval as IDirectInputDevice2W ptr, byval as GUID ptr, byval as LPDIPROPHEADER) as HRESULT
	SetProperty as function (byval as IDirectInputDevice2W ptr, byval as GUID ptr, byval as LPCDIPROPHEADER) as HRESULT
	Acquire as function (byval as IDirectInputDevice2W ptr) as HRESULT
	Unacquire as function (byval as IDirectInputDevice2W ptr) as HRESULT
	GetDeviceState as function (byval as IDirectInputDevice2W ptr, byval as DWORD, byval as LPVOID) as HRESULT
	GetDeviceData as function (byval as IDirectInputDevice2W ptr, byval as DWORD, byval as LPDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	SetDataFormat as function (byval as IDirectInputDevice2W ptr, byval as LPCDIDATAFORMAT) as HRESULT
	SetEventNotification as function (byval as IDirectInputDevice2W ptr, byval as HANDLE) as HRESULT
	SetCooperativeLevel as function (byval as IDirectInputDevice2W ptr, byval as HWND, byval as DWORD) as HRESULT
	GetObjectInfo as function (byval as IDirectInputDevice2W ptr, byval as LPDIDEVICEOBJECTINSTANCEW, byval as DWORD, byval as DWORD) as HRESULT
	GetDeviceInfo as function (byval as IDirectInputDevice2W ptr, byval as LPDIDEVICEINSTANCEW) as HRESULT
	RunControlPanel as function (byval as IDirectInputDevice2W ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputDevice2W ptr, byval as HINSTANCE, byval as DWORD, byval as GUID ptr) as HRESULT
	CreateEffect as function (byval as IDirectInputDevice2W ptr, byval as GUID ptr, byval as LPCDIEFFECT, byval as LPDIRECTINPUTEFFECT ptr, byval as LPUNKNOWN) as HRESULT
	EnumEffects as function (byval as IDirectInputDevice2W ptr, byval as LPDIENUMEFFECTSCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetEffectInfo as function (byval as IDirectInputDevice2W ptr, byval as LPDIEFFECTINFOW, byval as GUID ptr) as HRESULT
	GetForceFeedbackState as function (byval as IDirectInputDevice2W ptr, byval as LPDWORD) as HRESULT
	SendForceFeedbackCommand as function (byval as IDirectInputDevice2W ptr, byval as DWORD) as HRESULT
	EnumCreatedEffectObjects as function (byval as IDirectInputDevice2W ptr, byval as LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	Escape as function (byval as IDirectInputDevice2W ptr, byval as LPDIEFFESCAPE) as HRESULT
	Poll as function (byval as IDirectInputDevice2W ptr) as HRESULT
	SendDeviceData as function (byval as IDirectInputDevice2W ptr, byval as DWORD, byval as LPCDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
end type

type LPDIRECTINPUTDEVICE2W as IDirectInputDevice2W ptr
type LPDIRECTINPUTDEVICE2 as IDirectInputDevice2W ptr
#define IID_IDirectInputDevice2 IID_IDirectInputDevice2W
#define IDirectInputDevice2 IDirectInputDevice2W
#define IDirectInputDevice2Vtbl IDirectInputDevice2WVtbl

#else
type IDirectInputDevice2AVtbl_ as IDirectInputDevice2AVtbl

type IDirectInputDevice2A
	lpVtbl as IDirectInputDevice2AVtbl_ ptr
end type

type IDirectInputDevice2AVtbl
	QueryInterface as function (byval as IDirectInputDevice2A ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputDevice2A ptr) as ULONG
	Release as function (byval as IDirectInputDevice2A ptr) as ULONG
	GetCapabilities as function (byval as IDirectInputDevice2A ptr, byval as LPDIDEVCAPS) as HRESULT
	EnumObjects as function (byval as IDirectInputDevice2A ptr, byval as LPDIENUMDEVICEOBJECTSCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetProperty as function (byval as IDirectInputDevice2A ptr, byval as GUID ptr, byval as LPDIPROPHEADER) as HRESULT
	SetProperty as function (byval as IDirectInputDevice2A ptr, byval as GUID ptr, byval as LPCDIPROPHEADER) as HRESULT
	Acquire as function (byval as IDirectInputDevice2A ptr) as HRESULT
	Unacquire as function (byval as IDirectInputDevice2A ptr) as HRESULT
	GetDeviceState as function (byval as IDirectInputDevice2A ptr, byval as DWORD, byval as LPVOID) as HRESULT
	GetDeviceData as function (byval as IDirectInputDevice2A ptr, byval as DWORD, byval as LPDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	SetDataFormat as function (byval as IDirectInputDevice2A ptr, byval as LPCDIDATAFORMAT) as HRESULT
	SetEventNotification as function (byval as IDirectInputDevice2A ptr, byval as HANDLE) as HRESULT
	SetCooperativeLevel as function (byval as IDirectInputDevice2A ptr, byval as HWND, byval as DWORD) as HRESULT
	GetObjectInfo as function (byval as IDirectInputDevice2A ptr, byval as LPDIDEVICEOBJECTINSTANCEA, byval as DWORD, byval as DWORD) as HRESULT
	GetDeviceInfo as function (byval as IDirectInputDevice2A ptr, byval as LPDIDEVICEINSTANCEA) as HRESULT
	RunControlPanel as function (byval as IDirectInputDevice2A ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputDevice2A ptr, byval as HINSTANCE, byval as DWORD, byval as GUID ptr) as HRESULT
	CreateEffect as function (byval as IDirectInputDevice2A ptr, byval as GUID ptr, byval as LPCDIEFFECT, byval as LPDIRECTINPUTEFFECT ptr, byval as LPUNKNOWN) as HRESULT
	EnumEffects as function (byval as IDirectInputDevice2A ptr, byval as LPDIENUMEFFECTSCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetEffectInfo as function (byval as IDirectInputDevice2A ptr, byval as LPDIEFFECTINFOA, byval as GUID ptr) as HRESULT
	GetForceFeedbackState as function (byval as IDirectInputDevice2A ptr, byval as LPDWORD) as HRESULT
	SendForceFeedbackCommand as function (byval as IDirectInputDevice2A ptr, byval as DWORD) as HRESULT
	EnumCreatedEffectObjects as function (byval as IDirectInputDevice2A ptr, byval as LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	Escape as function (byval as IDirectInputDevice2A ptr, byval as LPDIEFFESCAPE) as HRESULT
	Poll as function (byval as IDirectInputDevice2A ptr) as HRESULT
	SendDeviceData as function (byval as IDirectInputDevice2A ptr, byval as DWORD, byval as LPCDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
end type

type LPDIRECTINPUTDEVICE2A as IDirectInputDevice2A ptr
type LPDIRECTINPUTDEVICE2 as IDirectInputDevice2A ptr
#define IID_IDirectInputDevice2 IID_IDirectInputDevice2A
#define IDirectInputDevice2 IDirectInputDevice2A
#define IDirectInputDevice2Vtbl IDirectInputDevice2AVtbl
#endif

#define IDirectInputDevice2_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectInputDevice2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectInputDevice2_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInputDevice2_GetCapabilities(p,a) (p)->lpVtbl->GetCapabilities(p,a)
#define IDirectInputDevice2_EnumObjects(p,a,b,c) (p)->lpVtbl->EnumObjects(p,a,b,c)
#define IDirectInputDevice2_GetProperty(p,a,b) (p)->lpVtbl->GetProperty(p,a,b)
#define IDirectInputDevice2_SetProperty(p,a,b) (p)->lpVtbl->SetProperty(p,a,b)
#define IDirectInputDevice2_Acquire(p) (p)->lpVtbl->Acquire(p)
#define IDirectInputDevice2_Unacquire(p) (p)->lpVtbl->Unacquire(p)
#define IDirectInputDevice2_GetDeviceState(p,a,b) (p)->lpVtbl->GetDeviceState(p,a,b)
#define IDirectInputDevice2_GetDeviceData(p,a,b,c,d) (p)->lpVtbl->GetDeviceData(p,a,b,c,d)
#define IDirectInputDevice2_SetDataFormat(p,a) (p)->lpVtbl->SetDataFormat(p,a)
#define IDirectInputDevice2_SetEventNotification(p,a) (p)->lpVtbl->SetEventNotification(p,a)
#define IDirectInputDevice2_SetCooperativeLevel(p,a,b) (p)->lpVtbl->SetCooperativeLevel(p,a,b)
#define IDirectInputDevice2_GetObjectInfo(p,a,b,c) (p)->lpVtbl->GetObjectInfo(p,a,b,c)
#define IDirectInputDevice2_GetDeviceInfo(p,a) (p)->lpVtbl->GetDeviceInfo(p,a)
#define IDirectInputDevice2_RunControlPanel(p,a,b) (p)->lpVtbl->RunControlPanel(p,a,b)
#define IDirectInputDevice2_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectInputDevice2_CreateEffect(p,a,b,c,d) (p)->lpVtbl->CreateEffect(p,a,b,c,d)
#define IDirectInputDevice2_EnumEffects(p,a,b,c) (p)->lpVtbl->EnumEffects(p,a,b,c)
#define IDirectInputDevice2_GetEffectInfo(p,a,b) (p)->lpVtbl->GetEffectInfo(p,a,b)
#define IDirectInputDevice2_GetForceFeedbackState(p,a) (p)->lpVtbl->GetForceFeedbackState(p,a)
#define IDirectInputDevice2_SendForceFeedbackCommand(p,a) (p)->lpVtbl->SendForceFeedbackCommand(p,a)
#define IDirectInputDevice2_EnumCreatedEffectObjects(p,a,b,c) (p)->lpVtbl->EnumCreatedEffectObjects(p,a,b,c)
#define IDirectInputDevice2_Escape(p,a) (p)->lpVtbl->Escape(p,a)
#define IDirectInputDevice2_Poll(p) (p)->lpVtbl->Poll(p)
#define IDirectInputDevice2_SendDeviceData(p,a,b,c,d) (p)->lpVtbl->SendDeviceData(p,a,b,c,d)

#define DIFEF_DEFAULT &h00000000
#define DIFEF_INCLUDENONSTANDARD &h00000001
#define DIFEF_MODIFYIFNEEDED &h00000010

#ifdef UNICODE
type IDirectInputDevice7WVtbl_ as IDirectInputDevice7WVtbl

type IDirectInputDevice7W
	lpVtbl as IDirectInputDevice7WVtbl_ ptr
end type

type IDirectInputDevice7WVtbl
	QueryInterface as function (byval as IDirectInputDevice7W ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputDevice7W ptr) as ULONG
	Release as function (byval as IDirectInputDevice7W ptr) as ULONG
	GetCapabilities as function (byval as IDirectInputDevice7W ptr, byval as LPDIDEVCAPS) as HRESULT
	EnumObjects as function (byval as IDirectInputDevice7W ptr, byval as LPDIENUMDEVICEOBJECTSCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetProperty as function (byval as IDirectInputDevice7W ptr, byval as GUID ptr, byval as LPDIPROPHEADER) as HRESULT
	SetProperty as function (byval as IDirectInputDevice7W ptr, byval as GUID ptr, byval as LPCDIPROPHEADER) as HRESULT
	Acquire as function (byval as IDirectInputDevice7W ptr) as HRESULT
	Unacquire as function (byval as IDirectInputDevice7W ptr) as HRESULT
	GetDeviceState as function (byval as IDirectInputDevice7W ptr, byval as DWORD, byval as LPVOID) as HRESULT
	GetDeviceData as function (byval as IDirectInputDevice7W ptr, byval as DWORD, byval as LPDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	SetDataFormat as function (byval as IDirectInputDevice7W ptr, byval as LPCDIDATAFORMAT) as HRESULT
	SetEventNotification as function (byval as IDirectInputDevice7W ptr, byval as HANDLE) as HRESULT
	SetCooperativeLevel as function (byval as IDirectInputDevice7W ptr, byval as HWND, byval as DWORD) as HRESULT
	GetObjectInfo as function (byval as IDirectInputDevice7W ptr, byval as LPDIDEVICEOBJECTINSTANCEW, byval as DWORD, byval as DWORD) as HRESULT
	GetDeviceInfo as function (byval as IDirectInputDevice7W ptr, byval as LPDIDEVICEINSTANCEW) as HRESULT
	RunControlPanel as function (byval as IDirectInputDevice7W ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputDevice7W ptr, byval as HINSTANCE, byval as DWORD, byval as GUID ptr) as HRESULT
	CreateEffect as function (byval as IDirectInputDevice7W ptr, byval as GUID ptr, byval as LPCDIEFFECT, byval as LPDIRECTINPUTEFFECT ptr, byval as LPUNKNOWN) as HRESULT
	EnumEffects as function (byval as IDirectInputDevice7W ptr, byval as LPDIENUMEFFECTSCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetEffectInfo as function (byval as IDirectInputDevice7W ptr, byval as LPDIEFFECTINFOW, byval as GUID ptr) as HRESULT
	GetForceFeedbackState as function (byval as IDirectInputDevice7W ptr, byval as LPDWORD) as HRESULT
	SendForceFeedbackCommand as function (byval as IDirectInputDevice7W ptr, byval as DWORD) as HRESULT
	EnumCreatedEffectObjects as function (byval as IDirectInputDevice7W ptr, byval as LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	Escape as function (byval as IDirectInputDevice7W ptr, byval as LPDIEFFESCAPE) as HRESULT
	Poll as function (byval as IDirectInputDevice7W ptr) as HRESULT
	SendDeviceData as function (byval as IDirectInputDevice7W ptr, byval as DWORD, byval as LPCDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	EnumEffectsInFile as function (byval as IDirectInputDevice7W ptr, byval as LPCWSTR, byval as LPDIENUMEFFECTSINFILECALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	WriteEffectToFile as function (byval as IDirectInputDevice7W ptr, byval as LPCWSTR, byval as DWORD, byval as LPDIFILEEFFECT, byval as DWORD) as HRESULT
end type

type LPDIRECTINPUTDEVICE7W as IDirectInputDevice7W ptr
type LPDIRECTINPUTDEVICE7 as IDirectInputDevice7W ptr
#define IID_IDirectInputDevice7 IID_IDirectInputDevice7W
#define IDirectInputDevice7 IDirectInputDevice7W
#define IDirectInputDevice7Vtbl IDirectInputDevice7WVtbl

#else
type IDirectInputDevice7AVtbl_ as IDirectInputDevice7AVtbl

type IDirectInputDevice7A
	lpVtbl as IDirectInputDevice7AVtbl_ ptr
end type

type IDirectInputDevice7AVtbl
	QueryInterface as function (byval as IDirectInputDevice7A ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputDevice7A ptr) as ULONG
	Release as function (byval as IDirectInputDevice7A ptr) as ULONG
	GetCapabilities as function (byval as IDirectInputDevice7A ptr, byval as LPDIDEVCAPS) as HRESULT
	EnumObjects as function (byval as IDirectInputDevice7A ptr, byval as LPDIENUMDEVICEOBJECTSCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetProperty as function (byval as IDirectInputDevice7A ptr, byval as GUID ptr, byval as LPDIPROPHEADER) as HRESULT
	SetProperty as function (byval as IDirectInputDevice7A ptr, byval as GUID ptr, byval as LPCDIPROPHEADER) as HRESULT
	Acquire as function (byval as IDirectInputDevice7A ptr) as HRESULT
	Unacquire as function (byval as IDirectInputDevice7A ptr) as HRESULT
	GetDeviceState as function (byval as IDirectInputDevice7A ptr, byval as DWORD, byval as LPVOID) as HRESULT
	GetDeviceData as function (byval as IDirectInputDevice7A ptr, byval as DWORD, byval as LPDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	SetDataFormat as function (byval as IDirectInputDevice7A ptr, byval as LPCDIDATAFORMAT) as HRESULT
	SetEventNotification as function (byval as IDirectInputDevice7A ptr, byval as HANDLE) as HRESULT
	SetCooperativeLevel as function (byval as IDirectInputDevice7A ptr, byval as HWND, byval as DWORD) as HRESULT
	GetObjectInfo as function (byval as IDirectInputDevice7A ptr, byval as LPDIDEVICEOBJECTINSTANCEA, byval as DWORD, byval as DWORD) as HRESULT
	GetDeviceInfo as function (byval as IDirectInputDevice7A ptr, byval as LPDIDEVICEINSTANCEA) as HRESULT
	RunControlPanel as function (byval as IDirectInputDevice7A ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputDevice7A ptr, byval as HINSTANCE, byval as DWORD, byval as GUID ptr) as HRESULT
	CreateEffect as function (byval as IDirectInputDevice7A ptr, byval as GUID ptr, byval as LPCDIEFFECT, byval as LPDIRECTINPUTEFFECT ptr, byval as LPUNKNOWN) as HRESULT
	EnumEffects as function (byval as IDirectInputDevice7A ptr, byval as LPDIENUMEFFECTSCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetEffectInfo as function (byval as IDirectInputDevice7A ptr, byval as LPDIEFFECTINFOA, byval as GUID ptr) as HRESULT
	GetForceFeedbackState as function (byval as IDirectInputDevice7A ptr, byval as LPDWORD) as HRESULT
	SendForceFeedbackCommand as function (byval as IDirectInputDevice7A ptr, byval as DWORD) as HRESULT
	EnumCreatedEffectObjects as function (byval as IDirectInputDevice7A ptr, byval as LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	Escape as function (byval as IDirectInputDevice7A ptr, byval as LPDIEFFESCAPE) as HRESULT
	Poll as function (byval as IDirectInputDevice7A ptr) as HRESULT
	SendDeviceData as function (byval as IDirectInputDevice7A ptr, byval as DWORD, byval as LPCDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	EnumEffectsInFile as function (byval as IDirectInputDevice7A ptr, byval as LPCSTR, byval as LPDIENUMEFFECTSINFILECALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	WriteEffectToFile as function (byval as IDirectInputDevice7A ptr, byval as LPCSTR, byval as DWORD, byval as LPDIFILEEFFECT, byval as DWORD) as HRESULT
end type

type LPDIRECTINPUTDEVICE7A as IDirectInputDevice7A ptr
type LPDIRECTINPUTDEVICE7 as IDirectInputDevice7A ptr
#define IID_IDirectInputDevice7 IID_IDirectInputDevice7A
#define IDirectInputDevice7 IDirectInputDevice7A
#define IDirectInputDevice7Vtbl IDirectInputDevice7AVtbl
#endif

#define IDirectInputDevice7_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectInputDevice7_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectInputDevice7_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInputDevice7_GetCapabilities(p,a) (p)->lpVtbl->GetCapabilities(p,a)
#define IDirectInputDevice7_EnumObjects(p,a,b,c) (p)->lpVtbl->EnumObjects(p,a,b,c)
#define IDirectInputDevice7_GetProperty(p,a,b) (p)->lpVtbl->GetProperty(p,a,b)
#define IDirectInputDevice7_SetProperty(p,a,b) (p)->lpVtbl->SetProperty(p,a,b)
#define IDirectInputDevice7_Acquire(p) (p)->lpVtbl->Acquire(p)
#define IDirectInputDevice7_Unacquire(p) (p)->lpVtbl->Unacquire(p)
#define IDirectInputDevice7_GetDeviceState(p,a,b) (p)->lpVtbl->GetDeviceState(p,a,b)
#define IDirectInputDevice7_GetDeviceData(p,a,b,c,d) (p)->lpVtbl->GetDeviceData(p,a,b,c,d)
#define IDirectInputDevice7_SetDataFormat(p,a) (p)->lpVtbl->SetDataFormat(p,a)
#define IDirectInputDevice7_SetEventNotification(p,a) (p)->lpVtbl->SetEventNotification(p,a)
#define IDirectInputDevice7_SetCooperativeLevel(p,a,b) (p)->lpVtbl->SetCooperativeLevel(p,a,b)
#define IDirectInputDevice7_GetObjectInfo(p,a,b,c) (p)->lpVtbl->GetObjectInfo(p,a,b,c)
#define IDirectInputDevice7_GetDeviceInfo(p,a) (p)->lpVtbl->GetDeviceInfo(p,a)
#define IDirectInputDevice7_RunControlPanel(p,a,b) (p)->lpVtbl->RunControlPanel(p,a,b)
#define IDirectInputDevice7_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectInputDevice7_CreateEffect(p,a,b,c,d) (p)->lpVtbl->CreateEffect(p,a,b,c,d)
#define IDirectInputDevice7_EnumEffects(p,a,b,c) (p)->lpVtbl->EnumEffects(p,a,b,c)
#define IDirectInputDevice7_GetEffectInfo(p,a,b) (p)->lpVtbl->GetEffectInfo(p,a,b)
#define IDirectInputDevice7_GetForceFeedbackState(p,a) (p)->lpVtbl->GetForceFeedbackState(p,a)
#define IDirectInputDevice7_SendForceFeedbackCommand(p,a) (p)->lpVtbl->SendForceFeedbackCommand(p,a)
#define IDirectInputDevice7_EnumCreatedEffectObjects(p,a,b,c) (p)->lpVtbl->EnumCreatedEffectObjects(p,a,b,c)
#define IDirectInputDevice7_Escape(p,a) (p)->lpVtbl->Escape(p,a)
#define IDirectInputDevice7_Poll(p) (p)->lpVtbl->Poll(p)
#define IDirectInputDevice7_SendDeviceData(p,a,b,c,d) (p)->lpVtbl->SendDeviceData(p,a,b,c,d)
#define IDirectInputDevice7_EnumEffectsInFile(p,a,b,c,d) (p)->lpVtbl->EnumEffectsInFile(p,a,b,c,d)
#define IDirectInputDevice7_WriteEffectToFile(p,a,b,c,d) (p)->lpVtbl->WriteEffectToFile(p,a,b,c,d)

#ifdef UNICODE
type IDirectInputDevice8WVtbl_ as IDirectInputDevice8WVtbl

type IDirectInputDevice8W
	lpVtbl as IDirectInputDevice8WVtbl_ ptr
end type

type IDirectInputDevice8WVtbl
	QueryInterface as function (byval as IDirectInputDevice8W ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputDevice8W ptr) as ULONG
	Release as function (byval as IDirectInputDevice8W ptr) as ULONG
	GetCapabilities as function (byval as IDirectInputDevice8W ptr, byval as LPDIDEVCAPS) as HRESULT
	EnumObjects as function (byval as IDirectInputDevice8W ptr, byval as LPDIENUMDEVICEOBJECTSCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetProperty as function (byval as IDirectInputDevice8W ptr, byval as GUID ptr, byval as LPDIPROPHEADER) as HRESULT
	SetProperty as function (byval as IDirectInputDevice8W ptr, byval as GUID ptr, byval as LPCDIPROPHEADER) as HRESULT
	Acquire as function (byval as IDirectInputDevice8W ptr) as HRESULT
	Unacquire as function (byval as IDirectInputDevice8W ptr) as HRESULT
	GetDeviceState as function (byval as IDirectInputDevice8W ptr, byval as DWORD, byval as LPVOID) as HRESULT
	GetDeviceData as function (byval as IDirectInputDevice8W ptr, byval as DWORD, byval as LPDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	SetDataFormat as function (byval as IDirectInputDevice8W ptr, byval as LPCDIDATAFORMAT) as HRESULT
	SetEventNotification as function (byval as IDirectInputDevice8W ptr, byval as HANDLE) as HRESULT
	SetCooperativeLevel as function (byval as IDirectInputDevice8W ptr, byval as HWND, byval as DWORD) as HRESULT
	GetObjectInfo as function (byval as IDirectInputDevice8W ptr, byval as LPDIDEVICEOBJECTINSTANCEW, byval as DWORD, byval as DWORD) as HRESULT
	GetDeviceInfo as function (byval as IDirectInputDevice8W ptr, byval as LPDIDEVICEINSTANCEW) as HRESULT
	RunControlPanel as function (byval as IDirectInputDevice8W ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputDevice8W ptr, byval as HINSTANCE, byval as DWORD, byval as GUID ptr) as HRESULT
	CreateEffect as function (byval as IDirectInputDevice8W ptr, byval as GUID ptr, byval as LPCDIEFFECT, byval as LPDIRECTINPUTEFFECT ptr, byval as LPUNKNOWN) as HRESULT
	EnumEffects as function (byval as IDirectInputDevice8W ptr, byval as LPDIENUMEFFECTSCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetEffectInfo as function (byval as IDirectInputDevice8W ptr, byval as LPDIEFFECTINFOW, byval as GUID ptr) as HRESULT
	GetForceFeedbackState as function (byval as IDirectInputDevice8W ptr, byval as LPDWORD) as HRESULT
	SendForceFeedbackCommand as function (byval as IDirectInputDevice8W ptr, byval as DWORD) as HRESULT
	EnumCreatedEffectObjects as function (byval as IDirectInputDevice8W ptr, byval as LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	Escape as function (byval as IDirectInputDevice8W ptr, byval as LPDIEFFESCAPE) as HRESULT
	Poll as function (byval as IDirectInputDevice8W ptr) as HRESULT
	SendDeviceData as function (byval as IDirectInputDevice8W ptr, byval as DWORD, byval as LPCDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	EnumEffectsInFile as function (byval as IDirectInputDevice8W ptr, byval as LPCWSTR, byval as LPDIENUMEFFECTSINFILECALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	WriteEffectToFile as function (byval as IDirectInputDevice8W ptr, byval as LPCWSTR, byval as DWORD, byval as LPDIFILEEFFECT, byval as DWORD) as HRESULT
	BuildActionMap as function (byval as IDirectInputDevice8W ptr, byval as LPDIACTIONFORMATW, byval as LPCWSTR, byval as DWORD) as HRESULT
	SetActionMap as function (byval as IDirectInputDevice8W ptr, byval as LPDIACTIONFORMATW, byval as LPCWSTR, byval as DWORD) as HRESULT
	GetImageInfo as function (byval as IDirectInputDevice8W ptr, byval as LPDIDEVICEIMAGEINFOHEADERW) as HRESULT
end type

type LPDIRECTINPUTDEVICE8W as IDirectInputDevice8W ptr
type LPDIRECTINPUTDEVICE8 as IDirectInputDevice8W ptr

#else
type IDirectInputDevice8AVtbl_ as IDirectInputDevice8AVtbl

type IDirectInputDevice8A
	lpVtbl as IDirectInputDevice8AVtbl_ ptr
end type

type IDirectInputDevice8AVtbl
	QueryInterface as function (byval as IDirectInputDevice8A ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputDevice8A ptr) as ULONG
	Release as function (byval as IDirectInputDevice8A ptr) as ULONG
	GetCapabilities as function (byval as IDirectInputDevice8A ptr, byval as LPDIDEVCAPS) as HRESULT
	EnumObjects as function (byval as IDirectInputDevice8A ptr, byval as LPDIENUMDEVICEOBJECTSCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetProperty as function (byval as IDirectInputDevice8A ptr, byval as GUID ptr, byval as LPDIPROPHEADER) as HRESULT
	SetProperty as function (byval as IDirectInputDevice8A ptr, byval as GUID ptr, byval as LPCDIPROPHEADER) as HRESULT
	Acquire as function (byval as IDirectInputDevice8A ptr) as HRESULT
	Unacquire as function (byval as IDirectInputDevice8A ptr) as HRESULT
	GetDeviceState as function (byval as IDirectInputDevice8A ptr, byval as DWORD, byval as LPVOID) as HRESULT
	GetDeviceData as function (byval as IDirectInputDevice8A ptr, byval as DWORD, byval as LPDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	SetDataFormat as function (byval as IDirectInputDevice8A ptr, byval as LPCDIDATAFORMAT) as HRESULT
	SetEventNotification as function (byval as IDirectInputDevice8A ptr, byval as HANDLE) as HRESULT
	SetCooperativeLevel as function (byval as IDirectInputDevice8A ptr, byval as HWND, byval as DWORD) as HRESULT
	GetObjectInfo as function (byval as IDirectInputDevice8A ptr, byval as LPDIDEVICEOBJECTINSTANCEA, byval as DWORD, byval as DWORD) as HRESULT
	GetDeviceInfo as function (byval as IDirectInputDevice8A ptr, byval as LPDIDEVICEINSTANCEA) as HRESULT
	RunControlPanel as function (byval as IDirectInputDevice8A ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputDevice8A ptr, byval as HINSTANCE, byval as DWORD, byval as GUID ptr) as HRESULT
	CreateEffect as function (byval as IDirectInputDevice8A ptr, byval as GUID ptr, byval as LPCDIEFFECT, byval as LPDIRECTINPUTEFFECT ptr, byval as LPUNKNOWN) as HRESULT
	EnumEffects as function (byval as IDirectInputDevice8A ptr, byval as LPDIENUMEFFECTSCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetEffectInfo as function (byval as IDirectInputDevice8A ptr, byval as LPDIEFFECTINFOA, byval as GUID ptr) as HRESULT
	GetForceFeedbackState as function (byval as IDirectInputDevice8A ptr, byval as LPDWORD) as HRESULT
	SendForceFeedbackCommand as function (byval as IDirectInputDevice8A ptr, byval as DWORD) as HRESULT
	EnumCreatedEffectObjects as function (byval as IDirectInputDevice8A ptr, byval as LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	Escape as function (byval as IDirectInputDevice8A ptr, byval as LPDIEFFESCAPE) as HRESULT
	Poll as function (byval as IDirectInputDevice8A ptr) as HRESULT
	SendDeviceData as function (byval as IDirectInputDevice8A ptr, byval as DWORD, byval as LPCDIDEVICEOBJECTDATA, byval as LPDWORD, byval as DWORD) as HRESULT
	EnumEffectsInFile as function (byval as IDirectInputDevice8A ptr, byval as LPCSTR, byval as LPDIENUMEFFECTSINFILECALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	WriteEffectToFile as function (byval as IDirectInputDevice8A ptr, byval as LPCSTR, byval as DWORD, byval as LPDIFILEEFFECT, byval as DWORD) as HRESULT
	BuildActionMap as function (byval as IDirectInputDevice8A ptr, byval as LPDIACTIONFORMATA, byval as LPCSTR, byval as DWORD) as HRESULT
	SetActionMap as function (byval as IDirectInputDevice8A ptr, byval as LPDIACTIONFORMATA, byval as LPCSTR, byval as DWORD) as HRESULT
	GetImageInfo as function (byval as IDirectInputDevice8A ptr, byval as LPDIDEVICEIMAGEINFOHEADERA) as HRESULT
end type

type LPDIRECTINPUTDEVICE8A as IDirectInputDevice8A ptr
type LPDIRECTINPUTDEVICE8 as IDirectInputDevice8A ptr
#endif

#define IDirectInputDevice8_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectInputDevice8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectInputDevice8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInputDevice8_GetCapabilities(p,a) (p)->lpVtbl->GetCapabilities(p,a)
#define IDirectInputDevice8_EnumObjects(p,a,b,c) (p)->lpVtbl->EnumObjects(p,a,b,c)
#define IDirectInputDevice8_GetProperty(p,a,b) (p)->lpVtbl->GetProperty(p,a,b)
#define IDirectInputDevice8_SetProperty(p,a,b) (p)->lpVtbl->SetProperty(p,a,b)
#define IDirectInputDevice8_Acquire(p) (p)->lpVtbl->Acquire(p)
#define IDirectInputDevice8_Unacquire(p) (p)->lpVtbl->Unacquire(p)
#define IDirectInputDevice8_GetDeviceState(p,a,b) (p)->lpVtbl->GetDeviceState(p,a,b)
#define IDirectInputDevice8_GetDeviceData(p,a,b,c,d) (p)->lpVtbl->GetDeviceData(p,a,b,c,d)
#define IDirectInputDevice8_SetDataFormat(p,a) (p)->lpVtbl->SetDataFormat(p,a)
#define IDirectInputDevice8_SetEventNotification(p,a) (p)->lpVtbl->SetEventNotification(p,a)
#define IDirectInputDevice8_SetCooperativeLevel(p,a,b) (p)->lpVtbl->SetCooperativeLevel(p,a,b)
#define IDirectInputDevice8_GetObjectInfo(p,a,b,c) (p)->lpVtbl->GetObjectInfo(p,a,b,c)
#define IDirectInputDevice8_GetDeviceInfo(p,a) (p)->lpVtbl->GetDeviceInfo(p,a)
#define IDirectInputDevice8_RunControlPanel(p,a,b) (p)->lpVtbl->RunControlPanel(p,a,b)
#define IDirectInputDevice8_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectInputDevice8_CreateEffect(p,a,b,c,d) (p)->lpVtbl->CreateEffect(p,a,b,c,d)
#define IDirectInputDevice8_EnumEffects(p,a,b,c) (p)->lpVtbl->EnumEffects(p,a,b,c)
#define IDirectInputDevice8_GetEffectInfo(p,a,b) (p)->lpVtbl->GetEffectInfo(p,a,b)
#define IDirectInputDevice8_GetForceFeedbackState(p,a) (p)->lpVtbl->GetForceFeedbackState(p,a)
#define IDirectInputDevice8_SendForceFeedbackCommand(p,a) (p)->lpVtbl->SendForceFeedbackCommand(p,a)
#define IDirectInputDevice8_EnumCreatedEffectObjects(p,a,b,c) (p)->lpVtbl->EnumCreatedEffectObjects(p,a,b,c)
#define IDirectInputDevice8_Escape(p,a) (p)->lpVtbl->Escape(p,a)
#define IDirectInputDevice8_Poll(p) (p)->lpVtbl->Poll(p)
#define IDirectInputDevice8_SendDeviceData(p,a,b,c,d) (p)->lpVtbl->SendDeviceData(p,a,b,c,d)
#define IDirectInputDevice8_EnumEffectsInFile(p,a,b,c,d) (p)->lpVtbl->EnumEffectsInFile(p,a,b,c,d)
#define IDirectInputDevice8_WriteEffectToFile(p,a,b,c,d) (p)->lpVtbl->WriteEffectToFile(p,a,b,c,d)
#define IDirectInputDevice8_BuildActionMap(p,a,b,c) (p)->lpVtbl->BuildActionMap(p,a,b,c)
#define IDirectInputDevice8_SetActionMap(p,a,b,c) (p)->lpVtbl->SetActionMap(p,a,b,c)
#define IDirectInputDevice8_GetImageInfo(p,a) (p)->lpVtbl->GetImageInfo(p,a)

type DIMOUSESTATE
	lX as LONG
	lY as LONG
	lZ as LONG
	rgbButtons(0 to 4-1) as UBYTE
end type

type LPDIMOUSESTATE as DIMOUSESTATE ptr

type DIMOUSESTATE2
	lX as LONG
	lY as LONG
	lZ as LONG
	rgbButtons(0 to 8-1) as UBYTE
end type

type LPDIMOUSESTATE2 as DIMOUSESTATE2 ptr

#define DIMOFS_X        offsetof(DIMOUSESTATE, lX)
#define DIMOFS_Y        offsetof(DIMOUSESTATE, lY)
#define DIMOFS_Z        offsetof(DIMOUSESTATE, lZ)
#define DIMOFS_BUTTON0 (offsetof(DIMOUSESTATE, rgbButtons) + 0)
#define DIMOFS_BUTTON1 (offsetof(DIMOUSESTATE, rgbButtons) + 1)
#define DIMOFS_BUTTON2 (offsetof(DIMOUSESTATE, rgbButtons) + 2)
#define DIMOFS_BUTTON3 (offsetof(DIMOUSESTATE, rgbButtons) + 3)
#define DIMOFS_BUTTON4 (offsetof(DIMOUSESTATE2, rgbButtons) + 4)
#define DIMOFS_BUTTON5 (offsetof(DIMOUSESTATE2, rgbButtons) + 5)
#define DIMOFS_BUTTON6 (offsetof(DIMOUSESTATE2, rgbButtons) + 6)
#define DIMOFS_BUTTON7 (offsetof(DIMOUSESTATE2, rgbButtons) + 7)

#define DIK_ESCAPE &h01
#define DIK_1 &h02
#define DIK_2 &h03
#define DIK_3 &h04
#define DIK_4 &h05
#define DIK_5 &h06
#define DIK_6 &h07
#define DIK_7 &h08
#define DIK_8 &h09
#define DIK_9 &h0A
#define DIK_0 &h0B
#define DIK_MINUS &h0C
#define DIK_EQUALS &h0D
#define DIK_BACK &h0E
#define DIK_TAB &h0F
#define DIK_Q &h10
#define DIK_W &h11
#define DIK_E &h12
#define DIK_R &h13
#define DIK_T &h14
#define DIK_Y &h15
#define DIK_U &h16
#define DIK_I &h17
#define DIK_O &h18
#define DIK_P &h19
#define DIK_LBRACKET &h1A
#define DIK_RBRACKET &h1B
#define DIK_RETURN &h1C
#define DIK_LCONTROL &h1D
#define DIK_A &h1E
#define DIK_S &h1F
#define DIK_D &h20
#define DIK_F &h21
#define DIK_G &h22
#define DIK_H &h23
#define DIK_J &h24
#define DIK_K &h25
#define DIK_L &h26
#define DIK_SEMICOLON &h27
#define DIK_APOSTROPHE &h28
#define DIK_GRAVE &h29
#define DIK_LSHIFT &h2A
#define DIK_BACKSLASH &h2B
#define DIK_Z &h2C
#define DIK_X &h2D
#define DIK_C &h2E
#define DIK_V &h2F
#define DIK_B &h30
#define DIK_N &h31
#define DIK_M &h32
#define DIK_COMMA &h33
#define DIK_PERIOD &h34
#define DIK_SLASH &h35
#define DIK_RSHIFT &h36
#define DIK_MULTIPLY &h37
#define DIK_LMENU &h38
#define DIK_SPACE &h39
#define DIK_CAPITAL &h3A
#define DIK_F1 &h3B
#define DIK_F2 &h3C
#define DIK_F3 &h3D
#define DIK_F4 &h3E
#define DIK_F5 &h3F
#define DIK_F6 &h40
#define DIK_F7 &h41
#define DIK_F8 &h42
#define DIK_F9 &h43
#define DIK_F10 &h44
#define DIK_NUMLOCK &h45
#define DIK_SCROLL &h46
#define DIK_NUMPAD7 &h47
#define DIK_NUMPAD8 &h48
#define DIK_NUMPAD9 &h49
#define DIK_SUBTRACT &h4A
#define DIK_NUMPAD4 &h4B
#define DIK_NUMPAD5 &h4C
#define DIK_NUMPAD6 &h4D
#define DIK_ADD &h4E
#define DIK_NUMPAD1 &h4F
#define DIK_NUMPAD2 &h50
#define DIK_NUMPAD3 &h51
#define DIK_NUMPAD0 &h52
#define DIK_DECIMAL &h53
#define DIK_OEM_102 &h56
#define DIK_F11 &h57
#define DIK_F12 &h58
#define DIK_F13 &h64
#define DIK_F14 &h65
#define DIK_F15 &h66
#define DIK_KANA &h70
#define DIK_ABNT_C1 &h73
#define DIK_CONVERT &h79
#define DIK_NOCONVERT &h7B
#define DIK_YEN &h7D
#define DIK_ABNT_C2 &h7E
#define DIK_NUMPADEQUALS &h8D
#define DIK_PREVTRACK &h90
#define DIK_AT &h91
#define DIK_COLON &h92
#define DIK_UNDERLINE &h93
#define DIK_KANJI &h94
#define DIK_STOP &h95
#define DIK_AX &h96
#define DIK_UNLABELED &h97
#define DIK_NEXTTRACK &h99
#define DIK_NUMPADENTER &h9C
#define DIK_RCONTROL &h9D
#define DIK_MUTE &hA0
#define DIK_CALCULATOR &hA1
#define DIK_PLAYPAUSE &hA2
#define DIK_MEDIASTOP &hA4
#define DIK_VOLUMEDOWN &hAE
#define DIK_VOLUMEUP &hB0
#define DIK_WEBHOME &hB2
#define DIK_NUMPADCOMMA &hB3
#define DIK_DIVIDE &hB5
#define DIK_SYSRQ &hB7
#define DIK_RMENU &hB8
#define DIK_PAUSE &hC5
#define DIK_HOME &hC7
#define DIK_UP &hC8
#define DIK_PRIOR &hC9
#define DIK_LEFT &hCB
#define DIK_RIGHT &hCD
#define DIK_END &hCF
#define DIK_DOWN &hD0
#define DIK_NEXT &hD1
#define DIK_INSERT &hD2
#define DIK_DELETE &hD3
#define DIK_LWIN &hDB
#define DIK_RWIN &hDC
#define DIK_APPS &hDD
#define DIK_POWER &hDE
#define DIK_SLEEP &hDF
#define DIK_WAKE &hE3
#define DIK_WEBSEARCH &hE5
#define DIK_WEBFAVORITES &hE6
#define DIK_WEBREFRESH &hE7
#define DIK_WEBSTOP &hE8
#define DIK_WEBFORWARD &hE9
#define DIK_WEBBACK &hEA
#define DIK_MYCOMPUTER &hEB
#define DIK_MAIL &hEC
#define DIK_MEDIASELECT &hED
#define DIK_BACKSPACE &h0E
#define DIK_NUMPADSTAR &h37
#define DIK_LALT &h38
#define DIK_CAPSLOCK &h3A
#define DIK_NUMPADMINUS &h4A
#define DIK_NUMPADPLUS &h4E
#define DIK_NUMPADPERIOD &h53
#define DIK_NUMPADSLASH &hB5
#define DIK_RALT &hB8
#define DIK_UPARROW &hC8
#define DIK_PGUP &hC9
#define DIK_LEFTARROW &hCB
#define DIK_RIGHTARROW &hCD
#define DIK_DOWNARROW &hD0
#define DIK_PGDN &hD1
#define DIK_CIRCUMFLEX &h90

type DIJOYSTATE
	lX as LONG
	lY as LONG
	lZ as LONG
	lRx as LONG
	lRy as LONG
	lRz as LONG
	rglSlider(0 to 2-1) as LONG
	rgdwPOV(0 to 4-1) as DWORD
	rgbButtons(0 to 32-1) as UBYTE
end type

type LPDIJOYSTATE as DIJOYSTATE ptr

type DIJOYSTATE2
	lX as LONG
	lY as LONG
	lZ as LONG
	lRx as LONG
	lRy as LONG
	lRz as LONG
	rglSlider(0 to 2-1) as LONG
	rgdwPOV(0 to 4-1) as DWORD
	rgbButtons(0 to 128-1) as UBYTE
	lVX as LONG
	lVY as LONG
	lVZ as LONG
	lVRx as LONG
	lVRy as LONG
	lVRz as LONG
	rglVSlider(0 to 2-1) as LONG
	lAX as LONG
	lAY as LONG
	lAZ as LONG
	lARx as LONG
	lARy as LONG
	lARz as LONG
	rglASlider(0 to 2-1) as LONG
	lFX as LONG
	lFY as LONG
	lFZ as LONG
	lFRx as LONG
	lFRy as LONG
	lFRz as LONG
	rglFSlider(0 to 2-1) as LONG
end type

type LPDIJOYSTATE2 as DIJOYSTATE2 ptr

#define DIJOFS_X            offsetof(DIJOYSTATE, lX)
#define DIJOFS_Y            offsetof(DIJOYSTATE, lY)
#define DIJOFS_Z            offsetof(DIJOYSTATE, lZ)
#define DIJOFS_RX           offsetof(DIJOYSTATE, lRx)
#define DIJOFS_RY           offsetof(DIJOYSTATE, lRy)
#define DIJOFS_RZ           offsetof(DIJOYSTATE, lRz)
#define DIJOFS_SLIDER(n)   (offsetof(DIJOYSTATE, rglSlider) + (n) * sizeof(LONG))
#define DIJOFS_POV(n)      (offsetof(DIJOYSTATE, rgdwPOV) + (n) * sizeof(DWORD))
#define DIJOFS_BUTTON(n)   (offsetof(DIJOYSTATE, rgbButtons) + (n))
#define DIJOFS_BUTTON0      DIJOFS_BUTTON(0)
#define DIJOFS_BUTTON1      DIJOFS_BUTTON(1)
#define DIJOFS_BUTTON2      DIJOFS_BUTTON(2)
#define DIJOFS_BUTTON3      DIJOFS_BUTTON(3)
#define DIJOFS_BUTTON4      DIJOFS_BUTTON(4)
#define DIJOFS_BUTTON5      DIJOFS_BUTTON(5)
#define DIJOFS_BUTTON6      DIJOFS_BUTTON(6)
#define DIJOFS_BUTTON7      DIJOFS_BUTTON(7)
#define DIJOFS_BUTTON8      DIJOFS_BUTTON(8)
#define DIJOFS_BUTTON9      DIJOFS_BUTTON(9)
#define DIJOFS_BUTTON10     DIJOFS_BUTTON(10)
#define DIJOFS_BUTTON11     DIJOFS_BUTTON(11)
#define DIJOFS_BUTTON12     DIJOFS_BUTTON(12)
#define DIJOFS_BUTTON13     DIJOFS_BUTTON(13)
#define DIJOFS_BUTTON14     DIJOFS_BUTTON(14)
#define DIJOFS_BUTTON15     DIJOFS_BUTTON(15)
#define DIJOFS_BUTTON16     DIJOFS_BUTTON(16)
#define DIJOFS_BUTTON17     DIJOFS_BUTTON(17)
#define DIJOFS_BUTTON18     DIJOFS_BUTTON(18)
#define DIJOFS_BUTTON19     DIJOFS_BUTTON(19)
#define DIJOFS_BUTTON20     DIJOFS_BUTTON(20)
#define DIJOFS_BUTTON21     DIJOFS_BUTTON(21)
#define DIJOFS_BUTTON22     DIJOFS_BUTTON(22)
#define DIJOFS_BUTTON23     DIJOFS_BUTTON(23)
#define DIJOFS_BUTTON24     DIJOFS_BUTTON(24)
#define DIJOFS_BUTTON25     DIJOFS_BUTTON(25)
#define DIJOFS_BUTTON26     DIJOFS_BUTTON(26)
#define DIJOFS_BUTTON27     DIJOFS_BUTTON(27)
#define DIJOFS_BUTTON28     DIJOFS_BUTTON(28)
#define DIJOFS_BUTTON29     DIJOFS_BUTTON(29)
#define DIJOFS_BUTTON30     DIJOFS_BUTTON(30)
#define DIJOFS_BUTTON31     DIJOFS_BUTTON(31)

#define DIENUM_STOP 0
#define DIENUM_CONTINUE 1

#ifndef UNICODE
type LPDIENUMDEVICESCALLBACKA as function (byval as LPCDIDEVICEINSTANCEA, byval as LPVOID) as BOOL
type LPDIENUMDEVICESBYSEMANTICSCBA as function (byval as LPCDIDEVICEINSTANCEA, byval as LPDIRECTINPUTDEVICE8A, byval as DWORD, byval as DWORD, byval as LPVOID) as BOOL
#define LPDIENUMDEVICESCALLBACK  LPDIENUMDEVICESCALLBACKA
#define LPDIENUMDEVICESBYSEMANTICSCB  LPDIENUMDEVICESBYSEMANTICSCBA
#else
type LPDIENUMDEVICESCALLBACKW as function (byval as LPCDIDEVICEINSTANCEW, byval as LPVOID) as BOOL
type LPDIENUMDEVICESBYSEMANTICSCBW as function (byval as LPCDIDEVICEINSTANCEW, byval as LPDIRECTINPUTDEVICE8W, byval as DWORD, byval as DWORD, byval as LPVOID) as BOOL
#define LPDIENUMDEVICESCALLBACK  LPDIENUMDEVICESCALLBACKW
#define LPDIENUMDEVICESBYSEMANTICSCB  LPDIENUMDEVICESBYSEMANTICSCBW
#endif

type LPDICONFIGUREDEVICESCALLBACK as function (byval as IUnknown ptr, byval as LPVOID) as BOOL

#define DIEDFL_ALLDEVICES &h00000000
#define DIEDFL_ATTACHEDONLY &h00000001
#define DIEDFL_FORCEFEEDBACK &h00000100
#define DIEDFL_INCLUDEALIASES &h00010000
#define DIEDFL_INCLUDEPHANTOMS &h00020000
#define DIEDFL_INCLUDEHIDDEN &h00040000


#define DIEDBS_MAPPEDPRI1 &h00000001
#define DIEDBS_MAPPEDPRI2 &h00000002
#define DIEDBS_RECENTDEVICE &h00000010
#define DIEDBS_NEWDEVICE &h00000020
#define DIEDBSFL_ATTACHEDONLY &h00000000
#define DIEDBSFL_THISUSER &h00000010
#define DIEDBSFL_FORCEFEEDBACK &h00000100
#define DIEDBSFL_AVAILABLEDEVICES &h00001000
#define DIEDBSFL_MULTIMICEKEYBOARDS &h00002000
#define DIEDBSFL_NONGAMINGDEVICES &h00004000
#define DIEDBSFL_VALID &h00007110

#ifdef UNICODE
type IDirectInputWVtbl_ as IDirectInputWVtbl

type IDirectInputW
	lpVtbl as IDirectInputWVtbl_ ptr
end type

type IDirectInputWVtbl
	QueryInterface as function (byval as IDirectInputW ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputW ptr) as ULONG
	Release as function (byval as IDirectInputW ptr) as ULONG
	CreateDevice as function (byval as IDirectInputW ptr, byval as GUID ptr, byval as LPDIRECTINPUTDEVICEW ptr, byval as LPUNKNOWN) as HRESULT
	EnumDevices as function (byval as IDirectInputW ptr, byval as DWORD, byval as LPDIENUMDEVICESCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetDeviceStatus as function (byval as IDirectInputW ptr, byval as GUID ptr) as HRESULT
	RunControlPanel as function (byval as IDirectInputW ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputW ptr, byval as HINSTANCE, byval as DWORD) as HRESULT
end type

type LPDIRECTINPUTW as IDirectInputW ptr
type LPDIRECTINPUT as IDirectInputW ptr
#define IID_IDirectInput IID_IDirectInputW
#define IDirectInput IDirectInputW
#define IDirectInputVtbl IDirectInputWVtbl

#else
type IDirectInputAVtbl_ as IDirectInputAVtbl

type IDirectInputA
	lpVtbl as IDirectInputAVtbl_ ptr
end type

type IDirectInputAVtbl
	QueryInterface as function (byval as IDirectInputA ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInputA ptr) as ULONG
	Release as function (byval as IDirectInputA ptr) as ULONG
	CreateDevice as function (byval as IDirectInputA ptr, byval as GUID ptr, byval as LPDIRECTINPUTDEVICEA ptr, byval as LPUNKNOWN) as HRESULT
	EnumDevices as function (byval as IDirectInputA ptr, byval as DWORD, byval as LPDIENUMDEVICESCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetDeviceStatus as function (byval as IDirectInputA ptr, byval as GUID ptr) as HRESULT
	RunControlPanel as function (byval as IDirectInputA ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInputA ptr, byval as HINSTANCE, byval as DWORD) as HRESULT
end type

type LPDIRECTINPUTA as IDirectInputA ptr
type LPDIRECTINPUT as IDirectInputA ptr
#define IID_IDirectInput IID_IDirectInputA
#define IDirectInput IDirectInputA
#define IDirectInputVtbl IDirectInputAVtbl
#endif

#define IDirectInput_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectInput_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectInput_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInput_CreateDevice(p,a,b,c) (p)->lpVtbl->CreateDevice(p,a,b,c)
#define IDirectInput_EnumDevices(p,a,b,c,d) (p)->lpVtbl->EnumDevices(p,a,b,c,d)
#define IDirectInput_GetDeviceStatus(p,a) (p)->lpVtbl->GetDeviceStatus(p,a)
#define IDirectInput_RunControlPanel(p,a,b) (p)->lpVtbl->RunControlPanel(p,a,b)
#define IDirectInput_Initialize(p,a,b) (p)->lpVtbl->Initialize(p,a,b)

#ifdef UNICODE
type IDirectInput2WVtbl_ as IDirectInput2WVtbl

type IDirectInput2W
	lpVtbl as IDirectInput2WVtbl_ ptr
end type

type IDirectInput2WVtbl
	QueryInterface as function (byval as IDirectInput2W ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInput2W ptr) as ULONG
	Release as function (byval as IDirectInput2W ptr) as ULONG
	CreateDevice as function (byval as IDirectInput2W ptr, byval as GUID ptr, byval as LPDIRECTINPUTDEVICEW ptr, byval as LPUNKNOWN) as HRESULT
	EnumDevices as function (byval as IDirectInput2W ptr, byval as DWORD, byval as LPDIENUMDEVICESCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetDeviceStatus as function (byval as IDirectInput2W ptr, byval as GUID ptr) as HRESULT
	RunControlPanel as function (byval as IDirectInput2W ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInput2W ptr, byval as HINSTANCE, byval as DWORD) as HRESULT
	FindDevice as function (byval as IDirectInput2W ptr, byval as GUID ptr, byval as LPCWSTR, byval as LPGUID) as HRESULT
end type

type LPDIRECTINPUT2W as IDirectInput2W ptr
type LPDIRECTINPUT2 as IDirectInput2W ptr
#define IID_IDirectInput2 IID_IDirectInput2W
#define IDirectInput2 IDirectInput2W
#define IDirectInput2Vtbl IDirectInput2WVtbl

#else
type IDirectInput2AVtbl_ as IDirectInput2AVtbl

type IDirectInput2A
	lpVtbl as IDirectInput2AVtbl_ ptr
end type

type IDirectInput2AVtbl
	QueryInterface as function (byval as IDirectInput2A ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInput2A ptr) as ULONG
	Release as function (byval as IDirectInput2A ptr) as ULONG
	CreateDevice as function (byval as IDirectInput2A ptr, byval as GUID ptr, byval as LPDIRECTINPUTDEVICEA ptr, byval as LPUNKNOWN) as HRESULT
	EnumDevices as function (byval as IDirectInput2A ptr, byval as DWORD, byval as LPDIENUMDEVICESCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetDeviceStatus as function (byval as IDirectInput2A ptr, byval as GUID ptr) as HRESULT
	RunControlPanel as function (byval as IDirectInput2A ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInput2A ptr, byval as HINSTANCE, byval as DWORD) as HRESULT
	FindDevice as function (byval as IDirectInput2A ptr, byval as GUID ptr, byval as LPCSTR, byval as LPGUID) as HRESULT
end type

type LPDIRECTINPUT2A as IDirectInput2A ptr
type LPDIRECTINPUT2 as IDirectInput2A ptr
#define IID_IDirectInput2 IID_IDirectInput2A
#define IDirectInput2 IDirectInput2A
#define IDirectInput2Vtbl IDirectInput2AVtbl
#endif

#define IDirectInput2_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectInput2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectInput2_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInput2_CreateDevice(p,a,b,c) (p)->lpVtbl->CreateDevice(p,a,b,c)
#define IDirectInput2_EnumDevices(p,a,b,c,d) (p)->lpVtbl->EnumDevices(p,a,b,c,d)
#define IDirectInput2_GetDeviceStatus(p,a) (p)->lpVtbl->GetDeviceStatus(p,a)
#define IDirectInput2_RunControlPanel(p,a,b) (p)->lpVtbl->RunControlPanel(p,a,b)
#define IDirectInput2_Initialize(p,a,b) (p)->lpVtbl->Initialize(p,a,b)
#define IDirectInput2_FindDevice(p,a,b,c) (p)->lpVtbl->FindDevice(p,a,b,c)

#ifdef UNICODE
type IDirectInput7WVtbl_ as IDirectInput7WVtbl

type IDirectInput7W
	lpVtbl as IDirectInput7WVtbl_ ptr
end type

type IDirectInput7WVtbl
	QueryInterface as function (byval as IDirectInput7W ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInput7W ptr) as ULONG
	Release as function (byval as IDirectInput7W ptr) as ULONG
	CreateDevice as function (byval as IDirectInput7W ptr, byval as GUID ptr, byval as LPDIRECTINPUTDEVICEW ptr, byval as LPUNKNOWN) as HRESULT
	EnumDevices as function (byval as IDirectInput7W ptr, byval as DWORD, byval as LPDIENUMDEVICESCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetDeviceStatus as function (byval as IDirectInput7W ptr, byval as GUID ptr) as HRESULT
	RunControlPanel as function (byval as IDirectInput7W ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInput7W ptr, byval as HINSTANCE, byval as DWORD) as HRESULT
	FindDevice as function (byval as IDirectInput7W ptr, byval as GUID ptr, byval as LPCWSTR, byval as LPGUID) as HRESULT
	CreateDeviceEx as function (byval as IDirectInput7W ptr, byval as GUID ptr, byval as IID ptr, byval as LPVOID ptr, byval as LPUNKNOWN) as HRESULT
end type

type LPDIRECTINPUT7W as IDirectInput7W ptr
type LPDIRECTINPUT7 as IDirectInput7W ptr
#define IID_IDirectInput7 IID_IDirectInput7W
#define IDirectInput7 IDirectInput7W
#define IDirectInput7Vtbl IDirectInput7WVtbl

#else
type IDirectInput7AVtbl_ as IDirectInput7AVtbl

type IDirectInput7A
	lpVtbl as IDirectInput7AVtbl_ ptr
end type

type IDirectInput7AVtbl
	QueryInterface as function (byval as IDirectInput7A ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInput7A ptr) as ULONG
	Release as function (byval as IDirectInput7A ptr) as ULONG
	CreateDevice as function (byval as IDirectInput7A ptr, byval as GUID ptr, byval as LPDIRECTINPUTDEVICEA ptr, byval as LPUNKNOWN) as HRESULT
	EnumDevices as function (byval as IDirectInput7A ptr, byval as DWORD, byval as LPDIENUMDEVICESCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetDeviceStatus as function (byval as IDirectInput7A ptr, byval as GUID ptr) as HRESULT
	RunControlPanel as function (byval as IDirectInput7A ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInput7A ptr, byval as HINSTANCE, byval as DWORD) as HRESULT
	FindDevice as function (byval as IDirectInput7A ptr, byval as GUID ptr, byval as LPCSTR, byval as LPGUID) as HRESULT
	CreateDeviceEx as function (byval as IDirectInput7A ptr, byval as GUID ptr, byval as IID ptr, byval as LPVOID ptr, byval as LPUNKNOWN) as HRESULT
end type

type LPDIRECTINPUT7A as IDirectInput7A ptr
type LPDIRECTINPUT7 as IDirectInput7A ptr
#define IID_IDirectInput7 IID_IDirectInput7A
#define IDirectInput7 IDirectInput7A
#define IDirectInput7Vtbl IDirectInput7AVtbl
#endif

#define IDirectInput7_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectInput7_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectInput7_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInput7_CreateDevice(p,a,b,c) (p)->lpVtbl->CreateDevice(p,a,b,c)
#define IDirectInput7_EnumDevices(p,a,b,c,d) (p)->lpVtbl->EnumDevices(p,a,b,c,d)
#define IDirectInput7_GetDeviceStatus(p,a) (p)->lpVtbl->GetDeviceStatus(p,a)
#define IDirectInput7_RunControlPanel(p,a,b) (p)->lpVtbl->RunControlPanel(p,a,b)
#define IDirectInput7_Initialize(p,a,b) (p)->lpVtbl->Initialize(p,a,b)
#define IDirectInput7_FindDevice(p,a,b,c) (p)->lpVtbl->FindDevice(p,a,b,c)
#define IDirectInput7_CreateDeviceEx(p,a,b,c,d) (p)->lpVtbl->CreateDeviceEx(p,a,b,c,d)

#ifdef UNICODE
type IDirectInput8WVtbl_ as IDirectInput8WVtbl

type IDirectInput8W
	lpVtbl as IDirectInput8WVtbl_ ptr
end type

type IDirectInput8WVtbl
	QueryInterface as function (byval as IDirectInput8W ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInput8W ptr) as ULONG
	Release as function (byval as IDirectInput8W ptr) as ULONG
	CreateDevice as function (byval as IDirectInput8W ptr, byval as GUID ptr, byval as LPDIRECTINPUTDEVICE8W ptr, byval as LPUNKNOWN) as HRESULT
	EnumDevices as function (byval as IDirectInput8W ptr, byval as DWORD, byval as LPDIENUMDEVICESCALLBACKW, byval as LPVOID, byval as DWORD) as HRESULT
	GetDeviceStatus as function (byval as IDirectInput8W ptr, byval as GUID ptr) as HRESULT
	RunControlPanel as function (byval as IDirectInput8W ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInput8W ptr, byval as HINSTANCE, byval as DWORD) as HRESULT
	FindDevice as function (byval as IDirectInput8W ptr, byval as GUID ptr, byval as LPCWSTR, byval as LPGUID) as HRESULT
	EnumDevicesBySemantics as function (byval as IDirectInput8W ptr, byval as LPCWSTR, byval as LPDIACTIONFORMATW, byval as LPDIENUMDEVICESBYSEMANTICSCBW, byval as LPVOID, byval as DWORD) as HRESULT
	ConfigureDevices as function (byval as IDirectInput8W ptr, byval as LPDICONFIGUREDEVICESCALLBACK, byval as LPDICONFIGUREDEVICESPARAMSW, byval as DWORD, byval as LPVOID) as HRESULT
end type

type LPDIRECTINPUT8W as IDirectInput8W ptr
type LPDIRECTINPUT8 as IDirectInput8W ptr
#define IID_IDirectInput8 IID_IDirectInput8W
#define IDirectInput8 IDirectInput8W
#define IDirectInput8Vtbl IDirectInput8WVtbl

#else
type IDirectInput8AVtbl_ as IDirectInput8AVtbl

type IDirectInput8A
	lpVtbl as IDirectInput8AVtbl_ ptr
end type

type IDirectInput8AVtbl
	QueryInterface as function (byval as IDirectInput8A ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectInput8A ptr) as ULONG
	Release as function (byval as IDirectInput8A ptr) as ULONG
	CreateDevice as function (byval as IDirectInput8A ptr, byval as GUID ptr, byval as LPDIRECTINPUTDEVICE8A ptr, byval as LPUNKNOWN) as HRESULT
	EnumDevices as function (byval as IDirectInput8A ptr, byval as DWORD, byval as LPDIENUMDEVICESCALLBACKA, byval as LPVOID, byval as DWORD) as HRESULT
	GetDeviceStatus as function (byval as IDirectInput8A ptr, byval as GUID ptr) as HRESULT
	RunControlPanel as function (byval as IDirectInput8A ptr, byval as HWND, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectInput8A ptr, byval as HINSTANCE, byval as DWORD) as HRESULT
	FindDevice as function (byval as IDirectInput8A ptr, byval as GUID ptr, byval as LPCSTR, byval as LPGUID) as HRESULT
	EnumDevicesBySemantics as function (byval as IDirectInput8A ptr, byval as LPCSTR, byval as LPDIACTIONFORMATA, byval as LPDIENUMDEVICESBYSEMANTICSCBA, byval as LPVOID, byval as DWORD) as HRESULT
	ConfigureDevices as function (byval as IDirectInput8A ptr, byval as LPDICONFIGUREDEVICESCALLBACK, byval as LPDICONFIGUREDEVICESPARAMSA, byval as DWORD, byval as LPVOID) as HRESULT
end type

type LPDIRECTINPUT8A as IDirectInput8A ptr
type LPDIRECTINPUT8 as IDirectInput8A ptr
#define IID_IDirectInput8 IID_IDirectInput8A
#define IDirectInput8 IDirectInput8A
#define IDirectInput8Vtbl IDirectInput8AVtbl
#endif

#define IDirectInput8_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectInput8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectInput8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInput8_CreateDevice(p,a,b,c) (p)->lpVtbl->CreateDevice(p,a,b,c)
#define IDirectInput8_EnumDevices(p,a,b,c,d) (p)->lpVtbl->EnumDevices(p,a,b,c,d)
#define IDirectInput8_GetDeviceStatus(p,a) (p)->lpVtbl->GetDeviceStatus(p,a)
#define IDirectInput8_RunControlPanel(p,a,b) (p)->lpVtbl->RunControlPanel(p,a,b)
#define IDirectInput8_Initialize(p,a,b) (p)->lpVtbl->Initialize(p,a,b)
#define IDirectInput8_FindDevice(p,a,b,c) (p)->lpVtbl->FindDevice(p,a,b,c)
#define IDirectInput8_EnumDevicesBySemantics(p,a,b,c,d,e) (p)->lpVtbl->EnumDevicesBySemantics(p,a,b,c,d,e)
#define IDirectInput8_ConfigureDevices(p,a,b,c,d) (p)->lpVtbl->ConfigureDevices(p,a,b,c,d)

declare function DirectInput8Create alias "DirectInput8Create" (byval hinst as HINSTANCE, byval dwVersion as DWORD, byval riidltf as IID ptr, byval ppvOut as LPVOID ptr, byval punkOuter as LPUNKNOWN) as HRESULT

#define DI_OK S_OK
#define DI_NOTATTACHED S_FALSE
#define DI_BUFFEROVERFLOW S_FALSE
#define DI_PROPNOEFFECT S_FALSE
#define DI_NOEFFECT S_FALSE
#define DI_POLLEDDEVICE cast(HRESULT,&h00000002L)
#define DI_DOWNLOADSKIPPED cast(HRESULT,&h00000003L)
#define DI_EFFECTRESTARTED cast(HRESULT,&h00000004L)
#define DI_TRUNCATED cast(HRESULT,&h00000008L)
#define DI_SETTINGSNOTSAVED cast(HRESULT,&h0000000BL)
#define DI_TRUNCATEDANDRESTARTED cast(HRESULT,&h0000000CL)
#define DI_WRITEPROTECT cast(HRESULT,&h00000013L)
#define DIERR_OLDDIRECTINPUTVERSION MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_OLD_WIN_VERSION)
#define DIERR_BETADIRECTINPUTVERSION MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_RMODE_APP)
#define DIERR_BADDRIVERVER MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_BAD_DRIVER_LEVEL)
#define DIERR_DEVICENOTREG REGDB_E_CLASSNOTREG
#define DIERR_NOTFOUND MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_FILE_NOT_FOUND)
#define DIERR_OBJECTNOTFOUND MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_FILE_NOT_FOUND)
#define DIERR_INVALIDPARAM E_INVALIDARG
#define DIERR_NOINTERFACE E_NOINTERFACE
#define DIERR_GENERIC E_FAIL
#define DIERR_OUTOFMEMORY E_OUTOFMEMORY
#define DIERR_UNSUPPORTED E_NOTIMPL
#define DIERR_NOTINITIALIZED MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_NOT_READY)
#define DIERR_ALREADYINITIALIZED MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_ALREADY_INITIALIZED)
#define DIERR_NOAGGREGATION CLASS_E_NOAGGREGATION
#define DIERR_OTHERAPPHASPRIO E_ACCESSDENIED
#define DIERR_INPUTLOST MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_READ_FAULT)
#define DIERR_ACQUIRED MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_BUSY)
#define DIERR_NOTACQUIRED MAKE_HRESULT(SEVERITY_ERROR, FACILITY_WIN32, ERROR_INVALID_ACCESS)
#define DIERR_READONLY E_ACCESSDENIED
#define DIERR_HANDLEEXISTS E_ACCESSDENIED
#ifndef E_PENDING
#define E_PENDING &h8000000A
#endif
#define DIERR_INSUFFICIENTPRIVS &h80040200L
#define DIERR_DEVICEFULL &h80040201L
#define DIERR_MOREDATA &h80040202L
#define DIERR_NOTDOWNLOADED &h80040203L
#define DIERR_HASEFFECTS &h80040204L
#define DIERR_NOTEXCLUSIVEACQUIRED &h80040205L
#define DIERR_INCOMPLETEEFFECT &h80040206L
#define DIERR_NOTBUFFERED &h80040207L
#define DIERR_EFFECTPLAYING &h80040208L
#define DIERR_UNPLUGGED &h80040209L
#define DIERR_REPORTFULL &h8004020AL
#define DIERR_MAPFILEFAIL &h8004020BL
#define DIKEYBOARD_ESCAPE &h81000401
#define DIKEYBOARD_1 &h81000402
#define DIKEYBOARD_2 &h81000403
#define DIKEYBOARD_3 &h81000404
#define DIKEYBOARD_4 &h81000405
#define DIKEYBOARD_5 &h81000406
#define DIKEYBOARD_6 &h81000407
#define DIKEYBOARD_7 &h81000408
#define DIKEYBOARD_8 &h81000409
#define DIKEYBOARD_9 &h8100040A
#define DIKEYBOARD_0 &h8100040B
#define DIKEYBOARD_MINUS &h8100040C
#define DIKEYBOARD_EQUALS &h8100040D
#define DIKEYBOARD_BACK &h8100040E
#define DIKEYBOARD_TAB &h8100040F
#define DIKEYBOARD_Q &h81000410
#define DIKEYBOARD_W &h81000411
#define DIKEYBOARD_E &h81000412
#define DIKEYBOARD_R &h81000413
#define DIKEYBOARD_T &h81000414
#define DIKEYBOARD_Y &h81000415
#define DIKEYBOARD_U &h81000416
#define DIKEYBOARD_I &h81000417
#define DIKEYBOARD_O &h81000418
#define DIKEYBOARD_P &h81000419
#define DIKEYBOARD_LBRACKET &h8100041A
#define DIKEYBOARD_RBRACKET &h8100041B
#define DIKEYBOARD_RETURN &h8100041C
#define DIKEYBOARD_LCONTROL &h8100041D
#define DIKEYBOARD_A &h8100041E
#define DIKEYBOARD_S &h8100041F
#define DIKEYBOARD_D &h81000420
#define DIKEYBOARD_F &h81000421
#define DIKEYBOARD_G &h81000422
#define DIKEYBOARD_H &h81000423
#define DIKEYBOARD_J &h81000424
#define DIKEYBOARD_K &h81000425
#define DIKEYBOARD_L &h81000426
#define DIKEYBOARD_SEMICOLON &h81000427
#define DIKEYBOARD_APOSTROPHE &h81000428
#define DIKEYBOARD_GRAVE &h81000429
#define DIKEYBOARD_LSHIFT &h8100042A
#define DIKEYBOARD_BACKSLASH &h8100042B
#define DIKEYBOARD_Z &h8100042C
#define DIKEYBOARD_X &h8100042D
#define DIKEYBOARD_C &h8100042E
#define DIKEYBOARD_V &h8100042F
#define DIKEYBOARD_B &h81000430
#define DIKEYBOARD_N &h81000431
#define DIKEYBOARD_M &h81000432
#define DIKEYBOARD_COMMA &h81000433
#define DIKEYBOARD_PERIOD &h81000434
#define DIKEYBOARD_SLASH &h81000435
#define DIKEYBOARD_RSHIFT &h81000436
#define DIKEYBOARD_MULTIPLY &h81000437
#define DIKEYBOARD_LMENU &h81000438
#define DIKEYBOARD_SPACE &h81000439
#define DIKEYBOARD_CAPITAL &h8100043A
#define DIKEYBOARD_F1 &h8100043B
#define DIKEYBOARD_F2 &h8100043C
#define DIKEYBOARD_F3 &h8100043D
#define DIKEYBOARD_F4 &h8100043E
#define DIKEYBOARD_F5 &h8100043F
#define DIKEYBOARD_F6 &h81000440
#define DIKEYBOARD_F7 &h81000441
#define DIKEYBOARD_F8 &h81000442
#define DIKEYBOARD_F9 &h81000443
#define DIKEYBOARD_F10 &h81000444
#define DIKEYBOARD_NUMLOCK &h81000445
#define DIKEYBOARD_SCROLL &h81000446
#define DIKEYBOARD_NUMPAD7 &h81000447
#define DIKEYBOARD_NUMPAD8 &h81000448
#define DIKEYBOARD_NUMPAD9 &h81000449
#define DIKEYBOARD_SUBTRACT &h8100044A
#define DIKEYBOARD_NUMPAD4 &h8100044B
#define DIKEYBOARD_NUMPAD5 &h8100044C
#define DIKEYBOARD_NUMPAD6 &h8100044D
#define DIKEYBOARD_ADD &h8100044E
#define DIKEYBOARD_NUMPAD1 &h8100044F
#define DIKEYBOARD_NUMPAD2 &h81000450
#define DIKEYBOARD_NUMPAD3 &h81000451
#define DIKEYBOARD_NUMPAD0 &h81000452
#define DIKEYBOARD_DECIMAL &h81000453
#define DIKEYBOARD_OEM_102 &h81000456
#define DIKEYBOARD_F11 &h81000457
#define DIKEYBOARD_F12 &h81000458
#define DIKEYBOARD_F13 &h81000464
#define DIKEYBOARD_F14 &h81000465
#define DIKEYBOARD_F15 &h81000466
#define DIKEYBOARD_KANA &h81000470
#define DIKEYBOARD_ABNT_C1 &h81000473
#define DIKEYBOARD_CONVERT &h81000479
#define DIKEYBOARD_NOCONVERT &h8100047B
#define DIKEYBOARD_YEN &h8100047D
#define DIKEYBOARD_ABNT_C2 &h8100047E
#define DIKEYBOARD_NUMPADEQUALS &h8100048D
#define DIKEYBOARD_PREVTRACK &h81000490
#define DIKEYBOARD_AT &h81000491
#define DIKEYBOARD_COLON &h81000492
#define DIKEYBOARD_UNDERLINE &h81000493
#define DIKEYBOARD_KANJI &h81000494
#define DIKEYBOARD_STOP &h81000495
#define DIKEYBOARD_AX &h81000496
#define DIKEYBOARD_UNLABELED &h81000497
#define DIKEYBOARD_NEXTTRACK &h81000499
#define DIKEYBOARD_NUMPADENTER &h8100049C
#define DIKEYBOARD_RCONTROL &h8100049D
#define DIKEYBOARD_MUTE &h810004A0
#define DIKEYBOARD_CALCULATOR &h810004A1
#define DIKEYBOARD_PLAYPAUSE &h810004A2
#define DIKEYBOARD_MEDIASTOP &h810004A4
#define DIKEYBOARD_VOLUMEDOWN &h810004AE
#define DIKEYBOARD_VOLUMEUP &h810004B0
#define DIKEYBOARD_WEBHOME &h810004B2
#define DIKEYBOARD_NUMPADCOMMA &h810004B3
#define DIKEYBOARD_DIVIDE &h810004B5
#define DIKEYBOARD_SYSRQ &h810004B7
#define DIKEYBOARD_RMENU &h810004B8
#define DIKEYBOARD_PAUSE &h810004C5
#define DIKEYBOARD_HOME &h810004C7
#define DIKEYBOARD_UP &h810004C8
#define DIKEYBOARD_PRIOR &h810004C9
#define DIKEYBOARD_LEFT &h810004CB
#define DIKEYBOARD_RIGHT &h810004CD
#define DIKEYBOARD_END &h810004CF
#define DIKEYBOARD_DOWN &h810004D0
#define DIKEYBOARD_NEXT &h810004D1
#define DIKEYBOARD_INSERT &h810004D2
#define DIKEYBOARD_DELETE &h810004D3
#define DIKEYBOARD_LWIN &h810004DB
#define DIKEYBOARD_RWIN &h810004DC
#define DIKEYBOARD_APPS &h810004DD
#define DIKEYBOARD_POWER &h810004DE
#define DIKEYBOARD_SLEEP &h810004DF
#define DIKEYBOARD_WAKE &h810004E3
#define DIKEYBOARD_WEBSEARCH &h810004E5
#define DIKEYBOARD_WEBFAVORITES &h810004E6
#define DIKEYBOARD_WEBREFRESH &h810004E7
#define DIKEYBOARD_WEBSTOP &h810004E8
#define DIKEYBOARD_WEBFORWARD &h810004E9
#define DIKEYBOARD_WEBBACK &h810004EA
#define DIKEYBOARD_MYCOMPUTER &h810004EB
#define DIKEYBOARD_MAIL &h810004EC
#define DIKEYBOARD_MEDIASELECT &h810004ED
#define DIVOICE_CHANNEL1 &h83000401
#define DIVOICE_CHANNEL2 &h83000402
#define DIVOICE_CHANNEL3 &h83000403
#define DIVOICE_CHANNEL4 &h83000404
#define DIVOICE_CHANNEL5 &h83000405
#define DIVOICE_CHANNEL6 &h83000406
#define DIVOICE_CHANNEL7 &h83000407
#define DIVOICE_CHANNEL8 &h83000408
#define DIVOICE_TEAM &h83000409
#define DIVOICE_ALL &h8300040A
#define DIVOICE_RECORDMUTE &h8300040B
#define DIVOICE_PLAYBACKMUTE &h8300040C
#define DIVOICE_TRANSMIT &h8300040D
#define DIVOICE_VOICECOMMAND &h83000410
#define DIVIRTUAL_DRIVING_RACE &h01000000
#define DIAXIS_DRIVINGR_STEER &h01008A01
#define DIAXIS_DRIVINGR_ACCELERATE &h01039202
#define DIAXIS_DRIVINGR_BRAKE &h01041203
#define DIBUTTON_DRIVINGR_SHIFTUP &h01000C01
#define DIBUTTON_DRIVINGR_SHIFTDOWN &h01000C02
#define DIBUTTON_DRIVINGR_VIEW &h01001C03
#define DIBUTTON_DRIVINGR_MENU &h010004FD
#define DIAXIS_DRIVINGR_ACCEL_AND_BRAKE &h01014A04
#define DIHATSWITCH_DRIVINGR_GLANCE &h01004601
#define DIBUTTON_DRIVINGR_BRAKE &h01004C04
#define DIBUTTON_DRIVINGR_DASHBOARD &h01004405
#define DIBUTTON_DRIVINGR_AIDS &h01004406
#define DIBUTTON_DRIVINGR_MAP &h01004407
#define DIBUTTON_DRIVINGR_BOOST &h01004408
#define DIBUTTON_DRIVINGR_PIT &h01004409
#define DIBUTTON_DRIVINGR_ACCELERATE_LINK &h0103D4E0
#define DIBUTTON_DRIVINGR_STEER_LEFT_LINK &h0100CCE4
#define DIBUTTON_DRIVINGR_STEER_RIGHT_LINK &h0100CCEC
#define DIBUTTON_DRIVINGR_GLANCE_LEFT_LINK &h0107C4E4
#define DIBUTTON_DRIVINGR_GLANCE_RIGHT_LINK &h0107C4EC
#define DIBUTTON_DRIVINGR_DEVICE &h010044FE
#define DIBUTTON_DRIVINGR_PAUSE &h010044FC
#define DIVIRTUAL_DRIVING_COMBAT &h02000000
#define DIAXIS_DRIVINGC_STEER &h02008A01
#define DIAXIS_DRIVINGC_ACCELERATE &h02039202
#define DIAXIS_DRIVINGC_BRAKE &h02041203
#define DIBUTTON_DRIVINGC_FIRE &h02000C01
#define DIBUTTON_DRIVINGC_WEAPONS &h02000C02
#define DIBUTTON_DRIVINGC_TARGET &h02000C03
#define DIBUTTON_DRIVINGC_MENU &h020004FD
#define DIAXIS_DRIVINGC_ACCEL_AND_BRAKE &h02014A04
#define DIHATSWITCH_DRIVINGC_GLANCE &h02004601
#define DIBUTTON_DRIVINGC_SHIFTUP &h02004C04
#define DIBUTTON_DRIVINGC_SHIFTDOWN &h02004C05
#define DIBUTTON_DRIVINGC_DASHBOARD &h02004406
#define DIBUTTON_DRIVINGC_AIDS &h02004407
#define DIBUTTON_DRIVINGC_BRAKE &h02004C08
#define DIBUTTON_DRIVINGC_FIRESECONDARY &h02004C09
#define DIBUTTON_DRIVINGC_ACCELERATE_LINK &h0203D4E0
#define DIBUTTON_DRIVINGC_STEER_LEFT_LINK &h0200CCE4
#define DIBUTTON_DRIVINGC_STEER_RIGHT_LINK &h0200CCEC
#define DIBUTTON_DRIVINGC_GLANCE_LEFT_LINK &h0207C4E4
#define DIBUTTON_DRIVINGC_GLANCE_RIGHT_LINK &h0207C4EC
#define DIBUTTON_DRIVINGC_DEVICE &h020044FE
#define DIBUTTON_DRIVINGC_PAUSE &h020044FC
#define DIVIRTUAL_DRIVING_TANK &h03000000
#define DIAXIS_DRIVINGT_STEER &h03008A01
#define DIAXIS_DRIVINGT_BARREL &h03010202
#define DIAXIS_DRIVINGT_ACCELERATE &h03039203
#define DIAXIS_DRIVINGT_ROTATE &h03020204
#define DIBUTTON_DRIVINGT_FIRE &h03000C01
#define DIBUTTON_DRIVINGT_WEAPONS &h03000C02
#define DIBUTTON_DRIVINGT_TARGET &h03000C03
#define DIBUTTON_DRIVINGT_MENU &h030004FD
#define DIHATSWITCH_DRIVINGT_GLANCE &h03004601
#define DIAXIS_DRIVINGT_BRAKE &h03045205
#define DIAXIS_DRIVINGT_ACCEL_AND_BRAKE &h03014A06
#define DIBUTTON_DRIVINGT_VIEW &h03005C04
#define DIBUTTON_DRIVINGT_DASHBOARD &h03005C05
#define DIBUTTON_DRIVINGT_BRAKE &h03004C06
#define DIBUTTON_DRIVINGT_FIRESECONDARY &h03004C07
#define DIBUTTON_DRIVINGT_ACCELERATE_LINK &h0303D4E0
#define DIBUTTON_DRIVINGT_STEER_LEFT_LINK &h0300CCE4
#define DIBUTTON_DRIVINGT_STEER_RIGHT_LINK &h0300CCEC
#define DIBUTTON_DRIVINGT_BARREL_UP_LINK &h030144E0
#define DIBUTTON_DRIVINGT_BARREL_DOWN_LINK &h030144E8
#define DIBUTTON_DRIVINGT_ROTATE_LEFT_LINK &h030244E4
#define DIBUTTON_DRIVINGT_ROTATE_RIGHT_LINK &h030244EC
#define DIBUTTON_DRIVINGT_GLANCE_LEFT_LINK &h0307C4E4
#define DIBUTTON_DRIVINGT_GLANCE_RIGHT_LINK &h0307C4EC
#define DIBUTTON_DRIVINGT_DEVICE &h030044FE
#define DIBUTTON_DRIVINGT_PAUSE &h030044FC
#define DIVIRTUAL_FLYING_CIVILIAN &h04000000
#define DIAXIS_FLYINGC_BANK &h04008A01
#define DIAXIS_FLYINGC_PITCH &h04010A02
#define DIAXIS_FLYINGC_THROTTLE &h04039203
#define DIBUTTON_FLYINGC_VIEW &h04002401
#define DIBUTTON_FLYINGC_DISPLAY &h04002402
#define DIBUTTON_FLYINGC_GEAR &h04002C03
#define DIBUTTON_FLYINGC_MENU &h040004FD
#define DIHATSWITCH_FLYINGC_GLANCE &h04004601
#define DIAXIS_FLYINGC_BRAKE &h04046A04
#define DIAXIS_FLYINGC_RUDDER &h04025205
#define DIAXIS_FLYINGC_FLAPS &h04055A06
#define DIBUTTON_FLYINGC_FLAPSUP &h04006404
#define DIBUTTON_FLYINGC_FLAPSDOWN &h04006405
#define DIBUTTON_FLYINGC_BRAKE_LINK &h04046CE0
#define DIBUTTON_FLYINGC_FASTER_LINK &h0403D4E0
#define DIBUTTON_FLYINGC_SLOWER_LINK &h0403D4E8
#define DIBUTTON_FLYINGC_GLANCE_LEFT_LINK &h0407C4E4
#define DIBUTTON_FLYINGC_GLANCE_RIGHT_LINK &h0407C4EC
#define DIBUTTON_FLYINGC_GLANCE_UP_LINK &h0407C4E0
#define DIBUTTON_FLYINGC_GLANCE_DOWN_LINK &h0407C4E8
#define DIBUTTON_FLYINGC_DEVICE &h040044FE
#define DIBUTTON_FLYINGC_PAUSE &h040044FC
#define DIVIRTUAL_FLYING_MILITARY &h05000000
#define DIAXIS_FLYINGM_BANK &h05008A01
#define DIAXIS_FLYINGM_PITCH &h05010A02
#define DIAXIS_FLYINGM_THROTTLE &h05039203
#define DIBUTTON_FLYINGM_FIRE &h05000C01
#define DIBUTTON_FLYINGM_WEAPONS &h05000C02
#define DIBUTTON_FLYINGM_TARGET &h05000C03
#define DIBUTTON_FLYINGM_MENU &h050004FD
#define DIHATSWITCH_FLYINGM_GLANCE &h05004601
#define DIBUTTON_FLYINGM_COUNTER &h05005C04
#define DIAXIS_FLYINGM_RUDDER &h05024A04
#define DIAXIS_FLYINGM_BRAKE &h05046205
#define DIBUTTON_FLYINGM_VIEW &h05006405
#define DIBUTTON_FLYINGM_DISPLAY &h05006406
#define DIAXIS_FLYINGM_FLAPS &h05055206
#define DIBUTTON_FLYINGM_FLAPSUP &h05005407
#define DIBUTTON_FLYINGM_FLAPSDOWN &h05005408
#define DIBUTTON_FLYINGM_FIRESECONDARY &h05004C09
#define DIBUTTON_FLYINGM_GEAR &h0500640A
#define DIBUTTON_FLYINGM_BRAKE_LINK &h050464E0
#define DIBUTTON_FLYINGM_FASTER_LINK &h0503D4E0
#define DIBUTTON_FLYINGM_SLOWER_LINK &h0503D4E8
#define DIBUTTON_FLYINGM_GLANCE_LEFT_LINK &h0507C4E4
#define DIBUTTON_FLYINGM_GLANCE_RIGHT_LINK &h0507C4EC
#define DIBUTTON_FLYINGM_GLANCE_UP_LINK &h0507C4E0
#define DIBUTTON_FLYINGM_GLANCE_DOWN_LINK &h0507C4E8
#define DIBUTTON_FLYINGM_DEVICE &h050044FE
#define DIBUTTON_FLYINGM_PAUSE &h050044FC
#define DIVIRTUAL_FLYING_HELICOPTER &h06000000
#define DIAXIS_FLYINGH_BANK &h06008A01
#define DIAXIS_FLYINGH_PITCH &h06010A02
#define DIAXIS_FLYINGH_COLLECTIVE &h06018A03
#define DIBUTTON_FLYINGH_FIRE &h06001401
#define DIBUTTON_FLYINGH_WEAPONS &h06001402
#define DIBUTTON_FLYINGH_TARGET &h06001403
#define DIBUTTON_FLYINGH_MENU &h060004FD
#define DIHATSWITCH_FLYINGH_GLANCE &h06004601
#define DIAXIS_FLYINGH_TORQUE &h06025A04
#define DIAXIS_FLYINGH_THROTTLE &h0603DA05
#define DIBUTTON_FLYINGH_COUNTER &h06005404
#define DIBUTTON_FLYINGH_VIEW &h06006405
#define DIBUTTON_FLYINGH_GEAR &h06006406
#define DIBUTTON_FLYINGH_FIRESECONDARY &h06004C07
#define DIBUTTON_FLYINGH_FASTER_LINK &h0603DCE0
#define DIBUTTON_FLYINGH_SLOWER_LINK &h0603DCE8
#define DIBUTTON_FLYINGH_GLANCE_LEFT_LINK &h0607C4E4
#define DIBUTTON_FLYINGH_GLANCE_RIGHT_LINK &h0607C4EC
#define DIBUTTON_FLYINGH_GLANCE_UP_LINK &h0607C4E0
#define DIBUTTON_FLYINGH_GLANCE_DOWN_LINK &h0607C4E8
#define DIBUTTON_FLYINGH_DEVICE &h060044FE
#define DIBUTTON_FLYINGH_PAUSE &h060044FC
#define DIVIRTUAL_SPACESIM &h07000000
#define DIAXIS_SPACESIM_LATERAL &h07008201
#define DIAXIS_SPACESIM_MOVE &h07010202
#define DIAXIS_SPACESIM_THROTTLE &h07038203
#define DIBUTTON_SPACESIM_FIRE &h07000401
#define DIBUTTON_SPACESIM_WEAPONS &h07000402
#define DIBUTTON_SPACESIM_TARGET &h07000403
#define DIBUTTON_SPACESIM_MENU &h070004FD
#define DIHATSWITCH_SPACESIM_GLANCE &h07004601
#define DIAXIS_SPACESIM_CLIMB &h0701C204
#define DIAXIS_SPACESIM_ROTATE &h07024205
#define DIBUTTON_SPACESIM_VIEW &h07004404
#define DIBUTTON_SPACESIM_DISPLAY &h07004405
#define DIBUTTON_SPACESIM_RAISE &h07004406
#define DIBUTTON_SPACESIM_LOWER &h07004407
#define DIBUTTON_SPACESIM_GEAR &h07004408
#define DIBUTTON_SPACESIM_FIRESECONDARY &h07004409
#define DIBUTTON_SPACESIM_LEFT_LINK &h0700C4E4
#define DIBUTTON_SPACESIM_RIGHT_LINK &h0700C4EC
#define DIBUTTON_SPACESIM_FORWARD_LINK &h070144E0
#define DIBUTTON_SPACESIM_BACKWARD_LINK &h070144E8
#define DIBUTTON_SPACESIM_FASTER_LINK &h0703C4E0
#define DIBUTTON_SPACESIM_SLOWER_LINK &h0703C4E8
#define DIBUTTON_SPACESIM_TURN_LEFT_LINK &h070244E4
#define DIBUTTON_SPACESIM_TURN_RIGHT_LINK &h070244EC
#define DIBUTTON_SPACESIM_GLANCE_LEFT_LINK &h0707C4E4
#define DIBUTTON_SPACESIM_GLANCE_RIGHT_LINK &h0707C4EC
#define DIBUTTON_SPACESIM_GLANCE_UP_LINK &h0707C4E0
#define DIBUTTON_SPACESIM_GLANCE_DOWN_LINK &h0707C4E8
#define DIBUTTON_SPACESIM_DEVICE &h070044FE
#define DIBUTTON_SPACESIM_PAUSE &h070044FC
#define DIVIRTUAL_FIGHTING_HAND2HAND &h08000000
#define DIAXIS_FIGHTINGH_LATERAL &h08008201
#define DIAXIS_FIGHTINGH_MOVE &h08010202
#define DIBUTTON_FIGHTINGH_PUNCH &h08000401
#define DIBUTTON_FIGHTINGH_KICK &h08000402
#define DIBUTTON_FIGHTINGH_BLOCK &h08000403
#define DIBUTTON_FIGHTINGH_CROUCH &h08000404
#define DIBUTTON_FIGHTINGH_JUMP &h08000405
#define DIBUTTON_FIGHTINGH_SPECIAL1 &h08000406
#define DIBUTTON_FIGHTINGH_SPECIAL2 &h08000407
#define DIBUTTON_FIGHTINGH_MENU &h080004FD
#define DIBUTTON_FIGHTINGH_SELECT &h08004408
#define DIHATSWITCH_FIGHTINGH_SLIDE &h08004601
#define DIBUTTON_FIGHTINGH_DISPLAY &h08004409
#define DIAXIS_FIGHTINGH_ROTATE &h08024203
#define DIBUTTON_FIGHTINGH_DODGE &h0800440A
#define DIBUTTON_FIGHTINGH_LEFT_LINK &h0800C4E4
#define DIBUTTON_FIGHTINGH_RIGHT_LINK &h0800C4EC
#define DIBUTTON_FIGHTINGH_FORWARD_LINK &h080144E0
#define DIBUTTON_FIGHTINGH_BACKWARD_LINK &h080144E8
#define DIBUTTON_FIGHTINGH_DEVICE &h080044FE
#define DIBUTTON_FIGHTINGH_PAUSE &h080044FC
#define DIVIRTUAL_FIGHTING_FPS &h09000000
#define DIAXIS_FPS_ROTATE &h09008201
#define DIAXIS_FPS_MOVE &h09010202
#define DIBUTTON_FPS_FIRE &h09000401
#define DIBUTTON_FPS_WEAPONS &h09000402
#define DIBUTTON_FPS_APPLY &h09000403
#define DIBUTTON_FPS_SELECT &h09000404
#define DIBUTTON_FPS_CROUCH &h09000405
#define DIBUTTON_FPS_JUMP &h09000406
#define DIAXIS_FPS_LOOKUPDOWN &h09018203
#define DIBUTTON_FPS_STRAFE &h09000407
#define DIBUTTON_FPS_MENU &h090004FD
#define DIHATSWITCH_FPS_GLANCE &h09004601
#define DIBUTTON_FPS_DISPLAY &h09004408
#define DIAXIS_FPS_SIDESTEP &h09024204
#define DIBUTTON_FPS_DODGE &h09004409
#define DIBUTTON_FPS_GLANCEL &h0900440A
#define DIBUTTON_FPS_GLANCER &h0900440B
#define DIBUTTON_FPS_FIRESECONDARY &h0900440C
#define DIBUTTON_FPS_ROTATE_LEFT_LINK &h0900C4E4
#define DIBUTTON_FPS_ROTATE_RIGHT_LINK &h0900C4EC
#define DIBUTTON_FPS_FORWARD_LINK &h090144E0
#define DIBUTTON_FPS_BACKWARD_LINK &h090144E8
#define DIBUTTON_FPS_GLANCE_UP_LINK &h0901C4E0
#define DIBUTTON_FPS_GLANCE_DOWN_LINK &h0901C4E8
#define DIBUTTON_FPS_STEP_LEFT_LINK &h090244E4
#define DIBUTTON_FPS_STEP_RIGHT_LINK &h090244EC
#define DIBUTTON_FPS_DEVICE &h090044FE
#define DIBUTTON_FPS_PAUSE &h090044FC
#define DIVIRTUAL_FIGHTING_THIRDPERSON &h0A000000
#define DIAXIS_TPS_TURN &h0A020201
#define DIAXIS_TPS_MOVE &h0A010202
#define DIBUTTON_TPS_RUN &h0A000401
#define DIBUTTON_TPS_ACTION &h0A000402
#define DIBUTTON_TPS_SELECT &h0A000403
#define DIBUTTON_TPS_USE &h0A000404
#define DIBUTTON_TPS_JUMP &h0A000405
#define DIBUTTON_TPS_MENU &h0A0004FD
#define DIHATSWITCH_TPS_GLANCE &h0A004601
#define DIBUTTON_TPS_VIEW &h0A004406
#define DIBUTTON_TPS_STEPLEFT &h0A004407
#define DIBUTTON_TPS_STEPRIGHT &h0A004408
#define DIAXIS_TPS_STEP &h0A00C203
#define DIBUTTON_TPS_DODGE &h0A004409
#define DIBUTTON_TPS_INVENTORY &h0A00440A
#define DIBUTTON_TPS_TURN_LEFT_LINK &h0A0244E4
#define DIBUTTON_TPS_TURN_RIGHT_LINK &h0A0244EC
#define DIBUTTON_TPS_FORWARD_LINK &h0A0144E0
#define DIBUTTON_TPS_BACKWARD_LINK &h0A0144E8
#define DIBUTTON_TPS_GLANCE_UP_LINK &h0A07C4E0
#define DIBUTTON_TPS_GLANCE_DOWN_LINK &h0A07C4E8
#define DIBUTTON_TPS_GLANCE_LEFT_LINK &h0A07C4E4
#define DIBUTTON_TPS_GLANCE_RIGHT_LINK &h0A07C4EC
#define DIBUTTON_TPS_DEVICE &h0A0044FE
#define DIBUTTON_TPS_PAUSE &h0A0044FC
#define DIVIRTUAL_STRATEGY_ROLEPLAYING &h0B000000
#define DIAXIS_STRATEGYR_LATERAL &h0B008201
#define DIAXIS_STRATEGYR_MOVE &h0B010202
#define DIBUTTON_STRATEGYR_GET &h0B000401
#define DIBUTTON_STRATEGYR_APPLY &h0B000402
#define DIBUTTON_STRATEGYR_SELECT &h0B000403
#define DIBUTTON_STRATEGYR_ATTACK &h0B000404
#define DIBUTTON_STRATEGYR_CAST &h0B000405
#define DIBUTTON_STRATEGYR_CROUCH &h0B000406
#define DIBUTTON_STRATEGYR_JUMP &h0B000407
#define DIBUTTON_STRATEGYR_MENU &h0B0004FD
#define DIHATSWITCH_STRATEGYR_GLANCE &h0B004601
#define DIBUTTON_STRATEGYR_MAP &h0B004408
#define DIBUTTON_STRATEGYR_DISPLAY &h0B004409
#define DIAXIS_STRATEGYR_ROTATE &h0B024203
#define DIBUTTON_STRATEGYR_LEFT_LINK &h0B00C4E4
#define DIBUTTON_STRATEGYR_RIGHT_LINK &h0B00C4EC
#define DIBUTTON_STRATEGYR_FORWARD_LINK &h0B0144E0
#define DIBUTTON_STRATEGYR_BACK_LINK &h0B0144E8
#define DIBUTTON_STRATEGYR_ROTATE_LEFT_LINK &h0B0244E4
#define DIBUTTON_STRATEGYR_ROTATE_RIGHT_LINK &h0B0244EC
#define DIBUTTON_STRATEGYR_DEVICE &h0B0044FE
#define DIBUTTON_STRATEGYR_PAUSE &h0B0044FC
#define DIVIRTUAL_STRATEGY_TURN &h0C000000
#define DIAXIS_STRATEGYT_LATERAL &h0C008201
#define DIAXIS_STRATEGYT_MOVE &h0C010202
#define DIBUTTON_STRATEGYT_SELECT &h0C000401
#define DIBUTTON_STRATEGYT_INSTRUCT &h0C000402
#define DIBUTTON_STRATEGYT_APPLY &h0C000403
#define DIBUTTON_STRATEGYT_TEAM &h0C000404
#define DIBUTTON_STRATEGYT_TURN &h0C000405
#define DIBUTTON_STRATEGYT_MENU &h0C0004FD
#define DIBUTTON_STRATEGYT_ZOOM &h0C004406
#define DIBUTTON_STRATEGYT_MAP &h0C004407
#define DIBUTTON_STRATEGYT_DISPLAY &h0C004408
#define DIBUTTON_STRATEGYT_LEFT_LINK &h0C00C4E4
#define DIBUTTON_STRATEGYT_RIGHT_LINK &h0C00C4EC
#define DIBUTTON_STRATEGYT_FORWARD_LINK &h0C0144E0
#define DIBUTTON_STRATEGYT_BACK_LINK &h0C0144E8
#define DIBUTTON_STRATEGYT_DEVICE &h0C0044FE
#define DIBUTTON_STRATEGYT_PAUSE &h0C0044FC
#define DIVIRTUAL_SPORTS_HUNTING &h0D000000
#define DIAXIS_HUNTING_LATERAL &h0D008201
#define DIAXIS_HUNTING_MOVE &h0D010202
#define DIBUTTON_HUNTING_FIRE &h0D000401
#define DIBUTTON_HUNTING_AIM &h0D000402
#define DIBUTTON_HUNTING_WEAPON &h0D000403
#define DIBUTTON_HUNTING_BINOCULAR &h0D000404
#define DIBUTTON_HUNTING_CALL &h0D000405
#define DIBUTTON_HUNTING_MAP &h0D000406
#define DIBUTTON_HUNTING_SPECIAL &h0D000407
#define DIBUTTON_HUNTING_MENU &h0D0004FD
#define DIHATSWITCH_HUNTING_GLANCE &h0D004601
#define DIBUTTON_HUNTING_DISPLAY &h0D004408
#define DIAXIS_HUNTING_ROTATE &h0D024203
#define DIBUTTON_HUNTING_CROUCH &h0D004409
#define DIBUTTON_HUNTING_JUMP &h0D00440A
#define DIBUTTON_HUNTING_FIRESECONDARY &h0D00440B
#define DIBUTTON_HUNTING_LEFT_LINK &h0D00C4E4
#define DIBUTTON_HUNTING_RIGHT_LINK &h0D00C4EC
#define DIBUTTON_HUNTING_FORWARD_LINK &h0D0144E0
#define DIBUTTON_HUNTING_BACK_LINK &h0D0144E8
#define DIBUTTON_HUNTING_ROTATE_LEFT_LINK &h0D0244E4
#define DIBUTTON_HUNTING_ROTATE_RIGHT_LINK &h0D0244EC
#define DIBUTTON_HUNTING_DEVICE &h0D0044FE
#define DIBUTTON_HUNTING_PAUSE &h0D0044FC
#define DIVIRTUAL_SPORTS_FISHING &h0E000000
#define DIAXIS_FISHING_LATERAL &h0E008201
#define DIAXIS_FISHING_MOVE &h0E010202
#define DIBUTTON_FISHING_CAST &h0E000401
#define DIBUTTON_FISHING_TYPE &h0E000402
#define DIBUTTON_FISHING_BINOCULAR &h0E000403
#define DIBUTTON_FISHING_BAIT &h0E000404
#define DIBUTTON_FISHING_MAP &h0E000405
#define DIBUTTON_FISHING_MENU &h0E0004FD
#define DIHATSWITCH_FISHING_GLANCE &h0E004601
#define DIBUTTON_FISHING_DISPLAY &h0E004406
#define DIAXIS_FISHING_ROTATE &h0E024203
#define DIBUTTON_FISHING_CROUCH &h0E004407
#define DIBUTTON_FISHING_JUMP &h0E004408
#define DIBUTTON_FISHING_LEFT_LINK &h0E00C4E4
#define DIBUTTON_FISHING_RIGHT_LINK &h0E00C4EC
#define DIBUTTON_FISHING_FORWARD_LINK &h0E0144E0
#define DIBUTTON_FISHING_BACK_LINK &h0E0144E8
#define DIBUTTON_FISHING_ROTATE_LEFT_LINK &h0E0244E4
#define DIBUTTON_FISHING_ROTATE_RIGHT_LINK &h0E0244EC
#define DIBUTTON_FISHING_DEVICE &h0E0044FE
#define DIBUTTON_FISHING_PAUSE &h0E0044FC
#define DIVIRTUAL_SPORTS_BASEBALL_BAT &h0F000000
#define DIAXIS_BASEBALLB_LATERAL &h0F008201
#define DIAXIS_BASEBALLB_MOVE &h0F010202
#define DIBUTTON_BASEBALLB_SELECT &h0F000401
#define DIBUTTON_BASEBALLB_NORMAL &h0F000402
#define DIBUTTON_BASEBALLB_POWER &h0F000403
#define DIBUTTON_BASEBALLB_BUNT &h0F000404
#define DIBUTTON_BASEBALLB_STEAL &h0F000405
#define DIBUTTON_BASEBALLB_BURST &h0F000406
#define DIBUTTON_BASEBALLB_SLIDE &h0F000407
#define DIBUTTON_BASEBALLB_CONTACT &h0F000408
#define DIBUTTON_BASEBALLB_MENU &h0F0004FD
#define DIBUTTON_BASEBALLB_NOSTEAL &h0F004409
#define DIBUTTON_BASEBALLB_BOX &h0F00440A
#define DIBUTTON_BASEBALLB_LEFT_LINK &h0F00C4E4
#define DIBUTTON_BASEBALLB_RIGHT_LINK &h0F00C4EC
#define DIBUTTON_BASEBALLB_FORWARD_LINK &h0F0144E0
#define DIBUTTON_BASEBALLB_BACK_LINK &h0F0144E8
#define DIBUTTON_BASEBALLB_DEVICE &h0F0044FE
#define DIBUTTON_BASEBALLB_PAUSE &h0F0044FC
#define DIVIRTUAL_SPORTS_BASEBALL_PITCH &h10000000
#define DIAXIS_BASEBALLP_LATERAL &h10008201
#define DIAXIS_BASEBALLP_MOVE &h10010202
#define DIBUTTON_BASEBALLP_SELECT &h10000401
#define DIBUTTON_BASEBALLP_PITCH &h10000402
#define DIBUTTON_BASEBALLP_BASE &h10000403
#define DIBUTTON_BASEBALLP_THROW &h10000404
#define DIBUTTON_BASEBALLP_FAKE &h10000405
#define DIBUTTON_BASEBALLP_MENU &h100004FD
#define DIBUTTON_BASEBALLP_WALK &h10004406
#define DIBUTTON_BASEBALLP_LOOK &h10004407
#define DIBUTTON_BASEBALLP_LEFT_LINK &h1000C4E4
#define DIBUTTON_BASEBALLP_RIGHT_LINK &h1000C4EC
#define DIBUTTON_BASEBALLP_FORWARD_LINK &h100144E0
#define DIBUTTON_BASEBALLP_BACK_LINK &h100144E8
#define DIBUTTON_BASEBALLP_DEVICE &h100044FE
#define DIBUTTON_BASEBALLP_PAUSE &h100044FC
#define DIVIRTUAL_SPORTS_BASEBALL_FIELD &h11000000
#define DIAXIS_BASEBALLF_LATERAL &h11008201
#define DIAXIS_BASEBALLF_MOVE &h11010202
#define DIBUTTON_BASEBALLF_NEAREST &h11000401
#define DIBUTTON_BASEBALLF_THROW1 &h11000402
#define DIBUTTON_BASEBALLF_THROW2 &h11000403
#define DIBUTTON_BASEBALLF_BURST &h11000404
#define DIBUTTON_BASEBALLF_JUMP &h11000405
#define DIBUTTON_BASEBALLF_DIVE &h11000406
#define DIBUTTON_BASEBALLF_MENU &h110004FD
#define DIBUTTON_BASEBALLF_SHIFTIN &h11004407
#define DIBUTTON_BASEBALLF_SHIFTOUT &h11004408
#define DIBUTTON_BASEBALLF_AIM_LEFT_LINK &h1100C4E4
#define DIBUTTON_BASEBALLF_AIM_RIGHT_LINK &h1100C4EC
#define DIBUTTON_BASEBALLF_FORWARD_LINK &h110144E0
#define DIBUTTON_BASEBALLF_BACK_LINK &h110144E8
#define DIBUTTON_BASEBALLF_DEVICE &h110044FE
#define DIBUTTON_BASEBALLF_PAUSE &h110044FC
#define DIVIRTUAL_SPORTS_BASKETBALL_OFFENSE &h12000000
#define DIAXIS_BBALLO_LATERAL &h12008201
#define DIAXIS_BBALLO_MOVE &h12010202
#define DIBUTTON_BBALLO_SHOOT &h12000401
#define DIBUTTON_BBALLO_DUNK &h12000402
#define DIBUTTON_BBALLO_PASS &h12000403
#define DIBUTTON_BBALLO_FAKE &h12000404
#define DIBUTTON_BBALLO_SPECIAL &h12000405
#define DIBUTTON_BBALLO_PLAYER &h12000406
#define DIBUTTON_BBALLO_BURST &h12000407
#define DIBUTTON_BBALLO_CALL &h12000408
#define DIBUTTON_BBALLO_MENU &h120004FD
#define DIHATSWITCH_BBALLO_GLANCE &h12004601
#define DIBUTTON_BBALLO_SCREEN &h12004409
#define DIBUTTON_BBALLO_PLAY &h1200440A
#define DIBUTTON_BBALLO_JAB &h1200440B
#define DIBUTTON_BBALLO_POST &h1200440C
#define DIBUTTON_BBALLO_TIMEOUT &h1200440D
#define DIBUTTON_BBALLO_SUBSTITUTE &h1200440E
#define DIBUTTON_BBALLO_LEFT_LINK &h1200C4E4
#define DIBUTTON_BBALLO_RIGHT_LINK &h1200C4EC
#define DIBUTTON_BBALLO_FORWARD_LINK &h120144E0
#define DIBUTTON_BBALLO_BACK_LINK &h120144E8
#define DIBUTTON_BBALLO_DEVICE &h120044FE
#define DIBUTTON_BBALLO_PAUSE &h120044FC
#define DIVIRTUAL_SPORTS_BASKETBALL_DEFENSE &h13000000
#define DIAXIS_BBALLD_LATERAL &h13008201
#define DIAXIS_BBALLD_MOVE &h13010202
#define DIBUTTON_BBALLD_JUMP &h13000401
#define DIBUTTON_BBALLD_STEAL &h13000402
#define DIBUTTON_BBALLD_FAKE &h13000403
#define DIBUTTON_BBALLD_SPECIAL &h13000404
#define DIBUTTON_BBALLD_PLAYER &h13000405
#define DIBUTTON_BBALLD_BURST &h13000406
#define DIBUTTON_BBALLD_PLAY &h13000407
#define DIBUTTON_BBALLD_MENU &h130004FD
#define DIHATSWITCH_BBALLD_GLANCE &h13004601
#define DIBUTTON_BBALLD_TIMEOUT &h13004408
#define DIBUTTON_BBALLD_SUBSTITUTE &h13004409
#define DIBUTTON_BBALLD_LEFT_LINK &h1300C4E4
#define DIBUTTON_BBALLD_RIGHT_LINK &h1300C4EC
#define DIBUTTON_BBALLD_FORWARD_LINK &h130144E0
#define DIBUTTON_BBALLD_BACK_LINK &h130144E8
#define DIBUTTON_BBALLD_DEVICE &h130044FE
#define DIBUTTON_BBALLD_PAUSE &h130044FC
#define DIVIRTUAL_SPORTS_FOOTBALL_FIELD &h14000000
#define DIBUTTON_FOOTBALLP_PLAY &h14000401
#define DIBUTTON_FOOTBALLP_SELECT &h14000402
#define DIBUTTON_FOOTBALLP_HELP &h14000403
#define DIBUTTON_FOOTBALLP_MENU &h140004FD
#define DIBUTTON_FOOTBALLP_DEVICE &h140044FE
#define DIBUTTON_FOOTBALLP_PAUSE &h140044FC
#define DIVIRTUAL_SPORTS_FOOTBALL_QBCK &h15000000
#define DIAXIS_FOOTBALLQ_LATERAL &h15008201
#define DIAXIS_FOOTBALLQ_MOVE &h15010202
#define DIBUTTON_FOOTBALLQ_SELECT &h15000401
#define DIBUTTON_FOOTBALLQ_SNAP &h15000402
#define DIBUTTON_FOOTBALLQ_JUMP &h15000403
#define DIBUTTON_FOOTBALLQ_SLIDE &h15000404
#define DIBUTTON_FOOTBALLQ_PASS &h15000405
#define DIBUTTON_FOOTBALLQ_FAKE &h15000406
#define DIBUTTON_FOOTBALLQ_MENU &h150004FD
#define DIBUTTON_FOOTBALLQ_FAKESNAP &h15004407
#define DIBUTTON_FOOTBALLQ_MOTION &h15004408
#define DIBUTTON_FOOTBALLQ_AUDIBLE &h15004409
#define DIBUTTON_FOOTBALLQ_LEFT_LINK &h1500C4E4
#define DIBUTTON_FOOTBALLQ_RIGHT_LINK &h1500C4EC
#define DIBUTTON_FOOTBALLQ_FORWARD_LINK &h150144E0
#define DIBUTTON_FOOTBALLQ_BACK_LINK &h150144E8
#define DIBUTTON_FOOTBALLQ_DEVICE &h150044FE
#define DIBUTTON_FOOTBALLQ_PAUSE &h150044FC
#define DIVIRTUAL_SPORTS_FOOTBALL_OFFENSE &h16000000
#define DIAXIS_FOOTBALLO_LATERAL &h16008201
#define DIAXIS_FOOTBALLO_MOVE &h16010202
#define DIBUTTON_FOOTBALLO_JUMP &h16000401
#define DIBUTTON_FOOTBALLO_LEFTARM &h16000402
#define DIBUTTON_FOOTBALLO_RIGHTARM &h16000403
#define DIBUTTON_FOOTBALLO_THROW &h16000404
#define DIBUTTON_FOOTBALLO_SPIN &h16000405
#define DIBUTTON_FOOTBALLO_MENU &h160004FD
#define DIBUTTON_FOOTBALLO_JUKE &h16004406
#define DIBUTTON_FOOTBALLO_SHOULDER &h16004407
#define DIBUTTON_FOOTBALLO_TURBO &h16004408
#define DIBUTTON_FOOTBALLO_DIVE &h16004409
#define DIBUTTON_FOOTBALLO_ZOOM &h1600440A
#define DIBUTTON_FOOTBALLO_SUBSTITUTE &h1600440B
#define DIBUTTON_FOOTBALLO_LEFT_LINK &h1600C4E4
#define DIBUTTON_FOOTBALLO_RIGHT_LINK &h1600C4EC
#define DIBUTTON_FOOTBALLO_FORWARD_LINK &h160144E0
#define DIBUTTON_FOOTBALLO_BACK_LINK &h160144E8
#define DIBUTTON_FOOTBALLO_DEVICE &h160044FE
#define DIBUTTON_FOOTBALLO_PAUSE &h160044FC
#define DIVIRTUAL_SPORTS_FOOTBALL_DEFENSE &h17000000
#define DIAXIS_FOOTBALLD_LATERAL &h17008201
#define DIAXIS_FOOTBALLD_MOVE &h17010202
#define DIBUTTON_FOOTBALLD_PLAY &h17000401
#define DIBUTTON_FOOTBALLD_SELECT &h17000402
#define DIBUTTON_FOOTBALLD_JUMP &h17000403
#define DIBUTTON_FOOTBALLD_TACKLE &h17000404
#define DIBUTTON_FOOTBALLD_FAKE &h17000405
#define DIBUTTON_FOOTBALLD_SUPERTACKLE &h17000406
#define DIBUTTON_FOOTBALLD_MENU &h170004FD
#define DIBUTTON_FOOTBALLD_SPIN &h17004407
#define DIBUTTON_FOOTBALLD_SWIM &h17004408
#define DIBUTTON_FOOTBALLD_BULLRUSH &h17004409
#define DIBUTTON_FOOTBALLD_RIP &h1700440A
#define DIBUTTON_FOOTBALLD_AUDIBLE &h1700440B
#define DIBUTTON_FOOTBALLD_ZOOM &h1700440C
#define DIBUTTON_FOOTBALLD_SUBSTITUTE &h1700440D
#define DIBUTTON_FOOTBALLD_LEFT_LINK &h1700C4E4
#define DIBUTTON_FOOTBALLD_RIGHT_LINK &h1700C4EC
#define DIBUTTON_FOOTBALLD_FORWARD_LINK &h170144E0
#define DIBUTTON_FOOTBALLD_BACK_LINK &h170144E8
#define DIBUTTON_FOOTBALLD_DEVICE &h170044FE
#define DIBUTTON_FOOTBALLD_PAUSE &h170044FC
#define DIVIRTUAL_SPORTS_GOLF &h18000000
#define DIAXIS_GOLF_LATERAL &h18008201
#define DIAXIS_GOLF_MOVE &h18010202
#define DIBUTTON_GOLF_SWING &h18000401
#define DIBUTTON_GOLF_SELECT &h18000402
#define DIBUTTON_GOLF_UP &h18000403
#define DIBUTTON_GOLF_DOWN &h18000404
#define DIBUTTON_GOLF_TERRAIN &h18000405
#define DIBUTTON_GOLF_FLYBY &h18000406
#define DIBUTTON_GOLF_MENU &h180004FD
#define DIHATSWITCH_GOLF_SCROLL &h18004601
#define DIBUTTON_GOLF_ZOOM &h18004407
#define DIBUTTON_GOLF_TIMEOUT &h18004408
#define DIBUTTON_GOLF_SUBSTITUTE &h18004409
#define DIBUTTON_GOLF_LEFT_LINK &h1800C4E4
#define DIBUTTON_GOLF_RIGHT_LINK &h1800C4EC
#define DIBUTTON_GOLF_FORWARD_LINK &h180144E0
#define DIBUTTON_GOLF_BACK_LINK &h180144E8
#define DIBUTTON_GOLF_DEVICE &h180044FE
#define DIBUTTON_GOLF_PAUSE &h180044FC
#define DIVIRTUAL_SPORTS_HOCKEY_OFFENSE &h19000000
#define DIAXIS_HOCKEYO_LATERAL &h19008201
#define DIAXIS_HOCKEYO_MOVE &h19010202
#define DIBUTTON_HOCKEYO_SHOOT &h19000401
#define DIBUTTON_HOCKEYO_PASS &h19000402
#define DIBUTTON_HOCKEYO_BURST &h19000403
#define DIBUTTON_HOCKEYO_SPECIAL &h19000404
#define DIBUTTON_HOCKEYO_FAKE &h19000405
#define DIBUTTON_HOCKEYO_MENU &h190004FD
#define DIHATSWITCH_HOCKEYO_SCROLL &h19004601
#define DIBUTTON_HOCKEYO_ZOOM &h19004406
#define DIBUTTON_HOCKEYO_STRATEGY &h19004407
#define DIBUTTON_HOCKEYO_TIMEOUT &h19004408
#define DIBUTTON_HOCKEYO_SUBSTITUTE &h19004409
#define DIBUTTON_HOCKEYO_LEFT_LINK &h1900C4E4
#define DIBUTTON_HOCKEYO_RIGHT_LINK &h1900C4EC
#define DIBUTTON_HOCKEYO_FORWARD_LINK &h190144E0
#define DIBUTTON_HOCKEYO_BACK_LINK &h190144E8
#define DIBUTTON_HOCKEYO_DEVICE &h190044FE
#define DIBUTTON_HOCKEYO_PAUSE &h190044FC
#define DIVIRTUAL_SPORTS_HOCKEY_DEFENSE &h1A000000
#define DIAXIS_HOCKEYD_LATERAL &h1A008201
#define DIAXIS_HOCKEYD_MOVE &h1A010202
#define DIBUTTON_HOCKEYD_PLAYER &h1A000401
#define DIBUTTON_HOCKEYD_STEAL &h1A000402
#define DIBUTTON_HOCKEYD_BURST &h1A000403
#define DIBUTTON_HOCKEYD_BLOCK &h1A000404
#define DIBUTTON_HOCKEYD_FAKE &h1A000405
#define DIBUTTON_HOCKEYD_MENU &h1A0004FD
#define DIHATSWITCH_HOCKEYD_SCROLL &h1A004601
#define DIBUTTON_HOCKEYD_ZOOM &h1A004406
#define DIBUTTON_HOCKEYD_STRATEGY &h1A004407
#define DIBUTTON_HOCKEYD_TIMEOUT &h1A004408
#define DIBUTTON_HOCKEYD_SUBSTITUTE &h1A004409
#define DIBUTTON_HOCKEYD_LEFT_LINK &h1A00C4E4
#define DIBUTTON_HOCKEYD_RIGHT_LINK &h1A00C4EC
#define DIBUTTON_HOCKEYD_FORWARD_LINK &h1A0144E0
#define DIBUTTON_HOCKEYD_BACK_LINK &h1A0144E8
#define DIBUTTON_HOCKEYD_DEVICE &h1A0044FE
#define DIBUTTON_HOCKEYD_PAUSE &h1A0044FC
#define DIVIRTUAL_SPORTS_HOCKEY_GOALIE &h1B000000
#define DIAXIS_HOCKEYG_LATERAL &h1B008201
#define DIAXIS_HOCKEYG_MOVE &h1B010202
#define DIBUTTON_HOCKEYG_PASS &h1B000401
#define DIBUTTON_HOCKEYG_POKE &h1B000402
#define DIBUTTON_HOCKEYG_STEAL &h1B000403
#define DIBUTTON_HOCKEYG_BLOCK &h1B000404
#define DIBUTTON_HOCKEYG_MENU &h1B0004FD
#define DIHATSWITCH_HOCKEYG_SCROLL &h1B004601
#define DIBUTTON_HOCKEYG_ZOOM &h1B004405
#define DIBUTTON_HOCKEYG_STRATEGY &h1B004406
#define DIBUTTON_HOCKEYG_TIMEOUT &h1B004407
#define DIBUTTON_HOCKEYG_SUBSTITUTE &h1B004408
#define DIBUTTON_HOCKEYG_LEFT_LINK &h1B00C4E4
#define DIBUTTON_HOCKEYG_RIGHT_LINK &h1B00C4EC
#define DIBUTTON_HOCKEYG_FORWARD_LINK &h1B0144E0
#define DIBUTTON_HOCKEYG_BACK_LINK &h1B0144E8
#define DIBUTTON_HOCKEYG_DEVICE &h1B0044FE
#define DIBUTTON_HOCKEYG_PAUSE &h1B0044FC
#define DIVIRTUAL_SPORTS_BIKING_MOUNTAIN &h1C000000
#define DIAXIS_BIKINGM_TURN &h1C008201
#define DIAXIS_BIKINGM_PEDAL &h1C010202
#define DIBUTTON_BIKINGM_JUMP &h1C000401
#define DIBUTTON_BIKINGM_CAMERA &h1C000402
#define DIBUTTON_BIKINGM_SPECIAL1 &h1C000403
#define DIBUTTON_BIKINGM_SELECT &h1C000404
#define DIBUTTON_BIKINGM_SPECIAL2 &h1C000405
#define DIBUTTON_BIKINGM_MENU &h1C0004FD
#define DIHATSWITCH_BIKINGM_SCROLL &h1C004601
#define DIBUTTON_BIKINGM_ZOOM &h1C004406
#define DIAXIS_BIKINGM_BRAKE &h1C044203
#define DIBUTTON_BIKINGM_LEFT_LINK &h1C00C4E4
#define DIBUTTON_BIKINGM_RIGHT_LINK &h1C00C4EC
#define DIBUTTON_BIKINGM_FASTER_LINK &h1C0144E0
#define DIBUTTON_BIKINGM_SLOWER_LINK &h1C0144E8
#define DIBUTTON_BIKINGM_BRAKE_BUTTON_LINK &h1C0444E8
#define DIBUTTON_BIKINGM_DEVICE &h1C0044FE
#define DIBUTTON_BIKINGM_PAUSE &h1C0044FC
#define DIVIRTUAL_SPORTS_SKIING &h1D000000
#define DIAXIS_SKIING_TURN &h1D008201
#define DIAXIS_SKIING_SPEED &h1D010202
#define DIBUTTON_SKIING_JUMP &h1D000401
#define DIBUTTON_SKIING_CROUCH &h1D000402
#define DIBUTTON_SKIING_CAMERA &h1D000403
#define DIBUTTON_SKIING_SPECIAL1 &h1D000404
#define DIBUTTON_SKIING_SELECT &h1D000405
#define DIBUTTON_SKIING_SPECIAL2 &h1D000406
#define DIBUTTON_SKIING_MENU &h1D0004FD
#define DIHATSWITCH_SKIING_GLANCE &h1D004601
#define DIBUTTON_SKIING_ZOOM &h1D004407
#define DIBUTTON_SKIING_LEFT_LINK &h1D00C4E4
#define DIBUTTON_SKIING_RIGHT_LINK &h1D00C4EC
#define DIBUTTON_SKIING_FASTER_LINK &h1D0144E0
#define DIBUTTON_SKIING_SLOWER_LINK &h1D0144E8
#define DIBUTTON_SKIING_DEVICE &h1D0044FE
#define DIBUTTON_SKIING_PAUSE &h1D0044FC
#define DIVIRTUAL_SPORTS_SOCCER_OFFENSE &h1E000000
#define DIAXIS_SOCCERO_LATERAL &h1E008201
#define DIAXIS_SOCCERO_MOVE &h1E010202
#define DIAXIS_SOCCERO_BEND &h1E018203
#define DIBUTTON_SOCCERO_SHOOT &h1E000401
#define DIBUTTON_SOCCERO_PASS &h1E000402
#define DIBUTTON_SOCCERO_FAKE &h1E000403
#define DIBUTTON_SOCCERO_PLAYER &h1E000404
#define DIBUTTON_SOCCERO_SPECIAL1 &h1E000405
#define DIBUTTON_SOCCERO_SELECT &h1E000406
#define DIBUTTON_SOCCERO_MENU &h1E0004FD
#define DIHATSWITCH_SOCCERO_GLANCE &h1E004601
#define DIBUTTON_SOCCERO_SUBSTITUTE &h1E004407
#define DIBUTTON_SOCCERO_SHOOTLOW &h1E004408
#define DIBUTTON_SOCCERO_SHOOTHIGH &h1E004409
#define DIBUTTON_SOCCERO_PASSTHRU &h1E00440A
#define DIBUTTON_SOCCERO_SPRINT &h1E00440B
#define DIBUTTON_SOCCERO_CONTROL &h1E00440C
#define DIBUTTON_SOCCERO_HEAD &h1E00440D
#define DIBUTTON_SOCCERO_LEFT_LINK &h1E00C4E4
#define DIBUTTON_SOCCERO_RIGHT_LINK &h1E00C4EC
#define DIBUTTON_SOCCERO_FORWARD_LINK &h1E0144E0
#define DIBUTTON_SOCCERO_BACK_LINK &h1E0144E8
#define DIBUTTON_SOCCERO_DEVICE &h1E0044FE
#define DIBUTTON_SOCCERO_PAUSE &h1E0044FC
#define DIVIRTUAL_SPORTS_SOCCER_DEFENSE &h1F000000
#define DIAXIS_SOCCERD_LATERAL &h1F008201
#define DIAXIS_SOCCERD_MOVE &h1F010202
#define DIBUTTON_SOCCERD_BLOCK &h1F000401
#define DIBUTTON_SOCCERD_STEAL &h1F000402
#define DIBUTTON_SOCCERD_FAKE &h1F000403
#define DIBUTTON_SOCCERD_PLAYER &h1F000404
#define DIBUTTON_SOCCERD_SPECIAL &h1F000405
#define DIBUTTON_SOCCERD_SELECT &h1F000406
#define DIBUTTON_SOCCERD_SLIDE &h1F000407
#define DIBUTTON_SOCCERD_MENU &h1F0004FD
#define DIHATSWITCH_SOCCERD_GLANCE &h1F004601
#define DIBUTTON_SOCCERD_FOUL &h1F004408
#define DIBUTTON_SOCCERD_HEAD &h1F004409
#define DIBUTTON_SOCCERD_CLEAR &h1F00440A
#define DIBUTTON_SOCCERD_GOALIECHARGE &h1F00440B
#define DIBUTTON_SOCCERD_SUBSTITUTE &h1F00440C
#define DIBUTTON_SOCCERD_LEFT_LINK &h1F00C4E4
#define DIBUTTON_SOCCERD_RIGHT_LINK &h1F00C4EC
#define DIBUTTON_SOCCERD_FORWARD_LINK &h1F0144E0
#define DIBUTTON_SOCCERD_BACK_LINK &h1F0144E8
#define DIBUTTON_SOCCERD_DEVICE &h1F0044FE
#define DIBUTTON_SOCCERD_PAUSE &h1F0044FC
#define DIVIRTUAL_SPORTS_RACQUET &h20000000
#define DIAXIS_RACQUET_LATERAL &h20008201
#define DIAXIS_RACQUET_MOVE &h20010202
#define DIBUTTON_RACQUET_SWING &h20000401
#define DIBUTTON_RACQUET_BACKSWING &h20000402
#define DIBUTTON_RACQUET_SMASH &h20000403
#define DIBUTTON_RACQUET_SPECIAL &h20000404
#define DIBUTTON_RACQUET_SELECT &h20000405
#define DIBUTTON_RACQUET_MENU &h200004FD
#define DIHATSWITCH_RACQUET_GLANCE &h20004601
#define DIBUTTON_RACQUET_TIMEOUT &h20004406
#define DIBUTTON_RACQUET_SUBSTITUTE &h20004407
#define DIBUTTON_RACQUET_LEFT_LINK &h2000C4E4
#define DIBUTTON_RACQUET_RIGHT_LINK &h2000C4EC
#define DIBUTTON_RACQUET_FORWARD_LINK &h200144E0
#define DIBUTTON_RACQUET_BACK_LINK &h200144E8
#define DIBUTTON_RACQUET_DEVICE &h200044FE
#define DIBUTTON_RACQUET_PAUSE &h200044FC
#define DIVIRTUAL_ARCADE_SIDE2SIDE &h21000000
#define DIAXIS_ARCADES_LATERAL &h21008201
#define DIAXIS_ARCADES_MOVE &h21010202
#define DIBUTTON_ARCADES_THROW &h21000401
#define DIBUTTON_ARCADES_CARRY &h21000402
#define DIBUTTON_ARCADES_ATTACK &h21000403
#define DIBUTTON_ARCADES_SPECIAL &h21000404
#define DIBUTTON_ARCADES_SELECT &h21000405
#define DIBUTTON_ARCADES_MENU &h210004FD
#define DIHATSWITCH_ARCADES_VIEW &h21004601
#define DIBUTTON_ARCADES_LEFT_LINK &h2100C4E4
#define DIBUTTON_ARCADES_RIGHT_LINK &h2100C4EC
#define DIBUTTON_ARCADES_FORWARD_LINK &h210144E0
#define DIBUTTON_ARCADES_BACK_LINK &h210144E8
#define DIBUTTON_ARCADES_VIEW_UP_LINK &h2107C4E0
#define DIBUTTON_ARCADES_VIEW_DOWN_LINK &h2107C4E8
#define DIBUTTON_ARCADES_VIEW_LEFT_LINK &h2107C4E4
#define DIBUTTON_ARCADES_VIEW_RIGHT_LINK &h2107C4EC
#define DIBUTTON_ARCADES_DEVICE &h210044FE
#define DIBUTTON_ARCADES_PAUSE &h210044FC
#define DIVIRTUAL_ARCADE_PLATFORM &h22000000
#define DIAXIS_ARCADEP_LATERAL &h22008201
#define DIAXIS_ARCADEP_MOVE &h22010202
#define DIBUTTON_ARCADEP_JUMP &h22000401
#define DIBUTTON_ARCADEP_FIRE &h22000402
#define DIBUTTON_ARCADEP_CROUCH &h22000403
#define DIBUTTON_ARCADEP_SPECIAL &h22000404
#define DIBUTTON_ARCADEP_SELECT &h22000405
#define DIBUTTON_ARCADEP_MENU &h220004FD
#define DIHATSWITCH_ARCADEP_VIEW &h22004601
#define DIBUTTON_ARCADEP_FIRESECONDARY &h22004406
#define DIBUTTON_ARCADEP_LEFT_LINK &h2200C4E4
#define DIBUTTON_ARCADEP_RIGHT_LINK &h2200C4EC
#define DIBUTTON_ARCADEP_FORWARD_LINK &h220144E0
#define DIBUTTON_ARCADEP_BACK_LINK &h220144E8
#define DIBUTTON_ARCADEP_VIEW_UP_LINK &h2207C4E0
#define DIBUTTON_ARCADEP_VIEW_DOWN_LINK &h2207C4E8
#define DIBUTTON_ARCADEP_VIEW_LEFT_LINK &h2207C4E4
#define DIBUTTON_ARCADEP_VIEW_RIGHT_LINK &h2207C4EC
#define DIBUTTON_ARCADEP_DEVICE &h220044FE
#define DIBUTTON_ARCADEP_PAUSE &h220044FC
#define DIVIRTUAL_CAD_2DCONTROL &h23000000
#define DIAXIS_2DCONTROL_LATERAL &h23008201
#define DIAXIS_2DCONTROL_MOVE &h23010202
#define DIAXIS_2DCONTROL_INOUT &h23018203
#define DIBUTTON_2DCONTROL_SELECT &h23000401
#define DIBUTTON_2DCONTROL_SPECIAL1 &h23000402
#define DIBUTTON_2DCONTROL_SPECIAL &h23000403
#define DIBUTTON_2DCONTROL_SPECIAL2 &h23000404
#define DIBUTTON_2DCONTROL_MENU &h230004FD
#define DIHATSWITCH_2DCONTROL_HATSWITCH &h23004601
#define DIAXIS_2DCONTROL_ROTATEZ &h23024204
#define DIBUTTON_2DCONTROL_DISPLAY &h23004405
#define DIBUTTON_2DCONTROL_DEVICE &h230044FE
#define DIBUTTON_2DCONTROL_PAUSE &h230044FC
#define DIVIRTUAL_CAD_3DCONTROL &h24000000
#define DIAXIS_3DCONTROL_LATERAL &h24008201
#define DIAXIS_3DCONTROL_MOVE &h24010202
#define DIAXIS_3DCONTROL_INOUT &h24018203
#define DIBUTTON_3DCONTROL_SELECT &h24000401
#define DIBUTTON_3DCONTROL_SPECIAL1 &h24000402
#define DIBUTTON_3DCONTROL_SPECIAL &h24000403
#define DIBUTTON_3DCONTROL_SPECIAL2 &h24000404
#define DIBUTTON_3DCONTROL_MENU &h240004FD
#define DIHATSWITCH_3DCONTROL_HATSWITCH &h24004601
#define DIAXIS_3DCONTROL_ROTATEX &h24034204
#define DIAXIS_3DCONTROL_ROTATEY &h2402C205
#define DIAXIS_3DCONTROL_ROTATEZ &h24024206
#define DIBUTTON_3DCONTROL_DISPLAY &h24004405
#define DIBUTTON_3DCONTROL_DEVICE &h240044FE
#define DIBUTTON_3DCONTROL_PAUSE &h240044FC
#define DIVIRTUAL_CAD_FLYBY &h25000000
#define DIAXIS_CADF_LATERAL &h25008201
#define DIAXIS_CADF_MOVE &h25010202
#define DIAXIS_CADF_INOUT &h25018203
#define DIBUTTON_CADF_SELECT &h25000401
#define DIBUTTON_CADF_SPECIAL1 &h25000402
#define DIBUTTON_CADF_SPECIAL &h25000403
#define DIBUTTON_CADF_SPECIAL2 &h25000404
#define DIBUTTON_CADF_MENU &h250004FD
#define DIHATSWITCH_CADF_HATSWITCH &h25004601
#define DIAXIS_CADF_ROTATEX &h25034204
#define DIAXIS_CADF_ROTATEY &h2502C205
#define DIAXIS_CADF_ROTATEZ &h25024206
#define DIBUTTON_CADF_DISPLAY &h25004405
#define DIBUTTON_CADF_DEVICE &h250044FE
#define DIBUTTON_CADF_PAUSE &h250044FC
#define DIVIRTUAL_CAD_MODEL &h26000000
#define DIAXIS_CADM_LATERAL &h26008201
#define DIAXIS_CADM_MOVE &h26010202
#define DIAXIS_CADM_INOUT &h26018203
#define DIBUTTON_CADM_SELECT &h26000401
#define DIBUTTON_CADM_SPECIAL1 &h26000402
#define DIBUTTON_CADM_SPECIAL &h26000403
#define DIBUTTON_CADM_SPECIAL2 &h26000404
#define DIBUTTON_CADM_MENU &h260004FD
#define DIHATSWITCH_CADM_HATSWITCH &h26004601
#define DIAXIS_CADM_ROTATEX &h26034204
#define DIAXIS_CADM_ROTATEY &h2602C205
#define DIAXIS_CADM_ROTATEZ &h26024206
#define DIBUTTON_CADM_DISPLAY &h26004405
#define DIBUTTON_CADM_DEVICE &h260044FE
#define DIBUTTON_CADM_PAUSE &h260044FC
#define DIVIRTUAL_REMOTE_CONTROL &h27000000
#define DIAXIS_REMOTE_SLIDER &h27050201
#define DIBUTTON_REMOTE_MUTE &h27000401
#define DIBUTTON_REMOTE_SELECT &h27000402
#define DIBUTTON_REMOTE_PLAY &h27002403
#define DIBUTTON_REMOTE_CUE &h27002404
#define DIBUTTON_REMOTE_REVIEW &h27002405
#define DIBUTTON_REMOTE_CHANGE &h27002406
#define DIBUTTON_REMOTE_RECORD &h27002407
#define DIBUTTON_REMOTE_MENU &h270004FD
#define DIAXIS_REMOTE_SLIDER2 &h27054202
#define DIBUTTON_REMOTE_TV &h27005C08
#define DIBUTTON_REMOTE_CABLE &h27005C09
#define DIBUTTON_REMOTE_CD &h27005C0A
#define DIBUTTON_REMOTE_VCR &h27005C0B
#define DIBUTTON_REMOTE_TUNER &h27005C0C
#define DIBUTTON_REMOTE_DVD &h27005C0D
#define DIBUTTON_REMOTE_ADJUST &h27005C0E
#define DIBUTTON_REMOTE_DIGIT0 &h2700540F
#define DIBUTTON_REMOTE_DIGIT1 &h27005410
#define DIBUTTON_REMOTE_DIGIT2 &h27005411
#define DIBUTTON_REMOTE_DIGIT3 &h27005412
#define DIBUTTON_REMOTE_DIGIT4 &h27005413
#define DIBUTTON_REMOTE_DIGIT5 &h27005414
#define DIBUTTON_REMOTE_DIGIT6 &h27005415
#define DIBUTTON_REMOTE_DIGIT7 &h27005416
#define DIBUTTON_REMOTE_DIGIT8 &h27005417
#define DIBUTTON_REMOTE_DIGIT9 &h27005418
#define DIBUTTON_REMOTE_DEVICE &h270044FE
#define DIBUTTON_REMOTE_PAUSE &h270044FC
#define DIVIRTUAL_BROWSER_CONTROL &h28000000
#define DIAXIS_BROWSER_LATERAL &h28008201
#define DIAXIS_BROWSER_MOVE &h28010202
#define DIBUTTON_BROWSER_SELECT &h28000401
#define DIAXIS_BROWSER_VIEW &h28018203
#define DIBUTTON_BROWSER_REFRESH &h28000402
#define DIBUTTON_BROWSER_MENU &h280004FD
#define DIBUTTON_BROWSER_SEARCH &h28004403
#define DIBUTTON_BROWSER_STOP &h28004404
#define DIBUTTON_BROWSER_HOME &h28004405
#define DIBUTTON_BROWSER_FAVORITES &h28004406
#define DIBUTTON_BROWSER_NEXT &h28004407
#define DIBUTTON_BROWSER_PREVIOUS &h28004408
#define DIBUTTON_BROWSER_HISTORY &h28004409
#define DIBUTTON_BROWSER_PRINT &h2800440A
#define DIBUTTON_BROWSER_DEVICE &h280044FE
#define DIBUTTON_BROWSER_PAUSE &h280044FC
#define DIVIRTUAL_DRIVING_MECHA &h29000000
#define DIAXIS_MECHA_STEER &h29008201
#define DIAXIS_MECHA_TORSO &h29010202
#define DIAXIS_MECHA_ROTATE &h29020203
#define DIAXIS_MECHA_THROTTLE &h29038204
#define DIBUTTON_MECHA_FIRE &h29000401
#define DIBUTTON_MECHA_WEAPONS &h29000402
#define DIBUTTON_MECHA_TARGET &h29000403
#define DIBUTTON_MECHA_REVERSE &h29000404
#define DIBUTTON_MECHA_ZOOM &h29000405
#define DIBUTTON_MECHA_JUMP &h29000406
#define DIBUTTON_MECHA_MENU &h290004FD
#define DIBUTTON_MECHA_CENTER &h29004407
#define DIHATSWITCH_MECHA_GLANCE &h29004601
#define DIBUTTON_MECHA_VIEW &h29004408
#define DIBUTTON_MECHA_FIRESECONDARY &h29004409
#define DIBUTTON_MECHA_LEFT_LINK &h2900C4E4
#define DIBUTTON_MECHA_RIGHT_LINK &h2900C4EC
#define DIBUTTON_MECHA_FORWARD_LINK &h290144E0
#define DIBUTTON_MECHA_BACK_LINK &h290144E8
#define DIBUTTON_MECHA_ROTATE_LEFT_LINK &h290244E4
#define DIBUTTON_MECHA_ROTATE_RIGHT_LINK &h290244EC
#define DIBUTTON_MECHA_FASTER_LINK &h2903C4E0
#define DIBUTTON_MECHA_SLOWER_LINK &h2903C4E8
#define DIBUTTON_MECHA_DEVICE &h290044FE
#define DIBUTTON_MECHA_PAUSE &h290044FC
#define DIAXIS_ANY_X_1 &hFF00C201
#define DIAXIS_ANY_X_2 &hFF00C202
#define DIAXIS_ANY_Y_1 &hFF014201
#define DIAXIS_ANY_Y_2 &hFF014202
#define DIAXIS_ANY_Z_1 &hFF01C201
#define DIAXIS_ANY_Z_2 &hFF01C202
#define DIAXIS_ANY_R_1 &hFF024201
#define DIAXIS_ANY_R_2 &hFF024202
#define DIAXIS_ANY_U_1 &hFF02C201
#define DIAXIS_ANY_U_2 &hFF02C202
#define DIAXIS_ANY_V_1 &hFF034201
#define DIAXIS_ANY_V_2 &hFF034202
#define DIAXIS_ANY_A_1 &hFF03C201
#define DIAXIS_ANY_A_2 &hFF03C202
#define DIAXIS_ANY_B_1 &hFF044201
#define DIAXIS_ANY_B_2 &hFF044202
#define DIAXIS_ANY_C_1 &hFF04C201
#define DIAXIS_ANY_C_2 &hFF04C202
#define DIAXIS_ANY_S_1 &hFF054201
#define DIAXIS_ANY_S_2 &hFF054202
#define DIAXIS_ANY_1 &hFF004201
#define DIAXIS_ANY_2 &hFF004202
#define DIAXIS_ANY_3 &hFF004203
#define DIAXIS_ANY_4 &hFF004204
#define DIPOV_ANY_1 &hFF004601
#define DIPOV_ANY_2 &hFF004602
#define DIPOV_ANY_3 &hFF004603
#define DIPOV_ANY_4 &hFF004604

#endif
