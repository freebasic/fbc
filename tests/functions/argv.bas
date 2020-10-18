' TEST_MODE : COMPILE_AND_RUN_OK

' Test arguments to main().
' A better test of COMMAND would be to actually call with some arguments...

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	#include "windows.bi"
#endif

ASSERT( __FB_ARGC__ = 1 )

'' Test argv[0] against __FILE__
dim as string expected_exe_1 = __FILE__
expected_exe_1 = left( expected_exe_1, len( expected_exe_1 ) - 4 )  ' Remove .bas
#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	expected_exe_1 += ".exe"

	'' Also test argv[0] against full exe path + name
	'' Windows (or MSYS2, or make?) passes the full absolute path in argv[0],
	'' even though the makefile invokes the test .exe with relative path.
	dim expected_exe_2 as zstring * (MAX_PATH + 1)
	GetModuleFileName( GetModuleHandle( NULL ), @expected_exe_2, sizeof( expected_exe_2 ) - 1 )
	ASSERT( len( expected_exe_2 ) >= len( expected_exe_1 ) )
	ASSERT( right( expected_exe_2, len( expected_exe_1 ) ) = expected_exe_1 )

	ASSERT( (*__FB_ARGV__[0] = expected_exe_1) or (*__FB_ARGV__[0] = expected_exe_2) )
	ASSERT( (command( 0 )    = expected_exe_1) or (command( 0 )    = expected_exe_2) )
#elseif defined( __FB_DOS__ )
#if ENABLE_CHECK_BUGS
	'' This depends on what kind of DOS is being run, in a bash like shell, etc.
	'' On DOS and Win98, should work
	'' On WinXP, there's confusion between short and long filenames.
	'' Just skip the test on DOS
	expected_exe_1 += ".exe"

	ASSERT( right( *__FB_ARGV__[0], len(expected_exe_1) ) = expected_exe_1 )
	ASSERT( right( command( 0 ), len(expected_exe_1) )    = expected_exe_1 )
#endif
#else
	ASSERT( *__FB_ARGV__[0] = expected_exe_1 )
	ASSERT( command( 0 )    = expected_exe_1 )
#endif


ASSERT( __FB_ARGV__[1] = 0 )
ASSERT( command( 1 ) = "" )
ASSERT( command( -1 ) = "" )  ' whole commandline
