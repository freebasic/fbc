'' FreeBASIC binding for SDL-1.2.15
''
'' based on the C header files:
''   SDL - Simple DirectMedia Layer
''   Copyright (C) 1997-2012 Sam Lantinga
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
''
''   Sam Lantinga
''   slouken@libsdl.org
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "SDL"

#ifdef __FB_WIN32__
	#inclib "gdi32"
	#inclib "user32"
	#inclib "winmm"
	#inclib "dxguid"
	#inclib "advapi32"
#endif

#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "crt/string.bi"
#include once "crt/ctype.bi"

#ifdef __FB_UNIX__
	#include once "crt/iconv.bi"
	#include once "X11/Xlib.bi"
	#include once "X11/Xatom.bi"
#else
	#include once "crt/stdarg.bi"
	#include once "windows.bi"
#endif

'' The following symbols have been renamed:
''     constant SDL_UNSUPPORTED => SDL_UNSUPPORTED_
''     constant SDL_QUIT => SDL_QUIT_
''     enum SDL_EventMask => SDL_EventMask_
''     #define SDL_VERSION => SDL_VERSION_

extern "C"

#define _SDL_H
#define _SDL_main_h
#define _SDL_stdinc_h
#define _SDL_config_h
#define _SDL_platform_h

#ifdef __FB_WIN32__
	#define _SDL_config_win32_h
#endif

type SDL_bool as long
enum
	SDL_FALSE = 0
	SDL_TRUE = 1
end enum

type Sint8 as byte
type Uint8 as ubyte
type Sint16 as short
type Uint16 as ushort
type Sint32 as long
type Uint32 as ulong
type Sint64 as longint
type Uint64 as ulongint

type SDL_DUMMY_ENUM as long
enum
	DUMMY_ENUM_VALUE
end enum

#define SDLCALL cdecl

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	#ifndef NULL
		const NULL = 0
	#endif
#endif

#define SDL_malloc malloc
#define SDL_calloc calloc
#define SDL_realloc realloc
#define SDL_free free
#define SDL_stack_alloc(type, count) cptr(type ptr, alloca(sizeof(type) * (count)))
#define SDL_stack_free(data)

#ifdef __FB_UNIX__
	#define SDL_getenv getenv
	#define SDL_putenv putenv
#else
	declare function SDL_getenv(byval name as const zstring ptr) as zstring ptr
	declare function SDL_putenv(byval variable as const zstring ptr) as long
#endif

#define SDL_qsort qsort
#define SDL_abs abs
#define SDL_min(x, y) iif((x) < (y), (x), (y))
#define SDL_max(x, y) iif((x) > (y), (x), (y))
#define SDL_isdigit(X) isdigit(X)
#define SDL_isspace(X) isspace(X)
#define SDL_toupper(X) toupper(X)
#define SDL_tolower(X) tolower(X)
#define SDL_memset memset
private sub SDL_memset4(byval dst as any ptr, byval value as ulong, byval length as uinteger)
	for i as integer = 0 to length - 1
		cast(ulong ptr, dst)[i] = value
	next
end sub
#define SDL_memcpy(dst, src, len) memcpy((dst), (src), (len))
#define SDL_memcpy4(dst, src, len) SDL_memcpy((dst), (src), (len) * 4)

#if defined(__FB_64BIT__) or ((not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))
	declare function SDL_revcpy(byval dst as any ptr, byval src as const any ptr, byval len as uinteger) as any ptr
#else
	private function SDL_revcpy(byval dst as any ptr, byval src as const any ptr, byval length as uinteger) as any ptr
		dim as const byte ptr s = src
		dim as byte ptr d = dst
		for i as integer = length - 1 to 0 step -1
			d[i] = s[i]
		next
		function = dst
	end function
#endif
#define SDL_memmove memmove
#define SDL_memcmp memcmp
#define SDL_strlen strlen
declare function SDL_strlcpy(byval dst as zstring ptr, byval src as const zstring ptr, byval maxlen as uinteger) as uinteger
declare function SDL_strlcat(byval dst as zstring ptr, byval src as const zstring ptr, byval maxlen as uinteger) as uinteger

#ifdef __FB_UNIX__
	#define SDL_strdup strdup
	declare function SDL_strrev(byval string as zstring ptr) as zstring ptr
	declare function SDL_strupr(byval string as zstring ptr) as zstring ptr
	declare function SDL_strlwr(byval string as zstring ptr) as zstring ptr
#else
	declare function SDL_strdup(byval string as const zstring ptr) as zstring ptr
	#define SDL_strrev _strrev
	#define SDL_strupr _strupr
	#define SDL_strlwr _strlwr
#endif

#define SDL_strchr strchr
#define SDL_strrchr strrchr
#define SDL_strstr strstr

#ifdef __FB_UNIX__
	#define SDL_itoa(value, string, radix) SDL_ltoa(cast(clong, value), string, radix)
	declare function SDL_ltoa(byval value as clong, byval string as zstring ptr, byval radix as long) as zstring ptr
#else
	#define SDL_itoa itoa
	#define SDL_ltoa _ltoa
#endif

#define SDL_uitoa(value, string, radix) SDL_ultoa(cast(clong, value), string, radix)

#ifdef __FB_UNIX__
	declare function SDL_ultoa(byval value as culong, byval string as zstring ptr, byval radix as long) as zstring ptr
#else
	#define SDL_ultoa _ultoa
#endif

#define SDL_strtol strtol
#define SDL_strtoul strtoul
declare function SDL_lltoa(byval value as Sint64, byval string as zstring ptr, byval radix as long) as zstring ptr
declare function SDL_ulltoa(byval value as Uint64, byval string as zstring ptr, byval radix as long) as zstring ptr
#define SDL_strtoll strtoll

#ifdef __FB_UNIX__
	#define SDL_strtoull strtoull
#else
	declare function SDL_strtoull(byval string as const zstring ptr, byval endp as zstring ptr ptr, byval base as long) as Uint64
#endif

#define SDL_strtod strtod
#define SDL_atoi atoi
#define SDL_atof atof
#define SDL_strcmp strcmp
#define SDL_strncmp strncmp

#ifdef __FB_UNIX__
	#define SDL_strcasecmp strcasecmp
	#define SDL_strncasecmp strncasecmp
#else
	#define SDL_strcasecmp _stricmp
	#define SDL_strncasecmp _strnicmp
#endif

#define SDL_sscanf sscanf

#ifdef __FB_UNIX__
	#define SDL_snprintf snprintf
	#define SDL_vsnprintf vsnprintf
#else
	declare function SDL_snprintf(byval text as zstring ptr, byval maxlen as uinteger, byval fmt as const zstring ptr, ...) as long
	declare function SDL_vsnprintf(byval text as zstring ptr, byval maxlen as uinteger, byval fmt as const zstring ptr, byval ap as va_list) as long
#endif

const SDL_ICONV_ERROR = cuint(-1)
const SDL_ICONV_E2BIG = cuint(-2)
const SDL_ICONV_EILSEQ = cuint(-3)
const SDL_ICONV_EINVAL = cuint(-4)

#ifdef __FB_UNIX__
	#define SDL_iconv_t iconv_t
	#define SDL_iconv_open iconv_open
	#define SDL_iconv_close iconv_close
	declare function SDL_iconv(byval cd as iconv_t, byval inbuf as const zstring ptr ptr, byval inbytesleft as uinteger ptr, byval outbuf as zstring ptr ptr, byval outbytesleft as uinteger ptr) as uinteger
#else
	type SDL_iconv_t as _SDL_iconv_t ptr
	declare function SDL_iconv_open(byval tocode as const zstring ptr, byval fromcode as const zstring ptr) as SDL_iconv_t
	declare function SDL_iconv_close(byval cd as SDL_iconv_t) as long
	declare function SDL_iconv(byval cd as SDL_iconv_t, byval inbuf as const zstring ptr ptr, byval inbytesleft as uinteger ptr, byval outbuf as zstring ptr ptr, byval outbytesleft as uinteger ptr) as uinteger
#endif

