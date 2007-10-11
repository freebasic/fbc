#include "fbcu.bi"

namespace fbc_tests.pp.inconce2

sub test2 cdecl

  dim inc_counter2 as integer = 0

#include "inc2.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

#include "../pp/inc2.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

#include "inc2.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

#include once "inc2.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

#include once "../pp/inc2.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

#include "inc2.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

end sub


private sub ctor () constructor

  fbcu.add_suite("fbc_tests.pp.inconce2")
  fbcu.add_test("test2", @test2)

end sub

end namespace
