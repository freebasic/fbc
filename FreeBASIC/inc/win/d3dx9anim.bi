''
''
'' d3dx9anim -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9anim_bi__
#define __win_d3dx9anim_bi__

extern IID_ID3DXAnimationSet alias "IID_ID3DXAnimationSet" as GUID
extern IID_ID3DXKeyframedAnimationSet alias "IID_ID3DXKeyframedAnimationSet" as GUID
extern IID_ID3DXCompressedAnimationSet alias "IID_ID3DXCompressedAnimationSet" as GUID
extern IID_ID3DXAnimationController alias "IID_ID3DXAnimationController" as GUID

enum D3DXMESHDATATYPE
	D3DXMESHTYPE_MESH = &h001
	D3DXMESHTYPE_PMESH = &h002
	D3DXMESHTYPE_PATCHMESH = &h003
	D3DXMESHTYPE_FORCE_DWORD = &h7fffffff
end enum

type D3DXMESHDATA
	Type as D3DXMESHDATATYPE
	union
		pMesh as LPD3DXMESH
		pPMesh as LPD3DXPMESH
		pPatchMesh as LPD3DXPATCHMESH
	end union
end type

type LPD3DXMESHDATA as D3DXMESHDATA ptr

type D3DXMESHCONTAINER
	Name as LPSTR
	MeshData as D3DXMESHDATA
	pMaterials as LPD3DXMATERIAL
	pEffects as LPD3DXEFFECTINSTANCE
	NumMaterials as DWORD
	pAdjacency as DWORD ptr
	pSkinInfo as LPD3DXSKININFO
	pNextMeshContainer as D3DXMESHCONTAINER ptr
end type

type LPD3DXMESHCONTAINER as D3DXMESHCONTAINER ptr

type D3DXFRAME
	Name as LPSTR
	TransformationMatrix as D3DXMATRIX
	pMeshContainer as LPD3DXMESHCONTAINER
	pFrameSibling as D3DXFRAME ptr
	pFrameFirstChild as D3DXFRAME ptr
end type

type LPD3DXFRAME as D3DXFRAME ptr
type LPD3DXALLOCATEHIERARCHY as ID3DXAllocateHierarchy ptr

type ID3DXAllocateHierarchyVtbl_ as ID3DXAllocateHierarchyVtbl

type ID3DXAllocateHierarchy
	lpVtbl as ID3DXAllocateHierarchyVtbl_ ptr
end type

type ID3DXAllocateHierarchyVtbl
	CreateFrame as function(byval as ID3DXAllocateHierarchy ptr, byval as LPCSTR, byval as LPD3DXFRAME ptr) as HRESULT
	CreateMeshContainer as function(byval as ID3DXAllocateHierarchy ptr, byval as LPCSTR, byval as D3DXMESHDATA ptr, byval as D3DXMATERIAL ptr, byval as D3DXEFFECTINSTANCE ptr, byval as DWORD, byval as DWORD ptr, byval as LPD3DXSKININFO, byval as LPD3DXMESHCONTAINER ptr) as HRESULT
	DestroyFrame as function(byval as ID3DXAllocateHierarchy ptr, byval as LPD3DXFRAME) as HRESULT
	DestroyMeshContainer as function(byval as ID3DXAllocateHierarchy ptr, byval as LPD3DXMESHCONTAINER) as HRESULT
end type

type LPD3DXLOADUSERDATA as ID3DXLoadUserData ptr

type ID3DXLoadUserDataVtbl_ as ID3DXLoadUserDataVtbl

type ID3DXLoadUserData
	lpVtbl as ID3DXLoadUserDataVtbl_ ptr
end type

type ID3DXLoadUserDataVtbl
	LoadTopLevelData as function(byval as LPD3DXFILEDATA) as HRESULT
	LoadFrameChildData as function(byval as LPD3DXFRAME, byval as LPD3DXFILEDATA) as HRESULT
	LoadMeshChildData as function(byval as LPD3DXMESHCONTAINER, byval as LPD3DXFILEDATA) as HRESULT
