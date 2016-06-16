#include "fbcu.bi"

namespace fbc_tests.pp.inconce5

sub test5 cdecl

  dim inc_counter1 as integer = 0
  dim inc_counter2 as integer = 0
  dim inc_counter3 as integer = 0
  dim inc_counter4 as integer = 0
  dim inc_counter5 as integer = 0

#include "inc5.bi"
  CU_ASSERT_EQUAL( inc_counter1, 4 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 2 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )
  CU_ASSERT_EQUAL( inc_counter5, 1 )

#include "inc5.bi"
  CU_ASSERT_EQUAL( inc_counter1, 6 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 3 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )
  CU_ASSERT_EQUAL( inc_counter5, 2 )

#include once "inc5.bi"
  CU_ASSERT_EQUAL( inc_counter1, 6 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 3 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )
  CU_ASSERT_EQUAL( inc_counter5, 2 )

#include once "../pp/inc5.bi"
  CU_ASSERT_EQUAL( inc_counter1, 6 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 3 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )
  CU_ASSERT_EQUAL( inc_counter5, 2 )

#include "inc5.bi"
  CU_ASSERT_EQUAL( inc_counter1, 8 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 4 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )
  CU_ASSERT_EQUAL( inc_counter5, 3 )

end sub

private sub ctor () constructor

  fbcu.add_suite("fbc_tests.pp.inc_once5")
  fbcu.add_test("test5", @test5)

end sub

end namespace
