'' Based on the android NDK r8e header

#ifndef __crt_android_stdio_bi__
#define __crt_android_stdio_bi__

extern "C"

#ifdef __FB_64BIT__
#define __LP64__
#endif

#define _IOFBF 0
#define _IOLBF 1
#define _IONBF 2
#define BUFSIZ 1024
#define FILENAME_MAX 1024
#define FOPEN_MAX 20
#define P_tmpdir "/tmp/"
#define L_tmpnam 1024
#define TMP_MAX 308915776

type fpos_t as clong

#if defined(__LP64__)
type __sbuf
	_base as ubyte ptr
	_size as size_t
end type
#else     
type __sbuf
	_base as ubyte ptr
	_size as long
end type
#endif

type FILE
	_p as ubyte ptr
	_r as long
	_w as long
#if defined(__LP64__)
	_flags as long
	_file as long
#else     
	_flags as short
	_file as short
#endif
	_bf as __sbuf
	_lbfsize as long
	_cookie as any ptr
	_close as function(byval as any ptr) as long
	_read as function(byval as any ptr, byval as zstring ptr, byval as long) as long
	_seek as function(byval as any ptr, byval as fpos_t, byval as long) as fpos_t
	_write as function(byval as any ptr, byval as const zstring ptr, byval as long) as long
	_ext as __sbuf
	_up as ubyte ptr
	_ur as long
	_ubuf(0 to 2) as ubyte
	_nbuf(0 to 0) as ubyte
	_lb as __sbuf
	_blksize as long
	_offset as fpos_t
end type

extern __sF(0 to 2) as FILE

#define	stdin	(@__sF(0))
#define	stdout	(@__sF(1))
#define	stderr	(@__sF(2))

declare function snprintf (byval s as zstring ptr, byval n as size_t, byval format as zstring ptr, ...) as long
declare function vsnprintf (byval s as zstring ptr, byval n as size_t, byval format as zstring ptr, byval arg as va_list) as long
declare function popen (byval as zstring ptr, byval as zstring ptr) as FILE ptr
declare function pclose (byval as FILE ptr) as long
declare function getw (byval as FILE ptr) as long
declare function putw (byval as long, byval as FILE ptr) as long

end extern

#endif
