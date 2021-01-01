'' FreeBASIC binding for SDL2-2.0.14
''
'' based on the C header files:
''   Simple DirectMedia Layer
''   Copyright (C) 1997-2020 Sam Lantinga <slouken@libsdl.org>
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
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "SDL2"

#include once "crt/long.bi"
#include once "crt/stdarg.bi"

#ifdef __FB_UNIX__
	#include once "crt/stdio.bi"
	#include once "crt/string.bi"
	#include once "crt/ctype.bi"
	#include once "crt/math.bi"
#else
	#include once "windows.bi"
	#include once "win/d3d9.bi"
#endif

'' The following symbols have been renamed:
''     #define SDL_PRIX64 => SDL_PRIX64_
''     constant SDL_UNSUPPORTED => SDL_UNSUPPORTED_
''     #if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
''         procedure SDL_CreateThread => SDL_CreateThread_
''         procedure SDL_CreateThreadWithStackSize => SDL_CreateThreadWithStackSize_
''     #endif
''     enum SDL_PixelType => SDL_PixelType_
''     constant SDL_QUIT => SDL_QUIT_
''     constant SDL_SENSORUPDATE => SDL_SENSORUPDATEEVENT
''     procedure SDL_Log => SDL_Log_
''     #define SDL_VERSION => SDL_VERSION_

extern "C"

#define SDL_h_
#define SDL_main_h_
#define SDL_stdinc_h_
#define SDL_platform_h_

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	const HAVE_WINAPIFAMILY_H = 0
	const WINAPI_FAMILY_WINRT = 0
#endif

#define SDLCALL cdecl

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	#ifndef NULL
		const NULL = 0
	#endif
#endif

declare function SDL_GetPlatform() as const zstring ptr
#define SDL_STRINGIFY_ARG(arg) #arg
#define SDL_FOURCC(A, B, C, D) ((((cast(Uint32, cast(Uint8, (A))) shl 0) or (cast(Uint32, cast(Uint8, (B))) shl 8)) or (cast(Uint32, cast(Uint8, (C))) shl 16)) or (cast(Uint32, cast(Uint8, (D))) shl 24))

type SDL_bool as long
enum
	SDL_FALSE = 0
	SDL_TRUE = 1
end enum

#define SDL_MAX_SINT8 cast(Sint8, &h7F)
#define SDL_MIN_SINT8 cast(Sint8, not &h7F)
type Sint8 as byte
#define SDL_MAX_UINT8 cast(Uint8, &hFF)
#define SDL_MIN_UINT8 cast(Uint8, &h00)
type Uint8 as ubyte
#define SDL_MAX_SINT16 cast(Sint16, &h7FFF)
#define SDL_MIN_SINT16 cast(Sint16, not &h7FFF)
type Sint16 as short
#define SDL_MAX_UINT16 cast(Uint16, &hFFFF)
#define SDL_MIN_UINT16 cast(Uint16, &h0000)
type Uint16 as ushort
#define SDL_MAX_SINT32 cast(Sint32, &h7FFFFFFF)
#define SDL_MIN_SINT32 cast(Sint32, not &h7FFFFFFF)
type Sint32 as long
#define SDL_MAX_UINT32 cast(Uint32, &hFFFFFFFFu)
#define SDL_MIN_UINT32 cast(Uint32, &h00000000)
type Uint32 as ulong
#define SDL_MAX_SINT64 cast(Sint64, &h7FFFFFFFFFFFFFFFll)
#define SDL_MIN_SINT64 cast(Sint64, not &h7FFFFFFFFFFFFFFFll)
type Sint64 as longint
#define SDL_MAX_UINT64 cast(Uint64, &hFFFFFFFFFFFFFFFFull)
#define SDL_MIN_UINT64 cast(Uint64, &h0000000000000000ull)
type Uint64 as ulongint

#if ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or (defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))
	#define SDL_PRIs64 "lld"
	#define SDL_PRIu64 "llu"
	#define SDL_PRIx64 "llx"
	#define SDL_PRIX64_ "llX"
#elseif defined(__FB_LINUX__) and defined(__FB_64BIT__)
	#define SDL_PRIs64 "ld"
	#define SDL_PRIu64 "lu"
	#define SDL_PRIx64 "lx"
	#define SDL_PRIX64_ "lX"
#else
	#define SDL_PRIs64 "I64d"
	#define SDL_PRIu64 "I64u"
	#define SDL_PRIx64 "I64x"
	#define SDL_PRIX64_ "I64X"
#endif

#define SDL_IN_BYTECAP(x)
#define SDL_INOUT_Z_CAP(x)
#define SDL_OUT_Z_CAP(x)
#define SDL_OUT_CAP(x)
#define SDL_OUT_BYTECAP(x)
#define SDL_OUT_Z_BYTECAP(x)
#define SDL_PRINTF_FORMAT_STRING
#define SDL_SCANF_FORMAT_STRING

type SDL_DUMMY_ENUM as long
enum
	DUMMY_ENUM_VALUE
end enum

#ifdef __FB_UNIX__
	#define SDL_stack_alloc(type, count) cptr(type ptr, alloca(sizeof(type) * (count)))
	#define SDL_stack_free(data)
#else
	#define SDL_stack_alloc(type, count) cptr(type ptr, SDL_malloc(sizeof(type) * (count)))
	#define SDL_stack_free(data) SDL_free(data)
#endif

declare function SDL_malloc(byval size as uinteger) as any ptr
declare function SDL_calloc(byval nmemb as uinteger, byval size as uinteger) as any ptr
declare function SDL_realloc(byval mem as any ptr, byval size as uinteger) as any ptr
declare sub SDL_free(byval mem as any ptr)

type SDL_malloc_func as function(byval size as uinteger) as any ptr
type SDL_calloc_func as function(byval nmemb as uinteger, byval size as uinteger) as any ptr
type SDL_realloc_func as function(byval mem as any ptr, byval size as uinteger) as any ptr
type SDL_free_func as sub(byval mem as any ptr)

declare sub SDL_GetMemoryFunctions(byval malloc_func as SDL_malloc_func ptr, byval calloc_func as SDL_calloc_func ptr, byval realloc_func as SDL_realloc_func ptr, byval free_func as SDL_free_func ptr)
declare function SDL_SetMemoryFunctions(byval malloc_func as SDL_malloc_func, byval calloc_func as SDL_calloc_func, byval realloc_func as SDL_realloc_func, byval free_func as SDL_free_func) as long
declare function SDL_GetNumAllocations() as long
declare function SDL_getenv(byval name as const zstring ptr) as zstring ptr
declare function SDL_setenv(byval name as const zstring ptr, byval value as const zstring ptr, byval overwrite as long) as long
declare sub SDL_qsort(byval base as any ptr, byval nmemb as uinteger, byval size as uinteger, byval compare as function(byval as const any ptr, byval as const any ptr) as long)
declare function SDL_abs(byval x as long) as long
#define SDL_min(x, y) iif((x) < (y), (x), (y))
#define SDL_max(x, y) iif((x) > (y), (x), (y))
declare function SDL_isdigit(byval x as long) as long
declare function SDL_isspace(byval x as long) as long
declare function SDL_isupper(byval x as long) as long
declare function SDL_islower(byval x as long) as long
declare function SDL_toupper(byval x as long) as long
declare function SDL_tolower(byval x as long) as long
declare function SDL_crc32(byval crc as Uint32, byval data as const any ptr, byval len as uinteger) as Uint32
declare function SDL_memset(byval dst as any ptr, byval c as long, byval len as uinteger) as any ptr

#define SDL_zero(x) SDL_memset(@(x), 0, sizeof(x))
#define SDL_zerop(x) SDL_memset((x), 0, sizeof(*(x)))
#define SDL_zeroa(x) SDL_memset((x), 0, sizeof(x))
private sub SDL_memset4(byval dst as any ptr, byval value as ulong, byval length as uinteger)
	for i as integer = 0 to length - 1
		cast(ulong ptr, dst)[i] = value
	next
end sub

declare function SDL_memcpy(byval dst as any ptr, byval src as const any ptr, byval len as uinteger) as any ptr
declare function SDL_memmove(byval dst as any ptr, byval src as const any ptr, byval len as uinteger) as any ptr
declare function SDL_memcmp(byval s1 as const any ptr, byval s2 as const any ptr, byval len as uinteger) as long
declare function SDL_wcslen(byval wstr as const wstring ptr) as uinteger
declare function SDL_wcslcpy(byval dst as wstring ptr, byval src as const wstring ptr, byval maxlen as uinteger) as uinteger
declare function SDL_wcslcat(byval dst as wstring ptr, byval src as const wstring ptr, byval maxlen as uinteger) as uinteger
declare function SDL_wcsdup(byval wstr as const wstring ptr) as wstring ptr
declare function SDL_wcsstr(byval haystack as const wstring ptr, byval needle as const wstring ptr) as wstring ptr
declare function SDL_wcscmp(byval str1 as const wstring ptr, byval str2 as const wstring ptr) as long
declare function SDL_wcsncmp(byval str1 as const wstring ptr, byval str2 as const wstring ptr, byval maxlen as uinteger) as long
declare function SDL_wcscasecmp(byval str1 as const wstring ptr, byval str2 as const wstring ptr) as long
declare function SDL_wcsncasecmp(byval str1 as const wstring ptr, byval str2 as const wstring ptr, byval len as uinteger) as long
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
declare function SDL_strtokr(byval s1 as zstring ptr, byval s2 as const zstring ptr, byval saveptr as zstring ptr ptr) as zstring ptr
declare function SDL_utf8strlen(byval str as const zstring ptr) as uinteger
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
declare function SDL_acosf(byval x as single) as single
declare function SDL_asin(byval x as double) as double
declare function SDL_asinf(byval x as single) as single
declare function SDL_atan(byval x as double) as double
declare function SDL_atanf(byval x as single) as single
declare function SDL_atan2(byval x as double, byval y as double) as double
declare function SDL_atan2f(byval x as single, byval y as single) as single
declare function SDL_ceil(byval x as double) as double
declare function SDL_ceilf(byval x as single) as single
declare function SDL_copysign(byval x as double, byval y as double) as double
declare function SDL_copysignf(byval x as single, byval y as single) as single
declare function SDL_cos(byval x as double) as double
declare function SDL_cosf(byval x as single) as single
declare function SDL_exp(byval x as double) as double
declare function SDL_expf(byval x as single) as single
declare function SDL_fabs(byval x as double) as double
declare function SDL_fabsf(byval x as single) as single
declare function SDL_floor(byval x as double) as double
declare function SDL_floorf(byval x as single) as single
declare function SDL_trunc(byval x as double) as double
declare function SDL_truncf(byval x as single) as single
declare function SDL_fmod(byval x as double, byval y as double) as double
declare function SDL_fmodf(byval x as single, byval y as single) as single
declare function SDL_log(byval x as double) as double
declare function SDL_logf(byval x as single) as single
declare function SDL_log10(byval x as double) as double
declare function SDL_log10f(byval x as single) as single
declare function SDL_pow(byval x as double, byval y as double) as double
declare function SDL_powf(byval x as single, byval y as single) as single
declare function SDL_scalbn(byval x as double, byval n as long) as double
declare function SDL_scalbnf(byval x as single, byval n as long) as single
declare function SDL_sin(byval x as double) as double
declare function SDL_sinf(byval x as single) as single
declare function SDL_sqrt(byval x as double) as double
declare function SDL_sqrtf(byval x as single) as single
declare function SDL_tan(byval x as double) as double
declare function SDL_tanf(byval x as single) as single

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
#define SDL_memcpy4(dst, src, dwords) SDL_memcpy((dst), (src), (dwords) * 4)
type SDL_main_func as function(byval argc as long, byval argv as zstring ptr ptr) as long
declare function SDL_main(byval argc as long, byval argv as zstring ptr ptr) as long
declare sub SDL_SetMainReady()

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	declare function SDL_RegisterApp(byval name as zstring ptr, byval style as Uint32, byval hInst as any ptr) as long
	declare sub SDL_UnregisterApp()
