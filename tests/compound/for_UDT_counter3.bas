# include "fbcunit.bi"

SUITE( fbc_tests.compound.for_UDT_counter3 )

	static shared as integer dtor_cnt = 0

	type foo
		declare constructor( v as integer )
		declare destructor( )
		declare operator for( )
		declare operator for( byref stp as foo )
		declare operator step( )
		declare operator step( byref stp as foo )
		declare operator next( byref end_cond as foo ) as integer
		declare operator next( byref end_cond as foo, byref stp as foo ) as integer
	private:	
		value as integer
		is_up as integer
	end type

	constructor foo( v as integer )
		value = v
	end constructor

	operator foo.for( )
		is_up = -1
	end operator

	operator foo.for( byref stp as foo )
		is_up = (stp.value >= 0)
	end operator

	destructor foo( )
		dtor_cnt += 1
	end destructor

	operator foo.step( )
		value += 1
	end operator

	operator foo.step( byref stp as foo )
		value += stp.value
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

	TEST( test_temp )
		do
			do
				'' this should create 3 temporaries
				for i as foo = 1 to 2 step 1
					exit do, do
				next
			loop
		loop
		
		CU_ASSERT_EQUAL( dtor_cnt, 3 )
	END_TEST

END_SUITE
