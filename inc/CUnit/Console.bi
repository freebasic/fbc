'' FreeBASIC binding for CUnit-2.1-3

#pragma once

#include once "CUnit.bi"
#include once "TestDB.bi"

extern "C"

#define CUNIT_CONSOLE_H_SEEN
declare sub CU_console_run_tests()

end extern
