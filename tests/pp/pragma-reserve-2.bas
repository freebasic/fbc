' TEST_MODE : COMPILE_ONLY_FAIL

'' accessing a reserved symbol generates an error

#pragma reserve symbol

print sizeof( symbol )
