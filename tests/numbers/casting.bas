# include "fbcu.bi"




namespace fbc_tests.numbers.casting

sub test1 cdecl ()
	dim as integer dst, src
	
	src = &hFF
	dst = cubyte( cuint( src ) )
	
	CU_ASSERT_EQUAL( dst, &hFF )
end sub

sub test2 cdecl ()
	dim as integer dst, src
	
	src = &hFFFF
	dst = cushort( cuint( src ) )
	
	CU_ASSERT_EQUAL( dst, &hFFFF )
end sub

sub test3 cdecl ()
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cuint( src )
	
	CU_ASSERT_EQUAL( dst, &hFFFFFFFF )
end sub

sub floatToInt( )
	'' Some float-to-int casting to ensure it compiles fine, including the
	'' regression test for bug #3310595.
	dim as single f = 123
	CU_ASSERT( cbyte( f ) = 123 )
	CU_ASSERT( cubyte( f ) = 123 )
	CU_ASSERT( cshort( f ) = 123 )
	CU_ASSERT( cushort( f ) = 123 )
	CU_ASSERT( cint( f ) = 123 )
	CU_ASSERT( cuint( f ) = 123 )
	CU_ASSERT( clng( f ) = 123 )
	CU_ASSERT( culng( f ) = 123 )
	CU_ASSERT( clngint( f ) = 123 )
	CU_ASSERT( culngint( f ) = 123 )

	dim as double d = 123
	CU_ASSERT( cbyte( d ) = 123 )
	CU_ASSERT( cubyte( d ) = 123 )
	CU_ASSERT( cshort( d ) = 123 )
	CU_ASSERT( cushort( d ) = 123 )
	CU_ASSERT( cint( d ) = 123 )
	CU_ASSERT( cuint( d ) = 123 )
	CU_ASSERT( clng( d ) = 123 )
	CU_ASSERT( culng( d ) = 123 )
	CU_ASSERT( clngint( d ) = 123 )
	CU_ASSERT( culngint( d ) = 123 )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.casting")
	fbcu.add_test("test1", @test1)
	fbcu.add_test("test2", @test2)
	fbcu.add_test("test3", @test3)
	fbcu.add_test("float to int", @floatToInt)

end sub

end namespace
