'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2009 David Adam
''   Copyright (C) 2010 Tony Wasserka
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
#include once "d3dx9.bi"

extern "Windows"

#define __WINE_D3DX9MESH_H
extern IID_ID3DXBaseMesh as const GUID
extern IID_ID3DXMesh as const GUID
extern IID_ID3DXPMesh as const GUID
extern IID_ID3DXSPMesh as const GUID
extern IID_ID3DXSkinInfo as const GUID
extern IID_ID3DXPatchMesh as const GUID
extern IID_ID3DXPRTBuffer as const GUID
extern IID_ID3DXPRTCompBuffer as const GUID
extern IID_ID3DXTextureGutterHelper as const GUID
extern IID_ID3DXPRTEngine as const GUID
const UNUSED16 = &hffff
const UNUSED32 = &hffffffff

type _MAX_FVF_DECL_SIZE as long
enum
	MAX_FVF_DECL_SIZE = 64 + 1
end enum

type _D3DXMESH as long
enum
	D3DXMESH_32BIT = &h001
	D3DXMESH_DONOTCLIP = &h002
	D3DXMESH_POINTS = &h004
	D3DXMESH_RTPATCHES = &h008
	D3DXMESH_NPATCHES = &h4000
	D3DXMESH_VB_SYSTEMMEM = &h010
	D3DXMESH_VB_MANAGED = &h020
	D3DXMESH_VB_WRITEONLY = &h040
	D3DXMESH_VB_DYNAMIC = &h080
	D3DXMESH_VB_SOFTWAREPROCESSING = &h8000
	D3DXMESH_IB_SYSTEMMEM = &h100
	D3DXMESH_IB_MANAGED = &h200
	D3DXMESH_IB_WRITEONLY = &h400
	D3DXMESH_IB_DYNAMIC = &h800
	D3DXMESH_IB_SOFTWAREPROCESSING = &h10000
	D3DXMESH_VB_SHARE = &h1000
	D3DXMESH_USEHWONLY = &h2000
	D3DXMESH_SYSTEMMEM = &h110
	D3DXMESH_MANAGED = &h220
	D3DXMESH_WRITEONLY = &h440
	D3DXMESH_DYNAMIC = &h880
	D3DXMESH_SOFTWAREPROCESSING = &h18000
end enum

type _D3DXMESHOPT as long
enum
	D3DXMESHOPT_DEVICEINDEPENDENT = &h00400000
	D3DXMESHOPT_COMPACT = &h01000000
	D3DXMESHOPT_ATTRSORT = &h02000000
	D3DXMESHOPT_VERTEXCACHE = &h04000000
	D3DXMESHOPT_STRIPREORDER = &h08000000
	D3DXMESHOPT_IGNOREVERTS = &h10000000
	D3DXMESHOPT_DONOTSPLIT = &h20000000
end enum

type _D3DXPATCHMESHTYPE as long
enum
	D3DXPATCHMESH_RECT = 1
	D3DXPATCHMESH_TRI = 2
	D3DXPATCHMESH_NPATCH = 3
	D3DXPATCHMESH_FORCE_DWORD = &h7fffffff
end enum

type D3DXPATCHMESHTYPE as _D3DXPATCHMESHTYPE

type _D3DXPATCHMESH as long
enum
	D3DXPATCHMESH_DEFAULT = 0
end enum

type _D3DXMESHSIMP as long
enum
	D3DXMESHSIMP_VERTEX = &h1
	D3DXMESHSIMP_FACE = &h2
end enum

type D3DXCLEANTYPE as long
enum
	D3DXCLEAN_BACKFACING = &h00000001
	D3DXCLEAN_BOWTIES = &h00000002
	D3DXCLEAN_SKINNING = D3DXCLEAN_BACKFACING
	D3DXCLEAN_OPTIMIZATION = D3DXCLEAN_BACKFACING
	D3DXCLEAN_SIMPLIFICATION = D3DXCLEAN_BACKFACING or D3DXCLEAN_BOWTIES
end enum

type _D3DXTANGENT as long
enum
	D3DXTANGENT_WRAP_U = &h0001
	D3DXTANGENT_WRAP_V = &h0002
	D3DXTANGENT_WRAP_UV = &h0003
	D3DXTANGENT_DONT_NORMALIZE_PARTIALS = &h0004
	D3DXTANGENT_DONT_ORTHOGONALIZE = &h0008
	D3DXTANGENT_ORTHOGONALIZE_FROM_V = &h0010
	D3DXTANGENT_ORTHOGONALIZE_FROM_U = &h0020
	D3DXTANGENT_WEIGHT_BY_AREA = &h0040
	D3DXTANGENT_WEIGHT_EQUAL = &h0080
	D3DXTANGENT_WIND_CW = &h0100
	D3DXTANGENT_CALCULATE_NORMALS = &h0200
	D3DXTANGENT_GENERATE_IN_PLACE = &h0400
end enum

type D3DXTANGENT as _D3DXTANGENT

type _D3DXIMT as long
enum
	D3DXIMT_WRAP_U = &h01
	D3DXIMT_WRAP_V = &h02
	D3DXIMT_WRAP_UV = &h03
end enum

type D3DXIMT as _D3DXIMT

type _D3DXUVATLAS as long
enum
	D3DXUVATLAS_DEFAULT = &h00
	D3DXUVATLAS_GEODESIC_FAST = &h01
	D3DXUVATLAS_GEODESIC_QUALITY = &h02
end enum

type D3DXUVATLAS as _D3DXUVATLAS

type _D3DXEFFECTDEFAULTTYPE as long
enum
	D3DXEDT_STRING = 1
	D3DXEDT_FLOATS = 2
	D3DXEDT_DWORD = 3
	D3DXEDT_FORCEDWORD = &h7fffffff
end enum

type D3DXEFFECTDEFAULTTYPE as _D3DXEFFECTDEFAULTTYPE

type _D3DXWELDEPSILONSFLAGS as long
enum
	D3DXWELDEPSILONS_WELDALL = &h1
	D3DXWELDEPSILONS_WELDPARTIALMATCHES = &h2
	D3DXWELDEPSILONS_DONOTREMOVEVERTICES = &h4
	D3DXWELDEPSILONS_DONOTSPLIT = &h8
end enum

type _D3DXSHCOMPRESSQUALITYTYPE as long
enum
	D3DXSHCQUAL_FASTLOWQUALITY = 1
	D3DXSHCQUAL_SLOWHIGHQUALITY = 2
	D3DXSHCQUAL_FORCE_DWORD = &h7fffffff
end enum

type D3DXSHCOMPRESSQUALITYTYPE as _D3DXSHCOMPRESSQUALITYTYPE

type _D3DXSHGPUSIMOPT as long
enum
	D3DXSHGPUSIMOPT_SHADOWRES256 = 1
	D3DXSHGPUSIMOPT_SHADOWRES512 = 0
	D3DXSHGPUSIMOPT_SHADOWRES1024 = 2
	D3DXSHGPUSIMOPT_SHADOWRES2048 = 3
	D3DXSHGPUSIMOPT_HIGHQUALITY = 4
	D3DXSHGPUSIMOPT_FORCE_DWORD = &h7fffffff
end enum

type D3DXSHGPUSIMOPT as _D3DXSHGPUSIMOPT
type LPD3DXBASEMESH as ID3DXBaseMesh ptr
type ID3DXMesh as ID3DXMesh_
type LPD3DXMESH as ID3DXMesh ptr
type LPD3DXPMESH as ID3DXPMesh ptr
type LPD3DXSPMESH as ID3DXSPMesh ptr
type LPD3DXSKININFO as ID3DXSkinInfo ptr
type LPD3DXPATCHMESH as ID3DXPatchMesh ptr
type LPD3DXPRTBUFFER as ID3DXPRTBuffer ptr
type LPD3DXPRTCOMPBUFFER as ID3DXPRTCompBuffer ptr
type LPD3DXPRTENGINE as ID3DXPRTEngine ptr
type ID3DXTextureGutterHelper as ID3DXTextureGutterHelper_
type LPD3DXTEXTUREGUTTERHELPER as ID3DXTextureGutterHelper ptr

type _D3DXATTRIBUTERANGE
	AttribId as DWORD
	FaceStart as DWORD
	FaceCount as DWORD
	VertexStart as DWORD
	VertexCount as DWORD
end type

type D3DXATTRIBUTERANGE as _D3DXATTRIBUTERANGE
type LPD3DXATTRIBUTERANGE as D3DXATTRIBUTERANGE ptr

type _D3DXMATERIAL
	MatD3D as D3DMATERIAL9
	pTextureFilename as zstring ptr
end type

type D3DXMATERIAL as _D3DXMATERIAL
type LPD3DXMATERIAL as _D3DXMATERIAL ptr

type _D3DXEFFECTDEFAULT
	pParamName as zstring ptr
	as D3DXEFFECTDEFAULTTYPE Type
	NumBytes as DWORD
	pValue as any ptr
end type

type D3DXEFFECTDEFAULT as _D3DXEFFECTDEFAULT
type LPD3DXEFFECTDEFAULT as _D3DXEFFECTDEFAULT ptr

type _D3DXEFFECTINSTANCE
	pEffectFilename as zstring ptr
	NumDefaults as DWORD
	pDefaults as LPD3DXEFFECTDEFAULT
end type

type D3DXEFFECTINSTANCE as _D3DXEFFECTINSTANCE
type LPD3DXEFFECTINSTANCE as _D3DXEFFECTINSTANCE ptr

type _D3DXATTRIBUTEWEIGHTS
	Position as FLOAT
	Boundary as FLOAT
	Normal as FLOAT
	Diffuse as FLOAT
	Specular as FLOAT
	Texcoords(0 to 7) as FLOAT
	Tangent as FLOAT
	Binormal as FLOAT
end type