declare function SDL_iconv_string(byval tocode as const zstring ptr, byval fromcode as const zstring ptr, byval inbuf as const zstring ptr, byval inbytesleft as uinteger) as zstring ptr
#define SDL_iconv_utf8_locale(S) SDL_iconv_string("", "UTF-8", S, SDL_strlen(S) + 1)
#define SDL_iconv_utf8_ucs2(S) cptr(Uint16 ptr, SDL_iconv_string("UCS-2", "UTF-8", S, SDL_strlen(S) + 1))
#define SDL_iconv_utf8_ucs4(S) cptr(Uint32 ptr, SDL_iconv_string("UCS-4", "UTF-8", S, SDL_strlen(S) + 1))

#if defined(__FB_DARWIN__) or defined(__FB_WIN32__)
	declare function SDL_main(byval argc as long, byval argv as zstring ptr ptr) as long
#endif

#ifdef __FB_WIN32__
	declare sub SDL_SetModuleHandle(byval hInst as any ptr)
	declare function SDL_RegisterApp(byval name as zstring ptr, byval style as Uint32, byval hInst as any ptr) as long
	declare sub SDL_UnregisterApp()
#endif

#define _SDL_audio_h
#define _SDL_error_h
declare sub SDL_SetError(byval fmt as const zstring ptr, ...)
declare function SDL_GetError() as zstring ptr
declare sub SDL_ClearError()
#define SDL_OutOfMemory() SDL_Error(SDL_ENOMEM)
#define SDL_Unsupported() SDL_Error(SDL_UNSUPPORTED_)

type SDL_errorcode as long
enum
	SDL_ENOMEM
	SDL_EFREAD
	SDL_EFWRITE
	SDL_EFSEEK
	SDL_UNSUPPORTED_
	SDL_LASTERROR
end enum

declare sub SDL_Error(byval code as SDL_errorcode)
#define _SDL_endian_h
const SDL_LIL_ENDIAN = 1234

#ifdef __FB_WIN32__
	const SDL_BIG_ENDIAN = 4321
#endif

const SDL_BYTEORDER = SDL_LIL_ENDIAN

#ifdef __FB_UNIX__
	const SDL_BIG_ENDIAN = 4321
#endif

#define SDL_Swap16(x) cushort((cushort(x) shl 8) or (cushort(x) shr 8))
#define SDL_Swap32(x) _
	culng((culng(x) shl 24) or _
	      ((culng(x) shl 8) and &h00FF0000) or _
	      ((culng(x) shr 8) and &h0000FF00) or _
	      (culng(x) shr 24))
#define SDL_Swap64(x) _
	culngint((SDL_Swap32(culngint(x) and &hFFFFFFFF) shl 32) or _
	         SDL_Swap32(culngint(x) shr 32))
#define SDL_SwapLE16(X) (X)
#define SDL_SwapLE32(X) (X)
#define SDL_SwapLE64(X) (X)
#define SDL_SwapBE16(X) SDL_Swap16(X)
#define SDL_SwapBE32(X) SDL_Swap32(X)
#define SDL_SwapBE64(X) SDL_Swap64(X)
#define _SDL_mutex_h
const SDL_MUTEX_TIMEDOUT = 1
const SDL_MUTEX_MAXWAIT = not cast(Uint32, 0)
type SDL_mutex as SDL_mutex_
declare function SDL_CreateMutex() as SDL_mutex ptr
#define SDL_LockMutex(m) SDL_mutexP(m)
declare function SDL_mutexP(byval mutex as SDL_mutex ptr) as long
#define SDL_UnlockMutex(m) SDL_mutexV(m)
declare function SDL_mutexV(byval mutex as SDL_mutex ptr) as long
declare sub SDL_DestroyMutex(byval mutex as SDL_mutex ptr)
type SDL_sem as SDL_semaphore
declare function SDL_CreateSemaphore(byval initial_value as Uint32) as SDL_sem ptr
declare sub SDL_DestroySemaphore(byval sem as SDL_sem ptr)
declare function SDL_SemWait(byval sem as SDL_sem ptr) as long
declare function SDL_SemTryWait(byval sem as SDL_sem ptr) as long
declare function SDL_SemWaitTimeout(byval sem as SDL_sem ptr, byval ms as Uint32) as long
declare function SDL_SemPost(byval sem as SDL_sem ptr) as long
declare function SDL_SemValue(byval sem as SDL_sem ptr) as Uint32
type SDL_cond as SDL_cond_
declare function SDL_CreateCond() as SDL_cond ptr
declare sub SDL_DestroyCond(byval cond as SDL_cond ptr)
declare function SDL_CondSignal(byval cond as SDL_cond ptr) as long
declare function SDL_CondBroadcast(byval cond as SDL_cond ptr) as long
declare function SDL_CondWait(byval cond as SDL_cond ptr, byval mut as SDL_mutex ptr) as long
declare function SDL_CondWaitTimeout(byval cond as SDL_cond ptr, byval mutex as SDL_mutex ptr, byval ms as Uint32) as long
#define _SDL_thread_h
type SDL_Thread as SDL_Thread_
declare function SDL_CreateThread(byval fn as function(byval as any ptr) as long, byval data as any ptr) as SDL_Thread ptr
declare function SDL_ThreadID() as Uint32
declare function SDL_GetThreadID(byval thread as SDL_Thread ptr) as Uint32
declare sub SDL_WaitThread(byval thread as SDL_Thread ptr, byval status as long ptr)
declare sub SDL_KillThread(byval thread as SDL_Thread ptr)
#define _SDL_rwops_h

#ifdef __FB_WIN32__
	type SDL_RWops_hidden_win32io_buffer
		data as any ptr
		size as long
		left as long
	end type

	type SDL_RWops_hidden_win32io
		append as long
		h as any ptr
		buffer as SDL_RWops_hidden_win32io_buffer
	end type
#endif

type SDL_RWops_hidden_stdio
	autoclose as long
	fp as FILE ptr
end type

type SDL_RWops_hidden_mem
	base as Uint8 ptr
	here as Uint8 ptr
	stop as Uint8 ptr
end type

type SDL_RWops_hidden_unknown
	data1 as any ptr
end type

union SDL_RWops_hidden
	#ifdef __FB_WIN32__
		win32io as SDL_RWops_hidden_win32io
	#endif

	stdio as SDL_RWops_hidden_stdio
	mem as SDL_RWops_hidden_mem
	unknown as SDL_RWops_hidden_unknown
end union

type SDL_RWops
	seek as function(byval context as SDL_RWops ptr, byval offset as long, byval whence as long) as long
	read as function(byval context as SDL_RWops ptr, byval ptr as any ptr, byval size as long, byval maxnum as long) as long
	write as function(byval context as SDL_RWops ptr, byval ptr as const any ptr, byval size as long, byval num as long) as long
	close as function(byval context as SDL_RWops ptr) as long
	as Uint32 type
	hidden as SDL_RWops_hidden
end type

declare function SDL_RWFromFile(byval file as const zstring ptr, byval mode as const zstring ptr) as SDL_RWops ptr
declare function SDL_RWFromFP(byval fp as FILE ptr, byval autoclose as long) as SDL_RWops ptr
declare function SDL_RWFromMem(byval mem as any ptr, byval size as long) as SDL_RWops ptr
declare function SDL_RWFromConstMem(byval mem as const any ptr, byval size as long) as SDL_RWops ptr
declare function SDL_AllocRW() as SDL_RWops ptr
declare sub SDL_FreeRW(byval area as SDL_RWops ptr)

const RW_SEEK_SET = 0
const RW_SEEK_CUR = 1
const RW_SEEK_END = 2
#define SDL_RWseek(ctx, offset, whence) (ctx)->seek(ctx, offset, whence)
#define SDL_RWtell(ctx) (ctx)->seek(ctx, 0, RW_SEEK_CUR)
#define SDL_RWread(ctx, ptr, size, n) (ctx)->read(ctx, ptr, size, n)
#define SDL_RWwrite(ctx, ptr, size, n) (ctx)->write(ctx, ptr, size, n)
#define SDL_RWclose(ctx) (ctx)->close(ctx)

