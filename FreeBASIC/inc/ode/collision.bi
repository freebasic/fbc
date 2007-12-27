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
#ifndef __ode_collision_bi__
#define __ode_collision_bi__

#include "common.bi"
#include "collision_space.bi"
#include "collision_trimesh.bi"
#include "contact.bi"

' general functions

/'*
 * @brief Destroy a geom, removing it from any space.
 *
 * Destroy a geom, removing it from any space it is in first. This one
 * function destroys a geom of any type, but to create a geom you must call
 * a creation function for that type.
 *
 * When a space is destroyed, if its cleanup mode is 1 (the default) then all
 * the geoms in that space are automatically destroyed as well.
 *
 * @param geom the geom to be destroyed.
 * @ingroup collide
 '/
declare sub      dGeomDestroy         cdecl alias "dGeomDestroy"         (g as dGeomID)
/'*
 * @brief Set the user-defined data pointer stored in the geom.
 *
 * @param geom the geom to hold the data
 * @param data the data pointer to be stored
 * @ingroup collide
 '/
declare sub      dGeomSetData         cdecl alias "dGeomSetData"         (g as dGeomID,  as any ptr)
/'*
 * @brief Get the user-defined data pointer stored in the geom.
 *
 * @param geom the geom containing the data
 * @ingroup collide
 '/
declare function dGeomGetData         cdecl alias "dGeomGetData"         (g as dGeomID) as any ptr
/'*
 * @brief Set the body associated with a placeable geom.
 *
 * Setting a body on a geom automatically combines the position vector and
 * rotation matrix of the body and geom, so that setting the position or
 * orientation of one will set the value for both objects. Setting a body
 * ID of zero gives the geom its own position and rotation, independent
 * from any body. If the geom was previously connected to a body then its
 * new independent position/rotation is set to the current position/rotation
 * of the body.
 *
 * Calling these functions on a non-placeable geom results in a runtime
 * error in the debug build of ODE.
 *
 * @param geom the geom to connect
 * @param body the body to attach to the geom
 * @ingroup collide
 '/
declare sub      dGeomSetBody         cdecl alias "dGeomSetBody"         (g as dGeomID,  as dBodyID)
/'*
 * @brief Get the body associated with a placeable geom.
 * @param geom the geom to query.
 * @sa dGeomSetBody
 * @ingroup collide
 '/
declare function dGeomGetBody         cdecl alias "dGeomGetBody"         (g as dGeomID) as dBodyID
/'*
 * @brief Set the position vector of a placeable geom.
 *
 * If the geom is attached to a body, the body's position will also be changed.
 * Calling this function on a non-placeable geom results in a runtime error in
 * the debug build of ODE.
 *
 * @param geom the geom to set.
 * @param x the new X coordinate.
 * @param y the new Y coordinate.
 * @param z the new Z coordinate.
 * @sa dBodySetPosition
 * @ingroup collide
 '/
declare sub      dGeomSetPosition     cdecl alias "dGeomSetPosition"     (g as dGeomID,  x as dReal,  y as dReal,  z as dReal)
/'*
 * @brief Set the rotation matrix of a placeable geom.
 *
 * If the geom is attached to a body, the body's rotation will also be changed.
 * Calling this function on a non-placeable geom results in a runtime error in
 * the debug build of ODE.
 *
 * @param geom the geom to set.
 * @param R the new rotation matrix.
 * @sa dBodySetRotation
 * @ingroup collide
 '/
declare sub      dGeomSetRotation     cdecl alias "dGeomSetRotation"     (g as dGeomID, byref R as dMatrix3)
/'*
 * @brief Set the rotation of a placeable geom.
 *
 * If the geom is attached to a body, the body's rotation will also be changed.
 *
 * Calling this function on a non-placeable geom results in a runtime error in
 * the debug build of ODE.
 *
 * @param geom the geom to set.
 * @param Q the new rotation.
 * @sa dBodySetQuaternion
 * @ingroup collide
 '/
declare sub      dGeomSetQuaternion   cdecl alias "dGeomSetQuaternion"   (g as dGeomID, byref q as dQuaternion)
/'*
 * @brief Get the position vector of a placeable geom.
 *
 * If the geom is attached to a body, the body's position will be returned.
 *
 * Calling this function on a non-placeable geom results in a runtime error in
 * the debug build of ODE.
 *
 * @param geom the geom to query.
 * @returns A pointer to the geom's position vector.
 * @remarks The returned value is a pointer to the geom's internal
 *          data structure. It is valid until any changes are made
 *          to the geom.
 * @sa dBodyGetPosition
 * @ingroup collide
 '/
declare function dGeomGetPosition     cdecl alias "dGeomGetPosition"     (g as dGeomID) as dReal ptr
/'*
 * @brief Get the rotation matrix of a placeable geom.
 *
 * If the geom is attached to a body, the body's rotation will be returned.
 *
 * Calling this function on a non-placeable geom results in a runtime error in
 * the debug build of ODE.
 *
 * @param geom the geom to query.
 * @returns A pointer to the geom's rotation matrix.
 * @remarks The returned value is a pointer to the geom's internal
 *          data structure. It is valid until any changes are made
 *          to the geom.
 * @sa dBodyGetRotation
 * @ingroup collide
 '/
declare function dGeomGetRotation     cdecl alias "dGeomGetRotation"     (g as dGeomID) as dReal ptr
/'*
 * @brief Get the rotation quaternion of a placeable geom.
 *
 * If the geom is attached to a body, the body's quaternion will be returned.
 *
 * Calling this function on a non-placeable geom results in a runtime error in
 * the debug build of ODE.
 *
 * @param geom the geom to query.
 * @param result a copy of the rotation quaternion.
 * @sa dBodyGetQuaternion
 * @ingroup collide
 '/
