'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright 2011 Dylan Smith
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "d3dx9.bi"

extern "Windows"

#define __WINE_D3DX9XOF_H
type D3DXF_FILEFORMAT as DWORD
const D3DXF_FILEFORMAT_BINARY = 0
const D3DXF_FILEFORMAT_TEXT = 1
const D3DXF_FILEFORMAT_COMPRESSED = 2
type D3DXF_FILESAVEOPTIONS as DWORD
const D3DXF_FILESAVE_TOFILE = &h00
const D3DXF_FILESAVE_TOWFILE = &h01
type D3DXF_FILELOADOPTIONS as DWORD
const D3DXF_FILELOAD_FROMFILE = &h00
const D3DXF_FILELOAD_FROMWFILE = &h01
const D3DXF_FILELOAD_FROMRESOURCE = &h02
const D3DXF_FILELOAD_FROMMEMORY = &h03

type _D3DXF_FILELOADRESOURCE
	hModule as HMODULE
	lpName as const zstring ptr
	lpType as const zstring ptr
end type

type D3DXF_FILELOADRESOURCE as _D3DXF_FILELOADRESOURCE

type _D3DXF_FILELOADMEMORY
	lpMemory as any ptr
	dSize as SIZE_T_
end type

type D3DXF_FILELOADMEMORY as _D3DXF_FILELOADMEMORY
extern IID_ID3DXFile as const GUID
extern IID_ID3DXFileSaveObject as const GUID
extern IID_ID3DXFileSaveData as const GUID
extern IID_ID3DXFileEnumObject as const GUID
extern IID_ID3DXFileData as const GUID

type ID3DXFile as ID3DXFile_
type LPD3DXFILE as ID3DXFile ptr
type LPLPD3DXFILE as ID3DXFile ptr ptr
type ID3DXFileSaveObject as ID3DXFileSaveObject_
type LPD3DXFILESAVEOBJECT as ID3DXFileSaveObject ptr
type LPLPD3DXFILESAVEOBJECT as ID3DXFileSaveObject ptr ptr
type ID3DXFileSaveData as ID3DXFileSaveData_
type LPD3DXFILESAVEDATA as ID3DXFileSaveData ptr
type LPLPD3DXFILESAVEDATA as ID3DXFileSaveData ptr ptr
type ID3DXFileEnumObject as ID3DXFileEnumObject_
type LPD3DXFILEENUMOBJECT as ID3DXFileEnumObject ptr
type LPLPD3DXFILEENUMOBJECT as ID3DXFileEnumObject ptr ptr
type ID3DXFileData as ID3DXFileData_
type LPD3DXFILEDATA as ID3DXFileData ptr
type LPLPD3DXFILEDATA as ID3DXFileData ptr ptr
declare function D3DXFileCreate(byval file as ID3DXFile ptr ptr) as HRESULT
type ID3DXFileVtbl as ID3DXFileVtbl_

type ID3DXFile_
	lpVtbl as ID3DXFileVtbl ptr
end type

type ID3DXFileVtbl_
	QueryInterface as function(byval This as ID3DXFile ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXFile ptr) as ULONG
	Release as function(byval This as ID3DXFile ptr) as ULONG
	CreateEnumObject as function(byval This as ID3DXFile ptr, byval src as const any ptr, byval type as D3DXF_FILELOADOPTIONS, byval enum_obj as ID3DXFileEnumObject ptr ptr) as HRESULT
	CreateSaveObject as function(byval This as ID3DXFile ptr, byval data as const any ptr, byval flags as D3DXF_FILESAVEOPTIONS, byval format as D3DXF_FILEFORMAT, byval save_obj as ID3DXFileSaveObject ptr ptr) as HRESULT
	RegisterTemplates as function(byval This as ID3DXFile ptr, byval data as const any ptr, byval data_size as SIZE_T_) as HRESULT
	RegisterEnumTemplates as function(byval This as ID3DXFile ptr, byval enum_obj as ID3DXFileEnumObject ptr) as HRESULT
end type

type ID3DXFileSaveObjectVtbl as ID3DXFileSaveObjectVtbl_

type ID3DXFileSaveObject_
	lpVtbl as ID3DXFileSaveObjectVtbl ptr
end type

type ID3DXFileSaveObjectVtbl_
	QueryInterface as function(byval This as ID3DXFileSaveObject ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXFileSaveObject ptr) as ULONG
	Release as function(byval This as ID3DXFileSaveObject ptr) as ULONG
	GetFile as function(byval This as ID3DXFileSaveObject ptr, byval file as ID3DXFile ptr ptr) as HRESULT
	AddDataObject as function(byval This as ID3DXFileSaveObject ptr, byval template_guid as const GUID const ptr, byval name as const zstring ptr, byval guid as const GUID ptr, byval data_size as SIZE_T_, byval data as const any ptr, byval obj as ID3DXFileSaveData ptr ptr) as HRESULT
	Save as function(byval This as ID3DXFileSaveObject ptr) as HRESULT
end type

type ID3DXFileSaveDataVtbl as ID3DXFileSaveDataVtbl_

type ID3DXFileSaveData_
	lpVtbl as ID3DXFileSaveDataVtbl ptr
end type

