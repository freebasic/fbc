#include "fb.h"

FBCALL int fb_Exec( FBSTRING *program, FBSTRING *args )
{
    return fb_ExecEx( program, args, TRUE );
}