declare sub      dGeomGetQuaternion   cdecl alias "dGeomGetQuaternion"   (g as dGeomID,  result as dQuaternion)
/'*
 * @brief Return the axis-aligned bounding box.
 *
 * Return in aabb an axis aligned bounding box that surrounds the given geom.
 * The aabb array has elements (minx, maxx, miny, maxy, minz, maxz). If the
 * geom is a space, a bounding box that surrounds all contained geoms is
 * returned.
 *
 * This function may return a pre-computed cached bounding box, if it can
 * determine that the geom has not moved since the last time the bounding
 * box was computed.
 *
 * @param geom the geom to query
 * @param aabb the returned bounding box
 * @ingroup collide
 '/
declare sub      dGeomGetAABB         cdecl alias "dGeomGetAABB"         (g as dGeomID,  aabb as dReal ptr)
/'*
 * @brief Determing if a geom is a space.
 * @param geom the geom to query
 * @returns Non-zero if the geom is a space, zero otherwise.
 * @ingroup collide
 '/
declare function dGeomIsSpace         cdecl alias "dGeomIsSpace"         (g as dGeomID) as integer
/'*
 * @brief Query for the space containing a particular geom.
 * @param geom the geom to query
 * @returns The space that contains the geom, or NULL if the geom is
 *          not contained by a space.
 * @ingroup collide
 '/
declare function dGeomGetSpace        cdecl alias "dGeomGetSpace"        (g as dGeomID) as dSpaceID
/'*
 * @brief Given a geom, this returns its class.
 *
 * The ODE classes are:
 *  @li dSphereClass
 *  @li dBoxClass
 *  @li dCylinderClass
 *  @li dPlaneClass
 *  @li dRayClass
 *  @li dConvexClass
 *  @li dGeomTransformClass
 *  @li dTriMeshClass
 *  @li dSimpleSpaceClass
 *  @li dHashSpaceClass
 *  @li dQuadTreeSpaceClass
 *  @li dFirstUserClass
 *  @li dLastUserClass
 *
 * User-defined class will return their own number.
 *
 * @param geom the geom to query
 * @returns The geom class ID.
 * @ingroup collide
 '/
declare function dGeomGetClass        cdecl alias "dGeomGetClass"        (g as dGeomID) as integer
/'*
 * @brief Set the "category" bitfield for the given geom.
 *
 * The category bitfield is used by spaces to govern which geoms will
 * interact with each other. The bitfield is guaranteed to be at least
 * 32 bits wide. The default category values for newly created geoms
 * have all bits set.
 *
 * @param geom the geom to set
 * @param bits the new bitfield value
 * @ingroup collide
 '/
declare sub      dGeomSetCategoryBits cdecl alias "dGeomSetCategoryBits" (g as dGeomID,  bits as uinteger)
/'*
 * @brief Set the "collide" bitfield for the given geom.
 *
 * The collide bitfield is used by spaces to govern which geoms will
 * interact with each other. The bitfield is guaranteed to be at least
 * 32 bits wide. The default category values for newly created geoms
 * have all bits set.
 *
 * @param geom the geom to set
 * @param bits the new bitfield value
 * @ingroup collide
 '/
declare sub      dGeomSetCollideBits  cdecl alias "dGeomSetCollideBits"  (g as dGeomID,  bits as uinteger)
/'*
 * @brief Get the "category" bitfield for the given geom.
 *
 * @param geom the geom to set
 * @param bits the new bitfield value
 * @sa dGeomSetCategoryBits
 * @ingroup collide
 '/
declare function dGeomGetCategoryBits cdecl alias "dGeomGetCategoryBits" (g as dGeomID) as uinteger
/'*
 * @brief Get the "collide" bitfield for the given geom.
 *
 * @param geom the geom to set
 * @param bits the new bitfield value
 * @sa dGeomSetCollideBits
 * @ingroup collide
 '/
declare function dGeomGetCollideBits  cdecl alias "dGeomGetCollideBits"  (g as dGeomID) as uinteger
/'*
 * @brief Enable a geom.
 *
 * Disabled geoms are completely ignored by dSpaceCollide and dSpaceCollide2,
 * although they can still be members of a space. New geoms are created in
 * the enabled state.
 *
 * @param geom   the geom to enable
 * @sa dGeomDisable
 * @sa dGeomIsEnabled
 * @ingroup collide
 '/
declare sub      dGeomEnable          cdecl alias "dGeomEnable"          (g as dGeomID)
/'*
 * @brief Disable a geom.
 *
 * Disabled geoms are completely ignored by dSpaceCollide and dSpaceCollide2,
 * although they can still be members of a space. New geoms are created in
 * the enabled state.
 *
 * @param geom   the geom to disable
 * @sa dGeomDisable
 * @sa dGeomIsEnabled
 * @ingroup collide
 '/
declare sub      dGeomDisable         cdecl alias "dGeomDisable"         (g as dGeomID)
/'*
 * @brief Check to see if a geom is enabled.
 *
 * Disabled geoms are completely ignored by dSpaceCollide and dSpaceCollide2,
 * although they can still be members of a space. New geoms are created in
 * the enabled state.
 *
 * @param geom   the geom to query
 * @returns Non-zero if the geom is enabled, zero otherwise.
 * @sa dGeomDisable
 * @sa dGeomIsEnabled
 * @ingroup collide
 '/
declare function dGeomIsEnabled       cdecl alias "dGeomIsEnabled"       (g as dGeomID) as integer


' geom offset from body

/'*
 * @brief Set the local offset position of a geom from its body.
 *
 * Sets the geom's positional offset in local coordinates.
 * After this call, the geom will be at a new position determined from the
 * body's position and the offset.
 * The geom must be attached to a body.
 * If the geom did not have an offset, it is automatically created.
 *
 * @param geom the geom to set.
 * @param x the new X coordinate.
 * @param y the new Y coordinate.
 * @param z the new Z coordinate.
 * @ingroup collide
 '/
declare sub dGeomSetOffsetPosition cdecl alias "dGeomSetOffsetPosition" (g as dGeomID,x as dReal,y as dReal,z as dReal)

