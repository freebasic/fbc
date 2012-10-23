/* ERASE for dynamic arrays of var-len strings */

#include "fb.h"

FBCALL void fb_ArrayEraseStr( FBARRAY *array )
{
	fb_ArrayDestructStr( array );
	fb_ArrayErase( array );
}
