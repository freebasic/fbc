''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' runtime-lib helpers -- for when simple calls can't be done, because args of
'' 						  diff types, quirk syntaxes, etc
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"
#include once "inc\rtl.bi"

type RTLCTX
	datainited		as integer
	lastlabel		as FBSYMBOL ptr
    labelcnt 		as integer
end type


declare function 	hMultithread_cb		( byval sym as FBSYMBOL ptr ) as integer
declare function 	hGfxlib_cb			( byval sym as FBSYMBOL ptr ) as integer
declare function 	hMultinput_cb		( byval sym as FBSYMBOL ptr ) as integer
declare function    hPrinter_cb         ( byval sym as FBSYMBOL ptr ) as integer
declare function    hSerial_cb          ( byval sym as FBSYMBOL ptr ) as integer
declare function 	hPorts_cb			( byval sym as FBSYMBOL ptr ) as integer


''globals
	dim shared ctx as RTLCTX

	dim shared rtlLookupTB(0 to FB_RTL_INDEXES-1) as FBSYMBOL ptr


'':::::::::::::::::::::::::::::::::::::::::::::::::::
'' FUNCTIONS
'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
ifuncdata:

'' fb_StrConcat ( byref dst as string, _
''				  byref str1 as any, byval str1len as integer, _
''				  byref str2 as any, byval str2len as integer ) as string
data @FB_RTL_STRCONCAT,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_StrCompare ( byref str1 as any, byval str1len as integer, _
''				   byref str2 as any, byval str2len as integer ) as integer
'' returns: 0= equal; -1=str1 < str2; 1=str1 > str2
data @FB_RTL_STRCOMPARE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_StrAssign ( byref dst as any, byval dst_len as integer, _
'' 				  byref src as any, byval src_len as integer, _
''                byval fillrem as integer = 1 ) as string
data @FB_RTL_STRASSIGN,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1
'' fb_StrConcatAssign ( byref dst as any, byval dst_len as integer, _
'' 				        byref src as any, byval src_len as integer, _
''					    byval fillrem as integer = 1 ) as string
data @FB_RTL_STRCONCATASSIGN,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1
'' fb_StrDelete ( byref str as string ) as void
data @FB_RTL_STRDELETE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_StrAllocTempResult ( byref str as string ) as string
data @FB_RTL_STRALLOCTMPRES,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_StrAllocTempDescV ( byref str as string ) as string
data @FB_RTL_STRALLOCTMPDESCV,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_StrAllocTempDescF ( byref str as any, byval strlen as integer ) as string
data @FB_RTL_STRALLOCTMPDESCF,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_StrAllocTempDescZ ( byval str as string ) as string
data @FB_RTL_STRALLOCTMPDESCZ,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE

'' fb_LongintDIV ( byval x as longint, byval y as longint ) as longint
data @FB_RTL_LONGINTDIV,"", _
	 FB_SYMBTYPE_LONGINT,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE
'' fb_ULongintDIV ( byval x as ulongint, byval y as ulongint ) as ulongint
data @FB_RTL_ULONGINTDIV,"", _
	 FB_SYMBTYPE_ULONGINT,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE
'' fb_LongintMOD ( byval x as longint, byval y as longint ) as longint
data @FB_RTL_LONGINTMOD,"", _
	 FB_SYMBTYPE_LONGINT,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE
'' fb_ULongintMOD ( byval x as ulongint, byval y as ulongint ) as ulongint
data @FB_RTL_ULONGINTMOD,"", _
	 FB_SYMBTYPE_ULONGINT,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE
'' fb_Dbl2ULongint ( byval x as double ) as ulongint
data @FB_RTL_DBL2ULONGINT,"", _
	 FB_SYMBTYPE_ULONGINT,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE

'' fb_ArrayRedim CDECL ( array() as ANY, byval elementlen as integer, _
''					     byval isvarlen as integer, _
''						 byval dimensions as integer, ... ) as integer
data @FB_RTL_ARRAYREDIM,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 INVALID,FB_ARGMODE_VARARG, FALSE
'' fb_ArrayRedimPresv CDECL ( array() as ANY, byval elementlen as integer, _
''					          byval isvarlen as integer, _
''						      byval dimensions as integer, ... ) as integer
data @FB_RTL_ARRAYREDIMPRESV,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 INVALID,FB_ARGMODE_VARARG, FALSE
'' fb_ArrayErase ( array() as ANY, byval isvarlen as integer ) as integer
data @FB_RTL_ARRAYERASE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_ArrayClear ( array() as ANY, byval isvarlen as integer ) as integer
data @FB_RTL_ARRAYCLEAR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_ArrayLBound ( array() as ANY, byval dimension as integer ) as integer
data @FB_RTL_ARRAYLBOUND,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_ArrayUBound ( array() as ANY, byval dimension as integer ) as integer
data @FB_RTL_ARRAYUBOUND,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_ArraySetDesc CDECL ( array() as ANY, byref arraydata as any, byval elementlen as integer, _
''						   byval dimensions as integer, ... ) as void
data @FB_RTL_ARRAYSETDESC,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 INVALID,FB_ARGMODE_VARARG, FALSE
'' fb_ArrayStrErase ( array() as any ) as void
data @FB_RTL_ARRAYSTRERASE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE
'' fb_ArrayAllocTempDesc CDECL ( byref pdesc as any ptr, arraydata as any, byval elementlen as integer, _
''						         byval dimensions as integer, ... ) as void ptr
data @FB_RTL_ARRAYALLOCTMPDESC,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 INVALID,FB_ARGMODE_VARARG, FALSE
'' fb_ArrayFreeTempDesc ( byval pdesc as any ptr) as void
data @FB_RTL_ARRAYFREETMPDESC,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE

'' fb_ArraySngBoundChk ( byval idx as integer, byval ubound as integer, _
''						 byval linenum as integer ) as any ptr
data @FB_RTL_ARRAYSNGBOUNDCHK,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_ArrayBoundChk ( byval idx as integer, byval lbound as integer, byval ubound as integer, _
''						byval linenum as integer ) as any ptr
data @FB_RTL_ARRAYBOUNDCHK,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_NullPtrChk ( byval p as any ptr, byval linenum as integer ) as any ptr
data @FB_RTL_NULLPTRCHK,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

''
'' fb_IntToStr ( byval number as integer ) as string
data @FB_RTL_INT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_UIntToStr ( byval number as uinteger ) as string
data @FB_RTL_UINT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE
'' fb_LongintToStr ( byval number as longint ) as string
data @FB_RTL_LONGINT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE
'' fb_ULongintToStr ( byval number as ulongint ) as string
data @FB_RTL_ULONGINT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE
'' fb_FloatToStr ( byval number as single ) as string
data @FB_RTL_FLT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE
'' fb_DoubleToStr ( byval number as double ) as string
data @FB_RTL_DBL2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE

'' fb_StrMid ( byref str as string, byval start as integer, byval len as integer ) as string
data @FB_RTL_STRMID,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_StrAssignMid ( byref dst as string, byval start as integer, byval len as integer, src as string ) as void
data @FB_RTL_STRASSIGNMID,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_StrFill1 ( byval cnt as integer, byval char as integer ) as string
data @FB_RTL_STRFILL1,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_StrFill2 ( byval cnt as integer, byref str as string ) as string
data @FB_RTL_STRFILL2,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_StrLen ( byref str as any, byval strlen as integer ) as integer
data @FB_RTL_STRLEN,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' lset ( byref dst as string, byref src as string ) as void
data @FB_RTL_STRLSET,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_ASC ( byref str as string, byval pos as integer = 0 ) as uinteger
data @FB_RTL_STRASC, "", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, 0
'' fb_CHR CDECL ( byval args as integer, ... ) as string
data @FB_RTL_STRCHR, "", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 INVALID,FB_ARGMODE_VARARG, FALSE
'' fb_StrInstr ( byval start as integer, srcstr as string, pattern as string ) as integer
data @FB_RTL_STRINSTR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_StrInstrAny ( byval start as integer, srcstr as string, pattern as string ) as integer
data @FB_RTL_STRINSTRANY,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_TRIM ( str as string ) as string
data @FB_RTL_STRTRIM,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_TrimAny ( str as string ) as string
data @FB_RTL_STRTRIMANY,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_TrimEx ( str as string, str as pattern ) as string
data @FB_RTL_STRTRIMEX,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_RTRIM ( str as string ) as string
data @FB_RTL_STRRTRIM,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_RTrimAny ( str as string ) as string
data @FB_RTL_STRRTRIMANY,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_RTrimEx ( str as string, str as pattern ) as string
data @FB_RTL_STRRTRIMEX,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_LTRIM ( str as string ) as string
data @FB_RTL_STRLTRIM,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_LTrimAny ( str as string ) as string
data @FB_RTL_STRLTRIMANY,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_LTrimEx ( str as string, str as pattern ) as string
data @FB_RTL_STRLTRIMEX,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE


''
'' fb_CpuDetect ( ) as uinteger
data @FB_RTL_CPUDETECT,"", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 0
'' fb_Init ( byval argc as integer, byval argv as zstring ptr ptr ) as void
data @FB_RTL_INIT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_POINTER+FB_SYMBTYPE_CHAR,FB_ARGMODE_BYVAL, FALSE
'' fb_InitSignals ( ) as void
data @FB_RTL_INITSIGNALS,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' fb_InitProfile ( ) as void
data @FB_RTL_INITPROFILE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' fb_CallCTORS CDECL ( ) as void
data @FB_RTL_INITCTOR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 0
'' __main CDECL ( ) as void
data @FB_RTL_INITCRTCTOR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 0
'' fb_End ( byval errlevel as integer ) as void
data @FB_RTL_END,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

''
'' fb_DataRestore ( byval labeladdrs as void ptr ) as void
data @FB_RTL_DATARESTORE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE
'' fb_DataReadStr ( byref dst as any, byval dst_size as integer, _
''                  byval fillrem as integer = 1 ) as void
data @FB_RTL_DATAREADSTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1
'' fb_DataReadByte ( byref dst as byte ) as void
data @FB_RTL_DATAREADBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYREF, FALSE
'' fb_DataReadShort ( byref dst as short ) as void
data @FB_RTL_DATAREADSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYREF, FALSE
'' fb_DataReadInt ( byref dst as integer ) as void
data @FB_RTL_DATAREADINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE
'' fb_DataReadLongint ( byref dst as longint ) as void
data @FB_RTL_DATAREADLONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYREF, FALSE
'' fb_DataReadUByte ( byref dst as ubyte ) as void
data @FB_RTL_DATAREADUBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYREF, FALSE
'' fb_DataReadUShort ( byref dst as ushort ) as void
data @FB_RTL_DATAREADUSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYREF, FALSE
'' fb_DataReadUInt ( byref dst as uinteger ) as void
data @FB_RTL_DATAREADUINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYREF, FALSE
'' fb_DataReadULongint ( byref dst as ulongint ) as void
data @FB_RTL_DATAREADULONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYREF, FALSE
'' fb_DataReadSingle ( byref dst as single ) as void
data @FB_RTL_DATAREADSINGLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, FALSE
'' fb_DataReadDouble ( byref dst as single ) as void
data @FB_RTL_DATAREADDOUBLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYREF, FALSE

''
'' fb_Pow CDECL ( byval x as double, byval y as double ) as double
data @FB_RTL_POW,"pow", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE
'' fb_SGNSingle ( byval x as single ) as integer
data @FB_RTL_SGNSINGLE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE
'' fb_SGNDouble ( byval x as double ) as integer
data @FB_RTL_SGNDOUBLE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE
'' fb_FIXSingle ( byval x as single ) as single
data @FB_RTL_FIXSINGLE,"", _
	 FB_SYMBTYPE_SINGLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE
'' fb_FIXDouble ( byval x as double ) as double
data @FB_RTL_FIXDOUBLE,"", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE
'' asin CDECL ( byval x as double ) as double
data @FB_RTL_ASIN,"asin", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE
'' acos CDECL ( byval x as double ) as double
data @FB_RTL_ACOS,"acos", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE
'' log CDECL ( byval x as double ) as double
data @FB_RTL_LOG,"log", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE

''
'' fb_PrintVoid ( byval filenum as integer = 0, byval mask as integer ) as void
data @FB_RTL_PRINTVOID,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void
data @FB_RTL_PRINTBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void
data @FB_RTL_PRINTUBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void
data @FB_RTL_PRINTSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void
data @FB_RTL_PRINTUSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void
data @FB_RTL_PRINTINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void
data @FB_RTL_PRINTUINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void
data @FB_RTL_PRINTLONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void
data @FB_RTL_PRINTULONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void
data @FB_RTL_PRINTSINGLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void
data @FB_RTL_PRINTDOUBLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void
data @FB_RTL_PRINTSTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

''
'' fb_LPrintVoid ( byval filenum as integer = 0, byval mask as integer ) as void
data @FB_RTL_LPRINTVOID,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void
data @FB_RTL_LPRINTBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void
data @FB_RTL_LPRINTUBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void
data @FB_RTL_LPRINTSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void
data @FB_RTL_LPRINTUSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void
data @FB_RTL_LPRINTINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void
data @FB_RTL_LPRINTUINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void
data @FB_RTL_LPRINTLONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void
data @FB_RTL_LPRINTULONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void
data @FB_RTL_LPRINTSINGLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void
data @FB_RTL_LPRINTDOUBLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void
data @FB_RTL_LPRINTSTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' spc ( byval filenum as integer = 0, byval n as integer ) as void
data @FB_RTL_PRINTSPC,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' tab ( byval filenum as integer = 0, byval newcol as integer ) as void
data @FB_RTL_PRINTTAB,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

''
'' fb_WriteVoid ( byval filenum as integer = 0, byval mask as integer ) as void
data @FB_RTL_WRITEVOID,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void
data @FB_RTL_WRITEBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void
data @FB_RTL_WRITEUBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void
data @FB_RTL_WRITESHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void
data @FB_RTL_WRITEUSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void
data @FB_RTL_WRITEINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void
data @FB_RTL_WRITEUINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void
data @FB_RTL_WRITELONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void
data @FB_RTL_WRITEULONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void
data @FB_RTL_WRITESINGLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void
data @FB_RTL_WRITEDOUBLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_WriteString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void
data @FB_RTL_WRITESTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintUsingInit ( fmtstr as string ) as integer
data @FB_RTL_PRINTUSGINIT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_PrintUsingStr ( byval filenum as integer, s as string, byval mask as integer ) as integer
data @FB_RTL_PRINTUSGSTR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintUsingVal ( byval filenum as integer, byval v as double, byval mask as integer ) as integer
data @FB_RTL_PRINTUSGVAL,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_PrintUsingEnd ( byval filenum as integer ) as integer
data @FB_RTL_PRINTUSGEND,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_LPrintUsingInit ( fmtstr as string ) as integer
data @FB_RTL_LPRINTUSGINIT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE


'' locate( byval row as integer = 0, byval col as integer = 0, byval cursor as integer = -1 ) as integer
data @FB_RTL_LOCATE_FN, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1
'' locate( byval row as integer = 0, byval col as integer = 0, byval cursor as integer = -1 ) as integer
data @FB_RTL_LOCATE_SUB, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_ConsoleView ( byval toprow as integer = 0, byval botrow as integer = 0 ) as void
data @FB_RTL_CONSOLEVIEW,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0
'' fb_ReadXY ( byval x as integer, byval y as integer, byval colorflag as integer ) as integer
data @FB_RTL_CONSOLEREADXY,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0


''
'' fb_MemCopy cdecl ( dst as any, src as any, byval bytes as integer ) as void
data @FB_RTL_MEMCOPY,"memcpy", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_MemSwap ( dst as any, src as any, byval bytes as integer ) as void
data @FB_RTL_MEMSWAP,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_StrSwap ( str1 as any, byval str1len as integer, str2 as any, byval str2len as integer ) as void
data @FB_RTL_STRSWAP,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_MemCopyClear ( dst as any, byval dstlen as integer, src as any, byval srclen as integer ) as void
data @FB_RTL_MEMCOPYCLEAR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

