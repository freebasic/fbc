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
 * atexit.c -- atexit() proc
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#ifdef WIN32

 /* can't include stdlib.h as Mingw32 will not import atexit() from crtdll, but
    from it's static lib.. libcrtdll.dll.a can't come from Mingw32 package either
    as it doesn't include the import for atexit() */

#include <_mingw.h>

_CRTIMP int __cdecl	atexit	(void (*proc)(void));

#else

#include <stdlib.h>

#endif


/*:::::*/
__stdcall void fb_AtExit ( void (*proc)(void) )
{

	atexit( proc );

}

