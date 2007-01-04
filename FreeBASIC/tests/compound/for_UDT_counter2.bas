# include "fbcu.bi"

namespace fbc_tests.compound.for_UDT_counter2

type foo
	declare constructor( byval r as zstring ptr )
	declare constructor( byval r as integer )
	declare operator +=( byref r as foo )
	declare operator cast( ) as string
	
	value as string
end type

constructor foo( byval r as zstring ptr )
	value = *r
end constructor

constructor foo( byval r as integer )
	value = chr( r )
end constructor

operator foo.+=( byref r as foo )
	select case r.value
	case "up"
		value[0] += 1
	case "down"
		value[0] -= 1
	end select
end operator

operator foo.cast( ) as string
	operator = value
end operator

operator <= ( byref l as foo, byref r as foo ) as integer
	select case l.value
	case "up"
		operator = 0
	case "down"
		operator = -1
	case else
		operator = l.value <= r.value
	end select
end operator

operator >= ( byref l as foo, byref r as foo ) as integer
	select case l.value
	case "up"
		operator = -1
	case "down"
		operator = 0
	case else
		operator = l.value >= r.value
	end select
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
	