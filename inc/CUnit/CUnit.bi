'' FreeBASIC binding for CUnit-2.1-3
''
'' based on the C header files:
''   CUnit - A Unit testing framework library for C.
''   Copyright (C) 2001       Anil Kumar
''   Copyright (C) 2004-2006  Anil Kumar, Jerry St.Clair
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Library General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Library General Public License for more details.
''
''   You should have received a copy of the GNU Library General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301  USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/string.bi"
#include once "crt/math.bi"
#include once "CUError.bi"
#include once "TestDB.bi"
#include once "TestRun.bi"

'' The following symbols have been renamed:
''     #define CU_TEST => CU_TEST_

#define CUNIT_CUNIT_H_SEEN
#define CU_VERSION "2.1-3"
const CU_MAX_TEST_NAME_LENGTH = 256
const CU_MAX_SUITE_NAME_LENGTH = 256
const CU_TRUE = 1
const CU_FALSE = 0
#define CU_MAX(a, b) iif((a) >= (b), (a), (b))
#define CU_MIN(a, b) iif((a) >= (b), (b), (a))
#define CU_PASS(msg) CU_assertImplementation(CU_TRUE, __LINE__, "CU_PASS(" #msg ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT(value) CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_FALSE)
#define CU_ASSERT_FATAL(value) CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_TRUE)
#define CU_TEST_(value) CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_FALSE)
#define CU_TEST_FATAL(value) CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_TRUE)
#define CU_FAIL(msg) CU_assertImplementation(CU_FALSE, __LINE__, "CU_FAIL(" #msg ")", __FILE__, "", CU_FALSE)
#define CU_FAIL_FATAL(msg) CU_assertImplementation(CU_FALSE, __LINE__, "CU_FAIL_FATAL(" #msg ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_TRUE(value) CU_assertImplementation((value), __LINE__, "CU_ASSERT_TRUE(" #value ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_TRUE_FATAL(value) CU_assertImplementation((value), __LINE__, "CU_ASSERT_TRUE_FATAL(" #value ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_FALSE(value) CU_assertImplementation(-((value) = 0), __LINE__, "CU_ASSERT_FALSE(" #value ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_FALSE_FATAL(value) CU_assertImplementation(-((value) = 0), __LINE__, "CU_ASSERT_FALSE_FATAL(" #value ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_EQUAL(actual, expected) CU_assertImplementation(-((actual) = (expected)), __LINE__, "CU_ASSERT_EQUAL(" #actual "," #expected ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_EQUAL_FATAL(actual, expected) CU_assertImplementation(-((actual) = (expected)), __LINE__, "CU_ASSERT_EQUAL_FATAL(" #actual "," #expected ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_NOT_EQUAL(actual, expected) CU_assertImplementation(-((actual) <> (expected)), __LINE__, "CU_ASSERT_NOT_EQUAL(" #actual "," #expected ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_NOT_EQUAL_FATAL(actual, expected) CU_assertImplementation(-((actual) <> (expected)), __LINE__, "CU_ASSERT_NOT_EQUAL_FATAL(" #actual "," #expected ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_PTR_EQUAL(actual, expected) CU_assertImplementation(-(cptr(const any ptr, (actual)) = cptr(const any ptr, (expected))), __LINE__, "CU_ASSERT_PTR_EQUAL(" #actual "," #expected ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_PTR_EQUAL_FATAL(actual, expected) CU_assertImplementation(-(cptr(const any ptr, (actual)) = cptr(const any ptr, (expected))), __LINE__, "CU_ASSERT_PTR_EQUAL_FATAL(" #actual "," #expected ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_PTR_NOT_EQUAL(actual, expected) CU_assertImplementation(-(cptr(const any ptr, (actual)) <> cptr(const any ptr, (expected))), __LINE__, "CU_ASSERT_PTR_NOT_EQUAL(" #actual "," #expected ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_PTR_NOT_EQUAL_FATAL(actual, expected) CU_assertImplementation(-(cptr(const any ptr, (actual)) <> cptr(const any ptr, (expected))), __LINE__, "CU_ASSERT_PTR_NOT_EQUAL_FATAL(" #actual "," #expected ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_PTR_NULL(value) CU_assertImplementation(-(NULL = cptr(const any ptr, (value))), __LINE__, "CU_ASSERT_PTR_NULL(" #value ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_PTR_NULL_FATAL(value) CU_assertImplementation(-(NULL = cptr(const any ptr, (value))), __LINE__, "CU_ASSERT_PTR_NULL_FATAL(" #value ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_PTR_NOT_NULL(value) CU_assertImplementation(-(NULL <> cptr(const any ptr, (value))), __LINE__, "CU_ASSERT_PTR_NOT_NULL(" #value ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_PTR_NOT_NULL_FATAL(value) CU_assertImplementation(-(NULL <> cptr(const any ptr, (value))), __LINE__, "CU_ASSERT_PTR_NOT_NULL_FATAL(" #value ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_STRING_EQUAL(actual, expected) CU_assertImplementation(-(strcmp(cptr(const zstring ptr, (actual)), cptr(const zstring ptr, (expected))) = 0), __LINE__, "CU_ASSERT_STRING_EQUAL(" #actual "," #expected ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_STRING_EQUAL_FATAL(actual, expected) CU_assertImplementation(-(strcmp(cptr(const zstring ptr, (actual)), cptr(const zstring ptr, (expected))) = 0), __LINE__, "CU_ASSERT_STRING_EQUAL_FATAL(" #actual "," #expected ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_STRING_NOT_EQUAL(actual, expected) CU_assertImplementation(strcmp(cptr(const zstring ptr, (actual)), cptr(const zstring ptr, (expected))), __LINE__, "CU_ASSERT_STRING_NOT_EQUAL(" #actual "," #expected ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_STRING_NOT_EQUAL_FATAL(actual, expected) CU_assertImplementation(strcmp(cptr(const zstring ptr, (actual)), cptr(const zstring ptr, (expected))), __LINE__, "CU_ASSERT_STRING_NOT_EQUAL_FATAL(" #actual "," #expected ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_NSTRING_EQUAL(actual, expected, count) CU_assertImplementation(-(strncmp(cptr(const zstring ptr, (actual)), cptr(const zstring ptr, (expected)), cuint(count)) = 0), __LINE__, "CU_ASSERT_NSTRING_EQUAL(" #actual "," #expected "," #count ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_NSTRING_EQUAL_FATAL(actual, expected, count) CU_assertImplementation(-(strncmp(cptr(const zstring ptr, (actual)), cptr(const zstring ptr, (expected)), cuint(count)) = 0), __LINE__, "CU_ASSERT_NSTRING_EQUAL_FATAL(" #actual "," #expected "," #count ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_NSTRING_NOT_EQUAL(actual, expected, count) CU_assertImplementation(strncmp(cptr(const zstring ptr, (actual)), cptr(const zstring ptr, (expected)), cuint(count)), __LINE__, "CU_ASSERT_NSTRING_NOT_EQUAL(" #actual "," #expected "," #count ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_NSTRING_NOT_EQUAL_FATAL(actual, expected, count) CU_assertImplementation(strncmp(cptr(const zstring ptr, (actual)), cptr(const zstring ptr, (expected)), cuint(count)), __LINE__, "CU_ASSERT_NSTRING_NOT_EQUAL_FATAL(" #actual "," #expected "," #count ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_DOUBLE_EQUAL(actual, expected, granularity) CU_assertImplementation(-(fabs(cdbl(actual) - (expected)) <= fabs(cdbl(granularity))), __LINE__, "CU_ASSERT_DOUBLE_EQUAL(" #actual "," #expected "," #granularity ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_DOUBLE_EQUAL_FATAL(actual, expected, granularity) CU_assertImplementation(-(fabs(cdbl(actual) - (expected)) <= fabs(cdbl(granularity))), __LINE__, "CU_ASSERT_DOUBLE_EQUAL_FATAL(" #actual "," #expected "," #granularity ")", __FILE__, "", CU_TRUE)
#define CU_ASSERT_DOUBLE_NOT_EQUAL(actual, expected, granularity) CU_assertImplementation(-(fabs(cdbl(actual) - (expected)) > fabs(cdbl(granularity))), __LINE__, "CU_ASSERT_DOUBLE_NOT_EQUAL(" #actual "," #expected "," #granularity ")", __FILE__, "", CU_FALSE)
#define CU_ASSERT_DOUBLE_NOT_EQUAL_FATAL(actual, expected, granularity) CU_assertImplementation(-(fabs(cdbl(actual) - (expected)) > fabs(cdbl(granularity))), __LINE__, "CU_ASSERT_DOUBLE_NOT_EQUAL_FATAL(" #actual "," #expected "," #granularity ")", __FILE__, "", CU_TRUE)
