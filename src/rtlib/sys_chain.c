/* chain function */

#include "fb.h"

FBCALL int fb_Chain ( FBSTRING *program )
{
    return fb_ExecEx( program, NULL, TRUE );
}
