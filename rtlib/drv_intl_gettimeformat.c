/* get localized short TIME format */

#include "fb.h"
#include "fb_private_intl.h"

#if defined( HOST_DOS )
int fb_DrvIntlGetTimeFormat( char *buffer, size_t len )
{
	DOS_COUNTRY_INFO_GENERAL Info;

	if( fb_hIntlGetInfo( &Info ) ) {
		switch( Info.time_format ) {
		case 0:
			if( len >= 12 ) {
				strcpy( buffer, "hh:mm:ss tt" );
				return TRUE;
			}
			break;
		case 1:
			if( len >= 9 ) {
				strcpy( buffer, "HH:mm:ss" );
				return TRUE;
			}
			break;
		}
	}

	return FALSE;
}

#elif defined( HOST_UNIX )
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

#elif defined( HOST_WIN32 )
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

#else
int fb_DrvIntlGetTimeFormat( char *buffer, size_t len )
{
    /* No localized time format available! */
    return FALSE;
}

#endif
