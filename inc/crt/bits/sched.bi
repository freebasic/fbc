'' FreeBASIC binding for glibc-2.22
''
'' based on the C header files:
''   Definitions for POSIX 1003.1b-1993 (aka POSIX.4) scheduling interface.
''   Copyright (C) 1996-2015 Free Software Foundation, Inc.
''   This file is part of the GNU C Library.
''
''   The GNU C Library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   The GNU C Library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with the GNU C Library; if not, see
''   <http://www.gnu.org/licenses/>.  
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifndef __FB_UNIX__
	#error "target not supported; this header is for GNU/Linux glibc"
#endif

#include once "crt/long.bi"

extern "C"

const SCHED_OTHER = 0
const SCHED_FIFO = 1
const SCHED_RR = 2

type sched_param
	__sched_priority as long
end type

const __defined_schedparam = 1

type __sched_param
	__sched_priority as long
end type

#define __cpu_set_t_defined
const __CPU_SETSIZE = 1024
#define __NCPUBITS (8 * sizeof(__cpu_mask))
type __cpu_mask as culong
#define __CPUELT(cpu) ((cpu) / __NCPUBITS)
#define __CPUMASK(cpu) (cast(__cpu_mask, 1) shl ((cpu) mod __NCPUBITS))

type cpu_set_t
	__bits(0 to (1024 / (8 * sizeof(__cpu_mask))) - 1) as __cpu_mask
end type

#define __CPU_ALLOC_SIZE(count) (((((count) + __NCPUBITS) - 1) / __NCPUBITS) * sizeof(__cpu_mask))
#define __CPU_ALLOC(count) __sched_cpualloc(count)
#define __CPU_FREE(cpuset) __sched_cpufree(cpuset)

declare function __sched_cpucount(byval __setsize as uinteger, byval __setp as const cpu_set_t ptr) as long
declare function __sched_cpualloc(byval __count as uinteger) as cpu_set_t ptr
declare sub __sched_cpufree(byval __set as cpu_set_t ptr)

end extern
