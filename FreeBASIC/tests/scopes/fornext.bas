# include "fbcu.bi"




'//
'// test FOR ... NExT
'//

namespace fbc_tests.scopes.fornext

'' Iterator in outside scope preserves value on exit
sub test_1 cdecl ()

  dim i as integer

  for i = 1 to 3
    exit for
  next

  CU_ASSERT_EQUAL( i, 1 )

end sub

'' Iterator in outside scope is one more than the end condition
'' on exit
sub test_2 cdecl ()

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

end sub

'' Setting the iterator inside the loop is checked by condition
sub test_3 cdecl ()

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

end sub


'' Iterator in outside scope is one less than the end condition
'' on exit
sub test_4 cdecl ()

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

end sub


'' For var as datatype, creates a new scope for var
sub test_5 cdecl ()

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

end sub


'' For var as datatype, creates a new scope for var
sub test_6 cdecl ()

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

end sub



sub ctor () constructor

  fbcu.add_suite("fbc_tests.scopes.fornext")
	fbcu.add_test("test 1", @test_1)
	fbcu.add_test("test 2", @test_2)
	fbcu.add_test("test 3", @test_3)
  fbcu.add_test("test 4", @test_4)
  fbcu.add_test("test 5", @test_5)
  fbcu.add_test("test 6", @test_6)

end sub

end namespace
