# include "fbcu.bi"



namespace fbc_tests.structs.bitfield_access

const TEST_W = 200
const TEST_H = 100
	
type foo_1 field=1 
	as short                 bpp :3
	as short                 w   :8 
	as short                 h   :8
end type 

type foo_2 field=1 
	as short                 bpp :3
	as short                 w   :8
	as short                 h
end type 

type foo_3 field=1 
	as short                 bpp :3
	as integer               w   :8 
	as integer               h
end type 


sub test_1 cdecl ()

	dim as foo_1 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dim as integer res = f.w * f.h
	
	CU_ASSERT_EQUAL( res, TEST_W * TEST_H )

end sub

sub test_2 cdecl ()

	dim as foo_2 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dim as integer res = f.w * f.h
	
	CU_ASSERT_EQUAL( res, TEST_W * TEST_H )

end sub

sub test_3 cdecl ()

	dim as foo_3 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dim as integer res = f.w * f.h
	
	CU_ASSERT_EQUAL( res, TEST_W * TEST_H )

end sub

dim shared as foo_1 f4

sub test_4 cdecl ()

	f4.w = TEST_W
	f4.h = TEST_H
	
	dim as integer res = f4.w * f4.h
	
	CU_ASSERT_EQUAL( res, TEST_W * TEST_H )

end sub

sub testNested cdecl( )
	type A
		as integer i : 1
	end type

	type B
		as A a
	end type

	dim as B b

	b.a.i = 1

	CU_ASSERT( b.a.i = 1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite("fbc_tests.structs.bitfield_access")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)
	fbcu.add_test("test_3", @test_3)
	fbcu.add_test("test_4", @test_4)
	fbcu.add_test("Nested field access", @testNested)
end sub

end namespace
