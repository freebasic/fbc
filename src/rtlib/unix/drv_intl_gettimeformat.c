/* get localized short TIME format */

#include "../fb.h"
#include <langinfo.h>

int fb_DrvIntlGetTimeFormat( char *buffer, size_t len )
{
    int do_esc = FALSE, do_fmt = FALSE;
    char *pszOutput = buffer;
    char achAddBuffer[2] = { 0 };
    const char *pszAdd = NULL;
    size_t remaining = len - 1, add_len = 0;
    const char *pszCurrent = nl_langinfo( T_FMT );

    DBG_ASSERT(buffer!=NULL);

    while ( *pszCurrent!=0 ) {
        char ch = *pszCurrent;
        if( do_esc ) {
            do_esc = FALSE;
            achAddBuffer[0] = ch;
            pszAdd = achAddBuffer;
            add_len = 1;
        } else if ( do_fmt ) {
            int succeeded = TRUE;
            do_fmt = FALSE;
            switch (ch) {
            case 'n':
                pszAdd = "\n";
                add_len = 1;
                break;
            case 't':
                pszAdd = "\t";
                add_len = 1;
                break;
            case '%':
                pszAdd = "%";
                add_len = 1;
                break;

            case 'H':
                pszAdd = "HH";
                add_len = 2;
                break;
            case 'I':
                pszAdd = "hh";
                add_len = 2;
                break;
            case 'M':
                pszAdd = "mm";
                add_len = 2;
                break;
            case 'p':
                pszAdd = "tt";
                add_len = 2;
                break;
            case 'r':
                pszAdd = "hh:mm:ss tt";
                add_len = 11;
                break;
            case 'R':
                pszAdd = "HH:mm";
                add_len = 5;
                break;
            case 'S':
                pszAdd = "ss";
                add_len = 2;
                break;
            case 'T':
            case 'X':
                pszAdd = "HH:mm:ss";
                add_len = 8;
                break;
            default:
                /* Unsupported format */
                succeeded = FALSE;
                break;
            }
            if( !succeeded )
                break;
        } else {
            switch (ch) {
            case '%':
                do_fmt = TRUE;
                break;
            case '\\':
                do_esc = TRUE;
                break;
            default:
                achAddBuffer[0] = ch;
                pszAdd = achAddBuffer;
                add_len = 1;
                break;
            }
        }
        if( add_len!=0 ) {
            if( remaining < add_len ) {
                return FALSE;
            }
            strcpy( pszOutput, pszAdd );
            pszOutput += add_len;
            remaining -= add_len;
            add_len = 0;
        }
        ++pszCurrent;
    }

    return TRUE;
}
