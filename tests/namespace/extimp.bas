''
'' external implementation
''

#include "fbcunit.bi"

namespace module.ns.extimp

  type bar
		field as integer
  end type
  
  declare function func( byval foo as bar ptr ) as integer
  
end namespace

'' external implementation, the param depends on a ns symbol too
function module.ns.extimp.func( byval foo as bar ptr ) as integer
  
  return 1
  
end function

private sub test_proc

	CU_ASSERT_TRUE( module.ns.extimp.func( 0 ) )

end sub

SUITE( fbc_tests.namespace_.extimp )
	TEST( all )
		test_proc
	END_TEST
END_SUITE
