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
 * sys_exec.c -- exec function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"

#include <process.h>

/*:::::*/
FBCALL int fb_Exec ( FBSTRING *program, FBSTRING *args )
{
	char	buffer[MAX_PATH+1];
	char	*argv[256];
	int	res;

	if( (program != NULL) && (program->data != NULL) )
	{
		char *argsdata;

		if( (args == NULL) || (args->data == NULL) )
			argsdata = "\0";
		else
			argsdata = args->data;

		argv[0] = &buffer[0];
		argv[1] = argsdata;
		argv[2] = NULL;
		res = spawnv(P_WAIT, (const char*)fb_hGetShortPath(program->data, buffer, MAX_PATH), (const char **)argv);
	}

	/* del if temp */
	fb_hStrDelTemp( args );
	fb_hStrDelTemp( program );

	return res;
}

