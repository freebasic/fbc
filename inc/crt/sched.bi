'' FreeBASIC binding for glibc-2.21

#pragma once

#ifndef __FB_UNIX__
	#error "target not supported; this header is for GNU/Linux glibc"
#endif

#include once "crt/sys/types.bi"
#include once "crt/stddef.bi"
#include once "crt/time.bi"
#include once "crt/bits/sched.bi"

extern "C"

const _SCHED_H = 1
#define sched_priority __sched_priority
declare function sched_setparam(byval __pid as __pid_t, byval __param as const sched_param ptr) as long
declare function sched_getparam(byval __pid as __pid_t, byval __param as sched_param ptr) as long
declare function sched_setscheduler(byval __pid as __pid_t, byval __policy as long, byval __param as const sched_param ptr) as long
declare function sched_getscheduler(byval __pid as __pid_t) as long
declare function sched_yield() as long
declare function sched_get_priority_max(byval __algorithm as long) as long
declare function sched_get_priority_min(byval __algorithm as long) as long
declare function sched_rr_get_interval(byval __pid as __pid_t, byval __t as timespec ptr) as long

#define CPU_SETSIZE __CPU_SETSIZE
#define CPU_ALLOC_SIZE(count) __CPU_ALLOC_SIZE(count)
#define CPU_ALLOC(count) __CPU_ALLOC(count)
#define CPU_FREE(cpuset) __CPU_FREE(cpuset)

declare function sched_setaffinity(byval __pid as __pid_t, byval __cpusetsize as uinteger, byval __cpuset as const cpu_set_t ptr) as long
declare function sched_getaffinity(byval __pid as __pid_t, byval __cpusetsize as uinteger, byval __cpuset as cpu_set_t ptr) as long
declare function __sched_setparam(byval __pid as __pid_t, byval __param as const sched_param ptr) as long
declare function __sched_getparam(byval __pid as __pid_t, byval __param as sched_param ptr) as long
declare function __sched_setscheduler(byval __pid as __pid_t, byval __policy as long, byval __param as const sched_param ptr) as long
declare function __sched_getscheduler(byval __pid as __pid_t) as long
declare function __sched_yield() as long
declare function __sched_get_priority_max(byval __algorithm as long) as long
declare function __sched_get_priority_min(byval __algorithm as long) as long
declare function __sched_rr_get_interval(byval __pid as __pid_t, byval __t as timespec ptr) as long
declare function __clone(byval __fn as function(byval __arg as any ptr) as long, byval __child_stack as any ptr, byval __flags as long, byval __arg as any ptr, ...) as long
declare function __clone2(byval __fn as function(byval __arg as any ptr) as long, byval __child_stack_base as any ptr, byval __child_stack_size as uinteger, byval __flags as long, byval __arg as any ptr, ...) as long

end extern
