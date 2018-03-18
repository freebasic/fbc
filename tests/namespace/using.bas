#include "fbcunit.bi"

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

SUITE( fbc_tests.namespace_.using_ )

	namespace ns_b
		using ns_a
	end namespace
	
	TEST( using1 )
		CU_ASSERT_EQUAL( .bar, 1234 )
		CU_ASSERT_EQUAL( ns_b.baz, 5678 )
	END_TEST

	TEST( using2 )
		CU_ASSERT_EQUAL( s1( ), 69 )
	END_TEST

END_SUITE
