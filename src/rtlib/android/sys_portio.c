/* ports I/O functions */

#include "../fb.h"

int fb_hIn( unsigned short port )
{
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_hOut( unsigned short port, unsigned char value )
{
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}