/'*
 * @brief Set the local offset rotation matrix of a geom from its body.
 *
 * Sets the geom's rotational offset in local coordinates.
 * After this call, the geom will be at a new position determined from the
 * body's position and the offset.
 * The geom must be attached to a body.
 * If the geom did not have an offset, it is automatically created.
 *
 * @param geom the geom to set.
 * @param R the new rotation matrix.
 * @ingroup collide
 '/
declare sub dGeomSetOffsetRotation cdecl alias "dGeomSetOffsetRotation" (g as dGeomID,r as dMatrix3)

/'*
 * @brief Set the local offset rotation of a geom from its body.
 *
 * Sets the geom's rotational offset in local coordinates.
 * After this call, the geom will be at a new position determined from the
 * body's position and the offset.
 * The geom must be attached to a body.
 * If the geom did not have an offset, it is automatically created.
 *
 * @param geom the geom to set.
 * @param Q the new rotation.
 * @ingroup collide
 '/
declare sub dGeomSetOffsetQuaternion cdecl alias "dGeomSetOffsetQuaternion" (g as dGeomID,q as dQuaternion)

/'*
 * @brief Set the offset position of a geom from its body.
 *
 * Sets the geom's positional offset to move it to the new world
 * coordinates.
 * After this call, the geom will be at the world position passed in,
 * and the offset will be the difference from the current body position.
 * The geom must be attached to a body.
 * If the geom did not have an offset, it is automatically created.
 *
 * @param geom the geom to set.
 * @param x the new X coordinate.
 * @param y the new Y coordinate.
 * @param z the new Z coordinate.
 * @ingroup collide
 '/
declare sub dGeomSetOffsetWorldPosition cdecl alias "dGeomSetOffsetWorldPosition" (g as dGeomID,x as dReal,y as dReal,z as dReal)

/'*
 * @brief Set the offset rotation of a geom from its body.
 *
 * Sets the geom's rotational offset to orient it to the new world
 * rotation matrix.
 * After this call, the geom will be at the world orientation passed in,
 * and the offset will be the difference from the current body orientation.
 * The geom must be attached to a body.
 * If the geom did not have an offset, it is automatically created.
 *
 * @param geom the geom to set.
 * @param R the new rotation matrix.
 * @ingroup collide
 '/
declare sub dGeomSetOffsetWorldRotation cdecl alias "dGeomSetOffsetWorldRotation" (g as dGeomID,r as dMatrix3)

/'*
 * @brief Set the offset rotation of a geom from its body.
 *
 * Sets the geom's rotational offset to orient it to the new world
 * rotation matrix.
 * After this call, the geom will be at the world orientation passed in,
 * and the offset will be the difference from the current body orientation.
 * The geom must be attached to a body.
 * If the geom did not have an offset, it is automatically created.
 *
 * @param geom the geom to set.
 * @param Q the new rotation.
 * @ingroup collide
 '/
declare sub dGeomSetOffsetWorldQuaternion cdecl alias "dGeomSetOffsetWorldQuaternion" (g as dGeomID,q as dQuaternion)


/'*
 * @brief Clear any offset from the geom.
 *
 * If the geom has an offset, it is eliminated and the geom is
 * repositioned at the body's position.  If the geom has no offset,
 * this function does nothing.
 * This is more efficient than calling dGeomSetOffsetPosition(zero)
 * and dGeomSetOffsetRotation(identiy), because this function actually
 * eliminates the offset, rather than leaving it as the identity transform.
 *
 * @param geom the geom to have its offset destroyed.
 * @ingroup collide
 '/
declare sub dGeomClearOffset cdecl alias "dGeomClearOffset" (g as dGeomID)


/'*
 * @brief Check to see whether the geom has an offset.
 *
 * This function will return non-zero if the offset has been created.
 * Note that there is a difference between a geom with no offset,
 * and a geom with an offset that is the identity transform.
 * In the latter case, although the observed behaviour is identical,
 * there is a unnecessary computation involved because the geom will
 * be applying the transform whenever it needs to recalculate its world
 * position.
 *
 * @param geom the geom to query.
 * @returns Non-zero if the geom has an offset, zero otherwise.
 * @ingroup collide
 '/
declare function dGeomIsOffset cdecl alias "dGeomIsOffset" (g as dGeomID) as integer


/'*
 * @brief Get the offset position vector of a geom.
 *
 * Returns the positional offset of the geom in local coordinates.
 * If the geom has no offset, this function returns the zero vector.
 *
 * @param geom the geom to query.
 * @returns A pointer to the geom's offset vector.
 * @remarks The returned value is a pointer to the geom's internal
 *          data structure. It is valid until any changes are made
 *          to the geom.
 * @ingroup collide
 '/
declare function dGeomGetOffsetPosition cdecl alias "dGeomGetOffsetPosition" (g as dGeomID) as dReal ptr
declare sub      dGeomCopyOffsetPosition cdecl alias "dGeomCopyOffsetPosition" (g as dGeomID,byref pos as dVector3)
/'*
 * @brief Get the offset position vector of a geom.
 *
 * Returns the positional offset of the geom in local coordinates.
 * If the geom has no offset, this function returns the zero vector.
 *
 * @param geom the geom to query.
 * @returns A pointer to the geom's offset vector.
 * @remarks The returned value is a pointer to the geom's internal
 *          data structure. It is valid until any changes are made
 *          to the geom.
 * @ingroup collide
 '/
declare function dGeomGetOffsetRotation cdecl alias "dGeomGetOffsetRotation" ( g as dGeomID) as dReal ptr
declare sub      dGeomCopyOffsetRotation cdecl alias "dGeomCopyOffsetRotation"( g as dGeomID,byref R as dMatrix3)

/'*
 * @brief Get the offset rotation quaternion of a geom.
 *
 * Returns the rotation offset of the geom as a quaternion.
 * If the geom has no offset, the identity quaternion is returned.
 *
 * @param geom the geom to query.
 * @param result a copy of the rotation quaternion.
 * @ingroup collide
 '/
declare sub dGeomGetOffsetQuaternion cdecl alias "dGeomGetOffsetQuaternion" ( g as dGeomID, resutl as dQuaternion ptr)

