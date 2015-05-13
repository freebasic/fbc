''
''
'' imagehlp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_imagehlp_bi__
#define __win_imagehlp_bi__

#inclib "imagehlp"

#define API_VERSION_NUMBER 7
#define BIND_NO_BOUND_IMPORTS &h00000001
#define BIND_NO_UPDATE &h00000002
#define BIND_ALL_IMAGES &h00000004
#define BIND_CACHE_IMPORT_DLLS &h00000008
#define CBA_DEFERRED_SYMBOL_LOAD_START 1
#define CBA_DEFERRED_SYMBOL_LOAD_COMPLETE 2
#define CBA_DEFERRED_SYMBOL_LOAD_FAILURE 3
#define CBA_SYMBOLS_UNLOADED 4
#define CBA_DUPLICATE_SYMBOL 5
#define CERT_PE_IMAGE_DIGEST_DEBUG_INFO 1
#define CERT_PE_IMAGE_DIGEST_RESOURCES 2
#define CERT_PE_IMAGE_DIGEST_ALL_IMPORT_INFO 4
#define CERT_PE_IMAGE_DIGEST_NON_PE_INFO 8
#define CERT_SECTION_TYPE_ANY 255
#define CHECKSUM_SUCCESS 0
#define CHECKSUM_OPEN_FAILURE 1
#define CHECKSUM_MAP_FAILURE 2
#define CHECKSUM_MAPVIEW_FAILURE 3
#define CHECKSUM_UNICODE_FAILURE 4
#define IMAGE_SEPARATION 65536
#define SPLITSYM_REMOVE_PRIVATE 1
#define SPLITSYM_EXTRACT_ALL 2
#define SPLITSYM_SYMBOLPATH_IS_SRC 4
#define SYMF_OMAP_GENERATED 1
#define SYMF_OMAP_MODIFIED 2
#define SYMOPT_CASE_INSENSITIVE 1
#define SYMOPT_UNDNAME 2
#define SYMOPT_DEFERRED_LOADS 4
#define SYMOPT_NO_CPP 8
#define SYMOPT_LOAD_LINES 16
#define SYMOPT_OMAP_FIND_NEAREST 32
#define UNDNAME_COMPLETE 0
#define UNDNAME_NO_LEADING_UNDERSCORES 1
#define UNDNAME_NO_MS_KEYWORDS 2
#define UNDNAME_NO_FUNCTION_RETURNS 4
#define UNDNAME_NO_ALLOCATION_MODEL 8
#define UNDNAME_NO_ALLOCATION_LANGUAGE 16
#define UNDNAME_NO_MS_THISTYPE 32
#define UNDNAME_NO_CV_THISTYPE 64
#define UNDNAME_NO_THISTYPE 96
#define UNDNAME_NO_ACCESS_SPECIFIERS 128
#define UNDNAME_NO_THROW_SIGNATURES 256
#define UNDNAME_NO_MEMBER_TYPE 512
#define UNDNAME_NO_RETURN_UDT_MODEL 1024
#define UNDNAME_32_BIT_DECODE 2048
#define UNDNAME_NAME_ONLY 4096
#define UNDNAME_NO_ARGUMENTS 8192
#define UNDNAME_NO_SPECIAL_SYMS 16384

enum IMAGEHLP_STATUS_REASON
	BindOutOfMemory
	BindRvaToVaFailed
	BindNoRoomInImage
	BindImportModuleFailed
	BindImportProcedureFailed
	BindImportModule
	BindImportProcedure
	BindForwarder
	BindForwarderNOT
	BindImageModified
	BindExpandFileHeaders
	BindImageComplete
	BindMismatchedSymbols
	BindSymbolsNotUpdated
end enum

type PIMAGEHLP_STATUS_ROUTINE as function (byval as IMAGEHLP_STATUS_REASON, byval as LPSTR, byval as LPSTR, byval as ULONG, byval as ULONG) as BOOL

type LOADED_IMAGE
	ModuleName as LPSTR
	hFile as HANDLE
	MappedAddress as PUCHAR
	FileHeader as PIMAGE_NT_HEADERS
	LastRvaSection as PIMAGE_SECTION_HEADER
	NumberOfSections as ULONG
	Sections as PIMAGE_SECTION_HEADER
	Characteristics as ULONG
	fSystemImage as BOOLEAN
	fDOSImage as BOOLEAN
	Links as LIST_ENTRY
	SizeOfImage as ULONG