end type

type LPD3DXSAVEUSERDATA as ID3DXSaveUserData ptr

type ID3DXSaveUserDataVtbl_ as ID3DXSaveUserDataVtbl

type ID3DXSaveUserData
	lpVtbl as ID3DXSaveUserDataVtbl_ ptr
end type

type ID3DXSaveUserDataVtbl
	AddFrameChildData as function(byval as D3DXFRAME ptr, byval as LPD3DXFILESAVEOBJECT, byval as LPD3DXFILESAVEDATA) as HRESULT
	AddMeshChildData as function(byval as D3DXMESHCONTAINER ptr, byval as LPD3DXFILESAVEOBJECT, byval as LPD3DXFILESAVEDATA) as HRESULT
	AddTopLevelDataObjectsPre as function(byval as LPD3DXFILESAVEOBJECT) as HRESULT
	AddTopLevelDataObjectsPost as function(byval as LPD3DXFILESAVEOBJECT) as HRESULT
	RegisterTemplates as function(byval as LPD3DXFILE) as HRESULT
	SaveTemplates as function(byval as LPD3DXFILESAVEOBJECT) as HRESULT
end type

enum D3DXCALLBACK_SEARCH_FLAGS
	D3DXCALLBACK_SEARCH_EXCLUDING_INITIAL_POSITION = &h01
	D3DXCALLBACK_SEARCH_BEHIND_INITIAL_POSITION = &h02
	D3DXCALLBACK_SEARCH_FORCE_DWORD = &h7fffffff
end enum

type LPD3DXANIMATIONSET as ID3DXAnimationSet ptr

type ID3DXAnimationSetVtbl_ as ID3DXAnimationSetVtbl

type ID3DXAnimationSet
	lpVtbl as ID3DXAnimationSetVtbl_ ptr
end type

type ID3DXAnimationSetVtbl
	QueryInterface as function(byval as ID3DXAnimationSet ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXAnimationSet ptr) as ULONG
	Release as function(byval as ID3DXAnimationSet ptr) as ULONG
	GetName as function(byval as ID3DXAnimationSet ptr) as LPCSTR
	GetPeriod as function(byval as ID3DXAnimationSet ptr) as DOUBLE
	GetPeriodicPosition as function(byval as ID3DXAnimationSet ptr, byval as DOUBLE) as DOUBLE
	GetNumAnimations as function(byval as ID3DXAnimationSet ptr) as UINT
	GetAnimationNameByIndex as function(byval as ID3DXAnimationSet ptr, byval as UINT, byval as LPCSTR ptr) as HRESULT
	GetAnimationIndexByName as function(byval as ID3DXAnimationSet ptr, byval as LPCSTR, byval as UINT ptr) as HRESULT
	GetSRT as function(byval as ID3DXAnimationSet ptr, byval as DOUBLE, byval as UINT, byval as D3DXVECTOR3 ptr, byval as D3DXQUATERNION ptr, byval as D3DXVECTOR3 ptr) as HRESULT
	GetCallback as function(byval as ID3DXAnimationSet ptr, byval as DOUBLE, byval as DWORD, byval as DOUBLE ptr, byval as LPVOID ptr) as HRESULT
end type

enum D3DXPLAYBACK_TYPE
	D3DXPLAY_LOOP = 0
	D3DXPLAY_ONCE = 1
	D3DXPLAY_PINGPONG = 2
	D3DXPLAY_FORCE_DWORD = &h7fffffff
end enum

type D3DXKEY_VECTOR3
	Time as FLOAT
	Value as D3DXVECTOR3
end type

type LPD3DXKEY_VECTOR3 as D3DXKEY_VECTOR3 ptr

type D3DXKEY_QUATERNION
	Time as FLOAT
	Value as D3DXQUATERNION
end type

type LPD3DXKEY_QUATERNION as D3DXKEY_QUATERNION ptr

type D3DXKEY_CALLBACK
	Time as FLOAT
	pCallbackData as LPVOID
