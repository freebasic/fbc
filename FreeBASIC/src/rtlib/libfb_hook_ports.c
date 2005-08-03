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
 * hook_ports.c -- ports I/O hooks, default to system implementations
 *
 * chng: aug/2005 written [lillo]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_In( unsigned short port )
{
	int res = -1;
	
	FB_LOCK();
	
	if( fb_hooks.inproc)
		res = fb_hooks.inproc( port );
	if( res < 0 )
		res = fb_hIn( port );
	
	FB_UNLOCK();
	
	return res;
}

/*:::::*/
FBCALL int fb_Out( unsigned short port, unsigned char value )
{
	int res = -1;
	
	FB_LOCK();
	
	if( fb_hooks.outproc)
		res = fb_hooks.outproc( port, value );
	if( res < 0 )
		res = fb_hOut( port, value );
	
	FB_UNLOCK();
	
	return res;
}

/*:::::*/
FBCALL int fb_Wait( unsigned short port, int and, int xor )
{
	int res;
	
	do {
		res = fb_In( port );
		if( res < 0 )
			return res;
		res ^= xor;
	} while( ( res & and ) == 0 );
	
	return FB_RTERROR_OK;
}
