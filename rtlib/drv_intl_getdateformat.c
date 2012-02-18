/* get localized short DATE format */

#include "fb.h"
#include "fb_private_intl.h"

#if defined( HOST_DOS )
int fb_DrvIntlGetDateFormat( char *buffer, size_t len )
{
    DOS_COUNTRY_INFO_GENERAL Info;

    if( len < 11 )
        return FALSE;
    if( !fb_hIntlGetInfo( &Info ) )
        return FALSE;

    switch( Info.date_format ) {
    case 0:
        strcpy( buffer, "MM/dd/yyyy" );
        break;
    case 1:
        strcpy( buffer, "dd/MM/yyyy" );
        break;
    case 2:
        strcpy( buffer, "yyyy/MM/dd" );
        break;
    default:
        return FALSE;
    }

    return TRUE;
}

#elif defined( HOST_UNIX )
int fb_DrvIntlGetDateFormat( char *buffer, size_t len )
{
    int do_esc = FALSE, do_fmt = FALSE;
    char *pszOutput = buffer;
    char achAddBuffer[2] = { 0 };
    const char *pszAdd = NULL;
    size_t remaining = len - 1, add_len = 0;
    const char *pszCurrent = nl_langinfo( D_FMT );

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

            case 'a':
                pszAdd = "ddd";
                add_len = 3;
                break;
            case 'A':
                pszAdd = "dddd";
                add_len = 4;
                break;
            case 'h':
            case 'b':
                pszAdd = "mmm";
                add_len = 3;
                break;
            case 'B':
                pszAdd = "mmmm";
                add_len = 4;
                break;
            case 'd':
            case 'e':
                pszAdd = "dd";
                add_len = 2;
                break;
            case 'F':
                pszAdd = "yyyy-MM-dd";
                add_len = 10;
                break;
            case 'm':
                pszAdd = "MM";
                add_len = 2;
                break;
            case 'D':
            case 'x':
                pszAdd = "MM/dd/yyyy";
                add_len = 10;
                break;
            case 'y':
                pszAdd = "yy";
                add_len = 2;
                break;
            case 'Y':
                pszAdd = "yyyy";
                add_len = 4;
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
int fb_DrvIntlGetDateFormat( char *buffer, size_t len )
{
    char *pszName;
    char achFormat[90];
    char achOrder[3] = { 0 };
    char achDayZero[2], *pszDayZero;
    char achMonZero[2], *pszMonZero;
    char achDate[2], *pszDate;
    size_t i;

    DBG_ASSERT(buffer!=NULL);

    /* Can I use this? The problem is that it returns the date format
     * with localized separators. */
    pszName = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_SSHORTDATE,
                                 achFormat, sizeof(achFormat) - 1 );
    if( pszName!=NULL ) {
        size_t uiNameSize = strlen(pszName);
        if( uiNameSize < len ) {
            strcpy( buffer, pszName );
            return TRUE;
        } else {
            return FALSE;
        }
    }


    /* Fall back for Win95 and WinNT < 4.0 */
    pszDayZero = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_IDAYLZERO,
                                    achDayZero, sizeof(achDayZero) );
    pszMonZero = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_IMONLZERO,
                                    achMonZero, sizeof(achMonZero) );
    pszDate = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_IDATE,
                                 achDate, sizeof(achDate) );
    if( pszDate!=NULL && pszDayZero!=0 && pszMonZero!=0 ) {
        switch( atoi( pszDate ) ) {
        case 0:
            FB_MEMCPY(achOrder, "mdy", 3);
            break;
        case 1:
            FB_MEMCPY(achOrder, "dmy", 3);
            break;
        case 2:
            FB_MEMCPY(achOrder, "ymd", 3);
            break;
        default:
            break;
        }

        if( achOrder[0]!=0 ) {
            size_t remaining = len - 1;
            int day_lead_zero = atoi( pszDayZero ) != 0;
            int mon_lead_zero = atoi( pszMonZero ) != 0;
            for(i=0; i!=3; ++i) {
                const char *pszAdd = NULL;
                size_t add_len;
                switch ( achOrder[i] ) {
                case 'm':
                    if( mon_lead_zero ) {
                        pszAdd = "MM";
                    } else {
                        pszAdd = "M";
                    }
                    break;
                case 'd':
                    if( day_lead_zero ) {
                        pszAdd = "dd";
                    } else {
                        pszAdd = "d";
                    }
                    break;
                case 'y':
                    pszAdd = "yyyy";
                    break;
                }
                add_len = strlen(pszAdd);
                if( remaining < add_len )
                    return FALSE;
                strcpy( buffer, pszAdd );
                buffer += add_len;
                remaining -= add_len;
                if( i!=2 ) {
                    if( remaining==0 )
                        return FALSE;
                    strcpy( buffer, "/" );
                    buffer += 1;
                    remaining -= 1;
                }
            }
            return TRUE;
        }
    }

    return FALSE;
}

#else
int fb_DrvIntlGetDateFormat( char *buffer, size_t len )
{
    /* No localized date format available! */
    return FALSE;
}

#endif
