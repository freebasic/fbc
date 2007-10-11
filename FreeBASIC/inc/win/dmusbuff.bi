''
''
'' dmusbuff -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dmusbuff_bi__
#define __win_dmusbuff_bi__

type DMUS_EVENTHEADER field=4
	cbEvent as DWORD
	dwChannelGroup as DWORD
	rtDelta as REFERENCE_TIME
	dwFlags as DWORD
end type

type LPDMUS_EVENTHEADER as DMUS_EVENTHEADER ptr

#define DMUS_EVENT_STRUCTURED &h00000001

#define QWORD_ALIGN(x) (((x) + 7) and not 7)
#define DMUS_EVENT_SIZE(cb) QWORD_ALIGN(sizeof(DMUS_EVENTHEADER) + cb)

#endif
