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

#include once "_mingw_unicode.bi"

extern "Windows"

#define __WINE_D3DX9ANIM_H
extern IID_ID3DXAnimationSet as const GUID
extern IID_ID3DXKeyframedAnimationSet as const GUID
extern IID_ID3DXCompressedAnimationSet as const GUID
extern IID_ID3DXAnimationController as const GUID

type _D3DXMESHDATATYPE as long
enum
	D3DXMESHTYPE_MESH = 1
	D3DXMESHTYPE_PMESH = 2
	D3DXMESHTYPE_PATCHMESH = 3
	D3DXMESHTYPE_FORCE_DWORD = &h7fffffff
end enum

type D3DXMESHDATATYPE as _D3DXMESHDATATYPE

type _D3DXCALLBACK_SEARCH_FLAGS as long
enum
	D3DXCALLBACK_SEARCH_EXCLUDING_INITIAL_POSITION = &h00000001
	D3DXCALLBACK_SEARCH_BEHIND_INITIAL_POSITION = &h00000002
	D3DXCALLBACK_SEARCH_FORCE_DWORD = &h7fffffff
end enum

type D3DXCALLBACK_SEARCH_FLAGS as _D3DXCALLBACK_SEARCH_FLAGS

type _D3DXPLAYBACK_TYPE as long
enum
	D3DXPLAY_LOOP = 0
	D3DXPLAY_ONCE = 1
	D3DXPLAY_PINGPONG = 2
	D3DXPLAY_FORCE_DWORD = &h7fffffff
end enum

type D3DXPLAYBACK_TYPE as _D3DXPLAYBACK_TYPE

type _D3DXCOMPRESSION_FLAGS as long
enum
	D3DXCOMPRESSION_DEFAULT = &h00000000
	D3DXCOMPRESSION_FORCE_DWORD = &h7fffffff
end enum

type D3DXCOMPRESSION_FLAGS as _D3DXCOMPRESSION_FLAGS

type _D3DXPRIORITY_TYPE as long
enum
	D3DXPRIORITY_LOW = 0
	D3DXPRIORITY_HIGH = 1
	D3DXPRIORITY_FORCE_DWORD = &h7fffffff
end enum

type D3DXPRIORITY_TYPE as _D3DXPRIORITY_TYPE

type _D3DXEVENT_TYPE as long
enum
	D3DXEVENT_TRACKSPEED = 0
	D3DXEVENT_TRACKWEIGHT = 1
	D3DXEVENT_TRACKPOSITION = 2
	D3DXEVENT_TRACKENABLE = 3
	D3DXEVENT_PRIORITYBLEND = 4
	D3DXEVENT_FORCE_DWORD = &h7fffffff
end enum

type D3DXEVENT_TYPE as _D3DXEVENT_TYPE

type _D3DXTRANSITION_TYPE as long
enum
	D3DXTRANSITION_LINEAR = 0
	D3DXTRANSITION_EASEINEASEOUT = 1
	D3DXTRANSITION_FORCE_DWORD = &h7fffffff
end enum

type D3DXTRANSITION_TYPE as _D3DXTRANSITION_TYPE

type _D3DXMESHDATA
	as D3DXMESHDATATYPE Type

	union
		pMesh as ID3DXMesh ptr
		pPMesh as ID3DXPMesh ptr
		pPatchMesh as ID3DXPatchMesh ptr
	end union
end type

type D3DXMESHDATA as _D3DXMESHDATA
type LPD3DXMESHDATA as _D3DXMESHDATA ptr

type _D3DXMESHCONTAINER
	Name as zstring ptr
	MeshData as D3DXMESHDATA
	pMaterials as LPD3DXMATERIAL
	pEffects as LPD3DXEFFECTINSTANCE
	NumMaterials as DWORD
	pAdjacency as DWORD ptr
	pSkinInfo as ID3DXSkinInfo ptr
	pNextMeshContainer as _D3DXMESHCONTAINER ptr
end type

type D3DXMESHCONTAINER as _D3DXMESHCONTAINER
type LPD3DXMESHCONTAINER as _D3DXMESHCONTAINER ptr

type _D3DXFRAME
	Name as zstring ptr
	TransformationMatrix as D3DXMATRIX
	pMeshContainer as LPD3DXMESHCONTAINER
	pFrameSibling as _D3DXFRAME ptr
	pFrameFirstChild as _D3DXFRAME ptr
end type

