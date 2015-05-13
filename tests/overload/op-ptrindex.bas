#include "fbcu.bi"

namespace fbc_tests.overload_.op_ptrindex

namespace simple
	type UDT
		array(0 to 3) as integer
		declare operator []( index as integer ) as integer
	end type

	operator UDT.[]( index as integer ) as integer
		operator = this.array(index)
	end operator

	private sub test cdecl( )
		dim x as UDT = ( { 111, 222, 333, 444 } )
		CU_ASSERT( x[0] = 111 )
		CU_ASSERT( x[1] = 222 )
		CU_ASSERT( x[2] = 333 )
		CU_ASSERT( x[3] = 444 )

		CU_ASSERT( (x)[0] = 111 )
		CU_ASSERT( (x)[1] = 222 )
		CU_ASSERT( (x)[2] = 333 )
		CU_ASSERT( (x)[3] = 444 )

		dim px as UDT ptr = @x
		CU_ASSERT( (*px)[0] = 111 )
		CU_ASSERT( (*px)[1] = 222 )
		CU_ASSERT( (*px)[2] = 333 )
		CU_ASSERT( (*px)[3] = 444 )
	end sub
end namespace

namespace byrefResult
	type UDT
		array(0 to 3) as integer
		declare operator []( index as integer ) byref as integer
	end type

	operator UDT.[]( index as integer ) byref as integer
		operator = this.array(index)
	end operator

	private sub test cdecl( )
		dim x as UDT = ( { 111, 222, 333, 444 } )

		CU_ASSERT( x[0] = 111 )
		x[0] = 123
		CU_ASSERT( x[0] = 123 )
		x[2] = 666
		CU_ASSERT( x[0] = 123 )
		CU_ASSERT( x[1] = 222 )
		CU_ASSERT( x[2] = 666 )
		CU_ASSERT( x[3] = 444 )
	end sub
end namespace

namespace multipleOverloads
	type UDT
		i as integer
		declare operator []( index as integer ) as integer
		declare operator []( index as string ) as integer
		declare operator []( index as double ) as integer
	end type

	operator UDT.[]( index as integer ) as integer
		operator = 1
	end operator

	operator UDT.[]( index as string ) as integer
		operator = 2
	end operator

	operator UDT.[]( index as double ) as integer
		operator = 3
	end operator

	private sub test cdecl( )
		dim x as UDT
		CU_ASSERT( x[0] = 1 )
		CU_ASSERT( x["abc"] = 2 )
		CU_ASSERT( x[1.5] = 3 )
	end sub
end namespace

namespace stringResult
	type UDT
		i as integer
		declare operator []( index as integer ) as string
	end type

	operator UDT.[]( index as integer ) as string
		operator = "abc"
	end operator

	private sub test cdecl( )
		dim x as UDT
		CU_ASSERT( x[0] = "abc" )
	end sub
end namespace

namespace multiPtrIndexSyntax
	type UDT
		i as integer
		declare operator [](byval i as integer) as integer ptr
	end type

	operator UDT.[](byval i as integer) as integer ptr
		this.i += i
		operator = @this.i
	end operator

	sub test cdecl( )
		dim x as UDT
		x.i = 100
		CU_ASSERT( x[1] = @x.i )
		CU_ASSERT( x.i = 101 )
		CU_ASSERT( x[1][0] = 102 )
		CU_ASSERT( x.i = 102 )
	end sub
end namespace

namespace ptrIndexFollowedByFieldSyntax
	type UDT
		i as integer
		declare operator [](byval i as integer) byref as UDT
	end type

	operator UDT.[](byval i as integer) byref as UDT
		this.i += i
		operator = this
	end operator

	sub test cdecl( )
		dim x as UDT
		x.i = 100
		CU_ASSERT( @x[1] = @x )
		CU_ASSERT( x.i = 101 )
		CU_ASSERT( x[1].i = 102 )
		CU_ASSERT( x.i = 102 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/overload/op-ptrindex" )
	fbcu.add_test( "simple", @simple.test )
	fbcu.add_test( "returning BYREF", @byrefResult.test )
	fbcu.add_test( "multiple overloads", @multipleOverloads.test )
	fbcu.add_test( "returning strings", @stringResult.test )
	fbcu.add_test( "multiPtrIndexSyntax", @multiPtrIndexSyntax.test )
	fbcu.add_test( "ptrIndexFollowedByFieldSyntax", @ptrIndexFollowedByFieldSyntax.test )
end sub

end namespace
