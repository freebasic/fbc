/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy)                             *
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
#ifndef __ode_collision_bi__
#define __ode_collision_bi__

#include "common.bi"
#include "collision_space.bi"
#include "collision_trimesh.bi"
#include "contact.bi"

declare sub      dGeomDestroy         cdecl alias "dGeomDestroy"         (g as dGeomID)

declare sub      dGeomSetData         cdecl alias "dGeomSetData"         (g as dGeomID,byval as any ptr)
declare function dGeomGetData         cdecl alias "dGeomGetData"         (g as dGeomID) as any ptr

declare sub      dGeomSetBody         cdecl alias "dGeomSetBody"         (g as dGeomID,byval as dBodyID)
declare function dGeomGetBody         cdecl alias "dGeomGetBody"         (g as dGeomID) as dBodyID

declare sub      dGeomSetPosition     cdecl alias "dGeomSetPosition"     (g as dGeomID,  x as dReal,  y as dReal,  z as dReal)
declare function dGeomGetPosition     cdecl alias "dGeomGetPosition"     (g as dGeomID) as dReal ptr
declare sub      dGeomCopyPosition    cdecl alias "dGeomCopyPosition"    (g as dGeomID,byref pos as dVector3)

declare sub      dGeomSetRotation     cdecl alias "dGeomSetRotation"     (g as dGeomID, R as dMatrix3)
declare function dGeomGetRotation     cdecl alias "dGeomGetRotation"     (g as dGeomID) as dReal ptr
declare sub      dGeomCopyRotation    cdecl alias "dGeomCopyRotation"    (g as dGeomID,byref r as dMatrix3)

declare sub      dGeomSetQuaternion   cdecl alias "dGeomSetQuaternion"   (g as dGeomID, byval q as dQuaternion)
declare sub      dGeomGetQuaternion   cdecl alias "dGeomGetQuaternion"   (g as dGeomID, byref result as dQuaternion)

declare sub      dGeomGetAABB         cdecl alias "dGeomGetAABB"         (g as dGeomID,  aabb as dReal ptr)
declare function dGeomIsSpace         cdecl alias "dGeomIsSpace"         (g as dGeomID) as integer
declare function dGeomGetSpace        cdecl alias "dGeomGetSpace"        (g as dGeomID) as dSpaceID
declare function dGeomGetClass        cdecl alias "dGeomGetClass"        (g as dGeomID) as integer

declare sub      dGeomSetCategoryBits cdecl alias "dGeomSetCategoryBits" (g as dGeomID, bits as uinteger)
declare function dGeomGetCategoryBits cdecl alias "dGeomGetCategoryBits" (g as dGeomID) as uinteger

declare sub      dGeomSetCollideBits  cdecl alias "dGeomSetCollideBits"  (g as dGeomID,  bits as uinteger)
declare function dGeomGetCollideBits  cdecl alias "dGeomGetCollideBits"  (g as dGeomID) as uinteger

declare sub      dGeomEnable          cdecl alias "dGeomEnable"          (g as dGeomID)
declare sub      dGeomDisable         cdecl alias "dGeomDisable"         (g as dGeomID)
declare function dGeomIsEnabled       cdecl alias "dGeomIsEnabled"       (g as dGeomID) as integer

declare sub      dGeomSetOffsetPosition cdecl alias "dGeomSetOffsetPosition" (g as dGeomID,x as dReal,y as dReal,z as dReal)
declare function dGeomGetOffsetPosition cdecl alias "dGeomGetOffsetPosition" (g as dGeomID) as dReal ptr
declare sub      dGeomCopyOffsetPosition cdecl alias "dGeomCopyOffsetPosition" (g as dGeomID,byref pos as dVector3)

