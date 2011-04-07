# include "fbcu.bi"

namespace n1
namespace n2
Extern As Integer v2
End namespace

namespace n3
Extern As Integer v3
End namespace

'Declare Sub s1
End namespace

Using n1
Using n1.n2
Using n1.n3

namespace n1
namespace n2
Dim Shared As Integer v2
End namespace

namespace n3
Dim Shared As Integer v3 = 69
End namespace

function s1( ) as integer
function = v3
End function
End namespace

namespace ns_a
	dim as integer bar = 1234
	dim as integer baz = 5678
end namespace

		using ns_a

namespace fbc_tests.ns.using_

	namespace ns_b
		using ns_a
	end namespace
	
	sub test_1 cdecl
		CU_ASSERT_EQUAL( .bar, 1234 )
		CU_ASSERT_EQUAL( ns_b.baz, 5678 )
	end sub

	sub test_2 cdecl
		CU_ASSERT_EQUAL( s1( ), 69 )
	end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.using")
		fbcu.add_test("#1", @test_1)
		fbcu.add_test("#2", @test_2)
		
	end sub

end namespace