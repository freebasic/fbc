/* get localized short TIME format */

#include "../fb.h"
#include "fb_private_intl.h"

int fb_DrvIntlGetTimeFormat( char *buffer, size_t len )
{
    char achFormat[90], *pszFormat;
    char achHourZero[8], *pszHourZero;
    char achTimeMark[8], *pszTimeMark;
    char achTimeMarkPos[8], *pszTimeMarkPos;
    int use_timemark, timemark_prefix;
    size_t i;

    DBG_ASSERT(buffer!=NULL);

    /* Can I use this? The problem is that it returns the date format
     * with localized separators. */
    pszFormat = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_STIMEFORMAT,
                                   achFormat, sizeof(achFormat) - 1 );
    if( pszFormat!=NULL ) {
        size_t uiNameSize = strlen(pszFormat);
        if( uiNameSize < len ) {
            strcpy( buffer, pszFormat );
            return TRUE;
        } else {
            return FALSE;
        }
    }


    /* Fall back for Win95 and WinNT < 4.0 */
    pszTimeMarkPos = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_ITIMEMARKPOSN,
                                        achTimeMarkPos, sizeof(achTimeMarkPos) );
    pszTimeMark = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_ITIME,
                                     achTimeMark, sizeof(achTimeMark) );
    pszHourZero = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_ITLZERO,
                                     achHourZero, sizeof(achHourZero) );

    i = 0;

    use_timemark = ( pszTimeMark!=NULL && atoi( pszTimeMark )==1 );
    timemark_prefix = ( pszTimeMarkPos!=NULL && atoi( pszTimeMarkPos )==1 );

    if( use_timemark && timemark_prefix ) {
        strcpy( achFormat + i, "AM/PM " );
        i += 6;
    }

    if( pszHourZero!=NULL && atoi( pszHourZero )==1 ) {
        if( !use_timemark ) {
            strcpy( achFormat + i, "HH:" );
        } else {
            strcpy( achFormat + i, "hh:" );
        }
        i += 3;
    }
    strcpy( achFormat + i, "mm:ss" );
    i += 5;

    if( use_timemark && !timemark_prefix ) {
        strcpy( achFormat + i, " AM/PM" );
        i += 6;
    }

    if( len < (i+1) )
        return FALSE;

    FB_MEMCPY(buffer, achFormat, i);
    buffer[i] = 0;

    return TRUE;
}
