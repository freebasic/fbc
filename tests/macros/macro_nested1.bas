# include "fbcu.bi"

namespace fbc_tests.macros.macro_nested1

# macro create_macro( name_, params_, body_ )
	# undef name_
	# macro name_ params_
		body_
	# endmacro
# endmacro

  create_macro( join, (foo,bar), foo & bar )

sub nestedTest cdecl ()

  CU_ASSERT_EQUAL( join( "hello", "world!" ), "helloworld!" )
  
end sub

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

sub commentsInParamsTest cdecl ()

  CU_ASSERT_EQUAL( join( "hello", "world!" ), "helloworld!" )
  
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.macros.nested_1")
	fbcu.add_test("nestedTest", @nestedTest)
	fbcu.add_test("commentsInParamsTest", @commentsInParamsTest)

end sub

end namespace
