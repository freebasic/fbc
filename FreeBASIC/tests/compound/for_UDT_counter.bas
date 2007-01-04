# include "fbcu.bi"




namespace fbc_tests.compound.for_UDT_counter

	#macro makeTest( __TYPE__ )
		defineTest( __TYPE__ )
		buildTest( __TYPE__ )
	#endmacro
	
	#macro doTest( __TYPE__ )
		testUDTCounter##__TYPE__( )
	#endmacro
	
	#macro defineTest( __TYPE__ )
	
		type foo##__TYPE__
			as __TYPE__ x, y
			declare operator +=( byref rhs as foo##__TYPE__ )
			declare constructor( )
			declare constructor( byval rhs as __TYPE__ )
			declare constructor( byref rhs as foo##__TYPE__ )
			declare operator let( byval rhs as __TYPE__ )
			declare destructor( )
		end type
		
		operator >=( byref lhs as foo##__TYPE__, byref rhs as foo##__TYPE__ ) as integer
			return lhs.x >= rhs.x
		end operator

		operator <=( byref lhs as foo##__TYPE__, byref rhs as foo##__TYPE__ ) as integer
			return lhs.x <= rhs.x
		end operator

		constructor foo##__TYPE__( )
			this.y = 69
		end constructor
		
		constructor foo##__TYPE__( byval rhs as __TYPE__ )
			this.x = rhs
			this.y = 69
		end constructor

		constructor foo##__TYPE__( byref rhs as foo##__TYPE__ )
			this.x = rhs.x
			this.y = rhs.y
		end constructor

		operator foo##__TYPE__.let( byval rhs as __TYPE__ )
			this.x = rhs
		end operator

		operator foo##__TYPE__.+=( byref rhs as foo##__TYPE__ )
			this.x += rhs.x
		end operator
		
		destructor foo##__TYPE__( )
			this.y = 0
		end destructor
	
	#endmacro
	
	#macro buildTest( __TYPE__ )
	
		sub testUDTCounter##__TYPE__( )
	
		    
			scope
				dim as __TYPE__ stp = 1
				dim as integer c
				dim as foo##__TYPE__ bar
		        
			    for bar = 0 to 9 step stp
					CU_ASSERT_EQUAL( c, bar.x )
					c += 1
				next
				
				c = 0
				for bars as foo##__TYPE__ = 0 to 9 step stp
					CU_ASSERT_EQUAL( bars.y, 69 )
					CU_ASSERT_EQUAL( c, bars.x )
					c += 1
				next
				
				'' top bar's dtor hasn't been called yet?
				CU_ASSERT_EQUAL( bar.y, 69 )
				
			end scope
			
		
		end sub	
	
	#endmacro
	
	makeTest( byte )
	makeTest( short )
	makeTest( integer )
	makeTest( single )
	makeTest( double )
	makeTest( longint )
    
    sub test_byte cdecl( )
		doTest( byte )
	end sub

    sub test_short cdecl( )
		doTest( short )
	end sub

    sub test_int cdecl( )
		doTest( integer )
	end sub

    sub test_single cdecl( )
		doTest( single )
	end sub

    sub test_dbl cdecl( )
		doTest( double )
	end sub

    sub test_long cdecl( )
		doTest( longint )
	end sub


sub ctor () constructor

	fbcu.add_suite("fbc_tests.compound.for_UDT_counter")
	fbcu.add_test("byte", @test_byte)
	fbcu.add_test("short", @test_short)
	fbcu.add_test("integer", @test_int)
	fbcu.add_test("single", @test_single)
	fbcu.add_test("double", @test_dbl)
	fbcu.add_test("longint", @test_long)

end sub

end namespace
