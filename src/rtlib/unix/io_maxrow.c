#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleGetMaxRow( void )
{
	return __fb_con.inited ? __fb_con.h : 24;
}
