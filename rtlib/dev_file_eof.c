/* detects EOF for file device */

#include "fb.h"

int fb_DevFileEof( FB_FILE *handle )
{
    int res;
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL )
	{
		FB_UNLOCK();
		return FB_TRUE;
	}

    res = FB_FALSE;

    switch( handle->mode )
    {
    /* non-text mode? */
    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:
        /* note: handle->putback_size will be checked by fb_FileEofEx() */
        res = ( ftell( fp ) >= handle->size? FB_TRUE : FB_FALSE );
        break;

    /* text-mode (INPUT, OUTPUT or APPEND) */
    default:
    	/* try feof() first, because the EOF char (27) */
    	if( feof( fp ) )
    	{
        	res = FB_TRUE;
    	}
		/* if in input mode, feof() won't return TRUE if file_pos == file_size */
		else if( handle->mode == FB_FILE_MODE_INPUT )
		{
        	int has_size = handle->hooks->pfnTell!=NULL && handle->hooks->pfnSeek!=NULL;
        	/* note: fseek() is unreliable in text-mode, size must be calculated
                 	 re-opening the file in binary mode */
        	if( has_size )
        		if( ftell( fp ) >= handle->size )
            		res = FB_TRUE;
    	}
    }

	FB_UNLOCK();

	return res;
}