declare sub      dGeomSetOffsetRotation cdecl alias "dGeomSetOffsetRotation" (g as dGeomID,byval r as dMatrix3)
declare function dGeomGetOffsetRotation cdecl alias "dGeomGetOffsetRotation" ( g as dGeomID) as dReal ptr
declare sub      dGeomCopyOffsetRotation cdecl alias "dGeomCopyOffsetRotation" (g as dGeomID, byref result as dMatrix3)

declare sub      dGeomSetOffsetQuaternion cdecl alias "dGeomSetOffsetQuaternion" (g as dGeomID,byval q as dQuaternion)
declare sub      dGeomGetOffsetQuaternion cdecl alias "dGeomGetOffsetQuaternion" ( g as dGeomID,byref result as dQuaternion)

declare sub      dGeomSetOffsetWorldPosition cdecl alias "dGeomSetOffsetWorldPosition" (g as dGeomID,x as dReal,y as dReal,z as dReal)
declare sub      dGeomSetOffsetWorldRotation cdecl alias "dGeomSetOffsetWorldRotation" (g as dGeomID,byval r as dMatrix3)
declare sub      dGeomSetOffsetWorldQuaternion cdecl alias "dGeomSetOffsetWorldQuaternion" (g as dGeomID,byval q as dQuaternion)

declare sub      dGeomClearOffset cdecl alias "dGeomClearOffset" (g as dGeomID)
declare function dGeomIsOffset cdecl alias "dGeomIsOffset" (g as dGeomID) as integer
#define CONTACTS_UNIMPORTANT &H80000000

declare function dCollide             cdecl alias "dCollide"       ( o1 as dGeomID,  o2 as dGeomID,  flags as integer,  contact as dContactGeom ptr, skip as integer) as integer
declare sub      dSpaceCollide        cdecl alias "dSpaceCollide"  ( s  as dSpaceID,  data as any ptr,  callback as dNearCallback ptr)
declare sub      dSpaceCollide2       cdecl alias "dSpaceCollide2" ( o1 as dGeomID,  o2 as dGeomID,  data as any ptr,  callback as dNearCallback ptr)

' standard classes
' the maximum number of user classes that are supported 
enum 
  dMaxUserClasses = 4
end enum

enum dClasses
  dSphereClass = 0
  dBoxClass
  dCapsuleClass
  dCylinderClass
  dPlaneClass
  dRayClass
  dConvexClass
  dGeomTransformClass
  dTriMeshClass
  dHeightfieldClass

  dFirstSpaceClass
  dSimpleSpaceClass = dFirstSpaceClass
  dHashSpaceClass
  dSweepAndPruneSpaceClass ' SAP
  dQuadTreeSpaceClass
  dLastSpaceClass = dQuadTreeSpaceClass

  dFirstUserClass
  dLastUserClass = dFirstUserClass + dMaxUserClasses - 1
  dGeomNumClasses
end enum

declare function dCreateSphere             cdecl alias "dCreateSphere"         ( space  as dSpaceID,  radius as dReal) as dGeomID
declare sub      dGeomSphereSetRadius      cdecl alias "dGeomSphereSetRadius"  ( sphere as dGeomID,  radius as dReal)
declare function dGeomSphereGetRadius      cdecl alias "dGeomSphereGetRadius"  ( sphere as dGeomID) as dReal
declare function dGeomSpherePointDepth     cdecl alias "dGeomSpherePointDepth" (sphere as dGeomID,  x as dReal,  y as dReal,  z as dReal) as dReal

declare function dCreateConvex             cdecl alias "dCreateConvex"         (space as dSpaceID,  _planes as dReal ptr,  _planecount as integer,  _points as dReal ptr,  _pointcount as integer,  _polygons as integer ptr ) as dGeomID
declare sub      dGeomSetConvex            cdecl alias "dGeomSetConvex"        (g as dGeomID     ,  _planes as dReal ptr,  _count as integer,  _points as dReal ptr,  _pointcount as integer,  _polygons as integer ptr)

