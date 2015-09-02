''
''
'' limits -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_limits_bi__
#define __crt_limits_bi__

#define PATH_MAX (259)
#define CHAR_BIT 8
#define MB_LEN_MAX 2
#define SCHAR_MIN (-128)
#define SCHAR_MAX 127
#define UCHAR_MAX 255
#define CHAR_MIN 0
#define CHAR_MAX 255
#define INT_MAX 2147483647
#define INT_MIN (-2147483647-1)
#define UINT_MAX &hFFFFFFFFu
#define SHRT_MAX 32767
#define SHRT_MIN (-32767-1)
#define USHRT_MAX &hffff
#define LONG_MAX 2147483647L
#define LONG_MIN (-2147483647L-1)
#define ULONG_MAX &hffffffffUL
#define LONG_LONG_MAX 9223372036854775807LL
#define LONG_LONG_MIN (-9223372036854775807LL-1)
#define ULONG_LONG_MAX (2ULL*9223372036854775807LL+1)
#define LLONG_MAX 9223372036854775807LL
#define LLONG_MIN (-9223372036854775807LL-1)
#define ULLONG_MAX (2ULL*9223372036854775807LL+1)

#define FLT_MIN (1.401298e-45f)
#define FLT_MAX (3.4028235e+38f)
#define DBL_MIN	(4.940656458412465e-324)
#define DBL_MAX (1.7976931348623157e+308)

#endif