''
'' fb_FileOpen( s as string, byval mode as integer, byval access as integer,
''		        byval lock as integer, byval filenum as integer, byval len as integer ) as integer
data @FB_RTL_FILEOPEN,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_FileOpenShort( mode as string, byval filenum as integer,
''                   filename as string, byval len as integer,
''                   access_mode as string, lock_mode as string) as integer
data @FB_RTL_FILEOPEN_SHORT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_FileOpenCons( s as string, byval mode as integer, byval access as integer,
''		           byval lock as integer, byval filenum as integer, byval len as integer ) as integer
data @FB_RTL_FILEOPEN_CONS,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_FileOpenErr( s as string, byval mode as integer, byval access as integer,
''		           byval lock as integer, byval filenum as integer, byval len as integer ) as integer
data @FB_RTL_FILEOPEN_ERR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_FileOpenPipe( s as string, byval mode as integer, byval access as integer,
''		           byval lock as integer, byval filenum as integer, byval len as integer ) as integer
data @FB_RTL_FILEOPEN_PIPE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_FileOpenScrn( s as string, byval mode as integer, byval access as integer,
''		           byval lock as integer, byval filenum as integer, byval len as integer ) as integer
data @FB_RTL_FILEOPEN_SCRN,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_FileOpenLpt( s as string, byval mode as integer, byval access as integer,
''		           byval lock as integer, byval filenum as integer, byval len as integer ) as integer
data @FB_RTL_FILEOPEN_LPT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_FileOpenCom( s as string, byval mode as integer, byval access as integer,
''		           byval lock as integer, byval filenum as integer, byval len as integer ) as integer
data @FB_RTL_FILEOPEN_COM,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_FileClose	( byval filenum as integer ) as integer
data @FB_RTL_FILECLOSE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_FilePut ( byval filenum as integer, byval offset as uinteger, value as any, byval valuelen as integer ) as integer
data @FB_RTL_FILEPUT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_FilePutStr ( byval filenum as integer, byval offset as uinteger, str as any, byval strlen as integer ) as integer
data @FB_RTL_FILEPUTSTR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_FilePutArray ( byval filenum as integer, byval offset as uinteger, array() as any ) as integer
data @FB_RTL_FILEPUTARRAY,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE
'' fb_FileGet ( byval filenum as integer, byval offset as uinteger, value as any, byval valuelen as integer ) as integer
data @FB_RTL_FILEGET,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_FileGetStr ( byval filenum as integer, byval offset as uinteger, str as any, byval strlen as integer ) as integer
data @FB_RTL_FILEGETSTR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_FileGetArray ( byval filenum as integer, byval offset as uinteger, array() as any ) as integer
data @FB_RTL_FILEGETARRAY,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE

'' fb_FileTell ( byval filenum as integer ) as uinteger
data @FB_RTL_FILETELL,"", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_FileSeek ( byval filenum as integer, byval newpos as uinteger ) as integer
data @FB_RTL_FILESEEK,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE

'' fb_FileStrInput ( byval bytes as integer, byval filenum as integer = 0 ) as string
data @FB_RTL_FILESTRINPUT, "", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_FileLineInput ( byval filenum as integer, _
''					  dst as any, byval dstlen as integer, byval fillrem as integer = 1 ) as integer
data @FB_RTL_FILELINEINPUT, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1
'' fb_LineInput ( text as string, _
''				  dst as any, byval dstlen as integer, byval fillrem as integer = 1, _
''				  byval addquestion as integer, byval addnewline as integer ) as integer
data @FB_RTL_CONSOLELINEINPUT, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1

'' fb_FileInput ( byval filenum as integer ) as integer
data @FB_RTL_FILEINPUT, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_ConsoleInput ( text as string,  byval addquestion as integer, _
''				     byval addnewline as integer ) as integer
data @FB_RTL_CONSOLEINPUT, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_InputByte ( x as byte ) as void
data @FB_RTL_INPUTBYTE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYREF, FALSE
'' fb_InputShort ( x as short ) as void
data @FB_RTL_INPUTSHORT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYREF, FALSE
'' fb_InputInt ( x as integer ) as void
data @FB_RTL_INPUTINT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE
'' fb_InputLongint ( x as longint ) as void
data @FB_RTL_INPUTLONGINT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYREF, FALSE
'' fb_InputSingle ( x as single ) as void
data @FB_RTL_INPUTSINGLE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, FALSE
'' fb_InputDouble ( x as double ) as void
data @FB_RTL_INPUTDOUBLE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYREF, FALSE
'' fb_InputString ( x as any, byval strlen as integer, byval fillrem as integer = 1 ) as void
data @FB_RTL_INPUTSTR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1

'' fb_FileLock ( byval inipos as integer, byval endpos as integer ) as integer
data @FB_RTL_FILELOCK,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0
'' fb_FileUnlock ( byval inipos as integer, byval endpos as integer ) as integer
data @FB_RTL_FILEUNLOCK,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' rename ( byval oldname as string, byval newname as string ) as integer
data @FB_RTL_FILERENAME,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE

'' width( byval cols as integer = -1, byval width_arg as integer = -1 ) as integer
data @FB_RTL_WIDTH, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1
'' width( dev as string, byval width_arg as integer = -1 ) as integer
data @FB_RTL_WIDTHDEV, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, -1
'' width( byval fnum as integer, byval width_arg as integer = -1 ) as integer
data @FB_RTL_WIDTHFILE, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, -1

''
'' fb_ErrorThrow cdecl ( byval linenum as integer, _
''						 byval reslabel as any ptr, byval resnxtlabel as any ptr ) as integer
data @FB_RTL_ERRORTHROW,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE
''
'' fb_ErrorThrowEx cdecl ( byval errnum as integer, byval linenum as integer, _
''						   byval reslabel as any ptr, byval resnxtlabel as any ptr ) as any ptr
data @FB_RTL_ERRORTHROWEX,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE
'' fb_ErrorSetHandler( byval newhandler as any ptr ) as any ptr
data @FB_RTL_ERRORSETHANDLER,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE

'' fb_ErrorGetNum( ) as integer
data @FB_RTL_ERRORGETNUM, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' fb_ErrorSetNum( byval errnum as integer ) as void
data @FB_RTL_ERRORSETNUM, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_ErrorResume( ) as any ptr
data @FB_RTL_ERRORRESUME, "", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 0
'' fb_ErrorResumeNext( ) as any ptr
data @FB_RTL_ERRORRESUMENEXT, "", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 0

''
'' fb_GfxPset ( byref target as any, byval x as single, byval y as single, byval color as uinteger, _
''				byval coordType as integer, byval ispreset as integer ) as void
data @FB_RTL_GFXPSET, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxPoint ( byref target as any, byval x as single, byval y as single ) as integer
data @FB_RTL_GFXPOINT, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxLine ( byref target as any, byval x1 as single = 0, byval y1 as single = 0, byval x2 as single = 0, byval y2 as single = 0, _
''              byval color as uinteger = DEFAULT_COLOR, byval line_type as integer = LINE_TYPE_LINE, _
''              byval style as uinteger = &hFFFF, byval coordType as integer = COORD_TYPE_AA ) as integer
data @FB_RTL_GFXLINE, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 9, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxEllipse ( byref target as any, byval x as single, byval y as single, byval radius as single, _
''				   byval color as uinteger = DEFAULT_COLOR, byval aspect as single = 0.0, _
''				   byval iniarc as single = 0.0, byval endarc as single = 6.283185, _
''				   byval FillFlag as integer = 0, byval CoordType as integer = COORD_TYPE_A ) as integer
data @FB_RTL_GFXCIRCLE, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 10, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxPaint ( byref target as any, byval x as single, byval y as single, byval color as uinteger = DEFAULT_COLOR, _
''				 byval border_color as uinteger = DEFAULT_COLOR, pattern as string, _
''				 byval mode as integer = PAINT_TYPE_FILL, byval coord_type as integer = COORD_TYPE_A ) as integer
data @FB_RTL_GFXPAINT, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 8, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxDraw ( byval target as any, cmd as string )
data @FB_RTL_GFXDRAW, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_GfxView ( byval x1 as integer = -32768, byval y1 as integer = -32768, _
''              byval x1 as integer = -32768, byval y1 as integer = -32768, _
''				byval fillcol as uinteger = DEFAULT_COLOR, byval bordercol as uinteger = DEFAULT_COLOR, _
''              byval screenFlag as integer = 0) as integer
data @FB_RTL_GFXVIEW, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 7, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxWindow (byval x1 as single = 0, byval y1 as single = 0, byval x2 as single = 0, _
'' 				 byval y2 as single = 0, byval screenflag as integer = 0 ) as integer
data @FB_RTL_GFXWINDOW, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_GfxPalette( byval attribute as integer = -1, byval r as integer = -1, _
''				  byval g as integer = -1, byval b as integer = -1 ) as void
data @FB_RTL_GFXPALETTE, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxPaletteUsing ( array as integer ) as void
data @FB_RTL_GFXPALETTEUSING, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE

'' fb_GfxPaletteGet( byval attribute as integer, byref r as integer, _
''					 byref g as integer, byref b as integer ) as void
data @FB_RTL_GFXPALETTEGET, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE

'' fb_GfxPaletteGetUsing ( array as integer ) as void
data @FB_RTL_GFXPALETTEGETUSING, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE

'' fb_GfxPut ( byref target as any, byval x as single, byval y as single, byref array as any, _
''			   byval x1 as integer = &hFFFF0000, byval y1 as integer = &hFFFF0000, _
''			   byval x2 as integer = &hFFFF0000, byval y2 as integer = &hFFFF0000, _
''			   byval coordType as integer, byval mode as integer, byval alpha as integer = -1, _
''			   byval func as function( src as uinteger, dest as uinteger ) as uinteger = 0 ) as integer
data @FB_RTL_GFXPUT, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 12, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxGet ( byref target as any, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, _
''			   byref array as any, byval coordType as integer, array() as any ) as integer
data @FB_RTL_GFXGET, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 8, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE

'' fb_GfxScreen ( byval w as integer, byval h as integer = 0, byval depth as integer = 0, _
''                byval fullscreenFlag as integer = 0 ) as integer
data @FB_RTL_GFXSCREENSET, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_GfxScreenRes ( byval w as integer, byval h as integer, byval depth as integer = 8, _
''					 byval num_pages as integer = 1, byval flags as integer = 0, byval refresh_rate as integer = 0 )
data @FB_RTL_GFXSCREENRES, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,8, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_ProfileBeginCall ( procname as string ) as any ptr
data @FB_RTL_PROFILEBEGINCALL, "", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE

'' fb_ProfileEndCall ( call as any ptr ) as void
data @FB_RTL_PROFILEENDCALL, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE

'' fb_EndProfile ( byval errlevel as integer ) as integer
data @FB_RTL_PROFILEEND, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' fb_GfxBload ( filename as string, byval dest as any ptr = NULL ) as integer
data @"bload", "fb_GfxBload", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, TRUE,NULL

'' fb_GfxBsave ( filename as string, byval src as any ptr, byval length as integer ) as integer
data @"bsave", "fb_GfxBsave", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 3, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, 0


'' fb_GfxFlip ( byval frompage as integer = -1, byval topage as integer = -1 ) as void
data @"flip", "fb_GfxFlip", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' pcopy ( byval frompage as integer, byval topage as integer ) as void
data @"pcopy", "fb_GfxFlip", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

data @"screencopy", "fb_GfxFlip", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxCursor ( number as integer) as single
data @"pointcoord", "fb_GfxCursor", _
	 FB_SYMBTYPE_SINGLE,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxPMap ( byval Coord as single, byval num as integer ) as single
data @"pmap", "fb_GfxPMap", _
	 FB_SYMBTYPE_SINGLE,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_Out( byval port as ushort, byval data as ubyte ) as void
data @"out", "fb_Out", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hPorts_cb, TRUE, FALSE, _
	 2, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYVAL, FALSE

'' fb_In( byval port as ushort ) as integer
data @"inp", "fb_In", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hPorts_cb, TRUE, FALSE, _
	 1, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE

'' fb_Wait ( byval port as ushort, byval and_mask as integer, byval xor_mask as integer = 0 )
data @"wait", "fb_Wait", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hPorts_cb, TRUE, FALSE, _
	 3, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_GfxWaitVSync ( void ) as integer
data @"screensync", "fb_GfxWaitVSync", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 0

'' fb_GfxSetPage ( byval work_page as integer = -1, byval visible_page as integer = -1 ) as void
data @"screenset", "fb_GfxSetPage", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxLock ( ) as void
data @"screenlock", "fb_GfxLock", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 0

'' fb_GfxUnlock ( ) as void
data @"screenunlock", "fb_GfxUnlock", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxScreenPtr ( ) as any ptr
data @"screenptr", "fb_GfxScreenPtr", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 0

'' fb_GfxSetWindowTitle ( title as string ) as void
data @"windowtitle", "fb_GfxSetWindowTitle", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_Multikey ( byval scancode as integer ) as integer
data @"multikey", "fb_Multikey", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxGetMouse ( byref x as integer, byref y as integer, byref z as integer, byref buttons as integer ) as integer
data @"getmouse", "fb_GetMouse", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, TRUE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0

'' fb_GfxSetMouse ( byval x as integer = -1, byval y as integer = -1, byval cursor as integer = -1 ) as integer
data @"setmouse", "fb_SetMouse", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, TRUE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxGetJoystick ( byval id as integer, byref buttons as integer = 0, _
''					   byref a1 as single = 0, byref a2 as single = 0, byref a3 as single = 0, _
''					   byref a4 as single = 0, byref a5 as single = 0, byref a6 as single = 0 ) as integer
data @"getjoystick", "fb_GfxGetJoystick", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 8, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0

'' fb_GfxScreenInfo ( byref w as integer, byref h as integer, byref depth as integer, _
''					  byref bpp as integer, byref pitch as integer, byref driver_name as string ) as void
data @"screeninfo", "fb_GfxScreenInfo", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 7, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, TRUE,""

'' fb_GfxScreenList ( byval depth as integer ) as integer
data @"screenlist", "fb_GfxScreenList", _
FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_GfxImageCreate ( byval width as integer, byval height as integer ) as any ptr
data @"imagecreate", "fb_GfxImageCreate", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,&hFEFF00FF

'' fb_GfxImageDestroy ( byval image as any ptr ) as void
data @"imagedestroy", "fb_GfxImageDestroy", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE


'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' fb_FileFree ( ) as integer
data @"freefile", "fb_FileFree", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' fb_FileEof ( byval filenum as integer ) as integer
data @"eof", "fb_FileEof", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_FileKill ( s as string ) as integer
data @"kill", "fb_FileKill", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_CVD ( str as string ) as double
data @"cvd","fb_CVD", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
data @"cvs","fb_CVS", _
	 FB_SYMBTYPE_SINGLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_CVI ( str as string ) as integer
data @"cvi","fb_CVI", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
data @"cvl","fb_CVI", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_CVSHORT ( str as string ) as short
data @"cvshort","fb_CVSHORT", _
	 FB_SYMBTYPE_SHORT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_CVLONGINT ( str as string ) as longint
data @"cvlongint","fb_CVLONGINT", _
	 FB_SYMBTYPE_LONGINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_HEX_b ( byval number as byte ) as string
data @"hex","fb_HEX_b", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE
'' fb_HEX_s ( byval number as short ) as string
data @"hex","fb_HEX_s", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE
'' fb_HEX_i ( byval number as integer ) as string
data @"hex","fb_HEX_i", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_HEX_l ( byval number as longint ) as string
data @"hex","fb_HEX_l", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_OCT_b ( byval number as byte ) as string
data @"oct","fb_OCT_b", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE
'' fb_OCT_s ( byval number as short ) as string
data @"oct","fb_OCT_s", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE
'' fb_OCT_i ( byval number as integer ) as string
data @"oct","fb_OCT_i", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_OCT_l ( byval number as longint ) as string
data @"oct","fb_OCT_l", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_BIN_b ( byval number as byte ) as string
data @"bin","fb_BIN_b", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE
'' fb_BIN_s ( byval number as short ) as string
data @"bin","fb_BIN_s", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE
'' fb_BIN_i ( byval number as integer ) as string
data @"bin","fb_BIN_i", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_BIN_l ( byval number as longint ) as string
data @"bin","fb_BIN_l", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_MKD ( byval number as double ) as string
data @"mkd","fb_MKD", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE
'' fb_MKS ( byval number as single ) as string
data @"mks","fb_MKS", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE
'' fb_MKI ( byval number as integer ) as string
data @"mki","fb_MKI", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
data @"mkl","fb_MKI", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_MKSHORT ( byval number as short ) as string
data @"mkshort","fb_MKSHORT", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE
'' fb_MKLONGINT ( byval number as longint ) as string
data @"mklongint","fb_MKLONGINT", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_LEFT ( str as string, byval n as integer ) as string
data @"left","fb_LEFT", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' fb_RIGHT ( str as string, byval n as integer ) as string
data @"right","fb_RIGHT", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_SPACE ( byval n as integer ) as string
data @"space","fb_SPACE", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LCASE ( str as string ) as string
data @"lcase","fb_LCASE", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_UCASE ( str as string ) as string
data @"ucase","fb_UCASE", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_VAL ( str as string ) as double
data @"val","fb_VAL", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_VALINT ( str as string ) as integer
data @"valint","fb_VALINT", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_VALUINT ( str as string ) as uinteger
data @"valuint","fb_VALUINT", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_VALLNG ( str as string ) as longint
data @"vallng","fb_VALLNG", _
	 FB_SYMBTYPE_LONGINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' fb_VALULNG ( str as string ) as ulongint
data @"valulng","fb_VALULNG", _
	 FB_SYMBTYPE_ULONGINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' exp CDECL ( byval rad as double ) as double
data @"exp","exp", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE

'' command ( byval argc as integer = -1 ) as string
data @"command","fb_Command", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1
'' curdir ( ) as string
data @"curdir","fb_CurDir", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' exepath ( ) as string
data @"exepath","fb_ExePath", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' randomize ( byval seed as double = -1.0 ) as void
data @"randomize","fb_Randomize", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, TRUE, -1.0
'' rnd ( byval n as integer ) as double
data @"rnd","fb_Rnd", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1

