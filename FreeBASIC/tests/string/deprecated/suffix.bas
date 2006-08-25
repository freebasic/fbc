# include once "fbcu.bi"

# if __FB_LANG__ = deprecated

namespace fbc_tests.string_.suffix

dim shared s$

sub mysub ( byval s$ )
	'' local
'	s$ = "1234"
end sub

sub stringScopeTest cdecl ()
	'' global
'	s$ = "5678"
	
	dim tmp$ = space( 4 )
	mysub( tmp$ )
	
	CU_ASSERT_EQUAL( s$, "5678" )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.suffix")
	fbcu.add_test("stringScopeTest", @stringScopeTest)

end sub

end namespace

# endif
