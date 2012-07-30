/* console input helpers */

#include "../fb.h"
#include "fb_private_console.h"
#include <sys/farptr.h>
#include <go32.h>

static int iCircBufferStatusInited = FALSE;
static unsigned short usCircBufferStatus = 0;

int fb_hConsoleInputBufferChanged( void )
{
    int is_changed;
    unsigned short usNewStatus;

    FB_LOCK();

    /* This is required to ensure that SLEEP still works even when
     * the input buffer is full (QB quirk) */
    fb_ConsoleMultikeyInit( );

    if( !iCircBufferStatusInited ) {
        iCircBufferStatusInited = TRUE;
        usCircBufferStatus = _farpeekw( _dos_ds, 0x41C );
    }

    usNewStatus = _farpeekw( _dos_ds, 0x41C );
    is_changed = usNewStatus!=usCircBufferStatus;
    if( is_changed )
        usCircBufferStatus = usNewStatus;

    /* Ensure that no IRQ disturbs us ... */
    fb_dos_cli();
    is_changed |= __fb_con.forceInpBufferChanged;
    __fb_con.forceInpBufferChanged = FALSE;
    fb_dos_sti();

    FB_UNLOCK();

    return is_changed;
}
