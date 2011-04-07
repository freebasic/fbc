''
''
'' CUnit -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CUnit_CUnit_bi__
#define __CUnit_CUnit_bi__

#inclib "cunit"

#include once "crt/string.bi"
#include once "crt/math.bi"

#define CU_VERSION "2.1-0"
#define CU_MAX_TEST_NAME_LENGTH 256
#define CU_MAX_SUITE_NAME_LENGTH 256
#define CU_TRUE 1
#define CU_FALSE 0
#define CU_UNREFERENCED_PARAMETER(x) cast( any ptr, x )

#include once "CUnit/CUError.bi"
#include once "CUnit/TestDB.bi"
#include once "CUnit/TestRun.bi"

#define CU_PASS(msg) _
  CU_assertImplementation(CU_TRUE, __LINE__, ("CU_PASS(" #msg ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT(value) _
  CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_FALSE)

#define CU_ASSERT_FATAL(value) _
  CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_TRUE)

#define CU_TEST(value) _
  CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_FALSE)

#define CU_TEST_FATAL(value) _
  CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_TRUE)

#define CU_FAIL(msg) _
  CU_assertImplementation(CU_FALSE, __LINE__, ("CU_FAIL(" #msg ")"), __FILE__, "", CU_FALSE)

#define CU_FAIL_FATAL(msg) _
  CU_assertImplementation(CU_FALSE, __LINE__, ("CU_FAIL_FATAL(" #msg ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_TRUE(value) _
  CU_assertImplementation((value) <> 0, __LINE__, ("CU_ASSERT_TRUE(" #value ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_TRUE_FATAL(value) _
  CU_assertImplementation((value), __LINE__, ("CU_ASSERT_TRUE_FATAL(" #value ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_FALSE(value) _
  CU_assertImplementation((value) = 0, __LINE__, ("CU_ASSERT_FALSE(" #value ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_FALSE_FATAL(value) _
  CU_assertImplementation((value) = 0, __LINE__, ("CU_ASSERT_FALSE_FATAL(" #value ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_EQUAL(actual, expected) _
  CU_assertImplementation(((actual) = (expected)), __LINE__, ("CU_ASSERT_EQUAL(" #actual "," #expected ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_EQUAL_FATAL(actual, expected) _
  CU_assertImplementation(((actual) = (expected)), __LINE__, ("CU_ASSERT_EQUAL_FATAL(" #actual "," #expected ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_NOT_EQUAL(actual, expected) _
  CU_assertImplementation(((actual) <> (expected)), __LINE__, ("CU_ASSERT_NOT_EQUAL(" #actual "," #expected ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_NOT_EQUAL_FATAL(actual, expected) _
  CU_assertImplementation(((actual) <> (expected)), __LINE__, ("CU_ASSERT_NOT_EQUAL_FATAL(" #actual "," #expected ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_PTR_EQUAL(actual, expected) _
  CU_assertImplementation((cast(any ptr,actual) = cast(any ptr,expected)), __LINE__, ("CU_ASSERT_PTR_EQUAL(" #actual "," #expected ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_PTR_EQUAL_FATAL(actual, expected) _
  CU_assertImplementation((cast(any ptr,actual) = cast(any ptr,expected)), __LINE__, ("CU_ASSERT_PTR_EQUAL_FATAL(" #actual "," #expected ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_PTR_NOT_EQUAL(actual, expected) _
  CU_assertImplementation((cast(any ptr,actual) <> cast(any ptr,expected)), __LINE__, ("CU_ASSERT_PTR_NOT_EQUAL(" #actual "," #expected ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_PTR_NOT_EQUAL_FATAL(actual, expected) _
  CU_assertImplementation((cast(any ptr,actual) <> cast(any ptr,expected)), __LINE__, ("CU_ASSERT_PTR_NOT_EQUAL_FATAL(" #actual "," #expected ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_PTR_NULL(value) _
  CU_assertImplementation((NULL = cast(any ptr,value)), __LINE__, ("CU_ASSERT_PTR_NULL(" #value")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_PTR_NULL_FATAL(value) _
  CU_assertImplementation((NULL = cast(any ptr,value)), __LINE__, ("CU_ASSERT_PTR_NULL_FATAL(" #value")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_PTR_NOT_NULL(value) _
  CU_assertImplementation((NULL <> cast(any ptr,value)), __LINE__, ("CU_ASSERT_PTR_NOT_NULL(" #value")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_PTR_NOT_NULL_FATAL(value) _
  CU_assertImplementation((NULL <> cast(any ptr,value)), __LINE__, ("CU_ASSERT_PTR_NOT_NULL_FATAL(" #value")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_STRING_EQUAL(actual, expected) _
  CU_assertImplementation(0=(strcmp((actual), (expected))), __LINE__, ("CU_ASSERT_STRING_EQUAL(" #actual ","  #expected ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_STRING_EQUAL_FATAL(actual, expected) _
  CU_assertImplementation(0=(strcmp((actual), (expected))), __LINE__, ("CU_ASSERT_STRING_EQUAL_FATAL(" #actual ","  #expected ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_STRING_NOT_EQUAL(actual, expected) _
  CU_assertImplementation((strcmp((actual), (expected))), __LINE__, ("CU_ASSERT_STRING_NOT_EQUAL(" #actual ","  #expected ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_STRING_NOT_EQUAL_FATAL(actual, expected) _
  CU_assertImplementation((strcmp((actual), (expected))), __LINE__, ("CU_ASSERT_STRING_NOT_EQUAL_FATAL(" #actual ","  #expected ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_NSTRING_EQUAL(actual, expected, count) _
  CU_assertImplementation(0=(strncmp((actual), (expected), (count))), __LINE__, ("CU_ASSERT_NSTRING_EQUAL(" #actual ","  #expected "," #count ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_NSTRING_EQUAL_FATAL(actual, expected, count) _
  CU_assertImplementation(0=(strncmp((actual), (expected), (count))), __LINE__, ("CU_ASSERT_NSTRING_EQUAL_FATAL(" #actual ","  #expected "," #count ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_NSTRING_NOT_EQUAL(actual, expected, count) _
  CU_assertImplementation((strncmp((actual), (expected), (count))), __LINE__, ("CU_ASSERT_NSTRING_NOT_EQUAL(" #actual ","  #expected "," #count ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_NSTRING_NOT_EQUAL_FATAL(actual, expected, count) _
  CU_assertImplementation((strncmp((actual), (expected), (count))), __LINE__, ("CU_ASSERT_NSTRING_NOT_EQUAL_FATAL(" #actual ","  #expected "," #count ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_DOUBLE_EQUAL(actual, expected, granularity) _
  CU_assertImplementation(((fabs(cast(double,actual) - (expected)) <= fabs(cast(double,granularity)))), __LINE__, ("CU_ASSERT_DOUBLE_EQUAL(" #actual ","  #expected "," #granularity ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_DOUBLE_EQUAL_FATAL(actual, expected, granularity) _
  CU_assertImplementation(((fabs(cast(double,actual) - (expected)) <= fabs(cast(double,granularity)))), __LINE__, ("CU_ASSERT_DOUBLE_EQUAL_FATAL(" #actual ","  #expected "," #granularity ")"), __FILE__, "", CU_TRUE)

#define CU_ASSERT_DOUBLE_NOT_EQUAL(actual, expected, granularity) _
  CU_assertImplementation(((fabs(cast(double,actual) - (expected)) > fabs(cast(double,granularity)))), __LINE__, ("CU_ASSERT_DOUBLE_NOT_EQUAL(" #actual ","  #expected "," #granularity ")"), __FILE__, "", CU_FALSE)

#define CU_ASSERT_DOUBLE_NOT_EQUAL_FATAL(actual, expected, granularity) _
  CU_assertImplementation(((fabs(cast(double,actual) - (expected)) > fabs(cast(double,granularity)))), __LINE__, ("CU_ASSERT_DOUBLE_NOT_EQUAL_FATAL(" #actual ","  #expected "," #granularity ")"), __FILE__, "", CU_TRUE)

#endif
