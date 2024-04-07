# include "fbcunit.bi"

SUITE( fbc_tests.structs.scope_type_1 )

	type P1
		a as integer
		b as integer
	end type

	type P2 extends P1
		c as integer
		d as integer
	end type

	TEST( scope1 )

		type P3 extends P1
			c as integer
			d as integer
		end type

		dim x as P2 = (1, 2, 3, 4 )

		CU_ASSERT( sizeof(x) = sizeof(integer) * 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 4 )

		dim y as P3 = (1, 2, 3, 4 )

		CU_ASSERT( sizeof(y) = sizeof(integer) * 4 )
		CU_ASSERT( y.a = 1 )
		CU_ASSERT( y.b = 2 )
		CU_ASSERT( y.c = 3 )
		CU_ASSERT( y.d = 4 )

	END_TEST

	namespace N
		type T1
			a as integer
		end type
	end namespace

	TEST( scope2 )
		scope
			using N
			type T2 extends T1
				b as integer
			end type
			scope
				type T3 extends T2
					c as integer
				end type

				dim x as T3 = (1,2,3)

				CU_ASSERT( sizeof(x) = sizeof(integer) * 3 )
				CU_ASSERT( x.a = 1 )
				CU_ASSERT( x.b = 2 )
				CU_ASSERT( x.c = 3 )

			end scope
		end scope

	END_TEST

	TEST( scope3 )
		scope
			type T1
				b as integer
			end type
			scope
				type T2 extends T1
					c as integer
				end type
				scope
					type T3 extends T2
						a as integer
					end type

					dim x as T3 = (1,2,3)

					CU_ASSERT( sizeof(x) = sizeof(integer) * 3 )
					CU_ASSERT( x.a = 3 )
					CU_ASSERT( x.b = 1 )
					CU_ASSERT( x.c = 2 )

				end scope
			end scope
		end scope

	END_TEST

END_SUITE