end type

type PLOADED_IMAGE as LOADED_IMAGE ptr

type IMAGE_DEBUG_INFORMATION
	List as LIST_ENTRY
	Size as DWORD
	MappedBase as PVOID
	Machine as USHORT
	Characteristics as USHORT
	CheckSum as DWORD
	ImageBase as DWORD
	SizeOfImage as DWORD
	NumberOfSections as DWORD
	Sections as PIMAGE_SECTION_HEADER
	ExportedNamesSize as DWORD
	ExportedNames as LPSTR
	NumberOfFunctionTableEntries as DWORD
	FunctionTableEntries as PIMAGE_FUNCTION_ENTRY
	LowestFunctionStartingAddress as DWORD
	HighestFunctionEndingAddress as DWORD
	NumberOfFpoTableEntries as DWORD
	FpoTableEntries as PFPO_DATA
	SizeOfCoffSymbols as DWORD
	CoffSymbols as PIMAGE_COFF_SYMBOLS_HEADER
	SizeOfCodeViewSymbols as DWORD
	CodeViewSymbols as PVOID
	ImageFilePath as LPSTR
	ImageFileName as LPSTR
	DebugFilePath as LPSTR
	TimeDateStamp as DWORD
	RomImage as BOOL
	DebugDirectory as PIMAGE_DEBUG_DIRECTORY
	NumberOfDebugDirectories as DWORD
	Reserved(0 to 3-1) as DWORD
end type

type PIMAGE_DEBUG_INFORMATION as IMAGE_DEBUG_INFORMATION ptr

enum ADDRESS_MODE
	AddrMode1616
	AddrMode1632
	AddrModeReal
	AddrModeFlat
end enum

type ADDRESS
	Offset as DWORD
	Segment as WORD
	Mode as ADDRESS_MODE
end type

type LPADDRESS as ADDRESS ptr

type KDHELP
	Thread as DWORD
	ThCallbackStack as DWORD
	NextCallback as DWORD
	FramePointer as DWORD
	KiCallUserMode as DWORD
	KeUserCallbackDispatcher as DWORD
	SystemRangeStart as DWORD
end type

type PKDHELP as KDHELP ptr

type STACKFRAME
	AddrPC as ADDRESS
	AddrReturn as ADDRESS
	AddrFrame as ADDRESS
	AddrStack as ADDRESS
	FuncTableEntry as LPVOID
	Params(0 to 4-1) as DWORD
	Far as BOOL
	Virtual as BOOL
	Reserved(0 to 3-1) as DWORD
	KdHelp as KDHELP
end type

type LPSTACKFRAME as STACKFRAME ptr
type PREAD_PROCESS_MEMORY_ROUTINE as function (byval as HANDLE, byval as LPCVOID, byval as LPVOID, byval as DWORD, byval as LPDWORD) as BOOL
type PFUNCTION_TABLE_ACCESS_ROUTINE as function (byval as HANDLE, byval as DWORD) as LPVOID
type PGET_MODULE_BASE_ROUTINE as function (byval as HANDLE, byval as DWORD) as DWORD
type PTRANSLATE_ADDRESS_ROUTINE as function (byval as HANDLE, byval as HANDLE, byval as LPADDRESS) as DWORD

type API_VERSION
	MajorVersion as USHORT
	MinorVersion as USHORT
	Revision as USHORT
	Reserved as USHORT
end type

type LPAPI_VERSION as API_VERSION ptr
type PSYM_ENUMMODULES_CALLBACK as function (byval as LPSTR, byval as ULONG, byval as PVOID) as BOOL
type PSYM_ENUMSYMBOLS_CALLBACK as function (byval as LPSTR, byval as ULONG, byval as ULONG, byval as PVOID) as BOOL
type PENUMLOADED_MODULES_CALLBACK as function (byval as LPSTR, byval as ULONG, byval as ULONG, byval as PVOID) as BOOL
type PSYMBOL_REGISTERED_CALLBACK as function (byval as HANDLE, byval as ULONG, byval as PVOID, byval as PVOID) as BOOL

enum SYM_TYPE
	SymNone
	SymCoff
	SymCv
	SymPdb
	SymExport
	SymDeferred
	SymSym
end enum

type IMAGEHLP_SYMBOL
	SizeOfStruct as DWORD
	Address as DWORD
	Size as DWORD
	Flags as DWORD
	MaxNameLength as DWORD
	Name as zstring * 1
