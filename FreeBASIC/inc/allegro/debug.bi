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
'      Debug facilities.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'

#ifndef ALLEGRO_DEBUG_H
#define ALLEGRO_DEBUG_H

#include "allegro/base.bi"

declare sub al_assert cdecl alias "al_assert" ( byval file as zstring ptr, byval _line as integer )
declare sub al_trace cdecl alias "al_trace" ( byval msg as zstring ptr, ... )

declare sub register_assert_handler cdecl alias "register_assert_handler" ( byval handler as function(byval msg as byte ptr) as integer)
declare sub register_trace_handler cdecl alias "register_trace_handler" ( byval handler as function(byval msg as byte ptr) as integer)

#ifdef DEBUGMODE
	#define ASSERT(condition)	if 0 <> (condition) then al_assert(__FILE__, __LINE__)
	#define TRACE			al_trace
#else
	#define ASSERT(condition)	if 0 then : end if
	#define TRACE			if 0 then : end if
#endif

#endif
