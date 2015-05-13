#pragma once

#include once "CUnit.bi"
#include once "TestDB.bi"

extern "C"

declare sub CU_automated_run_tests()
declare function CU_list_tests_to_file() as long
declare sub CU_set_output_filename(byval szFilenameRoot as const zstring ptr)

end extern
