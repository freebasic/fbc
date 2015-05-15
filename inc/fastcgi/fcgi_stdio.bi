'' FreeBASIC binding for fcgi-2.4.1-SNAP-0311112127
''
'' based on the C header files:
''   Copyright (c) 1995-1996 Open Market, Inc.
''
''   This FastCGI application library source and object code (the
''   "Software") and its documentation (the "Documentation") are
''   copyrighted by Open Market, Inc ("Open Market").  The following terms
''   apply to all files associated with the Software and Documentation
''   unless explicitly disclaimed in individual files.
''
''   Open Market permits you to use, copy, modify, distribute, and license
''   this Software and the Documentation for any purpose, provided that
''   existing copyright notices are retained in all copies and that this
''   notice is included verbatim in any distributions.  No written
''   agreement, license, or royalty fee is required for any of the
''   authorized uses.  Modifications to this Software and Documentation may
''   be copyrighted by their authors and need not follow the licensing
''   terms described here.  If modifications to this Software and
''   Documentation have new licensing terms, the new terms must be clearly
''   indicated on the first page of each file where they apply.
''
''   OPEN MARKET MAKES NO EXPRESS OR IMPLIED WARRANTY WITH RESPECT TO THE
''   SOFTWARE OR THE DOCUMENTATION, INCLUDING WITHOUT LIMITATION ANY
''   WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  IN
''   NO EVENT SHALL OPEN MARKET BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY
''   DAMAGES ARISING FROM OR RELATING TO THIS SOFTWARE OR THE
''   DOCUMENTATION, INCLUDING, WITHOUT LIMITATION, ANY INDIRECT, SPECIAL OR
''   CONSEQUENTIAL DAMAGES OR SIMILAR DAMAGES, INCLUDING LOST PROFITS OR
''   LOST DATA, EVEN IF OPEN MARKET HAS BEEN ADVISED OF THE POSSIBILITY OF
''   SUCH DAMAGES.  THE SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS".
''   OPEN MARKET HAS NO LIABILITY IN CONTRACT, TORT, NEGLIGENCE OR
''   OTHERWISE ARISING OUT OF THIS SOFTWARE OR THE DOCUMENTATION.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt.bi"
#include once "crt/long.bi"
#include once "fcgiapp.bi"
#include once "crt.bi"

'' The following symbols have been renamed:
''     #define FCGI_stdin => FCGI_stdin_
''     #define FCGI_stdout => FCGI_stdout_
''     #define FCGI_stderr => FCGI_stderr_

extern "C"

const _FCGI_STDIO = 1

type FCGI_FILE
	stdio_stream as FILE ptr
	fcgx_stream as FCGX_Stream ptr
end type

declare function FCGI_Accept() as long
declare sub FCGI_Finish()
declare function FCGI_StartFilterData() as long
declare sub FCGI_SetExitStatus(byval status as long)
#define FCGI_ToFILE(fcgi_file) fcgi_file->stdio_stream
#define FCGI_ToFcgiStream(fcgi_file) fcgi_file->fcgx_stream

#ifdef __FB_WIN32__
	extern import _fcgi_sF(0 to 3 - 1) as FCGI_FILE
#else
	extern _fcgi_sF(0 to 3 - 1) as FCGI_FILE
#endif

#define FCGI_stdin_ (@_fcgi_sF(0))
#define FCGI_stdout_ (@_fcgi_sF(1))
#define FCGI_stderr_ (@_fcgi_sF(2))