type D3DXFRAME as _D3DXFRAME
type LPD3DXFRAME as _D3DXFRAME ptr

type _D3DXKEY_VECTOR3
	Time as FLOAT
	Value as D3DXVECTOR3
end type

type D3DXKEY_VECTOR3 as _D3DXKEY_VECTOR3
type LPD3DXKEY_VECTOR3 as _D3DXKEY_VECTOR3 ptr

type _D3DXKEY_QUATERNION
	Time as FLOAT
	Value as D3DXQUATERNION
end type

type D3DXKEY_QUATERNION as _D3DXKEY_QUATERNION
type LPD3DXKEY_QUATERNION as _D3DXKEY_QUATERNION ptr

type _D3DXKEY_CALLBACK
	Time as single
	pCallbackData as any ptr
end type

type D3DXKEY_CALLBACK as _D3DXKEY_CALLBACK
type LPD3DXKEY_CALLBACK as _D3DXKEY_CALLBACK ptr

type _D3DXTRACK_DESC
	Priority as D3DXPRIORITY_TYPE
	Weight as FLOAT
	Speed as FLOAT
	Position as DOUBLE
	Enable as WINBOOL
end type

type D3DXTRACK_DESC as _D3DXTRACK_DESC
type LPD3DXTRACK_DESC as _D3DXTRACK_DESC ptr

type _D3DXEVENT_DESC
	as D3DXEVENT_TYPE Type
	Track as UINT
	StartTime as DOUBLE
	Duration as DOUBLE
	Transition as D3DXTRANSITION_TYPE

	union
		Weight as FLOAT
		Speed as FLOAT
		Position as DOUBLE
		Enable as WINBOOL
	end union
end type

type D3DXEVENT_DESC as _D3DXEVENT_DESC
type LPD3DXEVENT_DESC as _D3DXEVENT_DESC ptr
type D3DXEVENTHANDLE as DWORD
type LPD3DXEVENTHANDLE as DWORD ptr
type LPD3DXALLOCATEHIERARCHY as ID3DXAllocateHierarchy ptr
type LPD3DXLOADUSERDATA as ID3DXLoadUserData ptr
type LPD3DXSAVEUSERDATA as ID3DXSaveUserData ptr
type LPD3DXANIMATIONSET as ID3DXAnimationSet ptr
type LPD3DXKEYFRAMEDANIMATIONSET as ID3DXKeyframedAnimationSet ptr
type LPD3DXCOMPRESSEDANIMATIONSET as ID3DXCompressedAnimationSet ptr
type LPD3DXANIMATIONCALLBACKHANDLER as ID3DXAnimationCallbackHandler ptr
type LPD3DXANIMATIONCONTROLLER as ID3DXAnimationController ptr
type ID3DXAllocateHierarchyVtbl as ID3DXAllocateHierarchyVtbl_

type ID3DXAllocateHierarchy
	lpVtbl as ID3DXAllocateHierarchyVtbl ptr
end type

type ID3DXAllocateHierarchyVtbl_
	CreateFrame as function(byval This as ID3DXAllocateHierarchy ptr, byval name as const zstring ptr, byval new_frame as D3DXFRAME ptr ptr) as HRESULT
	CreateMeshContainer as function(byval This as ID3DXAllocateHierarchy ptr, byval name as const zstring ptr, byval mesh_data as const D3DXMESHDATA ptr, byval materials as const D3DXMATERIAL ptr, byval effect_instances as const D3DXEFFECTINSTANCE ptr, byval num_materials as DWORD, byval adjacency as const DWORD ptr, byval skin_info as ID3DXSkinInfo ptr, byval new_mesh_container as D3DXMESHCONTAINER ptr ptr) as HRESULT
	DestroyFrame as function(byval This as ID3DXAllocateHierarchy ptr, byval frame as LPD3DXFRAME) as HRESULT
	DestroyMeshContainer as function(byval This as ID3DXAllocateHierarchy ptr, byval mesh_container as LPD3DXMESHCONTAINER) as HRESULT
end type

type ID3DXLoadUserDataVtbl as ID3DXLoadUserDataVtbl_

type ID3DXLoadUserData
	lpVtbl as ID3DXLoadUserDataVtbl ptr
end type

