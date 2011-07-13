/*
 * file_attr.c -- file open mode and attribs
 *
 * chng: jun/2006 written [DrV]
 *
 */

#include "fb.h"

static int file_mode_map[] = { FB_FILE_ATTR_MODE_BINARY,   /* FB_FILE_MODE_BINARY = 0 */
	                           FB_FILE_ATTR_MODE_RANDOM,   /* FB_FILE_MODE_RANDOM = 1 */
    	                       FB_FILE_ATTR_MODE_INPUT,    /* FB_FILE_MODE_INPUT  = 2 */
    	                       FB_FILE_ATTR_MODE_OUTPUT,   /* FB_FILE_MODE_OUTPUT = 3 */
    	                       FB_FILE_ATTR_MODE_APPEND }; /* FB_FILE_MODE_APPEND = 4 */

FBCALL int fb_FileAttr 
	( 
		int handle, 
		int returntype 
	)
{
	int ret = 0;
	int err = 0;
	FB_FILE *file;
	
	file = FB_FILE_TO_HANDLE( handle );
	
	if ( !file ) 
	{
		ret = 0;
		err = FB_RTERROR_ILLEGALFUNCTIONCALL;
	} 
	else 
	{
		switch ( returntype )
		{
		case FB_FILE_ATTR_MODE:
			ret = file_mode_map[file->mode];
			err = FB_RTERROR_OK;
			break;
			
/* FB_FILE_ATTR_HANDLE only enabled on x86 for now due to return value size issues */
#ifdef HOST_X86


		case FB_FILE_ATTR_HANDLE:

      /* TODO: standardize the DEV_* structs, or provide a device hook function to get OS handle */

			if( file->type == FB_FILE_TYPE_PRINTER )
			{
				if( file->opaque )
				{
#if defined(HOST_WIN32)
					if( *((int*)file->opaque) ) /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					{
					  ret = **((int**)file->opaque); /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					  err = FB_RTERROR_OK;
					}
#else
					ret = *((int*)file->opaque); /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					err = FB_RTERROR_OK;
#endif
				}
			}
			else if( file->type == FB_FILE_TYPE_SERIAL )
			{
				if( file->opaque )
				{
					if( *((int*)file->opaque) ) /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					{
					  ret = **((int**)file->opaque); /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					  err = FB_RTERROR_OK;
					}
				}
			}
			else
			{
				ret = (int)file->opaque; /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
				err = FB_RTERROR_OK;
			}
			break;
#endif
				
		case FB_FILE_ATTR_ENCODING:
			ret = file->encod;
			err = FB_RTERROR_OK;
			break;
				
		default:
			ret = 0;
			err = FB_RTERROR_ILLEGALFUNCTIONCALL; 
			break;
		}
	}
	
	fb_ErrorSetNum( err );
	
	return ret;
	
}
