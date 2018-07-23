#include "fbcunit.bi"

/' object.method.overload
		tests method overloading for TYPEs
'/

SUITE( fbc_tests.structs.obj_meth_ovld )

	enum e_Param_t
		e_VoidParam
		e_ByteParam
		e_ShortParam
		e_IntegerParam
		e_LongintParam
		e_IntPtrParam
	end enum

	type UDT
		__ as integer
		
		declare function method () as e_Param_t
		declare function method (as byte) as e_Param_t
		declare function method (as short) as e_Param_t
		declare function method (as integer) as e_Param_t
		declare function method (as longint) as e_Param_t
		declare function method (as integer ptr) as e_Param_t
	end type

	function UDT.method () as e_Param_t : return e_VoidParam : end function
	function UDT.method (x as byte) as e_Param_t : return e_ByteParam : end function
	function UDT.method (x as short) as e_Param_t : return e_ShortParam : end function
	function UDT.method (x as integer) as e_Param_t : return e_IntegerParam : end function
	function UDT.method (x as longint) as e_Param_t : return e_LongintParam : end function
	function UDT.method (x as integer ptr) as e_Param_t : return e_IntPtrParam : end function

	TEST( all )
		dim x as UDT
		
		CU_ASSERT( x.method()					= e_VoidParam )
		CU_ASSERT( x.method(cbyte(0))		= e_ByteParam )
		CU_ASSERT( x.method(cshort(0))	= e_ShortParam )
		CU_ASSERT( x.method(cint(0))		= e_IntegerParam )
		CU_ASSERT( x.method(clngint(0))	= e_LongintParam )
		CU_ASSERT( x.method(cptr(integer ptr, 0)) = e_IntPtrParam )

	END_TEST

END_SUITE