declare function dCreateBox                cdecl alias "dCreateBox"            (space as dSpaceID,  lx as dReal,  ly as dReal,  lz as dReal) as dGeomID
declare sub      dGeomBoxSetLengths        cdecl alias "dGeomBoxSetLengths"    (box   as dGeomID ,  lx as dReal,  ly as dReal,  lz as dReal)
declare sub      dGeomBoxGetLengths        cdecl alias "dGeomBoxGetLengths"    (box   as dGeomID ,  result as dVector3 ptr)
declare function dGeomBoxPointDepth        cdecl alias "dGeomBoxPointDepth"    (box   as dGeomID ,  x as dReal,  y as dReal,  z as dReal) as dReal

declare function dCreatePlane              cdecl alias "dCreatePlane"          (space as dSpaceID,  a as dReal,  b as dReal,  c as dReal,  d as dReal) as dGeomID
declare sub      dGeomPlaneSetParams       cdecl alias "dGeomPlaneSetParams"   (plane as dGeomID ,  a as dReal,  b as dReal,  c as dReal,  d as dReal)
declare sub      dGeomPlaneGetParams       cdecl alias "dGeomPlaneGetParams"   (plane as dGeomID ,  result as dVector4)
declare function dGeomPlanePointDepth      cdecl alias "dGeomPlanePointDepth"  (plane as dGeomID ,  x as dReal,  y as dReal,  z as dReal) as dReal

declare function dCreateCapsule            cdecl alias "dCreateCapsule"        (space     as dSpaceID,  radius as dReal    ,  length as dReal) as dGeomID
declare sub      dGeomCapsuleSetParams     cdecl alias "dGeomCapsuleSetParams" (ccylinder as dGeomID ,  radius as dReal    ,  length as dReal)
declare sub      dGeomCapsuleGetParams     cdecl alias "dGeomCapsuleGetParams" (ccylinder as dGeomID ,  radius as dReal ptr,  length as dReal ptr)
declare function dGeomCapsulePointDepth    cdecl alias "dGeomCapsulePointDepth"(ccylinder as dGeomID ,  x as dReal         ,  y as dReal,  z as dReal) as dReal

' For now we want to have a backwards compatible C-API, note: C++ API is not.
#define dCreateCCylinder dCreateCapsule
#define dGeomCCylinderSetParams dGeomCapsuleSetParams
#define dGeomCCylinderGetParams dGeomCapsuleGetParams
#define dGeomCCylinderPointDepth dGeomCapsulePointDepth
#define dCCylinderClass dCapsuleClass

declare function dCreateCylinder           cdecl alias "dCreateCylinder"        (space    as dSpaceID,  radius as dReal    ,  length as dReal) as dGeomID
declare sub      dGeomCylinderSetParams    cdecl alias "dGeomCylinderSetParams" (cylinder as dGeomID ,  radius as dReal    ,  length as dReal)
declare sub      dGeomCylinderGetParams    cdecl alias "dGeomCylinderGetParams" (cylinder as dGeomID ,  radius as dReal ptr,  length as dReal ptr)

/'
declare function dCreateCCylinder          cdecl alias "dCreateCCylinder"         (space     as dSpaceID,  radius as dReal    ,  length as dReal) as dGeomID
declare sub      dGeomCCylinderSetParams   cdecl alias "dGeomCCylinderSetParams"  (ccylinder as dGeomID ,  radius as dReal    ,  length as dReal)
declare sub      dGeomCCylinderGetParams   cdecl alias "dGeomCCylinderGetParams"  (ccylinder as dGeomID ,  radius as dReal ptr,  length as dReal ptr)
declare function dGeomCCylinderPointDepth  cdecl alias "dGeomCCylinderPointDepth" (ccylinder as dGeomID ,  x as dReal,  y as dReal,  z as dReal) as dReal
'/

