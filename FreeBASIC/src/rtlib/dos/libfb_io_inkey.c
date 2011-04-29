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
 * io_inkey.c -- inkey$ function for DOS console mode apps
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"

#include <conio.h>

/*:::::*/
FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING	*res;
	unsigned int	k;
	int		chars;

	if( _conio_kbhit( ) )
	{
		chars = 1;
		k = (unsigned int)getch( );
		if( k == 0x00 || k == 0xE0 )
		{
			k = (unsigned int)getch( );
			chars = 2;
		}

        res = fb_hStrAllocTemp( NULL, chars );
        DBG_ASSERT( res!=NULL );
        if( chars > 1 )
            res->data[0] = FB_EXT_CHAR; /* note: can't use '\0' here as in qb */

        res->data[chars-1] = (unsigned char)k;
        res->data[chars-0] = '\0';

        /* Reset the status for "key buffer changed" when a key
         * was removed from the input queue. */
        fb_hConsoleInputBufferChanged();
    }
	else
		res = &__fb_ctx.null_desc;

	return res;
}

/*:::::*/
int fb_ConsoleGetkey( void )
{
	int k = 0;

	k = getch( );
	if( k == 0x00 || k == 0xE0 )
		k = getch( );

    /* Reset the status for "key buffer changed" when a key
     * was removed from the input queue. */
    fb_hConsoleInputBufferChanged();

	return k;
}

/*:::::*/
int fb_ConsoleKeyHit( void )
{

	return _conio_kbhit( );

}

