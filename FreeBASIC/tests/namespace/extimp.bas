''
'' external implementation
''

# include "fbcu.bi"

namespace fbc_tests.ns.extimp

  type bar
		field as integer
  end type
  
  declare function func( byval foo as bar ptr ) as integer
  
end namespace

'' external implementation, the param depends on a ns symbol too
function fbc_tests.ns.extimp.func( byval foo as bar ptr ) as integer
  
  return 1
  
end function

private sub test cdecl

	CU_ASSERT_TRUE( fbc_tests.ns.extimp.func( 0 ) )

end sub

private sub ctor () constructor

	fbcu.add_suite( "fbc_tests.namespace.extimp" )
	fbcu.add_test( "test", @test )
	
end sub
