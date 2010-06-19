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
 * io_hgetstr - console line input function for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"


/*:::::*/
char *fb_ConsoleReadStr( char *buffer, int len )
{
	int k, x, y, cols, pos = 0;
	char ch[2] = { 0, '\0' };
	
	if (!__fb_con.inited)
		return fgets(buffer, len, stdin);
	
	fb_ConsoleGetSize(&cols, NULL);
	
	do 
	{
		while( ((k = fb_hGetCh(TRUE)) == -1) || (k & 0x100) )
			fb_Delay( 10 );

		/* drop subsequent keypresses, if any; this is needed to avoid escape
		 * sequence parsing problems in the fb_ConsoleGetXY() call below.
		 */
		while( fb_hGetCh(TRUE) >= 0 )
			fb_Delay( 10 );
		
		fb_ConsoleGetXY(&x, &y);
		
		if (k == 8) 
		{
			if (pos > 0) 
			{
				x--;
				if (x <= 0) 
				{
					x = cols;
					y--;
					if (y <= 0)
						x = y = 1;
				}
				fb_hTermOut(SEQ_LOCATE, x-1, y-1);
				fb_hTermOut(SEQ_DEL_CHAR, 0, 0);
				pos--;
			}
		}
		else if (k != '\t') 
		{
			if (pos < len - 1) 
			{
				buffer[pos++] = ch[0] = k;
				fb_ConsolePrintBuffer(ch, 0);
				if (x == cols)
					fputc('\n', __fb_con.f_out);
			}
		}
	} while (k != '\r');

	fputc('\n', __fb_con.f_out);
	buffer[pos] = '\0';
	
	return buffer;
}

