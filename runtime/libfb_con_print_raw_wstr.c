/*
 * con_print_raw.c -- print raw data - no interpretation is done
 *
 * chng: sep/2005 written [mjs]
 *
 */

#include "fb_con.h"

#define FB_CONPRINTRAW fb_ConPrintRawWstr
#define FB_TCHAR FB_WCHAR
#define FB_CON_HOOK_TWRITE Write
#define FB_TCHAR_ADVANCE( iter, count ) \
    iter += count

#include "libfb_con_print_raw_uni.h"
