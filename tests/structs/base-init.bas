#include "fbcunit.bi"

SUITE( fbc_tests.structs.base_init )

	'' Implicit base default ctor call
	TEST_GROUP( implicitBaseDefCtor )
		dim shared as integer ctor_count

		type Parent
			as integer i
			declare constructor( )
		end type

		constructor Parent( )
			ctor_count += 1
			this.i = 123
		end constructor

		type Child extends Parent
			declare constructor( )
		end type

		constructor Child( )
		end constructor

		TEST( default )
			dim as Child c
			CU_ASSERT( c.i = 123 )
			CU_ASSERT( ctor_count = 1 )
		END_TEST
	END_TEST_GROUP

	'' BASE() with non-default ctor
	TEST_GROUP( explicitBaseCtor )
		type Parent
			as integer i
			declare constructor( )
			declare constructor( byval as integer )
		end type

		constructor Parent( )
			'' Shouldn't be called
			CU_FAIL( )
		end constructor

		constructor Parent( byval i as integer )
			this.i = 456
		end constructor

		type Child extends Parent
			declare constructor( )
		end type

		constructor Child( )
			base( 123 )
		end constructor

		TEST( default )
			dim as Child c
			CU_ASSERT( c.i = 456 )
		END_TEST
	END_TEST_GROUP

	'' BASE() with default ctor
	TEST_GROUP( explicitBaseDefCtor )
		dim shared as integer ctor_count

		type Parent
			as integer i
			declare constructor( )
		end type

		constructor Parent( )
			ctor_count += 1
			this.i = 456
		end constructor

		type Child extends Parent
			declare constructor( )
		end type

		constructor Child( )
			base( )
		end constructor

		TEST( default )
			dim as Child c
			CU_ASSERT( c.i = 456 )
			CU_ASSERT( ctor_count = 1 )
		END_TEST
	END_TEST_GROUP

	'' BASE() as initializer
	TEST_GROUP( explicitBaseInit )
		type Parent
			as integer a, b, c
		end type

		type Child extends Parent
			declare constructor( )
		end type

		constructor Child( )
			base( 1, 2, 3 )
		end constructor

		TEST( default )
			dim as Child c
			CU_ASSERT( c.a = 1 )
			CU_ASSERT( c.b = 2 )
			CU_ASSERT( c.c = 3 )
		END_TEST
	END_TEST_GROUP

	'' BASE() as partial initializer
	TEST_GROUP( explicitBasePartialInit )
		type Parent
			as integer a, b, c
		end type

		type Child extends Parent
			declare constructor( )
		end type

		constructor Child( )
			base( 123 )
		end constructor

		TEST( default )
			dim as Child c
			CU_ASSERT( c.a = 123 )
			CU_ASSERT( c.b = 0 )
			CU_ASSERT( c.c = 0 )
		END_TEST
	END_TEST_GROUP

	'' BASE() shouldn't overwrite RTTI
	TEST_GROUP( rttiPreserved )
		type Parent extends object
			as integer i
			declare constructor( byval as integer )
		end type

		constructor Parent( byval i as integer )
		end constructor

		type Child extends Parent
			declare constructor( )
			declare constructor( byref as const Child )
		end type

		constructor Child( )
			base( 123 )
		end constructor

		constructor Child( byref rhs as const Child )
			base( 456 )
		end constructor

		TEST( default )
			dim as Child c
			dim as Parent ptr p = @c
			CU_ASSERT( *p is Child )
		END_TEST
	END_TEST_GROUP

	'' POD base UDTs must be cleared
	TEST_GROUP( podBase )
		type Parent
			as integer a
		end type

		type Child extends Parent
			as integer b
			declare constructor( )
		end type

		constructor Child( )
			'' A POD base UDT should be cleared, just like any fields
		end constructor

		TEST( default )
			scope
				'' Try to trash the stack a little
				dim as integer a = 123, b = 456
				CU_ASSERT( a = 123 )
				CU_ASSERT( b = 456 )
			end scope
			scope
				dim as Child c
				CU_ASSERT( c.a = 0 )
				CU_ASSERT( c.b = 0 )
			end scope
		END_TEST
	END_TEST_GROUP

	'' BASE() affects a single ctor only 1
	TEST_GROUP( baseinitIsCtorSpecific1 )
		dim shared as integer defctor_count, intctor_count
		type Parent
			as integer i
			declare constructor( )
			declare constructor( byval as integer )
		end type

		constructor Parent( )
			defctor_count += 1
			this.i = 123
		end constructor

		constructor Parent( byval i as integer )
			intctor_count += 1
			this.i = i
		end constructor

		type Child extends Parent
			declare constructor( )
			declare constructor( byval as integer )
		end type

		constructor Child( )
		end constructor

		constructor Child( byval i as integer )
			base( i )
		end constructor

		TEST( default )
			dim as Child c1
			CU_ASSERT( c1.i = 123 )
			CU_ASSERT( defctor_count = 1 )
			CU_ASSERT( intctor_count = 0 )

			dim as Child c2 = Child( 456 )
			CU_ASSERT( c2.i = 456 )
			CU_ASSERT( defctor_count = 1 )
			CU_ASSERT( intctor_count = 1 )
		END_TEST
	END_TEST_GROUP

	'' BASE() affects a single ctor only 2
	TEST_GROUP( baseinitIsCtorSpecific2 )
		dim shared as integer defctor_count, intctor_count
		type Parent
			as integer i
			declare constructor( )
			declare constructor( byval as integer )
		end type

		constructor Parent( )
			defctor_count += 1
			this.i = 123
		end constructor

		constructor Parent( byval i as integer )
			intctor_count += 1
			this.i = i
		end constructor

		type Child extends Parent
			declare constructor( byval as integer )
			declare constructor( )
		end type

		'' Ctor order swapped
		constructor Child( byval i as integer )
			base( i )
		end constructor

		constructor Child( )
		end constructor

		TEST( default )
			dim as Child c1
			CU_ASSERT( c1.i = 123 )
			CU_ASSERT( defctor_count = 1 )
			CU_ASSERT( intctor_count = 0 )

			dim as Child c2 = Child( 456 )
			CU_ASSERT( c2.i = 456 )
			CU_ASSERT( defctor_count = 1 )
			CU_ASSERT( intctor_count = 1 )
		END_TEST
	END_TEST_GROUP

	'' Simple base field initialization
	TEST_GROUP( simple )
		type TBase
			dim baseField as integer = 1234
			declare constructor( )
			declare constructor( value as integer )
		end type

		constructor Tbase( )
		end constructor

		constructor TBase( value as integer )
			baseField = value
		end constructor

		type TFoo extends TBase
			dim fooField as integer = 5678
			declare constructor( )
			declare constructor( value as integer )
			declare constructor( baseValue as integer, value as integer )
		end type

		constructor TFoo( )
		end constructor

		constructor TFoo( value as integer )
			fooField = value
		end constructor

		constructor TFoo( baseValue as integer, value as integer )
			base( baseValue )
			fooField = value
		end constructor

		TEST( default )
			dim f1 as TFoo
			CU_ASSERT( f1.baseField = 1234 )
			CU_ASSERT( f1.fooField = 5678 )

			dim f2 as TFoo = (-3456)
			CU_ASSERT( f2.baseField = 1234 )
			CU_ASSERT( f2.fooField = -3456 )

			dim f3 as TFoo = TFoo(3333, 4444)
			CU_ASSERT( f3.baseField = 3333 )
			CU_ASSERT( f3.fooField = 4444 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( podBaseComplexDerived )
		'' POD base class, but a complex derived class. The derived class needs
		'' to have def-ctor & copy-ctor implicitly generated. The fact that the
		'' base class doesn't have a def-ctor shouldn't be a problem - it's a
		'' simple POD type that should just be cleared.

		type Parent
			i as integer
		end type

		type Child extends Parent
			s as string
		end type

		TEST( default )
			dim as Child c1
			c1.i = 123
			c1.s = "abc"

			dim as Child c2 = c1
			CU_ASSERT( c2.i = 123 )
			CU_ASSERT( c2.s = "abc" )
		END_TEST
	END_TEST_GROUP

END_SUITE