'' timer ( ) as double
data @"timer","fb_Timer", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' time ( ) as string
data @"time","fb_Time", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' date ( ) as string
data @"date","fb_Date", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' pos( ) as integer
data @"pos", "fb_GetX", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 0
'' pos( dummy ) as integer
data @"pos", "fb_Pos", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
     1, _
     FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' csrlin( ) as integer
data @"csrlin", "fb_GetY", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' cls( byval n as integer = 1 ) as void
data @"cls", "fb_Cls", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,&hFFFF0000
'' color( byval fc as integer = -1, byval bc as integer = -1 ) as integer
data @"color", "fb_Color", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1
'' inkey ( ) as string
data @"inkey","fb_Inkey", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, FALSE, FALSE, _
	 0
'' getkey ( ) as integer
data @"getkey","fb_Getkey", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, FALSE, FALSE, _
	 0

'' shell ( byval cmm as string = "" ) as integer
data @"shell","fb_Shell", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, TRUE,""

'' system ( ) as void
data @"system","fb_End", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0
'' stop ( ) as void
data @"stop","fb_End", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' run ( exename as string ) as integer
data @"run","fb_Run", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' chain ( exename as string ) as integer
data @"chain","fb_Chain", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' exec ( exename as string, arguments as string ) as integer
data @"exec","fb_Exec", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' environ ( varname as string ) as string
data @"environ","fb_GetEnviron", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' setenviron ( varname as string ) as integer
data @"setenviron","fb_SetEnviron", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' sleep ( byval msecs as integer ) as void
data @"sleep","fb_Sleep", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, -1
'' sleepex ( byval msecs as integer, byval kind as integer ) as integer
data @"sleep","fb_SleepEx", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultinput_cb, TRUE, TRUE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' reset ( ) as void
data @"reset","fb_FileReset", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' lof ( byval filenum as integer ) as uinteger
data @"lof","fb_FileSize", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' loc ( byval filenum as integer ) as uinteger
data @"loc","fb_FileLocation", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' lpos( int ) as integer
data @"lpos", "fb_LPos", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hPrinter_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' rset ( dst as string, src as string ) as void
data @"rset","fb_StrRset", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fre ( ) as uinteger
data @"fre","fb_GetMemAvail", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' allocate ( byval bytes as integer ) as any ptr
data @"allocate","malloc", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' callocate ( byval bytes as integer ) as any ptr
data @"callocate","calloc", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1
'' reallocate ( byval p as any ptr, byval bytes as integer ) as any ptr
data @"reallocate","realloc", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' deallocate ( byval p as any ptr ) as void
data @"deallocate","free", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE
'' clear ( dst as any, byval value as integer = 0, byval bytes as integer ) as void
data @"clear","memset", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' dir ( mask as string, byval v as integer = &h33 ) as string
data @"dir","fb_Dir", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, TRUE,"", _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,&h33

'' settime ( time as string ) as integer
data @"settime","fb_SetTime", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' setdate ( date as string ) as integer
data @"setdate","fb_SetDate", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' threadcreate ( byval proc as sub( byval param as integer ), byval param as integer = 0) as integer
data @"threadcreate", "fb_ThreadCreate", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultithread_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0
'' threadwait ( byval id as integer ) as void
data @"threadwait","fb_ThreadWait", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hMultithread_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' mutexcreate ( ) as integer
data @"mutexcreate","fb_MutexCreate", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' mutexdestroy ( byval id as integer ) as void
data @"mutexdestroy","fb_MutexDestroy", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' mutexlock ( byval id as integer ) as void
data @"mutexlock","fb_MutexLock", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' mutexunlock ( byval id as integer ) as void
data @"mutexunlock","fb_MutexUnlock", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' condcreate ( ) as integer
data @"condcreate","fb_CondCreate", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0
'' conddestroy ( byval id as integer ) as void
data @"conddestroy","fb_CondDestroy", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' condsignal ( byval id as integer ) as void
data @"condsignal","fb_CondSignal", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' condbroadcast ( byval id as integer ) as void
data @"condbroadcast","fb_CondBroadcast", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE
'' condwait ( byval id as integer ) as void
data @"condwait","fb_CondWait", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' dylibload ( filename as string ) as integer
data @"dylibload","fb_DylibLoad", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' dylibsymbol ( byval library as integer, symbol as string) as any ptr
data @"dylibsymbol","fb_DylibSymbol", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' dylibfree ( byval library as integer ) as void
data @"dylibfree","fb_DylibFree", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' beep ( ) as void
data @"beep","fb_Beep", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' mkdir ( byref path as string ) as integer
data @"mkdir","fb_MkDir", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' rmdir ( byref path as string ) as integer
data @"rmdir","fb_RmDir", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE
'' chdir ( byref path as string ) as integer
data @"chdir","fb_ChDir", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_Assert ( byval fname as string, byval linenum as integer, byval funcname as string, _
''			   byval expression as string ) as void
data @"fb_Assert","", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE

'' fb_AssertWarn ( byval fname as string, byval linenum as integer, byval funcname as string, _
''			       byval expression as string ) as void
data @"fb_AssertWarn","", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE

'' ERL ( ) as integer
data @"erl", "fb_ErrorGetLineNum", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' EOL
data NULL

'':::::::::::::::::::::::::::::::::::::::::::::::::::
'' MACROS
'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' name, debugonly?, args, arg[0] to arg[n] names, macro text
imacrodata:
''#define RGB(r,g,b) ((cuint(r) shl 16) or (cuint(g) shl 8) or cuint(b))
data "RGB", _
	 FALSE, _
	 3, "R", "G", "B", _
	 FB_DEFTOK_TYPE_TEX, "((cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") shl 16) or (cuint(", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ") shl 8) or cuint(", _
	 FB_DEFTOK_TYPE_ARG, 2, _
	 FB_DEFTOK_TYPE_TEX, "))", _
	 -1
''#define RGBA(r,g,b,a) ((cuint(r) shl 16) or (cuint(g) shl 8) or cuint(b) or (cuint(a) shl 24))
data "RGBA", FALSE, _
	 4, "R", "G", "B", "A", _
	 FB_DEFTOK_TYPE_TEX, "((cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") shl 16) or (cuint(", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ") shl 8) or cuint(", _
	 FB_DEFTOK_TYPE_ARG, 2, _
	 FB_DEFTOK_TYPE_TEX, ") or (cuint(", _
	 FB_DEFTOK_TYPE_ARG, 3, _
	 FB_DEFTOK_TYPE_TEX, ") shl 24))", _
	 -1

''#define va_arg(a,t) peek( t, a )
data "VA_ARG", _
	 FALSE, _
	 2, "A", "T", _
	 FB_DEFTOK_TYPE_TEX, "peek(", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ",", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ")", _
	 -1
''#define va_next(a,t) (a + len( t ))
data "VA_NEXT", _
	 FALSE, _
	 2, "A", "T", _
	 FB_DEFTOK_TYPE_TEX, "(cptr(", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, " ptr,", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") + 1)", _
	 -1

''#define ASSERT(e) if not (e) then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)
data "ASSERT", _
	 TRUE, _
	 1, "E", _
	 FB_DEFTOK_TYPE_TEX, "if not (", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") then fb_Assert(__FILE__, __LINE__, __FUNCTION__, ", _
	 FB_DEFTOK_TYPE_ARGSTR, 0, _
	 FB_DEFTOK_TYPE_TEX, ")", _
	 -1
''#define ASSERTWARN(e) if not (e) then fb_AssertWarn(__FILE__, __LINE__, __FUNCTION__, #e)
data "ASSERTWARN", _
	 TRUE, _
	 1, "E", _
	 FB_DEFTOK_TYPE_TEX, "if not (", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") then fb_AssertWarn(__FILE__, __LINE__, __FUNCTION__, ", _
	 FB_DEFTOK_TYPE_ARGSTR, 0, _
	 FB_DEFTOK_TYPE_TEX, ")", _
	 -1

''#define OFFSETOF(type_,field_) cint( @cptr( type_ ptr, 0 )->field_ )
data "OFFSETOF", _
	 FALSE, _
	 2, "T", "F", _
	 FB_DEFTOK_TYPE_TEX, "cint( @cptr( ", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, " ptr, 0 )->", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, " )", _
	 -1

data "__FB_MIN_VERSION__", _
     FALSE, _
     3, "MAJOR", "MINOR", "PATCH_LEVEL", _
	 FB_DEFTOK_TYPE_TEX, "((__FB_VER_MAJOR__ > (", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ")) or ((__FB_VER_MAJOR__ = (", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ")) and ((__FB_VER_MINOR__ > (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, "!)) or (__FB_VER_MINOR__ = (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ") and __FB_VER_PATCH__ >= (", _
	 FB_DEFTOK_TYPE_ARG, 2, _
	 FB_DEFTOK_TYPE_TEX, ")))))", _
	 -1

'#ifndef FB__BIGENDIAN
''#define LOWORD(x) (cuint(x) and &h0000FFFF)
data "LOWORD", _
	 FALSE, _
	 1, "X", _
	 FB_DEFTOK_TYPE_TEX, "(cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and &h0000FFFF)", _
	 -1
''#define HIWORD(x) (cyint(x) shr 16)
data "HIWORD", _
	 FALSE, _
	 1, "X", _
	 FB_DEFTOK_TYPE_TEX, "(cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") shr 16)", _
	 -1
''#define LOBYTE(x) (cuint(x) and &h000000FF)
data "LOBYTE", _
	 FALSE, _
	 1, "X", _
	 FB_DEFTOK_TYPE_TEX, "(cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and &h000000FF)", _
	 -1
''#define HIBYTE(x) ((cuint(x) and &h0000FF00) shr 8)
data "HIBYTE", _
	 FALSE, _
	 1, "X", _
	 FB_DEFTOK_TYPE_TEX, "((cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and &h0000FF00) shr 8)", _
	 -1
''#define BIT(x,y) (((x) and (1 shl (y))) > 0)
data "BIT", _
	 FALSE, _
	 2, "X", "Y", _
	 FB_DEFTOK_TYPE_TEX, "(((", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and (1 shl (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, "))) <> 0)", _
	 -1
''#define BITSET(x,y) ((x) or (1 shl (y)))
data "BITSET", _
	 FALSE, _
	 2, "X", "Y", _
	 FB_DEFTOK_TYPE_TEX, "((", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") or (1 shl (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ")))", _
	 -1