end type

type PIMAGEHLP_SYMBOL as IMAGEHLP_SYMBOL ptr

type IMAGEHLP_MODULE
	SizeOfStruct as DWORD
	BaseOfImage as DWORD
	ImageSize as DWORD
	TimeDateStamp as DWORD
	CheckSum as DWORD
	NumSyms as DWORD
	SymType as SYM_TYPE
	ModuleName as zstring * 32
	ImageName as zstring * 256
	LoadedImageName as zstring * 256
end type

type PIMAGEHLP_MODULE as IMAGEHLP_MODULE ptr

type IMAGEHLP_LINE
	SizeOfStruct as DWORD
	Key as DWORD
	LineNumber as DWORD
	FileName as PCHAR
	Address as DWORD
end type

type PIMAGEHLP_LINE as IMAGEHLP_LINE ptr

type IMAGEHLP_DEFERRED_SYMBOL_LOAD
	SizeOfStruct as DWORD
	BaseOfImage as DWORD
	CheckSum as DWORD
	TimeDateStamp as DWORD
	FileName as zstring * 260
	Reparse as BOOLEAN
end type

type PIMAGEHLP_DEFERRED_SYMBOL_LOAD as IMAGEHLP_DEFERRED_SYMBOL_LOAD ptr

type IMAGEHLP_DUPLICATE_SYMBOL
	SizeOfStruct as DWORD
	NumberOfDups as DWORD
	Symbol as PIMAGEHLP_SYMBOL
	SelectedSymbol as ULONG
end type

type PIMAGEHLP_DUPLICATE_SYMBOL as IMAGEHLP_DUPLICATE_SYMBOL ptr

type DIGEST_HANDLE as PVOID
type DIGEST_FUNCTION as function (byval as DIGEST_HANDLE, byval as PBYTE, byval as DWORD) as BOOL

