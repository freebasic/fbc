#include "fbcunit.bi"

SUITE( fbc_tests.overload_.pascal_ )

	TEST_GROUP( procedures )
		type UDT
			as integer i, j
		end type

		sub f1cdecl cdecl( byval i as integer, byval x as UDT )
		end sub

		sub f1pascal pascal( byval i as integer, byval x as UDT )
		end sub

		function f2cdecl cdecl( byval a as integer, byval b as integer ) as integer
			function = a
		end function

		function f2pascal pascal( byval a as integer, byval b as integer ) as integer
			function = a
		end function

		sub f3cdecl cdecl( byref a as string, c() as string )
		end sub

		sub f3pascal pascal( byref a as string, c() as string )
		end sub

		function f4 cdecl overload( byval x as UDT, byval i as integer ) as string
			function = "cdecl( UDT, integer )"
		end function

		function f4 pascal overload( byval i as integer, byval x as UDT ) as string
			function = "pascal( integer, UDT )"
		end function

		TEST( default )
			'' By using anonymous type()s, this ensures that the argument
			'' list parser cycles the parameters in the correct order.
			'' (if it didn't, the context type for the type() would be
			'' integer instead of UDT, which wouldn't allow two expressions)
			f1cdecl( 1, type( 2, 3 ) )
			f1pascal( 1, type( 2, 3 ) )

			'' Similarly, this would at least trigger a type mismatch
			'' since an integer can't be passed to an UDT.
			f1cdecl( 1, type( 2 ) )
			f1pascal( 1, type( 2 ) )

			CU_ASSERT( f2cdecl( 1, 2 ) = 1 )
			CU_ASSERT( f2pascal( 1, 2 ) = 1 )

			'' Another test case, using a bydesc array argument - that's
			'' another case where the argument list parser needs to check
			'' the parameter (to see whether BYDESC is allowed).
			dim sarray(0) as string
			f3cdecl( "", sarray() )
			f3pascal( "", sarray() )

			'' This checks that the overloading checks don't walk the
			'' parameter list in the wrong order for PASCAL procs
			CU_ASSERT( f4( type<UDT>( 2, 3 ), 1 ) = "cdecl( UDT, integer )" )
			CU_ASSERT( f4( 1, type<UDT>( 2, 3 ) ) = "pascal( integer, UDT )" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( constructors )
		'' This tests PASCAL constructors, to ensure that overloading checks
		'' and the internal hacks (astPatchCtorCall() etc.) that replace the
		'' THIS argument when needed work correctly when the argument order
		'' is reversed.

		type UDT
			i as integer
			declare constructor pascal( )
			declare constructor pascal( byval i as integer )
			declare constructor pascal( byref rhs as UDT )
		end type

		constructor UDT pascal( )
			'' Access THIS is all ctors, to ensure it's valid
			'' (testing the internal THIS replacement hacks)
			this.i = 123
		end constructor

		constructor UDT pascal( byval i as integer )
			this.i = i
		end constructor

		constructor UDT pascal( byref rhs as UDT )
			this.i = rhs.i
		end constructor

		function f1( byval x as UDT ) as integer
			function = x.i
		end function

		TEST( default )
			dim x1 as UDT
			dim x2 as UDT = UDT( )
			dim x3 as UDT = UDT( 456 )
			dim x4 as UDT = UDT( x1 )

			CU_ASSERT( x1.i = 123 )
			CU_ASSERT( x2.i = 123 )
			CU_ASSERT( x3.i = 456 )
			CU_ASSERT( x4.i = 123 )

			CU_ASSERT( f1( x1 ) = 123 )
			CU_ASSERT( f1( x3 ) = 456 )
			CU_ASSERT( f1( type( 789 ) ) = 789 )

			CU_ASSERT( (type<UDT>( x1 )).i = 123 )
			CU_ASSERT( (type<UDT>( 789 )).i = 789 )
		END_TEST
	END_TEST_GROUP

END_SUITE
