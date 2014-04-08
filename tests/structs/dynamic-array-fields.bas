# include "fbcu.bi"

namespace fbc_tests.structs.dynamic_array_fields

const FB_MAXARRAYDIMS = 8

type FBARRAYDIM
	elements	as uinteger
	lbound		as integer
	ubound		as integer
end type

type FBARRAY
	data		as any ptr
	ptr		as any ptr
	size		as uinteger
	element_len	as uinteger
	dimensions	as uinteger
	dimTB(0 to FB_MAXARRAYDIMS-1)	as FBARRAYDIM
end type

#macro declareFBARRAY( n )
	type FBARRAY##n
		data		as any ptr
		ptr		as any ptr
		size		as uinteger
		element_len	as uinteger
		dimensions	as uinteger
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

namespace descriptorAllocation
	'' The dynamic array field should only exist in memory in form of the
	'' dynamic array descriptor, which must have room for FB_MAXARRAYDIMS
	'' dimensions.

	type UDT1
		array()		as integer
	end type

	type UDT2
		a		as integer
		array()		as integer
		b		as integer
	end type

	type UDT3
		array1()	as integer
		array2()	as string
		array3()	as UDT2
		x		as UDT2
	end type

	type Descriptor1
		array(*)	as integer
	end type

	type Descriptor2
		array(*, *)	as integer
	end type

	type Descriptor3
		array(*, *, *)	as integer
	end type

	type Descriptor4
		array(*, *, *, *)	as integer
	end type

	type Descriptor5
		array(*, *, *, *, *)	as integer
	end type

	type Descriptor6
		array(*, *, *, *, *, *)	as integer
	end type

	type Descriptor7
		array(*, *, *, *, *, *, *)	as integer
	end type

	type Descriptor8
		array(*, *, *, *, *, *, *, *)	as integer
	end type

	sub test cdecl( )
		CU_ASSERT( sizeof( UDT1 ) = sizeof( FBARRAY ) )
		CU_ASSERT( sizeof( UDT2 ) = sizeof( integer ) + sizeof( FBARRAY ) + sizeof( integer ) )
		CU_ASSERT( sizeof( UDT3 ) = (sizeof( FBARRAY ) * 3) + sizeof( UDT2 ) )

		CU_ASSERT( sizeof( Descriptor1 ) = sizeof( FBARRAY1 ) )
		CU_ASSERT( sizeof( Descriptor2 ) = sizeof( FBARRAY2 ) )
		CU_ASSERT( sizeof( Descriptor3 ) = sizeof( FBARRAY3 ) )
		CU_ASSERT( sizeof( Descriptor4 ) = sizeof( FBARRAY4 ) )
		CU_ASSERT( sizeof( Descriptor5 ) = sizeof( FBARRAY5 ) )
		CU_ASSERT( sizeof( Descriptor6 ) = sizeof( FBARRAY6 ) )
		CU_ASSERT( sizeof( Descriptor7 ) = sizeof( FBARRAY7 ) )
		CU_ASSERT( sizeof( Descriptor8 ) = sizeof( FBARRAY8 ) )
	end sub
end namespace

namespace descriptorInitAndCleanUp
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
		array1() as integer
		array2() as string
		array3() as DtorUdt
	end type

	type UDT2
		array1() as integer
		array2() as string
		array3() as DtorUdt
	end type

	sub test cdecl( )
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
	end sub
end namespace

namespace copyPod
	type UDT1
		array() as integer
	end type

	type UDT2
		array() as integer
	end type

	private sub test cdecl( )
		'' Shouldn't crash etc.
		scope
			dim as UDT1 a, b
			b = a
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
	end sub
end namespace

namespace copyString
	type UDT1
		array() as string
	end type

	type UDT2
		array() as string
	end type

	private sub test cdecl( )
		'' Shouldn't crash etc.
		scope
			dim as UDT1 a, b
			b = a
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
	end sub
end namespace

namespace copyClass
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
		array() as MyClass
	end type

	type UDT2
		array() as MyClass
	end type

	private sub test cdecl( )
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
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/dynamic-array-fields")
	fbcu.add_test( "descriptor allocation", @descriptorAllocation.test )
	fbcu.add_test( "descriptor init & clean up", @descriptorInitAndCleanUp.test )
	fbcu.add_test( "copy pod", @copyPod.test )
	fbcu.add_test( "copy string", @copyString.test )
	fbcu.add_test( "copy class", @copyClass.test )
end sub

end namespace