type ID3DXLoadUserDataVtbl_
	LoadTopLevelData as function(byval child_data as ID3DXFileData ptr) as HRESULT
	LoadFrameChildData as function(byval frame as D3DXFRAME ptr, byval child_data as ID3DXFileData ptr) as HRESULT
	LoadMeshChildData as function(byval mesh_container as D3DXMESHCONTAINER ptr, byval child_data as ID3DXFileData ptr) as HRESULT
end type

type ID3DXSaveUserDataVtbl as ID3DXSaveUserDataVtbl_

type ID3DXSaveUserData
	lpVtbl as ID3DXSaveUserDataVtbl ptr
end type

type ID3DXSaveUserDataVtbl_
	AddFrameChildData as function(byval frame as const D3DXFRAME ptr, byval save_obj as ID3DXFileSaveObject ptr, byval frame_data as ID3DXFileSaveData ptr) as HRESULT
	AddMeshChildData as function(byval mesh_container as const D3DXMESHCONTAINER ptr, byval save_obj as ID3DXFileSaveObject ptr, byval mesh_data as ID3DXFileSaveData ptr) as HRESULT
	AddTopLevelDataObjectsPre as function(byval save_obj as ID3DXFileSaveObject ptr) as HRESULT
	AddTopLevelDataObjectsPost as function(byval save_obj as ID3DXFileSaveObject ptr) as HRESULT
	RegisterTemplates as function(byval file as ID3DXFile ptr) as HRESULT
	SaveTemplates as function(byval save_obj as ID3DXFileSaveObject ptr) as HRESULT
end type

type ID3DXAnimationSetVtbl as ID3DXAnimationSetVtbl_

type ID3DXAnimationSet
	lpVtbl as ID3DXAnimationSetVtbl ptr
end type

type ID3DXAnimationSetVtbl_
	QueryInterface as function(byval This as ID3DXAnimationSet ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXAnimationSet ptr) as ULONG
	Release as function(byval This as ID3DXAnimationSet ptr) as ULONG
	GetName as function(byval This as ID3DXAnimationSet ptr) as const zstring ptr
	GetPeriod as function(byval This as ID3DXAnimationSet ptr) as DOUBLE
	GetPeriodicPosition as function(byval This as ID3DXAnimationSet ptr, byval position as DOUBLE) as DOUBLE
	GetNumAnimations as function(byval This as ID3DXAnimationSet ptr) as UINT
	GetAnimationNameByIndex as function(byval This as ID3DXAnimationSet ptr, byval index as UINT, byval name as const zstring ptr ptr) as HRESULT
	GetAnimationIndexByName as function(byval This as ID3DXAnimationSet ptr, byval name as const zstring ptr, byval index as UINT ptr) as HRESULT
	GetSRT as function(byval This as ID3DXAnimationSet ptr, byval periodic_position as DOUBLE, byval animation as UINT, byval scale as D3DXVECTOR3 ptr, byval rotation as D3DXQUATERNION ptr, byval translation as D3DXVECTOR3 ptr) as HRESULT
	GetCallback as function(byval This as ID3DXAnimationSet ptr, byval position as double, byval flags as DWORD, byval callback_position as double ptr, byval callback_data as any ptr ptr) as HRESULT
end type

type ID3DXKeyframedAnimationSetVtbl as ID3DXKeyframedAnimationSetVtbl_

type ID3DXKeyframedAnimationSet
	lpVtbl as ID3DXKeyframedAnimationSetVtbl ptr
end type

