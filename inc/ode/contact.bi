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
#ifndef __ode_contact_bi__
#define __ode_contact_bi__
#include "common.bi"

enum SPARAMS
  dContactMu2       = &h0001
  dContactFDir1     = &h0002
  dContactBounce    = &h0004
  dContactSoftERP   = &h0008
  dContactSoftCFM   = &h0010
  dContactMotion1   = &h0020
  dContactMotion2   = &h0040
  dContactMotionN	  = &h0080
  dContactSlip1     = &h0100
  dContactSlip2     = &h0200

  dContactApprox0	  = &H0000
  dContactApprox1_1 = &h1000
  dContactApprox1_2 = &h2000
  dContactApprox1   = &h3000
end enum

type dSurfaceParameters
' must always be defined
  as SPARAMS mode          
  as dReal   mu
' only defined if the corresponding flag is set in mode 
  as dReal   mu2 
  as dReal   bounce 
  as dReal   bounce_vel
  as dReal   soft_erp
  as dReal   soft_cfm
  as dReal   motion1
  as dReal   motion2
  as dReal   motionN
  as dReal   slip1
  as dReal   slip2
end type

/'*
 * Describe the contact point between two geoms.
 *
 * If two bodies touch, or if a body touches a static feature in its 
 * environment, the contact is represented by one or more "contact 
 * points", described by dContactGeom.
 *
 * The convention is that if body 1 is moved along the normal vector by 
 * a distance depth (or equivalently if body 2 is moved the same distance 
 * in the opposite direction) then the contact depth will be reduced to 
 * zero. This means that the normal vector points "in" to body 1. '/
type dContactGeom
  as dVector3 pos 
  as dVector3 normal
  as dReal    depth
  as dGeomID  g1
  as dGeomID  g2
  as integer  side1
  as integer  side2
end type

' contact info used by contact joint
type dContact
  as dSurfaceParameters surface
  as dContactGeom       geom
  as dVector3           fdir1
end type

#endif ' __ode_contact_bi__