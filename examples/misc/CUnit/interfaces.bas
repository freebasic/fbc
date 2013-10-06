
#include once "crt.bi"
#include once "CUnit/Basic.bi"
#include once "CUnit/Console.bi"
#include once "CUnit/Automated.bi"

#define FALSE 0
#define TRUE 1

function init_suite_success cdecl() as long : return 0 : end function
function init_suite_failure cdecl() as long : return -1: end function
function clean_suite_success cdecl() as long : return 0: end function
function clean_suite_failure cdecl() as long : return -1: end function

sub test_success1 cdecl()
   CU_ASSERT(TRUE)
end sub

sub test_success2 cdecl()
   CU_ASSERT_NOT_EQUAL(2, -1)
end sub

sub test_success3 cdecl()
   CU_ASSERT_STRING_EQUAL("string #1", "string #1")
end sub

sub test_success4 cdecl()
   CU_ASSERT_STRING_NOT_EQUAL("string #1", "string #2")
end sub

sub test_failure1 cdecl()
   CU_ASSERT(FALSE)
end sub

sub test_failure2 cdecl()
   CU_ASSERT_EQUAL(2, 3)
end sub

sub test_failure3 cdecl()
   CU_ASSERT_STRING_NOT_EQUAL("string #1", "string #1")
end sub

sub test_failure4 cdecl()
   CU_ASSERT_STRING_EQUAL("string #1", "string #2")
end sub

'' main
   dim as CU_pSuite pSuite = NULL

   '' initialize the CUnit test registry
   if (CUE_SUCCESS <> CU_initialize_registry()) then
      end CU_get_error()
   end if

   '' add a suite to the registry
   pSuite = CU_add_suite("Suite_success", @init_suite_success, @clean_suite_success)
   if (NULL = pSuite) then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' add the tests to the suite
   if ((NULL = CU_add_test(pSuite, "successful_test_1", @test_success1)) or _
       (NULL = CU_add_test(pSuite, "successful_test_2", @test_success2)) or _
       (NULL = CU_add_test(pSuite, "successful_test_3", @test_success3))) then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' add a suite to the registry
   pSuite = CU_add_suite("Suite_init_failure", @init_suite_failure, NULL)
   if (NULL = pSuite) then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' add the tests to the suite
   if ((NULL = CU_add_test(pSuite, "successful_test_1", @test_success1)) or _
       (NULL = CU_add_test(pSuite, "successful_test_2", @test_success2)) or _
       (NULL = CU_add_test(pSuite, "successful_test_3", @test_success3))) then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' add a suite to the registry
   pSuite = CU_add_suite("Suite_clean_failure", NULL, @clean_suite_failure)
   if (NULL = pSuite) then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' add the tests to the suite
   if ((NULL = CU_add_test(pSuite, "successful_test_4", @test_success1)) or _
       (NULL = CU_add_test(pSuite, "failed_test_2",     @test_failure2)) or _
       (NULL = CU_add_test(pSuite, "successful_test_1", @test_success1))) then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' add a suite to the registry
   pSuite = CU_add_suite("Suite_mixed", NULL, NULL)
   if (NULL = pSuite) then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' add the tests to the suite
   if ((NULL = CU_add_test(pSuite, "successful_test_2", @test_success2)) or _
       (NULL = CU_add_test(pSuite, "failed_test_4",     @test_failure4)) or _
       (NULL = CU_add_test(pSuite, "failed_test_2",     @test_failure2)) or _
       (NULL = CU_add_test(pSuite, "successful_test_4", @test_success4))) then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' Run all tests using the basic interface
   CU_basic_set_mode(CU_BRM_VERBOSE)
   CU_basic_run_tests()
   printf(!"\n")
   CU_basic_show_failures(CU_get_failure_list())
   printf(!"\n\n")

   '' Run all tests using the automated interface
   CU_automated_run_tests()
   CU_list_tests_to_file()

   '' Run all tests using the console interface
   CU_console_run_tests()

   '' Clean up registry and return
   CU_cleanup_registry()
   end CU_get_error()
