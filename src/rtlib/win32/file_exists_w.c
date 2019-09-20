/* file existence testing for wide string filenames*/

#include "../fb.h"

FBCALL int fb_FileExistsW 
    ( 
        const FB_WCHAR *filename 
    )
{
    FILE *fp;
    
    fp = _wfopen(filename, L"r");
    if (fp) 
    {
        fclose(fp);
        return FB_TRUE;
    } 
    else
    {
        return FB_FALSE;
    }
}
