#include "fbcu.bi"

namespace fbc_tests.expressions.memberderef

namespace syntax
	type UDT
		i as integer
	end type

	dim shared x as UDT = (123)
	dim shared p as UDT ptr = @x
	dim shared pp as UDT ptr ptr = @p

	sub test cdecl( )
		CU_ASSERT( p->i = 123 )
		CU_ASSERT( (*p).i = 123 )
		CU_ASSERT( p[0].i = 123 )

		CU_ASSERT( (*pp)->i = 123 )
		CU_ASSERT( pp[0]->i = 123 )
		CU_ASSERT( (*pp[0]).i = 123 )
		CU_ASSERT( (**pp).i = 123 )
		CU_ASSERT( (*pp)[0].i = 123 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.expressions.memberderef" )
	fbcu.add_test( "syntax", @syntax.test )
end sub

end namespace