type ID3DXKeyframedAnimationSetVtbl_
	QueryInterface as function(byval This as ID3DXKeyframedAnimationSet ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXKeyframedAnimationSet ptr) as ULONG
	Release as function(byval This as ID3DXKeyframedAnimationSet ptr) as ULONG
	GetName as function(byval This as ID3DXKeyframedAnimationSet ptr) as const zstring ptr
	GetPeriod as function(byval This as ID3DXKeyframedAnimationSet ptr) as DOUBLE
	GetPeriodicPosition as function(byval This as ID3DXKeyframedAnimationSet ptr, byval position as DOUBLE) as DOUBLE
	GetNumAnimations as function(byval This as ID3DXKeyframedAnimationSet ptr) as UINT
	GetAnimationNameByIndex as function(byval This as ID3DXKeyframedAnimationSet ptr, byval index as UINT, byval name as const zstring ptr ptr) as HRESULT
	GetAnimationIndexByName as function(byval This as ID3DXKeyframedAnimationSet ptr, byval name as const zstring ptr, byval index as UINT ptr) as HRESULT
	GetSRT as function(byval This as ID3DXKeyframedAnimationSet ptr, byval periodic_position as DOUBLE, byval animation as UINT, byval scale as D3DXVECTOR3 ptr, byval rotation as D3DXQUATERNION ptr, byval translation as D3DXVECTOR3 ptr) as HRESULT
	GetCallback as function(byval This as ID3DXKeyframedAnimationSet ptr, byval position as double, byval flags as DWORD, byval callback_position as double ptr, byval callback_data as any ptr ptr) as HRESULT
	GetPlaybackType as function(byval This as ID3DXKeyframedAnimationSet ptr) as D3DXPLAYBACK_TYPE
	GetSourceTicksPerSecond as function(byval This as ID3DXKeyframedAnimationSet ptr) as DOUBLE
	GetNumScaleKeys as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT) as UINT
	GetScaleKeys as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval scale_keys as LPD3DXKEY_VECTOR3) as HRESULT
	GetScaleKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval key as UINT, byval scale_key as LPD3DXKEY_VECTOR3) as HRESULT
	SetScaleKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval key as UINT, byval scale_key as LPD3DXKEY_VECTOR3) as HRESULT
	GetNumRotationKeys as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT) as UINT
	GetRotationKeys as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval rotation_keys as LPD3DXKEY_QUATERNION) as HRESULT
	GetRotationKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval key as UINT, byval rotation_key as LPD3DXKEY_QUATERNION) as HRESULT
	SetRotationKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval key as UINT, byval rotation_key as LPD3DXKEY_QUATERNION) as HRESULT
	GetNumTranslationKeys as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT) as UINT
	GetTranslationKeys as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval translation_keys as LPD3DXKEY_VECTOR3) as HRESULT
	GetTranslationKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval key as UINT, byval translation_key as LPD3DXKEY_VECTOR3) as HRESULT
	SetTranslationKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval key as UINT, byval translation_key as LPD3DXKEY_VECTOR3) as HRESULT
	GetNumCallbackKeys as function(byval This as ID3DXKeyframedAnimationSet ptr) as UINT
	GetCallbackKeys as function(byval This as ID3DXKeyframedAnimationSet ptr, byval callback_keys as LPD3DXKEY_CALLBACK) as HRESULT
	GetCallbackKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval key as UINT, byval callback_key as LPD3DXKEY_CALLBACK) as HRESULT
	SetCallbackKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval key as UINT, byval callback_key as LPD3DXKEY_CALLBACK) as HRESULT
	UnregisterScaleKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval key as UINT) as HRESULT
	UnregisterRotationKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval key as UINT) as HRESULT
	UnregisterTranslationKey as function(byval This as ID3DXKeyframedAnimationSet ptr, byval animation as UINT, byval key as UINT) as HRESULT
	RegisterAnimationSRTKeys as function(byval This as ID3DXKeyframedAnimationSet ptr, byval name as const zstring ptr, byval num_scale_keys as UINT, byval num_rotation_keys as UINT, byval num_translation_keys as UINT, byval scale_keys as const D3DXKEY_VECTOR3 ptr, byval rotation_keys as const D3DXKEY_QUATERNION ptr, byval translation_keys as const D3DXKEY_VECTOR3 ptr, byval animation_index as DWORD ptr) as HRESULT
	Compress as function(byval This as ID3DXKeyframedAnimationSet ptr, byval flags as DWORD, byval lossiness as single, byval hierarchy as D3DXFRAME ptr, byval compressed_data as ID3DXBuffer ptr ptr) as HRESULT
	UnregisterAnimation as function(byval This as ID3DXKeyframedAnimationSet ptr, byval index as UINT) as HRESULT
end type

type ID3DXCompressedAnimationSetVtbl as ID3DXCompressedAnimationSetVtbl_

type ID3DXCompressedAnimationSet
	lpVtbl as ID3DXCompressedAnimationSetVtbl ptr
end type

