#include "fbcu.bi"

namespace fbc_tests.dim_.redim_

dim shared foo() as integer
dim shared as integer globcnt

Type T
	As Integer a, b, c, d
	Declare Constructor()
End Type

Constructor T()
	globcnt += 1
End Constructor

sub test1
	redim foo(1 to 2)
end sub

sub test2
	redim foo(3 to 4) as integer
end sub

sub test3
	redim foo(-1 to 1) as double
end sub

sub test4 cdecl
	scope
		dim bar() as T ptr
		redim bar(1) as T ptr
		CU_ASSERT_EQUAL( globcnt, 0 )
	end scope

	scope
		dim bar () as T
		redim bar(0 to 1) as T
		CU_ASSERT_EQUAL( globcnt, 2 )
	end scope
end sub

sub test cdecl
	test1
	CU_ASSERT_EQUAL( lbound(foo), 1 )
	CU_ASSERT_EQUAL( ubound(foo), 2 )
	
	test2
	CU_ASSERT_EQUAL( lbound(foo), 3 )
	CU_ASSERT_EQUAL( ubound(foo), 4 )
	
	test3
	CU_ASSERT_EQUAL( lbound(foo), 3 )
	CU_ASSERT_EQUAL( ubound(foo), 4 )
end sub

'' Regression test for #3474348
namespace commonRedimRedim
	common array() as integer

	private sub test cdecl( )
		redim array(0 to 4) as integer
		CU_ASSERT( lbound( array ) = 0 )
		CU_ASSERT( ubound( array ) = 4 )

		redim array(0 to 9) as integer
		CU_ASSERT( lbound( array ) = 0 )
		CU_ASSERT( ubound( array ) = 9 )
	end sub
end namespace

namespace commonDim
	common array() as integer

	private sub test cdecl( )
		'' Dim is allowed after Common -- as in QB.
		dim array(0 to 4) as integer

		CU_ASSERT( lbound( array ) = 0 )
		CU_ASSERT( ubound( array ) = 4 )
	end sub
end namespace

'' Regression test for #3510684: An array using a different mangling, which
'' affects the array descriptor too -- should still work just the same.
extern "C"
	dim shared global1() as integer
	dim shared global2(0 to 0) as integer
end extern

sub testMangled cdecl( )
	redim global1(0 to 0) as integer
	global1(0) = 123
	CU_ASSERT( global1(0) = 123 )

	global2(0) = 123
	CU_ASSERT( global2(0) = 123 )
end sub

namespace dtorOnlyElementsAreCleared
	type DtorUdt
		i as integer
		declare destructor( )
	end type

	destructor DtorUdt( )
	end destructor

	'' Any number, just large enough to hopefully not be all zero when
	'' allocating this many DtorUdt's from heap
	const ARRAY_SIZE = 1024

	sub testRedim cdecl( )
		'' new array
		redim array(0 to ARRAY_SIZE-1) as DtorUdt
		for i as integer = lbound( array ) to ubound( array )
			CU_ASSERT( array(i).i = 0 )
		next

		'' increase size of existing array (at least remainder needs to be cleared)
		redim array(0 to (ARRAY_SIZE*2)-1) as DtorUdt
		for i as integer = lbound( array ) to ubound( array )
			CU_ASSERT( array(i).i = 0 )
		next
	end sub

	sub testRedimPreserve cdecl( )
		'' new array
		redim preserve array(0 to ARRAY_SIZE-1) as DtorUdt
		for i as integer = lbound( array ) to ubound( array )
			CU_ASSERT( array(i).i = 0 )
		next

		'' increase size of existing array (remainder needs to be cleared)
		redim preserve array(0 to (ARRAY_SIZE*2)-1) as DtorUdt
		for i as integer = lbound( array ) to ubound( array )
			CU_ASSERT( array(i).i = 0 )
		next
	end sub
end namespace

namespace noCompileTimeChecks
	'' REDIM'ing a dynamic array with different amount of dimensions than
	'' what the compiler has previously seen should not cause a compile-time
	'' error, because the compiler cannot reliably track the amount of
	'' dimensions of a dynamic array, since it could be changed by a REDIM
	'' at any point in code, even in external modules, and the compiler
	'' cannot trace them all in the correct order.

	dim shared b() as integer

	sub f1( )
		redim b(0 to 9)

		for i as integer = lbound( b ) to ubound( b )
			b(i) = i
		next

		for i as integer = lbound( b ) to ubound( b )
			CU_ASSERT( b(i) = i )
		next

		erase b
	end sub

	sub f2( )
		redim b(0 to 9, 0 to 9) '' should not cause a compile-time error

		for i as integer = lbound( b, 1 ) to ubound( b, 1 )
		for j as integer = lbound( b, 2 ) to ubound( b, 2 )
			b(i, j) = i * 10 + j
		next
		next

		for i as integer = lbound( b, 1 ) to ubound( b, 1 )
		for j as integer = lbound( b, 2 ) to ubound( b, 2 )
			CU_ASSERT( b(i, j) = i * 10 + j )
		next
		next

		erase b
	end sub

	sub test cdecl( )
		dim a() as integer

		redim a(0 to 9)
		a(1) = 123
		CU_ASSERT( a(1) = 123 )

		redim a(0 to 9, 0 to 9) '' should not cause a compile-time error
		a(1, 1) = 123
		CU_ASSERT( a(1, 1) = 123 )

		f1( )
		f2( )

		f2( )
		f1( )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite("fbc_tests.dim.redim")
	fbcu.add_test("test", @test)
	fbcu.add_test("test4", @test4)
	fbcu.add_test( "Common/Redim/Redim", @commonRedimRedim.test )
	fbcu.add_test( "Common/Dim", @commonDim.test )
	fbcu.add_test( "array + desc using non-default mangling", @testMangled )
	fbcu.add_test( "dtorOnlyElementsAreCleared.testRedim", @dtorOnlyElementsAreCleared.testRedim )
	fbcu.add_test( "dtorOnlyElementsAreCleared.testRedimPreserve", @dtorOnlyElementsAreCleared.testRedimPreserve )
	fbcu.add_test( "noCompileTimeChecks", @noCompileTimeChecks.test )
end sub

end namespace
