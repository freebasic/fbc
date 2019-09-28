/* CHAIN function (wide string) */

#include "fb.h"

FBCALL int fb_Chain_W ( FB_WCHAR *program )
{
    return fb_ExecEx_W( program, NULL, TRUE );
}
