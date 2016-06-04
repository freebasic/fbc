# include "fbcu.bi"

namespace ns1
	function bar as integer
		function = 1234
	end function
	
end namespace

namespace ns2
	type UDT
		__ as byte
		declare sub proc1 ()
		declare sub proc2 ()
	end type
	
	sub UDT.proc1 ()
		using ns1
		CU_ASSERT_EQUAL( bar, 1234 )
	end sub

	function bar as integer
		function = 5678
	end function

	sub UDT.proc2 ()
		CU_ASSERT_EQUAL( bar, 5678 )
	end sub
	
end namespace


private sub test cdecl
	dim as ns2.UDT t
	
	t.proc1
	t.proc2

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.import_method")
	
	fbcu.add_test("test", @test)
	
end sub
