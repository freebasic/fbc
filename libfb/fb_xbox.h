/*
 * fb_xbox.h -- common XBOX definitions.
 *
 * chng: jul/2005 written [DrV]
 *
 */

#ifndef __FB_XBOX__
#define __FB_XBOX__

#define FBCALL __stdcall

#include <stdarg.h>
#include <hal/xbox.h>
#include <hal/fileio.h>

/* WinNT constants - !!!FIXME!!! these belong in openxdk headers */

#define Executive 0

#define KernelMode 0
#define UserMode 1

/* end WinNT constants */

#define FB_NEWLINE "\r\n"
#define FB_NEWLINE_WSTR _LC("\r\n")

typedef int FB_DIRCTX; /* dummy to make fb.h happy */

typedef long fb_off_t;

#define FB_THREADID HANDLE

#define FB_DYLIB HANDLE

extern HANDLE __fb_in_handle, __fb_out_handle;

#endif
