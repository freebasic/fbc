#include "../fb.h"

FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
    if( col != NULL )
        *col = 0;

    if( row != NULL )
        *row = 0;
}
