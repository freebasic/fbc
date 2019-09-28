#include "../fb.h"
#include "fb_private_console.h"
#include <process.h>

FBCALL int fb_ExecEx_W( FB_WCHAR *program, FB_WCHAR *args, int do_fork )
{
    FB_WCHAR buffer[MAX_PATH+1], *arguments;
    int	res = 0;
    size_t len_arguments;
#ifndef HOST_MINGW
    size_t len_program;
#endif

    if (fb_wstr_Len(program) == 0) {
// free programm ? -> not necessary for wstrings ???

        return -1;
    }

    fb_hGetShortPath_W( program, buffer, MAX_PATH );


#ifdef HOST_MINGW
    if( args==NULL )
    {
        arguments = L"";
    }
    else
    {
        len_arguments = fb_wstr_Len( args );
        arguments = alloca( (len_arguments + 1)*2 );
        DBG_ASSERT( arguments!=NULL );
        if( len_arguments )
            FB_MEMCPY( arguments, args, len_arguments*2 );
        arguments[len_arguments] = 0;
    }

#else
    len_program = fb_wstr_Len( buffer );
    len_arguments = fb_wstr_Len( args );

    arguments = alloca( (len_program + len_arguments + 2)*2 );
    DBG_ASSERT( arguments!=NULL );

    FB_MEMCPY( arguments, buffer, len_program*2 );
    arguments[len_program] = ' ';
    arguments[len_program+1] = 0;

    if( len_arguments!=0 )
    {
		wcscat( arguments, args );
    }
#endif

//OutputDebugString("arguments follow:");
//OutputDebugStringW(arguments);


//	FB_STRLOCK();
//
//	fb_hStrDelTemp_NoLock( args );
//    fb_hStrDelTemp_NoLock( program );
//
//    FB_STRUNLOCK();

    FB_CON_CORRECT_POSITION();

	{
#ifdef HOST_MINGW
    if( do_fork )
    {
        res = _wspawnl( _P_WAIT, buffer, buffer, arguments, NULL );
    }
    else
    {  
        res = _wexecl( buffer, buffer, arguments, NULL );
    }

#else
    STARTUPINFOW StartupInfo;
    PROCESS_INFORMATION ProcessInfo;
    memset( &StartupInfo, 0, sizeof(StartupInfo) );
    StartupInfo.cb = sizeof(StartupInfo);

    if( !CreateProcessW( NULL,        /* application name - correct! */
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
    } 
    else
    {
        /* Release main thread handle - we're not interested in it */
        CloseHandle( ProcessInfo.hThread );
        if( do_fork )
        {
            DWORD dwExitCode;
            WaitForSingleObject( ProcessInfo.hProcess,
                                 INFINITE );
            if( !GetExitCodeProcess( ProcessInfo.hProcess, &dwExitCode ) ) {
                res = -1;
            } else {
                res = (int) dwExitCode;
            }
            CloseHandle( ProcessInfo.hProcess );
        }
        else
        {
            res = (int) ProcessInfo.hProcess;
        }
    }
#endif
	}

	return res;
}
