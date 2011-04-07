
' TEST_MODE : MULTI_MODULE_TEST

#include "multi_module_subs.bi"

public sub TestOK()
  assert(0=0)
end sub

public sub TestFail()
  assert (1=0)
end sub
