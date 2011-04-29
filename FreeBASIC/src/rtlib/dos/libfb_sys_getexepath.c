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
 * sys_getexepath.c -- get the executable path for DOS
 *
 * chng: jan/2005 written [DrV]
 *       jun/2007 properly handle both / and \ in input (always return with \)
 *
 */

#include "fb.h"

/*:::::*/
char *fb_hGetExePath( char *dst, int maxlen )
{
	char *p;
	int argv_len, len;
	
	argv_len = strlen( __fb_ctx.argv[0] );
	
	/* check for drive letter - if there, get full path from argv[0] */
	if( isalpha(__fb_ctx.argv[0][0]) && __fb_ctx.argv[0][1] == ':' )
	{
		len = argv_len;
		if( len >= maxlen)
			return NULL;
		
		memcpy( dst, __fb_ctx.argv[0], len );
		dst[len] = '\0';
		
	}
	/* check for \ at beginning - get drive letter from cwd */
	else if( __fb_ctx.argv[0][0] == '\\' || __fb_ctx.argv[0][0] == '/' )
	{
		len = 1 + argv_len;
		if( len >= maxlen )
			return NULL;
		
		dst[0] = __fb_startup_cwd[0];
		dst[1] = ':';
		memcpy( dst + 2, __fb_ctx.argv[0], argv_len );
		dst[len] = '\0';
		
	}
	/* no drive letter, no \, so relative path - get cur dir from startup */
	else
	{
		int cwd_len;
		
		cwd_len = strlen(__fb_startup_cwd);
		
		len = cwd_len + 1 + argv_len;
		if( len >= maxlen )
			return NULL;
		
		memcpy( dst, __fb_startup_cwd, cwd_len );
		dst[cwd_len] = '\\';
		memcpy( dst + cwd_len + 1, __fb_ctx.argv[0], argv_len );
		dst[len] = '\0';
		
	}
	
	fb_hConvertPath( dst, len );
	
	p = strrchr( dst, '\\' );
	if( p != NULL )
		*p = '\0';
	
	/* upcase drive letter to be consistent with win32 port */
	dst[0] = toupper( dst[0] );
	
	return p;
}
