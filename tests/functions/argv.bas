' TEST_MODE : COMPILE_AND_RUN_OK

' Test arguments to main().
' A better test of COMMAND would be to actually call with some arguments...

ASSERT( __FB_ARGC__ = 1 )

dim as string expected_exe = __FILE__
expected_exe = left( expected_exe, len( expected_exe ) - 4)  ' Remove .bas
#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or defined(__FB_DOS__)
	expected_exe += ".exe"
#endif

ASSERT( *__FB_ARGV__[0] = expected_exe )
ASSERT( command( 0 ) = expected_exe )

ASSERT( __FB_ARGV__[1] = 0 )
ASSERT( command( 1 ) = "" )
ASSERT( command( -1 ) = "" )  ' whole commandline
