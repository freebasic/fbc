#ifndef __FB_AMIGA_H__
#define __FB_AMIGA_H__

/* AmigaOS/AROS/MorphOS platform definitions for the FreeBASIC runtime library */

#include <sys/types.h>
#include <stdlib.h>
#include <string.h>

#define FBCALL

#define FB_NEWLINE "\n"
#define FB_NEWLINE_WSTR _LC("\n")
#define FB_BINARY_NEWLINE "\r\n"
#define FB_BINARY_NEWLINE_WSTR _LC("\r\n")

#define FB_LL_FMTMOD "ll"
#define FB_HOST_PATHDIV "/"
#define FB_CONSOLE_MAXPAGES 1

/* File offset type */
#if defined(HOST_AROS) && defined(HOST_64BIT)
typedef long long fb_off_t;
#else
typedef long fb_off_t;
#endif

/* No background thread locking (no MT support) */
#define BG_LOCK()
#define BG_UNLOCK()

#endif
