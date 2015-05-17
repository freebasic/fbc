'' FreeBASIC binding for SDL2-2.0.3
''
'' based on the C header files:
''   Simple DirectMedia Layer
''   Copyright (C) 1997-2014 Sam Lantinga <slouken@libsdl.org>
''
''   This software is provided 'as-is', without any express or implied
''   warranty.  In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''   1. The origin of this software must not be misrepresented; you must not
''      claim that you wrote the original software. If you use this software
''      in a product, an acknowledgment in the product documentation would be
''      appreciated but is not required.
''   2. Altered source versions must be plainly marked as such, and must not be
''      misrepresented as being the original software.
''   3. This notice may not be removed or altered from any source distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "SDL2"

#include once "crt/long.bi"
#include once "crt/stdarg.bi"

#ifdef __FB_WIN32__
	#include once "windows.bi"
	#include once "win/d3d9.bi"
#else
	#include once "crt/stdio.bi"
	#include once "crt/string.bi"
	#include once "crt/ctype.bi"
	#include once "crt/math.bi"
	#include once "crt/iconv.bi"
#endif

'' The following symbols have been renamed:
''     #ifdef __FB_WIN32__
''         procedure SDL_CreateThread => SDL_CreateThread_
''     #endif
''     procedure SDL_Log => SDL_Log_
''     #define SDL_VERSION => SDL_VERSION_

extern "C"

#define _SDL_H
#define _SDL_main_h
#define _SDL_stdinc_h
#define _SDL_config_h
#define _SDL_platform_h
#define SDLCALL cdecl
#ifndef NULL
	const NULL = cptr(any ptr, 0)
#endif
declare function SDL_GetPlatform() as const zstring ptr

#ifdef __FB_WIN32__
	#define _SDL_config_windows_h
#else
	#define SDL_BYTEORDER SDL_LIL_ENDIAN
#endif

#define SDL_FOURCC(A, B, C, D) ((((cast(Uint32, cast(Uint8, (A))) shl 0) or (cast(Uint32, cast(Uint8, (B))) shl 8)) or (cast(Uint32, cast(Uint8, (C))) shl 16)) or (cast(Uint32, cast(Uint8, (D))) shl 24))

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

#ifdef __FB_WIN32__
	#define SDL_stack_alloc(type, count) cptr(type ptr, SDL_malloc(sizeof(type) * (count)))
	#define SDL_stack_free(data) SDL_free(data)
#else
	#define SDL_stack_alloc(type, count) cptr(type ptr, alloca(sizeof(type) * (count)))
	#define SDL_stack_free(data)
#endif

declare function SDL_malloc(byval size as uinteger) as any ptr
declare function SDL_calloc(byval nmemb as uinteger, byval size as uinteger) as any ptr
declare function SDL_realloc(byval mem as any ptr, byval size as uinteger) as any ptr
declare sub SDL_free(byval mem as any ptr)
declare function SDL_getenv(byval name as const zstring ptr) as zstring ptr
declare function SDL_setenv(byval name as const zstring ptr, byval value as const zstring ptr, byval overwrite as long) as long
declare sub SDL_qsort(byval base as any ptr, byval nmemb as uinteger, byval size as uinteger, byval compare as function(byval as const any ptr, byval as const any ptr) as long)
declare function SDL_abs(byval x as long) as long
#define SDL_min(x, y) iif((x) < (y), (x), (y))
#define SDL_max(x, y) iif((x) > (y), (x), (y))
declare function SDL_isdigit(byval x as long) as long
declare function SDL_isspace(byval x as long) as long
declare function SDL_toupper(byval x as long) as long
declare function SDL_tolower(byval x as long) as long
declare function SDL_memset(byval dst as any ptr, byval c as long, byval len as uinteger) as any ptr
#define SDL_zero(x) SDL_memset(@(x), 0, sizeof(x))
#define SDL_zerop(x) SDL_memset((x), 0, sizeof(*(x)))
#define SDL_memset4(dst, val, dwords) SDL_memset(dst, val, (dwords) * 4)
declare function SDL_memcpy(byval dst as any ptr, byval src as const any ptr, byval len as uinteger) as any ptr
#define SDL_memcpy4(dst, src, dwords) SDL_memcpy(dst, src, (dwords) * 4)
declare function SDL_memmove(byval dst as any ptr, byval src as const any ptr, byval len as uinteger) as any ptr
declare function SDL_memcmp(byval s1 as const any ptr, byval s2 as const any ptr, byval len as uinteger) as long
declare function SDL_wcslen(byval wstr as const wstring ptr) as uinteger
declare function SDL_wcslcpy(byval dst as wstring ptr, byval src as const wstring ptr, byval maxlen as uinteger) as uinteger
declare function SDL_wcslcat(byval dst as wstring ptr, byval src as const wstring ptr, byval maxlen as uinteger) as uinteger
declare function SDL_strlen(byval str as const zstring ptr) as uinteger
declare function SDL_strlcpy(byval dst as zstring ptr, byval src as const zstring ptr, byval maxlen as uinteger) as uinteger
declare function SDL_utf8strlcpy(byval dst as zstring ptr, byval src as const zstring ptr, byval dst_bytes as uinteger) as uinteger
declare function SDL_strlcat(byval dst as zstring ptr, byval src as const zstring ptr, byval maxlen as uinteger) as uinteger
declare function SDL_strdup(byval str as const zstring ptr) as zstring ptr
declare function SDL_strrev(byval str as zstring ptr) as zstring ptr
declare function SDL_strupr(byval str as zstring ptr) as zstring ptr
declare function SDL_strlwr(byval str as zstring ptr) as zstring ptr
declare function SDL_strchr(byval str as const zstring ptr, byval c as long) as zstring ptr
declare function SDL_strrchr(byval str as const zstring ptr, byval c as long) as zstring ptr
declare function SDL_strstr(byval haystack as const zstring ptr, byval needle as const zstring ptr) as zstring ptr
declare function SDL_itoa(byval value as long, byval str as zstring ptr, byval radix as long) as zstring ptr
declare function SDL_uitoa(byval value as ulong, byval str as zstring ptr, byval radix as long) as zstring ptr
declare function SDL_ltoa(byval value as clong, byval str as zstring ptr, byval radix as long) as zstring ptr
declare function SDL_ultoa(byval value as culong, byval str as zstring ptr, byval radix as long) as zstring ptr
declare function SDL_lltoa(byval value as Sint64, byval str as zstring ptr, byval radix as long) as zstring ptr
declare function SDL_ulltoa(byval value as Uint64, byval str as zstring ptr, byval radix as long) as zstring ptr
declare function SDL_atoi(byval str as const zstring ptr) as long
declare function SDL_atof(byval str as const zstring ptr) as double
declare function SDL_strtol(byval str as const zstring ptr, byval endp as zstring ptr ptr, byval base as long) as clong
declare function SDL_strtoul(byval str as const zstring ptr, byval endp as zstring ptr ptr, byval base as long) as culong
declare function SDL_strtoll(byval str as const zstring ptr, byval endp as zstring ptr ptr, byval base as long) as Sint64
declare function SDL_strtoull(byval str as const zstring ptr, byval endp as zstring ptr ptr, byval base as long) as Uint64
declare function SDL_strtod(byval str as const zstring ptr, byval endp as zstring ptr ptr) as double
declare function SDL_strcmp(byval str1 as const zstring ptr, byval str2 as const zstring ptr) as long
declare function SDL_strncmp(byval str1 as const zstring ptr, byval str2 as const zstring ptr, byval maxlen as uinteger) as long
declare function SDL_strcasecmp(byval str1 as const zstring ptr, byval str2 as const zstring ptr) as long
declare function SDL_strncasecmp(byval str1 as const zstring ptr, byval str2 as const zstring ptr, byval len as uinteger) as long
declare function SDL_sscanf(byval text as const zstring ptr, byval fmt as const zstring ptr, ...) as long
declare function SDL_vsscanf(byval text as const zstring ptr, byval fmt as const zstring ptr, byval ap as va_list) as long
declare function SDL_snprintf(byval text as zstring ptr, byval maxlen as uinteger, byval fmt as const zstring ptr, ...) as long
declare function SDL_vsnprintf(byval text as zstring ptr, byval maxlen as uinteger, byval fmt as const zstring ptr, byval ap as va_list) as long
declare function SDL_acos(byval x as double) as double
declare function SDL_asin(byval x as double) as double
declare function SDL_atan(byval x as double) as double
declare function SDL_atan2(byval x as double, byval y as double) as double
declare function SDL_ceil(byval x as double) as double
declare function SDL_copysign(byval x as double, byval y as double) as double
declare function SDL_cos(byval x as double) as double
declare function SDL_cosf(byval x as single) as single
declare function SDL_fabs(byval x as double) as double
declare function SDL_floor(byval x as double) as double
declare function SDL_log(byval x as double) as double
declare function SDL_pow(byval x as double, byval y as double) as double
declare function SDL_scalbn(byval x as double, byval n as long) as double
declare function SDL_sin(byval x as double) as double
declare function SDL_sinf(byval x as single) as single
declare function SDL_sqrt(byval x as double) as double

const SDL_ICONV_ERROR = cuint(-1)
const SDL_ICONV_E2BIG = cuint(-2)
const SDL_ICONV_EILSEQ = cuint(-3)
const SDL_ICONV_EINVAL = cuint(-4)
type SDL_iconv_t as _SDL_iconv_t ptr

declare function SDL_iconv_open(byval tocode as const zstring ptr, byval fromcode as const zstring ptr) as SDL_iconv_t
declare function SDL_iconv_close(byval cd as SDL_iconv_t) as long
declare function SDL_iconv(byval cd as SDL_iconv_t, byval inbuf as const zstring ptr ptr, byval inbytesleft as uinteger ptr, byval outbuf as zstring ptr ptr, byval outbytesleft as uinteger ptr) as uinteger
declare function SDL_iconv_string(byval tocode as const zstring ptr, byval fromcode as const zstring ptr, byval inbuf as const zstring ptr, byval inbytesleft as uinteger) as zstring ptr

#define SDL_iconv_utf8_locale(S) SDL_iconv_string("", "UTF-8", S, SDL_strlen(S) + 1)
#define SDL_iconv_utf8_ucs2(S) cptr(Uint16 ptr, SDL_iconv_string("UCS-2-INTERNAL", "UTF-8", S, SDL_strlen(S) + 1))
#define SDL_iconv_utf8_ucs4(S) cptr(Uint32 ptr, SDL_iconv_string("UCS-4-INTERNAL", "UTF-8", S, SDL_strlen(S) + 1))
declare function SDL_main(byval argc as long, byval argv as zstring ptr ptr) as long
declare sub SDL_SetMainReady()

#ifdef __FB_WIN32__
	declare function SDL_RegisterApp(byval name as zstring ptr, byval style as Uint32, byval hInst as any ptr) as long
	declare sub SDL_UnregisterApp()
#endif

#define _SDL_assert_h

#ifdef __FB_LINUX__
	#define SDL_BYTEORDER SDL_LIL_ENDIAN
#endif

const SDL_ASSERT_LEVEL = 2
#define SDL_TriggerBreakpoint() asm int 3
#define SDL_FUNCTION __FUNCTION__
#define SDL_FILE __FILE__
#define SDL_LINE __LINE__
const SDL_NULL_WHILE_LOOP_CONDITION = 0
#define SDL_disabled_assert(condition) scope : end scope

type SDL_assert_state as long
enum
	SDL_ASSERTION_RETRY
	SDL_ASSERTION_BREAK
	SDL_ASSERTION_ABORT
	SDL_ASSERTION_IGNORE
	SDL_ASSERTION_ALWAYS_IGNORE
end enum

type SDL_assert_data
	always_ignore as long
	trigger_count as ulong
	condition as const zstring ptr
	filename as const zstring ptr
	linenum as long
	function as const zstring ptr
	next as const SDL_assert_data ptr
end type

