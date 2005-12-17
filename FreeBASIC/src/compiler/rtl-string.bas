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

'' fb_WstrConcat ( byval str1 as wstring ptr, _
'' 				   byval str2 as wstring ptr ) as wstring
data @FB_RTL_WSTRCONCAT,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrConcatWA ( byval str1 as wstring ptr, _
'' 				     byref str2 as any, _
''					 byval str2_len as integer ) as wstring
data @FB_RTL_WSTRCONCATWA,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrConcatAW ( byref str1 as any, _
''					 byval str1_len as integer, _
''					 byval str2 as wstring ptr ) as wstring
data @FB_RTL_WSTRCONCATAW,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

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

'' fb_WstrCompare ( byval str1 as wstring ptr, _
''				    byval str2 as wstring ptr ) as integer
'' returns: 0= equal; -1=str1 < str2; 1=str1 > str2
data @FB_RTL_WSTRCOMPARE,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

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

'' fb_WstrAssign ( byval dst as wstring ptr, byval dst_len as integer, _
'' 				   byval src as wstring ptr) as wstring ptr
data @FB_RTL_WSTRASSIGN,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrAssignFromA ( byval dst as wstring ptr, byval dst_len as integer, _
'' 				        byref src as any, byval src_len as integer ) as wstring ptr
data @FB_RTL_WSTRASSIGNWA,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrAssignToA ( byref dst as any, byval dst_len as integer, _
'' 				      byval src as wstring ptr, byval fillrem as integer ) as string
data @FB_RTL_WSTRASSIGNAW,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

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

'' fb_WstrConcatAssign ( byval dst as wstring ptr, byval dst_len as integer, _
'' 				         byval src as wstring ptr) as wstring ptr
data @FB_RTL_WSTRCONCATASSIGN,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrDelete ( byref str as string ) as void
data @FB_RTL_STRDELETE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrDelete ( byval str as wstring ptr ) as void
data @FB_RTL_WSTRDELETE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

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

'' fb_StrAllocTempDescZ ( byval str as zstring ptr ) as string
data @FB_RTL_STRALLOCTMPDESCZ,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_CHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrAllocTempDescZEx ( byval str as zstring ptr, byval len as integer ) as string
data @FB_RTL_STRALLOCTMPDESCZEX,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_CHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrAlloc ( byval len as integer ) as WSTRING ptr
data @FB_RTL_WSTRALLOC,"", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_IntToStr ( byval number as integer ) as string
data @FB_RTL_INT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_IntToWstr ( byval number as integer ) as wstring
data @FB_RTL_INT2WSTR,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_UIntToStr ( byval number as uinteger ) as string
data @FB_RTL_UINT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE

'' fb_UIntToWstr ( byval number as uinteger ) as wstring
data @FB_RTL_UINT2WSTR,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE

'' fb_LongintToStr ( byval number as longint ) as string
data @FB_RTL_LONGINT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_LongintToWstr ( byval number as longint ) as wstring
data @FB_RTL_LONGINT2WSTR,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_ULongintToStr ( byval number as ulongint ) as string
data @FB_RTL_ULONGINT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_ULongintToWstr ( byval number as ulongint ) as wstring
data @FB_RTL_ULONGINT2WSTR,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_FloatToStr ( byval number as single ) as string
data @FB_RTL_FLT2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE

'' fb_FloatToWstr ( byval number as single ) as wstring
data @FB_RTL_FLT2WSTR,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE

'' fb_DoubleToStr ( byval number as double ) as string
data @FB_RTL_DBL2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE

'' fb_DoubleToWstr ( byval number as double ) as wstring
data @FB_RTL_DBL2WSTR,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrToStr ( byval str as wstring ptr ) as string
data @FB_RTL_WSTR2STR,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrToWstr ( byval str as zstring ptr ) as wstring
data @FB_RTL_STR2WSTR,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_CHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrMid ( byref str as string, byval start as integer, _
''			   byval len as integer ) as string
data @FB_RTL_STRMID,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrMid ( byval str as wstring ptr, byval start as integer, _
''			    byval len as integer ) as wstring
data @FB_RTL_WSTRMID,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_StrAssignMid ( byref dst as string, byval start as integer, _
''					 byval len as integer, byref src as string ) as void
data @FB_RTL_STRASSIGNMID,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrAssignMid ( byval dst as wstring ptr, byval start as integer, _
''					  byval len as integer, byval src as wstring ptr ) as void
data @FB_RTL_WSTRASSIGNMID,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrFill1 ( byval cnt as integer, byval char as integer ) as string
data @FB_RTL_STRFILL1,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrFill1 ( byval cnt as integer, byval char as integer ) as wstring
data @FB_RTL_WSTRFILL1,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
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