/'
 * Just generate any contacts (disables any contact refining).
 '/
#define CONTACTS_UNIMPORTANT &H80000000

' collision detection

/'*
 *
 * @brief Given two geoms o1 and o2 that potentially intersect,
 * generate contact information for them.
 *
 * Internally, this just calls the correct class-specific collision
 * functions for o1 and o2.
 *
 * @param o1 The first geom to test.
 * @param o2 The second geom to test.
 *
 * @param flags The flags specify how contacts should be generated if
 * the geoms touch. The lower 16 bits of flags is an integer that
 * specifies the maximum number of contact points to generate. Note
 * that if this number is zero, this function just pretends that it is
 * one -- in other words you can not ask for zero contacts. All other bits
 * in flags must be zero. In the future the other bits may be used to
 * select from different contact generation strategies.
 *
 * @param contact Points to an array of dContactGeom structures. The array
 * must be able to hold at least the maximum number of contacts. These
 * dContactGeom structures may be embedded within larger structures in the
 * array -- the skip parameter is the byte offset from one dContactGeom to
 * the next in the array. If skip is sizeof(dContactGeom) then contact
 * points to a normal (C-style) array. It is an error for skip to be smaller
 * than sizeof(dContactGeom).
 *
 * @returns If the geoms intersect, this function returns the number of contact
 * points generated (and updates the contact array), otherwise it returns 0
 * (and the contact array is not touched).
 *
 * @remarks If a space is passed as o1 or o2 then this function will collide
 * all objects contained in o1 with all objects contained in o2, and return
 * the resulting contact points. This method for colliding spaces with geoms
 * (or spaces with spaces) provides no user control over the individual
 * collisions. To get that control, use dSpaceCollide or dSpaceCollide2 instead.
 *
 * @remarks If o1 and o2 are the same geom then this function will do nothing
 * and return 0. Technically speaking an object intersects with itself, but it
 * is not useful to find contact points in this case.
 *
 * @remarks This function does not care if o1 and o2 are in the same space or not
 * (or indeed if they are in any space at all).
 *
 * @ingroup collide
 '/
declare function dCollide cdecl alias "dCollide" ( _
  o1      as dGeomID, _
  o2      as dGeomID, _
  flags   as integer, _
  contact as dContactGeom ptr, _
  skip    as integer) as integer

/'*
 * @brief Determines which pairs of geoms in a space may potentially intersect,
 * and calls the callback function for each candidate pair.
 *
 * @param space The space to test.
 *
 * @param data Passed from dSpaceCollide directly to the callback
 * function. Its meaning is user defined. The o1 and o2 arguments are the
 * geoms that may be near each other.
 *
 * @param callback A callback function is of type @ref dNearCallback.
 *
 * @remarks Other spaces that are contained within the colliding space are
 * not treated specially, i.e. they are not recursed into. The callback
 * function may be passed these contained spaces as one or both geom
 * arguments.
 *
 * @remarks dSpaceCollide() is guaranteed to pass all intersecting geom
 * pairs to the callback function, but may also pass close but
 * non-intersecting pairs. The number of these calls depends on the
 * internal algorithms used by the space. Thus you should not expect
 * that dCollide will return contacts for every pair passed to the
 * callback.
 *
 * @sa dSpaceCollide2
 * @ingroup collide
 '/
declare sub dSpaceCollide cdecl alias "dSpaceCollide" ( _
  s        as dSpaceID, _
  lpUser   as any ptr , _
  callback as dNearCallback ptr)

/'*
 * @brief Determines which geoms from one space may potentially intersect with 
 * geoms from another space, and calls the callback function for each candidate 
 * pair. 
 *
 * @param space1 The first space to test.
 *
 * @param space2 The second space to test.
 *
 * @param data Passed from dSpaceCollide directly to the callback
 * function. Its meaning is user defined. The o1 and o2 arguments are the
 * geoms that may be near each other.
 *
 * @param callback A callback function is of type @ref dNearCallback.
 *
 * @remarks This function can also test a single non-space geom against a 
 * space. This function is useful when there is a collision hierarchy, i.e. 
 * when there are spaces that contain other spaces.
 *
 * @remarks Other spaces that are contained within the colliding space are
 * not treated specially, i.e. they are not recursed into. The callback
 * function may be passed these contained spaces as one or both geom
 * arguments.
 *
 * @remarks dSpaceCollide2() is guaranteed to pass all intersecting geom
 * pairs to the callback function, but may also pass close but
 * non-intersecting pairs. The number of these calls depends on the
 * internal algorithms used by the space. Thus you should not expect
 * that dCollide will return contacts for every pair passed to the
 * callback.
 *
 * @sa dSpaceCollide
 * @ingroup collide
 '/
declare sub dSpaceCollide2 cdecl alias "dSpaceCollide2" ( _
  o1 as dGeomID, _
  o2 as dGeomID, _
  lpUser   as any ptr, _
  callback as dNearCallback ptr)

' standard classes
' the maximum number of user classes that are supported 
enum 
  dMaxUserClasses = 4
end enum

enum
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
  dQuadTreeSpaceClass
  dLastSpaceClass = dQuadTreeSpaceClass

  dFirstUserClass
  dLastUserClass = dFirstUserClass + dMaxUserClasses - 1
  dGeomNumClasses
end enum


/'*
 * @defgroup collide_sphere Sphere Class
 * @ingroup collide
 '/

/'*
 * @brief Create a sphere geom of the given radius, and return its ID. 
 *
 * @param space   a space to contain the new geom. May be null.
 * @param radius  the radius of the sphere.
 *
 * @returns A new sphere geom.
 *
 * @remarks The point of reference for a sphere is its center.
 *
 * @sa dGeomDestroy
 * @sa dGeomSphereSetRadius
 * @ingroup collide_sphere
 '/
declare function dCreateSphere             cdecl alias "dCreateSphere"         ( space  as dSpaceID,  radius as dReal) as dGeomID

