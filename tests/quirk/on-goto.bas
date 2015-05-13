#include "fbcu.bi"

private sub test1_0 cdecl( )
	dim i as integer

	i = 0
	on i goto label1
	goto exit1

	label1:
		CU_FAIL( )

	exit1:
end sub

private sub test1_1 cdecl( )
	dim i as integer

	i = 1
	on i goto label1
	CU_FAIL( )

	label1:
end sub

private sub test1_2 cdecl( )
	dim i as integer

	i = 2
	on i goto label1
	goto exit1

	label1:
		CU_FAIL( )

	exit1:
end sub

private sub test4_0 cdecl( )
	dim i as integer

	i = 0
	on i goto label1, label2, label3, label4
	goto exit1

	label1:
	label2:
	label3:
	label4:
		CU_FAIL( )

	exit1:
end sub

private sub test4_1 cdecl( )
	dim i as integer

	i = 1
	on i goto label1, label2, label3, label4
	CU_FAIL( )  '' not reached

	label1:
		goto exit1
	label2:
	label3:
	label4:
		CU_FAIL( )

	exit1:
end sub

private sub test4_2 cdecl( )
	dim i as integer

	i = 2
	on i goto label1, label2, label3, label4
	CU_FAIL( )  '' not reached

	label1:
		CU_FAIL( )
	label2:
		goto exit1
	label3:
	label4:
		CU_FAIL( )

	exit1:
end sub

private sub test4_3 cdecl( )
	dim i as integer

	i = 3
	on i goto label1, label2, label3, label4
	CU_FAIL( )  '' not reached

	label1:
	label2:
		CU_FAIL( )
	label3:
		goto exit1
	label4:
		CU_FAIL( )

	exit1:
end sub

private sub test4_4 cdecl( )
	dim i as integer

	i = 4
	on i goto label1, label2, label3, label4
	CU_FAIL( )  '' not reached

	label1:
	label2:
	label3:
		CU_FAIL( )
	label4:
end sub

private sub test4_5 cdecl( )
	dim i as integer

	i = 5
	on i goto label1, label2, label3, label4
	goto exit1

	label1:
	label2:
	label3:
	label4:
		CU_FAIL( )

	exit1:
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/quirk/on-goto" )
	fbcu.add_test( "1 0", @test1_0 )
	fbcu.add_test( "1 1", @test1_1 )
	fbcu.add_test( "1 2", @test1_2 )
	fbcu.add_test( "4 0", @test4_0 )
	fbcu.add_test( "4 1", @test4_1 )
	fbcu.add_test( "4 2", @test4_2 )
	fbcu.add_test( "4 3", @test4_3 )
	fbcu.add_test( "4 4", @test4_4 )
	fbcu.add_test( "4 5", @test4_5 )
end sub
