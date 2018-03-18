#include "fbcunit.bi"

SUITE( fbc_tests.overload_.simple )

	enum RESULT
		RESULT_INT
		RESULT_UINT
		RESULT_SNG
		RESULT_DBL
		RESULT_LNG
		RESULT_INTPTR
		RESULT_UINTPTR
		RESULT_SNGPTR
		RESULT_DBLPTR
		RESULT_LNGPTR
		RESULT_ENUM_A
		RESULT_ENUM_APTR
		RESULT_ENUM_B
		RESULT_ENUM_BPTR
	end enum

	enum enum_a
		enum0, enum1, enum2
	end enum

	enum enum_b
		enum3, enum4, enum5
	end enum

	# macro D_PROC(ArgT_, ReturnValue_)
	function proc overload ( byval arg as ArgT_ ) as RESULT
		function = ReturnValue_
	end function
	# endmacro

	D_PROC(integer,	RESULT_INT)
	D_PROC(uinteger,	RESULT_UINT)
	D_PROC(single,		RESULT_SNG)
	D_PROC(double,		RESULT_DBL)
	D_PROC(longint,	RESULT_LNG)

	D_PROC(integer ptr, RESULT_INTPTR)
	D_PROC(uinteger ptr, RESULT_UINTPTR)
	D_PROC(single ptr, RESULT_SNGPTR)
	D_PROC(double ptr, RESULT_DBLPTR)
	D_PROC(longint ptr, RESULT_LNGPTR)

	D_PROC(enum_a, RESULT_ENUM_A)
	D_PROC(enum_a ptr, RESULT_ENUM_APTR)

	D_PROC(enum_b, RESULT_ENUM_B)
	D_PROC(enum_b ptr, RESULT_ENUM_BPTR)

	# undef D_PROC

	TEST( all )
		dim intvar as integer
		dim uintvar as uinteger
		dim fltvar as single
		dim dblvar as double
		dim lngvar as longint
		dim barvar as ENUM_A
		dim bazvar as ENUM_B

		CU_ASSERT_EQUAL( proc( intvar ), RESULT_INT )
		CU_ASSERT_EQUAL( proc( uintvar ), RESULT_UINT )
		CU_ASSERT_EQUAL( proc( fltvar ), RESULT_SNG )
		CU_ASSERT_EQUAL( proc( dblvar ), RESULT_DBL )
		CU_ASSERT_EQUAL( proc( lngvar ), RESULT_LNG )
		CU_ASSERT_EQUAL( proc( barvar ), RESULT_ENUM_A )
		CU_ASSERT_EQUAL( proc( bazvar ), RESULT_ENUM_B )

		dim intptrvar as integer ptr
		dim uintptrvar as uinteger ptr
		dim fltptrvar as single ptr
		dim dblptrvar as double ptr
		dim lngptrvar as longint ptr
		dim barptrvar as ENUM_A ptr
		dim bazptrvar as ENUM_B ptr

		CU_ASSERT_EQUAL( proc( intptrvar ), RESULT_INTPTR )
		CU_ASSERT_EQUAL( proc( uintptrvar ), RESULT_UINTPTR )
		CU_ASSERT_EQUAL( proc( fltptrvar ), RESULT_SNGPTR )
		CU_ASSERT_EQUAL( proc( dblptrvar ), RESULT_DBLPTR )
		CU_ASSERT_EQUAL( proc( lngptrvar ), RESULT_LNGPTR )
		CU_ASSERT_EQUAL( proc( barptrvar ), RESULT_ENUM_APTR )
		CU_ASSERT_EQUAL( proc( bazptrvar ), RESULT_ENUM_BPTR )

		CU_ASSERT_EQUAL( proc( cdbl( intvar ) ), RESULT_DBL )
		CU_ASSERT_EQUAL( proc( intvar + dblvar ), RESULT_DBL )
	END_TEST

END_SUITE