declare function dCreateRay                cdecl alias "dCreateRay"            (space as dSpaceID, length       as dReal) as dGeomID
declare sub      dGeomRaySetLength         cdecl alias "dGeomRaySetLength"     (ray   as dGeomID,  length       as dReal)
declare function dGeomRayGetLength         cdecl alias "dGeomRayGetLength"     (ray   as dGeomID) as dReal
declare sub      dGeomRaySet               cdecl alias "dGeomRaySet"           (ray   as dGeomID,  px as dReal ,  py as dReal,  pz as dReal,  dx as dReal,  dy as dReal,  dz as dReal)
declare sub      dGeomRayGet               cdecl alias "dGeomRayGet"           (ray   as dGeomID, byref start    as dVector3   ,byref dir as dVector3)
declare sub      dGeomRaySetParams         cdecl alias "dGeomRaySetParams"     (g     as dGeomID,  FirstContact as integer    ,  BackfaceCull as integer)
declare sub      dGeomRayGetParams         cdecl alias "dGeomRayGetParams"     (g     as dGeomID,  FirstContact as integer ptr,  BackfaceCull as integer ptr)
declare sub      dGeomRaySetClosestHit     cdecl alias "dGeomRaySetClosestHit" (g     as dGeomID,  closestHit   as integer)
declare function dGeomRayGetClosestHit     cdecl alias "dGeomRayGetClosestHit" (g     as dGeomID) as integer

#include "collision_trimesh.bi"

declare function dCreateGeomTransform      cdecl alias "dCreateGeomTransform" ( space as dSpaceID) as dGeomID
declare sub      dGeomTransformSetGeom     cdecl alias "dGeomTransformSetGeom" ( g as dGeomID,  obj as dGeomID)
declare function dGeomTransformGetGeom     cdecl alias "dGeomTransformGetGeom" ( g as dGeomID) as dGeomID
declare sub      dGeomTransformSetCleanup  cdecl alias "dGeomTransformSetCleanup" ( g as dGeomID,  mode as integer)
declare function dGeomTransformGetCleanup  cdecl alias "dGeomTransformGetCleanup" ( g as dGeomID) as integer
declare sub      dGeomTransformSetInfo     cdecl alias "dGeomTransformSetInfo" ( g as dGeomID,  mode as integer)
declare function dGeomTransformGetInfo     cdecl alias "dGeomTransformGetInfo" ( g as dGeomID) as integer

type dHeightfieldGetHeight_t as function cdecl (byval p_user_data as any ptr,byval x as integer, byval z as integer) as dReal

declare function dCreateHeightfield cdecl alias "dCreateHeightfield" (byval space as dSpaceID,byval id as dHeightfieldDataID,byval bPlaceable as integer) as dGeomID
declare function dGeomHeightfieldDataCreate cdecl alias "dGeomHeightfieldDataCreate" () as dHeightfieldDataID
declare sub      dGeomHeightfieldDataDestroy cdecl alias "dGeomHeightfieldDataDestroy" (d as dHeightfieldDataID)
declare sub      dGeomHeightfieldDataBuildCallback  cdecl alias "dGeomHeightfieldDataBuildCallback" (byval d as dHeightfieldDataID, byval pUserData as any ptr, byval pCallback as any ptr, byval w as dReal,depth as dReal,widthSamples as integer,byval depthSamples as integer, byval scale as dReal,offset as dReal,thickness as dReal,bWrap as integer)
declare sub      dGeomHeightfieldDataBuildByte      cdecl alias "dGeomHeightfieldDataBuildByte" (d as dHeightfieldDataID,pHeightData as byte ptr,bCopyHeightData as integer,width as dReal,depth as dReal,widthSamples as integer,depthSamples as integer,scale as dReal,offset as dReal,thickness as dReal,bWrap as integer)
declare sub      dGeomHeightfieldDataBuildShort     cdecl alias "dGeomHeightfieldDataBuildShort" (d as dHeightfieldDataID,pHeightData as short ptr,bCopyHeightData as integer,width as dReal,depth as dReal,widthSamples as integer,depthSamples as integer,scale as dReal,offset as dReal,thickness as dReal,bWrap as integer)
declare sub      dGeomHeightfieldDataBuildSingle    cdecl alias "dGeomHeightfieldDataBuildSingle" (d as dHeightfieldDataID,pHeightData as single ptr,bCopyHeightData as integer,width as dReal,depth as dReal,widthSamples as integer,depthSamples as integer,scale as dReal,offset as dReal,thickness as dReal,bWrap as integer)
declare sub      dGeomHeightfieldDataBuildDouble    cdecl alias "dGeomHeightfieldDataBuildDouble" (d as dHeightfieldDataID, pHeightData as double ptr,bCopyHeightData as integer, width as dReal, depth as dReal,widthSamples as integer,depthSamples as integer, scale as dReal, offset as dReal,thickness as dReal,bWrap as integer)
declare sub      dGeomHeightfieldDataSetBounds      cdecl alias "dGeomHeightfieldDataSetBounds" (d as dHeightfieldDataID,minHeight as dReal, maxHeight as dReal)
declare sub      dGeomHeightfieldSetHeightfieldData cdecl alias "dGeomHeightfieldSetHeightfieldData" (g as dGeomID,d as dHeightfieldDataID)
declare function dGeomHeightfieldGetHeightfieldData cdecl alias "dGeomHeightfieldGetHeightfieldData" (g as dGeomID) as dHeightfieldDataID



