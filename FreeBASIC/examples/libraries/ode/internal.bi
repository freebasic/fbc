/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001,2002 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://www.freebasic.eu     *
 *                                                                       *
 ************************************************************************'/
#ifndef __DS_INTERNAL_BI
#define __DS_INTERNAL_BI

#include "drawstuff.bi"
' supplied by platform specific code
declare sub dsPlatformSimLoop(w as integer, _
                              h as integer, _
                              f as dsFunctions ptr   , _
                              initial_pause as integer)


' used by platform specific code
declare sub dsStartGraphics  (w as integer, _
                              h as integer, _
                              f as  dsFunctions ptr)

declare sub dsDrawFrame      (w     as integer, _
                              h     as integer, _
                              f     as dsFunctions ptr, _
                              pause as integer)
declare sub dsStopGraphics    ()
declare sub dsMotion          (mode   as integer, _
                               deltax as integer, _
                               deltay as integer)

declare function dsGetShadows () as integer
declare sub      dsSetShadows (a as integer)

declare function dsGetTextures() as integer
declare sub      dsSetTextures(a as integer)

declare function dsGetFog     () as integer
declare sub      dsSetFog     (a as integer)
#endif ' __DS_INTERNAL_BI