type ID3DXCompressedAnimationSetVtbl_
	QueryInterface as function(byval This as ID3DXCompressedAnimationSet ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXCompressedAnimationSet ptr) as ULONG
	Release as function(byval This as ID3DXCompressedAnimationSet ptr) as ULONG
	GetName as function(byval This as ID3DXCompressedAnimationSet ptr) as const zstring ptr
	GetPeriod as function(byval This as ID3DXCompressedAnimationSet ptr) as DOUBLE
	GetPeriodicPosition as function(byval This as ID3DXCompressedAnimationSet ptr, byval position as DOUBLE) as DOUBLE
	GetNumAnimations as function(byval This as ID3DXCompressedAnimationSet ptr) as UINT
	GetAnimationNameByIndex as function(byval This as ID3DXCompressedAnimationSet ptr, byval index as UINT, byval name as const zstring ptr ptr) as HRESULT
	GetAnimationIndexByName as function(byval This as ID3DXCompressedAnimationSet ptr, byval name as const zstring ptr, byval index as UINT ptr) as HRESULT
	GetSRT as function(byval This as ID3DXCompressedAnimationSet ptr, byval periodic_position as DOUBLE, byval animation as UINT, byval scale as D3DXVECTOR3 ptr, byval rotation as D3DXQUATERNION ptr, byval translation as D3DXVECTOR3 ptr) as HRESULT
	GetCallback as function(byval This as ID3DXCompressedAnimationSet ptr, byval position as double, byval flags as DWORD, byval callback_position as double ptr, byval callback_data as any ptr ptr) as HRESULT
	GetPlaybackType as function(byval This as ID3DXCompressedAnimationSet ptr) as D3DXPLAYBACK_TYPE
	GetSourceTicksPerSecond as function(byval This as ID3DXCompressedAnimationSet ptr) as DOUBLE
	GetCompressedData as function(byval This as ID3DXCompressedAnimationSet ptr, byval compressed_data as ID3DXBuffer ptr ptr) as HRESULT
	GetNumCallbackKeys as function(byval This as ID3DXCompressedAnimationSet ptr) as UINT
	GetCallbackKeys as function(byval This as ID3DXCompressedAnimationSet ptr, byval callback_keys as LPD3DXKEY_CALLBACK) as HRESULT
end type

type ID3DXAnimationCallbackHandlerVtbl as ID3DXAnimationCallbackHandlerVtbl_

type ID3DXAnimationCallbackHandler
	lpVtbl as ID3DXAnimationCallbackHandlerVtbl ptr
end type

type ID3DXAnimationCallbackHandlerVtbl_
	HandleCallback as function(byval This as ID3DXAnimationCallbackHandler ptr, byval track as UINT, byval callback_data as any ptr) as HRESULT
end type

type ID3DXAnimationControllerVtbl as ID3DXAnimationControllerVtbl_

type ID3DXAnimationController
	lpVtbl as ID3DXAnimationControllerVtbl ptr
end type

