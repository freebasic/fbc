/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://www.freebasic.eu     *
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

/' @defgroup drawstuff DrawStuff
DrawStuff is a library for rendering simple 3D objects in a virtual 
environment, for the purposes of demonstrating the features of ODE.
It is provided for demonstration purposes and is not intended for
production use.

@section Notes

In the virtual world, the z axis is "up" and z=0 is the floor.

The user is able to click+drag in the main window to move the camera:
  * left button - pan and tilt.
  * right button - forward and sideways.
  * left + right button (or middle button) - sideways and up.
'/

#ifndef __DRAWSTUFF_BI__
#define __DRAWSTUFF_BI__

#include "fbgfx.bi"
#include "GL/gl.bi"
#include "GL/glu.bi"

#include "version.bi"
#inclib "drawstuff"

' texture numbers
#define DS_NONE   0 'uses the current color instead of a texture
#define DS_WOOD   1

#ifndef dEPSILON
# define dEPSILON 1.192092896e-07
#endif
#ifndef M_PI
# define M_PI (3.14159265358979323846)
#endif
#ifndef NULL
# define NULL 0
#endif
#ifndef RAD_TO_DEG
# define RAD_TO_DEG (180.0/M_PI)
#endif
#ifndef DEG_TO_RAD
# define DEG_TO_RAD (M_PI/180.0)
#endif

/'
 * @struct dsFunctions
 * @brief Set of functions to be used as callbacks by the simulation loop.
 * @ingroup drawstuff
 '/
type dsFunctions
  as integer version                ' put DS_VERSION here
  ' version 1 data
  _start   as sub                    ' called before sim loop starts
  _step    as sub (pause as integer) ' called before every frame
  _command as sub (cmd   as integer) ' called if a command key is pressed
  _stop    as sub                    ' called after sim loop exits
  ' version 2 data
  as zstring ptr path_to_textures ' if nonzero, path to texture files
end type


/'
 * @brief Does the complete simulation.
 * @ingroup drawstuff
 * This function starts running the simulation, and only exits when the simulation is done.
 * Function pointers should be provided for the callbacks.
 * @param argv supports flags like '-notex' '-noshadow' '-pause'
 * @param fn Callback functions.
 '/
declare sub dsSimulationLoop(window_width  as integer, _
                             window_height as integer, _
                             fn as dsFunctions ptr)

/'
 * @brief exit with error message.
 * @ingroup drawstuff
 * This function displays an error message then exit.
 * @param msg format strin, like printf, without the newline character.
 '/
declare sub dsError (msg as string)

/'
 * @brief exit with error message and core dump.
 * @ingroup drawstuff
 * this functions tries to dump core or start the debugger.
 * @param msg format strin, like printf, without the newline character.
 '/
declare sub dsDebug (msg as string)

/'
 * @brief print log message
 * @ingroup drawstuff
 * @param msg format string, like printf, without the \n.
 '/
declare sub dsPrint (msg as string)

/'
 * @brief Sets the viewpoint
 * @ingroup drawstuff
 * @param xyz camera position.
 * @param hpr contains heading, pitch and roll numbers in degrees. heading=0
 * points along the x axis, pitch=0 is looking towards the horizon, and
 * roll 0 is "unrotated".
 '/
declare sub dsSetViewpoint (xyz as single ptr,hpr as single ptr)

/'
 * @brief Gets the viewpoint
 * @ingroup drawstuff
 * @param xyz position
 * @param hpr heading,pitch,roll.
 '/
declare sub dsGetViewpoint(xyz as single ptr,hpr as single ptr)

/'
 * @brief Stop the simulation loop.
 * @ingroup drawstuff
 * Calling this from within dsSimulationLoop()
 * will cause it to exit and return to the caller. it is the same as if the
 * user used the exit command. using this outside the loop will have no
 * effect.
 '/
declare sub dsStop()

/'
 * @brief Get the elapsed time (on wall-clock)
 * @ingroup drawstuff
 * It returns the nr of seconds since the last call to this function.
 '/
declare function dsElapsedTime() as double

/'
 * @brief Toggle the rendering of textures.
 * @ingroup drawstuff
 * It changes the way objects are drawn. these changes will apply to all further
 * dsDrawXXX() functions. 
 * @param the texture number must be a DS_xxx texture constant.
 * The current texture is colored according to the current color.
 * At the start of each frame, the texture is reset to none and the color is
 * reset to white.
 '/
declare sub dsSetTexture(texture_number as integer)

/'
 * @brief Set the color with which geometry is drawn.
 * @ingroup drawstuff
 * @param red Red component from 0 to 1
 * @param green Green component from 0 to 1
 * @param blue Blue component from 0 to 1
 '/
