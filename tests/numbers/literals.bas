# include "fbcu.bi"

namespace fbc_tests.numbers.literals

sub test1 cdecl ()
	CU_ASSERT( clng( 4294967295UL + 10UL ) = 9UL )
	CU_ASSERT( 4294967295UL > 2147483648UL )
	CU_ASSERT( 18446744073709551615ULL + 10ULL = 9ULL )
	CU_ASSERT( 9223372036854775808ULL < 18446744073709551615ULL )
	CU_ASSERT( (csng(1) or csng(2)) = 3 )
	CU_ASSERT( (csng(1) shl csng(2)) = 4 )
end sub

sub test2 cdecl ()
	#ifdef __FB_64BIT__
		CU_ASSERT( sizeof(long) = 4 )
		CU_ASSERT( sizeof(integer) = 8 )
		CU_ASSERT( sizeof(longint) = 8 )
	#else
		CU_ASSERT( sizeof(long) = 4 )
		CU_ASSERT( sizeof(integer) = 4 )
		CU_ASSERT( sizeof(longint) = 8 )
	#endif

	CU_ASSERT_EQUAL( sizeof(1),          sizeof(integer) )
	CU_ASSERT_EQUAL( sizeof(65536),      sizeof(integer) )
	CU_ASSERT_EQUAL( sizeof(4294967295), sizeof(integer) )
	CU_ASSERT_EQUAL( sizeof(4294967296), sizeof(longint) )
end sub

sub test3 cdecl ()
	# define s( n ) (#n & " ")

	# define bl &b1
	# define bu &B1

	# define ol &o1
	# define ou &O1

	# define hl &h1
	# define hu &H1

	CU_ASSERT_EQUAL( s(bl) & s(bu), "&b1 &B1 " )
	CU_ASSERT_EQUAL( s(ol) & s(ou), "&o1 &O1 " )
	CU_ASSERT_EQUAL( s(hl) & s(hu), "&h1 &H1 " )
end sub

sub ctor () constructor
	fbcu.add_suite("fbc_tests.numbers.literals")
	fbcu.add_test("test1", @test1)
	fbcu.add_test("test2", @test2)
	fbcu.add_test("test3", @test3)
end sub

end namespace
