#include "fbcunit.bi"

SUITE( fbc_tests.structs.derived_param )

	'' -------------------------------------------------------------------------

	'' Parameters derived from POD struct
	TEST_GROUP( noCtorBase )

		type TObject
			dim value as integer
		end type

		type TBase extends TObject
		end type

		type TDerived extends TBase
		end type


		sub passByref( byref b as TBase )
			b.value = 1
		end sub

		sub passPtr( b as TBase ptr )
			b->value = 2
		end sub

		function passByval( byval b as TBase ) as integer
			return b.value + 1
		end function

		TEST( default )
			dim d as TDerived

			passByref( d )
			CU_ASSERT( d.value = 1 )

			passPtr( @d )
			CU_ASSERT( d.value = 2 )

			passPtr( cast( TBase ptr, @d ) )
			CU_ASSERT( d.value = 2 )

			CU_ASSERT( passByval(d) = 3 )
		END_TEST

	END_TEST_GROUP


	'' -------------------------------------------------------------------------

	'' Parameters derived from class
	TEST_GROUP( withCtorBase )

		dim shared ctor_cnt as integer, dtor_cnt as integer 

		type TObject
			declare constructor( )
			declare destructor( )
			dim value as integer = 1234
		end type

		constructor TObject( )
			ctor_cnt += 1
		end constructor

		destructor TObject( )
			dtor_cnt += 1
		end destructor

		type TBase extends TObject
		end type

		type TDerived extends TBase
		end type


		sub passByref( byref b as TBase )
			b.value = 1
		end sub

		sub passPtr( b as TBase ptr )
			b->value = 2
		end sub

		function passByval( byval b as TBase ) as integer
			return b.value + 1
		end function


		TEST( default )
			scope
				dim d as TDerived

				passByref( d )
				CU_ASSERT( d.value = 1 )

				passPtr( cast( TBase ptr, @d ) )
				CU_ASSERT( d.value = 2 )

				'' This will cause the dtor to be called
				CU_ASSERT( passByval(d) = 3 )
			end scope

			'' one for "d", other for test_byval
			CU_ASSERT( ctor_cnt = 2 )
			CU_ASSERT( dtor_cnt = 2 )
		END_TEST

	END_TEST_GROUP

END_SUITE
