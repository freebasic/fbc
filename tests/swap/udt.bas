#include "fbcunit.bi"

SUITE( fbc_tests.swap_.udt_ )

	type udt
		a as integer
		b as short
	end type

	type udt2
		dummy as integer
		udt	as udt
	end type

	TEST( swap_local )
		dim as udt t1, t2

		t1.a = 1
		t1.b = 2
		t2.a = 3
		t2.b = 4

		swap t1, t2

		CU_ASSERT( t1.b = 4 ) 
		CU_ASSERT( t1.a = 3 ) 
		CU_ASSERT( t2.b = 2 ) 
		CU_ASSERT( t2.a = 1 ) 
	END_TEST

	TEST( swap_static_initialized )
		static as udt t1 = (1, 2), t2 = (3, 4)

		swap t1, t2

		CU_ASSERT( t1.b = 4 ) 
		CU_ASSERT( t1.a = 3 ) 
		CU_ASSERT( t2.b = 2 ) 
		CU_ASSERT( t2.a = 1 ) 
	END_TEST

	TEST( swap_local_initialized )
		dim as udt t1 = (1, 2), t2 = (3, 4)

		swap t1, t2

		CU_ASSERT( t1.b = 4 ) 
		CU_ASSERT( t1.a = 3 ) 
		CU_ASSERT( t2.b = 2 ) 
		CU_ASSERT( t2.a = 1 ) 
	END_TEST

	TEST( swap_reference )
		static as udt t1 = (1, 2), t2 = (3, 4)
		dim as udt ptr p1 = @t1, p2 = @t2

		swap *p1, *p2

		CU_ASSERT( t1.b = 4 ) 
		CU_ASSERT( t1.a = 3 ) 
		CU_ASSERT( t2.b = 2 ) 
		CU_ASSERT( t2.a = 1 ) 
	END_TEST

	TEST( swap_reference_to_field )
		static as udt2 t1 = (0, (1, 2)), t2 = (0, (3, 4))
		dim as udt2 ptr p1 = @t1, p2 = @t2

		swap p1->udt, p2->udt

		CU_ASSERT( t1.udt.b = 4 ) 
		CU_ASSERT( t1.udt.a = 3 ) 
		CU_ASSERT( t2.udt.b = 2 ) 
		CU_ASSERT( t2.udt.a = 1 ) 
	END_TEST

	'' SWAP on bitfields
	TEST( Bitfields )
		type T
			as integer x : 1
			as integer y : 2
			as integer z : 3
		end type

		dim as T a, b

		a.x = 1
		a.y = 0
		a.z = 0
		b.x = 0
		b.y = 0
		b.z = 0
		swap a.x, b.x
		CU_ASSERT( a.x = 0 )
		CU_ASSERT( a.y = 0 )
		CU_ASSERT( a.z = 0 )
		CU_ASSERT( b.x = 1 )
		CU_ASSERT( b.y = 0 )
		CU_ASSERT( b.z = 0 )

		a.x = 1
		a.y = 0
		a.z = 0
		b.x = 0
		b.y = 0
		b.z = 0
		swap a.x, b.y
		CU_ASSERT( a.x = 0 )
		CU_ASSERT( a.y = 0 )
		CU_ASSERT( a.z = 0 )
		CU_ASSERT( b.x = 0 )
		CU_ASSERT( b.y = 1 )
		CU_ASSERT( b.z = 0 )

		a.x = 1
		a.y = 0
		a.z = 0
		b.x = 0
		b.y = 0
		b.z = 0
		swap a.x, b.z
		CU_ASSERT( a.x = 0 )
		CU_ASSERT( a.y = 0 )
		CU_ASSERT( a.z = 0 )
		CU_ASSERT( b.x = 0 )
		CU_ASSERT( b.y = 0 )
		CU_ASSERT( b.z = 1 )

		a.x = 1
		a.y = 0
		a.z = 0
		swap a.x, a.y
		CU_ASSERT( a.x = 0 )
		CU_ASSERT( a.y = 1 )
		CU_ASSERT( a.z = 0 )

		a.x = 0
		a.y = 1
		a.z = 0
		swap a.y, a.z
		CU_ASSERT( a.x = 0 )
		CU_ASSERT( a.y = 0 )
		CU_ASSERT( a.z = 1 )
	END_TEST

END_SUITE
