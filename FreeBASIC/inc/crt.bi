''
'' crt (C runtime) prototypes
'' ported by DrV (i_am_drv@yahoo.com)
''

#ifdef FB__WIN32
'$inclib: 'crtdll'
#endif

type tm
	 tm_sec		 as integer			 ' seconds after the minute - [0,59]
	 tm_min		 as integer			 ' minutes after the hour - [0,59]
	 tm_hour	 as integer			 ' hours since midnight - [0,23]
	 tm_mday	 as integer			 ' days of the month - [1,31]
	 tm_mon		 as integer			 ' months since January - [0,11]
	 tm_year	 as integer			 ' years since 1900
	 tm_wday	 as integer			 ' days since Sunday - [0, 6]
	 tm_yday	 as integer			 ' days since January 1 - [0,365]
	 tm_isdst	 as integer			 ' daylight savings time flag
end type

declare sub		 	abort		CDECL alias "abort"			 	  ( )

' abs() already declared

' acos () already declared

' asctime() returns a string

' asin() already declared

declare function 	atan 		CDECL alias "atan"				( byval x as double) as double

' atan2() already declared

declare sub         atexit      CDECL alias "atexit"            ( )

declare function    atof        CDECL alias "atof"              ( byval s as string ) as double

declare function    atoi        CDECL alias "atoi"              ( byval s as string ) as integer

declare function    atol        CDECL alias "atol"              ( byval s as string ) as long

declare function 	beginthread	CDECL alias "_beginthread"	 	( byval start_address as integer, _
																			  byval stack_size as uinteger, _
																			  arglist as any ) as long

declare function    bsearch     CDECL alias "bsearch"           ( byval key as any ptr, _
                                                                              byval base_ptr as any ptr, _
                                                                              byval num as integer, _
                                                                              byval size as integer, _
                                                                              byval compare_proc as function ) as any ptr

declare function    calloc      CDECL alias "calloc"            ( byval num as integer, _
                                                                              byval size as integer ) as any ptr

declare function    ceil        CDECL alias "ceil"              ( byval x as double) as double

' clearerr() uses a FILE*

declare function 	clock 		CDECL alias "clock" 		 	( ) as integer

declare function    cosh        CDECL alias "cosh"              ( x as double ) as double

' ctime() returns a string

declare function    difftime    CDECL alias "difftime"          ( byref timer1 as long, _
                                                                              byref timer0 as long ) as double

' div() is mostly useless and returns a structure

declare sub			endthread	CDECL alias "_endthread"	 	( )

declare sub         exit_crt    CDECL alias "exit"              ( byval status as integer )

' exp() already defined

declare function    fabs        CDECL alias "fabs"              ( byval x as double ) as double

' f*() file rouitines use FILE*

declare function    floor       CDECL alias "floor"             ( byval x as double ) as double

declare function    fmod        CDECL alias "fmod"              ( byval x as double, _
                                                                              byval y as double ) as double
                                                                              
declare function    frexp       CDECL alias "frexp"             ( byval x as double, _
                                                                              byval expptr as integer ptr ) as double

declare sub         free        CDECL alias "free"              ( byval memblock as any ptr )

' getc() uses a FILE *

declare function    getchar     CDECL alias "getchar"           ( ) as integer

' getenv() returns a string

' note: gets usually returns its argument (char*), but this is useless in freeBASIC
declare function    gets        CDECL alias "gets"              ( byval buffer as string ) as integer

declare function    gmtime      CDECL alias "gmtime"            ( byval timer as long ptr ) as tm ptr

' is_wctype() uses wide characters

declare function    isalnum     CDECL alias "isalnum"           ( byval c as integer ) as integer

declare function    isalpha     CDECL alias "isalpha"           ( byval c as integer ) as integer

declare function    iscntrl     CDECL alias "iscntrl"           ( byval c as integer ) as integer

declare function    isdigit     CDECL alias "isdigit"           ( byval c as integer ) as integer

declare function    isgraph     CDECL alias "isgraph"           ( byval c as integer ) as integer

declare function    isleadbyte  CDECL alias "isleadbyte"        ( byval c as integer ) as integer

