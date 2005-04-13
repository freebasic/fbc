'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      Base header, defines basic stuff needed by pretty much
'      everything else.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_BASE_H
#define ALLEGRO_BASE_H

#include "crt.bi"

''#include "allegro/internal/alconfig.bi"

#define ALLEGRO_VERSION          4
#define ALLEGRO_SUB_VERSION      0
#define ALLEGRO_WIP_VERSION      3
#define ALLEGRO_VERSION_STR      "4.0.3 (RC3)"
#define ALLEGRO_DATE_STR         "2003"
#define ALLEGRO_DATE             20030330    ' yyyymmdd

'*******************************************
'************ Some global stuff ************
'*******************************************

#ifndef TRUE 
   #define TRUE         -1
   #define FALSE        0
#endif

#define AL_MIN(x,y) iif( (x) <= (y), (x), (y) )
#define MIN(x,y) AL_MIN((x),(y))
#define AL_MAX(x,y) iif( (x) >= (y), (x), (y) )
#define MAX(x,y) AL_MAX((x),(y))
' AL_MID is the fb equivalent of Allegro's MID
#define AL_MID(x,y,z) AL_MAX(x, AL_MIN(y, z))

' ABS and SGN are not here because they are built-ins

#define AL_ID(a,b,c,d)		(((a) shl 24) or ((b) shl 16) or ((c) shl 8) or (d))

extern import allegro_errno alias "allegro_errno" as integer ptr

type _DRIVER_INFO		' info about a hardware driver
	id as integer		' integer ID
	driver as any ptr	' the driver structure
	autodetect as integer	' set to allow autodetection
end type

#endif
