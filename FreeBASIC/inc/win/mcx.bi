''
''
'' mcx -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_mcx_bi__
#define __win_mcx_bi__

#define DIALOPTION_BILLING 64
#define DIALOPTION_QUIET 128
#define DIALOPTION_DIALTONE 256
#define MDMVOLFLAG_LOW 1
#define MDMVOLFLAG_MEDIUM 2
#define MDMVOLFLAG_HIGH 4
#define MDMVOL_LOW 0
#define MDMVOL_MEDIUM 1
#define MDMVOL_HIGH 2
#define MDMSPKRFLAG_OFF 1
#define MDMSPKRFLAG_DIAL 2
#define MDMSPKRFLAG_ON 4
#define MDMSPKRFLAG_CALLSETUP 8
#define MDMSPKR_OFF 0
#define MDMSPKR_DIAL 1
#define MDMSPKR_ON 2
#define MDMSPKR_CALLSETUP 3
#define MDM_COMPRESSION 1
#define MDM_ERROR_CONTROL 2
#define MDM_FORCED_EC 4
#define MDM_CELLULAR 8
#define MDM_FLOWCONTROL_HARD 16
#define MDM_FLOWCONTROL_SOFT 32
#define MDM_CCITT_OVERRIDE 64
#define MDM_SPEED_ADJUST 128
#define MDM_TONE_DIAL 256
#define MDM_BLIND_DIAL 512
#define MDM_V23_OVERRIDE 1024

type MODEMDEVCAPS
	dwActualSize as DWORD
	dwRequiredSize as DWORD
	dwDevSpecificOffset as DWORD
	dwDevSpecificSize as DWORD
	dwModemProviderVersion as DWORD
	dwModemManufacturerOffset as DWORD
	dwModemManufacturerSize as DWORD
	dwModemModelOffset as DWORD
	dwModemModelSize as DWORD
	dwModemVersionOffset as DWORD
	dwModemVersionSize as DWORD
	dwDialOptions as DWORD
	dwCallSetupFailTimer as DWORD
	dwInactivityTimeout as DWORD
	dwSpeakerVolume as DWORD
	dwSpeakerMode as DWORD
	dwModemOptions as DWORD
	dwMaxDTERate as DWORD
	dwMaxDCERate as DWORD
	abVariablePortion(0 to 1-1) as UBYTE
end type

type PMODEMDEVCAPS as MODEMDEVCAPS ptr
type LPMODEMDEVCAPS as MODEMDEVCAPS ptr

type MODEMSETTINGS
	dwActualSize as DWORD
	dwRequiredSize as DWORD
	dwDevSpecificOffset as DWORD
	dwDevSpecificSize as DWORD
	dwCallSetupFailTimer as DWORD
	dwInactivityTimeout as DWORD
	dwSpeakerVolume as DWORD
	dwSpeakerMode as DWORD
	dwPreferredModemOptions as DWORD
	dwNegotiatedModemOptions as DWORD
	dwNegotiatedDCERate as DWORD
	abVariablePortion(0 to 1-1) as UBYTE
end type

type PMODEMSETTINGS as MODEMSETTINGS ptr
type LPMODEMSETTINGS as MODEMSETTINGS ptr

#endif
