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
#ifndef __ode_timer_bi__
#define __ode_timer_bi__

#include "config.bi"

type dStopwatch
 as double   time
 as uinteger cc(0 to 1)
end type

declare sub      dTimerStart          cdecl alias "dTimerStart"          (byval description as zstring ptr)
declare sub      dTimerNow            cdecl alias "dTimerNow"            (byval description as zstring ptr)
declare sub      dTimerReport         cdecl alias "dTimerReport"         (byval fout as FILE ptr, byval average as integer)
declare function dTimerTicksPerSecond cdecl alias "dTimerTicksPerSecond" () as double
declare function dTimerResolution     cdecl alias "dTimerResolution"     () as double
declare sub      dTimerEnd            cdecl alias "dTimerEnd"            ()

declare sub      dStopwatchStart      cdecl alias "dStopwatchStart"      (byval w as dStopwatch ptr)
declare sub      dStopwatchReset      cdecl alias "dStopwatchReset"      (byval w as dStopwatch ptr)
declare sub      dStopwatchStop       cdecl alias "dStopwatchStop"       (byval w as dStopwatch ptr)
declare function dStopwatchTime       cdecl alias "dStopwatchTime"       (byval w as dStopwatch ptr) as double

#endif ' __ode_timer_bi__
