#include "fbcunit.bi"

SUITE( fbc_tests.pointers.casting1 )

	const TEST_VAL = &hDeadC0de

	type fluff as udttype

	type funcudt
		field	as integer
	end type

	type functype as function( ) as funcudt ptr

	type udttype
		fparray  as functype ptr
	end type

	type DerivedClass extends object
		as integer abc
	end type

	function realfunc( ) as funcudt ptr
		static as funcudt t = ( TEST_VAL )

		function = @t
	end function

	TEST( all )
		dim as udttype t
		
		dim as any ptr p
		dim as any ptr ptr pptr
		
		p = @t
		pptr = @p
		
		t.fparray = cast( any ptr ptr, callocate( 11 * len( functype ) ) )
		
		t.fparray[10] = @realfunc
		
		CU_ASSERT( cast(udttype ptr, *cast(any ptr ptr, pptr))->fparray[10]()->field = TEST_VAL )

		'' Bug #3269771 regression test (casting derived class pointers to integers)
		dim as DerivedClass ptr pclass
		#ifdef __FB_64BIT__
			dim as ulongint ull = culngint( pclass )
		#else
			dim as ulong ul = culng( pclass )
		#endif
		dim as uinteger ui = cuint( pclass )

		'' free t.fparray otherwise is considered a memory leak
		deallocate t.fparray
	END_TEST

END_SUITE
