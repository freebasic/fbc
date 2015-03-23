#pragma once

#include once "CUnit.bi"
#include once "TestDB.bi"

extern "C"

#define CUNIT_AUTOMATED_H_SEEN
declare sub CU_automated_run_tests()
declare function CU_list_tests_to_file() as CU_ErrorCode
declare sub CU_set_output_filename(byval szFilenameRoot as const zstring ptr)
declare sub CU_automated_enable_junit_xml(byval bFlag as long)
declare sub CU_automated_package_name_set(byval pName as const zstring ptr)
declare function CU_automated_package_name_get() as const zstring ptr

end extern