''#define BITRESET(x,y) ((x) and not (y))
data "BITRESET", _
	 FALSE, _
	 2, "X", "Y", _
	 FB_DEFTOK_TYPE_TEX, "((", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and not (1 shl (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ")))", _
	 -1
'#endif

'' EOL
data ""


'':::::::::::::::::::::::::::::::::::::::::::::::::::
'' implementation
'':::::::::::::::::::::::::::::::::::::::::::::::::::

#define cntptr(typ,t,cnt)						_
	t = typ                                     : _
	cnt = 0                                     : _
	do while( t >= IR_DATATYPE_POINTER )		: _
		t -= IR_DATATYPE_POINTER				: _
		cnt += 1								: _
	loop


'':::::
private sub hAddIntrinsicProcs( )
	dim as integer i, typ
	dim as string aname, optstr
	dim as integer p, pargs, ptype, pmode, palloctype
	dim as integer a, atype, alen, amode, optional, ptrcnt, errorcheck, overloaded
	dim as FBSYMBOL ptr proc
	dim as FBRTLCALLBACK pcallback
	dim as FBVALUE optval
	dim as zstring ptr pname, palias

	''
	restore ifuncdata
	i = 0
	do
		'' for each proc..
		read pname
		if( pname = NULL ) then
			exit do
		end if

		read aname
		read ptype, pmode
		read pcallback, errorcheck, overloaded
		read pargs

		proc = symbPreAddProc( )

		'' for each argument..
		for a = 0 to pargs-1
			read atype, amode, optional

			if( optional ) then
				select case as const atype
				case IR_DATATYPE_STRING
					read optstr
					optval.str = hAllocStringConst( optstr, 0 )
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					read optval.long
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					read optval.float
				case else
					read optval.int
				end select
			end if

			if( atype <> INVALID ) then
				alen = symbCalcArgLen( atype, NULL, amode )
			else
				alen = FB_POINTERSIZE
			end if

			cntptr( atype, typ, ptrcnt )

			symbAddArg( proc, NULL, _
						atype, NULL, ptrcnt, _
						alen, amode, INVALID, _
						optional, @optval )
		next

		''
		if( overloaded ) then
			palloctype = FB_ALLOCTYPE_OVERLOADED
		else
			palloctype = 0
		end if

		''
		cntptr( ptype, typ, ptrcnt )

		if( len( aname ) = 0 ) then
			palias = pname
		else
			palias = strptr( aname )
		end if

		proc = symbAddPrototype( proc, _
								 pname, palias, strptr( "fb" ), _
								 ptype, NULL, ptrcnt, _
								 palloctype, pmode, TRUE )

		''
		if( proc <> NULL ) then
			symbSetProcIsRTL( proc, TRUE )
			symbSetProcCallback( proc, pcallback )
			symbSetProcErrorCheck( proc, errorcheck )
		end if

		i += 1
	loop

end sub

'':::::
private sub hAddIntrinsicMacros( )
	dim as integer i, args, dbgonly, typ, argnum
	dim as FBDEFARG ptr arghead, lastarg, arg
	dim as FBDEFTOK ptr tok, tokhead
	dim as string mname, aname

	restore imacrodata
	do
		read mname
		if( len( mname ) = 0 ) then
			exit do
		end if

		read dbgonly

		arghead = NULL
		lastarg = NULL

		'' for each argument, add it
		read args
		for i = 0 to args-1
			read aname

			lastarg = symbAddDefineArg( lastarg, strptr( aname ) )

			if( arghead = NULL ) then
				arghead = lastarg
			end if
		next

		tokhead = NULL
		tok = NULL

    	do
    		read typ
    		if( typ = -1 ) then
    			exit do
    		end if

			tok = symbAddDefineTok( tok, typ )

    		select case typ
    		case FB_DEFTOK_TYPE_ARG, FB_DEFTOK_TYPE_ARGSTR
    			read symbGetDefTokArgNum( tok )
    		case FB_DEFTOK_TYPE_TEX
    			read symbGetDefTokText( tok )
    		end select

			if( tokhead = NULL ) then
				tokhead = tok
			end if

    	loop

    	'' only if debugging?
    	if( dbgonly and not env.clopt.debug ) then
    		tokhead = NULL
    	end if

        symbAddDefineMacro( strptr( mname ), tokhead, args, arghead )

	loop

end sub

'':::::
sub rtlInit static

	''
	fbAddDefaultLibs( )

	''
	hAddIntrinsicProcs( )

	''
	hAddIntrinsicMacros( )

	''
	ctx.datainited	= FALSE
	ctx.lastlabel	= NULL
    ctx.labelcnt 	= 0

end sub

'':::::
sub rtlEnd

	'' procs will be deleted when symbEnd is called

	'' ditto with macros

	'' reset the table as the pointers will change if
	'' the compiler is reseted
	erase rtlLookupTB

end sub

'':::::
private function rtlProcLookup( byval pname as zstring ptr, _
			   					byval pidx as integer _
			 				  ) as FBSYMBOL ptr static

    dim as integer id, class

    '' not cached yet? -- this won't work if #undef is used
    '' what is pretty unlikely with internal fb_* procs
	if( rtlLookupTB( pidx ) = NULL ) then
		rtlLookupTB( pidx ) = symbLookup( pname, id, class )
	end if

	function = rtlLookupTB( pidx )

end function

#define PROCLOOKUP(id) rtlProcLookup( strptr( FB_RTL_##id ), FB_RTL_IDX_##id )

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' strings
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
'' note: STRGETLEN must be called *before* astNewPARAM(e) because the expression 'e'
''       can be changed inside the former (address-of string's etc)

#define FIXSTRGETLEN(e) symbGetLen( astGetSymbolOrElm( e ) )

#define ZSTRGETLEN(e) iif( astIsPTR( e ), 0, symbGetLen( astGetSymbolOrElm( e ) ) )

#define STRGETLEN(e,t,l)												_
	select case as const t                                              :_
	case IR_DATATYPE_BYTE, IR_DATATYPE_UBYTE       						:_
		l = 0                                                           :_
	case IR_DATATYPE_FIXSTR                                             :_
		l = FIXSTRGETLEN( e )                         					:_
	case IR_DATATYPE_CHAR                                               :_
		l = ZSTRGETLEN( e )                            					:_
	case else                                                           :_
		l = -1															:_
	end select

'':::::
function rtlStrCompare ( byval str1 as ASTNODE ptr, _
						 byval sdtype1 as integer, _
					     byval str2 as ASTNODE ptr, _
					     byval sdtype2 as integer _
					   ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer str1len, str2len

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( STRCOMPARE ) )

   	'' always calc len before pushing the param
   	STRGETLEN( str1, sdtype1, str1len )

	STRGETLEN( str2, sdtype2, str2len )

    ''
    if( astNewPARAM( proc, str1, sdtype1 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, astNewCONSTi( str1len, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, str2, sdtype2 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, astNewCONSTi( str2len, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrConcat( byval str1 as ASTNODE ptr, _
					   byval sdtype1 as integer, _
					   byval str2 as ASTNODE ptr, _
					   byval sdtype2 as integer _
					 ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer str1len, str2len
    dim as FBSYMBOL ptr tstr

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( STRCONCAT ) )

    '' dst as string
    tstr = symbAddTempVar( FB_SYMBTYPE_STRING )
    if( astNewPARAM( proc, astNewVAR( tstr, NULL, 0, IR_DATATYPE_STRING ), IR_DATATYPE_STRING ) = NULL ) then
    	exit function
    end if

   	'' always calc len before pushing the param
   	STRGETLEN( str1, sdtype1, str1len )

	STRGETLEN( str2, sdtype2, str2len )

    ''
    if( astNewPARAM( proc, str1, sdtype1 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, astNewCONSTi( str1len, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, str2, sdtype2 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, astNewCONSTi( str2len, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrConcatAssign( byval dst as ASTNODE ptr, _
							 byval src as ASTNODE ptr _
						   ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer lgt, ddtype, sdtype

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( STRCONCATASSIGN ) )

    ''
   	ddtype = astGetDataType( dst )

	'' always calc len before pushing the param
	STRGETLEN( dst, ddtype, lgt )

	'' dst as any
	if( astNewPARAM( proc, dst, ddtype ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

   	'' always calc len before pushing the param
   	sdtype = astGetDataType( src )
	STRGETLEN( src, sdtype, lgt )

	'' src as any
	if( astNewPARAM( proc, src, sdtype ) = NULL ) then
    	exit function
    end if

    '' byval srclen as integer
	if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval fillrem as integer
	if( astNewPARAM( proc, astNewCONSTi( ddtype = IR_DATATYPE_FIXSTR, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	''
	function = proc

end function

'':::::
function rtlStrAssign( byval dst as ASTNODE ptr, _
					   byval src as ASTNODE ptr _
					 ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer lgt, ddtype, sdtype

	function = NULL

	''
    proc =  astNewFUNCT( PROCLOOKUP( STRASSIGN ) )

	'' always calc len before pushing the param
   	ddtype = astGetDataType( dst )
	STRGETLEN( dst, ddtype, lgt )

	'' dst as any
	if( astNewPARAM( proc, dst, ddtype ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

   	'' always calc len before pushing the param
   	sdtype = astGetDataType( src )
	STRGETLEN( src, sdtype, lgt )

	'' src as any
	if( astNewPARAM( proc, src, sdtype ) = NULL ) then
    	exit function
    end if

	'' byval srclen as integer
	if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval fillrem as integer
	if( astNewPARAM( proc, astNewCONSTi( ddtype = IR_DATATYPE_FIXSTR, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	''
	function = proc

end function

'':::::
function rtlStrDelete( byval strg as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( STRDELETE ) )

    '' str as ANY
    if( astNewPARAM( proc, strg, IR_DATATYPE_STRING ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrAllocTmpResult( byval strg as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( STRALLOCTMPRES ), NULL, TRUE )

    '' src as string
    if( astNewPARAM( proc, strg, IR_DATATYPE_STRING ) = NULL ) then
    	exit function
    end if

	function = proc

end function

'':::::
function rtlStrAllocTmpDesc	( byval strg as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as integer lgt, dtype

    function = NULL

	''
   	dtype = astGetDataType( strg )

	select case dtype
	case IR_DATATYPE_STRING
    	proc = astNewFUNCT( PROCLOOKUP( STRALLOCTMPDESCV ) )

    	'' str as string
    	if( astNewPARAM( proc, strg ) = NULL ) then
    		exit function
    	end if

	case IR_DATATYPE_CHAR
    	proc = astNewFUNCT( PROCLOOKUP( STRALLOCTMPDESCZ ) )

    	'' byval str as string
    	if( astNewPARAM( proc, strg ) = NULL ) then
    		exit function
    	end if

	case IR_DATATYPE_FIXSTR
    	proc = astNewFUNCT( PROCLOOKUP( STRALLOCTMPDESCF ) )

    	'' always calc len before pushing the param
		STRGETLEN( strg, dtype, lgt )

    	'' str as any
    	if( astNewPARAM( proc, strg ) = NULL ) then
    		exit function
    	end if

		'' byval strlen as integer
		if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

    end select

	''
	function = proc

end function

'':::::
function rtlToStr( byval expr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

    function = NULL

    '' constant? evaluate
    if( astIsCONST( expr ) ) then
    	return astNewCONSTs( astGetValueAsStr( expr ) )
    end if

    ''
	select case astGetDataClass( expr )
	case IR_DATACLASS_INTEGER

		select case as const astGetDataType( expr )
		case IR_DATATYPE_LONGINT
			f = PROCLOOKUP( LONGINT2STR)
		case IR_DATATYPE_ULONGINT
			f = PROCLOOKUP( ULONGINT2STR)
		case IR_DATATYPE_BYTE, IR_DATATYPE_SHORT, IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			f = PROCLOOKUP( INT2STR)
		case IR_DATATYPE_UBYTE, IR_DATATYPE_USHORT, IR_DATATYPE_UINT
			f = PROCLOOKUP( UINT2STR)
		'' zstring? do nothing
		case IR_DATATYPE_CHAR
			return expr
		'' pointer..
		case else
			f = PROCLOOKUP( UINT2STR)
		end select

	case IR_DATACLASS_FPOINT
		if( astGetDataType( expr ) = IR_DATATYPE_SINGLE ) then
			f = PROCLOOKUP( FLT2STR)
		else
			f = PROCLOOKUP( DBL2STR)
		end if

	'' anything else (UDT's, classes): can't print
	case else
		return NULL
	end select

	''
    proc = astNewFUNCT( f )

    ''
    if( astNewPARAM( proc, expr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrMid( byval expr1 as ASTNODE ptr, _
					byval expr2 as ASTNODE ptr, _
					byval expr3 as ASTNODE ptr _
				  ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

    function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( STRMID ) )

    ''
    if( astNewPARAM( proc, expr1 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr2 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr3 ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrAssignMid( byval expr1 as ASTNODE ptr, _
						  byval expr2 as ASTNODE ptr, _
						  byval expr3 as ASTNODE ptr, _
						  byval expr4 as ASTNODE ptr _
						) as ASTNODE ptr static

    dim as ASTNODE ptr proc

    function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( STRASSIGNMID ) )

    ''
    if( astNewPARAM( proc, expr1 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr2 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr3 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr4 ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = proc

end function

'':::::
function rtlStrLSet( byval dstexpr as ASTNODE ptr, _
					 byval srcexpr as ASTNODE ptr _
				   ) as integer static

    dim as ASTNODE ptr proc

    function = FALSE

	''
    proc = astNewFUNCT( PROCLOOKUP( STRLSET ) )

    '' dst as string
    if( astNewPARAM( proc, dstexpr ) = NULL ) then
    	exit function
    end if

    '' src as string
    if( astNewPARAM( proc, srcexpr ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlStrFill( byval expr1 as ASTNODE ptr, _
					 byval expr2 as ASTNODE ptr _
				   ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

    function = NULL

	select case astGetDataClass( expr2 )
	case IR_DATACLASS_INTEGER, IR_DATACLASS_FPOINT
		f = PROCLOOKUP( STRFILL1 )
	case else
		f = PROCLOOKUP( STRFILL2 )
	end select

    proc = astNewFUNCT( f )

    ''
    if( astNewPARAM( proc, expr1 ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr2 ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrAsc( byval expr as ASTNODE ptr, _
					byval posexpr as ASTNODE ptr _
				  ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( STRASC ) )

    '' src as string
    if( astNewPARAM( proc, expr ) = NULL ) then
    	exit function
    end if

    '' byval pos as integer
    if( posexpr = NULL ) then
    	posexpr = astNewCONSTi( 1, IR_DATATYPE_INTEGER )
    end if

    if( astNewPARAM( proc, posexpr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrChr( byval args as integer, _
					exprtb() as ASTNODE ptr _
				  ) as ASTNODE ptr static

	dim as ASTNODE ptr proc, expr
	dim as integer i

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( STRCHR ) )

    '' byval args as integer
    if( astNewPARAM( proc, astNewCONSTi( args, IR_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    '' ...
    for i = 0 to args-1
    	expr = exprtb(i)

    	'' check if non-numeric
    	if( astGetDataClass( expr ) >= IR_DATACLASS_STRING ) then
    		hReportErrorEx( FB_ERRMSG_PARAMTYPEMISMATCHAT, "at parameter: " + str$( i+1 ) )
    		exit function
    	end if

    	'' convert to int
    	if( astGetDataType( expr ) <> IR_DATATYPE_INTEGER ) then
    		expr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, expr )
    	end if

    	if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if
    next

    function = proc

end function

'':::::
function rtlStrInstr( byval nd_start as ASTNODE ptr, _
					  byval nd_text as ASTNODE ptr, _
					  byval nd_pattern as ASTNODE ptr, _
                      byval search_any as integer _
                    ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

    function = NULL

	''
    if( search_any ) then
		f = PROCLOOKUP( STRINSTRANY )
    else
		f = PROCLOOKUP( STRINSTR )
    end if
    proc = astNewFUNCT( f )

    ''
    if( astNewPARAM( proc, nd_start ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, nd_text ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, nd_pattern ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrTrim( byval nd_text as ASTNODE ptr, _
					 byval nd_pattern as ASTNODE ptr, _
                     byval is_any as integer _
                   ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

    function = NULL

	''
    if( is_any ) then
		f = PROCLOOKUP( STRTRIMANY )
    elseif( nd_pattern<>NULL ) then
		f = PROCLOOKUP( STRTRIMEX )
    else
		f = PROCLOOKUP( STRTRIM )
    end if
    proc = astNewFUNCT( f )

    ''
    if( astNewPARAM( proc, nd_text ) = NULL ) then
    	exit function
    end if

    if( nd_pattern<>NULL or is_any ) then
        if( astNewPARAM( proc, nd_pattern ) = NULL ) then
            exit function
        end if
    end if

    function = proc

end function

'':::::
function rtlStrRTrim( byval nd_text as ASTNODE ptr, _
					  byval nd_pattern as ASTNODE ptr, _
                      byval is_any as integer _
                    ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

    function = NULL

	''
    if( is_any ) then
		f = PROCLOOKUP( STRRTRIMANY )
    elseif( nd_pattern<>NULL ) then
		f = PROCLOOKUP( STRRTRIMEX )
    else
		f = PROCLOOKUP( STRRTRIM )
    end if
    proc = astNewFUNCT( f )

    ''
    if( astNewPARAM( proc, nd_text ) = NULL ) then
    	exit function
    end if

    if( nd_pattern<>NULL or is_any ) then
        if( astNewPARAM( proc, nd_pattern ) = NULL ) then
            exit function
        end if
    end if

    function = proc

end function

'':::::
function rtlStrLTrim( byval nd_text as ASTNODE ptr, _
					  byval nd_pattern as ASTNODE ptr, _
                      byval is_any as integer _
                    ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

    function = NULL

	''
    if( is_any ) then
		f = PROCLOOKUP( STRLTRIMANY )
    elseif( nd_pattern<>NULL ) then
		f = PROCLOOKUP( STRLTRIMEX )
    else
		f = PROCLOOKUP( STRLTRIM )
    end if
    proc = astNewFUNCT( f )

    ''
    if( astNewPARAM( proc, nd_text ) = NULL ) then
    	exit function
    end if

    if( nd_pattern<>NULL or is_any ) then
        if( astNewPARAM( proc, nd_pattern ) = NULL ) then
            exit function
        end if
    end if

    function = proc

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' arrays
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlArrayRedim( byval s as FBSYMBOL ptr, _
						byval elementlen as integer, _
						byval dimensions as integer, _
				        exprTB() as ASTNODE ptr, _
				        byval dopreserve as integer _
				      ) as integer static

    dim as ASTNODE ptr proc, expr
    dim as FBSYMBOL ptr f, reslabel
    dim as integer i, dtype, isvarlen

    function = FALSE

	''
	if( not dopreserve ) then
		f = PROCLOOKUP( ARRAYREDIM )
	else
		f = PROCLOOKUP( ARRAYREDIMPRESV )
	end if
    proc = astNewFUNCT( f )

    '' array() as ANY
    dtype =  symbGetType( s )
	expr = astNewVAR( s, NULL, 0, dtype )
    if( astNewPARAM( proc, expr, dtype ) = NULL ) then
    	exit function
    end if

	'' byval element_len as integer
	expr = astNewCONSTi( elementlen, IR_DATATYPE_INTEGER )
	if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval isvarlen as integer
	isvarlen = (dtype = IR_DATATYPE_STRING)
	if( astNewPARAM( proc, astNewCONSTi( isvarlen, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval dimensions as integer
	if( astNewPARAM( proc, astNewCONSTi( dimensions, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' ...
	for i = 0 to dimensions-1

		'' lbound
		expr = exprTB(i, 0)

    	'' convert to int
    	if( astGetDataType( expr ) <> IR_DATATYPE_INTEGER ) then
    		expr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, expr )
    	end if

		if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

		'' ubound
		expr = exprTB(i, 1)

    	'' convert to int
    	if( astGetDataType( expr ) <> IR_DATATYPE_INTEGER ) then
    		expr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, expr )
    	end if

		if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if
	next

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

    ''
	function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::
function rtlArrayErase( byval arrayexpr as ASTNODE ptr ) as integer static
    dim as ASTNODE ptr proc
    dim as integer dtype

	function = FALSE

	''
    proc = astNewFUNCT( PROCLOOKUP( ARRAYERASE ) )

	dtype = astGetDataType( arrayexpr )

    '' array() as ANY
    if( astNewPARAM( proc, arrayexpr, dtype ) = NULL ) then
    	exit function
    end if

	'' byval isvarlen as integer
	if( astNewPARAM( proc, astNewCONSTi( dtype = IR_DATATYPE_STRING, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    ''
	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlArrayClear( byval arrayexpr as ASTNODE ptr ) as integer static
    dim as ASTNODE ptr proc
    dim as integer dtype

    function = FALSE

	''
    proc = astNewFUNCT( PROCLOOKUP( ARRAYCLEAR ) )

    dtype = astGetDataType( arrayexpr )

    '' array() as ANY
    if( astNewPARAM( proc, arrayexpr, dtype ) = NULL ) then
    	exit function
    end if

	'' byval isvarlen as integer
	if( astNewPARAM( proc, astNewCONSTi( (dtype = IR_DATATYPE_STRING), IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    ''
	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlArrayStrErase( byval s as FBSYMBOL ptr ) as integer static
    dim as ASTNODE ptr proc
    dim as integer dtype

	function = FALSE

	''
    proc = astNewFUNCT( PROCLOOKUP( ARRAYSTRERASE ) )

    '' array() as ANY
    dtype = symbGetType( s )
    if( astNewPARAM( proc, astNewVAR( s, NULL, 0, dtype ), dtype ) = NULL ) then
    	exit function
    end if

    ''
	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlArrayBound( byval sexpr as ASTNODE ptr, _
						byval dimexpr as ASTNODE ptr, _
						byval islbound as integer _
					  ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = NULL

	''
	if( islbound ) then
		f = PROCLOOKUP( ARRAYLBOUND)
	else
		f = PROCLOOKUP( ARRAYUBOUND)
	end if
    proc = astNewFUNCT( f )

    '' array() as ANY
    if( astNewPARAM( proc, sexpr ) = NULL ) then
    	exit function
    end if

	'' byval dimension as integer
	if( astNewPARAM( proc, dimexpr ) = NULL ) then
		exit function
	end if

    ''
    function = proc

end function

'':::::
function rtlArraySetDesc( byval s as FBSYMBOL ptr, _
						  byval elementlen as integer, _
					      byval dimensions as integer, _
					      dTB() as FBARRAYDIM ) as integer static

    dim as ASTNODE ptr proc, expr
    dim as integer dtype, i

    function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( ARRAYSETDESC ) )

    '' array() as ANY
    dtype =  symbGetType( s )
	expr = astNewVAR( s, NULL, 0, dtype )
    if( astNewPARAM( proc, expr, dtype ) = NULL ) then
		exit function
	end if

	'' arraydata as any
	expr = astNewVAR( s, NULL, 0, dtype )
    if( astNewPARAM( proc, expr, dtype ) = NULL ) then
		exit function
	end if

	'' byval element_len as integer
	expr = astNewCONSTi( elementlen, IR_DATATYPE_INTEGER )
	if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
		exit function
	end if

	'' byval dimensions as integer
	expr = astNewCONSTi( dimensions, IR_DATATYPE_INTEGER )
	if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
		exit function
	end if

	'' ...
	for i = 0 to dimensions-1
		'' lbound
		expr = astNewCONSTi( dTB(i).lower, IR_DATATYPE_INTEGER )
		if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if

		'' ubound
		expr = astNewCONSTi( dTB(i).upper, IR_DATATYPE_INTEGER )
		if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if
	next

    ''
	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlArrayAllocTmpDesc( byval arrayexpr as ASTNODE ptr, _
							   byval pdesc as FBSYMBOL ptr _
							 ) as ASTNODE ptr

    dim as ASTNODE ptr proc, expr
    dim as integer dtype, dimensions
    dim as FBSYMBOL ptr s
    dim as FBVARDIM ptr d

	function = NULL

	s = astGetSymbolOrElm( arrayexpr )

	dimensions = symbGetArrayDimensions( s )

    proc = astNewFUNCT( PROCLOOKUP( ARRAYALLOCTMPDESC ) )

    '' byref pdesc as any ptr
	expr = astNewVAR( pdesc, NULL, 0, IR_DATATYPE_POINTER+IR_DATATYPE_VOID )
    if( astNewPARAM( proc, expr, IR_DATATYPE_POINTER+IR_DATATYPE_VOID ) = NULL ) then
    	exit function
    end if

    '' byref arraydata as any
    if( astNewPARAM( proc, arrayexpr, IR_DATATYPE_VOID ) = NULL ) then
    	exit function
    end if

	'' byval element_len as integer
	expr = astNewCONSTi( symbGetLen( s ), IR_DATATYPE_INTEGER )
	if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval dimensions as integer
	expr = astNewCONSTi( dimensions, IR_DATATYPE_INTEGER )
	if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' ...
    d = symbGetArrayFirstDim( s )
    do while( d <> NULL )
		'' lbound
		expr = astNewCONSTi( d->lower, IR_DATATYPE_INTEGER )
		if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

		'' ubound
		expr = astNewCONSTi( d->upper, IR_DATATYPE_INTEGER )
		if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

		'' next
		d = d->next
	loop

	function = proc

end function

'':::::
function rtlArrayFreeTempDesc( byval pdesc as FBSYMBOL ptr ) as ASTNODE ptr
    dim as ASTNODE ptr proc, expr

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( ARRAYFREETMPDESC ) )

    '' byval pdesc as any ptr
	expr = astNewVAR( pdesc, NULL, 0, IR_DATATYPE_POINTER+IR_DATATYPE_VOID )
    if( astNewPARAM( proc, expr, IR_DATATYPE_POINTER+IR_DATATYPE_VOID ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' bounds and null-pointer checks
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlArrayBoundsCheck( byval idx as ASTNODE ptr, _
							  byval lb as ASTNODE ptr, _
							  byval rb as ASTNODE ptr, _
							  byval linenum as integer _
							) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

   	function = NULL

   	'' lbound 0? do a single check
   	if( lb = NULL ) then
		f = PROCLOOKUP( ARRAYSNGBOUNDCHK )
	else
    	f = PROCLOOKUP( ARRAYBOUNDCHK )
	end if

   	proc = astNewFUNCT( f )

	'' idx
	if( astNewPARAM( proc, idx, IR_DATATYPE_INTEGER ) = NULL ) then
		exit function
	end if

	'' lbound
	if( lb <> NULL ) then
		if( astNewPARAM( proc, lb, IR_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if
	end if

	'' rbound
	if( astNewPARAM( proc, rb, IR_DATATYPE_INTEGER ) = NULL ) then
		exit function
	end if

	'' linenum
	if( astNewPARAM( proc, astNewCONSTi( linenum, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlNullPtrCheck( byval p as ASTNODE ptr, _
						  byval linenum as integer _
						) as ASTNODE ptr static

    dim as ASTNODE ptr proc

   	function = NULL

   	proc = astNewFUNCT( PROCLOOKUP( NULLPTRCHK ) )

	'' ptr
	p = astNewCONV( IR_OP_TOPOINTER, IR_DATATYPE_POINTER+IR_DATATYPE_VOID, NULL, p )
	if( astNewPARAM( proc, p, IR_DATATYPE_POINTER+IR_DATATYPE_VOID ) = NULL ) then
		exit function
	end if

	'' linenum
	if( astNewPARAM( proc, astNewCONSTi( linenum, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' data
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlDataRead( byval varexpr as ASTNODE ptr ) as integer static
    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args, dtype, lgt

    function = FALSE

	f = NULL
	args = 1
	select case as const astGetDataType( varexpr )
	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR
		f = PROCLOOKUP( DATAREADSTR )
		args = 3
	case IR_DATATYPE_BYTE
		f = PROCLOOKUP( DATAREADBYTE )
	case IR_DATATYPE_UBYTE
		f = PROCLOOKUP( DATAREADUBYTE )
	case IR_DATATYPE_SHORT
		f = PROCLOOKUP( DATAREADSHORT )
	case IR_DATATYPE_USHORT
		f = PROCLOOKUP( DATAREADUSHORT )
	case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
		f = PROCLOOKUP( DATAREADINT )
	case IR_DATATYPE_UINT
		f = PROCLOOKUP( DATAREADUINT )
	case IR_DATATYPE_LONGINT
		f = PROCLOOKUP( DATAREADLONGINT )
	case IR_DATATYPE_ULONGINT
		f = PROCLOOKUP( DATAREADULONGINT )
	case IR_DATATYPE_SINGLE
		f = PROCLOOKUP( DATAREADSINGLE )
	case IR_DATATYPE_DOUBLE
		f = PROCLOOKUP( DATAREADDOUBLE )
	case IR_DATATYPE_USERDEF
		exit function						'' illegal
	case else
		f = PROCLOOKUP( DATAREADUINT )
	end select

    if( f = NULL ) then
    	exit function
    end if

    proc = astNewFUNCT( f )

    if( args = 3 ) then
    	'' always calc len before pushing the param
		dtype = astGetDataType( varexpr )
		STRGETLEN( varexpr, dtype, lgt )
	end if

    '' byref var as any
    if( astNewPARAM( proc, varexpr ) = NULL ) then
 		exit function
 	end if

    if( args = 3 ) then
		'' byval dst_size as integer
		if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
 			exit function
 		end if

		'' byval fillrem as integer
		if( astNewPARAM( proc, astNewCONSTi( dtype = IR_DATATYPE_FIXSTR, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlDataRestore( byval label as FBSYMBOL ptr, _
						 byval afternode as ASTNODE ptr, _
						 byval isprofiler as integer = FALSE _
					   ) as integer static

    static as zstring * FB_MAXNAMELEN+1 lname
    dim as ASTNODE ptr proc, expr
    dim as FBSYMBOL ptr s

    function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( DATARESTORE ), NULL, isprofiler )

    '' begin of data or start from label?
    if( label <> NULL ) then
    	lname = FB_DATALABELPREFIX + symbGetName( label )
    else
    	lname = FB_DATALABELNAME
    end if

    '' label already declared?
    s = symbFindByNameAndClass( @lname, FB_SYMBCLASS_LABEL )
    if( s = NULL ) then
       	s = symbAddLabel( @lname, TRUE, TRUE )
    end if

    '' byval labeladdrs as void ptr
    expr = astNewADDR( IR_OP_ADDROF, astNewVAR( s, NULL, 0, IR_DATATYPE_BYTE ), s )
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

	''
	if( afternode = NULL ) then
		astAdd( proc )
	else
		astAddAfter( proc, afternode )
	end if

	function = TRUE

end function

'':::::
sub rtlDataStoreBegin static
    static as zstring * FB_MAXNAMELEN+1 lname
    dim as FBSYMBOL ptr l, label, s

	'' switch section, can't be code coz it will screw up debugging
	emitSECTION( EMIT_SECTYPE_CONST )

	'' emit default label if not yet emited
	if( not ctx.datainited ) then
		ctx.datainited = TRUE

		l = symbAddLabel( strptr( FB_DATALABELNAME ), TRUE, TRUE )
		if( l = NULL ) then
			l = symbFindByNameAndClass( strptr( FB_DATALABELNAME ), FB_SYMBCLASS_LABEL )
		end if

		lname = symbGetName( l )
		emitDATALABEL( lname )

	else
		s = symbFindByNameAndClass( strptr( FB_DATALABELNAME ), FB_SYMBCLASS_LABEL )
		lname = symbGetName( s )
	end if

	'' emit last label as a label in const section
	'' if any defined already, otherwise it will be the default
	label = symbGetLastLabel( )
	if( label <> NULL ) then
    	''
    	lname = FB_DATALABELPREFIX + symbGetName( label )
    	l = symbFindByNameAndClass( @lname, FB_SYMBCLASS_LABEL )
    	if( l = NULL ) then
       		l = symbAddLabel( @lname, TRUE, TRUE )
    	end if

    	lname = symbGetName( l )

    	'' stills the same label as before? incrase counter to link DATA's
    	if( ctx.lastlabel = label ) then
    		ctx.labelcnt = ctx.labelcnt + 1
    		lname += "_" + str( ctx.labelcnt )
    	else
    		ctx.lastlabel = label
    		ctx.labelcnt = 0
    	end if

    	emitDATALABEL( lname )

    else
    	symbSetLastLabel( symbFindByNameAndClass( strptr( FB_DATALABELNAME ), _
    											  FB_SYMBCLASS_LABEL ) )
    end if

	'' emit will link the last DATA with this one if any exists
	emitDATABEGIN( lname )

end sub

'':::::
function rtlDataStore( byval littext as string, _
					   byval litlen as integer, _
					   byval typ as integer _
					 ) as integer static

	'' emit will take care of all dirty details
	emitDATA( littext, litlen, typ )

	function = TRUE

end function

'':::::
function rtlDataStoreOFS( byval sym as FBSYMBOL ptr ) as integer static

	emitDATAOFS( symbGetName( sym ) )

	function = TRUE

end function

'':::::
sub rtlDataStoreEnd static

	'' emit end of data (will be repatched by emit if more DATA stmts follow)
	emitDATAEND( )

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' math
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlMathPow	( byval xexpr as ASTNODE ptr, _
					  byval yexpr as ASTNODE ptr ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( POW ) )

    '' byval x as double
    if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

    '' byval y as double
    if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function

'':::::
function rtlMathFSGN ( byval expr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = NULL

	''
	if( astGetDataType( expr ) = IR_DATATYPE_SINGLE ) then
		f = PROCLOOKUP( SGNSINGLE )
	else
		f = PROCLOOKUP( SGNDOUBLE )
	end if

    proc = astNewFUNCT( f )

    '' byval x as single|double
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function

'':::::
function rtlMathTRANS( byval op as integer, _
					   byval expr as ASTNODE ptr ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = NULL

	''
	select case op
	case IR_OP_ASIN
		f = PROCLOOKUP( ASIN )
	case IR_OP_ACOS
		f = PROCLOOKUP( ACOS )
	case IR_OP_LOG
		f = PROCLOOKUP( LOG )
	end select

    proc = astNewFUNCT( f )

    '' byval x as double
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function


'':::::
function rtlMathFIX ( byval expr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = NULL

	''
	select case astGetDataClass( expr )
	case IR_DATACLASS_FPOINT
		if( astGetDataType( expr ) = IR_DATATYPE_SINGLE ) then
			f = PROCLOOKUP( FIXSINGLE )
		else
			f = PROCLOOKUP( FIXDOUBLE )
		end if

	case IR_DATACLASS_INTEGER
		return expr

	case else
		exit function
	end select

    proc = astNewFUNCT( f )

    '' byval x as single|double
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function

'':::::
'' note: hCalcExprLen must be called *before* astNewPARAM(e) because the
''       expression 'e' can be changed inside the former (address-of string's etc)
private function hCalcExprLen( byval expr as ASTNODE ptr, _
							   byval realsize as integer = TRUE ) as integer static

	dim as FBSYMBOL ptr s
	dim as integer lgt, dtype

	function = -1

	dtype = astGetDataType( expr )
	select case as const dtype
	case IR_DATATYPE_BYTE, IR_DATATYPE_UBYTE
		function = 1

	case IR_DATATYPE_SHORT, IR_DATATYPE_USHORT
		function = 2

	case IR_DATATYPE_INTEGER, IR_DATATYPE_UINT, IR_DATATYPE_ENUM
		function = FB_INTEGERSIZE

	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		function = FB_INTEGERSIZE*2

	case IR_DATATYPE_SINGLE
		function = 4

	case IR_DATATYPE_DOUBLE
		function = 8

	case IR_DATATYPE_STRING
		function = FB_STRDESCLEN

	case IR_DATATYPE_FIXSTR
		function = FIXSTRGETLEN( expr )

	case IR_DATATYPE_CHAR
		lgt = ZSTRGETLEN( expr )
		'' char?
		if( lgt = 0 ) then
			function = 1
		else
			function = lgt
		end if

	case IR_DATATYPE_USERDEF
		s = astGetSymbolOrElm( expr )
		if( s <> NULL ) then
			'' if it's a type field that's an udt, no padding is
			'' ever added, realsize is always TRUE
			if( s->class = FB_SYMBCLASS_UDTELM ) then
				realsize = TRUE
			end if
			function = symbGetUDTLen( symbGetSubtype( s ), realsize )
		else
			function = 0
		end if

	case else
		if( dtype >= IR_DATATYPE_POINTER ) then
			function = FB_POINTERSIZE
		end if
	end select

end function

'':::::
function rtlMathLen( byval expr as ASTNODE ptr, _
					 byval checkstrings as integer = TRUE ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer dtype, lgt

	function = NULL

	dtype = astGetDataType( expr )

	'' LEN()?
	if( checkstrings ) then
		'' dyn-len or zstring?
		if( (dtype = IR_DATATYPE_STRING) or (dtype = IR_DATATYPE_CHAR) ) then
    		proc = astNewFUNCT( PROCLOOKUP( STRLEN ) )

    		'' always calc len before pushing the param
    		STRGETLEN( expr, dtype, lgt )

    		'' str as any
    		if( astNewPARAM( proc, expr, IR_DATATYPE_STRING ) = NULL ) then
 				exit function
 			end if

    		'' byval strlen as integer
			if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
 				exit function
 			end if

			return proc
		end if
	end if

	''
	lgt = hCalcExprLen( expr, FALSE )

	'' handle fix-len strings (evaluated at compile-time)
	if( checkstrings ) then
		if( dtype = IR_DATATYPE_FIXSTR ) then
			if( lgt > 0 ) then
				lgt -= 1						'' less the null-term
			end if
		end if
	end if

	function = astNewCONSTi( lgt, IR_DATATYPE_INTEGER )

	astDelTree( expr )

end function

'':::::
function rtlMathLongintDIV( byval dtype as integer, _
							byval lexpr as ASTNODE ptr, _
							byval ldtype as integer, _
					        byval rexpr as ASTNODE ptr, _
					        byval rdtype as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = NULL

	if( dtype = IR_DATATYPE_LONGINT ) then
		f = PROCLOOKUP( LONGINTDIV )
	else
		f = PROCLOOKUP( ULONGINTDIV )
	end if

    proc = astNewFUNCT( f )

    ''
    if( astNewPARAM( proc, lexpr, ldtype ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, rexpr, rdtype ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlMathLongintMOD( byval dtype as integer, _
							byval lexpr as ASTNODE ptr, _
							byval ldtype as integer, _
					        byval rexpr as ASTNODE ptr, _
					        byval rdtype as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = NULL

	if( dtype = IR_DATATYPE_LONGINT ) then
		f = PROCLOOKUP( LONGINTMOD )
	else
		f = PROCLOOKUP( ULONGINTMOD )
	end if

    proc = astNewFUNCT( f )

    ''
    if( astNewPARAM( proc, lexpr, ldtype ) = NULL ) then
    	exit function
    end if

    if( astNewPARAM( proc, rexpr, rdtype ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlMathFp2ULongint( byval expr as ASTNODE ptr, _
							 byval dtype as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( DBL2ULONGINT)  )

    ''
    if( astNewPARAM( proc, expr, dtype ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' console
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlPrint( byval fileexpr as ASTNODE ptr, _
				   byval iscomma as integer, _
				   byval issemicolon as integer, _
				   byval expr as ASTNODE ptr, _
                   byval islprint as integer = FALSE ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer mask, args, dtype

    function = FALSE

	if( expr = NULL ) then
		if( islprint ) then
			f = PROCLOOKUP( LPRINTVOID )
		else
			f = PROCLOOKUP( PRINTVOID )
		end if
		args = 2
	else

		dtype = astGetDataType( expr )
		select case as const dtype
		case IR_DATATYPE_FIXSTR, IR_DATATYPE_STRING, IR_DATATYPE_CHAR
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSTR )
			else
				f = PROCLOOKUP( PRINTSTR )
			end if
		case IR_DATATYPE_BYTE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTBYTE )
			else
				f = PROCLOOKUP( PRINTBYTE )
			end if
		case IR_DATATYPE_UBYTE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTUBYTE )
			else
				f = PROCLOOKUP( PRINTUBYTE )
			end if
		case IR_DATATYPE_SHORT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSHORT )
			else
				f = PROCLOOKUP( PRINTSHORT )
			end if
		case IR_DATATYPE_USHORT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTUSHORT )
			else
				f = PROCLOOKUP( PRINTUSHORT )
			end if
		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			if( islprint ) then
				f = PROCLOOKUP( LPRINTINT )
			else
				f = PROCLOOKUP( PRINTINT )
			end if
		case IR_DATATYPE_UINT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTUINT )
			else
				f = PROCLOOKUP( PRINTUINT )
			end if
		case IR_DATATYPE_LONGINT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTLONGINT )
			else
				f = PROCLOOKUP( PRINTLONGINT )
			end if
		case IR_DATATYPE_ULONGINT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTULONGINT )
			else
				f = PROCLOOKUP( PRINTULONGINT )
			end if
		case IR_DATATYPE_SINGLE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSINGLE )
			else
				f = PROCLOOKUP( PRINTSINGLE )
			end if
		case IR_DATATYPE_DOUBLE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTDOUBLE )
			else
				f = PROCLOOKUP( PRINTDOUBLE )
			end if

		case IR_DATATYPE_USERDEF
			exit function						'' illegal

		case else
			if( dtype >= IR_DATATYPE_POINTER ) then
				if( islprint ) then
					f = PROCLOOKUP( LPRINTUINT )
				else
					f = PROCLOOKUP( PRINTUINT )
				end if
				expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
			end if
		end select

		args = 3
	end if

    ''
	proc = astNewFUNCT( f )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    if( expr <> NULL ) then
    	'' byval? x as ???
    	if( astNewPARAM( proc, expr ) = NULL ) then
 			exit function
 		end if
    end if

    '' byval mask as integer
	mask = 0
	if( iscomma ) then
		mask or= FB_PRINTMASK_PAD
	elseif( not issemicolon ) then
		mask or= FB_PRINTMASK_NEWLINE
	end if

	expr = astNewCONSTi( mask, IR_DATATYPE_INTEGER )
    if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintSPC( byval fileexpr as ASTNODE ptr, _
					  byval expr as ASTNODE ptr, _
                      byval islprint as integer = FALSE ) as integer static

    dim as ASTNODE ptr proc

	function = FALSE

    if islprint then
    	hPrinter_cb( NULL )
    end if

	''
    proc = astNewFUNCT( PROCLOOKUP( PRINTSPC ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' byval n as integer
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintTab( byval fileexpr as ASTNODE ptr, _
					  byval expr as ASTNODE ptr, _
                      byval islprint as integer = FALSE ) as integer static

    dim as ASTNODE ptr proc

	function = FALSE

    if islprint then
    	hPrinter_cb( NULL )
    end if

	''
    proc = astNewFUNCT( PROCLOOKUP( PRINTTAB ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' byval newcol as integer
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlWrite( byval fileexpr as ASTNODE ptr, _
				   byval iscomma as integer, _
				   byval expr as ASTNODE ptr ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer mask, args, dtype

	function = FALSE

	if( expr = NULL ) then
		f = PROCLOOKUP( WRITEVOID)
		args = 2
	else

		dtype = astGetDataType( expr )
		select case as const dtype
		case IR_DATATYPE_FIXSTR, IR_DATATYPE_STRING, IR_DATATYPE_CHAR
			f = PROCLOOKUP( WRITESTR )
		case IR_DATATYPE_BYTE
			f = PROCLOOKUP( WRITEBYTE )
		case IR_DATATYPE_UBYTE
			f = PROCLOOKUP( WRITEUBYTE )
		case IR_DATATYPE_SHORT
			f = PROCLOOKUP( WRITESHORT )
		case IR_DATATYPE_USHORT
			f = PROCLOOKUP( WRITEUSHORT )
		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			f = PROCLOOKUP( WRITEINT )
		case IR_DATATYPE_UINT
			f = PROCLOOKUP( WRITEUINT )
		case IR_DATATYPE_LONGINT
			f = PROCLOOKUP( WRITELONGINT )
		case IR_DATATYPE_ULONGINT
			f = PROCLOOKUP( WRITEULONGINT )
		case IR_DATATYPE_SINGLE
			f = PROCLOOKUP( WRITESINGLE )
		case IR_DATATYPE_DOUBLE
			f = PROCLOOKUP( WRITEDOUBLE )
		case IR_DATATYPE_USERDEF
			exit function						'' illegal
		case else
			if( dtype >= IR_DATATYPE_POINTER ) then
				f = PROCLOOKUP( WRITEUINT )
				expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
			end if
		end select

		args = 3
	end if

    ''
	proc = astNewFUNCT( f )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    if( expr <> NULL ) then
    	'' byval? x as ???
    	if( astNewPARAM( proc, expr ) = NULL ) then
 			exit function
 		end if
    end if

    '' byval mask as integer
	mask = 0
	if( iscomma ) then
		mask or= FB_PRINTMASK_PAD
	else
		mask or= FB_PRINTMASK_NEWLINE
	end if

    if( astNewPARAM( proc, astNewCONSTi( mask, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsingInit( byval usingexpr as ASTNODE ptr, _
                            byval islprint as integer = FALSE ) as integer static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = FALSE

	''
	if( islprint ) then
		f = PROCLOOKUP( LPRINTUSGINIT )
	else
		f = PROCLOOKUP( PRINTUSGINIT )
	end if
    proc = astNewFUNCT( f )

    '' fmtstr as string
    if( astNewPARAM( proc, usingexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsingEnd( byval fileexpr as ASTNODE ptr, _
                           byval islprint as integer = FALSE ) as integer static

    dim as ASTNODE ptr proc

	function = FALSE

    if islprint then
    	hPrinter_cb( NULL )
    end if

	''
    proc = astNewFUNCT( PROCLOOKUP( PRINTUSGEND ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsing( byval fileexpr as ASTNODE ptr, _
						byval expr as ASTNODE ptr, _
						byval iscomma as integer, _
						byval issemicolon as integer, _
                        byval islprint as integer = FALSE ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer mask

	function = FALSE

    if islprint then
    	hPrinter_cb( NULL )
    end if

	select case astGetDataType( expr )
	case IR_DATATYPE_FIXSTR, IR_DATATYPE_STRING, IR_DATATYPE_CHAR
		f = PROCLOOKUP( PRINTUSGSTR )
	case else
		f = PROCLOOKUP( PRINTUSGVAL )
	end select

	proc = astNewFUNCT( f )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' s as string or byval v as double
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    '' byval mask as integer
	if( iscomma or issemicolon ) then
		mask = 0
	else
		mask = FB_PRINTMASK_NEWLINE or FB_PRINTMASK_ISLAST
	end if

    if( astNewPARAM( proc, astNewCONSTi( mask, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlCpuCheck( ) as integer static
	dim as ASTNODE ptr proc, cpu
	dim as FBSYMBOL ptr s, label

	function = FALSE

	''
	proc = astNewFUNCT( PROCLOOKUP( CPUDETECT ), NULL, TRUE )

	'' cpu = fb_CpuDetect shr 24
	cpu = astNewBOP( IR_OP_SHR, proc, astNewCONSTi( 24, IR_DATATYPE_UINT ) )

	'' if( cpu < env.clopt.cputype ) then
	label = symbAddLabel( NULL )
	astAdd( astNewBOP( IR_OP_GE, cpu, astNewCONSTi( env.clopt.cputype, IR_DATATYPE_UINT ), label, FALSE ) )

	'' print "This program requires at least a <cpu> to run."
	s = hAllocStringConst( "This program requires at least a " + str( env.clopt.cputype ) + "86 to run.", -1 )
	rtlPrint astNewCONSTi( 0, IR_DATATYPE_INTEGER ), FALSE, FALSE, astNewVAR( s, NULL, 0, IR_DATATYPE_FIXSTR )

	'' end 1
    proc = astNewFUNCT( PROCLOOKUP( END ), NULL, TRUE )
    if( astNewPARAM( proc, astNewCONSTi( 1, IR_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if
    astAdd( proc )

	'' end if
	astAdd( astNewLABEL( label ) )

	function = TRUE

end function

'':::::
function rtlInitSignals( ) as integer static
    dim as ASTNODE ptr proc

	function = FALSE

	'' init( )
    proc = astNewFUNCT( PROCLOOKUP( INITSIGNALS ), NULL, TRUE )

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlInitProfile( ) as integer static
    dim as ASTNODE ptr proc

	function = FALSE

	'' init( )
    proc = astNewFUNCT( PROCLOOKUP( INITPROFILE ), NULL, TRUE )

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlInitRt( byval argc as ASTNODE ptr, _
					byval argv as ASTNODE ptr, _
					byval isdllmain as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

    '' call default CRT0 constructors (only required for Win32) */
	if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
		'' __main()
    	proc = astNewFUNCT( PROCLOOKUP( INITCRTCTOR ), NULL, TRUE )
    	astAdd( proc )
    end if

	'' init( argc, argv )
    proc = astNewFUNCT( PROCLOOKUP( INIT ), NULL, TRUE )

    '' argc
    if( argc = NULL ) then
    	argc = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, argc ) = NULL ) then
    	exit function
    end if

    '' argv
    if( argv = NULL ) then
    	argv = astNewCONSTi( 0, IR_DATATYPE_POINTER+IR_DATATYPE_VOID )
    end if
    if( astNewPARAM( proc, argv ) = NULL ) then
    	exit function
    end if

    astAdd( proc )

    function = proc

    '' if error checking is on, call initSignals
    if( env.clopt.errorcheck ) then
    	if( not isdllmain ) then
    		rtlInitSignals( )
    	end if
	end if

    '' start profiling if requested
    if( env.clopt.profile ) then
	    if( not isdllmain ) then
	    	rtlInitProfile( )
	    end if
    end if

    '' if error checking is on, check the CPU type
    if( env.clopt.errorcheck ) then
    	if( not isdllmain ) then
    		rtlCpuCheck( )
    	end if
    end if

    '' call all freebasic constructor functions
    '' CallCTORS()
    proc = astNewFUNCT( PROCLOOKUP( INITCTOR ), NULL, TRUE )
    astAdd( proc )

end function

'':::::
function rtlExitRt( byval errlevel as ASTNODE ptr ) as integer static
    dim as ASTNODE ptr proc

	function = FALSE

    if( errlevel = NULL ) then
    	errlevel = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if

	'' exit profiling?
	if( env.clopt.profile ) then
		proc = astNewFUNCT( PROCLOOKUP( PROFILEEND ), NULL, TRUE )
    	'' errlevel
    	if( astNewPARAM( proc, errlevel ) = NULL ) then
    		exit function
    	end if
    	errlevel = proc
	end if

    '' end( level )
    proc = astNewFUNCT( PROCLOOKUP( END ), NULL, TRUE )

    '' errlevel
    if( astNewPARAM( proc, errlevel ) = NULL ) then
    	exit function
    end if

    astAdd( proc )

end function

'':::::
function rtlMemCopy( byval dst as ASTNODE ptr, _
					 byval src as ASTNODE ptr, _
					 byval bytes as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( MEMCOPY ) )

    '' dst as any
    if( astNewPARAM( proc, dst ) = NULL ) then
    	exit function
    end if

    '' src as any
    if( astNewPARAM( proc, src ) = NULL ) then
    	exit function
    end if

    '' byval bytes as integer
    if( astNewPARAM( proc, astNewCONSTi( bytes, IR_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    ''
    function = proc

end function

'':::::
function rtlMemSwap( byval dst as ASTNODE ptr, _
					 byval src as ASTNODE ptr ) as integer static

    dim as ASTNODE ptr proc
    dim as integer bytes

    function = FALSE

	'' simple type?
	if( (astGetDataType( dst ) <> IR_DATATYPE_USERDEF) and (astIsVAR( dst )) ) then

		'' push src
		astAdd( astNewSTACK( IR_OP_PUSH, astCloneTree( src ) ) )

		'' src = dst
		astAdd( astNewASSIGN( src, astCloneTree( dst ) ) )

		'' pop dst
		astAdd( astNewSTACK( IR_OP_POP, dst ) )

		exit sub
	end if

	''
    proc = astNewFUNCT( PROCLOOKUP( MEMSWAP ) )

    '' always calc len before pushing the param
    bytes = hCalcExprLen( dst )

    '' dst as any
    if( astNewPARAM( proc, dst ) = NULL ) then
    	exit function
    end if

    '' src as any
    if( astNewPARAM( proc, src ) = NULL ) then
    	exit function
    end if

    '' byval bytes as integer
    if( astNewPARAM( proc, astNewCONSTi( bytes, IR_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlStrSwap( byval str1 as ASTNODE ptr, _
					 byval str2 as ASTNODE ptr ) as integer static

    dim as ASTNODE ptr proc
    dim as integer lgt, dtype

	function = FALSE

	''
    proc = astNewFUNCT( PROCLOOKUP( STRSWAP ) )

	'' always calc len before pushing the param
	dtype = astGetDataType( str1 )
	STRGETLEN( str1, dtype, lgt )

    '' str1 as any
    if( astNewPARAM( proc, str1, IR_DATATYPE_STRING ) = NULL ) then
    	exit function
    end if

    '' byval str1len as integer
	if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' always calc len before pushing the param
	dtype = astGetDataType( str2 )
	STRGETLEN( str2, dtype, lgt )

    '' str2 as any
    if( astNewPARAM( proc, str2, IR_DATATYPE_STRING ) = NULL ) then
    	exit function
    end if

    '' byval str1len as integer
	if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlMemCopyClear( byval dstexpr as ASTNODE ptr, _
					      byval dstlen as integer, _
					      byval srcexpr as ASTNODE ptr, _
					      byval srclen as integer ) as integer static

    dim as ASTNODE ptr proc

	function = FALSE

	''
    proc = astNewFUNCT( PROCLOOKUP( MEMCOPYCLEAR ) )

    '' dst as any
    if( astNewPARAM( proc, dstexpr ) = NULL ) then
    	exit function
    end if

    '' byval dstlen as integer
    if( astNewPARAM( proc, astNewCONSTi( dstlen, IR_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    '' src as any
    if( astNewPARAM( proc, srcexpr ) = NULL ) then
    	exit function
    end if

    '' byval srclen as integer
    if( astNewPARAM( proc, astNewCONSTi( srclen, IR_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlConsoleView ( byval topexpr as ASTNODE ptr, _
						  byval botexpr as ASTNODE ptr ) as ASTNODE ptr

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( CONSOLEVIEW ) )

    '' byval toprow as integer
    if( astNewPARAM( proc, topexpr ) = NULL ) then
    	exit function
    end if

    '' byval botrow as integer
    if( astNewPARAM( proc, botexpr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlLocate ( byval row_arg as ASTNODE ptr, _
					 byval col_arg as ASTNODE ptr, _
					 byval cursor_vis_arg as ASTNODE ptr, _
                     byval isfunc as integer ) as ASTNODE ptr

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = NULL

	''
    if( isfunc ) then
		f = PROCLOOKUP( LOCATE_FN )
    else
		f = PROCLOOKUP( LOCATE_SUB )
    end if
    proc = astNewFUNCT( f )

    '' byval row_arg as integer
    if( row_arg = NULL ) then
    	row_arg = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, row_arg ) = NULL ) then
    	exit function
    end if

    '' byval col_arg as integer
    if( col_arg = NULL ) then
        col_arg = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, col_arg ) = NULL ) then
    	exit function
    end if

    '' byval cursor_vis_arg as integer
    if( cursor_vis_arg = NULL ) then
        cursor_vis_arg = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, cursor_vis_arg ) = NULL ) then
    	exit function
    end if

    if( not isfunc ) then
    	dim reslabel as FBSYMBOL ptr
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if
end function

'':::::
function rtlWidthScreen ( byval width_arg as ASTNODE ptr, _
					      byval height_arg as ASTNODE ptr, _
                          byval isfunc as integer ) as ASTNODE ptr

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( WIDTH ) )

    '' byval width_arg as integer
    if( width_arg = NULL ) then
    	width_arg = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, width_arg ) = NULL ) then
    	exit function
    end if

    '' byval height_arg as integer
    if( height_arg = NULL ) then
        height_arg = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, height_arg ) = NULL ) then
    	exit function
    end if

    if( not isfunc ) then
    	dim reslabel as FBSYMBOL ptr
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if
end function

'':::::
function rtlWidthDev ( byval device as ASTNODE ptr, _
					   byval width_arg as ASTNODE ptr, _
                       byval isfunc as integer ) as ASTNODE ptr

    dim as ASTNODE ptr proc

	function = NULL

    '' printer libraries are always required for width on devices
	hPrinter_cb( NULL )

	''
    proc = astNewFUNCT( PROCLOOKUP( WIDTHDEV ) )

    '' device as string
    if( astNewPARAM( proc, device ) = NULL ) then
    	exit function
    end if

    '' byval width_arg as integer
    if( astNewPARAM( proc, width_arg ) = NULL ) then
    	exit function
    end if

    ''
    if( not isfunc ) then
    	dim reslabel as FBSYMBOL ptr

    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if
end function

'':::::
function rtlWidthFile ( byval fnum as ASTNODE ptr, _
					    byval width_arg as ASTNODE ptr, _
                        byval isfunc as integer ) as ASTNODE ptr

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( WIDTHFILE ) )

    '' byval fnum as integer
    if( astNewPARAM( proc, fnum ) = NULL ) then
    	exit function
    end if

    '' byval width_arg as integer
    if( astNewPARAM( proc, width_arg ) = NULL ) then
    	exit function
    end if

    if( not isfunc ) then
    	dim reslabel as FBSYMBOL ptr

    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if
end function

'':::::
function rtlConsoleReadXY ( byval rowexpr as ASTNODE ptr, _
							byval columnexpr as ASTNODE ptr, _
							byval colorflagexpr as ASTNODE ptr ) as ASTNODE ptr

	dim as ASTNODE ptr proc

	function = NULL

	''
	proc = astNewFUNCT( PROCLOOKUP( CONSOLEREADXY ) )

	'' byval column as integer
	if( astNewPARAM( proc, columnexpr ) = NULL ) then
    	exit function
    end if

	'' byval row as integer
	if( astNewPARAM( proc, rowexpr ) = NULL ) then
    	exit function
    end if

	'' byval colorflag as integer
	if( colorflagexpr = NULL ) then
		colorflagexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
	end if
	if( astNewPARAM( proc, colorflagexpr ) = NULL ) then
    	exit function
    end if

	function = proc

end function

'':::::
private function hMultithread_cb( byval sym as FBSYMBOL ptr ) as integer

	env.clopt.multithreaded = TRUE

	return TRUE

end function

'':::::
private function hPorts_cb( byval sym as FBSYMBOL ptr ) as integer
    static as integer libsAdded = FALSE

	if( not libsadded ) then
		libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			symbAddLib( "advapi32" )
		end select
	end if

	function = TRUE

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' error
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function rtlErrorCheck( byval resexpr as ASTNODE ptr, _
						byval reslabel as FBSYMBOL ptr, _
						byval linenum as integer ) as integer static

	dim as ASTNODE ptr proc, param, dst
	dim as FBSYMBOL ptr nxtlabel

	function = FALSE

	if( not env.clopt.errorcheck ) then
		astAdd( resexpr )
		return TRUE
	end if

	''
	proc = astNewFUNCT( PROCLOOKUP( ERRORTHROW ) )

	''
	nxtlabel = symbAddLabel( NULL )

	'' result >= FB_RTERROR_OK? skip..
	resexpr = astNewBOP( IR_OP_EQ, resexpr, astNewCONSTi( 0, IR_DATATYPE_INTEGER ), nxtlabel, FALSE )

	astAdd( resexpr )

	'' else, fb_ErrorThrow( linenum, reslabel, resnxtlabel ); -- CDECL

    '' linenum
	if( astNewPARAM( proc, astNewCONSTi( linenum, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' reslabel
	if( reslabel <> NULL ) then
		param = astNewADDR( IR_OP_ADDROF, astNewVAR( reslabel, NULL, 0, IR_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, IR_DATATYPE_UINT )
	end if
	if( astNewPARAM( proc, param ) = NULL ) then
		exit function
	end if

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDR( IR_OP_ADDROF, astNewVAR( nxtlabel, NULL, 0, IR_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, IR_DATATYPE_UINT )
	end if
	if( astNewPARAM( proc, param ) = NULL ) then
		exit function
	end if

    '' dst
    dst = astNewBRANCH( IR_OP_JUMPPTR, NULL, proc )

    astAdd( dst )

	''
	astAdd( astNewLABEL( nxtlabel ) )

	'''''symbDelLabel nxtlabel
	'''''symbDelLabel reslabel

	function = TRUE

end function

'':::::
sub rtlErrorThrow( byval errexpr as ASTNODE ptr, _
				   byval linenum as integer ) static

	dim as ASTNODE ptr proc, param, dst
	dim as FBSYMBOL ptr nxtlabel, reslabel

	''
	proc = astNewFUNCT( PROCLOOKUP( ERRORTHROWEX ) )

	''
    reslabel = symbAddLabel( NULL )
    astAdd( astNewLABEL( reslabel ) )

	nxtlabel = symbAddLabel( NULL )

	'' fb_ErrorThrowEx( errnum, linenum, reslabel, resnxtlabel );

	'' errnum
	if( astNewPARAM( proc, errexpr ) = NULL ) then
		exit sub
	end if

    '' linenum
	if( astNewPARAM( proc, astNewCONSTi( linenum, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit sub
    end if

	'' reslabel
	if( env.clopt.resumeerr ) then
		param = astNewADDR( IR_OP_ADDROF, astNewVAR( reslabel, NULL, 0, IR_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, IR_DATATYPE_UINT )
	end if
	if( astNewPARAM( proc, param ) = NULL ) then
		exit function
	end if

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDR( IR_OP_ADDROF, astNewVAR( nxtlabel, NULL, 0, IR_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, IR_DATATYPE_UINT )
	end if
	if( astNewPARAM( proc, param ) = NULL ) then
		exit function
	end if

    '' dst
    dst = astNewBRANCH( IR_OP_JUMPPTR, NULL, proc )

    astAdd( dst )

	''
	astAdd( astNewLABEL( nxtlabel ) )

	'''''symbDelLabel nxtlabel
	'''''symbDelLabel reslabel

end sub

'':::::
sub rtlErrorSetHandler( byval newhandler as ASTNODE ptr, _
						byval savecurrent as integer ) static

    dim as ASTNODE ptr proc, expr

	''
    proc = astNewFUNCT( PROCLOOKUP( ERRORSETHANDLER ) )

    '' byval newhandler as uint
    if( astNewPARAM( proc, newhandler ) = NULL ) then
    	exit sub
    end if

    ''
    expr = NULL
    if( savecurrent ) then
    	if( fbIsLocal( ) ) then
    		if( env.procerrorhnd = NULL ) then
				env.procerrorhnd = symbAddTempVar( FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID )
                expr = astNewVAR( env.procerrorhnd, NULL, 0, IR_DATATYPE_POINTER+IR_DATATYPE_VOID )
                astAdd( astNewASSIGN( expr, proc ) )
    		end if
		end if
    end if

    if( expr = NULL ) then
    	astAdd( proc )
    end if

end sub

'':::::
function rtlErrorGetNum as ASTNODE ptr static
    dim as ASTNODE ptr proc

	''
    proc = astNewFUNCT( PROCLOOKUP( ERRORGETNUM ) )

    ''
    function = proc

end function

'':::::
sub rtlErrorSetNum( byval errexpr as ASTNODE ptr ) static
    dim as ASTNODE ptr proc

	''
    proc = astNewFUNCT( PROCLOOKUP( ERRORSETNUM ) )

    '' byval errnum as integer
    if( astNewPARAM( proc, errexpr ) = NULL ) then
    	exit sub
    end if

    ''
    astAdd( proc )

end sub

'':::::
sub rtlErrorResume( byval isnext as integer )
    dim as ASTNODE ptr proc, dst
    dim as FBSYMBOL ptr f

	''
	if( not isnext ) then
		f = PROCLOOKUP( ERRORRESUME )
	else
		f = PROCLOOKUP( ERRORRESUMENEXT )
	end if

	proc = astNewFUNCT( f )

    ''
    dst = astNewBRANCH( IR_OP_JUMPPTR, NULL, proc )

    astAdd( dst )

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' file
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlFileOpen( byval filename as ASTNODE ptr, _
					  byval fmode as ASTNODE ptr, _
					  byval faccess as ASTNODE ptr, _
				      byval flock as ASTNODE ptr, _
				      byval filenum as ASTNODE ptr, _
				      byval flen as ASTNODE ptr, _
				      byval isfunc as integer, _
                      byval openkind as FBOPENKIND ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f, reslabel

	function = NULL

    select case astGetDataType( fmode )
    case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR:
        '' this is the short form of the OPEN command
        proc = astNewFUNCT( PROCLOOKUP( FILEOPEN_SHORT ) )

        '' mode as string
        if( astNewPARAM( proc, fmode ) = NULL ) then
            exit function
        end if

        '' byval filenum as integer
        if( astNewPARAM( proc, filenum ) = NULL ) then
            exit function
        end if

        '' filename as string
        if( astNewPARAM( proc, filename ) = NULL ) then
            exit function
        end if

        '' byval len as integer
        if( astNewPARAM( proc, flen ) = NULL ) then
            exit function
        end if

        '' faccess as string
        if( astNewPARAM( proc, faccess ) = NULL ) then
            exit function
        end if

        '' flock as string
        if( astNewPARAM( proc, flock ) = NULL ) then
            exit function
        end if

    case else
        ''
        select case openkind
        case FB_FILE_TYPE_FILE
        	f = PROCLOOKUP( FILEOPEN )
    	case FB_FILE_TYPE_CONS
        	f = PROCLOOKUP( FILEOPEN_CONS )
    	case FB_FILE_TYPE_ERR
        	f = PROCLOOKUP( FILEOPEN_ERR )
    	case FB_FILE_TYPE_PIPE
        	f = PROCLOOKUP( FILEOPEN_PIPE )
    	case FB_FILE_TYPE_SCRN
        	f = PROCLOOKUP( FILEOPEN_SCRN )
    	case FB_FILE_TYPE_LPT
        	f = PROCLOOKUP( FILEOPEN_LPT )
    	case FB_FILE_TYPE_COM
        	f = PROCLOOKUP( FILEOPEN_COM )
        end select

        proc = astNewFUNCT( f )

        '' filename as string
        if( astNewPARAM( proc, filename ) = NULL ) then
            exit function
        end if

        '' byval mode as integer
        if( astNewPARAM( proc, fmode ) = NULL ) then
            exit function
        end if

        '' byval access as integer
        if( astNewPARAM( proc, faccess ) = NULL ) then
            exit function
        end if

        '' byval lock as integer
        if( astNewPARAM( proc, flock ) = NULL ) then
            exit function
        end if

        '' byval filenum as integer
        if( astNewPARAM( proc, filenum ) = NULL ) then
            exit function
        end if

        '' byval len as integer
        if( astNewPARAM( proc, flen ) = NULL ) then
            exit function
        end if
    end select

    ''
    if( not isfunc ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileClose( byval filenum as ASTNODE ptr, _
					   byval isfunc as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( FILECLOSE ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum ) = NULL ) then
 		exit function
 	end if

    ''
    if( not isfunc ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileSeek( byval filenum as ASTNODE ptr, _
					  byval newpos as ASTNODE ptr ) as integer static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

	function = FALSE

	''
    proc = astNewFUNCT( PROCLOOKUP( FILESEEK ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval newpos as integer
    if( astNewPARAM( proc, newpos ) = NULL ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

    ''
    function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::
function rtlFileTell( byval filenum as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc

    function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( FILETELL ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function

'':::::
function rtlFilePut( byval filenum as ASTNODE ptr, _
					 byval offset as ASTNODE ptr, _
					 byval src as ASTNODE ptr, _
					 byval isfunc as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer dtype, lgt, isstring
    dim as FBSYMBOL ptr f, reslabel

    function = NULL

	''
	dtype = astGetDataType( src )
	isstring = hIsString( dtype )
	if( isstring ) then
		f = PROCLOOKUP( FILEPUTSTR )
	else
		f = PROCLOOKUP( FILEPUT )
	end if

    proc = astNewFUNCT( f )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
    if( isstring ) then
    	STRGETLEN( src, dtype, lgt )
    else
    	lgt = hCalcExprLen( src )
    end if

    '' value as any | s as string
    if( astNewPARAM( proc, src ) = NULL ) then
 		exit function
 	end if

    '' byval valuelen as integer
   	if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ) ) = NULL ) then
		exit function
	end if

    ''
    if( not isfunc ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFilePutArray( byval filenum as ASTNODE ptr, _
						  byval offset as ASTNODE ptr, _
						  byval src as ASTNODE ptr, _
					 	  byval isfunc as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

    function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( FILEPUTARRAY ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' array() as any
    if( astNewPARAM( proc, src ) = NULL ) then
    	exit function
    end if

    ''
    if( not isfunc ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
	    	reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileGet( byval filenum as ASTNODE ptr, _
					 byval offset as ASTNODE ptr, _
					 byval dst as ASTNODE ptr, _
					 byval isfunc as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer dtype, lgt, isstring
    dim as FBSYMBOL ptr f, reslabel

    function = NULL

	''
	dtype = astGetDataType( dst )
	isstring = hIsString( dtype )
	if( isstring ) then
		f = PROCLOOKUP( FILEGETSTR )
	else
		f = PROCLOOKUP( FILEGET )
	end if

    proc = astNewFUNCT( f )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
    if( isstring ) then
    	STRGETLEN( dst, dtype, lgt )
    else
    	lgt = hCalcExprLen( dst )
    end if

    '' value as any
    if( astNewPARAM( proc, dst ) = NULL ) then
 		exit function
 	end if

    '' byval valuelen as integer
    if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

    ''
    if( not isfunc ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileGetArray( byval filenum as ASTNODE ptr, _
						  byval offset as ASTNODE ptr, _
						  byval dst as ASTNODE ptr, _
					 	  byval isfunc as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( FILEGETARRAY ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' array() as any
    if( astNewPARAM( proc, dst ) = NULL ) then
    	exit function
    end if

    ''
    if( not isfunc ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileStrInput( byval bytesexpr as ASTNODE ptr, _
						  byval filenum as ASTNODE ptr ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

    function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( FILESTRINPUT ) )

    '' byval bytes as integer
    if( astNewPARAM( proc, bytesexpr ) = NULL ) then
 		exit function
 	end if

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function

'':::::
function rtlFileLineInput( byval isfile as integer, _
						   byval expr as ASTNODE ptr, _
						   byval dstexpr as ASTNODE ptr, _
					       byval addquestion as integer, _
					       byval addnewline as integer ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args, lgt, dtype

	function = FALSE

	''
	if( isfile ) then
		f = PROCLOOKUP( FILELINEINPUT )
		args = 4
	else
		f = PROCLOOKUP( CONSOLELINEINPUT )
		args = 6
	end if

    proc = astNewFUNCT( f )

    '' "byval filenum as integer" or "text as string "
    if( (not isfile) and (expr = NULL) ) then
		expr = astNewVAR( hAllocStringConst( "", 0 ), NULL, 0, IR_DATATYPE_FIXSTR )
	end if

    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
	dtype = astGetDataType( dstexpr )
	STRGETLEN( dstexpr, dtype, lgt )

	'' dst as any
    if( astNewPARAM( proc, dstexpr ) = NULL ) then
 		exit function
 	end if

	'' byval dstlen as integer
	if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

	'' byval fillrem as integer
	if( astNewPARAM( proc, astNewCONSTi( dtype = IR_DATATYPE_FIXSTR, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    if( args = 6 ) then
    	'' byval addquestion as integer
 		if( astNewPARAM( proc, astNewCONSTi( addquestion, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if

    	'' byval addnewline as integer
    	if( astNewPARAM( proc, astNewCONSTi( addnewline, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
    end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileInput( byval isfile as integer, _
					   byval expr as ASTNODE ptr, _
				       byval addquestion as integer, _
				       byval addnewline as integer ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args

	function = FALSE

	''
	if( isfile ) then
		f = PROCLOOKUP( FILEINPUT )
		args = 1
	else
		f = PROCLOOKUP( CONSOLEINPUT )
		args = 3
	end if

    proc = astNewFUNCT( f )

    '' "byval filenum as integer" or "text as string "
    if( (not isfile) and (expr = NULL) ) then
		expr = astNewVAR( hAllocStringConst( "", 0 ), NULL, 0, IR_DATATYPE_FIXSTR )
	end if

	if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    if( args = 3 ) then
    	'' byval addquestion as integer
    	if( astNewPARAM( proc, astNewCONSTi( addquestion, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if

    	'' byval addnewline as integer
    	if( astNewPARAM( proc, astNewCONSTi( addnewline, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
    end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileInputGet( byval dstexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args, lgt, dtype

	function = FALSE

	''
	args = 1
	dtype = astGetDataType( dstexpr )
	select case as const dtype
	case IR_DATATYPE_FIXSTR, IR_DATATYPE_STRING, IR_DATATYPE_CHAR
		f = PROCLOOKUP( INPUTSTR )
		args = 3
	case IR_DATATYPE_BYTE, IR_DATATYPE_UBYTE
		f = PROCLOOKUP( INPUTBYTE )
	case IR_DATATYPE_SHORT, IR_DATATYPE_USHORT
		f = PROCLOOKUP( INPUTSHORT )
	case IR_DATATYPE_INTEGER, IR_DATATYPE_UINT, IR_DATATYPE_ENUM
		f = PROCLOOKUP( INPUTINT )
	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		f = PROCLOOKUP( INPUTLONGINT )
	case IR_DATATYPE_SINGLE
		f = PROCLOOKUP( INPUTSINGLE )
	case IR_DATATYPE_DOUBLE
		f = PROCLOOKUP( INPUTDOUBLE )
	case IR_DATATYPE_USERDEF
		exit function							'' illegal
	case else
		if( dtype >= IR_DATATYPE_POINTER ) then	'' non-sense but..
			f = PROCLOOKUP( INPUTINT )
			dstexpr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, dstexpr )
		end if
	end select

    proc = astNewFUNCT( f )

    '' always calc len before pushing the param
    if( args > 1 ) then
		STRGETLEN( dstexpr, dtype, lgt )
	end if

    '' dst as any
    if( astNewPARAM( proc, dstexpr ) = NULL ) then
 		exit function
 	end if

    if( args > 1 ) then
		'' byval dstlen as integer
		if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
 			exit function
 		end if

		'' byval fillrem as integer
		if( astNewPARAM( proc, astNewCONSTi( dtype = IR_DATATYPE_FIXSTR, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if
    end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileLock( byval islock as integer, _
					  byval filenum as ASTNODE ptr, _
					  byval iniexpr as ASTNODE ptr, _
					  byval endexpr as ASTNODE ptr ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = FALSE

	''
	if( islock ) then
		f = PROCLOOKUP( FILELOCK )
	else
		f = PROCLOOKUP( FILEUNLOCK )
	end if

    proc = astNewFUNCT( f )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval inipos as integer
    if( astNewPARAM( proc, iniexpr ) = NULL ) then
 		exit function
 	end if

    '' byval endpos as integer
    if( astNewPARAM( proc, endexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileRename( byval filename_new as ASTNODE ptr, _
                        byval filename_old as ASTNODE ptr, _
                        byval isfunc as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( FILERENAME ) )

    '' byval filename_old as string
    if( astNewPARAM( proc, filename_old ) = NULL ) then
 		exit function
 	end if

    '' byval filename_new as integer
    if( astNewPARAM( proc, filename_new ) = NULL ) then
 		exit function
 	end if

    ''
    if( not isfunc ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' gfx
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hMultinput_cb( byval sym as FBSYMBOL ptr ) as integer static
    static as integer libsAdded = FALSE

	if( not libsadded ) then
		libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			symbAddLib( "user32" )
		end select
	end if

	function = TRUE

end function

'':::::
private function hPrinter_cb( byval sym as FBSYMBOL ptr ) as integer static
    static as integer libsAdded = FALSE

	if( not libsadded ) then

        libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			symbAddLib( "winspool" )
		end select

	end if

    function = TRUE

end function

'':::::
private function hGfxlib_cb( byval sym as FBSYMBOL ptr ) as integer static
    static as integer libsAdded = FALSE

	if( not libsadded ) then
		libsAdded = TRUE

		symbAddLib( "fbgfx" )

		select case as const env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			symbAddLib( "user32" )
			symbAddLib( "gdi32" )
			symbAddLib( "winmm" )

		case FB_COMPTARGET_LINUX
#ifdef TARGET_LINUX
			fbAddLibPath( "/usr/X11R6/lib" )
#endif

			symbAddLib( "X11" )
			symbAddLib( "Xext" )
			symbAddLib( "Xpm" )
			symbAddLib( "Xrandr" )
			symbAddLib( "Xrender" )

		end select
	end if

	return TRUE
end function

'':::::
function rtlGfxPset( byval target as ASTNODE ptr, _
					 byval targetisptr as integer, _
					 byval xexpr as ASTNODE ptr, _
					 byval yexpr as ASTNODE ptr, _
					 byval cexpr as ASTNODE ptr, _
					 byval coordtype as integer, _
					 byval ispreset as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXPSET ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval color as uinteger
 	if( astNewPARAM( proc, cexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' byval ispreset as integer
 	if( astNewPARAM( proc, astNewCONSTi( ispreset, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPoint( byval target as ASTNODE ptr, _
					  byval targetisptr as integer, _
					  byval xexpr as ASTNODE ptr, _
					  byval yexpr as ASTNODE ptr ) as ASTNODE ptr

	dim as ASTNODE ptr proc
	dim as integer targetmode

	function = NULL

	proc = astNewFUNCT( PROCLOOKUP( GFXPOINT ) )

	'' byref target as any
	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( yexpr = NULL ) then
 		yexpr = astNewCONSTf( -1, IR_DATATYPE_SINGLE )
 	end if
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

	function = proc

end function

'':::::
function rtlGfxLine( byval target as ASTNODE ptr, _
					 byval targetisptr as integer, _
					 byval x1expr as ASTNODE ptr, _
					 byval y1expr as ASTNODE ptr, _
					 byval x2expr as ASTNODE ptr, _
					 byval y2expr as ASTNODE ptr, _
					 byval cexpr as ASTNODE ptr, _
					 byval linetype as integer, _
					 byval styleexpr as ASTNODE ptr, _
					 byval coordtype as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXLINE ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x1 as single
 	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y1 as single
 	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval x2 as single
 	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y2 as single
 	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval color as uinteger
 	if( astNewPARAM( proc, cexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval linetype as integer
 	if( astNewPARAM( proc, astNewCONSTi( linetype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' byval style as uinteger
 	if( styleexpr = NULL ) then
 		styleexpr = astNewCONSTi( &h0000FFFF, IR_DATATYPE_UINT )
 	end if
 	if( astNewPARAM( proc, styleexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxCircle( byval target as ASTNODE ptr, _
					   byval targetisptr as integer, _
					   byval xexpr as ASTNODE ptr, _
					   byval yexpr as ASTNODE ptr, _
					   byval radexpr as ASTNODE ptr, _
					   byval cexpr as ASTNODE ptr, _
					   byval aspexpr as ASTNODE ptr, _
					   byval iniexpr as ASTNODE ptr, _
					   byval endexpr as ASTNODE ptr, _
					   byval fillflag as integer, _
					   byval coordtype as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXCIRCLE ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval radians as single
 	if( astNewPARAM( proc, radexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval color as uinteger
 	if( astNewPARAM( proc, cexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval aspect as single
 	if( aspexpr = NULL ) then
 		aspexpr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
 	end if
 	if( astNewPARAM( proc, aspexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval arcini as single
 	if( iniexpr = NULL ) then
 		iniexpr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
 	end if
 	if( astNewPARAM( proc, iniexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval arcend as single
 	if( endexpr = NULL ) then
 		endexpr = astNewCONSTf( 3.141593*2, IR_DATATYPE_SINGLE )
 	end if
 	if( astNewPARAM( proc, endexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval fillflag as integer
 	if( astNewPARAM( proc, astNewCONSTi( fillflag, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPaint( byval target as ASTNODE ptr, _
					  byval targetisptr as integer, _
					  byval xexpr as ASTNODE ptr, _
					  byval yexpr as ASTNODE ptr, _
					  byval pexpr as ASTNODE ptr, _
					  byval bexpr as ASTNODE ptr, _
					  byval coord_type as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode, pattern

    function = FALSE

	proc = astNewFUNCT( PROCLOOKUP( GFXPAINT ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

	'' byval color as uinteger
	pattern = astGetDataType( pexpr )
	if( ( pattern = IR_DATATYPE_FIXSTR ) or ( pattern = IR_DATATYPE_STRING ) ) then
		pattern = TRUE
		if( astNewPARAM( proc, astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
	else
		pattern = FALSE
		if( astNewPARAM( proc, pexpr ) = NULL ) then
 			exit function
 		end if
	end if

	'' byval border_color as uinteger
	if( astNewPARAM( proc, bexpr ) = NULL ) then
 		exit function
 	end if

	'' pattern as string, byval mode as integer
	if( pattern = TRUE ) then
		if( astNewPARAM( proc, pexpr ) = NULL ) then
 			exit function
 		end if
		if( astNewPARAM( proc, astNewCONSTi( 1, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
	else
    	if( astNewPARAM( proc, astNewVAR( hAllocStringConst( "", 0 ), NULL, 0, IR_DATATYPE_FIXSTR ) ) = NULL ) then
 			exit function
 		end if
		if( astNewPARAM( proc, astNewCONSTi( 0, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
	end if

	'' byval coord_type as integer
	if( astNewPARAM( proc, astNewCONSTi( coord_type, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxDraw( byval target as ASTNODE ptr, _
					 byval targetisptr as integer, _
					 byval cexpr as ASTNODE ptr )

    dim as ASTNODE ptr proc
    dim as integer targetmode

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXDRAW ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' cmd as string
 	if( astNewPARAM( proc, cexpr ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxView( byval x1expr as ASTNODE ptr, _
					 byval y1expr as ASTNODE ptr, _
					 byval x2expr as ASTNODE ptr, _
					 byval y2expr as ASTNODE ptr, _
			    	 byval fillexpr as ASTNODE ptr, _
			    	 byval bordexpr as ASTNODE ptr, _
			    	 byval screenflag as integer ) as integer

    dim as ASTNODE ptr proc

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXVIEW ) )

 	'' byval x1 as integer
 	if( x1expr = NULL ) then
        x1expr = astNewCONSTi( -32768, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y1 as integer
 	if( y1expr = NULL ) then
        y1expr = astNewCONSTi( -32768, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval x2 as integer
 	if( x2expr = NULL ) then
        x2expr = astNewCONSTi( -32768, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y2 as integer
 	if( y2expr = NULL ) then
        y2expr = astNewCONSTi( -32768, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval fillcolor as uinteger
 	if( fillexpr = NULL ) then
 		fillexpr = astNewCONSTi( &hFEFF00FF, IR_DATATYPE_UINT )
 	end if
 	if( astNewPARAM( proc, fillexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval bordercolor as uinteger
 	if( bordexpr = NULL ) then
 		bordexpr = astNewCONSTi( &hFEFF00FF, IR_DATATYPE_UINT )
 	end if
 	if( astNewPARAM( proc, bordexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval screenflag as integer
 	if( astNewPARAM( proc, astNewCONSTi( screenflag, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxWindow( byval x1expr as ASTNODE ptr, _
					   byval y1expr as ASTNODE ptr, _
					   byval x2expr as ASTNODE ptr, _
					   byval y2expr as ASTNODE ptr, _
					   byval screenflag as integer ) as integer

    dim as ASTNODE ptr proc

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXWINDOW ) )

 	'' byval x1 as single
 	if( x1expr = NULL ) then
        x1expr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
    end if
 	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y1 as single
 	if( y1expr = NULL ) then
        y1expr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
    end if
 	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval x2 as single
 	if( x2expr = NULL ) then
        x2expr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
    end if
 	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y2 as single
 	if( y2expr = NULL ) then
        y2expr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
    end if
 	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval screenflag as integer
 	if( astNewPARAM( proc, astNewCONSTi( screenflag, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPalette ( byval attexpr as ASTNODE ptr, _
						 byval rexpr as ASTNODE ptr, _
						 byval gexpr as ASTNODE ptr, _
						 byval bexpr as ASTNODE ptr, _
						 byval isget as integer ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer defval, targetmode

	function = FALSE

    if( isget ) then
    	f = PROCLOOKUP( GFXPALETTEGET )
    else
    	f = PROCLOOKUP( GFXPALETTE )
    end if
	proc = astNewFUNCT( f )

	if( isget ) then
		targetmode = FB_ARGMODE_BYREF
		defval = 0
	else
		targetmode = FB_ARGMODE_BYVAL
		defval = -1
	end if

 	'' byval attr as integer
 	if( attexpr = NULL ) then
        attexpr = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, attexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval r as integer
 	if( rexpr = NULL ) then
        rexpr = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, rexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval g as integer
 	if( gexpr = NULL ) then
 		targetmode = FB_ARGMODE_BYVAL
        gexpr = astNewCONSTi( defval, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, gexpr, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval b as integer
 	if( bexpr = NULL ) then
        bexpr = astNewCONSTi( defval, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, bexpr, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPaletteUsing ( byval arrayexpr as ASTNODE ptr, _
							  byval isget as integer ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = FALSE

    if( isget ) then
    	f = PROCLOOKUP( GFXPALETTEGETUSING )
    else
    	f = PROCLOOKUP( GFXPALETTEUSING )
    end if
	proc = astNewFUNCT( f )

 	'' byref array as integer
 	if( astNewPARAM( proc, arrayexpr ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPut( byval target as ASTNODE ptr, _
					byval targetisptr as integer, _
					byval xexpr as ASTNODE ptr, _
					byval yexpr as ASTNODE ptr, _
			   		byval arrayexpr as ASTNODE ptr, _
			   		byval isptr as integer, _
					byval x1expr as ASTNODE ptr, _
					byval x2expr as ASTNODE ptr, _
					byval y1expr as ASTNODE ptr, _
					byval y2expr as ASTNODE ptr, _
			   		byval mode as integer, _
			   		byval alphaexpr as ASTNODE ptr, _
			   		byval funcexpr as ASTNODE ptr, _
			   		byval coordtype as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode, argmode
    dim as FBSYMBOL ptr reslabel

    function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXPUT ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

 	'' byref array as any
	if( isptr ) then
		argmode = FB_ARGMODE_BYVAL
	else
		argmode = INVALID
	end if
 	if( astNewPARAM( proc, arrayexpr, INVALID, argmode ) = NULL ) then
 		exit function
 	end if

 	'' area coordinates, if any
 	if( x1expr = NULL ) then
 		x1expr = astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER )
 		x2expr = astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER )
 		y1expr = astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER )
 		y2expr = astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER )
 	end if
  	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if
  	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if
  	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if
  	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' byval mode as integer
 	if( astNewPARAM( proc, astNewCONSTi( mode, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

	'' byval alpha as integer
	if( alphaexpr = NULL ) then
		alphaexpr = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
	end if
 	if( astNewPARAM( proc, alphaexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval func as function( src as uinteger, dest as uinteger ) as uinteger
 	if( funcexpr = NULL ) then
 		funcexpr = astNewCONSTi(0, IR_DATATYPE_INTEGER )
 	end if
 	if( astNewPARAM( proc, funcexpr ) = NULL ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

	function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::
function rtlGfxGet( byval target as ASTNODE ptr, _
					byval targetisptr as integer, _
					byval x1expr as ASTNODE ptr, _
					byval y1expr as ASTNODE ptr, _
					byval x2expr as ASTNODE ptr, _
					byval y2expr as ASTNODE ptr, _
			   		byval arrayexpr as ASTNODE ptr, _
			   		byval isptr as integer, _
			   		byval symbol as FBSYMBOL ptr, _
			   		byval coordtype as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode, argmode
    dim as FBSYMBOL ptr reslabel

    function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXGET ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x1 as single
 	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y1 as single
 	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval x2 as single
 	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y2 as single
 	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byref array as any
	if( isptr ) then
		argmode = FB_ARGMODE_BYVAL
	else
		argmode = INVALID
	end if
 	if( astNewPARAM( proc, arrayexpr, INVALID, argmode ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' array() as any
 	if( not isptr ) then
 		arrayexpr = astNewVAR( symbol, NULL, 0, symbGetType( symbol ) )
 	else
 		arrayexpr = astNewCONSTi( NULL, IR_DATATYPE_POINTER+IR_DATATYPE_VOID )
 	end if
 	if( astNewPARAM( proc, arrayexpr, INVALID, argmode ) = NULL ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

	function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::
function rtlGfxScreenSet( byval wexpr as ASTNODE ptr, _
						  byval hexpr as ASTNODE ptr, _
						  byval dexpr as ASTNODE ptr, _
						  byval pexpr as ASTNODE ptr, _
						  byval fexpr as ASTNODE ptr, _
						  byval rexpr as ASTNODE ptr ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f, reslabel

	function = FALSE

	if( hexpr = NULL ) then
		f = PROCLOOKUP( GFXSCREENSET )
	else
		f = PROCLOOKUP( GFXSCREENRES )
	end if
    proc = astNewFUNCT( f )

 	'' byval m as integer
 	if( astNewPARAM( proc, wexpr ) = NULL ) then
 		exit function
 	end if

	if( hexpr <> NULL ) then
		if( astNewPARAM( proc, hexpr ) = NULL ) then
			exit function
		end if
	end if

 	'' byval d as integer
 	if( dexpr = NULL ) then
 		dexpr = astNewCONSTi( 8, IR_DATATYPE_INTEGER )
 	end if
 	if( astNewPARAM( proc, dexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval depth as integer
 	if( pexpr = NULL ) then
 		pexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 	end if
 	if( astNewPARAM( proc, pexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval fullscreen s integer
 	if( fexpr = NULL ) then
 		fexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 	end if
 	if( astNewPARAM( proc, fexpr ) = NULL ) then
 		exit function
 	end if

	'' byval refresh_rate as integer
	if( rexpr = NULL ) then
		rexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
	end if
 	if( astNewPARAM( proc, rexpr ) = NULL ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

	function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' profiling
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hGetProcName( byval proc as FBSYMBOL ptr ) as ASTNODE ptr
	dim as string procname
	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr
	dim as integer at

	if( proc = NULL ) then
		s = hAllocStringConst( "(??)", -1 )

	else
		procname = symbGetName( proc )

		select case fbGetNaming( )
        case FB_COMPNAMING_WIN32, FB_COMPNAMING_CYGWIN
			procname = mid( procname, 2)
			at = instr( procname, "@" )
			if( at ) then
				procname = mid( procname, 1, at - 1 )
			end if
        end select

		if( len( procname ) and 3 ) then
			procname += string( 4 - ( len( procname ) and 3 ), 32 )
		end if
		s = hAllocStringConst( procname, -1 )
	end if

	expr = astNewADDR( IR_OP_ADDROF, astNewVAR( s, NULL, 0, IR_DATATYPE_FIXSTR ), s, NULL )

	function = expr

end function

'':::::
function rtlProfileBeginCall( byval symbol as FBSYMBOL ptr ) as ASTNODE ptr
	dim as ASTNODE ptr proc, expr

	function = NULL

	proc = astNewFUNCT( PROCLOOKUP( PROFILEBEGINCALL ), NULL, TRUE )

	expr = hGetProcName( symbol )
	if( astNewPARAM( proc, expr, INVALID, FB_ARGMODE_BYVAL ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlProfileEndCall( ) as ASTNODE ptr
    dim as ASTNODE ptr proc

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( PROFILEENDCALL ), NULL, TRUE )

  	function = proc

end function