#endif

#define SDL_assert_h_
const SDL_ASSERT_LEVEL = 2

#if defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	#define SDL_TriggerBreakpoint() raise(SIGTRAP)
#else
	#define SDL_TriggerBreakpoint() asm int 3
#endif

#define SDL_FUNCTION __FUNCTION__
#define SDL_FILE __FILE__
#define SDL_LINE __LINE__
const SDL_NULL_WHILE_LOOP_CONDITION = 0
#define SDL_disabled_assert(condition) scope : end scope

type SDL_AssertState as long
enum
	SDL_ASSERTION_RETRY
	SDL_ASSERTION_BREAK
	SDL_ASSERTION_ABORT
	SDL_ASSERTION_IGNORE
	SDL_ASSERTION_ALWAYS_IGNORE
end enum

type SDL_AssertData
	always_ignore as long
	trigger_count as ulong
	condition as const zstring ptr
	filename as const zstring ptr
	linenum as long
	function as const zstring ptr
	next as const SDL_AssertData ptr
end type

declare function SDL_ReportAssertion(byval as SDL_AssertData ptr, byval as const zstring ptr, byval as const zstring ptr, byval as long) as SDL_AssertState
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
type SDL_AssertionHandler as function(byval data as const SDL_AssertData ptr, byval userdata as any ptr) as SDL_AssertState

declare sub SDL_SetAssertionHandler(byval handler as SDL_AssertionHandler, byval userdata as any ptr)
declare function SDL_GetDefaultAssertionHandler() as SDL_AssertionHandler
declare function SDL_GetAssertionHandler(byval puserdata as any ptr ptr) as SDL_AssertionHandler
declare function SDL_GetAssertionReport() as const SDL_AssertData ptr
declare sub SDL_ResetAssertionReport()
type SDL_assert_state as SDL_AssertState
type SDL_assert_data as SDL_AssertData
#define SDL_atomic_h_
type SDL_SpinLock as long
declare function SDL_AtomicTryLock(byval lock as SDL_SpinLock ptr) as SDL_bool
declare sub SDL_AtomicLock(byval lock as SDL_SpinLock ptr)
declare sub SDL_AtomicUnlock(byval lock as SDL_SpinLock ptr)
#define SDL_CompilerBarrier() asm nop
declare sub SDL_MemoryBarrierReleaseFunction()
declare sub SDL_MemoryBarrierAcquireFunction()
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
#define SDL_audio_h_
#define SDL_error_h_
declare function SDL_SetError(byval fmt as const zstring ptr, ...) as long
declare function SDL_GetError() as const zstring ptr
declare function SDL_GetErrorMsg(byval errstr as zstring ptr, byval maxlen as long) as zstring ptr
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
#define SDL_endian_h_
const SDL_LIL_ENDIAN = 1234

#ifdef __FB_WIN32__
	const SDL_BIG_ENDIAN = 4321
#endif

const SDL_BYTEORDER = SDL_LIL_ENDIAN

#ifdef __FB_UNIX__
	const SDL_BYTEORDER = SDL_LIL_ENDIAN
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
#define SDL_mutex_h_
const SDL_MUTEX_TIMEDOUT = 1
const SDL_MUTEX_MAXWAIT = not cast(Uint32, 0)
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
#define SDL_thread_h_
type SDL_threadID as culong
type SDL_TLSID as ulong

type SDL_ThreadPriority as long
enum
	SDL_THREAD_PRIORITY_LOW
	SDL_THREAD_PRIORITY_NORMAL
	SDL_THREAD_PRIORITY_HIGH
	SDL_THREAD_PRIORITY_TIME_CRITICAL
end enum

type SDL_ThreadFunction as function(byval data as any ptr) as long

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	#define SDL_PASSED_BEGINTHREAD_ENDTHREAD
#endif

#if (defined(__FB_CYGWIN__) and defined(__FB_64BIT__)) or ((not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_CYGWIN__)))
	type pfnSDL_CurrentBeginThread as function(byval as any ptr, byval as ulong, byval func as function stdcall(byval as any ptr) as ulong, byval as any ptr, byval as ulong, byval as ulong ptr) as uinteger
#elseif defined(__FB_WIN32__) and defined(__FB_64BIT__)
	type pfnSDL_CurrentBeginThread as function(byval as any ptr, byval as ulong, byval func as function(byval as any ptr) as ulong, byval as any ptr, byval as ulong, byval as ulong ptr) as uinteger
#endif

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	type pfnSDL_CurrentEndThread as sub(byval code as ulong)
#endif

#ifdef __FB_WIN32__
	#ifdef __FB_64BIT__
		declare function SDL_beginthread alias "_beginthreadex"(byval _Security as any ptr, byval _StackSize as ulong, byval _StartAddress as function(byval as any ptr) as ulong, byval _ArgList as any ptr, byval _InitFlag as ulong, byval _ThrdAddr as ulong ptr) as uinteger
	#else
		declare function SDL_beginthread alias "_beginthreadex"(byval _Security as any ptr, byval _StackSize as ulong, byval _StartAddress as function stdcall(byval as any ptr) as ulong, byval _ArgList as any ptr, byval _InitFlag as ulong, byval _ThrdAddr as ulong ptr) as uinteger
	#endif

	declare sub SDL_endthread alias "_endthreadex"(byval _Retval as ulong)
#elseif defined(__FB_CYGWIN__)
	#define SDL_beginthread _beginthreadex
	#define SDL_endthread _endthreadex
#endif

type SDL_Thread as SDL_Thread_

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	declare function SDL_CreateThread_ alias "SDL_CreateThread"(byval fn as SDL_ThreadFunction, byval name as const zstring ptr, byval data as any ptr, byval pfnBeginThread as pfnSDL_CurrentBeginThread, byval pfnEndThread as pfnSDL_CurrentEndThread) as SDL_Thread ptr
	declare function SDL_CreateThreadWithStackSize_ alias "SDL_CreateThreadWithStackSize"(byval fn as function(byval as any ptr) as long, byval name as const zstring ptr, byval stacksize as const uinteger, byval data as any ptr, byval pfnBeginThread as pfnSDL_CurrentBeginThread, byval pfnEndThread as pfnSDL_CurrentEndThread) as SDL_Thread ptr
	#define SDL_CreateThread(fn, name, data) SDL_CreateThread_(fn, name, data, cast(pfnSDL_CurrentBeginThread, SDL_beginthread), cast(pfnSDL_CurrentEndThread, SDL_endthread))
	#define SDL_CreateThreadWithStackSize(fn, name, stacksize, data) SDL_CreateThreadWithStackSize_(fn, name, data, cast(pfnSDL_CurrentBeginThread, _beginthreadex), cast(pfnSDL_CurrentEndThread, SDL_endthread))
#else
	declare function SDL_CreateThread(byval fn as SDL_ThreadFunction, byval name as const zstring ptr, byval data as any ptr) as SDL_Thread ptr
	declare function SDL_CreateThreadWithStackSize(byval fn as SDL_ThreadFunction, byval name as const zstring ptr, byval stacksize as const uinteger, byval data as any ptr) as SDL_Thread ptr
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

#define SDL_rwops_h_
const SDL_RWOPS_UNKNOWN = 0u
const SDL_RWOPS_WINFILE = 1u
const SDL_RWOPS_STDFILE = 2u
const SDL_RWOPS_JNIFILE = 3u
const SDL_RWOPS_MEMORY = 4u
const SDL_RWOPS_MEMORY_RO = 5u

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
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

#ifdef __FB_CYGWIN__
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
	#ifdef __FB_CYGWIN__
		windowsio as SDL_RWops_hidden_windowsio
	#endif

	#ifdef __FB_UNIX__
		stdio as SDL_RWops_hidden_stdio
	#else
		windowsio as SDL_RWops_hidden_windowsio
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

#ifdef __FB_UNIX__
	declare function SDL_RWFromFP(byval fp as FILE ptr, byval autoclose as SDL_bool) as SDL_RWops ptr
#else
	declare function SDL_RWFromFP(byval fp as any ptr, byval autoclose as SDL_bool) as SDL_RWops ptr
#endif

declare function SDL_RWFromMem(byval mem as any ptr, byval size as long) as SDL_RWops ptr
declare function SDL_RWFromConstMem(byval mem as const any ptr, byval size as long) as SDL_RWops ptr
declare function SDL_AllocRW() as SDL_RWops ptr
declare sub SDL_FreeRW(byval area as SDL_RWops ptr)

const RW_SEEK_SET = 0
const RW_SEEK_CUR = 1
const RW_SEEK_END = 2

declare function SDL_RWsize(byval context as SDL_RWops ptr) as Sint64
declare function SDL_RWseek(byval context as SDL_RWops ptr, byval offset as Sint64, byval whence as long) as Sint64
declare function SDL_RWtell(byval context as SDL_RWops ptr) as Sint64
declare function SDL_RWread(byval context as SDL_RWops ptr, byval ptr as any ptr, byval size as uinteger, byval maxnum as uinteger) as uinteger
declare function SDL_RWwrite(byval context as SDL_RWops ptr, byval ptr as const any ptr, byval size as uinteger, byval num as uinteger) as uinteger
declare function SDL_RWclose(byval context as SDL_RWops ptr) as long
declare function SDL_LoadFile_RW(byval src as SDL_RWops ptr, byval datasize as uinteger ptr, byval freesrc as long) as any ptr
declare function SDL_LoadFile(byval file as const zstring ptr, byval datasize as uinteger ptr) as any ptr
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
const AUDIO_U16 = AUDIO_U16LSB
const AUDIO_S16 = AUDIO_S16LSB
const AUDIO_S32LSB = &h8020
const AUDIO_S32MSB = &h9020
const AUDIO_S32 = AUDIO_S32LSB
const AUDIO_F32LSB = &h8120
const AUDIO_F32MSB = &h9120
const AUDIO_F32 = AUDIO_F32LSB
const AUDIO_U16SYS = AUDIO_U16LSB
const AUDIO_S16SYS = AUDIO_S16LSB
const AUDIO_S32SYS = AUDIO_S32LSB
const AUDIO_F32SYS = AUDIO_F32LSB
const SDL_AUDIO_ALLOW_FREQUENCY_CHANGE = &h00000001
const SDL_AUDIO_ALLOW_FORMAT_CHANGE = &h00000002
const SDL_AUDIO_ALLOW_CHANNELS_CHANGE = &h00000004
const SDL_AUDIO_ALLOW_SAMPLES_CHANGE = &h00000008
const SDL_AUDIO_ALLOW_ANY_CHANGE = ((SDL_AUDIO_ALLOW_FREQUENCY_CHANGE or SDL_AUDIO_ALLOW_FORMAT_CHANGE) or SDL_AUDIO_ALLOW_CHANNELS_CHANGE) or SDL_AUDIO_ALLOW_SAMPLES_CHANGE
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
const SDL_AUDIOCVT_MAX_FILTERS = 9

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
	filters(0 to (9 + 1) - 1) as SDL_AudioFilter
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
type SDL_AudioStream as _SDL_AudioStream
declare function SDL_NewAudioStream(byval src_format as const SDL_AudioFormat, byval src_channels as const Uint8, byval src_rate as const long, byval dst_format as const SDL_AudioFormat, byval dst_channels as const Uint8, byval dst_rate as const long) as SDL_AudioStream ptr
declare function SDL_AudioStreamPut(byval stream as SDL_AudioStream ptr, byval buf as const any ptr, byval len as long) as long
declare function SDL_AudioStreamGet(byval stream as SDL_AudioStream ptr, byval buf as any ptr, byval len as long) as long
declare function SDL_AudioStreamAvailable(byval stream as SDL_AudioStream ptr) as long
declare function SDL_AudioStreamFlush(byval stream as SDL_AudioStream ptr) as long
declare sub SDL_AudioStreamClear(byval stream as SDL_AudioStream ptr)
declare sub SDL_FreeAudioStream(byval stream as SDL_AudioStream ptr)
const SDL_MIX_MAXVOLUME = 128
declare sub SDL_MixAudio(byval dst as Uint8 ptr, byval src as const Uint8 ptr, byval len as Uint32, byval volume as long)
declare sub SDL_MixAudioFormat(byval dst as Uint8 ptr, byval src as const Uint8 ptr, byval format as SDL_AudioFormat, byval len as Uint32, byval volume as long)
declare function SDL_QueueAudio(byval dev as SDL_AudioDeviceID, byval data as const any ptr, byval len as Uint32) as long
declare function SDL_DequeueAudio(byval dev as SDL_AudioDeviceID, byval data as any ptr, byval len as Uint32) as Uint32
declare function SDL_GetQueuedAudioSize(byval dev as SDL_AudioDeviceID) as Uint32
declare sub SDL_ClearQueuedAudio(byval dev as SDL_AudioDeviceID)
declare sub SDL_LockAudio()
declare sub SDL_LockAudioDevice(byval dev as SDL_AudioDeviceID)
declare sub SDL_UnlockAudio()
declare sub SDL_UnlockAudioDevice(byval dev as SDL_AudioDeviceID)
declare sub SDL_CloseAudio()
declare sub SDL_CloseAudioDevice(byval dev as SDL_AudioDeviceID)
#define SDL_clipboard_h_
declare function SDL_SetClipboardText(byval text as const zstring ptr) as long
declare function SDL_GetClipboardText() as zstring ptr
declare function SDL_HasClipboardText() as SDL_bool
#define SDL_cpuinfo_h_
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
declare function SDL_HasAVX2() as SDL_bool
declare function SDL_HasAVX512F() as SDL_bool
declare function SDL_HasARMSIMD() as SDL_bool
declare function SDL_HasNEON() as SDL_bool
declare function SDL_GetSystemRAM() as long
declare function SDL_SIMDGetAlignment() as uinteger
declare function SDL_SIMDAlloc(byval len as const uinteger) as any ptr
declare function SDL_SIMDRealloc(byval mem as any ptr, byval len as const uinteger) as any ptr
declare sub SDL_SIMDFree(byval ptr as any ptr)

