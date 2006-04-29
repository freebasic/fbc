''
''
'' allegro\debug -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_debug_bi__
#define __allegro_debug_bi__

#include once "allegro/base.bi"

declare sub al_assert_ cdecl alias "al_assert" (byval file as zstring ptr, byval line as integer)
declare sub al_trace_ cdecl alias "al_trace" (byval msg as zstring ptr, ...)
declare sub register_assert_handler cdecl alias "register_assert_handler" (byval handler as function cdecl(byval as zstring ptr) as integer)
declare sub register_trace_handler cdecl alias "register_trace_handler" (byval handler as function cdecl(byval as zstring ptr) as integer)

#ifdef DEBUGMODE
#define AL_ASSERT(condition) if (condition) = 0 then al_assert_( __FILE__, __LINE__ )
#define AL_TRACE al_trace_
#else
#define AL_ASSERT(condition)
#define AL_TRACE
#endif

#endif
