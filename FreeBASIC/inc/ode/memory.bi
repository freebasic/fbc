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
#ifndef __ode_memory_bi__
#define __ode_memory_bi__

#include "config.bi"

type dAllocFunction   as any
type dReallocFunction as any
type dFreeFunction    as any

declare sub      dSetAllocHandler   cdecl alias "dSetAllocHandler"   (byval fn as dAllocFunction ptr)
declare sub      dSetReallocHandler cdecl alias "dSetReallocHandler" (byval fn as dReallocFunction ptr)
declare sub      dSetFreeHandler    cdecl alias "dSetFreeHandler"    (byval fn as dFreeFunction ptr)
declare function dGetAllocHandler   cdecl alias "dGetAllocHandler"   () as dAllocFunction ptr
declare function dGetReallocHandler cdecl alias "dGetReallocHandler" () as dReallocFunction ptr
declare function dGetFreeHandler    cdecl alias "dGetFreeHandler"    () as dFreeFunction ptr
declare function dAlloc             cdecl alias "dAlloc"             (byval size as integer) as any ptr
declare function dRealloc           cdecl alias "dRealloc"           (byval p as any ptr, byval oldsize as integer, byval newsize as integer) as any ptr
declare sub      dFree              cdecl alias "dFree"              (byval p as any ptr, byval size as integer)

#endif
