''
''
'' fcgi_stdio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __fcgi_stdio_bi__
#define __fcgi_stdio_bi__

#define _FCGI_STDIO 1

#include once "crt.bi"
#include once "fastcgi/fcgiapp.bi"

type FCGI_FILE
	stdio_stream as FILE ptr
	fcgx_stream as FCGX_Stream ptr
end type

extern "c"
declare function FCGI_Accept () as integer
declare sub FCGI_Finish ()
declare function FCGI_StartFilterData () as integer
declare sub FCGI_SetExitStatus (byval status as integer)
declare sub FCGI_perror (byval str as zstring ptr)
declare function FCGI_fopen (byval path as zstring ptr, byval mode as zstring ptr) as FCGI_FILE ptr
declare function FCGI_fclose (byval fp as FCGI_FILE ptr) as integer
declare function FCGI_fflush (byval fp as FCGI_FILE ptr) as integer
declare function FCGI_freopen (byval path as zstring ptr, byval mode as zstring ptr, byval fp as FCGI_FILE ptr) as FCGI_FILE ptr
declare function FCGI_setvbuf (byval fp as FCGI_FILE ptr, byval buf as zstring ptr, byval bufmode as integer, byval size as integer) as integer
declare sub FCGI_setbuf (byval fp as FCGI_FILE ptr, byval buf as zstring ptr)
declare function FCGI_fseek (byval fp as FCGI_FILE ptr, byval offset as integer, byval whence as integer) as integer
declare function FCGI_ftell (byval fp as FCGI_FILE ptr) as integer
declare sub FCGI_rewind (byval fp as FCGI_FILE ptr)
declare function FCGI_fgetc (byval fp as FCGI_FILE ptr) as integer
declare function FCGI_getchar () as integer
declare function FCGI_ungetc (byval c as integer, byval fp as FCGI_FILE ptr) as integer
declare function FCGI_fgets (byval str as zstring ptr, byval size as integer, byval fp as FCGI_FILE ptr) as zstring ptr
declare function FCGI_gets (byval str as zstring ptr) as zstring ptr
declare function FCGI_fputc (byval c as integer, byval fp as FCGI_FILE ptr) as integer
declare function FCGI_putchar (byval c as integer) as integer
declare function FCGI_fputs (byval str as zstring ptr, byval fp as FCGI_FILE ptr) as integer
declare function FCGI_puts (byval str as zstring ptr) as integer
declare function FCGI_fprintf (byval fp as FCGI_FILE ptr, byval format as zstring ptr, ...) as integer
declare function FCGI_printf (byval format as zstring ptr, ...) as integer
''''''' declare function FCGI_vfprintf (byval fp as FCGI_FILE ptr, byval format as zstring ptr, byval ap as va_list) as integer
''''''' declare function FCGI_vprintf (byval format as zstring ptr, byval ap as va_list) as integer
declare function FCGI_fread (byval ptr as any ptr, byval size as integer, byval nmemb as integer, byval fp as FCGI_FILE ptr) as integer
declare function FCGI_fwrite (byval ptr as any ptr, byval size as integer, byval nmemb as integer, byval fp as FCGI_FILE ptr) as integer
declare function FCGI_feof (byval fp as FCGI_FILE ptr) as integer
declare function FCGI_ferror (byval fp as FCGI_FILE ptr) as integer
declare sub FCGI_clearerr (byval fp as FCGI_FILE ptr)
declare function FCGI_tmpfile () as FCGI_FILE ptr
declare function FCGI_fileno (byval fp as FCGI_FILE ptr) as integer
declare function FCGI_fdopen (byval fd as integer, byval mode as zstring ptr) as FCGI_FILE ptr
declare function FCGI_popen (byval cmd as zstring ptr, byval type as zstring ptr) as FCGI_FILE ptr
declare function FCGI_pclose (byval as FCGI_FILE ptr) as integer
end extern

#ifndef NO_FCGI_DEFINES

''
'' Replace standard types, variables, and functions with FastCGI wrappers.
'' Use undef in case a macro is already defined.
''

#undef  FILE
#define	FILE     FCGI_FILE

#undef  stdin
#define	stdin    FCGI_stdin
#undef  stdout
#define	stdout   FCGI_stdout
#undef  stderr
#define	stderr   FCGI_stderr

#undef  perror
#define	perror   FCGI_perror

#undef  fopen
#define	fopen    FCGI_fopen
#undef  fclose
#define	fclose   FCGI_fclose
#undef  fflush
#define	fflush   FCGI_fflush
#undef  freopen
#define	freopen  FCGI_freopen

#undef  setvbuf
#define	setvbuf  FCGI_setvbuf
#undef  setbuf
#define	setbuf   FCGI_setbuf

#undef  fseek
#define fseek    FCGI_fseek
#undef  ftell
#define ftell    FCGI_ftell
#undef  rewind
#define rewind   FCGI_rewind
#undef  fgetpos
#define fgetpos  FCGI_fgetpos
#undef  fsetpos
#define fsetpos  FCGI_fsetpos

#undef  fgetc
#define	fgetc    FCGI_fgetc
#undef  getc
#define getc     FCGI_fgetc
#undef  getchar
#define	getchar  FCGI_getchar
#undef  ungetc
#define ungetc   FCGI_ungetc

#undef  fgets
#define fgets    FCGI_fgets
#undef  gets
#define	gets     FCGI_gets

#undef  fputc
#define fputc    FCGI_fputc
#undef  putc
#define putc     FCGI_fputc
#undef  putchar
#define	putchar  FCGI_putchar

#undef  fputs
#define	fputs    FCGI_fputs
#undef  puts
#define	puts     FCGI_puts

#undef  fprintf
#define	fprintf  FCGI_fprintf
#undef  printf
#define	printf   FCGI_printf

#undef  vfprintf
#define vfprintf FCGI_vfprintf
#undef  vprintf
#define vprintf  FCGI_vprintf

#undef  fread
#define	fread    FCGI_fread
#undef  fwrite
#define fwrite   FCGI_fwrite

#undef  feof
#define	feof     FCGI_feof
#undef  ferror
#define ferror   FCGI_ferror
#undef  clearerr
#define	clearerr FCGI_clearerr

#undef  tmpfile
#define tmpfile  FCGI_tmpfile

#undef  fileno
#define fileno   FCGI_fileno
#undef  fdopen
#define fdopen   FCGI_fdopen
#undef  popen
#define popen    FCGI_popen
#undef  pclose
#define	pclose   FCGI_pclose

#endif '' NO_FCGI_DEFINES

#endif
