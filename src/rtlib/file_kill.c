/* kill function */

#include "fb.h"
#include <errno.h>

/*:::::*/
FBCALL int fb_FileKill( FBSTRING *str )
{
	int res = 0, err = 0;

	if( str->data != NULL )
	{
		res = remove( str->data );
		err = errno;
	}

	/* del if temp */
	fb_hStrDelTemp( str );
	
	if ( res == 0 )
	{
		res = FB_RTERROR_OK;
	}
	else
	{
		switch (err)
		{
		case ENOENT:
			res = FB_RTERROR_FILENOTFOUND;
			break;
		case EACCES:
			res = FB_RTERROR_FILEIO;
			break;
		case EPERM:
			res = FB_RTERROR_NOPRIVILEGES;
			break;
		default:
			res = FB_RTERROR_ILLEGALFUNCTIONCALL;
			break;
		}
	}

	return fb_ErrorSetNum( res );
}
