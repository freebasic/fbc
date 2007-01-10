# include "fbcu.bi"

namespace fbc_tests.compound.for_UDT_counter2

type foo
	declare constructor( byval r as zstring ptr )
	
	declare operator for( byref stp as foo )
	declare operator step( byref stp as foo )
	declare operator next( byref end_cond as foo ) as integer
	
	declare operator cast( ) as string
	
private:	
	value as string
	is_up as integer
end type

constructor foo( byval r as zstring ptr )
	value = *r
end constructor

operator foo.for( byref stp as foo )

	if( @stp = NULL ) then
		is_up = -1
	else
		is_up = (stp.value = "up")
	end if
	
end operator

operator foo.step( byref stp as foo )
	
	if( is_up ) then
		value[0] += 1
	else
		value[0] -= 1
	end if
	
end operator

operator foo.next( byref end_cond as foo ) as integer
	
	if( is_up ) then
		operator = value <= end_cond.value
	else
		operator = value >= end_cond.value
	end if
	
end operator

operator foo.cast( ) as string
	operator = value
end operator

sub test_a2z cdecl
	dim as integer cnt = asc( "a" )
	for i as foo = "a" to "z" step "up"
		CU_ASSERT_EQUAL( asc( i ), cnt )
		cnt += 1
	next
end sub	

sub test_z2a cdecl
	dim as integer cnt = asc( "z" )
	for i as foo = "z" to "a" step "down"
		CU_ASSERT_EQUAL( asc( i ), cnt )
		cnt -= 1
	next
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.compound.for_UDT_counter2")
	fbcu.add_test("byte", @test_a2z)
	fbcu.add_test("short", @test_z2a)

end sub

end namespace
	