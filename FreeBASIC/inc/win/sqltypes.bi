''
''
'' sqltypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''

#ifndef __sqltypes_bi__
#define __sqltypes_bi__

type SQLCHAR as ubyte
type SQLSCHAR as byte
type SQLDATE as ubyte
type SQLDECIMAL as ubyte
type SQLDOUBLE as double
type SQLFLOAT as double
type SQLINTEGER as integer
type SQLUINTEGER as uinteger
type SQLNUMERIC as ubyte
type SQLPOINTER as any ptr
type SQLREAL as single
type SQLSMALLINT as short
type SQLUSMALLINT as ushort
type SQLTIME as ubyte
type SQLTIMESTAMP as ubyte
type SQLVARCHAR as ubyte
type SQLRETURN as SQLSMALLINT
type SQLHANDLE as SQLINTEGER
type SQLHENV as SQLHANDLE
type SQLHDBC as SQLHANDLE
type SQLHSTMT as SQLHANDLE
type SQLHDESC as SQLHANDLE

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

enum SQLINTERVAL
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

union SQL_INTERVAL_STRUCT_intval
	year_month as SQL_YEAR_MONTH_STRUCT
	day_second as SQL_DAY_SECOND_STRUCT
end union

type tagSQL_INTERVAL_STRUCT
	interval_type as SQLINTERVAL
	interval_sign as SQLSMALLINT
	intval as SQL_INTERVAL_STRUCT_intval
end type

type SQL_INTERVAL_STRUCT as tagSQL_INTERVAL_STRUCT


#define SQL_MAX_NUMERIC_LEN 16

type tagSQL_NUMERIC_STRUCT
	precision as SQLCHAR
	scale as SQLSCHAR
	sign as SQLCHAR
	val(0 to 16-1) as SQLCHAR
end type

type SQL_NUMERIC_STRUCT as tagSQL_NUMERIC_STRUCT

type tagSQLGUID
	Data1 as DWORD
	Data2 as WORD
	Data3 as WORD
	Data4(0 to 8-1) as BYTE
end type

type SQLGUID as tagSQLGUID
type BOOKMARK as SQLUINTEGER
type SQLWCHAR as ushort
type SQLTCHAR as SQLCHAR

#endif
