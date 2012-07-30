/* helper functions for internationalization support */

#include "../fb.h"
#include "fb_private_intl.h"
#include <dpmi.h>
#include <go32.h>

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