end type

type LPD3DXKEY_CALLBACK as D3DXKEY_CALLBACK ptr

enum D3DXCOMPRESSION_FLAGS
	D3DXCOMPRESS_DEFAULT = &h00
	D3DXCOMPRESS_FORCE_DWORD = &h7fffffff
end enum

type LPD3DXKEYFRAMEDANIMATIONSET as ID3DXKeyframedAnimationSet ptr

type ID3DXKeyframedAnimationSetVtbl_ as ID3DXKeyframedAnimationSetVtbl

type ID3DXKeyframedAnimationSet
	lpVtbl as ID3DXKeyframedAnimationSetVtbl_ ptr
end type

type ID3DXKeyframedAnimationSetVtbl
	QueryInterface as function(byval as ID3DXKeyframedAnimationSet ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXKeyframedAnimationSet ptr) as ULONG
	Release as function(byval as ID3DXKeyframedAnimationSet ptr) as ULONG
	GetName as function(byval as ID3DXKeyframedAnimationSet ptr) as LPCSTR
	GetPeriod as function(byval as ID3DXKeyframedAnimationSet ptr) as DOUBLE
	GetPeriodicPosition as function(byval as ID3DXKeyframedAnimationSet ptr, byval as DOUBLE) as DOUBLE
	GetNumAnimations as function(byval as ID3DXKeyframedAnimationSet ptr) as UINT
	GetAnimationNameByIndex as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as LPCSTR ptr) as HRESULT
	GetAnimationIndexByName as function(byval as ID3DXKeyframedAnimationSet ptr, byval as LPCSTR, byval as UINT ptr) as HRESULT
	GetSRT as function(byval as ID3DXKeyframedAnimationSet ptr, byval as DOUBLE, byval as UINT, byval as D3DXVECTOR3 ptr, byval as D3DXQUATERNION ptr, byval as D3DXVECTOR3 ptr) as HRESULT
	GetCallback as function(byval as ID3DXKeyframedAnimationSet ptr, byval as DOUBLE, byval as DWORD, byval as DOUBLE ptr, byval as LPVOID ptr) as HRESULT
	GetPlaybackType as function(byval as ID3DXKeyframedAnimationSet ptr) as D3DXPLAYBACK_TYPE
	GetSourceTicksPerSecond as function(byval as ID3DXKeyframedAnimationSet ptr) as DOUBLE
	GetNumScaleKeys as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT) as UINT
	GetScaleKeys as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as LPD3DXKEY_VECTOR3) as HRESULT
	GetScaleKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as UINT, byval as LPD3DXKEY_VECTOR3) as HRESULT
	SetScaleKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as UINT, byval as LPD3DXKEY_VECTOR3) as HRESULT
	GetNumRotationKeys as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT) as UINT
	GetRotationKeys as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as LPD3DXKEY_QUATERNION) as HRESULT
	GetRotationKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as UINT, byval as LPD3DXKEY_QUATERNION) as HRESULT
	SetRotationKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as UINT, byval as LPD3DXKEY_QUATERNION) as HRESULT
	GetNumTranslationKeys as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT) as UINT
	GetTranslationKeys as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as LPD3DXKEY_VECTOR3) as HRESULT
	GetTranslationKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as UINT, byval as LPD3DXKEY_VECTOR3) as HRESULT
	SetTranslationKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as UINT, byval as LPD3DXKEY_VECTOR3) as HRESULT
	GetNumCallbackKeys as function(byval as ID3DXKeyframedAnimationSet ptr) as UINT
	GetCallbackKeys as function(byval as ID3DXKeyframedAnimationSet ptr, byval as LPD3DXKEY_CALLBACK) as HRESULT
	GetCallbackKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as LPD3DXKEY_CALLBACK) as HRESULT
	SetCallbackKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as LPD3DXKEY_CALLBACK) as HRESULT
	UnregisterScaleKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as UINT) as HRESULT
	UnregisterRotationKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as UINT) as HRESULT
	UnregisterTranslationKey as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT, byval as UINT) as HRESULT
	RegisterAnimationSRTKeys as function(byval as ID3DXKeyframedAnimationSet ptr, byval as LPCSTR, byval as UINT, byval as UINT, byval as UINT, byval as D3DXKEY_VECTOR3 ptr, byval as D3DXKEY_QUATERNION ptr, byval as D3DXKEY_VECTOR3 ptr, byval as DWORD ptr) as HRESULT
	Compress as function(byval as ID3DXKeyframedAnimationSet ptr, byval as DWORD, byval as FLOAT, byval as LPD3DXFRAME, byval as LPD3DXBUFFER ptr) as HRESULT
	UnregisterAnimation as function(byval as ID3DXKeyframedAnimationSet ptr, byval as UINT) as HRESULT
