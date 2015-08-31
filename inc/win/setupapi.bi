'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "setupapi"

#include once "_mingw_unicode.bi"
#include once "commctrl.bi"
#include once "oledlg.bi"

extern "Windows"

#define _INC_SETUPAPI
const _SETUPAPI_VER = &h0502
const LINE_LEN = 256
const MAX_INF_STRING_LENGTH = 4096
const MAX_INF_SECTION_NAME_LENGTH = 255
const MAX_TITLE_LEN = 60
const MAX_INSTRUCTION_LEN = 256
const MAX_LABEL_LEN = 30
const MAX_SERVICE_NAME_LEN = 256
const MAX_SUBTITLE_LEN = 256
const SP_MAX_MACHINENAME_LENGTH = MAX_PATH + 3
type HINF as PVOID

#ifdef __FB_64BIT__
	type _INFCONTEXT
		Inf as PVOID
		CurrentInf as PVOID
		Section as UINT
		Line as UINT
	end type
#else
	type _INFCONTEXT field = 1
		Inf as PVOID
		CurrentInf as PVOID
		Section as UINT
		Line as UINT
	end type
#endif

type INFCONTEXT as _INFCONTEXT
type PINFCONTEXT as _INFCONTEXT ptr

#ifdef __FB_64BIT__
	type _SP_INF_INFORMATION
		InfStyle as DWORD
		InfCount as DWORD
		VersionData(0 to 0) as UBYTE
	end type
#else
	type _SP_INF_INFORMATION field = 1
		InfStyle as DWORD
		InfCount as DWORD
		VersionData(0 to 0) as UBYTE
	end type
#endif

type SP_INF_INFORMATION as _SP_INF_INFORMATION
type PSP_INF_INFORMATION as _SP_INF_INFORMATION ptr

#ifdef __FB_64BIT__
	type _SP_ALTPLATFORM_INFO_V2
		cbSize as DWORD
		Platform as DWORD
		MajorVersion as DWORD
		MinorVersion as DWORD
		ProcessorArchitecture as WORD

		union
			Reserved as WORD
			Flags as WORD
		end union

		FirstValidatedMajorVersion as DWORD
		FirstValidatedMinorVersion as DWORD
	end type
#else
	type _SP_ALTPLATFORM_INFO_V2 field = 1
		cbSize as DWORD
		Platform as DWORD
		MajorVersion as DWORD
		MinorVersion as DWORD
		ProcessorArchitecture as WORD

		union field = 1
			Reserved as WORD
			Flags as WORD
		end union

		FirstValidatedMajorVersion as DWORD
		FirstValidatedMinorVersion as DWORD
	end type
#endif

type SP_ALTPLATFORM_INFO_V2 as _SP_ALTPLATFORM_INFO_V2
type PSP_ALTPLATFORM_INFO_V2 as _SP_ALTPLATFORM_INFO_V2 ptr

#ifdef __FB_64BIT__
	type _SP_ALTPLATFORM_INFO_V1
		cbSize as DWORD
		Platform as DWORD
		MajorVersion as DWORD
		MinorVersion as DWORD
		ProcessorArchitecture as WORD
		Reserved as WORD
	end type
#else
	type _SP_ALTPLATFORM_INFO_V1 field = 1
		cbSize as DWORD
		Platform as DWORD
		MajorVersion as DWORD
		MinorVersion as DWORD
		ProcessorArchitecture as WORD
		Reserved as WORD
	end type
#endif

type SP_ALTPLATFORM_INFO_V1 as _SP_ALTPLATFORM_INFO_V1
type PSP_ALTPLATFORM_INFO_V1 as _SP_ALTPLATFORM_INFO_V1 ptr
type SP_ALTPLATFORM_INFO as SP_ALTPLATFORM_INFO_V2
type PSP_ALTPLATFORM_INFO as PSP_ALTPLATFORM_INFO_V2
const SP_ALTPLATFORM_FLAGS_VERSION_RANGE = &h0001

#ifdef __FB_64BIT__
	type _SP_ORIGINAL_FILE_INFO_A
		cbSize as DWORD
		OriginalInfName as zstring * 260
		OriginalCatalogName as zstring * 260
	end type
#else
	type _SP_ORIGINAL_FILE_INFO_A field = 1
		cbSize as DWORD
		OriginalInfName as zstring * 260
		OriginalCatalogName as zstring * 260
	end type
#endif

type SP_ORIGINAL_FILE_INFO_A as _SP_ORIGINAL_FILE_INFO_A
type PSP_ORIGINAL_FILE_INFO_A as _SP_ORIGINAL_FILE_INFO_A ptr

#ifdef __FB_64BIT__
	type _SP_ORIGINAL_FILE_INFO_W
		cbSize as DWORD
		OriginalInfName as wstring * 260
		OriginalCatalogName as wstring * 260
	end type
#else
	type _SP_ORIGINAL_FILE_INFO_W field = 1
		cbSize as DWORD
		OriginalInfName as wstring * 260
		OriginalCatalogName as wstring * 260
	end type
#endif

type SP_ORIGINAL_FILE_INFO_W as _SP_ORIGINAL_FILE_INFO_W
type PSP_ORIGINAL_FILE_INFO_W as _SP_ORIGINAL_FILE_INFO_W ptr

#ifdef UNICODE
	type SP_ORIGINAL_FILE_INFO as SP_ORIGINAL_FILE_INFO_W
	type PSP_ORIGINAL_FILE_INFO as PSP_ORIGINAL_FILE_INFO_W
#else
	type SP_ORIGINAL_FILE_INFO as SP_ORIGINAL_FILE_INFO_A
	type PSP_ORIGINAL_FILE_INFO as PSP_ORIGINAL_FILE_INFO_A
#endif

const INF_STYLE_NONE = &h00000000
const INF_STYLE_OLDNT = &h00000001
const INF_STYLE_WIN4 = &h00000002
const INF_STYLE_CACHE_ENABLE = &h00000010
const INF_STYLE_CACHE_DISABLE = &h00000020
const INF_STYLE_CACHE_IGNORE = &h00000040
const DIRID_ABSOLUTE = -1
const DIRID_ABSOLUTE_16BIT = &hffff
const DIRID_NULL = 0
const DIRID_SRCPATH = 1
const DIRID_WINDOWS = 10
const DIRID_SYSTEM = 11
const DIRID_DRIVERS = 12
const DIRID_IOSUBSYS = DIRID_DRIVERS
const DIRID_INF = 17
const DIRID_HELP = 18
const DIRID_FONTS = 20
const DIRID_VIEWERS = 21
const DIRID_COLOR = 23
const DIRID_APPS = 24
const DIRID_SHARED = 25
const DIRID_BOOT = 30
const DIRID_SYSTEM16 = 50
const DIRID_SPOOL = 51
const DIRID_SPOOLDRIVERS = 52
const DIRID_USERPROFILE = 53
const DIRID_LOADER = 54
const DIRID_PRINTPROCESSOR = 55
const DIRID_DEFAULT = DIRID_SYSTEM
const DIRID_COMMON_STARTMENU = 16406
const DIRID_COMMON_PROGRAMS = 16407
const DIRID_COMMON_STARTUP = 16408
const DIRID_COMMON_DESKTOPDIRECTORY = 16409
const DIRID_COMMON_FAVORITES = 16415
const DIRID_COMMON_APPDATA = 16419
const DIRID_PROGRAM_FILES = 16422
const DIRID_SYSTEM_X86 = 16425
const DIRID_PROGRAM_FILES_X86 = 16426
const DIRID_PROGRAM_FILES_COMMON = 16427
const DIRID_PROGRAM_FILES_COMMONX86 = 16428
const DIRID_COMMON_TEMPLATES = 16429
const DIRID_COMMON_DOCUMENTS = 16430
const DIRID_USER = &h8000
type PSP_FILE_CALLBACK_A as function(byval Context as PVOID, byval Notification as UINT, byval Param1 as UINT_PTR, byval Param2 as UINT_PTR) as UINT
type PSP_FILE_CALLBACK_W as function(byval Context as PVOID, byval Notification as UINT, byval Param1 as UINT_PTR, byval Param2 as UINT_PTR) as UINT

#ifdef UNICODE
	type PSP_FILE_CALLBACK as PSP_FILE_CALLBACK_W
#else
	type PSP_FILE_CALLBACK as PSP_FILE_CALLBACK_A
#endif

const SPFILENOTIFY_STARTQUEUE = &h00000001
const SPFILENOTIFY_ENDQUEUE = &h00000002
const SPFILENOTIFY_STARTSUBQUEUE = &h00000003
const SPFILENOTIFY_ENDSUBQUEUE = &h00000004
const SPFILENOTIFY_STARTDELETE = &h00000005
const SPFILENOTIFY_ENDDELETE = &h00000006
const SPFILENOTIFY_DELETEERROR = &h00000007
const SPFILENOTIFY_STARTRENAME = &h00000008
const SPFILENOTIFY_ENDRENAME = &h00000009
const SPFILENOTIFY_RENAMEERROR = &h0000000a
const SPFILENOTIFY_STARTCOPY = &h0000000b
const SPFILENOTIFY_ENDCOPY = &h0000000c
const SPFILENOTIFY_COPYERROR = &h0000000d
const SPFILENOTIFY_NEEDMEDIA = &h0000000e
const SPFILENOTIFY_QUEUESCAN = &h0000000f
const SPFILENOTIFY_CABINETINFO = &h00000010
const SPFILENOTIFY_FILEINCABINET = &h00000011
const SPFILENOTIFY_NEEDNEWCABINET = &h00000012
const SPFILENOTIFY_FILEEXTRACTED = &h00000013
const SPFILENOTIFY_FILEOPDELAYED = &h00000014
const SPFILENOTIFY_STARTBACKUP = &h00000015
const SPFILENOTIFY_BACKUPERROR = &h00000016
const SPFILENOTIFY_ENDBACKUP = &h00000017
const SPFILENOTIFY_QUEUESCAN_EX = &h00000018
const SPFILENOTIFY_STARTREGISTRATION = &h00000019
const SPFILENOTIFY_ENDREGISTRATION = &h00000020
const SPFILENOTIFY_QUEUESCAN_SIGNERINFO = &h00000040
const SPFILENOTIFY_LANGMISMATCH = &h00010000
const SPFILENOTIFY_TARGETEXISTS = &h00020000
const SPFILENOTIFY_TARGETNEWER = &h00040000
const FILEOP_COPY = 0
const FILEOP_RENAME = 1
const FILEOP_DELETE = 2
const FILEOP_BACKUP = 3
const FILEOP_ABORT = 0
const FILEOP_DOIT = 1
const FILEOP_SKIP = 2
const FILEOP_RETRY = FILEOP_DOIT
const FILEOP_NEWPATH = 4
const COPYFLG_WARN_IF_SKIP = &h00000001
const COPYFLG_NOSKIP = &h00000002
const COPYFLG_NOVERSIONCHECK = &h00000004
const COPYFLG_FORCE_FILE_IN_USE = &h00000008
const COPYFLG_NO_OVERWRITE = &h00000010
const COPYFLG_NO_VERSION_DIALOG = &h00000020
const COPYFLG_OVERWRITE_OLDER_ONLY = &h00000040
const COPYFLG_REPLACEONLY = &h00000400
const COPYFLG_NODECOMP = &h00000800
const COPYFLG_REPLACE_BOOT_FILE = &h00001000
const COPYFLG_NOPRUNE = &h00002000
const DELFLG_IN_USE = &h00000001
const DELFLG_IN_USE1 = &h00010000

#ifdef __FB_64BIT__
	type _FILEPATHS_A
		Target as PCSTR
		Source as PCSTR
		Win32Error as UINT
		Flags as DWORD
	end type
#else
	type _FILEPATHS_A field = 1
		Target as PCSTR
		Source as PCSTR
		Win32Error as UINT
		Flags as DWORD
	end type
#endif

type FILEPATHS_A as _FILEPATHS_A
type PFILEPATHS_A as _FILEPATHS_A ptr

#ifdef __FB_64BIT__
	type _FILEPATHS_W
		Target as PCWSTR
		Source as PCWSTR
		Win32Error as UINT
		Flags as DWORD
	end type
#else
	type _FILEPATHS_W field = 1
		Target as PCWSTR
		Source as PCWSTR
		Win32Error as UINT
		Flags as DWORD
	end type
#endif

type FILEPATHS_W as _FILEPATHS_W
type PFILEPATHS_W as _FILEPATHS_W ptr

#ifdef UNICODE
	type FILEPATHS as FILEPATHS_W
	type PFILEPATHS as PFILEPATHS_W
#else
	type FILEPATHS as FILEPATHS_A
	type PFILEPATHS as PFILEPATHS_A
#endif

#ifdef __FB_64BIT__
	type _FILEPATHS_SIGNERINFO_A
		Target as PCSTR
		Source as PCSTR
		Win32Error as UINT
		Flags as DWORD
		DigitalSigner as PCSTR
		Version as PCSTR
		CatalogFile as PCSTR
	end type
#else
	type _FILEPATHS_SIGNERINFO_A field = 1
		Target as PCSTR
		Source as PCSTR
		Win32Error as UINT
		Flags as DWORD
		DigitalSigner as PCSTR
		Version as PCSTR
		CatalogFile as PCSTR
	end type
#endif

type FILEPATHS_SIGNERINFO_A as _FILEPATHS_SIGNERINFO_A
type PFILEPATHS_SIGNERINFO_A as _FILEPATHS_SIGNERINFO_A ptr

#ifdef __FB_64BIT__
	type _FILEPATHS_SIGNERINFO_W
		Target as PCWSTR
		Source as PCWSTR
		Win32Error as UINT
		Flags as DWORD
		DigitalSigner as PCWSTR
		Version as PCWSTR
		CatalogFile as PCWSTR
	end type
#else
	type _FILEPATHS_SIGNERINFO_W field = 1
		Target as PCWSTR
		Source as PCWSTR
		Win32Error as UINT
		Flags as DWORD
		DigitalSigner as PCWSTR
		Version as PCWSTR
		CatalogFile as PCWSTR
	end type
#endif

type FILEPATHS_SIGNERINFO_W as _FILEPATHS_SIGNERINFO_W
type PFILEPATHS_SIGNERINFO_W as _FILEPATHS_SIGNERINFO_W ptr

#ifdef UNICODE
	type FILEPATHS_SIGNERINFO as FILEPATHS_SIGNERINFO_W
	type PFILEPATHS_SIGNERINFO as PFILEPATHS_SIGNERINFO_W
#else
	type FILEPATHS_SIGNERINFO as FILEPATHS_SIGNERINFO_A
	type PFILEPATHS_SIGNERINFO as PFILEPATHS_SIGNERINFO_A
#endif

#ifdef __FB_64BIT__
	type _SOURCE_MEDIA_A
		Reserved as PCSTR
		Tagfile as PCSTR
		Description as PCSTR
		SourcePath as PCSTR
		SourceFile as PCSTR
		Flags as DWORD
	end type
#else
	type _SOURCE_MEDIA_A field = 1
		Reserved as PCSTR
		Tagfile as PCSTR
		Description as PCSTR
		SourcePath as PCSTR
		SourceFile as PCSTR
		Flags as DWORD
	end type
#endif

type SOURCE_MEDIA_A as _SOURCE_MEDIA_A
type PSOURCE_MEDIA_A as _SOURCE_MEDIA_A ptr

#ifdef __FB_64BIT__
	type _SOURCE_MEDIA_W
		Reserved as PCWSTR
		Tagfile as PCWSTR
		Description as PCWSTR
		SourcePath as PCWSTR
		SourceFile as PCWSTR
		Flags as DWORD
	end type
#else
	type _SOURCE_MEDIA_W field = 1
		Reserved as PCWSTR
		Tagfile as PCWSTR
		Description as PCWSTR
		SourcePath as PCWSTR
		SourceFile as PCWSTR
		Flags as DWORD
	end type
#endif

type SOURCE_MEDIA_W as _SOURCE_MEDIA_W
type PSOURCE_MEDIA_W as _SOURCE_MEDIA_W ptr

#ifdef UNICODE
	type SOURCE_MEDIA as SOURCE_MEDIA_W
	type PSOURCE_MEDIA as PSOURCE_MEDIA_W
#else
	type SOURCE_MEDIA as SOURCE_MEDIA_A
	type PSOURCE_MEDIA as PSOURCE_MEDIA_A
#endif

#ifdef __FB_64BIT__
	type _CABINET_INFO_A
		CabinetPath as PCSTR
		CabinetFile as PCSTR
		DiskName as PCSTR
		SetId as USHORT
		CabinetNumber as USHORT
	end type
#else
	type _CABINET_INFO_A field = 1
		CabinetPath as PCSTR
		CabinetFile as PCSTR
		DiskName as PCSTR
		SetId as USHORT
		CabinetNumber as USHORT
	end type
#endif

type CABINET_INFO_A as _CABINET_INFO_A
type PCABINET_INFO_A as _CABINET_INFO_A ptr

#ifdef __FB_64BIT__
	type _CABINET_INFO_W
		CabinetPath as PCWSTR
		CabinetFile as PCWSTR
		DiskName as PCWSTR
		SetId as USHORT
		CabinetNumber as USHORT
	end type
#else
	type _CABINET_INFO_W field = 1
		CabinetPath as PCWSTR
		CabinetFile as PCWSTR
		DiskName as PCWSTR
		SetId as USHORT
		CabinetNumber as USHORT
	end type
#endif

type CABINET_INFO_W as _CABINET_INFO_W
type PCABINET_INFO_W as _CABINET_INFO_W ptr

#ifdef UNICODE
	type CABINET_INFO as CABINET_INFO_W
	type PCABINET_INFO as PCABINET_INFO_W
#else
	type CABINET_INFO as CABINET_INFO_A
	type PCABINET_INFO as PCABINET_INFO_A
#endif

#ifdef __FB_64BIT__
	type _FILE_IN_CABINET_INFO_A
		NameInCabinet as PCSTR
		FileSize as DWORD
		Win32Error as DWORD
		DosDate as WORD
		DosTime as WORD
		DosAttribs as WORD
		FullTargetName as zstring * 260
	end type
#else
	type _FILE_IN_CABINET_INFO_A field = 1
		NameInCabinet as PCSTR
		FileSize as DWORD
		Win32Error as DWORD
		DosDate as WORD
		DosTime as WORD
		DosAttribs as WORD
		FullTargetName as zstring * 260
	end type
#endif

type FILE_IN_CABINET_INFO_A as _FILE_IN_CABINET_INFO_A
type PFILE_IN_CABINET_INFO_A as _FILE_IN_CABINET_INFO_A ptr

#ifdef __FB_64BIT__
	type _FILE_IN_CABINET_INFO_W
		NameInCabinet as PCWSTR
		FileSize as DWORD
		Win32Error as DWORD
		DosDate as WORD
		DosTime as WORD
		DosAttribs as WORD
		FullTargetName as wstring * 260
	end type
#else
	type _FILE_IN_CABINET_INFO_W field = 1
		NameInCabinet as PCWSTR
		FileSize as DWORD
		Win32Error as DWORD
		DosDate as WORD
		DosTime as WORD
		DosAttribs as WORD
		FullTargetName as wstring * 260
	end type
#endif

type FILE_IN_CABINET_INFO_W as _FILE_IN_CABINET_INFO_W
type PFILE_IN_CABINET_INFO_W as _FILE_IN_CABINET_INFO_W ptr

#ifdef UNICODE
	type FILE_IN_CABINET_INFO as FILE_IN_CABINET_INFO_W
	type PFILE_IN_CABINET_INFO as PFILE_IN_CABINET_INFO_W
#else
	type FILE_IN_CABINET_INFO as FILE_IN_CABINET_INFO_A
	type PFILE_IN_CABINET_INFO as PFILE_IN_CABINET_INFO_A
#endif

#ifdef __FB_64BIT__
	type _SP_REGISTER_CONTROL_STATUSA
		cbSize as DWORD
		FileName as PCSTR
		Win32Error as DWORD
		FailureCode as DWORD
	end type
#else
	type _SP_REGISTER_CONTROL_STATUSA field = 1
		cbSize as DWORD
		FileName as PCSTR
		Win32Error as DWORD
		FailureCode as DWORD
	end type
#endif

type SP_REGISTER_CONTROL_STATUSA as _SP_REGISTER_CONTROL_STATUSA
type PSP_REGISTER_CONTROL_STATUSA as _SP_REGISTER_CONTROL_STATUSA ptr

#ifdef __FB_64BIT__
	type _SP_REGISTER_CONTROL_STATUSW
		cbSize as DWORD
		FileName as PCWSTR
		Win32Error as DWORD
		FailureCode as DWORD
	end type
#else
	type _SP_REGISTER_CONTROL_STATUSW field = 1
		cbSize as DWORD
		FileName as PCWSTR
		Win32Error as DWORD
		FailureCode as DWORD
	end type
#endif

type SP_REGISTER_CONTROL_STATUSW as _SP_REGISTER_CONTROL_STATUSW
type PSP_REGISTER_CONTROL_STATUSW as _SP_REGISTER_CONTROL_STATUSW ptr

#ifdef UNICODE
	type SP_REGISTER_CONTROL_STATUS as SP_REGISTER_CONTROL_STATUSW
	type PSP_REGISTER_CONTROL_STATUS as PSP_REGISTER_CONTROL_STATUSW
#else
	type SP_REGISTER_CONTROL_STATUS as SP_REGISTER_CONTROL_STATUSA
	type PSP_REGISTER_CONTROL_STATUS as PSP_REGISTER_CONTROL_STATUSA
#endif

const SPREG_SUCCESS = &h00000000
const SPREG_LOADLIBRARY = &h00000001
const SPREG_GETPROCADDR = &h00000002
const SPREG_REGSVR = &h00000003
const SPREG_DLLINSTALL = &h00000004
const SPREG_TIMEOUT = &h00000005
const SPREG_UNKNOWN = &hFFFFFFFF
type HSPFILEQ as PVOID

#ifdef __FB_64BIT__
	type _SP_FILE_COPY_PARAMS_A
		cbSize as DWORD
		QueueHandle as HSPFILEQ
		SourceRootPath as PCSTR
		SourcePath as PCSTR
		SourceFilename as PCSTR
		SourceDescription as PCSTR
		SourceTagfile as PCSTR
		TargetDirectory as PCSTR
		TargetFilename as PCSTR
		CopyStyle as DWORD
		LayoutInf as HINF
		SecurityDescriptor as PCSTR
	end type
#else
	type _SP_FILE_COPY_PARAMS_A field = 1
		cbSize as DWORD
		QueueHandle as HSPFILEQ
		SourceRootPath as PCSTR
		SourcePath as PCSTR
		SourceFilename as PCSTR
		SourceDescription as PCSTR
		SourceTagfile as PCSTR
		TargetDirectory as PCSTR
		TargetFilename as PCSTR
		CopyStyle as DWORD
		LayoutInf as HINF
		SecurityDescriptor as PCSTR
	end type
#endif

type SP_FILE_COPY_PARAMS_A as _SP_FILE_COPY_PARAMS_A
type PSP_FILE_COPY_PARAMS_A as _SP_FILE_COPY_PARAMS_A ptr

#ifdef __FB_64BIT__
	type _SP_FILE_COPY_PARAMS_W
		cbSize as DWORD
		QueueHandle as HSPFILEQ
		SourceRootPath as PCWSTR
		SourcePath as PCWSTR
		SourceFilename as PCWSTR
		SourceDescription as PCWSTR
		SourceTagfile as PCWSTR
		TargetDirectory as PCWSTR
		TargetFilename as PCWSTR
		CopyStyle as DWORD
		LayoutInf as HINF
		SecurityDescriptor as PCWSTR
	end type
#else
	type _SP_FILE_COPY_PARAMS_W field = 1
		cbSize as DWORD
		QueueHandle as HSPFILEQ
		SourceRootPath as PCWSTR
		SourcePath as PCWSTR
		SourceFilename as PCWSTR
		SourceDescription as PCWSTR
		SourceTagfile as PCWSTR
		TargetDirectory as PCWSTR
		TargetFilename as PCWSTR
		CopyStyle as DWORD
		LayoutInf as HINF
		SecurityDescriptor as PCWSTR
	end type
#endif

type SP_FILE_COPY_PARAMS_W as _SP_FILE_COPY_PARAMS_W
type PSP_FILE_COPY_PARAMS_W as _SP_FILE_COPY_PARAMS_W ptr

#ifdef UNICODE
	type SP_FILE_COPY_PARAMS as SP_FILE_COPY_PARAMS_W
	type PSP_FILE_COPY_PARAMS as PSP_FILE_COPY_PARAMS_W
#else
	type SP_FILE_COPY_PARAMS as SP_FILE_COPY_PARAMS_A
	type PSP_FILE_COPY_PARAMS as PSP_FILE_COPY_PARAMS_A
#endif

type HDSKSPC as PVOID
type HDEVINFO as PVOID

