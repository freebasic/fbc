''
''
'' sys\types
''
''
''
''
''
#ifndef __crt_sys_freebsd_types_bi__
#define __crt_sys_freebsd_types_bi__

type __clock_t as integer
type __time_t as integer

union __mstate_t
	as ubyte __mbstate8(0 to 127)
	as ulongint _mbstateL
end union

#endif