end type

type LPD3DXCOMPRESSEDANIMATIONSET as ID3DXCompressedAnimationSet ptr

type ID3DXCompressedAnimationSetVtbl_ as ID3DXCompressedAnimationSetVtbl

type ID3DXCompressedAnimationSet
	lpVtbl as ID3DXCompressedAnimationSetVtbl_ ptr
end type

type ID3DXCompressedAnimationSetVtbl
	QueryInterface as function(byval as ID3DXCompressedAnimationSet ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXCompressedAnimationSet ptr) as ULONG
	Release as function(byval as ID3DXCompressedAnimationSet ptr) as ULONG
	GetName as function(byval as ID3DXCompressedAnimationSet ptr) as LPCSTR
	GetPeriod as function(byval as ID3DXCompressedAnimationSet ptr) as DOUBLE
	GetPeriodicPosition as function(byval as ID3DXCompressedAnimationSet ptr, byval as DOUBLE) as DOUBLE
	GetNumAnimations as function(byval as ID3DXCompressedAnimationSet ptr) as UINT
	GetAnimationNameByIndex as function(byval as ID3DXCompressedAnimationSet ptr, byval as UINT, byval as LPCSTR ptr) as HRESULT
	GetAnimationIndexByName as function(byval as ID3DXCompressedAnimationSet ptr, byval as LPCSTR, byval as UINT ptr) as HRESULT
	GetSRT as function(byval as ID3DXCompressedAnimationSet ptr, byval as DOUBLE, byval as UINT, byval as D3DXVECTOR3 ptr, byval as D3DXQUATERNION ptr, byval as D3DXVECTOR3 ptr) as HRESULT
	GetCallback as function(byval as ID3DXCompressedAnimationSet ptr, byval as DOUBLE, byval as DWORD, byval as DOUBLE ptr, byval as LPVOID ptr) as HRESULT
	GetPlaybackType as function(byval as ID3DXCompressedAnimationSet ptr) as D3DXPLAYBACK_TYPE
	GetSourceTicksPerSecond as function(byval as ID3DXCompressedAnimationSet ptr) as DOUBLE
	GetCompressedData as function(byval as ID3DXCompressedAnimationSet ptr, byval as LPD3DXBUFFER ptr) as HRESULT
	GetNumCallbackKeys as function(byval as ID3DXCompressedAnimationSet ptr) as UINT
	GetCallbackKeys as function(byval as ID3DXCompressedAnimationSet ptr, byval as LPD3DXKEY_CALLBACK) as HRESULT
end type

enum D3DXPRIORITY_TYPE
	D3DXPRIORITY_LOW = 0
	D3DXPRIORITY_HIGH = 1
	D3DXPRIORITY_FORCE_DWORD = &h7fffffff
end enum

type D3DXTRACK_DESC
	Priority as D3DXPRIORITY_TYPE
	Weight as FLOAT
	Speed as FLOAT
	Position as DOUBLE
	Enable as BOOL
end type

type LPD3DXTRACK_DESC as D3DXTRACK_DESC ptr

