#ifndef __crt_stdint_bi__
#define __crt_stdint_bi__

#include "crt/wchar.bi"

#ifndef int8_t
type int8_t as byte
type int16_t as short
type int32_t as integer
type int64_t as longint
#endif

type uint8_t as ubyte
type uint16_t as ushort
#ifndef uint32_t
type uint32_t as uinteger
#endif
type uint64_t as ulongint

type int_least8_t as byte
type int_least16_t as short
type int_least32_t as integer
type int_least64_t as longint

type uint_least8_t as ubyte
type uint_least16_t as ushort
type uint_least32_t as uinteger
type uint_least64_t as ulongint

type int_fast8_t as byte
#ifdef __FB_64BIT__
type int_fast16_t as long
type int_fast32_t as long
type int_fast64_t as long
#else
type int_fast16_t as integer
type int_fast32_t as integer
type int_fast64_t as longint
#endif

type uint_fast8_t as ubyte
#ifdef __FB_64BIT__
type uint_fast16_t as ulong
type uint_fast32_t as ulong
type uint_fast64_t as ulong
#else
type uint_fast16_t as uinteger
type uint_fast32_t as uinteger
type uint_fast64_t as ulongint
#endif

#ifdef __FB_64BIT__
	#ifndef intptr_t
	type intptr_t as longint
	#endif
	type uintptr_t as ulongint
#else
	#ifndef intptr_t
	type intptr_t as integer
	#endif
	type uintptr_t as uinteger
#endif

type intmax_t as longint
type uintmax_t as ulongint

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

#define INT_LEAST8_MIN (-128)
#define INT_LEAST16_MIN (-32767-1)
#define INT_LEAST32_MIN (-2147483647-1)
#define INT_LEAST64_MIN (-__INT64_C(9223372036854775807)-1)

#define INT_LEAST8_MAX (127)
#define INT_LEAST16_MAX (32767)
#define INT_LEAST32_MAX (2147483647)
#define INT_LEAST64_MAX (__INT64_C(9223372036854775807))

#define UINT_LEAST8_MAX (255)
#define UINT_LEAST16_MAX (65535)
#define UINT_LEAST32_MAX (4294967295U)
#define UINT_LEAST64_MAX (__UINT64_C(18446744073709551615))

#define INT_FAST8_MIN (-128)
#ifdef __FB_64BIT__
#  define INT_FAST16_MIN (-9223372036854775807L-1)
#  define INT_FAST32_MIN (-9223372036854775807L-1)
#else
#  define INT_FAST16_MIN (-2147483647-1)
#  define INT_FAST32_MIN (-2147483647-1)
#endif
#define INT_FAST64_MIN (-__INT64_C(9223372036854775807)-1)

#define INT_FAST8_MAX (127)
#ifdef __FB_64BIT__
#  define INT_FAST16_MAX (9223372036854775807L)
#  define INT_FAST32_MAX (9223372036854775807L)
#else
#  define INT_FAST16_MAX (2147483647)
#  define INT_FAST32_MAX (2147483647)
#endif
#define INT_FAST64_MAX (__INT64_C(9223372036854775807))

#define UINT_FAST8_MAX (255)
#ifdef __FB_64BIT__
#  define UINT_FAST16_MAX (18446744073709551615UL)
#  define UINT_FAST32_MAX (18446744073709551615UL)
#else
#  define UINT_FAST16_MAX (4294967295U)
#  define UINT_FAST32_MAX (4294967295U)
#endif
#define UINT_FAST64_MAX (__UINT64_C(18446744073709551615))

#ifdef __FB_64BIT__
#  define INTPTR_MIN (-9223372036854775807L-1)
#  define INTPTR_MAX (9223372036854775807L)
#  define UINTPTR_MAX (18446744073709551615UL)
#else
#  define INTPTR_MIN (-2147483647-1)
#  define INTPTR_MAX (2147483647)
#  define UINTPTR_MAX (4294967295U)
#endif

#define INTMAX_MIN (-__INT64_C(9223372036854775807)-1)
#define INTMAX_MAX (__INT64_C(9223372036854775807))
#define UINTMAX_MAX (__UINT64_C(18446744073709551615))

#ifdef __FB_64BIT__
#  define PTRDIFF_MIN (-9223372036854775807L-1)
#  define PTRDIFF_MAX (9223372036854775807L)
#else
#  define PTRDIFF_MIN (-2147483647-1)
#  define PTRDIFF_MAX (2147483647)
#endif

#define SIG_ATOMIC_MIN (-2147483647-1)
#define SIG_ATOMIC_MAX (2147483647)

#ifdef __FB_64BIT__
#  define SIZE_MAX (18446744073709551615UL)
#else
#  define SIZE_MAX (4294967295U)
#endif

#ifndef WCHAR_MIN
#  define WCHAR_MIN __WCHAR_MIN
#  define WCHAR_MAX __WCHAR_MAX
#endif

#define WINT_MIN (0u)
#define WINT_MAX (4294967295u)

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
