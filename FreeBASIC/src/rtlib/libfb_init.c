/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * init.c -- libfb initialization
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"


/* globals */
FBSTRING fb_strNullDesc = { NULL, 0 };
FB_FILE fb_fileTB[FB_MAX_FILES] = { { NULL } };
int fb_viewTopRow = -1;
int fb_viewBotRow = -1;

FB_ERRORCTX fb_errctx = { 0 };
FB_INPCTX fb_inpctx = { 0 };
FB_PRINTUSGCTX fb_printusgctx = { 0 };


/*:::::*/
FBCALL void fb_Init ( void )
{

	/* os-dep initialization */
	fb_hInit( );

	/////atexit( &fb_End );

}
