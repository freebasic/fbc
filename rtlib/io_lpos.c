/* Returns the printers X position */

#include "fb.h"

/*:::::*/
FBCALL int fb_LPos( int printer_index )
{
    int cur;
    char buffer[32];
	
    FB_LOCK();

    sprintf(buffer, "LPT%d:", (printer_index+1));
    cur = fb_DevPrinterGetOffset( buffer );

	FB_UNLOCK();
	
    return cur;
}
