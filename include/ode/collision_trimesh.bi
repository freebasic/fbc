/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://fsr.sf.net/forum     *
 *                                                                       *
 * This library is free software; you can redistribute it and/or         *
 * modify it under the terms of EITHER:                                  *
 *   (1) The GNU Lesser General Public License as published by the Free  *
 *       Software Foundation; either version 2.1 of the License, or (at  *
 *       your option) any later version. The text of the GNU Lesser      *
 *       General Public License is included with this library in the     *
 *       file LICENSE.TXT.                                               *
 *   (2) The BSD-style license that is included with this library in     *
 *       the file LICENSE-BSD.TXT.                                       *
 *                                                                       *
 * This library is distributed in the hope that it will be useful,       *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the files    *
 * LICENSE.TXT and LICENSE-BSD.TXT for more details.                     *
 *                                                                       *
 ************************************************************************'/
#ifndef __ode_collision_trimesh_bi__
#define __ode_collision_trimesh_bi__

enum 
 TRIMESH_FACE_NORMALS
 TRIMESH_LAST_TRANSFORMATION
end enum
type dTriMeshDataID    as dxTriMeshData ptr

type dTriCallback as function cdecl ( _
  TriMesh       as dGeomID, _
  RefObject     as dGeomID, _
  TriangleIndex as integer) as integer

type dTriArrayCallback as sub cdecl ( _
  TriMesh    as dGeomID, _
  RefObject  as dGeomID, _
  TriIndices as integer ptr, _
  TriCount   as integer)

type dTriRayCallback as function cdecl ( _
  TriMesh       as dGeomID , _
  Ray           as dGeomID , _
  TriangleIndex as integer, _
  u             as dReal, _
  v             as dReal) as integer

extern "C"

declare function dGeomTriMeshDataCreate       () as dTriMeshDataID
declare sub      dGeomTriMeshDataDestroy      (byval g as dTriMeshDataID)
declare sub      dGeomTriMeshDataSet          (byval g as dTriMeshDataID, byval data_id as integer, byval data as any ptr)
declare sub      dGeomTriMeshDataBuildSingle  (byval g as dTriMeshDataID, byval Vertices as any ptr, byval VertexStride as integer, byval VertexCount as integer, byval Indices as any ptr, byval IndexCount as integer, byval TriStride as integer)
declare sub      dGeomTriMeshDataBuildSingle1 (byval g as dTriMeshDataID, byval Vertices as any ptr, byval VertexStride as integer, byval VertexCount as integer, byval Indices as any ptr, byval IndexCount as integer, byval TriStride as integer, byval Normals as any ptr)
declare sub      dGeomTriMeshDataBuildDouble  (byval g as dTriMeshDataID, byval Vertices as any ptr, byval VertexStride as integer, byval VertexCount as integer, byval Indices as any ptr, byval IndexCount as integer, byval TriStride as integer)
declare sub      dGeomTriMeshDataBuildDouble1 (byval g as dTriMeshDataID, byval Vertices as any ptr, byval VertexStride as integer, byval VertexCount as integer, byval Indices as any ptr, byval IndexCount as integer, byval TriStride as integer, byval Normals as any ptr)
declare sub      dGeomTriMeshDataBuildSimple  (byval g as dTriMeshDataID, byval Vertices as dReal ptr, byval VertexCount as integer, byval Indices as integer ptr, byval IndexCount as integer)
declare sub      dGeomTriMeshDataBuildSimple1 (byval g as dTriMeshDataID, byval Vertices as dReal ptr, byval VertexCount as integer, byval Indices as integer ptr, byval IndexCount as integer, byval Normals as integer ptr)

declare sub      dGeomTriMeshSetCallback      (byval g as dGeomID, Callback as dTriCallback ptr)
declare function dGeomTriMeshGetCallback      (byval g as dGeomID) as dTriCallback ptr

declare sub      dGeomTriMeshSetArrayCallback (byval g as dGeomID, byval ArrayCallback as dTriArrayCallback ptr)
declare function dGeomTriMeshGetArrayCallback (byval g as dGeomID) as dTriArrayCallback ptr

declare sub      dGeomTriMeshSetRayCallback   (byval g as dGeomID, byval Callback as dTriRayCallback ptr)
declare function dGeomTriMeshGetRayCallback   (byval g as dGeomID) as dTriRayCallback ptr
declare function dCreateTriMesh               (byval s as dSpaceID, byval Data as dTriMeshDataID, byval Callback as dTriCallback ptr, byval ArrayCallback as dTriArrayCallback ptr, byval RayCallback as dTriRayCallback ptr) as dGeomID
declare sub      dGeomTriMeshSetData          (byval g as dGeomID, byval Data as dTriMeshDataID)
declare sub      dGeomTriMeshEnableTC         (byval g as dGeomID, byval geomClass as integer, byval enable as integer)
declare function dGeomTriMeshIsTCEnabled      (byval g as dGeomID, byval geomClass as integer) as integer
declare sub      dGeomTriMeshClearTCCache     (byval g as dGeomID)
declare function dGeomTriMeshGetTriMeshDataID (byval g as dGeomID) as dTriMeshDataID
declare sub      dGeomTriMeshGetTriangle      (byval g as dGeomID, byval Index as integer, byval v0 as dVector3 ptr, byval v1 as dVector3 ptr, byval v2 as dVector3 ptr)
declare sub      dGeomTriMeshGetPoint         (byval g as dGeomID, byval Index as integer, byval u as dReal, byval v as dReal, byval Out as dVector3)

end extern

#endif ' __ode_collision_trimesh_bi__