declare sub dsSetColor(r as single, _
                       g as single, _
                       b as single)

/'
 * @brief Set the color and transparency with which geometry is drawn.
 * @ingroup drawstuff
 * @param alpha Note that alpha transparency is a misnomer: it is alpha opacity.
 * 1.0 means fully opaque, and 0.0 means fully transparent.
 '/
declare sub dsSetColorAlpha (r as single, _
                             g as single, _
                             b as single, _
                             a as single)

/'
 * @brief Draw a box.
 * @ingroup drawstuff
 * @param pos is the x,y,z of the center of the object.
 * @param R is a 3x3 rotation matrix for the object, stored by row like this:
 *        [ R11 R12 R13 0 ]
 *        [ R21 R22 R23 0 ]
 *        [ R31 R32 R33 0 ]
 * @param sides[] is an array of x,y,z side lengths.
 '/
declare sub dsDrawBox (p     as single ptr, _
                       R     as single ptr, _
                       sides as single ptr)

/'
 * @brief Draw a sphere.
 * @ingroup drawstuff
 * @param pos Position of center.
 * @param R orientation.
 * @param radius
 '/
declare sub dsDrawSphere (p    as single ptr, _
                          R    as single ptr, _
                          radius as single)

/'
 * @brief Draw a triangle.
 * @ingroup drawstuff
 * @param pos Position of center
 * @param R orientation
 * @param v0 first vertex
 * @param v1 second
 * @param v2 third vertex
 * @param solid set to 0 for wireframe
 '/
declare sub dsDrawTriangle (p   as single ptr   , _
                            R   as single ptr   , _
                            v0    as single ptr, _
                            v1    as single ptr, _
                            v2    as single ptr, _
                            solid as integer)

/'
 * @brief Draw a z-aligned cylinder
 * @ingroup drawstuff
 '/
declare sub dsDrawCylinder (p    as single ptr, _
                            R    as single ptr, _
                            length as single, _
                            radius as single)

/'
 * @brief Draw a z-aligned capsule
 * @ingroup drawstuff
 '/
declare sub dsDrawCapsule (p      as single ptr, _
                           R      as single ptr, _
                           length as single, _
                           radius as single)
/'
 * @brief Draw a line.
 * @ingroup drawstuff
 '/
declare sub dsDrawLine (pos1 as single ptr,pos2 as single ptr)

/'
 * @brief Draw a convex shape.
 * @ingroup drawstuff
 '/
declare sub dsDrawConvex(P           as single ptr, _
                         R           as single ptr, _
                         _planes     as single ptr, _
                         _planecount as integer  , _
                         _points     as single ptr, _
                         _pointcount as integer  , _
                         _polygons   as integer ptr)

' these drawing functions are identical to the ones above, 
' except they take * double arrays for `P' and `R'.
declare sub dsDrawBoxD (P as double ptr, _
                        R as double ptr, _
                        sides as double ptr)

declare sub dsDrawSphereD (P as double ptr, _
                           R as double ptr, _
                           radius as single)

declare sub dsDrawTriangleD (P    as double ptr, _
                             R    as double ptr, _
                            v0    as double ptr, _
                            v1    as double ptr, _
                            v2    as double ptr, _
                            solid as integer)
declare sub dsDrawCylinderD (P     as double ptr, _
                             R     as double ptr, _
                            length as single, _
                            radius as single)
declare sub dsDrawCapsuleD (P      as double ptr, _
                            R      as double ptr, _
                            length as single, _
                            radius as single)
declare sub dsDrawLineD (pos1 as double ptr, _
                         pos2 as double ptr)
declare sub dsDrawConvexD(P          as double ptr, _
                          R          as double ptr, _
                         _planes     as double ptr, _
                         _planecount as uinteger  , _
                         _points     as double ptr, _
                         _pointcount as uinteger  , _
                         _polygons   as uinteger ptr)
/'
 * @brief Set the quality with which curved objects are rendered.
 * @ingroup drawstuff
 * Higher numbers are higher quality, but slower to draw. 
 * This must be set before the first objects are drawn to be effective.
 * Default sphere quality is 1, default capsule quality is 3.
 '/
declare sub dsSetSphereQuality (n as integer) ' default = 1
declare sub dsSetCapsuleQuality(n as integer) ' default = 3

' Backwards compatible API
#define dsDrawCappedCylinder dsDrawCapsule
#define dsDrawCappedCylinderD dsDrawCapsuleD
#define dsSetCappedCylinderQuality dsSetCapsuleQuality

#endif '__DRAWSTUFF_BI__