#define SDL_events_h_
#define SDL_video_h_
#define SDL_pixels_h_
const SDL_ALPHA_OPAQUE = 255
const SDL_ALPHA_TRANSPARENT = 0

type SDL_PixelType_ as long
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

type SDL_BitmapOrder as long
enum
	SDL_BITMAPORDER_NONE
	SDL_BITMAPORDER_4321
	SDL_BITMAPORDER_1234
end enum

type SDL_PackedOrder as long
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

type SDL_ArrayOrder as long
enum
	SDL_ARRAYORDER_NONE
	SDL_ARRAYORDER_RGB
	SDL_ARRAYORDER_RGBA
	SDL_ARRAYORDER_ARGB
	SDL_ARRAYORDER_BGR
	SDL_ARRAYORDER_BGRA
	SDL_ARRAYORDER_ABGR
end enum

type SDL_PackedLayout as long
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
#define SDL_ISPIXELFORMAT_PACKED(format) ((SDL_ISPIXELFORMAT_FOURCC(format) = 0) andalso (((SDL_PIXELTYPE(format) = SDL_PIXELTYPE_PACKED8) orelse (SDL_PIXELTYPE(format) = SDL_PIXELTYPE_PACKED16)) orelse (SDL_PIXELTYPE(format) = SDL_PIXELTYPE_PACKED32)))
#define SDL_ISPIXELFORMAT_ARRAY(format) ((SDL_ISPIXELFORMAT_FOURCC(format) = 0) andalso (((((SDL_PIXELTYPE(format) = SDL_PIXELTYPE_ARRAYU8) orelse (SDL_PIXELTYPE(format) = SDL_PIXELTYPE_ARRAYU16)) orelse (SDL_PIXELTYPE(format) = SDL_PIXELTYPE_ARRAYU32)) orelse (SDL_PIXELTYPE(format) = SDL_PIXELTYPE_ARRAYF16)) orelse (SDL_PIXELTYPE(format) = SDL_PIXELTYPE_ARRAYF32)))
#define SDL_ISPIXELFORMAT_ALPHA(format) ((SDL_ISPIXELFORMAT_PACKED(format) andalso ((((SDL_PIXELORDER(format) = SDL_PACKEDORDER_ARGB) orelse (SDL_PIXELORDER(format) = SDL_PACKEDORDER_RGBA)) orelse (SDL_PIXELORDER(format) = SDL_PACKEDORDER_ABGR)) orelse (SDL_PIXELORDER(format) = SDL_PACKEDORDER_BGRA))) orelse (SDL_ISPIXELFORMAT_ARRAY(format) andalso ((((SDL_PIXELORDER(format) = SDL_ARRAYORDER_ARGB) orelse (SDL_PIXELORDER(format) = SDL_ARRAYORDER_RGBA)) orelse (SDL_PIXELORDER(format) = SDL_ARRAYORDER_ABGR)) orelse (SDL_PIXELORDER(format) = SDL_ARRAYORDER_BGRA))))
#define SDL_ISPIXELFORMAT_FOURCC(format) ((format) andalso (SDL_PIXELFLAG(format) <> 1))

type SDL_PixelFormatEnum as long
enum
	SDL_PIXELFORMAT_UNKNOWN
	SDL_PIXELFORMAT_INDEX1LSB = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX1, SDL_BITMAPORDER_4321, 0, 1, 0)
	SDL_PIXELFORMAT_INDEX1MSB = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX1, SDL_BITMAPORDER_1234, 0, 1, 0)
	SDL_PIXELFORMAT_INDEX4LSB = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX4, SDL_BITMAPORDER_4321, 0, 4, 0)
	SDL_PIXELFORMAT_INDEX4MSB = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX4, SDL_BITMAPORDER_1234, 0, 4, 0)
	SDL_PIXELFORMAT_INDEX8 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX8, 0, 0, 8, 1)
	SDL_PIXELFORMAT_RGB332 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED8, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_332, 8, 1)
	SDL_PIXELFORMAT_XRGB4444 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_4444, 12, 2)
	SDL_PIXELFORMAT_RGB444 = SDL_PIXELFORMAT_XRGB4444
	SDL_PIXELFORMAT_XBGR4444 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_4444, 12, 2)
	SDL_PIXELFORMAT_BGR444 = SDL_PIXELFORMAT_XBGR4444
	SDL_PIXELFORMAT_XRGB1555 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_1555, 15, 2)
	SDL_PIXELFORMAT_RGB555 = SDL_PIXELFORMAT_XRGB1555
	SDL_PIXELFORMAT_XBGR1555 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_1555, 15, 2)
	SDL_PIXELFORMAT_BGR555 = SDL_PIXELFORMAT_XBGR1555
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
	SDL_PIXELFORMAT_XRGB8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_8888, 24, 4)
	SDL_PIXELFORMAT_RGB888 = SDL_PIXELFORMAT_XRGB8888
	SDL_PIXELFORMAT_RGBX8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_RGBX, SDL_PACKEDLAYOUT_8888, 24, 4)
	SDL_PIXELFORMAT_XBGR8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_8888, 24, 4)
	SDL_PIXELFORMAT_BGR888 = SDL_PIXELFORMAT_XBGR8888
	SDL_PIXELFORMAT_BGRX8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_BGRX, SDL_PACKEDLAYOUT_8888, 24, 4)
	SDL_PIXELFORMAT_ARGB8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_8888, 32, 4)
	SDL_PIXELFORMAT_RGBA8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_RGBA, SDL_PACKEDLAYOUT_8888, 32, 4)
	SDL_PIXELFORMAT_ABGR8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ABGR, SDL_PACKEDLAYOUT_8888, 32, 4)
	SDL_PIXELFORMAT_BGRA8888 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_BGRA, SDL_PACKEDLAYOUT_8888, 32, 4)
	SDL_PIXELFORMAT_ARGB2101010 = SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_2101010, 32, 4)
	SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_ABGR8888
	SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_BGRA8888
	SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_ARGB8888
	SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_RGBA8888
	SDL_PIXELFORMAT_YV12 = SDL_DEFINE_PIXELFOURCC(asc("Y"), asc("V"), asc("1"), asc("2"))
	SDL_PIXELFORMAT_IYUV = SDL_DEFINE_PIXELFOURCC(asc("I"), asc("Y"), asc("U"), asc("V"))
	SDL_PIXELFORMAT_YUY2 = SDL_DEFINE_PIXELFOURCC(asc("Y"), asc("U"), asc("Y"), asc("2"))
	SDL_PIXELFORMAT_UYVY = SDL_DEFINE_PIXELFOURCC(asc("U"), asc("Y"), asc("V"), asc("Y"))
	SDL_PIXELFORMAT_YVYU = SDL_DEFINE_PIXELFOURCC(asc("Y"), asc("V"), asc("Y"), asc("U"))
	SDL_PIXELFORMAT_NV12 = SDL_DEFINE_PIXELFOURCC(asc("N"), asc("V"), asc("1"), asc("2"))
	SDL_PIXELFORMAT_NV21 = SDL_DEFINE_PIXELFOURCC(asc("N"), asc("V"), asc("2"), asc("1"))
	SDL_PIXELFORMAT_EXTERNAL_OES = SDL_DEFINE_PIXELFOURCC(asc("O"), asc("E"), asc("S"), asc(" "))
end enum

type SDL_Color
	r as Uint8
	g as Uint8
	b as Uint8
	a as Uint8
end type

type SDL_Colour as SDL_Color

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
#define SDL_rect_h_

type SDL_Point
	x as long
	y as long
end type

type SDL_FPoint
	x as single
	y as single
end type

type SDL_Rect
	x as long
	y as long
	w as long
	h as long
end type

type SDL_FRect
	x as single
	y as single
	w as single
	h as single
end type

private function SDL_PointInRect(byval p as const SDL_Point ptr, byval r as const SDL_Rect ptr) as SDL_bool
	return iif((((p->x >= r->x) andalso (p->x < (r->x + r->w))) andalso (p->y >= r->y)) andalso (p->y < (r->y + r->h)), SDL_TRUE, SDL_FALSE)
end function

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
#define SDL_surface_h_
#define SDL_blendmode_h_

type SDL_BlendMode as long
enum
	SDL_BLENDMODE_NONE = &h00000000
	SDL_BLENDMODE_BLEND = &h00000001
	SDL_BLENDMODE_ADD = &h00000002
	SDL_BLENDMODE_MOD = &h00000004
	SDL_BLENDMODE_MUL = &h00000008
	SDL_BLENDMODE_INVALID = &h7FFFFFFF
end enum

type SDL_BlendOperation as long
enum
	SDL_BLENDOPERATION_ADD = &h1
	SDL_BLENDOPERATION_SUBTRACT = &h2
	SDL_BLENDOPERATION_REV_SUBTRACT = &h3
	SDL_BLENDOPERATION_MINIMUM = &h4
	SDL_BLENDOPERATION_MAXIMUM = &h5
end enum

type SDL_BlendFactor as long
enum
	SDL_BLENDFACTOR_ZERO = &h1
	SDL_BLENDFACTOR_ONE = &h2
	SDL_BLENDFACTOR_SRC_COLOR = &h3
	SDL_BLENDFACTOR_ONE_MINUS_SRC_COLOR = &h4
	SDL_BLENDFACTOR_SRC_ALPHA = &h5
	SDL_BLENDFACTOR_ONE_MINUS_SRC_ALPHA = &h6
	SDL_BLENDFACTOR_DST_COLOR = &h7
	SDL_BLENDFACTOR_ONE_MINUS_DST_COLOR = &h8
	SDL_BLENDFACTOR_DST_ALPHA = &h9
	SDL_BLENDFACTOR_ONE_MINUS_DST_ALPHA = &hA
end enum

