' TEST_MODE : COMPILE_AND_RUN_OK

#define assert_(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

'' Regression test for nested namespace abbreviation mangling
'' TODO: Find better way to test fbc's name mangling than this hack?

namespace aaa alias "aaa"
	type UDT
		i as long
	end type
	namespace bbb alias "bbb"
		declare operator + cdecl(byref l as const aaa.UDT, byref r as const aaa.UDT) as string
	end namespace
end namespace

function tester cdecl alias "_ZN3aaa3bbbplERKNS_3UDTES3_"(byref l as const aaa.UDT, byref r as const aaa.UDT) as string
	function = __FILE__ + " test 1"
end function

dim as const aaa.UDT x = (1), y = (2)
assert_( (x + y) = (__FILE__ + " test 1") )
