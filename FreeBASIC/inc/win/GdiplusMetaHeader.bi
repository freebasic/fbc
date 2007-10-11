''
''
'' GdiplusMetaHeader -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusMetaHeader_bi__
#define __win_GdiplusMetaHeader_bi__

type ENHMETAHEADER3
	iType as DWORD
	nSize as DWORD
	rclBounds as RECTL
	rclFrame as RECTL
	dSignature as DWORD
	nVersion as DWORD
	nBytes as DWORD
	nRecords as DWORD
	nHandles as WORD
	sReserved as WORD
	nDescription as DWORD
	offDescription as DWORD
	nPalEntries as DWORD
	szlDevice as SIZEL
	szlMillimeters as SIZEL
end type

type PWMFRect16 field=2
	Left as INT16
	Top as INT16
	Right as INT16
	Bottom as INT16
end type

type WmfPlaceableFileHeader field=2
	Key as UINT32
	Hmf as INT16
	BoundingBox as PWMFRect16
	Inch as INT16
	Reserved as UINT32
	Checksum as INT16
end type

#define GDIP_EMFPLUSFLAGS_DISPLAY &h00000001

type MetafileHeader
	Type_ as MetafileType
	Size as UINT
	Version as UINT
	EmfPlusFlags as UINT
	DpiX as REAL
	DpiY as REAL
	X as INT_
	Y as INT_
	Width as INT_
	Height as INT_
	EmfPlusHeaderSize as INT_
	LogicalDpiX as INT_
	LogicalDpiY as INT_

	declare function GetType () as MetafileType
	declare function GetMetafileSize () as UINT
	declare function GetVersion () as UINT
	declare function GetEmfPlusFlags () as UINT
	declare function GetDpiX () as REAL
	declare function GetDpiY () as REAL
	declare sub GetBounds (byval rect as Rect ptr)
	declare function IsWmf () as BOOL
	declare function IsWmfPlaceable () as BOOL
	declare function IsEmf () as BOOL
	declare function IsEmfOrEmfPlus () as BOOL
	declare function IsEmfPlus () as BOOL
	declare function IsEmfPlusDual () as BOOL
	declare function IsEmfPlusOnly () as BOOL
	declare function IsDisplay () as BOOL
	declare function GetWmfHeader () as METAHEADER ptr
	declare function GetEmfHeader () as ENHMETAHEADER3 ptr
end type

'' !!!WRITEME!!! the MetafileHeader methods

#endif
