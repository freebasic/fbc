#ifndef CRT_BI
#define CRT_BI
''
'' crt (C runtime) prototypes
'' ported by DrV (i_am_drv@yahoo.com)
''

#ifdef FB__WIN32
'$inclib: 'msvcrt'
#endif

' typedefs

type ulong as uinteger

type FILE as any

' constants

#if defined(FB__WIN32)

#	define CLOCKS_PER_SEC  1000
#	define RAND_MAX  32767

#elseif defined(FB__DOS)

#	define CLOCKS_PER_SEC  91
#	define RAND_MAX  2147483647

#elseif defined(FB__LINUX)

#	define CLOCKS_PER_SEC  1000000 ' as per http://www.die.net/doc/linux/man/man3/clock.3.html
#	define RAND_MAX  ??? ' fixme

#else
#	print crt.bi: unsupported platform
#endif

#ifndef NULL
#	define NULL 0
#endif

'' #if defined(FB__X86)
	#define SCHAR_MAX   127
	#define SCHAR_MIN  -128
	#define UCHAR_MAX   255
	#define CHAR_BIT   8
	#define USHRT_MAX   65535
	#define SHRT_MAX   32767
	#define SHRT_MIN  -32768
	#define UINT_MAX   4294967295
	#define ULONG_MAX   4294967295
	#define INT_MAX   2147483647
	#define INT_MIN  -2147483648
	#define LONG_MAX   2147483647
	#define LONG_MIN  -2147483648
	#define CHAR_MAX   127
	#define CHAR_MIN  -128

	#define DBL_DIG   15
	#define DBL_EPSILON   2.2204460492503131e-016
	#define DBL_MANT_DIG   53
	#define DBL_MAX   1.7976931348623158e+308
	#define DBL_MAX_10_EXP   308
	#define DBL_MAX_EXP   1024
	#define DBL_MIN   2.2250738585072014e-308
	#define DBL_MIN_10_EXP  -307
	#define DBL_MIN_EXP  -1021
	#define DBL_RADIX   2
	#define DBL_ROUNDS   1

	#define FLT_DIG   6
	#define FLT_EPSILON   1.192092896e-07
	#define FLT_MANT_DIG   24
	#define FLT_MAX   3.402823466e+38
	#define FLT_MAX_10_EXP   38
	#define FLT_MAX_EXP   128
	#define FLT_MIN   1.175494351e-38
	#define FLT_MIN_10_EXP  -37
	#define FLT_MIN_EXP  -125
	#define FLT_RADIX   2
	#define FLT_ROUNDS   1
'' #endif


type tm
	tm_sec		as integer	' seconds after the minute - [0,59]
	tm_min		as integer	' minutes after the hour - [0,59]
	tm_hour		as integer	' hours since midnight - [0,23]
	tm_mday		as integer	' days of the month - [1,31]
	tm_mon		as integer	' months since January - [0,11]
	tm_year		as integer	' years since 1900
	tm_wday		as integer	' days since Sunday - [0, 6]
	tm_yday		as integer	' days since January 1 - [0,365]
	tm_isdst	as integer	' daylight savings time flag
end type

declare sub abort cdecl alias "abort" ( )

' abs() already declared

' acos () already declared

declare function asctime cdecl alias "asctime" ( byval timeptr as tm ptr ) as byte ptr

' asin() already declared

declare function atan cdecl alias "atan" ( byval x as double) as double

' atan2() already declared

declare sub atexit cdecl alias "atexit" ( )

declare function atof cdecl alias "atof" ( byval s as string ) as double

declare function atoi cdecl alias "atoi" ( byval s as string ) as integer

declare function atol cdecl alias "atol" ( byval s as string ) as long

declare function beginthread cdecl alias "_beginthread" ( byval start_address as integer, byval stack_size as uinteger, arglist as any ) as long

declare function bsearch cdecl alias "bsearch" ( byval key as any ptr, byval base_ptr as any ptr, byval num as integer, byval size as integer, byval compare_proc as function() as integer ) as any ptr

declare function calloc cdecl alias "calloc" ( byval num as integer, byval size as integer ) as any ptr

declare function ceil cdecl alias "ceil" ( byval x as double) as double

' clearerr() uses a FILE*

declare function clock cdecl alias "clock" ( ) as integer

declare function cosh cdecl alias "cosh" ( x as double ) as double

declare function ctime cdecl alias "ctime" ( byval timr as integer ) as byte ptr

declare function difftime cdecl alias "difftime" ( byval timer1 as integer, byval timer0 as integer ) as double

' div() is mostly useless and returns a structure

declare sub endthread cdecl alias "_endthread" ( )

