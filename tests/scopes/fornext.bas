#include "fbcunit.bi"

'//
'// test FOR ... NEXT
'//

SUITE( fbc_tests.scopes.fornext )

	'' Iterator in outside scope preserves value on exit
	TEST( exitValue )

	  dim i as integer

	  for i = 1 to 3
		exit for
	  next

	  CU_ASSERT_EQUAL( i, 1 )

	END_TEST

	'' Iterator in outside scope is one more than the end condition
	'' on exit
	TEST( exitValueIsOneMore )

	  dim i as integer
	  dim j as integer

	  j = 0

	  for i = 1 to 3

		'' Paranoia - don't allow infinite loop
		j += 1
		if j > 3 then
		  exit for
		end if

	  next

	  CU_ASSERT_EQUAL( j, 3 )
	  CU_ASSERT_EQUAL( i, 4 )

	END_TEST

	'' Setting the iterator inside the loop is checked by condition
	TEST( setIterator )

	  dim i as integer
	  dim j as integer

	  j = 0

	  for i = 1 to 3

		i = 3

		'' Paranoia - don't allow infinite loop
		j += 1
		if j > 3 then
		  exit for
		end if

	  next

	  CU_ASSERT_EQUAL( j, 1 )
	  CU_ASSERT_EQUAL( i, 4 )

	END_TEST


	'' Iterator in outside scope is one less than the end condition
	'' on exit
	TEST( exitValueIsOneLess )

	  dim i as integer
	  dim j as integer

	  j = 0

	  for i = 3 to 1 step -1

		'' Paranoia - don't allow infinite loop
		j += 1
		if j > 3 then
		  exit for
		end if

	  next

	  CU_ASSERT_EQUAL( j, 3 )
	  CU_ASSERT_EQUAL( i, 0 )

	END_TEST


	'' For var as datatype, creates a new scope for var
	TEST( scopedVar )

	  dim i as integer
	  dim j as integer

	  i = 100
	  j = 0

	  for i as integer = 1 to 3

		'' Paranoia - don't allow infinite loop
		j += 1
		if j > 3 then
		  exit for
		end if

	  next

	  CU_ASSERT_EQUAL( j, 3 )
	  CU_ASSERT_EQUAL( i, 100 )

	END_TEST


	'' For var as datatype, creates a new scope for var
	TEST( scopedVarNested )

	  dim i as integer
	  dim j1 as integer
	  dim j2 as integer

	  i = 100
	  j1 = 0

	  for i as integer = 1 to 3

		'' Paranoia - don't allow infinite loop
		j1 += 1
		if j1 > 3 then
		  exit for
		end if

		j2 = 0

		for i as integer = 1 to 3

		  CU_ASSERT_EQUAL( j2 + 1, i )

		  '' Paranoia - don't allow infinite loop
		  j2 += 1
		  if j2 > 3 then
			exit for
		  end if

		next 

		CU_ASSERT_EQUAL( j2, 3 )

	  next

	  CU_ASSERT_EQUAL( j1, 3 )
	  CU_ASSERT_EQUAL( i, 100 )

	END_TEST

END_SUITE
