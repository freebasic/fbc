' TEST_MODE : COMPILE_AND_RUN_OK

#define assert_(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

'' Regression test for FBSTRING abbreviation mangling
'' TODO: Find better way to test fbc's name mangling than this hack?

namespace aaa alias "aaa"
	namespace bbb alias "bbb"
		declare function f cdecl(byref as string, byref as string) as string
	end namespace
end namespace

function tester cdecl alias "_ZN3aaa3bbb1FER8FBSTRINGS2_"(byref s1 as string, byref s2 as string) as string
	function = __FILE__ + " test 1 " + s1 + " " + s2
end function

assert_( aaa.bbb.f("333", "444") = (__FILE__ + " test 1 333 444") )