/'*
 * @brief Set the radius of a sphere geom.
 *
 * @param sphere  the sphere to set.
 * @param radius  the new radius.
 *
 * @sa dGeomSphereGetRadius
 * @ingroup collide_sphere
 '/
declare sub      dGeomSphereSetRadius      cdecl alias "dGeomSphereSetRadius"  ( sphere as dGeomID,  radius as dReal)

/'*
 * @brief Retrieves the radius of a sphere geom.
 *
 * @param sphere  the sphere to query.
 *
 * @sa dGeomSphereSetRadius
 * @ingroup collide_sphere
 '/
declare function dGeomSphereGetRadius      cdecl alias "dGeomSphereGetRadius"  ( sphere as dGeomID) as dReal

/'*
 * @brief Calculate the depth of the a given point within a sphere.
 *
 * @param sphere  the sphere to query.
 * @param x       the X coordinate of the point.
 * @param y       the Y coordinate of the point.
 * @param z       the Z coordinate of the point.
 *
 * @returns The depth of the point. Points inside the sphere will have a 
 * positive depth, points outside it will have a negative depth, and points
 * on the surface will have a depth of zero.
 *
 * @ingroup collide_sphere
 '/
declare function dGeomSpherePointDepth     cdecl alias "dGeomSpherePointDepth" (sphere as dGeomID,  x as dReal,  y as dReal,  z as dReal) as dReal

declare function dCreateConvex cdecl alias "dCreateConvex" ( _
  s           as dSpaceID , _
  _planes     as dReal ptr, _
  _planecount as integer  , _
  _points     as dReal ptr, _
  _pointcount as integer,  _
  _polygons   as integer ptr ) as dGeomID
declare sub dGeomSetConvex cdecl alias "dGeomSetConvex" ( _
  g           as dGeomID  , _
  _planes     as dReal ptr, _
  _count      as integer  , _
  _points     as dReal ptr, _
  _pointcount as integer  , _
  _polygons   as integer ptr)

/'*
 * @brief Create a box geom with the provided side lengths.
 *
 * @param space   a space to contain the new geom. May be null.
 * @param lx      the length of the box along the X axis
 * @param ly      the length of the box along the Y axis
 * @param lz      the length of the box along the Z axis
 *
 * @returns A new box geom.
 *
 * @remarks The point of reference for a box is its center.
 *
 * @sa dGeomDestroy
 * @sa dGeomBoxSetLengths
 * @ingroup collide_box
 '/
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

declare function dCreateCylinder           cdecl alias "dCreateCylinder"        (space    as dSpaceID,  radius as dReal    ,  length as dReal) as dGeomID
declare sub      dGeomCylinderSetParams    cdecl alias "dGeomCylinderSetParams" (cylinder as dGeomID ,  radius as dReal    ,  length as dReal)
declare sub      dGeomCylinderGetParams    cdecl alias "dGeomCylinderGetParams" (cylinder as dGeomID ,  radius as dReal ptr,  length as dReal ptr)

' For now we want to have a backwards compatible C-API, note: C++ API is not.
#define dCreateCCylinder dCreateCapsule
#define dGeomCCylinderSetParams dGeomCapsuleSetParams
#define dGeomCCylinderGetParams dGeomCapsuleGetParams
#define dGeomCCylinderPointDepth dGeomCapsulePointDepth
#define dCCylinderClass dCapsuleClass

'declare function dCreateCCylinder          cdecl alias "dCreateCCylinder"         (space     as dSpaceID,  radius as dReal    ,  length as dReal) as dGeomID
'declare sub      dGeomCCylinderSetParams   cdecl alias "dGeomCCylinderSetParams"  (ccylinder as dGeomID ,  radius as dReal    ,  length as dReal)
'declare sub      dGeomCCylinderGetParams   cdecl alias "dGeomCCylinderGetParams"  (ccylinder as dGeomID ,  radius as dReal ptr,  length as dReal ptr)
'declare function dGeomCCylinderPointDepth  cdecl alias "dGeomCCylinderPointDepth" (ccylinder as dGeomID ,  x as dReal,  y as dReal,  z as dReal) as dReal

declare function dCreateRay                cdecl alias "dCreateRay"            (space as dSpaceID, length       as dReal) as dGeomID
declare sub      dGeomRaySetLength         cdecl alias "dGeomRaySetLength"     (ray   as dGeomID,  length       as dReal)
declare function dGeomRayGetLength         cdecl alias "dGeomRayGetLength"     (ray   as dGeomID) as dReal
declare sub      dGeomRaySet               cdecl alias "dGeomRaySet"           (ray   as dGeomID,  px           as dReal      ,  py           as dReal,  pz as dReal,  dx as dReal,  dy as dReal,  dz as dReal)
declare sub      dGeomRayGet               cdecl alias "dGeomRayGet"           (ray   as dGeomID,  start        as dVector3   ,  dir          as dVector3)
declare sub      dGeomRaySetParams         cdecl alias "dGeomRaySetParams"     (g     as dGeomID,  FirstContact as integer    ,  BackfaceCull as integer)
declare sub      dGeomRayGetParams         cdecl alias "dGeomRayGetParams"     (g     as dGeomID,  FirstContact as integer ptr,  BackfaceCull as integer ptr)
declare sub      dGeomRaySetClosestHit     cdecl alias "dGeomRaySetClosestHit" (g     as dGeomID,  closestHit   as integer)
declare function dGeomRayGetClosestHit     cdecl alias "dGeomRayGetClosestHit" (g     as dGeomID) as integer


declare function dCreateGeomTransform      cdecl alias "dCreateGeomTransform" ( space as dSpaceID) as dGeomID
declare sub      dGeomTransformSetGeom     cdecl alias "dGeomTransformSetGeom" ( g as dGeomID,  obj as dGeomID)
declare function dGeomTransformGetGeom     cdecl alias "dGeomTransformGetGeom" ( g as dGeomID) as dGeomID
declare sub      dGeomTransformSetCleanup  cdecl alias "dGeomTransformSetCleanup" ( g as dGeomID,  mode as integer)
declare function dGeomTransformGetCleanup  cdecl alias "dGeomTransformGetCleanup" ( g as dGeomID) as integer
declare sub      dGeomTransformSetInfo     cdecl alias "dGeomTransformSetInfo" ( g as dGeomID,  mode as integer)
declare function dGeomTransformGetInfo     cdecl alias "dGeomTransformGetInfo" ( g as dGeomID) as integer

