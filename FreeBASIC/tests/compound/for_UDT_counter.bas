# include "fbcu.bi"




namespace fbc_tests.compound.for_UDT_counter

	dim shared as integer global_tor = 0
	
	#macro makeTest( __TYPE__ )
		defineTest( __TYPE__ )
		buildTest( __TYPE__ )
	#endmacro
	
	#macro doTest( __TYPE__ )
		testUDTCounter##__TYPE__( )
	#endmacro
	
	#macro defineTest( __TYPE__ )
	
		type foo##__TYPE__
			as double x, y
			declare operator let( byval rhs as __TYPE__ )
			declare operator +=( byval rhs as __TYPE__ )
			declare constructor( )
			declare destructor( )
		end type
		
		operator >=( byref lhs as foo##__TYPE__, byval rhs as __TYPE__ ) as integer
			return lhs.x >= rhs
		end operator
		operator <=( byref lhs as foo##__TYPE__, byval rhs as __TYPE__ ) as integer
			return lhs.x <= rhs
		end operator
		operator foo##__TYPE__.let( byval rhs as __TYPE__ )
			this.x = rhs
		end operator
		operator foo##__TYPE__.+=( byval rhs as __TYPE__ )
			this.x += rhs
		end operator
		
		constructor foo##__TYPE__( )
			this.y = 69
			global_tor += 1
		end constructor
		
		destructor foo##__TYPE__( )
			this.y = 0
			global_tor -= 1
		end destructor
	
	#endmacro
	
	#macro buildTest( __TYPE__ )
	
		sub testUDTCounter##__TYPE__( )
	
		    
			scope
			    
			    dim as foo##__TYPE__ bazz
			    CU_ASSERT( global_tor = 1 )
			    
				dim as double dblStep = .5
				dim as integer c
				dim as foo##__TYPE__ bar
		        CU_ASSERT( global_tor = 2 )
		        
				for bar = 0 to 9 step dblStep + dblStep
					CU_ASSERT( bar.y = 69 )
					CU_ASSERT( c = bar.x )
					c += 1
				next
				
				c = 0
				for bars as foo##__TYPE__ = 0 to 9 step dblStep + dblStep
					CU_ASSERT( bars.y = 69 )
					CU_ASSERT( c = bars.x )
					CU_ASSERT( global_tor = 3 )
					c += 1
				next
				
				CU_ASSERT( global_tor = 2 )
				
				'' top bar's dtor hasn't been called yet?
				CU_ASSERT( bar.y = 69 )
				
			end scope
			
			CU_ASSERT( global_tor = 0 )
			
		
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
