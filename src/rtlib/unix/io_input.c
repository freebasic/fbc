/* console input helpers */

#include "../fb.h"
#include "fb_private_console.h"

int fb_hConsoleInputBufferChanged( void )
{
    /* FIXME: We need to find a method to set a flag whenver a NEW character
     *        was passed to the input buffer. Maybe we can use something
     *        like ftell( stdin ) + some modifications of key input functions?
     *
     * INFO: Don't clear the input buffer in any case because this will
     *       cause more trouble than not clearing the input buffer.
     *
     * mjs, 2005-10-13
     */
	return fb_KeyHit();
}