/'*
 * @brief Callback prototype
 *
 * Used by the callback heightfield data type to sample a height for a
 * given cell position.
 *
 * @param p_user_data User data specified when creating the dHeightfieldDataID
 * @param x The index of a sample in the local x axis. It is a value
 * in the range zero to ( nWidthSamples - 1 ).
 * @param x The index of a sample in the local z axis. It is a value
 * in the range zero to ( nDepthSamples - 1 ).
 *
 * @return The sample height which is then scaled and offset using the
 * values specified when the heightfield data was created.
 *
 * @ingroup collide
 '/
type dHeightfieldGetHeight_t as function cdecl ( _
  byval p_user_data as any ptr, _
  byval x as integer, _
  byval z as integer) as dReal



/'*
 * @brief Creates a heightfield geom.
 *
 * Uses the information in the given dHeightfieldDataID to construct
 * a geom representing a heightfield in a collision space.
 *
 * @param space The space to add the geom to.
 * @param data The dHeightfieldDataID created by dGeomHeightfieldDataCreate and
 * setup by dGeomHeightfieldDataBuildCallback, dGeomHeightfieldDataBuildByte,
 * dGeomHeightfieldDataBuildShort or dGeomHeightfieldDataBuildFloat.
 * @param bPlaceable If non-zero this geom can be transformed in the world using the
 * usual functions such as dGeomSetPosition and dGeomSetRotation. If the geom is
 * not set as placeable, then it uses a fixed orientation where the global y axis
 * represents the dynamic 'height' of the heightfield.
 *
 * @return A geom id to reference this geom in other calls.
 *
 * @ingroup collide
 '/
declare function dCreateHeightfield cdecl alias "dCreateHeightfield" ( _
byval space as dSpaceID, _
byval id as dHeightfieldDataID, _
byval bPlaceable as integer) as dGeomID

/'*
 * @brief Creates a new empty dHeightfieldDataID.
 *
 * Allocates a new dHeightfieldDataID and returns it. You must call
 * dGeomHeightfieldDataDestroy to destroy it after the geom has been removed.
 * The dHeightfieldDataID value is used when specifying a data format type.
 *
 * @return A dHeightfieldDataID for use with dGeomHeightfieldDataBuildCallback,
 * dGeomHeightfieldDataBuildByte, dGeomHeightfieldDataBuildShort or
 * dGeomHeightfieldDataBuildFloat.
 * @ingroup collide
 '/
declare function dGeomHeightfieldDataCreate cdecl alias "dGeomHeightfieldDataCreate" () as dHeightfieldDataID

/'*
 * @brief Destroys a dHeightfieldDataID.
 *
 * Deallocates a given dHeightfieldDataID and all managed resources.
 *
 * @param d A dHeightfieldDataID created by dGeomHeightfieldDataCreate
 * @ingroup collide
 '/
declare sub dGeomHeightfieldDataDestroy cdecl alias "dGeomHeightfieldDataDestroy" (d as dHeightfieldDataID)



/'*
 * @brief Configures a dHeightfieldDataID to use a callback to
 * retrieve height data.
 *
 * Before a dHeightfieldDataID can be used by a geom it must be
 * configured to specify the format of the height data.
 * This call specifies that the heightfield data is computed by
 * the user and it should use the given callback when determining
 * the height of a given element of it's shape.
 *
 * @param d A new dHeightfieldDataID created by dGeomHeightfieldDataCreate
 *
 * @param width Specifies the total 'width' of the heightfield along
 * the geom's local x axis.
 * @param depth Specifies the total 'depth' of the heightfield along
 * the geom's local z axis.
 *
 * @param widthSamples Specifies the number of vertices to sample
 * along the width of the heightfield. Each vertex has a corresponding
 * height value which forms the overall shape.
 * Naturally this value must be at least two or more.
 * @param depthSamples Specifies the number of vertices to sample
 * along the depth of the heightfield.
 *
 * @param scale A uniform scale applied to all raw height data.
 * @param offset An offset applied to the scaled height data.
 *
 * @param thickness A value subtracted from the lowest height
 * value which in effect adds an additional cuboid to the base of the
 * heightfield. This is used to prevent geoms from looping under the
 * desired terrain and not registering as a collision. Note that the
 * thickness is not affected by the scale or offset parameters.
 *
 * @param bWrap If non-zero the heightfield will infinitely tile in both
 * directions along the local x and z axes. If zero the heightfield is
 * bounded from zero to width in the local x axis, and zero to depth in
 * the local z axis.
 *
 * @ingroup collide
 '/
declare sub dGeomHeightfieldDataBuildCallback cdecl alias "dGeomHeightfieldDataBuildCallback" ( _
  h as dHeightfieldDataID, _
  pUserData    as any ptr, _
  pCallback    as any ptr, _
  _width       as dReal,_
  depth        as dReal, _
  widthSamples as integer, _
  depthSamples as integer, _
  scale        as dReal, _
  offset       as dReal, _
  thickness    as dReal, _
  bWrap        as integer)

