''
''
'' sqltypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_sqltypes_bi__
#define __win_sqltypes_bi__

type SCHAR as byte
type SDWORD as integer
type SWORD as short
type UDWORD as ULONG
type UWORD as USHORT
type SLONG as integer
type SSHORT as short
type SDOUBLE as double
type LDOUBLE as double
type SFLOAT as single
type PTR_ as PVOID
type HENV as PVOID
type HDBC as PVOID
type HSTMT as PVOID
type RETCODE as short
type SQLCHAR as UCHAR
type SQLSCHAR as SCHAR
type SQLINTEGER as SDWORD
type SQLSMALLINT as SWORD
type SQLUINTEGER as UDWORD
type SQLUSMALLINT as UWORD
type SQLPOINTER as PVOID
type SQLHANDLE as any ptr
type SQLHENV as SQLHANDLE
type SQLHDBC as SQLHANDLE
type SQLHSTMT as SQLHANDLE
type SQLHDESC as SQLHANDLE
type SQLRETURN as SQLSMALLINT
type SQLHWND as HWND
type BOOKMARK as ULONG
type SQLWCHAR as wchar_t
#ifdef UNICODE
type SQLTCHAR as SQLWCHAR
#else
type SQLTCHAR as SQLCHAR
#endif
type SQLDATE as ubyte
type SQLDECIMAL as ubyte
type SQLDOUBLE as double
type SQLFLOAT as double
type SQLNUMERIC as ubyte
type SQLREAL as single
type SQLTIME as ubyte
type SQLTIMESTAMP as ubyte
type SQLVARCHAR as ubyte
type ODBCINT64 as longint
type SQLBIGINT as longint
type SQLUBIGINT as ulongint

#define SQLLEN SQLINTEGER
#define SQLROWOFFSET SQLINTEGER
#define SQLROWCOUNT SQLUINTEGER
#define SQLULEN SQLUINTEGER
#define SQLTRANSID DWORD
#define SQLSETPOSIROW SQLUSMALLINT



type DATE_STRUCT
	year as SQLSMALLINT
	month as SQLUSMALLINT
	day as SQLUSMALLINT
end type

type TIME_STRUCT
	hour as SQLUSMALLINT
	minute as SQLUSMALLINT
	second as SQLUSMALLINT
end type

type TIMESTAMP_STRUCT
	year as SQLSMALLINT
	month as SQLUSMALLINT
	day as SQLUSMALLINT
	hour as SQLUSMALLINT
	minute as SQLUSMALLINT
	second as SQLUSMALLINT
	fraction as SQLUINTEGER
end type

type SQL_DATE_STRUCT as DATE_STRUCT
type SQL_TIME_STRUCT as TIME_STRUCT
type SQL_TIMESTAMP_STRUCT as TIMESTAMP_STRUCT

enum SQLINTERVAL
	SQL_IS_YEAR = 1
	SQL_IS_MONTH
	SQL_IS_DAY
	SQL_IS_HOUR
	SQL_IS_MINUTE
	SQL_IS_SECOND
	SQL_IS_YEAR_TO_MONTH
	SQL_IS_DAY_TO_HOUR
	SQL_IS_DAY_TO_MINUTE
	SQL_IS_DAY_TO_SECOND
	SQL_IS_HOUR_TO_MINUTE
	SQL_IS_HOUR_TO_SECOND
	SQL_IS_MINUTE_TO_SECOND
end enum


type SQL_YEAR_MONTH
	year as SQLUINTEGER
	month as SQLUINTEGER
end type

type SQL_YEAR_MONTH_STRUCT as SQL_YEAR_MONTH

type SQL_DAY_SECOND
	day as SQLUINTEGER
	hour as SQLUINTEGER
	minute as SQLUINTEGER
	second as SQLUINTEGER
	fraction as SQLUINTEGER
end type

type SQL_DAY_SECOND_STRUCT as SQL_DAY_SECOND

union SQL_INTERVAL_STRUCT_intval
	year_month as SQL_YEAR_MONTH_STRUCT
	day_second as SQL_DAY_SECOND_STRUCT
end union

type SQL_INTERVAL_STRUCT
	interval_type as SQLINTERVAL
	interval_sign as SQLSMALLINT
	intval as SQL_INTERVAL_STRUCT_intval
end type

#define SQL_MAX_NUMERIC_LEN 16

type SQL_NUMERIC_STRUCT
	precision as SQLCHAR
	scale as SQLSCHAR
	sign as SQLCHAR
	val(0 to 16-1) as SQLCHAR
end type

#ifdef GUID_DEFINED
type SQLGUID as GUID
#else
type SQLGUID
    Data1 as DWORD
    Data2 as WORD 
    Data3 as WORD 
    Data4(0 to 8-1) as UBYTE
end type
#endif

#endif
