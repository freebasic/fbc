#include "fbcu.bi"

namespace fbc_tests.overload_.op_fieldderef

namespace simple
	type UDT
		i as integer
	end type

	dim shared globali as integer = 123

	operator ->(byref l as UDT) as UDT
		l.i += 100
		operator = l
	end operator

	sub test cdecl( )
		dim x as UDT
		x.i = 400
		CU_ASSERT( x->i = 500 )
		CU_ASSERT( (x)->i = 600 )
	end sub
end namespace

namespace withSingleDeref
	type UDT
		pi as integer ptr
	end type

	dim shared globali as integer = 123

	operator ->(byref l as UDT) as UDT
		operator = l
	end operator

	sub test cdecl( )
		dim x as UDT
		x.pi = @globali
		CU_ASSERT( x->*pi = 123 )
	end sub
end namespace

namespace withMultiDeref
	type UDT
		pppi as integer ptr ptr ptr
	end type

	dim shared globali as integer = 123
	dim shared globalpi as integer ptr = @globali
	dim shared globalppi as integer ptr ptr = @globalpi

	operator ->(byref l as UDT) as UDT
		operator = l
	end operator

	sub test cdecl( )
		dim x as UDT
		x.pppi = @globalppi
		CU_ASSERT( x->***pppi = 123 )
	end sub
end namespace

namespace parenthesized
	type T
		elem as integer
	end type

	operator ->(x as T) as T
		operator = x
	end operator

	sub test cdecl()
		dim as T x
		x.elem = 123
		CU_ASSERT( x->elem = 123 )
		CU_ASSERT( (@x)[0]->elem = 123 )
		CU_ASSERT( (x)->elem = 123 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.overload.op-fieldderef" )
	fbcu.add_test( "simple", @simple.test )
	fbcu.add_test( "withSingleDeref", @withSingleDeref.test )
	fbcu.add_test( "withMultiDeref", @withMultiDeref.test )
	fbcu.add_test( "parenthesized", @parenthesized.test )
end sub

end namespace
