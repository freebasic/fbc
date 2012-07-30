/* console pcopy function */

#include "../fb.h"
#include "fb_private_console.h"
#include <go32.h>

int fb_ConsolePageCopy( int src, int dst )
{
	/* use current? */
	if( src < 0 )
		src = __fb_con.active;

	if( dst < 0 )
		dst = __fb_con.visible;

	if( src == dst )
		return fb_ErrorSetNum( FB_RTERROR_OK );

	/* do the copy */
	int cols, rows;
	fb_ConsoleGetSize( &cols, &rows );

	unsigned long srcAddr = fb_hGetPageAddr( src, cols, rows );
	unsigned long dstAddr = fb_hGetPageAddr( dst, cols, rows );

	_movedataw( _dos_ds, srcAddr, _dos_ds, dstAddr, cols * rows );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
