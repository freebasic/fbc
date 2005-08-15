/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * intl_conv_w32.c -- Convert a strings character set to another character set.
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fb.h"
#include <stddef.h>
#include <stdlib.h>

static
FBSTRING *fb_hIntlConvertToWC(FBSTRING *source, UINT source_cp )
{
    FBSTRING *res;
    int CharsRequired;
    size_t idx;

    FB_STRLOCK();
    CharsRequired =
        MultiByteToWideChar( source_cp,
                             0,
                             source->data,
                             FB_STRSIZE(source),
                             NULL,
                             0 );

    res = fb_hStrAllocTemp( NULL, CharsRequired * sizeof(WCHAR) + 1 );
    if( res==NULL )
        return &fb_strNullDesc;

    MultiByteToWideChar( source_cp,
                         0,
                         (LPCSTR) source->data,
                         FB_STRSIZE(source),
                         (LPWSTR) res->data,
                         CharsRequired );

    idx = CharsRequired * sizeof(WCHAR);
    res->data[idx++] = 0;
    res->data[idx++] = 0;

    return res;
}

static
FBSTRING *fb_hIntlConvertFromWC(FBSTRING *source, UINT dest_cp )
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

    res = fb_hStrAllocTemp( NULL, CharsRequired );
    if( res==NULL )
        return &fb_strNullDesc;

    WideCharToMultiByte( dest_cp,
                         0,
                         (LPCWSTR) source->data,
                         FB_STRSIZE(source) / sizeof(WCHAR),
                         (LPSTR) res->data,
                         CharsRequired,
                         NULL,
                         NULL );

    res->data[CharsRequired] = 0;

    return res;
}

FBSTRING *fb_hIntlConvertString( FBSTRING *source,
                                 int source_cp,
                                 int dest_cp )
{
    FBSTRING *res = fb_hIntlConvertToWC( source, source_cp );
    res = fb_hIntlConvertFromWC( res, dest_cp );
    return res;
}