declare function    islower     CDECL alias "islower"           ( byval c as integer ) as integer

declare function    isprint     CDECL alias "isprint"           ( byval c as integer ) as integer

declare function    ispunct     CDECL alias "ispunct"           ( byval c as integer ) as integer

declare function    isspace     CDECL alias "isspace"           ( byval c as integer ) as integer

declare function    isupper     CDECL alias "isupper"           ( byval c as integer ) as integer

' isw*() use wide characters

declare function    isxdigit    CDECL alias "isxdigit"          ( byval c as integer ) as integer

declare function    labs        CDECL alias "labsl"             ( byval n as long ) as long

declare function    ldexp       CDECL alias "ldexp"             ( byval x as double, _
                                                                              byval exp as integer ) as double
                                                                              
' ldiv() returns a structure

' localeconv() returns a pointer to a structure that contains strings

declare function    localtime   CDECL alias "localtime"         ( byval timer as long ptr ) as tm ptr

' log() already defined

declare function    log10       CDECL alias "log10"             ( byval x as double ) as double

' setjmp() is evil

declare function    malloc      CDECL alias "malloc"            ( byval size as integer ) as any ptr

' mb*() use multibyte strings

declare function    memchr      CDECL alias "memchr"            ( byval buf as any ptr, _
                                                                              byval c as integer, _
                                                                              byval count as integer ) as any ptr
                                                                              
declare function    memcmp      CDECL alias "memcmp"            ( byval buf1 as any ptr, _
                                                                              byval buf2 as any ptr, _
                                                                              byval count as integer ) as integer

declare function    memcpy      CDECL alias "memcpy"            ( byval dest as any ptr, _
                                                                              byval src as any ptr, _
                                                                              byval count as integer ) as any ptr
                                                                              
declare function    memmove     CDECL alias "memmove"           ( byval dest as any ptr, _
                                                                              byval src as any ptr, _
                                                                              byval count as integer ) as any ptr

declare function 	memset 		CDECL alias "memset"		 	( buffer as any, _
																			  byval c as integer, _
																			  byval bytes as integer) as integer
																			  
declare function    mktime      CDECL alias "mktime"            ( byval timeptr as tm ptr ) as long

declare function    modf        CDECL alias "modf"              ( byval x as double, _
                                                                              byval intptr as double ptr ) as double
                                                                              
declare sub         perror      CDECL alias "perror"            ( byval s as string )

declare function    pow         CDECL alias "pow"               ( byval x as double, _
                                                                              byval y as double ) as double

' printf() is useless without C-style optional arguments

' putc() uses a FILE*

declare function    putchar     CDECL alias "putchar"           ( byval c as integer ) as integer

declare function    puts        CDECL alias "puts"              ( byval s as string ) as integer

declare sub         qsort       CDECL alias "qsort"             ( byval baseptr as any ptr, _
                                                                              byval num As integer, _
                                                                              byval size as integer, _
                                                                              byval compare_func as function )
                                                                              
declare function    raise       CDECL alias "raise"             ( byval sig as integer ) as integer

declare function    rand        CDECL alias "rand"              ( ) as integer

declare function    realloc     CDECL alias "realloc"           ( byval memblock as any ptr, _
                                                                              byval size as integer ) as any ptr
                                                                              
declare function    remove      CDECL alias "remove"            ( byval path as string ) as integer

' rename() already declared

' rewind() uses a FILE*

' scanf() is useless without C-style optional arguments

' setbuf() uses a FILE*

' note: setlocale usually returns a string (char*), but this is useless in freeBASIC
declare function    setlocale   CDECL alias "setlocale"         ( byval category as integer, _
                                                                              byval locale as string ) as integer

' setvbuf() uses a FILE*

declare sub         signal      CDECL alias "signal"            ( byval sig as integer, _
                                                                              byval func as sub )
                                                                              
' sin() already declared

declare function    sinh        CDECL alias "sinh"              ( byval x as double ) as double

' sprintf() is useless without C-style optional arguments

declare function    sqrt        CDECL alias "sqrt"              ( byval x as double ) as double

declare sub         srand       CDECL alias "srand"             ( byval seed as unsigned integer )

' sscanf() is useless without C-style optional arguments