declare function SDL_ReportAssertion(byval as SDL_assert_data ptr, byval as const zstring ptr, byval as const zstring ptr, byval as long) as SDL_assert_state
#macro SDL_enabled_assert(condition)
	scope
		while (condition) = 0
			static as SDL_assert_data assert_data = ( 0, 0, @#condition, 0, 0, 0, 0 )
			dim as const SDL_assert_state state = SDL_ReportAssertion(@assert_data, SDL_FUNCTION, SDL_FILE, SDL_LINE)
			select case state
			case SDL_ASSERTION_RETRY
				continue while
			case SDL_ASSERTION_BREAK
				SDL_TriggerBreakpoint()
			end select
			exit while
		wend
	end scope
#endmacro
#define SDL_assert(condition) SDL_enabled_assert(condition)
#define SDL_assert_release(condition) SDL_enabled_assert(condition)
#define SDL_assert_paranoid(condition) SDL_disabled_assert(condition)
#define SDL_assert_always(condition) SDL_enabled_assert(condition)
type SDL_AssertionHandler as function(byval data as const SDL_assert_data ptr, byval userdata as any ptr) as SDL_assert_state

declare sub SDL_SetAssertionHandler(byval handler as SDL_AssertionHandler, byval userdata as any ptr)
declare function SDL_GetDefaultAssertionHandler() as SDL_AssertionHandler
declare function SDL_GetAssertionHandler(byval puserdata as any ptr ptr) as SDL_AssertionHandler
declare function SDL_GetAssertionReport() as const SDL_assert_data ptr
declare sub SDL_ResetAssertionReport()
#define _SDL_atomic_h_
type SDL_SpinLock as long
declare function SDL_AtomicTryLock(byval lock as SDL_SpinLock ptr) as SDL_bool
declare sub SDL_AtomicLock(byval lock as SDL_SpinLock ptr)
declare sub SDL_AtomicUnlock(byval lock as SDL_SpinLock ptr)
#define SDL_CompilerBarrier() asm nop
#define SDL_MemoryBarrierRelease() SDL_CompilerBarrier()
#define SDL_MemoryBarrierAcquire() SDL_CompilerBarrier()

type SDL_atomic_t
	value as long
end type

declare function SDL_AtomicCAS(byval a as SDL_atomic_t ptr, byval oldval as long, byval newval as long) as SDL_bool
declare function SDL_AtomicSet(byval a as SDL_atomic_t ptr, byval v as long) as long
declare function SDL_AtomicGet(byval a as SDL_atomic_t ptr) as long
declare function SDL_AtomicAdd(byval a as SDL_atomic_t ptr, byval v as long) as long
#define SDL_AtomicIncRef(a) SDL_AtomicAdd(a, 1)
#define SDL_AtomicDecRef(a) (SDL_AtomicAdd(a, -1) = 1)
declare function SDL_AtomicCASPtr(byval a as any ptr ptr, byval oldval as any ptr, byval newval as any ptr) as SDL_bool
declare function SDL_AtomicSetPtr(byval a as any ptr ptr, byval v as any ptr) as any ptr
declare function SDL_AtomicGetPtr(byval a as any ptr ptr) as any ptr
#define _SDL_audio_h
#define _SDL_error_h
declare function SDL_SetError(byval fmt as const zstring ptr, ...) as long
declare function SDL_GetError() as const zstring ptr
declare sub SDL_ClearError()

#define SDL_OutOfMemory() SDL_Error(SDL_ENOMEM)
#define SDL_Unsupported() SDL_Error(SDL_UNSUPPORTED_)
#define SDL_InvalidParamError(param) SDL_SetError("Parameter '%s' is invalid", (param))

type SDL_errorcode as long
enum
	SDL_ENOMEM
	SDL_EFREAD
	SDL_EFWRITE
	SDL_EFSEEK
	SDL_UNSUPPORTED_
	SDL_LASTERROR
end enum

declare function SDL_Error(byval code as SDL_errorcode) as long
#define _SDL_endian_h
const SDL_LIL_ENDIAN = 1234
const SDL_BIG_ENDIAN = 4321

#ifdef __FB_WIN32__
	#define SDL_BYTEORDER SDL_LIL_ENDIAN
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
private function SDL_SwapFloat(byval x as single) as single
	union swapper
		f as single
		ui32 as Uint32
	end union
	dim swapper as swapper
	swapper.f = x
	swapper.ui32 = SDL_Swap32(swapper.ui32)
	return swapper.f
end function

#define SDL_SwapLE16(X) (X)
#define SDL_SwapLE32(X) (X)
#define SDL_SwapLE64(X) (X)
#define SDL_SwapFloatLE(X) (X)
#define SDL_SwapBE16(X) SDL_Swap16(X)
#define SDL_SwapBE32(X) SDL_Swap32(X)
#define SDL_SwapBE64(X) SDL_Swap64(X)
#define SDL_SwapFloatBE(X) SDL_SwapFloat(X)
#define _SDL_mutex_h
const SDL_MUTEX_TIMEDOUT = 1
#define SDL_MUTEX_MAXWAIT (not cast(Uint32, 0))
type SDL_mutex as SDL_mutex_
declare function SDL_CreateMutex() as SDL_mutex ptr
#define SDL_mutexP(m) SDL_LockMutex(m)
declare function SDL_LockMutex(byval mutex as SDL_mutex ptr) as long
declare function SDL_TryLockMutex(byval mutex as SDL_mutex ptr) as long
#define SDL_mutexV(m) SDL_UnlockMutex(m)
declare function SDL_UnlockMutex(byval mutex as SDL_mutex ptr) as long
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
declare function SDL_CondWait(byval cond as SDL_cond ptr, byval mutex as SDL_mutex ptr) as long
declare function SDL_CondWaitTimeout(byval cond as SDL_cond ptr, byval mutex as SDL_mutex ptr, byval ms as Uint32) as long
#define _SDL_thread_h
type SDL_threadID as culong
type SDL_TLSID as ulong

type SDL_ThreadPriority as long
enum
	SDL_THREAD_PRIORITY_LOW
	SDL_THREAD_PRIORITY_NORMAL
	SDL_THREAD_PRIORITY_HIGH
end enum

type SDL_ThreadFunction as function(byval data as any ptr) as long

#ifdef __FB_WIN32__
	#define SDL_PASSED_BEGINTHREAD_ENDTHREAD
#endif

#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
	type pfnSDL_CurrentBeginThread as function(byval as any ptr, byval as ulong, byval func as function(byval as any ptr) as ulong, byval arg as any ptr, byval as ulong, byval threadID as ulong ptr) as uinteger
#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
	type pfnSDL_CurrentBeginThread as function(byval as any ptr, byval as ulong, byval func as function stdcall(byval as any ptr) as ulong, byval arg as any ptr, byval as ulong, byval threadID as ulong ptr) as uinteger
#endif

#ifdef __FB_WIN32__
	type pfnSDL_CurrentEndThread as sub(byval code as ulong)
#endif

type SDL_Thread as SDL_Thread_

#ifdef __FB_WIN32__
	declare function SDL_CreateThread_ alias "SDL_CreateThread"(byval fn as SDL_ThreadFunction, byval name as const zstring ptr, byval data as any ptr, byval pfnBeginThread as pfnSDL_CurrentBeginThread, byval pfnEndThread as pfnSDL_CurrentEndThread) as SDL_Thread ptr
	#define SDL_CreateThread(fn, name, data) SDL_CreateThread_(fn, name, data, cast(pfnSDL_CurrentBeginThread, _beginthreadex), cast(pfnSDL_CurrentEndThread, _endthreadex))
#else
	declare function SDL_CreateThread(byval fn as SDL_ThreadFunction, byval name as const zstring ptr, byval data as any ptr) as SDL_Thread ptr
#endif

declare function SDL_GetThreadName(byval thread as SDL_Thread ptr) as const zstring ptr
declare function SDL_ThreadID() as SDL_threadID
declare function SDL_GetThreadID(byval thread as SDL_Thread ptr) as SDL_threadID
declare function SDL_SetThreadPriority(byval priority as SDL_ThreadPriority) as long
declare sub SDL_WaitThread(byval thread as SDL_Thread ptr, byval status as long ptr)
declare sub SDL_DetachThread(byval thread as SDL_Thread ptr)
declare function SDL_TLSCreate() as SDL_TLSID
declare function SDL_TLSGet(byval id as SDL_TLSID) as any ptr
declare function SDL_TLSSet(byval id as SDL_TLSID, byval value as const any ptr, byval destructor as sub(byval as any ptr)) as long

#define _SDL_rwops_h
const SDL_RWOPS_UNKNOWN = 0
const SDL_RWOPS_WINFILE = 1
const SDL_RWOPS_STDFILE = 2
const SDL_RWOPS_JNIFILE = 3
const SDL_RWOPS_MEMORY = 4
const SDL_RWOPS_MEMORY_RO = 5

#ifdef __FB_WIN32__
	type SDL_RWops_hidden_windowsio_buffer
		data as any ptr
		size as uinteger
		left as uinteger
	end type

	type SDL_RWops_hidden_windowsio
		append as SDL_bool
		h as any ptr
		buffer as SDL_RWops_hidden_windowsio_buffer
	end type
#else
	type SDL_RWops_hidden_stdio
		autoclose as SDL_bool
		fp as FILE ptr
	end type
#endif

type SDL_RWops_hidden_mem
	base as Uint8 ptr
	here as Uint8 ptr
	stop as Uint8 ptr
end type

type SDL_RWops_hidden_unknown
	data1 as any ptr
	data2 as any ptr
end type

union SDL_RWops_hidden
	#ifdef __FB_WIN32__
		windowsio as SDL_RWops_hidden_windowsio
	#else
		stdio as SDL_RWops_hidden_stdio
	#endif

	mem as SDL_RWops_hidden_mem
	unknown as SDL_RWops_hidden_unknown
end union

type SDL_RWops
	size as function(byval context as SDL_RWops ptr) as Sint64
	seek as function(byval context as SDL_RWops ptr, byval offset as Sint64, byval whence as long) as Sint64
	read as function(byval context as SDL_RWops ptr, byval ptr as any ptr, byval size as uinteger, byval maxnum as uinteger) as uinteger
	write as function(byval context as SDL_RWops ptr, byval ptr as const any ptr, byval size as uinteger, byval num as uinteger) as uinteger
	close as function(byval context as SDL_RWops ptr) as long
	as Uint32 type
	hidden as SDL_RWops_hidden
end type

declare function SDL_RWFromFile(byval file as const zstring ptr, byval mode as const zstring ptr) as SDL_RWops ptr

#ifdef __FB_WIN32__
	declare function SDL_RWFromFP(byval fp as any ptr, byval autoclose as SDL_bool) as SDL_RWops ptr
#else
	declare function SDL_RWFromFP(byval fp as FILE ptr, byval autoclose as SDL_bool) as SDL_RWops ptr
#endif

declare function SDL_RWFromMem(byval mem as any ptr, byval size as long) as SDL_RWops ptr
declare function SDL_RWFromConstMem(byval mem as const any ptr, byval size as long) as SDL_RWops ptr
declare function SDL_AllocRW() as SDL_RWops ptr
declare sub SDL_FreeRW(byval area as SDL_RWops ptr)

const RW_SEEK_SET = 0
const RW_SEEK_CUR = 1
const RW_SEEK_END = 2
#define SDL_RWsize(ctx) (ctx)->size(ctx)
#define SDL_RWseek(ctx, offset, whence) (ctx)->seek(ctx, offset, whence)
#define SDL_RWtell(ctx) (ctx)->seek(ctx, 0, RW_SEEK_CUR)
#define SDL_RWread(ctx, ptr, size, n) (ctx)->read(ctx, ptr, size, n)
#define SDL_RWwrite(ctx, ptr, size, n) (ctx)->write(ctx, ptr, size, n)
#define SDL_RWclose(ctx) (ctx)->close(ctx)

declare function SDL_ReadU8(byval src as SDL_RWops ptr) as Uint8
declare function SDL_ReadLE16(byval src as SDL_RWops ptr) as Uint16
declare function SDL_ReadBE16(byval src as SDL_RWops ptr) as Uint16
declare function SDL_ReadLE32(byval src as SDL_RWops ptr) as Uint32
declare function SDL_ReadBE32(byval src as SDL_RWops ptr) as Uint32
declare function SDL_ReadLE64(byval src as SDL_RWops ptr) as Uint64
declare function SDL_ReadBE64(byval src as SDL_RWops ptr) as Uint64
declare function SDL_WriteU8(byval dst as SDL_RWops ptr, byval value as Uint8) as uinteger
declare function SDL_WriteLE16(byval dst as SDL_RWops ptr, byval value as Uint16) as uinteger
declare function SDL_WriteBE16(byval dst as SDL_RWops ptr, byval value as Uint16) as uinteger
declare function SDL_WriteLE32(byval dst as SDL_RWops ptr, byval value as Uint32) as uinteger
declare function SDL_WriteBE32(byval dst as SDL_RWops ptr, byval value as Uint32) as uinteger
declare function SDL_WriteLE64(byval dst as SDL_RWops ptr, byval value as Uint64) as uinteger
declare function SDL_WriteBE64(byval dst as SDL_RWops ptr, byval value as Uint64) as uinteger
type SDL_AudioFormat as Uint16

const SDL_AUDIO_MASK_BITSIZE = &hFF
const SDL_AUDIO_MASK_DATATYPE = 1 shl 8
const SDL_AUDIO_MASK_ENDIAN = 1 shl 12
const SDL_AUDIO_MASK_SIGNED = 1 shl 15
#define SDL_AUDIO_BITSIZE(x) (x and SDL_AUDIO_MASK_BITSIZE)
#define SDL_AUDIO_ISFLOAT(x) (x and SDL_AUDIO_MASK_DATATYPE)
#define SDL_AUDIO_ISBIGENDIAN(x) (x and SDL_AUDIO_MASK_ENDIAN)
#define SDL_AUDIO_ISSIGNED(x) (x and SDL_AUDIO_MASK_SIGNED)
#define SDL_AUDIO_ISINT(x) (SDL_AUDIO_ISFLOAT(x) = 0)
#define SDL_AUDIO_ISLITTLEENDIAN(x) (SDL_AUDIO_ISBIGENDIAN(x) = 0)
#define SDL_AUDIO_ISUNSIGNED(x) (SDL_AUDIO_ISSIGNED(x) = 0)
const AUDIO_U8 = &h0008
const AUDIO_S8 = &h8008
const AUDIO_U16LSB = &h0010
const AUDIO_S16LSB = &h8010
const AUDIO_U16MSB = &h1010
const AUDIO_S16MSB = &h9010
#define AUDIO_U16 AUDIO_U16LSB
#define AUDIO_S16 AUDIO_S16LSB
const AUDIO_S32LSB = &h8020
const AUDIO_S32MSB = &h9020
#define AUDIO_S32 AUDIO_S32LSB
const AUDIO_F32LSB = &h8120
const AUDIO_F32MSB = &h9120
#define AUDIO_F32 AUDIO_F32LSB
#define AUDIO_U16SYS AUDIO_U16LSB
#define AUDIO_S16SYS AUDIO_S16LSB
#define AUDIO_S32SYS AUDIO_S32LSB
#define AUDIO_F32SYS AUDIO_F32LSB
const SDL_AUDIO_ALLOW_FREQUENCY_CHANGE = &h00000001
const SDL_AUDIO_ALLOW_FORMAT_CHANGE = &h00000002
const SDL_AUDIO_ALLOW_CHANNELS_CHANGE = &h00000004
#define SDL_AUDIO_ALLOW_ANY_CHANGE ((SDL_AUDIO_ALLOW_FREQUENCY_CHANGE or SDL_AUDIO_ALLOW_FORMAT_CHANGE) or SDL_AUDIO_ALLOW_CHANNELS_CHANGE)
type SDL_AudioCallback as sub(byval userdata as any ptr, byval stream as Uint8 ptr, byval len as long)

type SDL_AudioSpec
	freq as long
	format as SDL_AudioFormat
	channels as Uint8
	silence as Uint8
	samples as Uint16
	padding as Uint16
	size as Uint32
	callback as SDL_AudioCallback
	userdata as any ptr
end type

type SDL_AudioCVT as SDL_AudioCVT_
type SDL_AudioFilter as sub(byval cvt as SDL_AudioCVT ptr, byval format as SDL_AudioFormat)

type SDL_AudioCVT_ field = 1
	needed as long
	src_format as SDL_AudioFormat
	dst_format as SDL_AudioFormat
	rate_incr as double
	buf as Uint8 ptr
	len as long
	len_cvt as long
	len_mult as long
	len_ratio as double
	filters(0 to 9) as SDL_AudioFilter
	filter_index as long
end type

declare function SDL_GetNumAudioDrivers() as long
declare function SDL_GetAudioDriver(byval index as long) as const zstring ptr
declare function SDL_AudioInit(byval driver_name as const zstring ptr) as long
declare sub SDL_AudioQuit()
declare function SDL_GetCurrentAudioDriver() as const zstring ptr
declare function SDL_OpenAudio(byval desired as SDL_AudioSpec ptr, byval obtained as SDL_AudioSpec ptr) as long
type SDL_AudioDeviceID as Uint32
declare function SDL_GetNumAudioDevices(byval iscapture as long) as long
declare function SDL_GetAudioDeviceName(byval index as long, byval iscapture as long) as const zstring ptr
declare function SDL_OpenAudioDevice(byval device as const zstring ptr, byval iscapture as long, byval desired as const SDL_AudioSpec ptr, byval obtained as SDL_AudioSpec ptr, byval allowed_changes as long) as SDL_AudioDeviceID

type SDL_AudioStatus as long
enum
	SDL_AUDIO_STOPPED = 0
	SDL_AUDIO_PLAYING
	SDL_AUDIO_PAUSED
end enum

declare function SDL_GetAudioStatus() as SDL_AudioStatus
declare function SDL_GetAudioDeviceStatus(byval dev as SDL_AudioDeviceID) as SDL_AudioStatus
declare sub SDL_PauseAudio(byval pause_on as long)
declare sub SDL_PauseAudioDevice(byval dev as SDL_AudioDeviceID, byval pause_on as long)
declare function SDL_LoadWAV_RW(byval src as SDL_RWops ptr, byval freesrc as long, byval spec as SDL_AudioSpec ptr, byval audio_buf as Uint8 ptr ptr, byval audio_len as Uint32 ptr) as SDL_AudioSpec ptr
#define SDL_LoadWAV(file, spec, audio_buf, audio_len) SDL_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1, spec, audio_buf, audio_len)
declare sub SDL_FreeWAV(byval audio_buf as Uint8 ptr)
declare function SDL_BuildAudioCVT(byval cvt as SDL_AudioCVT ptr, byval src_format as SDL_AudioFormat, byval src_channels as Uint8, byval src_rate as long, byval dst_format as SDL_AudioFormat, byval dst_channels as Uint8, byval dst_rate as long) as long
declare function SDL_ConvertAudio(byval cvt as SDL_AudioCVT ptr) as long
const SDL_MIX_MAXVOLUME = 128
declare sub SDL_MixAudio(byval dst as Uint8 ptr, byval src as const Uint8 ptr, byval len as Uint32, byval volume as long)
declare sub SDL_MixAudioFormat(byval dst as Uint8 ptr, byval src as const Uint8 ptr, byval format as SDL_AudioFormat, byval len as Uint32, byval volume as long)
declare sub SDL_LockAudio()
declare sub SDL_LockAudioDevice(byval dev as SDL_AudioDeviceID)
declare sub SDL_UnlockAudio()
declare sub SDL_UnlockAudioDevice(byval dev as SDL_AudioDeviceID)
declare sub SDL_CloseAudio()
declare sub SDL_CloseAudioDevice(byval dev as SDL_AudioDeviceID)
#define _SDL_clipboard_h
declare function SDL_SetClipboardText(byval text as const zstring ptr) as long
declare function SDL_GetClipboardText() as zstring ptr
declare function SDL_HasClipboardText() as SDL_bool
#define _SDL_cpuinfo_h
const SDL_CACHELINE_SIZE = 128
declare function SDL_GetCPUCount() as long
declare function SDL_GetCPUCacheLineSize() as long
declare function SDL_HasRDTSC() as SDL_bool
declare function SDL_HasAltiVec() as SDL_bool
declare function SDL_HasMMX() as SDL_bool
declare function SDL_Has3DNow() as SDL_bool
declare function SDL_HasSSE() as SDL_bool
declare function SDL_HasSSE2() as SDL_bool
declare function SDL_HasSSE3() as SDL_bool
declare function SDL_HasSSE41() as SDL_bool
declare function SDL_HasSSE42() as SDL_bool
declare function SDL_HasAVX() as SDL_bool
declare function SDL_GetSystemRAM() as long

#define _SDL_events_h
#define _SDL_video_h
#define _SDL_pixels_h
const SDL_ALPHA_OPAQUE = 255
const SDL_ALPHA_TRANSPARENT = 0

enum
	SDL_PIXELTYPE_UNKNOWN
	SDL_PIXELTYPE_INDEX1
	SDL_PIXELTYPE_INDEX4
	SDL_PIXELTYPE_INDEX8
	SDL_PIXELTYPE_PACKED8
	SDL_PIXELTYPE_PACKED16
	SDL_PIXELTYPE_PACKED32
	SDL_PIXELTYPE_ARRAYU8
	SDL_PIXELTYPE_ARRAYU16
	SDL_PIXELTYPE_ARRAYU32
	SDL_PIXELTYPE_ARRAYF16
	SDL_PIXELTYPE_ARRAYF32
end enum

enum
	SDL_BITMAPORDER_NONE
	SDL_BITMAPORDER_4321
	SDL_BITMAPORDER_1234
end enum

enum
	SDL_PACKEDORDER_NONE
	SDL_PACKEDORDER_XRGB
	SDL_PACKEDORDER_RGBX
	SDL_PACKEDORDER_ARGB
	SDL_PACKEDORDER_RGBA
	SDL_PACKEDORDER_XBGR
	SDL_PACKEDORDER_BGRX
	SDL_PACKEDORDER_ABGR
	SDL_PACKEDORDER_BGRA
end enum

enum
	SDL_ARRAYORDER_NONE
	SDL_ARRAYORDER_RGB
	SDL_ARRAYORDER_RGBA
	SDL_ARRAYORDER_ARGB
	SDL_ARRAYORDER_BGR
	SDL_ARRAYORDER_BGRA
	SDL_ARRAYORDER_ABGR
end enum

enum
	SDL_PACKEDLAYOUT_NONE
	SDL_PACKEDLAYOUT_332
	SDL_PACKEDLAYOUT_4444
	SDL_PACKEDLAYOUT_1555
	SDL_PACKEDLAYOUT_5551
	SDL_PACKEDLAYOUT_565
	SDL_PACKEDLAYOUT_8888
	SDL_PACKEDLAYOUT_2101010
	SDL_PACKEDLAYOUT_1010102
end enum

#define SDL_DEFINE_PIXELFOURCC(A, B, C, D) SDL_FOURCC(A, B, C, D)
#define SDL_DEFINE_PIXELFORMAT(type, order, layout, bits, bytes) ((((((1 shl 28) or ((type) shl 24)) or ((order) shl 20)) or ((layout) shl 16)) or ((bits) shl 8)) or ((bytes) shl 0))
#define SDL_PIXELFLAG(X) (((X) shr 28) and &h0F)
#define SDL_PIXELTYPE(X) (((X) shr 24) and &h0F)
#define SDL_PIXELORDER(X) (((X) shr 20) and &h0F)
#define SDL_PIXELLAYOUT(X) (((X) shr 16) and &h0F)
#define SDL_BITSPERPIXEL(X) (((X) shr 8) and &hFF)
#define SDL_BYTESPERPIXEL(X) iif(SDL_ISPIXELFORMAT_FOURCC(X), iif((((X) = SDL_PIXELFORMAT_YUY2) orelse ((X) = SDL_PIXELFORMAT_UYVY)) orelse ((X) = SDL_PIXELFORMAT_YVYU), 2, 1), ((X) shr 0) and &hFF)
#define SDL_ISPIXELFORMAT_INDEXED(format) ((SDL_ISPIXELFORMAT_FOURCC(format) = 0) andalso (((SDL_PIXELTYPE(format) = SDL_PIXELTYPE_INDEX1) orelse (SDL_PIXELTYPE(format) = SDL_PIXELTYPE_INDEX4)) orelse (SDL_PIXELTYPE(format) = SDL_PIXELTYPE_INDEX8)))
#define SDL_ISPIXELFORMAT_ALPHA(format) ((SDL_ISPIXELFORMAT_FOURCC(format) = 0) andalso ((((SDL_PIXELORDER(format) = SDL_PACKEDORDER_ARGB) orelse (SDL_PIXELORDER(format) = SDL_PACKEDORDER_RGBA)) orelse (SDL_PIXELORDER(format) = SDL_PACKEDORDER_ABGR)) orelse (SDL_PIXELORDER(format) = SDL_PACKEDORDER_BGRA)))
#define SDL_ISPIXELFORMAT_FOURCC(format) ((format) andalso (SDL_PIXELFLAG(format) <> 1))

enum
	SDL_PIXELFORMAT_UNKNOWN
	SDL_PIXELFORMAT_INDEX1LSB = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX1, SDL_BITMAPORDER_4321, 0, 1, 0)
	SDL_PIXELFORMAT_INDEX1MSB = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX1, SDL_BITMAPORDER_1234, 0, 1, 0)
	SDL_PIXELFORMAT_INDEX4LSB = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX4, SDL_BITMAPORDER_4321, 0, 4, 0)
	SDL_PIXELFORMAT_INDEX4MSB = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX4, SDL_BITMAPORDER_1234, 0, 4, 0)
	SDL_PIXELFORMAT_INDEX8 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX8, 0, 0, 8, 1)
	SDL_PIXELFORMAT_RGB332 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED8, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_332, 8, 1)
	SDL_PIXELFORMAT_RGB444 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_4444, 12, 2)
	SDL_PIXELFORMAT_RGB555 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_1555, 15, 2)
	SDL_PIXELFORMAT_BGR555 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_1555, 15, 2)
	SDL_PIXELFORMAT_ARGB4444 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_4444, 16, 2)
	SDL_PIXELFORMAT_RGBA4444 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_RGBA, SDL_PACKEDLAYOUT_4444, 16, 2)
	SDL_PIXELFORMAT_ABGR4444 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_ABGR, SDL_PACKEDLAYOUT_4444, 16, 2)
	SDL_PIXELFORMAT_BGRA4444 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_BGRA, SDL_PACKEDLAYOUT_4444, 16, 2)
	SDL_PIXELFORMAT_ARGB1555 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_1555, 16, 2)
	SDL_PIXELFORMAT_RGBA5551 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_RGBA, SDL_PACKEDLAYOUT_5551, 16, 2)
	SDL_PIXELFORMAT_ABGR1555 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_ABGR, SDL_PACKEDLAYOUT_1555, 16, 2)
	SDL_PIXELFORMAT_BGRA5551 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_BGRA, SDL_PACKEDLAYOUT_5551, 16, 2)
	SDL_PIXELFORMAT_RGB565 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_565, 16, 2)
	SDL_PIXELFORMAT_BGR565 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_565, 16, 2)
	SDL_PIXELFORMAT_RGB24 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU8, SDL_ARRAYORDER_RGB, 0, 24, 3)
	SDL_PIXELFORMAT_BGR24 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU8, SDL_ARRAYORDER_BGR, 0, 24, 3)
	SDL_PIXELFORMAT_RGB888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_8888, 24, 4)
	SDL_PIXELFORMAT_RGBX8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_RGBX, SDL_PACKEDLAYOUT_8888, 24, 4)
	SDL_PIXELFORMAT_BGR888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_8888, 24, 4)
	SDL_PIXELFORMAT_BGRX8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_BGRX, SDL_PACKEDLAYOUT_8888, 24, 4)
	SDL_PIXELFORMAT_ARGB8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_8888, 32, 4)
	SDL_PIXELFORMAT_RGBA8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_RGBA, SDL_PACKEDLAYOUT_8888, 32, 4)
	SDL_PIXELFORMAT_ABGR8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ABGR, SDL_PACKEDLAYOUT_8888, 32, 4)
	SDL_PIXELFORMAT_BGRA8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_BGRA, SDL_PACKEDLAYOUT_8888, 32, 4)
	SDL_PIXELFORMAT_ARGB2101010 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_2101010, 32, 4)
	SDL_PIXELFORMAT_YV12 = SDL_DEFINE_PIXELFOURCC(asc("Y"), asc("V"), asc("1"), asc("2"))
	SDL_PIXELFORMAT_IYUV = SDL_DEFINE_PIXELFOURCC(asc("I"), asc("Y"), asc("U"), asc("V"))
	SDL_PIXELFORMAT_YUY2 = SDL_DEFINE_PIXELFOURCC(asc("Y"), asc("U"), asc("Y"), asc("2"))
	SDL_PIXELFORMAT_UYVY = SDL_DEFINE_PIXELFOURCC(asc("U"), asc("Y"), asc("V"), asc("Y"))
	SDL_PIXELFORMAT_YVYU = SDL_DEFINE_PIXELFOURCC(asc("Y"), asc("V"), asc("Y"), asc("U"))
