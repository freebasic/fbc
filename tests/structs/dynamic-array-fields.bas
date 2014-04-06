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

	sub test cdecl( )
		CU_ASSERT( sizeof( UDT1 ) = sizeof( FBARRAY ) )
		CU_ASSERT( sizeof( UDT2 ) = sizeof( integer ) + sizeof( FBARRAY ) + sizeof( integer ) )
		CU_ASSERT( sizeof( UDT3 ) = (sizeof( FBARRAY ) * 3) + sizeof( UDT2 ) )
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

	type UDT
		array1() as integer
		array2() as string
		array3() as DtorUdt
	end type

	sub test cdecl( )
		scope
			dim x as UDT

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
			dim x as UDT
			redim x.array3(0 to 0)
			CU_ASSERT( dtorudt_dtors = 0 )
		end scope
		CU_ASSERT( dtorudt_dtors = 1 )
		dtorudt_dtors = 0

		scope
			dim x as UDT
			redim x.array3(10 to 20)
			CU_ASSERT( dtorudt_dtors = 0 )
		end scope
		CU_ASSERT( dtorudt_dtors = 11 )
		dtorudt_dtors = 0

		scope
			dim x as UDT
			redim x.array3(0 to 1, 0 to 0)
			CU_ASSERT( dtorudt_dtors = 0 )
		end scope
		CU_ASSERT( dtorudt_dtors = 2 )
		dtorudt_dtors = 0

		scope
			dim x as UDT
			redim x.array3(0 to 1, 0 to 1)
			CU_ASSERT( dtorudt_dtors = 0 )
		end scope
		CU_ASSERT( dtorudt_dtors = 4 )
		dtorudt_dtors = 0

		'' Can't really test whether integer/string arrays are freed,
		'' but at least we can test that it doesn't crash when having to
		'' do it...
		scope
			dim x as UDT
			redim x.array1(1 to 3, 4 to 10)
			redim x.array2(2 to 20, 3 to 3, 4 to 5)
		end scope
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/dynamic-array-fields")
	fbcu.add_test( "descriptor allocation", @descriptorAllocation.test )
	fbcu.add_test( "descriptor init & clean up", @descriptorInitAndCleanUp.test )
end sub

end namespace