declare sub FCGI_perror(byval str as const zstring ptr)
declare function FCGI_fopen(byval path as const zstring ptr, byval mode as const zstring ptr) as FCGI_FILE ptr
declare function FCGI_fclose(byval fp as FCGI_FILE ptr) as long
declare function FCGI_fflush(byval fp as FCGI_FILE ptr) as long
declare function FCGI_freopen(byval path as const zstring ptr, byval mode as const zstring ptr, byval fp as FCGI_FILE ptr) as FCGI_FILE ptr
declare function FCGI_setvbuf(byval fp as FCGI_FILE ptr, byval buf as zstring ptr, byval bufmode as long, byval size as uinteger) as long
declare sub FCGI_setbuf(byval fp as FCGI_FILE ptr, byval buf as zstring ptr)
declare function FCGI_fseek(byval fp as FCGI_FILE ptr, byval offset as clong, byval whence as long) as long
declare function FCGI_ftell(byval fp as FCGI_FILE ptr) as long
declare sub FCGI_rewind(byval fp as FCGI_FILE ptr)
declare function FCGI_fgetc(byval fp as FCGI_FILE ptr) as long
declare function FCGI_getchar() as long
declare function FCGI_ungetc(byval c as long, byval fp as FCGI_FILE ptr) as long
declare function FCGI_fgets(byval str as zstring ptr, byval size as long, byval fp as FCGI_FILE ptr) as zstring ptr
declare function FCGI_gets(byval str as zstring ptr) as zstring ptr
declare function FCGI_fputc(byval c as long, byval fp as FCGI_FILE ptr) as long
declare function FCGI_putchar(byval c as long) as long
declare function FCGI_fputs(byval str as const zstring ptr, byval fp as FCGI_FILE ptr) as long
declare function FCGI_puts(byval str as const zstring ptr) as long
declare function FCGI_fprintf(byval fp as FCGI_FILE ptr, byval format as const zstring ptr, ...) as long
declare function FCGI_printf(byval format as const zstring ptr, ...) as long
declare function FCGI_vfprintf(byval fp as FCGI_FILE ptr, byval format as const zstring ptr, byval ap as va_list) as long
declare function FCGI_vprintf(byval format as const zstring ptr, byval ap as va_list) as long
declare function FCGI_fread(byval ptr as any ptr, byval size as uinteger, byval nmemb as uinteger, byval fp as FCGI_FILE ptr) as uinteger
declare function FCGI_fwrite(byval ptr as any ptr, byval size as uinteger, byval nmemb as uinteger, byval fp as FCGI_FILE ptr) as uinteger
declare function FCGI_feof(byval fp as FCGI_FILE ptr) as long
declare function FCGI_ferror(byval fp as FCGI_FILE ptr) as long
declare sub FCGI_clearerr(byval fp as FCGI_FILE ptr)
declare function FCGI_tmpfile() as FCGI_FILE ptr
declare function FCGI_fileno(byval fp as FCGI_FILE ptr) as long
declare function FCGI_fdopen(byval fd as long, byval mode as const zstring ptr) as FCGI_FILE ptr
declare function FCGI_popen(byval cmd as const zstring ptr, byval type as const zstring ptr) as FCGI_FILE ptr
declare function FCGI_pclose(byval as FCGI_FILE ptr) as long

#ifndef NO_FCGI_DEFINES
	#undef FILE
	#define FILE FCGI_FILE
	#undef stdin
	#define stdin FCGI_stdin_
	#undef stdout
	#define stdout FCGI_stdout_
	#undef stderr
	#define stderr FCGI_stderr_
	#undef perror
	#define perror FCGI_perror
	#undef fopen
	#define fopen FCGI_fopen
	#undef fclose
	#define fclose FCGI_fclose
	#undef fflush
	#define fflush FCGI_fflush
	#undef freopen
	#define freopen FCGI_freopen
	#undef setvbuf
	#define setvbuf FCGI_setvbuf
	#undef setbuf
	#define setbuf FCGI_setbuf
	#undef fseek
	#define fseek FCGI_fseek
	#undef ftell
	#define ftell FCGI_ftell
	#undef rewind
	#define rewind FCGI_rewind
	#undef fgetpos
	#define fgetpos FCGI_fgetpos
	#undef fsetpos
	#define fsetpos FCGI_fsetpos
	#undef fgetc
	#define fgetc FCGI_fgetc
	#undef getc
	#define getc FCGI_fgetc
	#undef getchar
	#define getchar FCGI_getchar
	#undef ungetc
	#define ungetc FCGI_ungetc
	#undef fgets
	#define fgets FCGI_fgets
	#undef gets
	#define gets FCGI_gets
	#undef fputc
	#define fputc FCGI_fputc
	#undef putc
	#define putc FCGI_fputc
	#undef putchar
	#define putchar FCGI_putchar
	#undef fputs
	#define fputs FCGI_fputs
	#undef puts
	#define puts FCGI_puts
	#undef fprintf
	#define fprintf FCGI_fprintf
	#undef printf
	#define printf FCGI_printf
	#undef vfprintf
	#define vfprintf FCGI_vfprintf
	#undef vprintf
	#define vprintf FCGI_vprintf
	#undef fread
	#define fread FCGI_fread
	#undef fwrite
	#define fwrite FCGI_fwrite
	#undef feof
	#define feof FCGI_feof
	#undef ferror
	#define ferror FCGI_ferror
	#undef clearerr
	#define clearerr FCGI_clearerr
	#undef tmpfile
	#define tmpfile FCGI_tmpfile
	#undef fileno
	#define fileno FCGI_fileno
	#undef fdopen
	#define fdopen FCGI_fdopen
	#undef popen
	#define popen FCGI_popen
	#undef pclose
	#define pclose FCGI_pclose
#endif

end extern