type ID3DXAnimationControllerVtbl_
	QueryInterface as function(byval This as ID3DXAnimationController ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXAnimationController ptr) as ULONG
	Release as function(byval This as ID3DXAnimationController ptr) as ULONG
	GetMaxNumAnimationOutputs as function(byval This as ID3DXAnimationController ptr) as UINT
	GetMaxNumAnimationSets as function(byval This as ID3DXAnimationController ptr) as UINT
	GetMaxNumTracks as function(byval This as ID3DXAnimationController ptr) as UINT
	GetMaxNumEvents as function(byval This as ID3DXAnimationController ptr) as UINT
	RegisterAnimationOutput as function(byval This as ID3DXAnimationController ptr, byval name as const zstring ptr, byval matrix as D3DXMATRIX ptr, byval scale as D3DXVECTOR3 ptr, byval rotation as D3DXQUATERNION ptr, byval translation as D3DXVECTOR3 ptr) as HRESULT
	RegisterAnimationSet as function(byval This as ID3DXAnimationController ptr, byval anim_set as ID3DXAnimationSet ptr) as HRESULT
	UnregisterAnimationSet as function(byval This as ID3DXAnimationController ptr, byval anim_set as ID3DXAnimationSet ptr) as HRESULT
	GetNumAnimationSets as function(byval This as ID3DXAnimationController ptr) as UINT
	GetAnimationSet as function(byval This as ID3DXAnimationController ptr, byval index as UINT, byval anim_set as ID3DXAnimationSet ptr ptr) as HRESULT
	GetAnimationSetByName as function(byval This as ID3DXAnimationController ptr, byval name as const zstring ptr, byval anim_set as ID3DXAnimationSet ptr ptr) as HRESULT
	AdvanceTime as function(byval This as ID3DXAnimationController ptr, byval time_delta as double, byval callback_handler as ID3DXAnimationCallbackHandler ptr ptr) as HRESULT
	ResetTime as function(byval This as ID3DXAnimationController ptr) as HRESULT
	GetTime as function(byval This as ID3DXAnimationController ptr) as DOUBLE
	SetTrackAnimationSet as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval anim_set as ID3DXAnimationSet ptr) as HRESULT
	GetTrackAnimationSet as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval anim_set as ID3DXAnimationSet ptr ptr) as HRESULT
	GetTrackPriority as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval priority as D3DXPRIORITY_TYPE ptr) as HRESULT
	SetTrackSpeed as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval speed as FLOAT) as HRESULT
	SetTrackWeight as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval weight as FLOAT) as HRESULT
	SetTrackPosition as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval position as DOUBLE) as HRESULT
	SetTrackEnable as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval enable as WINBOOL) as HRESULT
	SetTrackDesc as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval desc as LPD3DXTRACK_DESC) as HRESULT
	GetTrackDesc as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval desc as LPD3DXTRACK_DESC) as HRESULT
	SetPriorityBlend as function(byval This as ID3DXAnimationController ptr, byval blend_weight as FLOAT) as HRESULT
	GetPriorityBlend as function(byval This as ID3DXAnimationController ptr) as FLOAT
	KeyTrackSpeed as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval new_speed as FLOAT, byval start_time as DOUBLE, byval duration as DOUBLE, byval transition as D3DXTRANSITION_TYPE) as D3DXEVENTHANDLE
	KeyTrackWeight as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval new_weight as FLOAT, byval start_time as DOUBLE, byval duration as DOUBLE, byval transition as D3DXTRANSITION_TYPE) as D3DXEVENTHANDLE
	KeyTrackPosition as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval new_position as DOUBLE, byval start_time as DOUBLE) as D3DXEVENTHANDLE
	KeyTrackEnable as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval new_enable as WINBOOL, byval start_time as DOUBLE) as D3DXEVENTHANDLE
	KeyPriorityBlend as function(byval This as ID3DXAnimationController ptr, byval new_blend_weight as FLOAT, byval start_time as DOUBLE, byval duration as DOUBLE, byval transition as D3DXTRANSITION_TYPE) as D3DXEVENTHANDLE
	UnkeyEvent as function(byval This as ID3DXAnimationController ptr, byval event as D3DXEVENTHANDLE) as HRESULT
	UnkeyAllTrackEvents as function(byval This as ID3DXAnimationController ptr, byval track as UINT) as HRESULT
	UnkeyAllPriorityBlends as function(byval This as ID3DXAnimationController ptr) as HRESULT
	GetCurrentTrackEvent as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval event_type as D3DXEVENT_TYPE) as D3DXEVENTHANDLE
	GetCurrentPriorityBlend as function(byval This as ID3DXAnimationController ptr) as D3DXEVENTHANDLE
	GetUpcomingTrackEvent as function(byval This as ID3DXAnimationController ptr, byval track as UINT, byval event as D3DXEVENTHANDLE) as D3DXEVENTHANDLE
	GetUpcomingPriorityBlend as function(byval This as ID3DXAnimationController ptr, byval handle as D3DXEVENTHANDLE) as D3DXEVENTHANDLE
	ValidateEvent as function(byval This as ID3DXAnimationController ptr, byval event as D3DXEVENTHANDLE) as HRESULT
	GetEventDesc as function(byval This as ID3DXAnimationController ptr, byval event as D3DXEVENTHANDLE, byval desc as LPD3DXEVENT_DESC) as HRESULT
	CloneAnimationController as function(byval This as ID3DXAnimationController ptr, byval max_num_anim_outputs as UINT, byval max_num_anim_sets as UINT, byval max_num_tracks as UINT, byval max_num_events as UINT, byval anim_controller as ID3DXAnimationController ptr ptr) as HRESULT
end type