type D3DXATTRIBUTEWEIGHTS as _D3DXATTRIBUTEWEIGHTS
type LPD3DXATTRIBUTEWEIGHTS as _D3DXATTRIBUTEWEIGHTS ptr

type _D3DXWELDEPSILONS
	Position as FLOAT
	BlendWeights as FLOAT
	Normals as FLOAT
	PSize as FLOAT
	Specular as FLOAT
	Diffuse as FLOAT
	Texcoords(0 to 7) as FLOAT
	Tangent as FLOAT
	Binormal as FLOAT
	TessFactor as FLOAT
end type

type D3DXWELDEPSILONS as _D3DXWELDEPSILONS
type LPD3DXWELDEPSILONS as _D3DXWELDEPSILONS ptr

type _D3DXBONECOMBINATION
	AttribId as DWORD
	FaceStart as DWORD
	FaceCount as DWORD
	VertexStart as DWORD
	VertexCout as DWORD
	BoneId as DWORD ptr
end type

type D3DXBONECOMBINATION as _D3DXBONECOMBINATION
type LPD3DXBONECOMBINATION as _D3DXBONECOMBINATION ptr

type _D3DXPATCHINFO
	PatchType as D3DXPATCHMESHTYPE
	Degree as D3DDEGREETYPE
	Basis as D3DBASISTYPE
end type

type D3DXPATCHINFO as _D3DXPATCHINFO
type LPD3DXPATCHINFO as _D3DXPATCHINFO ptr

type _D3DXINTERSECTINFO
	FaceIndex as DWORD
	U as FLOAT
	V as FLOAT
	Dist as FLOAT
end type

type D3DXINTERSECTINFO as _D3DXINTERSECTINFO
type LPD3DXINTERSECTINFO as _D3DXINTERSECTINFO ptr

type _D3DXSHMATERIAL
	Diffuse as D3DCOLORVALUE
	bMirror as WINBOOL
	bSubSurf as WINBOOL
	RelativeIndexOfRefraction as FLOAT
	Absorption as D3DCOLORVALUE
	ReducedScattering as D3DCOLORVALUE
end type

type D3DXSHMATERIAL as _D3DXSHMATERIAL

type _D3DXSHPRTSPLITMESHVERTDATA
	uVertRemap as UINT
	uSubCluster as UINT
	ucVertStatus as UCHAR
end type

type D3DXSHPRTSPLITMESHVERTDATA as _D3DXSHPRTSPLITMESHVERTDATA

type _D3DXSHPRTSPLITMESHCLUSTERDATA
	uVertStart as UINT
	uVertLength as UINT
	uFaceStart as UINT
	uFaceLength as UINT
	uClusterStart as UINT
	uClusterLength as UINT
end type

type D3DXSHPRTSPLITMESHCLUSTERDATA as _D3DXSHPRTSPLITMESHCLUSTERDATA

type _XFILECOMPRESSEDANIMATIONSET
	CompressedBlockSize as DWORD
	TicksPerSec as FLOAT
	PlaybackType as DWORD
	BufferLength as DWORD
end type

type XFILECOMPRESSEDANIMATIONSET as _XFILECOMPRESSEDANIMATIONSET
type LPD3DXUVATLASCB as function(byval complete as single, byval ctx as any ptr) as HRESULT
type LPD3DXIMTSIGNALCALLBACK as function(byval as const D3DXVECTOR2 ptr, byval as UINT, byval as UINT, byval as any ptr, byval as FLOAT ptr) as HRESULT
type LPD3DXSHPRTSIMCB as function(byval complete as single, byval ctx as any ptr) as HRESULT
type ID3DXBaseMeshVtbl as ID3DXBaseMeshVtbl_

type ID3DXBaseMesh
	lpVtbl as ID3DXBaseMeshVtbl ptr
end type

