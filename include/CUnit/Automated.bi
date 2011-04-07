''
''
'' Automated -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CUnit_Automated_bi__
#define __CUnit_Automated_bi__

#include once "CUnit/CUnit.bi"
#include once "CUnit/TestDB.bi"

declare sub CU_automated_run_tests cdecl alias "CU_automated_run_tests" ()
declare function CU_list_tests_to_file cdecl alias "CU_list_tests_to_file" () as CU_ErrorCode
declare sub CU_set_output_filename cdecl alias "CU_set_output_filename" (byval szFilenameRoot as zstring ptr)

#endif
