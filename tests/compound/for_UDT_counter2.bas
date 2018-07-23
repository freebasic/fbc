# include "fbcunit.bi"

SUITE( fbc_tests.compound.for_UDT_counter2 )

	type foo
		declare constructor( byval r as zstring ptr )
		
		declare operator for( )
		declare operator for( byref stp as foo )
		declare operator step( )
		declare operator step( byref stp as foo )
		declare operator next( byref end_cond as foo ) as integer
		declare operator next( byref end_cond as foo, byref stp as foo ) as integer
		
		declare operator cast( ) as string
		
	private:	
		value as string
		is_up as integer
	end type

	constructor foo( byval r as zstring ptr )
		value = *r
	end constructor

	operator foo.for( )
		is_up = -1
	end operator

	operator foo.for( byref stp as foo )
		is_up = (stp.value = "up")
	end operator

	operator foo.step( )
		value[0] += 1
	end operator

	operator foo.step( byref stp as foo )
		
		if( is_up ) then
			value[0] += 1
		else
			value[0] -= 1
		end if
		
	end operator

	operator foo.next( byref end_cond as foo ) as integer
		operator = value <= end_cond.value
	end operator

	operator foo.next( byref end_cond as foo, byref stp as foo ) as integer
		
		if( is_up ) then
			operator = value <= end_cond.value
		else
			operator = value >= end_cond.value
		end if
		
	end operator

	operator foo.cast( ) as string
		operator = value
	end operator

	TEST( a2z )
		dim as integer cnt = asc( "a" )
		for i as foo = "a" to "z" step "up"
			CU_ASSERT_EQUAL( asc( i ), cnt )
			cnt += 1
		next
	END_TEST

	TEST( z2a )
		dim as integer cnt = asc( "z" )
		for i as foo = "z" to "a" step "down"
			CU_ASSERT_EQUAL( asc( i ), cnt )
			cnt -= 1
		next
	END_TEST

END_SUITE
