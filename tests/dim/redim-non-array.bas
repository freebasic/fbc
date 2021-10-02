' TEST_MODE : COMPILE_ONLY_FAIL

dim as integer d

scope
  redim d(10)   '' should induce a compiler error message
end scope