#ifdef __FB_64BIT__
	type _SP_DEVINFO_DATA
		cbSize as DWORD
		ClassGuid as GUID
		DevInst as DWORD
		Reserved as ULONG_PTR
	end type
#else
	type _SP_DEVINFO_DATA field = 1
		cbSize as DWORD
		ClassGuid as GUID
		DevInst as DWORD
		Reserved as ULONG_PTR
	end type
#endif

type SP_DEVINFO_DATA as _SP_DEVINFO_DATA
type PSP_DEVINFO_DATA as _SP_DEVINFO_DATA ptr

#ifdef __FB_64BIT__
	type _SP_DEVICE_INTERFACE_DATA
		cbSize as DWORD
		InterfaceClassGuid as GUID
		Flags as DWORD
		Reserved as ULONG_PTR
	end type
#else
	type _SP_DEVICE_INTERFACE_DATA field = 1
		cbSize as DWORD
		InterfaceClassGuid as GUID
		Flags as DWORD
		Reserved as ULONG_PTR
	end type
#endif

type SP_DEVICE_INTERFACE_DATA as _SP_DEVICE_INTERFACE_DATA
type PSP_DEVICE_INTERFACE_DATA as _SP_DEVICE_INTERFACE_DATA ptr
const SPINT_ACTIVE = &h00000001
const SPINT_DEFAULT = &h00000002
const SPINT_REMOVED = &h00000004
type SP_INTERFACE_DEVICE_DATA as SP_DEVICE_INTERFACE_DATA
type PSP_INTERFACE_DEVICE_DATA as PSP_DEVICE_INTERFACE_DATA
const SPID_ACTIVE = SPINT_ACTIVE
const SPID_DEFAULT = SPINT_DEFAULT
const SPID_REMOVED = SPINT_REMOVED

#ifdef __FB_64BIT__
	type _SP_DEVICE_INTERFACE_DETAIL_DATA_A
		cbSize as DWORD
		DevicePath as zstring * 1
	end type
#else
	type _SP_DEVICE_INTERFACE_DETAIL_DATA_A field = 1
		cbSize as DWORD
		DevicePath as zstring * 1
	end type
#endif

type SP_DEVICE_INTERFACE_DETAIL_DATA_A as _SP_DEVICE_INTERFACE_DETAIL_DATA_A
type PSP_DEVICE_INTERFACE_DETAIL_DATA_A as _SP_DEVICE_INTERFACE_DETAIL_DATA_A ptr

#ifdef __FB_64BIT__
	type _SP_DEVICE_INTERFACE_DETAIL_DATA_W
		cbSize as DWORD
		DevicePath as wstring * 1
	end type
#else
	type _SP_DEVICE_INTERFACE_DETAIL_DATA_W field = 1
		cbSize as DWORD
		DevicePath as wstring * 1
	end type
#endif

type SP_DEVICE_INTERFACE_DETAIL_DATA_W as _SP_DEVICE_INTERFACE_DETAIL_DATA_W
type PSP_DEVICE_INTERFACE_DETAIL_DATA_W as _SP_DEVICE_INTERFACE_DETAIL_DATA_W ptr

#ifdef UNICODE
	type SP_DEVICE_INTERFACE_DETAIL_DATA as SP_DEVICE_INTERFACE_DETAIL_DATA_W
	type PSP_DEVICE_INTERFACE_DETAIL_DATA as PSP_DEVICE_INTERFACE_DETAIL_DATA_W
#else
	type SP_DEVICE_INTERFACE_DETAIL_DATA as SP_DEVICE_INTERFACE_DETAIL_DATA_A
	type PSP_DEVICE_INTERFACE_DETAIL_DATA as PSP_DEVICE_INTERFACE_DETAIL_DATA_A
#endif

type SP_INTERFACE_DEVICE_DETAIL_DATA_W as SP_DEVICE_INTERFACE_DETAIL_DATA_W
type PSP_INTERFACE_DEVICE_DETAIL_DATA_W as PSP_DEVICE_INTERFACE_DETAIL_DATA_W
type SP_INTERFACE_DEVICE_DETAIL_DATA_A as SP_DEVICE_INTERFACE_DETAIL_DATA_A
type PSP_INTERFACE_DEVICE_DETAIL_DATA_A as PSP_DEVICE_INTERFACE_DETAIL_DATA_A

#ifdef UNICODE
	type SP_INTERFACE_DEVICE_DETAIL_DATA as SP_INTERFACE_DEVICE_DETAIL_DATA_W
	type PSP_INTERFACE_DEVICE_DETAIL_DATA as PSP_INTERFACE_DEVICE_DETAIL_DATA_W
#else
	type SP_INTERFACE_DEVICE_DETAIL_DATA as SP_INTERFACE_DEVICE_DETAIL_DATA_A
	type PSP_INTERFACE_DEVICE_DETAIL_DATA as PSP_INTERFACE_DEVICE_DETAIL_DATA_A
#endif

#ifdef __FB_64BIT__
	type _SP_DEVINFO_LIST_DETAIL_DATA_A
		cbSize as DWORD
		ClassGuid as GUID
		RemoteMachineHandle as HANDLE
		RemoteMachineName as zstring * 260 + 3
	end type
#else
	type _SP_DEVINFO_LIST_DETAIL_DATA_A field = 1
		cbSize as DWORD
		ClassGuid as GUID
		RemoteMachineHandle as HANDLE
		RemoteMachineName as zstring * 260 + 3
	end type
#endif

type SP_DEVINFO_LIST_DETAIL_DATA_A as _SP_DEVINFO_LIST_DETAIL_DATA_A
type PSP_DEVINFO_LIST_DETAIL_DATA_A as _SP_DEVINFO_LIST_DETAIL_DATA_A ptr

#ifdef __FB_64BIT__
	type _SP_DEVINFO_LIST_DETAIL_DATA_W
		cbSize as DWORD
		ClassGuid as GUID
		RemoteMachineHandle as HANDLE
		RemoteMachineName as wstring * 260 + 3
	end type
#else
	type _SP_DEVINFO_LIST_DETAIL_DATA_W field = 1
		cbSize as DWORD
		ClassGuid as GUID
		RemoteMachineHandle as HANDLE
		RemoteMachineName as wstring * 260 + 3
	end type
#endif

type SP_DEVINFO_LIST_DETAIL_DATA_W as _SP_DEVINFO_LIST_DETAIL_DATA_W
type PSP_DEVINFO_LIST_DETAIL_DATA_W as _SP_DEVINFO_LIST_DETAIL_DATA_W ptr

#ifdef UNICODE
	type SP_DEVINFO_LIST_DETAIL_DATA as SP_DEVINFO_LIST_DETAIL_DATA_W
	type PSP_DEVINFO_LIST_DETAIL_DATA as PSP_DEVINFO_LIST_DETAIL_DATA_W
#else
	type SP_DEVINFO_LIST_DETAIL_DATA as SP_DEVINFO_LIST_DETAIL_DATA_A
	type PSP_DEVINFO_LIST_DETAIL_DATA as PSP_DEVINFO_LIST_DETAIL_DATA_A
#endif

const DIF_SELECTDEVICE = &h00000001
const DIF_INSTALLDEVICE = &h00000002
const DIF_ASSIGNRESOURCES = &h00000003
const DIF_PROPERTIES = &h00000004
const DIF_REMOVE = &h00000005
const DIF_FIRSTTIMESETUP = &h00000006
const DIF_FOUNDDEVICE = &h00000007
const DIF_SELECTCLASSDRIVERS = &h00000008
const DIF_VALIDATECLASSDRIVERS = &h00000009
const DIF_INSTALLCLASSDRIVERS = &h0000000A
const DIF_CALCDISKSPACE = &h0000000B
const DIF_DESTROYPRIVATEDATA = &h0000000C
const DIF_VALIDATEDRIVER = &h0000000D
const DIF_DETECT = &h0000000F
const DIF_INSTALLWIZARD = &h00000010
const DIF_DESTROYWIZARDDATA = &h00000011
const DIF_PROPERTYCHANGE = &h00000012
const DIF_ENABLECLASS = &h00000013
const DIF_DETECTVERIFY = &h00000014
const DIF_INSTALLDEVICEFILES = &h00000015
const DIF_UNREMOVE = &h00000016
const DIF_SELECTBESTCOMPATDRV = &h00000017
const DIF_ALLOW_INSTALL = &h00000018
const DIF_REGISTERDEVICE = &h00000019
const DIF_NEWDEVICEWIZARD_PRESELECT = &h0000001A
const DIF_NEWDEVICEWIZARD_SELECT = &h0000001B
const DIF_NEWDEVICEWIZARD_PREANALYZE = &h0000001C
const DIF_NEWDEVICEWIZARD_POSTANALYZE = &h0000001D
const DIF_NEWDEVICEWIZARD_FINISHINSTALL = &h0000001E
const DIF_UNUSED1 = &h0000001F
const DIF_INSTALLINTERFACES = &h00000020
const DIF_DETECTCANCEL = &h00000021
const DIF_REGISTER_COINSTALLERS = &h00000022
const DIF_ADDPROPERTYPAGE_ADVANCED = &h00000023
const DIF_ADDPROPERTYPAGE_BASIC = &h00000024
const DIF_RESERVED1 = &h00000025
const DIF_TROUBLESHOOTER = &h00000026
const DIF_POWERMESSAGEWAKE = &h00000027
const DIF_ADDREMOTEPROPERTYPAGE_ADVANCED = &h00000028
const DIF_UPDATEDRIVER_UI = &h00000029
const DIF_RESERVED2 = &h00000030
const DIF_MOVEDEVICE = &h0000000E
type DI_FUNCTION as UINT

#ifdef __FB_64BIT__
	type _SP_DEVINSTALL_PARAMS_A
		cbSize as DWORD
		Flags as DWORD
		FlagsEx as DWORD
		hwndParent as HWND

		#ifdef __FB_64BIT__
			#ifdef UNICODE
				InstallMsgHandler as PSP_FILE_CALLBACK_W
			#else
				InstallMsgHandler as PSP_FILE_CALLBACK_A
			#endif
		#endif

		InstallMsgHandlerContext as PVOID
		FileQueue as HSPFILEQ
		ClassInstallReserved as ULONG_PTR
		Reserved as DWORD
		DriverPath as zstring * 260
	end type
#else
	type _SP_DEVINSTALL_PARAMS_A field = 1
		cbSize as DWORD
		Flags as DWORD
		FlagsEx as DWORD
		hwndParent as HWND

		#ifndef __FB_64BIT__
			#ifdef UNICODE
				InstallMsgHandler as PSP_FILE_CALLBACK_W
			#else
				InstallMsgHandler as PSP_FILE_CALLBACK_A
			#endif
		#endif

		InstallMsgHandlerContext as PVOID
		FileQueue as HSPFILEQ
		ClassInstallReserved as ULONG_PTR
		Reserved as DWORD
		DriverPath as zstring * 260
	end type
#endif

type SP_DEVINSTALL_PARAMS_A as _SP_DEVINSTALL_PARAMS_A
type PSP_DEVINSTALL_PARAMS_A as _SP_DEVINSTALL_PARAMS_A ptr

#ifdef __FB_64BIT__
	type _SP_DEVINSTALL_PARAMS_W
		cbSize as DWORD
		Flags as DWORD
		FlagsEx as DWORD
		hwndParent as HWND

		#ifdef __FB_64BIT__
			#ifdef UNICODE
				InstallMsgHandler as PSP_FILE_CALLBACK_W
			#else
				InstallMsgHandler as PSP_FILE_CALLBACK_A
			#endif
		#endif

		InstallMsgHandlerContext as PVOID
		FileQueue as HSPFILEQ
		ClassInstallReserved as ULONG_PTR
		Reserved as DWORD
		DriverPath as wstring * 260
	end type
#else
	type _SP_DEVINSTALL_PARAMS_W field = 1
		cbSize as DWORD
		Flags as DWORD
		FlagsEx as DWORD
		hwndParent as HWND

		#ifndef __FB_64BIT__
			#ifdef UNICODE
				InstallMsgHandler as PSP_FILE_CALLBACK_W
			#else
				InstallMsgHandler as PSP_FILE_CALLBACK_A
			#endif
		#endif

		InstallMsgHandlerContext as PVOID
		FileQueue as HSPFILEQ
		ClassInstallReserved as ULONG_PTR
		Reserved as DWORD
		DriverPath as wstring * 260
	end type
#endif

type SP_DEVINSTALL_PARAMS_W as _SP_DEVINSTALL_PARAMS_W
type PSP_DEVINSTALL_PARAMS_W as _SP_DEVINSTALL_PARAMS_W ptr

#ifdef UNICODE
	type SP_DEVINSTALL_PARAMS as SP_DEVINSTALL_PARAMS_W
	type PSP_DEVINSTALL_PARAMS as PSP_DEVINSTALL_PARAMS_W
#else
	type SP_DEVINSTALL_PARAMS as SP_DEVINSTALL_PARAMS_A
	type PSP_DEVINSTALL_PARAMS as PSP_DEVINSTALL_PARAMS_A
#endif

const DI_SHOWOEM = &h00000001
const DI_SHOWCOMPAT = &h00000002
const DI_SHOWCLASS = &h00000004
const DI_SHOWALL = &h00000007
const DI_NOVCP = &h00000008
const DI_DIDCOMPAT = &h00000010
const DI_DIDCLASS = &h00000020
const DI_AUTOASSIGNRES = &h00000040
const DI_NEEDRESTART = &h00000080
const DI_NEEDREBOOT = &h00000100
const DI_NOBROWSE = &h00000200
const DI_MULTMFGS = &h00000400
const DI_DISABLED = &h00000800
const DI_GENERALPAGE_ADDED = &h00001000
const DI_RESOURCEPAGE_ADDED = &h00002000
const DI_PROPERTIES_CHANGE = &h00004000
const DI_INF_IS_SORTED = &h00008000
const DI_ENUMSINGLEINF = &h00010000
const DI_DONOTCALLCONFIGMG = &h00020000
const DI_INSTALLDISABLED = &h00040000
const DI_COMPAT_FROM_CLASS = &h00080000
const DI_CLASSINSTALLPARAMS = &h00100000
const DI_NODI_DEFAULTACTION = &h00200000
const DI_QUIETINSTALL = &h00800000
const DI_NOFILECOPY = &h01000000
const DI_FORCECOPY = &h02000000
const DI_DRIVERPAGE_ADDED = &h04000000
const DI_USECI_SELECTSTRINGS = &h08000000
const DI_OVERRIDE_INFFLAGS = &h10000000
const DI_PROPS_NOCHANGEUSAGE = &h20000000
const DI_NOSELECTICONS = &h40000000
const DI_NOWRITE_IDS = &h80000000
const DI_FLAGSEX_USEOLDINFSEARCH = &h00000001
const DI_FLAGSEX_RESERVED2 = &h00000002
const DI_FLAGSEX_CI_FAILED = &h00000004
const DI_FLAGSEX_DIDINFOLIST = &h00000010
const DI_FLAGSEX_DIDCOMPATINFO = &h00000020
const DI_FLAGSEX_FILTERCLASSES = &h00000040
const DI_FLAGSEX_SETFAILEDINSTALL = &h00000080
const DI_FLAGSEX_DEVICECHANGE = &h00000100
const DI_FLAGSEX_ALWAYSWRITEIDS = &h00000200
const DI_FLAGSEX_PROPCHANGE_PENDING = &h00000400
const DI_FLAGSEX_ALLOWEXCLUDEDDRVS = &h00000800
const DI_FLAGSEX_NOUIONQUERYREMOVE = &h00001000
const DI_FLAGSEX_USECLASSFORCOMPAT = &h00002000
const DI_FLAGSEX_RESERVED3 = &h00004000
const DI_FLAGSEX_NO_DRVREG_MODIFY = &h00008000
const DI_FLAGSEX_IN_SYSTEM_SETUP = &h00010000
const DI_FLAGSEX_INET_DRIVER = &h00020000
const DI_FLAGSEX_APPENDDRIVERLIST = &h00040000
const DI_FLAGSEX_PREINSTALLBACKUP = &h00080000
const DI_FLAGSEX_BACKUPONREPLACE = &h00100000
const DI_FLAGSEX_DRIVERLIST_FROM_URL = &h00200000
const DI_FLAGSEX_RESERVED1 = &h00400000
const DI_FLAGSEX_EXCLUDE_OLD_INET_DRIVERS = &h00800000
const DI_FLAGSEX_POWERPAGE_ADDED = &h01000000
const DI_FLAGSEX_FILTERSIMILARDRIVERS = &h02000000
const DI_FLAGSEX_INSTALLEDDRIVER = &h04000000
const DI_FLAGSEX_NO_CLASSLIST_NODE_MERGE = &h08000000
const DI_FLAGSEX_ALTPLATFORM_DRVSEARCH = &h10000000
const DI_FLAGSEX_RESTART_DEVICE_ONLY = &h20000000

#ifdef __FB_64BIT__
	type _SP_CLASSINSTALL_HEADER
		cbSize as DWORD
		InstallFunction as DI_FUNCTION
	end type
#else
	type _SP_CLASSINSTALL_HEADER field = 1
		cbSize as DWORD
		InstallFunction as DI_FUNCTION
	end type
#endif

type SP_CLASSINSTALL_HEADER as _SP_CLASSINSTALL_HEADER
type PSP_CLASSINSTALL_HEADER as _SP_CLASSINSTALL_HEADER ptr

#ifdef __FB_64BIT__
	type _SP_ENABLECLASS_PARAMS
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		ClassGuid as GUID
		EnableMessage as DWORD
	end type
#else
	type _SP_ENABLECLASS_PARAMS field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		ClassGuid as GUID
		EnableMessage as DWORD
	end type
#endif

type SP_ENABLECLASS_PARAMS as _SP_ENABLECLASS_PARAMS
type PSP_ENABLECLASS_PARAMS as _SP_ENABLECLASS_PARAMS ptr
const ENABLECLASS_QUERY = 0
const ENABLECLASS_SUCCESS = 1
const ENABLECLASS_FAILURE = 2
const DICS_ENABLE = &h00000001
const DICS_DISABLE = &h00000002
const DICS_PROPCHANGE = &h00000003
const DICS_START = &h00000004
const DICS_STOP = &h00000005
const DICS_FLAG_GLOBAL = &h00000001
const DICS_FLAG_CONFIGSPECIFIC = &h00000002
const DICS_FLAG_CONFIGGENERAL = &h00000004

#ifdef __FB_64BIT__
	type _SP_PROPCHANGE_PARAMS
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		StateChange as DWORD
		Scope as DWORD
		HwProfile as DWORD
	end type
#else
	type _SP_PROPCHANGE_PARAMS field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		StateChange as DWORD
		Scope as DWORD
		HwProfile as DWORD
	end type
#endif

type SP_PROPCHANGE_PARAMS as _SP_PROPCHANGE_PARAMS
type PSP_PROPCHANGE_PARAMS as _SP_PROPCHANGE_PARAMS ptr

#ifdef __FB_64BIT__
	type _SP_REMOVEDEVICE_PARAMS
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Scope as DWORD
		HwProfile as DWORD
	end type
#else
	type _SP_REMOVEDEVICE_PARAMS field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Scope as DWORD
		HwProfile as DWORD
	end type
#endif

type SP_REMOVEDEVICE_PARAMS as _SP_REMOVEDEVICE_PARAMS
type PSP_REMOVEDEVICE_PARAMS as _SP_REMOVEDEVICE_PARAMS ptr
const DI_REMOVEDEVICE_GLOBAL = &h00000001
const DI_REMOVEDEVICE_CONFIGSPECIFIC = &h00000002

#ifdef __FB_64BIT__
	type _SP_UNREMOVEDEVICE_PARAMS
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Scope as DWORD
		HwProfile as DWORD
	end type
#else
	type _SP_UNREMOVEDEVICE_PARAMS field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Scope as DWORD
		HwProfile as DWORD
	end type
#endif

type SP_UNREMOVEDEVICE_PARAMS as _SP_UNREMOVEDEVICE_PARAMS
type PSP_UNREMOVEDEVICE_PARAMS as _SP_UNREMOVEDEVICE_PARAMS ptr
const DI_UNREMOVEDEVICE_CONFIGSPECIFIC = &h00000002

#ifdef __FB_64BIT__
	type _SP_SELECTDEVICE_PARAMS_A
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Title as zstring * 60
		Instructions as zstring * 256
		ListLabel as zstring * 30
		SubTitle as zstring * 256
		Reserved(0 to 1) as UBYTE
	end type
#else
	type _SP_SELECTDEVICE_PARAMS_A field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Title as zstring * 60
		Instructions as zstring * 256
		ListLabel as zstring * 30
		SubTitle as zstring * 256
		Reserved(0 to 1) as UBYTE
	end type
#endif

type SP_SELECTDEVICE_PARAMS_A as _SP_SELECTDEVICE_PARAMS_A
type PSP_SELECTDEVICE_PARAMS_A as _SP_SELECTDEVICE_PARAMS_A ptr

#ifdef __FB_64BIT__
	type _SP_SELECTDEVICE_PARAMS_W
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Title as wstring * 60
		Instructions as wstring * 256
		ListLabel as wstring * 30
		SubTitle as wstring * 256
	end type
#else
	type _SP_SELECTDEVICE_PARAMS_W field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Title as wstring * 60
		Instructions as wstring * 256
		ListLabel as wstring * 30
		SubTitle as wstring * 256
	end type
#endif

type SP_SELECTDEVICE_PARAMS_W as _SP_SELECTDEVICE_PARAMS_W
type PSP_SELECTDEVICE_PARAMS_W as _SP_SELECTDEVICE_PARAMS_W ptr

#ifdef UNICODE
	type SP_SELECTDEVICE_PARAMS as SP_SELECTDEVICE_PARAMS_W
	type PSP_SELECTDEVICE_PARAMS as PSP_SELECTDEVICE_PARAMS_W
#else
	type SP_SELECTDEVICE_PARAMS as SP_SELECTDEVICE_PARAMS_A
	type PSP_SELECTDEVICE_PARAMS as PSP_SELECTDEVICE_PARAMS_A
#endif

type PDETECT_PROGRESS_NOTIFY as function(byval ProgressNotifyParam as PVOID, byval DetectComplete as DWORD) as WINBOOL

#ifdef __FB_64BIT__
	type _SP_DETECTDEVICE_PARAMS
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		DetectProgressNotify as PDETECT_PROGRESS_NOTIFY
		ProgressNotifyParam as PVOID
	end type
#else
	type _SP_DETECTDEVICE_PARAMS field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		DetectProgressNotify as PDETECT_PROGRESS_NOTIFY
		ProgressNotifyParam as PVOID
	end type
#endif

type SP_DETECTDEVICE_PARAMS as _SP_DETECTDEVICE_PARAMS
type PSP_DETECTDEVICE_PARAMS as _SP_DETECTDEVICE_PARAMS ptr
const MAX_INSTALLWIZARD_DYNAPAGES = 20

#ifdef __FB_64BIT__
	type _SP_INSTALLWIZARD_DATA
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Flags as DWORD
		DynamicPages(0 to 19) as HPROPSHEETPAGE
		NumDynamicPages as DWORD
		DynamicPageFlags as DWORD
		PrivateFlags as DWORD
		PrivateData as LPARAM
		hwndWizardDlg as HWND
	end type
#else
	type _SP_INSTALLWIZARD_DATA field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Flags as DWORD
		DynamicPages(0 to 19) as HPROPSHEETPAGE
		NumDynamicPages as DWORD
		DynamicPageFlags as DWORD
		PrivateFlags as DWORD
		PrivateData as LPARAM
		hwndWizardDlg as HWND
	end type
#endif

