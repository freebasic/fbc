# include "fbcunit.bi"

SUITE( fbc_tests.dim_.shadowing )

	#macro expectbounds( l, u )
		CU_ASSERT( lbound( x ) = l )
		CU_ASSERT( ubound( x ) = u )
	#endmacro

	'' empty dynamic array
	TEST( emptyDynamicArray )
		dim x() as integer
		expectbounds( 0, -1 )

		scope
			expectbounds( 0, -1 )
			dim x() as integer
			expectbounds( 0, -1 )
			redim x(1 to 1)
			expectbounds( 1, 1 )
		end scope
		expectbounds( 0, -1 )

		scope
			expectbounds( 0, -1 )
			dim x(1 to 1) as integer
			expectbounds( 1, 1 )
		end scope
		expectbounds( 0, -1 )

		'' This redims, instead of shadowing:
		scope
			expectbounds( 0, -1 )
			redim x(1 to 1) as integer
			expectbounds( 1, 1 )
		end scope
		expectbounds( 1, 1 )
	END_TEST

	'' filled dynamic array
	TEST( filledDynamicArray )
		redim x(1 to 1) as integer
		expectbounds( 1, 1 )

		scope
			expectbounds( 1, 1 )
			dim x() as integer
			expectbounds( 0, -1 )
			redim x(2 to 2)
			expectbounds( 2, 2 )
		end scope
		expectbounds( 1, 1 )

		scope
			expectbounds( 1, 1 )
			dim x(2 to 2) as integer
			expectbounds( 2, 2 )
		end scope
		expectbounds( 1, 1 )

		'' This redims, instead of shadowing:
		scope
			expectbounds( 1, 1 )
			redim x(2 to 2) as integer
			expectbounds( 2, 2 )
		end scope
		expectbounds( 2, 2 )
	END_TEST

	'' fixed-size array
	TEST( fixedSizeArray )
		dim x(1 to 1) as integer
		expectbounds( 1, 1 )

		scope
			expectbounds( 1, 1 )
			dim x() as integer
			expectbounds( 0, -1 )
			redim x(2 to 2)
			expectbounds( 2, 2 )
		end scope
		expectbounds( 1, 1 )

		scope
			expectbounds( 1, 1 )
			dim x(2 to 2) as integer
			expectbounds( 2, 2 )
		end scope
		expectbounds( 1, 1 )

		scope
			expectbounds( 1, 1 )
			redim x(2 to 2) as integer
			expectbounds( 2, 2 )
		end scope
		expectbounds( 1, 1 )
	END_TEST

	TEST_GROUP( dimImplicitThisField )
		type UDT
			i as integer
			array(0 to 1) as integer

			declare function f1( ) as integer ptr
			declare function f2( ) as integer ptr
		end type

		function UDT.f1( ) as integer ptr
			dim i as integer
			function = @i
		end function

		function UDT.f2( ) as integer ptr
			dim array(0 to 1) as integer
			function = @array(0)
		end function

		'' dim shadowing implicit THIS field
		TEST( default )
			dim x as UDT
			CU_ASSERT( @x.i <> x.f1( ) )
			CU_ASSERT( @x.array(0) <> x.f2( ) )
		END_TEST

	END_TEST_GROUP

END_SUITE
