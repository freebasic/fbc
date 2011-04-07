# include "fbcu.bi"

namespace fbc_tests.string_.idx

type tbar
	baz as zstring * 10 => "0123"
end type

type tfoo
	bar0 as tbar
	bar1 as tbar
end type

''
sub test_local cdecl ()
	dim as tfoo f
	
	CU_ASSERT_EQUAL( f.bar0.baz[0], asc("0") )
	CU_ASSERT_EQUAL( f.bar0.baz[1], asc("1") )
	var x = 2
	CU_ASSERT_EQUAL( f.bar0.baz[x], asc("2") )

	CU_ASSERT_EQUAL( f.bar1.baz[0], asc("0") )
	CU_ASSERT_EQUAL( f.bar1.baz[1], asc("1") )
	CU_ASSERT_EQUAL( f.bar1.baz[x], asc("2") )
	
end sub

''
sub test_static cdecl ()
	static as tfoo f
	
	CU_ASSERT_EQUAL( f.bar0.baz[0], asc("0") )
	CU_ASSERT_EQUAL( f.bar0.baz[1], asc("1") )
	var x = 2
	CU_ASSERT_EQUAL( f.bar0.baz[x], asc("2") )

	CU_ASSERT_EQUAL( f.bar1.baz[0], asc("0") )
	CU_ASSERT_EQUAL( f.bar1.baz[1], asc("1") )
	CU_ASSERT_EQUAL( f.bar1.baz[x], asc("2") )
	
end sub

''
	dim shared as tfoo g_f
sub test_global cdecl ()
	
	CU_ASSERT_EQUAL( g_f.bar0.baz[0], asc("0") )
	CU_ASSERT_EQUAL( g_f.bar0.baz[1], asc("1") )
	var x = 2
	CU_ASSERT_EQUAL( g_f.bar0.baz[x], asc("2") )

	CU_ASSERT_EQUAL( g_f.bar1.baz[0], asc("0") )
	CU_ASSERT_EQUAL( g_f.bar1.baz[1], asc("1") )
	CU_ASSERT_EQUAL( g_f.bar1.baz[x], asc("2") )
	
end sub
	
private sub ctor () constructor

	fbcu.add_suite("fb-tests-string:idx")
	fbcu.add_test("local", @test_local)
	fbcu.add_test("static", @test_static)
	fbcu.add_test("global", @test_global)

end sub
	
end namespace