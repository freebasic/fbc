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
 * io_gethnd - console handle getter
 *
 * chng: dec/2005 written [v1ctor]
 *
 */

#include "fb_con.h"

static int is_init = FALSE;

/*:::::*/
HANDLE fb_hConsoleGetHandle
	(
		int is_input
	)
{
	if( is_init == FALSE )
	{
		is_init = TRUE;

		__fb_con.inHandle = GetStdHandle( STD_INPUT_HANDLE );
		__fb_con.outHandle = GetStdHandle( STD_OUTPUT_HANDLE );

    	if( __fb_con.inHandle != NULL )
	    {
    	    /* Initialize console mode to enable processed input */
        	DWORD dwMode;
        	if( GetConsoleMode( __fb_con.inHandle, &dwMode ) )
        	{
            	dwMode |= ENABLE_PROCESSED_INPUT;
            	SetConsoleMode( __fb_con.inHandle, dwMode );
        	}
    	}

    	__fb_con.active = __fb_con.visible = 0;
    	__fb_con.pgHandleTb[0] = __fb_con.outHandle;
    }

	return (is_input? __fb_con.inHandle : __fb_con.pgHandleTb[__fb_con.active]);
}

/*:::::*/
void fb_hConsoleResetHandles()
{
	/* 
		Called by fb_FileResetEx() to cause fb_hConsoleGetHandle() 
		to reset the stored I/O handles 
	*/

	is_init = FALSE;
}