type SP_INSTALLWIZARD_DATA as _SP_INSTALLWIZARD_DATA
type PSP_INSTALLWIZARD_DATA as _SP_INSTALLWIZARD_DATA ptr
const NDW_INSTALLFLAG_DIDFACTDEFS = &h00000001
const NDW_INSTALLFLAG_HARDWAREALLREADYIN = &h00000002
const NDW_INSTALLFLAG_NEEDRESTART = DI_NEEDRESTART
const NDW_INSTALLFLAG_NEEDREBOOT = DI_NEEDREBOOT
const NDW_INSTALLFLAG_NEEDSHUTDOWN = &h00000200
const NDW_INSTALLFLAG_EXPRESSINTRO = &h00000400
const NDW_INSTALLFLAG_SKIPISDEVINSTALLED = &h00000800
const NDW_INSTALLFLAG_NODETECTEDDEVS = &h00001000
const NDW_INSTALLFLAG_INSTALLSPECIFIC = &h00002000
const NDW_INSTALLFLAG_SKIPCLASSLIST = &h00004000
const NDW_INSTALLFLAG_CI_PICKED_OEM = &h00008000
const NDW_INSTALLFLAG_PCMCIAMODE = &h00010000
const NDW_INSTALLFLAG_PCMCIADEVICE = &h00020000
const NDW_INSTALLFLAG_USERCANCEL = &h00040000
const NDW_INSTALLFLAG_KNOWNCLASS = &h00080000
const DYNAWIZ_FLAG_PAGESADDED = &h00000001
const DYNAWIZ_FLAG_ANALYZE_HANDLECONFLICT = &h00000008
const DYNAWIZ_FLAG_INSTALLDET_NEXT = &h00000002
const DYNAWIZ_FLAG_INSTALLDET_PREV = &h00000004
const MIN_IDD_DYNAWIZ_RESOURCE_ID = 10000
const MAX_IDD_DYNAWIZ_RESOURCE_ID = 11000
const IDD_DYNAWIZ_FIRSTPAGE = 10000
const IDD_DYNAWIZ_SELECT_PREVPAGE = 10001
const IDD_DYNAWIZ_SELECT_NEXTPAGE = 10002
const IDD_DYNAWIZ_ANALYZE_PREVPAGE = 10003
const IDD_DYNAWIZ_ANALYZE_NEXTPAGE = 10004
const IDD_DYNAWIZ_SELECTDEV_PAGE = 10009
const IDD_DYNAWIZ_ANALYZEDEV_PAGE = 10010
const IDD_DYNAWIZ_INSTALLDETECTEDDEVS_PAGE = 10011
const IDD_DYNAWIZ_SELECTCLASS_PAGE = 10012
const IDD_DYNAWIZ_INSTALLDETECTED_PREVPAGE = 10006
const IDD_DYNAWIZ_INSTALLDETECTED_NEXTPAGE = 10007
const IDD_DYNAWIZ_INSTALLDETECTED_NODEVS = 10008

#ifdef __FB_64BIT__
	type _SP_NEWDEVICEWIZARD_DATA
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Flags as DWORD
		DynamicPages(0 to 19) as HPROPSHEETPAGE
		NumDynamicPages as DWORD
		hwndWizardDlg as HWND
	end type
#else
	type _SP_NEWDEVICEWIZARD_DATA field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		Flags as DWORD
		DynamicPages(0 to 19) as HPROPSHEETPAGE
		NumDynamicPages as DWORD
		hwndWizardDlg as HWND
	end type
#endif

type SP_NEWDEVICEWIZARD_DATA as _SP_NEWDEVICEWIZARD_DATA
type PSP_NEWDEVICEWIZARD_DATA as _SP_NEWDEVICEWIZARD_DATA ptr
type SP_ADDPROPERTYPAGE_DATA as SP_NEWDEVICEWIZARD_DATA
type PSP_ADDPROPERTYPAGE_DATA as PSP_NEWDEVICEWIZARD_DATA

#ifdef __FB_64BIT__
	type _SP_TROUBLESHOOTER_PARAMS_A
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		ChmFile as zstring * 260
		HtmlTroubleShooter as zstring * 260
	end type
#else
	type _SP_TROUBLESHOOTER_PARAMS_A field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		ChmFile as zstring * 260
		HtmlTroubleShooter as zstring * 260
	end type
#endif

type SP_TROUBLESHOOTER_PARAMS_A as _SP_TROUBLESHOOTER_PARAMS_A
type PSP_TROUBLESHOOTER_PARAMS_A as _SP_TROUBLESHOOTER_PARAMS_A ptr

#ifdef __FB_64BIT__
	type _SP_TROUBLESHOOTER_PARAMS_W
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		ChmFile as wstring * 260
		HtmlTroubleShooter as wstring * 260
	end type
#else
	type _SP_TROUBLESHOOTER_PARAMS_W field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		ChmFile as wstring * 260
		HtmlTroubleShooter as wstring * 260
	end type
#endif

type SP_TROUBLESHOOTER_PARAMS_W as _SP_TROUBLESHOOTER_PARAMS_W
type PSP_TROUBLESHOOTER_PARAMS_W as _SP_TROUBLESHOOTER_PARAMS_W ptr

#ifdef UNICODE
	type SP_TROUBLESHOOTER_PARAMS as SP_TROUBLESHOOTER_PARAMS_W
	type PSP_TROUBLESHOOTER_PARAMS as PSP_TROUBLESHOOTER_PARAMS_W
#else
	type SP_TROUBLESHOOTER_PARAMS as SP_TROUBLESHOOTER_PARAMS_A
	type PSP_TROUBLESHOOTER_PARAMS as PSP_TROUBLESHOOTER_PARAMS_A
#endif

#ifdef __FB_64BIT__
	type _SP_POWERMESSAGEWAKE_PARAMS_A
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		PowerMessageWake as zstring * 256 * 2
	end type
#else
	type _SP_POWERMESSAGEWAKE_PARAMS_A field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		PowerMessageWake as zstring * 256 * 2
	end type
#endif

type SP_POWERMESSAGEWAKE_PARAMS_A as _SP_POWERMESSAGEWAKE_PARAMS_A
type PSP_POWERMESSAGEWAKE_PARAMS_A as _SP_POWERMESSAGEWAKE_PARAMS_A ptr

#ifdef __FB_64BIT__
	type _SP_POWERMESSAGEWAKE_PARAMS_W
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		PowerMessageWake as wstring * 256 * 2
	end type
#else
	type _SP_POWERMESSAGEWAKE_PARAMS_W field = 1
		ClassInstallHeader as SP_CLASSINSTALL_HEADER
		PowerMessageWake as wstring * 256 * 2
	end type
#endif

type SP_POWERMESSAGEWAKE_PARAMS_W as _SP_POWERMESSAGEWAKE_PARAMS_W
type PSP_POWERMESSAGEWAKE_PARAMS_W as _SP_POWERMESSAGEWAKE_PARAMS_W ptr

#ifdef UNICODE
	type SP_POWERMESSAGEWAKE_PARAMS as SP_POWERMESSAGEWAKE_PARAMS_W
	type PSP_POWERMESSAGEWAKE_PARAMS as PSP_POWERMESSAGEWAKE_PARAMS_W
#else
	type SP_POWERMESSAGEWAKE_PARAMS as SP_POWERMESSAGEWAKE_PARAMS_A
	type PSP_POWERMESSAGEWAKE_PARAMS as PSP_POWERMESSAGEWAKE_PARAMS_A
#endif

#ifdef __FB_64BIT__
	type _SP_DRVINFO_DATA_V2_A
		cbSize as DWORD
		DriverType as DWORD
		Reserved as ULONG_PTR
		Description as zstring * 256
		MfgName as zstring * 256
		ProviderName as zstring * 256
		DriverDate as FILETIME
		DriverVersion as DWORDLONG
	end type
#else
	type _SP_DRVINFO_DATA_V2_A field = 1
		cbSize as DWORD
		DriverType as DWORD
		Reserved as ULONG_PTR
		Description as zstring * 256
		MfgName as zstring * 256
		ProviderName as zstring * 256
		DriverDate as FILETIME
		DriverVersion as DWORDLONG
	end type
#endif

type SP_DRVINFO_DATA_V2_A as _SP_DRVINFO_DATA_V2_A
type PSP_DRVINFO_DATA_V2_A as _SP_DRVINFO_DATA_V2_A ptr

#ifdef __FB_64BIT__
	type _SP_DRVINFO_DATA_V2_W
		cbSize as DWORD
		DriverType as DWORD
		Reserved as ULONG_PTR
		Description as wstring * 256
		MfgName as wstring * 256
		ProviderName as wstring * 256
		DriverDate as FILETIME
		DriverVersion as DWORDLONG
	end type
#else
	type _SP_DRVINFO_DATA_V2_W field = 1
		cbSize as DWORD
		DriverType as DWORD
		Reserved as ULONG_PTR
		Description as wstring * 256
		MfgName as wstring * 256
		ProviderName as wstring * 256
		DriverDate as FILETIME
		DriverVersion as DWORDLONG
	end type
#endif

type SP_DRVINFO_DATA_V2_W as _SP_DRVINFO_DATA_V2_W
type PSP_DRVINFO_DATA_V2_W as _SP_DRVINFO_DATA_V2_W ptr

#ifdef __FB_64BIT__
	type _SP_DRVINFO_DATA_V1_A
		cbSize as DWORD
		DriverType as DWORD
		Reserved as ULONG_PTR
		Description as zstring * 256
		MfgName as zstring * 256
		ProviderName as zstring * 256
	end type
#else
	type _SP_DRVINFO_DATA_V1_A field = 1
		cbSize as DWORD
		DriverType as DWORD
		Reserved as ULONG_PTR
		Description as zstring * 256
		MfgName as zstring * 256
		ProviderName as zstring * 256
	end type
#endif

type SP_DRVINFO_DATA_V1_A as _SP_DRVINFO_DATA_V1_A
type PSP_DRVINFO_DATA_V1_A as _SP_DRVINFO_DATA_V1_A ptr

#ifdef __FB_64BIT__
	type _SP_DRVINFO_DATA_V1_W
		cbSize as DWORD
		DriverType as DWORD
		Reserved as ULONG_PTR
		Description as wstring * 256
		MfgName as wstring * 256
		ProviderName as wstring * 256
	end type
#else
	type _SP_DRVINFO_DATA_V1_W field = 1
		cbSize as DWORD
		DriverType as DWORD
		Reserved as ULONG_PTR
		Description as wstring * 256
		MfgName as wstring * 256
		ProviderName as wstring * 256
	end type
#endif

type SP_DRVINFO_DATA_V1_W as _SP_DRVINFO_DATA_V1_W
type PSP_DRVINFO_DATA_V1_W as _SP_DRVINFO_DATA_V1_W ptr

#ifdef UNICODE
	type SP_DRVINFO_DATA_V1 as SP_DRVINFO_DATA_V1_W
	type PSP_DRVINFO_DATA_V1 as PSP_DRVINFO_DATA_V1_W
	type SP_DRVINFO_DATA_V2 as SP_DRVINFO_DATA_V2_W
	type PSP_DRVINFO_DATA_V2 as PSP_DRVINFO_DATA_V2_W
#else
	type SP_DRVINFO_DATA_V1 as SP_DRVINFO_DATA_V1_A
	type PSP_DRVINFO_DATA_V1 as PSP_DRVINFO_DATA_V1_A
	type SP_DRVINFO_DATA_V2 as SP_DRVINFO_DATA_V2_A
	type PSP_DRVINFO_DATA_V2 as PSP_DRVINFO_DATA_V2_A
#endif

type SP_DRVINFO_DATA_A as SP_DRVINFO_DATA_V2_A
type PSP_DRVINFO_DATA_A as PSP_DRVINFO_DATA_V2_A
type SP_DRVINFO_DATA_W as SP_DRVINFO_DATA_V2_W
type PSP_DRVINFO_DATA_W as PSP_DRVINFO_DATA_V2_W
type SP_DRVINFO_DATA as SP_DRVINFO_DATA_V2
type PSP_DRVINFO_DATA as PSP_DRVINFO_DATA_V2

#ifdef __FB_64BIT__
	type _SP_DRVINFO_DETAIL_DATA_A
		cbSize as DWORD
		InfDate as FILETIME
		CompatIDsOffset as DWORD
		CompatIDsLength as DWORD
		Reserved as ULONG_PTR
		SectionName as zstring * 256
		InfFileName as zstring * 260
		DrvDescription as zstring * 256
		HardwareID as zstring * 1
	end type
#else
	type _SP_DRVINFO_DETAIL_DATA_A field = 1
		cbSize as DWORD
		InfDate as FILETIME
		CompatIDsOffset as DWORD
		CompatIDsLength as DWORD
		Reserved as ULONG_PTR
		SectionName as zstring * 256
		InfFileName as zstring * 260
		DrvDescription as zstring * 256
		HardwareID as zstring * 1
	end type
#endif

type SP_DRVINFO_DETAIL_DATA_A as _SP_DRVINFO_DETAIL_DATA_A
type PSP_DRVINFO_DETAIL_DATA_A as _SP_DRVINFO_DETAIL_DATA_A ptr

#ifdef __FB_64BIT__
	type _SP_DRVINFO_DETAIL_DATA_W
		cbSize as DWORD
		InfDate as FILETIME
		CompatIDsOffset as DWORD
		CompatIDsLength as DWORD
		Reserved as ULONG_PTR
		SectionName as wstring * 256
		InfFileName as wstring * 260
		DrvDescription as wstring * 256
		HardwareID as wstring * 1
	end type
#else
	type _SP_DRVINFO_DETAIL_DATA_W field = 1
		cbSize as DWORD
		InfDate as FILETIME
		CompatIDsOffset as DWORD
		CompatIDsLength as DWORD
		Reserved as ULONG_PTR
		SectionName as wstring * 256
		InfFileName as wstring * 260
		DrvDescription as wstring * 256
		HardwareID as wstring * 1
	end type
#endif

type SP_DRVINFO_DETAIL_DATA_W as _SP_DRVINFO_DETAIL_DATA_W
type PSP_DRVINFO_DETAIL_DATA_W as _SP_DRVINFO_DETAIL_DATA_W ptr

#ifdef UNICODE
	type SP_DRVINFO_DETAIL_DATA as SP_DRVINFO_DETAIL_DATA_W
	type PSP_DRVINFO_DETAIL_DATA as PSP_DRVINFO_DETAIL_DATA_W
#else
	type SP_DRVINFO_DETAIL_DATA as SP_DRVINFO_DETAIL_DATA_A
	type PSP_DRVINFO_DETAIL_DATA as PSP_DRVINFO_DETAIL_DATA_A
#endif

#ifdef __FB_64BIT__
	type _SP_DRVINSTALL_PARAMS
		cbSize as DWORD
		Rank as DWORD
		Flags as DWORD
		PrivateData as DWORD_PTR
		Reserved as DWORD
	end type
#else
	type _SP_DRVINSTALL_PARAMS field = 1
		cbSize as DWORD
		Rank as DWORD
		Flags as DWORD
		PrivateData as DWORD_PTR
		Reserved as DWORD
	end type
#endif

type SP_DRVINSTALL_PARAMS as _SP_DRVINSTALL_PARAMS
type PSP_DRVINSTALL_PARAMS as _SP_DRVINSTALL_PARAMS ptr
const DNF_DUPDESC = &h00000001
const DNF_OLDDRIVER = &h00000002
const DNF_EXCLUDEFROMLIST = &h00000004
const DNF_NODRIVER = &h00000008
const DNF_LEGACYINF = &h00000010
const DNF_CLASS_DRIVER = &h00000020
const DNF_COMPATIBLE_DRIVER = &h00000040
const DNF_INET_DRIVER = &h00000080
const DNF_UNUSED1 = &h00000100
const DNF_INDEXED_DRIVER = &h00000200
const DNF_OLD_INET_DRIVER = &h00000400
const DNF_BAD_DRIVER = &h00000800
const DNF_DUPPROVIDER = &h00001000
const DNF_INF_IS_SIGNED = &h00002000
const DNF_OEM_F6_INF = &h00004000
const DNF_DUPDRIVERVER = &h00008000
const DNF_BASIC_DRIVER = &h00010000
const DNF_AUTHENTICODE_SIGNED = &h00020000
const DRIVER_HARDWAREID_RANK = &h00000FFF
const DRIVER_COMPATID_RANK = &h00003FFF
const DRIVER_UNTRUSTED_RANK = &h00008000
const DRIVER_UNTRUSTED_HARDWAREID_RANK = &h00008FFF
const DRIVER_UNTRUSTED_COMPATID_RANK = &h0000BFFF
const DRIVER_W9X_SUSPECT_RANK = &h0000C000
const DRIVER_W9X_SUSPECT_HARDWAREID_RANK = &h0000CFFF
const DRIVER_W9X_SUSPECT_COMPATID_RANK = &h0000FFFF
type PSP_DETSIG_CMPPROC as function(byval DeviceInfoSet as HDEVINFO, byval NewDeviceData as PSP_DEVINFO_DATA, byval ExistingDeviceData as PSP_DEVINFO_DATA, byval CompareContext as PVOID) as DWORD

#ifdef __FB_64BIT__
	type _COINSTALLER_CONTEXT_DATA
		PostProcessing as WINBOOL
		InstallResult as DWORD
		PrivateData as PVOID
	end type
#else
	type _COINSTALLER_CONTEXT_DATA field = 1
		PostProcessing as WINBOOL
		InstallResult as DWORD
		PrivateData as PVOID
	end type
#endif

type COINSTALLER_CONTEXT_DATA as _COINSTALLER_CONTEXT_DATA
type PCOINSTALLER_CONTEXT_DATA as _COINSTALLER_CONTEXT_DATA ptr

#ifdef __FB_64BIT__
	type _SP_CLASSIMAGELIST_DATA
		cbSize as DWORD
		ImageList as HIMAGELIST
		Reserved as ULONG_PTR
	end type
#else
	type _SP_CLASSIMAGELIST_DATA field = 1
		cbSize as DWORD
		ImageList as HIMAGELIST
		Reserved as ULONG_PTR
	end type
#endif

type SP_CLASSIMAGELIST_DATA as _SP_CLASSIMAGELIST_DATA
type PSP_CLASSIMAGELIST_DATA as _SP_CLASSIMAGELIST_DATA ptr

#ifdef __FB_64BIT__
	type _SP_PROPSHEETPAGE_REQUEST
		cbSize as DWORD
		PageRequested as DWORD
		DeviceInfoSet as HDEVINFO
		DeviceInfoData as PSP_DEVINFO_DATA
	end type
#else
	type _SP_PROPSHEETPAGE_REQUEST field = 1
		cbSize as DWORD
		PageRequested as DWORD
		DeviceInfoSet as HDEVINFO
		DeviceInfoData as PSP_DEVINFO_DATA
	end type
#endif

type SP_PROPSHEETPAGE_REQUEST as _SP_PROPSHEETPAGE_REQUEST
type PSP_PROPSHEETPAGE_REQUEST as _SP_PROPSHEETPAGE_REQUEST ptr
const SPPSR_SELECT_DEVICE_RESOURCES = 1
const SPPSR_ENUM_BASIC_DEVICE_PROPERTIES = 2
const SPPSR_ENUM_ADV_DEVICE_PROPERTIES = 3

#ifdef __FB_64BIT__
	type _SP_BACKUP_QUEUE_PARAMS_V2_A
		cbSize as DWORD
		FullInfPath as zstring * 260
		FilenameOffset as INT_
		ReinstallInstance as zstring * 260
	end type
#else
	type _SP_BACKUP_QUEUE_PARAMS_V2_A field = 1
		cbSize as DWORD
		FullInfPath as zstring * 260
		FilenameOffset as INT_
		ReinstallInstance as zstring * 260
	end type
#endif

type SP_BACKUP_QUEUE_PARAMS_V2_A as _SP_BACKUP_QUEUE_PARAMS_V2_A
type PSP_BACKUP_QUEUE_PARAMS_V2_A as _SP_BACKUP_QUEUE_PARAMS_V2_A ptr

#ifdef __FB_64BIT__
	type _SP_BACKUP_QUEUE_PARAMS_V2_W
		cbSize as DWORD
		FullInfPath as wstring * 260
		FilenameOffset as INT_
		ReinstallInstance as wstring * 260
	end type
#else
	type _SP_BACKUP_QUEUE_PARAMS_V2_W field = 1
		cbSize as DWORD
		FullInfPath as wstring * 260
		FilenameOffset as INT_
		ReinstallInstance as wstring * 260
	end type
#endif

type SP_BACKUP_QUEUE_PARAMS_V2_W as _SP_BACKUP_QUEUE_PARAMS_V2_W
type PSP_BACKUP_QUEUE_PARAMS_V2_W as _SP_BACKUP_QUEUE_PARAMS_V2_W ptr

#ifdef __FB_64BIT__
	type _SP_BACKUP_QUEUE_PARAMS_V1_A
		cbSize as DWORD
		FullInfPath as zstring * 260
		FilenameOffset as INT_
	end type
#else
	type _SP_BACKUP_QUEUE_PARAMS_V1_A field = 1
		cbSize as DWORD
		FullInfPath as zstring * 260
		FilenameOffset as INT_
	end type
#endif

type SP_BACKUP_QUEUE_PARAMS_V1_A as _SP_BACKUP_QUEUE_PARAMS_V1_A
type PSP_BACKUP_QUEUE_PARAMS_V1_A as _SP_BACKUP_QUEUE_PARAMS_V1_A ptr

#ifdef __FB_64BIT__
	type _SP_BACKUP_QUEUE_PARAMS_V1_W
		cbSize as DWORD
		FullInfPath as wstring * 260
		FilenameOffset as INT_
	end type
#else
	type _SP_BACKUP_QUEUE_PARAMS_V1_W field = 1
		cbSize as DWORD
		FullInfPath as wstring * 260
		FilenameOffset as INT_
	end type
#endif

type SP_BACKUP_QUEUE_PARAMS_V1_W as _SP_BACKUP_QUEUE_PARAMS_V1_W
type PSP_BACKUP_QUEUE_PARAMS_V1_W as _SP_BACKUP_QUEUE_PARAMS_V1_W ptr

#ifdef UNICODE
	type SP_BACKUP_QUEUE_PARAMS_V1 as SP_BACKUP_QUEUE_PARAMS_V1_W
	type PSP_BACKUP_QUEUE_PARAMS_V1 as PSP_BACKUP_QUEUE_PARAMS_V1_W
	type SP_BACKUP_QUEUE_PARAMS_V2 as SP_BACKUP_QUEUE_PARAMS_V2_W
	type PSP_BACKUP_QUEUE_PARAMS_V2 as PSP_BACKUP_QUEUE_PARAMS_V2_W
#else
	type SP_BACKUP_QUEUE_PARAMS_V1 as SP_BACKUP_QUEUE_PARAMS_V1_A
	type PSP_BACKUP_QUEUE_PARAMS_V1 as PSP_BACKUP_QUEUE_PARAMS_V1_A
	type SP_BACKUP_QUEUE_PARAMS_V2 as SP_BACKUP_QUEUE_PARAMS_V2_A
	type PSP_BACKUP_QUEUE_PARAMS_V2 as PSP_BACKUP_QUEUE_PARAMS_V2_A
#endif

type SP_BACKUP_QUEUE_PARAMS_A as SP_BACKUP_QUEUE_PARAMS_V2_A
type PSP_BACKUP_QUEUE_PARAMS_A as PSP_BACKUP_QUEUE_PARAMS_V2_A
type SP_BACKUP_QUEUE_PARAMS_W as SP_BACKUP_QUEUE_PARAMS_V2_W
type PSP_BACKUP_QUEUE_PARAMS_W as PSP_BACKUP_QUEUE_PARAMS_V2_W
type SP_BACKUP_QUEUE_PARAMS as SP_BACKUP_QUEUE_PARAMS_V2
type PSP_BACKUP_QUEUE_PARAMS as PSP_BACKUP_QUEUE_PARAMS_V2