declare function SDL_ReadLE16(byval src as SDL_RWops ptr) as Uint16
declare function SDL_ReadBE16(byval src as SDL_RWops ptr) as Uint16
declare function SDL_ReadLE32(byval src as SDL_RWops ptr) as Uint32
declare function SDL_ReadBE32(byval src as SDL_RWops ptr) as Uint32
declare function SDL_ReadLE64(byval src as SDL_RWops ptr) as Uint64
declare function SDL_ReadBE64(byval src as SDL_RWops ptr) as Uint64
declare function SDL_WriteLE16(byval dst as SDL_RWops ptr, byval value as Uint16) as long
declare function SDL_WriteBE16(byval dst as SDL_RWops ptr, byval value as Uint16) as long
declare function SDL_WriteLE32(byval dst as SDL_RWops ptr, byval value as Uint32) as long
declare function SDL_WriteBE32(byval dst as SDL_RWops ptr, byval value as Uint32) as long
declare function SDL_WriteLE64(byval dst as SDL_RWops ptr, byval value as Uint64) as long
declare function SDL_WriteBE64(byval dst as SDL_RWops ptr, byval value as Uint64) as long

type SDL_AudioSpec
	freq as long
	format as Uint16
	channels as Uint8
	silence as Uint8
	samples as Uint16
	padding as Uint16
	size as Uint32
	callback as sub(byval userdata as any ptr, byval stream as Uint8 ptr, byval len as long)
	userdata as any ptr
end type

const AUDIO_U8 = &h0008
const AUDIO_S8 = &h8008
const AUDIO_U16LSB = &h0010
const AUDIO_S16LSB = &h8010
const AUDIO_U16MSB = &h1010
const AUDIO_S16MSB = &h9010
const AUDIO_U16 = AUDIO_U16LSB
const AUDIO_S16 = AUDIO_S16LSB
const AUDIO_U16SYS = AUDIO_U16LSB
const AUDIO_S16SYS = AUDIO_S16LSB

type SDL_AudioCVT
	needed as long
	src_format as Uint16
	dst_format as Uint16
	rate_incr as double
	buf as Uint8 ptr
	len as long
	len_cvt as long
	len_mult as long
	len_ratio as double
	filters(0 to 9) as sub(byval cvt as SDL_AudioCVT ptr, byval format as Uint16)
	filter_index as long
end type

declare function SDL_AudioInit(byval driver_name as const zstring ptr) as long
declare sub SDL_AudioQuit()
declare function SDL_AudioDriverName(byval namebuf as zstring ptr, byval maxlen as long) as zstring ptr
declare function SDL_OpenAudio(byval desired as SDL_AudioSpec ptr, byval obtained as SDL_AudioSpec ptr) as long

type SDL_audiostatus as long
enum
	SDL_AUDIO_STOPPED = 0
	SDL_AUDIO_PLAYING
	SDL_AUDIO_PAUSED
end enum

declare function SDL_GetAudioStatus() as SDL_audiostatus
declare sub SDL_PauseAudio(byval pause_on as long)
declare function SDL_LoadWAV_RW(byval src as SDL_RWops ptr, byval freesrc as long, byval spec as SDL_AudioSpec ptr, byval audio_buf as Uint8 ptr ptr, byval audio_len as Uint32 ptr) as SDL_AudioSpec ptr
#define SDL_LoadWAV(file, spec, audio_buf, audio_len) SDL_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1, spec, audio_buf, audio_len)
declare sub SDL_FreeWAV(byval audio_buf as Uint8 ptr)
declare function SDL_BuildAudioCVT(byval cvt as SDL_AudioCVT ptr, byval src_format as Uint16, byval src_channels as Uint8, byval src_rate as long, byval dst_format as Uint16, byval dst_channels as Uint8, byval dst_rate as long) as long
declare function SDL_ConvertAudio(byval cvt as SDL_AudioCVT ptr) as long
const SDL_MIX_MAXVOLUME = 128
declare sub SDL_MixAudio(byval dst as Uint8 ptr, byval src as const Uint8 ptr, byval len as Uint32, byval volume as long)
declare sub SDL_LockAudio()
declare sub SDL_UnlockAudio()
declare sub SDL_CloseAudio()

#define _SDL_cdrom_h
const SDL_MAX_TRACKS = 99
const SDL_AUDIO_TRACK = &h00
const SDL_DATA_TRACK = &h04

type CDstatus as long
enum
	CD_TRAYEMPTY
	CD_STOPPED
	CD_PLAYING
	CD_PAUSED
	CD_ERROR = -1
end enum

#define CD_INDRIVE(status) (clng(status) > 0)

type SDL_CDtrack
	id as Uint8
	as Uint8 type
	unused as Uint16
	length as Uint32
	offset as Uint32
end type

type SDL_CD
	id as long
	status as CDstatus
	numtracks as long
	cur_track as long
	cur_frame as long
	track(0 to (99 + 1) - 1) as SDL_CDtrack
end type

const CD_FPS = 75
#macro FRAMES_TO_MSF(f_, M, S, F)
	scope
		dim value as long = f_
		(*(F)) = value mod CD_FPS
		value /= CD_FPS
		(*(S)) = value mod 60
		value /= 60
		(*(M)) = value
	end scope
#endmacro
#define MSF_TO_FRAMES(M, S, F) (((((M) * 60) * CD_FPS) + ((S) * CD_FPS)) + (F))

declare function SDL_CDNumDrives() as long
declare function SDL_CDName(byval drive as long) as const zstring ptr
declare function SDL_CDOpen(byval drive as long) as SDL_CD ptr
declare function SDL_CDStatus(byval cdrom as SDL_CD ptr) as CDstatus
declare function SDL_CDPlayTracks(byval cdrom as SDL_CD ptr, byval start_track as long, byval start_frame as long, byval ntracks as long, byval nframes as long) as long
declare function SDL_CDPlay(byval cdrom as SDL_CD ptr, byval start as long, byval length as long) as long
declare function SDL_CDPause(byval cdrom as SDL_CD ptr) as long
declare function SDL_CDResume(byval cdrom as SDL_CD ptr) as long
declare function SDL_CDStop(byval cdrom as SDL_CD ptr) as long
declare function SDL_CDEject(byval cdrom as SDL_CD ptr) as long
declare sub SDL_CDClose(byval cdrom as SDL_CD ptr)
#define _SDL_cpuinfo_h
declare function SDL_HasRDTSC() as SDL_bool
declare function SDL_HasMMX() as SDL_bool
declare function SDL_HasMMXExt() as SDL_bool
declare function SDL_Has3DNow() as SDL_bool
declare function SDL_Has3DNowExt() as SDL_bool
declare function SDL_HasSSE() as SDL_bool
declare function SDL_HasSSE2() as SDL_bool
declare function SDL_HasAltiVec() as SDL_bool

#define _SDL_events_h
#define _SDL_active_h
const SDL_APPMOUSEFOCUS = &h01
const SDL_APPINPUTFOCUS = &h02
const SDL_APPACTIVE = &h04
declare function SDL_GetAppState() as Uint8
#define _SDL_keyboard_h
#define _SDL_keysym_h

