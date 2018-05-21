/* console input helpers */

#include "../fb.h"
#include "fb_private_console.h"

int fb_hConsoleInputBufferChanged( void )
{
	return fb_KeyHit();
}
