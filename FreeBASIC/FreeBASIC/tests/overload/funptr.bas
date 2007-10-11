# include "fbcu.bi"



namespace fbc_tests.overloads.funptr

type sub_wo_params_t as sub () 
type sub_w_params_t as sub ( byval as integer ) 

enum
	WITHOUT_PARAMS
	WITH_PARAMS
end enum

function proc overload (byval s as sub_wo_params_t ptr ) as integer
   function = WITHOUT_PARAMS
end function 

function proc overload (byval s as sub_w_params_t ptr ) as integer
   function = WITH_PARAMS
end function 

sub sub_wo_params ( )
end sub 

sub sub_w_params ( byval i as integer )
end sub 

sub test_initialization_wo_params cdecl ()
	dim fn as sub_wo_params_t = @sub_wo_params
	dim pfn as sub_wo_params_t ptr = @fn

	CU_ASSERT_EQUAL( proc( pfn ), WITHOUT_PARAMS )
end sub

sub test_assignment_wo_params cdecl ()
	dim fn as sub_wo_params_t
	dim pfn as sub_wo_params_t ptr

	fn = @sub_wo_params
	pfn = @fn

	CU_ASSERT_EQUAL( proc( pfn ), WITHOUT_PARAMS )
end sub

sub test_initialization_w_params cdecl ()
	dim fn as sub_w_params_t = @sub_w_params
	dim pfn as sub_w_params_t ptr = @fn

	CU_ASSERT_EQUAL( proc( pfn ), WITH_PARAMS )
end sub

sub test_assignment_w_params cdecl ()
	dim fn as sub_w_params_t
	dim pfn as sub_w_params_t ptr

	fn = @sub_w_params
	pfn = @fn

	CU_ASSERT_EQUAL( proc( pfn ), WITH_PARAMS )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:function pointers")
	fbcu.add_test("test_initialization_wo_params", @test_initialization_wo_params)
	fbcu.add_test("test_assignment_wo_params", @test_assignment_wo_params)
	fbcu.add_test("test_initialization_w_params", @test_initialization_w_params)
	fbcu.add_test("test_assignment_w_params", @test_assignment_w_params)

end sub

end namespace
