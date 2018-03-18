#include "fbcunit.bi"

SUITE( fbc_tests.structs.byval_copy )

	TEST_GROUP( passingByvalDoesntCallLet1 )
		dim shared as integer dtors, lets

		type UDT
			i as integer
			declare destructor( )
			declare operator let( byref rhs as UDT )
		end type

		destructor UDT( )
			dtors += 1
		end destructor

		operator UDT.let( byref rhs as UDT )
			lets += 1
		end operator

		function f( byval x as UDT ) as integer
			CU_ASSERT( x.i = 123 )
			function = x.i
		end function

		TEST( default )
			'' UDT param copy-constructed from variable arg, should not call
			'' the Let overload, since it's copy-construction and the lhs
			'' isn't initialized yet.
			scope
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				dim x as UDT
				x.i = 123
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				CU_ASSERT( f( x ) = 123 )
				CU_ASSERT( dtors = 1 )
				CU_ASSERT( lets = 0 )
			end scope
			CU_ASSERT( dtors = 2 )
			CU_ASSERT( lets = 0 )
			dtors = 0
			lets = 0

			scope
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				CU_ASSERT( f( type( 123 ) ) = 123 )
				CU_ASSERT( dtors = 1 )
				CU_ASSERT( lets = 0 )
			end scope
			CU_ASSERT( dtors = 1 )
			CU_ASSERT( lets = 0 )
			dtors = 0
			lets = 0
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( passingByvalDoesntCallLet2 )
		dim shared as integer intctors, dtors, lets

		type UDT
			i as integer
			declare constructor( byval i as integer )
			declare destructor( )
			declare operator let( byref rhs as UDT )
		end type

		constructor UDT( byval i as integer )
			intctors += 1
			this.i = i
		end constructor

		destructor UDT( )
			dtors += 1
		end destructor

		operator UDT.let( byref rhs as UDT )
			lets += 1
		end operator

		function f( byval x as UDT ) as integer
			CU_ASSERT( x.i = 123 )
			function = x.i
		end function

		TEST( default )
			'' UDT param copy-constructed from variable arg
			scope
				CU_ASSERT( intctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				dim x as UDT = UDT( 123 )
				CU_ASSERT( intctors = 1 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				CU_ASSERT( f( x ) = 123 )
				CU_ASSERT( intctors = 1 )
				CU_ASSERT( dtors = 1 )
				CU_ASSERT( lets = 0 )
			end scope
			CU_ASSERT( intctors = 1 )
			CU_ASSERT( dtors = 2 )
			CU_ASSERT( lets = 0 )
			intctors = 0
			dtors = 0
			lets = 0

			'' UDT param constructed from TYPEINI/CALLCTOR
			scope
				CU_ASSERT( intctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				CU_ASSERT( f( type( 123 ) ) = 123 )
				CU_ASSERT( intctors = 1 )
				CU_ASSERT( dtors = 1 )
				CU_ASSERT( lets = 0 )
			end scope
			CU_ASSERT( intctors = 1 )
			CU_ASSERT( dtors = 1 )
			CU_ASSERT( lets = 0 )
			intctors = 0
			dtors = 0
			lets = 0

			'' UDT param constructed from TYPEINI/CALLCTOR
			scope
				CU_ASSERT( intctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				CU_ASSERT( f( UDT( 123 ) ) = 123 )
				CU_ASSERT( intctors = 1 )
				CU_ASSERT( dtors = 1 )
				CU_ASSERT( lets = 0 )
			end scope
			CU_ASSERT( intctors = 1 )
			CU_ASSERT( dtors = 1 )
			CU_ASSERT( lets = 0 )
			intctors = 0
			dtors = 0
			lets = 0

			'' UDT param implicitly constructed from integer arg
			scope
				CU_ASSERT( intctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				CU_ASSERT( f( 123 ) = 123 )
				CU_ASSERT( intctors = 1 )
				CU_ASSERT( dtors = 1 )
				CU_ASSERT( lets = 0 )
			end scope
			CU_ASSERT( intctors = 1 )
			CU_ASSERT( dtors = 1 )
			CU_ASSERT( lets = 0 )
			intctors = 0
			dtors = 0
			lets = 0
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( returnByvalDoesntCallLet )
		dim shared as integer lets

		type UDT
			i as integer
			declare operator let( byref as const UDT )
		end type

		operator UDT.let( byref rhs as const UDT )
			lets += 1
		end operator

		function f( ) as UDT
			dim x as UDT
			x.i = 123
			CU_ASSERT( lets = 0 )

			'' This RETURN is a copy-construction, not an assignment,
			'' so the LET overload shouldn't be called.
			return x
		end function

		TEST( default )
			CU_ASSERT( lets = 0 )
			CU_ASSERT( f( ).i = 123 )
			CU_ASSERT( lets = 0 )
		END_TEST
	END_TEST_GROUP

END_SUITE