type SDLKey as long
enum
	SDLK_UNKNOWN = 0
	SDLK_FIRST = 0
	SDLK_BACKSPACE = 8
	SDLK_TAB = 9
	SDLK_CLEAR = 12
	SDLK_RETURN = 13
	SDLK_PAUSE = 19
	SDLK_ESCAPE = 27
	SDLK_SPACE = 32
	SDLK_EXCLAIM = 33
	SDLK_QUOTEDBL = 34
	SDLK_HASH = 35
	SDLK_DOLLAR = 36
	SDLK_AMPERSAND = 38
	SDLK_QUOTE = 39
	SDLK_LEFTPAREN = 40
	SDLK_RIGHTPAREN = 41
	SDLK_ASTERISK = 42
	SDLK_PLUS = 43
	SDLK_COMMA = 44
	SDLK_MINUS = 45
	SDLK_PERIOD = 46
	SDLK_SLASH = 47
	SDLK_0 = 48
	SDLK_1 = 49
	SDLK_2 = 50
	SDLK_3 = 51
	SDLK_4 = 52
	SDLK_5 = 53
	SDLK_6 = 54
	SDLK_7 = 55
	SDLK_8 = 56
	SDLK_9 = 57
	SDLK_COLON = 58
	SDLK_SEMICOLON = 59
	SDLK_LESS = 60
	SDLK_EQUALS = 61
	SDLK_GREATER = 62
	SDLK_QUESTION = 63
	SDLK_AT = 64
	SDLK_LEFTBRACKET = 91
	SDLK_BACKSLASH = 92
	SDLK_RIGHTBRACKET = 93
	SDLK_CARET = 94
	SDLK_UNDERSCORE = 95
	SDLK_BACKQUOTE = 96
	SDLK_a = 97
	SDLK_b = 98
	SDLK_c = 99
	SDLK_d = 100
	SDLK_e = 101
	SDLK_f = 102
	SDLK_g = 103
	SDLK_h = 104
	SDLK_i = 105
	SDLK_j = 106
	SDLK_k = 107
	SDLK_l = 108
	SDLK_m = 109
	SDLK_n = 110
	SDLK_o = 111
	SDLK_p = 112
	SDLK_q = 113
	SDLK_r = 114
	SDLK_s = 115
	SDLK_t = 116
	SDLK_u = 117
	SDLK_v = 118
	SDLK_w = 119
	SDLK_x = 120
	SDLK_y = 121
	SDLK_z = 122
	SDLK_DELETE = 127
	SDLK_WORLD_0 = 160
	SDLK_WORLD_1 = 161
	SDLK_WORLD_2 = 162
	SDLK_WORLD_3 = 163
	SDLK_WORLD_4 = 164
	SDLK_WORLD_5 = 165
	SDLK_WORLD_6 = 166
	SDLK_WORLD_7 = 167
	SDLK_WORLD_8 = 168
	SDLK_WORLD_9 = 169
	SDLK_WORLD_10 = 170
	SDLK_WORLD_11 = 171
	SDLK_WORLD_12 = 172
	SDLK_WORLD_13 = 173
	SDLK_WORLD_14 = 174
	SDLK_WORLD_15 = 175
	SDLK_WORLD_16 = 176
	SDLK_WORLD_17 = 177
	SDLK_WORLD_18 = 178
	SDLK_WORLD_19 = 179
	SDLK_WORLD_20 = 180
	SDLK_WORLD_21 = 181
	SDLK_WORLD_22 = 182
	SDLK_WORLD_23 = 183
	SDLK_WORLD_24 = 184
	SDLK_WORLD_25 = 185
	SDLK_WORLD_26 = 186
	SDLK_WORLD_27 = 187
	SDLK_WORLD_28 = 188
	SDLK_WORLD_29 = 189
	SDLK_WORLD_30 = 190
	SDLK_WORLD_31 = 191
	SDLK_WORLD_32 = 192
	SDLK_WORLD_33 = 193
	SDLK_WORLD_34 = 194
	SDLK_WORLD_35 = 195
	SDLK_WORLD_36 = 196
	SDLK_WORLD_37 = 197
	SDLK_WORLD_38 = 198
	SDLK_WORLD_39 = 199
	SDLK_WORLD_40 = 200
	SDLK_WORLD_41 = 201
	SDLK_WORLD_42 = 202
	SDLK_WORLD_43 = 203
	SDLK_WORLD_44 = 204
	SDLK_WORLD_45 = 205
	SDLK_WORLD_46 = 206
	SDLK_WORLD_47 = 207
	SDLK_WORLD_48 = 208
	SDLK_WORLD_49 = 209
	SDLK_WORLD_50 = 210
	SDLK_WORLD_51 = 211
	SDLK_WORLD_52 = 212
	SDLK_WORLD_53 = 213
	SDLK_WORLD_54 = 214
	SDLK_WORLD_55 = 215
	SDLK_WORLD_56 = 216
	SDLK_WORLD_57 = 217
	SDLK_WORLD_58 = 218
	SDLK_WORLD_59 = 219
	SDLK_WORLD_60 = 220
	SDLK_WORLD_61 = 221
	SDLK_WORLD_62 = 222
	SDLK_WORLD_63 = 223
	SDLK_WORLD_64 = 224
	SDLK_WORLD_65 = 225
	SDLK_WORLD_66 = 226
	SDLK_WORLD_67 = 227
	SDLK_WORLD_68 = 228
	SDLK_WORLD_69 = 229
	SDLK_WORLD_70 = 230
	SDLK_WORLD_71 = 231
	SDLK_WORLD_72 = 232
	SDLK_WORLD_73 = 233
	SDLK_WORLD_74 = 234
	SDLK_WORLD_75 = 235
	SDLK_WORLD_76 = 236
	SDLK_WORLD_77 = 237
	SDLK_WORLD_78 = 238
	SDLK_WORLD_79 = 239
	SDLK_WORLD_80 = 240
	SDLK_WORLD_81 = 241
	SDLK_WORLD_82 = 242
	SDLK_WORLD_83 = 243
	SDLK_WORLD_84 = 244
	SDLK_WORLD_85 = 245
	SDLK_WORLD_86 = 246
	SDLK_WORLD_87 = 247
	SDLK_WORLD_88 = 248
	SDLK_WORLD_89 = 249
	SDLK_WORLD_90 = 250
	SDLK_WORLD_91 = 251
	SDLK_WORLD_92 = 252
	SDLK_WORLD_93 = 253
	SDLK_WORLD_94 = 254
	SDLK_WORLD_95 = 255
	SDLK_KP0 = 256
	SDLK_KP1 = 257
	SDLK_KP2 = 258
	SDLK_KP3 = 259
	SDLK_KP4 = 260
	SDLK_KP5 = 261
	SDLK_KP6 = 262
	SDLK_KP7 = 263
	SDLK_KP8 = 264
	SDLK_KP9 = 265
	SDLK_KP_PERIOD = 266
	SDLK_KP_DIVIDE = 267
	SDLK_KP_MULTIPLY = 268
	SDLK_KP_MINUS = 269
	SDLK_KP_PLUS = 270
	SDLK_KP_ENTER = 271
	SDLK_KP_EQUALS = 272
	SDLK_UP = 273
	SDLK_DOWN = 274
	SDLK_RIGHT = 275
	SDLK_LEFT = 276
	SDLK_INSERT = 277
	SDLK_HOME = 278
	SDLK_END = 279
	SDLK_PAGEUP = 280
	SDLK_PAGEDOWN = 281
	SDLK_F1 = 282
	SDLK_F2 = 283
	SDLK_F3 = 284
	SDLK_F4 = 285
	SDLK_F5 = 286
	SDLK_F6 = 287
	SDLK_F7 = 288
	SDLK_F8 = 289
	SDLK_F9 = 290
	SDLK_F10 = 291
	SDLK_F11 = 292
	SDLK_F12 = 293
	SDLK_F13 = 294
	SDLK_F14 = 295
	SDLK_F15 = 296
	SDLK_NUMLOCK = 300
	SDLK_CAPSLOCK = 301
	SDLK_SCROLLOCK = 302
	SDLK_RSHIFT = 303
	SDLK_LSHIFT = 304
	SDLK_RCTRL = 305
	SDLK_LCTRL = 306
	SDLK_RALT = 307
	SDLK_LALT = 308
	SDLK_RMETA = 309
	SDLK_LMETA = 310
	SDLK_LSUPER = 311
	SDLK_RSUPER = 312
	SDLK_MODE = 313
	SDLK_COMPOSE = 314
	SDLK_HELP = 315
	SDLK_PRINT = 316
	SDLK_SYSREQ = 317
	SDLK_BREAK = 318
	SDLK_MENU = 319
	SDLK_POWER = 320
	SDLK_EURO = 321
	SDLK_UNDO = 322
	SDLK_LAST