/'*
 * @brief Configures a dHeightfieldDataID to use height data in byte format.
 *
 * Before a dHeightfieldDataID can be used by a geom it must be
 * configured to specify the format of the height data.
 * This call specifies that the heightfield data is stored as a rectangular
 * array of bytes (8 bit unsigned) representing the height at each sample point.
 *
 * @param d A new dHeightfieldDataID created by dGeomHeightfieldDataCreate
 *
 * @param pHeightData A pointer to the height data.
 * @param bCopyHeightData When non-zero the height data is copied to an
 * internal store. When zero the height data is accessed by reference and
 * so must persist throughout the lifetime of the heightfield.
 *
 * @param width Specifies the total 'width' of the heightfield along
 * the geom's local x axis.
 * @param depth Specifies the total 'depth' of the heightfield along
 * the geom's local z axis.
 *
 * @param widthSamples Specifies the number of vertices to sample
 * along the width of the heightfield. Each vertex has a corresponding
 * height value which forms the overall shape.
 * Naturally this value must be at least two or more.
 * @param depthSamples Specifies the number of vertices to sample
 * along the depth of the heightfield.
 *
 * @param scale A uniform scale applied to all raw height data.
 * @param offset An offset applied to the scaled height data.
 *
 * @param thickness A value subtracted from the lowest height
 * value which in effect adds an additional cuboid to the base of the
 * heightfield. This is used to prevent geoms from looping under the
 * desired terrain and not registering as a collision. Note that the
 * thickness is not affected by the scale or offset parameters.
 *
 * @param bWrap If non-zero the heightfield will infinitely tile in both
 * directions along the local x and z axes. If zero the heightfield is
 * bounded from zero to width in the local x axis, and zero to depth in
 * the local z axis.
 *
 * @ingroup collide
 '/
declare sub dGeomHeightfieldDataBuildByte cdecl alias "dGeomHeightfieldDataBuildByte" ( _
  d               as dHeightfieldDataID, _
  pHeightData     as byte ptr, _
  bCopyHeightData as integer, _
  _width          as dReal, _
  depth           as dReal, _
  widthSamples    as integer, _
  depthSamples    as integer, _
  scale           as dReal, _
  offset          as dReal, _
  thickness       as dReal,bWrap as integer)

/'*
 * @brief Configures a dHeightfieldDataID to use height data in short format.
 *
 * Before a dHeightfieldDataID can be used by a geom it must be
 * configured to specify the format of the height data.
 * This call specifies that the heightfield data is stored as a rectangular
 * array of shorts (16 bit signed) representing the height at each sample point.
 *
 * @param d A new dHeightfieldDataID created by dGeomHeightfieldDataCreate
 *
 * @param pHeightData A pointer to the height data.
 * @param bCopyHeightData When non-zero the height data is copied to an
 * internal store. When zero the height data is accessed by reference and
 * so must persist throughout the lifetime of the heightfield.
 *
 * @param width Specifies the total 'width' of the heightfield along
 * the geom's local x axis.
 * @param depth Specifies the total 'depth' of the heightfield along
 * the geom's local z axis.
 *
 * @param widthSamples Specifies the number of vertices to sample
 * along the width of the heightfield. Each vertex has a corresponding
 * height value which forms the overall shape.
 * Naturally this value must be at least two or more.
 * @param depthSamples Specifies the number of vertices to sample
 * along the depth of the heightfield.
 *
 * @param scale A uniform scale applied to all raw height data.
 * @param offset An offset applied to the scaled height data.
 *
 * @param thickness A value subtracted from the lowest height
 * value which in effect adds an additional cuboid to the base of the
 * heightfield. This is used to prevent geoms from looping under the
 * desired terrain and not registering as a collision. Note that the
 * thickness is not affected by the scale or offset parameters.
 *
 * @param bWrap If non-zero the heightfield will infinitely tile in both
 * directions along the local x and z axes. If zero the heightfield is
 * bounded from zero to width in the local x axis, and zero to depth in
 * the local z axis.
 *
 * @ingroup collide
 '/
declare sub dGeomHeightfieldDataBuildShort cdecl alias "dGeomHeightfieldDataBuildShort" ( _
  d               as dHeightfieldDataID, _
  pHeightData     as short ptr, _
  bCopyHeightData as integer, _
  _width          as dReal, _
  depth           as dReal, _
  widthSamples    as integer, _
  depthSamples    as integer, _
  scale           as dReal, _
  offset          as dReal, _
  thickness       as dReal, _
  bWrap           as integer)

/'*
 * @brief Configures a dHeightfieldDataID to use height data in 
 * single precision floating point format.
 *
 * Before a dHeightfieldDataID can be used by a geom it must be
 * configured to specify the format of the height data.
 * This call specifies that the heightfield data is stored as a rectangular
 * array of single precision floats representing the height at each
 * sample point.
 *
 * @param d A new dHeightfieldDataID created by dGeomHeightfieldDataCreate
 *
 * @param pHeightData A pointer to the height data.
 * @param bCopyHeightData When non-zero the height data is copied to an
 * internal store. When zero the height data is accessed by reference and
 * so must persist throughout the lifetime of the heightfield.
 *
 * @param width Specifies the total 'width' of the heightfield along
 * the geom's local x axis.
 * @param depth Specifies the total 'depth' of the heightfield along
 * the geom's local z axis.
 *
 * @param widthSamples Specifies the number of vertices to sample
 * along the width of the heightfield. Each vertex has a corresponding
 * height value which forms the overall shape.
 * Naturally this value must be at least two or more.
 * @param depthSamples Specifies the number of vertices to sample
 * along the depth of the heightfield.
 *
 * @param scale A uniform scale applied to all raw height data.
 * @param offset An offset applied to the scaled height data.
 *
 * @param thickness A value subtracted from the lowest height
 * value which in effect adds an additional cuboid to the base of the
 * heightfield. This is used to prevent geoms from looping under the
 * desired terrain and not registering as a collision. Note that the
 * thickness is not affected by the scale or offset parameters.
 *
 * @param bWrap If non-zero the heightfield will infinitely tile in both
 * directions along the local x and z axes. If zero the heightfield is
 * bounded from zero to width in the local x axis, and zero to depth in
 * the local z axis.
 *
 * @ingroup collide
 '/
declare sub dGeomHeightfieldDataBuildSingle cdecl alias "dGeomHeightfieldDataBuildSingle" ( _
  d               as dHeightfieldDataID, _
  pHeightData     as single ptr, _
  bCopyHeightData as integer,_ 
  _width          as dReal, _
  depth           as dReal, _
  widthSamples    as integer, _
  depthSamples    as integer, _
  scale           as dReal, _
  offset          as dReal, _
  thickness       as dReal,bWrap as integer)

