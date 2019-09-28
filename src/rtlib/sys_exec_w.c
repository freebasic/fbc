/* EXEC function (wide string) */

#include "fb.h"

FBCALL int fb_Exec_W( FB_WCHAR *program, FB_WCHAR *args )
{
    return fb_ExecEx_W( program, args, TRUE );
}
