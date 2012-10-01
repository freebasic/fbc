/* short version of OPEN */

#include "fb.h"

/*:::::*/
FBCALL int fb_FileOpenShort( FBSTRING *str_file_mode,
                             int fnum,
                             FBSTRING *filename,
                             int len,
                             FBSTRING *str_access_mode,
                             FBSTRING *str_lock_mode)
{
    unsigned file_mode = 0;
    int access_mode = -1, lock_mode = -1;
    size_t file_mode_len, access_mode_len, lock_mode_len;
    int error_code = FB_RTERROR_OK;

    if( !FB_FILE_INDEX_VALID( fnum ) )
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    file_mode_len = FB_STRSIZE( str_file_mode );
    access_mode_len = FB_STRSIZE( str_access_mode );
    lock_mode_len = FB_STRSIZE( str_lock_mode );

    if( file_mode_len != 1 || access_mode_len>2 || lock_mode_len>2 ) {
		error_code = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( error_code==FB_RTERROR_OK ) {
        if( strcasecmp(str_file_mode->data, "B")==0 ) {
            file_mode = FB_FILE_MODE_BINARY;
        } else if( strcasecmp(str_file_mode->data, "I")==0 ) {
            file_mode = FB_FILE_MODE_INPUT;
        } else if( strcasecmp(str_file_mode->data, "O")==0 ) {
            file_mode = FB_FILE_MODE_OUTPUT;
        } else if( strcasecmp(str_file_mode->data, "A")==0 ) {
            file_mode = FB_FILE_MODE_APPEND;
        } else if( strcasecmp(str_file_mode->data, "R")==0 ) {
            file_mode = FB_FILE_MODE_RANDOM;
        } else {
            error_code = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    if( access_mode_len!=0 && error_code==FB_RTERROR_OK ) {
        if ( strcasecmp(str_access_mode->data, "R")==0 ) {
            access_mode = FB_FILE_ACCESS_READ;
        } else if ( strcasecmp(str_access_mode->data, "W")==0 ) {
            access_mode = FB_FILE_ACCESS_WRITE;
        } else if ( strcasecmp(str_access_mode->data, "RW")==0 ) {
            access_mode = FB_FILE_ACCESS_READWRITE;
        } else {
            error_code = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    if( lock_mode_len!=0 && error_code==FB_RTERROR_OK ) {
        if ( strcasecmp(str_lock_mode->data, "S")==0 ) {
            lock_mode = FB_FILE_LOCK_SHARED;
        } else if ( strcasecmp(str_lock_mode->data, "R")==0 ) {
            lock_mode = FB_FILE_LOCK_READ;
        } else if ( strcasecmp(str_lock_mode->data, "W")==0 ) {
            lock_mode = FB_FILE_LOCK_WRITE;
        } else if ( strcasecmp(str_lock_mode->data, "RW")==0 ) {
            lock_mode = FB_FILE_LOCK_READWRITE;
        } else {
            error_code = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    FB_LOCK();
    fb_hStrDelTemp_NoLock( str_file_mode );
    fb_hStrDelTemp_NoLock( str_access_mode );
    fb_hStrDelTemp_NoLock( str_lock_mode );
    FB_UNLOCK();

    if( error_code!=FB_RTERROR_OK )
        return error_code;

    if( access_mode == -1 ) {
        /* determine the default access mode for a given file mode */
        switch (file_mode) {
        case FB_FILE_MODE_INPUT:
            access_mode = FB_FILE_ACCESS_READ;
            break;
        case FB_FILE_MODE_OUTPUT:
        case FB_FILE_MODE_APPEND:
            access_mode = FB_FILE_ACCESS_WRITE;
            break;
        default:
            access_mode = FB_FILE_ACCESS_ANY;
            break;
        }
    }

    if( lock_mode == -1 ) {
        /* determine the default lock mode for a given file mode */
        switch (file_mode) {
        case FB_FILE_MODE_INPUT:
            lock_mode = FB_FILE_LOCK_SHARED;
            break;
        default:
            lock_mode = FB_FILE_LOCK_WRITE;
            break;
        }
    }

    return fb_FileOpen( filename,
                        file_mode,
                        access_mode,
                        lock_mode,
                        fnum,
                        len );
}
