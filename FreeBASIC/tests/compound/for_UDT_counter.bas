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
			    ASSERT( global_tor = 1 )
			    
				dim as double dblStep = .5
				dim as integer c
				dim as foo##__TYPE__ bar
		        ASSERT( global_tor = 2 )
		        
				for bar = 0 to 9 step dblStep + dblStep
					ASSERT( bar.y = 69 )
					ASSERT( c = bar.x )
					c += 1
				next
				
				c = 0
				for bars as foo##__TYPE__ = 0 to 9 step dblStep + dblStep
					ASSERT( bars.y = 69 )
					ASSERT( c = bars.x )
					ASSERT( global_tor = 3 )
					c += 1
				next
				
				ASSERT( global_tor = 2 )
				
				'' top bar's dtor hasn't been called yet?
				ASSERT( bar.y = 69 )
				
			end scope
			
			ASSERT( global_tor = 0 )
			
		
		end sub	
	
	#endmacro
	
	makeTest( byte )
	makeTest( short )
	makeTest( integer )
	makeTest( single )
	makeTest( double )
	makeTest( longint )
    
    sub testCounter( )

		doTest( byte )
		doTest( short )
		doTest( integer )
		doTest( single )
		doTest( double )
		doTest( longint )
		
	end sub



sub ctor () constructor

	fbcu.add_suite("fbc_tests.compound.for_UDT_counter")
	fbcu.add_test("test UDT as counter", @testCounter)

end sub

end namespace
