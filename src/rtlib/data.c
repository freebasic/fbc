/* DATA core */

#include "fb.h"

FB_DATADESC *__fb_data_ptr = NULL;

static void hSkipLink( void )
{
	/* If a link was reached, move to the next non-link, or NULL ("EOF") */
	while( __fb_data_ptr && (__fb_data_ptr->len == FB_DATATYPE_LINK) ) {
		__fb_data_ptr = __fb_data_ptr->next;
	}

	DBG_ASSERT( (__fb_data_ptr == NULL) ||
	            (__fb_data_ptr->len != FB_DATATYPE_LINK) );
}

FBCALL void fb_DataRestore( FB_DATADESC *labeladdr )
{
	FB_LOCK();

	__fb_data_ptr = labeladdr;
	hSkipLink( );

	FB_UNLOCK();
}

/* Callers are expected to FB_LOCK/FB_UNLOCK */
void fb_DataNext( void )
{
	/* Move forward in current DATA table, if any */
	if( __fb_data_ptr ) {
		DBG_ASSERT( __fb_data_ptr->len != FB_DATATYPE_LINK );
		__fb_data_ptr += 1;
		hSkipLink( );
	}
}
