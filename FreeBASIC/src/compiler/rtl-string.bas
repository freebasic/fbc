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


'' intrinsic runtime lib string functions (MID, LEFT, STR, VAL, HEX, ...)
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"


'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

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

'' fb_StrSwap ( str1 as any, byval str1len as integer, str2 as any, byval str2len as integer ) as void
data @FB_RTL_STRSWAP,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

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

'' rset ( dst as string, src as string ) as void
data @"rset","fb_StrRset", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
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

'' EOL
data NULL


'':::::
sub rtlStringModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlStringModEnd( )

	'' procs will be deleted when symbEnd is called

end sub


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