declare sub      dClosestLineSegmentPoints cdecl alias "dClosestLineSegmentPoints" ( a1 as dVector3,  a2 as dVector3,  b1 as dVector3,  b2 as dVector3,  cp1 as dVector3,  cp2 as dVector3)
declare function dBoxTouchesBox            cdecl alias "dBoxTouchesBox" ( _p1 as dVector3,  R1 as dMatrix3,  side1 as dVector3,  _p2 as dVector3,  R2 as dMatrix3,  side2 as dVector3) as integer
declare sub      dInfiniteAABB             cdecl alias "dInfiniteAABB" ( geom as dGeomID,  aabb() as dReal)

/'
typedef void dGetAABBFn (dGeomID, dReal aabb[6]);
typedef int dColliderFn (dGeomID o1, dGeomID o2,
			 int flags, dContactGeom *contact, int skip);
typedef dColliderFn * dGetColliderFnFn (int num);
typedef void dGeomDtorFn (dGeomID o);
typedef int dAABBTestFn (dGeomID o1, dGeomID o2, dReal aabb[6]);
'/

type dGetAABBFn       as sub      cdecl (byval o1 as dGeomID, aabb() as dReal)
type dColliderFn      as function cdecl (byval o1 as dGeomID,byval o2 as dGeomID, byval flags as integer, byval contact as dContactGeom ptr,byval skip as integer) as integer
type dGetColliderFnFn as function cdecl (byval num as integer) as dColliderFn ptr
type dGeomDtorFn      as sub      cdecl (byval o as dGeomID)
type dAABBTestFn      as function cdecl (byval o1 as dGeomID,byval o2 as dGeomID,aabb() as dReal) as integer

type dGeomClass
  bytes     as integer
  collider  as dGetColliderFnFn ptr
  aabb      as dGetAABBFn ptr
  aabb_test as dAABBTestFn ptr
  dtor      as dGeomDtorFn ptr
end type

declare function dCreateGeomClass  cdecl alias "dCreateGeomClass"  ( classptr as dGeomClass ptr) as integer
declare function dGeomGetClassData cdecl alias "dGeomGetClassData" ( geo      as dGeomID) as any ptr
declare function dCreateGeom       cdecl alias "dCreateGeom"       ( classnum as integer) as dGeomID

declare sub      dSetColliderOverride (i as integer,j as integer, fn as dColliderFn ptr)

#endif ' __ode_collision_bi__