' strcat() is useless in freeBASIC (use string + operator instead)

' note: strchr() usually returns char*, but this does not have a direct mapping in freeBASIC
declare function    strchr      CDECL alias "strchr"            ( byval s as string, _
                                                                              byval c as integer ) as integer
                                                                              
declare function    strcmp      CDECL alias "strcmp"            ( byval string1 as string, _
                                                                              byval string2 as string ) as integer
                                                                              
declare function    strcoll     CDECL alias "strcoll"           ( byval string1 as string, _
                                                                              byval string2 as string ) as integer
                                                                              
' strcpy() is useless in freeBASIC (use string = operator instead)

declare function    strcspn     CDECL alias "strcspn"           ( byval s as string, _
                                                                              byval strCharSet as string ) as integer
                                                                              
' strerror() returns a string

declare function    strftime    CDECL alias "strftime"          ( byval strDest as string, _
                                                                              byval maxsize as integer, _
                                                                              byval fmt as string, _
                                                                              byval timeptr as tm ptr ) as integer
                                                                              
declare function    strlen      CDECL alias "strlen"            ( byval s as string ) as integer

' strncat() is useless in freeBASIC (use string + operator instead)

declare function    strncmp     CDECL alias "strncmp"           ( byval string1 as string, _
                                                                              byval string2 as string, _
                                                                              byval count as integer ) as integer
                                                                              
' strncpy() is useless in freeBASIC (use string = operator instead)

' note: strpbrk() usually returns a char*, but this does not have a direct mapping in freeBASIC
declare function    strpbrk     CDECL alias "strpbrk"           ( byval s as string, _
                                                                              byval strCharSet as string ) as integer

' note: strrchr() usually returns a char*, but this does not have a direct mapping in freeBASIC
declare function    strrchr     CDECL alias "strrchr"           ( byval s as string, _
                                                                              byval c as integer ) as integer
                                                                              
declare function    strspn      CDECL alias "strspn"            ( byval s as string, _
                                                                              byval strCharSet as string ) as integer
                                                                              
' note: strstr() usually returns a char*, but this does not have a direct mapping in freeBASIC

declare function    strstr      CDECL alias "strstr"            ( byval s as string, _
                                                                              byval strCharSet as string ) as integer
                                                                              
declare function    strtod      CDECL alias "strtod"            ( byval nptr as string, _
                                                                              byval endptr as integer ptr ) as double
                                                                              
' strtok() is evil

declare function    strtol      CDECL alias "strtol"            ( byval nptr as string, _
                                                                              byval endptr as integer ptr, _
                                                                              byval n_base as integer ) as long
                                                                              
declare function    strtoul     CDECL alias "strtoul"           ( byval nptr as string, _
                                                                              byval endptr as integer ptr, _
                                                                              byval n_base as integer ) as unsigned long
                                                                              
declare function    strxfrm     CDECL alias "strxfrm"           ( byval strDest as string, _
                                                                              byval strSource as string, _
                                                                              byval count as integer ) as integer

' swprintf() uses wide characters and is useless without C-style optional parameters

' swscanf() uses wide characters and is useless without C-style optional parameters

' note: system() is already used for BASIC's 'SYSTEM'; renamed to system_crt
declare function    system_crt  CDECL alias "system"           ( byval cmd as string ) as integer

' tan() already declared

declare function    tanh        CDECL alias "tanh"             ( byval x as double ) as double

' time() already used for BASIC's 'TIME$'; also time() returns a structure

' tmpfile() uses a FILE*

' tmpnam() returns a string

declare function    tolower     CDECL alias "tolower"          ( byval c as integer ) as integer

declare function    toupper     CDECL alias "toupper"          ( byval c as integer ) as integer

' towlower() and towupper() use wide characters

' ungetc() uses a FILE*

' ungetcw() uses a FILE* and wide characters

' vfprintf() uses a FILE*

' vfwprintf() uses a FILE* and wide characters

' vprintf() uses a structure with a string in it

' vsprintf() uses a structure with a string in it

' vswprintf() uses a structure with a wide-character string in it

' vwprintf() uses a structure with a wide-character string in it

' wcs*() wide character strings

