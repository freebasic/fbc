# include "fbcunit.bi"

SUITE( fbc_tests.file_.close_ )

	const filename = "./file/close.bas"

	#macro TEST_CLOSE_STMT(err_expected, params...)
	scope
		close params
		dim as integer e = err()
		CU_ASSERT_EQUAL(e, err_expected)
	end scope
	#endmacro

	enum FB_RTERROR
		OK = 0
		ILLEGALFUNCTIONCALL = 1
	end enum

	const FALSE = 0
	const TRUE = -1

	private function openfile(byval fn as integer) as integer

		CU_ASSERT_EQUAL( fn, freefile() )

		if( open( filename, for input, as #fn ) <> OK ) then
			CU_FAIL( "File open error" )
			return FALSE
		else
			CU_ASSERT_EQUAL( freefile(), fn+1 )
			return TRUE
		end if

	end function

	TEST( close1 )

		'' close(0) should fail
		CU_ASSERT_EQUAL( close(0), ILLEGALFUNCTIONCALL )

		'' make sure freefile() is 1
		CU_ASSERT_EQUAL( freefile(), 1 )

		CU_ASSERT_EQUAL( close(1), ILLEGALFUNCTIONCALL )

		'' open file at #1
		if openfile( 1 ) then

			'' close(0) should fail, and no files should be closed
			'' (old behaviour: close(0) would close all files)
			CU_ASSERT_EQUAL( close(0), ILLEGALFUNCTIONCALL )

			'' make sure freefile() is still 2 (so #1 hasn't been closed)
			CU_ASSERT_EQUAL( freefile(), 2 )

		end if

		'' close(1) should close file #1 and return no error
		CU_ASSERT_EQUAL( close(1), 0 )

		'' freefile() should be 1 again
		CU_ASSERT_EQUAL( freefile(), 1 )

		'' close(1) should fail again
		CU_ASSERT_EQUAL( close(1), ILLEGALFUNCTIONCALL )

	END_TEST

	TEST( closeall )

		'' close() with no open files should give no error
		CU_ASSERT_EQUAL( close(), OK )

		'' open file at #1
		if openfile( 1 ) then
			'' freefile() should now be 2
			CU_ASSERT_EQUAL( freefile(), 2 )
		end if

		'' open file at #2
		openfile( 2 )

		'' close() should close all files and return no error
		CU_ASSERT_EQUAL( close(), OK )

		'' freefile() should now be 1 again
		CU_ASSERT_EQUAL( freefile(), 1 )

		'' #1 and #2 should be closed, so these should fail
		CU_ASSERT_EQUAL( close(1), ILLEGALFUNCTIONCALL )
		CU_ASSERT_EQUAL( close(2), ILLEGALFUNCTIONCALL )

		'' close() should still return no error
		CU_ASSERT_EQUAL( close(), OK )

	END_TEST

	TEST( closestmt )

		'' close (no params) should succeed.
		TEST_CLOSE_STMT( OK, )

		openfile( 1 )
		openfile( 2 )

		CU_ASSERT_EQUAL( freefile(), 3 )

		'' both should be closed, no error returned (although err() will only show the success of #2)
		TEST_CLOSE_STMT( OK, #1, #2 )

	#if __FB_ERR__ = 0
		'' close #1 and close #2 should now fail
		TEST_CLOSE_STMT( ILLEGALFUNCTIONCALL, #1 )
		TEST_CLOSE_STMT( ILLEGALFUNCTIONCALL, #2 )
	#endif

		openfile( 1 )
		openfile( 2 )

		'' "close" should close both and succeed
		TEST_CLOSE_STMT( OK, )

	END_TEST

END_SUITE
