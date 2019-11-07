/* get file length by wide filename */

#include "../fb.h"

fb_off_t fb_FileLenExW( const FB_WCHAR *filename )
{
    FILE *fp;
    fb_off_t len;
    
    fp = _wfopen( filename, L"rb" );    
    if( fp != NULL )
    {
        if( fseeko( fp, 0, SEEK_END ) == 0 ) 
        {
            if( (len = ftello( fp )) != -1 ) 
            {
                fclose( fp );
                fb_ErrorSetNum( FB_RTERROR_OK );
                return len;
            }
        }

        fclose( fp );
    }

    fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    return 0;
}

FBCALL long long fb_FileLenW( const FB_WCHAR *filename )
{
    return fb_FileLenExW( filename );
}
