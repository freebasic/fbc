'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#include once "dmdls.bi"

#define __WINE_DMUSIC_BUFFER_H
#define QWORD_ALIGN(x) (((x) + 7) and (not 7))
#define DMUS_EVENT_SIZE(cb) QWORD_ALIGN(sizeof(DMUS_EVENTHEADER) + cb)
const DMUS_EVENT_STRUCTURED = &h1
type DMUS_EVENTHEADER as _DMUS_EVENTHEADER
type LPDMUS_EVENTHEADER as _DMUS_EVENTHEADER ptr

type _DMUS_EVENTHEADER field = 4
	cbEvent as DWORD
	dwChannelGroup as DWORD
	rtDelta as REFERENCE_TIME
	dwFlags as DWORD
end type
