#include "fbcu.bi"

namespace fbc_tests.pp.inconce2self

sub test2self cdecl

  dim inc_counter2 as integer = 0

#include "inc2self.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

#include "inc2self.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

#include once "inc2self.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

#include once "inc2self.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

#include "inc2self.bi"
  CU_ASSERT_EQUAL( inc_counter2, 1 )

end sub

private sub ctor () constructor

  fbcu.add_suite("fbc_tests.pp.inc_once2_self")
  fbcu.add_test("test2self", @test2self)

end sub

end namespace