enum D3DXEVENT_TYPE
	D3DXEVENT_TRACKSPEED = 0
	D3DXEVENT_TRACKWEIGHT = 1
	D3DXEVENT_TRACKPOSITION = 2
	D3DXEVENT_TRACKENABLE = 3
	D3DXEVENT_PRIORITYBLEND = 4
	D3DXEVENT_FORCE_DWORD = &h7fffffff
end enum

enum D3DXTRANSITION_TYPE
	D3DXTRANSITION_LINEAR = &h000
	D3DXTRANSITION_EASEINEASEOUT = &h001
	D3DXTRANSITION_FORCE_DWORD = &h7fffffff
end enum

type D3DXEVENT_DESC
	Type as D3DXEVENT_TYPE
	Track as UINT
	StartTime as DOUBLE
	Duration as DOUBLE
	Transition as D3DXTRANSITION_TYPE
	union
		Weight as FLOAT
		Speed as FLOAT
		Position as DOUBLE
		Enable as BOOL
	end union
end type

type LPD3DXEVENT_DESC as D3DXEVENT_DESC ptr

type D3DXEVENTHANDLE as DWORD
type LPD3DXEVENTHANDLE as D3DXEVENTHANDLE ptr
type LPD3DXANIMATIONCALLBACKHANDLER as ID3DXAnimationCallbackHandler ptr

type ID3DXAnimationCallbackHandlerVtbl_ as ID3DXAnimationCallbackHandlerVtbl

type ID3DXAnimationCallbackHandler
	lpVtbl as ID3DXAnimationCallbackHandlerVtbl_ ptr
end type

type ID3DXAnimationCallbackHandlerVtbl
	HandleCallback as function(byval as ID3DXAnimationCallbackHandler ptr, byval as UINT, byval as LPVOID) as HRESULT
end type

type LPD3DXANIMATIONCONTROLLER as ID3DXAnimationController ptr

type ID3DXAnimationControllerVtbl_ as ID3DXAnimationControllerVtbl

type ID3DXAnimationController
	lpVtbl as ID3DXAnimationControllerVtbl_ ptr
end type

