# include "fbcu.bi"



namespace fbc_tests.pointers.arith
	
	dim shared as integer ptr p1, p2, tb
	
sub pointerDiffTest cdecl ()
	CU_ASSERT_EQUAL( p2 - p1, 1 )
	CU_ASSERT_EQUAL( p1 - p2, -1 )
	CU_ASSERT( sizeof( p2 - p1 ) >= sizeof( p2 ) )
end sub
	 
sub integralAdditionTest cdecl ()
	CU_ASSERT_EQUAL( p1 + 1, @tb[1] )
end sub

sub integralAdditionAssignmentTest cdecl ()
	p1 += 1
	CU_ASSERT_EQUAL( p1, @tb[1] )
end sub

sub integralSubtractionTest cdecl ()
	CU_ASSERT_EQUAL( p2 - 1, @tb[0] )
end sub

sub integralSubtractionAssignmentTest cdecl ()
	p2 -= 1
	CU_ASSERT_EQUAL( p2, @tb[0] )
end sub

private function init cdecl () as long
	tb = allocate(2 * sizeof(integer))
	if (0 = tb) then
		return -1
	end if

	p1 = @tb[0]
	p2 = @tb[1]

	return 0
end function

private function cleanup cdecl () as long
	deallocate(tb)
	return 0
end function

namespace varAddressOffset
	type UDT
		as integer a, b, c
	end type

	#macro check( varaccess, dtype )
		dim as uinteger addrof_x = cuint( @(varaccess) )
		CU_ASSERT(  (@(varaccess))      = cptr( dtype ptr, addrof_x                     ) )
		CU_ASSERT( ((@(varaccess)) + 1) = cptr( dtype ptr, addrof_x + sizeof( dtype ) ) )
		CU_ASSERT( cuint( (@(varaccess))     ) =  addrof_x                      )
		CU_ASSERT( cuint( (@(varaccess)) + 1 ) = (addrof_x + sizeof( dtype )) )
	#endmacro

	private sub checkByvalParam_Byte      ( byval x as byte        ) : check( x, byte        ) : end sub
	private sub checkByvalParam_BytePtr   ( byval x as byte ptr    ) : check( x, byte ptr    ) : end sub
	private sub checkByvalParam_Integer   ( byval x as integer     ) : check( x, integer     ) : end sub
	private sub checkByvalParam_IntegerPtr( byval x as integer ptr ) : check( x, integer ptr ) : end sub
	private sub checkByvalParam_Udt       ( byval x as UDT         ) : check( x, UDT         ) : end sub
	private sub checkByvalParam_UdtPtr    ( byval x as UDT ptr     ) : check( x, UDT ptr     ) : end sub

	private sub checkByrefParam_Byte      ( byref x as byte        ) : check( @x, byte        ptr ) : end sub
	private sub checkByrefParam_BytePtr   ( byref x as byte ptr    ) : check( @x, byte ptr    ptr ) : end sub
	private sub checkByrefParam_Integer   ( byref x as integer     ) : check( @x, integer     ptr ) : end sub
	private sub checkByrefParam_IntegerPtr( byref x as integer ptr ) : check( @x, integer ptr ptr ) : end sub
	private sub checkByrefParam_Udt       ( byref x as UDT         ) : check( @x, UDT         ptr ) : end sub
	private sub checkByrefParam_UdtPtr    ( byref x as UDT ptr     ) : check( @x, UDT ptr     ptr ) : end sub

	sub test cdecl( )
		checkByvalParam_Byte      ( 0 )
		checkByvalParam_BytePtr   ( 0 )
		checkByvalParam_Integer   ( 0 )
		checkByvalParam_IntegerPtr( 0 )
		checkByvalParam_Udt       ( type( 0, 0, 0 ) )
		checkByvalParam_UdtPtr    ( 0 )

		scope : dim x as byte        : checkByrefParam_Byte      ( x ) : end scope
		scope : dim x as byte ptr    : checkByrefParam_BytePtr   ( x ) : end scope
		scope : dim x as integer     : checkByrefParam_Integer   ( x ) : end scope
		scope : dim x as integer ptr : checkByrefParam_IntegerPtr( x ) : end scope
		scope : dim x as UDT         : checkByrefParam_Udt       ( x ) : end scope
		scope : dim x as UDT ptr     : checkByrefParam_UdtPtr    ( x ) : end scope

		#macro testLocal_( dtype )
			scope
				dim x as dtype
				check( x, dtype )
			end scope
		#endmacro

		#macro testLocal( dtype )
			testLocal_( dtype )
			testLocal_( dtype ptr )
			testLocal_( dtype ptr ptr )
		#endmacro

		testLocal( byte     )
		testLocal( ubyte    )
		testLocal( short    )
		testLocal( ushort   )
		testLocal( long     )
		testLocal( ulong    )
		testLocal( longint  )
		testLocal( ulongint )
		testLocal( integer  )
		testLocal( uinteger )
		testLocal( single   )
		testLocal( double   )
		testLocal( string   )
		testLocal( UDT      )

		#undef testLocal_
		#undef testLocal
	end sub
end namespace

private sub ctor () constructor
	fbcu.add_suite("fbc_tests.pointers.arith", @init, @cleanup)
	fbcu.add_test("pointerDiffTest", @pointerDiffTest)
	fbcu.add_test("integralAdditionTest", @integralAdditionTest)
	fbcu.add_test("integralAdditionAssignmentTest", @integralAdditionAssignmentTest)
	fbcu.add_test("integralSubtractionTest", @integralSubtractionTest)
	fbcu.add_test("integralSubtractionAssignmentTest", @integralSubtractionAssignmentTest)
	fbcu.add_test( "varAddressOffset", @varAddressOffset.test )
end sub

end namespace
