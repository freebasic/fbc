/*
 * data.c -- RESTORE stmt
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"


FB_DATADESC *__fb_data_ptr = NULL;


/*:::::*/
FBCALL void fb_DataRestore( FB_DATADESC *labeladdr )
{
	FB_LOCK();

	__fb_data_ptr = labeladdr;

	FB_UNLOCK();
}
