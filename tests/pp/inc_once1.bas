#include "fbcu.bi"

namespace fbc_tests.pp.inconce1

sub test1 cdecl

  dim inc_counter1 as integer = 0

#include "inc1.bi"
  CU_ASSERT_EQUAL( inc_counter1, 1 )

#include "inc1.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )

#include once "../pp/inc1.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )

#include once "../pp/inc1.bi"
  CU_ASSERT_EQUAL( inc_counter1, 2 )

#include "../pp/inc1.bi"
  CU_ASSERT_EQUAL( inc_counter1, 3 )

end sub


private sub ctor () constructor

  fbcu.add_suite("fbc_tests.pp.inc_once1")
  fbcu.add_test("test1", @test1)

end sub

end namespace
