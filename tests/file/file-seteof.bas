# include "fbcunit.bi"

#include "file.bi"

SUITE( fbc_tests.file_.file_seteof )

	const filename = "./file/seteof.tmp"

	TEST( seteofbinary )

		#macro chkSetEof( i )
			seek #1, i+1
			CU_ASSERT( seek(1) = (i+1) )
			FileSetEof( 1 )
			CU_ASSERT( lof(1) = i )
			CU_ASSERT( seek(1) = (i+1) )
		#endmacro

		if( open( filename for output as #1 ) = 0 ) then
			close #1
			if( open( filename for binary as #1 ) = 0 ) then

				'' FileSetEof can be used to increase file size
				for i as integer = 0 to 10000 step 1000
					chkSetEof( i )
				next

				'' or decrease file size
				for i as integer = 10000 to 0 step -1000
					chkSetEof( i )
				next

				close #1

				kill filename
			else
				CU_FAIL( "seteofbinary: failed" )
			end if
		else
			CU_FAIL( "seteofbinary: failed" )
		end if
	END_TEST

END_SUITE
