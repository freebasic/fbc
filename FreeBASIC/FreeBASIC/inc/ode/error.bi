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
#ifndef __ode_error_bi__
#define __ode_error_bi__

#include "config.bi"

/' all user defined error functions have this type. error and debug functions
 * should not return.
 '/
type dMessageFunction as sub cdecl (byval num as integer,msg as zstring ptr,va_list as any ptr)

declare sub      dSetErrorHandler   cdecl alias "dSetErrorHandler"   (byval fn as dMessageFunction ptr)
declare function dGetErrorHandler   cdecl alias "dGetErrorHandler"   () as dMessageFunction ptr

declare sub      dSetDebugHandler   cdecl alias "dSetDebugHandler"   (byval fn as dMessageFunction ptr)
declare function dGetDebugHandler   cdecl alias "dGetDebugHandler"   () as dMessageFunction ptr

declare sub      dSetMessageHandler cdecl alias "dSetMessageHandler" (byval fn as dMessageFunction ptr)
declare function dGetMessageHandler cdecl alias "dGetMessageHandler" () as dMessageFunction ptr

declare sub      dError             cdecl alias "dError"             (byval num as integer, byval msg as zstring ptr, ...)
declare sub      dDebug             cdecl alias "dDebug"             (byval num as integer, byval msg as zstring ptr, ...)
declare sub      dMessage           cdecl alias "dMessage"           (byval num as integer, byval msg as zstring ptr, ...)

#endif ' __ode_error_bi__
