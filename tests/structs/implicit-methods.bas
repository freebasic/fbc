#include "fbcunit.bi"

SUITE( fbc_tests.structs.implicit_methods )

	TEST_GROUP( copyCtorUdt )
		dim shared as integer ctors, copyctors, lets

		type Nested
			i as integer
			declare constructor( )
			declare constructor( byref rhs as const Nested )
			declare operator let( byref rhs as const Nested )
		end type

		constructor Nested( )
			ctors += 1
		end constructor

		constructor Nested( byref rhs as const Nested )
			copyctors += 1
		end constructor

		operator Nested.let( byref rhs as const Nested )
			this.i = rhs.i
			lets += 1
		end operator

		type UDT
			myfield as Nested
		end type

		TEST( default )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 0 )

			dim x1 as UDT
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 0 )

			dim x2 as UDT = x1
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyCtorConstUdt )
		dim shared as integer ctors, copyctors, lets

		type Nested
			i as integer
			declare constructor( )
			declare constructor( byref rhs as const Nested )
			declare operator let( byref rhs as const Nested )
		end type

		constructor Nested( )
			ctors += 1
		end constructor

		constructor Nested( byref rhs as const Nested )
			copyctors += 1
		end constructor

		operator Nested.let( byref rhs as const Nested )
			this.i = rhs.i
			lets += 1
		end operator

		type UDT
			myfield as Nested
		end type

		TEST( default )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 0 )

			dim x1 as const UDT = UDT( )
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 0 )

			dim x2 as UDT = x1
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyCtorString )
		type UDT
			s as string
		end type

		TEST( default )
			dim x1 as UDT
			x1.s = "abc"

			dim x2 as UDT = x1
			CU_ASSERT( x2.s = "abc" )

			CU_ASSERT( strptr( x1.s ) <> strptr( x2.s ) )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyCtorConstString )
		type UDT
			s as string
			declare constructor( byref as string )
		end type

		constructor UDT( byref s as string )
			this.s = s
		end constructor

		TEST( default )
			dim x1 as const UDT = UDT( "abc" )
			CU_ASSERT( x1.s = "abc" )

			dim x2 as UDT = x1
			CU_ASSERT( x2.s = "abc" )

			CU_ASSERT( strptr( x1.s ) <> strptr( x2.s ) )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyLetUdt )
		dim shared as integer ctors, copyctors, lets

		type Nested
			i as integer
			declare constructor( )
			declare constructor( byref rhs as const Nested )
			declare operator let( byref rhs as const Nested )
		end type

		constructor Nested( )
			ctors += 1
		end constructor

		constructor Nested( byref rhs as const Nested )
			copyctors += 1
		end constructor

		operator Nested.let( byref rhs as const Nested )
			this.i = rhs.i
			lets += 1
		end operator

		type UDT
			myfield as Nested
		end type

		TEST( default )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 0 )

			dim as UDT x1, x2
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 0 )

			x2 = x1
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyLetConstUdt )
		dim shared as integer ctors, copyctors, lets

		type Nested
			i as integer
			declare constructor( )
			declare constructor( byref rhs as const Nested )
			declare operator let( byref rhs as const Nested )
		end type

		constructor Nested( )
			ctors += 1
		end constructor

		constructor Nested( byref rhs as const Nested )
			copyctors += 1
		end constructor

		operator Nested.let( byref rhs as const Nested )
			this.i = rhs.i
			lets += 1
		end operator

		type UDT
			myfield as Nested
		end type

		TEST( default )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 0 )

			dim as const UDT x1 = UDT( )
			dim as UDT x2
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 0 )

			x2 = x1
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( copyctors = 0 )
			CU_ASSERT( lets = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyLetString )
		type UDT
			s as string
		end type

		TEST( default )
			dim as UDT x1, x2
			x1.s = "abc"

			x2 = x1
			CU_ASSERT( x2.s = "abc" )

			CU_ASSERT( strptr( x1.s ) <> strptr( x2.s ) )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyLetConstString )
		type UDT
			s as string
			declare constructor( byref as string )
		end type

		constructor UDT( byref s as string )
			this.s = s
		end constructor

		TEST( default )
			dim x1 as const UDT = UDT( "abc" )
			CU_ASSERT( x1.s = "abc" )

			dim x2 as UDT = UDT( "foo" )
			CU_ASSERT( x2.s = "foo" )

			x2 = x1
			CU_ASSERT( x2.s = "abc" )

			CU_ASSERT( strptr( x1.s ) <> strptr( x2.s ) )
		END_TEST
	END_TEST_GROUP

	''
	'' We have to detect copy-constructors or copy-LET-overloads even if their
	'' parameter if a forward reference to the UDT, otherwise we'd add the implicit
	'' copyctor/copylet despite the user-defined ones already being there, and then
	'' we'd end up with duplicate definitions...
	''
	TEST_GROUP( copyCtorFwdref1 )
		dim shared as integer copyctors

		type UDT as UDT_

		type UDT_
			i as integer
			declare constructor( )
			declare constructor( byref as UDT )
		end type

		constructor UDT_( )
		end constructor

		TEST( default )
			dim as UDT_ a
			CU_ASSERT( copyctors = 0 )

			dim as UDT_ b = a
			CU_ASSERT( copyctors = 1 )
		END_TEST

		constructor UDT_( byref rhs as UDT )
			copyctors += 1
		end constructor
	END_TEST_GROUP

	TEST_GROUP( copyCtorFwdref2 )
		dim shared as integer copyctors

		type UDT as UDT_

		type UDT_
			i as integer
			declare constructor( )
			declare constructor( byref as UDT )
		end type

		constructor UDT_( )
		end constructor

		constructor UDT_( byref rhs as UDT )
			copyctors += 1
		end constructor

		TEST( default )
			dim as UDT_ a
			CU_ASSERT( copyctors = 0 )

			dim as UDT_ b = a
			CU_ASSERT( copyctors = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyCtorConstFwdref1 )
		dim shared as integer copyctors

		type UDT as UDT_

		type UDT_
			i as integer
			declare constructor( )
			declare constructor( byref as const UDT )
		end type

		constructor UDT_( )
		end constructor

		TEST( default )
			scope
				dim as UDT_ a
				CU_ASSERT( copyctors = 0 )

				dim as UDT_ b = a
				CU_ASSERT( copyctors = 1 )
			end scope
			copyctors = 0

			scope
				dim as const UDT_ a = UDT_( )
				CU_ASSERT( copyctors = 0 )

				dim as UDT_ b = a
				CU_ASSERT( copyctors = 1 )
			end scope
		END_TEST

		constructor UDT_( byref rhs as const UDT )
			copyctors += 1
		end constructor
	END_TEST_GROUP

	TEST_GROUP( copyCtorConstFwdref2 )
		dim shared as integer copyctors

		type UDT as UDT_

		type UDT_
			i as integer
			declare constructor( )
			declare constructor( byref as const UDT )
		end type

		constructor UDT_( )
		end constructor

		constructor UDT_( byref rhs as const UDT )
			copyctors += 1
		end constructor

		TEST( default )
			scope
				dim as UDT_ a
				CU_ASSERT( copyctors = 0 )

				dim as UDT_ b = a
				CU_ASSERT( copyctors = 1 )
			end scope
			copyctors = 0

			scope
				dim as const UDT_ a = UDT_( )
				CU_ASSERT( copyctors = 0 )

				dim as UDT_ b = a
				CU_ASSERT( copyctors = 1 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyLetFwdref1 )
		dim shared as integer copylets

		type UDT as UDT_

		type UDT_
			i as integer
			declare operator let( byref as UDT )
		end type

		TEST( default )
			dim as UDT_ a, b
			CU_ASSERT( copylets = 0 )

			b = a
			CU_ASSERT( copylets = 1 )
		END_TEST

		operator UDT_.let( byref rhs as UDT )
			copylets += 1
		end operator
	END_TEST_GROUP

	TEST_GROUP( copyLetFwdref2 )
		dim shared as integer copylets

		type UDT as UDT_

		type UDT_
			i as integer
			declare operator let( byref as UDT )
		end type

		operator UDT_.let( byref rhs as UDT )
			copylets += 1
		end operator

		TEST( default )
			dim as UDT_ a, b
			CU_ASSERT( copylets = 0 )

			b = a
			CU_ASSERT( copylets = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyLetConstFwdref1 )
		dim shared as integer copylets

		type UDT as UDT_

		type UDT_
			i as integer
			declare operator let( byref as const UDT )
		end type

		TEST( default )
			scope
				dim as UDT_ a, b
				CU_ASSERT( copylets = 0 )

				b = a
				CU_ASSERT( copylets = 1 )
			end scope
			copylets = 0

			scope
				dim a as const UDT_ = ( 123 )
				dim b as UDT_
				CU_ASSERT( copylets = 0 )

				b = a
				CU_ASSERT( copylets = 1 )
			end scope
		END_TEST

		operator UDT_.let( byref rhs as const UDT )
			copylets += 1
		end operator
	END_TEST_GROUP

	TEST_GROUP( copyLetConstFwdref2 )
		dim shared as integer copylets

		type UDT as UDT_

		type UDT_
			i as integer
			declare operator let( byref as const UDT )
		end type

		operator UDT_.let( byref rhs as const UDT )
			copylets += 1
		end operator

		TEST( default )
			scope
				dim as UDT_ a, b
				CU_ASSERT( copylets = 0 )

				b = a
				CU_ASSERT( copylets = 1 )
			end scope
			copylets = 0

			scope
				dim a as const UDT_ = ( 123 )
				dim b as UDT_
				CU_ASSERT( copylets = 0 )

				b = a
				CU_ASSERT( copylets = 1 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( virtualWithByvalSelfResult )
		'' An UDT with a virtual method that returns the UDT itself byval.
		''
		'' fbc must be careful to declare implicit members, calculate the UDT
		'' return type, and implement implicit members in the right order,
		'' otherwise some code (such as the function pointers for vtable slots)
		'' may try to use the UDT return type while it's not known yet.

		type UDT extends object
			i as integer = 123
			declare virtual function f() as UDT
		end type

		function UDT.f() as UDT
			function = type()
		end function

		TEST( default )
			dim as UDT a, b
			CU_ASSERT( a.i = 123 )
			CU_ASSERT( b.i = 123 )

			a.i = 0
			b.i = 0
			CU_ASSERT( a.i = 0 )
			CU_ASSERT( b.i = 0 )

			b = a.f()
			CU_ASSERT( a.i = 0 )
			CU_ASSERT( b.i = 123 )

			a.i = 0
			b.i = 0
			CU_ASSERT( a.i = 0 )
			CU_ASSERT( b.i = 0 )

			a = a.f()
			CU_ASSERT( a.i = 123 )
			CU_ASSERT( b.i = 0 )
		END_TEST
	END_TEST_GROUP

END_SUITE
