'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

'' The following symbols have been renamed:
''     typedef PTR => PTR_

#define __SQLTYPES
type SQLCHAR as ubyte
type SQLSCHAR as byte
type SQLDATE as ubyte
type SQLDECIMAL as ubyte
type SQLDOUBLE as double
type SQLFLOAT as double
type SQLINTEGER as long
type SQLUINTEGER as ulong

#ifdef __FB_64BIT__
	type SQLLEN as INT64
	type SQLULEN as UINT64
	type SQLSETPOSIROW as UINT64
	type SQLROWCOUNT as SQLULEN
	type SQLROWSETSIZE as SQLULEN
	type SQLTRANSID as SQLULEN
	type SQLROWOFFSET as SQLLEN
#else
	type SQLLEN as SQLINTEGER
	type SQLULEN as SQLUINTEGER
	type SQLSETPOSIROW as SQLUSMALLINT
	type SQLROWCOUNT as SQLUINTEGER
	type SQLROWSETSIZE as SQLUINTEGER
	type SQLTRANSID as SQLUINTEGER
	type SQLROWOFFSET as SQLINTEGER
#endif

type SQLNUMERIC as ubyte
type SQLPOINTER as any ptr
type SQLREAL as single
type SQLSMALLINT as short
type SQLUSMALLINT as ushort
type SQLTIME as ubyte
type SQLTIMESTAMP as ubyte
type SQLVARCHAR as ubyte
type SQLRETURN as SQLSMALLINT
type SQLHANDLE as any ptr
type SQLHENV as SQLHANDLE
type SQLHDBC as SQLHANDLE
type SQLHSTMT as SQLHANDLE
type SQLHDESC as SQLHANDLE
type SCHAR as byte
type SDWORD as long
type SWORD as short
type UDWORD as ulong
type UWORD as ushort
type SLONG as long
type SSHORT as short
type SDOUBLE as double
type LDOUBLE as double
type SFLOAT as single
type PTR_ as any ptr
type HENV as any ptr
type HDBC as any ptr
type HSTMT as any ptr
type RETCODE as short
type SQLHWND as HWND
#define __SQLDATE

type tagDATE_STRUCT
	year as SQLSMALLINT
	month as SQLUSMALLINT
	day as SQLUSMALLINT
end type

type DATE_STRUCT as tagDATE_STRUCT
type SQL_DATE_STRUCT as DATE_STRUCT

type tagTIME_STRUCT
	hour as SQLUSMALLINT
	minute as SQLUSMALLINT
	second as SQLUSMALLINT
end type

type TIME_STRUCT as tagTIME_STRUCT
type SQL_TIME_STRUCT as TIME_STRUCT

type tagTIMESTAMP_STRUCT
	year as SQLSMALLINT
	month as SQLUSMALLINT
	day as SQLUSMALLINT
	hour as SQLUSMALLINT
	minute as SQLUSMALLINT
	second as SQLUSMALLINT
	fraction as SQLUINTEGER
end type

type TIMESTAMP_STRUCT as tagTIMESTAMP_STRUCT
type SQL_TIMESTAMP_STRUCT as TIMESTAMP_STRUCT

type SQLINTERVAL as long
enum
	SQL_IS_YEAR = 1
	SQL_IS_MONTH = 2
	SQL_IS_DAY = 3
	SQL_IS_HOUR = 4
	SQL_IS_MINUTE = 5
	SQL_IS_SECOND = 6
	SQL_IS_YEAR_TO_MONTH = 7
	SQL_IS_DAY_TO_HOUR = 8
	SQL_IS_DAY_TO_MINUTE = 9
	SQL_IS_DAY_TO_SECOND = 10
	SQL_IS_HOUR_TO_MINUTE = 11
	SQL_IS_HOUR_TO_SECOND = 12
	SQL_IS_MINUTE_TO_SECOND = 13
end enum

type tagSQL_YEAR_MONTH
	year as SQLUINTEGER
	month as SQLUINTEGER
end type

type SQL_YEAR_MONTH_STRUCT as tagSQL_YEAR_MONTH

type tagSQL_DAY_SECOND
	day as SQLUINTEGER
	hour as SQLUINTEGER
	minute as SQLUINTEGER
	second as SQLUINTEGER
	fraction as SQLUINTEGER
end type

type SQL_DAY_SECOND_STRUCT as tagSQL_DAY_SECOND

union tagSQL_INTERVAL_STRUCT_intval
	year_month as SQL_YEAR_MONTH_STRUCT
	day_second as SQL_DAY_SECOND_STRUCT
end union

type tagSQL_INTERVAL_STRUCT
	interval_type as SQLINTERVAL
	interval_sign as SQLSMALLINT
	intval as tagSQL_INTERVAL_STRUCT_intval
end type

type SQL_INTERVAL_STRUCT as tagSQL_INTERVAL_STRUCT
type ODBCINT64 as longint
type SQLBIGINT as longint
type SQLUBIGINT as ulongint
const SQL_MAX_NUMERIC_LEN = 16

type tagSQL_NUMERIC_STRUCT
	precision as SQLCHAR
	scale as SQLSCHAR
	sign as SQLCHAR
	val(0 to 15) as SQLCHAR
end type

type SQL_NUMERIC_STRUCT as tagSQL_NUMERIC_STRUCT
type SQLGUID as GUID

#ifdef __FB_64BIT__
	type BOOKMARK as SQLULEN
#else
	type BOOKMARK as SQLUINTEGER
#endif

type SQLWCHAR as wchar_t

#ifdef UNICODE
	type SQLTCHAR as SQLWCHAR
#else
	type SQLTCHAR as SQLCHAR
#endif