'' fb_WstrFill2 ( byval cnt as integer, byval str as wstring ptr ) as wstring
data @FB_RTL_WSTRFILL2,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrLen ( byref str as any, byval strlen as integer ) as integer
data @FB_RTL_STRLEN,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrLen ( byval str as wstring ptr ) as integer
data @FB_RTL_WSTRLEN,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrLset ( byref dst as string, byref src as string ) as void
data @FB_RTL_STRLSET,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrLset ( byval dst as wstring ptr, byval src as wstring ptr ) as void
data @FB_RTL_WSTRLSET,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_ASC ( byref str as string, byval pos as integer = 0 ) as uinteger
data @FB_RTL_STRASC, "", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, 0

'' fb_WstrAsc ( byval str as wstring ptr, byval pos as integer = 0 ) as uinteger
data @FB_RTL_WSTRASC, "", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, 0

'' fb_CHR CDECL ( byval args as integer, ... ) as string
data @FB_RTL_STRCHR, "", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 INVALID,FB_ARGMODE_VARARG, FALSE

'' fb_WstrChr CDECL ( byval args as integer, ... ) as wstring
data @FB_RTL_WSTRCHR, "", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 INVALID,FB_ARGMODE_VARARG, FALSE

'' fb_StrInstr ( byval start as integer, byref srcstr as string, _
''				 byref pattern as string ) as integer
data @FB_RTL_STRINSTR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrInstr ( byval start as integer, byval srcstr as wstring ptr, _
''				  byval pattern as wstring ptr ) as integer
data @FB_RTL_WSTRINSTR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrInstrAny ( byval start as integer, byref srcstr as string, _
''					byref pattern as string ) as integer
data @FB_RTL_STRINSTRANY,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrInstrAny ( byval start as integer, byval srcstr as wstring ptr, _
''					 byval pattern as wstring ptr ) as integer
data @FB_RTL_WSTRINSTRANY,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_TRIM ( byref str as string ) as string
data @FB_RTL_STRTRIM,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrTrim ( byval str as wstring ptr ) as wstring
data @FB_RTL_WSTRTRIM,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_TrimAny ( byref str as string, byref pattern as string ) as string
data @FB_RTL_STRTRIMANY,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrTrimAny ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring
data @FB_RTL_WSTRTRIMANY,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_TrimEx ( byref str as string, byref pattern as string ) as string
data @FB_RTL_STRTRIMEX,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrTrimEx ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring
data @FB_RTL_WSTRTRIMEX,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_RTRIM ( byref str as string ) as string
data @FB_RTL_STRRTRIM,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrRTrim ( byval str as wstring ptr ) as wstring
data @FB_RTL_WSTRRTRIM,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_RTrimAny ( byref str as string, byref pattern as string ) as string
data @FB_RTL_STRRTRIMANY,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrRTrimAny ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring
data @FB_RTL_WSTRRTRIMANY,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_RTrimEx ( byref str as string, byref pattern as string ) as string
data @FB_RTL_STRRTRIMEX,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrRTrimEx ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring
data @FB_RTL_WSTRRTRIMEX,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_LTRIM ( byref str as string ) as string
data @FB_RTL_STRLTRIM,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrLTrim ( byval str as wstring ptr ) as wstring
data @FB_RTL_WSTRLTRIM,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_LTrimAny ( byref str as string, byref pattern as string ) as string
data @FB_RTL_STRLTRIMANY,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrLTrimAny ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring
data @FB_RTL_WSTRLTRIMANY,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_LTrimEx ( byref str as string, byref pattern as string ) as string
data @FB_RTL_STRLTRIMEX,"", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrLTrimEx ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring
data @FB_RTL_WSTRLTRIMEX,"", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrSwap ( byref str1 as any, byval str1len as integer, _
''				byref str2 as any, byval str2len as integer ) as void
data @FB_RTL_STRSWAP,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrSwap ( byval str1 as wstring ptr, byval str1len as integer, _
''				 byval str2 as wstring ptr, byval str2len as integer ) as void
data @FB_RTL_WSTRSWAP,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_VAL overload ( byref str as string ) as double
data @FB_RTL_STR2DBL,"fb_VAL", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrVal ( byval str as wstring ptr ) as double
data @FB_RTL_STR2DBL,"fb_WstrVal", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_VALINT overload ( byref str as string ) as integer
data @FB_RTL_STR2INT,"fb_VALINT", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrValInt ( byval str as wstring ptr ) as integer
data @FB_RTL_STR2INT,"fb_WstrValInt", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_VALUINT overload ( byref str as string ) as uinteger
data @FB_RTL_STR2UINT,"fb_VALUINT", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrValUInt ( byval str as wstring ptr ) as uinteger
data @FB_RTL_STR2UINT,"fb_WstrValUInt", _
	 FB_SYMBTYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_VALLNG overload ( byref str as string ) as longint
data @FB_RTL_STR2LNG,"fb_VALLNG", _
	 FB_SYMBTYPE_LONGINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrValLng ( byval str as wstring ptr ) as longint
