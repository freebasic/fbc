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
 * sys_exec.c -- exec function for Windows
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <assert.h>
#include <malloc.h>
#include <string.h>
#include <process.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_hExec ( FBSTRING *program, FBSTRING *args, int do_wait )
{
    char	buffer[MAX_PATH+1];
    char   *application;
    char   *arguments;
    int		res = 0;
    int     got_program;
    size_t  len_arguments, len_program;

    FB_STRLOCK();

    got_program = (program != NULL) && (program->data != NULL);

    if( !got_program ) {
        fb_hStrDelTemp( args );
        fb_hStrDelTemp( program );
        FB_STRUNLOCK();
        return -1;
    }

    application = fb_hGetShortPath( program->data, buffer, MAX_PATH );
    assert( application!=NULL );
    if( application==program->data ) {
        application = buffer;
        FB_MEMCPY(application, program->data, FB_STRSIZE( program ) );
    }

#ifdef TARGET_WIN32
    if( args==NULL ) {
        arguments = "";
    } else {
        len_arguments = FB_STRSIZE( args );
        arguments = alloca( len_arguments + 1 );
        assert( arguments!=NULL );
        if( len_arguments )
            FB_MEMCPY( arguments, args->data, len_arguments );
        arguments[len_arguments] = 0;
    }
#else
    len_program = strlen( buffer );
    len_arguments = ( ( args==NULL ) ? 0 : FB_STRSIZE( args ) );

    arguments = alloca( len_program + len_arguments + 2 );
    assert( arguments!=NULL );

    FB_MEMCPY( arguments, buffer, len_program );
    arguments[len_program] = ' ';
    if( len_arguments!=0 )
        FB_MEMCPY( arguments + len_program + 1, args->data, len_arguments );
    arguments[len_program + len_arguments + 1] = 0;
#endif

	fb_hStrDelTemp( args );
    fb_hStrDelTemp( program );

    FB_STRUNLOCK();

	{
#ifdef TARGET_WIN32
        res = _spawnl( (do_wait ? _P_WAIT : _P_NOWAIT), buffer, buffer, arguments, NULL );
#else
        STARTUPINFO StartupInfo;
        PROCESS_INFORMATION ProcessInfo;
        memset( &StartupInfo, 0, sizeof(StartupInfo) );
        StartupInfo.cb = sizeof(StartupInfo);

        if( !CreateProcess( NULL,        /* application name - correct! */
                            arguments,   /* command line */
                            NULL, NULL,  /* default security descriptors */
                            FALSE,       /* don't inherit handles */
                            CREATE_DEFAULT_ERROR_MODE, /* do we really need this? */
                            NULL,        /* default environment */
                            NULL,        /* current directory */
                            &StartupInfo,
                            &ProcessInfo ) )
        {
            res = -1;
        } else {
            DWORD dwExitCode;
            /* Release main thread handle - we're not interested in it */
            CloseHandle( ProcessInfo.hThread );
            WaitForSingleObject( ProcessInfo.hProcess,
                                 INFINITE );
            if( !GetExitCodeProcess( ProcessInfo.hProcess, &dwExitCode ) ) {
                res = -1;
            } else {
                res = (int) dwExitCode;
            }
            CloseHandle( ProcessInfo.hProcess );
        }
#endif
	}

	return res;
}

/*:::::*/
FBCALL int fb_Exec ( FBSTRING *program, FBSTRING *args )
{
    return fb_hExec( program, args, TRUE );
}