declare sub exit_crt cdecl alias "exit" ( byval status as integer )

' exp() already defined

declare function fabs cdecl alias "fabs" ( byval x as double ) as double

declare function fopen cdecl alias "fopen" (byval fname as string, byval as string) as FILE ptr
declare function freopen cdecl alias "freopen" (byval as string, byval as string, byval as FILE ptr) as FILE ptr
declare function fflush cdecl alias "fflush" (byval as FILE ptr) as integer
declare function fclose cdecl alias "fclose" (byval as FILE ptr) as integer

declare function fgetc cdecl alias "fgetc" (byval as FILE ptr) as integer
declare function fgets cdecl alias "fgets" (byval as string, byval as integer, byval as FILE ptr) as byte ptr
declare function fputc cdecl alias "fputc" (byval as integer, byval as FILE ptr) as integer
declare function fputs cdecl alias "fputs" (byval as string, byval as FILE ptr) as integer

declare function fread cdecl alias "fread" (byval as any ptr, byval as integer, byval as integer, byval as FILE ptr) as integer
declare function fwrite cdecl alias "fwrite" (byval as any ptr, byval as integer, byval as integer, byval as FILE ptr) as integer

declare function fseek cdecl alias "fseek" (byval as FILE ptr, byval as integer, byval as integer) as integer
declare function ftell cdecl alias "ftell" (byval as FILE ptr) as integer
declare sub rewind cdecl alias "rewind" (byval as FILE ptr)


declare function floor cdecl alias "floor" ( byval x as double ) as double

declare function fmod cdecl alias "fmod" ( byval x as double, byval y as double ) as double

declare function frexp cdecl alias "frexp" ( byval x as double, byval expptr as integer ptr ) as double

declare sub free cdecl alias "free" ( byval memblock as any ptr )

' getc() uses a FILE *

declare function getchar cdecl alias "getchar" ( ) as integer

' getenv() returns a string

declare function getenv cdecl alias "getenv" ( byval varname as string ) as byte ptr

declare function gets cdecl alias "gets" ( byval buffer as string ) as byte ptr

declare function gmtime cdecl alias "gmtime" ( byval timer as long ptr ) as tm ptr

' is_wctype() uses wide characters

declare function isalnum cdecl alias "isalnum" ( byval c as integer ) as integer

declare function isalpha cdecl alias "isalpha" ( byval c as integer ) as integer

declare function iscntrl cdecl alias "iscntrl" ( byval c as integer ) as integer

declare function isdigit cdecl alias "isdigit" ( byval c as integer ) as integer

declare function isgraph cdecl alias "isgraph" ( byval c as integer ) as integer

declare function isleadbyte cdecl alias "isleadbyte" ( byval c as integer ) as integer

declare function islower cdecl alias "islower" ( byval c as integer ) as integer

declare function isprint cdecl alias "isprint" ( byval c as integer ) as integer

declare function ispunct cdecl alias "ispunct" ( byval c as integer ) as integer

declare function isspace cdecl alias "isspace" ( byval c as integer ) as integer

declare function isupper cdecl alias "isupper" ( byval c as integer ) as integer

declare function isxdigit cdecl alias "isxdigit" ( byval c as integer ) as integer

declare function labs cdecl alias "labs" ( byval n as long ) as long

declare function ldexp cdecl alias "ldexp" ( byval x as double, byval exp as integer ) as double

' ldiv() returns a structure

' localeconv() returns a pointer to a structure that contains strings

declare function localtime cdecl alias "localtime" ( byval timer as long ptr ) as tm ptr

' log() already defined

declare function log10 cdecl alias "log10" ( byval x as double ) as double

' setjmp() is evil

declare function malloc cdecl alias "malloc" ( byval size as integer ) as any ptr

' mb*() use multibyte strings

declare function memchr cdecl alias "memchr" ( byval buf as any ptr, byval c as integer, byval count as integer ) as any ptr

declare function memcmp cdecl alias "memcmp" ( byval buf1 as any ptr, byval buf2 as any ptr, byval count as integer ) as integer

declare function memcpy cdecl alias "memcpy" ( byval dest as any ptr, byval src as any ptr, byval count as integer ) as any ptr

declare function memmove cdecl alias "memmove" ( byval dest as any ptr, byval src as any ptr, byval count as integer ) as any ptr

declare function memset cdecl alias "memset" ( buffer as any, byval c as integer, byval bytes as integer) as integer

declare function mktime cdecl alias "mktime" ( byval timeptr as tm ptr ) as long

declare function modf cdecl alias "modf" ( byval x as double, byval intptr as double ptr ) as double

declare sub perror cdecl alias "perror" ( byval s as string )

