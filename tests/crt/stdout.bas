# include once "fbcunit.bi"
# include once "crt.bi"

'' TODO: change to SUITE() & TEST() 
''   after improving fbcunit API (see below)
	
namespace fbc_tests.crt.stdoutTest

sub test cdecl ()

	fputs( "hello", stdout )
	CU_PASS("just a compile check")

end sub

sub ctor () constructor

'// fbcunit should handle this internally ...
'// need to add capability to fbcunit
# if ENABLE_CONSOLE_OUTPUT
	fbcu.add_suite("fbc_tests.crt.stdout")
	fbcu.add_test("test", @test)
# endif

end sub

end namespace
