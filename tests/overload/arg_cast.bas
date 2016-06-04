# include "fbcu.bi"
	
namespace fbc_tests.overloads.arg_cast
	
	type A
		member as integer
	end type
	
	type B
		declare operator cast as A
		member as integer
	end type

	operator B.cast as A : return type(0) : end operator
	sub f overload (x as integer) : CU_ASSERT(0): end sub
	sub f (x as A) : end sub
	
	sub the_test cdecl ( )
		/'dim x as B
		f x'/
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.overload.arg_cast")
		fbcu.add_test("test_arg_udt_cast", @the_test)
	
	end sub

end namespace
