/* ERASE for dynamic arrays of var-len strings */

#include "fb.h"

FBCALL void fb_ArrayStrErase( FBARRAY *array )
{
	fb_ArrayErase( array, -1 );
}
