#include "fbcunit.bi"

#undef short
type short as integer

private sub testRedefStandardType
	CU_ASSERT( sizeof( short ) = sizeof( integer ) )
end sub

private function f1( ) as integer
	function = 123
end function

private sub testPreUndefFunction
	CU_ASSERT( f1( ) = 123 )
end sub

#undef f1

private sub testPostUndefFunction
	'' Wouldn't be allowed if function f1 still existed
	dim f1 as integer = 777
	CU_ASSERT( f1 = 777 )
end sub

private function f1 alias "f2"( ) as integer
	function = 456
end function

private sub testRedefFunction
	CU_ASSERT( f1( ) = 456 )
end sub

private sub testUndefConstants
	#define FOO 123
	CU_ASSERT( FOO = 123 )
	#undef FOO

	#define FOO 456
	CU_ASSERT( FOO = 456 )
	#undef FOO

	const FOO = "foo"
	CU_ASSERT( FOO = "foo" )
	#undef FOO

	type FOO
		as integer x, y, z
	end type

	dim as FOO FOO = ( 1, 2, 3 )
	CU_ASSERT( FOO.x = 1 )
	CU_ASSERT( FOO.y = 2 )
	CU_ASSERT( FOO.z = 3 )
	'' At the moment, this undefs the var, not the type
	#undef FOO

	dim as FOO x
	#undef FOO

	const FOO = 5
	CU_ASSERT( FOO = 5 )
end sub

namespace N
	dim shared as integer i = 123
end namespace

private sub testPreUndefNamespace
	CU_ASSERT( N.i = 123 )
end sub

#undef N

private sub testPostUndefNamespace
	'' Wouldn't be allowed if namespace N existed
	dim as integer N = 456
	CU_ASSERT( N = 456 )
end sub

namespace N alias "N2"
	dim shared as integer i = 456
end namespace

private sub testRedefNamespace
	CU_ASSERT( N.i = 456 )
	using N
	CU_ASSERT( i = 456 )
	#undef N
	CU_ASSERT( i = 456 )
end sub

private sub testRegression1
	'' Shouldn't cause a compiler crash
	dim j as integer ptr = allocate( 4 )
	deallocate( j )
	#undef allocate
	#undef deallocate
end sub

SUITE( fbc_tests.quirk.undef_ )

	'' assuming that these tests need to be module level

	TEST( redefStandardType )
		testRedefStandardType
	END_TEST
	TEST( preUndefFunction )
		testPreUndefFunction
	END_TEST
	TEST( postUndefFunction )
		testPostUndefFunction
	END_TEST
	TEST( redefFunction )
		testRedefFunction
	END_TEST
	TEST( undefConstants )
		testUndefConstants
	END_TEST
	TEST( preUndefNamespace )
		testPreUndefNamespace
	END_TEST
	TEST( postUndefNamespace )
		testPostUndefNamespace
	END_TEST
	TEST( redefNamespace )
		testRedefNamespace
	END_TEST
	TEST( regression1 )
		testRegression1
	END_TEST

END_SUITE
