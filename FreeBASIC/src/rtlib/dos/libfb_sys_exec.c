/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2007 The FreeBASIC development team.
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
 * sys_exec.c -- exec function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"

#include <process.h>
#include <stdlib.h>

/*:::::*/
FBCALL int fb_ExecEx ( FBSTRING *program, FBSTRING *args, int do_fork )
{
	char buffer[MAX_PATH+1];
	char *argv[256], c, *startpos;
	int	res = 0;
	int	i;
	int	in_quotes = FALSE;

	if( (program != NULL) && (program->data != NULL) )
	{
		char *argsdata;

		if( (args == NULL) || (args->data == NULL) )
			argsdata = "\0";
		else
			argsdata = args->data;

		argv[0] = &buffer[0];

		for (i = 1, startpos = argsdata; (c = *argsdata) != '\0'; argsdata++) {
			if (in_quotes) {
				if (c == '"') {
					in_quotes = FALSE;
					argv[i] = (char*)malloc(argsdata - startpos + 1);
					memcpy(argv[i], startpos, argsdata - startpos);
					argv[i][argsdata - startpos] = '\0';
					i++;
					startpos = argsdata + 1;
					if (*startpos == ' ') startpos++;
				}
			} else { /* in_quotes */
				if (c == '"') {
					in_quotes = TRUE;
					startpos = argsdata + 1;
				} else if (c == ' ') {
					if (argsdata - startpos > 0) {
						argv[i] = (char*)malloc(argsdata - startpos + 1);
						memcpy(argv[i], startpos, argsdata - startpos);
						argv[i][argsdata - startpos] = '\0';
						i++;
					}
					startpos = argsdata + 1;
				}
			} /* in_quotes */
		}

		/* get last arg */
		if (startpos < argsdata) {
			argv[i] = (char*)malloc(argsdata - startpos + 1);
			memcpy(argv[i], startpos, argsdata - startpos);
			argv[i][argsdata - startpos] = '\0';
			i++;
		}

		argv[i] = NULL;


		/* NOTE: DJGPP info on 3rd arg of spawnv* functions is inconsistent;
		   in docs, defined as const char **;
		   in process.h, defined as char *const _argv[]
		*/

		fb_hGetShortPath( program->data, buffer, MAX_PATH );
		if( do_fork )
			res = spawnv( P_WAIT, (const char*)buffer, (char * const *)argv );
		else
			res = execv( (const char*)buffer, (char * const *)argv );

		for (i = 1; argv[i] != NULL; i++) {
			free(argv[i]);
		}
	}

	/* del if temp */
	fb_hStrDelTemp( args );
	fb_hStrDelTemp( program );

	return res;
}

/*:::::*/
FBCALL int fb_Exec ( FBSTRING *program, FBSTRING *args )
{
	return fb_ExecEx( program, args, TRUE );
}

