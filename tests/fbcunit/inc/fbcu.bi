'' compatibility macro between fbc's test-suite and new fbcunit.bi
'' after everything looks OK, then next step is to remove this 
'' file and update the tests for compatibility with fbcunit.bi

#define FBCU_ENABLE_MACROS 0
#include "fbcunit.bi"

#include once "crt/string.bi"

#ifndef NULL
#define NULL 0
#endif
