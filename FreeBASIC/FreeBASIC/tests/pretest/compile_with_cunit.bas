
' TEST_MODE : CUNIT_COMPATIBLE

#include "fbcu.bi"

namespace fbc_tests.pretest

sub test_true cdecl ()
  CU_ASSERT_TRUE( -1 )
end sub

private sub ctor () constructor

  fbcu.add_suite("fb-tests-cunit-pretests")
  fbcu.add_test("test_true", @test_true)

end sub

end namespace
