# include "fbcunit.bi"

#include "file.bi"

SUITE( fbc_tests.file_.file_truncate )

	const filename = "./file/truncate.tmp"

	TEST( truncatebinary )

		#macro chkTruncate( i )
			seek #1, i+1
			CU_ASSERT( seek(1) = (i+1) )
			FileTruncate( 1 )
			CU_ASSERT( lof(1) = i )
			CU_ASSERT( seek(1) = (i+1) )
		#endmacro

		if( open( filename for output as #1 ) = 0 ) then
			close #1
			if( open( filename for binary as #1 ) = 0 ) then

				'' truncate can be used to increase file size
				for i as integer = 0 to 10000 step 1000
					chkTruncate( 1 )
				next

				'' or decrease file size
				for i as integer = 10000 to 0 step -1000
					chkTruncate( 1 )
				next

				close #1

				kill filename
			else
				CU_FAIL( "truncatebinary: failed" )
			end if
		else
			CU_FAIL( "truncatebinary: failed" )
		end if
	END_TEST

END_SUITE