declare function CheckSumMappedFile alias "CheckSumMappedFile" (byval as LPVOID, byval as DWORD, byval as LPDWORD, byval as LPDWORD) as PIMAGE_NT_HEADERS
declare function TouchFileTimes alias "TouchFileTimes" (byval as HANDLE, byval as LPSYSTEMTIME) as BOOL
declare function SplitSymbols alias "SplitSymbols" (byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as DWORD) as BOOL
declare function FindDebugInfoFile alias "FindDebugInfoFile" (byval as LPSTR, byval as LPSTR, byval as LPSTR) as HANDLE
declare function FindExecutableImage alias "FindExecutableImage" (byval as LPSTR, byval as LPSTR, byval as LPSTR) as HANDLE
declare function UpdateDebugInfoFile alias "UpdateDebugInfoFile" (byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as PIMAGE_NT_HEADERS) as BOOL
declare function UpdateDebugInfoFileEx alias "UpdateDebugInfoFileEx" (byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as PIMAGE_NT_HEADERS, byval as DWORD) as BOOL
declare function BindImage alias "BindImage" (byval as LPSTR, byval as LPSTR, byval as LPSTR) as BOOL
declare function BindImageEx alias "BindImageEx" (byval as DWORD, byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as PIMAGEHLP_STATUS_ROUTINE) as BOOL
declare function ReBaseImage alias "ReBaseImage" (byval as LPSTR, byval as LPSTR, byval as BOOL, byval as BOOL, byval as BOOL, byval as ULONG, byval as ULONG ptr, byval as ULONG ptr, byval as ULONG ptr, byval as ULONG ptr, byval as ULONG) as BOOL
declare function ImageLoad alias "ImageLoad" (byval as LPSTR, byval as LPSTR) as PLOADED_IMAGE
declare function ImageUnload alias "ImageUnload" (byval as PLOADED_IMAGE) as BOOL
declare function ImageNtHeader alias "ImageNtHeader" (byval as PVOID) as PIMAGE_NT_HEADERS
declare function ImageDirectoryEntryToData alias "ImageDirectoryEntryToData" (byval as PVOID, byval as BOOLEAN, byval as USHORT, byval as PULONG) as PVOID
declare function ImageRvaToSection alias "ImageRvaToSection" (byval as PIMAGE_NT_HEADERS, byval as PVOID, byval as ULONG) as PIMAGE_SECTION_HEADER
declare function ImageRvaToVa alias "ImageRvaToVa" (byval as PIMAGE_NT_HEADERS, byval as PVOID, byval as ULONG, byval as PIMAGE_SECTION_HEADER ptr) as PVOID
declare function MapAndLoad alias "MapAndLoad" (byval as LPSTR, byval as LPSTR, byval as PLOADED_IMAGE, byval as BOOL, byval as BOOL) as BOOL
declare function GetImageConfigInformation alias "GetImageConfigInformation" (byval as PLOADED_IMAGE, byval as PIMAGE_LOAD_CONFIG_DIRECTORY) as BOOL
declare function GetImageUnusedHeaderBytes alias "GetImageUnusedHeaderBytes" (byval as PLOADED_IMAGE, byval as LPDWORD) as DWORD
declare function SetImageConfigInformation alias "SetImageConfigInformation" (byval as PLOADED_IMAGE, byval as PIMAGE_LOAD_CONFIG_DIRECTORY) as BOOL
declare function UnMapAndLoad alias "UnMapAndLoad" (byval as PLOADED_IMAGE) as BOOL
declare function MapDebugInformation alias "MapDebugInformation" (byval as HANDLE, byval as LPSTR, byval as LPSTR, byval as DWORD) as PIMAGE_DEBUG_INFORMATION
declare function UnmapDebugInformation alias "UnmapDebugInformation" (byval as PIMAGE_DEBUG_INFORMATION) as BOOL
declare function SearchTreeForFile alias "SearchTreeForFile" (byval as LPSTR, byval as LPSTR, byval as LPSTR) as BOOL
declare function MakeSureDirectoryPathExists alias "MakeSureDirectoryPathExists" (byval as LPCSTR) as BOOL
declare function UnDecorateSymbolName alias "UnDecorateSymbolName" (byval as LPCSTR, byval as LPSTR, byval as DWORD, byval as DWORD) as DWORD
declare function StackWalk alias "StackWalk" (byval as DWORD, byval as HANDLE, byval as HANDLE, byval as LPSTACKFRAME, byval as LPVOID, byval as PREAD_PROCESS_MEMORY_ROUTINE, byval as PFUNCTION_TABLE_ACCESS_ROUTINE, byval as PGET_MODULE_BASE_ROUTINE, byval as PTRANSLATE_ADDRESS_ROUTINE) as BOOL
declare function ImagehlpApiVersion alias "ImagehlpApiVersion" () as LPAPI_VERSION
declare function ImagehlpApiVersionEx alias "ImagehlpApiVersionEx" (byval as LPAPI_VERSION) as LPAPI_VERSION
declare function GetTimestampForLoadedLibrary alias "GetTimestampForLoadedLibrary" (byval as HMODULE) as DWORD
declare function RemovePrivateCvSymbolic alias "RemovePrivateCvSymbolic" (byval as PCHAR, byval as PCHAR ptr, byval as ULONG ptr) as BOOL
declare sub RemoveRelocations alias "RemoveRelocations" (byval as PCHAR)
declare function SymSetOptions alias "SymSetOptions" (byval as DWORD) as DWORD
declare function SymGetOptions alias "SymGetOptions" () as DWORD
declare function SymCleanup alias "SymCleanup" (byval as HANDLE) as BOOL
declare function SymEnumerateModules alias "SymEnumerateModules" (byval as HANDLE, byval as PSYM_ENUMMODULES_CALLBACK, byval as PVOID) as BOOL
declare function SymEnumerateSymbols alias "SymEnumerateSymbols" (byval as HANDLE, byval as DWORD, byval as PSYM_ENUMSYMBOLS_CALLBACK, byval as PVOID) as BOOL
declare function EnumerateLoadedModules alias "EnumerateLoadedModules" (byval as HANDLE, byval as PENUMLOADED_MODULES_CALLBACK, byval as PVOID) as BOOL
declare function SymFunctionTableAccess alias "SymFunctionTableAccess" (byval as HANDLE, byval as DWORD) as LPVOID
declare function SymGetModuleInfo alias "SymGetModuleInfo" (byval as HANDLE, byval as DWORD, byval as PIMAGEHLP_MODULE) as BOOL
declare function SymGetModuleBase alias "SymGetModuleBase" (byval as HANDLE, byval as DWORD) as DWORD
declare function SymGetSymFromAddr alias "SymGetSymFromAddr" (byval as HANDLE, byval as DWORD, byval as PDWORD, byval as PIMAGEHLP_SYMBOL) as BOOL
declare function SymGetSymFromName alias "SymGetSymFromName" (byval as HANDLE, byval as LPSTR, byval as PIMAGEHLP_SYMBOL) as BOOL
declare function SymGetSymNext alias "SymGetSymNext" (byval as HANDLE, byval as PIMAGEHLP_SYMBOL) as BOOL
declare function SymGetSymPrev alias "SymGetSymPrev" (byval as HANDLE, byval as PIMAGEHLP_SYMBOL) as BOOL
declare function SymGetLineFromAddr alias "SymGetLineFromAddr" (byval as HANDLE, byval as DWORD, byval as PDWORD, byval as PIMAGEHLP_LINE) as BOOL
declare function SymGetLineFromName alias "SymGetLineFromName" (byval as HANDLE, byval as LPSTR, byval as LPSTR, byval as DWORD, byval as PLONG, byval as PIMAGEHLP_LINE) as BOOL
declare function SymGetLineNext alias "SymGetLineNext" (byval as HANDLE, byval as PIMAGEHLP_LINE) as BOOL
declare function SymGetLinePrev alias "SymGetLinePrev" (byval as HANDLE, byval as PIMAGEHLP_LINE) as BOOL
declare function SymMatchFileName alias "SymMatchFileName" (byval as LPSTR, byval as LPSTR, byval as LPSTR ptr, byval as LPSTR ptr) as BOOL
declare function SymInitialize alias "SymInitialize" (byval as HANDLE, byval as LPSTR, byval as BOOL) as BOOL
declare function SymGetSearchPath alias "SymGetSearchPath" (byval as HANDLE, byval as LPSTR, byval as DWORD) as BOOL
declare function SymSetSearchPath alias "SymSetSearchPath" (byval as HANDLE, byval as LPSTR) as BOOL
declare function SymLoadModule alias "SymLoadModule" (byval as HANDLE, byval as HANDLE, byval as PSTR, byval as PSTR, byval as DWORD, byval as DWORD) as BOOL
declare function SymUnloadModule alias "SymUnloadModule" (byval as HANDLE, byval as DWORD) as BOOL
declare function SymUnDName alias "SymUnDName" (byval as PIMAGEHLP_SYMBOL, byval as LPSTR, byval as DWORD) as BOOL
declare function SymRegisterCallback alias "SymRegisterCallback" (byval as HANDLE, byval as PSYMBOL_REGISTERED_CALLBACK, byval as PVOID) as BOOL
declare function ImageGetDigestStream alias "ImageGetDigestStream" (byval as HANDLE, byval as DWORD, byval as DIGEST_FUNCTION, byval as DIGEST_HANDLE) as BOOL
declare function ImageAddCertificate alias "ImageAddCertificate" (byval as HANDLE, byval as LPWIN_CERTIFICATE, byval as PDWORD) as BOOL
declare function ImageRemoveCertificate alias "ImageRemoveCertificate" (byval as HANDLE, byval as DWORD) as BOOL
declare function ImageEnumerateCertificates alias "ImageEnumerateCertificates" (byval as HANDLE, byval as WORD, byval as PDWORD, byval as PDWORD, byval as DWORD) as BOOL
declare function ImageGetCertificateData alias "ImageGetCertificateData" (byval as HANDLE, byval as DWORD, byval as LPWIN_CERTIFICATE, byval as PDWORD) as BOOL
declare function ImageGetCertificateHeader alias "ImageGetCertificateHeader" (byval as HANDLE, byval as DWORD, byval as LPWIN_CERTIFICATE) as BOOL
declare function CopyPdb alias "CopyPdb" (byval as CHAR ptr, byval as CHAR ptr, byval as BOOL) as BOOL
declare function RemovePrivateCvSymbolicEx alias "RemovePrivateCvSymbolicEx" (byval as PCHAR, byval as ULONG, byval as PCHAR ptr, byval as ULONG ptr) as BOOL

#ifdef UNICODE
declare function MapFileAndCheckSum alias "MapFileAndCheckSumW" (byval as PWSTR, byval as LPDWORD, byval as LPDWORD) as DWORD
#else ''UNICODE
declare function MapFileAndCheckSum alias "MapFileAndCheckSumA" (byval as LPSTR, byval as LPDWORD, byval as LPDWORD) as DWORD
#endif ''UNICODE


#endif
