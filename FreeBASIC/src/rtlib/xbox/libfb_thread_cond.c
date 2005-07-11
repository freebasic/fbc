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
 * thread_cond.c -- Linux (pthreads) condition variables handling routines
 *
 * chng: feb/2005 written [lillo]
 *
 */

//THIS IS IMPORTANT! THIS LIB IS CAPABLE OF DOING THREADS!

#include <pthread.h>
#include "../fb.h"


typedef struct _FBCOND
{
} FBCOND;

static FBCOND condTB[FB_MAXCONDS];
static FB_LIST condList = { 0 };


/*:::::*/
FBCALL FBCOND *fb_CondCreate( void )
{
}

/*:::::*/
FBCALL void fb_CondDestroy( FBCOND *cond )
{
}

/*:::::*/
FBCALL void fb_CondSignal( FBCOND *cond )
{
}

/*:::::*/
FBCALL void fb_CondBroadcast( FBCOND *cond )
{
}

/*:::::*/
FBCALL void fb_CondWait( FBCOND *cond )
{
}