type ID3DXFileSaveDataVtbl_
	QueryInterface as function(byval This as ID3DXFileSaveData ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXFileSaveData ptr) as ULONG
	Release as function(byval This as ID3DXFileSaveData ptr) as ULONG
	GetSave as function(byval This as ID3DXFileSaveData ptr, byval save_obj as ID3DXFileSaveObject ptr ptr) as HRESULT
	GetName as function(byval This as ID3DXFileSaveData ptr, byval name as zstring ptr, byval size as SIZE_T_ ptr) as HRESULT
	GetId as function(byval This as ID3DXFileSaveData ptr, byval as LPGUID) as HRESULT
	GetType as function(byval This as ID3DXFileSaveData ptr, byval as GUID ptr) as HRESULT
	AddDataObject as function(byval This as ID3DXFileSaveData ptr, byval template_guid as const GUID const ptr, byval name as const zstring ptr, byval guid as const GUID ptr, byval data_size as SIZE_T_, byval data as const any ptr, byval obj as ID3DXFileSaveData ptr ptr) as HRESULT
	AddDataReference as function(byval This as ID3DXFileSaveData ptr, byval name as const zstring ptr, byval id as const GUID ptr) as HRESULT
end type

type ID3DXFileEnumObjectVtbl as ID3DXFileEnumObjectVtbl_

type ID3DXFileEnumObject_
	lpVtbl as ID3DXFileEnumObjectVtbl ptr
end type

type ID3DXFileEnumObjectVtbl_
	QueryInterface as function(byval This as ID3DXFileEnumObject ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXFileEnumObject ptr) as ULONG
	Release as function(byval This as ID3DXFileEnumObject ptr) as ULONG
	GetFile as function(byval This as ID3DXFileEnumObject ptr, byval file as ID3DXFile ptr ptr) as HRESULT
	GetChildren as function(byval This as ID3DXFileEnumObject ptr, byval as SIZE_T_ ptr) as HRESULT
	GetChild as function(byval This as ID3DXFileEnumObject ptr, byval id as SIZE_T_, byval child as ID3DXFileData ptr ptr) as HRESULT
	GetDataObjectById as function(byval This as ID3DXFileEnumObject ptr, byval guid as const GUID const ptr, byval obj as ID3DXFileData ptr ptr) as HRESULT
	GetDataObjectByName as function(byval This as ID3DXFileEnumObject ptr, byval name as const zstring ptr, byval obj as ID3DXFileData ptr ptr) as HRESULT
end type

type ID3DXFileDataVtbl as ID3DXFileDataVtbl_

type ID3DXFileData_
	lpVtbl as ID3DXFileDataVtbl ptr
end type

type ID3DXFileDataVtbl_
	QueryInterface as function(byval This as ID3DXFileData ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXFileData ptr) as ULONG
	Release as function(byval This as ID3DXFileData ptr) as ULONG
	GetEnum as function(byval This as ID3DXFileData ptr, byval enum_obj as ID3DXFileEnumObject ptr ptr) as HRESULT
	GetName as function(byval This as ID3DXFileData ptr, byval name as zstring ptr, byval size as SIZE_T_ ptr) as HRESULT
	GetId as function(byval This as ID3DXFileData ptr, byval as LPGUID) as HRESULT
	Lock as function(byval This as ID3DXFileData ptr, byval data_size as SIZE_T_ ptr, byval data as const any ptr ptr) as HRESULT
	Unlock as function(byval This as ID3DXFileData ptr) as HRESULT
	GetType as function(byval This as ID3DXFileData ptr, byval as GUID ptr) as HRESULT
	IsReference as function(byval This as ID3DXFileData ptr) as WINBOOL
	GetChildren as function(byval This as ID3DXFileData ptr, byval as SIZE_T_ ptr) as HRESULT
	GetChild as function(byval This as ID3DXFileData ptr, byval id as SIZE_T_, byval child as ID3DXFileData ptr ptr) as HRESULT
end type

const _FACD3DXF = &h876
#define D3DXFERR_BADOBJECT MAKE_HRESULT(1, _FACD3DXF, 900)
#define D3DXFERR_BADVALUE MAKE_HRESULT(1, _FACD3DXF, 901)
#define D3DXFERR_BADTYPE MAKE_HRESULT(1, _FACD3DXF, 902)
#define D3DXFERR_NOTFOUND MAKE_HRESULT(1, _FACD3DXF, 903)
#define D3DXFERR_NOTDONEYET MAKE_HRESULT(1, _FACD3DXF, 904)
#define D3DXFERR_FILENOTFOUND MAKE_HRESULT(1, _FACD3DXF, 905)
#define D3DXFERR_RESOURCENOTFOUND MAKE_HRESULT(1, _FACD3DXF, 906)
#define D3DXFERR_BADRESOURCE MAKE_HRESULT(1, _FACD3DXF, 907)
#define D3DXFERR_BADFILETYPE MAKE_HRESULT(1, _FACD3DXF, 908)
#define D3DXFERR_BADFILEVERSION MAKE_HRESULT(1, _FACD3DXF, 909)
#define D3DXFERR_BADFILEFLOATSIZE MAKE_HRESULT(1, _FACD3DXF, 910)
#define D3DXFERR_BADFILE MAKE_HRESULT(1, _FACD3DXF, 911)
#define D3DXFERR_PARSEERROR MAKE_HRESULT(1, _FACD3DXF, 912)
#define D3DXFERR_BADARRAYSIZE MAKE_HRESULT(1, _FACD3DXF, 913)
#define D3DXFERR_BADDATAREFERENCE MAKE_HRESULT(1, _FACD3DXF, 914)
#define D3DXFERR_NOMOREOBJECTS MAKE_HRESULT(1, _FACD3DXF, 915)
#define D3DXFERR_NOMOREDATA MAKE_HRESULT(1, _FACD3DXF, 916)
#define D3DXFERR_BADCACHEFILE MAKE_HRESULT(1, _FACD3DXF, 917)

end extern
