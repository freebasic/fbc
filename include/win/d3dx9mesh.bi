''
''
'' d3dx9mesh -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9mesh_bi__
#define __win_d3dx9mesh_bi__

#include once "win/d3dx9.bi"

extern IID_ID3DXBaseMesh alias "IID_ID3DXBaseMesh" as GUID
extern IID_ID3DXMesh alias "IID_ID3DXMesh" as GUID
extern IID_ID3DXPMesh alias "IID_ID3DXPMesh" as GUID
extern IID_ID3DXSPMesh alias "IID_ID3DXSPMesh" as GUID
extern IID_ID3DXSkinInfo alias "IID_ID3DXSkinInfo" as GUID
extern IID_ID3DXPatchMesh alias "IID_ID3DXPatchMesh" as GUID

enum D3DXPATCHMESHTYPE
	D3DXPATCHMESH_RECT = &h001
	D3DXPATCHMESH_TRI = &h002
	D3DXPATCHMESH_NPATCH = &h003
	D3DXPATCHMESH_FORCE_DWORD = &h7fffffff
end enum

enum D3DXMESH
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

enum D3DXPATCHMESH
	D3DXPATCHMESH_DEFAULT = 000
end enum

enum D3DXMESHSIMP
	D3DXMESHSIMP_VERTEX = &h1
	D3DXMESHSIMP_FACE = &h2
end enum

enum D3DXCLEANTYPE
	D3DXCLEAN_BACKFACING = &h00000001
	D3DXCLEAN_BOWTIES = &h00000002
	D3DXCLEAN_SKINNING = D3DXCLEAN_BACKFACING
	D3DXCLEAN_OPTIMIZATION = D3DXCLEAN_BACKFACING
	D3DXCLEAN_SIMPLIFICATION = D3DXCLEAN_BACKFACING or D3DXCLEAN_BOWTIES
end enum

enum MAX_FVF_DECL_SIZE
	MAX_FVF_DECL_SIZE = 64+1
end enum

type LPD3DXBASEMESH as ID3DXBaseMesh ptr
type LPD3DXMESH as ID3DXMesh ptr
type LPD3DXPMESH as ID3DXPMesh ptr
type LPD3DXSPMESH as ID3DXSPMesh ptr
type LPD3DXSKININFO as ID3DXSkinInfo ptr
type LPD3DXPATCHMESH as ID3DXPatchMesh ptr

type D3DXATTRIBUTERANGE
	AttribId as DWORD
	FaceStart as DWORD
	FaceCount as DWORD
	VertexStart as DWORD
	VertexCount as DWORD
end type

type LPD3DXATTRIBUTERANGE as D3DXATTRIBUTERANGE ptr

type D3DXMATERIAL
	MatD3D as D3DMATERIAL9
	pTextureFilename as LPSTR
end type

type LPD3DXMATERIAL as D3DXMATERIAL ptr

enum D3DXEFFECTDEFAULTTYPE
	D3DXEDT_STRING = &h1
	D3DXEDT_FLOATS = &h2
	D3DXEDT_DWORD = &h3
	D3DXEDT_FORCEDWORD = &h7fffffff
end enum

type D3DXEFFECTDEFAULT
	pParamName as LPSTR
	Type as D3DXEFFECTDEFAULTTYPE
	NumBytes as DWORD
	pValue as LPVOID
end type

type LPD3DXEFFECTDEFAULT as D3DXEFFECTDEFAULT ptr

type D3DXEFFECTINSTANCE
	pEffectFilename as LPSTR
	NumDefaults as DWORD
	pDefaults as LPD3DXEFFECTDEFAULT
end type

type LPD3DXEFFECTINSTANCE as D3DXEFFECTINSTANCE ptr

type D3DXATTRIBUTEWEIGHTS
	Position as FLOAT
	Boundary as FLOAT
	Normal as FLOAT
	Diffuse as FLOAT
	Specular as FLOAT
	Texcoord(0 to 8-1) as FLOAT
	Tangent as FLOAT
	Binormal as FLOAT
end type

type LPD3DXATTRIBUTEWEIGHTS as D3DXATTRIBUTEWEIGHTS ptr

enum D3DXWELDEPSILONSFLAGS
	D3DXWELDEPSILONS_WELDALL = &h1
	D3DXWELDEPSILONS_WELDPARTIALMATCHES = &h2
	D3DXWELDEPSILONS_DONOTREMOVEVERTICES = &h4
	D3DXWELDEPSILONS_DONOTSPLIT = &h8
end enum

type D3DXWELDEPSILONS
	Position as FLOAT
	BlendWeights as FLOAT
	Normal as FLOAT
	PSize as FLOAT
	Specular as FLOAT
	Diffuse as FLOAT
	Texcoord(0 to 8-1) as FLOAT
	Tangent as FLOAT
	Binormal as FLOAT
	TessFactor as FLOAT
end type

type LPD3DXWELDEPSILONS as D3DXWELDEPSILONS ptr

type ID3DXBaseMeshVtbl_ as ID3DXBaseMeshVtbl

type ID3DXBaseMesh
	lpVtbl as ID3DXBaseMeshVtbl_ ptr
end type

