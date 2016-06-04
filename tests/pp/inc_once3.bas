#include "fbcu.bi"

namespace fbc_tests.pp.inconce3

sub test3 cdecl

  dim inc_counter1 as integer = 0
  dim inc_counter2 as integer = 0
  dim inc_counter3 as integer = 0

#include "inc3.bi"
  CU_ASSERT_EQUAL( inc_counter1, 1 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 1 )

#include "../pp/inc3.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 2 )

#include once "inc3.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 2 )

#include once "../pp/inc3.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 2 )

#include "inc3.bi"
  CU_ASSERT_EQUAL( inc_counter1, 3 )
  CU_ASSERT_EQUAL( inc_counter2, 1 )
  CU_ASSERT_EQUAL( inc_counter3, 3 )

end sub

private sub ctor () constructor

  fbcu.add_suite("fbc_tests.pp.inc_once3")
  fbcu.add_test("test3", @test3)

end sub

end namespace
