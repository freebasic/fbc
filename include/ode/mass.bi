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
#ifndef __ode_mass_bi__
#define __ode_mass_bi__

#include "common.bi"

type dMass
  as dReal    mass
  as dVector4 c
  as dMatrix3 i
end type
declare sub dMassAdjust                 cdecl alias "dMassAdjust"            (byval m as dMass ptr, byval newmass as dReal)
declare sub dMassTranslate              cdecl alias "dMassTranslate"         (byval m as dMass ptr, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dMassRotate                 cdecl alias "dMassRotate"            (byval m as dMass ptr, byref R as dMatrix3)
declare sub dMassAdd                    cdecl alias "dMassAdd"               (byval a as dMass ptr, byval b as dMass ptr)

declare function dMassCheck             cdecl alias "dMassCheck"             (byval m as dMass ptr) as integer
declare sub      dMassSetZero           cdecl alias "dMassSetZero"           (byval as dMass ptr)
declare sub      dMassSetParameters     cdecl alias "dMassSetParameters"     ( _
  byval m   as dMass ptr, byval themass as dReal, _
  byval cgx as dReal, byval cgy as dReal, byval cgz as dReal, _
  byval I11 as dReal, byval I22 as dReal, byval I33 as dReal, _
  byval I12 as dReal, byval I13 as dReal, byval I23 as dReal)
declare sub dMassSetSphere              cdecl alias "dMassSetSphere"         (byval m as dMass ptr, byval density    as dReal, byval radius as dReal)
declare sub dMassSetSphereTotal         cdecl alias "dMassSetSphereTotal"    (byval m as dMass ptr, byval total_mass as dReal, byval radius as dReal)
declare sub dMassSetCappedCylinder      cdecl alias "dMassSetCappedCylinder" (byval m as dMass ptr, byval density    as dReal, byval direction as integer, byval radius as dReal, byval length as dReal)
declare sub dMassSetCapsule             cdecl alias "dMassSetCapsule"        (byval m as dMass ptr, byval density    as dReal, byval direction as integer, byval radius as dReal, byval length as dReal)
declare sub dMassSetCapsuleTotal        cdecl alias "dMassSetCapsuleTotal"   (byval m as dMass ptr, byval total_mass as dReal, byval direction as integer, byval radius as dReal, byval length as dReal)
declare sub dMassSetCappedCylinderTotal cdecl alias "dMassSetCappedCylinderTotal" ( _
byval m as dMass ptr, _
byval total_mass as dReal, _
byval direction as integer, _
byval radius as dReal, _
byval length as dReal)

declare sub dMassSetCylinder            cdecl alias "dMassSetCylinder"       ( _
byval m as dMass ptr, _
byval density as dReal, _
byval direction as integer, _
byval radius as dReal, _
byval length as dReal)
declare sub dMassSetCylinderTotal       cdecl alias "dMassSetCylinderTotal"  (byval m as dMass ptr, byval total_mass as dReal, byval direction as integer, byval radius as dReal, byval length as dReal)
declare sub dMassSetBox                 cdecl alias "dMassSetBox"            (byval m as dMass ptr, byval density as dReal, byval lx as dReal, byval ly as dReal, byval lz as dReal)
declare sub dMassSetBoxTotal            cdecl alias "dMassSetBoxTotal"       (byval m as dMass ptr, byval total_mass as dReal, byval lx as dReal, byval ly as dReal, byval lz as dReal)

#endif __ode_mass_bi__