const ERROR_EXPECTED_SECTION_NAME = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or 0
const ERROR_BAD_SECTION_NAME_LINE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or 1
const ERROR_SECTION_NAME_TOO_LONG = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or 2
const ERROR_GENERAL_SYNTAX = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or 3
const ERROR_WRONG_INF_STYLE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h100
const ERROR_SECTION_NOT_FOUND = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h101
const ERROR_LINE_NOT_FOUND = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h102
const ERROR_NO_BACKUP = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h103
const ERROR_NO_ASSOCIATED_CLASS = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h200
const ERROR_CLASS_MISMATCH = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h201
const ERROR_DUPLICATE_FOUND = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h202
const ERROR_NO_DRIVER_SELECTED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h203
const ERROR_KEY_DOES_NOT_EXIST = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h204
const ERROR_INVALID_DEVINST_NAME = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h205
const ERROR_INVALID_CLASS = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h206
const ERROR_DEVINST_ALREADY_EXISTS = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h207
const ERROR_DEVINFO_NOT_REGISTERED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h208
const ERROR_INVALID_REG_PROPERTY = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h209
const ERROR_NO_INF = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h20A
const ERROR_NO_SUCH_DEVINST = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h20B
const ERROR_CANT_LOAD_CLASS_ICON = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h20C
const ERROR_INVALID_CLASS_INSTALLER = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h20D
const ERROR_DI_DO_DEFAULT = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h20E
const ERROR_DI_NOFILECOPY = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h20F
const ERROR_INVALID_HWPROFILE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h210
const ERROR_NO_DEVICE_SELECTED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h211
const ERROR_DEVINFO_LIST_LOCKED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h212
const ERROR_DEVINFO_DATA_LOCKED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h213
const ERROR_DI_BAD_PATH = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h214
const ERROR_NO_CLASSINSTALL_PARAMS = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h215
const ERROR_FILEQUEUE_LOCKED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h216
const ERROR_BAD_SERVICE_INSTALLSECT = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h217
const ERROR_NO_CLASS_DRIVER_LIST = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h218
const ERROR_NO_ASSOCIATED_SERVICE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h219
const ERROR_NO_DEFAULT_DEVICE_INTERFACE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h21A
const ERROR_DEVICE_INTERFACE_ACTIVE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h21B
const ERROR_DEVICE_INTERFACE_REMOVED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h21C
const ERROR_BAD_INTERFACE_INSTALLSECT = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h21D
const ERROR_NO_SUCH_INTERFACE_CLASS = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h21E
const ERROR_INVALID_REFERENCE_STRING = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h21F
const ERROR_INVALID_MACHINENAME = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h220
const ERROR_REMOTE_COMM_FAILURE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h221
const ERROR_MACHINE_UNAVAILABLE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h222
const ERROR_NO_CONFIGMGR_SERVICES = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h223
const ERROR_INVALID_PROPPAGE_PROVIDER = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h224
const ERROR_NO_SUCH_DEVICE_INTERFACE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h225
const ERROR_DI_POSTPROCESSING_REQUIRED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h226
const ERROR_INVALID_COINSTALLER = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h227
const ERROR_NO_COMPAT_DRIVERS = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h228
const ERROR_NO_DEVICE_ICON = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h229
const ERROR_INVALID_INF_LOGCONFIG = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h22A
const ERROR_DI_DONT_INSTALL = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h22B
const ERROR_INVALID_FILTER_DRIVER = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h22C
const ERROR_NON_WINDOWS_NT_DRIVER = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h22D
const ERROR_NON_WINDOWS_DRIVER = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h22E
const ERROR_NO_CATALOG_FOR_OEM_INF = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h22F
const ERROR_DEVINSTALL_QUEUE_NONNATIVE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h230
const ERROR_NOT_DISABLEABLE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h231
const ERROR_CANT_REMOVE_DEVINST = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h232
const ERROR_INVALID_TARGET = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h233
const ERROR_DRIVER_NONNATIVE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h234
const ERROR_IN_WOW64 = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h235
const ERROR_SET_SYSTEM_RESTORE_POINT = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h236
const ERROR_INCORRECTLY_COPIED_INF = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h237
const ERROR_SCE_DISABLED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h238
const ERROR_UNKNOWN_EXCEPTION = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h239
const ERROR_PNP_REGISTRY_ERROR = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h23A
const ERROR_REMOTE_REQUEST_UNSUPPORTED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h23B
const ERROR_NOT_AN_INSTALLED_OEM_INF = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h23C
const ERROR_INF_IN_USE_BY_DEVICES = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h23D
const ERROR_DI_FUNCTION_OBSOLETE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h23E
const ERROR_NO_AUTHENTICODE_CATALOG = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h23F
const ERROR_AUTHENTICODE_DISALLOWED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h240
const ERROR_AUTHENTICODE_TRUSTED_PUBLISHER = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h241
const ERROR_AUTHENTICODE_TRUST_NOT_ESTABLISHED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h242
const ERROR_AUTHENTICODE_PUBLISHER_NOT_TRUSTED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h243
const ERROR_SIGNATURE_OSATTRIBUTE_MISMATCH = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h244
const ERROR_ONLY_VALIDATE_VIA_AUTHENTICODE = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h245
const ERROR_UNRECOVERABLE_STACK_OVERFLOW = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h300
const EXCEPTION_SPAPI_UNRECOVERABLE_STACK_OVERFLOW = ERROR_UNRECOVERABLE_STACK_OVERFLOW
const ERROR_NO_DEFAULT_INTERFACE_DEVICE = ERROR_NO_DEFAULT_DEVICE_INTERFACE
const ERROR_INTERFACE_DEVICE_ACTIVE = ERROR_DEVICE_INTERFACE_ACTIVE
const ERROR_INTERFACE_DEVICE_REMOVED = ERROR_DEVICE_INTERFACE_REMOVED
const ERROR_NO_SUCH_INTERFACE_DEVICE = ERROR_NO_SUCH_DEVICE_INTERFACE
const ERROR_NOT_INSTALLED = (APPLICATION_ERROR_MASK or ERROR_SEVERITY_ERROR) or &h1000
declare function SetupGetInfInformationA(byval InfSpec as LPCVOID, byval SearchControl as DWORD, byval ReturnBuffer as PSP_INF_INFORMATION, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
declare function SetupGetInfInformationW(byval InfSpec as LPCVOID, byval SearchControl as DWORD, byval ReturnBuffer as PSP_INF_INFORMATION, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
const INFINFO_INF_SPEC_IS_HINF = 1
const INFINFO_INF_NAME_IS_ABSOLUTE = 2
const INFINFO_DEFAULT_SEARCH = 3
const INFINFO_REVERSE_DEFAULT_SEARCH = 4
const INFINFO_INF_PATH_LIST_SEARCH = 5

#ifdef UNICODE
	declare function SetupGetInfInformation alias "SetupGetInfInformationW"(byval InfSpec as LPCVOID, byval SearchControl as DWORD, byval ReturnBuffer as PSP_INF_INFORMATION, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#else
	declare function SetupGetInfInformation alias "SetupGetInfInformationA"(byval InfSpec as LPCVOID, byval SearchControl as DWORD, byval ReturnBuffer as PSP_INF_INFORMATION, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

const SRCLIST_TEMPORARY = &h00000001
const SRCLIST_NOBROWSE = &h00000002
const SRCLIST_SYSTEM = &h00000010
const SRCLIST_USER = &h00000020
const SRCLIST_SYSIFADMIN = &h00000040
const SRCLIST_SUBDIRS = &h00000100
const SRCLIST_APPEND = &h00000200
const SRCLIST_NOSTRIPPLATFORM = &h00000400
const FILE_COMPRESSION_NONE = 0
const FILE_COMPRESSION_WINLZA = 1
const FILE_COMPRESSION_MSZIP = 2
const FILE_COMPRESSION_NTCAB = 3
declare function SetupQueryInfFileInformationA(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupQueryInfFileInformation alias "SetupQueryInfFileInformationA"(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupQueryInfFileInformationW(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupQueryInfFileInformation alias "SetupQueryInfFileInformationW"(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupQueryInfOriginalFileInformationA(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval OriginalFileInfo as PSP_ORIGINAL_FILE_INFO_A) as WINBOOL

#ifndef UNICODE
	declare function SetupQueryInfOriginalFileInformation alias "SetupQueryInfOriginalFileInformationA"(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval OriginalFileInfo as PSP_ORIGINAL_FILE_INFO_A) as WINBOOL
#endif

declare function SetupQueryInfOriginalFileInformationW(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval OriginalFileInfo as PSP_ORIGINAL_FILE_INFO_W) as WINBOOL

#ifdef UNICODE
	declare function SetupQueryInfOriginalFileInformation alias "SetupQueryInfOriginalFileInformationW"(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval OriginalFileInfo as PSP_ORIGINAL_FILE_INFO_W) as WINBOOL
#endif

declare function SetupQueryInfVersionInformationA(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval Key as PCSTR, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupQueryInfVersionInformation alias "SetupQueryInfVersionInformationA"(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval Key as PCSTR, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupQueryInfVersionInformationW(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval Key as PCWSTR, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupQueryInfVersionInformation alias "SetupQueryInfVersionInformationW"(byval InfInformation as PSP_INF_INFORMATION, byval InfIndex as UINT, byval Key as PCWSTR, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetInfFileListA(byval DirectoryPath as PCSTR, byval InfStyle as DWORD, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupGetInfFileList alias "SetupGetInfFileListA"(byval DirectoryPath as PCSTR, byval InfStyle as DWORD, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetInfFileListW(byval DirectoryPath as PCWSTR, byval InfStyle as DWORD, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupGetInfFileList alias "SetupGetInfFileListW"(byval DirectoryPath as PCWSTR, byval InfStyle as DWORD, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupOpenInfFileW(byval FileName as PCWSTR, byval InfClass as PCWSTR, byval InfStyle as DWORD, byval ErrorLine as PUINT) as HINF

#ifdef UNICODE
	declare function SetupOpenInfFile alias "SetupOpenInfFileW"(byval FileName as PCWSTR, byval InfClass as PCWSTR, byval InfStyle as DWORD, byval ErrorLine as PUINT) as HINF
#endif

declare function SetupOpenInfFileA(byval FileName as PCSTR, byval InfClass as PCSTR, byval InfStyle as DWORD, byval ErrorLine as PUINT) as HINF

#ifndef UNICODE
	declare function SetupOpenInfFile alias "SetupOpenInfFileA"(byval FileName as PCSTR, byval InfClass as PCSTR, byval InfStyle as DWORD, byval ErrorLine as PUINT) as HINF
#endif

declare function SetupOpenMasterInf() as HINF
declare function SetupOpenAppendInfFileW(byval FileName as PCWSTR, byval InfHandle as HINF, byval ErrorLine as PUINT) as WINBOOL

#ifdef UNICODE
	declare function SetupOpenAppendInfFile alias "SetupOpenAppendInfFileW"(byval FileName as PCWSTR, byval InfHandle as HINF, byval ErrorLine as PUINT) as WINBOOL
#endif

declare function SetupOpenAppendInfFileA(byval FileName as PCSTR, byval InfHandle as HINF, byval ErrorLine as PUINT) as WINBOOL

#ifndef UNICODE
	declare function SetupOpenAppendInfFile alias "SetupOpenAppendInfFileA"(byval FileName as PCSTR, byval InfHandle as HINF, byval ErrorLine as PUINT) as WINBOOL
#endif

declare sub SetupCloseInfFile(byval InfHandle as HINF)
declare function SetupFindFirstLineA(byval InfHandle as HINF, byval Section as PCSTR, byval Key as PCSTR, byval Context as PINFCONTEXT) as WINBOOL

#ifndef UNICODE
	declare function SetupFindFirstLine alias "SetupFindFirstLineA"(byval InfHandle as HINF, byval Section as PCSTR, byval Key as PCSTR, byval Context as PINFCONTEXT) as WINBOOL
#endif

declare function SetupFindFirstLineW(byval InfHandle as HINF, byval Section as PCWSTR, byval Key as PCWSTR, byval Context as PINFCONTEXT) as WINBOOL

#ifdef UNICODE
	declare function SetupFindFirstLine alias "SetupFindFirstLineW"(byval InfHandle as HINF, byval Section as PCWSTR, byval Key as PCWSTR, byval Context as PINFCONTEXT) as WINBOOL
#endif

declare function SetupFindNextLine(byval ContextIn as PINFCONTEXT, byval ContextOut as PINFCONTEXT) as WINBOOL
declare function SetupFindNextMatchLineA(byval ContextIn as PINFCONTEXT, byval Key as PCSTR, byval ContextOut as PINFCONTEXT) as WINBOOL

#ifndef UNICODE
	declare function SetupFindNextMatchLine alias "SetupFindNextMatchLineA"(byval ContextIn as PINFCONTEXT, byval Key as PCSTR, byval ContextOut as PINFCONTEXT) as WINBOOL
#endif

declare function SetupFindNextMatchLineW(byval ContextIn as PINFCONTEXT, byval Key as PCWSTR, byval ContextOut as PINFCONTEXT) as WINBOOL

#ifdef UNICODE
	declare function SetupFindNextMatchLine alias "SetupFindNextMatchLineW"(byval ContextIn as PINFCONTEXT, byval Key as PCWSTR, byval ContextOut as PINFCONTEXT) as WINBOOL
#endif

declare function SetupGetLineByIndexA(byval InfHandle as HINF, byval Section as PCSTR, byval Index as DWORD, byval Context as PINFCONTEXT) as WINBOOL

#ifndef UNICODE
	declare function SetupGetLineByIndex alias "SetupGetLineByIndexA"(byval InfHandle as HINF, byval Section as PCSTR, byval Index as DWORD, byval Context as PINFCONTEXT) as WINBOOL
#endif

declare function SetupGetLineByIndexW(byval InfHandle as HINF, byval Section as PCWSTR, byval Index as DWORD, byval Context as PINFCONTEXT) as WINBOOL

#ifdef UNICODE
	declare function SetupGetLineByIndex alias "SetupGetLineByIndexW"(byval InfHandle as HINF, byval Section as PCWSTR, byval Index as DWORD, byval Context as PINFCONTEXT) as WINBOOL
#endif

declare function SetupGetLineCountA(byval InfHandle as HINF, byval Section as PCSTR) as LONG

#ifndef UNICODE
	declare function SetupGetLineCount alias "SetupGetLineCountA"(byval InfHandle as HINF, byval Section as PCSTR) as LONG
#endif

declare function SetupGetLineCountW(byval InfHandle as HINF, byval Section as PCWSTR) as LONG

#ifdef UNICODE
	declare function SetupGetLineCount alias "SetupGetLineCountW"(byval InfHandle as HINF, byval Section as PCWSTR) as LONG
#endif

declare function SetupGetLineTextA(byval Context as PINFCONTEXT, byval InfHandle as HINF, byval Section as PCSTR, byval Key as PCSTR, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupGetLineText alias "SetupGetLineTextA"(byval Context as PINFCONTEXT, byval InfHandle as HINF, byval Section as PCSTR, byval Key as PCSTR, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetLineTextW(byval Context as PINFCONTEXT, byval InfHandle as HINF, byval Section as PCWSTR, byval Key as PCWSTR, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupGetLineText alias "SetupGetLineTextW"(byval Context as PINFCONTEXT, byval InfHandle as HINF, byval Section as PCWSTR, byval Key as PCWSTR, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetFieldCount(byval Context as PINFCONTEXT) as DWORD
declare function SetupGetStringFieldA(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupGetStringField alias "SetupGetStringFieldA"(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetStringFieldW(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupGetStringField alias "SetupGetStringFieldW"(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetIntField(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval IntegerValue as PINT) as WINBOOL
declare function SetupGetMultiSzFieldA(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupGetMultiSzField alias "SetupGetMultiSzFieldA"(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as LPDWORD) as WINBOOL
#endif

declare function SetupGetMultiSzFieldW(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupGetMultiSzField alias "SetupGetMultiSzFieldW"(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as LPDWORD) as WINBOOL
#endif

declare function SetupGetBinaryField(byval Context as PINFCONTEXT, byval FieldIndex as DWORD, byval ReturnBuffer as PBYTE, byval ReturnBufferSize as DWORD, byval RequiredSize as LPDWORD) as WINBOOL
declare function SetupGetFileCompressionInfoA(byval SourceFileName as PCSTR, byval ActualSourceFileName as PSTR ptr, byval SourceFileSize as PDWORD, byval TargetFileSize as PDWORD, byval CompressionType as PUINT) as DWORD

#ifndef UNICODE
	declare function SetupGetFileCompressionInfo alias "SetupGetFileCompressionInfoA"(byval SourceFileName as PCSTR, byval ActualSourceFileName as PSTR ptr, byval SourceFileSize as PDWORD, byval TargetFileSize as PDWORD, byval CompressionType as PUINT) as DWORD
#endif

declare function SetupGetFileCompressionInfoW(byval SourceFileName as PCWSTR, byval ActualSourceFileName as PWSTR ptr, byval SourceFileSize as PDWORD, byval TargetFileSize as PDWORD, byval CompressionType as PUINT) as DWORD

#ifdef UNICODE
	declare function SetupGetFileCompressionInfo alias "SetupGetFileCompressionInfoW"(byval SourceFileName as PCWSTR, byval ActualSourceFileName as PWSTR ptr, byval SourceFileSize as PDWORD, byval TargetFileSize as PDWORD, byval CompressionType as PUINT) as DWORD
#endif

declare function SetupGetFileCompressionInfoExA(byval SourceFileName as PCSTR, byval ActualSourceFileNameBuffer as PSTR, byval ActualSourceFileNameBufferLen as DWORD, byval RequiredBufferLen as PDWORD, byval SourceFileSize as PDWORD, byval TargetFileSize as PDWORD, byval CompressionType as PUINT) as WINBOOL

#ifndef UNICODE
	declare function SetupGetFileCompressionInfoEx alias "SetupGetFileCompressionInfoExA"(byval SourceFileName as PCSTR, byval ActualSourceFileNameBuffer as PSTR, byval ActualSourceFileNameBufferLen as DWORD, byval RequiredBufferLen as PDWORD, byval SourceFileSize as PDWORD, byval TargetFileSize as PDWORD, byval CompressionType as PUINT) as WINBOOL
#endif

declare function SetupGetFileCompressionInfoExW(byval SourceFileName as PCWSTR, byval ActualSourceFileNameBuffer as PWSTR, byval ActualSourceFileNameBufferLen as DWORD, byval RequiredBufferLen as PDWORD, byval SourceFileSize as PDWORD, byval TargetFileSize as PDWORD, byval CompressionType as PUINT) as WINBOOL

#ifdef UNICODE
	declare function SetupGetFileCompressionInfoEx alias "SetupGetFileCompressionInfoExW"(byval SourceFileName as PCWSTR, byval ActualSourceFileNameBuffer as PWSTR, byval ActualSourceFileNameBufferLen as DWORD, byval RequiredBufferLen as PDWORD, byval SourceFileSize as PDWORD, byval TargetFileSize as PDWORD, byval CompressionType as PUINT) as WINBOOL
#endif

declare function SetupDecompressOrCopyFileA(byval SourceFileName as PCSTR, byval TargetFileName as PCSTR, byval CompressionType as PUINT) as DWORD

#ifndef UNICODE
	declare function SetupDecompressOrCopyFile alias "SetupDecompressOrCopyFileA"(byval SourceFileName as PCSTR, byval TargetFileName as PCSTR, byval CompressionType as PUINT) as DWORD
#endif

declare function SetupDecompressOrCopyFileW(byval SourceFileName as PCWSTR, byval TargetFileName as PCWSTR, byval CompressionType as PUINT) as DWORD

#ifdef UNICODE
	declare function SetupDecompressOrCopyFile alias "SetupDecompressOrCopyFileW"(byval SourceFileName as PCWSTR, byval TargetFileName as PCWSTR, byval CompressionType as PUINT) as DWORD
#endif

declare function SetupGetSourceFileLocationA(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval FileName as PCSTR, byval SourceId as PUINT, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupGetSourceFileLocation alias "SetupGetSourceFileLocationA"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval FileName as PCSTR, byval SourceId as PUINT, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetSourceFileLocationW(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval FileName as PCWSTR, byval SourceId as PUINT, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupGetSourceFileLocation alias "SetupGetSourceFileLocationW"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval FileName as PCWSTR, byval SourceId as PUINT, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetSourceFileSizeA(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval FileName as PCSTR, byval Section as PCSTR, byval FileSize as PDWORD, byval RoundingFactor as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupGetSourceFileSize alias "SetupGetSourceFileSizeA"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval FileName as PCSTR, byval Section as PCSTR, byval FileSize as PDWORD, byval RoundingFactor as UINT) as WINBOOL
#endif

declare function SetupGetSourceFileSizeW(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval FileName as PCWSTR, byval Section as PCWSTR, byval FileSize as PDWORD, byval RoundingFactor as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupGetSourceFileSize alias "SetupGetSourceFileSizeW"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval FileName as PCWSTR, byval Section as PCWSTR, byval FileSize as PDWORD, byval RoundingFactor as UINT) as WINBOOL
#endif

declare function SetupGetTargetPathA(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval Section as PCSTR, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupGetTargetPath alias "SetupGetTargetPathA"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval Section as PCSTR, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetTargetPathW(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval Section as PCWSTR, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupGetTargetPath alias "SetupGetTargetPathW"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval Section as PCWSTR, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupSetSourceListA(byval Flags as DWORD, byval SourceList as PCSTR ptr, byval SourceCount as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupSetSourceList alias "SetupSetSourceListA"(byval Flags as DWORD, byval SourceList as PCSTR ptr, byval SourceCount as UINT) as WINBOOL
#endif

declare function SetupSetSourceListW(byval Flags as DWORD, byval SourceList as PCWSTR ptr, byval SourceCount as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupSetSourceList alias "SetupSetSourceListW"(byval Flags as DWORD, byval SourceList as PCWSTR ptr, byval SourceCount as UINT) as WINBOOL
#endif

declare function SetupCancelTemporarySourceList() as WINBOOL
declare function SetupAddToSourceListA(byval Flags as DWORD, byval Source as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupAddToSourceList alias "SetupAddToSourceListA"(byval Flags as DWORD, byval Source as PCSTR) as WINBOOL
#endif

declare function SetupAddToSourceListW(byval Flags as DWORD, byval Source as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupAddToSourceList alias "SetupAddToSourceListW"(byval Flags as DWORD, byval Source as PCWSTR) as WINBOOL
#endif

declare function SetupRemoveFromSourceListA(byval Flags as DWORD, byval Source as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupRemoveFromSourceList alias "SetupRemoveFromSourceListA"(byval Flags as DWORD, byval Source as PCSTR) as WINBOOL
#endif

declare function SetupRemoveFromSourceListW(byval Flags as DWORD, byval Source as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupRemoveFromSourceList alias "SetupRemoveFromSourceListW"(byval Flags as DWORD, byval Source as PCWSTR) as WINBOOL
#endif

declare function SetupQuerySourceListA(byval Flags as DWORD, byval List as PCSTR ptr ptr, byval Count as PUINT) as WINBOOL

#ifndef UNICODE
	declare function SetupQuerySourceList alias "SetupQuerySourceListA"(byval Flags as DWORD, byval List as PCSTR ptr ptr, byval Count as PUINT) as WINBOOL
#endif

declare function SetupQuerySourceListW(byval Flags as DWORD, byval List as PCWSTR ptr ptr, byval Count as PUINT) as WINBOOL

#ifdef UNICODE
	declare function SetupQuerySourceList alias "SetupQuerySourceListW"(byval Flags as DWORD, byval List as PCWSTR ptr ptr, byval Count as PUINT) as WINBOOL
#endif

declare function SetupFreeSourceListA(byval List as PCSTR ptr ptr, byval Count as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupFreeSourceList alias "SetupFreeSourceListA"(byval List as PCSTR ptr ptr, byval Count as UINT) as WINBOOL
#endif

declare function SetupFreeSourceListW(byval List as PCWSTR ptr ptr, byval Count as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupFreeSourceList alias "SetupFreeSourceListW"(byval List as PCWSTR ptr ptr, byval Count as UINT) as WINBOOL
#endif

declare function SetupPromptForDiskA(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval DiskName as PCSTR, byval PathToSource as PCSTR, byval FileSought as PCSTR, byval TagFile as PCSTR, byval DiskPromptStyle as DWORD, byval PathBuffer as PSTR, byval PathBufferSize as DWORD, byval PathRequiredSize as PDWORD) as UINT

#ifndef UNICODE
	declare function SetupPromptForDisk alias "SetupPromptForDiskA"(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval DiskName as PCSTR, byval PathToSource as PCSTR, byval FileSought as PCSTR, byval TagFile as PCSTR, byval DiskPromptStyle as DWORD, byval PathBuffer as PSTR, byval PathBufferSize as DWORD, byval PathRequiredSize as PDWORD) as UINT
#endif

declare function SetupPromptForDiskW(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval DiskName as PCWSTR, byval PathToSource as PCWSTR, byval FileSought as PCWSTR, byval TagFile as PCWSTR, byval DiskPromptStyle as DWORD, byval PathBuffer as PWSTR, byval PathBufferSize as DWORD, byval PathRequiredSize as PDWORD) as UINT

#ifdef UNICODE
	declare function SetupPromptForDisk alias "SetupPromptForDiskW"(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval DiskName as PCWSTR, byval PathToSource as PCWSTR, byval FileSought as PCWSTR, byval TagFile as PCWSTR, byval DiskPromptStyle as DWORD, byval PathBuffer as PWSTR, byval PathBufferSize as DWORD, byval PathRequiredSize as PDWORD) as UINT
#endif

declare function SetupCopyErrorA(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval DiskName as PCSTR, byval PathToSource as PCSTR, byval SourceFile as PCSTR, byval TargetPathFile as PCSTR, byval Win32ErrorCode as UINT, byval Style as DWORD, byval PathBuffer as PSTR, byval PathBufferSize as DWORD, byval PathRequiredSize as PDWORD) as UINT

#ifndef UNICODE
	declare function SetupCopyError alias "SetupCopyErrorA"(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval DiskName as PCSTR, byval PathToSource as PCSTR, byval SourceFile as PCSTR, byval TargetPathFile as PCSTR, byval Win32ErrorCode as UINT, byval Style as DWORD, byval PathBuffer as PSTR, byval PathBufferSize as DWORD, byval PathRequiredSize as PDWORD) as UINT
#endif

declare function SetupCopyErrorW(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval DiskName as PCWSTR, byval PathToSource as PCWSTR, byval SourceFile as PCWSTR, byval TargetPathFile as PCWSTR, byval Win32ErrorCode as UINT, byval Style as DWORD, byval PathBuffer as PWSTR, byval PathBufferSize as DWORD, byval PathRequiredSize as PDWORD) as UINT

#ifdef UNICODE
	declare function SetupCopyError alias "SetupCopyErrorW"(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval DiskName as PCWSTR, byval PathToSource as PCWSTR, byval SourceFile as PCWSTR, byval TargetPathFile as PCWSTR, byval Win32ErrorCode as UINT, byval Style as DWORD, byval PathBuffer as PWSTR, byval PathBufferSize as DWORD, byval PathRequiredSize as PDWORD) as UINT
#endif

declare function SetupRenameErrorA(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval SourceFile as PCSTR, byval TargetFile as PCSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT

#ifndef UNICODE
	declare function SetupRenameError alias "SetupRenameErrorA"(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval SourceFile as PCSTR, byval TargetFile as PCSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT
#endif

declare function SetupRenameErrorW(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval SourceFile as PCWSTR, byval TargetFile as PCWSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT

#ifdef UNICODE
	declare function SetupRenameError alias "SetupRenameErrorW"(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval SourceFile as PCWSTR, byval TargetFile as PCWSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT
#endif

declare function SetupDeleteErrorA(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval File as PCSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT

#ifndef UNICODE
	declare function SetupDeleteError alias "SetupDeleteErrorA"(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval File as PCSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT
#endif

declare function SetupDeleteErrorW(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval File as PCWSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT

#ifdef UNICODE
	declare function SetupDeleteError alias "SetupDeleteErrorW"(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval File as PCWSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT
#endif

declare function SetupBackupErrorA(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval SourceFile as PCSTR, byval TargetFile as PCSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT

#ifndef UNICODE
	declare function SetupBackupError alias "SetupBackupErrorA"(byval hwndParent as HWND, byval DialogTitle as PCSTR, byval SourceFile as PCSTR, byval TargetFile as PCSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT
#endif

declare function SetupBackupErrorW(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval SourceFile as PCWSTR, byval TargetFile as PCWSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT

#ifdef UNICODE
	declare function SetupBackupError alias "SetupBackupErrorW"(byval hwndParent as HWND, byval DialogTitle as PCWSTR, byval SourceFile as PCWSTR, byval TargetFile as PCWSTR, byval Win32ErrorCode as UINT, byval Style as DWORD) as UINT
#endif

const IDF_NOBROWSE = &h00000001
const IDF_NOSKIP = &h00000002
const IDF_NODETAILS = &h00000004
const IDF_NOCOMPRESSED = &h00000008
const IDF_CHECKFIRST = &h00000100
const IDF_NOBEEP = &h00000200
const IDF_NOFOREGROUND = &h00000400
const IDF_WARNIFSKIP = &h00000800
const IDF_NOREMOVABLEMEDIAPROMPT = &h00001000
const IDF_USEDISKNAMEASPROMPT = &h00002000
const IDF_OEMDISK = &h80000000
const DPROMPT_SUCCESS = 0
const DPROMPT_CANCEL = 1
const DPROMPT_SKIPFILE = 2
const DPROMPT_BUFFERTOOSMALL = 3
const DPROMPT_OUTOFMEMORY = 4
const SETDIRID_NOT_FULL_PATH = &h00000001
const SRCINFO_PATH = 1
const SRCINFO_TAGFILE = 2
const SRCINFO_DESCRIPTION = 3
const SRCINFO_FLAGS = 4
const SRCINFO_TAGFILE2 = 5
const SRC_FLAGS_CABFILE = &h0010
declare function SetupSetDirectoryIdA(byval InfHandle as HINF, byval Id as DWORD, byval Directory as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupSetDirectoryId alias "SetupSetDirectoryIdA"(byval InfHandle as HINF, byval Id as DWORD, byval Directory as PCSTR) as WINBOOL
#endif

declare function SetupSetDirectoryIdW(byval InfHandle as HINF, byval Id as DWORD, byval Directory as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupSetDirectoryId alias "SetupSetDirectoryIdW"(byval InfHandle as HINF, byval Id as DWORD, byval Directory as PCWSTR) as WINBOOL
#endif

declare function SetupSetDirectoryIdExA(byval InfHandle as HINF, byval Id as DWORD, byval Directory as PCSTR, byval Flags as DWORD, byval Reserved1 as DWORD, byval Reserved2 as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupSetDirectoryIdEx alias "SetupSetDirectoryIdExA"(byval InfHandle as HINF, byval Id as DWORD, byval Directory as PCSTR, byval Flags as DWORD, byval Reserved1 as DWORD, byval Reserved2 as PVOID) as WINBOOL
#endif

declare function SetupSetDirectoryIdExW(byval InfHandle as HINF, byval Id as DWORD, byval Directory as PCWSTR, byval Flags as DWORD, byval Reserved1 as DWORD, byval Reserved2 as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupSetDirectoryIdEx alias "SetupSetDirectoryIdExW"(byval InfHandle as HINF, byval Id as DWORD, byval Directory as PCWSTR, byval Flags as DWORD, byval Reserved1 as DWORD, byval Reserved2 as PVOID) as WINBOOL
#endif

declare function SetupGetSourceInfoA(byval InfHandle as HINF, byval SourceId as UINT, byval InfoDesired as UINT, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupGetSourceInfo alias "SetupGetSourceInfoA"(byval InfHandle as HINF, byval SourceId as UINT, byval InfoDesired as UINT, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupGetSourceInfoW(byval InfHandle as HINF, byval SourceId as UINT, byval InfoDesired as UINT, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupGetSourceInfo alias "SetupGetSourceInfoW"(byval InfHandle as HINF, byval SourceId as UINT, byval InfoDesired as UINT, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupInstallFileA(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval SourceFile as PCSTR, byval SourcePathRoot as PCSTR, byval DestinationName as PCSTR, byval CopyStyle as DWORD, byval CopyMsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupInstallFile alias "SetupInstallFileA"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval SourceFile as PCSTR, byval SourcePathRoot as PCSTR, byval DestinationName as PCSTR, byval CopyStyle as DWORD, byval CopyMsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID) as WINBOOL
#endif

declare function SetupInstallFileW(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval SourceFile as PCWSTR, byval SourcePathRoot as PCWSTR, byval DestinationName as PCWSTR, byval CopyStyle as DWORD, byval CopyMsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupInstallFile alias "SetupInstallFileW"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval SourceFile as PCWSTR, byval SourcePathRoot as PCWSTR, byval DestinationName as PCWSTR, byval CopyStyle as DWORD, byval CopyMsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID) as WINBOOL
#endif

declare function SetupInstallFileExA(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval SourceFile as PCSTR, byval SourcePathRoot as PCSTR, byval DestinationName as PCSTR, byval CopyStyle as DWORD, byval CopyMsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID, byval FileWasInUse as PBOOL) as WINBOOL

#ifndef UNICODE
	declare function SetupInstallFileEx alias "SetupInstallFileExA"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval SourceFile as PCSTR, byval SourcePathRoot as PCSTR, byval DestinationName as PCSTR, byval CopyStyle as DWORD, byval CopyMsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID, byval FileWasInUse as PBOOL) as WINBOOL
#endif

declare function SetupInstallFileExW(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval SourceFile as PCWSTR, byval SourcePathRoot as PCWSTR, byval DestinationName as PCWSTR, byval CopyStyle as DWORD, byval CopyMsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID, byval FileWasInUse as PBOOL) as WINBOOL

#ifdef UNICODE
	declare function SetupInstallFileEx alias "SetupInstallFileExW"(byval InfHandle as HINF, byval InfContext as PINFCONTEXT, byval SourceFile as PCWSTR, byval SourcePathRoot as PCWSTR, byval DestinationName as PCWSTR, byval CopyStyle as DWORD, byval CopyMsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID, byval FileWasInUse as PBOOL) as WINBOOL
#endif

const SP_COPY_DELETESOURCE = &h0000001
const SP_COPY_REPLACEONLY = &h0000002
const SP_COPY_NEWER = &h0000004
const SP_COPY_NEWER_OR_SAME = SP_COPY_NEWER
const SP_COPY_NOOVERWRITE = &h0000008
const SP_COPY_NODECOMP = &h0000010
const SP_COPY_LANGUAGEAWARE = &h0000020
const SP_COPY_SOURCE_ABSOLUTE = &h0000040
const SP_COPY_SOURCEPATH_ABSOLUTE = &h0000080
const SP_COPY_IN_USE_NEEDS_REBOOT = &h0000100
const SP_COPY_FORCE_IN_USE = &h0000200
const SP_COPY_NOSKIP = &h0000400
const SP_FLAG_CABINETCONTINUATION = &h0000800
const SP_COPY_FORCE_NOOVERWRITE = &h0001000
const SP_COPY_FORCE_NEWER = &h0002000
const SP_COPY_WARNIFSKIP = &h0004000
const SP_COPY_NOBROWSE = &h0008000
const SP_COPY_NEWER_ONLY = &h0010000
const SP_COPY_SOURCE_SIS_MASTER = &h0020000
const SP_COPY_OEMINF_CATALOG_ONLY = &h0040000
const SP_COPY_REPLACE_BOOT_FILE = &h0080000
const SP_COPY_NOPRUNE = &h0100000
const SP_COPY_OEM_F6_INF = &h0200000
const SP_BACKUP_BACKUPPASS = &h00000001
const SP_BACKUP_DEMANDPASS = &h00000002
const SP_BACKUP_SPECIAL = &h00000004
const SP_BACKUP_BOOTFILE = &h00000008

declare function SetupOpenFileQueue() as HSPFILEQ
declare function SetupCloseFileQueue(byval QueueHandle as HSPFILEQ) as WINBOOL
declare function SetupSetFileQueueAlternatePlatformA(byval QueueHandle as HSPFILEQ, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval AlternateDefaultCatalogFile as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupSetFileQueueAlternatePlatform alias "SetupSetFileQueueAlternatePlatformA"(byval QueueHandle as HSPFILEQ, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval AlternateDefaultCatalogFile as PCSTR) as WINBOOL
#endif

declare function SetupSetFileQueueAlternatePlatformW(byval QueueHandle as HSPFILEQ, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval AlternateDefaultCatalogFile as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupSetFileQueueAlternatePlatform alias "SetupSetFileQueueAlternatePlatformW"(byval QueueHandle as HSPFILEQ, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval AlternateDefaultCatalogFile as PCWSTR) as WINBOOL
#endif

declare function SetupSetPlatformPathOverrideA(byval Override as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupSetPlatformPathOverride alias "SetupSetPlatformPathOverrideA"(byval Override as PCSTR) as WINBOOL
#endif

declare function SetupSetPlatformPathOverrideW(byval Override as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupSetPlatformPathOverride alias "SetupSetPlatformPathOverrideW"(byval Override as PCWSTR) as WINBOOL
#endif

declare function SetupQueueCopyA(byval QueueHandle as HSPFILEQ, byval SourceRootPath as PCSTR, byval SourcePath as PCSTR, byval SourceFilename as PCSTR, byval SourceDescription as PCSTR, byval SourceTagfile as PCSTR, byval TargetDirectory as PCSTR, byval TargetFilename as PCSTR, byval CopyStyle as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupQueueCopy alias "SetupQueueCopyA"(byval QueueHandle as HSPFILEQ, byval SourceRootPath as PCSTR, byval SourcePath as PCSTR, byval SourceFilename as PCSTR, byval SourceDescription as PCSTR, byval SourceTagfile as PCSTR, byval TargetDirectory as PCSTR, byval TargetFilename as PCSTR, byval CopyStyle as DWORD) as WINBOOL
#endif

declare function SetupQueueCopyW(byval QueueHandle as HSPFILEQ, byval SourceRootPath as PCWSTR, byval SourcePath as PCWSTR, byval SourceFilename as PCWSTR, byval SourceDescription as PCWSTR, byval SourceTagfile as PCWSTR, byval TargetDirectory as PCWSTR, byval TargetFilename as PCWSTR, byval CopyStyle as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupQueueCopy alias "SetupQueueCopyW"(byval QueueHandle as HSPFILEQ, byval SourceRootPath as PCWSTR, byval SourcePath as PCWSTR, byval SourceFilename as PCWSTR, byval SourceDescription as PCWSTR, byval SourceTagfile as PCWSTR, byval TargetDirectory as PCWSTR, byval TargetFilename as PCWSTR, byval CopyStyle as DWORD) as WINBOOL
#endif

declare function SetupQueueCopyIndirectA(byval CopyParams as PSP_FILE_COPY_PARAMS_A) as WINBOOL

#ifndef UNICODE
	declare function SetupQueueCopyIndirect alias "SetupQueueCopyIndirectA"(byval CopyParams as PSP_FILE_COPY_PARAMS_A) as WINBOOL
#endif

declare function SetupQueueCopyIndirectW(byval CopyParams as PSP_FILE_COPY_PARAMS_W) as WINBOOL

#ifdef UNICODE
	declare function SetupQueueCopyIndirect alias "SetupQueueCopyIndirectW"(byval CopyParams as PSP_FILE_COPY_PARAMS_W) as WINBOOL
#endif

declare function SetupQueueDefaultCopyA(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval SourceRootPath as PCSTR, byval SourceFilename as PCSTR, byval TargetFilename as PCSTR, byval CopyStyle as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupQueueDefaultCopy alias "SetupQueueDefaultCopyA"(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval SourceRootPath as PCSTR, byval SourceFilename as PCSTR, byval TargetFilename as PCSTR, byval CopyStyle as DWORD) as WINBOOL
#endif

declare function SetupQueueDefaultCopyW(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval SourceRootPath as PCWSTR, byval SourceFilename as PCWSTR, byval TargetFilename as PCWSTR, byval CopyStyle as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupQueueDefaultCopy alias "SetupQueueDefaultCopyW"(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval SourceRootPath as PCWSTR, byval SourceFilename as PCWSTR, byval TargetFilename as PCWSTR, byval CopyStyle as DWORD) as WINBOOL
#endif

declare function SetupQueueCopySectionA(byval QueueHandle as HSPFILEQ, byval SourceRootPath as PCSTR, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCSTR, byval CopyStyle as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupQueueCopySection alias "SetupQueueCopySectionA"(byval QueueHandle as HSPFILEQ, byval SourceRootPath as PCSTR, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCSTR, byval CopyStyle as DWORD) as WINBOOL
#endif

declare function SetupQueueCopySectionW(byval QueueHandle as HSPFILEQ, byval SourceRootPath as PCWSTR, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCWSTR, byval CopyStyle as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupQueueCopySection alias "SetupQueueCopySectionW"(byval QueueHandle as HSPFILEQ, byval SourceRootPath as PCWSTR, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCWSTR, byval CopyStyle as DWORD) as WINBOOL
#endif

declare function SetupQueueDeleteA(byval QueueHandle as HSPFILEQ, byval PathPart1 as PCSTR, byval PathPart2 as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupQueueDelete alias "SetupQueueDeleteA"(byval QueueHandle as HSPFILEQ, byval PathPart1 as PCSTR, byval PathPart2 as PCSTR) as WINBOOL
#endif

declare function SetupQueueDeleteW(byval QueueHandle as HSPFILEQ, byval PathPart1 as PCWSTR, byval PathPart2 as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupQueueDelete alias "SetupQueueDeleteW"(byval QueueHandle as HSPFILEQ, byval PathPart1 as PCWSTR, byval PathPart2 as PCWSTR) as WINBOOL
#endif

declare function SetupQueueDeleteSectionA(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupQueueDeleteSection alias "SetupQueueDeleteSectionA"(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCSTR) as WINBOOL
#endif

declare function SetupQueueDeleteSectionW(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupQueueDeleteSection alias "SetupQueueDeleteSectionW"(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCWSTR) as WINBOOL
#endif

declare function SetupQueueRenameA(byval QueueHandle as HSPFILEQ, byval SourcePath as PCSTR, byval SourceFilename as PCSTR, byval TargetPath as PCSTR, byval TargetFilename as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupQueueRename alias "SetupQueueRenameA"(byval QueueHandle as HSPFILEQ, byval SourcePath as PCSTR, byval SourceFilename as PCSTR, byval TargetPath as PCSTR, byval TargetFilename as PCSTR) as WINBOOL
#endif

declare function SetupQueueRenameW(byval QueueHandle as HSPFILEQ, byval SourcePath as PCWSTR, byval SourceFilename as PCWSTR, byval TargetPath as PCWSTR, byval TargetFilename as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupQueueRename alias "SetupQueueRenameW"(byval QueueHandle as HSPFILEQ, byval SourcePath as PCWSTR, byval SourceFilename as PCWSTR, byval TargetPath as PCWSTR, byval TargetFilename as PCWSTR) as WINBOOL
#endif

declare function SetupQueueRenameSectionA(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupQueueRenameSection alias "SetupQueueRenameSectionA"(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCSTR) as WINBOOL
#endif

declare function SetupQueueRenameSectionW(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupQueueRenameSection alias "SetupQueueRenameSectionW"(byval QueueHandle as HSPFILEQ, byval InfHandle as HINF, byval ListInfHandle as HINF, byval Section as PCWSTR) as WINBOOL
#endif

declare function SetupCommitFileQueueA(byval Owner as HWND, byval QueueHandle as HSPFILEQ, byval MsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupCommitFileQueue alias "SetupCommitFileQueueA"(byval Owner as HWND, byval QueueHandle as HSPFILEQ, byval MsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID) as WINBOOL
#endif

declare function SetupCommitFileQueueW(byval Owner as HWND, byval QueueHandle as HSPFILEQ, byval MsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupCommitFileQueue alias "SetupCommitFileQueueW"(byval Owner as HWND, byval QueueHandle as HSPFILEQ, byval MsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID) as WINBOOL
#endif

declare function SetupScanFileQueueA(byval FileQueue as HSPFILEQ, byval Flags as DWORD, byval Window as HWND, byval CallbackRoutine as PSP_FILE_CALLBACK_A, byval CallbackContext as PVOID, byval Result as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupScanFileQueue alias "SetupScanFileQueueA"(byval FileQueue as HSPFILEQ, byval Flags as DWORD, byval Window as HWND, byval CallbackRoutine as PSP_FILE_CALLBACK_A, byval CallbackContext as PVOID, byval Result as PDWORD) as WINBOOL
#endif

declare function SetupScanFileQueueW(byval FileQueue as HSPFILEQ, byval Flags as DWORD, byval Window as HWND, byval CallbackRoutine as PSP_FILE_CALLBACK_W, byval CallbackContext as PVOID, byval Result as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupScanFileQueue alias "SetupScanFileQueueW"(byval FileQueue as HSPFILEQ, byval Flags as DWORD, byval Window as HWND, byval CallbackRoutine as PSP_FILE_CALLBACK_W, byval CallbackContext as PVOID, byval Result as PDWORD) as WINBOOL
#endif

const SPQ_SCAN_FILE_PRESENCE = &h00000001
const SPQ_SCAN_FILE_VALIDITY = &h00000002
const SPQ_SCAN_USE_CALLBACK = &h00000004
const SPQ_SCAN_USE_CALLBACKEX = &h00000008
const SPQ_SCAN_INFORM_USER = &h00000010
const SPQ_SCAN_PRUNE_COPY_QUEUE = &h00000020
const SPQ_SCAN_USE_CALLBACK_SIGNERINFO = &h00000040
const SPQ_SCAN_PRUNE_DELREN = &h00000080
const SPQ_DELAYED_COPY = &h00000001

declare function SetupGetFileQueueCount(byval FileQueue as HSPFILEQ, byval SubQueueFileOp as UINT, byval NumOperations as PUINT) as WINBOOL
declare function SetupGetFileQueueFlags(byval FileQueue as HSPFILEQ, byval Flags as PDWORD) as WINBOOL
declare function SetupSetFileQueueFlags(byval FileQueue as HSPFILEQ, byval FlagMask as DWORD, byval Flags as DWORD) as WINBOOL

const SPQ_FLAG_BACKUP_AWARE = &h00000001
const SPQ_FLAG_ABORT_IF_UNSIGNED = &h00000002
const SPQ_FLAG_FILES_MODIFIED = &h00000004
const SPQ_FLAG_VALID = &h00000007
const SPOST_NONE = 0
const SPOST_PATH = 1
const SPOST_URL = 2
const SPOST_MAX = 3
declare function SetupCopyOEMInfA(byval SourceInfFileName as PCSTR, byval OEMSourceMediaLocation as PCSTR, byval OEMSourceMediaType as DWORD, byval CopyStyle as DWORD, byval DestinationInfFileName as PSTR, byval DestinationInfFileNameSize as DWORD, byval RequiredSize as PDWORD, byval DestinationInfFileNameComponent as PSTR ptr) as WINBOOL

#ifndef UNICODE
	declare function SetupCopyOEMInf alias "SetupCopyOEMInfA"(byval SourceInfFileName as PCSTR, byval OEMSourceMediaLocation as PCSTR, byval OEMSourceMediaType as DWORD, byval CopyStyle as DWORD, byval DestinationInfFileName as PSTR, byval DestinationInfFileNameSize as DWORD, byval RequiredSize as PDWORD, byval DestinationInfFileNameComponent as PSTR ptr) as WINBOOL
#endif

declare function SetupCopyOEMInfW(byval SourceInfFileName as PCWSTR, byval OEMSourceMediaLocation as PCWSTR, byval OEMSourceMediaType as DWORD, byval CopyStyle as DWORD, byval DestinationInfFileName as PWSTR, byval DestinationInfFileNameSize as DWORD, byval RequiredSize as PDWORD, byval DestinationInfFileNameComponent as PWSTR ptr) as WINBOOL

#ifdef UNICODE
	declare function SetupCopyOEMInf alias "SetupCopyOEMInfW"(byval SourceInfFileName as PCWSTR, byval OEMSourceMediaLocation as PCWSTR, byval OEMSourceMediaType as DWORD, byval CopyStyle as DWORD, byval DestinationInfFileName as PWSTR, byval DestinationInfFileNameSize as DWORD, byval RequiredSize as PDWORD, byval DestinationInfFileNameComponent as PWSTR ptr) as WINBOOL
#endif

const SUOI_FORCEDELETE = &h00000001
declare function SetupUninstallOEMInfA(byval InfFileName as PCSTR, byval Flags as DWORD, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupUninstallOEMInf alias "SetupUninstallOEMInfA"(byval InfFileName as PCSTR, byval Flags as DWORD, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupUninstallOEMInfW(byval InfFileName as PCWSTR, byval Flags as DWORD, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupUninstallOEMInf alias "SetupUninstallOEMInfW"(byval InfFileName as PCWSTR, byval Flags as DWORD, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupUninstallNewlyCopiedInfs(byval FileQueue as HSPFILEQ, byval Flags as DWORD, byval Reserved as PVOID) as WINBOOL
declare function SetupCreateDiskSpaceListA(byval Reserved1 as PVOID, byval Reserved2 as DWORD, byval Flags as UINT) as HDSKSPC

#ifndef UNICODE
	declare function SetupCreateDiskSpaceList alias "SetupCreateDiskSpaceListA"(byval Reserved1 as PVOID, byval Reserved2 as DWORD, byval Flags as UINT) as HDSKSPC
#endif

declare function SetupCreateDiskSpaceListW(byval Reserved1 as PVOID, byval Reserved2 as DWORD, byval Flags as UINT) as HDSKSPC

#ifdef UNICODE
	declare function SetupCreateDiskSpaceList alias "SetupCreateDiskSpaceListW"(byval Reserved1 as PVOID, byval Reserved2 as DWORD, byval Flags as UINT) as HDSKSPC
#endif

const SPDSL_IGNORE_DISK = &h00000001
const SPDSL_DISALLOW_NEGATIVE_ADJUST = &h00000002
declare function SetupDuplicateDiskSpaceListA(byval DiskSpace as HDSKSPC, byval Reserved1 as PVOID, byval Reserved2 as DWORD, byval Flags as UINT) as HDSKSPC

#ifndef UNICODE
	declare function SetupDuplicateDiskSpaceList alias "SetupDuplicateDiskSpaceListA"(byval DiskSpace as HDSKSPC, byval Reserved1 as PVOID, byval Reserved2 as DWORD, byval Flags as UINT) as HDSKSPC
#endif

declare function SetupDuplicateDiskSpaceListW(byval DiskSpace as HDSKSPC, byval Reserved1 as PVOID, byval Reserved2 as DWORD, byval Flags as UINT) as HDSKSPC

#ifdef UNICODE
	declare function SetupDuplicateDiskSpaceList alias "SetupDuplicateDiskSpaceListW"(byval DiskSpace as HDSKSPC, byval Reserved1 as PVOID, byval Reserved2 as DWORD, byval Flags as UINT) as HDSKSPC
#endif

declare function SetupDestroyDiskSpaceList(byval DiskSpace as HDSKSPC) as WINBOOL
declare function SetupQueryDrivesInDiskSpaceListA(byval DiskSpace as HDSKSPC, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupQueryDrivesInDiskSpaceList alias "SetupQueryDrivesInDiskSpaceListA"(byval DiskSpace as HDSKSPC, byval ReturnBuffer as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupQueryDrivesInDiskSpaceListW(byval DiskSpace as HDSKSPC, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupQueryDrivesInDiskSpaceList alias "SetupQueryDrivesInDiskSpaceListW"(byval DiskSpace as HDSKSPC, byval ReturnBuffer as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupQuerySpaceRequiredOnDriveA(byval DiskSpace as HDSKSPC, byval DriveSpec as PCSTR, byval SpaceRequired as LONGLONG ptr, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupQuerySpaceRequiredOnDrive alias "SetupQuerySpaceRequiredOnDriveA"(byval DiskSpace as HDSKSPC, byval DriveSpec as PCSTR, byval SpaceRequired as LONGLONG ptr, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupQuerySpaceRequiredOnDriveW(byval DiskSpace as HDSKSPC, byval DriveSpec as PCWSTR, byval SpaceRequired as LONGLONG ptr, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupQuerySpaceRequiredOnDrive alias "SetupQuerySpaceRequiredOnDriveW"(byval DiskSpace as HDSKSPC, byval DriveSpec as PCWSTR, byval SpaceRequired as LONGLONG ptr, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupAdjustDiskSpaceListA(byval DiskSpace as HDSKSPC, byval DriveRoot as LPCSTR, byval Amount as LONGLONG, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupAdjustDiskSpaceList alias "SetupAdjustDiskSpaceListA"(byval DiskSpace as HDSKSPC, byval DriveRoot as LPCSTR, byval Amount as LONGLONG, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupAdjustDiskSpaceListW(byval DiskSpace as HDSKSPC, byval DriveRoot as LPCWSTR, byval Amount as LONGLONG, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupAdjustDiskSpaceList alias "SetupAdjustDiskSpaceListW"(byval DiskSpace as HDSKSPC, byval DriveRoot as LPCWSTR, byval Amount as LONGLONG, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupAddToDiskSpaceListA(byval DiskSpace as HDSKSPC, byval TargetFilespec as PCSTR, byval FileSize as LONGLONG, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupAddToDiskSpaceList alias "SetupAddToDiskSpaceListA"(byval DiskSpace as HDSKSPC, byval TargetFilespec as PCSTR, byval FileSize as LONGLONG, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupAddToDiskSpaceListW(byval DiskSpace as HDSKSPC, byval TargetFilespec as PCWSTR, byval FileSize as LONGLONG, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupAddToDiskSpaceList alias "SetupAddToDiskSpaceListW"(byval DiskSpace as HDSKSPC, byval TargetFilespec as PCWSTR, byval FileSize as LONGLONG, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupAddSectionToDiskSpaceListA(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval ListInfHandle as HINF, byval SectionName as PCSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupAddSectionToDiskSpaceList alias "SetupAddSectionToDiskSpaceListA"(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval ListInfHandle as HINF, byval SectionName as PCSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupAddSectionToDiskSpaceListW(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval ListInfHandle as HINF, byval SectionName as PCWSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupAddSectionToDiskSpaceList alias "SetupAddSectionToDiskSpaceListW"(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval ListInfHandle as HINF, byval SectionName as PCWSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupAddInstallSectionToDiskSpaceListA(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval SectionName as PCSTR, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupAddInstallSectionToDiskSpaceList alias "SetupAddInstallSectionToDiskSpaceListA"(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval SectionName as PCSTR, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupAddInstallSectionToDiskSpaceListW(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval SectionName as PCWSTR, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupAddInstallSectionToDiskSpaceList alias "SetupAddInstallSectionToDiskSpaceListW"(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval SectionName as PCWSTR, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupRemoveFromDiskSpaceListA(byval DiskSpace as HDSKSPC, byval TargetFilespec as PCSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupRemoveFromDiskSpaceList alias "SetupRemoveFromDiskSpaceListA"(byval DiskSpace as HDSKSPC, byval TargetFilespec as PCSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupRemoveFromDiskSpaceListW(byval DiskSpace as HDSKSPC, byval TargetFilespec as PCWSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupRemoveFromDiskSpaceList alias "SetupRemoveFromDiskSpaceListW"(byval DiskSpace as HDSKSPC, byval TargetFilespec as PCWSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupRemoveSectionFromDiskSpaceListA(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval ListInfHandle as HINF, byval SectionName as PCSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupRemoveSectionFromDiskSpaceList alias "SetupRemoveSectionFromDiskSpaceListA"(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval ListInfHandle as HINF, byval SectionName as PCSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupRemoveSectionFromDiskSpaceListW(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval ListInfHandle as HINF, byval SectionName as PCWSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupRemoveSectionFromDiskSpaceList alias "SetupRemoveSectionFromDiskSpaceListW"(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval ListInfHandle as HINF, byval SectionName as PCWSTR, byval Operation as UINT, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupRemoveInstallSectionFromDiskSpaceListA(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval SectionName as PCSTR, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupRemoveInstallSectionFromDiskSpaceList alias "SetupRemoveInstallSectionFromDiskSpaceListA"(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval SectionName as PCSTR, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupRemoveInstallSectionFromDiskSpaceListW(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval SectionName as PCWSTR, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupRemoveInstallSectionFromDiskSpaceList alias "SetupRemoveInstallSectionFromDiskSpaceListW"(byval DiskSpace as HDSKSPC, byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval SectionName as PCWSTR, byval Reserved1 as PVOID, byval Reserved2 as UINT) as WINBOOL
#endif

declare function SetupIterateCabinetA(byval CabinetFile as PCSTR, byval Reserved as DWORD, byval MsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupIterateCabinet alias "SetupIterateCabinetA"(byval CabinetFile as PCSTR, byval Reserved as DWORD, byval MsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID) as WINBOOL
#endif

declare function SetupIterateCabinetW(byval CabinetFile as PCWSTR, byval Reserved as DWORD, byval MsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupIterateCabinet alias "SetupIterateCabinetW"(byval CabinetFile as PCWSTR, byval Reserved as DWORD, byval MsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID) as WINBOOL
#endif

declare function SetupPromptReboot(byval FileQueue as HSPFILEQ, byval Owner as HWND, byval ScanOnly as WINBOOL) as INT_
const SPFILEQ_FILE_IN_USE = &h00000001
const SPFILEQ_REBOOT_RECOMMENDED = &h00000002
const SPFILEQ_REBOOT_IN_PROGRESS = &h00000004

declare function SetupInitDefaultQueueCallback(byval OwnerWindow as HWND) as PVOID
declare function SetupInitDefaultQueueCallbackEx(byval OwnerWindow as HWND, byval AlternateProgressWindow as HWND, byval ProgressMessage as UINT, byval Reserved1 as DWORD, byval Reserved2 as PVOID) as PVOID
declare sub SetupTermDefaultQueueCallback(byval Context as PVOID)
declare function SetupDefaultQueueCallbackA(byval Context as PVOID, byval Notification as UINT, byval Param1 as UINT_PTR, byval Param2 as UINT_PTR) as UINT

#ifndef UNICODE
	declare function SetupDefaultQueueCallback alias "SetupDefaultQueueCallbackA"(byval Context as PVOID, byval Notification as UINT, byval Param1 as UINT_PTR, byval Param2 as UINT_PTR) as UINT
#endif

declare function SetupDefaultQueueCallbackW(byval Context as PVOID, byval Notification as UINT, byval Param1 as UINT_PTR, byval Param2 as UINT_PTR) as UINT

#ifdef UNICODE
	declare function SetupDefaultQueueCallback alias "SetupDefaultQueueCallbackW"(byval Context as PVOID, byval Notification as UINT, byval Param1 as UINT_PTR, byval Param2 as UINT_PTR) as UINT
#endif

const FLG_ADDREG_DELREG_BIT = &h00008000
const FLG_ADDREG_BINVALUETYPE = &h00000001
const FLG_ADDREG_NOCLOBBER = &h00000002
const FLG_ADDREG_DELVAL = &h00000004
const FLG_ADDREG_APPEND = &h00000008
const FLG_ADDREG_KEYONLY = &h00000010
const FLG_ADDREG_OVERWRITEONLY = &h00000020
const FLG_ADDREG_64BITKEY = &h00001000
const FLG_ADDREG_KEYONLY_COMMON = &h00002000
const FLG_ADDREG_32BITKEY = &h00004000
const FLG_ADDREG_TYPE_MASK = &hFFFF0000 or FLG_ADDREG_BINVALUETYPE
const FLG_ADDREG_TYPE_SZ = &h00000000
const FLG_ADDREG_TYPE_MULTI_SZ = &h00010000
const FLG_ADDREG_TYPE_EXPAND_SZ = &h00020000
const FLG_ADDREG_TYPE_BINARY = &h00000000 or FLG_ADDREG_BINVALUETYPE
const FLG_ADDREG_TYPE_DWORD = &h00010000 or FLG_ADDREG_BINVALUETYPE
const FLG_ADDREG_TYPE_NONE = &h00020000 or FLG_ADDREG_BINVALUETYPE
const FLG_DELREG_VALUE = &h00000000
const FLG_DELREG_TYPE_MASK = FLG_ADDREG_TYPE_MASK
const FLG_DELREG_TYPE_SZ = FLG_ADDREG_TYPE_SZ
const FLG_DELREG_TYPE_MULTI_SZ = FLG_ADDREG_TYPE_MULTI_SZ
const FLG_DELREG_TYPE_EXPAND_SZ = FLG_ADDREG_TYPE_EXPAND_SZ
const FLG_DELREG_TYPE_BINARY = FLG_ADDREG_TYPE_BINARY
const FLG_DELREG_TYPE_DWORD = FLG_ADDREG_TYPE_DWORD
const FLG_DELREG_TYPE_NONE = FLG_ADDREG_TYPE_NONE
const FLG_DELREG_64BITKEY = FLG_ADDREG_64BITKEY
const FLG_DELREG_KEYONLY_COMMON = FLG_ADDREG_KEYONLY_COMMON
const FLG_DELREG_32BITKEY = FLG_ADDREG_32BITKEY
const FLG_DELREG_OPERATION_MASK = &h000000FE
const FLG_DELREG_MULTI_SZ_DELSTRING = (FLG_DELREG_TYPE_MULTI_SZ or FLG_ADDREG_DELREG_BIT) or &h00000002
const FLG_BITREG_CLEARBITS = &h00000000
const FLG_BITREG_SETBITS = &h00000001
const FLG_BITREG_64BITKEY = &h00001000
const FLG_BITREG_32BITKEY = &h00004000
const FLG_INI2REG_64BITKEY = &h00001000
const FLG_INI2REG_32BITKEY = &h00004000
const FLG_REGSVR_DLLREGISTER = &h00000001
const FLG_REGSVR_DLLINSTALL = &h00000002
const FLG_PROFITEM_CURRENTUSER = &h00000001
const FLG_PROFITEM_DELETE = &h00000002
const FLG_PROFITEM_GROUP = &h00000004
const FLG_PROFITEM_CSIDL = &h00000008
declare function SetupInstallFromInfSectionA(byval Owner as HWND, byval InfHandle as HINF, byval SectionName as PCSTR, byval Flags as UINT, byval RelativeKeyRoot as HKEY, byval SourceRootPath as PCSTR, byval CopyFlags as UINT, byval MsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL

#ifndef UNICODE
	declare function SetupInstallFromInfSection alias "SetupInstallFromInfSectionA"(byval Owner as HWND, byval InfHandle as HINF, byval SectionName as PCSTR, byval Flags as UINT, byval RelativeKeyRoot as HKEY, byval SourceRootPath as PCSTR, byval CopyFlags as UINT, byval MsgHandler as PSP_FILE_CALLBACK_A, byval Context as PVOID, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
#endif

declare function SetupInstallFromInfSectionW(byval Owner as HWND, byval InfHandle as HINF, byval SectionName as PCWSTR, byval Flags as UINT, byval RelativeKeyRoot as HKEY, byval SourceRootPath as PCWSTR, byval CopyFlags as UINT, byval MsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL

#ifdef UNICODE
	declare function SetupInstallFromInfSection alias "SetupInstallFromInfSectionW"(byval Owner as HWND, byval InfHandle as HINF, byval SectionName as PCWSTR, byval Flags as UINT, byval RelativeKeyRoot as HKEY, byval SourceRootPath as PCWSTR, byval CopyFlags as UINT, byval MsgHandler as PSP_FILE_CALLBACK_W, byval Context as PVOID, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
#endif

const SPINST_LOGCONFIG = &h00000001
const SPINST_INIFILES = &h00000002
const SPINST_REGISTRY = &h00000004
const SPINST_INI2REG = &h00000008
const SPINST_FILES = &h00000010
const SPINST_BITREG = &h00000020
const SPINST_REGSVR = &h00000040
const SPINST_UNREGSVR = &h00000080
const SPINST_PROFILEITEMS = &h00000100
const SPINST_COPYINF = &h00000200
const SPINST_ALL = &h000003ff
const SPINST_SINGLESECTION = &h00010000
const SPINST_LOGCONFIG_IS_FORCED = &h00020000
const SPINST_LOGCONFIGS_ARE_OVERRIDES = &h00040000
const SPINST_REGISTERCALLBACKAWARE = &h00080000
declare function SetupInstallFilesFromInfSectionA(byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval FileQueue as HSPFILEQ, byval SectionName as PCSTR, byval SourceRootPath as PCSTR, byval CopyFlags as UINT) as WINBOOL

#ifndef UNICODE
	declare function SetupInstallFilesFromInfSection alias "SetupInstallFilesFromInfSectionA"(byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval FileQueue as HSPFILEQ, byval SectionName as PCSTR, byval SourceRootPath as PCSTR, byval CopyFlags as UINT) as WINBOOL
#endif

declare function SetupInstallFilesFromInfSectionW(byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval FileQueue as HSPFILEQ, byval SectionName as PCWSTR, byval SourceRootPath as PCWSTR, byval CopyFlags as UINT) as WINBOOL

#ifdef UNICODE
	declare function SetupInstallFilesFromInfSection alias "SetupInstallFilesFromInfSectionW"(byval InfHandle as HINF, byval LayoutInfHandle as HINF, byval FileQueue as HSPFILEQ, byval SectionName as PCWSTR, byval SourceRootPath as PCWSTR, byval CopyFlags as UINT) as WINBOOL
#endif

const SPSVCINST_TAGTOFRONT = &h00000001
const SPSVCINST_ASSOCSERVICE = &h00000002
const SPSVCINST_DELETEEVENTLOGENTRY = &h00000004
const SPSVCINST_NOCLOBBER_DISPLAYNAME = &h00000008
const SPSVCINST_NOCLOBBER_STARTTYPE = &h00000010
const SPSVCINST_NOCLOBBER_ERRORCONTROL = &h00000020
const SPSVCINST_NOCLOBBER_LOADORDERGROUP = &h00000040
const SPSVCINST_NOCLOBBER_DEPENDENCIES = &h00000080
const SPSVCINST_NOCLOBBER_DESCRIPTION = &h00000100
const SPSVCINST_STOPSERVICE = &h00000200
const SPSVCINST_CLOBBER_SECURITY = &h00000400
const SPFILELOG_SYSTEMLOG = &h00000001
const SPFILELOG_FORCENEW = &h00000002
const SPFILELOG_QUERYONLY = &h00000004
const SPFILELOG_OEMFILE = &h00000001
type HSPFILELOG as PVOID
declare function SetupInstallServicesFromInfSectionA(byval InfHandle as HINF, byval SectionName as PCSTR, byval Flags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupInstallServicesFromInfSection alias "SetupInstallServicesFromInfSectionA"(byval InfHandle as HINF, byval SectionName as PCSTR, byval Flags as DWORD) as WINBOOL
#endif

declare function SetupInstallServicesFromInfSectionW(byval InfHandle as HINF, byval SectionName as PCWSTR, byval Flags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupInstallServicesFromInfSection alias "SetupInstallServicesFromInfSectionW"(byval InfHandle as HINF, byval SectionName as PCWSTR, byval Flags as DWORD) as WINBOOL
#endif

declare function SetupInstallServicesFromInfSectionExA(byval InfHandle as HINF, byval SectionName as PCSTR, byval Flags as DWORD, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Reserved1 as PVOID, byval Reserved2 as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupInstallServicesFromInfSectionEx alias "SetupInstallServicesFromInfSectionExA"(byval InfHandle as HINF, byval SectionName as PCSTR, byval Flags as DWORD, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Reserved1 as PVOID, byval Reserved2 as PVOID) as WINBOOL
#endif

declare function SetupInstallServicesFromInfSectionExW(byval InfHandle as HINF, byval SectionName as PCWSTR, byval Flags as DWORD, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Reserved1 as PVOID, byval Reserved2 as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupInstallServicesFromInfSectionEx alias "SetupInstallServicesFromInfSectionExW"(byval InfHandle as HINF, byval SectionName as PCWSTR, byval Flags as DWORD, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Reserved1 as PVOID, byval Reserved2 as PVOID) as WINBOOL
#endif

declare sub InstallHinfSectionA(byval Window as HWND, byval ModuleHandle as HINSTANCE, byval CommandLine as PCSTR, byval ShowCommand as INT_)

#ifndef UNICODE
	declare sub InstallHinfSection alias "InstallHinfSectionA"(byval Window as HWND, byval ModuleHandle as HINSTANCE, byval CommandLine as PCSTR, byval ShowCommand as INT_)
#endif

declare sub InstallHinfSectionW(byval Window as HWND, byval ModuleHandle as HINSTANCE, byval CommandLine as PCWSTR, byval ShowCommand as INT_)

#ifdef UNICODE
	declare sub InstallHinfSection alias "InstallHinfSectionW"(byval Window as HWND, byval ModuleHandle as HINSTANCE, byval CommandLine as PCWSTR, byval ShowCommand as INT_)
#endif

declare function SetupInitializeFileLogA(byval LogFileName as PCSTR, byval Flags as DWORD) as HSPFILELOG

#ifndef UNICODE
	declare function SetupInitializeFileLog alias "SetupInitializeFileLogA"(byval LogFileName as PCSTR, byval Flags as DWORD) as HSPFILELOG
#endif

declare function SetupInitializeFileLogW(byval LogFileName as PCWSTR, byval Flags as DWORD) as HSPFILELOG

#ifdef UNICODE
	declare function SetupInitializeFileLog alias "SetupInitializeFileLogW"(byval LogFileName as PCWSTR, byval Flags as DWORD) as HSPFILELOG
#endif

declare function SetupTerminateFileLog(byval FileLogHandle as HSPFILELOG) as WINBOOL
declare function SetupLogFileA(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCSTR, byval SourceFilename as PCSTR, byval TargetFilename as PCSTR, byval Checksum as DWORD, byval DiskTagfile as PCSTR, byval DiskDescription as PCSTR, byval OtherInfo as PCSTR, byval Flags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupLogFile alias "SetupLogFileA"(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCSTR, byval SourceFilename as PCSTR, byval TargetFilename as PCSTR, byval Checksum as DWORD, byval DiskTagfile as PCSTR, byval DiskDescription as PCSTR, byval OtherInfo as PCSTR, byval Flags as DWORD) as WINBOOL
#endif

declare function SetupLogFileW(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCWSTR, byval SourceFilename as PCWSTR, byval TargetFilename as PCWSTR, byval Checksum as DWORD, byval DiskTagfile as PCWSTR, byval DiskDescription as PCWSTR, byval OtherInfo as PCWSTR, byval Flags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupLogFile alias "SetupLogFileW"(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCWSTR, byval SourceFilename as PCWSTR, byval TargetFilename as PCWSTR, byval Checksum as DWORD, byval DiskTagfile as PCWSTR, byval DiskDescription as PCWSTR, byval OtherInfo as PCWSTR, byval Flags as DWORD) as WINBOOL
#endif

declare function SetupRemoveFileLogEntryA(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCSTR, byval TargetFilename as PCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetupRemoveFileLogEntry alias "SetupRemoveFileLogEntryA"(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCSTR, byval TargetFilename as PCSTR) as WINBOOL
#endif

declare function SetupRemoveFileLogEntryW(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCWSTR, byval TargetFilename as PCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetupRemoveFileLogEntry alias "SetupRemoveFileLogEntryW"(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCWSTR, byval TargetFilename as PCWSTR) as WINBOOL
#endif

type SetupFileLogInfo as long
enum
	SetupFileLogSourceFilename
	SetupFileLogChecksum
	SetupFileLogDiskTagfile
	SetupFileLogDiskDescription
	SetupFileLogOtherInfo
	SetupFileLogMax
end enum

declare function SetupQueryFileLogA(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCSTR, byval TargetFilename as PCSTR, byval DesiredInfo as SetupFileLogInfo, byval DataOut as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupQueryFileLog alias "SetupQueryFileLogA"(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCSTR, byval TargetFilename as PCSTR, byval DesiredInfo as SetupFileLogInfo, byval DataOut as PSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupQueryFileLogW(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCWSTR, byval TargetFilename as PCWSTR, byval DesiredInfo as SetupFileLogInfo, byval DataOut as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupQueryFileLog alias "SetupQueryFileLogW"(byval FileLogHandle as HSPFILELOG, byval LogSectionName as PCWSTR, byval TargetFilename as PCWSTR, byval DesiredInfo as SetupFileLogInfo, byval DataOut as PWSTR, byval ReturnBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

type LogSeverity as DWORD
const LogSevInformation = &h00000000
const LogSevWarning = &h00000001
const LogSevError = &h00000002
const LogSevFatalError = &h00000003
const LogSevMaximum = &h00000004
const DICD_GENERATE_ID = &h00000001
const DICD_INHERIT_CLASSDRVS = &h00000002
const DIOD_INHERIT_CLASSDRVS = &h00000002
const DIOD_CANCEL_REMOVE = &h00000004
const DIODI_NO_ADD = &h00000001
const SPRDI_FIND_DUPS = &h00000001
const SPDIT_NODRIVER = &h00000000
const SPDIT_CLASSDRIVER = &h00000001
const SPDIT_COMPATDRIVER = &h00000002
declare function SetupOpenLog(byval Erase as WINBOOL) as WINBOOL
declare function SetupLogErrorA(byval MessageString as LPCSTR, byval Severity as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupLogError alias "SetupLogErrorA"(byval MessageString as LPCSTR, byval Severity as DWORD) as WINBOOL
#endif

declare function SetupLogErrorW(byval MessageString as LPCWSTR, byval Severity as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupLogError alias "SetupLogErrorW"(byval MessageString as LPCWSTR, byval Severity as DWORD) as WINBOOL
#endif

declare sub SetupCloseLog()
declare function SetupGetBackupInformationA(byval QueueHandle as HSPFILEQ, byval BackupParams as PSP_BACKUP_QUEUE_PARAMS_A) as WINBOOL

#ifndef UNICODE
	declare function SetupGetBackupInformation alias "SetupGetBackupInformationA"(byval QueueHandle as HSPFILEQ, byval BackupParams as PSP_BACKUP_QUEUE_PARAMS_A) as WINBOOL
#endif

declare function SetupGetBackupInformationW(byval QueueHandle as HSPFILEQ, byval BackupParams as PSP_BACKUP_QUEUE_PARAMS_W) as WINBOOL

#ifdef UNICODE
	declare function SetupGetBackupInformation alias "SetupGetBackupInformationW"(byval QueueHandle as HSPFILEQ, byval BackupParams as PSP_BACKUP_QUEUE_PARAMS_W) as WINBOOL
#endif

declare function SetupPrepareQueueForRestoreA(byval QueueHandle as HSPFILEQ, byval BackupPath as PCSTR, byval RestoreFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupPrepareQueueForRestore alias "SetupPrepareQueueForRestoreA"(byval QueueHandle as HSPFILEQ, byval BackupPath as PCSTR, byval RestoreFlags as DWORD) as WINBOOL
#endif

declare function SetupPrepareQueueForRestoreW(byval QueueHandle as HSPFILEQ, byval BackupPath as PCWSTR, byval RestoreFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupPrepareQueueForRestore alias "SetupPrepareQueueForRestoreW"(byval QueueHandle as HSPFILEQ, byval BackupPath as PCWSTR, byval RestoreFlags as DWORD) as WINBOOL
#endif

declare function SetupSetNonInteractiveMode(byval NonInteractiveFlag as WINBOOL) as WINBOOL
declare function SetupGetNonInteractiveMode() as WINBOOL
declare function SetupDiCreateDeviceInfoList(byval ClassGuid as const GUID ptr, byval hwndParent as HWND) as HDEVINFO
declare function SetupDiCreateDeviceInfoListExA(byval ClassGuid as const GUID ptr, byval hwndParent as HWND, byval MachineName as PCSTR, byval Reserved as PVOID) as HDEVINFO

#ifndef UNICODE
	declare function SetupDiCreateDeviceInfoListEx alias "SetupDiCreateDeviceInfoListExA"(byval ClassGuid as const GUID ptr, byval hwndParent as HWND, byval MachineName as PCSTR, byval Reserved as PVOID) as HDEVINFO
#endif

declare function SetupDiCreateDeviceInfoListExW(byval ClassGuid as const GUID ptr, byval hwndParent as HWND, byval MachineName as PCWSTR, byval Reserved as PVOID) as HDEVINFO

#ifdef UNICODE
	declare function SetupDiCreateDeviceInfoListEx alias "SetupDiCreateDeviceInfoListExW"(byval ClassGuid as const GUID ptr, byval hwndParent as HWND, byval MachineName as PCWSTR, byval Reserved as PVOID) as HDEVINFO
#endif

declare function SetupDiGetDeviceInfoListClass(byval DeviceInfoSet as HDEVINFO, byval ClassGuid as LPGUID) as WINBOOL
declare function SetupDiGetDeviceInfoListDetailA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoSetDetailData as PSP_DEVINFO_LIST_DETAIL_DATA_A) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetDeviceInfoListDetail alias "SetupDiGetDeviceInfoListDetailA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoSetDetailData as PSP_DEVINFO_LIST_DETAIL_DATA_A) as WINBOOL
#endif

declare function SetupDiGetDeviceInfoListDetailW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoSetDetailData as PSP_DEVINFO_LIST_DETAIL_DATA_W) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetDeviceInfoListDetail alias "SetupDiGetDeviceInfoListDetailW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoSetDetailData as PSP_DEVINFO_LIST_DETAIL_DATA_W) as WINBOOL
#endif

declare function SetupDiCreateDeviceInfoA(byval DeviceInfoSet as HDEVINFO, byval DeviceName as PCSTR, byval ClassGuid as const GUID ptr, byval DeviceDescription as PCSTR, byval hwndParent as HWND, byval CreationFlags as DWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL

#ifndef UNICODE
	declare function SetupDiCreateDeviceInfo alias "SetupDiCreateDeviceInfoA"(byval DeviceInfoSet as HDEVINFO, byval DeviceName as PCSTR, byval ClassGuid as const GUID ptr, byval DeviceDescription as PCSTR, byval hwndParent as HWND, byval CreationFlags as DWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
#endif

declare function SetupDiCreateDeviceInfoW(byval DeviceInfoSet as HDEVINFO, byval DeviceName as PCWSTR, byval ClassGuid as const GUID ptr, byval DeviceDescription as PCWSTR, byval hwndParent as HWND, byval CreationFlags as DWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL

#ifdef UNICODE
	declare function SetupDiCreateDeviceInfo alias "SetupDiCreateDeviceInfoW"(byval DeviceInfoSet as HDEVINFO, byval DeviceName as PCWSTR, byval ClassGuid as const GUID ptr, byval DeviceDescription as PCWSTR, byval hwndParent as HWND, byval CreationFlags as DWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
#endif

declare function SetupDiOpenDeviceInfoA(byval DeviceInfoSet as HDEVINFO, byval DeviceInstanceId as PCSTR, byval hwndParent as HWND, byval OpenFlags as DWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL

#ifndef UNICODE
	declare function SetupDiOpenDeviceInfo alias "SetupDiOpenDeviceInfoA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInstanceId as PCSTR, byval hwndParent as HWND, byval OpenFlags as DWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
#endif

declare function SetupDiOpenDeviceInfoW(byval DeviceInfoSet as HDEVINFO, byval DeviceInstanceId as PCWSTR, byval hwndParent as HWND, byval OpenFlags as DWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL

#ifdef UNICODE
	declare function SetupDiOpenDeviceInfo alias "SetupDiOpenDeviceInfoW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInstanceId as PCWSTR, byval hwndParent as HWND, byval OpenFlags as DWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
#endif

declare function SetupDiGetDeviceInstanceIdA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstanceId as PSTR, byval DeviceInstanceIdSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetDeviceInstanceId alias "SetupDiGetDeviceInstanceIdA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstanceId as PSTR, byval DeviceInstanceIdSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetDeviceInstanceIdW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstanceId as PWSTR, byval DeviceInstanceIdSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetDeviceInstanceId alias "SetupDiGetDeviceInstanceIdW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstanceId as PWSTR, byval DeviceInstanceIdSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiDeleteDeviceInfo(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiEnumDeviceInfo(byval DeviceInfoSet as HDEVINFO, byval MemberIndex as DWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiDestroyDeviceInfoList(byval DeviceInfoSet as HDEVINFO) as WINBOOL
declare function SetupDiEnumDeviceInterfaces(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval MemberIndex as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiEnumInterfaceDevice alias "SetupDiEnumDeviceInterfaces"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval MemberIndex as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiCreateDeviceInterfaceA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval ReferenceString as PCSTR, byval CreationFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL

#ifndef UNICODE
	declare function SetupDiCreateDeviceInterface alias "SetupDiCreateDeviceInterfaceA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval ReferenceString as PCSTR, byval CreationFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
	declare function SetupDiCreateInterfaceDevice alias "SetupDiCreateDeviceInterfaceA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval ReferenceString as PCSTR, byval CreationFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
#endif

declare function SetupDiCreateDeviceInterfaceW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval ReferenceString as PCWSTR, byval CreationFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL

#ifdef UNICODE
	declare function SetupDiCreateDeviceInterface alias "SetupDiCreateDeviceInterfaceW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval ReferenceString as PCWSTR, byval CreationFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
	declare function SetupDiCreateInterfaceDevice alias "SetupDiCreateDeviceInterfaceW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval ReferenceString as PCWSTR, byval CreationFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
#endif

declare function SetupDiCreateInterfaceDeviceW alias "SetupDiCreateDeviceInterfaceW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval ReferenceString as PCWSTR, byval CreationFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiCreateInterfaceDeviceA alias "SetupDiCreateDeviceInterfaceA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InterfaceClassGuid as const GUID ptr, byval ReferenceString as PCSTR, byval CreationFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiOpenDeviceInterfaceA(byval DeviceInfoSet as HDEVINFO, byval DevicePath as PCSTR, byval OpenFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL

#ifndef UNICODE
	declare function SetupDiOpenDeviceInterface alias "SetupDiOpenDeviceInterfaceA"(byval DeviceInfoSet as HDEVINFO, byval DevicePath as PCSTR, byval OpenFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
#endif

declare function SetupDiOpenDeviceInterfaceW(byval DeviceInfoSet as HDEVINFO, byval DevicePath as PCWSTR, byval OpenFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL

#ifdef UNICODE
	declare function SetupDiOpenDeviceInterface alias "SetupDiOpenDeviceInterfaceW"(byval DeviceInfoSet as HDEVINFO, byval DevicePath as PCWSTR, byval OpenFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
#endif

declare function SetupDiOpenInterfaceDeviceW alias "SetupDiOpenDeviceInterfaceW"(byval DeviceInfoSet as HDEVINFO, byval DevicePath as PCWSTR, byval OpenFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiOpenInterfaceDeviceA alias "SetupDiOpenDeviceInterfaceA"(byval DeviceInfoSet as HDEVINFO, byval DevicePath as PCSTR, byval OpenFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL

#ifdef UNICODE
	declare function SetupDiOpenInterfaceDevice alias "SetupDiOpenDeviceInterfaceW"(byval DeviceInfoSet as HDEVINFO, byval DevicePath as PCWSTR, byval OpenFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
#else
	declare function SetupDiOpenInterfaceDevice alias "SetupDiOpenDeviceInterfaceA"(byval DeviceInfoSet as HDEVINFO, byval DevicePath as PCSTR, byval OpenFlags as DWORD, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
#endif

declare function SetupDiGetDeviceInterfaceAlias(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval AliasInterfaceClassGuid as const GUID ptr, byval AliasDeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiGetInterfaceDeviceAlias alias "SetupDiGetDeviceInterfaceAlias"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval AliasInterfaceClassGuid as const GUID ptr, byval AliasDeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiDeleteDeviceInterfaceData(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiDeleteInterfaceDeviceData alias "SetupDiDeleteDeviceInterfaceData"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiRemoveDeviceInterface(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiRemoveInterfaceDevice alias "SetupDiRemoveDeviceInterface"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA) as WINBOOL
declare function SetupDiGetDeviceInterfaceDetailA(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval DeviceInterfaceDetailData as PSP_DEVICE_INTERFACE_DETAIL_DATA_A, byval DeviceInterfaceDetailDataSize as DWORD, byval RequiredSize as PDWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetDeviceInterfaceDetail alias "SetupDiGetDeviceInterfaceDetailA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval DeviceInterfaceDetailData as PSP_DEVICE_INTERFACE_DETAIL_DATA_A, byval DeviceInterfaceDetailDataSize as DWORD, byval RequiredSize as PDWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
	declare function SetupDiGetInterfaceDeviceDetail alias "SetupDiGetDeviceInterfaceDetailA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval DeviceInterfaceDetailData as PSP_DEVICE_INTERFACE_DETAIL_DATA_A, byval DeviceInterfaceDetailDataSize as DWORD, byval RequiredSize as PDWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
#endif

declare function SetupDiGetDeviceInterfaceDetailW(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval DeviceInterfaceDetailData as PSP_DEVICE_INTERFACE_DETAIL_DATA_W, byval DeviceInterfaceDetailDataSize as DWORD, byval RequiredSize as PDWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetDeviceInterfaceDetail alias "SetupDiGetDeviceInterfaceDetailW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval DeviceInterfaceDetailData as PSP_DEVICE_INTERFACE_DETAIL_DATA_W, byval DeviceInterfaceDetailDataSize as DWORD, byval RequiredSize as PDWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
	declare function SetupDiGetInterfaceDeviceDetail alias "SetupDiGetDeviceInterfaceDetailW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval DeviceInterfaceDetailData as PSP_DEVICE_INTERFACE_DETAIL_DATA_W, byval DeviceInterfaceDetailDataSize as DWORD, byval RequiredSize as PDWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
#endif

declare function SetupDiGetInterfaceDeviceDetailW alias "SetupDiGetDeviceInterfaceDetailW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval DeviceInterfaceDetailData as PSP_DEVICE_INTERFACE_DETAIL_DATA_W, byval DeviceInterfaceDetailDataSize as DWORD, byval RequiredSize as PDWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiGetInterfaceDeviceDetailA alias "SetupDiGetDeviceInterfaceDetailA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval DeviceInterfaceDetailData as PSP_DEVICE_INTERFACE_DETAIL_DATA_A, byval DeviceInterfaceDetailDataSize as DWORD, byval RequiredSize as PDWORD, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiInstallDeviceInterfaces(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiInstallInterfaceDevices alias "SetupDiInstallDeviceInterfaces"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiSetDeviceInterfaceDefault(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Flags as DWORD, byval Reserved as PVOID) as WINBOOL
declare function SetupDiRegisterDeviceInfo(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Flags as DWORD, byval CompareProc as PSP_DETSIG_CMPPROC, byval CompareContext as PVOID, byval DupDeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiBuildDriverInfoList(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverType as DWORD) as WINBOOL
declare function SetupDiCancelDriverInfoSearch(byval DeviceInfoSet as HDEVINFO) as WINBOOL
declare function SetupDiEnumDriverInfoA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverType as DWORD, byval MemberIndex as DWORD, byval DriverInfoData as PSP_DRVINFO_DATA_A) as WINBOOL

#ifndef UNICODE
	declare function SetupDiEnumDriverInfo alias "SetupDiEnumDriverInfoA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverType as DWORD, byval MemberIndex as DWORD, byval DriverInfoData as PSP_DRVINFO_DATA_A) as WINBOOL
#endif

declare function SetupDiEnumDriverInfoW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverType as DWORD, byval MemberIndex as DWORD, byval DriverInfoData as PSP_DRVINFO_DATA_W) as WINBOOL

#ifdef UNICODE
	declare function SetupDiEnumDriverInfo alias "SetupDiEnumDriverInfoW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverType as DWORD, byval MemberIndex as DWORD, byval DriverInfoData as PSP_DRVINFO_DATA_W) as WINBOOL
#endif

declare function SetupDiGetSelectedDriverA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetSelectedDriver alias "SetupDiGetSelectedDriverA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A) as WINBOOL
#endif

declare function SetupDiGetSelectedDriverW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetSelectedDriver alias "SetupDiGetSelectedDriverW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W) as WINBOOL
#endif

declare function SetupDiSetSelectedDriverA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A) as WINBOOL

#ifndef UNICODE
	declare function SetupDiSetSelectedDriver alias "SetupDiSetSelectedDriverA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A) as WINBOOL
#endif

declare function SetupDiSetSelectedDriverW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W) as WINBOOL

#ifdef UNICODE
	declare function SetupDiSetSelectedDriver alias "SetupDiSetSelectedDriverW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W) as WINBOOL
#endif

declare function SetupDiGetDriverInfoDetailA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A, byval DriverInfoDetailData as PSP_DRVINFO_DETAIL_DATA_A, byval DriverInfoDetailDataSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetDriverInfoDetail alias "SetupDiGetDriverInfoDetailA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A, byval DriverInfoDetailData as PSP_DRVINFO_DETAIL_DATA_A, byval DriverInfoDetailDataSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetDriverInfoDetailW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W, byval DriverInfoDetailData as PSP_DRVINFO_DETAIL_DATA_W, byval DriverInfoDetailDataSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetDriverInfoDetail alias "SetupDiGetDriverInfoDetailW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W, byval DriverInfoDetailData as PSP_DRVINFO_DETAIL_DATA_W, byval DriverInfoDetailDataSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiDestroyDriverInfoList(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverType as DWORD) as WINBOOL
const DIGCF_DEFAULT = &h00000001
const DIGCF_PRESENT = &h00000002
const DIGCF_ALLCLASSES = &h00000004
const DIGCF_PROFILE = &h00000008
const DIGCF_DEVICEINTERFACE = &h00000010
const DIGCF_INTERFACEDEVICE = DIGCF_DEVICEINTERFACE
const DIBCI_NOINSTALLCLASS = &h00000001
const DIBCI_NODISPLAYCLASS = &h00000002
declare function SetupDiGetClassDevsA(byval ClassGuid as const GUID ptr, byval Enumerator as PCSTR, byval hwndParent as HWND, byval Flags as DWORD) as HDEVINFO

#ifndef UNICODE
	declare function SetupDiGetClassDevs alias "SetupDiGetClassDevsA"(byval ClassGuid as const GUID ptr, byval Enumerator as PCSTR, byval hwndParent as HWND, byval Flags as DWORD) as HDEVINFO
#endif

declare function SetupDiGetClassDevsW(byval ClassGuid as const GUID ptr, byval Enumerator as PCWSTR, byval hwndParent as HWND, byval Flags as DWORD) as HDEVINFO

#ifdef UNICODE
	declare function SetupDiGetClassDevs alias "SetupDiGetClassDevsW"(byval ClassGuid as const GUID ptr, byval Enumerator as PCWSTR, byval hwndParent as HWND, byval Flags as DWORD) as HDEVINFO
#endif

declare function SetupDiGetClassDevsExA(byval ClassGuid as const GUID ptr, byval Enumerator as PCSTR, byval hwndParent as HWND, byval Flags as DWORD, byval DeviceInfoSet as HDEVINFO, byval MachineName as PCSTR, byval Reserved as PVOID) as HDEVINFO

#ifndef UNICODE
	declare function SetupDiGetClassDevsEx alias "SetupDiGetClassDevsExA"(byval ClassGuid as const GUID ptr, byval Enumerator as PCSTR, byval hwndParent as HWND, byval Flags as DWORD, byval DeviceInfoSet as HDEVINFO, byval MachineName as PCSTR, byval Reserved as PVOID) as HDEVINFO
#endif

declare function SetupDiGetClassDevsExW(byval ClassGuid as const GUID ptr, byval Enumerator as PCWSTR, byval hwndParent as HWND, byval Flags as DWORD, byval DeviceInfoSet as HDEVINFO, byval MachineName as PCWSTR, byval Reserved as PVOID) as HDEVINFO

#ifdef UNICODE
	declare function SetupDiGetClassDevsEx alias "SetupDiGetClassDevsExW"(byval ClassGuid as const GUID ptr, byval Enumerator as PCWSTR, byval hwndParent as HWND, byval Flags as DWORD, byval DeviceInfoSet as HDEVINFO, byval MachineName as PCWSTR, byval Reserved as PVOID) as HDEVINFO
#endif

declare function SetupDiGetINFClassA(byval InfName as PCSTR, byval ClassGuid as LPGUID, byval ClassName as PSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetINFClass alias "SetupDiGetINFClassA"(byval InfName as PCSTR, byval ClassGuid as LPGUID, byval ClassName as PSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetINFClassW(byval InfName as PCWSTR, byval ClassGuid as LPGUID, byval ClassName as PWSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetINFClass alias "SetupDiGetINFClassW"(byval InfName as PCWSTR, byval ClassGuid as LPGUID, byval ClassName as PWSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiBuildClassInfoList(byval Flags as DWORD, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
declare function SetupDiBuildClassInfoListExA(byval Flags as DWORD, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiBuildClassInfoListEx alias "SetupDiBuildClassInfoListExA"(byval Flags as DWORD, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiBuildClassInfoListExW(byval Flags as DWORD, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiBuildClassInfoListEx alias "SetupDiBuildClassInfoListExW"(byval Flags as DWORD, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetClassDescriptionA(byval ClassGuid as const GUID ptr, byval ClassDescription as PSTR, byval ClassDescriptionSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetClassDescription alias "SetupDiGetClassDescriptionA"(byval ClassGuid as const GUID ptr, byval ClassDescription as PSTR, byval ClassDescriptionSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetClassDescriptionW(byval ClassGuid as const GUID ptr, byval ClassDescription as PWSTR, byval ClassDescriptionSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetClassDescription alias "SetupDiGetClassDescriptionW"(byval ClassGuid as const GUID ptr, byval ClassDescription as PWSTR, byval ClassDescriptionSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetClassDescriptionExA(byval ClassGuid as const GUID ptr, byval ClassDescription as PSTR, byval ClassDescriptionSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetClassDescriptionEx alias "SetupDiGetClassDescriptionExA"(byval ClassGuid as const GUID ptr, byval ClassDescription as PSTR, byval ClassDescriptionSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetClassDescriptionExW(byval ClassGuid as const GUID ptr, byval ClassDescription as PWSTR, byval ClassDescriptionSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetClassDescriptionEx alias "SetupDiGetClassDescriptionExW"(byval ClassGuid as const GUID ptr, byval ClassDescription as PWSTR, byval ClassDescriptionSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiCallClassInstaller(byval InstallFunction as DI_FUNCTION, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiSelectDevice(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiSelectBestCompatDrv(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiInstallDevice(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiInstallDriverFiles(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiRegisterCoDeviceInstallers(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiRemoveDevice(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiUnremoveDevice(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiRestartDevices(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiChangeState(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiInstallClassA(byval hwndParent as HWND, byval InfFileName as PCSTR, byval Flags as DWORD, byval FileQueue as HSPFILEQ) as WINBOOL

#ifndef UNICODE
	declare function SetupDiInstallClass alias "SetupDiInstallClassA"(byval hwndParent as HWND, byval InfFileName as PCSTR, byval Flags as DWORD, byval FileQueue as HSPFILEQ) as WINBOOL
#endif

declare function SetupDiInstallClassW(byval hwndParent as HWND, byval InfFileName as PCWSTR, byval Flags as DWORD, byval FileQueue as HSPFILEQ) as WINBOOL

#ifdef UNICODE
	declare function SetupDiInstallClass alias "SetupDiInstallClassW"(byval hwndParent as HWND, byval InfFileName as PCWSTR, byval Flags as DWORD, byval FileQueue as HSPFILEQ) as WINBOOL
#endif

declare function SetupDiInstallClassExA(byval hwndParent as HWND, byval InfFileName as PCSTR, byval Flags as DWORD, byval FileQueue as HSPFILEQ, byval InterfaceClassGuid as const GUID ptr, byval Reserved1 as PVOID, byval Reserved2 as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiInstallClassEx alias "SetupDiInstallClassExA"(byval hwndParent as HWND, byval InfFileName as PCSTR, byval Flags as DWORD, byval FileQueue as HSPFILEQ, byval InterfaceClassGuid as const GUID ptr, byval Reserved1 as PVOID, byval Reserved2 as PVOID) as WINBOOL
#endif

declare function SetupDiInstallClassExW(byval hwndParent as HWND, byval InfFileName as PCWSTR, byval Flags as DWORD, byval FileQueue as HSPFILEQ, byval InterfaceClassGuid as const GUID ptr, byval Reserved1 as PVOID, byval Reserved2 as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiInstallClassEx alias "SetupDiInstallClassExW"(byval hwndParent as HWND, byval InfFileName as PCWSTR, byval Flags as DWORD, byval FileQueue as HSPFILEQ, byval InterfaceClassGuid as const GUID ptr, byval Reserved1 as PVOID, byval Reserved2 as PVOID) as WINBOOL
#endif

declare function SetupDiOpenClassRegKey(byval ClassGuid as const GUID ptr, byval samDesired as REGSAM) as HKEY
const DIOCR_INSTALLER = &h00000001
const DIOCR_INTERFACE = &h00000002
declare function SetupDiOpenClassRegKeyExA(byval ClassGuid as const GUID ptr, byval samDesired as REGSAM, byval Flags as DWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as HKEY

#ifndef UNICODE
	declare function SetupDiOpenClassRegKeyEx alias "SetupDiOpenClassRegKeyExA"(byval ClassGuid as const GUID ptr, byval samDesired as REGSAM, byval Flags as DWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as HKEY
#endif

declare function SetupDiOpenClassRegKeyExW(byval ClassGuid as const GUID ptr, byval samDesired as REGSAM, byval Flags as DWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as HKEY

#ifdef UNICODE
	declare function SetupDiOpenClassRegKeyEx alias "SetupDiOpenClassRegKeyExW"(byval ClassGuid as const GUID ptr, byval samDesired as REGSAM, byval Flags as DWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as HKEY
#endif

declare function SetupDiCreateDeviceInterfaceRegKeyA(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM, byval InfHandle as HINF, byval InfSectionName as PCSTR) as HKEY

#ifndef UNICODE
	declare function SetupDiCreateDeviceInterfaceRegKey alias "SetupDiCreateDeviceInterfaceRegKeyA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM, byval InfHandle as HINF, byval InfSectionName as PCSTR) as HKEY
	declare function SetupDiCreateInterfaceDeviceRegKey alias "SetupDiCreateDeviceInterfaceRegKeyA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM, byval InfHandle as HINF, byval InfSectionName as PCSTR) as HKEY
#endif

declare function SetupDiCreateDeviceInterfaceRegKeyW(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM, byval InfHandle as HINF, byval InfSectionName as PCWSTR) as HKEY

#ifdef UNICODE
	declare function SetupDiCreateDeviceInterfaceRegKey alias "SetupDiCreateDeviceInterfaceRegKeyW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM, byval InfHandle as HINF, byval InfSectionName as PCWSTR) as HKEY
	declare function SetupDiCreateInterfaceDeviceRegKey alias "SetupDiCreateDeviceInterfaceRegKeyW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM, byval InfHandle as HINF, byval InfSectionName as PCWSTR) as HKEY
#endif

declare function SetupDiCreateInterfaceDeviceRegKeyW alias "SetupDiCreateDeviceInterfaceRegKeyW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM, byval InfHandle as HINF, byval InfSectionName as PCWSTR) as HKEY
declare function SetupDiCreateInterfaceDeviceRegKeyA alias "SetupDiCreateDeviceInterfaceRegKeyA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM, byval InfHandle as HINF, byval InfSectionName as PCSTR) as HKEY
declare function SetupDiOpenDeviceInterfaceRegKey(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM) as HKEY
declare function SetupDiOpenInterfaceDeviceRegKey alias "SetupDiOpenDeviceInterfaceRegKey"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD, byval samDesired as REGSAM) as HKEY
declare function SetupDiDeleteDeviceInterfaceRegKey(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD) as WINBOOL
declare function SetupDiDeleteInterfaceDeviceRegKey alias "SetupDiDeleteDeviceInterfaceRegKey"(byval DeviceInfoSet as HDEVINFO, byval DeviceInterfaceData as PSP_DEVICE_INTERFACE_DATA, byval Reserved as DWORD) as WINBOOL

const DIREG_DEV = &h00000001
const DIREG_DRV = &h00000002
const DIREG_BOTH = &h00000004
declare function SetupDiCreateDevRegKeyA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Scope as DWORD, byval HwProfile as DWORD, byval KeyType as DWORD, byval InfHandle as HINF, byval InfSectionName as PCSTR) as HKEY

#ifndef UNICODE
	declare function SetupDiCreateDevRegKey alias "SetupDiCreateDevRegKeyA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Scope as DWORD, byval HwProfile as DWORD, byval KeyType as DWORD, byval InfHandle as HINF, byval InfSectionName as PCSTR) as HKEY
#endif

declare function SetupDiCreateDevRegKeyW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Scope as DWORD, byval HwProfile as DWORD, byval KeyType as DWORD, byval InfHandle as HINF, byval InfSectionName as PCWSTR) as HKEY

#ifdef UNICODE
	declare function SetupDiCreateDevRegKey alias "SetupDiCreateDevRegKeyW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Scope as DWORD, byval HwProfile as DWORD, byval KeyType as DWORD, byval InfHandle as HINF, byval InfSectionName as PCWSTR) as HKEY
#endif

declare function SetupDiOpenDevRegKey(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Scope as DWORD, byval HwProfile as DWORD, byval KeyType as DWORD, byval samDesired as REGSAM) as HKEY
declare function SetupDiDeleteDevRegKey(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Scope as DWORD, byval HwProfile as DWORD, byval KeyType as DWORD) as WINBOOL
declare function SetupDiGetHwProfileList(byval HwProfileList as PDWORD, byval HwProfileListSize as DWORD, byval RequiredSize as PDWORD, byval CurrentlyActiveIndex as PDWORD) as WINBOOL
declare function SetupDiGetHwProfileListExA(byval HwProfileList as PDWORD, byval HwProfileListSize as DWORD, byval RequiredSize as PDWORD, byval CurrentlyActiveIndex as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetHwProfileListEx alias "SetupDiGetHwProfileListExA"(byval HwProfileList as PDWORD, byval HwProfileListSize as DWORD, byval RequiredSize as PDWORD, byval CurrentlyActiveIndex as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetHwProfileListExW(byval HwProfileList as PDWORD, byval HwProfileListSize as DWORD, byval RequiredSize as PDWORD, byval CurrentlyActiveIndex as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetHwProfileListEx alias "SetupDiGetHwProfileListExW"(byval HwProfileList as PDWORD, byval HwProfileListSize as DWORD, byval RequiredSize as PDWORD, byval CurrentlyActiveIndex as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL
#endif

const SPDRP_DEVICEDESC = &h00000000
const SPDRP_HARDWAREID = &h00000001
const SPDRP_COMPATIBLEIDS = &h00000002
const SPDRP_UNUSED0 = &h00000003
const SPDRP_SERVICE = &h00000004
const SPDRP_UNUSED1 = &h00000005
const SPDRP_UNUSED2 = &h00000006
const SPDRP_CLASS = &h00000007
const SPDRP_CLASSGUID = &h00000008
const SPDRP_DRIVER = &h00000009
const SPDRP_CONFIGFLAGS = &h0000000A
const SPDRP_MFG = &h0000000B
const SPDRP_FRIENDLYNAME = &h0000000C
const SPDRP_LOCATION_INFORMATION = &h0000000D
const SPDRP_PHYSICAL_DEVICE_OBJECT_NAME = &h0000000E
const SPDRP_CAPABILITIES = &h0000000F
const SPDRP_UI_NUMBER = &h00000010
const SPDRP_UPPERFILTERS = &h00000011
const SPDRP_LOWERFILTERS = &h00000012
const SPDRP_BUSTYPEGUID = &h00000013
const SPDRP_LEGACYBUSTYPE = &h00000014
const SPDRP_BUSNUMBER = &h00000015
const SPDRP_ENUMERATOR_NAME = &h00000016
const SPDRP_SECURITY = &h00000017
const SPDRP_SECURITY_SDS = &h00000018
const SPDRP_DEVTYPE = &h00000019
const SPDRP_EXCLUSIVE = &h0000001A
const SPDRP_CHARACTERISTICS = &h0000001B
const SPDRP_ADDRESS = &h0000001C
const SPDRP_UI_NUMBER_DESC_FORMAT = &h0000001D
const SPDRP_DEVICE_POWER_DATA = &h0000001E
const SPDRP_REMOVAL_POLICY = &h0000001F
const SPDRP_REMOVAL_POLICY_HW_DEFAULT = &h00000020
const SPDRP_REMOVAL_POLICY_OVERRIDE = &h00000021
const SPDRP_INSTALL_STATE = &h00000022
const SPDRP_LOCATION_PATHS = &h00000023
const SPDRP_MAXIMUM_PROPERTY = &h00000024
const SPCRP_SECURITY = &h00000017
const SPCRP_SECURITY_SDS = &h00000018
const SPCRP_DEVTYPE = &h00000019
const SPCRP_EXCLUSIVE = &h0000001A
const SPCRP_CHARACTERISTICS = &h0000001B
const SPCRP_MAXIMUM_PROPERTY = &h0000001C
declare function SetupDiGetDeviceRegistryPropertyA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Property as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetDeviceRegistryProperty alias "SetupDiGetDeviceRegistryPropertyA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Property as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetDeviceRegistryPropertyW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Property as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetDeviceRegistryProperty alias "SetupDiGetDeviceRegistryPropertyW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Property as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetClassRegistryPropertyA(byval ClassGuid as const GUID ptr, byval Property as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetClassRegistryProperty alias "SetupDiGetClassRegistryPropertyA"(byval ClassGuid as const GUID ptr, byval Property as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetClassRegistryPropertyW(byval ClassGuid as const GUID ptr, byval Property as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetClassRegistryProperty alias "SetupDiGetClassRegistryPropertyW"(byval ClassGuid as const GUID ptr, byval Property as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiSetDeviceRegistryPropertyA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Property as DWORD, byval PropertyBuffer as const UBYTE ptr, byval PropertyBufferSize as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiSetDeviceRegistryProperty alias "SetupDiSetDeviceRegistryPropertyA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Property as DWORD, byval PropertyBuffer as const UBYTE ptr, byval PropertyBufferSize as DWORD) as WINBOOL
#endif

declare function SetupDiSetDeviceRegistryPropertyW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Property as DWORD, byval PropertyBuffer as const UBYTE ptr, byval PropertyBufferSize as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiSetDeviceRegistryProperty alias "SetupDiSetDeviceRegistryPropertyW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval Property as DWORD, byval PropertyBuffer as const UBYTE ptr, byval PropertyBufferSize as DWORD) as WINBOOL
#endif

declare function SetupDiSetClassRegistryPropertyA(byval ClassGuid as const GUID ptr, byval Property as DWORD, byval PropertyBuffer as const UBYTE ptr, byval PropertyBufferSize as DWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiSetClassRegistryProperty alias "SetupDiSetClassRegistryPropertyA"(byval ClassGuid as const GUID ptr, byval Property as DWORD, byval PropertyBuffer as const UBYTE ptr, byval PropertyBufferSize as DWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiSetClassRegistryPropertyW(byval ClassGuid as const GUID ptr, byval Property as DWORD, byval PropertyBuffer as const UBYTE ptr, byval PropertyBufferSize as DWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiSetClassRegistryProperty alias "SetupDiSetClassRegistryPropertyW"(byval ClassGuid as const GUID ptr, byval Property as DWORD, byval PropertyBuffer as const UBYTE ptr, byval PropertyBufferSize as DWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetDeviceInstallParamsA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstallParams as PSP_DEVINSTALL_PARAMS_A) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetDeviceInstallParams alias "SetupDiGetDeviceInstallParamsA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstallParams as PSP_DEVINSTALL_PARAMS_A) as WINBOOL
#endif

declare function SetupDiGetDeviceInstallParamsW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstallParams as PSP_DEVINSTALL_PARAMS_W) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetDeviceInstallParams alias "SetupDiGetDeviceInstallParamsW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstallParams as PSP_DEVINSTALL_PARAMS_W) as WINBOOL
#endif

declare function SetupDiGetClassInstallParamsA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval ClassInstallParams as PSP_CLASSINSTALL_HEADER, byval ClassInstallParamsSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetClassInstallParams alias "SetupDiGetClassInstallParamsA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval ClassInstallParams as PSP_CLASSINSTALL_HEADER, byval ClassInstallParamsSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetClassInstallParamsW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval ClassInstallParams as PSP_CLASSINSTALL_HEADER, byval ClassInstallParamsSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetClassInstallParams alias "SetupDiGetClassInstallParamsW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval ClassInstallParams as PSP_CLASSINSTALL_HEADER, byval ClassInstallParamsSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiSetDeviceInstallParamsA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstallParams as PSP_DEVINSTALL_PARAMS_A) as WINBOOL

#ifndef UNICODE
	declare function SetupDiSetDeviceInstallParams alias "SetupDiSetDeviceInstallParamsA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstallParams as PSP_DEVINSTALL_PARAMS_A) as WINBOOL
#endif

declare function SetupDiSetDeviceInstallParamsW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstallParams as PSP_DEVINSTALL_PARAMS_W) as WINBOOL

#ifdef UNICODE
	declare function SetupDiSetDeviceInstallParams alias "SetupDiSetDeviceInstallParamsW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DeviceInstallParams as PSP_DEVINSTALL_PARAMS_W) as WINBOOL
#endif

declare function SetupDiSetClassInstallParamsA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval ClassInstallParams as PSP_CLASSINSTALL_HEADER, byval ClassInstallParamsSize as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiSetClassInstallParams alias "SetupDiSetClassInstallParamsA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval ClassInstallParams as PSP_CLASSINSTALL_HEADER, byval ClassInstallParamsSize as DWORD) as WINBOOL
#endif

declare function SetupDiSetClassInstallParamsW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval ClassInstallParams as PSP_CLASSINSTALL_HEADER, byval ClassInstallParamsSize as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiSetClassInstallParams alias "SetupDiSetClassInstallParamsW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval ClassInstallParams as PSP_CLASSINSTALL_HEADER, byval ClassInstallParamsSize as DWORD) as WINBOOL
#endif

declare function SetupDiGetDriverInstallParamsA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A, byval DriverInstallParams as PSP_DRVINSTALL_PARAMS) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetDriverInstallParams alias "SetupDiGetDriverInstallParamsA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A, byval DriverInstallParams as PSP_DRVINSTALL_PARAMS) as WINBOOL
#endif

declare function SetupDiGetDriverInstallParamsW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W, byval DriverInstallParams as PSP_DRVINSTALL_PARAMS) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetDriverInstallParams alias "SetupDiGetDriverInstallParamsW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W, byval DriverInstallParams as PSP_DRVINSTALL_PARAMS) as WINBOOL
#endif

declare function SetupDiSetDriverInstallParamsA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A, byval DriverInstallParams as PSP_DRVINSTALL_PARAMS) as WINBOOL

#ifndef UNICODE
	declare function SetupDiSetDriverInstallParams alias "SetupDiSetDriverInstallParamsA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_A, byval DriverInstallParams as PSP_DRVINSTALL_PARAMS) as WINBOOL
#endif

declare function SetupDiSetDriverInstallParamsW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W, byval DriverInstallParams as PSP_DRVINSTALL_PARAMS) as WINBOOL

#ifdef UNICODE
	declare function SetupDiSetDriverInstallParams alias "SetupDiSetDriverInstallParamsW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval DriverInfoData as PSP_DRVINFO_DATA_W, byval DriverInstallParams as PSP_DRVINSTALL_PARAMS) as WINBOOL
#endif

declare function SetupDiLoadClassIcon(byval ClassGuid as const GUID ptr, byval LargeIcon as HICON ptr, byval MiniIconIndex as PINT) as WINBOOL
const DMI_MASK = &h00000001
const DMI_BKCOLOR = &h00000002
const DMI_USERECT = &h00000004

declare function SetupDiDrawMiniIcon(byval hdc as HDC, byval rc as RECT, byval MiniIconIndex as INT_, byval Flags as DWORD) as INT_
declare function SetupDiGetClassBitmapIndex(byval ClassGuid as const GUID ptr, byval MiniIconIndex as PINT) as WINBOOL
declare function SetupDiGetClassImageList(byval ClassImageListData as PSP_CLASSIMAGELIST_DATA) as WINBOOL
declare function SetupDiGetClassImageListExA(byval ClassImageListData as PSP_CLASSIMAGELIST_DATA, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetClassImageListEx alias "SetupDiGetClassImageListExA"(byval ClassImageListData as PSP_CLASSIMAGELIST_DATA, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetClassImageListExW(byval ClassImageListData as PSP_CLASSIMAGELIST_DATA, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetClassImageListEx alias "SetupDiGetClassImageListExW"(byval ClassImageListData as PSP_CLASSIMAGELIST_DATA, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetClassImageIndex(byval ClassImageListData as PSP_CLASSIMAGELIST_DATA, byval ClassGuid as const GUID ptr, byval ImageIndex as PINT) as WINBOOL
declare function SetupDiDestroyClassImageList(byval ClassImageListData as PSP_CLASSIMAGELIST_DATA) as WINBOOL
const DIGCDP_FLAG_BASIC = &h00000001
const DIGCDP_FLAG_ADVANCED = &h00000002
const DIGCDP_FLAG_REMOTE_BASIC = &h00000003
const DIGCDP_FLAG_REMOTE_ADVANCED = &h00000004
declare function SetupDiGetClassDevPropertySheetsA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval PropertySheetHeader as LPPROPSHEETHEADERA, byval PropertySheetHeaderPageListSize as DWORD, byval RequiredSize as PDWORD, byval PropertySheetType as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetClassDevPropertySheets alias "SetupDiGetClassDevPropertySheetsA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval PropertySheetHeader as LPPROPSHEETHEADERA, byval PropertySheetHeaderPageListSize as DWORD, byval RequiredSize as PDWORD, byval PropertySheetType as DWORD) as WINBOOL
#endif

declare function SetupDiGetClassDevPropertySheetsW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval PropertySheetHeader as LPPROPSHEETHEADERW, byval PropertySheetHeaderPageListSize as DWORD, byval RequiredSize as PDWORD, byval PropertySheetType as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetClassDevPropertySheets alias "SetupDiGetClassDevPropertySheetsW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval PropertySheetHeader as LPPROPSHEETHEADERW, byval PropertySheetHeaderPageListSize as DWORD, byval RequiredSize as PDWORD, byval PropertySheetType as DWORD) as WINBOOL
#endif

const IDI_RESOURCEFIRST = 159
const IDI_RESOURCE = 159
const IDI_RESOURCELAST = 161
const IDI_RESOURCEOVERLAYFIRST = 161
const IDI_RESOURCEOVERLAYLAST = 161
const IDI_CONFLICT = 161
const IDI_CLASSICON_OVERLAYFIRST = 500
const IDI_CLASSICON_OVERLAYLAST = 502
const IDI_PROBLEM_OVL = 500
const IDI_DISABLED_OVL = 501
const IDI_FORCED_OVL = 502

declare function SetupDiAskForOEMDisk(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiSelectOEMDrv(byval hwndParent as HWND, byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiClassNameFromGuidA(byval ClassGuid as const GUID ptr, byval ClassName as PSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiClassNameFromGuid alias "SetupDiClassNameFromGuidA"(byval ClassGuid as const GUID ptr, byval ClassName as PSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiClassNameFromGuidW(byval ClassGuid as const GUID ptr, byval ClassName as PWSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiClassNameFromGuid alias "SetupDiClassNameFromGuidW"(byval ClassGuid as const GUID ptr, byval ClassName as PWSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiClassNameFromGuidExA(byval ClassGuid as const GUID ptr, byval ClassName as PSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiClassNameFromGuidEx alias "SetupDiClassNameFromGuidExA"(byval ClassGuid as const GUID ptr, byval ClassName as PSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiClassNameFromGuidExW(byval ClassGuid as const GUID ptr, byval ClassName as PWSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiClassNameFromGuidEx alias "SetupDiClassNameFromGuidExW"(byval ClassGuid as const GUID ptr, byval ClassName as PWSTR, byval ClassNameSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiClassGuidsFromNameA(byval ClassName as PCSTR, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiClassGuidsFromName alias "SetupDiClassGuidsFromNameA"(byval ClassName as PCSTR, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiClassGuidsFromNameW(byval ClassName as PCWSTR, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiClassGuidsFromName alias "SetupDiClassGuidsFromNameW"(byval ClassName as PCWSTR, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiClassGuidsFromNameExA(byval ClassName as PCSTR, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiClassGuidsFromNameEx alias "SetupDiClassGuidsFromNameExA"(byval ClassName as PCSTR, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiClassGuidsFromNameExW(byval ClassName as PCWSTR, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiClassGuidsFromNameEx alias "SetupDiClassGuidsFromNameExW"(byval ClassName as PCWSTR, byval ClassGuidList as LPGUID, byval ClassGuidListSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetHwProfileFriendlyNameA(byval HwProfile as DWORD, byval FriendlyName as PSTR, byval FriendlyNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetHwProfileFriendlyName alias "SetupDiGetHwProfileFriendlyNameA"(byval HwProfile as DWORD, byval FriendlyName as PSTR, byval FriendlyNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetHwProfileFriendlyNameW(byval HwProfile as DWORD, byval FriendlyName as PWSTR, byval FriendlyNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetHwProfileFriendlyName alias "SetupDiGetHwProfileFriendlyNameW"(byval HwProfile as DWORD, byval FriendlyName as PWSTR, byval FriendlyNameSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetHwProfileFriendlyNameExA(byval HwProfile as DWORD, byval FriendlyName as PSTR, byval FriendlyNameSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetHwProfileFriendlyNameEx alias "SetupDiGetHwProfileFriendlyNameExA"(byval HwProfile as DWORD, byval FriendlyName as PSTR, byval FriendlyNameSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCSTR, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetHwProfileFriendlyNameExW(byval HwProfile as DWORD, byval FriendlyName as PWSTR, byval FriendlyNameSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetHwProfileFriendlyNameEx alias "SetupDiGetHwProfileFriendlyNameExW"(byval HwProfile as DWORD, byval FriendlyName as PWSTR, byval FriendlyNameSize as DWORD, byval RequiredSize as PDWORD, byval MachineName as PCWSTR, byval Reserved as PVOID) as WINBOOL
#endif

const SPWPT_SELECTDEVICE = &h00000001
const SPWP_USE_DEVINFO_DATA = &h00000001
declare function SetupDiGetWizardPage(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval InstallWizardData as PSP_INSTALLWIZARD_DATA, byval PageType as DWORD, byval Flags as DWORD) as HPROPSHEETPAGE
declare function SetupDiGetSelectedDevice(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiSetSelectedDevice(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA) as WINBOOL
declare function SetupDiGetActualModelsSectionA(byval Context as PINFCONTEXT, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSectionWithExt as PSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetActualModelsSection alias "SetupDiGetActualModelsSectionA"(byval Context as PINFCONTEXT, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSectionWithExt as PSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetActualModelsSectionW(byval Context as PINFCONTEXT, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSectionWithExt as PWSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetActualModelsSection alias "SetupDiGetActualModelsSectionW"(byval Context as PINFCONTEXT, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSectionWithExt as PWSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetActualSectionToInstallA(byval InfHandle as HINF, byval InfSectionName as PCSTR, byval InfSectionWithExt as PSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Extension as PSTR ptr) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetActualSectionToInstall alias "SetupDiGetActualSectionToInstallA"(byval InfHandle as HINF, byval InfSectionName as PCSTR, byval InfSectionWithExt as PSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Extension as PSTR ptr) as WINBOOL
#endif

declare function SetupDiGetActualSectionToInstallW(byval InfHandle as HINF, byval InfSectionName as PCWSTR, byval InfSectionWithExt as PWSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Extension as PWSTR ptr) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetActualSectionToInstall alias "SetupDiGetActualSectionToInstallW"(byval InfHandle as HINF, byval InfSectionName as PCWSTR, byval InfSectionWithExt as PWSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Extension as PWSTR ptr) as WINBOOL
#endif

declare function SetupDiGetActualSectionToInstallExA(byval InfHandle as HINF, byval InfSectionName as PCSTR, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSectionWithExt as PSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Extension as PSTR ptr, byval Reserved as PVOID) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetActualSectionToInstallEx alias "SetupDiGetActualSectionToInstallExA"(byval InfHandle as HINF, byval InfSectionName as PCSTR, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSectionWithExt as PSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Extension as PSTR ptr, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupDiGetActualSectionToInstallExW(byval InfHandle as HINF, byval InfSectionName as PCWSTR, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSectionWithExt as PWSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Extension as PWSTR ptr, byval Reserved as PVOID) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetActualSectionToInstallEx alias "SetupDiGetActualSectionToInstallExW"(byval InfHandle as HINF, byval InfSectionName as PCWSTR, byval AlternatePlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSectionWithExt as PWSTR, byval InfSectionWithExtSize as DWORD, byval RequiredSize as PDWORD, byval Extension as PWSTR ptr, byval Reserved as PVOID) as WINBOOL
#endif

declare function SetupEnumInfSectionsA(byval InfHandle as HINF, byval Index as UINT, byval Buffer as PSTR, byval Size as UINT, byval SizeNeeded as UINT ptr) as WINBOOL

#ifndef UNICODE
	declare function SetupEnumInfSections alias "SetupEnumInfSectionsA"(byval InfHandle as HINF, byval Index as UINT, byval Buffer as PSTR, byval Size as UINT, byval SizeNeeded as UINT ptr) as WINBOOL
#endif

declare function SetupEnumInfSectionsW(byval InfHandle as HINF, byval Index as UINT, byval Buffer as PWSTR, byval Size as UINT, byval SizeNeeded as UINT ptr) as WINBOOL

#ifdef UNICODE
	declare function SetupEnumInfSections alias "SetupEnumInfSectionsW"(byval InfHandle as HINF, byval Index as UINT, byval Buffer as PWSTR, byval Size as UINT, byval SizeNeeded as UINT ptr) as WINBOOL
#endif

#ifdef __FB_64BIT__
	type _SP_INF_SIGNER_INFO_A
		cbSize as DWORD
		CatalogFile as zstring * 260
		DigitalSigner as zstring * 260
		DigitalSignerVersion as zstring * 260
	end type
#else
	type _SP_INF_SIGNER_INFO_A field = 1
		cbSize as DWORD
		CatalogFile as zstring * 260
		DigitalSigner as zstring * 260
		DigitalSignerVersion as zstring * 260
	end type
#endif

type SP_INF_SIGNER_INFO_A as _SP_INF_SIGNER_INFO_A
type PSP_INF_SIGNER_INFO_A as _SP_INF_SIGNER_INFO_A ptr

#ifdef __FB_64BIT__
	type _SP_INF_SIGNER_INFO_W
		cbSize as DWORD
		CatalogFile as wstring * 260
		DigitalSigner as wstring * 260
		DigitalSignerVersion as wstring * 260
	end type
#else
	type _SP_INF_SIGNER_INFO_W field = 1
		cbSize as DWORD
		CatalogFile as wstring * 260
		DigitalSigner as wstring * 260
		DigitalSignerVersion as wstring * 260
	end type
#endif

type SP_INF_SIGNER_INFO_W as _SP_INF_SIGNER_INFO_W
type PSP_INF_SIGNER_INFO_W as _SP_INF_SIGNER_INFO_W ptr

#ifdef UNICODE
	type SP_INF_SIGNER_INFO as SP_INF_SIGNER_INFO_W
	type PSP_INF_SIGNER_INFO as PSP_INF_SIGNER_INFO_W
#else
	type SP_INF_SIGNER_INFO as SP_INF_SIGNER_INFO_A
	type PSP_INF_SIGNER_INFO as PSP_INF_SIGNER_INFO_A
#endif

declare function SetupVerifyInfFileA(byval InfName as PCSTR, byval AltPlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSignerInfo as PSP_INF_SIGNER_INFO_A) as WINBOOL

#ifndef UNICODE
	declare function SetupVerifyInfFile alias "SetupVerifyInfFileA"(byval InfName as PCSTR, byval AltPlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSignerInfo as PSP_INF_SIGNER_INFO_A) as WINBOOL
#endif

declare function SetupVerifyInfFileW(byval InfName as PCWSTR, byval AltPlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSignerInfo as PSP_INF_SIGNER_INFO_W) as WINBOOL

#ifdef UNICODE
	declare function SetupVerifyInfFile alias "SetupVerifyInfFileW"(byval InfName as PCWSTR, byval AltPlatformInfo as PSP_ALTPLATFORM_INFO, byval InfSignerInfo as PSP_INF_SIGNER_INFO_W) as WINBOOL
#endif

const DICUSTOMDEVPROP_MERGE_MULTISZ = &h00000001
declare function SetupDiGetCustomDevicePropertyA(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval CustomPropertyName as PCSTR, byval Flags as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupDiGetCustomDeviceProperty alias "SetupDiGetCustomDevicePropertyA"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval CustomPropertyName as PCSTR, byval Flags as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

declare function SetupDiGetCustomDevicePropertyW(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval CustomPropertyName as PCWSTR, byval Flags as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupDiGetCustomDeviceProperty alias "SetupDiGetCustomDevicePropertyW"(byval DeviceInfoSet as HDEVINFO, byval DeviceInfoData as PSP_DEVINFO_DATA, byval CustomPropertyName as PCWSTR, byval Flags as DWORD, byval PropertyRegDataType as PDWORD, byval PropertyBuffer as PBYTE, byval PropertyBufferSize as DWORD, byval RequiredSize as PDWORD) as WINBOOL
#endif

const SCWMI_CLOBBER_SECURITY = &h00000001
declare function SetupConfigureWmiFromInfSectionA(byval InfHandle as HINF, byval SectionName as PCSTR, byval Flags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetupConfigureWmiFromInfSection alias "SetupConfigureWmiFromInfSectionA"(byval InfHandle as HINF, byval SectionName as PCSTR, byval Flags as DWORD) as WINBOOL
#endif

declare function SetupConfigureWmiFromInfSectionW(byval InfHandle as HINF, byval SectionName as PCWSTR, byval Flags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetupConfigureWmiFromInfSection alias "SetupConfigureWmiFromInfSectionW"(byval InfHandle as HINF, byval SectionName as PCWSTR, byval Flags as DWORD) as WINBOOL
#endif

end extern
