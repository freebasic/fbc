
' TEST_MODE : FBCUNIT_COMPATIBLE

#include "fbcunit.bi"

namespace fbc_tests.pretest

sub test_true cdecl ()
  CU_ASSERT_TRUE( -1 )
end sub

private sub ctor () constructor

  fbcu.add_suite("fbc_tests.pretest.compile_with_fbcunit")
  fbcu.add_test("test_true", @test_true)

end sub

end namespace
