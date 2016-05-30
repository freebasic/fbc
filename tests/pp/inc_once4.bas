#include "fbcu.bi"

namespace fbc_tests.pp.inconce4

sub test4 cdecl

  dim inc_counter1 as integer = 0
  dim inc_counter2 as integer = 0
  dim inc_counter3 as integer = 0
  dim inc_counter4 as integer = 0

#include "inc4.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 1 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )

#include "inc4.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 1 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )

#include once "inc4.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 1 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )

#include once "../pp/inc4.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 1 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )

#include "../pp/inc4.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 1 )
  CU_ASSERT_EQUAL( inc_counter4, 1 )

end sub

private sub ctor () constructor

  fbcu.add_suite("fbc_tests.pp.inc_once4")
  fbcu.add_test("test4", @test4)

end sub

end namespace
