# include "fbcunit.bi"

SUITE( fbc_tests.compound.for_UDT_counter )

	#macro makeTest( __TYPE__ )
		defineTest( __TYPE__ )
		buildTest( __TYPE__ )
	#endmacro
	
	#macro doTest( __TYPE__ )
		testUDTCounter##__TYPE__( )
	#endmacro
	
	#macro defineTest( __TYPE__ )
	
		type foo##__TYPE__
			as __TYPE__ x
			declare constructor( )
			declare constructor( byval rhs as __TYPE__ )
			declare constructor( byref rhs as foo##__TYPE__ )
			
			declare operator let( byval rhs as __TYPE__ )
			declare operator let( byref rhs as foo##__TYPE__ )
			
			declare operator for( )
			declare operator for( byref stp as foo##__TYPE__ )
			declare operator step( )
			declare operator step( byref stp as foo##__TYPE__ )
			declare operator next( byref end_cond as foo##__TYPE__ ) as integer
			declare operator next( byref end_cond as foo##__TYPE__, byref stp as foo##__TYPE__ ) as integer
			
			declare destructor( )
			
		private:
			as integer is_up
			
			declare function test_method( byref end_cond as foo##__TYPE__ ) as integer
		end type
		
		constructor foo##__TYPE__( )
			this.x = 0
		end constructor

		constructor foo##__TYPE__( byval rhs as __TYPE__ )
			this.x = rhs
		end constructor

		constructor foo##__TYPE__( byref rhs as foo##__TYPE__ )
			this.x = rhs.x
		end constructor

		operator foo##__TYPE__.let( byval rhs as __TYPE__ )
			this.x = rhs
		end operator
		
		operator foo##__TYPE__.let( byref rhs as foo##__TYPE__ )
			this.x = rhs.x
		end operator
		
		operator foo##__TYPE__.for( )
			is_up = -1
		end operator

		operator foo##__TYPE__.for( byref stp as foo##__TYPE__ )
			is_up = (stp.x >= 0)
		end operator

		operator foo##__TYPE__.step( )
			x += 1
		end operator

		operator foo##__TYPE__.step( byref stp as foo##__TYPE__ )
			x += stp.x
		end operator

		operator foo##__TYPE__.next( byref end_cond as foo##__TYPE__ ) as integer
			return x <= end_cond.x
		end operator

		operator foo##__TYPE__.next( byref end_cond as foo##__TYPE__, byref stp as foo##__TYPE__ ) as integer
			if( is_up ) then
				return x <= end_cond.x
			else
				return x >= end_cond.x
			end if
		end operator

		destructor foo##__TYPE__( )
		end destructor
	
	#endmacro
	
	#macro buildTest( __TYPE__ )
	
		sub testUDTCounter##__TYPE__( )
	
			scope
				dim as __TYPE__ stp = 1
				dim as __TYPE__ c
				dim as foo##__TYPE__ bar
		        
			    for bar = 0 to 9
					CU_ASSERT_EQUAL( c, bar.x )
					c += 1
				next
				
				c = 0
				for cnt as foo##__TYPE__ = 0 to 9 step stp
					CU_ASSERT_EQUAL( c, cnt.x )
					c += stp
				next

				c = 9
				for cnt as foo##__TYPE__ = 9 to 0 step -stp
					CU_ASSERT_EQUAL( c, cnt.x )
					c -= stp
				next
				
			end scope
			
		
		end sub	
	
	#endmacro
	
	makeTest( byte )
	makeTest( short )
	makeTest( long )
	makeTest( integer )
	makeTest( single )
	makeTest( double )
	makeTest( longint )
    
    TEST( test_byte )
		doTest( byte )
	END_TEST

    TEST( test_short )
		doTest( short )
	END_TEST

    TEST( test_long )
		doTest( long )
	END_TEST

    TEST( test_int )
		doTest( integer )
	END_TEST

    TEST( test_single )
		doTest( single )
	END_TEST

    TEST( test_dbl )
		doTest( double )
	END_TEST

    TEST( test_longint )
		doTest( longint )
	END_TEST

END_SUITE
