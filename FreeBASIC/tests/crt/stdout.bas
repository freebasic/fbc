# include once "fbcu.bi"
# include once "crt.bi"



	
namespace fbc_tests.crt.stdoutTest

sub test cdecl ()

	fputs( "hello", stdout )
	CU_PASS("just a compile check")

end sub

sub ctor () constructor

'// fbcu should handle this internally ...
# if defined(FBCU_CONFIG_TEST_OUTPUT)
	fbcu.add_suite("fbc_tests.crt.stdout")
	fbcu.add_test("test", @test)
# endif

end sub

end namespace
