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
 * sys_dylib.c -- Dynamic library loading and symbols retrieving
 *
 * chng: feb/2005 written [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"


/*:::::*/
FBCALL void *fb_DylibLoad( FBSTRING *library )
{
	void *res = NULL;
	int i;
	char libname[1024];
	char *libnameformat[] = { "%s",
							  "lib%s",
							  "lib%s.so",
							  "./%s",
							  "./lib%s",
							  "./lib%s.so",
							  NULL };

	libname[1023] = '\0';
	if( (library) && (library->data) ) {
		for( i = 0; libnameformat[i]; i++ ) {
			snprintf( libname, 1023, libnameformat[i], library->data );
			res = dlopen( libname, RTLD_LAZY );
			if( res )
				break;
		}
	}

	/* del if temp */
	fb_hStrDelTemp( library );

	return res;
}

/*:::::*/
FBCALL void *fb_DylibSymbol( void *library, FBSTRING *symbol )
{
	void *proc = NULL;

	if( library == NULL )
		library = dlopen( NULL, RTLD_LAZY );

	if( (symbol) && (symbol->data) )
		proc = dlsym( library, symbol->data );

	/* del if temp */
	fb_hStrDelTemp( symbol );

	return proc;
}