/'*
 * @brief Configures a dHeightfieldDataID to use height data in 
 * double precision floating point format.
 *
 * Before a dHeightfieldDataID can be used by a geom it must be
 * configured to specify the format of the height data.
 * This call specifies that the heightfield data is stored as a rectangular
 * array of double precision floats representing the height at each
 * sample point.
 *
 * @param d A new dHeightfieldDataID created by dGeomHeightfieldDataCreate
 *
 * @param pHeightData A pointer to the height data.
 * @param bCopyHeightData When non-zero the height data is copied to an
 * internal store. When zero the height data is accessed by reference and
 * so must persist throughout the lifetime of the heightfield.
 *
 * @param width Specifies the total 'width' of the heightfield along
 * the geom's local x axis.
 * @param depth Specifies the total 'depth' of the heightfield along
 * the geom's local z axis.
 *
 * @param widthSamples Specifies the number of vertices to sample
 * along the width of the heightfield. Each vertex has a corresponding
 * height value which forms the overall shape.
 * Naturally this value must be at least two or more.
 * @param depthSamples Specifies the number of vertices to sample
 * along the depth of the heightfield.
 *
 * @param scale A uniform scale applied to all raw height data.
 * @param offset An offset applied to the scaled height data.
 *
 * @param thickness A value subtracted from the lowest height
 * value which in effect adds an additional cuboid to the base of the
 * heightfield. This is used to prevent geoms from looping under the
 * desired terrain and not registering as a collision. Note that the
 * thickness is not affected by the scale or offset parameters.
 *
 * @param bWrap If non-zero the heightfield will infinitely tile in both
 * directions along the local x and z axes. If zero the heightfield is
 * bounded from zero to width in the local x axis, and zero to depth in
 * the local z axis.
 *
 * @ingroup collide
 '/
declare sub dGeomHeightfieldDataBuildDouble cdecl alias "dGeomHeightfieldDataBuildDouble" (d as dHeightfieldDataID, pHeightData as double ptr,bCopyHeightData as integer, width as dReal, depth as dReal,widthSamples as integer,depthSamples as integer, scale as dReal, offset as dReal,thickness as dReal,bWrap as integer)

/'*
 * @brief Manually set the minimum and maximum height bounds.
 *
 * This call allows you to set explicit min / max values after initial
 * creation typically for callback heightfields which default to +/- infinity,
 * or those whose data has changed. This must be set prior to binding with a
 * geom, as the the AABB is not recomputed after it's first generation.
 *
 * @remarks The minimum and maximum values are used to compute the AABB
 * for the heightfield which is used for early rejection of collisions.
 * A close fit will yield a more efficient collision check.
 *
 * @param d A dHeightfieldDataID created by dGeomHeightfieldDataCreate
 * @param min_height The new minimum height value. Scale, offset and thickness is then applied.
 * @param max_height The new maximum height value. Scale and offset is then applied.
 * @ingroup collide
 '/
declare sub dGeomHeightfieldDataSetBounds cdecl alias "dGeomHeightfieldDataSetBounds" (d as dHeightfieldDataID,minHeight as dReal, maxHeight as dReal)

/'*
 * @brief Assigns a dHeightfieldDataID to a heightfield geom.
 *
 * Associates the given dHeightfieldDataID with a heightfield geom.
 * This is done without affecting the GEOM_PLACEABLE flag.
 *
 * @param g A geom created by dCreateHeightfield
 * @param d A dHeightfieldDataID created by dGeomHeightfieldDataCreate
 * @ingroup collide
 '/
declare sub dGeomHeightfieldSetHeightfieldData cdecl alias "dGeomHeightfieldSetHeightfieldData" (g as dGeomID,d as dHeightfieldDataID)

/'*
 * @brief Gets the dHeightfieldDataID bound to a heightfield geom.
 *
 * Returns the dHeightfieldDataID associated with a heightfield geom.
 *
 * @param g A geom created by dCreateHeightfield
 * @return The dHeightfieldDataID which may be NULL if none was assigned.
 * @ingroup collide
 '/
declare function dGeomHeightfieldGetHeightfieldData cdecl alias "dGeomHeightfieldGetHeightfieldData" ( _
  g as dGeomID) as dHeightfieldDataID

' utility functions


declare sub      dClosestLineSegmentPoints cdecl alias "dClosestLineSegmentPoints" ( _
  a1  as dVector3, a2  as dVector3,  _
  b1  as dVector3, b2  as dVector3,  _
  cp1 as dVector3, cp2 as dVector3)
declare function dBoxTouchesBox            cdecl alias "dBoxTouchesBox" ( _
  p1    as dVector3,  _
  R1    as dMatrix3,  _
  side1 as dVector3,  _
  p2    as dVector3,  _
  R2    as dMatrix3,  _
  side2 as dVector3) as integer

' The meaning of flags parameter is the same as in dCollide()
declare function dBoxBox cdecl alias "dBoxBox" ( _
  p1          as dVector3, _
  R1          as dMatrix3, _
  side1       as dVector3, _
  p2          as dVector3, _
  R2          as dMatrix3, _
  side2       as dVector3, _
  normal      as dVector3, _
  depth       as dReal ptr, _
  return_code as integer ptr, _
  flags       as integer, _
  conatact    as dContactGeom ptr, _
  skip        as integer) as integer

declare sub dInfiniteAABB cdecl alias "dInfiniteAABB" ( _
  geom as dGeomID, _
  aabb as dReal ptr)
declare sub dInitODE  cdecl alias "dInitODE"
declare sub dCloseODE cdecl alias "dCloseODE"

type dGetAABBFn       as any
type dColliderFn      as integer
type dGetColliderFnFn as dColliderFn
type dGeomDtorFn      as any
type dAABBTestFn      as integer

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

#endif ' __ode_collision_bi__
