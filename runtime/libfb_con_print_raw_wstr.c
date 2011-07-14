/* print raw data - no interpretation is done */

#include "fb_con.h"

#define FB_CONPRINTRAW fb_ConPrintRawWstr
#define FB_TCHAR FB_WCHAR
#define FB_CON_HOOK_TWRITE Write
#define FB_TCHAR_ADVANCE( iter, count ) \
    iter += count

#include "libfb_con_print_raw_uni.h"
