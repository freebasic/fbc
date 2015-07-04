# include "fbcu.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with these tests
#undef FALSE
#undef TRUE

# define FALSE 0
# define TRUE NOT FALSE

# define FOO TRUE

namespace fbc_tests.macros.conditional

sub ifEqualityTest cdecl ()

# if FOO = TRUE
CU_PASS("")
# else
CU_FAIL_FATAL("")
# endif

end sub

sub ifInequalityTest cdecl ()

# if FOO <> FALSE and not defined(BAR)
CU_PASS("")
# else
CU_FAIL_FATAL("")
# endif

end sub

sub elseifDefinedTest cdecl ()

# if defined(FOO) and defined(BAR)
CU_FAIL_FATAL("")
# elseif not defined(FOO) and defined(BAR)
CU_FAIL_FATAL("")
# elseif defined(FOO) and not defined(BAR)
CU_PASS("")
# elseif not defined(FOO) or not defined(BAR)
CU_FAIL_FATAL("")
# endif

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.macros.conditional")
	fbcu.add_test("ifEqualityTest", @ifEqualityTest)
	fbcu.add_test("ifInequalityTest", @ifInequalityTest)
	fbcu.add_test("elseifDefinedTest", @elseifDefinedTest)

end sub

end namespace
