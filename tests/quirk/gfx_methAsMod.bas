' TEST_MODE : COMPILE_ONLY_OK

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
	
screen 13 