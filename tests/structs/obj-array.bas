# include "fbcu.bi"

namespace fbc_tests.structs.array

namespace ctoronly
	dim shared as integer ctors

	type UDT
		i as integer
		declare constructor( )
	end type

	constructor UDT( )
		ctors += 1
	end constructor

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		dim x(1) as UDT
		CU_ASSERT( ctors = 2 )
	end sub
end namespace

namespace dtoronly
	dim shared as integer dtors

	type UDT
		i as integer
		declare destructor( )
	end type

	destructor UDT( )
		dtors += 1
	end destructor

	sub test cdecl( )
		CU_ASSERT( dtors = 0 )
		scope
			dim x(1) as UDT
			CU_ASSERT( dtors = 0 )
		end scope
		CU_ASSERT( dtors = 2 )
	end sub
end namespace

namespace defctorNoParams
	dim shared as integer ctors, dtors

	type UDT
		i as integer
		declare constructor( )
		declare destructor( )
	end type

	constructor UDT( )
		ctors += 1
	end constructor

	destructor UDT( )
		dtors += 1
	end destructor

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		CU_ASSERT( dtors = 0 )
		scope
			dim as UDT u(0 to 1)
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( dtors = 0 )
		end scope
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( dtors = 2 )
	end sub
end namespace

namespace defctorWithParams
	dim shared as integer ctors, dtors

	type UDT
		dim as integer i
		declare constructor( byval i as integer = 0 )
		declare destructor( )
	end type

	constructor UDT( byval i as integer = 0 )
		ctors += 1
	end constructor

	destructor UDT( )
		dtors += 1
	end destructor

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		CU_ASSERT( dtors = 0 )
		scope
			dim as UDT u(0 to 1)
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( dtors = 0 )
		end scope
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( dtors = 2 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/array" )
	fbcu.add_test( "object array, ctor only", @ctoronly.test )
	fbcu.add_test( "object array, dtor only", @dtoronly.test )
	fbcu.add_test( "object array, defctor without params", @defctorNoParams.test )
	fbcu.add_test( "object array, defctor with params", @defctorWithParams.test )
end sub

end namespace