data @FB_RTL_STR2LNG,"fb_WstrValLng", _
	 FB_SYMBTYPE_LONGINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_VALULNG overload ( byref str as string ) as ulongint
data @FB_RTL_STR2ULNG,"fb_VALULNG", _
	 FB_SYMBTYPE_ULONGINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrValULng ( byval str as wstring ptr ) as ulongint
data @FB_RTL_STR2ULNG,"fb_WstrValULng", _
	 FB_SYMBTYPE_ULONGINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

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

'' fb_HEXEx_i ( byval number as integer, byval digits as integer ) as string
data @"hex","fb_HEXEx_i", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_HEX_l ( byval number as longint ) as string
data @"hex","fb_HEX_l", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_HEXEx_l ( byval number as longint, byval digits as integer ) as string
data @"hex","fb_HEXEx_l", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrHex_b ( byval number as byte ) as wstring
data @"whex","fb_WstrHex_b", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrHex_s ( byval number as short ) as wstring
data @"whex","fb_WstrHex_s", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrHex_i ( byval number as integer ) as wstring
data @"whex","fb_WstrHex_i", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrHexEx_i ( byval number as integer, byval digits as integer ) as wstring
data @"whex","fb_WstrHexEx_i", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrHex_l ( byval number as longint ) as wstring
data @"whex","fb_WstrHex_l", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrHexEx_l ( byval number as longint, byval digits as integer ) as wstring
data @"whex","fb_WstrHexEx_l", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

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

'' fb_OCTEx_i ( byval number as integer, byval digits as integer ) as string
data @"oct","fb_OCTEx_i", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_OCT_l ( byval number as longint ) as string
data @"oct","fb_OCT_l", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_OCTEx_l ( byval number as longint, byval digits as integer ) as string
data @"oct","fb_OCTEx_l", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrOct_b ( byval number as byte ) as wstring
data @"woct","fb_WstrOct_b", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrOct_s ( byval number as short ) as wstring
data @"woct","fb_WstrOct_s", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrOct_i ( byval number as integer ) as wstring
data @"woct","fb_WstrOct_i", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrOctEx_i ( byval number as integer, byval digits as integer ) as wstring
data @"woct","fb_WstrOctEx_i", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrOct_l ( byval number as longint ) as wstring
data @"woct","fb_WstrOct_l", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrOctEx_l ( byval number as longint, byval digits as integer ) as wstring
data @"woct","fb_WstrOctEx_l", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

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

'' fb_BINEx_i ( byval number as integer, byval digits as integer ) as string
data @"bin","fb_BINEx_i", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_BIN_l ( byval number as longint ) as string
data @"bin","fb_BIN_l", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_BINEx_l ( byval number as longint, byval digits as integer ) as string
data @"bin","fb_BINEx_l", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrBin_b ( byval number as byte ) as wstring
data @"wbin","fb_WstrBin_b", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrBin_s ( byval number as short ) as wstring
data @"wbin","fb_WstrBin_s", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrBin_i ( byval number as integer ) as wstring
data @"wbin","fb_WstrBin_i", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrBinEx_i ( byval number as integer, byval digits as integer ) as wstring
data @"wbin","fb_WstrBinEx_i", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrBin_l ( byval number as longint ) as wstring
data @"wbin","fb_WstrBin_l", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrBinEx_l ( byval number as longint, byval digits as integer ) as wstring
data @"wbin","fb_WstrBinEx_l", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

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

'' fb_LEFT overload ( byref str as string, byval n as integer ) as string
data @"left","fb_LEFT", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrLeft ( byval str as wstring ptr, byval n as integer ) as wstring
data @"left","fb_WstrLeft", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_RIGHT overload ( byref str as string, byval n as integer ) as string
data @"right","fb_RIGHT", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrRight ( byval str as wstring ptr, byval n as integer ) as wstring
data @"right","fb_WstrRight", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_SPACE overload ( byval n as integer ) as string
data @"space","fb_SPACE", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WstrSpace ( byval n as integer ) as wstring
data @"wspace","fb_WstrSpace", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LCASE overload ( byref str as string ) as string
data @"lcase","fb_LCASE", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrLcase ( byval str as wstring ptr ) as wstring
data @"lcase","fb_WstrLcase", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_UCASE overload ( byref str as string ) as string
data @"ucase","fb_UCASE", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrUcase ( byval str as wstring ptr ) as wstring
data @"ucase","fb_WstrUcase", _
	 FB_SYMBTYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_StrRset overload ( byref dst as string, byref src as string ) as void
data @"rset","fb_StrRset", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_WstrRset ( byval dst as wstring ptr, byval src as wstring ptr ) as void
data @"rset","fb_WstrRset", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 2, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_CVD ( byref str as string ) as double
data @"cvd","fb_CVD", _
	 FB_SYMBTYPE_DOUBLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_CVS ( byref str as string ) as single