end enum

type SDL_Color
	r as Uint8
	g as Uint8
	b as Uint8
	a as Uint8
end type

#define SDL_Colour SDL_Color

type SDL_Palette
	ncolors as long
	colors as SDL_Color ptr
	version as Uint32
	refcount as long
end type

type SDL_PixelFormat
	format as Uint32
	palette as SDL_Palette ptr
	BitsPerPixel as Uint8
	BytesPerPixel as Uint8
	padding(0 to 1) as Uint8
	Rmask as Uint32
	Gmask as Uint32
	Bmask as Uint32
	Amask as Uint32
	Rloss as Uint8
	Gloss as Uint8
	Bloss as Uint8
	Aloss as Uint8
	Rshift as Uint8
	Gshift as Uint8
	Bshift as Uint8
	Ashift as Uint8
	refcount as long
	next as SDL_PixelFormat ptr
end type

declare function SDL_GetPixelFormatName(byval format as Uint32) as const zstring ptr
declare function SDL_PixelFormatEnumToMasks(byval format as Uint32, byval bpp as long ptr, byval Rmask as Uint32 ptr, byval Gmask as Uint32 ptr, byval Bmask as Uint32 ptr, byval Amask as Uint32 ptr) as SDL_bool
declare function SDL_MasksToPixelFormatEnum(byval bpp as long, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as Uint32
declare function SDL_AllocFormat(byval pixel_format as Uint32) as SDL_PixelFormat ptr
declare sub SDL_FreeFormat(byval format as SDL_PixelFormat ptr)
declare function SDL_AllocPalette(byval ncolors as long) as SDL_Palette ptr
declare function SDL_SetPixelFormatPalette(byval format as SDL_PixelFormat ptr, byval palette as SDL_Palette ptr) as long
declare function SDL_SetPaletteColors(byval palette as SDL_Palette ptr, byval colors as const SDL_Color ptr, byval firstcolor as long, byval ncolors as long) as long
declare sub SDL_FreePalette(byval palette as SDL_Palette ptr)
declare function SDL_MapRGB(byval format as const SDL_PixelFormat ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8) as Uint32
declare function SDL_MapRGBA(byval format as const SDL_PixelFormat ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as Uint32
declare sub SDL_GetRGB(byval pixel as Uint32, byval format as const SDL_PixelFormat ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr)
declare sub SDL_GetRGBA(byval pixel as Uint32, byval format as const SDL_PixelFormat ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr, byval a as Uint8 ptr)
declare sub SDL_CalculateGammaRamp(byval gamma as single, byval ramp as Uint16 ptr)
#define _SDL_rect_h

type SDL_Point
	x as long
	y as long
end type

type SDL_Rect
	x as long
	y as long
	w as long
	h as long
end type

private function SDL_RectEmpty(byval r as const SDL_Rect ptr) as SDL_bool
	return iif(((r = 0) orelse (r->w <= 0)) orelse (r->h <= 0), SDL_TRUE, SDL_FALSE)
end function

private function SDL_RectEquals(byval a as const SDL_Rect ptr, byval b as const SDL_Rect ptr) as SDL_bool
	return iif(((((a andalso b) andalso (a->x = b->x)) andalso (a->y = b->y)) andalso (a->w = b->w)) andalso (a->h = b->h), SDL_TRUE, SDL_FALSE)
end function

declare function SDL_HasIntersection(byval A as const SDL_Rect ptr, byval B as const SDL_Rect ptr) as SDL_bool
declare function SDL_IntersectRect(byval A as const SDL_Rect ptr, byval B as const SDL_Rect ptr, byval result as SDL_Rect ptr) as SDL_bool
declare sub SDL_UnionRect(byval A as const SDL_Rect ptr, byval B as const SDL_Rect ptr, byval result as SDL_Rect ptr)
declare function SDL_EnclosePoints(byval points as const SDL_Point ptr, byval count as long, byval clip as const SDL_Rect ptr, byval result as SDL_Rect ptr) as SDL_bool
declare function SDL_IntersectRectAndLine(byval rect as const SDL_Rect ptr, byval X1 as long ptr, byval Y1 as long ptr, byval X2 as long ptr, byval Y2 as long ptr) as SDL_bool
#define _SDL_surface_h
#define _SDL_blendmode_h

type SDL_BlendMode as long
enum
	SDL_BLENDMODE_NONE = &h00000000
	SDL_BLENDMODE_BLEND = &h00000001
	SDL_BLENDMODE_ADD = &h00000002
	SDL_BLENDMODE_MOD = &h00000004
end enum

const SDL_SWSURFACE = 0
const SDL_PREALLOC = &h00000001
const SDL_RLEACCEL = &h00000002
const SDL_DONTFREE = &h00000004
#define SDL_MUSTLOCK(S) (((S)->flags and SDL_RLEACCEL) <> 0)
type SDL_BlitMap as SDL_BlitMap_

type SDL_Surface
	flags as Uint32
	format as SDL_PixelFormat ptr
	w as long
	h as long
	pitch as long
	pixels as any ptr
	userdata as any ptr
	locked as long
	lock_data as any ptr
	clip_rect as SDL_Rect
	map as SDL_BlitMap ptr
	refcount as long
end type

type SDL_blit as function(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_CreateRGBSurface(byval flags as Uint32, byval width as long, byval height as long, byval depth as long, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare function SDL_CreateRGBSurfaceFrom(byval pixels as any ptr, byval width as long, byval height as long, byval depth as long, byval pitch as long, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare sub SDL_FreeSurface(byval surface as SDL_Surface ptr)
declare function SDL_SetSurfacePalette(byval surface as SDL_Surface ptr, byval palette as SDL_Palette ptr) as long
declare function SDL_LockSurface(byval surface as SDL_Surface ptr) as long
declare sub SDL_UnlockSurface(byval surface as SDL_Surface ptr)
declare function SDL_LoadBMP_RW(byval src as SDL_RWops ptr, byval freesrc as long) as SDL_Surface ptr
#define SDL_LoadBMP(file) SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
declare function SDL_SaveBMP_RW(byval surface as SDL_Surface ptr, byval dst as SDL_RWops ptr, byval freedst as long) as long
#define SDL_SaveBMP(surface, file) SDL_SaveBMP_RW(surface, SDL_RWFromFile(file, "wb"), 1)
declare function SDL_SetSurfaceRLE(byval surface as SDL_Surface ptr, byval flag as long) as long
declare function SDL_SetColorKey(byval surface as SDL_Surface ptr, byval flag as long, byval key as Uint32) as long
declare function SDL_GetColorKey(byval surface as SDL_Surface ptr, byval key as Uint32 ptr) as long
declare function SDL_SetSurfaceColorMod(byval surface as SDL_Surface ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8) as long
declare function SDL_GetSurfaceColorMod(byval surface as SDL_Surface ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr) as long
declare function SDL_SetSurfaceAlphaMod(byval surface as SDL_Surface ptr, byval alpha as Uint8) as long
declare function SDL_GetSurfaceAlphaMod(byval surface as SDL_Surface ptr, byval alpha as Uint8 ptr) as long
declare function SDL_SetSurfaceBlendMode(byval surface as SDL_Surface ptr, byval blendMode as SDL_BlendMode) as long
declare function SDL_GetSurfaceBlendMode(byval surface as SDL_Surface ptr, byval blendMode as SDL_BlendMode ptr) as long
declare function SDL_SetClipRect(byval surface as SDL_Surface ptr, byval rect as const SDL_Rect ptr) as SDL_bool
declare sub SDL_GetClipRect(byval surface as SDL_Surface ptr, byval rect as SDL_Rect ptr)
declare function SDL_ConvertSurface(byval src as SDL_Surface ptr, byval fmt as const SDL_PixelFormat ptr, byval flags as Uint32) as SDL_Surface ptr
declare function SDL_ConvertSurfaceFormat(byval src as SDL_Surface ptr, byval pixel_format as Uint32, byval flags as Uint32) as SDL_Surface ptr
declare function SDL_ConvertPixels(byval width as long, byval height as long, byval src_format as Uint32, byval src as const any ptr, byval src_pitch as long, byval dst_format as Uint32, byval dst as any ptr, byval dst_pitch as long) as long
declare function SDL_FillRect(byval dst as SDL_Surface ptr, byval rect as const SDL_Rect ptr, byval color as Uint32) as long
declare function SDL_FillRects(byval dst as SDL_Surface ptr, byval rects as const SDL_Rect ptr, byval count as long, byval color as Uint32) as long
#define SDL_BlitSurface SDL_UpperBlit
declare function SDL_UpperBlit(byval src as SDL_Surface ptr, byval srcrect as const SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_LowerBlit(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_SoftStretch(byval src as SDL_Surface ptr, byval srcrect as const SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as const SDL_Rect ptr) as long
#define SDL_BlitScaled SDL_UpperBlitScaled
declare function SDL_UpperBlitScaled(byval src as SDL_Surface ptr, byval srcrect as const SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_LowerBlitScaled(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long

type SDL_DisplayMode
	format as Uint32
	w as long
	h as long
	refresh_rate as long
	driverdata as any ptr
end type

type SDL_WindowFlags as long
enum
	SDL_WINDOW_FULLSCREEN = &h00000001
	SDL_WINDOW_OPENGL = &h00000002
	SDL_WINDOW_SHOWN = &h00000004
	SDL_WINDOW_HIDDEN = &h00000008
	SDL_WINDOW_BORDERLESS = &h00000010
	SDL_WINDOW_RESIZABLE = &h00000020
	SDL_WINDOW_MINIMIZED = &h00000040
	SDL_WINDOW_MAXIMIZED = &h00000080
	SDL_WINDOW_INPUT_GRABBED = &h00000100
	SDL_WINDOW_INPUT_FOCUS = &h00000200
	SDL_WINDOW_MOUSE_FOCUS = &h00000400
	SDL_WINDOW_FULLSCREEN_DESKTOP = SDL_WINDOW_FULLSCREEN or &h00001000
	SDL_WINDOW_FOREIGN = &h00000800
	SDL_WINDOW_ALLOW_HIGHDPI = &h00002000
end enum

const SDL_WINDOWPOS_UNDEFINED_MASK = &h1FFF0000
#define SDL_WINDOWPOS_UNDEFINED_DISPLAY(X) (SDL_WINDOWPOS_UNDEFINED_MASK or (X))
#define SDL_WINDOWPOS_UNDEFINED SDL_WINDOWPOS_UNDEFINED_DISPLAY(0)
#define SDL_WINDOWPOS_ISUNDEFINED(X) (((X) and &hFFFF0000) = SDL_WINDOWPOS_UNDEFINED_MASK)
const SDL_WINDOWPOS_CENTERED_MASK = &h2FFF0000
#define SDL_WINDOWPOS_CENTERED_DISPLAY(X) (SDL_WINDOWPOS_CENTERED_MASK or (X))
#define SDL_WINDOWPOS_CENTERED SDL_WINDOWPOS_CENTERED_DISPLAY(0)
#define SDL_WINDOWPOS_ISCENTERED(X) (((X) and &hFFFF0000) = SDL_WINDOWPOS_CENTERED_MASK)

type SDL_WindowEventID as long
enum
	SDL_WINDOWEVENT_NONE
	SDL_WINDOWEVENT_SHOWN
	SDL_WINDOWEVENT_HIDDEN
	SDL_WINDOWEVENT_EXPOSED
	SDL_WINDOWEVENT_MOVED
	SDL_WINDOWEVENT_RESIZED
	SDL_WINDOWEVENT_SIZE_CHANGED
	SDL_WINDOWEVENT_MINIMIZED
	SDL_WINDOWEVENT_MAXIMIZED
	SDL_WINDOWEVENT_RESTORED
	SDL_WINDOWEVENT_ENTER
	SDL_WINDOWEVENT_LEAVE
	SDL_WINDOWEVENT_FOCUS_GAINED
	SDL_WINDOWEVENT_FOCUS_LOST
	SDL_WINDOWEVENT_CLOSE
end enum

type SDL_GLContext as any ptr

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
	SDL_GL_RETAINED_BACKING
	SDL_GL_CONTEXT_MAJOR_VERSION
	SDL_GL_CONTEXT_MINOR_VERSION
	SDL_GL_CONTEXT_EGL
	SDL_GL_CONTEXT_FLAGS
	SDL_GL_CONTEXT_PROFILE_MASK
	SDL_GL_SHARE_WITH_CURRENT_CONTEXT
	SDL_GL_FRAMEBUFFER_SRGB_CAPABLE
end enum

type SDL_GLprofile as long
enum
	SDL_GL_CONTEXT_PROFILE_CORE = &h0001
	SDL_GL_CONTEXT_PROFILE_COMPATIBILITY = &h0002
	SDL_GL_CONTEXT_PROFILE_ES = &h0004
end enum

type SDL_GLcontextFlag as long
enum
	SDL_GL_CONTEXT_DEBUG_FLAG = &h0001
	SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG = &h0002
	SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG = &h0004
	SDL_GL_CONTEXT_RESET_ISOLATION_FLAG = &h0008
end enum

declare function SDL_GetNumVideoDrivers() as long
declare function SDL_GetVideoDriver(byval index as long) as const zstring ptr
declare function SDL_VideoInit(byval driver_name as const zstring ptr) as long
declare sub SDL_VideoQuit()
declare function SDL_GetCurrentVideoDriver() as const zstring ptr
declare function SDL_GetNumVideoDisplays() as long
declare function SDL_GetDisplayName(byval displayIndex as long) as const zstring ptr
declare function SDL_GetDisplayBounds(byval displayIndex as long, byval rect as SDL_Rect ptr) as long
declare function SDL_GetNumDisplayModes(byval displayIndex as long) as long
declare function SDL_GetDisplayMode(byval displayIndex as long, byval modeIndex as long, byval mode as SDL_DisplayMode ptr) as long
declare function SDL_GetDesktopDisplayMode(byval displayIndex as long, byval mode as SDL_DisplayMode ptr) as long
declare function SDL_GetCurrentDisplayMode(byval displayIndex as long, byval mode as SDL_DisplayMode ptr) as long
declare function SDL_GetClosestDisplayMode(byval displayIndex as long, byval mode as const SDL_DisplayMode ptr, byval closest as SDL_DisplayMode ptr) as SDL_DisplayMode ptr
type SDL_Window as SDL_Window_
declare function SDL_GetWindowDisplayIndex(byval window as SDL_Window ptr) as long
declare function SDL_SetWindowDisplayMode(byval window as SDL_Window ptr, byval mode as const SDL_DisplayMode ptr) as long
declare function SDL_GetWindowDisplayMode(byval window as SDL_Window ptr, byval mode as SDL_DisplayMode ptr) as long
declare function SDL_GetWindowPixelFormat(byval window as SDL_Window ptr) as Uint32
declare function SDL_CreateWindow(byval title as const zstring ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval flags as Uint32) as SDL_Window ptr
declare function SDL_CreateWindowFrom(byval data as const any ptr) as SDL_Window ptr
declare function SDL_GetWindowID(byval window as SDL_Window ptr) as Uint32
declare function SDL_GetWindowFromID(byval id as Uint32) as SDL_Window ptr
declare function SDL_GetWindowFlags(byval window as SDL_Window ptr) as Uint32
declare sub SDL_SetWindowTitle(byval window as SDL_Window ptr, byval title as const zstring ptr)
declare function SDL_GetWindowTitle(byval window as SDL_Window ptr) as const zstring ptr
declare sub SDL_SetWindowIcon(byval window as SDL_Window ptr, byval icon as SDL_Surface ptr)
declare function SDL_SetWindowData(byval window as SDL_Window ptr, byval name as const zstring ptr, byval userdata as any ptr) as any ptr
declare function SDL_GetWindowData(byval window as SDL_Window ptr, byval name as const zstring ptr) as any ptr
declare sub SDL_SetWindowPosition(byval window as SDL_Window ptr, byval x as long, byval y as long)
declare sub SDL_GetWindowPosition(byval window as SDL_Window ptr, byval x as long ptr, byval y as long ptr)
declare sub SDL_SetWindowSize(byval window as SDL_Window ptr, byval w as long, byval h as long)
declare sub SDL_GetWindowSize(byval window as SDL_Window ptr, byval w as long ptr, byval h as long ptr)
declare sub SDL_SetWindowMinimumSize(byval window as SDL_Window ptr, byval min_w as long, byval min_h as long)
declare sub SDL_GetWindowMinimumSize(byval window as SDL_Window ptr, byval w as long ptr, byval h as long ptr)
declare sub SDL_SetWindowMaximumSize(byval window as SDL_Window ptr, byval max_w as long, byval max_h as long)
declare sub SDL_GetWindowMaximumSize(byval window as SDL_Window ptr, byval w as long ptr, byval h as long ptr)
declare sub SDL_SetWindowBordered(byval window as SDL_Window ptr, byval bordered as SDL_bool)
declare sub SDL_ShowWindow(byval window as SDL_Window ptr)
declare sub SDL_HideWindow(byval window as SDL_Window ptr)
declare sub SDL_RaiseWindow(byval window as SDL_Window ptr)
declare sub SDL_MaximizeWindow(byval window as SDL_Window ptr)
declare sub SDL_MinimizeWindow(byval window as SDL_Window ptr)
declare sub SDL_RestoreWindow(byval window as SDL_Window ptr)
declare function SDL_SetWindowFullscreen(byval window as SDL_Window ptr, byval flags as Uint32) as long
declare function SDL_GetWindowSurface(byval window as SDL_Window ptr) as SDL_Surface ptr
declare function SDL_UpdateWindowSurface(byval window as SDL_Window ptr) as long
declare function SDL_UpdateWindowSurfaceRects(byval window as SDL_Window ptr, byval rects as const SDL_Rect ptr, byval numrects as long) as long
declare sub SDL_SetWindowGrab(byval window as SDL_Window ptr, byval grabbed as SDL_bool)
declare function SDL_GetWindowGrab(byval window as SDL_Window ptr) as SDL_bool
declare function SDL_SetWindowBrightness(byval window as SDL_Window ptr, byval brightness as single) as long
declare function SDL_GetWindowBrightness(byval window as SDL_Window ptr) as single
declare function SDL_SetWindowGammaRamp(byval window as SDL_Window ptr, byval red as const Uint16 ptr, byval green as const Uint16 ptr, byval blue as const Uint16 ptr) as long
declare function SDL_GetWindowGammaRamp(byval window as SDL_Window ptr, byval red as Uint16 ptr, byval green as Uint16 ptr, byval blue as Uint16 ptr) as long
declare sub SDL_DestroyWindow(byval window as SDL_Window ptr)
declare function SDL_IsScreenSaverEnabled() as SDL_bool
declare sub SDL_EnableScreenSaver()
declare sub SDL_DisableScreenSaver()
declare function SDL_GL_LoadLibrary(byval path as const zstring ptr) as long
declare function SDL_GL_GetProcAddress(byval proc as const zstring ptr) as any ptr
declare sub SDL_GL_UnloadLibrary()
declare function SDL_GL_ExtensionSupported(byval extension as const zstring ptr) as SDL_bool
declare sub SDL_GL_ResetAttributes()
declare function SDL_GL_SetAttribute(byval attr as SDL_GLattr, byval value as long) as long
declare function SDL_GL_GetAttribute(byval attr as SDL_GLattr, byval value as long ptr) as long
declare function SDL_GL_CreateContext(byval window as SDL_Window ptr) as SDL_GLContext
declare function SDL_GL_MakeCurrent(byval window as SDL_Window ptr, byval context as SDL_GLContext) as long
declare function SDL_GL_GetCurrentWindow() as SDL_Window ptr
declare function SDL_GL_GetCurrentContext() as SDL_GLContext
declare sub SDL_GL_GetDrawableSize(byval window as SDL_Window ptr, byval w as long ptr, byval h as long ptr)
declare function SDL_GL_SetSwapInterval(byval interval as long) as long
declare function SDL_GL_GetSwapInterval() as long
declare sub SDL_GL_SwapWindow(byval window as SDL_Window ptr)
declare sub SDL_GL_DeleteContext(byval context as SDL_GLContext)

#define _SDL_keyboard_h
#define _SDL_keycode_h
#define _SDL_scancode_h

type SDL_Scancode as long
enum
	SDL_SCANCODE_UNKNOWN = 0
	SDL_SCANCODE_A = 4
	SDL_SCANCODE_B = 5
	SDL_SCANCODE_C = 6
	SDL_SCANCODE_D = 7
	SDL_SCANCODE_E = 8
	SDL_SCANCODE_F = 9
	SDL_SCANCODE_G = 10
	SDL_SCANCODE_H = 11
	SDL_SCANCODE_I = 12
	SDL_SCANCODE_J = 13
	SDL_SCANCODE_K = 14
	SDL_SCANCODE_L = 15
	SDL_SCANCODE_M = 16
	SDL_SCANCODE_N = 17
	SDL_SCANCODE_O = 18
	SDL_SCANCODE_P = 19
	SDL_SCANCODE_Q = 20
	SDL_SCANCODE_R = 21
	SDL_SCANCODE_S = 22
	SDL_SCANCODE_T = 23
	SDL_SCANCODE_U = 24
	SDL_SCANCODE_V = 25
	SDL_SCANCODE_W = 26
	SDL_SCANCODE_X = 27
	SDL_SCANCODE_Y = 28
	SDL_SCANCODE_Z = 29
	SDL_SCANCODE_1 = 30
	SDL_SCANCODE_2 = 31
	SDL_SCANCODE_3 = 32
	SDL_SCANCODE_4 = 33
	SDL_SCANCODE_5 = 34
	SDL_SCANCODE_6 = 35
	SDL_SCANCODE_7 = 36
	SDL_SCANCODE_8 = 37
	SDL_SCANCODE_9 = 38
	SDL_SCANCODE_0 = 39
	SDL_SCANCODE_RETURN = 40
	SDL_SCANCODE_ESCAPE = 41
	SDL_SCANCODE_BACKSPACE = 42
	SDL_SCANCODE_TAB = 43
	SDL_SCANCODE_SPACE = 44
	SDL_SCANCODE_MINUS = 45
	SDL_SCANCODE_EQUALS = 46
	SDL_SCANCODE_LEFTBRACKET = 47
	SDL_SCANCODE_RIGHTBRACKET = 48
	SDL_SCANCODE_BACKSLASH = 49
	SDL_SCANCODE_NONUSHASH = 50
	SDL_SCANCODE_SEMICOLON = 51
	SDL_SCANCODE_APOSTROPHE = 52
	SDL_SCANCODE_GRAVE = 53
	SDL_SCANCODE_COMMA = 54
	SDL_SCANCODE_PERIOD = 55
	SDL_SCANCODE_SLASH = 56
	SDL_SCANCODE_CAPSLOCK = 57
	SDL_SCANCODE_F1 = 58
	SDL_SCANCODE_F2 = 59
	SDL_SCANCODE_F3 = 60
	SDL_SCANCODE_F4 = 61
	SDL_SCANCODE_F5 = 62
	SDL_SCANCODE_F6 = 63
	SDL_SCANCODE_F7 = 64
	SDL_SCANCODE_F8 = 65
	SDL_SCANCODE_F9 = 66
	SDL_SCANCODE_F10 = 67
	SDL_SCANCODE_F11 = 68
	SDL_SCANCODE_F12 = 69
	SDL_SCANCODE_PRINTSCREEN = 70
	SDL_SCANCODE_SCROLLLOCK = 71
	SDL_SCANCODE_PAUSE = 72
	SDL_SCANCODE_INSERT = 73
	SDL_SCANCODE_HOME = 74
	SDL_SCANCODE_PAGEUP = 75
	SDL_SCANCODE_DELETE = 76
	SDL_SCANCODE_END = 77
	SDL_SCANCODE_PAGEDOWN = 78
	SDL_SCANCODE_RIGHT = 79
	SDL_SCANCODE_LEFT = 80
	SDL_SCANCODE_DOWN = 81
	SDL_SCANCODE_UP = 82
	SDL_SCANCODE_NUMLOCKCLEAR = 83
	SDL_SCANCODE_KP_DIVIDE = 84
	SDL_SCANCODE_KP_MULTIPLY = 85
	SDL_SCANCODE_KP_MINUS = 86
	SDL_SCANCODE_KP_PLUS = 87
	SDL_SCANCODE_KP_ENTER = 88
	SDL_SCANCODE_KP_1 = 89
	SDL_SCANCODE_KP_2 = 90
	SDL_SCANCODE_KP_3 = 91
	SDL_SCANCODE_KP_4 = 92
	SDL_SCANCODE_KP_5 = 93
	SDL_SCANCODE_KP_6 = 94
	SDL_SCANCODE_KP_7 = 95
	SDL_SCANCODE_KP_8 = 96
	SDL_SCANCODE_KP_9 = 97
	SDL_SCANCODE_KP_0 = 98
	SDL_SCANCODE_KP_PERIOD = 99
	SDL_SCANCODE_NONUSBACKSLASH = 100
	SDL_SCANCODE_APPLICATION = 101
	SDL_SCANCODE_POWER = 102
	SDL_SCANCODE_KP_EQUALS = 103
	SDL_SCANCODE_F13 = 104
	SDL_SCANCODE_F14 = 105
	SDL_SCANCODE_F15 = 106
	SDL_SCANCODE_F16 = 107
	SDL_SCANCODE_F17 = 108
	SDL_SCANCODE_F18 = 109
	SDL_SCANCODE_F19 = 110
	SDL_SCANCODE_F20 = 111
	SDL_SCANCODE_F21 = 112
	SDL_SCANCODE_F22 = 113
	SDL_SCANCODE_F23 = 114
	SDL_SCANCODE_F24 = 115
	SDL_SCANCODE_EXECUTE = 116
	SDL_SCANCODE_HELP = 117
	SDL_SCANCODE_MENU = 118
	SDL_SCANCODE_SELECT = 119
	SDL_SCANCODE_STOP = 120
	SDL_SCANCODE_AGAIN = 121
	SDL_SCANCODE_UNDO = 122
	SDL_SCANCODE_CUT = 123
	SDL_SCANCODE_COPY = 124
	SDL_SCANCODE_PASTE = 125
	SDL_SCANCODE_FIND = 126
	SDL_SCANCODE_MUTE = 127
	SDL_SCANCODE_VOLUMEUP = 128
	SDL_SCANCODE_VOLUMEDOWN = 129
	SDL_SCANCODE_KP_COMMA = 133
	SDL_SCANCODE_KP_EQUALSAS400 = 134
	SDL_SCANCODE_INTERNATIONAL1 = 135
	SDL_SCANCODE_INTERNATIONAL2 = 136
	SDL_SCANCODE_INTERNATIONAL3 = 137
	SDL_SCANCODE_INTERNATIONAL4 = 138
	SDL_SCANCODE_INTERNATIONAL5 = 139
	SDL_SCANCODE_INTERNATIONAL6 = 140
	SDL_SCANCODE_INTERNATIONAL7 = 141
	SDL_SCANCODE_INTERNATIONAL8 = 142
	SDL_SCANCODE_INTERNATIONAL9 = 143
	SDL_SCANCODE_LANG1 = 144
	SDL_SCANCODE_LANG2 = 145
	SDL_SCANCODE_LANG3 = 146
	SDL_SCANCODE_LANG4 = 147
	SDL_SCANCODE_LANG5 = 148
	SDL_SCANCODE_LANG6 = 149
	SDL_SCANCODE_LANG7 = 150
	SDL_SCANCODE_LANG8 = 151
	SDL_SCANCODE_LANG9 = 152
	SDL_SCANCODE_ALTERASE = 153
	SDL_SCANCODE_SYSREQ = 154
	SDL_SCANCODE_CANCEL = 155
	SDL_SCANCODE_CLEAR = 156
	SDL_SCANCODE_PRIOR = 157
	SDL_SCANCODE_RETURN2 = 158
	SDL_SCANCODE_SEPARATOR = 159
	SDL_SCANCODE_OUT = 160
	SDL_SCANCODE_OPER = 161
	SDL_SCANCODE_CLEARAGAIN = 162
	SDL_SCANCODE_CRSEL = 163
	SDL_SCANCODE_EXSEL = 164
	SDL_SCANCODE_KP_00 = 176
	SDL_SCANCODE_KP_000 = 177
	SDL_SCANCODE_THOUSANDSSEPARATOR = 178
	SDL_SCANCODE_DECIMALSEPARATOR = 179
	SDL_SCANCODE_CURRENCYUNIT = 180
	SDL_SCANCODE_CURRENCYSUBUNIT = 181
	SDL_SCANCODE_KP_LEFTPAREN = 182
	SDL_SCANCODE_KP_RIGHTPAREN = 183
	SDL_SCANCODE_KP_LEFTBRACE = 184
	SDL_SCANCODE_KP_RIGHTBRACE = 185
	SDL_SCANCODE_KP_TAB = 186
	SDL_SCANCODE_KP_BACKSPACE = 187
	SDL_SCANCODE_KP_A = 188
	SDL_SCANCODE_KP_B = 189
	SDL_SCANCODE_KP_C = 190
	SDL_SCANCODE_KP_D = 191
	SDL_SCANCODE_KP_E = 192
	SDL_SCANCODE_KP_F = 193
	SDL_SCANCODE_KP_XOR = 194
	SDL_SCANCODE_KP_POWER = 195
	SDL_SCANCODE_KP_PERCENT = 196
	SDL_SCANCODE_KP_LESS = 197
	SDL_SCANCODE_KP_GREATER = 198
	SDL_SCANCODE_KP_AMPERSAND = 199
	SDL_SCANCODE_KP_DBLAMPERSAND = 200
	SDL_SCANCODE_KP_VERTICALBAR = 201
	SDL_SCANCODE_KP_DBLVERTICALBAR = 202
	SDL_SCANCODE_KP_COLON = 203
	SDL_SCANCODE_KP_HASH = 204
	SDL_SCANCODE_KP_SPACE = 205
	SDL_SCANCODE_KP_AT = 206
	SDL_SCANCODE_KP_EXCLAM = 207
	SDL_SCANCODE_KP_MEMSTORE = 208
	SDL_SCANCODE_KP_MEMRECALL = 209
	SDL_SCANCODE_KP_MEMCLEAR = 210
	SDL_SCANCODE_KP_MEMADD = 211
	SDL_SCANCODE_KP_MEMSUBTRACT = 212
	SDL_SCANCODE_KP_MEMMULTIPLY = 213
	SDL_SCANCODE_KP_MEMDIVIDE = 214
	SDL_SCANCODE_KP_PLUSMINUS = 215
	SDL_SCANCODE_KP_CLEAR = 216
	SDL_SCANCODE_KP_CLEARENTRY = 217
	SDL_SCANCODE_KP_BINARY = 218
	SDL_SCANCODE_KP_OCTAL = 219
	SDL_SCANCODE_KP_DECIMAL = 220
	SDL_SCANCODE_KP_HEXADECIMAL = 221
	SDL_SCANCODE_LCTRL = 224
	SDL_SCANCODE_LSHIFT = 225
	SDL_SCANCODE_LALT = 226
	SDL_SCANCODE_LGUI = 227
	SDL_SCANCODE_RCTRL = 228
	SDL_SCANCODE_RSHIFT = 229
	SDL_SCANCODE_RALT = 230
	SDL_SCANCODE_RGUI = 231
	SDL_SCANCODE_MODE = 257
	SDL_SCANCODE_AUDIONEXT = 258
	SDL_SCANCODE_AUDIOPREV = 259
	SDL_SCANCODE_AUDIOSTOP = 260
	SDL_SCANCODE_AUDIOPLAY = 261
	SDL_SCANCODE_AUDIOMUTE = 262
	SDL_SCANCODE_MEDIASELECT = 263
	SDL_SCANCODE_WWW = 264
	SDL_SCANCODE_MAIL = 265
	SDL_SCANCODE_CALCULATOR = 266
	SDL_SCANCODE_COMPUTER = 267
	SDL_SCANCODE_AC_SEARCH = 268
	SDL_SCANCODE_AC_HOME = 269
	SDL_SCANCODE_AC_BACK = 270
	SDL_SCANCODE_AC_FORWARD = 271
	SDL_SCANCODE_AC_STOP = 272
	SDL_SCANCODE_AC_REFRESH = 273
	SDL_SCANCODE_AC_BOOKMARKS = 274
	SDL_SCANCODE_BRIGHTNESSDOWN = 275
	SDL_SCANCODE_BRIGHTNESSUP = 276
	SDL_SCANCODE_DISPLAYSWITCH = 277
	SDL_SCANCODE_KBDILLUMTOGGLE = 278
	SDL_SCANCODE_KBDILLUMDOWN = 279
	SDL_SCANCODE_KBDILLUMUP = 280
	SDL_SCANCODE_EJECT = 281
	SDL_SCANCODE_SLEEP = 282
	SDL_SCANCODE_APP1 = 283
	SDL_SCANCODE_APP2 = 284
	SDL_NUM_SCANCODES = 512
end enum

type SDL_Keycode as Sint32
const SDLK_SCANCODE_MASK = 1 shl 30
#define SDL_SCANCODE_TO_KEYCODE(X) (X or SDLK_SCANCODE_MASK)

enum
	SDLK_UNKNOWN = 0
	SDLK_RETURN = asc(!"\r")
	SDLK_ESCAPE = asc(!"\27")
	SDLK_BACKSPACE = asc(!"\b")
	SDLK_TAB = asc(!"\t")
	SDLK_SPACE = asc(" ")
	SDLK_EXCLAIM = asc("!")
	SDLK_QUOTEDBL = asc("""")
	SDLK_HASH = asc("#")
	SDLK_PERCENT = asc("%")
	SDLK_DOLLAR = asc("$")
	SDLK_AMPERSAND = asc("&")
	SDLK_QUOTE = asc("'")
	SDLK_LEFTPAREN = asc("(")
	SDLK_RIGHTPAREN = asc(")")
	SDLK_ASTERISK = asc("*")
	SDLK_PLUS = asc("+")
	SDLK_COMMA = asc(",")
	SDLK_MINUS = asc("-")
	SDLK_PERIOD = asc(".")
	SDLK_SLASH = asc("/")
	SDLK_0 = asc("0")
	SDLK_1 = asc("1")
	SDLK_2 = asc("2")
	SDLK_3 = asc("3")
	SDLK_4 = asc("4")
	SDLK_5 = asc("5")
	SDLK_6 = asc("6")
	SDLK_7 = asc("7")
	SDLK_8 = asc("8")
	SDLK_9 = asc("9")
	SDLK_COLON = asc(":")
	SDLK_SEMICOLON = asc(";")
	SDLK_LESS = asc("<")
	SDLK_EQUALS = asc("=")
	SDLK_GREATER = asc(">")
	SDLK_QUESTION = asc("?")
	SDLK_AT = asc("@")
	SDLK_LEFTBRACKET = asc("[")
	SDLK_BACKSLASH = asc(!"\\")
	SDLK_RIGHTBRACKET = asc("]")
	SDLK_CARET = asc("^")
	SDLK_UNDERSCORE = asc("_")
	SDLK_BACKQUOTE = asc("`")
	SDLK_a = asc("a")
	SDLK_b = asc("b")
	SDLK_c = asc("c")
	SDLK_d = asc("d")
	SDLK_e = asc("e")
	SDLK_f = asc("f")
	SDLK_g = asc("g")
	SDLK_h = asc("h")
	SDLK_i = asc("i")
	SDLK_j = asc("j")
	SDLK_k = asc("k")
	SDLK_l = asc("l")
	SDLK_m = asc("m")
	SDLK_n = asc("n")
	SDLK_o = asc("o")
	SDLK_p = asc("p")
	SDLK_q = asc("q")
	SDLK_r = asc("r")
	SDLK_s = asc("s")
	SDLK_t = asc("t")
	SDLK_u = asc("u")
	SDLK_v = asc("v")
	SDLK_w = asc("w")
	SDLK_x = asc("x")
	SDLK_y = asc("y")
	SDLK_z = asc("z")
	SDLK_CAPSLOCK = SDL_SCANCODE_CAPSLOCK or (1 shl 30)
	SDLK_F1 = SDL_SCANCODE_F1 or (1 shl 30)
	SDLK_F2 = SDL_SCANCODE_F2 or (1 shl 30)
	SDLK_F3 = SDL_SCANCODE_F3 or (1 shl 30)
	SDLK_F4 = SDL_SCANCODE_F4 or (1 shl 30)
	SDLK_F5 = SDL_SCANCODE_F5 or (1 shl 30)
	SDLK_F6 = SDL_SCANCODE_F6 or (1 shl 30)
	SDLK_F7 = SDL_SCANCODE_F7 or (1 shl 30)
	SDLK_F8 = SDL_SCANCODE_F8 or (1 shl 30)
	SDLK_F9 = SDL_SCANCODE_F9 or (1 shl 30)
	SDLK_F10 = SDL_SCANCODE_F10 or (1 shl 30)
	SDLK_F11 = SDL_SCANCODE_F11 or (1 shl 30)
	SDLK_F12 = SDL_SCANCODE_F12 or (1 shl 30)
	SDLK_PRINTSCREEN = SDL_SCANCODE_PRINTSCREEN or (1 shl 30)
	SDLK_SCROLLLOCK = SDL_SCANCODE_SCROLLLOCK or (1 shl 30)
	SDLK_PAUSE = SDL_SCANCODE_PAUSE or (1 shl 30)
	SDLK_INSERT = SDL_SCANCODE_INSERT or (1 shl 30)
	SDLK_HOME = SDL_SCANCODE_HOME or (1 shl 30)
	SDLK_PAGEUP = SDL_SCANCODE_PAGEUP or (1 shl 30)
	SDLK_DELETE = asc(!"\127")
	SDLK_END = SDL_SCANCODE_END or (1 shl 30)
	SDLK_PAGEDOWN = SDL_SCANCODE_PAGEDOWN or (1 shl 30)
	SDLK_RIGHT = SDL_SCANCODE_RIGHT or (1 shl 30)
	SDLK_LEFT = SDL_SCANCODE_LEFT or (1 shl 30)
	SDLK_DOWN = SDL_SCANCODE_DOWN or (1 shl 30)
	SDLK_UP = SDL_SCANCODE_UP or (1 shl 30)
	SDLK_NUMLOCKCLEAR = SDL_SCANCODE_NUMLOCKCLEAR or (1 shl 30)
	SDLK_KP_DIVIDE = SDL_SCANCODE_KP_DIVIDE or (1 shl 30)
	SDLK_KP_MULTIPLY = SDL_SCANCODE_KP_MULTIPLY or (1 shl 30)
	SDLK_KP_MINUS = SDL_SCANCODE_KP_MINUS or (1 shl 30)
	SDLK_KP_PLUS = SDL_SCANCODE_KP_PLUS or (1 shl 30)
	SDLK_KP_ENTER = SDL_SCANCODE_KP_ENTER or (1 shl 30)
	SDLK_KP_1 = SDL_SCANCODE_KP_1 or (1 shl 30)
	SDLK_KP_2 = SDL_SCANCODE_KP_2 or (1 shl 30)
	SDLK_KP_3 = SDL_SCANCODE_KP_3 or (1 shl 30)
	SDLK_KP_4 = SDL_SCANCODE_KP_4 or (1 shl 30)
	SDLK_KP_5 = SDL_SCANCODE_KP_5 or (1 shl 30)
	SDLK_KP_6 = SDL_SCANCODE_KP_6 or (1 shl 30)
	SDLK_KP_7 = SDL_SCANCODE_KP_7 or (1 shl 30)
	SDLK_KP_8 = SDL_SCANCODE_KP_8 or (1 shl 30)
	SDLK_KP_9 = SDL_SCANCODE_KP_9 or (1 shl 30)
	SDLK_KP_0 = SDL_SCANCODE_KP_0 or (1 shl 30)
	SDLK_KP_PERIOD = SDL_SCANCODE_KP_PERIOD or (1 shl 30)
	SDLK_APPLICATION = SDL_SCANCODE_APPLICATION or (1 shl 30)
	SDLK_POWER = SDL_SCANCODE_POWER or (1 shl 30)
	SDLK_KP_EQUALS = SDL_SCANCODE_KP_EQUALS or (1 shl 30)
	SDLK_F13 = SDL_SCANCODE_F13 or (1 shl 30)
	SDLK_F14 = SDL_SCANCODE_F14 or (1 shl 30)
	SDLK_F15 = SDL_SCANCODE_F15 or (1 shl 30)
	SDLK_F16 = SDL_SCANCODE_F16 or (1 shl 30)
	SDLK_F17 = SDL_SCANCODE_F17 or (1 shl 30)
	SDLK_F18 = SDL_SCANCODE_F18 or (1 shl 30)
	SDLK_F19 = SDL_SCANCODE_F19 or (1 shl 30)
	SDLK_F20 = SDL_SCANCODE_F20 or (1 shl 30)
	SDLK_F21 = SDL_SCANCODE_F21 or (1 shl 30)
	SDLK_F22 = SDL_SCANCODE_F22 or (1 shl 30)
	SDLK_F23 = SDL_SCANCODE_F23 or (1 shl 30)
	SDLK_F24 = SDL_SCANCODE_F24 or (1 shl 30)
	SDLK_EXECUTE = SDL_SCANCODE_EXECUTE or (1 shl 30)
	SDLK_HELP = SDL_SCANCODE_HELP or (1 shl 30)
	SDLK_MENU = SDL_SCANCODE_MENU or (1 shl 30)
	SDLK_SELECT = SDL_SCANCODE_SELECT or (1 shl 30)
	SDLK_STOP = SDL_SCANCODE_STOP or (1 shl 30)
	SDLK_AGAIN = SDL_SCANCODE_AGAIN or (1 shl 30)
	SDLK_UNDO = SDL_SCANCODE_UNDO or (1 shl 30)
	SDLK_CUT = SDL_SCANCODE_CUT or (1 shl 30)
	SDLK_COPY = SDL_SCANCODE_COPY or (1 shl 30)
	SDLK_PASTE = SDL_SCANCODE_PASTE or (1 shl 30)
	SDLK_FIND = SDL_SCANCODE_FIND or (1 shl 30)
	SDLK_MUTE = SDL_SCANCODE_MUTE or (1 shl 30)
	SDLK_VOLUMEUP = SDL_SCANCODE_VOLUMEUP or (1 shl 30)
	SDLK_VOLUMEDOWN = SDL_SCANCODE_VOLUMEDOWN or (1 shl 30)
	SDLK_KP_COMMA = SDL_SCANCODE_KP_COMMA or (1 shl 30)
	SDLK_KP_EQUALSAS400 = SDL_SCANCODE_KP_EQUALSAS400 or (1 shl 30)
	SDLK_ALTERASE = SDL_SCANCODE_ALTERASE or (1 shl 30)
	SDLK_SYSREQ = SDL_SCANCODE_SYSREQ or (1 shl 30)
	SDLK_CANCEL = SDL_SCANCODE_CANCEL or (1 shl 30)
	SDLK_CLEAR = SDL_SCANCODE_CLEAR or (1 shl 30)
	SDLK_PRIOR = SDL_SCANCODE_PRIOR or (1 shl 30)
	SDLK_RETURN2 = SDL_SCANCODE_RETURN2 or (1 shl 30)
	SDLK_SEPARATOR = SDL_SCANCODE_SEPARATOR or (1 shl 30)
	SDLK_OUT = SDL_SCANCODE_OUT or (1 shl 30)
	SDLK_OPER = SDL_SCANCODE_OPER or (1 shl 30)
	SDLK_CLEARAGAIN = SDL_SCANCODE_CLEARAGAIN or (1 shl 30)
	SDLK_CRSEL = SDL_SCANCODE_CRSEL or (1 shl 30)
	SDLK_EXSEL = SDL_SCANCODE_EXSEL or (1 shl 30)
	SDLK_KP_00 = SDL_SCANCODE_KP_00 or (1 shl 30)
	SDLK_KP_000 = SDL_SCANCODE_KP_000 or (1 shl 30)
	SDLK_THOUSANDSSEPARATOR = SDL_SCANCODE_THOUSANDSSEPARATOR or (1 shl 30)
	SDLK_DECIMALSEPARATOR = SDL_SCANCODE_DECIMALSEPARATOR or (1 shl 30)
	SDLK_CURRENCYUNIT = SDL_SCANCODE_CURRENCYUNIT or (1 shl 30)
	SDLK_CURRENCYSUBUNIT = SDL_SCANCODE_CURRENCYSUBUNIT or (1 shl 30)
	SDLK_KP_LEFTPAREN = SDL_SCANCODE_KP_LEFTPAREN or (1 shl 30)
	SDLK_KP_RIGHTPAREN = SDL_SCANCODE_KP_RIGHTPAREN or (1 shl 30)
	SDLK_KP_LEFTBRACE = SDL_SCANCODE_KP_LEFTBRACE or (1 shl 30)
	SDLK_KP_RIGHTBRACE = SDL_SCANCODE_KP_RIGHTBRACE or (1 shl 30)
	SDLK_KP_TAB = SDL_SCANCODE_KP_TAB or (1 shl 30)
	SDLK_KP_BACKSPACE = SDL_SCANCODE_KP_BACKSPACE or (1 shl 30)
	SDLK_KP_A = SDL_SCANCODE_KP_A or (1 shl 30)
	SDLK_KP_B = SDL_SCANCODE_KP_B or (1 shl 30)
	SDLK_KP_C = SDL_SCANCODE_KP_C or (1 shl 30)
	SDLK_KP_D = SDL_SCANCODE_KP_D or (1 shl 30)
	SDLK_KP_E = SDL_SCANCODE_KP_E or (1 shl 30)
	SDLK_KP_F = SDL_SCANCODE_KP_F or (1 shl 30)
	SDLK_KP_XOR = SDL_SCANCODE_KP_XOR or (1 shl 30)
	SDLK_KP_POWER = SDL_SCANCODE_KP_POWER or (1 shl 30)
	SDLK_KP_PERCENT = SDL_SCANCODE_KP_PERCENT or (1 shl 30)
	SDLK_KP_LESS = SDL_SCANCODE_KP_LESS or (1 shl 30)
	SDLK_KP_GREATER = SDL_SCANCODE_KP_GREATER or (1 shl 30)
	SDLK_KP_AMPERSAND = SDL_SCANCODE_KP_AMPERSAND or (1 shl 30)
	SDLK_KP_DBLAMPERSAND = SDL_SCANCODE_KP_DBLAMPERSAND or (1 shl 30)
	SDLK_KP_VERTICALBAR = SDL_SCANCODE_KP_VERTICALBAR or (1 shl 30)
	SDLK_KP_DBLVERTICALBAR = SDL_SCANCODE_KP_DBLVERTICALBAR or (1 shl 30)
	SDLK_KP_COLON = SDL_SCANCODE_KP_COLON or (1 shl 30)
	SDLK_KP_HASH = SDL_SCANCODE_KP_HASH or (1 shl 30)
	SDLK_KP_SPACE = SDL_SCANCODE_KP_SPACE or (1 shl 30)
	SDLK_KP_AT = SDL_SCANCODE_KP_AT or (1 shl 30)
	SDLK_KP_EXCLAM = SDL_SCANCODE_KP_EXCLAM or (1 shl 30)
	SDLK_KP_MEMSTORE = SDL_SCANCODE_KP_MEMSTORE or (1 shl 30)
	SDLK_KP_MEMRECALL = SDL_SCANCODE_KP_MEMRECALL or (1 shl 30)
	SDLK_KP_MEMCLEAR = SDL_SCANCODE_KP_MEMCLEAR or (1 shl 30)
	SDLK_KP_MEMADD = SDL_SCANCODE_KP_MEMADD or (1 shl 30)
	SDLK_KP_MEMSUBTRACT = SDL_SCANCODE_KP_MEMSUBTRACT or (1 shl 30)
	SDLK_KP_MEMMULTIPLY = SDL_SCANCODE_KP_MEMMULTIPLY or (1 shl 30)
	SDLK_KP_MEMDIVIDE = SDL_SCANCODE_KP_MEMDIVIDE or (1 shl 30)
	SDLK_KP_PLUSMINUS = SDL_SCANCODE_KP_PLUSMINUS or (1 shl 30)
	SDLK_KP_CLEAR = SDL_SCANCODE_KP_CLEAR or (1 shl 30)
	SDLK_KP_CLEARENTRY = SDL_SCANCODE_KP_CLEARENTRY or (1 shl 30)
	SDLK_KP_BINARY = SDL_SCANCODE_KP_BINARY or (1 shl 30)
	SDLK_KP_OCTAL = SDL_SCANCODE_KP_OCTAL or (1 shl 30)
	SDLK_KP_DECIMAL = SDL_SCANCODE_KP_DECIMAL or (1 shl 30)
	SDLK_KP_HEXADECIMAL = SDL_SCANCODE_KP_HEXADECIMAL or (1 shl 30)
	SDLK_LCTRL = SDL_SCANCODE_LCTRL or (1 shl 30)
	SDLK_LSHIFT = SDL_SCANCODE_LSHIFT or (1 shl 30)
	SDLK_LALT = SDL_SCANCODE_LALT or (1 shl 30)
	SDLK_LGUI = SDL_SCANCODE_LGUI or (1 shl 30)
	SDLK_RCTRL = SDL_SCANCODE_RCTRL or (1 shl 30)
	SDLK_RSHIFT = SDL_SCANCODE_RSHIFT or (1 shl 30)
	SDLK_RALT = SDL_SCANCODE_RALT or (1 shl 30)
	SDLK_RGUI = SDL_SCANCODE_RGUI or (1 shl 30)
	SDLK_MODE = SDL_SCANCODE_MODE or (1 shl 30)
	SDLK_AUDIONEXT = SDL_SCANCODE_AUDIONEXT or (1 shl 30)
	SDLK_AUDIOPREV = SDL_SCANCODE_AUDIOPREV or (1 shl 30)
	SDLK_AUDIOSTOP = SDL_SCANCODE_AUDIOSTOP or (1 shl 30)
	SDLK_AUDIOPLAY = SDL_SCANCODE_AUDIOPLAY or (1 shl 30)
	SDLK_AUDIOMUTE = SDL_SCANCODE_AUDIOMUTE or (1 shl 30)
	SDLK_MEDIASELECT = SDL_SCANCODE_MEDIASELECT or (1 shl 30)
	SDLK_WWW = SDL_SCANCODE_WWW or (1 shl 30)
	SDLK_MAIL = SDL_SCANCODE_MAIL or (1 shl 30)
	SDLK_CALCULATOR = SDL_SCANCODE_CALCULATOR or (1 shl 30)
	SDLK_COMPUTER = SDL_SCANCODE_COMPUTER or (1 shl 30)
	SDLK_AC_SEARCH = SDL_SCANCODE_AC_SEARCH or (1 shl 30)
	SDLK_AC_HOME = SDL_SCANCODE_AC_HOME or (1 shl 30)
	SDLK_AC_BACK = SDL_SCANCODE_AC_BACK or (1 shl 30)
	SDLK_AC_FORWARD = SDL_SCANCODE_AC_FORWARD or (1 shl 30)
	SDLK_AC_STOP = SDL_SCANCODE_AC_STOP or (1 shl 30)
	SDLK_AC_REFRESH = SDL_SCANCODE_AC_REFRESH or (1 shl 30)
	SDLK_AC_BOOKMARKS = SDL_SCANCODE_AC_BOOKMARKS or (1 shl 30)
	SDLK_BRIGHTNESSDOWN = SDL_SCANCODE_BRIGHTNESSDOWN or (1 shl 30)
	SDLK_BRIGHTNESSUP = SDL_SCANCODE_BRIGHTNESSUP or (1 shl 30)
	SDLK_DISPLAYSWITCH = SDL_SCANCODE_DISPLAYSWITCH or (1 shl 30)
	SDLK_KBDILLUMTOGGLE = SDL_SCANCODE_KBDILLUMTOGGLE or (1 shl 30)
	SDLK_KBDILLUMDOWN = SDL_SCANCODE_KBDILLUMDOWN or (1 shl 30)
	SDLK_KBDILLUMUP = SDL_SCANCODE_KBDILLUMUP or (1 shl 30)
	SDLK_EJECT = SDL_SCANCODE_EJECT or (1 shl 30)
	SDLK_SLEEP = SDL_SCANCODE_SLEEP or (1 shl 30)
end enum

type SDL_Keymod as long
enum
	KMOD_NONE = &h0000
	KMOD_LSHIFT = &h0001
	KMOD_RSHIFT = &h0002
	KMOD_LCTRL = &h0040
	KMOD_RCTRL = &h0080
	KMOD_LALT = &h0100
	KMOD_RALT = &h0200
	KMOD_LGUI = &h0400
	KMOD_RGUI = &h0800
	KMOD_NUM = &h1000
	KMOD_CAPS = &h2000
	KMOD_MODE = &h4000
	KMOD_RESERVED = &h8000
end enum

#define KMOD_CTRL (KMOD_LCTRL or KMOD_RCTRL)
#define KMOD_SHIFT (KMOD_LSHIFT or KMOD_RSHIFT)
#define KMOD_ALT (KMOD_LALT or KMOD_RALT)
#define KMOD_GUI (KMOD_LGUI or KMOD_RGUI)

type SDL_Keysym
	scancode as SDL_Scancode
	sym as SDL_Keycode
	mod_ as Uint16
	unused as Uint32
end type

declare function SDL_GetKeyboardFocus() as SDL_Window ptr
declare function SDL_GetKeyboardState(byval numkeys as long ptr) as const Uint8 ptr
declare function SDL_GetModState() as SDL_Keymod
declare sub SDL_SetModState(byval modstate as SDL_Keymod)
declare function SDL_GetKeyFromScancode(byval scancode as SDL_Scancode) as SDL_Keycode
declare function SDL_GetScancodeFromKey(byval key as SDL_Keycode) as SDL_Scancode
declare function SDL_GetScancodeName(byval scancode as SDL_Scancode) as const zstring ptr
declare function SDL_GetScancodeFromName(byval name as const zstring ptr) as SDL_Scancode
declare function SDL_GetKeyName(byval key as SDL_Keycode) as const zstring ptr
declare function SDL_GetKeyFromName(byval name as const zstring ptr) as SDL_Keycode
declare sub SDL_StartTextInput()
declare function SDL_IsTextInputActive() as SDL_bool
declare sub SDL_StopTextInput()
declare sub SDL_SetTextInputRect(byval rect as SDL_Rect ptr)
declare function SDL_HasScreenKeyboardSupport() as SDL_bool
declare function SDL_IsScreenKeyboardShown(byval window as SDL_Window ptr) as SDL_bool
#define _SDL_mouse_h

type SDL_SystemCursor as long
enum
	SDL_SYSTEM_CURSOR_ARROW
	SDL_SYSTEM_CURSOR_IBEAM
	SDL_SYSTEM_CURSOR_WAIT
	SDL_SYSTEM_CURSOR_CROSSHAIR
	SDL_SYSTEM_CURSOR_WAITARROW
	SDL_SYSTEM_CURSOR_SIZENWSE
	SDL_SYSTEM_CURSOR_SIZENESW
	SDL_SYSTEM_CURSOR_SIZEWE
	SDL_SYSTEM_CURSOR_SIZENS
	SDL_SYSTEM_CURSOR_SIZEALL
	SDL_SYSTEM_CURSOR_NO
	SDL_SYSTEM_CURSOR_HAND
	SDL_NUM_SYSTEM_CURSORS
end enum

declare function SDL_GetMouseFocus() as SDL_Window ptr
declare function SDL_GetMouseState(byval x as long ptr, byval y as long ptr) as Uint32
declare function SDL_GetRelativeMouseState(byval x as long ptr, byval y as long ptr) as Uint32
declare sub SDL_WarpMouseInWindow(byval window as SDL_Window ptr, byval x as long, byval y as long)
declare function SDL_SetRelativeMouseMode(byval enabled as SDL_bool) as long
declare function SDL_GetRelativeMouseMode() as SDL_bool
type SDL_Cursor as SDL_Cursor_
declare function SDL_CreateCursor(byval data as const Uint8 ptr, byval mask as const Uint8 ptr, byval w as long, byval h as long, byval hot_x as long, byval hot_y as long) as SDL_Cursor ptr
declare function SDL_CreateColorCursor(byval surface as SDL_Surface ptr, byval hot_x as long, byval hot_y as long) as SDL_Cursor ptr
declare function SDL_CreateSystemCursor(byval id as SDL_SystemCursor) as SDL_Cursor ptr
declare sub SDL_SetCursor(byval cursor as SDL_Cursor ptr)
declare function SDL_GetCursor() as SDL_Cursor ptr
declare function SDL_GetDefaultCursor() as SDL_Cursor ptr
declare sub SDL_FreeCursor(byval cursor as SDL_Cursor ptr)
declare function SDL_ShowCursor(byval toggle as long) as long

#define SDL_BUTTON(X) (1 shl ((X) - 1))
const SDL_BUTTON_LEFT = 1
const SDL_BUTTON_MIDDLE = 2
const SDL_BUTTON_RIGHT = 3
const SDL_BUTTON_X1 = 4
const SDL_BUTTON_X2 = 5
#define SDL_BUTTON_LMASK SDL_BUTTON(SDL_BUTTON_LEFT)
#define SDL_BUTTON_MMASK SDL_BUTTON(SDL_BUTTON_MIDDLE)
#define SDL_BUTTON_RMASK SDL_BUTTON(SDL_BUTTON_RIGHT)
#define SDL_BUTTON_X1MASK SDL_BUTTON(SDL_BUTTON_X1)
#define SDL_BUTTON_X2MASK SDL_BUTTON(SDL_BUTTON_X2)
#define _SDL_joystick_h
type SDL_Joystick as _SDL_Joystick

type SDL_JoystickGUID
	data(0 to 15) as Uint8
end type

type SDL_JoystickID as Sint32
declare function SDL_NumJoysticks() as long
declare function SDL_JoystickNameForIndex(byval device_index as long) as const zstring ptr
declare function SDL_JoystickOpen(byval device_index as long) as SDL_Joystick ptr
declare function SDL_JoystickName(byval joystick as SDL_Joystick ptr) as const zstring ptr
declare function SDL_JoystickGetDeviceGUID(byval device_index as long) as SDL_JoystickGUID
declare function SDL_JoystickGetGUID(byval joystick as SDL_Joystick ptr) as SDL_JoystickGUID
declare sub SDL_JoystickGetGUIDString(byval guid as SDL_JoystickGUID, byval pszGUID as zstring ptr, byval cbGUID as long)
declare function SDL_JoystickGetGUIDFromString(byval pchGUID as const zstring ptr) as SDL_JoystickGUID
declare function SDL_JoystickGetAttached(byval joystick as SDL_Joystick ptr) as SDL_bool
declare function SDL_JoystickInstanceID(byval joystick as SDL_Joystick ptr) as SDL_JoystickID
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
#define SDL_HAT_RIGHTUP (SDL_HAT_RIGHT or SDL_HAT_UP)
#define SDL_HAT_RIGHTDOWN (SDL_HAT_RIGHT or SDL_HAT_DOWN)
#define SDL_HAT_LEFTUP (SDL_HAT_LEFT or SDL_HAT_UP)
#define SDL_HAT_LEFTDOWN (SDL_HAT_LEFT or SDL_HAT_DOWN)

declare function SDL_JoystickGetHat(byval joystick as SDL_Joystick ptr, byval hat as long) as Uint8
declare function SDL_JoystickGetBall(byval joystick as SDL_Joystick ptr, byval ball as long, byval dx as long ptr, byval dy as long ptr) as long
declare function SDL_JoystickGetButton(byval joystick as SDL_Joystick ptr, byval button as long) as Uint8
declare sub SDL_JoystickClose(byval joystick as SDL_Joystick ptr)
#define _SDL_gamecontroller_h
type SDL_GameController as _SDL_GameController

type SDL_GameControllerBindType as long
enum
	SDL_CONTROLLER_BINDTYPE_NONE = 0
	SDL_CONTROLLER_BINDTYPE_BUTTON
	SDL_CONTROLLER_BINDTYPE_AXIS
	SDL_CONTROLLER_BINDTYPE_HAT
end enum

type SDL_GameControllerButtonBind_value_hat
	hat as long
	hat_mask as long
end type

union SDL_GameControllerButtonBind_value
	button as long
	axis as long
	hat as SDL_GameControllerButtonBind_value_hat
end union

type SDL_GameControllerButtonBind
	bindType as SDL_GameControllerBindType
	value as SDL_GameControllerButtonBind_value
end type

declare function SDL_GameControllerAddMappingsFromRW(byval rw as SDL_RWops ptr, byval freerw as long) as long
#define SDL_GameControllerAddMappingsFromFile(file) SDL_GameControllerAddMappingsFromRW(SDL_RWFromFile(file, "rb"), 1)
declare function SDL_GameControllerAddMapping(byval mappingString as const zstring ptr) as long
declare function SDL_GameControllerMappingForGUID(byval guid as SDL_JoystickGUID) as zstring ptr
declare function SDL_GameControllerMapping(byval gamecontroller as SDL_GameController ptr) as zstring ptr
declare function SDL_IsGameController(byval joystick_index as long) as SDL_bool
declare function SDL_GameControllerNameForIndex(byval joystick_index as long) as const zstring ptr
declare function SDL_GameControllerOpen(byval joystick_index as long) as SDL_GameController ptr
declare function SDL_GameControllerName(byval gamecontroller as SDL_GameController ptr) as const zstring ptr
declare function SDL_GameControllerGetAttached(byval gamecontroller as SDL_GameController ptr) as SDL_bool
declare function SDL_GameControllerGetJoystick(byval gamecontroller as SDL_GameController ptr) as SDL_Joystick ptr
declare function SDL_GameControllerEventState(byval state as long) as long
declare sub SDL_GameControllerUpdate()

type SDL_GameControllerAxis as long
enum
	SDL_CONTROLLER_AXIS_INVALID = -1
	SDL_CONTROLLER_AXIS_LEFTX
	SDL_CONTROLLER_AXIS_LEFTY
	SDL_CONTROLLER_AXIS_RIGHTX
	SDL_CONTROLLER_AXIS_RIGHTY
	SDL_CONTROLLER_AXIS_TRIGGERLEFT
	SDL_CONTROLLER_AXIS_TRIGGERRIGHT
	SDL_CONTROLLER_AXIS_MAX
end enum

declare function SDL_GameControllerGetAxisFromString(byval pchString as const zstring ptr) as SDL_GameControllerAxis
declare function SDL_GameControllerGetStringForAxis(byval axis as SDL_GameControllerAxis) as const zstring ptr
declare function SDL_GameControllerGetBindForAxis(byval gamecontroller as SDL_GameController ptr, byval axis as SDL_GameControllerAxis) as SDL_GameControllerButtonBind
declare function SDL_GameControllerGetAxis(byval gamecontroller as SDL_GameController ptr, byval axis as SDL_GameControllerAxis) as Sint16

type SDL_GameControllerButton as long
enum
	SDL_CONTROLLER_BUTTON_INVALID = -1
	SDL_CONTROLLER_BUTTON_A
	SDL_CONTROLLER_BUTTON_B
	SDL_CONTROLLER_BUTTON_X
	SDL_CONTROLLER_BUTTON_Y
	SDL_CONTROLLER_BUTTON_BACK
	SDL_CONTROLLER_BUTTON_GUIDE
	SDL_CONTROLLER_BUTTON_START
	SDL_CONTROLLER_BUTTON_LEFTSTICK
	SDL_CONTROLLER_BUTTON_RIGHTSTICK
	SDL_CONTROLLER_BUTTON_LEFTSHOULDER
	SDL_CONTROLLER_BUTTON_RIGHTSHOULDER
	SDL_CONTROLLER_BUTTON_DPAD_UP
	SDL_CONTROLLER_BUTTON_DPAD_DOWN
	SDL_CONTROLLER_BUTTON_DPAD_LEFT
	SDL_CONTROLLER_BUTTON_DPAD_RIGHT
	SDL_CONTROLLER_BUTTON_MAX
end enum

declare function SDL_GameControllerGetButtonFromString(byval pchString as const zstring ptr) as SDL_GameControllerButton
declare function SDL_GameControllerGetStringForButton(byval button as SDL_GameControllerButton) as const zstring ptr
declare function SDL_GameControllerGetBindForButton(byval gamecontroller as SDL_GameController ptr, byval button as SDL_GameControllerButton) as SDL_GameControllerButtonBind
declare function SDL_GameControllerGetButton(byval gamecontroller as SDL_GameController ptr, byval button as SDL_GameControllerButton) as Uint8
declare sub SDL_GameControllerClose(byval gamecontroller as SDL_GameController ptr)

#define _SDL_quit_h
#define _SDL_gesture_h
#define _SDL_touch_h
type SDL_TouchID as Sint64
type SDL_FingerID as Sint64

type SDL_Finger
	id as SDL_FingerID
	x as single
	y as single
	pressure as single
end type

#define SDL_TOUCH_MOUSEID cast(Uint32, -1)
declare function SDL_GetNumTouchDevices() as long
declare function SDL_GetTouchDevice(byval index as long) as SDL_TouchID
declare function SDL_GetNumTouchFingers(byval touchID as SDL_TouchID) as long
declare function SDL_GetTouchFinger(byval touchID as SDL_TouchID, byval index as long) as SDL_Finger ptr
type SDL_GestureID as Sint64
declare function SDL_RecordGesture(byval touchId as SDL_TouchID) as long
declare function SDL_SaveAllDollarTemplates(byval dst as SDL_RWops ptr) as long
declare function SDL_SaveDollarTemplate(byval gestureId as SDL_GestureID, byval dst as SDL_RWops ptr) as long
declare function SDL_LoadDollarTemplates(byval touchId as SDL_TouchID, byval src as SDL_RWops ptr) as long
const SDL_RELEASED = 0
const SDL_PRESSED = 1

type SDL_EventType as long
enum
	SDL_FIRSTEVENT = 0
	SDL_QUIT_ = &h100
	SDL_APP_TERMINATING
	SDL_APP_LOWMEMORY
	SDL_APP_WILLENTERBACKGROUND
	SDL_APP_DIDENTERBACKGROUND
	SDL_APP_WILLENTERFOREGROUND
	SDL_APP_DIDENTERFOREGROUND
	SDL_WINDOWEVENT = &h200
	SDL_SYSWMEVENT
	SDL_KEYDOWN = &h300
	SDL_KEYUP
	SDL_TEXTEDITING
	SDL_TEXTINPUT
	SDL_MOUSEMOTION = &h400
	SDL_MOUSEBUTTONDOWN
	SDL_MOUSEBUTTONUP
	SDL_MOUSEWHEEL
	SDL_JOYAXISMOTION = &h600
	SDL_JOYBALLMOTION
	SDL_JOYHATMOTION
	SDL_JOYBUTTONDOWN
	SDL_JOYBUTTONUP
	SDL_JOYDEVICEADDED
	SDL_JOYDEVICEREMOVED
	SDL_CONTROLLERAXISMOTION = &h650
	SDL_CONTROLLERBUTTONDOWN
	SDL_CONTROLLERBUTTONUP
	SDL_CONTROLLERDEVICEADDED
	SDL_CONTROLLERDEVICEREMOVED
	SDL_CONTROLLERDEVICEREMAPPED
	SDL_FINGERDOWN = &h700
	SDL_FINGERUP
	SDL_FINGERMOTION
	SDL_DOLLARGESTURE = &h800
	SDL_DOLLARRECORD
	SDL_MULTIGESTURE
	SDL_CLIPBOARDUPDATE = &h900
	SDL_DROPFILE = &h1000
	SDL_RENDER_TARGETS_RESET = &h2000
	SDL_USEREVENT = &h8000
	SDL_LASTEVENT = &hFFFF
end enum

type SDL_CommonEvent
	as Uint32 type
	timestamp as Uint32
end type

type SDL_WindowEvent
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	event as Uint8
	padding1 as Uint8
	padding2 as Uint8
	padding3 as Uint8
	data1 as Sint32
	data2 as Sint32
end type

type SDL_KeyboardEvent
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	state as Uint8
	repeat as Uint8
	padding2 as Uint8
	padding3 as Uint8
	keysym as SDL_Keysym
end type

const SDL_TEXTEDITINGEVENT_TEXT_SIZE = 32

type SDL_TextEditingEvent
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	text as zstring * 32
	start as Sint32
	length as Sint32
end type

const SDL_TEXTINPUTEVENT_TEXT_SIZE = 32

type SDL_TextInputEvent
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	text as zstring * 32
end type

type SDL_MouseMotionEvent
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	which as Uint32
	state as Uint32
	x as Sint32
	y as Sint32
	xrel as Sint32
	yrel as Sint32
end type

type SDL_MouseButtonEvent
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	which as Uint32
	button as Uint8
	state as Uint8
	clicks as Uint8
	padding1 as Uint8
	x as Sint32
	y as Sint32
end type

type SDL_MouseWheelEvent
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	which as Uint32
	x as Sint32
	y as Sint32
end type

type SDL_JoyAxisEvent
	as Uint32 type
	timestamp as Uint32
	which as SDL_JoystickID
	axis as Uint8
	padding1 as Uint8
	padding2 as Uint8
	padding3 as Uint8
	value as Sint16
	padding4 as Uint16
end type

type SDL_JoyBallEvent
	as Uint32 type
	timestamp as Uint32
	which as SDL_JoystickID
	ball as Uint8
	padding1 as Uint8
	padding2 as Uint8
	padding3 as Uint8
	xrel as Sint16
	yrel as Sint16
end type

type SDL_JoyHatEvent
	as Uint32 type
	timestamp as Uint32
	which as SDL_JoystickID
	hat as Uint8
	value as Uint8
	padding1 as Uint8
	padding2 as Uint8
end type

type SDL_JoyButtonEvent
	as Uint32 type
	timestamp as Uint32
	which as SDL_JoystickID
	button as Uint8
	state as Uint8
	padding1 as Uint8
	padding2 as Uint8
end type

type SDL_JoyDeviceEvent
	as Uint32 type
	timestamp as Uint32
	which as Sint32
end type

type SDL_ControllerAxisEvent
	as Uint32 type
	timestamp as Uint32
	which as SDL_JoystickID
	axis as Uint8
	padding1 as Uint8
	padding2 as Uint8
	padding3 as Uint8
	value as Sint16
	padding4 as Uint16
end type

type SDL_ControllerButtonEvent
	as Uint32 type
	timestamp as Uint32
	which as SDL_JoystickID
	button as Uint8
	state as Uint8
	padding1 as Uint8
	padding2 as Uint8
end type

type SDL_ControllerDeviceEvent
	as Uint32 type
	timestamp as Uint32
	which as Sint32
end type

type SDL_TouchFingerEvent
	as Uint32 type
	timestamp as Uint32
	touchId as SDL_TouchID
	fingerId as SDL_FingerID
	x as single
	y as single
	dx as single
	dy as single
	pressure as single
end type

type SDL_MultiGestureEvent
	as Uint32 type
	timestamp as Uint32
	touchId as SDL_TouchID
	dTheta as single
	dDist as single
	x as single
	y as single
	numFingers as Uint16
	padding as Uint16
end type

type SDL_DollarGestureEvent
	as Uint32 type
	timestamp as Uint32
	touchId as SDL_TouchID
	gestureId as SDL_GestureID
	numFingers as Uint32
	error as single
	x as single
	y as single
end type

type SDL_DropEvent
	as Uint32 type
	timestamp as Uint32
	file as zstring ptr
end type

type SDL_QuitEvent
	as Uint32 type
	timestamp as Uint32
end type

type SDL_OSEvent
	as Uint32 type
	timestamp as Uint32
end type

type SDL_UserEvent
	as Uint32 type
	timestamp as Uint32
	windowID as Uint32
	code as Sint32
	data1 as any ptr
	data2 as any ptr
end type

type SDL_SysWMmsg as SDL_SysWMmsg_

type SDL_SysWMEvent
	as Uint32 type
	timestamp as Uint32
	msg as SDL_SysWMmsg ptr
end type

union SDL_Event
	as Uint32 type
	common as SDL_CommonEvent
	window as SDL_WindowEvent
	key as SDL_KeyboardEvent
	edit as SDL_TextEditingEvent
	text as SDL_TextInputEvent
	motion as SDL_MouseMotionEvent
	button as SDL_MouseButtonEvent
	wheel as SDL_MouseWheelEvent
	jaxis as SDL_JoyAxisEvent
	jball as SDL_JoyBallEvent
	jhat as SDL_JoyHatEvent
	jbutton as SDL_JoyButtonEvent
	jdevice as SDL_JoyDeviceEvent
	caxis as SDL_ControllerAxisEvent
	cbutton as SDL_ControllerButtonEvent
	cdevice as SDL_ControllerDeviceEvent
	quit as SDL_QuitEvent
	user as SDL_UserEvent
	syswm as SDL_SysWMEvent
	tfinger as SDL_TouchFingerEvent
	mgesture as SDL_MultiGestureEvent
	dgesture as SDL_DollarGestureEvent
	drop as SDL_DropEvent
	padding(0 to 55) as Uint8
end union

declare sub SDL_PumpEvents()

type SDL_eventaction as long
enum
	SDL_ADDEVENT
	SDL_PEEKEVENT
	SDL_GETEVENT
end enum

declare function SDL_PeepEvents(byval events as SDL_Event ptr, byval numevents as long, byval action as SDL_eventaction, byval minType as Uint32, byval maxType as Uint32) as long
private function SDL_QuitRequested() as SDL_bool
	SDL_PumpEvents()
	function = (SDL_PeepEvents(NULL, 0, SDL_PEEKEVENT, SDL_QUIT_, SDL_QUIT_) > 0)
end function
declare function SDL_HasEvent(byval type as Uint32) as SDL_bool
declare function SDL_HasEvents(byval minType as Uint32, byval maxType as Uint32) as SDL_bool
declare sub SDL_FlushEvent(byval type as Uint32)
declare sub SDL_FlushEvents(byval minType as Uint32, byval maxType as Uint32)
declare function SDL_PollEvent(byval event as SDL_Event ptr) as long
declare function SDL_WaitEvent(byval event as SDL_Event ptr) as long
declare function SDL_WaitEventTimeout(byval event as SDL_Event ptr, byval timeout as long) as long
declare function SDL_PushEvent(byval event as SDL_Event ptr) as long
type SDL_EventFilter as function(byval userdata as any ptr, byval event as SDL_Event ptr) as long
declare sub SDL_SetEventFilter(byval filter as SDL_EventFilter, byval userdata as any ptr)
declare function SDL_GetEventFilter(byval filter as SDL_EventFilter ptr, byval userdata as any ptr ptr) as SDL_bool
declare sub SDL_AddEventWatch(byval filter as SDL_EventFilter, byval userdata as any ptr)
declare sub SDL_DelEventWatch(byval filter as SDL_EventFilter, byval userdata as any ptr)
declare sub SDL_FilterEvents(byval filter as SDL_EventFilter, byval userdata as any ptr)

const SDL_QUERY = -1
const SDL_IGNORE = 0
const SDL_DISABLE = 0
const SDL_ENABLE = 1
declare function SDL_EventState(byval type as Uint32, byval state as long) as Uint8
#define SDL_GetEventState(type) SDL_EventState(type, SDL_QUERY)
declare function SDL_RegisterEvents(byval numevents as long) as Uint32
#define _SDL_filesystem_h
declare function SDL_GetBasePath() as zstring ptr
declare function SDL_GetPrefPath(byval org as const zstring ptr, byval app as const zstring ptr) as zstring ptr
#define _SDL_haptic_h
type SDL_Haptic as _SDL_Haptic
const SDL_HAPTIC_CONSTANT = 1 shl 0
const SDL_HAPTIC_SINE = 1 shl 1
const SDL_HAPTIC_LEFTRIGHT = 1 shl 2
const SDL_HAPTIC_TRIANGLE = 1 shl 3
const SDL_HAPTIC_SAWTOOTHUP = 1 shl 4
const SDL_HAPTIC_SAWTOOTHDOWN = 1 shl 5
const SDL_HAPTIC_RAMP = 1 shl 6
const SDL_HAPTIC_SPRING = 1 shl 7
const SDL_HAPTIC_DAMPER = 1 shl 8
const SDL_HAPTIC_INERTIA = 1 shl 9
const SDL_HAPTIC_FRICTION = 1 shl 10
const SDL_HAPTIC_CUSTOM = 1 shl 11
const SDL_HAPTIC_GAIN = 1 shl 12
const SDL_HAPTIC_AUTOCENTER = 1 shl 13
const SDL_HAPTIC_STATUS = 1 shl 14
const SDL_HAPTIC_PAUSE = 1 shl 15
const SDL_HAPTIC_POLAR = 0
const SDL_HAPTIC_CARTESIAN = 1
const SDL_HAPTIC_SPHERICAL = 2
const SDL_HAPTIC_INFINITY = 4294967295u

type SDL_HapticDirection
	as Uint8 type
	dir(0 to 2) as Sint32
end type

type SDL_HapticConstant
	as Uint16 type
	direction as SDL_HapticDirection
	length as Uint32
	delay as Uint16
	button as Uint16
	interval as Uint16
	level as Sint16
	attack_length as Uint16
	attack_level as Uint16
	fade_length as Uint16
	fade_level as Uint16
end type

type SDL_HapticPeriodic
	as Uint16 type
	direction as SDL_HapticDirection
	length as Uint32
	delay as Uint16
	button as Uint16
	interval as Uint16
	period as Uint16
	magnitude as Sint16
	offset as Sint16
	phase as Uint16
	attack_length as Uint16
	attack_level as Uint16
	fade_length as Uint16
	fade_level as Uint16
end type

type SDL_HapticCondition
	as Uint16 type
	direction as SDL_HapticDirection
	length as Uint32
	delay as Uint16
	button as Uint16
	interval as Uint16
	right_sat(0 to 2) as Uint16
	left_sat(0 to 2) as Uint16
	right_coeff(0 to 2) as Sint16
	left_coeff(0 to 2) as Sint16
	deadband(0 to 2) as Uint16
	center(0 to 2) as Sint16
end type

type SDL_HapticRamp
	as Uint16 type
	direction as SDL_HapticDirection
	length as Uint32
	delay as Uint16
	button as Uint16
	interval as Uint16
	start as Sint16
	as Sint16 end
	attack_length as Uint16
	attack_level as Uint16
	fade_length as Uint16
	fade_level as Uint16
end type

type SDL_HapticLeftRight
	as Uint16 type
	length as Uint32
	large_magnitude as Uint16
	small_magnitude as Uint16
end type

type SDL_HapticCustom
	as Uint16 type
	direction as SDL_HapticDirection
	length as Uint32
	delay as Uint16
	button as Uint16
	interval as Uint16
	channels as Uint8
	period as Uint16
	samples as Uint16
	data as Uint16 ptr
	attack_length as Uint16
	attack_level as Uint16
	fade_length as Uint16
	fade_level as Uint16
end type

union SDL_HapticEffect
	as Uint16 type
	constant as SDL_HapticConstant
	periodic as SDL_HapticPeriodic
	condition as SDL_HapticCondition
	ramp as SDL_HapticRamp
	leftright as SDL_HapticLeftRight
	custom as SDL_HapticCustom
end union

declare function SDL_NumHaptics() as long
declare function SDL_HapticName(byval device_index as long) as const zstring ptr
declare function SDL_HapticOpen(byval device_index as long) as SDL_Haptic ptr
declare function SDL_HapticOpened(byval device_index as long) as long
declare function SDL_HapticIndex(byval haptic as SDL_Haptic ptr) as long
declare function SDL_MouseIsHaptic() as long
declare function SDL_HapticOpenFromMouse() as SDL_Haptic ptr
declare function SDL_JoystickIsHaptic(byval joystick as SDL_Joystick ptr) as long
declare function SDL_HapticOpenFromJoystick(byval joystick as SDL_Joystick ptr) as SDL_Haptic ptr
declare sub SDL_HapticClose(byval haptic as SDL_Haptic ptr)
declare function SDL_HapticNumEffects(byval haptic as SDL_Haptic ptr) as long
declare function SDL_HapticNumEffectsPlaying(byval haptic as SDL_Haptic ptr) as long
declare function SDL_HapticQuery(byval haptic as SDL_Haptic ptr) as ulong
declare function SDL_HapticNumAxes(byval haptic as SDL_Haptic ptr) as long
declare function SDL_HapticEffectSupported(byval haptic as SDL_Haptic ptr, byval effect as SDL_HapticEffect ptr) as long
declare function SDL_HapticNewEffect(byval haptic as SDL_Haptic ptr, byval effect as SDL_HapticEffect ptr) as long
declare function SDL_HapticUpdateEffect(byval haptic as SDL_Haptic ptr, byval effect as long, byval data as SDL_HapticEffect ptr) as long
declare function SDL_HapticRunEffect(byval haptic as SDL_Haptic ptr, byval effect as long, byval iterations as Uint32) as long
declare function SDL_HapticStopEffect(byval haptic as SDL_Haptic ptr, byval effect as long) as long
declare sub SDL_HapticDestroyEffect(byval haptic as SDL_Haptic ptr, byval effect as long)
declare function SDL_HapticGetEffectStatus(byval haptic as SDL_Haptic ptr, byval effect as long) as long
declare function SDL_HapticSetGain(byval haptic as SDL_Haptic ptr, byval gain as long) as long
declare function SDL_HapticSetAutocenter(byval haptic as SDL_Haptic ptr, byval autocenter as long) as long
declare function SDL_HapticPause(byval haptic as SDL_Haptic ptr) as long
declare function SDL_HapticUnpause(byval haptic as SDL_Haptic ptr) as long
declare function SDL_HapticStopAll(byval haptic as SDL_Haptic ptr) as long
declare function SDL_HapticRumbleSupported(byval haptic as SDL_Haptic ptr) as long
declare function SDL_HapticRumbleInit(byval haptic as SDL_Haptic ptr) as long
declare function SDL_HapticRumblePlay(byval haptic as SDL_Haptic ptr, byval strength as single, byval length as Uint32) as long
declare function SDL_HapticRumbleStop(byval haptic as SDL_Haptic ptr) as long

#define _SDL_hints_h
#define SDL_HINT_FRAMEBUFFER_ACCELERATION "SDL_FRAMEBUFFER_ACCELERATION"
#define SDL_HINT_RENDER_DRIVER "SDL_RENDER_DRIVER"
#define SDL_HINT_RENDER_OPENGL_SHADERS "SDL_RENDER_OPENGL_SHADERS"
#define SDL_HINT_RENDER_DIRECT3D_THREADSAFE "SDL_RENDER_DIRECT3D_THREADSAFE"
#define SDL_HINT_RENDER_DIRECT3D11_DEBUG "SDL_HINT_RENDER_DIRECT3D11_DEBUG"
#define SDL_HINT_RENDER_SCALE_QUALITY "SDL_RENDER_SCALE_QUALITY"
#define SDL_HINT_RENDER_VSYNC "SDL_RENDER_VSYNC"
#define SDL_HINT_VIDEO_ALLOW_SCREENSAVER "SDL_VIDEO_ALLOW_SCREENSAVER"
#define SDL_HINT_VIDEO_X11_XVIDMODE "SDL_VIDEO_X11_XVIDMODE"
#define SDL_HINT_VIDEO_X11_XINERAMA "SDL_VIDEO_X11_XINERAMA"
#define SDL_HINT_VIDEO_X11_XRANDR "SDL_VIDEO_X11_XRANDR"
#define SDL_HINT_GRAB_KEYBOARD "SDL_GRAB_KEYBOARD"
#define SDL_HINT_MOUSE_RELATIVE_MODE_WARP "SDL_MOUSE_RELATIVE_MODE_WARP"
#define SDL_HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS "SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS"
#define SDL_HINT_IDLE_TIMER_DISABLED "SDL_IOS_IDLE_TIMER_DISABLED"
#define SDL_HINT_ORIENTATIONS "SDL_IOS_ORIENTATIONS"
#define SDL_HINT_ACCELEROMETER_AS_JOYSTICK "SDL_ACCELEROMETER_AS_JOYSTICK"
#define SDL_HINT_XINPUT_ENABLED "SDL_XINPUT_ENABLED"
#define SDL_HINT_GAMECONTROLLERCONFIG "SDL_GAMECONTROLLERCONFIG"
#define SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS "SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS"
#define SDL_HINT_ALLOW_TOPMOST "SDL_ALLOW_TOPMOST"
#define SDL_HINT_TIMER_RESOLUTION "SDL_TIMER_RESOLUTION"
#define SDL_HINT_VIDEO_HIGHDPI_DISABLED "SDL_VIDEO_HIGHDPI_DISABLED"
#define SDL_HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK "SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK"
#define SDL_HINT_VIDEO_WIN_D3DCOMPILER "SDL_VIDEO_WIN_D3DCOMPILER"
#define SDL_HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT "SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT"
#define SDL_HINT_WINRT_PRIVACY_POLICY_URL "SDL_HINT_WINRT_PRIVACY_POLICY_URL"
#define SDL_HINT_WINRT_PRIVACY_POLICY_LABEL "SDL_HINT_WINRT_PRIVACY_POLICY_LABEL"
#define SDL_HINT_WINRT_HANDLE_BACK_BUTTON "SDL_HINT_WINRT_HANDLE_BACK_BUTTON"
#define SDL_HINT_VIDEO_MAC_FULLSCREEN_SPACES "SDL_VIDEO_MAC_FULLSCREEN_SPACES"

type SDL_HintPriority as long
enum
	SDL_HINT_DEFAULT
	SDL_HINT_NORMAL
	SDL_HINT_OVERRIDE
end enum

declare function SDL_SetHintWithPriority(byval name as const zstring ptr, byval value as const zstring ptr, byval priority as SDL_HintPriority) as SDL_bool
declare function SDL_SetHint(byval name as const zstring ptr, byval value as const zstring ptr) as SDL_bool
declare function SDL_GetHint(byval name as const zstring ptr) as const zstring ptr
type SDL_HintCallback as sub(byval userdata as any ptr, byval name as const zstring ptr, byval oldValue as const zstring ptr, byval newValue as const zstring ptr)
declare sub SDL_AddHintCallback(byval name as const zstring ptr, byval callback as SDL_HintCallback, byval userdata as any ptr)
declare sub SDL_DelHintCallback(byval name as const zstring ptr, byval callback as SDL_HintCallback, byval userdata as any ptr)
declare sub SDL_ClearHints()
#define _SDL_loadso_h
declare function SDL_LoadObject(byval sofile as const zstring ptr) as any ptr
declare function SDL_LoadFunction(byval handle as any ptr, byval name as const zstring ptr) as any ptr
declare sub SDL_UnloadObject(byval handle as any ptr)
#define _SDL_log_h
const SDL_MAX_LOG_MESSAGE = 4096

enum
	SDL_LOG_CATEGORY_APPLICATION
	SDL_LOG_CATEGORY_ERROR
	SDL_LOG_CATEGORY_ASSERT
	SDL_LOG_CATEGORY_SYSTEM
	SDL_LOG_CATEGORY_AUDIO
	SDL_LOG_CATEGORY_VIDEO
	SDL_LOG_CATEGORY_RENDER
	SDL_LOG_CATEGORY_INPUT
	SDL_LOG_CATEGORY_TEST
	SDL_LOG_CATEGORY_RESERVED1
	SDL_LOG_CATEGORY_RESERVED2
	SDL_LOG_CATEGORY_RESERVED3
	SDL_LOG_CATEGORY_RESERVED4
	SDL_LOG_CATEGORY_RESERVED5
	SDL_LOG_CATEGORY_RESERVED6
	SDL_LOG_CATEGORY_RESERVED7
	SDL_LOG_CATEGORY_RESERVED8
	SDL_LOG_CATEGORY_RESERVED9
	SDL_LOG_CATEGORY_RESERVED10
	SDL_LOG_CATEGORY_CUSTOM
end enum

type SDL_LogPriority as long
enum
	SDL_LOG_PRIORITY_VERBOSE = 1
	SDL_LOG_PRIORITY_DEBUG
	SDL_LOG_PRIORITY_INFO
	SDL_LOG_PRIORITY_WARN
	SDL_LOG_PRIORITY_ERROR
	SDL_LOG_PRIORITY_CRITICAL
	SDL_NUM_LOG_PRIORITIES
end enum

declare sub SDL_LogSetAllPriority(byval priority as SDL_LogPriority)
declare sub SDL_LogSetPriority(byval category as long, byval priority as SDL_LogPriority)
declare function SDL_LogGetPriority(byval category as long) as SDL_LogPriority
declare sub SDL_LogResetPriorities()
declare sub SDL_Log_ alias "SDL_Log"(byval fmt as const zstring ptr, ...)
declare sub SDL_LogVerbose(byval category as long, byval fmt as const zstring ptr, ...)
declare sub SDL_LogDebug(byval category as long, byval fmt as const zstring ptr, ...)
declare sub SDL_LogInfo(byval category as long, byval fmt as const zstring ptr, ...)
declare sub SDL_LogWarn(byval category as long, byval fmt as const zstring ptr, ...)
declare sub SDL_LogError(byval category as long, byval fmt as const zstring ptr, ...)
declare sub SDL_LogCritical(byval category as long, byval fmt as const zstring ptr, ...)
declare sub SDL_LogMessage(byval category as long, byval priority as SDL_LogPriority, byval fmt as const zstring ptr, ...)
declare sub SDL_LogMessageV(byval category as long, byval priority as SDL_LogPriority, byval fmt as const zstring ptr, byval ap as va_list)
type SDL_LogOutputFunction as sub(byval userdata as any ptr, byval category as long, byval priority as SDL_LogPriority, byval message as const zstring ptr)
declare sub SDL_LogGetOutputFunction(byval callback as SDL_LogOutputFunction ptr, byval userdata as any ptr ptr)
declare sub SDL_LogSetOutputFunction(byval callback as SDL_LogOutputFunction, byval userdata as any ptr)
#define _SDL_messagebox_h

type SDL_MessageBoxFlags as long
enum
	SDL_MESSAGEBOX_ERROR = &h00000010
	SDL_MESSAGEBOX_WARNING = &h00000020
	SDL_MESSAGEBOX_INFORMATION = &h00000040
end enum

type SDL_MessageBoxButtonFlags as long
enum
	SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = &h00000001
	SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = &h00000002
end enum

type SDL_MessageBoxButtonData
	flags as Uint32
	buttonid as long
	text as const zstring ptr
end type

type SDL_MessageBoxColor
	r as Uint8
	g as Uint8
	b as Uint8
end type

type SDL_MessageBoxColorType as long
enum
	SDL_MESSAGEBOX_COLOR_BACKGROUND
	SDL_MESSAGEBOX_COLOR_TEXT
	SDL_MESSAGEBOX_COLOR_BUTTON_BORDER
	SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND
	SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED
	SDL_MESSAGEBOX_COLOR_MAX
end enum

type SDL_MessageBoxColorScheme
	colors(0 to SDL_MESSAGEBOX_COLOR_MAX - 1) as SDL_MessageBoxColor
end type

type SDL_MessageBoxData
	flags as Uint32
	window as SDL_Window ptr
	title as const zstring ptr
	message as const zstring ptr
	numbuttons as long
	buttons as const SDL_MessageBoxButtonData ptr
	colorScheme as const SDL_MessageBoxColorScheme ptr
end type

declare function SDL_ShowMessageBox(byval messageboxdata as const SDL_MessageBoxData ptr, byval buttonid as long ptr) as long
declare function SDL_ShowSimpleMessageBox(byval flags as Uint32, byval title as const zstring ptr, byval message as const zstring ptr, byval window as SDL_Window ptr) as long
#define _SDL_power_h

type SDL_PowerState as long
enum
	SDL_POWERSTATE_UNKNOWN
	SDL_POWERSTATE_ON_BATTERY
	SDL_POWERSTATE_NO_BATTERY
	SDL_POWERSTATE_CHARGING
	SDL_POWERSTATE_CHARGED
end enum

declare function SDL_GetPowerInfo(byval secs as long ptr, byval pct as long ptr) as SDL_PowerState
#define _SDL_render_h

type SDL_RendererFlags as long
enum
	SDL_RENDERER_SOFTWARE = &h00000001
	SDL_RENDERER_ACCELERATED = &h00000002
	SDL_RENDERER_PRESENTVSYNC = &h00000004
	SDL_RENDERER_TARGETTEXTURE = &h00000008
end enum

type SDL_RendererInfo
	name as const zstring ptr
	flags as Uint32
	num_texture_formats as Uint32
	texture_formats(0 to 15) as Uint32
	max_texture_width as long
	max_texture_height as long
end type

type SDL_TextureAccess as long
enum
	SDL_TEXTUREACCESS_STATIC
	SDL_TEXTUREACCESS_STREAMING
	SDL_TEXTUREACCESS_TARGET
end enum

type SDL_TextureModulate as long
enum
	SDL_TEXTUREMODULATE_NONE = &h00000000
	SDL_TEXTUREMODULATE_COLOR = &h00000001
	SDL_TEXTUREMODULATE_ALPHA = &h00000002
end enum

type SDL_RendererFlip as long
enum
	SDL_FLIP_NONE = &h00000000
	SDL_FLIP_HORIZONTAL = &h00000001
	SDL_FLIP_VERTICAL = &h00000002
end enum

declare function SDL_GetNumRenderDrivers() as long
declare function SDL_GetRenderDriverInfo(byval index as long, byval info as SDL_RendererInfo ptr) as long
type SDL_Renderer as SDL_Renderer_
declare function SDL_CreateWindowAndRenderer(byval width as long, byval height as long, byval window_flags as Uint32, byval window as SDL_Window ptr ptr, byval renderer as SDL_Renderer ptr ptr) as long
declare function SDL_CreateRenderer(byval window as SDL_Window ptr, byval index as long, byval flags as Uint32) as SDL_Renderer ptr
declare function SDL_CreateSoftwareRenderer(byval surface as SDL_Surface ptr) as SDL_Renderer ptr
declare function SDL_GetRenderer(byval window as SDL_Window ptr) as SDL_Renderer ptr
declare function SDL_GetRendererInfo(byval renderer as SDL_Renderer ptr, byval info as SDL_RendererInfo ptr) as long
declare function SDL_GetRendererOutputSize(byval renderer as SDL_Renderer ptr, byval w as long ptr, byval h as long ptr) as long
type SDL_Texture as SDL_Texture_
declare function SDL_CreateTexture(byval renderer as SDL_Renderer ptr, byval format as Uint32, byval access as long, byval w as long, byval h as long) as SDL_Texture ptr
declare function SDL_CreateTextureFromSurface(byval renderer as SDL_Renderer ptr, byval surface as SDL_Surface ptr) as SDL_Texture ptr
declare function SDL_QueryTexture(byval texture as SDL_Texture ptr, byval format as Uint32 ptr, byval access as long ptr, byval w as long ptr, byval h as long ptr) as long
declare function SDL_SetTextureColorMod(byval texture as SDL_Texture ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8) as long
declare function SDL_GetTextureColorMod(byval texture as SDL_Texture ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr) as long
declare function SDL_SetTextureAlphaMod(byval texture as SDL_Texture ptr, byval alpha as Uint8) as long
declare function SDL_GetTextureAlphaMod(byval texture as SDL_Texture ptr, byval alpha as Uint8 ptr) as long
declare function SDL_SetTextureBlendMode(byval texture as SDL_Texture ptr, byval blendMode as SDL_BlendMode) as long
declare function SDL_GetTextureBlendMode(byval texture as SDL_Texture ptr, byval blendMode as SDL_BlendMode ptr) as long
declare function SDL_UpdateTexture(byval texture as SDL_Texture ptr, byval rect as const SDL_Rect ptr, byval pixels as const any ptr, byval pitch as long) as long
declare function SDL_UpdateYUVTexture(byval texture as SDL_Texture ptr, byval rect as const SDL_Rect ptr, byval Yplane as const Uint8 ptr, byval Ypitch as long, byval Uplane as const Uint8 ptr, byval Upitch as long, byval Vplane as const Uint8 ptr, byval Vpitch as long) as long
declare function SDL_LockTexture(byval texture as SDL_Texture ptr, byval rect as const SDL_Rect ptr, byval pixels as any ptr ptr, byval pitch as long ptr) as long
declare sub SDL_UnlockTexture(byval texture as SDL_Texture ptr)
declare function SDL_RenderTargetSupported(byval renderer as SDL_Renderer ptr) as SDL_bool
declare function SDL_SetRenderTarget(byval renderer as SDL_Renderer ptr, byval texture as SDL_Texture ptr) as long
declare function SDL_GetRenderTarget(byval renderer as SDL_Renderer ptr) as SDL_Texture ptr
declare function SDL_RenderSetLogicalSize(byval renderer as SDL_Renderer ptr, byval w as long, byval h as long) as long
declare sub SDL_RenderGetLogicalSize(byval renderer as SDL_Renderer ptr, byval w as long ptr, byval h as long ptr)
declare function SDL_RenderSetViewport(byval renderer as SDL_Renderer ptr, byval rect as const SDL_Rect ptr) as long
declare sub SDL_RenderGetViewport(byval renderer as SDL_Renderer ptr, byval rect as SDL_Rect ptr)
declare function SDL_RenderSetClipRect(byval renderer as SDL_Renderer ptr, byval rect as const SDL_Rect ptr) as long
declare sub SDL_RenderGetClipRect(byval renderer as SDL_Renderer ptr, byval rect as SDL_Rect ptr)
declare function SDL_RenderSetScale(byval renderer as SDL_Renderer ptr, byval scaleX as single, byval scaleY as single) as long
declare sub SDL_RenderGetScale(byval renderer as SDL_Renderer ptr, byval scaleX as single ptr, byval scaleY as single ptr)
declare function SDL_SetRenderDrawColor(byval renderer as SDL_Renderer ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as long
declare function SDL_GetRenderDrawColor(byval renderer as SDL_Renderer ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr, byval a as Uint8 ptr) as long
declare function SDL_SetRenderDrawBlendMode(byval renderer as SDL_Renderer ptr, byval blendMode as SDL_BlendMode) as long
declare function SDL_GetRenderDrawBlendMode(byval renderer as SDL_Renderer ptr, byval blendMode as SDL_BlendMode ptr) as long
declare function SDL_RenderClear(byval renderer as SDL_Renderer ptr) as long
declare function SDL_RenderDrawPoint(byval renderer as SDL_Renderer ptr, byval x as long, byval y as long) as long
declare function SDL_RenderDrawPoints(byval renderer as SDL_Renderer ptr, byval points as const SDL_Point ptr, byval count as long) as long
declare function SDL_RenderDrawLine(byval renderer as SDL_Renderer ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long) as long
declare function SDL_RenderDrawLines(byval renderer as SDL_Renderer ptr, byval points as const SDL_Point ptr, byval count as long) as long
declare function SDL_RenderDrawRect(byval renderer as SDL_Renderer ptr, byval rect as const SDL_Rect ptr) as long
declare function SDL_RenderDrawRects(byval renderer as SDL_Renderer ptr, byval rects as const SDL_Rect ptr, byval count as long) as long
declare function SDL_RenderFillRect(byval renderer as SDL_Renderer ptr, byval rect as const SDL_Rect ptr) as long
declare function SDL_RenderFillRects(byval renderer as SDL_Renderer ptr, byval rects as const SDL_Rect ptr, byval count as long) as long
declare function SDL_RenderCopy(byval renderer as SDL_Renderer ptr, byval texture as SDL_Texture ptr, byval srcrect as const SDL_Rect ptr, byval dstrect as const SDL_Rect ptr) as long
declare function SDL_RenderCopyEx(byval renderer as SDL_Renderer ptr, byval texture as SDL_Texture ptr, byval srcrect as const SDL_Rect ptr, byval dstrect as const SDL_Rect ptr, byval angle as const double, byval center as const SDL_Point ptr, byval flip as const SDL_RendererFlip) as long
declare function SDL_RenderReadPixels(byval renderer as SDL_Renderer ptr, byval rect as const SDL_Rect ptr, byval format as Uint32, byval pixels as any ptr, byval pitch as long) as long
declare sub SDL_RenderPresent(byval renderer as SDL_Renderer ptr)
declare sub SDL_DestroyTexture(byval texture as SDL_Texture ptr)
declare sub SDL_DestroyRenderer(byval renderer as SDL_Renderer ptr)
declare function SDL_GL_BindTexture(byval texture as SDL_Texture ptr, byval texw as single ptr, byval texh as single ptr) as long
declare function SDL_GL_UnbindTexture(byval texture as SDL_Texture ptr) as long
#define _SDL_system_h

#ifdef __FB_WIN32__
	declare function SDL_Direct3D9GetAdapterIndex(byval displayIndex as long) as long
	declare function SDL_RenderGetD3D9Device(byval renderer as SDL_Renderer ptr) as IDirect3DDevice9 ptr
	declare sub SDL_DXGIGetOutputInfo(byval displayIndex as long, byval adapterIndex as long ptr, byval outputIndex as long ptr)
#endif

#define _SDL_timer_h
declare function SDL_GetTicks() as Uint32
#define SDL_TICKS_PASSED(A, B) (cast(Sint32, (B) - (A)) <= 0)
declare function SDL_GetPerformanceCounter() as Uint64
declare function SDL_GetPerformanceFrequency() as Uint64
declare sub SDL_Delay(byval ms as Uint32)
type SDL_TimerCallback as function(byval interval as Uint32, byval param as any ptr) as Uint32
type SDL_TimerID as long
declare function SDL_AddTimer(byval interval as Uint32, byval callback as SDL_TimerCallback, byval param as any ptr) as SDL_TimerID
declare function SDL_RemoveTimer(byval id as SDL_TimerID) as SDL_bool
#define _SDL_version_h

type SDL_version
	major as Uint8
	minor as Uint8
	patch as Uint8
end type

const SDL_MAJOR_VERSION = 2
const SDL_MINOR_VERSION = 0
const SDL_PATCHLEVEL = 3
#macro SDL_VERSION_(x)
	scope
		(x)->major = SDL_MAJOR_VERSION
		(x)->minor = SDL_MINOR_VERSION
		(x)->patch = SDL_PATCHLEVEL
	end scope
#endmacro
#define SDL_VERSIONNUM(X, Y, Z) ((((X) * 1000) + ((Y) * 100)) + (Z))
#define SDL_COMPILEDVERSION SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL)
#define SDL_VERSION_ATLEAST(X, Y, Z) (SDL_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z))

declare sub SDL_GetVersion(byval ver as SDL_version ptr)
declare function SDL_GetRevision() as const zstring ptr
declare function SDL_GetRevisionNumber() as long

const SDL_INIT_TIMER = &h00000001
const SDL_INIT_AUDIO = &h00000010
const SDL_INIT_VIDEO = &h00000020
const SDL_INIT_JOYSTICK = &h00000200
const SDL_INIT_HAPTIC = &h00001000
const SDL_INIT_GAMECONTROLLER = &h00002000
const SDL_INIT_EVENTS = &h00004000
const SDL_INIT_NOPARACHUTE = &h00100000
#define SDL_INIT_EVERYTHING ((((((SDL_INIT_TIMER or SDL_INIT_AUDIO) or SDL_INIT_VIDEO) or SDL_INIT_EVENTS) or SDL_INIT_JOYSTICK) or SDL_INIT_HAPTIC) or SDL_INIT_GAMECONTROLLER)

declare function SDL_Init(byval flags as Uint32) as long
declare function SDL_InitSubSystem(byval flags as Uint32) as long
declare sub SDL_QuitSubSystem(byval flags as Uint32)
declare function SDL_WasInit(byval flags as Uint32) as Uint32
declare sub SDL_Quit()

end extern