type ID3DXBaseMeshVtbl
	QueryInterface as function(byval as ID3DXBaseMesh ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXBaseMesh ptr) as ULONG
	Release as function(byval as ID3DXBaseMesh ptr) as ULONG
	DrawSubset as function(byval as ID3DXBaseMesh ptr, byval as DWORD) as HRESULT
	GetNumFaces as function(byval as ID3DXBaseMesh ptr) as DWORD
	GetNumVertices as function(byval as ID3DXBaseMesh ptr) as DWORD
	GetFVF as function(byval as ID3DXBaseMesh ptr) as DWORD
	GetDeclaration as function(byval as ID3DXBaseMesh ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetNumBytesPerVertex as function(byval as ID3DXBaseMesh ptr) as DWORD
	GetOptions as function(byval as ID3DXBaseMesh ptr) as DWORD
	GetDevice as function(byval as ID3DXBaseMesh ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	CloneMeshFVF as function(byval as ID3DXBaseMesh ptr, byval as DWORD, byval as DWORD, byval as LPDIRECT3DDEVICE9, byval as LPD3DXMESH ptr) as HRESULT
	CloneMesh as function(byval as ID3DXBaseMesh ptr, byval as DWORD, byval as D3DVERTEXELEMENT9 ptr, byval as LPDIRECT3DDEVICE9, byval as LPD3DXMESH ptr) as HRESULT
	GetVertexBuffer as function(byval as ID3DXBaseMesh ptr, byval as LPDIRECT3DVERTEXBUFFER9 ptr) as HRESULT
	GetIndexBuffer as function(byval as ID3DXBaseMesh ptr, byval as LPDIRECT3DINDEXBUFFER9 ptr) as HRESULT
	LockVertexBuffer as function(byval as ID3DXBaseMesh ptr, byval as DWORD, byval as LPVOID ptr) as HRESULT
	UnlockVertexBuffer as function(byval as ID3DXBaseMesh ptr) as HRESULT
	LockIndexBuffer as function(byval as ID3DXBaseMesh ptr, byval as DWORD, byval as LPVOID ptr) as HRESULT
	UnlockIndexBuffer as function(byval as ID3DXBaseMesh ptr) as HRESULT
	GetAttributeTable as function(byval as ID3DXBaseMesh ptr, byval as D3DXATTRIBUTERANGE ptr, byval as DWORD ptr) as HRESULT
	ConvertPointRepsToAdjacency as function(byval as ID3DXBaseMesh ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	ConvertAdjacencyToPointReps as function(byval as ID3DXBaseMesh ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GenerateAdjacency as function(byval as ID3DXBaseMesh ptr, byval as FLOAT, byval as DWORD ptr) as HRESULT
	UpdateSemantics as function(byval as ID3DXBaseMesh ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
end type

type ID3DXMeshVtbl_ as ID3DXMeshVtbl

type ID3DXMesh
	lpVtbl as ID3DXMeshVtbl_ ptr
end type

type ID3DXMeshVtbl
	QueryInterface as function(byval as ID3DXMesh ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXMesh ptr) as ULONG
	Release as function(byval as ID3DXMesh ptr) as ULONG
	DrawSubset as function(byval as ID3DXMesh ptr, byval as DWORD) as HRESULT
	GetNumFaces as function(byval as ID3DXMesh ptr) as DWORD
	GetNumVertices as function(byval as ID3DXMesh ptr) as DWORD
	GetFVF as function(byval as ID3DXMesh ptr) as DWORD
	GetDeclaration as function(byval as ID3DXMesh ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetNumBytesPerVertex as function(byval as ID3DXMesh ptr) as DWORD
	GetOptions as function(byval as ID3DXMesh ptr) as DWORD
	GetDevice as function(byval as ID3DXMesh ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	CloneMeshFVF as function(byval as ID3DXMesh ptr, byval as DWORD, byval as DWORD, byval as LPDIRECT3DDEVICE9, byval as LPD3DXMESH ptr) as HRESULT
	CloneMesh as function(byval as ID3DXMesh ptr, byval as DWORD, byval as D3DVERTEXELEMENT9 ptr, byval as LPDIRECT3DDEVICE9, byval as LPD3DXMESH ptr) as HRESULT
	GetVertexBuffer as function(byval as ID3DXMesh ptr, byval as LPDIRECT3DVERTEXBUFFER9 ptr) as HRESULT
	GetIndexBuffer as function(byval as ID3DXMesh ptr, byval as LPDIRECT3DINDEXBUFFER9 ptr) as HRESULT
	LockVertexBuffer as function(byval as ID3DXMesh ptr, byval as DWORD, byval as LPVOID ptr) as HRESULT
	UnlockVertexBuffer as function(byval as ID3DXMesh ptr) as HRESULT
	LockIndexBuffer as function(byval as ID3DXMesh ptr, byval as DWORD, byval as LPVOID ptr) as HRESULT
	UnlockIndexBuffer as function(byval as ID3DXMesh ptr) as HRESULT
	GetAttributeTable as function(byval as ID3DXMesh ptr, byval as D3DXATTRIBUTERANGE ptr, byval as DWORD ptr) as HRESULT
	ConvertPointRepsToAdjacency as function(byval as ID3DXMesh ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	ConvertAdjacencyToPointReps as function(byval as ID3DXMesh ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GenerateAdjacency as function(byval as ID3DXMesh ptr, byval as FLOAT, byval as DWORD ptr) as HRESULT
	UpdateSemantics as function(byval as ID3DXMesh ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
	LockAttributeBuffer as function(byval as ID3DXMesh ptr, byval as DWORD, byval as DWORD ptr ptr) as HRESULT
	UnlockAttributeBuffer as function(byval as ID3DXMesh ptr) as HRESULT
	Optimize as function(byval as ID3DXMesh ptr, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD ptr, byval as LPD3DXBUFFER ptr, byval as LPD3DXMESH ptr) as HRESULT
	OptimizeInplace as function(byval as ID3DXMesh ptr, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD ptr, byval as LPD3DXBUFFER ptr) as HRESULT
	SetAttributeTable as function(byval as ID3DXMesh ptr, byval as D3DXATTRIBUTERANGE ptr, byval as DWORD) as HRESULT
end type

type ID3DXPMeshVtbl_ as ID3DXPMeshVtbl

type ID3DXPMesh
	lpVtbl as ID3DXPMeshVtbl_ ptr
end type

type ID3DXPMeshVtbl
	QueryInterface as function(byval as ID3DXPMesh ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXPMesh ptr) as ULONG
	Release as function(byval as ID3DXPMesh ptr) as ULONG
	DrawSubset as function(byval as ID3DXPMesh ptr, byval as DWORD) as HRESULT
	GetNumFaces as function(byval as ID3DXPMesh ptr) as DWORD
	GetNumVertices as function(byval as ID3DXPMesh ptr) as DWORD
	GetFVF as function(byval as ID3DXPMesh ptr) as DWORD
	GetDeclaration as function(byval as ID3DXPMesh ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetNumBytesPerVertex as function(byval as ID3DXPMesh ptr) as DWORD
	GetOptions as function(byval as ID3DXPMesh ptr) as DWORD
	GetDevice as function(byval as ID3DXPMesh ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	CloneMeshFVF as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as DWORD, byval as LPDIRECT3DDEVICE9, byval as LPD3DXMESH ptr) as HRESULT
	CloneMesh as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as D3DVERTEXELEMENT9 ptr, byval as LPDIRECT3DDEVICE9, byval as LPD3DXMESH ptr) as HRESULT
	GetVertexBuffer as function(byval as ID3DXPMesh ptr, byval as LPDIRECT3DVERTEXBUFFER9 ptr) as HRESULT
	GetIndexBuffer as function(byval as ID3DXPMesh ptr, byval as LPDIRECT3DINDEXBUFFER9 ptr) as HRESULT
	LockVertexBuffer as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as LPVOID ptr) as HRESULT
	UnlockVertexBuffer as function(byval as ID3DXPMesh ptr) as HRESULT
	LockIndexBuffer as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as LPVOID ptr) as HRESULT
	UnlockIndexBuffer as function(byval as ID3DXPMesh ptr) as HRESULT
	GetAttributeTable as function(byval as ID3DXPMesh ptr, byval as D3DXATTRIBUTERANGE ptr, byval as DWORD ptr) as HRESULT
	ConvertPointRepsToAdjacency as function(byval as ID3DXPMesh ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	ConvertAdjacencyToPointReps as function(byval as ID3DXPMesh ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GenerateAdjacency as function(byval as ID3DXPMesh ptr, byval as FLOAT, byval as DWORD ptr) as HRESULT
	UpdateSemantics as function(byval as ID3DXPMesh ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
	ClonePMeshFVF as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as DWORD, byval as LPDIRECT3DDEVICE9, byval as LPD3DXPMESH ptr) as HRESULT
	ClonePMesh as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as D3DVERTEXELEMENT9 ptr, byval as LPDIRECT3DDEVICE9, byval as LPD3DXPMESH ptr) as HRESULT
	SetNumFaces as function(byval as ID3DXPMesh ptr, byval as DWORD) as HRESULT
	SetNumVertices as function(byval as ID3DXPMesh ptr, byval as DWORD) as HRESULT
	GetMaxFaces as function(byval as ID3DXPMesh ptr) as DWORD
	GetMinFaces as function(byval as ID3DXPMesh ptr) as DWORD
	GetMaxVertices as function(byval as ID3DXPMesh ptr) as DWORD
	GetMinVertices as function(byval as ID3DXPMesh ptr) as DWORD
	Save as function(byval as ID3DXPMesh ptr, byval as IStream ptr, byval as D3DXMATERIAL ptr, byval as D3DXEFFECTINSTANCE ptr, byval as DWORD) as HRESULT
	Optimize as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr, byval as LPD3DXBUFFER ptr, byval as LPD3DXMESH ptr) as HRESULT
	OptimizeBaseLOD as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
	TrimByFaces as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	TrimByVertices as function(byval as ID3DXPMesh ptr, byval as DWORD, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GetAdjacency as function(byval as ID3DXPMesh ptr, byval as DWORD ptr) as HRESULT
	GenerateVertexHistory as function(byval as ID3DXPMesh ptr, byval as DWORD ptr) as HRESULT
end type

type ID3DXSPMeshVtbl_ as ID3DXSPMeshVtbl

type ID3DXSPMesh
	lpVtbl as ID3DXSPMeshVtbl_ ptr
end type

type ID3DXSPMeshVtbl
	QueryInterface as function(byval as ID3DXSPMesh ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXSPMesh ptr) as ULONG
	Release as function(byval as ID3DXSPMesh ptr) as ULONG
	GetNumFaces as function(byval as ID3DXSPMesh ptr) as DWORD
	GetNumVertices as function(byval as ID3DXSPMesh ptr) as DWORD
	GetFVF as function(byval as ID3DXSPMesh ptr) as DWORD
	GetDeclaration as function(byval as ID3DXSPMesh ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetOptions as function(byval as ID3DXSPMesh ptr) as DWORD
	GetDevice as function(byval as ID3DXSPMesh ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	CloneMeshFVF as function(byval as ID3DXSPMesh ptr, byval as DWORD, byval as DWORD, byval as LPDIRECT3DDEVICE9, byval as DWORD ptr, byval as DWORD ptr, byval as LPD3DXMESH ptr) as HRESULT
	CloneMesh as function(byval as ID3DXSPMesh ptr, byval as DWORD, byval as D3DVERTEXELEMENT9 ptr, byval as LPDIRECT3DDEVICE9, byval as DWORD ptr, byval as DWORD ptr, byval as LPD3DXMESH ptr) as HRESULT
	ClonePMeshFVF as function(byval as ID3DXSPMesh ptr, byval as DWORD, byval as DWORD, byval as LPDIRECT3DDEVICE9, byval as DWORD ptr, byval as FLOAT ptr, byval as LPD3DXPMESH ptr) as HRESULT
	ClonePMesh as function(byval as ID3DXSPMesh ptr, byval as DWORD, byval as D3DVERTEXELEMENT9 ptr, byval as LPDIRECT3DDEVICE9, byval as DWORD ptr, byval as FLOAT ptr, byval as LPD3DXPMESH ptr) as HRESULT
	ReduceFaces as function(byval as ID3DXSPMesh ptr, byval as DWORD) as HRESULT
	ReduceVertices as function(byval as ID3DXSPMesh ptr, byval as DWORD) as HRESULT
	GetMaxFaces as function(byval as ID3DXSPMesh ptr) as DWORD
	GetMaxVertices as function(byval as ID3DXSPMesh ptr) as DWORD
	GetVertexAttributeWeights as function(byval as ID3DXSPMesh ptr, byval as LPD3DXATTRIBUTEWEIGHTS) as HRESULT
	GetVertexWeights as function(byval as ID3DXSPMesh ptr, byval as FLOAT ptr) as HRESULT
end type

#define UNUSED16 (&hffff)
#define UNUSED32 (&hffffffff)

enum D3DXMESHOPT
	D3DXMESHOPT_COMPACT = &h01000000
	D3DXMESHOPT_ATTRSORT = &h02000000
	D3DXMESHOPT_VERTEXCACHE = &h04000000
	D3DXMESHOPT_STRIPREORDER = &h08000000
	D3DXMESHOPT_IGNOREVERTS = &h10000000
	D3DXMESHOPT_DONOTSPLIT = &h20000000
	D3DXMESHOPT_DEVICEINDEPENDENT = &h00400000
end enum

type D3DXBONECOMBINATION
	AttribId as DWORD
	FaceStart as DWORD
	FaceCount as DWORD
	VertexStart as DWORD
	VertexCount as DWORD
	BoneId as DWORD ptr
end type

type LPD3DXBONECOMBINATION as D3DXBONECOMBINATION ptr

type D3DXPATCHINFO
	PatchType as D3DXPATCHMESHTYPE
	Degree as D3DDEGREETYPE
	Basis as D3DBASISTYPE
end type

type LPD3DXPATCHINFO as D3DXPATCHINFO ptr

type ID3DXPatchMeshVtbl_ as ID3DXPatchMeshVtbl

type ID3DXPatchMesh
	lpVtbl as ID3DXPatchMeshVtbl_ ptr
end type

type ID3DXPatchMeshVtbl
	QueryInterface as function(byval as ID3DXPatchMesh ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXPatchMesh ptr) as ULONG
	Release as function(byval as ID3DXPatchMesh ptr) as ULONG
	GetNumPatches as function(byval as ID3DXPatchMesh ptr) as DWORD
	GetNumVertices as function(byval as ID3DXPatchMesh ptr) as DWORD
	GetDeclaration as function(byval as ID3DXPatchMesh ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetControlVerticesPerPatch as function(byval as ID3DXPatchMesh ptr) as DWORD
	GetOptions as function(byval as ID3DXPatchMesh ptr) as DWORD
	GetDevice as function(byval as ID3DXPatchMesh ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	GetPatchInfo as function(byval as ID3DXPatchMesh ptr, byval as LPD3DXPATCHINFO) as HRESULT
	GetVertexBuffer as function(byval as ID3DXPatchMesh ptr, byval as LPDIRECT3DVERTEXBUFFER9 ptr) as HRESULT
	GetIndexBuffer as function(byval as ID3DXPatchMesh ptr, byval as LPDIRECT3DINDEXBUFFER9 ptr) as HRESULT
	LockVertexBuffer as function(byval as ID3DXPatchMesh ptr, byval as DWORD, byval as LPVOID ptr) as HRESULT
	UnlockVertexBuffer as function(byval as ID3DXPatchMesh ptr) as HRESULT
	LockIndexBuffer as function(byval as ID3DXPatchMesh ptr, byval as DWORD, byval as LPVOID ptr) as HRESULT
	UnlockIndexBuffer as function(byval as ID3DXPatchMesh ptr) as HRESULT
	LockAttributeBuffer as function(byval as ID3DXPatchMesh ptr, byval as DWORD, byval as DWORD ptr ptr) as HRESULT
	UnlockAttributeBuffer as function(byval as ID3DXPatchMesh ptr) as HRESULT
	GetTessSize as function(byval as ID3DXPatchMesh ptr, byval as FLOAT, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GenerateAdjacency as function(byval as ID3DXPatchMesh ptr, byval as FLOAT) as HRESULT
	CloneMesh as function(byval as ID3DXPatchMesh ptr, byval as DWORD, byval as D3DVERTEXELEMENT9 ptr, byval as LPD3DXPATCHMESH ptr) as HRESULT
	Optimize as function(byval as ID3DXPatchMesh ptr, byval as DWORD) as HRESULT
	SetDisplaceParam as function(byval as ID3DXPatchMesh ptr, byval as LPDIRECT3DBASETEXTURE9, byval as D3DTEXTUREFILTERTYPE, byval as D3DTEXTUREFILTERTYPE, byval as D3DTEXTUREFILTERTYPE, byval as D3DTEXTUREADDRESS, byval as DWORD) as HRESULT
	GetDisplaceParam as function(byval as ID3DXPatchMesh ptr, byval as LPDIRECT3DBASETEXTURE9 ptr, byval as D3DTEXTUREFILTERTYPE ptr, byval as D3DTEXTUREFILTERTYPE ptr, byval as D3DTEXTUREFILTERTYPE ptr, byval as D3DTEXTUREADDRESS ptr, byval as DWORD ptr) as HRESULT
	Tessellate as function(byval as ID3DXPatchMesh ptr, byval as FLOAT, byval as LPD3DXMESH) as HRESULT
	TessellateAdaptive as function(byval as ID3DXPatchMesh ptr, byval as D3DXVECTOR4 ptr, byval as DWORD, byval as DWORD, byval as LPD3DXMESH) as HRESULT
end type

type ID3DXSkinInfoVtbl_ as ID3DXSkinInfoVtbl

type ID3DXSkinInfo
	lpVtbl as ID3DXSkinInfoVtbl_ ptr
end type

type ID3DXSkinInfoVtbl
	QueryInterface as function(byval as ID3DXSkinInfo ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXSkinInfo ptr) as ULONG
	Release as function(byval as ID3DXSkinInfo ptr) as ULONG
	SetBoneInfluence as function(byval as ID3DXSkinInfo ptr, byval as DWORD, byval as DWORD, byval as DWORD ptr, byval as FLOAT ptr) as HRESULT
	SetBoneVertexInfluence as function(byval as ID3DXSkinInfo ptr, byval as DWORD, byval as DWORD, byval as single) as HRESULT
	GetNumBoneInfluences as function(byval as ID3DXSkinInfo ptr, byval as DWORD) as DWORD
	GetBoneInfluence as function(byval as ID3DXSkinInfo ptr, byval as DWORD, byval as DWORD ptr, byval as FLOAT ptr) as HRESULT
	GetBoneVertexInfluence as function(byval as ID3DXSkinInfo ptr, byval as DWORD, byval as DWORD, byval as single ptr, byval as DWORD ptr) as HRESULT
	GetMaxVertexInfluences as function(byval as ID3DXSkinInfo ptr, byval as DWORD ptr) as HRESULT
	GetNumBones as function(byval as ID3DXSkinInfo ptr) as DWORD
	FindBoneVertexInfluenceIndex as function(byval as ID3DXSkinInfo ptr, byval as DWORD, byval as DWORD, byval as DWORD ptr) as HRESULT
	GetMaxFaceInfluences as function(byval as ID3DXSkinInfo ptr, byval as LPDIRECT3DINDEXBUFFER9, byval as DWORD, byval as DWORD ptr) as HRESULT
	SetMinBoneInfluence as function(byval as ID3DXSkinInfo ptr, byval as FLOAT) as HRESULT
	GetMinBoneInfluence as function(byval as ID3DXSkinInfo ptr) as FLOAT
	SetBoneName as function(byval as ID3DXSkinInfo ptr, byval as DWORD, byval as LPCSTR) as HRESULT
	GetBoneName as function(byval as ID3DXSkinInfo ptr, byval as DWORD) as LPCSTR
	SetBoneOffsetMatrix as function(byval as ID3DXSkinInfo ptr, byval as DWORD, byval as D3DXMATRIX ptr) as HRESULT
	GetBoneOffsetMatrix as function(byval as ID3DXSkinInfo ptr, byval as DWORD) as LPD3DXMATRIX
	Clone as function(byval as ID3DXSkinInfo ptr, byval as LPD3DXSKININFO ptr) as HRESULT
	Remap as function(byval as ID3DXSkinInfo ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
	SetFVF as function(byval as ID3DXSkinInfo ptr, byval as DWORD) as HRESULT
	SetDeclaration as function(byval as ID3DXSkinInfo ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
	GetFVF as function(byval as ID3DXSkinInfo ptr) as DWORD
	GetDeclaration as function(byval as ID3DXSkinInfo ptr, byval as D3DVERTEXELEMENT9 ptr) as HRESULT
	UpdateSkinnedMesh as function(byval as ID3DXSkinInfo ptr, byval as D3DXMATRIX ptr, byval as D3DXMATRIX ptr, byval as LPCVOID, byval as PVOID) as HRESULT
	ConvertToBlendedMesh as function(byval as ID3DXSkinInfo ptr, byval as LPD3DXMESH, byval as DWORD, byval as DWORD ptr, byval as LPDWORD, byval as DWORD ptr, byval as LPD3DXBUFFER ptr, byval as DWORD ptr, byval as DWORD ptr, byval as LPD3DXBUFFER ptr, byval as LPD3DXMESH ptr) as HRESULT
	ConvertToIndexedBlendedMesh as function(byval as ID3DXSkinInfo ptr, byval as LPD3DXMESH, byval as DWORD, byval as DWORD, byval as DWORD ptr, byval as LPDWORD, byval as DWORD ptr, byval as LPD3DXBUFFER ptr, byval as DWORD ptr, byval as DWORD ptr, byval as LPD3DXBUFFER ptr, byval as LPD3DXMESH ptr) as HRESULT
end type

declare function D3DXCreateMesh alias "D3DXCreateMesh" (byval NumFaces as DWORD, byval NumVertices as DWORD, byval Options as DWORD, byval pDeclaration as D3DVERTEXELEMENT9 ptr, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppMesh as LPD3DXMESH ptr) as HRESULT
declare function D3DXCreateMeshFVF alias "D3DXCreateMeshFVF" (byval NumFaces as DWORD, byval NumVertices as DWORD, byval Options as DWORD, byval FVF as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppMesh as LPD3DXMESH ptr) as HRESULT
declare function D3DXCreateSPMesh alias "D3DXCreateSPMesh" (byval pMesh as LPD3DXMESH, byval pAdjacency as DWORD ptr, byval pVertexAttributeWeights as D3DXATTRIBUTEWEIGHTS ptr, byval pVertexWeights as FLOAT ptr, byval ppSMesh as LPD3DXSPMESH ptr) as HRESULT
declare function D3DXCleanMesh alias "D3DXCleanMesh" (byval CleanType as D3DXCLEANTYPE, byval pMeshIn as LPD3DXMESH, byval pAdjacencyIn as DWORD ptr, byval ppMeshOut as LPD3DXMESH ptr, byval pAdjacencyOut as DWORD ptr, byval ppErrorsAndWarnings as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXValidMesh alias "D3DXValidMesh" (byval pMeshIn as LPD3DXMESH, byval pAdjacency as DWORD ptr, byval ppErrorsAndWarnings as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXGeneratePMesh alias "D3DXGeneratePMesh" (byval pMesh as LPD3DXMESH, byval pAdjacency as DWORD ptr, byval pVertexAttributeWeights as D3DXATTRIBUTEWEIGHTS ptr, byval pVertexWeights as FLOAT ptr, byval MinValue as DWORD, byval Options as DWORD, byval ppPMesh as LPD3DXPMESH ptr) as HRESULT
declare function D3DXSimplifyMesh alias "D3DXSimplifyMesh" (byval pMesh as LPD3DXMESH, byval pAdjacency as DWORD ptr, byval pVertexAttributeWeights as D3DXATTRIBUTEWEIGHTS ptr, byval pVertexWeights as FLOAT ptr, byval MinValue as DWORD, byval Options as DWORD, byval ppMesh as LPD3DXMESH ptr) as HRESULT
declare function D3DXComputeBoundingSphere alias "D3DXComputeBoundingSphere" (byval pFirstPosition as D3DXVECTOR3 ptr, byval NumVertices as DWORD, byval dwStride as DWORD, byval pCenter as D3DXVECTOR3 ptr, byval pRadius as FLOAT ptr) as HRESULT
declare function D3DXComputeBoundingBox alias "D3DXComputeBoundingBox" (byval pFirstPosition as D3DXVECTOR3 ptr, byval NumVertices as DWORD, byval dwStride as DWORD, byval pMin as D3DXVECTOR3 ptr, byval pMax as D3DXVECTOR3 ptr) as HRESULT
declare function D3DXComputeNormals alias "D3DXComputeNormals" (byval pMesh as LPD3DXBASEMESH, byval pAdjacency as DWORD ptr) as HRESULT
declare function D3DXCreateBuffer alias "D3DXCreateBuffer" (byval NumBytes as DWORD, byval ppBuffer as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXLoadMeshFromXInMemory alias "D3DXLoadMeshFromXInMemory" (byval Memory as LPCVOID, byval SizeOfMemory as DWORD, byval Options as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppAdjacency as LPD3DXBUFFER ptr, byval ppMaterials as LPD3DXBUFFER ptr, byval ppEffectInstances as LPD3DXBUFFER ptr, byval pNumMaterials as DWORD ptr, byval ppMesh as LPD3DXMESH ptr) as HRESULT
declare function D3DXLoadMeshFromXResource alias "D3DXLoadMeshFromXResource" (byval Module as HMODULE, byval Name as LPCSTR, byval Type as LPCSTR, byval Options as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppAdjacency as LPD3DXBUFFER ptr, byval ppMaterials as LPD3DXBUFFER ptr, byval ppEffectInstances as LPD3DXBUFFER ptr, byval pNumMaterials as DWORD ptr, byval ppMesh as LPD3DXMESH ptr) as HRESULT
#ifdef UNICODE
declare function D3DXLoadMeshFromX alias "D3DXLoadMeshFromXW" (byval pFilename as LPCWSTR, byval Options as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppAdjacency as LPD3DXBUFFER ptr, byval ppMaterials as LPD3DXBUFFER ptr, byval ppEffectInstances as LPD3DXBUFFER ptr, byval pNumMaterials as DWORD ptr, byval ppMesh as LPD3DXMESH ptr) as HRESULT
declare function D3DXSaveMeshToX alias "D3DXSaveMeshToXW" (byval pFilename as LPCWSTR, byval pMesh as LPD3DXMESH, byval pAdjacency as DWORD ptr, byval pMaterials as D3DXMATERIAL ptr, byval pEffectInstances as D3DXEFFECTINSTANCE ptr, byval NumMaterials as DWORD, byval Format as DWORD) as HRESULT
#else
declare function D3DXLoadMeshFromX alias "D3DXLoadMeshFromXA" (byval pFilename as LPCSTR, byval Options as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppAdjacency as LPD3DXBUFFER ptr, byval ppMaterials as LPD3DXBUFFER ptr, byval ppEffectInstances as LPD3DXBUFFER ptr, byval pNumMaterials as DWORD ptr, byval ppMesh as LPD3DXMESH ptr) as HRESULT
declare function D3DXSaveMeshToX alias "D3DXSaveMeshToXA" (byval pFilename as LPCSTR, byval pMesh as LPD3DXMESH, byval pAdjacency as DWORD ptr, byval pMaterials as D3DXMATERIAL ptr, byval pEffectInstances as D3DXEFFECTINSTANCE ptr, byval NumMaterials as DWORD, byval Format as DWORD) as HRESULT
#endif
declare function D3DXCreatePMeshFromStream alias "D3DXCreatePMeshFromStream" (byval pStream as IStream ptr, byval Options as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppMaterials as LPD3DXBUFFER ptr, byval ppEffectInstances as LPD3DXBUFFER ptr, byval pNumMaterials as DWORD ptr, byval ppPMesh as LPD3DXPMESH ptr) as HRESULT
declare function D3DXCreateSkinInfo alias "D3DXCreateSkinInfo" (byval NumVertices as DWORD, byval pDeclaration as D3DVERTEXELEMENT9 ptr, byval NumBones as DWORD, byval ppSkinInfo as LPD3DXSKININFO ptr) as HRESULT
declare function D3DXCreateSkinInfoFVF alias "D3DXCreateSkinInfoFVF" (byval NumVertices as DWORD, byval FVF as DWORD, byval NumBones as DWORD, byval ppSkinInfo as LPD3DXSKININFO ptr) as HRESULT
declare function D3DXLoadMeshFromXof alias "D3DXLoadMeshFromXof" (byval pxofMesh as LPD3DXFILEDATA, byval Options as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppAdjacency as LPD3DXBUFFER ptr, byval ppMaterials as LPD3DXBUFFER ptr, byval ppEffectInstances as LPD3DXBUFFER ptr, byval pNumMaterials as DWORD ptr, byval ppMesh as LPD3DXMESH ptr) as HRESULT
declare function D3DXLoadSkinMeshFromXof alias "D3DXLoadSkinMeshFromXof" (byval pxofMesh as LPD3DXFILEDATA, byval Options as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppAdjacency as LPD3DXBUFFER ptr, byval ppMaterials as LPD3DXBUFFER ptr, byval ppEffectInstances as LPD3DXBUFFER ptr, byval pMatOut as DWORD ptr, byval ppSkinInfo as LPD3DXSKININFO ptr, byval ppMesh as LPD3DXMESH ptr) as HRESULT
declare function D3DXCreateSkinInfoFromBlendedMesh alias "D3DXCreateSkinInfoFromBlendedMesh" (byval pMesh as LPD3DXBASEMESH, byval NumBones as DWORD, byval pBoneCombinationTable as D3DXBONECOMBINATION ptr, byval ppSkinInfo as LPD3DXSKININFO ptr) as HRESULT
declare function D3DXTessellateNPatches alias "D3DXTessellateNPatches" (byval pMeshIn as LPD3DXMESH, byval pAdjacencyIn as DWORD ptr, byval NumSegs as FLOAT, byval QuadraticInterpNormals as BOOL, byval ppMeshOut as LPD3DXMESH ptr, byval ppAdjacencyOut as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXGenerateOutputDecl alias "D3DXGenerateOutputDecl" (byval pOutput as D3DVERTEXELEMENT9 ptr, byval pInput as D3DVERTEXELEMENT9 ptr) as HRESULT
declare function D3DXLoadPatchMeshFromXof alias "D3DXLoadPatchMeshFromXof" (byval pXofObjMesh as LPD3DXFILEDATA, byval Options as DWORD, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppMaterials as LPD3DXBUFFER ptr, byval ppEffectInstances as LPD3DXBUFFER ptr, byval pNumMaterials as PDWORD, byval ppMesh as LPD3DXPATCHMESH ptr) as HRESULT
declare function D3DXRectPatchSize alias "D3DXRectPatchSize" (byval pfNumSegs as FLOAT ptr, byval pdwTriangles as DWORD ptr, byval pdwVertices as DWORD ptr) as HRESULT
declare function D3DXTriPatchSize alias "D3DXTriPatchSize" (byval pfNumSegs as FLOAT ptr, byval pdwTriangles as DWORD ptr, byval pdwVertices as DWORD ptr) as HRESULT
declare function D3DXTessellateRectPatch alias "D3DXTessellateRectPatch" (byval pVB as LPDIRECT3DVERTEXBUFFER9, byval pNumSegs as FLOAT ptr, byval pdwInDecl as D3DVERTEXELEMENT9 ptr, byval pRectPatchInfo as D3DRECTPATCH_INFO ptr, byval pMesh as LPD3DXMESH) as HRESULT
declare function D3DXTessellateTriPatch alias "D3DXTessellateTriPatch" (byval pVB as LPDIRECT3DVERTEXBUFFER9, byval pNumSegs as FLOAT ptr, byval pInDecl as D3DVERTEXELEMENT9 ptr, byval pTriPatchInfo as D3DTRIPATCH_INFO ptr, byval pMesh as LPD3DXMESH) as HRESULT
declare function D3DXCreateNPatchMesh alias "D3DXCreateNPatchMesh" (byval pMeshSysMem as LPD3DXMESH, byval pPatchMesh as LPD3DXPATCHMESH ptr) as HRESULT
declare function D3DXCreatePatchMesh alias "D3DXCreatePatchMesh" (byval pInfo as D3DXPATCHINFO ptr, byval dwNumPatches as DWORD, byval dwNumVertices as DWORD, byval dwOptions as DWORD, byval pDecl as D3DVERTEXELEMENT9 ptr, byval pD3DDevice as LPDIRECT3DDEVICE9, byval pPatchMesh as LPD3DXPATCHMESH ptr) as HRESULT
declare function D3DXValidPatchMesh alias "D3DXValidPatchMesh" (byval pMesh as LPD3DXPATCHMESH, byval dwcDegenerateVertices as DWORD ptr, byval dwcDegeneratePatches as DWORD ptr, byval ppErrorsAndWarnings as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXGetFVFVertexSize alias "D3DXGetFVFVertexSize" (byval FVF as DWORD) as UINT
declare function D3DXGetDeclVertexSize alias "D3DXGetDeclVertexSize" (byval pDecl as D3DVERTEXELEMENT9 ptr, byval Stream as DWORD) as UINT
declare function D3DXGetDeclLength alias "D3DXGetDeclLength" (byval pDecl as D3DVERTEXELEMENT9 ptr) as UINT
declare function D3DXDeclaratorFromFVF alias "D3DXDeclaratorFromFVF" (byval FVF as DWORD, byval pDeclarator as D3DVERTEXELEMENT9 ptr) as HRESULT
declare function D3DXFVFFromDeclarator alias "D3DXFVFFromDeclarator" (byval pDeclarator as D3DVERTEXELEMENT9 ptr, byval pFVF as DWORD ptr) as HRESULT
declare function D3DXWeldVertices alias "D3DXWeldVertices" (byval pMesh as LPD3DXMESH, byval Flags as DWORD, byval pEpsilons as D3DXWELDEPSILONS ptr, byval pAdjacencyIn as DWORD ptr, byval pAdjacencyOut as DWORD ptr, byval pFaceRemap as DWORD ptr, byval ppVertexRemap as LPD3DXBUFFER ptr) as HRESULT

type D3DXINTERSECTINFO
	FaceIndex as DWORD
	U as FLOAT
	V as FLOAT
	Dist as FLOAT
end type

type LPD3DXINTERSECTINFO as D3DXINTERSECTINFO ptr

declare function D3DXIntersect alias "D3DXIntersect" (byval pMesh as LPD3DXBASEMESH, byval pRayPos as D3DXVECTOR3 ptr, byval pRayDir as D3DXVECTOR3 ptr, byval pHit as BOOL ptr, byval pFaceIndex as DWORD ptr, byval pU as FLOAT ptr, byval pV as FLOAT ptr, byval pDist as FLOAT ptr, byval ppAllHits as LPD3DXBUFFER ptr, byval pCountOfHits as DWORD ptr) as HRESULT
declare function D3DXIntersectSubset alias "D3DXIntersectSubset" (byval pMesh as LPD3DXBASEMESH, byval AttribId as DWORD, byval pRayPos as D3DXVECTOR3 ptr, byval pRayDir as D3DXVECTOR3 ptr, byval pHit as BOOL ptr, byval pFaceIndex as DWORD ptr, byval pU as FLOAT ptr, byval pV as FLOAT ptr, byval pDist as FLOAT ptr, byval ppAllHits as LPD3DXBUFFER ptr, byval pCountOfHits as DWORD ptr) as HRESULT
declare function D3DXSplitMesh alias "D3DXSplitMesh" (byval pMeshIn as LPD3DXMESH, byval pAdjacencyIn as DWORD ptr, byval MaxSize as DWORD, byval Options as DWORD, byval pMeshesOut as DWORD ptr, byval ppMeshArrayOut as LPD3DXBUFFER ptr, byval ppAdjacencyArrayOut as LPD3DXBUFFER ptr, byval ppFaceRemapArrayOut as LPD3DXBUFFER ptr, byval ppVertRemapArrayOut as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXIntersectTri alias "D3DXIntersectTri" (byval p0 as D3DXVECTOR3 ptr, byval p1 as D3DXVECTOR3 ptr, byval p2 as D3DXVECTOR3 ptr, byval pRayPos as D3DXVECTOR3 ptr, byval pRayDir as D3DXVECTOR3 ptr, byval pU as FLOAT ptr, byval pV as FLOAT ptr, byval pDist as FLOAT ptr) as BOOL
declare function D3DXSphereBoundProbe alias "D3DXSphereBoundProbe" (byval pCenter as D3DXVECTOR3 ptr, byval Radius as FLOAT, byval pRayPosition as D3DXVECTOR3 ptr, byval pRayDirection as D3DXVECTOR3 ptr) as BOOL
declare function D3DXBoxBoundProbe alias "D3DXBoxBoundProbe" (byval pMin as D3DXVECTOR3 ptr, byval pMax as D3DXVECTOR3 ptr, byval pRayPosition as D3DXVECTOR3 ptr, byval pRayDirection as D3DXVECTOR3 ptr) as BOOL
declare function D3DXComputeTangent alias "D3DXComputeTangent" (byval Mesh as LPD3DXMESH, byval TexStage as DWORD, byval TangentIndex as DWORD, byval BinormIndex as DWORD, byval Wrap as DWORD, byval pAdjacency as DWORD ptr) as HRESULT
declare function D3DXConvertMeshSubsetToSingleStrip alias "D3DXConvertMeshSubsetToSingleStrip" (byval MeshIn as LPD3DXBASEMESH, byval AttribId as DWORD, byval IBOptions as DWORD, byval ppIndexBuffer as LPDIRECT3DINDEXBUFFER9 ptr, byval pNumIndices as DWORD ptr) as HRESULT
declare function D3DXConvertMeshSubsetToStrips alias "D3DXConvertMeshSubsetToStrips" (byval MeshIn as LPD3DXBASEMESH, byval AttribId as DWORD, byval IBOptions as DWORD, byval ppIndexBuffer as LPDIRECT3DINDEXBUFFER9 ptr, byval pNumIndices as DWORD ptr, byval ppStripLengths as LPD3DXBUFFER ptr, byval pNumStrips as DWORD ptr) as HRESULT
declare function D3DXOptimizeFaces alias "D3DXOptimizeFaces" (byval pbIndices as LPCVOID, byval cFaces as UINT, byval cVertices as UINT, byval b32BitIndices as BOOL, byval pFaceRemap as DWORD ptr) as HRESULT
declare function D3DXOptimizeVertices alias "D3DXOptimizeVertices" (byval pbIndices as LPCVOID, byval cFaces as UINT, byval cVertices as UINT, byval b32BitIndices as BOOL, byval pVertexRemap as DWORD ptr) as HRESULT

enum D3DXSHCOMPRESSQUALITYTYPE
	D3DXSHCQUAL_FASTLOWQUALITY = 1
	D3DXSHCQUAL_SLOWHIGHQUALITY = 2
	D3DXSHCQUAL_FORCE_DWORD = &h7fffffff
end enum

enum D3DXSHGPUSIMOPT
	D3DXSHGPUSIMOPT_SHADOWRES256 = 1
	D3DXSHGPUSIMOPT_SHADOWRES512 = 0
	D3DXSHGPUSIMOPT_SHADOWRES1024 = 2
	D3DXSHGPUSIMOPT_SHADOWRES2048 = 3
	D3DXSHGPUSIMOPT_HIGHQUALITY = 4
	D3DXSHGPUSIMOPT_FORCE_DWORD = &h7fffffff
end enum

type D3DXSHMATERIAL
	Diffuse as D3DCOLORVALUE
	bMirror as BOOL
	bSubSurf as BOOL
	RelativeIndexOfRefraction as FLOAT
	Absorption as D3DCOLORVALUE
	ReducedScattering as D3DCOLORVALUE
end type

type D3DXSHPRTSPLITMESHVERTDATA
	uVertRemap as UINT
	uSubCluster as UINT
	ucVertStatus as UCHAR
end type

type D3DXSHPRTSPLITMESHCLUSTERDATA
	uVertStart as UINT
	uVertLength as UINT
	uFaceStart as UINT
	uFaceLength as UINT
	uClusterStart as UINT
	uClusterLength as UINT
end type

type LPD3DXSHPRTSIMCB as function(byval as single, byval as LPVOID) as HRESULT

extern IID_ID3DXPRTBuffer alias "IID_ID3DXPRTBuffer" as GUID
extern IID_ID3DXPRTCompBuffer alias "IID_ID3DXPRTCompBuffer" as GUID
extern IID_ID3DXTextureGutterHelper alias "IID_ID3DXTextureGutterHelper" as GUID
extern IID_ID3DXPRTEngine alias "IID_ID3DXPRTEngine" as GUID

type LPD3DXTEXTUREGUTTERHELPER as ID3DXTextureGutterHelper ptr
type LPD3DXPRTBUFFER as ID3DXPRTBuffer ptr

type ID3DXPRTBufferVtbl_ as ID3DXPRTBufferVtbl

type ID3DXPRTBuffer
	lpVtbl as ID3DXPRTBufferVtbl_ ptr
end type

type ID3DXPRTBufferVtbl
	QueryInterface as function(byval as ID3DXPRTBuffer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXPRTBuffer ptr) as ULONG
	Release as function(byval as ID3DXPRTBuffer ptr) as ULONG
	GetNumSamples as function(byval as ID3DXPRTBuffer ptr) as UINT
	GetNumCoeffs as function(byval as ID3DXPRTBuffer ptr) as UINT
	GetNumChannels as function(byval as ID3DXPRTBuffer ptr) as UINT
	IsTexture as function(byval as ID3DXPRTBuffer ptr) as BOOL
	GetWidth as function(byval as ID3DXPRTBuffer ptr) as UINT
	GetHeight as function(byval as ID3DXPRTBuffer ptr) as UINT
	Resize as function(byval as ID3DXPRTBuffer ptr, byval as UINT) as HRESULT
	LockBuffer as function(byval as ID3DXPRTBuffer ptr, byval as UINT, byval as UINT, byval as FLOAT ptr ptr) as HRESULT
	UnlockBuffer as function(byval as ID3DXPRTBuffer ptr) as HRESULT
	ScaleBuffer as function(byval as ID3DXPRTBuffer ptr, byval as FLOAT) as HRESULT
	AddBuffer as function(byval as ID3DXPRTBuffer ptr, byval as LPD3DXPRTBUFFER) as HRESULT
	AttachGH as function(byval as ID3DXPRTBuffer ptr, byval as LPD3DXTEXTUREGUTTERHELPER) as HRESULT
	ReleaseGH as function(byval as ID3DXPRTBuffer ptr) as HRESULT
	EvalGH as function(byval as ID3DXPRTBuffer ptr) as HRESULT
	ExtractTexture as function(byval as ID3DXPRTBuffer ptr, byval as UINT, byval as UINT, byval as UINT, byval as LPDIRECT3DTEXTURE9) as HRESULT
	ExtractToMesh as function(byval as ID3DXPRTBuffer ptr, byval as UINT, byval as D3DDECLUSAGE, byval as UINT, byval as LPD3DXMESH) as HRESULT
end type

type LPD3DXPRTCOMPBUFFER as ID3DXPRTCompBuffer ptr

type ID3DXPRTCompBufferVtbl_ as ID3DXPRTCompBufferVtbl

type ID3DXPRTCompBuffer
	lpVtbl as ID3DXPRTCompBufferVtbl_ ptr
end type

type ID3DXPRTCompBufferVtbl
	QueryInterface as function(byval as ID3DXPRTCompBuffer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXPRTCompBuffer ptr) as ULONG
	Release as function(byval as ID3DXPRTCompBuffer ptr) as ULONG
	GetNumSamples as function(byval as ID3DXPRTCompBuffer ptr) as UINT
	GetNumCoeffs as function(byval as ID3DXPRTCompBuffer ptr) as UINT
	GetNumChannels as function(byval as ID3DXPRTCompBuffer ptr) as UINT
	IsTexture as function(byval as ID3DXPRTCompBuffer ptr) as BOOL
	GetWidth as function(byval as ID3DXPRTCompBuffer ptr) as UINT
	GetHeight as function(byval as ID3DXPRTCompBuffer ptr) as UINT
	GetNumClusters as function(byval as ID3DXPRTCompBuffer ptr) as UINT
	GetNumPCA as function(byval as ID3DXPRTCompBuffer ptr) as UINT
	NormalizeData as function(byval as ID3DXPRTCompBuffer ptr) as HRESULT
	ExtractBasis as function(byval as ID3DXPRTCompBuffer ptr, byval as UINT, byval as FLOAT ptr) as HRESULT
	ExtractClusterIDs as function(byval as ID3DXPRTCompBuffer ptr, byval as UINT ptr) as HRESULT
	ExtractPCA as function(byval as ID3DXPRTCompBuffer ptr, byval as UINT, byval as UINT, byval as FLOAT ptr) as HRESULT
	ExtractTexture as function(byval as ID3DXPRTCompBuffer ptr, byval as UINT, byval as UINT, byval as LPDIRECT3DTEXTURE9) as HRESULT
	ExtractToMesh as function(byval as ID3DXPRTCompBuffer ptr, byval as UINT, byval as D3DDECLUSAGE, byval as UINT, byval as LPD3DXMESH) as HRESULT
end type

type ID3DXTextureGutterHelperVtbl_ as ID3DXTextureGutterHelperVtbl

type ID3DXTextureGutterHelper
	lpVtbl as ID3DXTextureGutterHelperVtbl_ ptr
end type

type ID3DXTextureGutterHelperVtbl
	QueryInterface as function(byval as ID3DXTextureGutterHelper ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXTextureGutterHelper ptr) as ULONG
	Release as function(byval as ID3DXTextureGutterHelper ptr) as ULONG
	GetWidth as function(byval as ID3DXTextureGutterHelper ptr) as UINT
	GetHeight as function(byval as ID3DXTextureGutterHelper ptr) as UINT
	ApplyGuttersFloat as function(byval as ID3DXTextureGutterHelper ptr, byval as FLOAT ptr, byval as UINT, byval as UINT, byval as UINT) as HRESULT
	ApplyGuttersTex as function(byval as ID3DXTextureGutterHelper ptr, byval as LPDIRECT3DTEXTURE9) as HRESULT
	ApplyGuttersPRT as function(byval as ID3DXTextureGutterHelper ptr, byval as LPD3DXPRTBUFFER) as HRESULT
	GetFaceMap as function(byval as ID3DXTextureGutterHelper ptr, byval as UINT ptr) as HRESULT
	GetBaryMap as function(byval as ID3DXTextureGutterHelper ptr, byval as D3DXVECTOR2 ptr) as HRESULT
	GetTexelMap as function(byval as ID3DXTextureGutterHelper ptr, byval as D3DXVECTOR2 ptr) as HRESULT
	GetGutterMap as function(byval as ID3DXTextureGutterHelper ptr, byval as UBYTE ptr) as HRESULT
	SetFaceMap as function(byval as ID3DXTextureGutterHelper ptr, byval as UINT ptr) as HRESULT
	SetBaryMap as function(byval as ID3DXTextureGutterHelper ptr, byval as D3DXVECTOR2 ptr) as HRESULT
	SetTexelMap as function(byval as ID3DXTextureGutterHelper ptr, byval as D3DXVECTOR2 ptr) as HRESULT
	SetGutterMap as function(byval as ID3DXTextureGutterHelper ptr, byval as UBYTE ptr) as HRESULT
end type

type LPD3DXPRTENGINE as ID3DXPRTEngine ptr

type ID3DXPRTEngineVtbl_ as ID3DXPRTEngineVtbl

type ID3DXPRTEngine
	lpVtbl as ID3DXPRTEngineVtbl_ ptr
end type

type ID3DXPRTEngineVtbl
	QueryInterface as function(byval as ID3DXPRTEngine ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXPRTEngine ptr) as ULONG
	Release as function(byval as ID3DXPRTEngine ptr) as ULONG
	SetMeshMaterials as function(byval as ID3DXPRTEngine ptr, byval as D3DXSHMATERIAL ptr ptr, byval as UINT, byval as UINT, byval as BOOL, byval as FLOAT) as HRESULT
	SetPerVertexAlbedo as function(byval as ID3DXPRTEngine ptr, byval as any ptr, byval as UINT, byval as UINT) as HRESULT
	SetPerTexelAlbedo as function(byval as ID3DXPRTEngine ptr, byval as LPDIRECT3DTEXTURE9, byval as UINT, byval as LPD3DXTEXTUREGUTTERHELPER) as HRESULT
	GetVertexAlbedo as function(byval as ID3DXPRTEngine ptr, byval as D3DXCOLOR ptr, byval as UINT) as HRESULT
	SetPerTexelNormal as function(byval as ID3DXPRTEngine ptr, byval as LPDIRECT3DTEXTURE9) as HRESULT
	ExtractPerVertexAlbedo as function(byval as ID3DXPRTEngine ptr, byval as LPD3DXMESH, byval as D3DDECLUSAGE, byval as UINT) as HRESULT
	ResampleBuffer as function(byval as ID3DXPRTEngine ptr, byval as LPD3DXPRTBUFFER, byval as LPD3DXPRTBUFFER) as HRESULT
	GetAdaptedMesh as function(byval as ID3DXPRTEngine ptr, byval as LPDIRECT3DDEVICE9, byval as UINT ptr, byval as UINT ptr, byval as FLOAT ptr, byval as LPD3DXMESH ptr) as HRESULT
	GetNumVerts as function(byval as ID3DXPRTEngine ptr) as UINT
	GetNumFaces as function(byval as ID3DXPRTEngine ptr) as UINT
	RobustMeshRefine as function(byval as ID3DXPRTEngine ptr, byval as FLOAT, byval as UINT) as HRESULT
	SetSamplingInfo as function(byval as ID3DXPRTEngine ptr, byval as UINT, byval as BOOL, byval as BOOL, byval as BOOL, byval as FLOAT) as HRESULT
	ComputeDirectLightingSH as function(byval as ID3DXPRTEngine ptr, byval as UINT, byval as LPD3DXPRTBUFFER) as HRESULT
	ComputeDirectLightingSHAdaptive as function(byval as ID3DXPRTEngine ptr, byval as UINT, byval as FLOAT, byval as FLOAT, byval as UINT, byval as LPD3DXPRTBUFFER) as HRESULT
	ComputeDirectLightingSHGPU as function(byval as ID3DXPRTEngine ptr, byval as LPDIRECT3DDEVICE9, byval as UINT, byval as UINT, byval as FLOAT, byval as FLOAT, byval as LPD3DXPRTBUFFER) as HRESULT
	ComputeSS as function(byval as ID3DXPRTEngine ptr, byval as LPD3DXPRTBUFFER, byval as LPD3DXPRTBUFFER, byval as LPD3DXPRTBUFFER) as HRESULT
	ComputeBounce as function(byval as ID3DXPRTEngine ptr, byval as LPD3DXPRTBUFFER, byval as LPD3DXPRTBUFFER, byval as LPD3DXPRTBUFFER) as HRESULT
	ComputeBounceAdaptive as function(byval as ID3DXPRTEngine ptr, byval as LPD3DXPRTBUFFER, byval as FLOAT, byval as FLOAT, byval as UINT, byval as LPD3DXPRTBUFFER, byval as LPD3DXPRTBUFFER) as HRESULT
	ComputeVolumeSamplesDirectSH as function(byval as ID3DXPRTEngine ptr, byval as UINT, byval as UINT, byval as UINT, byval as D3DXVECTOR3 ptr, byval as LPD3DXPRTBUFFER) as HRESULT
	ComputeVolumeSamples as function(byval as ID3DXPRTEngine ptr, byval as LPD3DXPRTBUFFER, byval as UINT, byval as UINT, byval as D3DXVECTOR3 ptr, byval as LPD3DXPRTBUFFER) as HRESULT
	FreeSSData as function(byval as ID3DXPRTEngine ptr) as HRESULT
	FreeBounceData as function(byval as ID3DXPRTEngine ptr) as HRESULT
	ComputeConvCoeffs as function(byval as ID3DXPRTEngine ptr, byval as LPD3DXPRTBUFFER, byval as UINT, byval as D3DXVECTOR3 ptr, byval as LPD3DXPRTBUFFER) as HRESULT
	ScaleMeshChunk as function(byval as ID3DXPRTEngine ptr, byval as UINT, byval as FLOAT, byval as LPD3DXPRTBUFFER) as HRESULT
	MultiplyAlbedo as function(byval as ID3DXPRTEngine ptr, byval as LPD3DXPRTBUFFER) as HRESULT
	SetCallBack as function(byval as ID3DXPRTEngine ptr, byval as LPD3DXSHPRTSIMCB, byval as FLOAT, byval as LPVOID) as HRESULT
end type

declare function D3DXCreatePRTBuffer alias "D3DXCreatePRTBuffer" (byval NumSamples as UINT, byval NumCoeffs as UINT, byval NumChannels as UINT, byval ppBuffer as LPD3DXPRTBUFFER ptr) as HRESULT
declare function D3DXCreatePRTBufferTex alias "D3DXCreatePRTBufferTex" (byval Width as UINT, byval Height as UINT, byval NumCoeffs as UINT, byval NumChannels as UINT, byval ppBuffer as LPD3DXPRTBUFFER ptr) as HRESULT
declare function D3DXLoadPRTBufferFromFileA alias "D3DXLoadPRTBufferFromFileA" (byval pFilename as LPCSTR, byval ppBuffer as LPD3DXPRTBUFFER ptr) as HRESULT
declare function D3DXLoadPRTBufferFromFileW alias "D3DXLoadPRTBufferFromFileW" (byval pFilename as LPCWSTR, byval ppBuffer as LPD3DXPRTBUFFER ptr) as HRESULT
declare function D3DXSavePRTBufferToFileA alias "D3DXSavePRTBufferToFileA" (byval pFileName as LPCSTR, byval pBuffer as LPD3DXPRTBUFFER) as HRESULT
declare function D3DXSavePRTBufferToFileW alias "D3DXSavePRTBufferToFileW" (byval pFileName as LPCWSTR, byval pBuffer as LPD3DXPRTBUFFER) as HRESULT
declare function D3DXLoadPRTCompBufferFromFileA alias "D3DXLoadPRTCompBufferFromFileA" (byval pFilename as LPCSTR, byval ppBuffer as LPD3DXPRTCOMPBUFFER ptr) as HRESULT
declare function D3DXLoadPRTCompBufferFromFileW alias "D3DXLoadPRTCompBufferFromFileW" (byval pFilename as LPCWSTR, byval ppBuffer as LPD3DXPRTCOMPBUFFER ptr) as HRESULT
declare function D3DXSavePRTCompBufferToFileA alias "D3DXSavePRTCompBufferToFileA" (byval pFileName as LPCSTR, byval pBuffer as LPD3DXPRTCOMPBUFFER) as HRESULT
declare function D3DXSavePRTCompBufferToFileW alias "D3DXSavePRTCompBufferToFileW" (byval pFileName as LPCWSTR, byval pBuffer as LPD3DXPRTCOMPBUFFER) as HRESULT
declare function D3DXCreatePRTCompBuffer alias "D3DXCreatePRTCompBuffer" (byval Quality as D3DXSHCOMPRESSQUALITYTYPE, byval NumClusters as UINT, byval NumPCA as UINT, byval pBufferIn as LPD3DXPRTBUFFER, byval ppBufferOut as LPD3DXPRTCOMPBUFFER ptr) as HRESULT
declare function D3DXCreateTextureGutterHelper alias "D3DXCreateTextureGutterHelper" (byval Width as UINT, byval Height as UINT, byval pMesh as LPD3DXMESH, byval GutterSize as FLOAT, byval ppBuffer as LPD3DXTEXTUREGUTTERHELPER ptr) as HRESULT
declare function D3DXCreatePRTEngine alias "D3DXCreatePRTEngine" (byval pMesh as LPD3DXMESH, byval ExtractUVs as BOOL, byval pBlockerMesh as LPD3DXMESH, byval ppEngine as LPD3DXPRTENGINE ptr) as HRESULT
declare function D3DXConcatenateMeshes alias "D3DXConcatenateMeshes" (byval ppMeshes as LPD3DXMESH ptr, byval NumMeshes as UINT, byval Options as DWORD, byval pGeomXForms as D3DXMATRIX ptr, byval pTextureXForms as D3DXMATRIX ptr, byval pDecl as D3DVERTEXELEMENT9 ptr, byval pD3DDevice as LPDIRECT3DDEVICE9, byval ppMeshOut as LPD3DXMESH ptr) as HRESULT
declare function D3DXSHPRTCompSuperCluster alias "D3DXSHPRTCompSuperCluster" (byval pClusterIDs as UINT ptr, byval pScene as LPD3DXMESH, byval MaxNumClusters as UINT, byval NumClusters as UINT, byval pSuperClusterIDs as UINT ptr, byval pNumSuperClusters as UINT ptr) as HRESULT
declare function D3DXSHPRTCompSplitMeshSC alias "D3DXSHPRTCompSplitMeshSC" (byval pClusterIDs as UINT ptr, byval NumVertices as UINT, byval NumClusters as UINT, byval pSuperClusterIDs as UINT ptr, byval NumSuperClusters as UINT, byval pInputIB as LPVOID, byval InputIBIs32Bit as BOOL, byval NumFaces as UINT, byval ppIBData as LPD3DXBUFFER ptr, byval pIBDataLength as UINT ptr, byval OutputIBIs32Bit as BOOL, byval ppFaceRemap as LPD3DXBUFFER ptr, byval ppVertData as LPD3DXBUFFER ptr, byval pVertDataLength as UINT ptr, byval pSCClusterList as UINT ptr, byval pSCData as D3DXSHPRTSPLITMESHCLUSTERDATA ptr) as HRESULT

extern DXFILEOBJ_XSkinMeshHeader alias "DXFILEOBJ_XSkinMeshHeader" as GUID
extern DXFILEOBJ_VertexDuplicationIndices alias "DXFILEOBJ_VertexDuplicationIndices" as GUID
extern DXFILEOBJ_FaceAdjacency alias "DXFILEOBJ_FaceAdjacency" as GUID
extern DXFILEOBJ_SkinWeights alias "DXFILEOBJ_SkinWeights" as GUID
extern DXFILEOBJ_Patch alias "DXFILEOBJ_Patch" as GUID
extern DXFILEOBJ_PatchMesh alias "DXFILEOBJ_PatchMesh" as GUID
extern DXFILEOBJ_PatchMesh9 alias "DXFILEOBJ_PatchMesh9" as GUID
extern DXFILEOBJ_PMInfo alias "DXFILEOBJ_PMInfo" as GUID
extern DXFILEOBJ_PMAttributeRange alias "DXFILEOBJ_PMAttributeRange" as GUID
extern DXFILEOBJ_PMVSplitRecord alias "DXFILEOBJ_PMVSplitRecord" as GUID
extern DXFILEOBJ_FVFData alias "DXFILEOBJ_FVFData" as GUID
extern DXFILEOBJ_VertexElement alias "DXFILEOBJ_VertexElement" as GUID
extern DXFILEOBJ_DeclData alias "DXFILEOBJ_DeclData" as GUID
extern DXFILEOBJ_EffectFloats alias "DXFILEOBJ_EffectFloats" as GUID
extern DXFILEOBJ_EffectString alias "DXFILEOBJ_EffectString" as GUID
extern DXFILEOBJ_EffectDWord alias "DXFILEOBJ_EffectDWord" as GUID
extern DXFILEOBJ_EffectParamFloats alias "DXFILEOBJ_EffectParamFloats" as GUID
extern DXFILEOBJ_EffectParamString alias "DXFILEOBJ_EffectParamString" as GUID
extern DXFILEOBJ_EffectParamDWord alias "DXFILEOBJ_EffectParamDWord" as GUID
extern DXFILEOBJ_EffectInstance alias "DXFILEOBJ_EffectInstance" as GUID
extern DXFILEOBJ_AnimTicksPerSecond alias "DXFILEOBJ_AnimTicksPerSecond" as GUID
extern DXFILEOBJ_CompressedAnimationSet alias "DXFILEOBJ_CompressedAnimationSet" as GUID

type XFILECOMPRESSEDANIMATIONSET
	CompressedBlockSize as DWORD
	TicksPerSec as FLOAT
	PlaybackType as DWORD
	BufferLength as DWORD
end type

#endif
