#include "fbcunit.bi"

#define NULL 0

SUITE( fbc_tests.structs.dynamic_array_fields )

	type FBARRAYDIM
		elements	as uinteger
		lbound		as integer
		ubound		as integer
	end type

	#macro declareFBARRAY( n )
		type FBARRAY##n
			data		as any ptr
			ptr		as any ptr
			size		as uinteger
			element_len	as uinteger
			dimensions	as uinteger
			flags		as uinteger
			dimTB(0 to (n)-1)	as FBARRAYDIM
		end type
	#endmacro

	declareFBARRAY( 1 )
	declareFBARRAY( 2 )
	declareFBARRAY( 3 )
	declareFBARRAY( 4 )
	declareFBARRAY( 5 )
	declareFBARRAY( 6 )
	declareFBARRAY( 7 )
	declareFBARRAY( 8 )

	TEST_GROUP( descriptorAllocation )
		'' The dynamic array field should only exist in memory in form of the
		'' dynamic array descriptor, which should have the exact size needed for
		'' the amount of dimensions specified in the field declaration.

		type UDT1
			array(any)	as integer
		end type

		type UDT2
			a		as integer
			array(any)	as integer
			b		as integer
		end type

		type UDT3
			array1(any)	as integer
			array2(any)	as string
			array3(any)	as UDT2
			x		as UDT2
		end type

		type Descriptor1
			array(any)	as integer
		end type

		type Descriptor2
			array(any, any)	as integer
		end type

		type Descriptor3
			array(any, any, any)	as integer
		end type

		type Descriptor4
			array(any, any, any, any)	as integer
		end type

		type Descriptor5
			array(any, any, any, any, any)	as integer
		end type

		type Descriptor6
			array(any, any, any, any, any, any)	as integer
		end type

		type Descriptor7
			array(any, any, any, any, any, any, any)	as integer
		end type

		type Descriptor8
			array(any, any, any, any, any, any, any, any)	as integer
		end type

		TEST( default )
			CU_ASSERT( sizeof( UDT1 ) = sizeof( FBARRAY1 ) )
			CU_ASSERT( sizeof( UDT2 ) = sizeof( integer ) + sizeof( FBARRAY1 ) + sizeof( integer ) )
			CU_ASSERT( sizeof( UDT3 ) = (sizeof( FBARRAY1 ) * 3) + sizeof( UDT2 ) )

			CU_ASSERT( sizeof( Descriptor1 ) = sizeof( FBARRAY1 ) )
			CU_ASSERT( sizeof( Descriptor2 ) = sizeof( FBARRAY2 ) )
			CU_ASSERT( sizeof( Descriptor3 ) = sizeof( FBARRAY3 ) )
			CU_ASSERT( sizeof( Descriptor4 ) = sizeof( FBARRAY4 ) )
			CU_ASSERT( sizeof( Descriptor5 ) = sizeof( FBARRAY5 ) )
			CU_ASSERT( sizeof( Descriptor6 ) = sizeof( FBARRAY6 ) )
			CU_ASSERT( sizeof( Descriptor7 ) = sizeof( FBARRAY7 ) )
			CU_ASSERT( sizeof( Descriptor8 ) = sizeof( FBARRAY8 ) )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( descriptorInitAndCleanUp )
		'' The dynamic array field must be constructed & destructed, similar to
		'' dynamic strings, and the parent UDT must be given a ctor/dtor if
		'' it has none.

		dim shared dtorudt_dtors as integer

		type DtorUdt
			i as integer
			declare destructor( )
		end type

		destructor DtorUdt( )
			dtorudt_dtors += 1
		end destructor

		type UDT1
			array1(any) as integer
			array2(any) as string
			array3(any) as DtorUdt
		end type

		type UDT2
			array1(any, any) as integer
			array2(any, any, any) as string
			array3(any, any) as DtorUdt
		end type

		TEST( default )
			scope
				dim x as UDT1

				'' Arrays should be initially empty (unallocated)
				CU_ASSERT( @x.array1(0) = NULL )
				CU_ASSERT( @x.array2(0) = NULL )
				CU_ASSERT( @x.array3(0) = NULL )

				CU_ASSERT( lbound( x.array1 ) = 0 )
				CU_ASSERT( ubound( x.array1 ) = -1 )

				CU_ASSERT( lbound( x.array2 ) = 0 )
				CU_ASSERT( ubound( x.array2 ) = -1 )

				CU_ASSERT( lbound( x.array3 ) = 0 )
				CU_ASSERT( ubound( x.array3 ) = -1 )

				CU_ASSERT( dtorudt_dtors = 0 )
			end scope
			'' And no dtors should be called for the empty arrays
			CU_ASSERT( dtorudt_dtors = 0 )

			scope
				dim x as UDT1
				redim x.array3(0 to 0)
				CU_ASSERT( dtorudt_dtors = 0 )
			end scope
			CU_ASSERT( dtorudt_dtors = 1 )
			dtorudt_dtors = 0

			scope
				dim x as UDT1
				redim x.array3(10 to 20)
				CU_ASSERT( dtorudt_dtors = 0 )
			end scope
			CU_ASSERT( dtorudt_dtors = 11 )
			dtorudt_dtors = 0

			scope
				dim x as UDT2
				redim x.array3(0 to 1, 0 to 0)
				CU_ASSERT( dtorudt_dtors = 0 )
			end scope
			CU_ASSERT( dtorudt_dtors = 2 )
			dtorudt_dtors = 0

			scope
				dim x as UDT2
				redim x.array3(0 to 1, 0 to 1)
				CU_ASSERT( dtorudt_dtors = 0 )
			end scope
			CU_ASSERT( dtorudt_dtors = 4 )
			dtorudt_dtors = 0

			'' Can't really test whether integer/string arrays are freed,
			'' but at least we can test that it doesn't crash when having to
			'' do it...
			scope
				dim x as UDT2
				redim x.array1(1 to 3, 4 to 10)
				redim x.array2(2 to 20, 3 to 3, 4 to 5)
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyPod )
		type UDT1
			array(any) as integer
		end type

		type UDT2
			array(any, any) as integer
		end type

		TEST( default )
			'' Shouldn't crash etc.
			scope
				dim as UDT1 a, b
				b = a
			end scope

			'' Copying empty/unallocated arrays
			scope
				dim as UDT1 a, b
				CU_ASSERT( ubound( a.array, 0 ) = 0 )
				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( ubound( b.array, 0 ) = 0 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				b = a
				CU_ASSERT( ubound( a.array, 0 ) = 0 )
				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( ubound( b.array, 0 ) = 0 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
			end scope

			'' Self-assignment
			scope
				dim x as UDT1
				x = x

				redim x.array(0 to 1)
				x.array(0) = 1
				x.array(1) = 2

				CU_ASSERT( ubound( x.array, 0 ) = 1 )
				CU_ASSERT( lbound( x.array ) = 0 )
				CU_ASSERT( ubound( x.array ) = 1 )
				CU_ASSERT( x.array(0) = 1 )
				CU_ASSERT( x.array(1) = 2 )

				x = x

				CU_ASSERT( ubound( x.array, 0 ) = 1 )
				CU_ASSERT( lbound( x.array ) = 0 )
				CU_ASSERT( ubound( x.array ) = 1 )
				CU_ASSERT( x.array(0) = 1 )
				CU_ASSERT( x.array(1) = 2 )
			end scope

			'' simple
			scope
				dim as UDT1 a, b

				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				redim a.array(0 to 1)
				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = 1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
				a.array(0) = 0
				a.array(1) = 1

				b = a

				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = 1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = 1 )
				CU_ASSERT( a.array(0) = 0 )
				CU_ASSERT( a.array(1) = 1 )
				CU_ASSERT( b.array(0) = 0 )
				CU_ASSERT( b.array(1) = 1 )
			end scope

			'' negative diff
			scope
				dim as UDT1 a, b

				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				redim a.array(10 to 11)
				CU_ASSERT( lbound( a.array ) = 10 )
				CU_ASSERT( ubound( a.array ) = 11 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
				a.array(10) = 10
				a.array(11) = 11

				b = a

				CU_ASSERT( lbound( a.array ) = 10 )
				CU_ASSERT( ubound( a.array ) = 11 )
				CU_ASSERT( lbound( b.array ) = 10 )
				CU_ASSERT( ubound( b.array ) = 11 )
				CU_ASSERT( a.array(10) = 10 )
				CU_ASSERT( a.array(11) = 11 )
				CU_ASSERT( b.array(10) = 10 )
				CU_ASSERT( b.array(11) = 11 )
			end scope

			'' positive diff
			scope
				dim as UDT1 a, b

				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				redim a.array(-11 to -10)
				CU_ASSERT( lbound( a.array ) = -11 )
				CU_ASSERT( ubound( a.array ) = -10 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
				a.array(-11) = -11
				a.array(-10) = -10

				b = a

				CU_ASSERT( lbound( a.array ) = -11 )
				CU_ASSERT( ubound( a.array ) = -10 )
				CU_ASSERT( lbound( b.array ) = -11 )
				CU_ASSERT( ubound( b.array ) = -10 )
				CU_ASSERT( a.array(-11) = -11 )
				CU_ASSERT( a.array(-10) = -10 )
				CU_ASSERT( b.array(-11) = -11 )
				CU_ASSERT( b.array(-10) = -10 )
			end scope

			'' multiple dimensions
			scope
				dim as UDT2 a, b

				CU_ASSERT( ubound( a.array, 0 ) = 0 )
				CU_ASSERT( ubound( b.array, 0 ) = 0 )

				redim a.array(0 to 1, 0 to 1)
				CU_ASSERT( ubound( a.array, 0 ) = 2 )
				CU_ASSERT( lbound( a.array, 1 ) = 0 )
				CU_ASSERT( ubound( a.array, 1 ) = 1 )
				CU_ASSERT( lbound( a.array, 2 ) = 0 )
				CU_ASSERT( ubound( a.array, 2 ) = 1 )
				CU_ASSERT( ubound( b.array, 0 ) = 0 )
				a.array(0, 0) = 1
				a.array(0, 1) = 2
				a.array(1, 0) = 3
				a.array(1, 1) = 4

				b = a

				CU_ASSERT( ubound( a.array, 0 ) = 2 )
				CU_ASSERT( lbound( a.array, 1 ) = 0 )
				CU_ASSERT( ubound( a.array, 1 ) = 1 )
				CU_ASSERT( lbound( a.array, 2 ) = 0 )
				CU_ASSERT( ubound( a.array, 2 ) = 1 )
				CU_ASSERT( a.array(0, 0) = 1 )
				CU_ASSERT( a.array(0, 1) = 2 )
				CU_ASSERT( a.array(1, 0) = 3 )
				CU_ASSERT( a.array(1, 1) = 4 )
				CU_ASSERT( ubound( b.array, 0 ) = 2 )
				CU_ASSERT( lbound( b.array, 1 ) = 0 )
				CU_ASSERT( ubound( b.array, 1 ) = 1 )
				CU_ASSERT( lbound( b.array, 2 ) = 0 )
				CU_ASSERT( ubound( b.array, 2 ) = 1 )
				CU_ASSERT( b.array(0, 0) = 1 )
				CU_ASSERT( b.array(0, 1) = 2 )
				CU_ASSERT( b.array(1, 0) = 3 )
				CU_ASSERT( b.array(1, 1) = 4 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyString )
		type UDT1
			array(any) as string
		end type

		type UDT2
			array(any, any) as string
		end type

		TEST( default )
			'' Shouldn't crash etc.
			scope
				dim as UDT1 a, b
				b = a
			end scope

			'' Self-assignment
			scope
				dim x as UDT1
				x = x

				redim x.array(0 to 1)
				x.array(0) = "1"
				x.array(1) = "2"

				CU_ASSERT( ubound( x.array, 0 ) = 1 )
				CU_ASSERT( lbound( x.array ) = 0 )
				CU_ASSERT( ubound( x.array ) = 1 )
				CU_ASSERT( x.array(0) = "1" )
				CU_ASSERT( x.array(1) = "2" )

				x = x

				CU_ASSERT( ubound( x.array, 0 ) = 1 )
				CU_ASSERT( lbound( x.array ) = 0 )
				CU_ASSERT( ubound( x.array ) = 1 )
				CU_ASSERT( x.array(0) = "1" )
				CU_ASSERT( x.array(1) = "2" )
			end scope

			'' simple
			scope
				dim as UDT1 a, b

				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				redim a.array(0 to 1)
				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = 1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
				a.array(0) = "0"
				a.array(1) = "1"

				b = a

				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = 1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = 1 )
				CU_ASSERT( a.array(0) = "0" )
				CU_ASSERT( a.array(1) = "1" )
				CU_ASSERT( b.array(0) = "0" )
				CU_ASSERT( b.array(1) = "1" )
			end scope

			'' negative diff
			scope
				dim as UDT1 a, b

				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				redim a.array(10 to 11)
				CU_ASSERT( lbound( a.array ) = 10 )
				CU_ASSERT( ubound( a.array ) = 11 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
				a.array(10) = "10"
				a.array(11) = "11"

				b = a

				CU_ASSERT( lbound( a.array ) = 10 )
				CU_ASSERT( ubound( a.array ) = 11 )
				CU_ASSERT( lbound( b.array ) = 10 )
				CU_ASSERT( ubound( b.array ) = 11 )
				CU_ASSERT( a.array(10) = "10" )
				CU_ASSERT( a.array(11) = "11" )
				CU_ASSERT( b.array(10) = "10" )
				CU_ASSERT( b.array(11) = "11" )
			end scope

			'' positive diff
			scope
				dim as UDT1 a, b

				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				redim a.array(-11 to -10)
				CU_ASSERT( lbound( a.array ) = -11 )
				CU_ASSERT( ubound( a.array ) = -10 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
				a.array(-11) = "-11"
				a.array(-10) = "-10"

				b = a

				CU_ASSERT( lbound( a.array ) = -11 )
				CU_ASSERT( ubound( a.array ) = -10 )
				CU_ASSERT( lbound( b.array ) = -11 )
				CU_ASSERT( ubound( b.array ) = -10 )
				CU_ASSERT( a.array(-11) = "-11" )
				CU_ASSERT( a.array(-10) = "-10" )
				CU_ASSERT( b.array(-11) = "-11" )
				CU_ASSERT( b.array(-10) = "-10" )
			end scope

			'' multiple dimensions
			scope
				dim as UDT2 a, b

				CU_ASSERT( ubound( a.array, 0 ) = 0 )
				CU_ASSERT( ubound( b.array, 0 ) = 0 )

				redim a.array(0 to 1, 0 to 1)
				CU_ASSERT( ubound( a.array, 0 ) = 2 )
				CU_ASSERT( lbound( a.array, 1 ) = 0 )
				CU_ASSERT( ubound( a.array, 1 ) = 1 )
				CU_ASSERT( lbound( a.array, 2 ) = 0 )
				CU_ASSERT( ubound( a.array, 2 ) = 1 )
				CU_ASSERT( ubound( b.array, 0 ) = 0 )
				a.array(0, 0) = "1"
				a.array(0, 1) = "2"
				a.array(1, 0) = "3"
				a.array(1, 1) = "4"

				b = a

				CU_ASSERT( ubound( a.array, 0 ) = 2 )
				CU_ASSERT( lbound( a.array, 1 ) = 0 )
				CU_ASSERT( ubound( a.array, 1 ) = 1 )
				CU_ASSERT( lbound( a.array, 2 ) = 0 )
				CU_ASSERT( ubound( a.array, 2 ) = 1 )
				CU_ASSERT( a.array(0, 0) = "1" )
				CU_ASSERT( a.array(0, 1) = "2" )
				CU_ASSERT( a.array(1, 0) = "3" )
				CU_ASSERT( a.array(1, 1) = "4" )
				CU_ASSERT( ubound( b.array, 0 ) = 2 )
				CU_ASSERT( lbound( b.array, 1 ) = 0 )
				CU_ASSERT( ubound( b.array, 1 ) = 1 )
				CU_ASSERT( lbound( b.array, 2 ) = 0 )
				CU_ASSERT( ubound( b.array, 2 ) = 1 )
				CU_ASSERT( b.array(0, 0) = "1" )
				CU_ASSERT( b.array(0, 1) = "2" )
				CU_ASSERT( b.array(1, 0) = "3" )
				CU_ASSERT( b.array(1, 1) = "4" )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyClass )
		dim shared as integer ctors, dtors, lets

		type MyClass
			i as integer
			declare constructor( )
			declare destructor( )
			declare operator let( byref as MyClass )
		end type

		constructor MyClass( )
			ctors += 1
		end constructor

		destructor MyClass( )
			dtors += 1
		end destructor

		operator MyClass.let( byref other as MyClass )
			lets += 1
			this.i = other.i
		end operator

		type UDT1
			array(any) as MyClass
		end type

		type UDT2
			array(any, any) as MyClass
		end type

		TEST( default )
			'' Shouldn't crash etc.
			scope
				dim as UDT1 a, b
				CU_ASSERT( ctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				b = a
			end scope
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			CU_ASSERT( lets = 0 )

			'' Self-assignment
			ctors = 0
			dtors = 0
			lets = 0
			scope
				dim x as UDT1
				CU_ASSERT( ctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				x = x
				CU_ASSERT( ctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )

				redim x.array(0 to 1)
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				x.array(0).i = 1
				x.array(1).i = 2

				CU_ASSERT( ubound( x.array, 0 ) = 1 )
				CU_ASSERT( lbound( x.array ) = 0 )
				CU_ASSERT( ubound( x.array ) = 1 )
				CU_ASSERT( x.array(0).i = 1 )
				CU_ASSERT( x.array(1).i = 2 )

				x = x
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 2 )
				CU_ASSERT( ubound( x.array, 0 ) = 1 )
				CU_ASSERT( lbound( x.array ) = 0 )
				CU_ASSERT( ubound( x.array ) = 1 )
				CU_ASSERT( x.array(0).i = 1 )
				CU_ASSERT( x.array(1).i = 2 )
			end scope
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( dtors = 2 )
			CU_ASSERT( lets = 2 )

			'' simple
			ctors = 0
			dtors = 0
			lets = 0
			scope
				dim as UDT1 a, b
				CU_ASSERT( ctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				redim a.array(0 to 1)
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = 1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
				a.array(0).i = 0
				a.array(1).i = 1

				b = a
				CU_ASSERT( ctors = 4 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 2 )
				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = 1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = 1 )
				CU_ASSERT( a.array(0).i = 0 )
				CU_ASSERT( a.array(1).i = 1 )
				CU_ASSERT( b.array(0).i = 0 )
				CU_ASSERT( b.array(1).i = 1 )
			end scope
			CU_ASSERT( ctors = 4 )
			CU_ASSERT( dtors = 4 )
			CU_ASSERT( lets = 2 )

			'' negative diff
			ctors = 0
			dtors = 0
			lets = 0
			scope
				dim as UDT1 a, b
				CU_ASSERT( ctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				redim a.array(10 to 11)
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				CU_ASSERT( lbound( a.array ) = 10 )
				CU_ASSERT( ubound( a.array ) = 11 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
				a.array(10).i = 10
				a.array(11).i = 11

				b = a
				CU_ASSERT( ctors = 4 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 2 )
				CU_ASSERT( lbound( a.array ) = 10 )
				CU_ASSERT( ubound( a.array ) = 11 )
				CU_ASSERT( lbound( b.array ) = 10 )
				CU_ASSERT( ubound( b.array ) = 11 )
				CU_ASSERT( a.array(10).i = 10 )
				CU_ASSERT( a.array(11).i = 11 )
				CU_ASSERT( b.array(10).i = 10 )
				CU_ASSERT( b.array(11).i = 11 )
			end scope
			CU_ASSERT( ctors = 4 )
			CU_ASSERT( dtors = 4 )
			CU_ASSERT( lets = 2 )

			'' positive diff
			ctors = 0
			dtors = 0
			lets = 0
			scope
				dim as UDT1 a, b
				CU_ASSERT( ctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				CU_ASSERT( lbound( a.array ) = 0 )
				CU_ASSERT( ubound( a.array ) = -1 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )

				redim a.array(-11 to -10)
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				CU_ASSERT( lbound( a.array ) = -11 )
				CU_ASSERT( ubound( a.array ) = -10 )
				CU_ASSERT( lbound( b.array ) = 0 )
				CU_ASSERT( ubound( b.array ) = -1 )
				a.array(-11).i = -11
				a.array(-10).i = -10

				b = a
				CU_ASSERT( ctors = 4 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 2 )
				CU_ASSERT( lbound( a.array ) = -11 )
				CU_ASSERT( ubound( a.array ) = -10 )
				CU_ASSERT( lbound( b.array ) = -11 )
				CU_ASSERT( ubound( b.array ) = -10 )
				CU_ASSERT( a.array(-11).i = -11 )
				CU_ASSERT( a.array(-10).i = -10 )
				CU_ASSERT( b.array(-11).i = -11 )
				CU_ASSERT( b.array(-10).i = -10 )
			end scope
			CU_ASSERT( ctors = 4 )
			CU_ASSERT( dtors = 4 )
			CU_ASSERT( lets = 2 )

			'' multiple dimensions
			ctors = 0
			dtors = 0
			lets = 0
			scope
				dim as UDT2 a, b
				CU_ASSERT( ctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				CU_ASSERT( ubound( a.array, 0 ) = 0 )
				CU_ASSERT( ubound( b.array, 0 ) = 0 )

				redim a.array(0 to 1, 0 to 1)
				CU_ASSERT( ctors = 4 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 0 )
				CU_ASSERT( ubound( a.array, 0 ) = 2 )
				CU_ASSERT( lbound( a.array, 1 ) = 0 )
				CU_ASSERT( ubound( a.array, 1 ) = 1 )
				CU_ASSERT( lbound( a.array, 2 ) = 0 )
				CU_ASSERT( ubound( a.array, 2 ) = 1 )
				CU_ASSERT( ubound( b.array, 0 ) = 0 )
				a.array(0, 0).i = 1
				a.array(0, 1).i = 2
				a.array(1, 0).i = 3
				a.array(1, 1).i = 4

				b = a
				CU_ASSERT( ctors = 8 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( lets = 4 )
				CU_ASSERT( ubound( a.array, 0 ) = 2 )
				CU_ASSERT( lbound( a.array, 1 ) = 0 )
				CU_ASSERT( ubound( a.array, 1 ) = 1 )
				CU_ASSERT( lbound( a.array, 2 ) = 0 )
				CU_ASSERT( ubound( a.array, 2 ) = 1 )
				CU_ASSERT( a.array(0, 0).i = 1 )
				CU_ASSERT( a.array(0, 1).i = 2 )
				CU_ASSERT( a.array(1, 0).i = 3 )
				CU_ASSERT( a.array(1, 1).i = 4 )
				CU_ASSERT( ubound( b.array, 0 ) = 2 )
				CU_ASSERT( lbound( b.array, 1 ) = 0 )
				CU_ASSERT( ubound( b.array, 1 ) = 1 )
				CU_ASSERT( lbound( b.array, 2 ) = 0 )
				CU_ASSERT( ubound( b.array, 2 ) = 1 )
				CU_ASSERT( b.array(0, 0).i = 1 )
				CU_ASSERT( b.array(0, 1).i = 2 )
				CU_ASSERT( b.array(1, 0).i = 3 )
				CU_ASSERT( b.array(1, 1).i = 4 )
			end scope
			CU_ASSERT( ctors = 8 )
			CU_ASSERT( dtors = 8 )
			CU_ASSERT( lets = 4 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( redimMakesDynamic )
		'' REDIM should make a dynamic array even if the bounds are constant,
		'' as for variables.

		type UDT
			redim array(0 to 0) as integer
		end type

		TEST( default )
			'' Should only allocate descriptor for 1 dimension
			CU_ASSERT( sizeof( UDT ) = sizeof( FBARRAY1 ) )

			dim x as UDT
			CU_ASSERT( ubound( x.array, 0 ) = 1 )
			CU_ASSERT( lbound( x.array ) = 0 )
			CU_ASSERT( ubound( x.array ) = 0 )

			redim x.array(1 to 1)
			CU_ASSERT( lbound( x.array ) = 1 )
			CU_ASSERT( ubound( x.array ) = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dimWithNonConstBoundsMakesDynamic )
		'' DIM with non-constant bounds should also make a dynamic array,
		'' as for variables.

		dim shared as integer i = 123

		type UDT
			dim array(i to i) as integer
		end type

		TEST( default )
			'' Should only allocate descriptor for 1 dimension
			CU_ASSERT( sizeof( UDT ) = sizeof( FBARRAY1 ) )

			dim x as UDT
			CU_ASSERT( ubound( x.array, 0 ) = 1 )
			CU_ASSERT( lbound( x.array ) = 123 )
			CU_ASSERT( ubound( x.array ) = 123 )

			redim x.array(1 to 1)
			CU_ASSERT( lbound( x.array ) = 1 )
			CU_ASSERT( ubound( x.array ) = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( initialBounds )
		dim shared as integer a = 10

		type UDT
			'' Testing various bounds expressions
			dim array1(a to a) as integer
			redim array2(20 to 20, 30 to 30) as integer
			array3(iif( a > 5, 1, 2 ) to 3) as integer  '' even one using a temp var!
		end type

		TEST( default )
			CU_ASSERT( sizeof( UDT ) = sizeof( FBARRAY1 ) + sizeof( FBARRAY2 ) + sizeof( FBARRAY1 ) )

			scope
				dim x as UDT

				CU_ASSERT( ubound( x.array1, 0 ) = 1 )
				CU_ASSERT( lbound( x.array1 ) = 10 )
				CU_ASSERT( ubound( x.array1 ) = 10 )
				CU_ASSERT( x.array1(10) = 0 )

				CU_ASSERT( ubound( x.array2, 0 ) = 2 )
				CU_ASSERT( lbound( x.array2, 1 ) = 20 )
				CU_ASSERT( ubound( x.array2, 1 ) = 20 )
				CU_ASSERT( lbound( x.array2, 2 ) = 30 )
				CU_ASSERT( ubound( x.array2, 2 ) = 30 )
				CU_ASSERT( x.array2(20,30) = 0 )

				CU_ASSERT( ubound( x.array3, 0 ) = 1 )
				CU_ASSERT( lbound( x.array3 ) = 1 )
				CU_ASSERT( ubound( x.array3 ) = 3 )
			end scope

			'' Changing the global variable referenced by the field initializers...
			a = 4

			scope
				dim x as UDT

				CU_ASSERT( ubound( x.array1, 0 ) = 1 )
				CU_ASSERT( lbound( x.array1 ) = 4 )
				CU_ASSERT( ubound( x.array1 ) = 4 )
				CU_ASSERT( x.array1(4) = 0 )

				CU_ASSERT( ubound( x.array2, 0 ) = 2 )
				CU_ASSERT( lbound( x.array2, 1 ) = 20 )
				CU_ASSERT( ubound( x.array2, 1 ) = 20 )
				CU_ASSERT( lbound( x.array2, 2 ) = 30 )
				CU_ASSERT( ubound( x.array2, 2 ) = 30 )
				CU_ASSERT( x.array2(20,30) = 0 )

				CU_ASSERT( ubound( x.array3, 0 ) = 1 )
				CU_ASSERT( lbound( x.array3 ) = 2 )
				CU_ASSERT( ubound( x.array3 ) = 3 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( scoping )
		'' When REDIM'ing a field via implicit "this", the field should be
		'' preferred over any global vars.

		dim shared a(any) as integer

		type UDT
			a(any) as integer
			declare sub f1( )
			declare sub f2( )
			declare sub f3( )
			declare sub f4( )
			declare sub f5( )
		end type

		sub UDT.f1( )
			'' should redim this.a, not the global a
			redim a(1 to 1)
		end sub

		sub UDT.f2( )
			'' should redim this.a, not the global a
			redim a(2 to 2) as integer
		end sub

		sub UDT.f3( )
			'' should make a new local array that overrides the field (and the global too)
			dim a(any) as integer
			redim a(0 to 0)
		end sub

		sub UDT.f4( )
			redim a(4 to 4)
			dim a(any) as integer
			redim a(0 to 0)
		end sub

		sub UDT.f5( )
			'' different dtype, should make a new local array
			redim a(0 to 0) as string
		end sub

		TEST( default )
			dim x as UDT
			CU_ASSERT( lbound( a ) = 0 )
			CU_ASSERT( ubound( a ) = -1 )
			CU_ASSERT( lbound( x.a ) = 0 )
			CU_ASSERT( ubound( x.a ) = -1 )
			x.f1( )
			CU_ASSERT( lbound( a ) = 0 )
			CU_ASSERT( ubound( a ) = -1 )
			CU_ASSERT( lbound( x.a ) = 1 )
			CU_ASSERT( ubound( x.a ) = 1 )
			x.f2( )
			CU_ASSERT( lbound( a ) = 0 )
			CU_ASSERT( ubound( a ) = -1 )
			CU_ASSERT( lbound( x.a ) = 2 )
			CU_ASSERT( ubound( x.a ) = 2 )
			x.f3( )
			CU_ASSERT( lbound( a ) = 0 )
			CU_ASSERT( ubound( a ) = -1 )
			CU_ASSERT( lbound( x.a ) = 2 )
			CU_ASSERT( ubound( x.a ) = 2 )
			x.f4( )
			CU_ASSERT( lbound( a ) = 0 )
			CU_ASSERT( ubound( a ) = -1 )
			CU_ASSERT( lbound( x.a ) = 4 )
			CU_ASSERT( ubound( x.a ) = 4 )
			x.f5( )
			CU_ASSERT( lbound( a ) = 0 )
			CU_ASSERT( ubound( a ) = -1 )
			CU_ASSERT( lbound( x.a ) = 4 )
			CU_ASSERT( ubound( x.a ) = 4 )
		END_TEST
	END_TEST_GROUP

END_SUITE