declare function SDL_ComposeCustomBlendMode(byval srcColorFactor as SDL_BlendFactor, byval dstColorFactor as SDL_BlendFactor, byval colorOperation as SDL_BlendOperation, byval srcAlphaFactor as SDL_BlendFactor, byval dstAlphaFactor as SDL_BlendFactor, byval alphaOperation as SDL_BlendOperation) as SDL_BlendMode
const SDL_SWSURFACE = 0
const SDL_PREALLOC = &h00000001
const SDL_RLEACCEL = &h00000002
const SDL_DONTFREE = &h00000004
const SDL_SIMD_ALIGNED = &h00000008
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
	list_blitmap as any ptr
	clip_rect as SDL_Rect
	map as SDL_BlitMap ptr
	refcount as long
end type

type SDL_blit as function(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long

type SDL_YUV_CONVERSION_MODE as long
enum
	SDL_YUV_CONVERSION_JPEG
	SDL_YUV_CONVERSION_BT601
	SDL_YUV_CONVERSION_BT709
	SDL_YUV_CONVERSION_AUTOMATIC
end enum

declare function SDL_CreateRGBSurface(byval flags as Uint32, byval width as long, byval height as long, byval depth as long, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare function SDL_CreateRGBSurfaceWithFormat(byval flags as Uint32, byval width as long, byval height as long, byval depth as long, byval format as Uint32) as SDL_Surface ptr
declare function SDL_CreateRGBSurfaceFrom(byval pixels as any ptr, byval width as long, byval height as long, byval depth as long, byval pitch as long, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare function SDL_CreateRGBSurfaceWithFormatFrom(byval pixels as any ptr, byval width as long, byval height as long, byval depth as long, byval pitch as long, byval format as Uint32) as SDL_Surface ptr
declare sub SDL_FreeSurface(byval surface as SDL_Surface ptr)
declare function SDL_SetSurfacePalette(byval surface as SDL_Surface ptr, byval palette as SDL_Palette ptr) as long
declare function SDL_LockSurface(byval surface as SDL_Surface ptr) as long
declare sub SDL_UnlockSurface(byval surface as SDL_Surface ptr)
declare function SDL_LoadBMP_RW(byval src as SDL_RWops ptr, byval freesrc as long) as SDL_Surface ptr
#define SDL_LoadBMP(file) SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
declare function SDL_SaveBMP_RW(byval surface as SDL_Surface ptr, byval dst as SDL_RWops ptr, byval freedst as long) as long
#define SDL_SaveBMP(surface, file) SDL_SaveBMP_RW(surface, SDL_RWFromFile(file, "wb"), 1)
declare function SDL_SetSurfaceRLE(byval surface as SDL_Surface ptr, byval flag as long) as long
declare function SDL_HasSurfaceRLE(byval surface as SDL_Surface ptr) as SDL_bool
declare function SDL_SetColorKey(byval surface as SDL_Surface ptr, byval flag as long, byval key as Uint32) as long
declare function SDL_HasColorKey(byval surface as SDL_Surface ptr) as SDL_bool
declare function SDL_GetColorKey(byval surface as SDL_Surface ptr, byval key as Uint32 ptr) as long
declare function SDL_SetSurfaceColorMod(byval surface as SDL_Surface ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8) as long
declare function SDL_GetSurfaceColorMod(byval surface as SDL_Surface ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr) as long
declare function SDL_SetSurfaceAlphaMod(byval surface as SDL_Surface ptr, byval alpha as Uint8) as long
declare function SDL_GetSurfaceAlphaMod(byval surface as SDL_Surface ptr, byval alpha as Uint8 ptr) as long
declare function SDL_SetSurfaceBlendMode(byval surface as SDL_Surface ptr, byval blendMode as SDL_BlendMode) as long
declare function SDL_GetSurfaceBlendMode(byval surface as SDL_Surface ptr, byval blendMode as SDL_BlendMode ptr) as long
declare function SDL_SetClipRect(byval surface as SDL_Surface ptr, byval rect as const SDL_Rect ptr) as SDL_bool
declare sub SDL_GetClipRect(byval surface as SDL_Surface ptr, byval rect as SDL_Rect ptr)
declare function SDL_DuplicateSurface(byval surface as SDL_Surface ptr) as SDL_Surface ptr
declare function SDL_ConvertSurface(byval src as SDL_Surface ptr, byval fmt as const SDL_PixelFormat ptr, byval flags as Uint32) as SDL_Surface ptr
declare function SDL_ConvertSurfaceFormat(byval src as SDL_Surface ptr, byval pixel_format as Uint32, byval flags as Uint32) as SDL_Surface ptr
declare function SDL_ConvertPixels(byval width as long, byval height as long, byval src_format as Uint32, byval src as const any ptr, byval src_pitch as long, byval dst_format as Uint32, byval dst as any ptr, byval dst_pitch as long) as long
declare function SDL_FillRect(byval dst as SDL_Surface ptr, byval rect as const SDL_Rect ptr, byval color as Uint32) as long
declare function SDL_FillRects(byval dst as SDL_Surface ptr, byval rects as const SDL_Rect ptr, byval count as long, byval color as Uint32) as long
declare function SDL_UpperBlit(byval src as SDL_Surface ptr, byval srcrect as const SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_BlitSurface alias "SDL_UpperBlit"(byval src as SDL_Surface ptr, byval srcrect as const SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_LowerBlit(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_SoftStretch(byval src as SDL_Surface ptr, byval srcrect as const SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as const SDL_Rect ptr) as long
declare function SDL_UpperBlitScaled(byval src as SDL_Surface ptr, byval srcrect as const SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_BlitScaled alias "SDL_UpperBlitScaled"(byval src as SDL_Surface ptr, byval srcrect as const SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare function SDL_LowerBlitScaled(byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as long
declare sub SDL_SetYUVConversionMode(byval mode as SDL_YUV_CONVERSION_MODE)
declare function SDL_GetYUVConversionMode() as SDL_YUV_CONVERSION_MODE
declare function SDL_GetYUVConversionModeForResolution(byval width as long, byval height as long) as SDL_YUV_CONVERSION_MODE

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
	SDL_WINDOW_MOUSE_CAPTURE = &h00004000
	SDL_WINDOW_ALWAYS_ON_TOP = &h00008000
	SDL_WINDOW_SKIP_TASKBAR = &h00010000
	SDL_WINDOW_UTILITY = &h00020000
	SDL_WINDOW_TOOLTIP = &h00040000
	SDL_WINDOW_POPUP_MENU = &h00080000
	SDL_WINDOW_VULKAN = &h10000000
	SDL_WINDOW_METAL = &h20000000
end enum

const SDL_WINDOWPOS_UNDEFINED_MASK = &h1FFF0000u
#define SDL_WINDOWPOS_UNDEFINED_DISPLAY(X) (SDL_WINDOWPOS_UNDEFINED_MASK or (X))
#define SDL_WINDOWPOS_UNDEFINED SDL_WINDOWPOS_UNDEFINED_DISPLAY(0)
#define SDL_WINDOWPOS_ISUNDEFINED(X) (((X) and &hFFFF0000) = SDL_WINDOWPOS_UNDEFINED_MASK)
const SDL_WINDOWPOS_CENTERED_MASK = &h2FFF0000u
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
	SDL_WINDOWEVENT_TAKE_FOCUS
	SDL_WINDOWEVENT_HIT_TEST
end enum

type SDL_DisplayEventID as long
enum
	SDL_DISPLAYEVENT_NONE
	SDL_DISPLAYEVENT_ORIENTATION
	SDL_DISPLAYEVENT_CONNECTED
	SDL_DISPLAYEVENT_DISCONNECTED
end enum

type SDL_DisplayOrientation as long
enum
	SDL_ORIENTATION_UNKNOWN
	SDL_ORIENTATION_LANDSCAPE
	SDL_ORIENTATION_LANDSCAPE_FLIPPED
	SDL_ORIENTATION_PORTRAIT
	SDL_ORIENTATION_PORTRAIT_FLIPPED
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
	SDL_GL_CONTEXT_RELEASE_BEHAVIOR
	SDL_GL_CONTEXT_RESET_NOTIFICATION
	SDL_GL_CONTEXT_NO_ERROR
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

type SDL_GLcontextReleaseFlag as long
enum
	SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE = &h0000
	SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = &h0001
end enum

type SDL_GLContextResetNotification as long
enum
	SDL_GL_CONTEXT_RESET_NO_NOTIFICATION = &h0000
	SDL_GL_CONTEXT_RESET_LOSE_CONTEXT = &h0001
end enum

declare function SDL_GetNumVideoDrivers() as long
declare function SDL_GetVideoDriver(byval index as long) as const zstring ptr
declare function SDL_VideoInit(byval driver_name as const zstring ptr) as long
declare sub SDL_VideoQuit()
declare function SDL_GetCurrentVideoDriver() as const zstring ptr
declare function SDL_GetNumVideoDisplays() as long
declare function SDL_GetDisplayName(byval displayIndex as long) as const zstring ptr
declare function SDL_GetDisplayBounds(byval displayIndex as long, byval rect as SDL_Rect ptr) as long
declare function SDL_GetDisplayUsableBounds(byval displayIndex as long, byval rect as SDL_Rect ptr) as long
declare function SDL_GetDisplayDPI(byval displayIndex as long, byval ddpi as single ptr, byval hdpi as single ptr, byval vdpi as single ptr) as long
declare function SDL_GetDisplayOrientation(byval displayIndex as long) as SDL_DisplayOrientation
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
declare function SDL_GetWindowBordersSize(byval window as SDL_Window ptr, byval top as long ptr, byval left as long ptr, byval bottom as long ptr, byval right as long ptr) as long
declare sub SDL_SetWindowMinimumSize(byval window as SDL_Window ptr, byval min_w as long, byval min_h as long)
declare sub SDL_GetWindowMinimumSize(byval window as SDL_Window ptr, byval w as long ptr, byval h as long ptr)
declare sub SDL_SetWindowMaximumSize(byval window as SDL_Window ptr, byval max_w as long, byval max_h as long)
declare sub SDL_GetWindowMaximumSize(byval window as SDL_Window ptr, byval w as long ptr, byval h as long ptr)
declare sub SDL_SetWindowBordered(byval window as SDL_Window ptr, byval bordered as SDL_bool)
declare sub SDL_SetWindowResizable(byval window as SDL_Window ptr, byval resizable as SDL_bool)
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
declare function SDL_GetGrabbedWindow() as SDL_Window ptr
declare function SDL_SetWindowBrightness(byval window as SDL_Window ptr, byval brightness as single) as long
declare function SDL_GetWindowBrightness(byval window as SDL_Window ptr) as single
declare function SDL_SetWindowOpacity(byval window as SDL_Window ptr, byval opacity as single) as long
declare function SDL_GetWindowOpacity(byval window as SDL_Window ptr, byval out_opacity as single ptr) as long
declare function SDL_SetWindowModalFor(byval modal_window as SDL_Window ptr, byval parent_window as SDL_Window ptr) as long
declare function SDL_SetWindowInputFocus(byval window as SDL_Window ptr) as long
declare function SDL_SetWindowGammaRamp(byval window as SDL_Window ptr, byval red as const Uint16 ptr, byval green as const Uint16 ptr, byval blue as const Uint16 ptr) as long
declare function SDL_GetWindowGammaRamp(byval window as SDL_Window ptr, byval red as Uint16 ptr, byval green as Uint16 ptr, byval blue as Uint16 ptr) as long

type SDL_HitTestResult as long
enum
	SDL_HITTEST_NORMAL
	SDL_HITTEST_DRAGGABLE
	SDL_HITTEST_RESIZE_TOPLEFT
	SDL_HITTEST_RESIZE_TOP
	SDL_HITTEST_RESIZE_TOPRIGHT
	SDL_HITTEST_RESIZE_RIGHT
	SDL_HITTEST_RESIZE_BOTTOMRIGHT
	SDL_HITTEST_RESIZE_BOTTOM
	SDL_HITTEST_RESIZE_BOTTOMLEFT
	SDL_HITTEST_RESIZE_LEFT
end enum

type SDL_HitTest as function(byval win as SDL_Window ptr, byval area as const SDL_Point ptr, byval data as any ptr) as SDL_HitTestResult
declare function SDL_SetWindowHitTest(byval window as SDL_Window ptr, byval callback as SDL_HitTest, byval callback_data as any ptr) as long
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

#define SDL_keyboard_h_
#define SDL_keycode_h_
#define SDL_scancode_h_

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
	SDL_SCANCODE_AUDIOREWIND = 285
	SDL_SCANCODE_AUDIOFASTFORWARD = 286
	SDL_NUM_SCANCODES = 512
end enum

type SDL_Keycode as Sint32
const SDLK_SCANCODE_MASK = 1 shl 30
#define SDL_SCANCODE_TO_KEYCODE(X) (X or SDLK_SCANCODE_MASK)

type SDL_KeyCode as long
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
	SDLK_APP1 = SDL_SCANCODE_APP1 or (1 shl 30)
	SDLK_APP2 = SDL_SCANCODE_APP2 or (1 shl 30)
	SDLK_AUDIOREWIND = SDL_SCANCODE_AUDIOREWIND or (1 shl 30)
	SDLK_AUDIOFASTFORWARD = SDL_SCANCODE_AUDIOFASTFORWARD or (1 shl 30)
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
	KMOD_CTRL = KMOD_LCTRL or KMOD_RCTRL
	KMOD_SHIFT = KMOD_LSHIFT or KMOD_RSHIFT
	KMOD_ALT = KMOD_LALT or KMOD_RALT
	KMOD_GUI = KMOD_LGUI or KMOD_RGUI
end enum

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
#define SDL_mouse_h_

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

type SDL_MouseWheelDirection as long
enum
	SDL_MOUSEWHEEL_NORMAL
	SDL_MOUSEWHEEL_FLIPPED
end enum

declare function SDL_GetMouseFocus() as SDL_Window ptr
declare function SDL_GetMouseState(byval x as long ptr, byval y as long ptr) as Uint32
declare function SDL_GetGlobalMouseState(byval x as long ptr, byval y as long ptr) as Uint32
declare function SDL_GetRelativeMouseState(byval x as long ptr, byval y as long ptr) as Uint32
declare sub SDL_WarpMouseInWindow(byval window as SDL_Window ptr, byval x as long, byval y as long)
declare function SDL_WarpMouseGlobal(byval x as long, byval y as long) as long
declare function SDL_SetRelativeMouseMode(byval enabled as SDL_bool) as long
declare function SDL_CaptureMouse(byval enabled as SDL_bool) as long
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
#define SDL_joystick_h_
type SDL_Joystick as _SDL_Joystick

type SDL_JoystickGUID
	data(0 to 15) as Uint8
end type

type SDL_JoystickID as Sint32

type SDL_JoystickType as long
enum
	SDL_JOYSTICK_TYPE_UNKNOWN
	SDL_JOYSTICK_TYPE_GAMECONTROLLER
	SDL_JOYSTICK_TYPE_WHEEL
	SDL_JOYSTICK_TYPE_ARCADE_STICK
	SDL_JOYSTICK_TYPE_FLIGHT_STICK
	SDL_JOYSTICK_TYPE_DANCE_PAD
	SDL_JOYSTICK_TYPE_GUITAR
	SDL_JOYSTICK_TYPE_DRUM_KIT
	SDL_JOYSTICK_TYPE_ARCADE_PAD
	SDL_JOYSTICK_TYPE_THROTTLE
end enum

type SDL_JoystickPowerLevel as long
enum
	SDL_JOYSTICK_POWER_UNKNOWN = -1
	SDL_JOYSTICK_POWER_EMPTY
	SDL_JOYSTICK_POWER_LOW
	SDL_JOYSTICK_POWER_MEDIUM
	SDL_JOYSTICK_POWER_FULL
	SDL_JOYSTICK_POWER_WIRED
	SDL_JOYSTICK_POWER_MAX
end enum

const SDL_IPHONE_MAX_GFORCE = 5.0
declare sub SDL_LockJoysticks()
declare sub SDL_UnlockJoysticks()
declare function SDL_NumJoysticks() as long
declare function SDL_JoystickNameForIndex(byval device_index as long) as const zstring ptr
declare function SDL_JoystickGetDevicePlayerIndex(byval device_index as long) as long
declare function SDL_JoystickGetDeviceGUID(byval device_index as long) as SDL_JoystickGUID
declare function SDL_JoystickGetDeviceVendor(byval device_index as long) as Uint16
declare function SDL_JoystickGetDeviceProduct(byval device_index as long) as Uint16
declare function SDL_JoystickGetDeviceProductVersion(byval device_index as long) as Uint16
declare function SDL_JoystickGetDeviceType(byval device_index as long) as SDL_JoystickType
declare function SDL_JoystickGetDeviceInstanceID(byval device_index as long) as SDL_JoystickID
declare function SDL_JoystickOpen(byval device_index as long) as SDL_Joystick ptr
declare function SDL_JoystickFromInstanceID(byval instance_id as SDL_JoystickID) as SDL_Joystick ptr
declare function SDL_JoystickFromPlayerIndex(byval player_index as long) as SDL_Joystick ptr
declare function SDL_JoystickAttachVirtual(byval type as SDL_JoystickType, byval naxes as long, byval nbuttons as long, byval nhats as long) as long
declare function SDL_JoystickDetachVirtual(byval device_index as long) as long
declare function SDL_JoystickIsVirtual(byval device_index as long) as SDL_bool
declare function SDL_JoystickSetVirtualAxis(byval joystick as SDL_Joystick ptr, byval axis as long, byval value as Sint16) as long
declare function SDL_JoystickSetVirtualButton(byval joystick as SDL_Joystick ptr, byval button as long, byval value as Uint8) as long
declare function SDL_JoystickSetVirtualHat(byval joystick as SDL_Joystick ptr, byval hat as long, byval value as Uint8) as long
declare function SDL_JoystickName(byval joystick as SDL_Joystick ptr) as const zstring ptr
declare function SDL_JoystickGetPlayerIndex(byval joystick as SDL_Joystick ptr) as long
declare sub SDL_JoystickSetPlayerIndex(byval joystick as SDL_Joystick ptr, byval player_index as long)
declare function SDL_JoystickGetGUID(byval joystick as SDL_Joystick ptr) as SDL_JoystickGUID
declare function SDL_JoystickGetVendor(byval joystick as SDL_Joystick ptr) as Uint16
declare function SDL_JoystickGetProduct(byval joystick as SDL_Joystick ptr) as Uint16
declare function SDL_JoystickGetProductVersion(byval joystick as SDL_Joystick ptr) as Uint16
declare function SDL_JoystickGetSerial(byval joystick as SDL_Joystick ptr) as const zstring ptr
declare function SDL_JoystickGetType(byval joystick as SDL_Joystick ptr) as SDL_JoystickType
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
const SDL_JOYSTICK_AXIS_MAX = 32767
const SDL_JOYSTICK_AXIS_MIN = -32768
declare function SDL_JoystickGetAxis(byval joystick as SDL_Joystick ptr, byval axis as long) as Sint16
declare function SDL_JoystickGetAxisInitialState(byval joystick as SDL_Joystick ptr, byval axis as long, byval state as Sint16 ptr) as SDL_bool

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
declare function SDL_JoystickRumble(byval joystick as SDL_Joystick ptr, byval low_frequency_rumble as Uint16, byval high_frequency_rumble as Uint16, byval duration_ms as Uint32) as long
declare function SDL_JoystickRumbleTriggers(byval joystick as SDL_Joystick ptr, byval left_rumble as Uint16, byval right_rumble as Uint16, byval duration_ms as Uint32) as long
declare function SDL_JoystickHasLED(byval joystick as SDL_Joystick ptr) as SDL_bool
declare function SDL_JoystickSetLED(byval joystick as SDL_Joystick ptr, byval red as Uint8, byval green as Uint8, byval blue as Uint8) as long
declare sub SDL_JoystickClose(byval joystick as SDL_Joystick ptr)
declare function SDL_JoystickCurrentPowerLevel(byval joystick as SDL_Joystick ptr) as SDL_JoystickPowerLevel
#define SDL_gamecontroller_h_
#define SDL_sensor_h_
type SDL_Sensor as _SDL_Sensor
type SDL_SensorID as Sint32

type SDL_SensorType as long
enum
	SDL_SENSOR_INVALID = -1
	SDL_SENSOR_UNKNOWN
	SDL_SENSOR_ACCEL
	SDL_SENSOR_GYRO
end enum

const SDL_STANDARD_GRAVITY = 9.80665f
declare sub SDL_LockSensors()
declare sub SDL_UnlockSensors()
declare function SDL_NumSensors() as long
declare function SDL_SensorGetDeviceName(byval device_index as long) as const zstring ptr
declare function SDL_SensorGetDeviceType(byval device_index as long) as SDL_SensorType
declare function SDL_SensorGetDeviceNonPortableType(byval device_index as long) as long
declare function SDL_SensorGetDeviceInstanceID(byval device_index as long) as SDL_SensorID
declare function SDL_SensorOpen(byval device_index as long) as SDL_Sensor ptr
declare function SDL_SensorFromInstanceID(byval instance_id as SDL_SensorID) as SDL_Sensor ptr
declare function SDL_SensorGetName(byval sensor as SDL_Sensor ptr) as const zstring ptr
declare function SDL_SensorGetType(byval sensor as SDL_Sensor ptr) as SDL_SensorType
declare function SDL_SensorGetNonPortableType(byval sensor as SDL_Sensor ptr) as long
declare function SDL_SensorGetInstanceID(byval sensor as SDL_Sensor ptr) as SDL_SensorID
declare function SDL_SensorGetData(byval sensor as SDL_Sensor ptr, byval data as single ptr, byval num_values as long) as long
declare sub SDL_SensorClose(byval sensor as SDL_Sensor ptr)
declare sub SDL_SensorUpdate()
type SDL_GameController as _SDL_GameController

type SDL_GameControllerType as long
enum
	SDL_CONTROLLER_TYPE_UNKNOWN = 0
	SDL_CONTROLLER_TYPE_XBOX360
	SDL_CONTROLLER_TYPE_XBOXONE
	SDL_CONTROLLER_TYPE_PS3
	SDL_CONTROLLER_TYPE_PS4
	SDL_CONTROLLER_TYPE_NINTENDO_SWITCH_PRO
	SDL_CONTROLLER_TYPE_VIRTUAL
	SDL_CONTROLLER_TYPE_PS5
end enum

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
declare function SDL_GameControllerNumMappings() as long
declare function SDL_GameControllerMappingForIndex(byval mapping_index as long) as zstring ptr
declare function SDL_GameControllerMappingForGUID(byval guid as SDL_JoystickGUID) as zstring ptr
declare function SDL_GameControllerMapping(byval gamecontroller as SDL_GameController ptr) as zstring ptr
declare function SDL_IsGameController(byval joystick_index as long) as SDL_bool
declare function SDL_GameControllerNameForIndex(byval joystick_index as long) as const zstring ptr
declare function SDL_GameControllerTypeForIndex(byval joystick_index as long) as SDL_GameControllerType
declare function SDL_GameControllerMappingForDeviceIndex(byval joystick_index as long) as zstring ptr
declare function SDL_GameControllerOpen(byval joystick_index as long) as SDL_GameController ptr
declare function SDL_GameControllerFromInstanceID(byval joyid as SDL_JoystickID) as SDL_GameController ptr
declare function SDL_GameControllerFromPlayerIndex(byval player_index as long) as SDL_GameController ptr
declare function SDL_GameControllerName(byval gamecontroller as SDL_GameController ptr) as const zstring ptr
declare function SDL_GameControllerGetType(byval gamecontroller as SDL_GameController ptr) as SDL_GameControllerType
declare function SDL_GameControllerGetPlayerIndex(byval gamecontroller as SDL_GameController ptr) as long
declare sub SDL_GameControllerSetPlayerIndex(byval gamecontroller as SDL_GameController ptr, byval player_index as long)
declare function SDL_GameControllerGetVendor(byval gamecontroller as SDL_GameController ptr) as Uint16
declare function SDL_GameControllerGetProduct(byval gamecontroller as SDL_GameController ptr) as Uint16
declare function SDL_GameControllerGetProductVersion(byval gamecontroller as SDL_GameController ptr) as Uint16
declare function SDL_GameControllerGetSerial(byval gamecontroller as SDL_GameController ptr) as const zstring ptr
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
declare function SDL_GameControllerHasAxis(byval gamecontroller as SDL_GameController ptr, byval axis as SDL_GameControllerAxis) as SDL_bool
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
	SDL_CONTROLLER_BUTTON_MISC1
	SDL_CONTROLLER_BUTTON_PADDLE1
	SDL_CONTROLLER_BUTTON_PADDLE2
	SDL_CONTROLLER_BUTTON_PADDLE3
	SDL_CONTROLLER_BUTTON_PADDLE4
	SDL_CONTROLLER_BUTTON_TOUCHPAD
	SDL_CONTROLLER_BUTTON_MAX
end enum

declare function SDL_GameControllerGetButtonFromString(byval pchString as const zstring ptr) as SDL_GameControllerButton
declare function SDL_GameControllerGetStringForButton(byval button as SDL_GameControllerButton) as const zstring ptr
declare function SDL_GameControllerGetBindForButton(byval gamecontroller as SDL_GameController ptr, byval button as SDL_GameControllerButton) as SDL_GameControllerButtonBind
declare function SDL_GameControllerHasButton(byval gamecontroller as SDL_GameController ptr, byval button as SDL_GameControllerButton) as SDL_bool
declare function SDL_GameControllerGetButton(byval gamecontroller as SDL_GameController ptr, byval button as SDL_GameControllerButton) as Uint8
declare function SDL_GameControllerGetNumTouchpads(byval gamecontroller as SDL_GameController ptr) as long
declare function SDL_GameControllerGetNumTouchpadFingers(byval gamecontroller as SDL_GameController ptr, byval touchpad as long) as long
declare function SDL_GameControllerGetTouchpadFinger(byval gamecontroller as SDL_GameController ptr, byval touchpad as long, byval finger as long, byval state as Uint8 ptr, byval x as single ptr, byval y as single ptr, byval pressure as single ptr) as long
declare function SDL_GameControllerHasSensor(byval gamecontroller as SDL_GameController ptr, byval type as SDL_SensorType) as SDL_bool
declare function SDL_GameControllerSetSensorEnabled(byval gamecontroller as SDL_GameController ptr, byval type as SDL_SensorType, byval enabled as SDL_bool) as long
declare function SDL_GameControllerIsSensorEnabled(byval gamecontroller as SDL_GameController ptr, byval type as SDL_SensorType) as SDL_bool
declare function SDL_GameControllerGetSensorData(byval gamecontroller as SDL_GameController ptr, byval type as SDL_SensorType, byval data as single ptr, byval num_values as long) as long
declare function SDL_GameControllerRumble(byval gamecontroller as SDL_GameController ptr, byval low_frequency_rumble as Uint16, byval high_frequency_rumble as Uint16, byval duration_ms as Uint32) as long
declare function SDL_GameControllerRumbleTriggers(byval gamecontroller as SDL_GameController ptr, byval left_rumble as Uint16, byval right_rumble as Uint16, byval duration_ms as Uint32) as long
declare function SDL_GameControllerHasLED(byval gamecontroller as SDL_GameController ptr) as SDL_bool
declare function SDL_GameControllerSetLED(byval gamecontroller as SDL_GameController ptr, byval red as Uint8, byval green as Uint8, byval blue as Uint8) as long
declare sub SDL_GameControllerClose(byval gamecontroller as SDL_GameController ptr)

#define SDL_quit_h_
#define SDL_gesture_h_
#define SDL_touch_h_
type SDL_TouchID as Sint64
type SDL_FingerID as Sint64

type SDL_TouchDeviceType as long
enum
	SDL_TOUCH_DEVICE_INVALID = -1
	SDL_TOUCH_DEVICE_DIRECT
	SDL_TOUCH_DEVICE_INDIRECT_ABSOLUTE
	SDL_TOUCH_DEVICE_INDIRECT_RELATIVE
end enum

type SDL_Finger
	id as SDL_FingerID
	x as single
	y as single
	pressure as single
end type

const SDL_TOUCH_MOUSEID = cast(Uint32, -1)
const SDL_MOUSE_TOUCHID = cast(Sint64, -1)
declare function SDL_GetNumTouchDevices() as long
declare function SDL_GetTouchDevice(byval index as long) as SDL_TouchID
declare function SDL_GetTouchDeviceType(byval touchID as SDL_TouchID) as SDL_TouchDeviceType
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
	SDL_LOCALECHANGED
	SDL_DISPLAYEVENT = &h150
	SDL_WINDOWEVENT = &h200
	SDL_SYSWMEVENT
	SDL_KEYDOWN = &h300
	SDL_KEYUP
	SDL_TEXTEDITING
	SDL_TEXTINPUT
	SDL_KEYMAPCHANGED
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
	SDL_CONTROLLERTOUCHPADDOWN
	SDL_CONTROLLERTOUCHPADMOTION
	SDL_CONTROLLERTOUCHPADUP
	SDL_CONTROLLERSENSORUPDATE
	SDL_FINGERDOWN = &h700
	SDL_FINGERUP
	SDL_FINGERMOTION
	SDL_DOLLARGESTURE = &h800
	SDL_DOLLARRECORD
	SDL_MULTIGESTURE
	SDL_CLIPBOARDUPDATE = &h900
	SDL_DROPFILE = &h1000
	SDL_DROPTEXT
	SDL_DROPBEGIN
	SDL_DROPCOMPLETE
	SDL_AUDIODEVICEADDED = &h1100
	SDL_AUDIODEVICEREMOVED
	SDL_SENSORUPDATEEVENT = &h1200
	SDL_RENDER_TARGETS_RESET = &h2000
	SDL_RENDER_DEVICE_RESET
	SDL_USEREVENT = &h8000
	SDL_LASTEVENT = &hFFFF
end enum

type SDL_CommonEvent
	as Uint32 type
	timestamp as Uint32
end type

type SDL_DisplayEvent
	as Uint32 type
	timestamp as Uint32
	display as Uint32
	event as Uint8
	padding1 as Uint8
	padding2 as Uint8
	padding3 as Uint8
	data1 as Sint32
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
	direction as Uint32
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

type SDL_ControllerTouchpadEvent
	as Uint32 type
	timestamp as Uint32
	which as SDL_JoystickID
	touchpad as Sint32
	finger as Sint32
	x as single
	y as single
	pressure as single
end type

type SDL_ControllerSensorEvent
	as Uint32 type
	timestamp as Uint32
	which as SDL_JoystickID
	sensor as Sint32
	data(0 to 2) as single
end type

type SDL_AudioDeviceEvent
	as Uint32 type
	timestamp as Uint32
	which as Uint32
	iscapture as Uint8
	padding1 as Uint8
	padding2 as Uint8
	padding3 as Uint8
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
	windowID as Uint32
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
	windowID as Uint32
end type

type SDL_SensorEvent
	as Uint32 type
	timestamp as Uint32
	which as Sint32
	data(0 to 5) as single
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
	display as SDL_DisplayEvent
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
	ctouchpad as SDL_ControllerTouchpadEvent
	csensor as SDL_ControllerSensorEvent
	adevice as SDL_AudioDeviceEvent
	sensor as SDL_SensorEvent
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
#define SDL_filesystem_h_
declare function SDL_GetBasePath() as zstring ptr
declare function SDL_GetPrefPath(byval org as const zstring ptr, byval app as const zstring ptr) as zstring ptr
#define SDL_haptic_h_
type SDL_Haptic as _SDL_Haptic
const SDL_HAPTIC_CONSTANT = culng(1u shl 0)
const SDL_HAPTIC_SINE = culng(1u shl 1)
const SDL_HAPTIC_LEFTRIGHT = culng(1u shl 2)
const SDL_HAPTIC_TRIANGLE = culng(1u shl 3)
const SDL_HAPTIC_SAWTOOTHUP = culng(1u shl 4)
const SDL_HAPTIC_SAWTOOTHDOWN = culng(1u shl 5)
const SDL_HAPTIC_RAMP = culng(1u shl 6)
const SDL_HAPTIC_SPRING = culng(1u shl 7)
const SDL_HAPTIC_DAMPER = culng(1u shl 8)
const SDL_HAPTIC_INERTIA = culng(1u shl 9)
const SDL_HAPTIC_FRICTION = culng(1u shl 10)
const SDL_HAPTIC_CUSTOM = culng(1u shl 11)
const SDL_HAPTIC_GAIN = culng(1u shl 12)
const SDL_HAPTIC_AUTOCENTER = culng(1u shl 13)
const SDL_HAPTIC_STATUS = culng(1u shl 14)
const SDL_HAPTIC_PAUSE = culng(1u shl 15)
const SDL_HAPTIC_POLAR = 0
const SDL_HAPTIC_CARTESIAN = 1
const SDL_HAPTIC_SPHERICAL = 2
const SDL_HAPTIC_STEERING_AXIS = 3
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

#define SDL_hints_h_
#define SDL_HINT_FRAMEBUFFER_ACCELERATION "SDL_FRAMEBUFFER_ACCELERATION"
#define SDL_HINT_RENDER_DRIVER "SDL_RENDER_DRIVER"
#define SDL_HINT_RENDER_OPENGL_SHADERS "SDL_RENDER_OPENGL_SHADERS"
#define SDL_HINT_RENDER_DIRECT3D_THREADSAFE "SDL_RENDER_DIRECT3D_THREADSAFE"
#define SDL_HINT_RENDER_DIRECT3D11_DEBUG "SDL_RENDER_DIRECT3D11_DEBUG"
#define SDL_HINT_RENDER_LOGICAL_SIZE_MODE "SDL_RENDER_LOGICAL_SIZE_MODE"
#define SDL_HINT_RENDER_SCALE_QUALITY "SDL_RENDER_SCALE_QUALITY"
#define SDL_HINT_RENDER_VSYNC "SDL_RENDER_VSYNC"
#define SDL_HINT_VIDEO_ALLOW_SCREENSAVER "SDL_VIDEO_ALLOW_SCREENSAVER"
#define SDL_HINT_VIDEO_EXTERNAL_CONTEXT "SDL_VIDEO_EXTERNAL_CONTEXT"
#define SDL_HINT_VIDEO_X11_XVIDMODE "SDL_VIDEO_X11_XVIDMODE"
#define SDL_HINT_VIDEO_X11_XINERAMA "SDL_VIDEO_X11_XINERAMA"
#define SDL_HINT_VIDEO_X11_XRANDR "SDL_VIDEO_X11_XRANDR"
#define SDL_HINT_VIDEO_X11_WINDOW_VISUALID "SDL_VIDEO_X11_WINDOW_VISUALID"
#define SDL_HINT_VIDEO_X11_NET_WM_PING "SDL_VIDEO_X11_NET_WM_PING"
#define SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR "SDL_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR"
#define SDL_HINT_VIDEO_X11_FORCE_EGL "SDL_VIDEO_X11_FORCE_EGL"
#define SDL_HINT_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN "SDL_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN"
#define SDL_HINT_WINDOWS_INTRESOURCE_ICON "SDL_WINDOWS_INTRESOURCE_ICON"
#define SDL_HINT_WINDOWS_INTRESOURCE_ICON_SMALL "SDL_WINDOWS_INTRESOURCE_ICON_SMALL"
#define SDL_HINT_WINDOWS_ENABLE_MESSAGELOOP "SDL_WINDOWS_ENABLE_MESSAGELOOP"
#define SDL_HINT_GRAB_KEYBOARD "SDL_GRAB_KEYBOARD"
#define SDL_HINT_MOUSE_DOUBLE_CLICK_TIME "SDL_MOUSE_DOUBLE_CLICK_TIME"
#define SDL_HINT_MOUSE_DOUBLE_CLICK_RADIUS "SDL_MOUSE_DOUBLE_CLICK_RADIUS"
#define SDL_HINT_MOUSE_NORMAL_SPEED_SCALE "SDL_MOUSE_NORMAL_SPEED_SCALE"
#define SDL_HINT_MOUSE_RELATIVE_SPEED_SCALE "SDL_MOUSE_RELATIVE_SPEED_SCALE"
#define SDL_HINT_MOUSE_RELATIVE_SCALING "SDL_MOUSE_RELATIVE_SCALING"
#define SDL_HINT_MOUSE_RELATIVE_MODE_WARP "SDL_MOUSE_RELATIVE_MODE_WARP"
#define SDL_HINT_MOUSE_FOCUS_CLICKTHROUGH "SDL_MOUSE_FOCUS_CLICKTHROUGH"
#define SDL_HINT_TOUCH_MOUSE_EVENTS "SDL_TOUCH_MOUSE_EVENTS"
#define SDL_HINT_MOUSE_TOUCH_EVENTS "SDL_MOUSE_TOUCH_EVENTS"
#define SDL_HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS "SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS"
#define SDL_HINT_IDLE_TIMER_DISABLED "SDL_IOS_IDLE_TIMER_DISABLED"
#define SDL_HINT_ORIENTATIONS "SDL_IOS_ORIENTATIONS"
#define SDL_HINT_APPLE_TV_CONTROLLER_UI_EVENTS "SDL_APPLE_TV_CONTROLLER_UI_EVENTS"
#define SDL_HINT_APPLE_TV_REMOTE_ALLOW_ROTATION "SDL_APPLE_TV_REMOTE_ALLOW_ROTATION"
#define SDL_HINT_IOS_HIDE_HOME_INDICATOR "SDL_IOS_HIDE_HOME_INDICATOR"
#define SDL_HINT_ACCELEROMETER_AS_JOYSTICK "SDL_ACCELEROMETER_AS_JOYSTICK"
#define SDL_HINT_TV_REMOTE_AS_JOYSTICK "SDL_TV_REMOTE_AS_JOYSTICK"
#define SDL_HINT_XINPUT_ENABLED "SDL_XINPUT_ENABLED"
#define SDL_HINT_XINPUT_USE_OLD_JOYSTICK_MAPPING "SDL_XINPUT_USE_OLD_JOYSTICK_MAPPING"
#define SDL_HINT_GAMECONTROLLERTYPE "SDL_GAMECONTROLLERTYPE"
#define SDL_HINT_GAMECONTROLLERCONFIG "SDL_GAMECONTROLLERCONFIG"
#define SDL_HINT_GAMECONTROLLERCONFIG_FILE "SDL_GAMECONTROLLERCONFIG_FILE"
#define SDL_HINT_GAMECONTROLLER_IGNORE_DEVICES "SDL_GAMECONTROLLER_IGNORE_DEVICES"
#define SDL_HINT_GAMECONTROLLER_IGNORE_DEVICES_EXCEPT "SDL_GAMECONTROLLER_IGNORE_DEVICES_EXCEPT"
#define SDL_HINT_GAMECONTROLLER_USE_BUTTON_LABELS "SDL_GAMECONTROLLER_USE_BUTTON_LABELS"
#define SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS "SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS"
#define SDL_HINT_JOYSTICK_HIDAPI "SDL_JOYSTICK_HIDAPI"
#define SDL_HINT_JOYSTICK_HIDAPI_PS4 "SDL_JOYSTICK_HIDAPI_PS4"
#define SDL_HINT_JOYSTICK_HIDAPI_PS5 "SDL_JOYSTICK_HIDAPI_PS5"
#define SDL_HINT_JOYSTICK_HIDAPI_PS4_RUMBLE "SDL_JOYSTICK_HIDAPI_PS4_RUMBLE"
#define SDL_HINT_JOYSTICK_HIDAPI_STEAM "SDL_JOYSTICK_HIDAPI_STEAM"
#define SDL_HINT_JOYSTICK_HIDAPI_SWITCH "SDL_JOYSTICK_HIDAPI_SWITCH"
#define SDL_HINT_JOYSTICK_HIDAPI_XBOX "SDL_JOYSTICK_HIDAPI_XBOX"
#define SDL_HINT_JOYSTICK_HIDAPI_CORRELATE_XINPUT "SDL_JOYSTICK_HIDAPI_CORRELATE_XINPUT"
#define SDL_HINT_JOYSTICK_HIDAPI_GAMECUBE "SDL_JOYSTICK_HIDAPI_GAMECUBE"
#define SDL_HINT_ENABLE_STEAM_CONTROLLERS "SDL_ENABLE_STEAM_CONTROLLERS"
#define SDL_HINT_JOYSTICK_RAWINPUT "SDL_JOYSTICK_RAWINPUT"
#define SDL_HINT_JOYSTICK_THREAD "SDL_JOYSTICK_THREAD"
#define SDL_HINT_LINUX_JOYSTICK_DEADZONES "SDL_LINUX_JOYSTICK_DEADZONES"
#define SDL_HINT_ALLOW_TOPMOST "SDL_ALLOW_TOPMOST"
#define SDL_HINT_TIMER_RESOLUTION "SDL_TIMER_RESOLUTION"
#define SDL_HINT_QTWAYLAND_CONTENT_ORIENTATION "SDL_QTWAYLAND_CONTENT_ORIENTATION"
#define SDL_HINT_QTWAYLAND_WINDOW_FLAGS "SDL_QTWAYLAND_WINDOW_FLAGS"
#define SDL_HINT_THREAD_STACK_SIZE "SDL_THREAD_STACK_SIZE"
#define SDL_HINT_THREAD_PRIORITY_POLICY "SDL_THREAD_PRIORITY_POLICY"
#define SDL_HINT_THREAD_FORCE_REALTIME_TIME_CRITICAL "SDL_THREAD_FORCE_REALTIME_TIME_CRITICAL"
#define SDL_HINT_VIDEO_HIGHDPI_DISABLED "SDL_VIDEO_HIGHDPI_DISABLED"
#define SDL_HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK "SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK"
#define SDL_HINT_VIDEO_WIN_D3DCOMPILER "SDL_VIDEO_WIN_D3DCOMPILER"
#define SDL_HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT "SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT"
#define SDL_HINT_WINRT_PRIVACY_POLICY_URL "SDL_WINRT_PRIVACY_POLICY_URL"
#define SDL_HINT_WINRT_PRIVACY_POLICY_LABEL "SDL_WINRT_PRIVACY_POLICY_LABEL"
#define SDL_HINT_WINRT_HANDLE_BACK_BUTTON "SDL_WINRT_HANDLE_BACK_BUTTON"
#define SDL_HINT_VIDEO_MAC_FULLSCREEN_SPACES "SDL_VIDEO_MAC_FULLSCREEN_SPACES"
#define SDL_HINT_MAC_BACKGROUND_APP "SDL_MAC_BACKGROUND_APP"
#define SDL_HINT_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION "SDL_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION"
#define SDL_HINT_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION "SDL_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION"
#define SDL_HINT_IME_INTERNAL_EDITING "SDL_IME_INTERNAL_EDITING"
#define SDL_HINT_ANDROID_TRAP_BACK_BUTTON "SDL_ANDROID_TRAP_BACK_BUTTON"
#define SDL_HINT_ANDROID_BLOCK_ON_PAUSE "SDL_ANDROID_BLOCK_ON_PAUSE"
#define SDL_HINT_ANDROID_BLOCK_ON_PAUSE_PAUSEAUDIO "SDL_ANDROID_BLOCK_ON_PAUSE_PAUSEAUDIO"
#define SDL_HINT_RETURN_KEY_HIDES_IME "SDL_RETURN_KEY_HIDES_IME"
#define SDL_HINT_EMSCRIPTEN_KEYBOARD_ELEMENT "SDL_EMSCRIPTEN_KEYBOARD_ELEMENT"
#define SDL_HINT_EMSCRIPTEN_ASYNCIFY "SDL_EMSCRIPTEN_ASYNCIFY"
#define SDL_HINT_NO_SIGNAL_HANDLERS "SDL_NO_SIGNAL_HANDLERS"
#define SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4 "SDL_WINDOWS_NO_CLOSE_ON_ALT_F4"
#define SDL_HINT_BMP_SAVE_LEGACY_FORMAT "SDL_BMP_SAVE_LEGACY_FORMAT"
#define SDL_HINT_WINDOWS_DISABLE_THREAD_NAMING "SDL_WINDOWS_DISABLE_THREAD_NAMING"
#define SDL_HINT_RPI_VIDEO_LAYER "SDL_RPI_VIDEO_LAYER"
#define SDL_HINT_VIDEO_DOUBLE_BUFFER "SDL_VIDEO_DOUBLE_BUFFER"
#define SDL_HINT_OPENGL_ES_DRIVER "SDL_OPENGL_ES_DRIVER"
#define SDL_HINT_AUDIO_RESAMPLING_MODE "SDL_AUDIO_RESAMPLING_MODE"
#define SDL_HINT_AUDIO_CATEGORY "SDL_AUDIO_CATEGORY"
#define SDL_HINT_RENDER_BATCHING "SDL_RENDER_BATCHING"
#define SDL_HINT_AUTO_UPDATE_JOYSTICKS "SDL_AUTO_UPDATE_JOYSTICKS"
#define SDL_HINT_AUTO_UPDATE_SENSORS "SDL_AUTO_UPDATE_SENSORS"
#define SDL_HINT_EVENT_LOGGING "SDL_EVENT_LOGGING"
#define SDL_HINT_WAVE_RIFF_CHUNK_SIZE "SDL_WAVE_RIFF_CHUNK_SIZE"
#define SDL_HINT_WAVE_TRUNCATION "SDL_WAVE_TRUNCATION"
#define SDL_HINT_WAVE_FACT_CHUNK "SDL_WAVE_FACT_CHUNK"
#define SDL_HINT_DISPLAY_USABLE_BOUNDS "SDL_DISPLAY_USABLE_BOUNDS"
#define SDL_HINT_AUDIO_DEVICE_APP_NAME "SDL_AUDIO_DEVICE_APP_NAME"
#define SDL_HINT_AUDIO_DEVICE_STREAM_NAME "SDL_AUDIO_DEVICE_STREAM_NAME"
#define SDL_HINT_PREFERRED_LOCALES "SDL_PREFERRED_LOCALES"

type SDL_HintPriority as long
enum
	SDL_HINT_DEFAULT
	SDL_HINT_NORMAL
	SDL_HINT_OVERRIDE
end enum

declare function SDL_SetHintWithPriority(byval name as const zstring ptr, byval value as const zstring ptr, byval priority as SDL_HintPriority) as SDL_bool
declare function SDL_SetHint(byval name as const zstring ptr, byval value as const zstring ptr) as SDL_bool
declare function SDL_GetHint(byval name as const zstring ptr) as const zstring ptr
declare function SDL_GetHintBoolean(byval name as const zstring ptr, byval default_value as SDL_bool) as SDL_bool
type SDL_HintCallback as sub(byval userdata as any ptr, byval name as const zstring ptr, byval oldValue as const zstring ptr, byval newValue as const zstring ptr)
declare sub SDL_AddHintCallback(byval name as const zstring ptr, byval callback as SDL_HintCallback, byval userdata as any ptr)
declare sub SDL_DelHintCallback(byval name as const zstring ptr, byval callback as SDL_HintCallback, byval userdata as any ptr)
declare sub SDL_ClearHints()
#define SDL_loadso_h_
declare function SDL_LoadObject(byval sofile as const zstring ptr) as any ptr
declare function SDL_LoadFunction(byval handle as any ptr, byval name as const zstring ptr) as any ptr
declare sub SDL_UnloadObject(byval handle as any ptr)
#define SDL_log_h_
const SDL_MAX_LOG_MESSAGE = 4096

type SDL_LogCategory as long
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
#define SDL_messagebox_h_

type SDL_MessageBoxFlags as long
enum
	SDL_MESSAGEBOX_ERROR = &h00000010
	SDL_MESSAGEBOX_WARNING = &h00000020
	SDL_MESSAGEBOX_INFORMATION = &h00000040
	SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT = &h00000080
	SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT = &h00000100
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
#define SDL_metal_h_
type SDL_MetalView as any ptr
declare function SDL_Metal_CreateView(byval window as SDL_Window ptr) as SDL_MetalView
declare sub SDL_Metal_DestroyView(byval view as SDL_MetalView)
declare function SDL_Metal_GetLayer(byval view as SDL_MetalView) as any ptr
declare sub SDL_Metal_GetDrawableSize(byval window as SDL_Window ptr, byval w as long ptr, byval h as long ptr)
#define SDL_power_h_

type SDL_PowerState as long
enum
	SDL_POWERSTATE_UNKNOWN
	SDL_POWERSTATE_ON_BATTERY
	SDL_POWERSTATE_NO_BATTERY
	SDL_POWERSTATE_CHARGING
	SDL_POWERSTATE_CHARGED
end enum

declare function SDL_GetPowerInfo(byval secs as long ptr, byval pct as long ptr) as SDL_PowerState
#define SDL_render_h_

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

type SDL_ScaleMode as long
enum
	SDL_ScaleModeNearest
	SDL_ScaleModeLinear
	SDL_ScaleModeBest
end enum

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
declare function SDL_SetTextureScaleMode(byval texture as SDL_Texture ptr, byval scaleMode as SDL_ScaleMode) as long
declare function SDL_GetTextureScaleMode(byval texture as SDL_Texture ptr, byval scaleMode as SDL_ScaleMode ptr) as long
declare function SDL_UpdateTexture(byval texture as SDL_Texture ptr, byval rect as const SDL_Rect ptr, byval pixels as const any ptr, byval pitch as long) as long
declare function SDL_UpdateYUVTexture(byval texture as SDL_Texture ptr, byval rect as const SDL_Rect ptr, byval Yplane as const Uint8 ptr, byval Ypitch as long, byval Uplane as const Uint8 ptr, byval Upitch as long, byval Vplane as const Uint8 ptr, byval Vpitch as long) as long
declare function SDL_LockTexture(byval texture as SDL_Texture ptr, byval rect as const SDL_Rect ptr, byval pixels as any ptr ptr, byval pitch as long ptr) as long
declare function SDL_LockTextureToSurface(byval texture as SDL_Texture ptr, byval rect as const SDL_Rect ptr, byval surface as SDL_Surface ptr ptr) as long
declare sub SDL_UnlockTexture(byval texture as SDL_Texture ptr)
declare function SDL_RenderTargetSupported(byval renderer as SDL_Renderer ptr) as SDL_bool
declare function SDL_SetRenderTarget(byval renderer as SDL_Renderer ptr, byval texture as SDL_Texture ptr) as long
declare function SDL_GetRenderTarget(byval renderer as SDL_Renderer ptr) as SDL_Texture ptr
declare function SDL_RenderSetLogicalSize(byval renderer as SDL_Renderer ptr, byval w as long, byval h as long) as long
declare sub SDL_RenderGetLogicalSize(byval renderer as SDL_Renderer ptr, byval w as long ptr, byval h as long ptr)
declare function SDL_RenderSetIntegerScale(byval renderer as SDL_Renderer ptr, byval enable as SDL_bool) as long
declare function SDL_RenderGetIntegerScale(byval renderer as SDL_Renderer ptr) as SDL_bool
declare function SDL_RenderSetViewport(byval renderer as SDL_Renderer ptr, byval rect as const SDL_Rect ptr) as long
declare sub SDL_RenderGetViewport(byval renderer as SDL_Renderer ptr, byval rect as SDL_Rect ptr)
declare function SDL_RenderSetClipRect(byval renderer as SDL_Renderer ptr, byval rect as const SDL_Rect ptr) as long
declare sub SDL_RenderGetClipRect(byval renderer as SDL_Renderer ptr, byval rect as SDL_Rect ptr)
declare function SDL_RenderIsClipEnabled(byval renderer as SDL_Renderer ptr) as SDL_bool
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
declare function SDL_RenderDrawPointF(byval renderer as SDL_Renderer ptr, byval x as single, byval y as single) as long
declare function SDL_RenderDrawPointsF(byval renderer as SDL_Renderer ptr, byval points as const SDL_FPoint ptr, byval count as long) as long
declare function SDL_RenderDrawLineF(byval renderer as SDL_Renderer ptr, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single) as long
declare function SDL_RenderDrawLinesF(byval renderer as SDL_Renderer ptr, byval points as const SDL_FPoint ptr, byval count as long) as long
declare function SDL_RenderDrawRectF(byval renderer as SDL_Renderer ptr, byval rect as const SDL_FRect ptr) as long
declare function SDL_RenderDrawRectsF(byval renderer as SDL_Renderer ptr, byval rects as const SDL_FRect ptr, byval count as long) as long
declare function SDL_RenderFillRectF(byval renderer as SDL_Renderer ptr, byval rect as const SDL_FRect ptr) as long
declare function SDL_RenderFillRectsF(byval renderer as SDL_Renderer ptr, byval rects as const SDL_FRect ptr, byval count as long) as long
declare function SDL_RenderCopyF(byval renderer as SDL_Renderer ptr, byval texture as SDL_Texture ptr, byval srcrect as const SDL_Rect ptr, byval dstrect as const SDL_FRect ptr) as long
declare function SDL_RenderCopyExF(byval renderer as SDL_Renderer ptr, byval texture as SDL_Texture ptr, byval srcrect as const SDL_Rect ptr, byval dstrect as const SDL_FRect ptr, byval angle as const double, byval center as const SDL_FPoint ptr, byval flip as const SDL_RendererFlip) as long
declare function SDL_RenderReadPixels(byval renderer as SDL_Renderer ptr, byval rect as const SDL_Rect ptr, byval format as Uint32, byval pixels as any ptr, byval pitch as long) as long
declare sub SDL_RenderPresent(byval renderer as SDL_Renderer ptr)
declare sub SDL_DestroyTexture(byval texture as SDL_Texture ptr)
declare sub SDL_DestroyRenderer(byval renderer as SDL_Renderer ptr)
declare function SDL_RenderFlush(byval renderer as SDL_Renderer ptr) as long
declare function SDL_GL_BindTexture(byval texture as SDL_Texture ptr, byval texw as single ptr, byval texh as single ptr) as long
declare function SDL_GL_UnbindTexture(byval texture as SDL_Texture ptr) as long
declare function SDL_RenderGetMetalLayer(byval renderer as SDL_Renderer ptr) as any ptr
declare function SDL_RenderGetMetalCommandEncoder(byval renderer as SDL_Renderer ptr) as any ptr

#define SDL_shape_h_
const SDL_NONSHAPEABLE_WINDOW = -1
const SDL_INVALID_SHAPE_ARGUMENT = -2
const SDL_WINDOW_LACKS_SHAPE = -3
declare function SDL_CreateShapedWindow(byval title as const zstring ptr, byval x as ulong, byval y as ulong, byval w as ulong, byval h as ulong, byval flags as Uint32) as SDL_Window ptr
declare function SDL_IsShapedWindow(byval window as const SDL_Window ptr) as SDL_bool

type WindowShapeMode as long
enum
	ShapeModeDefault
	ShapeModeBinarizeAlpha
	ShapeModeReverseBinarizeAlpha
	ShapeModeColorKey
end enum

#define SDL_SHAPEMODEALPHA(mode) (((mode = ShapeModeDefault) orelse (mode = ShapeModeBinarizeAlpha)) orelse (mode = ShapeModeReverseBinarizeAlpha))

union SDL_WindowShapeParams
	binarizationCutoff as Uint8
	colorKey as SDL_Color
end union

type SDL_WindowShapeMode
	mode as WindowShapeMode
	parameters as SDL_WindowShapeParams
end type

declare function SDL_SetWindowShape(byval window as SDL_Window ptr, byval shape as SDL_Surface ptr, byval shape_mode as SDL_WindowShapeMode ptr) as long
declare function SDL_GetShapedWindowMode(byval window as SDL_Window ptr, byval shape_mode as SDL_WindowShapeMode ptr) as long
#define SDL_system_h_

#ifdef __FB_LINUX__
	declare function SDL_LinuxSetThreadPriority(byval threadID as Sint64, byval priority as long) as long
#elseif defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	type SDL_WindowsMessageHook as sub(byval userdata as any ptr, byval hWnd as any ptr, byval message as ulong, byval wParam as Uint64, byval lParam as Sint64)
	declare sub SDL_SetWindowsMessageHook(byval callback as SDL_WindowsMessageHook, byval userdata as any ptr)
	declare function SDL_Direct3D9GetAdapterIndex(byval displayIndex as long) as long
	declare function SDL_RenderGetD3D9Device(byval renderer as SDL_Renderer ptr) as IDirect3DDevice9 ptr
	declare function SDL_DXGIGetOutputInfo(byval displayIndex as long, byval adapterIndex as long ptr, byval outputIndex as long ptr) as SDL_bool
#endif

declare function SDL_IsTablet() as SDL_bool
declare sub SDL_OnApplicationWillTerminate()
declare sub SDL_OnApplicationDidReceiveMemoryWarning()
declare sub SDL_OnApplicationWillResignActive()
declare sub SDL_OnApplicationDidEnterBackground()
declare sub SDL_OnApplicationWillEnterForeground()
declare sub SDL_OnApplicationDidBecomeActive()
#define SDL_timer_h_
declare function SDL_GetTicks() as Uint32
#define SDL_TICKS_PASSED(A, B) (cast(Sint32, (B) - (A)) <= 0)
declare function SDL_GetPerformanceCounter() as Uint64
declare function SDL_GetPerformanceFrequency() as Uint64
declare sub SDL_Delay(byval ms as Uint32)
type SDL_TimerCallback as function(byval interval as Uint32, byval param as any ptr) as Uint32
type SDL_TimerID as long
declare function SDL_AddTimer(byval interval as Uint32, byval callback as SDL_TimerCallback, byval param as any ptr) as SDL_TimerID
declare function SDL_RemoveTimer(byval id as SDL_TimerID) as SDL_bool
#define SDL_version_h_

type SDL_version
	major as Uint8
	minor as Uint8
	patch as Uint8
end type

const SDL_MAJOR_VERSION = 2
const SDL_MINOR_VERSION = 0
const SDL_PATCHLEVEL = 14
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
#define _SDL_locale_h

type SDL_Locale
	language as const zstring ptr
	country as const zstring ptr
end type

declare function SDL_GetPreferredLocales() as SDL_Locale ptr
#define SDL_misc_h_
declare function SDL_OpenURL(byval url as const zstring ptr) as long
const SDL_INIT_TIMER = &h00000001u
const SDL_INIT_AUDIO = &h00000010u
const SDL_INIT_VIDEO = &h00000020u
const SDL_INIT_JOYSTICK = &h00000200u
const SDL_INIT_HAPTIC = &h00001000u
const SDL_INIT_GAMECONTROLLER = &h00002000u
const SDL_INIT_EVENTS = &h00004000u
const SDL_INIT_SENSOR = &h00008000u
const SDL_INIT_NOPARACHUTE = &h00100000u
const SDL_INIT_EVERYTHING = culng(culng(culng(culng(culng(culng(culng(SDL_INIT_TIMER or SDL_INIT_AUDIO) or SDL_INIT_VIDEO) or SDL_INIT_EVENTS) or SDL_INIT_JOYSTICK) or SDL_INIT_HAPTIC) or SDL_INIT_GAMECONTROLLER) or SDL_INIT_SENSOR)

declare function SDL_Init(byval flags as Uint32) as long
declare function SDL_InitSubSystem(byval flags as Uint32) as long
declare sub SDL_QuitSubSystem(byval flags as Uint32)
declare function SDL_WasInit(byval flags as Uint32) as Uint32
declare sub SDL_Quit()

end extern