data @"cvs","fb_CVS", _
	 FB_SYMBTYPE_SINGLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_CVI ( byref str as string ) as integer
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

'' fb_CVSHORT ( byref str as string ) as short
data @"cvshort","fb_CVSHORT", _
	 FB_SYMBTYPE_SHORT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_CVLONGINT ( byref str as string ) as longint
data @"cvlongint","fb_CVLONGINT", _
	 FB_SYMBTYPE_LONGINT,FB_FUNCMODE_STDCALL, _
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
   	str1len = rtlCalcStrLen( str1, sdtype1 )

	str2len = rtlCalcStrLen( str2, sdtype2 )

    '' byref str1 as any
    if( astNewPARAM( proc, str1, sdtype1 ) = NULL ) then
    	exit function
    end if

    '' byval str1_len as integer
    if( astNewPARAM( proc, _
    				 astNewCONSTi( str1len, IR_DATATYPE_INTEGER ), _
    				 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byref str2 as any
    if( astNewPARAM( proc, str2, sdtype2 ) = NULL ) then
    	exit function
    end if

    '' byval str2_len as integer
    if( astNewPARAM( proc, _
    				 astNewCONSTi( str2len, IR_DATATYPE_INTEGER ), _
    				 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlWstrCompare( byval str1 as ASTNODE ptr, _
					     byval str2 as ASTNODE ptr _
					   ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( WSTRCOMPARE ) )

    '' byval str1 as wstring ptr
    if( astNewPARAM( proc, str1 ) = NULL ) then
    	exit function
    end if

    '' byval str2 as wstring ptr
    if( astNewPARAM( proc, str2 ) = NULL ) then
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

    '' byref dst as string
    tstr = symbAddTempVar( FB_SYMBTYPE_STRING )
    if( astNewPARAM( proc, _
    				 astNewVAR( tstr, 0, IR_DATATYPE_STRING ), _
    				 IR_DATATYPE_STRING ) = NULL ) then
    	exit function
    end if

   	'' always calc len before pushing the param
   	str1len = rtlCalcStrLen( str1, sdtype1 )

	str2len = rtlCalcStrLen( str2, sdtype2 )

    '' byref str1 as any
    if( astNewPARAM( proc, str1, sdtype1 ) = NULL ) then
    	exit function
    end if

    '' byval str1_len as integer
    if( astNewPARAM( proc, _
    				 astNewCONSTi( str1len, IR_DATATYPE_INTEGER ), _
    				 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byref str2 as any
    if( astNewPARAM( proc, str2, sdtype2 ) = NULL ) then
    	exit function
    end if

    '' byval str2_len as integer
    if( astNewPARAM( proc, _
    				 astNewCONSTi( str2len, IR_DATATYPE_INTEGER ), _
    				 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlWstrConcatWA( byval str1 as ASTNODE ptr, _
					      byval str2 as ASTNODE ptr, _
					      byval sdtype2 as integer _
					  	) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer str2len

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( WSTRCONCATWA ) )

    '' byval str1 as wstring ptr
    if( astNewPARAM( proc, str1 ) = NULL ) then
    	exit function
    end if

   	'' always calc len before pushing the param
   	str2len = rtlCalcStrLen( str2, sdtype2 )

    '' byref str2 as any
    if( astNewPARAM( proc, str2, sdtype2 ) = NULL ) then
    	exit function
    end if

    '' byval str2_len as integer
    if( astNewPARAM( proc, _
    				 astNewCONSTi( str2len, IR_DATATYPE_INTEGER ), _
    				 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlWstrConcatAW( byval str1 as ASTNODE ptr, _
					      byval sdtype1 as integer, _
					      byval str2 as ASTNODE ptr _
					  	) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer str1len

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( WSTRCONCATAW ) )

   	'' always calc len before pushing the param
   	str1len = rtlCalcStrLen( str1, sdtype1 )

    '' byref str1 as any
    if( astNewPARAM( proc, str1, sdtype1 ) = NULL ) then
    	exit function
    end if

    '' byval str1_len as integer
    if( astNewPARAM( proc, _
    				 astNewCONSTi( str1len, IR_DATATYPE_INTEGER ), _
    				 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byval str2 as wstring ptr
    if( astNewPARAM( proc, str2 ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlWstrConcat( byval str1 as ASTNODE ptr, _
					    byval sdtype1 as integer, _
					    byval str2 as ASTNODE ptr, _
					    byval sdtype2 as integer _
					  ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

	'' both not wstrings?
    if( sdtype1 <> sdtype2 ) then
    	'' left ?
    	if( sdtype1 = IR_DATATYPE_WCHAR ) then
    		return rtlWstrConcatWA( str1, str2, sdtype2 )

    	'' right..
    	else
    		return rtlWstrConcatAW( str1, sdtype1, str2 )
    	end if
    end if

    '' both wstrings..
    proc = astNewFUNCT( PROCLOOKUP( WSTRCONCAT ) )

    '' byval str1 as wstring ptr
    if( astNewPARAM( proc, str1 ) = NULL ) then
    	exit function
    end if

    '' byval str2 as wstring ptr
    if( astNewPARAM( proc, str2 ) = NULL ) then
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
	lgt = rtlCalcStrLen( dst, ddtype )

	'' dst as any
	if( astNewPARAM( proc, dst, ddtype ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

   	'' always calc len before pushing the param
   	sdtype = astGetDataType( src )
	lgt = rtlCalcStrLen( src, sdtype )

	'' src as any
	if( astNewPARAM( proc, src, sdtype ) = NULL ) then
    	exit function
    end if

    '' byval srclen as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval fillrem as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( ddtype = IR_DATATYPE_FIXSTR, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	''
	function = proc

end function

'':::::
function rtlWstrConcatAssign( byval dst as ASTNODE ptr, _
							  byval src as ASTNODE ptr _
						    ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer lgt

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( WSTRCONCATASSIGN ) )

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( dst, IR_DATATYPE_WCHAR )

	'' byval dst as wstring ptr
	if( astNewPARAM( proc, dst ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval src as wstring ptr
	if( astNewPARAM( proc, src ) = NULL ) then
    	exit function
    end if

	''
	function = proc

end function

'':::::
function rtlWstrAssignWA( byval dst as ASTNODE ptr, _
					      byval src as ASTNODE ptr, _
					      byval sdtype as integer _
					  	) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer dstlen, srclen

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( WSTRASSIGNWA ) )

   	'' always calc len before pushing the param
	dstlen = rtlCalcStrLen( dst, IR_DATATYPE_WCHAR )
	srclen = rtlCalcStrLen( src, sdtype )

    '' byval dst as wstring ptr
    if( astNewPARAM( proc, dst ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( dstlen, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byref src as any
    if( astNewPARAM( proc, src ) = NULL ) then
    	exit function
    end if

	'' byval srclen as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( srclen, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlWstrAssignAW( byval dst as ASTNODE ptr, _
					      byval ddtype as integer, _
					      byval src as ASTNODE ptr _
					  	) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer lgt

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( WSTRASSIGNAW ) )

   	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( dst, ddtype )

    '' byref dst as any
    if( astNewPARAM( proc, dst ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byval src as wstring ptr
    if( astNewPARAM( proc, src ) = NULL ) then
    	exit function
    end if

	'' byval fillrem as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( ddtype = IR_DATATYPE_FIXSTR, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrAssign( byval dst as ASTNODE ptr, _
					   byval src as ASTNODE ptr _
					 ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer lgt, ddtype, sdtype

	function = NULL

    ddtype = astGetDataType( dst )
    sdtype = astGetDataType( src )

	'' wstring source?
    if( sdtype = IR_DATATYPE_WCHAR ) then
    	return rtlWstrAssignAW( dst, ddtype, src )

    '' destine?
    elseif( ddtype = IR_DATATYPE_WCHAR ) then
    	return rtlWstrAssignWA( dst, src, sdtype )
    end if

    '' both strings
    proc = astNewFUNCT( PROCLOOKUP( STRASSIGN ) )

	'' always calc len before pushing the param

	lgt = rtlCalcStrLen( dst, ddtype )

	'' dst as any
	if( astNewPARAM( proc, dst, ddtype ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

   	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( src, sdtype )

	'' src as any
	if( astNewPARAM( proc, src, sdtype ) = NULL ) then
    	exit function
    end if

	'' byval srclen as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval fillrem as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( ddtype = IR_DATATYPE_FIXSTR, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	''
	function = proc

end function

'':::::
function rtlWstrAssign( byval dst as ASTNODE ptr, _
					    byval src as ASTNODE ptr _
					  ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as integer lgt, ddtype, sdtype

	function = NULL

	ddtype = astGetDataType( dst )
	sdtype = astGetDataType( src )

	'' both not wstrings?
    if( ddtype <> sdtype ) then
    	'' left ?
    	if( ddtype = IR_DATATYPE_WCHAR ) then
    		return rtlWstrAssignWA( dst, src, sdtype )

    	'' right..
    	else
    		return rtlWstrAssignAW( dst, ddtype, src )
    	end if
    end if

    '' both wstrings..
    proc = astNewFUNCT( PROCLOOKUP( WSTRASSIGN ) )

   	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( dst, ddtype )

    '' byval dst as wstring ptr
    if( astNewPARAM( proc, dst ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byval src as wstring ptr
    if( astNewPARAM( proc, src ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrDelete( byval strg as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as integer dtype

	function = NULL

	''
    dtype = astGetDataType( strg )
    select case dtype
    '' it could be a wstring ptr too due the temporary
    '' wstrings that must be handled by AST
    case IR_DATATYPE_WCHAR, _
    	 IR_DATATYPE_POINTER+IR_DATATYPE_WCHAR
    	proc = astNewFUNCT( PROCLOOKUP( WSTRDELETE ) )
    case else
    	proc = astNewFUNCT( PROCLOOKUP( STRDELETE ) )
    	dtype = IR_DATATYPE_STRING
    end select

    '' str as ANY
    if( astNewPARAM( proc, strg, dtype ) = NULL ) then
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
function rtlStrAllocTmpDesc	( byval strexpr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as integer lgt, dtype
    dim as FBSYMBOL ptr litsym

    function = NULL

	''
   	dtype = astGetDataType( strexpr )

	select case dtype
	case IR_DATATYPE_STRING
    	proc = astNewFUNCT( PROCLOOKUP( STRALLOCTMPDESCV ) )

    	'' str as string
    	if( astNewPARAM( proc, strexpr ) = NULL ) then
    		exit function
    	end if

	case IR_DATATYPE_CHAR

    	'' literal?
    	litsym = astGetStrLitSymbol( strexpr )
    	if( litsym = NULL ) then
    		proc = astNewFUNCT( PROCLOOKUP( STRALLOCTMPDESCZ ) )
    	else
    		proc = astNewFUNCT( PROCLOOKUP( STRALLOCTMPDESCZEX ) )
    	end if

    	'' byval str as zstring ptr
    	if( astNewPARAM( proc, strexpr ) = NULL ) then
    		exit function
    	end if

    	'' length is known at compile-time
    	if( litsym <> NULL ) then
    		lgt = symbGetStrLen( litsym ) - 1	'' less the null-term

            '' byval len as integer
    		if( astNewPARAM( proc, _
    						 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
    						 IR_DATATYPE_INTEGER ) = NULL ) then
    			exit function
    		end if
    	end if

	case IR_DATATYPE_FIXSTR
    	proc = astNewFUNCT( PROCLOOKUP( STRALLOCTMPDESCF ) )

    	'' always calc len before pushing the param
		lgt = rtlCalcStrLen( strexpr, dtype )

    	'' str as any
    	if( astNewPARAM( proc, strexpr ) = NULL ) then
    		exit function
    	end if

		'' byval strlen as integer
		if( astNewPARAM( proc, _
						 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
						 IR_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

    end select

	''
	function = proc

end function

'':::::
function rtlWstrAlloc( byval lenexpr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as integer dtype

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( WSTRALLOC ) )

    '' byval len as integer
    if( astNewPARAM( proc, lenexpr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlWstrToA( byval expr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc

    function = NULL

    proc = astNewFUNCT( PROCLOOKUP( WSTR2STR ) )

    '' byval str as wstring ptr
    if( astNewPARAM( proc, expr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlAToWstr( byval expr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc

    function = NULL

    proc = astNewFUNCT( PROCLOOKUP( STR2WSTR ) )

    '' byval str as zstring ptr
    if( astNewPARAM( proc, expr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlToStr( byval expr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f, litsym

    function = NULL

    '' constant? evaluate
    if( astIsCONST( expr ) ) then
    	return astNewCONSTstr( astGetValueAsStr( expr ) )
    end if

    '' wstring literal? convert from unicode at compile-time
    if( astGetDataType( expr ) = IR_DATATYPE_WCHAR ) then
    	litsym = astGetStrLitSymbol( expr )
    	if( litsym <> NULL ) then
			if( env.target.wchar.doconv ) then
				litsym = symbAllocStrConst( str( *symbGetVarTextW( litsym ) ), _
							   	   	   		symbGetWstrLen( litsym ) - 1 )

				return astNewVAR( litsym, 0, IR_DATATYPE_CHAR )
    		end if
    	end if
    end if

    ''
	select case astGetDataClass( expr )
	case IR_DATACLASS_INTEGER

		select case as const astGetDataType( expr )
		case IR_DATATYPE_LONGINT
			f = PROCLOOKUP( LONGINT2STR )
		case IR_DATATYPE_ULONGINT
			f = PROCLOOKUP( ULONGINT2STR )
		case IR_DATATYPE_BYTE, IR_DATATYPE_SHORT, IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			f = PROCLOOKUP( INT2STR )
		case IR_DATATYPE_UBYTE, IR_DATATYPE_USHORT, IR_DATATYPE_UINT
			f = PROCLOOKUP( UINT2STR )
		'' zstring? do nothing
		case IR_DATATYPE_CHAR
			return expr
		'' wstring? convert..
		case IR_DATATYPE_WCHAR
			return rtlWStrToA( expr )
		'' pointer..
		case else
			f = PROCLOOKUP( UINT2STR )
			expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
		end select

	case IR_DATACLASS_FPOINT
		if( astGetDataType( expr ) = IR_DATATYPE_SINGLE ) then
			f = PROCLOOKUP( FLT2STR )
		else
			f = PROCLOOKUP( DBL2STR )
		end if

	case IR_DATACLASS_STRING
		'' do nothing
		return expr

	'' anything else (UDT's, classes): can't convert
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
function rtlToWstr( byval expr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f, litsym

    function = NULL

    '' constant? evaluate
    if( astIsCONST( expr ) ) then
    	return astNewCONSTwstr( astGetValueAsWstr( expr ) )
    end if

    '' string literal? convert to unicode at compile-time
    if( astGetDataType( expr ) = IR_DATATYPE_CHAR ) then
    	litsym = astGetStrLitSymbol( expr )
    	if( litsym <> NULL ) then
			if( env.target.wchar.doconv ) then
				litsym = symbAllocWstrConst( wstr( *symbGetVarText( litsym ) ), _
							 			     symbGetStrLen( litsym ) - 1 )
    			return astNewVAR( litsym, 0, IR_DATATYPE_WCHAR )
    		end if
    	end if
    end if

    ''
	select case astGetDataClass( expr )
	case IR_DATACLASS_INTEGER

		select case as const astGetDataType( expr )
		case IR_DATATYPE_LONGINT
			f = PROCLOOKUP( LONGINT2WSTR )
		case IR_DATATYPE_ULONGINT
			f = PROCLOOKUP( ULONGINT2WSTR )
		case IR_DATATYPE_BYTE, IR_DATATYPE_SHORT, IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			f = PROCLOOKUP( INT2WSTR )
		case IR_DATATYPE_UBYTE, IR_DATATYPE_USHORT, IR_DATATYPE_UINT
			f = PROCLOOKUP( UINT2WSTR )
		'' wstring? do nothing
		case IR_DATATYPE_WCHAR
			return expr
		'' zstring? convert..
		case IR_DATATYPE_CHAR
			return rtlAToWstr( expr )
		'' pointer..
		case else
			f = PROCLOOKUP( UINT2WSTR )
			expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
		end select

	case IR_DATACLASS_FPOINT
		if( astGetDataType( expr ) = IR_DATATYPE_SINGLE ) then
			f = PROCLOOKUP( FLT2WSTR )
		else
			f = PROCLOOKUP( DBL2WSTR )
		end if

	case IR_DATACLASS_STRING
		'' convert
		return rtlAToWstr( expr )

	'' anything else (UDT's, classes): can't convert
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
function rtlStrToVal( byval expr as ASTNODE ptr, _
					  byval to_dtype as integer _
					) as ASTNODE ptr static

    dim as ASTNODE ptr proc, exprTB(0)
    dim as integer modeTB(0)
    dim as FBSYMBOL ptr f, s

    function = NULL

    ''
	select case as const to_dtype
	case IR_DATATYPE_BYTE, IR_DATATYPE_SHORT, IR_DATATYPE_INTEGER
		f = PROCLOOKUP( STR2INT )

	case IR_DATATYPE_UBYTE, IR_DATATYPE_USHORT, IR_DATATYPE_UINT
		f = PROCLOOKUP( STR2UINT )

	case IR_DATATYPE_LONGINT
		f = PROCLOOKUP( STR2LNG )

	case IR_DATATYPE_ULONGINT
		f = PROCLOOKUP( STR2ULNG )

	case else
		f = PROCLOOKUP( STR2DBL )
	end select

	''
	exprTB(0) = expr
	modeTB(0) = INVALID
	f = symbFindClosestOvlProc( f, 1, exprTB(), modeTB() )

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
    if( astGetDataType( expr1 ) <> IR_DATATYPE_WCHAR ) then
    	proc = astNewFUNCT( PROCLOOKUP( STRMID ) )
    else
    	proc = astNewFUNCT( PROCLOOKUP( WSTRMID ) )
    end if

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
    if( astGetDataType( expr1 ) <> IR_DATATYPE_WCHAR ) then
    	proc = astNewFUNCT( PROCLOOKUP( STRASSIGNMID ) )
    else
    	proc = astNewFUNCT( PROCLOOKUP( WSTRASSIGNMID ) )
    end if

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
    if( astGetDataType( dstexpr ) <> IR_DATATYPE_WCHAR ) then
    	proc = astNewFUNCT( PROCLOOKUP( STRLSET ) )
    else
    	proc = astNewFUNCT( PROCLOOKUP( WSTRLSET ) )
    end if

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

	select case astGetDataType( expr2 )
	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR
		f = PROCLOOKUP( STRFILL2 )
	case else
		f = PROCLOOKUP( STRFILL1 )
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
function rtlWstrFill( byval expr1 as ASTNODE ptr, _
					  byval expr2 as ASTNODE ptr _
				     ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

    function = NULL

	if( astGetDataType( expr2 ) = IR_DATATYPE_WCHAR ) then
		f = PROCLOOKUP( WSTRFILL2 )
	else
		f = PROCLOOKUP( WSTRFILL1 )
	end if

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

    ''
    if( astGetDataType( expr ) <> IR_DATATYPE_WCHAR ) then
    	proc = astNewFUNCT( PROCLOOKUP( STRASC ) )
    else
    	proc = astNewFUNCT( PROCLOOKUP( WSTRASC ) )
    end if

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
					exprtb() as ASTNODE ptr, _
					byval is_wstr as integer _
				  ) as ASTNODE ptr static

	dim as ASTNODE ptr proc, expr
	dim as integer i

	function = NULL

    if( not is_wstr ) then
    	proc = astNewFUNCT( PROCLOOKUP( STRCHR ) )
    else
    	proc = astNewFUNCT( PROCLOOKUP( WSTRCHR ) )
    end if

    '' byval args as integer
    if( astNewPARAM( proc, astNewCONSTi( args, IR_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    '' ...
    for i = 0 to args-1
    	expr = exprtb(i)

    	'' check if non-numeric
    	if( astGetDataClass( expr ) >= IR_DATACLASS_STRING ) then
    		hReportErrorEx( FB_ERRMSG_PARAMTYPEMISMATCHAT, "at parameter: " + str( i+1 ) )
    		exit function
    	end if

    	'' don't allow w|zstring's either..
    	select case astGetDataType( expr )
    	case IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR
    		hReportErrorEx( FB_ERRMSG_PARAMTYPEMISMATCHAT, "at parameter: " + str( i+1 ) )
    		exit function

    	case IR_DATATYPE_INTEGER

    	'' convert to int as chr() is a varargs function
    	case else
    		expr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, expr )
    	end select

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
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRINSTRANY )
		else
			f = PROCLOOKUP( WSTRINSTRANY )
		end if
    else
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRINSTR )
		else
			f = PROCLOOKUP( WSTRINSTR )
		end if
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
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRTRIMANY )
		else
			f = PROCLOOKUP( WSTRTRIMANY )
		end if
    elseif( nd_pattern <> NULL ) then
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRTRIMEX )
		else
			f = PROCLOOKUP( WSTRTRIMEX )
		end if
    else
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRTRIM )
		else
			f = PROCLOOKUP( WSTRTRIM )
		end if
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
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRRTRIMANY )
		else
			f = PROCLOOKUP( WSTRRTRIMANY )
		end if
    elseif( nd_pattern <> NULL ) then
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRRTRIMEX )
		else
			f = PROCLOOKUP( WSTRRTRIMEX )
		end if
    else
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRRTRIM )
		else
			f = PROCLOOKUP( WSTRRTRIM )
		end if
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
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRLTRIMANY )
		else
			f = PROCLOOKUP( WSTRLTRIMANY )
		end if
    elseif( nd_pattern <> NULL ) then
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRLTRIMEX )
		else
			f = PROCLOOKUP( WSTRLTRIMEX )
		end if
    else
		if( astGetDataType( nd_text ) <> IR_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRLTRIM )
		else
			f = PROCLOOKUP( WSTRLTRIM )
		end if
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
					 byval str2 as ASTNODE ptr _
				   ) as integer static

    dim as ASTNODE ptr proc
    dim as integer lgt, dtype

	function = FALSE

	''
    proc = astNewFUNCT( PROCLOOKUP( STRSWAP ) )

	'' always calc len before pushing the param
	dtype = astGetDataType( str1 )
	lgt = rtlCalcStrLen( str1, dtype )

    '' str1 as any
    if( astNewPARAM( proc, str1, IR_DATATYPE_STRING ) = NULL ) then
    	exit function
    end if

    '' byval str1len as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' always calc len before pushing the param
	dtype = astGetDataType( str2 )
	lgt = rtlCalcStrLen( str2, dtype )

    '' str2 as any
    if( astNewPARAM( proc, str2, IR_DATATYPE_STRING ) = NULL ) then
    	exit function
    end if

    '' byval str2len as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlWstrSwap( byval str1 as ASTNODE ptr, _
					  byval str2 as ASTNODE ptr _
					) as integer static

    dim as ASTNODE ptr proc
    dim as integer lgt

	function = FALSE

	''
    proc = astNewFUNCT( PROCLOOKUP( WSTRSWAP ) )

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( str1, astGetDataType( str1 ) )

    '' byval str1 as wstring ptr
    if( astNewPARAM( proc, str1 ) = NULL ) then
    	exit function
    end if

    '' byval str1len as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( str2, astGetDataType( str2 ) )

    '' byval str2 as wstring ptr
    if( astNewPARAM( proc, str2 ) = NULL ) then
    	exit function
    end if

    '' byval str2len as integer
	if( astNewPARAM( proc, _
					 astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), _
					 IR_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

