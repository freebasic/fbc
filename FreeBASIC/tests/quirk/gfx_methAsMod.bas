# include "fbcu.bi"

namespace fbc_tests.quirk.gfx_methodsAndModifiers

	type foo
	
		__ as integer
		
		declare function pset( ) as integer
		declare function preset( ) as integer
		declare function get( ) as integer
	
		declare sub palGet( ) 
		declare sub putPset( ) 
		declare sub putPreset( ) 
	
	end type
	
	function foo.pset( ) as integer
		return 0
	end function
	
	function foo.preset( ) as integer
		return 0
	end function
	
	function foo.get( ) as integer
		return 0
	end function
	
	sub foo.palGet( )
	    
	    dim as integer c
		palette get 1, c
		
	end sub
	
	sub foo.putPset( )
	    
	    dim as integer ptr c
		put( 0, 0 ), c, pset
		
	end sub
	
	sub foo.putPreset( )
	    
	    dim as integer ptr c
		put( 0, 0 ), c, preset
		
	end sub
	
	dim shared as foo bar
	
	sub test_palGet cdecl()
		bar.palget( )
	end sub
	sub test_putPset cdecl()
		bar.putPset( )
	end sub
	sub test_putPreset cdecl()
		bar.putPreset( )
	end sub

 	sub ctor () constructor

		fbcu.add_suite("fbc_tests.quirk.gfx_methodsAndModifiers")
		fbcu.add_test("palette get having method 'get'", @test_palGet)
		fbcu.add_test("put(x,y),pset having method 'pset'", @test_putPset)
		fbcu.add_test("put(x,y),preset having method 'preset'", @test_putPreset)

	end sub

end namespace