type ID3DXBaseMeshVtbl_
	QueryInterface as function(byval This as ID3DXBaseMesh ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXBaseMesh ptr) as ULONG
	Release as function(byval This as ID3DXBaseMesh ptr) as ULONG
	DrawSubset as function(byval This as ID3DXBaseMesh ptr, byval attrib_id as DWORD) as HRESULT
	GetNumFaces as function(byval This as ID3DXBaseMesh ptr) as DWORD
	GetNumVertices as function(byval This as ID3DXBaseMesh ptr) as DWORD
	GetFVF as function(byval This as ID3DXBaseMesh ptr) as DWORD
	GetDeclaration as function(byval This as ID3DXBaseMesh ptr, byval declaration as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetNumBytesPerVertex as function(byval This as ID3DXBaseMesh ptr) as DWORD
	GetOptions as function(byval This as ID3DXBaseMesh ptr) as DWORD
	GetDevice as function(byval This as ID3DXBaseMesh ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	CloneMeshFVF as function(byval This as ID3DXBaseMesh ptr, byval options as DWORD, byval fvf as DWORD, byval device as IDirect3DDevice9 ptr, byval clone_mesh as ID3DXMesh ptr ptr) as HRESULT
	CloneMesh as function(byval This as ID3DXBaseMesh ptr, byval options as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval device as IDirect3DDevice9 ptr, byval clone_mesh as ID3DXMesh ptr ptr) as HRESULT
	GetVertexBuffer as function(byval This as ID3DXBaseMesh ptr, byval vertex_buffer as IDirect3DVertexBuffer9 ptr ptr) as HRESULT
	GetIndexBuffer as function(byval This as ID3DXBaseMesh ptr, byval index_buffer as IDirect3DIndexBuffer9 ptr ptr) as HRESULT
	LockVertexBuffer as function(byval This as ID3DXBaseMesh ptr, byval flags as DWORD, byval data as any ptr ptr) as HRESULT
	UnlockVertexBuffer as function(byval This as ID3DXBaseMesh ptr) as HRESULT
	LockIndexBuffer as function(byval This as ID3DXBaseMesh ptr, byval flags as DWORD, byval data as any ptr ptr) as HRESULT
	UnlockIndexBuffer as function(byval This as ID3DXBaseMesh ptr) as HRESULT
	GetAttributeTable as function(byval This as ID3DXBaseMesh ptr, byval attrib_table as D3DXATTRIBUTERANGE ptr, byval attrib_table_size as DWORD ptr) as HRESULT
	ConvertPointRepsToAdjacency as function(byval This as ID3DXBaseMesh ptr, byval point_reps as const DWORD ptr, byval adjacency as DWORD ptr) as HRESULT
	ConvertAdjacencyToPointReps as function(byval This as ID3DXBaseMesh ptr, byval adjacency as const DWORD ptr, byval point_reps as DWORD ptr) as HRESULT
	GenerateAdjacency as function(byval This as ID3DXBaseMesh ptr, byval epsilon as FLOAT, byval adjacency as DWORD ptr) as HRESULT
	UpdateSemantics as function(byval This as ID3DXBaseMesh ptr, byval declaration as D3DVERTEXELEMENT9 ptr) as HRESULT
end type

type ID3DXMeshVtbl as ID3DXMeshVtbl_

type ID3DXMesh_
	lpVtbl as ID3DXMeshVtbl ptr
end type

type ID3DXMeshVtbl_
	QueryInterface as function(byval This as ID3DXMesh ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXMesh ptr) as ULONG
	Release as function(byval This as ID3DXMesh ptr) as ULONG
	DrawSubset as function(byval This as ID3DXMesh ptr, byval attrib_id as DWORD) as HRESULT
	GetNumFaces as function(byval This as ID3DXMesh ptr) as DWORD
	GetNumVertices as function(byval This as ID3DXMesh ptr) as DWORD
	GetFVF as function(byval This as ID3DXMesh ptr) as DWORD
	GetDeclaration as function(byval This as ID3DXMesh ptr, byval declaration as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetNumBytesPerVertex as function(byval This as ID3DXMesh ptr) as DWORD
	GetOptions as function(byval This as ID3DXMesh ptr) as DWORD
	GetDevice as function(byval This as ID3DXMesh ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	CloneMeshFVF as function(byval This as ID3DXMesh ptr, byval options as DWORD, byval fvf as DWORD, byval device as IDirect3DDevice9 ptr, byval clone_mesh as ID3DXMesh ptr ptr) as HRESULT
	CloneMesh as function(byval This as ID3DXMesh ptr, byval options as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval device as IDirect3DDevice9 ptr, byval clone_mesh as ID3DXMesh ptr ptr) as HRESULT
	GetVertexBuffer as function(byval This as ID3DXMesh ptr, byval vertex_buffer as IDirect3DVertexBuffer9 ptr ptr) as HRESULT
	GetIndexBuffer as function(byval This as ID3DXMesh ptr, byval index_buffer as IDirect3DIndexBuffer9 ptr ptr) as HRESULT
	LockVertexBuffer as function(byval This as ID3DXMesh ptr, byval flags as DWORD, byval data as any ptr ptr) as HRESULT
	UnlockVertexBuffer as function(byval This as ID3DXMesh ptr) as HRESULT
	LockIndexBuffer as function(byval This as ID3DXMesh ptr, byval flags as DWORD, byval data as any ptr ptr) as HRESULT
	UnlockIndexBuffer as function(byval This as ID3DXMesh ptr) as HRESULT
	GetAttributeTable as function(byval This as ID3DXMesh ptr, byval attrib_table as D3DXATTRIBUTERANGE ptr, byval attrib_table_size as DWORD ptr) as HRESULT
	ConvertPointRepsToAdjacency as function(byval This as ID3DXMesh ptr, byval point_reps as const DWORD ptr, byval adjacency as DWORD ptr) as HRESULT
	ConvertAdjacencyToPointReps as function(byval This as ID3DXMesh ptr, byval adjacency as const DWORD ptr, byval point_reps as DWORD ptr) as HRESULT
	GenerateAdjacency as function(byval This as ID3DXMesh ptr, byval epsilon as FLOAT, byval adjacency as DWORD ptr) as HRESULT
	UpdateSemantics as function(byval This as ID3DXMesh ptr, byval declaration as D3DVERTEXELEMENT9 ptr) as HRESULT
	LockAttributeBuffer as function(byval This as ID3DXMesh ptr, byval flags as DWORD, byval data as DWORD ptr ptr) as HRESULT
	UnlockAttributeBuffer as function(byval This as ID3DXMesh ptr) as HRESULT
	Optimize as function(byval This as ID3DXMesh ptr, byval flags as DWORD, byval adjacency_in as const DWORD ptr, byval adjacency_out as DWORD ptr, byval face_remap as DWORD ptr, byval vertex_remap as ID3DXBuffer ptr ptr, byval opt_mesh as ID3DXMesh ptr ptr) as HRESULT
	OptimizeInplace as function(byval This as ID3DXMesh ptr, byval flags as DWORD, byval adjacency_in as const DWORD ptr, byval adjacency_out as DWORD ptr, byval face_remap as DWORD ptr, byval vertex_remap as ID3DXBuffer ptr ptr) as HRESULT
	SetAttributeTable as function(byval This as ID3DXMesh ptr, byval attrib_table as const D3DXATTRIBUTERANGE ptr, byval attrib_table_size as DWORD) as HRESULT
end type

type ID3DXPMeshVtbl as ID3DXPMeshVtbl_

type ID3DXPMesh
	lpVtbl as ID3DXPMeshVtbl ptr
end type

type ID3DXPMeshVtbl_
	QueryInterface as function(byval This as ID3DXPMesh ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXPMesh ptr) as ULONG
	Release as function(byval This as ID3DXPMesh ptr) as ULONG
	DrawSubset as function(byval This as ID3DXPMesh ptr, byval attrib_id as DWORD) as HRESULT
	GetNumFaces as function(byval This as ID3DXPMesh ptr) as DWORD
	GetNumVertices as function(byval This as ID3DXPMesh ptr) as DWORD
	GetFVF as function(byval This as ID3DXPMesh ptr) as DWORD
	GetDeclaration as function(byval This as ID3DXPMesh ptr, byval declaration as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetNumBytesPerVertex as function(byval This as ID3DXPMesh ptr) as DWORD
	GetOptions as function(byval This as ID3DXPMesh ptr) as DWORD
	GetDevice as function(byval This as ID3DXPMesh ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	CloneMeshFVF as function(byval This as ID3DXPMesh ptr, byval options as DWORD, byval fvf as DWORD, byval device as IDirect3DDevice9 ptr, byval clone_mesh as ID3DXMesh ptr ptr) as HRESULT
	CloneMesh as function(byval This as ID3DXPMesh ptr, byval options as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval device as IDirect3DDevice9 ptr, byval clone_mesh as ID3DXMesh ptr ptr) as HRESULT
	GetVertexBuffer as function(byval This as ID3DXPMesh ptr, byval vertex_buffer as IDirect3DVertexBuffer9 ptr ptr) as HRESULT
	GetIndexBuffer as function(byval This as ID3DXPMesh ptr, byval index_buffer as IDirect3DIndexBuffer9 ptr ptr) as HRESULT
	LockVertexBuffer as function(byval This as ID3DXPMesh ptr, byval flags as DWORD, byval data as any ptr ptr) as HRESULT
	UnlockVertexBuffer as function(byval This as ID3DXPMesh ptr) as HRESULT
	LockIndexBuffer as function(byval This as ID3DXPMesh ptr, byval flags as DWORD, byval data as any ptr ptr) as HRESULT
	UnlockIndexBuffer as function(byval This as ID3DXPMesh ptr) as HRESULT
	GetAttributeTable as function(byval This as ID3DXPMesh ptr, byval attrib_table as D3DXATTRIBUTERANGE ptr, byval attrib_table_size as DWORD ptr) as HRESULT
	ConvertPointRepsToAdjacency as function(byval This as ID3DXPMesh ptr, byval point_reps as const DWORD ptr, byval adjacency as DWORD ptr) as HRESULT
	ConvertAdjacencyToPointReps as function(byval This as ID3DXPMesh ptr, byval adjacency as const DWORD ptr, byval point_reps as DWORD ptr) as HRESULT
	GenerateAdjacency as function(byval This as ID3DXPMesh ptr, byval epsilon as FLOAT, byval adjacency as DWORD ptr) as HRESULT
	UpdateSemantics as function(byval This as ID3DXPMesh ptr, byval declaration as D3DVERTEXELEMENT9 ptr) as HRESULT
	ClonePMeshFVF as function(byval This as ID3DXPMesh ptr, byval options as DWORD, byval fvf as DWORD, byval device as IDirect3DDevice9 ptr, byval clone_mesh as ID3DXPMesh ptr ptr) as HRESULT
	ClonePMesh as function(byval This as ID3DXPMesh ptr, byval options as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval device as IDirect3DDevice9 ptr, byval clone_mesh as ID3DXPMesh ptr ptr) as HRESULT
	SetNumFaces as function(byval This as ID3DXPMesh ptr, byval faces as DWORD) as HRESULT
	SetNumVertices as function(byval This as ID3DXPMesh ptr, byval vertices as DWORD) as HRESULT
	GetMaxFaces as function(byval This as ID3DXPMesh ptr) as DWORD
	GetMinFaces as function(byval This as ID3DXPMesh ptr) as DWORD
	GetMaxVertices as function(byval This as ID3DXPMesh ptr) as DWORD
	GetMinVertices as function(byval This as ID3DXPMesh ptr) as DWORD
	Save as function(byval This as ID3DXPMesh ptr, byval stream as IStream ptr, byval material as const D3DXMATERIAL ptr, byval effect_instance as const D3DXEFFECTINSTANCE ptr, byval num_materials as DWORD) as HRESULT
	Optimize as function(byval This as ID3DXPMesh ptr, byval flags as DWORD, byval adjacency_out as DWORD ptr, byval face_remap as DWORD ptr, byval vertex_remap as ID3DXBuffer ptr ptr, byval opt_mesh as ID3DXMesh ptr ptr) as HRESULT
	OptimizeBaseLOD as function(byval This as ID3DXPMesh ptr, byval flags as DWORD, byval face_remap as DWORD ptr) as HRESULT
	TrimByFaces as function(byval This as ID3DXPMesh ptr, byval new_faces_min as DWORD, byval new_faces_max as DWORD, byval face_remap as DWORD ptr, byval vertex_remap as DWORD ptr) as HRESULT
	TrimByVertices as function(byval This as ID3DXPMesh ptr, byval new_vertices_min as DWORD, byval new_vertices_max as DWORD, byval face_remap as DWORD ptr, byval vertex_remap as DWORD ptr) as HRESULT
	GetAdjacency as function(byval This as ID3DXPMesh ptr, byval adjacency as DWORD ptr) as HRESULT
	GenerateVertexHistory as function(byval This as ID3DXPMesh ptr, byval vertex_history as DWORD ptr) as HRESULT
end type

type ID3DXSPMeshVtbl as ID3DXSPMeshVtbl_

type ID3DXSPMesh
	lpVtbl as ID3DXSPMeshVtbl ptr
end type

type ID3DXSPMeshVtbl_
	QueryInterface as function(byval This as ID3DXSPMesh ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXSPMesh ptr) as ULONG
	Release as function(byval This as ID3DXSPMesh ptr) as ULONG
	GetNumFaces as function(byval This as ID3DXSPMesh ptr) as DWORD
	GetNumVertices as function(byval This as ID3DXSPMesh ptr) as DWORD
	GetNumFVF as function(byval This as ID3DXSPMesh ptr) as DWORD
	GetDeclaration as function(byval This as ID3DXSPMesh ptr, byval declaration as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetOptions as function(byval This as ID3DXSPMesh ptr) as DWORD
	GetDevice as function(byval This as ID3DXSPMesh ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	CloneMeshFVF as function(byval This as ID3DXSPMesh ptr, byval options as DWORD, byval fvf as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency_out as DWORD ptr, byval vertex_remap_out as DWORD ptr, byval clone_mesh as ID3DXMesh ptr ptr) as HRESULT
	CloneMesh as function(byval This as ID3DXSPMesh ptr, byval options as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval device as IDirect3DDevice9 ptr, byval adjacency_out as DWORD ptr, byval vertex_remap_out as DWORD ptr, byval clone_mesh as ID3DXMesh ptr ptr) as HRESULT
	ClonePMeshFVF as function(byval This as ID3DXSPMesh ptr, byval options as DWORD, byval fvf as DWORD, byval device as IDirect3DDevice9 ptr, byval vertex_remap_out as DWORD ptr, byval errors_by_face as single ptr, byval clone_mesh as ID3DXPMesh ptr ptr) as HRESULT
	ClonePMesh as function(byval This as ID3DXSPMesh ptr, byval options as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval device as IDirect3DDevice9 ptr, byval vertex_remap_out as DWORD ptr, byval errors_by_face as single ptr, byval clone_mesh as ID3DXPMesh ptr ptr) as HRESULT
	ReduceFaces as function(byval This as ID3DXSPMesh ptr, byval faces as DWORD) as HRESULT
	ReduceVertices as function(byval This as ID3DXSPMesh ptr, byval vertices as DWORD) as HRESULT
	GetMaxFaces as function(byval This as ID3DXSPMesh ptr) as DWORD
	GetMaxVertices as function(byval This as ID3DXSPMesh ptr) as DWORD
	GetVertexAttributeWeights as function(byval This as ID3DXSPMesh ptr, byval vertex_attribute_weights as LPD3DXATTRIBUTEWEIGHTS) as HRESULT
	GetVertexWeights as function(byval This as ID3DXSPMesh ptr, byval vertex_weights as FLOAT ptr) as HRESULT
end type

type ID3DXPatchMeshVtbl as ID3DXPatchMeshVtbl_

type ID3DXPatchMesh
	lpVtbl as ID3DXPatchMeshVtbl ptr
end type

type ID3DXPatchMeshVtbl_
	QueryInterface as function(byval This as ID3DXPatchMesh ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXPatchMesh ptr) as ULONG
	Release as function(byval This as ID3DXPatchMesh ptr) as ULONG
	GetNumPatches as function(byval This as ID3DXPatchMesh ptr) as DWORD
	GetNumVertices as function(byval This as ID3DXPatchMesh ptr) as DWORD
	GetDeclaration as function(byval This as ID3DXPatchMesh ptr, byval declaration as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetControlVerticesPerPatch as function(byval This as ID3DXPatchMesh ptr) as DWORD
	GetOptions as function(byval This as ID3DXPatchMesh ptr) as DWORD
	GetDevice as function(byval This as ID3DXPatchMesh ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	GetPatchInfo as function(byval This as ID3DXPatchMesh ptr, byval patch_info as LPD3DXPATCHINFO) as HRESULT
	GetVertexBuffer as function(byval This as ID3DXPatchMesh ptr, byval vertex_buffer as IDirect3DVertexBuffer9 ptr ptr) as HRESULT
	GetIndexBuffer as function(byval This as ID3DXPatchMesh ptr, byval index_buffer as IDirect3DIndexBuffer9 ptr ptr) as HRESULT
	LockVertexBuffer as function(byval This as ID3DXPatchMesh ptr, byval flags as DWORD, byval data as any ptr ptr) as HRESULT
	UnlockVertexBuffer as function(byval This as ID3DXPatchMesh ptr) as HRESULT
	LockIndexBuffer as function(byval This as ID3DXPatchMesh ptr, byval flags as DWORD, byval data as any ptr ptr) as HRESULT
	UnlockIndexBuffer as function(byval This as ID3DXPatchMesh ptr) as HRESULT
	LockAttributeBuffer as function(byval This as ID3DXPatchMesh ptr, byval flags as DWORD, byval data as DWORD ptr ptr) as HRESULT
	UnlockAttributeBuffer as function(byval This as ID3DXPatchMesh ptr) as HRESULT
	GetTessSize as function(byval This as ID3DXPatchMesh ptr, byval tess_level as FLOAT, byval adaptive as DWORD, byval num_triangles as DWORD ptr, byval num_vertices as DWORD ptr) as HRESULT
	GenerateAdjacency as function(byval This as ID3DXPatchMesh ptr, byval tolerance as FLOAT) as HRESULT
	CloneMesh as function(byval This as ID3DXPatchMesh ptr, byval options as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval clone_mesh as ID3DXPatchMesh ptr ptr) as HRESULT
	Optimize as function(byval This as ID3DXPatchMesh ptr, byval flags as DWORD) as HRESULT
	SetDisplaceParam as function(byval This as ID3DXPatchMesh ptr, byval texture as IDirect3DBaseTexture9 ptr, byval min_filter as D3DTEXTUREFILTERTYPE, byval mag_filter as D3DTEXTUREFILTERTYPE, byval mip_filter as D3DTEXTUREFILTERTYPE, byval wrap as D3DTEXTUREADDRESS, byval lod_bias as DWORD) as HRESULT
	GetDisplaceParam as function(byval This as ID3DXPatchMesh ptr, byval texture as IDirect3DBaseTexture9 ptr ptr, byval min_filter as D3DTEXTUREFILTERTYPE ptr, byval mag_filter as D3DTEXTUREFILTERTYPE ptr, byval mip_filter as D3DTEXTUREFILTERTYPE ptr, byval wrap as D3DTEXTUREADDRESS ptr, byval lod_bias as DWORD ptr) as HRESULT
	Tessellate as function(byval This as ID3DXPatchMesh ptr, byval tess_level as single, byval mesh as ID3DXMesh ptr) as HRESULT
	TessellateAdaptive as function(byval This as ID3DXPatchMesh ptr, byval trans as const D3DXVECTOR4 ptr, byval max_tess_level as DWORD, byval min_tess_level as DWORD, byval mesh as ID3DXMesh ptr) as HRESULT
end type

type ID3DXSkinInfoVtbl as ID3DXSkinInfoVtbl_

type ID3DXSkinInfo
	lpVtbl as ID3DXSkinInfoVtbl ptr
end type

type ID3DXSkinInfoVtbl_
	QueryInterface as function(byval This as ID3DXSkinInfo ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXSkinInfo ptr) as ULONG
	Release as function(byval This as ID3DXSkinInfo ptr) as ULONG
	SetBoneInfluence as function(byval This as ID3DXSkinInfo ptr, byval bone as DWORD, byval num_influences as DWORD, byval vertices as const DWORD ptr, byval weights as const FLOAT ptr) as HRESULT
	SetBoneVertexInfluence as function(byval This as ID3DXSkinInfo ptr, byval bone_num as DWORD, byval influence_num as DWORD, byval weight as single) as HRESULT
	GetNumBoneInfluences as function(byval This as ID3DXSkinInfo ptr, byval bone as DWORD) as DWORD
	GetBoneInfluence as function(byval This as ID3DXSkinInfo ptr, byval bone as DWORD, byval vertices as DWORD ptr, byval weights as FLOAT ptr) as HRESULT
	GetBoneVertexInfluence as function(byval This as ID3DXSkinInfo ptr, byval bone_num as DWORD, byval influence_num as DWORD, byval weight as single ptr, byval vertex_num as DWORD ptr) as HRESULT
	GetMaxVertexInfluences as function(byval This as ID3DXSkinInfo ptr, byval max_vertex_influences as DWORD ptr) as HRESULT
	GetNumBones as function(byval This as ID3DXSkinInfo ptr) as DWORD
	FindBoneVertexInfluenceIndex as function(byval This as ID3DXSkinInfo ptr, byval bone_num as DWORD, byval vertex_num as DWORD, byval influence_index as DWORD ptr) as HRESULT
	GetMaxFaceInfluences as function(byval This as ID3DXSkinInfo ptr, byval index_buffer as IDirect3DIndexBuffer9 ptr, byval num_faces as DWORD, byval max_face_influences as DWORD ptr) as HRESULT
	SetMinBoneInfluence as function(byval This as ID3DXSkinInfo ptr, byval min_influence as FLOAT) as HRESULT
	GetMinBoneInfluence as function(byval This as ID3DXSkinInfo ptr) as FLOAT
	SetBoneName as function(byval This as ID3DXSkinInfo ptr, byval bone_idx as DWORD, byval name as const zstring ptr) as HRESULT
	GetBoneName as function(byval This as ID3DXSkinInfo ptr, byval bone_idx as DWORD) as const zstring ptr
	SetBoneOffsetMatrix as function(byval This as ID3DXSkinInfo ptr, byval bone as DWORD, byval bone_transform as const D3DXMATRIX ptr) as HRESULT
	GetBoneOffsetMatrix as function(byval This as ID3DXSkinInfo ptr, byval bone as DWORD) as D3DXMATRIX ptr
	Clone as function(byval This as ID3DXSkinInfo ptr, byval skin_info as ID3DXSkinInfo ptr ptr) as HRESULT
	Remap as function(byval This as ID3DXSkinInfo ptr, byval num_vertices as DWORD, byval vertex_remap as DWORD ptr) as HRESULT
	SetFVF as function(byval This as ID3DXSkinInfo ptr, byval FVF as DWORD) as HRESULT
	SetDeclaration as function(byval This as ID3DXSkinInfo ptr, byval declaration as const D3DVERTEXELEMENT9 ptr) as HRESULT
	GetFVF as function(byval This as ID3DXSkinInfo ptr) as DWORD
	GetDeclaration as function(byval This as ID3DXSkinInfo ptr, byval declaration as D3DVERTEXELEMENT9 ptr) as HRESULT
	UpdateSkinnedMesh as function(byval This as ID3DXSkinInfo ptr, byval bone_transforms as const D3DXMATRIX ptr, byval bone_inv_transpose_transforms as const D3DXMATRIX ptr, byval src_vertices as const any ptr, byval dst_vertices as any ptr) as HRESULT
	ConvertToBlendedMesh as function(byval This as ID3DXSkinInfo ptr, byval mesh_in as ID3DXMesh ptr, byval options as DWORD, byval adjacency_in as const DWORD ptr, byval adjacency_out as DWORD ptr, byval face_remap as DWORD ptr, byval vertex_remap as ID3DXBuffer ptr ptr, byval max_face_infl as DWORD ptr, byval num_bone_combinations as DWORD ptr, byval bone_combination_table as ID3DXBuffer ptr ptr, byval mesh_out as ID3DXMesh ptr ptr) as HRESULT
	ConvertToIndexedBlendedMesh as function(byval This as ID3DXSkinInfo ptr, byval mesh_in as ID3DXMesh ptr, byval options as DWORD, byval palette_size as DWORD, byval adjacency_in as const DWORD ptr, byval adjacency_out as DWORD ptr, byval face_remap as DWORD ptr, byval vertex_remap as ID3DXBuffer ptr ptr, byval max_face_infl as DWORD ptr, byval num_bone_combinations as DWORD ptr, byval bone_combination_table as ID3DXBuffer ptr ptr, byval mesh_out as ID3DXMesh ptr ptr) as HRESULT
end type

type ID3DXPRTBufferVtbl as ID3DXPRTBufferVtbl_

type ID3DXPRTBuffer
	lpVtbl as ID3DXPRTBufferVtbl ptr
end type

type ID3DXPRTBufferVtbl_
	QueryInterface as function(byval This as ID3DXPRTBuffer ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXPRTBuffer ptr) as ULONG
	Release as function(byval This as ID3DXPRTBuffer ptr) as ULONG
	GetNumSamples as function(byval This as ID3DXPRTBuffer ptr) as UINT
	GetNumCoeffs as function(byval This as ID3DXPRTBuffer ptr) as UINT
	GetNumChannels as function(byval This as ID3DXPRTBuffer ptr) as UINT
	IsTexture as function(byval This as ID3DXPRTBuffer ptr) as WINBOOL
	GetWidth as function(byval This as ID3DXPRTBuffer ptr) as WINBOOL
	GetHeight as function(byval This as ID3DXPRTBuffer ptr) as WINBOOL
	Resize as function(byval This as ID3DXPRTBuffer ptr, byval new_size as UINT) as HRESULT
	LockBuffer as function(byval This as ID3DXPRTBuffer ptr, byval start as UINT, byval num_samples as UINT, byval data as FLOAT ptr ptr) as HRESULT
	UnlockBuffer as function(byval This as ID3DXPRTBuffer ptr) as HRESULT
	ScaleBuffer as function(byval This as ID3DXPRTBuffer ptr, byval scale as FLOAT) as HRESULT
	AddBuffer as function(byval This as ID3DXPRTBuffer ptr, byval buffer as ID3DXPRTBuffer ptr) as HRESULT
	AttachGH as function(byval This as ID3DXPRTBuffer ptr, byval gh as ID3DXTextureGutterHelper ptr) as HRESULT
	ReleaseGH as function(byval This as ID3DXPRTBuffer ptr) as HRESULT
	EvalGH as function(byval This as ID3DXPRTBuffer ptr) as HRESULT
	ExtractTexture as function(byval This as ID3DXPRTBuffer ptr, byval channel as UINT, byval start_coefficient as UINT, byval num_coefficients as UINT, byval texture as IDirect3DTexture9 ptr) as HRESULT
	ExtractToMesh as function(byval This as ID3DXPRTBuffer ptr, byval num_coefficients as UINT, byval usage as D3DDECLUSAGE, byval usage_index_start as UINT, byval scene as ID3DXMesh ptr) as HRESULT
end type

type ID3DXPRTCompBufferVtbl as ID3DXPRTCompBufferVtbl_

type ID3DXPRTCompBuffer
	lpVtbl as ID3DXPRTCompBufferVtbl ptr
end type

type ID3DXPRTCompBufferVtbl_
	QueryInterface as function(byval This as ID3DXPRTCompBuffer ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXPRTCompBuffer ptr) as ULONG
	Release as function(byval This as ID3DXPRTCompBuffer ptr) as ULONG
	GetNumSamples as function(byval This as ID3DXPRTCompBuffer ptr) as UINT
	GetNumCoeffs as function(byval This as ID3DXPRTCompBuffer ptr) as UINT
	GetNumChannels as function(byval This as ID3DXPRTCompBuffer ptr) as UINT
	IsTexture as function(byval This as ID3DXPRTCompBuffer ptr) as WINBOOL
	GetWidth as function(byval This as ID3DXPRTCompBuffer ptr) as UINT
	GetHeight as function(byval This as ID3DXPRTCompBuffer ptr) as UINT
	GetNumClusters as function(byval This as ID3DXPRTCompBuffer ptr) as UINT
	GetNumPCA as function(byval This as ID3DXPRTCompBuffer ptr) as UINT
	NormalizeData as function(byval This as ID3DXPRTCompBuffer ptr) as HRESULT
	ExtractBasis as function(byval This as ID3DXPRTCompBuffer ptr, byval cluster as UINT, byval cluster_basis as FLOAT ptr) as HRESULT
	ExtractClusterIDs as function(byval This as ID3DXPRTCompBuffer ptr, byval cluster_ids as UINT ptr) as HRESULT
	ExtractPCA as function(byval This as ID3DXPRTCompBuffer ptr, byval start_pca as UINT, byval num_extract as UINT, byval pca_coefficients as FLOAT ptr) as HRESULT
	ExtractTexture as function(byval This as ID3DXPRTCompBuffer ptr, byval start_pca as UINT, byval num_pca as UINT, byval texture as IDirect3DTexture9 ptr) as HRESULT
	ExtractToMesh as function(byval This as ID3DXPRTCompBuffer ptr, byval num_pca as UINT, byval usage as D3DDECLUSAGE, byval usage_index_start as UINT, byval scene as ID3DXMesh ptr) as HRESULT
end type

type ID3DXTextureGutterHelperVtbl as ID3DXTextureGutterHelperVtbl_

type ID3DXTextureGutterHelper_
	lpVtbl as ID3DXTextureGutterHelperVtbl ptr
end type

type ID3DXTextureGutterHelperVtbl_
	QueryInterface as function(byval This as ID3DXTextureGutterHelper ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXTextureGutterHelper ptr) as ULONG
	Release as function(byval This as ID3DXTextureGutterHelper ptr) as ULONG
	GetWidth as function(byval This as ID3DXTextureGutterHelper ptr) as UINT
	GetHeight as function(byval This as ID3DXTextureGutterHelper ptr) as UINT
	ApplyGuttersFloat as function(byval This as ID3DXTextureGutterHelper ptr, byval data_in as FLOAT ptr, byval num_coeffs as UINT, byval width as UINT, byval height as UINT) as HRESULT
	ApplyGuttersTex as function(byval This as ID3DXTextureGutterHelper ptr, byval texture as IDirect3DTexture9 ptr) as HRESULT
	ApplyGuttersPRT as function(byval This as ID3DXTextureGutterHelper ptr, byval buffer as ID3DXPRTBuffer ptr) as HRESULT
	ResampleTex as function(byval This as ID3DXTextureGutterHelper ptr, byval texture_in as IDirect3DTexture9 ptr, byval mesh_in as ID3DXMesh ptr, byval usage as D3DDECLUSAGE, byval usage_index as UINT, byval texture_out as IDirect3DTexture9 ptr) as HRESULT
	GetFaceMap as function(byval This as ID3DXTextureGutterHelper ptr, byval face_data as UINT ptr) as HRESULT
	GetBaryMap as function(byval This as ID3DXTextureGutterHelper ptr, byval bary_data as D3DXVECTOR2 ptr) as HRESULT
	GetTexelMap as function(byval This as ID3DXTextureGutterHelper ptr, byval texel_data as D3DXVECTOR2 ptr) as HRESULT
	GetGutterMap as function(byval This as ID3DXTextureGutterHelper ptr, byval gutter_data as UBYTE ptr) as HRESULT
	SetFaceMap as function(byval This as ID3DXTextureGutterHelper ptr, byval face_data as UINT ptr) as HRESULT
	SetBaryMap as function(byval This as ID3DXTextureGutterHelper ptr, byval bary_data as D3DXVECTOR2 ptr) as HRESULT
	SetTexelMap as function(byval This as ID3DXTextureGutterHelper ptr, byval texel_data as D3DXVECTOR2 ptr) as HRESULT
	SetGutterMap as function(byval This as ID3DXTextureGutterHelper ptr, byval gutter_data as UBYTE ptr) as HRESULT
end type

type ID3DXPRTEngineVtbl as ID3DXPRTEngineVtbl_

type ID3DXPRTEngine
	lpVtbl as ID3DXPRTEngineVtbl ptr
end type

type ID3DXPRTEngineVtbl_
	QueryInterface as function(byval This as ID3DXPRTEngine ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXPRTEngine ptr) as ULONG
	Release as function(byval This as ID3DXPRTEngine ptr) as ULONG
	SetMeshMaterials as function(byval This as ID3DXPRTEngine ptr, byval materials as const D3DXSHMATERIAL ptr ptr, byval num_meshes as UINT, byval num_channels as UINT, byval set_albedo as WINBOOL, byval length_scale as FLOAT) as HRESULT
	SetPerVertexAlbedo as function(byval This as ID3DXPRTEngine ptr, byval data_in as const any ptr, byval num_channels as UINT, byval stride as UINT) as HRESULT
	SetPerTexelAlbedo as function(byval This as ID3DXPRTEngine ptr, byval albedo_texture as IDirect3DTexture9 ptr, byval num_channels as UINT, byval gh as ID3DXTextureGutterHelper ptr) as HRESULT
	GetVertexAlbedo as function(byval This as ID3DXPRTEngine ptr, byval vert_colors as D3DXCOLOR ptr, byval num_verts as UINT) as HRESULT
	SetPerTexelNormals as function(byval This as ID3DXPRTEngine ptr, byval normal_texture as IDirect3DTexture9 ptr) as HRESULT
	ExtractPerVertexAlbedo as function(byval This as ID3DXPRTEngine ptr, byval mesh as ID3DXMesh ptr, byval usage as D3DDECLUSAGE, byval num_channels as UINT) as HRESULT
	ResampleBuffer as function(byval This as ID3DXPRTEngine ptr, byval buffer_in as ID3DXPRTBuffer ptr, byval buffer_out as ID3DXPRTBuffer ptr) as HRESULT
	GetAdaptedMesh as function(byval This as ID3DXPRTEngine ptr, byval device as IDirect3DDevice9 ptr, byval face_remap as UINT ptr, byval vert_remap as UINT ptr, byval vert_weights as single ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
	GetNumVerts as function(byval This as ID3DXPRTEngine ptr) as UINT
	GetNumFaces as function(byval This as ID3DXPRTEngine ptr) as UINT
	SetMinMaxIntersection as function(byval This as ID3DXPRTEngine ptr, byval min as FLOAT, byval max as FLOAT) as HRESULT
	RobustMeshRefine as function(byval This as ID3DXPRTEngine ptr, byval min_edge_length as FLOAT, byval max_subdiv as UINT) as HRESULT
	SetSamplingInfo as function(byval This as ID3DXPRTEngine ptr, byval num_rays as UINT, byval use_sphere as WINBOOL, byval use_cosine as WINBOOL, byval adaptive as WINBOOL, byval adpative_thresh as FLOAT) as HRESULT
	ComputeDirectLightingSH as function(byval This as ID3DXPRTEngine ptr, byval sh_order as UINT, byval data_out as ID3DXPRTBuffer ptr) as HRESULT
	ComputeDirectLightingSHAdaptive as function(byval This as ID3DXPRTEngine ptr, byval sh_order as UINT, byval adaptive_thresh as single, byval min_edge_length as single, byval max_subdiv as UINT, byval data_out as ID3DXPRTBuffer ptr) as HRESULT
	ComputeDirectLightingSHGPU as function(byval This as ID3DXPRTEngine ptr, byval device as IDirect3DDevice9 ptr, byval flags as UINT, byval sh_order as UINT, byval zbias as single, byval zangle_bias as single, byval data_out as ID3DXPRTBuffer ptr) as HRESULT
	ComputeSS as function(byval This as ID3DXPRTEngine ptr, byval data_in as ID3DXPRTBuffer ptr, byval data_out as ID3DXPRTBuffer ptr, byval data_total as ID3DXPRTBuffer ptr) as HRESULT
	ComputeSSAdaptive as function(byval This as ID3DXPRTEngine ptr, byval data_in as ID3DXPRTBuffer ptr, byval adaptive_thres as single, byval min_edge_length as single, byval max_subdiv as UINT, byval data_out as ID3DXPRTBuffer ptr, byval data_total as ID3DXPRTBuffer ptr) as HRESULT
	ComputeBounce as function(byval This as ID3DXPRTEngine ptr, byval data_in as ID3DXPRTBuffer ptr, byval data_out as ID3DXPRTBuffer ptr, byval data_total as ID3DXPRTBuffer ptr) as HRESULT
	ComputeBounceAdaptive as function(byval This as ID3DXPRTEngine ptr, byval data_in as ID3DXPRTBuffer ptr, byval adaptive_thres as single, byval min_edge_length as single, byval max_subdiv as UINT, byval data_out as ID3DXPRTBuffer ptr, byval data_total as ID3DXPRTBuffer ptr) as HRESULT
	ComputeVolumeSamplesDirectSH as function(byval This as ID3DXPRTEngine ptr, byval sh_order_in as UINT, byval sh_order_out as UINT, byval num_vol_samples as UINT, byval sample_locs as const D3DXVECTOR3 ptr, byval data_out as ID3DXPRTBuffer ptr) as HRESULT
	ComputeVolumeSamples as function(byval This as ID3DXPRTEngine ptr, byval surf_data_in as ID3DXPRTBuffer ptr, byval sh_order as UINT, byval num_vol_samples as UINT, byval sample_locs as const D3DXVECTOR3 ptr, byval data_out as ID3DXPRTBuffer ptr) as HRESULT
	ComputeSurfSamplesDirectSH as function(byval This as ID3DXPRTEngine ptr, byval sh_order as UINT, byval num_samples as UINT, byval sample_locs as const D3DXVECTOR3 ptr, byval sample_norms as const D3DXVECTOR3 ptr, byval data_out as ID3DXPRTBuffer ptr) as HRESULT
	ComputeSurfSamplesBounce as function(byval This as ID3DXPRTEngine ptr, byval surf_data_in as ID3DXPRTBuffer ptr, byval num_samples as UINT, byval sample_locs as const D3DXVECTOR3 ptr, byval sample_norms as const D3DXVECTOR3 ptr, byval data_out as ID3DXPRTBuffer ptr, byval data_total as ID3DXPRTBuffer ptr) as HRESULT
	FreeSSData as function(byval This as ID3DXPRTEngine ptr) as HRESULT
	FreeBounceData as function(byval This as ID3DXPRTEngine ptr) as HRESULT
	ComputeLDPRTCoeffs as function(byval This as ID3DXPRTEngine ptr, byval data_in as ID3DXPRTBuffer ptr, byval sh_order as UINT, byval norm_out as D3DXVECTOR3 ptr, byval data_out as ID3DXPRTBuffer ptr) as HRESULT
	ScaleMeshChunk as function(byval This as ID3DXPRTEngine ptr, byval mesh_chunk as UINT, byval scale as single, byval data_out as ID3DXPRTBuffer ptr) as HRESULT
	MultiplyAlbedo as function(byval This as ID3DXPRTEngine ptr, byval data_out as ID3DXPRTBuffer ptr) as HRESULT
	SetCallback as function(byval This as ID3DXPRTEngine ptr, byval cb as LPD3DXSHPRTSIMCB, byval frequency as single, byval user_context as any ptr) as HRESULT
	ShadowRayIntersects as function(byval This as ID3DXPRTEngine ptr, byval ray_pos as const D3DXVECTOR3 ptr, byval ray_dir as const D3DXVECTOR3 ptr) as WINBOOL
	ClosestRayIntersects as function(byval This as ID3DXPRTEngine ptr, byval ray_pos as const D3DXVECTOR3 ptr, byval ray_dir as const D3DXVECTOR3 ptr, byval face_index as DWORD ptr, byval u as FLOAT ptr, byval v as FLOAT ptr, byval dist as FLOAT ptr) as WINBOOL
end type

declare function D3DXCreateMesh(byval face_count as DWORD, byval vertex_count as DWORD, byval flags as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval device as IDirect3DDevice9 ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
declare function D3DXCreateMeshFVF(byval face_count as DWORD, byval vertex_count as DWORD, byval flags as DWORD, byval fvf as DWORD, byval device as IDirect3DDevice9 ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
declare function D3DXCreateBuffer(byval size as DWORD, byval buffer as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateSPMesh(byval mesh as ID3DXMesh ptr, byval adjacency as const DWORD ptr, byval attribute_weights as const D3DXATTRIBUTEWEIGHTS ptr, byval vertex_weights as const single ptr, byval spmesh as ID3DXSPMesh ptr ptr) as HRESULT
declare function D3DXCreatePMeshFromStream(byval stream as IStream ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval mesh as ID3DXPMesh ptr ptr) as HRESULT
declare function D3DXCreateSkinInfo(byval vertex_count as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval bone_count as DWORD, byval skin_info as ID3DXSkinInfo ptr ptr) as HRESULT
declare function D3DXCreateSkinInfoFVF(byval vertex_count as DWORD, byval fvf as DWORD, byval bone_count as DWORD, byval skin_info as ID3DXSkinInfo ptr ptr) as HRESULT
declare function D3DXCreateSkinInfoFromBlendedMesh(byval mesh as ID3DXBaseMesh ptr, byval bone_count as DWORD, byval bone_combination_table as const D3DXBONECOMBINATION ptr, byval skin_info as ID3DXSkinInfo ptr ptr) as HRESULT
declare function D3DXCreatePatchMesh(byval patch_info as const D3DXPATCHINFO ptr, byval patch_count as DWORD, byval vertex_count as DWORD, byval flags as DWORD, byval declaration as const D3DVERTEXELEMENT9 ptr, byval device as IDirect3DDevice9 ptr, byval mesh as ID3DXPatchMesh ptr ptr) as HRESULT
declare function D3DXCreatePRTBuffer(byval sample_count as UINT, byval coeff_count as UINT, byval channel_count as UINT, byval buffer as ID3DXPRTBuffer ptr ptr) as HRESULT
declare function D3DXCreatePRTBufferTex(byval width as UINT, byval height as UINT, byval coeff_count as UINT, byval channel_count as UINT, byval buffer as ID3DXPRTBuffer ptr ptr) as HRESULT
declare function D3DXCreatePRTCompBuffer(byval quality as D3DXSHCOMPRESSQUALITYTYPE, byval cluster_count as UINT, byval pca_count as UINT, byval cb as LPD3DXSHPRTSIMCB, byval ctx as any ptr, byval input as ID3DXPRTBuffer ptr, byval buffer as ID3DXPRTCompBuffer ptr ptr) as HRESULT
declare function D3DXCreateTextureGutterHelper(byval width as UINT, byval height as UINT, byval mesh as ID3DXMesh ptr, byval gutter_size as single, byval gh as ID3DXTextureGutterHelper ptr ptr) as HRESULT
declare function D3DXCreatePRTEngine(byval mesh as ID3DXMesh ptr, byval adjacency as DWORD ptr, byval extract_uv as WINBOOL, byval blocker_mesh as ID3DXMesh ptr, byval engine as ID3DXPRTEngine ptr ptr) as HRESULT
declare function D3DXLoadMeshFromXA(byval filename as const zstring ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency as ID3DXBuffer ptr ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
declare function D3DXLoadMeshFromXW(byval filename as const wstring ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency as ID3DXBuffer ptr ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXLoadMeshFromX alias "D3DXLoadMeshFromXW"(byval filename as const wstring ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency as ID3DXBuffer ptr ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
#else
	declare function D3DXLoadMeshFromX alias "D3DXLoadMeshFromXA"(byval filename as const zstring ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency as ID3DXBuffer ptr ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
#endif

declare function D3DXLoadMeshFromXInMemory(byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency as ID3DXBuffer ptr ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
declare function D3DXLoadMeshFromXResource(byval module as HMODULE, byval resource as const zstring ptr, byval resource_type as const zstring ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency as ID3DXBuffer ptr ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
declare function D3DXLoadMeshFromXof(byval file_data as ID3DXFileData ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency as ID3DXBuffer ptr ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
declare function D3DXLoadPatchMeshFromXof(byval file_data as ID3DXFileData ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency as ID3DXBuffer ptr ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval mesh as ID3DXPatchMesh ptr ptr) as HRESULT
declare function D3DXLoadSkinMeshFromXof(byval file_data as ID3DXFileData ptr, byval flags as DWORD, byval device as IDirect3DDevice9 ptr, byval adjacency as ID3DXBuffer ptr ptr, byval materials as ID3DXBuffer ptr ptr, byval effect_instances as ID3DXBuffer ptr ptr, byval material_count as DWORD ptr, byval skin_info as ID3DXSkinInfo ptr ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
declare function D3DXLoadPRTBufferFromFileA(byval filename as const zstring ptr, byval buffer as ID3DXPRTBuffer ptr ptr) as HRESULT
declare function D3DXLoadPRTBufferFromFileW(byval filename as const wstring ptr, byval buffer as ID3DXPRTBuffer ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXLoadPRTBufferFromFile alias "D3DXLoadPRTBufferFromFileW"(byval filename as const wstring ptr, byval buffer as ID3DXPRTBuffer ptr ptr) as HRESULT
#else
	declare function D3DXLoadPRTBufferFromFile alias "D3DXLoadPRTBufferFromFileA"(byval filename as const zstring ptr, byval buffer as ID3DXPRTBuffer ptr ptr) as HRESULT
#endif

declare function D3DXLoadPRTCompBufferFromFileA(byval filename as const zstring ptr, byval buffer as ID3DXPRTCompBuffer ptr ptr) as HRESULT
declare function D3DXLoadPRTCompBufferFromFileW(byval filename as const wstring ptr, byval buffer as ID3DXPRTCompBuffer ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXLoadPRTCompBufferFromFile alias "D3DXLoadPRTCompBufferFromFileW"(byval filename as const wstring ptr, byval buffer as ID3DXPRTCompBuffer ptr ptr) as HRESULT
#else
	declare function D3DXLoadPRTCompBufferFromFile alias "D3DXLoadPRTCompBufferFromFileA"(byval filename as const zstring ptr, byval buffer as ID3DXPRTCompBuffer ptr ptr) as HRESULT
#endif

declare function D3DXSaveMeshToXA(byval filename as const zstring ptr, byval mesh as ID3DXMesh ptr, byval adjacency as const DWORD ptr, byval materials as const D3DXMATERIAL ptr, byval effect_instances as const D3DXEFFECTINSTANCE ptr, byval material_count as DWORD, byval format as DWORD) as HRESULT
declare function D3DXSaveMeshToXW(byval filename as const wstring ptr, byval mesh as ID3DXMesh ptr, byval adjacency as const DWORD ptr, byval materials as const D3DXMATERIAL ptr, byval effect_instances as const D3DXEFFECTINSTANCE ptr, byval material_count as DWORD, byval format as DWORD) as HRESULT

#ifdef UNICODE
	declare function D3DXSaveMeshToX alias "D3DXSaveMeshToXW"(byval filename as const wstring ptr, byval mesh as ID3DXMesh ptr, byval adjacency as const DWORD ptr, byval materials as const D3DXMATERIAL ptr, byval effect_instances as const D3DXEFFECTINSTANCE ptr, byval material_count as DWORD, byval format as DWORD) as HRESULT
#else
	declare function D3DXSaveMeshToX alias "D3DXSaveMeshToXA"(byval filename as const zstring ptr, byval mesh as ID3DXMesh ptr, byval adjacency as const DWORD ptr, byval materials as const D3DXMATERIAL ptr, byval effect_instances as const D3DXEFFECTINSTANCE ptr, byval material_count as DWORD, byval format as DWORD) as HRESULT
#endif

declare function D3DXSavePRTBufferToFileA(byval filename as const zstring ptr, byval buffer as ID3DXPRTBuffer ptr) as HRESULT
declare function D3DXSavePRTBufferToFileW(byval filename as const wstring ptr, byval buffer as ID3DXPRTBuffer ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXSavePRTBufferToFile alias "D3DXSavePRTBufferToFileW"(byval filename as const wstring ptr, byval buffer as ID3DXPRTBuffer ptr) as HRESULT
#else
	declare function D3DXSavePRTBufferToFile alias "D3DXSavePRTBufferToFileA"(byval filename as const zstring ptr, byval buffer as ID3DXPRTBuffer ptr) as HRESULT
#endif

declare function D3DXSavePRTCompBufferToFileA(byval filename as const zstring ptr, byval buffer as ID3DXPRTCompBuffer ptr) as HRESULT
declare function D3DXSavePRTCompBufferToFileW(byval filename as const wstring ptr, byval buffer as ID3DXPRTCompBuffer ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXSavePRTCompBufferToFile alias "D3DXSavePRTCompBufferToFileW"(byval filename as const wstring ptr, byval buffer as ID3DXPRTCompBuffer ptr) as HRESULT
#else
	declare function D3DXSavePRTCompBufferToFile alias "D3DXSavePRTCompBufferToFileA"(byval filename as const zstring ptr, byval buffer as ID3DXPRTCompBuffer ptr) as HRESULT
#endif

declare function D3DXGetDeclLength(byval decl as const D3DVERTEXELEMENT9 ptr) as UINT
declare function D3DXGetDeclVertexSize(byval decl as const D3DVERTEXELEMENT9 ptr, byval stream_idx as DWORD) as UINT
declare function D3DXGetFVFVertexSize(byval as DWORD) as UINT
declare function D3DXBoxBoundProbe(byval vmin as const D3DXVECTOR3 ptr, byval vmax as const D3DXVECTOR3 ptr, byval ray_pos as const D3DXVECTOR3 ptr, byval ray_dir as const D3DXVECTOR3 ptr) as WINBOOL
declare function D3DXSphereBoundProbe(byval center as const D3DXVECTOR3 ptr, byval radius as FLOAT, byval ray_pos as const D3DXVECTOR3 ptr, byval ray_dir as const D3DXVECTOR3 ptr) as WINBOOL
declare function D3DXCleanMesh(byval clean_type as D3DXCLEANTYPE, byval mesh_in as ID3DXMesh ptr, byval adjacency_in as const DWORD ptr, byval mesh_out as ID3DXMesh ptr ptr, byval adjacency_out as DWORD ptr, byval errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXConcatenateMeshes(byval meshes as ID3DXMesh ptr ptr, byval mesh_count as UINT, byval flags as DWORD, byval geometry_matrices as const D3DXMATRIX ptr, byval texture_matrices as const D3DXMATRIX ptr, byval declaration as const D3DVERTEXELEMENT9 ptr, byval device as IDirect3DDevice9 ptr, byval mesh as ID3DXMesh ptr ptr) as HRESULT
declare function D3DXComputeBoundingBox(byval first_pos as const D3DXVECTOR3 ptr, byval num_vertices as DWORD, byval stride as DWORD, byval vmin as D3DXVECTOR3 ptr, byval vmax as D3DXVECTOR3 ptr) as HRESULT
declare function D3DXComputeBoundingSphere(byval first_pos as const D3DXVECTOR3 ptr, byval num_vertices as DWORD, byval stride as DWORD, byval center as D3DXVECTOR3 ptr, byval radius as FLOAT ptr) as HRESULT
declare function D3DXComputeIMTFromPerTexelSignal(byval mesh as ID3DXMesh ptr, byval texture_idx as DWORD, byval texel_signal as single ptr, byval width as UINT, byval height as UINT, byval signal_dimension as UINT, byval component_count as UINT, byval flags as DWORD, byval cb as LPD3DXUVATLASCB, byval ctx as any ptr, byval buffer as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXComputeIMTFromPerVertexSignal(byval mesh as ID3DXMesh ptr, byval vertex_signal as const single ptr, byval signal_dimension as UINT, byval signal_stride as UINT, byval flags as DWORD, byval cb as LPD3DXUVATLASCB, byval ctx as any ptr, byval buffer as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXComputeIMTFromSignal(byval mesh as ID3DXMesh ptr, byval texture_idx as DWORD, byval signal_dimension as UINT, byval max_uv_distance as single, byval flags as DWORD, byval signal_cb as LPD3DXIMTSIGNALCALLBACK, byval signal_ctx as any ptr, byval status_cb as LPD3DXUVATLASCB, byval status_ctx as any ptr, byval buffer as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXComputeIMTFromTexture(byval mesh as ID3DXMesh ptr, byval texture as IDirect3DTexture9 ptr, byval texture_idx as DWORD, byval options as DWORD, byval cb as LPD3DXUVATLASCB, byval ctx as any ptr, byval out as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXComputeNormals(byval mesh as ID3DXBaseMesh ptr, byval adjacency as const DWORD ptr) as HRESULT
declare function D3DXComputeTangentFrameEx(byval mesh_in as ID3DXMesh ptr, byval texture_in_semantic as DWORD, byval texture_in_idx as DWORD, byval u_partial_out_semantic as DWORD, byval u_partial_out_idx as DWORD, byval v_partial_out_semantic as DWORD, byval v_partial_out_idx as DWORD, byval normal_out_semantic as DWORD, byval normal_out_idx as DWORD, byval flags as DWORD, byval adjacency as const DWORD ptr, byval partial_edge_threshold as single, byval singular_point_threshold as single, byval normal_edge_threshold as single, byval mesh_out as ID3DXMesh ptr ptr, byval buffer as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXComputeTangent(byval mesh as ID3DXMesh ptr, byval stage as DWORD, byval tangent_idx as DWORD, byval binorm_idx as DWORD, byval wrap as DWORD, byval adjacency as const DWORD ptr) as HRESULT
declare function D3DXConvertMeshSubsetToSingleStrip(byval mesh_in as ID3DXBaseMesh ptr, byval attribute_id as DWORD, byval ib_flags as DWORD, byval index_buffer as IDirect3DIndexBuffer9 ptr ptr, byval index_count as DWORD ptr) as HRESULT
declare function D3DXConvertMeshSubsetToStrips(byval mesh_in as ID3DXBaseMesh ptr, byval attribute_id as DWORD, byval ib_flags as DWORD, byval index_buffer as IDirect3DIndexBuffer9 ptr ptr, byval index_count as DWORD ptr, byval strip_lengths as ID3DXBuffer ptr ptr, byval strip_count as DWORD ptr) as HRESULT
declare function D3DXDeclaratorFromFVF(byval as DWORD, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
declare function D3DXFVFFromDeclarator(byval decl as const D3DVERTEXELEMENT9 ptr, byval fvf as DWORD ptr) as HRESULT
declare function D3DXGenerateOutputDecl(byval decl_out as D3DVERTEXELEMENT9 ptr, byval decl_in as const D3DVERTEXELEMENT9 ptr) as HRESULT
declare function D3DXGeneratePMesh(byval mesh as ID3DXMesh ptr, byval adjacency as const DWORD ptr, byval attribute_weights as const D3DXATTRIBUTEWEIGHTS ptr, byval vertex_weights as const single ptr, byval min_value as DWORD, byval flags as DWORD, byval pmesh as ID3DXPMesh ptr ptr) as HRESULT
declare function D3DXIntersect(byval mesh as ID3DXBaseMesh ptr, byval ray_position as const D3DXVECTOR3 ptr, byval ray_direction as const D3DXVECTOR3 ptr, byval hit as WINBOOL ptr, byval face_idx as DWORD ptr, byval u as single ptr, byval v as single ptr, byval distance as single ptr, byval hits as ID3DXBuffer ptr ptr, byval hit_count as DWORD ptr) as HRESULT
declare function D3DXIntersectSubset(byval mesh as ID3DXBaseMesh ptr, byval attribute_id as DWORD, byval ray_position as const D3DXVECTOR3 ptr, byval ray_direction as const D3DXVECTOR3 ptr, byval hit as WINBOOL ptr, byval face_idx as DWORD ptr, byval u as single ptr, byval v as single ptr, byval distance as single ptr, byval hits as ID3DXBuffer ptr ptr, byval hit_count as DWORD ptr) as HRESULT
declare function D3DXIntersectTri(byval vtx0 as const D3DXVECTOR3 ptr, byval vtx1 as const D3DXVECTOR3 ptr, byval vtx2 as const D3DXVECTOR3 ptr, byval ray_pos as const D3DXVECTOR3 ptr, byval ray_dir as const D3DXVECTOR3 ptr, byval u as FLOAT ptr, byval v as FLOAT ptr, byval dist as FLOAT ptr) as WINBOOL
declare function D3DXOptimizeFaces(byval indices as const any ptr, byval face_count as UINT, byval vertex_count as UINT, byval idx_32bit as WINBOOL, byval face_remap as DWORD ptr) as HRESULT
declare function D3DXOptimizeVertices(byval indices as const any ptr, byval face_count as UINT, byval vertex_count as UINT, byval idx_32bit as WINBOOL, byval vertex_remap as DWORD ptr) as HRESULT
declare function D3DXRectPatchSize(byval segment_count as const FLOAT ptr, byval num_triangles as DWORD ptr, byval num_vertices as DWORD ptr) as HRESULT
declare function D3DXSHPRTCompSuperCluster(byval cluster_ids as UINT ptr, byval scene as ID3DXMesh ptr, byval max_cluster_count as UINT, byval cluster_count as UINT, byval scluster_ids as UINT ptr, byval scluster_count as UINT ptr) as HRESULT
declare function D3DXSHPRTCompSplitMeshSC(byval cluster_idx as UINT ptr, byval vertex_count as UINT, byval cluster_count as UINT, byval scluster_ids as UINT ptr, byval scluster_count as UINT, byval index_buffer_in as any ptr, byval ib_in_32bit as WINBOOL, byval face_count as UINT, byval index_buffer_out as ID3DXBuffer ptr ptr, byval index_buffer_size as UINT ptr, byval ib_out_32bit as WINBOOL, byval face_remap as ID3DXBuffer ptr ptr, byval vertex_data as ID3DXBuffer ptr ptr, byval vertex_data_length as UINT ptr, byval sc_cluster_list as UINT ptr, byval sc_data as D3DXSHPRTSPLITMESHCLUSTERDATA ptr) as HRESULT
declare function D3DXSimplifyMesh(byval mesh_in as ID3DXMesh ptr, byval adjacency as const DWORD ptr, byval attribute_weights as const D3DXATTRIBUTEWEIGHTS ptr, byval vertex_weights as const single ptr, byval min_value as DWORD, byval flags as DWORD, byval mesh_out as ID3DXMesh ptr ptr) as HRESULT
declare function D3DXSplitMesh(byval mesh_in as ID3DXMesh ptr, byval adjacency_in as const DWORD ptr, byval max_size as const DWORD, byval flags as const DWORD, byval mesh_out_count as DWORD ptr, byval mesh_out as ID3DXBuffer ptr ptr, byval adjacency_out as ID3DXBuffer ptr ptr, byval face_remap_out as ID3DXBuffer ptr ptr, byval vertex_remap_out as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXTesselateNPatches(byval mesh_in as ID3DXMesh ptr, byval adjacency_in as const DWORD ptr, byval segment_count as single, byval quad_interp as WINBOOL, byval mesh_out as ID3DXMesh ptr ptr, byval adjacency_out as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXTesselateRectPatch(byval buffer as IDirect3DVertexBuffer9 ptr, byval segment_count as const single ptr, byval declaration as const D3DVERTEXELEMENT9 ptr, byval patch_info as const D3DRECTPATCH_INFO ptr, byval mesh as ID3DXMesh ptr) as HRESULT
declare function D3DXTesselateTriPatch(byval buffer as IDirect3DVertexBuffer9 ptr, byval segment_count as const single ptr, byval declaration as const D3DVERTEXELEMENT9 ptr, byval patch_info as const D3DTRIPATCH_INFO ptr, byval mesh as ID3DXMesh ptr) as HRESULT
declare function D3DXTriPatchSize(byval segment_count as const FLOAT ptr, byval num_triangles as DWORD ptr, byval num_vertices as DWORD ptr) as HRESULT
declare function D3DXUVAtlasCreate(byval mesh_in as ID3DXMesh ptr, byval max_chart_count as UINT, byval max_stretch_in as single, byval width as UINT, byval height as UINT, byval gutter as single, byval texture_idx as DWORD, byval adjacency as const DWORD ptr, byval false_edges as const DWORD ptr, byval imt_array as const single ptr, byval cb as LPD3DXUVATLASCB, byval cb_freq as single, byval ctx as any ptr, byval flags as DWORD, byval mesh_out as ID3DXMesh ptr ptr, byval face_partitioning_out as ID3DXBuffer ptr ptr, byval vertex_remap_out as ID3DXBuffer ptr ptr, byval max_stretch_out as single ptr, byval chart_count as UINT ptr) as HRESULT
declare function D3DXUVAtlasPack(byval mesh as ID3DXMesh ptr, byval width as UINT, byval height as UINT, byval gutter as single, byval texture_idx as DWORD, byval partition_result_adjacency as const DWORD ptr, byval cb as LPD3DXUVATLASCB, byval cb_freq as single, byval ctx as any ptr, byval flags as DWORD, byval face_partitioning as ID3DXBuffer ptr) as HRESULT
declare function D3DXUVAtlasPartition(byval mesh_in as ID3DXMesh ptr, byval max_chart_count as UINT, byval max_stretch_in as single, byval texture_idx as DWORD, byval adjacency as const DWORD ptr, byval false_edges as const DWORD ptr, byval imt_array as const single ptr, byval cb as LPD3DXUVATLASCB, byval cb_freq as single, byval ctx as any ptr, byval flags as DWORD, byval mesh_out as ID3DXMesh ptr ptr, byval face_partitioning_out as ID3DXBuffer ptr ptr, byval vertex_remap_out as ID3DXBuffer ptr ptr, byval adjacency_out as ID3DXBuffer ptr ptr, byval max_stretch_out as single ptr, byval chart_count as UINT ptr) as HRESULT
declare function D3DXValidMesh(byval mesh as ID3DXMesh ptr, byval adjacency as const DWORD ptr, byval errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXValidPatchMesh(byval mesh as ID3DXPatchMesh ptr, byval degenerate_vertex_count as DWORD ptr, byval degenerate_patch_count as DWORD ptr, byval errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXWeldVertices(byval mesh as ID3DXMesh ptr, byval flags as DWORD, byval epsilons as const D3DXWELDEPSILONS ptr, byval adjacency_in as const DWORD ptr, byval adjacency_out as DWORD ptr, byval face_remap_out as DWORD ptr, byval vertex_remap_out as ID3DXBuffer ptr ptr) as HRESULT

extern DXFILEOBJ_XSkinMeshHeader as const GUID
extern DXFILEOBJ_VertexDuplicationIndices as const GUID
extern DXFILEOBJ_FaceAdjacency as const GUID
extern DXFILEOBJ_SkinWeights as const GUID
extern DXFILEOBJ_Patch as const GUID
extern DXFILEOBJ_PatchMesh as const GUID
extern DXFILEOBJ_PatchMesh9 as const GUID
extern DXFILEOBJ_PMInfo as const GUID
extern DXFILEOBJ_PMAttributeRange as const GUID
extern DXFILEOBJ_PMVSplitRecord as const GUID
extern DXFILEOBJ_FVFData as const GUID
extern DXFILEOBJ_VertexElement as const GUID
extern DXFILEOBJ_DeclData as const GUID
extern DXFILEOBJ_EffectFloats as const GUID
extern DXFILEOBJ_EffectString as const GUID
extern DXFILEOBJ_EffectDWord as const GUID
extern DXFILEOBJ_EffectParamFloats as const GUID
extern DXFILEOBJ_EffectParamString as const GUID
extern DXFILEOBJ_EffectParamDWord as const GUID
extern DXFILEOBJ_EffectInstance as const GUID
extern DXFILEOBJ_AnimTicksPerSecond as const GUID
extern DXFILEOBJ_CompressedAnimationSet as const GUID

end extern
