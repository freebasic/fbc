'' FreeBASIC binding for fcgi-2.4.1-SNAP-0910052249
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
''   Copyright © 2021 FreeBASIC development team

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
	type FILE as FCGI_FILE
	#undef stdin
	#define stdin FCGI_stdin_
	#undef stdout
	#define stdout FCGI_stdout_
	#undef stderr
	#define stderr FCGI_stderr_
	#undef perror
	declare sub perror alias "FCGI_perror"(byval str as const zstring ptr)
	#undef fopen
	declare function fopen alias "FCGI_fopen"(byval path as const zstring ptr, byval mode as const zstring ptr) as FCGI_FILE ptr
	#undef fclose
	declare function fclose alias "FCGI_fclose"(byval fp as FCGI_FILE ptr) as long
	#undef fflush
	declare function fflush alias "FCGI_fflush"(byval fp as FCGI_FILE ptr) as long
	#undef freopen
	declare function freopen alias "FCGI_freopen"(byval path as const zstring ptr, byval mode as const zstring ptr, byval fp as FCGI_FILE ptr) as FCGI_FILE ptr
	#undef setvbuf
	declare function setvbuf alias "FCGI_setvbuf"(byval fp as FCGI_FILE ptr, byval buf as zstring ptr, byval bufmode as long, byval size as uinteger) as long
	#undef setbuf
	declare sub setbuf alias "FCGI_setbuf"(byval fp as FCGI_FILE ptr, byval buf as zstring ptr)
	#undef fseek
	declare function fseek alias "FCGI_fseek"(byval fp as FCGI_FILE ptr, byval offset as clong, byval whence as long) as long
	#undef ftell
	declare function ftell alias "FCGI_ftell"(byval fp as FCGI_FILE ptr) as long
	#undef rewind
	declare sub rewind alias "FCGI_rewind"(byval fp as FCGI_FILE ptr)
	#undef fgetpos
	#define fgetpos FCGI_fgetpos
	#undef fsetpos
	#define fsetpos FCGI_fsetpos
	#undef fgetc
	declare function fgetc alias "FCGI_fgetc"(byval fp as FCGI_FILE ptr) as long
	#undef getc
	declare function getc alias "FCGI_fgetc"(byval fp as FCGI_FILE ptr) as long
	#undef getchar
	declare function getchar alias "FCGI_getchar"() as long
	#undef ungetc
	declare function ungetc alias "FCGI_ungetc"(byval c as long, byval fp as FCGI_FILE ptr) as long
	#undef fgets
	declare function fgets alias "FCGI_fgets"(byval str as zstring ptr, byval size as long, byval fp as FCGI_FILE ptr) as zstring ptr
	#undef gets
	declare function gets alias "FCGI_gets"(byval str as zstring ptr) as zstring ptr
	#undef fputc
	declare function fputc alias "FCGI_fputc"(byval c as long, byval fp as FCGI_FILE ptr) as long
	#undef putc
	declare function putc alias "FCGI_fputc"(byval c as long, byval fp as FCGI_FILE ptr) as long
	#undef putchar
	declare function putchar alias "FCGI_putchar"(byval c as long) as long
	#undef fputs
	declare function fputs alias "FCGI_fputs"(byval str as const zstring ptr, byval fp as FCGI_FILE ptr) as long
	#undef puts
	declare function puts alias "FCGI_puts"(byval str as const zstring ptr) as long
	#undef fprintf
	declare function fprintf alias "FCGI_fprintf"(byval fp as FCGI_FILE ptr, byval format as const zstring ptr, ...) as long
	#undef printf
	declare function printf alias "FCGI_printf"(byval format as const zstring ptr, ...) as long
	#undef vfprintf
	declare function vfprintf alias "FCGI_vfprintf"(byval fp as FCGI_FILE ptr, byval format as const zstring ptr, byval ap as va_list) as long
	#undef vprintf
	declare function vprintf alias "FCGI_vprintf"(byval format as const zstring ptr, byval ap as va_list) as long
	#undef fread
	declare function fread alias "FCGI_fread"(byval ptr as any ptr, byval size as uinteger, byval nmemb as uinteger, byval fp as FCGI_FILE ptr) as uinteger
	#undef fwrite
	declare function fwrite alias "FCGI_fwrite"(byval ptr as any ptr, byval size as uinteger, byval nmemb as uinteger, byval fp as FCGI_FILE ptr) as uinteger
	#undef feof
	declare function feof alias "FCGI_feof"(byval fp as FCGI_FILE ptr) as long
	#undef ferror
	declare function ferror alias "FCGI_ferror"(byval fp as FCGI_FILE ptr) as long
	#undef clearerr
	declare sub clearerr alias "FCGI_clearerr"(byval fp as FCGI_FILE ptr)
	#undef tmpfile
	declare function tmpfile alias "FCGI_tmpfile"() as FCGI_FILE ptr
	#undef fileno
	declare function fileno alias "FCGI_fileno"(byval fp as FCGI_FILE ptr) as long
	#undef fdopen
	declare function fdopen alias "FCGI_fdopen"(byval fd as long, byval mode as const zstring ptr) as FCGI_FILE ptr
	#undef popen
	declare function popen alias "FCGI_popen"(byval cmd as const zstring ptr, byval type as const zstring ptr) as FCGI_FILE ptr
	#undef pclose
	declare function pclose alias "FCGI_pclose"(byval as FCGI_FILE ptr) as long
#endif

end extern
