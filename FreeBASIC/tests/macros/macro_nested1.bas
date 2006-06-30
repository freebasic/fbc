
# macro create_macro( name_, params_, body_ )
	# undef name_
	# macro name_ params_
		body_
	# endmacro
# endmacro

  create_macro( join, (foo,bar), foo & bar )

  assert( join( "hello", "world!" ) = "helloworld!" )
  
'' test comments

# undef create_macro

# macro create_macro /' define a new macro '/ _
	( _
		name_, _ ' name
		params_, _ ' params
		body_ _ ' body 
	) ' macro
	
	# undef name_
	# macro name_ params_ ' params_
		body_	' body_
	# endmacro 	' name_
# endmacro ' create_macro

  create_macro( join, (foo,bar), foo & bar ) ' white-space

  assert( join( "hello", "world!" ) = "helloworld!" )
  
