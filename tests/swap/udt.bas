# include "fbcu.bi"

namespace fbc_tests.swp

type udt
	a as integer
	b as short
end type

type udt2
	dummy as integer
	udt	as udt
end type

sub test_swap_local cdecl ()
	dim as udt t1, t2
	
	t1.a = 1
	t1.b = 2
	t2.a = 3
	t2.b = 4
	
	swap t1, t2
	
	CU_ASSERT( t1.b = 4 ) 
	CU_ASSERT( t1.a = 3 ) 
	CU_ASSERT( t2.b = 2 ) 
	CU_ASSERT( t2.a = 1 ) 
	
end sub

sub test_swap_static_initialized cdecl ()
	static as udt t1 = (1, 2), t2 = (3, 4)
	
	swap t1, t2
	
	CU_ASSERT( t1.b = 4 ) 
	CU_ASSERT( t1.a = 3 ) 
	CU_ASSERT( t2.b = 2 ) 
	CU_ASSERT( t2.a = 1 ) 
	
end sub

sub test_swap_local_initialized cdecl ()
	dim as udt t1 = (1, 2), t2 = (3, 4)
	
	swap t1, t2
	
	CU_ASSERT( t1.b = 4 ) 
	CU_ASSERT( t1.a = 3 ) 
	CU_ASSERT( t2.b = 2 ) 
	CU_ASSERT( t2.a = 1 ) 
	
end sub

sub test_swap_reference cdecl ()
	static as udt t1 = (1, 2), t2 = (3, 4)
	dim as udt ptr p1 = @t1, p2 = @t2
	
	swap *p1, *p2
	
	CU_ASSERT( t1.b = 4 ) 
	CU_ASSERT( t1.a = 3 ) 
	CU_ASSERT( t2.b = 2 ) 
	CU_ASSERT( t2.a = 1 ) 
	
end sub

sub test_swap_reference_to_field cdecl ()
	static as udt2 t1 = (0, (1, 2)), t2 = (0, (3, 4))
	dim as udt2 ptr p1 = @t1, p2 = @t2
	
	swap p1->udt, p2->udt
	
	CU_ASSERT( t1.udt.b = 4 ) 
	CU_ASSERT( t1.udt.a = 3 ) 
	CU_ASSERT( t2.udt.b = 2 ) 
	CU_ASSERT( t2.udt.a = 1 ) 
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-swap-udt")
	fbcu.add_test("test_swap_local", @test_swap_local)
	fbcu.add_test("test_swap_static_initialized", @test_swap_static_initialized)
	fbcu.add_test("test_swap_local_initialized", @test_swap_local_initialized)
	fbcu.add_test("test_swap_reference", @test_swap_reference)
	fbcu.add_test("test_swap_reference_to_field", @test_swap_reference_to_field)

end sub

end namespace