end enum

type SDLMod as long
enum
	KMOD_NONE = &h0000
	KMOD_LSHIFT = &h0001
	KMOD_RSHIFT = &h0002
	KMOD_LCTRL = &h0040
	KMOD_RCTRL = &h0080
	KMOD_LALT = &h0100
	KMOD_RALT = &h0200
	KMOD_LMETA = &h0400
	KMOD_RMETA = &h0800
	KMOD_NUM = &h1000
	KMOD_CAPS = &h2000
	KMOD_MODE = &h4000
	KMOD_RESERVED = &h8000
end enum

const KMOD_CTRL = KMOD_LCTRL or KMOD_RCTRL
const KMOD_SHIFT = KMOD_LSHIFT or KMOD_RSHIFT
const KMOD_ALT = KMOD_LALT or KMOD_RALT
const KMOD_META = KMOD_LMETA or KMOD_RMETA

type SDL_keysym
	scancode as Uint8
	sym as SDLKey
	mod_ as SDLMod
	unicode_ as Uint16
end type

const SDL_ALL_HOTKEYS = &hFFFFFFFF
declare function SDL_EnableUNICODE(byval enable as long) as long
const SDL_DEFAULT_REPEAT_DELAY = 500
const SDL_DEFAULT_REPEAT_INTERVAL = 30
declare function SDL_EnableKeyRepeat(byval delay as long, byval interval as long) as long
declare sub SDL_GetKeyRepeat(byval delay as long ptr, byval interval as long ptr)
declare function SDL_GetKeyState(byval numkeys as long ptr) as Uint8 ptr
declare function SDL_GetModState() as SDLMod
declare sub SDL_SetModState(byval modstate as SDLMod)
declare function SDL_GetKeyName(byval key as SDLKey) as zstring ptr

#define _SDL_mouse_h
#define _SDL_video_h
const SDL_ALPHA_OPAQUE = 255
const SDL_ALPHA_TRANSPARENT = 0

type SDL_Rect
	x as Sint16
	y as Sint16
	w as Uint16
	h as Uint16
end type

type SDL_Color
	r as Uint8
	g as Uint8
	b as Uint8
	unused as Uint8
end type

type SDL_Colour as SDL_Color

type SDL_Palette
	ncolors as long
	colors as SDL_Color ptr
end type

type SDL_PixelFormat
	palette as SDL_Palette ptr
	BitsPerPixel as Uint8
	BytesPerPixel as Uint8
	Rloss as Uint8
	Gloss as Uint8
	Bloss as Uint8
	Aloss as Uint8
	Rshift as Uint8
	Gshift as Uint8
	Bshift as Uint8
	Ashift as Uint8
	Rmask as Uint32
	Gmask as Uint32
	Bmask as Uint32
	Amask as Uint32
	colorkey as Uint32
	alpha as Uint8
end type

type private_hwdata as private_hwdata_
type SDL_BlitMap as SDL_BlitMap_

type SDL_Surface
	flags as Uint32
	format as SDL_PixelFormat ptr
	w as long
	h as long
	pitch as Uint16
	pixels as any ptr
	offset as long
	hwdata as private_hwdata ptr
	clip_rect as SDL_Rect
	unused1 as Uint32
	locked as Uint32
	map as SDL_BlitMap ptr
	format_version as ulong
	refcount as long
end type

