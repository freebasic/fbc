# include "fbcunit.bi"

data_1:
data -1, "true"
data  0, "false"
data -1, "TRUE"
data  0, "FALSE"
data -1, "True"
data  0, "False"
data -1, "TrUe"
data  0, "FaLsE"
data  0, 0
data -1, 1
data -1, -1
data  0, +0.0
data  0, -0.0
data -1, 1.234e+4
data -1, 1.234d+4
data  0, &h0
data -1, &h1
data -1, &hffffffff
data  0, &b0
data -1, &b1

SUITE( fbc_tests.boolean_.boolean_data )

	'' RTLIB - DATAREADBOOL

	TEST( data_read_boolean )
		
		dim i as integer
		dim c as integer
		dim b as boolean

		'' need to RESTORE here, out-of-order
		'' module constructors might mess with
		'' our starting point

		restore data_1

		for c = 1 to 20
			read i, b
			CU_ASSERT_EQUAL( i, cint(b) )
		next

	END_TEST

END_SUITE
