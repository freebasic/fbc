
# macro hello1( )
	 	
	"hello"
	 
	 	
# endmacro

# macro world1( )

	 	
	"world!"
	 
# endmacro

  assert( hello1( ) + world1( ) = "helloworld!" ) 
  
'' with args

# macro hello2( foo )
	 	
	"hello"
	 
	 	
# endmacro

# macro world2( foo )

	 	
	"world!"
	 
# endmacro

  assert( hello2( 0 ) + world2( 0 ) = "helloworld!" ) 