const SDL_SWSURFACE = &h00000000
const SDL_HWSURFACE = &h00000001
const SDL_ASYNCBLIT = &h00000004
const SDL_ANYFORMAT = &h10000000
const SDL_HWPALETTE = &h20000000
const SDL_DOUBLEBUF = &h40000000
const SDL_FULLSCREEN = &h80000000
const SDL_OPENGL = &h00000002
const SDL_OPENGLBLIT = &h0000000A
const SDL_RESIZABLE = &h00000010
const SDL_NOFRAME = &h00000020
const SDL_HWACCEL = &h00000100
const SDL_SRCCOLORKEY = &h00001000
const SDL_RLEACCELOK = &h00002000
const SDL_RLEACCEL = &h00004000
const SDL_SRCALPHA = &h00010000
const SDL_PREALLOC = &h01000000
#define SDL_MUSTLOCK(surface) (surface->offset orelse ((surface->flags and ((SDL_HWSURFACE or SDL_ASYNCBLIT) or SDL_RLEACCEL)) <> 0))
type SDL_blit as function(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long

type SDL_VideoInfo
	hw_available : 1 as Uint32
	wm_available : 1 as Uint32
	UnusedBits1 : 6 as Uint32
	UnusedBits2 : 1 as Uint32
	blit_hw : 1 as Uint32
	blit_hw_CC : 1 as Uint32
	blit_hw_A : 1 as Uint32
	blit_sw : 1 as Uint32
	blit_sw_CC : 1 as Uint32
	blit_sw_A : 1 as Uint32
	blit_fill : 1 as Uint32
	UnusedBits3 : 16 as Uint32
	video_mem as Uint32
	vfmt as SDL_PixelFormat ptr
	current_w as long
	current_h as long
end type

const SDL_YV12_OVERLAY = &h32315659
const SDL_IYUV_OVERLAY = &h56555949
const SDL_YUY2_OVERLAY = &h32595559
const SDL_UYVY_OVERLAY = &h59565955
const SDL_YVYU_OVERLAY = &h55595659
type private_yuvhwfuncs as private_yuvhwfuncs_
type private_yuvhwdata as private_yuvhwdata_

type SDL_Overlay
	format as Uint32
	w as long
	h as long
	planes as long
	pitches as Uint16 ptr
	pixels as Uint8 ptr ptr
	hwfuncs as private_yuvhwfuncs ptr
	hwdata as private_yuvhwdata ptr
	hw_overlay : 1 as Uint32
	UnusedBits : 31 as Uint32
end type

type SDL_GLattr as long
enum
	SDL_GL_RED_SIZE
	SDL_GL_GREEN_SIZE
	SDL_GL_BLUE_SIZE
	SDL_GL_ALPHA_SIZE
	SDL_GL_BUFFER_SIZE
	SDL_GL_DOUBLEBUFFER
	SDL_GL_DEPTH_SIZE
	SDL_GL_STENCIL_SIZE
	SDL_GL_ACCUM_RED_SIZE
	SDL_GL_ACCUM_GREEN_SIZE
	SDL_GL_ACCUM_BLUE_SIZE
	SDL_GL_ACCUM_ALPHA_SIZE
	SDL_GL_STEREO
	SDL_GL_MULTISAMPLEBUFFERS
	SDL_GL_MULTISAMPLESAMPLES
	SDL_GL_ACCELERATED_VISUAL
	SDL_GL_SWAP_CONTROL
end enum

const SDL_LOGPAL = &h01
const SDL_PHYSPAL = &h02
declare function SDL_VideoInit(byval driver_name as const zstring ptr, byval flags as Uint32) as long
declare sub SDL_VideoQuit()
declare function SDL_VideoDriverName(byval namebuf as zstring ptr, byval maxlen as long) as zstring ptr
declare function SDL_GetVideoSurface() as SDL_Surface ptr
declare function SDL_GetVideoInfo() as const SDL_VideoInfo ptr
declare function SDL_VideoModeOK(byval width as long, byval height as long, byval bpp as long, byval flags as Uint32) as long
declare function SDL_ListModes(byval format as SDL_PixelFormat ptr, byval flags as Uint32) as SDL_Rect ptr ptr
declare function SDL_SetVideoMode(byval width as long, byval height as long, byval bpp as long, byval flags as Uint32) as SDL_Surface ptr
declare sub SDL_UpdateRects(byval screen as SDL_Surface ptr, byval numrects as long, byval rects as SDL_Rect ptr)
declare sub SDL_UpdateRect(byval screen as SDL_Surface ptr, byval x as Sint32, byval y as Sint32, byval w as Uint32, byval h as Uint32)
declare function SDL_Flip(byval screen as SDL_Surface ptr) as long
declare function SDL_SetGamma(byval red as single, byval green as single, byval blue as single) as long
declare function SDL_SetGammaRamp(byval red as const Uint16 ptr, byval green as const Uint16 ptr, byval blue as const Uint16 ptr) as long
declare function SDL_GetGammaRamp(byval red as Uint16 ptr, byval green as Uint16 ptr, byval blue as Uint16 ptr) as long
declare function SDL_SetColors(byval surface as SDL_Surface ptr, byval colors as SDL_Color ptr, byval firstcolor as long, byval ncolors as long) as long
declare function SDL_SetPalette(byval surface as SDL_Surface ptr, byval flags as long, byval colors as SDL_Color ptr, byval firstcolor as long, byval ncolors as long) as long
declare function SDL_MapRGB(byval format as const SDL_PixelFormat const ptr, byval r as const Uint8, byval g as const Uint8, byval b as const Uint8) as Uint32
declare function SDL_MapRGBA(byval format as const SDL_PixelFormat const ptr, byval r as const Uint8, byval g as const Uint8, byval b as const Uint8, byval a as const Uint8) as Uint32
declare sub SDL_GetRGB(byval pixel as Uint32, byval fmt as const SDL_PixelFormat const ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr)
declare sub SDL_GetRGBA(byval pixel as Uint32, byval fmt as const SDL_PixelFormat const ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr, byval a as Uint8 ptr)
declare function SDL_CreateRGBSurface(byval flags as Uint32, byval width as long, byval height as long, byval depth as long, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare function SDL_AllocSurface alias "SDL_CreateRGBSurface"(byval flags as Uint32, byval width as long, byval height as long, byval depth as long, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare function SDL_CreateRGBSurfaceFrom(byval pixels as any ptr, byval width as long, byval height as long, byval depth as long, byval pitch as long, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare sub SDL_FreeSurface(byval surface as SDL_Surface ptr)
declare function SDL_LockSurface(byval surface as SDL_Surface ptr) as long
declare sub SDL_UnlockSurface(byval surface as SDL_Surface ptr)
declare function SDL_LoadBMP_RW(byval src as SDL_RWops ptr, byval freesrc as long) as SDL_Surface ptr
#define SDL_LoadBMP(file) SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
declare function SDL_SaveBMP_RW(byval surface as SDL_Surface ptr, byval dst as SDL_RWops ptr, byval freedst as long) as long
#define SDL_SaveBMP(surface, file) SDL_SaveBMP_RW(surface, SDL_RWFromFile(file, "wb"), 1)
declare function SDL_SetColorKey(byval surface as SDL_Surface ptr, byval flag as Uint32, byval key as Uint32) as long
declare function SDL_SetAlpha(byval surface as SDL_Surface ptr, byval flag as Uint32, byval alpha as Uint8) as long
declare function SDL_SetClipRect(byval surface as SDL_Surface ptr, byval rect as const SDL_Rect ptr) as SDL_bool
declare sub SDL_GetClipRect(byval surface as SDL_Surface ptr, byval rect as SDL_Rect ptr)
declare function SDL_ConvertSurface(byval src as SDL_Surface ptr, byval fmt as SDL_PixelFormat ptr, byval flags as Uint32) as SDL_Surface ptr
declare function SDL_UpperBlit(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_BlitSurface alias "SDL_UpperBlit"(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_LowerBlit(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_FillRect(byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr, byval color as Uint32) as long
declare function SDL_DisplayFormat(byval surface as SDL_Surface ptr) as SDL_Surface ptr
declare function SDL_DisplayFormatAlpha(byval surface as SDL_Surface ptr) as SDL_Surface ptr
declare function SDL_CreateYUVOverlay(byval width as long, byval height as long, byval format as Uint32, byval display as SDL_Surface ptr) as SDL_Overlay ptr
declare function SDL_LockYUVOverlay(byval overlay as SDL_Overlay ptr) as long
declare sub SDL_UnlockYUVOverlay(byval overlay as SDL_Overlay ptr)
declare function SDL_DisplayYUVOverlay(byval overlay as SDL_Overlay ptr, byval dstrect as SDL_Rect ptr) as long
declare sub SDL_FreeYUVOverlay(byval overlay as SDL_Overlay ptr)
declare function SDL_GL_LoadLibrary(byval path as const zstring ptr) as long
declare function SDL_GL_GetProcAddress(byval proc as const zstring ptr) as any ptr
declare function SDL_GL_SetAttribute(byval attr as SDL_GLattr, byval value as long) as long
declare function SDL_GL_GetAttribute(byval attr as SDL_GLattr, byval value as long ptr) as long
declare sub SDL_GL_SwapBuffers()
declare sub SDL_GL_UpdateRects(byval numrects as long, byval rects as SDL_Rect ptr)
declare sub SDL_GL_Lock()
declare sub SDL_GL_Unlock()
declare sub SDL_WM_SetCaption(byval title as const zstring ptr, byval icon as const zstring ptr)
declare sub SDL_WM_GetCaption(byval title as zstring ptr ptr, byval icon as zstring ptr ptr)
declare sub SDL_WM_SetIcon(byval icon as SDL_Surface ptr, byval mask as Uint8 ptr)
declare function SDL_WM_IconifyWindow() as long
declare function SDL_WM_ToggleFullScreen(byval surface as SDL_Surface ptr) as long

type SDL_GrabMode as long
enum
	SDL_GRAB_QUERY = -1
	SDL_GRAB_OFF = 0
	SDL_GRAB_ON = 1
	SDL_GRAB_FULLSCREEN
end enum

declare function SDL_WM_GrabInput(byval mode as SDL_GrabMode) as SDL_GrabMode
declare function SDL_SoftStretch(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
type WMcursor as WMcursor_

type SDL_Cursor
	area as SDL_Rect
	hot_x as Sint16
	hot_y as Sint16
	data as Uint8 ptr
	mask as Uint8 ptr
	save(0 to 1) as Uint8 ptr
	wm_cursor as WMcursor ptr
end type

declare function SDL_GetMouseState(byval x as long ptr, byval y as long ptr) as Uint8
declare function SDL_GetRelativeMouseState(byval x as long ptr, byval y as long ptr) as Uint8
declare sub SDL_WarpMouse(byval x as Uint16, byval y as Uint16)
declare function SDL_CreateCursor(byval data as Uint8 ptr, byval mask as Uint8 ptr, byval w as long, byval h as long, byval hot_x as long, byval hot_y as long) as SDL_Cursor ptr
declare sub SDL_SetCursor(byval cursor as SDL_Cursor ptr)
declare function SDL_GetCursor() as SDL_Cursor ptr
declare sub SDL_FreeCursor(byval cursor as SDL_Cursor ptr)
declare function SDL_ShowCursor(byval toggle as long) as long

#define SDL_BUTTON(X) (1 shl ((X) - 1))
const SDL_BUTTON_LEFT = 1
const SDL_BUTTON_MIDDLE = 2
const SDL_BUTTON_RIGHT = 3
const SDL_BUTTON_WHEELUP = 4
const SDL_BUTTON_WHEELDOWN = 5
const SDL_BUTTON_X1 = 6
const SDL_BUTTON_X2 = 7
#define SDL_BUTTON_LMASK SDL_BUTTON(SDL_BUTTON_LEFT)
#define SDL_BUTTON_MMASK SDL_BUTTON(SDL_BUTTON_MIDDLE)
#define SDL_BUTTON_RMASK SDL_BUTTON(SDL_BUTTON_RIGHT)
#define SDL_BUTTON_X1MASK SDL_BUTTON(SDL_BUTTON_X1)
#define SDL_BUTTON_X2MASK SDL_BUTTON(SDL_BUTTON_X2)
#define _SDL_joystick_h
type SDL_Joystick as _SDL_Joystick

declare function SDL_NumJoysticks() as long
declare function SDL_JoystickName(byval device_index as long) as const zstring ptr
declare function SDL_JoystickOpen(byval device_index as long) as SDL_Joystick ptr
declare function SDL_JoystickOpened(byval device_index as long) as long
declare function SDL_JoystickIndex(byval joystick as SDL_Joystick ptr) as long
declare function SDL_JoystickNumAxes(byval joystick as SDL_Joystick ptr) as long
declare function SDL_JoystickNumBalls(byval joystick as SDL_Joystick ptr) as long
declare function SDL_JoystickNumHats(byval joystick as SDL_Joystick ptr) as long
declare function SDL_JoystickNumButtons(byval joystick as SDL_Joystick ptr) as long
declare sub SDL_JoystickUpdate()
declare function SDL_JoystickEventState(byval state as long) as long
declare function SDL_JoystickGetAxis(byval joystick as SDL_Joystick ptr, byval axis as long) as Sint16

const SDL_HAT_CENTERED = &h00
const SDL_HAT_UP = &h01
const SDL_HAT_RIGHT = &h02
const SDL_HAT_DOWN = &h04
const SDL_HAT_LEFT = &h08
const SDL_HAT_RIGHTUP = SDL_HAT_RIGHT or SDL_HAT_UP
const SDL_HAT_RIGHTDOWN = SDL_HAT_RIGHT or SDL_HAT_DOWN
const SDL_HAT_LEFTUP = SDL_HAT_LEFT or SDL_HAT_UP
const SDL_HAT_LEFTDOWN = SDL_HAT_LEFT or SDL_HAT_DOWN

declare function SDL_JoystickGetHat(byval joystick as SDL_Joystick ptr, byval hat as long) as Uint8
declare function SDL_JoystickGetBall(byval joystick as SDL_Joystick ptr, byval ball as long, byval dx as long ptr, byval dy as long ptr) as long
declare function SDL_JoystickGetButton(byval joystick as SDL_Joystick ptr, byval button as long) as Uint8
declare sub SDL_JoystickClose(byval joystick as SDL_Joystick ptr)

#define _SDL_quit_h
const SDL_RELEASED = 0
const SDL_PRESSED = 1

type SDL_EventType as long
enum
#ifndef __FB_JS__
	SDL_NOEVENT = 0
	SDL_ACTIVEEVENT
	SDL_KEYDOWN
	SDL_KEYUP
	SDL_MOUSEMOTION
	SDL_MOUSEBUTTONDOWN
	SDL_MOUSEBUTTONUP
	SDL_JOYAXISMOTION
	SDL_JOYBALLMOTION
	SDL_JOYHATMOTION
	SDL_JOYBUTTONDOWN
	SDL_JOYBUTTONUP
	SDL_QUIT_
	SDL_SYSWMEVENT
	SDL_EVENT_RESERVEDA
	SDL_EVENT_RESERVEDB
	SDL_VIDEORESIZE
	SDL_VIDEOEXPOSE
	SDL_EVENT_RESERVED2
	SDL_EVENT_RESERVED3
	SDL_EVENT_RESERVED4
	SDL_EVENT_RESERVED5
	SDL_EVENT_RESERVED6
	SDL_EVENT_RESERVED7
	SDL_USEREVENT = 24
	SDL_NUMEVENTS = 32
#else
	SDL_NOEVENT        = 0
	SDL_FIRSTEVENT     = 0
	SDL_QUIT_          = &h100
	SDL_WINDOWEVENT    = &h200
	SDL_SYSWMEVENT
	SDL_KEYDOWN        = &h300
	SDL_KEYUP
	SDL_TEXTEDITING
	SDL_TEXTINPUT
	SDL_MOUSEMOTION    = &h400
	SDL_MOUSEBUTTONDOWN
	SDL_MOUSEBUTTONUP
	SDL_MOUSEWHEEL
	SDL_INPUTMOTION    = &h500
	SDL_INPUTBUTTONDOWN
	SDL_INPUTBUTTONUP
	SDL_INPUTWHEEL
	SDL_INPUTPROXIMITYIN
	SDL_INPUTPROXIMITYOUT
	SDL_JOYAXISMOTION  = &h600
	SDL_JOYBALLMOTION
	SDL_JOYHATMOTION
	SDL_JOYBUTTONDOWN
	SDL_JOYBUTTONUP
	SDL_FINGERDOWN      = &h700
	SDL_FINGERUP
	SDL_FINGERMOTION
	SDL_TOUCHBUTTONDOWN
	SDL_TOUCHBUTTONUP
	SDL_DOLLARGESTURE   = &h800
	SDL_DOLLARRECORD
	SDL_MULTIGESTURE
	SDL_CLIPBOARDUPDATE = &h900
	SDL_EVENT_COMPAT1 = &h7000
	SDL_EVENT_COMPAT2
	SDL_EVENT_COMPAT3
	SDL_USEREVENT    = &h8000
	SDL_LASTEVENT    = &hFFFF
#endif
end enum

#define SDL_EVENTMASK(X) (1 shl (X))

type SDL_EventMask_ as long
#ifndef __FB_JS__
enum
	SDL_ACTIVEEVENTMASK = SDL_EVENTMASK(SDL_ACTIVEEVENT)
	SDL_KEYDOWNMASK = SDL_EVENTMASK(SDL_KEYDOWN)
	SDL_KEYUPMASK = SDL_EVENTMASK(SDL_KEYUP)
	SDL_KEYEVENTMASK = SDL_EVENTMASK(SDL_KEYDOWN) or SDL_EVENTMASK(SDL_KEYUP)
	SDL_MOUSEMOTIONMASK = SDL_EVENTMASK(SDL_MOUSEMOTION)
	SDL_MOUSEBUTTONDOWNMASK = SDL_EVENTMASK(SDL_MOUSEBUTTONDOWN)
	SDL_MOUSEBUTTONUPMASK = SDL_EVENTMASK(SDL_MOUSEBUTTONUP)
	SDL_MOUSEEVENTMASK = (SDL_EVENTMASK(SDL_MOUSEMOTION) or SDL_EVENTMASK(SDL_MOUSEBUTTONDOWN)) or SDL_EVENTMASK(SDL_MOUSEBUTTONUP)
	SDL_JOYAXISMOTIONMASK = SDL_EVENTMASK(SDL_JOYAXISMOTION)
	SDL_JOYBALLMOTIONMASK = SDL_EVENTMASK(SDL_JOYBALLMOTION)
	SDL_JOYHATMOTIONMASK = SDL_EVENTMASK(SDL_JOYHATMOTION)
	SDL_JOYBUTTONDOWNMASK = SDL_EVENTMASK(SDL_JOYBUTTONDOWN)
	SDL_JOYBUTTONUPMASK = SDL_EVENTMASK(SDL_JOYBUTTONUP)
	SDL_JOYEVENTMASK = (((SDL_EVENTMASK(SDL_JOYAXISMOTION) or SDL_EVENTMASK(SDL_JOYBALLMOTION)) or SDL_EVENTMASK(SDL_JOYHATMOTION)) or SDL_EVENTMASK(SDL_JOYBUTTONDOWN)) or SDL_EVENTMASK(SDL_JOYBUTTONUP)
	SDL_VIDEORESIZEMASK = SDL_EVENTMASK(SDL_VIDEORESIZE)
	SDL_VIDEOEXPOSEMASK = SDL_EVENTMASK(SDL_VIDEOEXPOSE)
	SDL_QUITMASK = SDL_EVENTMASK(SDL_QUIT_)
	SDL_SYSWMEVENTMASK = SDL_EVENTMASK(SDL_SYSWMEVENT)
end enum
#endif

const SDL_ALLEVENTS = &hFFFFFFFF

type SDL_ActiveEvent
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
#endif
	gain as Uint8
	state as Uint8
end type

type SDL_KeyboardEvent
#ifndef __FB_JS__
	as Uint8 type
	which as Uint8
	state as Uint8
#else
	as Uint32 type
	windowID as Uint32
	state as Uint8
	repeat as Uint8
	padding2 as Uint8
	padding3 as Uint8
#endif
	keysym as SDL_keysym
end type

type SDL_MouseMotionEvent
#ifndef __FB_JS__
	as Uint8 type
	which as Uint8
	state as Uint8
	x as Uint16
	y as Uint16
#else
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	which as Uint32
	state as Uint32
	x as Sint16
	y as Sint16
#endif
	xrel as Sint16
	yrel as Sint16
end type

type SDL_MouseButtonEvent
#ifndef __FB_JS__
	as Uint8 type
	which as Uint8
	button as Uint8
	state as Uint8
	x as Uint16
	y as Uint16
#else
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	which as Uint32
	button as Uint8
	state as Uint8
	padding1 as Uint8
	padding2 as Uint8
	x as Sint16
	y as Sint16
#endif
end type

type SDL_JoyAxisEvent
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
#endif
	which as Uint8
	axis as Uint8
#ifndef __FB_JS__
	value as Sint16
#else
	padding1 as Uint8
	padding2 as Uint8
	value as integer
#endif
end type

type SDL_JoyBallEvent
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
#endif
	which as Uint8
	ball as Uint8
#ifndef __FB_JS__
	xrel as Sint16
	yrel as Sint16
#else
	padding1 as Uint8
	padding2 as Uint8
	xrel as integer
	yrel as integer
#endif
end type

type SDL_JoyHatEvent
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
#endif
	which as Uint8
	hat as Uint8
	value as Uint8
#ifdef __FB_JS__
	as Uint8 padding1
#endif
end type

type SDL_JoyButtonEvent
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
#endif
	which as Uint8
	button as Uint8
	state as Uint8
#ifdef __FB_JS__
	as Uint8 padding1
#endif
end type

type SDL_ResizeEvent
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
#endif
	w as long
	h as long
end type

type SDL_ExposeEvent
	as Uint8 type
end type

type SDL_QuitEvent
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
#endif
end type

type SDL_UserEvent
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
	windowID as Uint32
#endif
	code as long
	data1 as any ptr
	data2 as any ptr
end type

type SDL_SysWMmsg as SDL_SysWMmsg_

type SDL_SysWMEvent
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
#endif
	msg as SDL_SysWMmsg ptr
end type

union SDL_Event
#ifndef __FB_JS__
	as Uint8 type
#else
	as Uint32 type
#endif
	active as SDL_ActiveEvent
	key as SDL_KeyboardEvent
	motion as SDL_MouseMotionEvent
	button as SDL_MouseButtonEvent
	jaxis as SDL_JoyAxisEvent
	jball as SDL_JoyBallEvent
	jhat as SDL_JoyHatEvent
	jbutton as SDL_JoyButtonEvent
	resize as SDL_ResizeEvent
	expose as SDL_ExposeEvent
	quit as SDL_QuitEvent
	user as SDL_UserEvent
	syswm as SDL_SysWMEvent
end union

declare sub SDL_PumpEvents()

type SDL_eventaction as long
enum
	SDL_ADDEVENT
	SDL_PEEKEVENT
	SDL_GETEVENT
end enum

declare function SDL_PeepEvents(byval events as SDL_Event ptr, byval numevents as long, byval action as SDL_eventaction, byval mask as Uint32) as long
#ifndef __FB_JS__
private function SDL_QuitRequested() as SDL_bool
	SDL_PumpEvents()
	function = SDL_PeepEvents(NULL, 0, SDL_PEEKEVENT, SDL_QUITMASK)
end function
#endif
declare function SDL_PollEvent(byval event as SDL_Event ptr) as long
declare function SDL_WaitEvent(byval event as SDL_Event ptr) as long
declare function SDL_PushEvent(byval event as SDL_Event ptr) as long
type SDL_EventFilter as function(byval event as const SDL_Event ptr) as long
declare sub SDL_SetEventFilter(byval filter as SDL_EventFilter)
declare function SDL_GetEventFilter() as SDL_EventFilter

const SDL_QUERY = -1
const SDL_IGNORE = 0
const SDL_DISABLE = 0
const SDL_ENABLE = 1
declare function SDL_EventState(byval type as Uint8, byval state as long) as Uint8
#define _SDL_loadso_h

declare function SDL_LoadObject(byval sofile as const zstring ptr) as any ptr
declare function SDL_LoadFunction(byval handle as any ptr, byval name as const zstring ptr) as any ptr
declare sub SDL_UnloadObject(byval handle as any ptr)

#define _SDL_timer_h
const SDL_TIMESLICE = 10
const TIMER_RESOLUTION = 10
declare function SDL_GetTicks() as Uint32
declare sub SDL_Delay(byval ms as Uint32)
type SDL_TimerCallback as function(byval interval as Uint32) as Uint32
declare function SDL_SetTimer(byval interval as Uint32, byval callback as SDL_TimerCallback) as long
type SDL_NewTimerCallback as function(byval interval as Uint32, byval param as any ptr) as Uint32
type SDL_TimerID as _SDL_TimerID ptr
declare function SDL_AddTimer(byval interval as Uint32, byval callback as SDL_NewTimerCallback, byval param as any ptr) as SDL_TimerID
declare function SDL_RemoveTimer(byval t as SDL_TimerID) as SDL_bool
#define _SDL_version_h
const SDL_MAJOR_VERSION = 1
const SDL_MINOR_VERSION = 2
const SDL_PATCHLEVEL = 15

type SDL_version
	major as Uint8
	minor as Uint8
	patch as Uint8
end type

#macro SDL_VERSION_(X)
	scope
		(X)->major = SDL_MAJOR_VERSION
		(X)->minor = SDL_MINOR_VERSION
		(X)->patch = SDL_PATCHLEVEL
	end scope
#endmacro
#define SDL_VERSIONNUM(X, Y, Z) ((((X) * 1000) + ((Y) * 100)) + (Z))
#define SDL_COMPILEDVERSION SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL)
#define SDL_VERSION_ATLEAST(X, Y, Z) (SDL_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z))
declare function SDL_Linked_Version() as const SDL_version ptr
const SDL_INIT_TIMER = &h00000001
const SDL_INIT_AUDIO = &h00000010
const SDL_INIT_VIDEO = &h00000020
const SDL_INIT_CDROM = &h00000100
const SDL_INIT_JOYSTICK = &h00000200
const SDL_INIT_NOPARACHUTE = &h00100000
const SDL_INIT_EVENTTHREAD = &h01000000
const SDL_INIT_EVERYTHING = &h0000FFFF

declare function SDL_Init(byval flags as Uint32) as long
declare function SDL_InitSubSystem(byval flags as Uint32) as long
declare sub SDL_QuitSubSystem(byval flags as Uint32)
declare function SDL_WasInit(byval flags as Uint32) as Uint32
declare sub SDL_Quit()
#define _SDL_syswm_h

#ifdef __FB_DARWIN__
	#define Cursor X11Cursor
	#undef Cursor
#endif

#ifdef __FB_UNIX__
	type SDL_SYSWM_TYPE as long
	enum
		SDL_SYSWM_X11
	end enum

	union SDL_SysWMmsg_event
		xevent as XEvent
	end union
#else
	#define WIN32_LEAN_AND_MEAN
#endif

type SDL_SysWMmsg_
	version as SDL_version

	#ifdef __FB_UNIX__
		subsystem as SDL_SYSWM_TYPE
		event as SDL_SysWMmsg_event
	#else
		hwnd as HWND
		msg as UINT
		wParam as WPARAM
		lParam as LPARAM
	#endif
end type

#ifdef __FB_UNIX__
	type SDL_SysWMinfo_info_x11
		display as Display ptr
		window as Window
		lock_func as sub()
		unlock_func as sub()
		fswindow as Window
		wmwindow as Window
		gfxdisplay as Display ptr
	end type

	union SDL_SysWMinfo_info
		x11 as SDL_SysWMinfo_info_x11
	end union
#endif

type SDL_SysWMinfo
	version as SDL_version

	#ifdef __FB_UNIX__
		subsystem as SDL_SYSWM_TYPE
		info as SDL_SysWMinfo_info
	#else
		window as HWND
		hglrc as HGLRC
	#endif
end type

declare function SDL_GetWMInfo(byval info as SDL_SysWMinfo ptr) as long

end extern
