'' FreeBASIC binding for CUnit-2.1-3

#pragma once

#include once "CUnit.bi"
#include once "TestDB.bi"

extern "C"

#define CUNIT_CURSES_H_SEEN
declare sub CU_curses_run_tests()

end extern
