#include "fbcu.bi"

#undef short
type short as integer

private sub testRedefStandardType cdecl( )
	CU_ASSERT( sizeof( short ) = sizeof( integer ) )
end sub

private function f1( ) as integer
	function = 123
end function

private sub testPreUndefFunction cdecl( )
	CU_ASSERT( f1( ) = 123 )
end sub

#undef f1

private sub testPostUndefFunction cdecl( )
	'' Wouldn't be allowed if function f1 still existed
	dim f1 as integer = 777
	CU_ASSERT( f1 = 777 )
end sub

private function f1 alias "f2"( ) as integer
	function = 456
end function

private sub testRedefFunction cdecl( )
	CU_ASSERT( f1( ) = 456 )
end sub

private sub testUndefConstants cdecl( )
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

private sub testPreUndefNamespace cdecl( )
	CU_ASSERT( N.i = 123 )
end sub

#undef N

private sub testPostUndefNamespace cdecl( )
	'' Wouldn't be allowed if namespace N existed
	dim as integer N = 456
	CU_ASSERT( N = 456 )
end sub

namespace N alias "N2"
	dim shared as integer i = 456
end namespace

private sub testRedefNamespace cdecl( )
	CU_ASSERT( N.i = 456 )
	using N
	CU_ASSERT( i = 456 )
	#undef N
	CU_ASSERT( i = 456 )
end sub

private sub testRegression1 cdecl( )
	'' Shouldn't cause a compiler crash
	dim j as integer ptr = allocate( 4 )
	deallocate( j )
	#undef allocate
	#undef deallocate
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/quirk/undef" )
	fbcu.add_test( "redefining a standard type", @testRedefStandardType )
	fbcu.add_test( "before undeffing a function", @testPreUndefFunction )
	fbcu.add_test( "after undeffing the function", @testPostUndefFunction )
	fbcu.add_test( "after redefining the function", @testRedefFunction )
	fbcu.add_test( "constants", @testUndefConstants )
	fbcu.add_test( "before undeffing the namespace", @testPreUndefNamespace )
	fbcu.add_test( "after undeffing the namespace", @testPostUndefNamespace )
	fbcu.add_test( "after redefining the namespace", @testRedefNamespace )
	fbcu.add_test( "regression test 1", @testRegression1 )
end sub
