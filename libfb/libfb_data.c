/*
 * data.c -- DATA core
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
short fb_DataGetLen( void )
{
	short len;

	if( __fb_data_ptr == NULL )
		return 0;

	len = __fb_data_ptr->len;

	/* link? */
	while ( len == FB_DATATYPE_LINK )
	{
		__fb_data_ptr = __fb_data_ptr->next;
		if( __fb_data_ptr == NULL )
			return 0;

		len = __fb_data_ptr->len;
	}

	return len;
}

