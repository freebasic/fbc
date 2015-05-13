/'
 '  Simple example of a CUnit unit test.
 '
 '  This program (crudely) demonstrates a very simple "black box"
 '  test of the standard library functions fprintf() and fread().
 '  It uses suite initialization and cleanup functions to open
 '  and close a common temporary file used by the test functions.
 '  The test functions then write to and read from the temporary
 '  file in the course of testing the library functions.
 '
 '  The 2 test functions are added to a single CUnit suite, and
 '  then run using the CUnit Basic interface.  The output of the
 '  program (on CUnit version 2.0-2) is:
 '
 '           CUnit : A Unit testing framework for C.
 '           http://cunit.sourceforge.net/
 '
 '       Suite: Suite_1
 '         Test: test of fprintf() ... passed
 '         Test: test of fread() ... passed
 '
 '       --Run Summary: Type      Total     Ran  Passed  Failed
 '                      suites        1       1     n/a       0
 '                      tests         2       2       2       0
 '                      asserts       5       5       5       0
 '/
 

#include once "crt/stdio.bi"
#include once "crt/string.bi"
#include once "CUnit/Basic.bi"

'' Pointer to the file used by the tests.
dim shared as FILE ptr temp_file = NULL

/' The suite initialization function.
 ' Opens the temporary file used by the tests.
 ' Returns zero on success, non-zero otherwise.
 '/
function init_suite1 cdecl() as long
   temp_file = fopen("temp.txt", "w+")
   if temp_file = NULL then
      return -1
   else
      return 0
   end if
end function

/' The suite cleanup function.
 ' Closes the temporary file used by the tests.
 ' Returns zero on success, non-zero otherwise.
 '/
function clean_suite1 cdecl() as long
   if fclose(temp_file) <> 0 then
      return -1
   else
      remove( "temp.txt" )
      temp_file = NULL
      return 0
   end if
end function

/' Simple test of fprintf().
 ' Writes test data to the temporary file and checks
 ' whether the expected number of bytes were written.
 '/
sub testFPRINTF cdecl()
   dim as integer i1 = 10

   if temp_file <> NULL then
      CU_ASSERT( fprintf(temp_file, "") = 0)
      CU_ASSERT( fprintf(temp_file, !"Q\n") = 2 )
      CU_ASSERT( fprintf(temp_file, "i1 = %d", i1) = 7 )
   end if
end sub

/' Simple test of fread().
 ' Reads the data previously written by testFPRINTF()
 ' and checks whether the expected characters are present.
 ' Must be run after testFPRINTF().
 '/
sub testFREAD cdecl()
   dim as zstring * 20 buffer

   if temp_file <> NULL then
      rewind(temp_file)
      CU_ASSERT( fread(@buffer, len(ubyte), sizeof(buffer), temp_file) = 9 )
      CU_ASSERT( buffer = !"Q\ni1 = 10" )
   end if
end sub

/' The main() function for setting up and running the tests.
 ' Returns a CUE_SUCCESS on successful running, another
 ' CUnit error code on failure.
 '/
   dim as CU_pSuite pSuite = NULL

   '' initialize the CUnit test registry
   if CU_initialize_registry() <> CUE_SUCCESS then
      end CU_get_error()
   end if

   '' add a suite to the registry
   pSuite = CU_add_suite("Suite_1", @init_suite1, @clean_suite1)
   if pSuite = NULL then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' add the tests to the suite
   '' NOTE - ORDER IS IMPORTANT - MUST TEST fread() AFTER fprintf()
   if CU_add_test(pSuite, "test of fprintf()", @testFPRINTF) = NULL or _
      CU_add_test(pSuite, "test of fread()", @testFREAD) = NULL then
      CU_cleanup_registry()
      end CU_get_error()
   end if

   '' Run all tests using the CUnit Basic interface
   CU_basic_set_mode(CU_BRM_VERBOSE)
   CU_basic_run_tests()
   
   CU_cleanup_registry()
   end CU_get_error()
