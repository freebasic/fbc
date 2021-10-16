' TEST_MODE : COMPILE_ONLY_FAIL

'' reserve a global symbol

#pragma reserve (shared) symbol

'' error: Duplicated definition
sub symbol()
end sub
