''
''
'' d3dx9xof -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9xof_bi__
#define __win_d3dx9xof_bi__

#include once "win/d3dx9.bi"

type D3DXF_FILEFORMAT as DWORD

#define D3DXF_FILEFORMAT_BINARY 0
#define D3DXF_FILEFORMAT_TEXT 1
#define D3DXF_FILEFORMAT_COMPRESSED 2

type D3DXF_FILESAVEOPTIONS as DWORD

#define D3DXF_FILESAVE_TOFILE &h00L
#define D3DXF_FILESAVE_TOWFILE &h01L

type D3DXF_FILELOADOPTIONS as DWORD

#define D3DXF_FILELOAD_FROMFILE &h00L
#define D3DXF_FILELOAD_FROMWFILE &h01L
#define D3DXF_FILELOAD_FROMRESOURCE &h02L
#define D3DXF_FILELOAD_FROMMEMORY &h03L

type D3DXF_FILELOADRESOURCE
	hModule as HMODULE
	lpName as LPCSTR
	lpType as LPCSTR
end type

type D3DXF_FILELOADMEMORY
	lpMemory as LPCVOID
	dSize as SIZE_T
end type

extern IID_ID3DXFile alias "IID_ID3DXFile" as GUID
extern IID_ID3DXFileSaveObject alias "IID_ID3DXFileSaveObject" as GUID
extern IID_ID3DXFileSaveData alias "IID_ID3DXFileSaveData" as GUID
extern IID_ID3DXFileEnumObject alias "IID_ID3DXFileEnumObject" as GUID
extern IID_ID3DXFileData alias "IID_ID3DXFileData" as GUID

type ID3DXFileVtbl_ as ID3DXFileVtbl

type ID3DXFile
	lpVtbl as ID3DXFileVtbl_ ptr
end type

type ID3DXFileEnumObject_ as ID3DXFileEnumObject
type ID3DXFileSaveObject_ as ID3DXFileSaveObject

type ID3DXFileVtbl
	QueryInterface as function(byval as ID3DXFile ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXFile ptr) as ULONG
	Release as function(byval as ID3DXFile ptr) as ULONG
	CreateEnumObject as function(byval as ID3DXFile ptr, byval as LPCVOID, byval as D3DXF_FILELOADOPTIONS, byval as ID3DXFileEnumObject_ ptr ptr) as HRESULT
	CreateSaveObject as function(byval as ID3DXFile ptr, byval as LPCVOID, byval as D3DXF_FILESAVEOPTIONS, byval as D3DXF_FILEFORMAT, byval as ID3DXFileSaveObject_ ptr ptr) as HRESULT
	RegisterTemplates as function(byval as ID3DXFile ptr, byval as LPCVOID, byval as SIZE_T) as HRESULT
	RegisterEnumTemplates as function(byval as ID3DXFile ptr, byval as ID3DXFileEnumObject_ ptr) as HRESULT
end type

type ID3DXFileSaveObjectVtbl_ as ID3DXFileSaveObjectVtbl

type ID3DXFileSaveObject
	lpVtbl as ID3DXFileSaveObjectVtbl_ ptr
end type

type ID3DXFileSaveData_ as ID3DXFileSaveData

type ID3DXFileSaveObjectVtbl
	QueryInterface as function(byval as ID3DXFileSaveObject ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXFileSaveObject ptr) as ULONG
	Release as function(byval as ID3DXFileSaveObject ptr) as ULONG
	GetFile as function(byval as ID3DXFileSaveObject ptr, byval as ID3DXFile ptr ptr) as HRESULT
	AddDataObject as function(byval as ID3DXFileSaveObject ptr, byval as GUID ptr, byval as LPCSTR, byval as GUID ptr, byval as SIZE_T, byval as LPCVOID, byval as ID3DXFileSaveData_ ptr ptr) as HRESULT
	Save as function(byval as ID3DXFileSaveObject ptr) as HRESULT
end type

type ID3DXFileSaveDataVtbl_ as ID3DXFileSaveDataVtbl

type ID3DXFileSaveData
	lpVtbl as ID3DXFileSaveDataVtbl_ ptr
end type

type ID3DXFileSaveDataVtbl
	QueryInterface as function(byval as ID3DXFileSaveData ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXFileSaveData ptr) as ULONG
	Release as function(byval as ID3DXFileSaveData ptr) as ULONG
	GetSave as function(byval as ID3DXFileSaveData ptr, byval as ID3DXFileSaveObject ptr ptr) as HRESULT
	GetName as function(byval as ID3DXFileSaveData ptr, byval as LPSTR, byval as SIZE_T ptr) as HRESULT
	GetId as function(byval as ID3DXFileSaveData ptr, byval as LPGUID) as HRESULT
	GetType as function(byval as ID3DXFileSaveData ptr, byval as GUID ptr) as HRESULT
	AddDataObject as function(byval as ID3DXFileSaveData ptr, byval as GUID ptr, byval as LPCSTR, byval as GUID ptr, byval as SIZE_T, byval as LPCVOID, byval as ID3DXFileSaveData ptr ptr) as HRESULT
	AddDataReference as function(byval as ID3DXFileSaveData ptr, byval as LPCSTR, byval as GUID ptr) as HRESULT
end type

type ID3DXFileEnumObjectVtbl_ as ID3DXFileEnumObjectVtbl

type ID3DXFileEnumObject
	lpVtbl as ID3DXFileEnumObjectVtbl_ ptr
end type

type ID3DXFileData_ as ID3DXFileData

