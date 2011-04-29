/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * drv_intl.c -- helper functions for internationalization support
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <stddef.h>
#include "fb.h"

int fb_hIntlGetInfo( DOS_COUNTRY_INFO_GENERAL *pInfo )
{
    int result = FALSE;
    int arg_seg, arg_sel;
    __dpmi_regs r;

    DBG_ASSERT( pInfo!=NULL );
    memset( pInfo, 0, sizeof(DOS_COUNTRY_INFO_GENERAL) );

    pInfo->info_id = 0x01;
    pInfo->size_data = sizeof(DOS_COUNTRY_INFO_GENERAL) - 3;

    arg_seg = __dpmi_allocate_dos_memory( (sizeof(DOS_COUNTRY_INFO_GENERAL) + 15) >> 4,
                                          &arg_sel );
    if( arg_seg==0 )
        return FALSE;

    memset( &r, 0, sizeof(r) );

    r.x.ax = 0x6501;
    r.x.bx = 0xFFFF;
    r.x.dx = 0xFFFF;
    r.x.es = arg_seg;
    r.x.di = 0x0000;
    r.x.cx = sizeof(DOS_COUNTRY_INFO_GENERAL);

    if( __dpmi_int( 0x21, &r )==0 ) {
        if( (r.x.flags & 0x01)==0 ) {
            movedata( arg_sel, 0,
                      _my_ds(), (unsigned) pInfo,
                      sizeof(DOS_COUNTRY_INFO_GENERAL) );
            result = TRUE;
        }
    }

    __dpmi_free_dos_memory( arg_sel );

    return result;
}