type ID3DXAnimationControllerVtbl
	QueryInterface as function(byval as ID3DXAnimationController ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXAnimationController ptr) as ULONG
	Release as function(byval as ID3DXAnimationController ptr) as ULONG
	GetMaxNumAnimationOutputs as function(byval as ID3DXAnimationController ptr) as UINT
	GetMaxNumAnimationSets as function(byval as ID3DXAnimationController ptr) as UINT
	GetMaxNumTracks as function(byval as ID3DXAnimationController ptr) as UINT
	GetMaxNumEvents as function(byval as ID3DXAnimationController ptr) as UINT
	RegisterAnimationOutput as function(byval as ID3DXAnimationController ptr, byval as LPCSTR, byval as D3DXMATRIX ptr, byval as D3DXVECTOR3 ptr, byval as D3DXQUATERNION ptr, byval as D3DXVECTOR3 ptr) as HRESULT
	RegisterAnimationSet as function(byval as ID3DXAnimationController ptr, byval as LPD3DXANIMATIONSET) as HRESULT
	UnregisterAnimationSet as function(byval as ID3DXAnimationController ptr, byval as LPD3DXANIMATIONSET) as HRESULT
	GetNumAnimationSets as function(byval as ID3DXAnimationController ptr) as UINT
	GetAnimationSet as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as LPD3DXANIMATIONSET ptr) as HRESULT
	GetAnimationSetByName as function(byval as ID3DXAnimationController ptr, byval as LPCSTR, byval as LPD3DXANIMATIONSET ptr) as HRESULT
	AdvanceTime as function(byval as ID3DXAnimationController ptr, byval as DOUBLE, byval as LPD3DXANIMATIONCALLBACKHANDLER) as HRESULT
	ResetTime as function(byval as ID3DXAnimationController ptr) as HRESULT
	GetTime as function(byval as ID3DXAnimationController ptr) as DOUBLE
	SetTrackAnimationSet as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as LPD3DXANIMATIONSET) as HRESULT
	GetTrackAnimationSet as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as LPD3DXANIMATIONSET ptr) as HRESULT
	SetTrackPriority as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as D3DXPRIORITY_TYPE) as HRESULT
	SetTrackSpeed as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as FLOAT) as HRESULT
	SetTrackWeight as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as FLOAT) as HRESULT
	SetTrackPosition as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as DOUBLE) as HRESULT
	SetTrackEnable as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as BOOL) as HRESULT
	SetTrackDesc as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as LPD3DXTRACK_DESC) as HRESULT
	GetTrackDesc as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as LPD3DXTRACK_DESC) as HRESULT
	SetPriorityBlend as function(byval as ID3DXAnimationController ptr, byval as FLOAT) as HRESULT
	GetPriorityBlend as function(byval as ID3DXAnimationController ptr) as FLOAT
	KeyTrackSpeed as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as FLOAT, byval as DOUBLE, byval as DOUBLE, byval as D3DXTRANSITION_TYPE) as D3DXEVENTHANDLE
	KeyTrackWeight as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as FLOAT, byval as DOUBLE, byval as DOUBLE, byval as D3DXTRANSITION_TYPE) as D3DXEVENTHANDLE
	KeyTrackPosition as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as DOUBLE, byval as DOUBLE) as D3DXEVENTHANDLE
	KeyTrackEnable as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as BOOL, byval as DOUBLE) as D3DXEVENTHANDLE
	KeyPriorityBlend as function(byval as ID3DXAnimationController ptr, byval as FLOAT, byval as DOUBLE, byval as DOUBLE, byval as D3DXTRANSITION_TYPE) as D3DXEVENTHANDLE
	UnkeyEvent as function(byval as ID3DXAnimationController ptr, byval as D3DXEVENTHANDLE) as HRESULT
	UnkeyAllTrackEvents as function(byval as ID3DXAnimationController ptr, byval as UINT) as HRESULT
	UnkeyAllPriorityBlends as function(byval as ID3DXAnimationController ptr) as HRESULT
	GetCurrentTrackEvent as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as D3DXEVENT_TYPE) as D3DXEVENTHANDLE
	GetCurrentPriorityBlend as function(byval as ID3DXAnimationController ptr) as D3DXEVENTHANDLE
	GetUpcomingTrackEvent as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as D3DXEVENTHANDLE) as D3DXEVENTHANDLE
	GetUpcomingPriorityBlend as function(byval as ID3DXAnimationController ptr, byval as D3DXEVENTHANDLE) as D3DXEVENTHANDLE
	ValidateEvent as function(byval as ID3DXAnimationController ptr, byval as D3DXEVENTHANDLE) as HRESULT
	GetEventDesc as function(byval as ID3DXAnimationController ptr, byval as D3DXEVENTHANDLE, byval as LPD3DXEVENT_DESC) as HRESULT
	CloneAnimationController as function(byval as ID3DXAnimationController ptr, byval as UINT, byval as UINT, byval as UINT, byval as UINT, byval as LPD3DXANIMATIONCONTROLLER ptr) as HRESULT
end type