type ID3DXFileEnumObjectVtbl
	QueryInterface as function(byval as ID3DXFileEnumObject ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXFileEnumObject ptr) as ULONG
	Release as function(byval as ID3DXFileEnumObject ptr) as ULONG
	GetFile as function(byval as ID3DXFileEnumObject ptr, byval as ID3DXFile ptr ptr) as HRESULT
	GetChildren as function(byval as ID3DXFileEnumObject ptr, byval as SIZE_T ptr) as HRESULT
	GetChild as function(byval as ID3DXFileEnumObject ptr, byval as SIZE_T, byval as ID3DXFileData_ ptr ptr) as HRESULT
	GetDataObjectById as function(byval as ID3DXFileEnumObject ptr, byval as GUID ptr, byval as ID3DXFileData_ ptr ptr) as HRESULT
	GetDataObjectByName as function(byval as ID3DXFileEnumObject ptr, byval as LPCSTR, byval as ID3DXFileData_ ptr ptr) as HRESULT
end type

type ID3DXFileDataVtbl_ as ID3DXFileDataVtbl

type ID3DXFileData
	lpVtbl as ID3DXFileDataVtbl_ ptr
end type

type ID3DXFileDataVtbl
	QueryInterface as function(byval as ID3DXFileData ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXFileData ptr) as ULONG
	Release as function(byval as ID3DXFileData ptr) as ULONG
	GetEnum as function(byval as ID3DXFileData ptr, byval as ID3DXFileEnumObject ptr ptr) as HRESULT
	GetName as function(byval as ID3DXFileData ptr, byval as LPSTR, byval as SIZE_T ptr) as HRESULT
	GetId as function(byval as ID3DXFileData ptr, byval as LPGUID) as HRESULT
	Lock as function(byval as ID3DXFileData ptr, byval as SIZE_T ptr, byval as LPCVOID ptr) as HRESULT
	Unlock as function(byval as ID3DXFileData ptr) as HRESULT
	GetType as function(byval as ID3DXFileData ptr, byval as GUID ptr) as HRESULT
	IsReference as function(byval as ID3DXFileData ptr) as BOOL
	GetChildren as function(byval as ID3DXFileData ptr, byval as SIZE_T ptr) as HRESULT
	GetChild as function(byval as ID3DXFileData ptr, byval as SIZE_T, byval as ID3DXFileData ptr ptr) as HRESULT
end type

declare function D3DXFileCreate alias "D3DXFileCreate" (byval lplpDirectXFile as ID3DXFile ptr ptr) as HRESULT

#define _FACD3DXF &h876

#define D3DXFERR_BADOBJECT MAKE_HRESULT( 1, _FACD3DXF, 900 )
#define D3DXFERR_BADVALUE MAKE_HRESULT( 1, _FACD3DXF, 901 )
#define D3DXFERR_BADTYPE MAKE_HRESULT( 1, _FACD3DXF, 902 )
#define D3DXFERR_NOTFOUND MAKE_HRESULT( 1, _FACD3DXF, 903 )
#define D3DXFERR_NOTDONEYET MAKE_HRESULT( 1, _FACD3DXF, 904 )
#define D3DXFERR_FILENOTFOUND MAKE_HRESULT( 1, _FACD3DXF, 905 )
#define D3DXFERR_RESOURCENOTFOUND MAKE_HRESULT( 1, _FACD3DXF, 906 )
#define D3DXFERR_BADRESOURCE MAKE_HRESULT( 1, _FACD3DXF, 907 )
#define D3DXFERR_BADFILETYPE MAKE_HRESULT( 1, _FACD3DXF, 908 )
#define D3DXFERR_BADFILEVERSION MAKE_HRESULT( 1, _FACD3DXF, 909 )
#define D3DXFERR_BADFILEFLOATSIZE MAKE_HRESULT( 1, _FACD3DXF, 910 )
#define D3DXFERR_BADFILE MAKE_HRESULT( 1, _FACD3DXF, 911 )
#define D3DXFERR_PARSEERROR MAKE_HRESULT( 1, _FACD3DXF, 912 )
#define D3DXFERR_BADARRAYSIZE MAKE_HRESULT( 1, _FACD3DXF, 913 )
#define D3DXFERR_BADDATAREFERENCE MAKE_HRESULT( 1, _FACD3DXF, 914 )
#define D3DXFERR_NOMOREOBJECTS MAKE_HRESULT( 1, _FACD3DXF, 915 )
#define D3DXFERR_NOMOREDATA MAKE_HRESULT( 1, _FACD3DXF, 916 )
#define D3DXFERR_BADCACHEFILE MAKE_HRESULT( 1, _FACD3DXF, 917 )

type LPD3DXFILE as ID3DXFile ptr
type LPLPD3DXFILE as ID3DXFile ptr ptr
type LPD3DXFILEENUMOBJECT as ID3DXFileEnumObject ptr
type LPLPD3DXFILEENUMOBJECT as ID3DXFileEnumObject ptr ptr
type LPD3DXFILESAVEOBJECT as ID3DXFileSaveObject ptr
type LPLPD3DXFILESAVEOBJECT as ID3DXFileSaveObject ptr ptr
type LPD3DXFILEDATA as ID3DXFileData ptr
type LPLPD3DXFILEDATA as ID3DXFileData ptr ptr
type LPD3DXFILESAVEDATA as ID3DXFileSaveData ptr
type LPLPD3DXFILESAVEDATA as ID3DXFileSaveData ptr ptr

#endif
