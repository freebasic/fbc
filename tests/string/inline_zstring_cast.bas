# include "fbcu.bi"

namespace fbc_tests.string_.inline_zstring_cast
	
	const as string key = "This is a string that's exactly 63 characters long! Oh yeah!!!!"
	
	sub ztest cdecl ()
		dim as ubyte foo(63)
		*cast(zstring ptr, @foo(0)) = key
		CU_ASSERT( *cast(zstring ptr, @foo(0)) = key )
	end sub
	
	sub wtest cdecl ()
		dim as ubyte foo(63*sizeof(wstring))
		*cast(wstring ptr, @foo(0)) = key
		CU_ASSERT( *cast(wstring ptr, @foo(0)) = key )
	end sub
	
	sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.string_.inline_zstring_cast")
		fbcu.add_test("inline zstring cast assignment", @ztest)
		fbcu.add_test("inline wstring cast assignment", @wtest)
	
	end sub
	
end namespace
