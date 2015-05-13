''
''
'' jit-walk -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_walk_bi__
#define __jit_walk_bi__

#include "jit/jit-arch.bi"

declare function _jit_get_frame_address cdecl alias "_jit_get_frame_address" (byval start as any ptr, byval n as uinteger) as any ptr

#define	jit_get_frame_address(n) (_jit_get_frame_address(jit_get_current_frame(), (n)))
#define	jit_get_current_frame() jit_get_frame_address(0)

declare function jit_get_next_frame_address cdecl alias "jit_get_next_frame_address" (byval frame as any ptr) as any ptr
declare function _jit_get_return_address cdecl alias "_jit_get_return_address" (byval frame as any ptr, byval frame0 as any ptr, byval return0 as any ptr) as any ptr

#define	jit_get_return_address(frame) (_jit_get_return_address((frame), 0, 0))

type jit_crawl_mark_t
	mark as any ptr
end type

#define jit_get_current_return() (jit_get_return_address(jit_get_current_frame()))
#define	jit_declare_crawl_mark(name) dim name as jit_crawl_mark_t = Type(0)

declare function jit_frame_contains_crawl_mark cdecl alias "jit_frame_contains_crawl_mark" (byval frame as any ptr, byval mark as jit_crawl_mark_t ptr) as integer

#endif