declare function pow cdecl alias "pow" ( byval x as double, byval y as double ) as double

declare function printf cdecl alias "printf" ( byval format as string, ... ) as integer

' putc() uses a FILE*

declare function putchar cdecl alias "putchar" ( byval c as integer ) as integer

declare function puts cdecl alias "puts" ( byval s as string ) as integer

declare sub qsort cdecl alias "qsort" ( byval baseptr as any ptr, byval num As integer, byval size as integer, byval compare_func as function() as integer )

declare function raise cdecl alias "raise" ( byval sig as integer ) as integer

declare function rand cdecl alias "rand" ( ) as integer

declare function realloc cdecl alias "realloc" ( byval memblock as any ptr, byval size as integer ) as any ptr

declare function remove cdecl alias "remove" ( byval path as string ) as integer

' rename() already declared

declare function scanf cdecl alias "scanf" ( byval format as string, ... ) as integer

' setbuf() uses a FILE*

declare function setlocale cdecl alias "setlocale" ( byval category as integer, byval locale as string ) as byte ptr

' setvbuf() uses a FILE*

declare sub signal cdecl alias "signal" ( byval sig as integer, byval func as sub )

' sin() already declared

declare function sinh cdecl alias "sinh" ( byval x as double ) as double

declare function sprintf cdecl alias "sprintf" ( byval buffer as byte ptr, byval format as string, ... ) as integer

declare function sqrt cdecl alias "sqrt" ( byval x as double ) as double

declare sub srand cdecl alias "srand" ( byval seed as unsigned integer )

declare function sscanf cdecl alias "sscanf" ( byval buffer as byte ptr, byval format as string, ... ) as integer

declare function strcat cdecl alias "strcat" ( byval dst as string, byval src as string ) as byte ptr

declare function strchr cdecl alias "strchr" ( byval s as string, byval c as integer ) as byte ptr

declare function strcmp cdecl alias "strcmp" ( byval string1 as string, byval string2 as string ) as integer

declare function strcoll cdecl alias "strcoll" ( byval string1 as string, byval string2 as string ) as integer

declare function strcpy cdecl alias "strcpy" ( byval dst as string, byval src as string ) as byte ptr

declare function strcspn cdecl alias "strcspn" ( byval s as string, byval strCharSet as string ) as integer

declare function strerror cdecl alias "strerror" ( byval errnum as integer ) as byte ptr

declare function strftime cdecl alias "strftime" ( byval strDest as string, byval maxsize as integer, byval fmt as string, byval timeptr as tm ptr ) as integer

declare function strlen cdecl alias "strlen" ( byval s as string ) as integer

declare function strncat cdecl alias "strncat" ( byval dst as string, byval src as string, byval count as integer ) as byte ptr

declare function strncmp cdecl alias "strncmp" ( byval string1 as string, byval string2 as string, byval count as integer ) as integer

declare function strncpy cdecl alias "strncpy" ( byval dst as string, byval src as string, byval count as integer ) as byte ptr

declare function strpbrk cdecl alias "strpbrk" ( byval s as string, byval strCharSet as string ) as byte ptr

declare function strrchr cdecl alias "strrchr" ( byval s as string, byval c as integer ) as byte ptr

declare function strspn cdecl alias "strspn" ( byval s as string, byval strCharSet as string ) as integer

declare function strstr cdecl alias "strstr" ( byval string1 as string, byval string2 as string ) as byte ptr

declare function strtod cdecl alias "strtod" ( byval nptr as string, byval endptr as integer ptr ) as double

' strtok() is evil

declare function strtol cdecl alias "strtol" ( byval nptr as string, byval endptr as integer ptr, byval n_base as integer ) as long

declare function strtoul cdecl alias "strtoul" ( byval nptr as string, byval endptr as integer ptr, byval n_base as integer ) as unsigned long

declare function strxfrm cdecl alias "strxfrm" ( byval strDest as string, byval strSource as string, byval count as integer ) as integer

' note: system() is already used for BASIC's 'SYSTEM'; renamed to system_crt
declare function system_crt cdecl alias "system" ( byval cmd as string ) as integer

' tan() already declared

declare function tanh cdecl alias "tanh" ( byval x as double ) as double

' time() already used for BASIC's 'TIME$'; also time() returns a structure

' tmpfile() uses a FILE*

declare function tmpnam cdecl alias "tmpnam" ( byval strng as string ) as byte ptr

declare function tolower cdecl alias "tolower" ( byval c as integer ) as integer

declare function toupper cdecl alias "toupper" ( byval c as integer ) as integer

' ungetc() uses a FILE*


#endif ' CRT_BI
