''
''
'' collision_trimesh -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ode_collision_trimesh_bi__
#define __ode_collision_trimesh_bi__

type dTriMeshDataID as dxTriMeshData ptr

declare function dGeomTriMeshDataCreate cdecl alias "dGeomTriMeshDataCreate" () as dTriMeshDataID
declare sub dGeomTriMeshDataDestroy cdecl alias "dGeomTriMeshDataDestroy" (byval g as dTriMeshDataID)

enum 
	TRIMESH_FACE_NORMALS
	TRIMESH_LAST_TRANSFORMATION
end enum

declare sub dGeomTriMeshDataSet cdecl alias "dGeomTriMeshDataSet" (byval g as dTriMeshDataID, byval data_id as integer, byval data as any ptr)
declare sub dGeomTriMeshDataBuildSingle cdecl alias "dGeomTriMeshDataBuildSingle" (byval g as dTriMeshDataID, byval Vertices as any ptr, byval VertexStride as integer, byval VertexCount as integer, byval Indices as any ptr, byval IndexCount as integer, byval TriStride as integer)
declare sub dGeomTriMeshDataBuildSingle1 cdecl alias "dGeomTriMeshDataBuildSingle1" (byval g as dTriMeshDataID, byval Vertices as any ptr, byval VertexStride as integer, byval VertexCount as integer, byval Indices as any ptr, byval IndexCount as integer, byval TriStride as integer, byval Normals as any ptr)
declare sub dGeomTriMeshDataBuildDouble cdecl alias "dGeomTriMeshDataBuildDouble" (byval g as dTriMeshDataID, byval Vertices as any ptr, byval VertexStride as integer, byval VertexCount as integer, byval Indices as any ptr, byval IndexCount as integer, byval TriStride as integer)
declare sub dGeomTriMeshDataBuildDouble1 cdecl alias "dGeomTriMeshDataBuildDouble1" (byval g as dTriMeshDataID, byval Vertices as any ptr, byval VertexStride as integer, byval VertexCount as integer, byval Indices as any ptr, byval IndexCount as integer, byval TriStride as integer, byval Normals as any ptr)
declare sub dGeomTriMeshDataBuildSimple cdecl alias "dGeomTriMeshDataBuildSimple" (byval g as dTriMeshDataID, byval Vertices as dReal ptr, byval VertexCount as integer, byval Indices as integer ptr, byval IndexCount as integer)
declare sub dGeomTriMeshDataBuildSimple1 cdecl alias "dGeomTriMeshDataBuildSimple1" (byval g as dTriMeshDataID, byval Vertices as dReal ptr, byval VertexCount as integer, byval Indices as integer ptr, byval IndexCount as integer, byval Normals as integer ptr)

type dTriCallback as integer

declare sub dGeomTriMeshSetCallback cdecl alias "dGeomTriMeshSetCallback" (byval g as dGeomID, byval Callback as dTriCallback ptr)
declare function dGeomTriMeshGetCallback cdecl alias "dGeomTriMeshGetCallback" (byval g as dGeomID) as dTriCallback ptr

type dTriArrayCallback as any

declare sub dGeomTriMeshSetArrayCallback cdecl alias "dGeomTriMeshSetArrayCallback" (byval g as dGeomID, byval ArrayCallback as dTriArrayCallback ptr)
declare function dGeomTriMeshGetArrayCallback cdecl alias "dGeomTriMeshGetArrayCallback" (byval g as dGeomID) as dTriArrayCallback ptr

type dTriRayCallback as integer

declare sub dGeomTriMeshSetRayCallback cdecl alias "dGeomTriMeshSetRayCallback" (byval g as dGeomID, byval Callback as dTriRayCallback ptr)
declare function dGeomTriMeshGetRayCallback cdecl alias "dGeomTriMeshGetRayCallback" (byval g as dGeomID) as dTriRayCallback ptr
declare function dCreateTriMesh cdecl alias "dCreateTriMesh" (byval space as dSpaceID, byval Data as dTriMeshDataID, byval Callback as dTriCallback ptr, byval ArrayCallback as dTriArrayCallback ptr, byval RayCallback as dTriRayCallback ptr) as dGeomID
declare sub dGeomTriMeshSetData cdecl alias "dGeomTriMeshSetData" (byval g as dGeomID, byval Data as dTriMeshDataID)
declare sub dGeomTriMeshEnableTC cdecl alias "dGeomTriMeshEnableTC" (byval g as dGeomID, byval geomClass as integer, byval enable as integer)
declare function dGeomTriMeshIsTCEnabled cdecl alias "dGeomTriMeshIsTCEnabled" (byval g as dGeomID, byval geomClass as integer) as integer
declare sub dGeomTriMeshClearTCCache cdecl alias "dGeomTriMeshClearTCCache" (byval g as dGeomID)
declare function dGeomTriMeshGetTriMeshDataID cdecl alias "dGeomTriMeshGetTriMeshDataID" (byval g as dGeomID) as dTriMeshDataID
declare sub dGeomTriMeshGetTriangle cdecl alias "dGeomTriMeshGetTriangle" (byval g as dGeomID, byval Index as integer, byval v0 as dVector3 ptr, byval v1 as dVector3 ptr, byval v2 as dVector3 ptr)
declare sub dGeomTriMeshGetPoint cdecl alias "dGeomTriMeshGetPoint" (byval g as dGeomID, byval Index as integer, byval u as dReal, byval v as dReal, byval Out as dVector3)

#endif
