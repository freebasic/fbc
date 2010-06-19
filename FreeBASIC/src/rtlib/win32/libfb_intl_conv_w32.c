/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
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

FBSTRING *fb_hIntlConvertString( FBSTRING *source,
                                 int source_cp,
                                 int dest_cp )
{
    return fb_hIntlConvertFromWC( fb_hIntlConvertToWC( source, source_cp ),
                                  dest_cp );
}