declare function D3DXLoadMeshHierarchyFromXA(byval filename as const zstring ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval alloc as ID3DXAllocateHierarchy ptr, byval user_data_loader as ID3DXLoadUserData ptr, byval frame_hierarchy as D3DXFRAME ptr ptr, byval animation_controller as ID3DXAnimationController ptr ptr) as HRESULT
declare function D3DXLoadMeshHierarchyFromXW(byval filename as const wstring ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval alloc as ID3DXAllocateHierarchy ptr, byval user_data_loader as ID3DXLoadUserData ptr, byval frame_hierarchy as D3DXFRAME ptr ptr, byval animation_controller as ID3DXAnimationController ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXLoadMeshHierarchyFromX alias "D3DXLoadMeshHierarchyFromXW"(byval filename as const wstring ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval alloc as ID3DXAllocateHierarchy ptr, byval user_data_loader as ID3DXLoadUserData ptr, byval frame_hierarchy as D3DXFRAME ptr ptr, byval animation_controller as ID3DXAnimationController ptr ptr) as HRESULT
#else
	declare function D3DXLoadMeshHierarchyFromX alias "D3DXLoadMeshHierarchyFromXA"(byval filename as const zstring ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval alloc as ID3DXAllocateHierarchy ptr, byval user_data_loader as ID3DXLoadUserData ptr, byval frame_hierarchy as D3DXFRAME ptr ptr, byval animation_controller as ID3DXAnimationController ptr ptr) as HRESULT
#endif

declare function D3DXLoadMeshHierarchyFromXInMemory(byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval alloc as ID3DXAllocateHierarchy ptr, byval user_data_loader as ID3DXLoadUserData ptr, byval frame_hierarchy as D3DXFRAME ptr ptr, byval animation_controller as ID3DXAnimationController ptr ptr) as HRESULT
declare function D3DXSaveMeshHierarchyToFileA(byval filename as const zstring ptr, byval format as DWORD, byval frame_root as const D3DXFRAME ptr, byval animation_controller as ID3DXAnimationController ptr, byval user_data_saver as ID3DXSaveUserData ptr) as HRESULT
declare function D3DXSaveMeshHierarchyToFileW(byval filename as const wstring ptr, byval format as DWORD, byval frame_root as const D3DXFRAME ptr, byval animation_controller as ID3DXAnimationController ptr, byval user_data_saver as ID3DXSaveUserData ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXSaveMeshHierarchyToFile alias "D3DXSaveMeshHierarchyToFileW"(byval filename as const wstring ptr, byval format as DWORD, byval frame_root as const D3DXFRAME ptr, byval animation_controller as ID3DXAnimationController ptr, byval user_data_saver as ID3DXSaveUserData ptr) as HRESULT
#else
	declare function D3DXSaveMeshHierarchyToFile alias "D3DXSaveMeshHierarchyToFileA"(byval filename as const zstring ptr, byval format as DWORD, byval frame_root as const D3DXFRAME ptr, byval animation_controller as ID3DXAnimationController ptr, byval user_data_saver as ID3DXSaveUserData ptr) as HRESULT
#endif

declare function D3DXFrameDestroy(byval frame_root as D3DXFRAME ptr, byval alloc as ID3DXAllocateHierarchy ptr) as HRESULT
declare function D3DXFrameAppendChild(byval parent as D3DXFRAME ptr, byval child as const D3DXFRAME ptr) as HRESULT
declare function D3DXFrameFind(byval root as const D3DXFRAME ptr, byval name as const zstring ptr) as D3DXFRAME ptr
declare function D3DXFrameRegisterNamedMatrices(byval frame_root as D3DXFRAME ptr, byval animation_controller as ID3DXAnimationController ptr) as HRESULT
declare function D3DXFrameNumNamedMatrices(byval frame_root as const D3DXFRAME ptr) as UINT
declare function D3DXFrameCalculateBoundingSphere(byval frame_root as const D3DXFRAME ptr, byval center as D3DXVECTOR3 ptr, byval radius as FLOAT ptr) as HRESULT
declare function D3DXCreateKeyframedAnimationSet(byval name as const zstring ptr, byval ticks_per_second as double, byval playback_type as D3DXPLAYBACK_TYPE, byval animation_count as UINT, byval callback_key_count as UINT, byval callback_keys as const D3DXKEY_CALLBACK ptr, byval animation_set as ID3DXKeyframedAnimationSet ptr ptr) as HRESULT
declare function D3DXCreateCompressedAnimationSet(byval name as const zstring ptr, byval ticks_per_second as double, byval playback_type as D3DXPLAYBACK_TYPE, byval compressed_data as ID3DXBuffer ptr, byval callback_key_count as UINT, byval callback_keys as const D3DXKEY_CALLBACK ptr, byval animation_set as ID3DXCompressedAnimationSet ptr ptr) as HRESULT
declare function D3DXCreateAnimationController(byval max_animation_output_count as UINT, byval max_animation_set_count as UINT, byval max_track_count as UINT, byval max_event_count as UINT, byval animation_controller as ID3DXAnimationController ptr ptr) as HRESULT

end extern
