/* fre function for Windows */

#include "fb.h"

/*:::::*/
FBCALL unsigned int fb_GetMemAvail ( int mode )
{

	MEMORYSTATUS ms;

	ms.dwLength = sizeof( MEMORYSTATUS );
	GlobalMemoryStatus( &ms );

	return ms.dwAvailPhys;

}

