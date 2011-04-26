/*
 * io_isredir - console redirection check
 *
 * chng: dec/2005 written [v1ctor]
 *
 */

#include "fb_con.h"

/*:::::*/
int fb_ConsoleIsRedirected( int is_input )
{
	DWORD mode;

	if( GetConsoleMode( (is_input? __fb_in_handle : __fb_out_handle), &mode ) == 0 )
		return TRUE;
	else
    	return FALSE;
}
