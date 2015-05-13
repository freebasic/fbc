#ifndef __crt_stdint_bi__
#define __crt_stdint_bi__

#ifndef int8_t
type int8_t as byte
type int16_t as short
type int32_t as long
type int64_t as longint
#endif

type uint8_t as ubyte
type uint16_t as ushort
#ifndef uint32_t
type uint32_t as ulong
#endif
type uint64_t as ulongint

type int_least8_t as int8_t
type int_least16_t as int16_t
type int_least32_t as int32_t
type int_least64_t as int64_t

type uint_least8_t as uint8_t
type uint_least16_t as uint16_t
type uint_least32_t as uint32_t
type uint_least64_t as uint64_t

type int_fast8_t as int8_t
type int_fast16_t as int16_t
type int_fast32_t as int32_t
type int_fast64_t as int64_t

type uint_fast8_t as uint8_t
type uint_fast16_t as uint16_t
type uint_fast32_t as uint32_t
type uint_fast64_t as uint64_t

#ifndef intptr_t
type intptr_t as integer
#endif
type uintptr_t as uinteger

type intmax_t as int64_t
type uintmax_t as uint64_t

#define __INT64_C(c) c##LL
#define __UINT64_C(c) c##ULL

#define INT8_MIN (-128)
#define INT16_MIN (-32767-1)
#define INT32_MIN (-2147483647-1)
#define INT64_MIN (-__INT64_C(9223372036854775807)-1)

#define INT8_MAX (127)
#define INT16_MAX (32767)
#define INT32_MAX (2147483647)
#define INT64_MAX (__INT64_C(9223372036854775807))

#define UINT8_MAX (255)
#define UINT16_MAX (65535)
#define UINT32_MAX (4294967295U)
#define UINT64_MAX (__UINT64_C(18446744073709551615))

#define INT_LEAST8_MIN INT8_MIN
#define INT_LEAST16_MIN INT16_MIN
#define INT_LEAST32_MIN INT32_MIN
#define INT_LEAST64_MIN INT64_MIN

#define INT_LEAST8_MAX INT8_MAX
#define INT_LEAST16_MAX INT16_MAX
#define INT_LEAST32_MAX INT32_MAX
#define INT_LEAST64_MAX INT64_MAX

#define UINT_LEAST8_MAX UINT8_MAX
#define UINT_LEAST16_MAX UINT16_MAX
#define UINT_LEAST32_MAX UINT32_MAX
#define UINT_LEAST64_MAX UINT64_MAX

#define INT_FAST8_MIN INT8_MIN
#define INT_FAST16_MIN INT16_MIN
#define INT_FAST32_MIN INT32_MIN
#define INT_FAST64_MIN INT64_MIN

#define INT_FAST8_MAX INT8_MAX
#define INT_FAST16_MAX INT16_MAX
#define INT_FAST32_MAX INT32_MAX
#define INT_FAST64_MAX INT64_MAX

#define UINT_FAST8_MAX UINT8_MAX
#define UINT_FAST16_MAX UINT16_MAX
#define UINT_FAST32_MAX UINT32_MAX
#define UINT_FAST64_MAX UINT64_MAX

#ifdef __FB_64BIT__
	#define INTPTR_MIN INT64_MIN
	#define INTPTR_MAX INT64_MAX
	#define UINTPTR_MAX UINT64_MAX
#else
	#define INTPTR_MIN INT32_MIN
	#define INTPTR_MAX INT32_MAX
	#define UINTPTR_MAX UINT32_MAX
#endif

#define INTMAX_MIN INT64_MIN
#define INTMAX_MAX INT64_MAX
#define UINTMAX_MAX UINT64_MAX

#ifdef __FB_64BIT__
	#define PTRDIFF_MIN INT64_MIN
	#define PTRDIFF_MAX INT64_MAX
#else
	#define PTRDIFF_MIN INT32_MIN
	#define PTRDIFF_MAX INT32_MAX
#endif

#define SIG_ATOMIC_MIN INT32_MIN
#define SIG_ATOMIC_MAX INT32_MAX

#ifdef __FB_64BIT__
	#define SIZE_MAX UINT64_MAX
#else
	#define SIZE_MAX UINT32_MAX
#endif

#ifdef __FB_DOS__
	#define WCHAR_MIN (0u)
	#define WCHAR_MAX UINT8_MAX
#elseif defined( __FB_WIN32__ ) or defined( __FB_CYGWIN__ )
	#define WCHAR_MIN (0u)
	#define WCHAR_MAX UINT16_MAX
#else
	#define WCHAR_MIN INT32_MIN
	#define WCHAR_MAX INT32_MAX
#endif
#define WINT_MIN WCHAR_MIN
#define WINT_MAX WCHAR_MAX

#define INT8_C(c) c
#define INT16_C(c) c
#define INT32_C(c) c
#define INT64_C(c) c##LL

#define UINT8_C(c) c##U
#define UINT16_C(c) c##U
#define UINT32_C(c) c##U
#define UINT64_C(c) c##ULL

#define INTMAX_C(c) c##LL
#define UINTMAX_C(c) c##ULL

#endif
