# include "fbcu.bi"

namespace fbc_tests.structs.anon_nested

type test
	as short a, b
end type

type test_pair
	as test t1, t2
end type

const test_1 = 1234, test_2 = 5678, test_3 = 9012, test_4 = 3456

function istrue_ref( byref p1 as test_pair, byref p2 as test_pair ) as integer
	function = (p1.t1.a = p2.t2.b) and (p1.t1.b = p2.t2.a) and (p1.t2.a = p2.t1.b) and (p1.t2.b = p2.t1.a)
end function

function istrue_val( byval p1 as test_pair, byval p2 as test_pair ) as integer
	function = (p1.t1.a = p2.t2.b) and (p1.t1.b = p2.t2.a) and (p1.t2.a = p2.t1.b) and (p1.t2.b = p2.t1.a)
end function

function istrue_ptr( byval p1 as test_pair ptr, byval p2 as test_pair ptr ) as integer
	function = (p1->t1.a = p2->t2.b) and (p1->t1.b = p2->t2.a) and (p1->t2.a = p2->t1.b) and (p1->t2.b = p2->t1.a)
end function

sub test_ref cdecl ()
  dim as integer istrue
  
  istrue = istrue_ref( type<test_pair>( type<test>( test_1, test_2 ), type<test>( test_3, test_4 ) ), _ 
                  	   type<test_pair>( type<test>( test_4, test_3 ), type<test>( test_2, test_1 ) ) )   
  
  CU_ASSERT( istrue )
end sub

sub test_val cdecl ()
  dim as integer istrue
  
  istrue = istrue_val( type<test_pair>( type<test>( test_1, test_2 ), type<test>( test_3, test_4 ) ), _ 
                  	   type<test_pair>( type<test>( test_4, test_3 ), type<test>( test_2, test_1 ) ) )  
  
  CU_ASSERT( istrue )
end sub

sub test_ptr cdecl ()
  dim as integer istrue
  
  istrue = istrue_ptr( @type<test_pair>( type<test>( test_1, test_2 ), type<test>( test_3, test_4 ) ), _ 
                  	   @type<test_pair>( type<test>( test_4, test_3 ), type<test>( test_2, test_1 ) ) )
  
  CU_ASSERT( istrue )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.structs.anon-nested" )
	fbcu.add_test("pass by reference", @test_ref)
	fbcu.add_test("pass by value", @test_val)
	fbcu.add_test("pass by address", @test_ptr)
end sub

end namespace
