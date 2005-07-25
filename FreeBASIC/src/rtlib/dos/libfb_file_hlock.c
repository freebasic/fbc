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
 *	file_hlock - low-level lock and unlock functions for DOS
 *
 *  chng: jan/2005 written [DrV]
 *
 */


#include "fb.h"
#include "fb_rterr.h"
#include <io.h>

/*:::::*/
int fb_hFileLock( FILE *f, unsigned int inipos, unsigned int size )
{
	int res;
	res = _dos_lock(fileno(f), inipos, size );
	return fb_ErrorSetNum( res == 0? FB_RTERROR_OK: FB_RTERROR_FILEIO );
}

/*:::::*/
int fb_hFileUnlock( FILE *f, unsigned int inipos, unsigned int size )
{
	int res;
	res = _dos_unlock(fileno(f), inipos, size);
	return fb_ErrorSetNum( res == 0? FB_RTERROR_OK: FB_RTERROR_FILEIO );
}