declare function D3DXLoadMeshHierarchyFromXInMemory alias "D3DXLoadMeshHierarchyFromXInMemory" (byval Memory as LPCVOID, byval SizeOfMemory as DWORD, byval MeshOptions as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval pAlloc as LPD3DXALLOCATEHIERARCHY, byval pUserDataLoader as LPD3DXLOADUSERDATA, byval ppFrameHierarchy as LPD3DXFRAME ptr, byval ppAnimController as LPD3DXANIMATIONCONTROLLER ptr) as HRESULT
declare function D3DXFrameDestroy alias "D3DXFrameDestroy" (byval pFrameRoot as LPD3DXFRAME, byval pAlloc as LPD3DXALLOCATEHIERARCHY) as HRESULT
declare function D3DXFrameAppendChild alias "D3DXFrameAppendChild" (byval pFrameParent as LPD3DXFRAME, byval pFrameChild as D3DXFRAME ptr) as HRESULT
declare function D3DXFrameFind alias "D3DXFrameFind" (byval pFrameRoot as D3DXFRAME ptr, byval Name as LPCSTR) as LPD3DXFRAME
declare function D3DXFrameRegisterNamedMatrices alias "D3DXFrameRegisterNamedMatrices" (byval pFrameRoot as LPD3DXFRAME, byval pAnimController as LPD3DXANIMATIONCONTROLLER) as HRESULT
declare function D3DXFrameNumNamedMatrices alias "D3DXFrameNumNamedMatrices" (byval pFrameRoot as D3DXFRAME ptr) as UINT
declare function D3DXFrameCalculateBoundingSphere alias "D3DXFrameCalculateBoundingSphere" (byval pFrameRoot as D3DXFRAME ptr, byval pObjectCenter as LPD3DXVECTOR3, byval pObjectRadius as FLOAT ptr) as HRESULT
declare function D3DXCreateKeyframedAnimationSet alias "D3DXCreateKeyframedAnimationSet" (byval pName as LPCSTR, byval TicksPerSecond as DOUBLE, byval Playback as D3DXPLAYBACK_TYPE, byval NumAnimations as UINT, byval NumCallbackKeys as UINT, byval pCallbackKeys as D3DXKEY_CALLBACK ptr, byval ppAnimationSet as LPD3DXKEYFRAMEDANIMATIONSET ptr) as HRESULT
declare function D3DXCreateCompressedAnimationSet alias "D3DXCreateCompressedAnimationSet" (byval pName as LPCSTR, byval TicksPerSecond as DOUBLE, byval Playback as D3DXPLAYBACK_TYPE, byval pCompressedData as LPD3DXBUFFER, byval NumCallbackKeys as UINT, byval pCallbackKeys as D3DXKEY_CALLBACK ptr, byval ppAnimationSet as LPD3DXCOMPRESSEDANIMATIONSET ptr) as HRESULT
declare function D3DXCreateAnimationController alias "D3DXCreateAnimationController" (byval MaxNumMatrices as UINT, byval MaxNumAnimationSets as UINT, byval MaxNumTracks as UINT, byval MaxNumEvents as UINT, byval ppAnimController as LPD3DXANIMATIONCONTROLLER ptr) as HRESULT

#ifdef UNICODE
declare function D3DXLoadMeshHierarchyFromX alias "D3DXLoadMeshHierarchyFromXW" (byval Filename as LPCWSTR, byval MeshOptions as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval pAlloc as LPD3DXALLOCATEHIERARCHY, byval pUserDataLoader as LPD3DXLOADUSERDATA, byval ppFrameHierarchy as LPD3DXFRAME ptr, byval ppAnimController as LPD3DXANIMATIONCONTROLLER ptr) as HRESULT
declare function D3DXSaveMeshHierarchyToFile alias "D3DXSaveMeshHierarchyToFileW" (byval Filename as LPCWSTR, byval XFormat as DWORD, byval pFrameRoot as D3DXFRAME ptr, byval pAnimController as LPD3DXANIMATIONCONTROLLER, byval pUserDataSaver as LPD3DXSAVEUSERDATA) as HRESULT
#else
declare function D3DXLoadMeshHierarchyFromX alias "D3DXLoadMeshHierarchyFromXA" (byval Filename as LPCSTR, byval MeshOptions as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval pAlloc as LPD3DXALLOCATEHIERARCHY, byval pUserDataLoader as LPD3DXLOADUSERDATA, byval ppFrameHierarchy as LPD3DXFRAME ptr, byval ppAnimController as LPD3DXANIMATIONCONTROLLER ptr) as HRESULT
declare function D3DXSaveMeshHierarchyToFile alias "D3DXSaveMeshHierarchyToFileA" (byval Filename as LPCSTR, byval XFormat as DWORD, byval pFrameRoot as D3DXFRAME ptr, byval pAnimcontroller as LPD3DXANIMATIONCONTROLLER, byval pUserDataSaver as LPD3DXSAVEUSERDATA) as HRESULT
#endif

#endif
