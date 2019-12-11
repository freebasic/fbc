/* Core i18n functions */

#include "../fb.h"
#include "fb_private_intl.h"

/* Convert a strings character set to another character set. */
static FBSTRING *fb_hIntlConvertToWC( FBSTRING *source, UINT source_cp )
{
    FBSTRING *res;
    int CharsRequired;

    FB_STRLOCK();

    CharsRequired =
        MultiByteToWideChar( source_cp,
                             0,
                             source->data,
                             FB_STRSIZE(source),
                             NULL,
                             0 );

    res = fb_hStrAllocTemp_NoLock( NULL, (CharsRequired + 1) * sizeof(WCHAR) - 1 );
    if( res!=NULL ) {
        size_t idx = CharsRequired * sizeof(WCHAR);
        MultiByteToWideChar( source_cp,
                             0,
                             (LPCSTR) source->data,
                             FB_STRSIZE(source),
                             (LPWSTR) res->data,
                             CharsRequired );
        *((WCHAR*) (res->data + idx)) = 0;
    } else {
        res = &__fb_ctx.null_desc;
    }

    fb_hStrDelTemp_NoLock( source );

    FB_STRUNLOCK();

    return res;
}

static FBSTRING *fb_hIntlConvertFromWC( FBSTRING *source, UINT dest_cp )
{
    FBSTRING *res;
    int CharsRequired;

    FB_STRLOCK();

    CharsRequired =
        WideCharToMultiByte( dest_cp,
                             0,
                             (LPCWSTR) source->data,
                             FB_STRSIZE(source) / sizeof(WCHAR),
                             (LPSTR) NULL,
                             0,
                             NULL,
                             NULL );

    res = fb_hStrAllocTemp_NoLock( NULL, CharsRequired );
    if( res!=NULL ) {
        WideCharToMultiByte( dest_cp,
                             0,
                             (LPCWSTR) source->data,
                             FB_STRSIZE(source) / sizeof(WCHAR),
                             (LPSTR) res->data,
                             CharsRequired,
                             NULL,
                             NULL );
        res->data[CharsRequired] = 0;
    } else {
        res = &__fb_ctx.null_desc;
    }

    fb_hStrDelTemp_NoLock( source );

    FB_STRUNLOCK();

    return res;
}

FBSTRING *fb_hIntlConvertString( FBSTRING *source, int source_cp, int dest_cp )
{
	return fb_hIntlConvertFromWC( fb_hIntlConvertToWC( source, source_cp ), dest_cp );
}

char *fb_hGetLocaleInfo( LCID Locale, LCTYPE LCType, char *pszBuffer, size_t uiSize )
{
    if( uiSize==0 ) {
        uiSize = 64;
        pszBuffer = NULL;
        for(;;) {
            char* pszNewBuffer = (char*) realloc( pszBuffer, uiSize <<= 1 );
            if( pszNewBuffer==NULL ) {
                free(pszBuffer);
                break;
            }
            pszBuffer = pszNewBuffer;
            if( GetLocaleInfo( Locale, LCType, pszBuffer, uiSize - 1 )!=0 ) {
                return pszBuffer;
            }
            if( GetLastError( ) != ERROR_INSUFFICIENT_BUFFER ) {
                free( pszBuffer );
                pszBuffer = NULL;
                break;
            }
        }
    } else {
        if( GetLocaleInfo( Locale, LCType, pszBuffer, uiSize )!=0 )
            return pszBuffer;
    }
    return NULL;
}
