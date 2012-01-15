''
''
'' gtypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtypes_bi__
#define __gtypes_bi__

#include once "config.bi"

type gchar as byte
type gshort as short
type glong as integer
type gint as integer
type gboolean as gint
type guchar as ubyte
type gushort as ushort
type gulong as uinteger
type guint as uinteger
type gfloat as single
type gdouble as double

#define G_MININT64 ((&h8000000000000000LL))
#define G_MAXINT64 ((&h7fffffffffffffffLL))
#define G_MAXUINT64 ((&hffffffffffffffffULL))

type gpointer as any ptr
type gconstpointer as any ptr
type GCompareFunc as function cdecl(byval as gconstpointer, byval as gconstpointer) as gint
type GCompareDataFunc as function cdecl(byval as gconstpointer, byval as gconstpointer, byval as gpointer) as gint
type GEqualFunc as function cdecl(byval as gconstpointer, byval as gconstpointer) as gboolean
type GDestroyNotify as sub cdecl(byval as gpointer)
type GFunc as sub cdecl(byval as gpointer, byval as gpointer)
type GHashFunc as function cdecl(byval as gconstpointer) as guint
type GHFunc as sub cdecl(byval as gpointer, byval as gpointer, byval as gpointer)
type GFreeFunc as sub cdecl(byval as gpointer)
type GTranslateFunc as function cdecl(byval as zstring ptr, byval as gpointer) as gchar

#define G_E 2.7182818284590452353602874713526624977572470937000
#define G_LN2 0.69314718055994530941723212145817656807550013436026
#define G_LN10 2.3025850929940456840179914546843642076011014886288
#define G_PI 3.1415926535897932384626433832795028841971693993751
#define G_PI_2 1.5707963267948966192313216916397514420985846996876
#define G_PI_4 0.78539816339744830961566084581987572104929234984378
#define G_SQRT2 1.4142135623730950488016887242096980785696718753769
#define G_LITTLE_ENDIAN 1234
#define G_BIG_ENDIAN 4321
#define G_PDP_ENDIAN 3412

type GDoubleIEEE754 as _GDoubleIEEE754
type GFloatIEEE754 as _GFloatIEEE754

#define G_IEEE754_FLOAT_BIAS (127)
#define G_IEEE754_DOUBLE_BIAS (1023)
#define G_LOG_2_BASE_10 (0.30102999566398119521)

type _GFloatIEEE754_mpn
	mantissa:23 as guint
	biased_exponent:8 as guint
	sign:1 as guint
end type

union _GFloatIEEE754
	v_float as gfloat
	mpn as _GFloatIEEE754_mpn
end union

type _GDoubleIEEE754_mpn
	mantissa_low as guint
	mantissa_high:20 as guint
	biased_exponent:11 as guint
	sign:1 as guint
end type

union _GDoubleIEEE754
	v_double as gdouble
	mpn as _GDoubleIEEE754_mpn
end union


type GTimeVal as _GTimeVal

type _GTimeVal
	tv_sec as glong
	tv_usec as glong
end type

#endif
