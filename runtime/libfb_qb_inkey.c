/*
 * InkeyQB - QB compatible INKEY
 *
 * chng: oct/2007 written [jeffm]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_InkeyQB( void )
{
	FBSTRING *res = fb_Inkey();
	
	FB_LOCK();
	
	if( res && res->data 
		&& ( FB_STRSIZE(res) == 2 ) 
		&& ( res->data[0] == FB_EXT_CHAR ) )
	{
		res->data[0] = 0;
	}

	FB_UNLOCK();
	
	return res;
}
