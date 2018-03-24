#include "fbcunit.bi"

'' assuming that this test needs to be module level

private sub test1_0_proc()
	dim i as integer

	i = 0
	on i goto label1
	goto exit1

	label1:
		CU_FAIL( )

	exit1:
end sub

private sub test1_1_proc()
	dim i as integer

	i = 1
	on i goto label1
	CU_FAIL( )

	label1:
end sub

private sub test1_2_proc()
	dim i as integer

	i = 2
	on i goto label1
	goto exit1

	label1:
		CU_FAIL( )

	exit1:
end sub

private sub test4_0_proc()
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

private sub test4_1_proc()
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

private sub test4_2_proc()
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

private sub test4_3_proc()
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

private sub test4_4_proc()
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

private sub test4_5_proc()
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

SUITE( fbc_tests.quirk.on_goto )
	TEST( test1_0 )
		test1_0_proc
	END_TEST
	TEST( test1_1 )
		test1_1_proc
	END_TEST
	TEST( test1_2 )
		test1_2_proc
	END_TEST
	TEST( test4_0 )
		test4_0_proc
	END_TEST
	TEST( test4_1 )
		test4_1_proc
	END_TEST
	TEST( test4_2 )
		test4_2_proc
	END_TEST
	TEST( test4_3 )
		test4_3_proc
	END_TEST
	TEST( test4_4 )
		test4_4_proc
	END_TEST
	TEST( test4_5 )
		test4_5_proc
	END_TEST

END_SUITE
