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


'' runtime-lib helpers, for when simple calls can't be done, 'cause args of diff types, etc
''
'' chng: oct/2004 written [v1ctor]

defint a-z
option explicit
option escape

'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\rtl.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\emit.bi'

#define AUTOADDGFXLIBS

type RTLCTX
	datainited		as integer
	lastlabel		as FBSYMBOL ptr
    labelcnt 		as integer
end type

declare function	rtlCheckError		( byval resexpr as integer, byval reslabel as FBSYMBOL ptr ) as integer


''globals
	dim shared ctx as RTLCTX

	redim shared ifuncTB( 0 ) as FBSYMBOL ptr


'':::::::::::::::::::::::::::::::::::::::::::::::::::
'' FUNCTIONS
'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' name,alias,typ,mode, args, [arg typ,mode,optional[,value]]*args (same order as FB.IFUNC)
ifuncdata:

'' fb_StrConcat ( dst as string, _
''				  str1 as any, byval str1len as integer, _
''				  str2 as any, byval str2len as integer ) as string
data "fb_StrConcat","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 5, _
						FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_StrCompare ( str1 as any, byval str1len as integer, _
''				   str2 as any, byval str2len as integer ) as integer
'' returns: 0= equal; -1=str1 < str2; 1=str1 > str2
data "fb_StrCompare","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 4, _
						 FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_StrAssign ( dst as any, byval dst_len as integer, _
'' 				  src as any, byval src_len as integer ) as void
data "fb_StrAssign","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 4, _
						FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_StrConcatAssign ( dst as any, byval dst_len as integer, _
'' 				        src as any, byval src_len as integer ) as void
data "fb_StrConcatAssign","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 4, _
						      FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						      FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_StrDelete ( str as string ) as void
data "fb_StrDelete","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_StrAllocTempResult ( str as string ) as string
data "fb_StrAllocTempResult","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
						FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_StrAllocTempDesc ( str as any, byval strlen as integer ) as string
data "fb_StrAllocTempDesc","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 2, _
						FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_LongintDIV ( byval x as longint, byval y as longint ) as longint
data "__divdi3","", FB.SYMBTYPE.LONGINT,FB.FUNCMODE.CDECL, 2, _
					FB.SYMBTYPE.LONGINT,FB.ARGMODE.BYVAL, FALSE, _
					FB.SYMBTYPE.LONGINT,FB.ARGMODE.BYVAL, FALSE
'' fb_ULongintDIV ( byval x as ulongint, byval y as ulongint ) as ulongint
data "__udivdi3","", FB.SYMBTYPE.ULONGINT,FB.FUNCMODE.CDECL, 2, _
					 FB.SYMBTYPE.ULONGINT,FB.ARGMODE.BYVAL, FALSE, _
					 FB.SYMBTYPE.ULONGINT,FB.ARGMODE.BYVAL, FALSE
'' fb_LongintMOD ( byval x as longint, byval y as longint ) as longint
data "__moddi3","", FB.SYMBTYPE.LONGINT,FB.FUNCMODE.CDECL, 2, _
					FB.SYMBTYPE.LONGINT,FB.ARGMODE.BYVAL, FALSE, _
					FB.SYMBTYPE.LONGINT,FB.ARGMODE.BYVAL, FALSE
'' fb_ULongintMOD ( byval x as ulongint, byval y as ulongint ) as ulongint
data "__umoddi3","", FB.SYMBTYPE.ULONGINT,FB.FUNCMODE.CDECL, 2, _
					 FB.SYMBTYPE.ULONGINT,FB.ARGMODE.BYVAL, FALSE, _
					 FB.SYMBTYPE.ULONGINT,FB.ARGMODE.BYVAL, FALSE


'' fb_ArrayRedim CDECL ( array() as ANY, byval elementlen as integer, _
''					     byval isvarlen as integer, byval preserve as integer, _
''						 byval dimensions as integer, ... ) as integer
data "fb_ArrayRedim","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.CDECL, 6, _
						 FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						             INVALID,FB.ARGMODE.VARARG, FALSE
'' fb_ArrayErase ( array() as ANY, byval isvarlen as integer ) as integer
data "fb_ArrayErase","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
						 FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_ArrayClear ( array() as ANY, byval isvarlen as integer ) as integer
data "fb_ArrayClear","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
						 FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_ArrayLBound ( array() as ANY, byval dimension as integer ) as integer
data "fb_ArrayLBound","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
						  FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_ArrayUBound ( array() as ANY, byval dimension as integer ) as integer
data "fb_ArrayUBound","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
						  FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_ArraySetDesc CDECL ( array() as ANY, arraydata as any, byval elementlen as integer, _
''						   byval dimensions as integer, ... ) as void
data "fb_ArraySetDesc","", FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 5, _
						   FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE, _
						   FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						               INVALID,FB.ARGMODE.VARARG, FALSE
'' fb_ArrayStrErase ( array() as any ) as void
data "fb_ArrayStrErase","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
							FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE
'' fb_ArrayAllocTempDesc CDECL ( byref pdesc as any ptr, arraydata as any, byval elementlen as integer, _
''						         byval dimensions as integer, ... ) as void ptr
data "fb_ArrayAllocTempDesc","", FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 5, _
					 	         FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						         FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						         FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						         FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						                     INVALID,FB.ARGMODE.VARARG, FALSE
'' fb_ArrayFreeTempDesc ( byval pdesc as any ptr) as void
data "fb_ArrayFreeTempDesc","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						        FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE

''
'' fb_IntToStr ( byval number as integer ) as string
data "fb_IntToStr","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_UIntToStr ( byval number as uinteger ) as string
data "fb_UIntToStr","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					    FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE
'' fb_LongintToStr ( byval number as longint ) as string
data "fb_LongintToStr","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					       FB.SYMBTYPE.LONGINT,FB.ARGMODE.BYVAL, FALSE
'' fb_ULongintToStr ( byval number as ulongint ) as string
data "fb_ULongintToStr","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					        FB.SYMBTYPE.ULONGINT,FB.ARGMODE.BYVAL, FALSE
'' fb_FloatToStr ( byval number as single ) as string
data "fb_FloatToStr","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
						 FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE
'' fb_DoubleToStr ( byval number as double ) as string
data "fb_DoubleToStr","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
						  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE

'' fb_StrInstr ( byval start as integer, srcstr as string, pattern as string ) as integer
data "fb_StrInstr","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_StrMid ( str as string, byval start as integer, byval len as integer ) as string
data "fb_StrMid","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 3, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_StrAssignMid ( dst as string, byval start as integer, byval len as integer, src as string ) as void
data "fb_StrAssignMid","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 4, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_StrFill1 ( byval cnt as integer, byval char as integer ) as string
data "fb_StrFill1","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 2, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_StrFill2 ( byval cnt as integer, str as string ) as string
data "fb_StrFill2","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 2, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_StrLen ( str as any, byval strlen as integer ) as integer
data "fb_StrLen","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
					 FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_ASC ( str as string, byval pos as integer = 0 ) as uinteger
data "fb_ASC", "", FB.SYMBTYPE.UINT,FB.FUNCMODE.STDCALL, 2, _
				   FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
				   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE, 0
'' fb_CHR CDECL ( byval args as integer, ... ) as string
data "fb_CHR", "", FB.SYMBTYPE.STRING,FB.FUNCMODE.CDECL, 2, _
				   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
				               INVALID,FB.ARGMODE.VARARG, FALSE

''
'' fb_END ( byval errlevel as integer ) as void
data "fb_End","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
				  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

''
'' fb_DataRestore ( byval labeladdrs as void ptr ) as void
data "fb_DataRestore","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						  FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE
'' fb_DataReadStr ( dst as any, byval dst_size as integer ) as void
data "fb_DataReadStr","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_DataReadByte ( dst as byte ) as void
data "fb_DataReadByte","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						   FB.SYMBTYPE.BYTE,FB.ARGMODE.BYREF, FALSE
'' fb_DataReadShort ( dst as short ) as void
data "fb_DataReadShort","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
							FB.SYMBTYPE.SHORT,FB.ARGMODE.BYREF, FALSE
'' fb_DataReadInt ( dst as integer ) as void
data "fb_DataReadInt","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYREF, FALSE
'' fb_DataReadLongint ( dst as longint ) as void
data "fb_DataReadLongint","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						      FB.SYMBTYPE.LONGINT,FB.ARGMODE.BYREF, FALSE
'' fb_DataReadUByte ( dst as ubyte ) as void
data "fb_DataReadUByte","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						    FB.SYMBTYPE.UBYTE,FB.ARGMODE.BYREF, FALSE
'' fb_DataReadUShort ( dst as ushort ) as void
data "fb_DataReadUShort","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
							 FB.SYMBTYPE.USHORT,FB.ARGMODE.BYREF, FALSE
'' fb_DataReadUInt ( dst as uinteger ) as void
data "fb_DataReadUInt","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						   FB.SYMBTYPE.UINT,FB.ARGMODE.BYREF, FALSE
'' fb_DataReadULongint ( dst as ulongint ) as void
data "fb_DataReadULongint","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						       FB.SYMBTYPE.ULONGINT,FB.ARGMODE.BYREF, FALSE
'' fb_DataReadSingle ( dst as single ) as void
data "fb_DataReadSingle","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						     FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYREF, FALSE
'' fb_DataReadDouble ( dst as single ) as void
data "fb_DataReadDouble","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						     FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYREF, FALSE

''
'' fb_Pow CDECL ( byval x as double, byval y as double ) as double
data "fb_Pow","pow", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 2, _
					 FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE, _
					 FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' fb_SGNSingle ( byval x as single ) as integer
data "fb_SGNSingle","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE
'' fb_SGNDouble ( byval x as double ) as integer
data "fb_SGNDouble","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' fb_FIXSingle ( byval x as single ) as single
data "fb_FIXSingle","", FB.SYMBTYPE.SINGLE,FB.FUNCMODE.STDCALL, 1, _
						FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE
'' fb_FIXDouble ( byval x as double ) as double
data "fb_FIXDouble","", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.STDCALL, 1, _
						FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE

''
'' fb_PrintVoid ( byval filenum as integer = 0, byval mask as integer ) as void
data "fb_PrintVoid","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void
data "fb_PrintByte","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						FB.SYMBTYPE.BYTE,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void
data "fb_PrintUByte","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.UBYTE,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void
data "fb_PrintShort","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.SHORT,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void
data "fb_PrintUShort","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.USHORT,FB.ARGMODE.BYVAL, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void
data "fb_PrintInt","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void
data "fb_PrintUInt","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void
data "fb_PrintLongint","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
					      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
					      FB.SYMBTYPE.LONGINT,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void
data "fb_PrintULongint","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						    FB.SYMBTYPE.ULONGINT,FB.ARGMODE.BYVAL, FALSE, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void
data "fb_PrintSingle","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void
data "fb_PrintDouble","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void
data "fb_PrintString","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' spc ( byval filenum as integer = 0, byval n as integer ) as void
data "fb_PrintSPC","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' tab ( byval filenum as integer = 0, byval newcol as integer ) as void
data "fb_PrintTab","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

''
'' fb_WriteVoid ( byval filenum as integer = 0, byval mask as integer ) as void
data "fb_WriteVoid","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void
data "fb_WriteByte","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						FB.SYMBTYPE.BYTE,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void
data "fb_WriteUByte","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.UBYTE,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void
data "fb_WriteShort","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.SHORT,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void
data "fb_WriteUShort","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.USHORT,FB.ARGMODE.BYVAL, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void
data "fb_WriteInt","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void
data "fb_WriteUInt","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void
data "fb_WriteLongint","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
					       FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
					       FB.SYMBTYPE.LONGINT,FB.ARGMODE.BYVAL, FALSE, _
					       FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void
data "fb_WriteULongint","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						    FB.SYMBTYPE.ULONGINT,FB.ARGMODE.BYVAL, FALSE, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void
data "fb_WriteSingle","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void
data "fb_WriteDouble","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_WriteString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void
data "fb_WriteString","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_PrintUsingInit ( fmtstr as string ) as integer
data "fb_PrintUsingInit","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						     FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_PrintUsingStr ( byval filenum as integer, s as string, byval mask as integer ) as integer
data "fb_PrintUsingStr","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						    FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintUsingVal ( byval filenum as integer, byval v as double, byval mask as integer ) as integer
data "fb_PrintUsingVal","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						    FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_PrintUsingEnd ( byval filenum as integer ) as integer
data "fb_PrintUsingEnd","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE


'' fb_ConsoleView ( byval toprow as integer = 0, byval botrow as integer = 0 ) as void
data "fb_ConsoleView","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0
'' fb_ConsoleReadXY ( byval y as integer, byval x as integer, byval colorflag as integer ) as integer
data "fb_ConsoleReadXY","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0


''
'' fb_MemCopy cdecl ( dst as any, src as any, byval bytes as integer ) as void
data "fb_MemCopy","memcpy", FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 3, _
							FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
							FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_MemSwap ( dst as any, src as any, byval bytes as integer ) as void
data "fb_MemSwap","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_StrSwap ( str1 as any, byval str1len as integer, str2 as any, byval str2len as integer ) as void
data "fb_StrSwap","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 4, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

''
'' fb_FileOpen( s as string, byval mode as integer, byval access as integer,
''		        byval lock as integer, byval filenum as integer, byval len as integer ) as integer
data "fb_FileOpen","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 6, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_FileClose	( byval filenum as integer ) as integer
data "fb_FileClose","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_FilePut ( byval filenum as integer, byval offset as uinteger, value as any, byval valuelen as integer ) as integer
data "fb_FilePut","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 4, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_FilePutStr ( byval filenum as integer, byval offset as uinteger, s as string ) as integer
data "fb_FilePutStr","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_FilePutArray ( byval filenum as integer, byval offset as uinteger, array() as any ) as integer
data "fb_FilePutArray","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						   FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE
'' fb_FileGet ( byval filenum as integer, byval offset as uinteger, value as any, byval valuelen as integer ) as integer
data "fb_FileGet","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 4, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_FileGetStr ( byval filenum as integer, byval offset as uinteger, s as string ) as integer
data "fb_FileGetStr","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_FileGetArray ( byval filenum as integer, byval offset as uinteger, array() as any ) as integer
data "fb_FileGetArray","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						   FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE

'' fb_FileTell ( byval filenum as integer ) as uinteger
data "fb_FileTell","", FB.SYMBTYPE.UINT,FB.FUNCMODE.STDCALL, 1, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_FileSeek ( byval filenum as integer, byval newpos as uinteger ) as integer
data "fb_FileSeek","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE

'' fb_FileStrInput ( byval bytes as integer, byval filenum as integer = 0 ) as string
data "fb_FileStrInput", "", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 2, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0

'' fb_FileLineInput ( byval filenum as integer, dst as any, byval dstlen as integer ) as integer
data "fb_FileLineInput", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						     FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						     FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						     FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_LineInput ( text as string, dst as any, byval dstlen as integer, _
''				  byval addquestion as integer, byval addnewline as integer ) as integer
data "fb_LineInput", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 5, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						 FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_FileInput ( byval filenum as integer ) as integer
data "fb_FileInput", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_ConsoleInput ( text as string,  byval addquestion as integer, _
''				     byval addnewline as integer ) as integer
data "fb_ConsoleInput", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						    FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_InputByte ( x as byte ) as void
data "fb_InputByte","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						FB.SYMBTYPE.BYTE,FB.ARGMODE.BYREF, FALSE
'' fb_InputShort ( x as short ) as void
data "fb_InputShort","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						 FB.SYMBTYPE.SHORT,FB.ARGMODE.BYREF, FALSE
'' fb_InputInt ( x as integer ) as void
data "fb_InputInt","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYREF, FALSE
'' fb_InputLongint ( x as longint ) as void
data "fb_InputLongint","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
					       FB.SYMBTYPE.LONGINT,FB.ARGMODE.BYREF, FALSE
'' fb_InputSingle ( x as single ) as void
data "fb_InputSingle","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYREF, FALSE
'' fb_InputDouble ( x as double ) as void
data "fb_InputDouble","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYREF, FALSE
'' fb_InputString ( x as any, byval strlen as integer ) as void
data "fb_InputString","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
						  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_FileLock ( byval inipos as integer, byval endpos as integer ) as integer
data "fb_FileLock","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0
'' fb_FileUnlock ( byval inipos as integer, byval endpos as integer ) as integer
data "fb_FileUnlock","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0


''
'' fb_ErrorThrow cdecl ( byval reslabel as any ptr, byval resnxtlabel as any ptr ) as any ptr
data "fb_ErrorThrow","", FB.SYMBTYPE.UINT,FB.FUNCMODE.CDECL, 2, _
						 FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE
''
'' fb_ErrorThrowEx cdecl ( byval errnum as integer, byval reslabel as any ptr, _
''                        byval resnxtlabel as any ptr ) as any ptr
data "fb_ErrorThrowEx","", FB.SYMBTYPE.UINT,FB.FUNCMODE.CDECL, 3, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						   FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE, _
						   FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE
'' fb_ErrorSetHandler( byval newhandler as any ptr ) as any ptr
data "fb_ErrorSetHandler","", FB.SYMBTYPE.UINT,FB.FUNCMODE.STDCALL, 1, _
							  FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE

'' fb_ErrorGetNum( ) as integer
data "fb_ErrorGetNum", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 0
'' fb_ErrorSetNum( byval errnum as integer ) as void
data "fb_ErrorSetNum", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_ErrorResume( ) as any ptr
data "fb_ErrorResume", "", FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 0
'' fb_ErrorResumeNext( ) as any ptr
data "fb_ErrorResumeNext", "", FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 0

''
'' fb_GfxPset ( byref target as any, byval x as single, byval y as single, byval color as uinteger, byval coordType as integer)
data "fb_GfxPset", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 5, _
					   FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxPoint ( byref target as any, byval x as single, byval y as single ) as integer
data "fb_GfxPoint", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxLine ( byref target as any, byval x1 as single = 0, byval y1 as single = 0, byval x2 as single = 0, byval y2 as single = 0, _
''              byval color as uinteger = DEFAULT_COLOR, byval line_type as integer = LINE_TYPE_LINE, _
''              byval style as uinteger = &hFFFF, byval coordType as integer = COORD_TYPE_AA ) as integer
data "fb_GfxLine", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 9, _
					   FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxEllipse ( byref target as any, byval x as single, byval y as single, byval radius as single, _
''				   byval color as uinteger = DEFAULT_COLOR, byval aspect as single = 0.0, _
''				   byval iniarc as single = 0.0, byval endarc as single = 6.283185, _
''				   byval FillFlag as integer = 0, byval CoordType as integer = COORD_TYPE_A ) as integer
data "fb_GfxEllipse", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 10, _
						  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxPaint ( byref target as any, byval x as single, byval y as single, byval color as uinteger = DEFAULT_COLOR, _
''				 byval border_color as uinteger = DEFAULT_COLOR, pattern as string, _
''				 byval mode as integer = PAINT_TYPE_FILL, byval coord_type as integer = COORD_TYPE_A ) as integer
data "fb_GfxPaint", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 8, _
						FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxDraw ( byval target as any, cmd as string )
data "fb_GfxDraw", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
					   FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' fb_GfxView ( byval x1 as integer = -32768, byval y1 as integer = -32768, _
''              byval x1 as integer = -32768, byval y1 as integer = -32768, _
''				byval fillcol as uinteger = DEFAULT_COLOR, byval bordercol as uinteger = DEFAULT_COLOR, _
''              byval screenFlag as integer = 0) as integer
data "fb_GfxView", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 7, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxWindow (byval x1 as single = 0, byval y1 as single = 0, byval x2 as single = 0, _
'' 				 byval y2 as single = 0, byval screenflag as integer = 0 ) as integer
data "fb_GfxWindow", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 5, _
						 FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0

'' fb_GfxPalette( byval attribute as integer = -1, byval r as integer = -1, _
''				  byval g as integer = -1, byval b as integer = -1 ) as void
data "fb_GfxPalette", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 4, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1

'' fb_GfxPaletteUsing ( array as integer ) as void
data "fb_GfxPaletteUsing", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						       FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYREF, FALSE

'' fb_GfxPut ( byref target as any, byval x as single, byval y as single, byref array as any, _
''			   byval coordType as integer, byval mode as integer )  as void
data "fb_GfxPut", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 6, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxGet ( byref target as any, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, _
''			   byref array as any, byval coordType as integer, array() as any ) as integer
data "fb_GfxGet", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 8, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE

'' fb_GfxScreen ( byval w as integer, byval h as integer = 0, byval depth as integer = 0, _
''                byval fullscreenFlag as integer = 0 ) as integer
data "fb_GfxScreen", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 4, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0

'' fb_GfxScreenRes ( byval w as integer, byval h as integer, byval depth as integer = 8, _
''					 byval num_pages as integer = 1, byval flags as integer = 0 )
data "fb_GfxScreenRes", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 5, _
					 		FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,8, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,1, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0

'' fb_GfxBload ( filename as string, byval dest as any ptr )
data "fb_GfxBload", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
						FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, TRUE,0

'' fb_GfxBsave ( filename as string, byval src as any ptr, byval length as integer )
data "fb_GfxBsave", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'':::::::::::::::::::::::::::::::::::::::::::::::::::


'' fb_GfxFlip ( byval frompage as integer = -1, byval topage as integer = -1 ) as void
data "flip", "fb_GfxFlip", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1

'' pcopy ( byval frompage as integer, byval topage as integer ) as void
data "pcopy", "fb_GfxFlip", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

data "screencopy", "fb_GfxFlip", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1

'' fb_GfxCursor ( number as integer) as single
data "pointcoord", "fb_GfxCursor", FB.SYMBTYPE.SINGLE,FB.FUNCMODE.STDCALL, 1, _
						           FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxPMap ( byval Coord as single, byval num as integer ) as single
data "pmap", "fb_GfxPMap", FB.SYMBTYPE.SINGLE,FB.FUNCMODE.STDCALL, 2, _
						   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
						   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxPaletteOut( byval port as integer, byval data as integer ) as void
data "out", "fb_GfxPaletteOut", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
							    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
							    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxPaletteInp( byval port as integer ) as integer
data "inp", "fb_GfxPaletteInp", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
							    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxWaitVSync ( byval port as integer, byval and_mask as integer, byval xor_mask as integer = 0 )
data "wait", "fb_GfxWaitVSync", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
								FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
								FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
								FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0

'' fb_GfxSetPage ( byval work_page as integer = -1, byval visible_page as integer = -1 ) as void
data "screenset", "fb_GfxSetPage", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1

'' fb_GfxLock ( ) as void
data "screenlock", "fb_GfxLock", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 0

'' fb_GfxUnlock ( ) as void
data "screenunlock", "fb_GfxUnlock", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
									 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
									 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1

'' fb_GfxScreenPtr ( ) as any ptr
data "screenptr", "fb_GfxScreenPtr", FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 0

'' fb_GfxSetWindowTitle ( title as string ) as void
data "windowtitle", "fb_GfxSetWindowTitle", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
											FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' fb_GfxMultikey ( scancode as integer ) as integer
data "multikey", "fb_GfxMultikey", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxGetMouse ( byref x as integer, byref y as integer, byref z as integer, byref buttons as integer ) as void
data "getmouse", "fb_GfxGetMouse", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 4, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYREF, FALSE, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYREF, FALSE, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYREF, TRUE,0, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYREF, TRUE,0

'' fb_GfxSetMouse ( byval x as integer = -1, byval y as integer = -1, byval cursor as integer = -1 ) as void
data "setmouse", "fb_GfxSetMouse", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1

'' fb_GfxScreenInfo ( ) as any ptr
data "screeninfo", "fb_GfxScreenInfo", FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 0


'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' fb_FileFree ( ) as integer
data "freefile", "fb_FileFree", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 0
'' fb_FileEof ( byval filenum as integer ) as integer
data "eof", "fb_FileEof", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_FileKill ( s as string ) as integer
data "kill", "fb_FileKill", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
							FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' fb_CVD ( str as string ) as double
data "cvd","fb_CVD", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
data "cvs","fb_CVS", FB.SYMBTYPE.SINGLE,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_CVI ( str as string ) as integer
data "cvi","fb_CVI", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
data "cvl","fb_CVI", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' fb_HEX ( byval number as integer ) as string
data "hex","fb_HEX", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_OCT ( byval number as integer ) as string
data "oct","fb_OCT", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_BIN ( byval number as integer ) as string
data "bin","fb_BIN", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_MKD ( byval number as double ) as string
data "mkd","fb_MKD", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' fb_MKI ( byval number as integer ) as string
data "mki","fb_MKI", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
data "mkl","fb_MKI", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_MKS ( byval number as single ) as string
data "mks","fb_MKS", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE

'' fb_LEFT ( str as string, byval n as integer ) as string
data "left","fb_LEFT", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 2, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_RIGHT ( str as string, byval n as integer ) as string
data "right","fb_RIGHT", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 2, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_SPACE ( byval n as integer ) as string
data "space","fb_SPACE", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_LTRIM ( str as string ) as string
data "ltrim","fb_LTRIM", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_RTRIM ( str as string ) as string
data "rtrim","fb_RTRIM", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_TRIM ( str as string ) as string
data "trim","fb_TRIM", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_LCASE ( str as string ) as string
data "lcase","fb_LCASE", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_UCASE ( str as string ) as string
data "ucase","fb_UCASE", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' fb_VAL ( str as string ) as double
data "val","fb_VAL", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_VAL64 ( str as string ) as longint
data "val64","fb_VAL64", FB.SYMBTYPE.LONGINT,FB.FUNCMODE.STDCALL, 1, _
					     FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' cos CDECL ( byval rad as double ) as double
data "cos","cos", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
				  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' acos CDECL ( byval x as double ) as double
data "acos","acos", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
					FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' sin CDECL ( byval rad as double ) as double
data "sin","sin", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
				  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' asin CDECL ( byval x as double ) as double
data "asin","asin", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
					FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' tan CDECL ( byval rad as double ) as double
data "tan","tan", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
				  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' atn CDECL ( byval x as double ) as double
data "atn","atan", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
				   FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' atan2 CDECL ( byval x as double, byval y as double ) as double
data "atan2","atan2", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 2, _
					  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' sqr CDECL ( byval rad as double ) as double
data "sqr","sqrt", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
				   FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' log CDECL ( byval rad as double ) as double
data "log","log", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
				  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' exp CDECL ( byval rad as double ) as double
data "exp","exp", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
				  FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE
'' int CDECL ( byval val as double ) as double
data "int","floor", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.CDECL, 1, _
					FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, FALSE

'' command ( byval argc as integer = -1 ) as string
data "command","fb_Command", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
							 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1
'' curdir ( ) as string
data "curdir","fb_CurDir", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 0
'' exepath ( ) as string
data "exepath","fb_ExePath", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 0

'' randomize ( byval seed as double = -1.0 ) as void
data "randomize","fb_Randomize", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
					             FB.SYMBTYPE.DOUBLE,FB.ARGMODE.BYVAL, TRUE, -1.0
'' rnd ( byval n as integer ) as double
data "rnd","fb_Rnd", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,1

'' timer ( ) as double
data "timer","fb_Timer", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.STDCALL, 0
'' time ( ) as string
data "time","fb_Time", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 0
'' date ( ) as string
data "date","fb_Date", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 0

'' pos( ) as integer
data "pos", "fb_GetX", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 0
'' csrlin( ) as integer
data "csrlin", "fb_GetY", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 0
'' cls( byval n as integer = 1 ) as void
data "cls", "fb_Cls", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,&hFFFF0000
'' locate( byval row as integer = 0, byval col as integer = 0, byval cursor as integer = -1 ) as void
data "locate", "fb_Locate", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 3, _
				 		    FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
							FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1
'' color( byval fc as integer = -1, byval bc as integer = -1 ) as void
data "color", "fb_Color", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1
'' width( byval cols as integer = 0, byval rows as integer = 0 ) as void
data "width", "fb_Width", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0

'' inkey ( ) as string
data "inkey","fb_Inkey", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 0
'' getkey ( ) as integer
data "getkey","fb_Getkey", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 0

'' shell ( byval cmm as string ) as integer
data "shell","system", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.CDECL, 1, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYVAL, FALSE

'' name ( byval oldname as string, byval newname as string ) as integer
data "name","rename", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.CDECL, 2, _
					  FB.SYMBTYPE.STRING,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.STRING,FB.ARGMODE.BYVAL, FALSE

'' system ( ) as void
data "system","fb_End", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
				        FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0
'' stop ( ) as void
data "stop","fb_End", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
				      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0

'' run ( exename as string ) as integer
data "run","fb_Run", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
				      FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' chain ( exename as string ) as integer
data "chain","fb_Chain", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
				         FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' exec ( exename as string, arguments as string ) as integer
data "exec","fb_Exec", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
				       FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
				       FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' environ ( varname as string ) as string
data "environ","fb_GetEnviron", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
				       			FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' setenviron ( varname as string ) as integer
data "setenviron","fb_SetEnviron", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
				       			   FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' sleep ( byval msecs as integer ) as void
data "sleep","fb_Sleep", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
					     FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE, -1

'' reset ( ) as void
data "reset","fb_FileReset", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 0
'' lof ( byval filenum as integer ) as uinteger
data "lof","fb_FileSize", FB.SYMBTYPE.UINT,FB.FUNCMODE.STDCALL, 1, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' loc ( byval filenum as integer ) as uinteger
data "loc","fb_FileLocation", FB.SYMBTYPE.UINT,FB.FUNCMODE.STDCALL, 1, _
						      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' lset ( dst as string, src as string ) as void
data "lset","fb_StrLset", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
				          FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
				          FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' rset ( dst as string, src as string ) as void
data "rset","fb_StrRset", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
				          FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
				          FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' fre ( ) as uinteger
data "fre","fb_GetMemAvail", FB.SYMBTYPE.UINT,FB.FUNCMODE.STDCALL, 1, _
				            FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0

'' allocate ( byval bytes as integer ) as any ptr
data "allocate","malloc", FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 1, _
					      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' callocate ( byval bytes as integer ) as any ptr
data "callocate","calloc", FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 2, _
					       FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					       FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,1
'' reallocate ( byval p as any ptr, byval bytes as integer ) as any ptr
data "reallocate","realloc", FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 2, _
					         FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE, _
					         FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' deallocate ( byval p as any ptr ) as void
data "deallocate","free", FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 1, _
					      FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE
'' clear ( dst as any, byval value as integer = 0, byval bytes as integer ) as void
data "clear","memset", FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 3, _
					   FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' dir ( mask as string, byval v as integer = &h33 ) as string
data "dir","fb_Dir", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 2, _
                     FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
                     FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,&h33

'' settime ( time as string ) as integer
data "settime","fb_SetTime", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
                     		 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' setdate ( date as string ) as integer
data "setdate","fb_SetDate", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
                     		 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' threadcreate ( byval proc as sub( byval param as integer ), byval param as integer = 0) as integer
data "threadcreate","fb_ThreadCreate", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
									   FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE, _
									   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,0
'' threadwait ( byval id as integer ) as void
data "threadwait","fb_ThreadWait", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' mutexcreate ( ) as integer
data "mutexcreate","fb_MutexCreate", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 0
'' mutexdestroy ( byval id as integer ) as void
data "mutexdestroy","fb_MutexDestroy", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
									   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' mutexlock ( byval id as integer ) as void
data "mutexlock","fb_MutexLock", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
								 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' mutexunlock ( byval id as integer ) as void
data "mutexunlock","fb_MutexUnlock", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
									 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' condcreate ( ) as integer
data "condcreate","fb_CondCreate", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 0
'' conddestroy ( byval id as integer ) as void
data "conddestroy","fb_CondDestroy", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
									 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' condsignal ( byval id as integer ) as void
data "condsignal","fb_CondSignal", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
								   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' condbroadcast ( byval id as integer ) as void
data "condbroadcast","fb_CondBroadcast", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
										 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' condwait ( byval id as integer ) as void
data "condwait","fb_CondWait", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
							   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' dylibload ( filename as string ) as integer
data "dylibload","fb_DylibLoad", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
								 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' dylibsymbol( byval library as integer, symbol as string) as any ptr
data "dylibsymbol","fb_DylibSymbol", FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
									 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
									 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'':::::::::::::::::::::::::::::::::::::::::::::::::::

#ifdef TARGET_WIN32

'' beep ( ) as void
data "beep","_beep", FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 0

'' mkdir ( byval path as string ) as integer
data "mkdir","_mkdir", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.CDECL, 1, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYVAL, FALSE
'' rmdir ( byval path as string ) as integer
data "rmdir","_rmdir", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.CDECL, 1, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYVAL, FALSE
'' chdir ( byval path as string ) as integer
data "chdir","_chdir", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.CDECL, 1, _
					   FB.SYMBTYPE.STRING,FB.ARGMODE.BYVAL, FALSE

#else

'' beep ( ) as void
data "beep","", FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 0

'' mkdir ( byval path as string, byval mode as integer = &o644 ) as integer
data "mkdir","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.CDECL, 2, _
                 FB.SYMBTYPE.STRING,FB.ARGMODE.BYVAL, FALSE, _
                 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,&o644
'' rmdir ( byval path as string ) as integer
data "rmdir","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.CDECL, 1, _
                 FB.SYMBTYPE.STRING,FB.ARGMODE.BYVAL, FALSE
'' chdir ( byval path as string ) as integer
data "chdir","", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.CDECL, 1, _
                 FB.SYMBTYPE.STRING,FB.ARGMODE.BYVAL, FALSE

#endif


'' EOL
data ""

'':::::::::::::::::::::::::::::::::::::::::::::::::::
'' MACROS
'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' name, args, arg[0] to arg[n] names, macro text
imacrodata:
''#define RGB(r,g,b) ((cuint(r) shl 16) or (cuint(g) shl 8) or cuint(b))
data "RGB", 3, "R", "G", "B", "((cuint(#R#) shl 16) or (cuint(#G#) shl 8) or cuint(#B#))"

''#define va_arg(a,t) peek( t, a )
data "VA_ARG", 2, "A", "T", "peek( #T#, #A# )"
''#define va_next(a,t) (a + len( t ))
data "VA_NEXT", 2, "A", "T", "(#A# + len( #T# ))"

'#ifndef FB__BIGENDIAN
''#define LOWORD(x) (cuint(x) and &h0000FFFF)
data "LOWORD", 1, "X", "(cuint(#X#) and &h0000FFFF)"
''#define HIWORD(x) (cyint(x) shr 16)
data "HIWORD", 1, "X", "(cuint(#X#) shr 16)"
''#define LOBYTE(x) (cuint(x) and &h000000FF)
data "LOBYTE", 1, "X", "(cuint(#X#) and &h000000FF)"
''#define HIBYTE(x) ((cuint(x) and &h0000FF00) shr 8)
data "HIBYTE", 1, "X", "((cuint(#X#) and &h0000FF00) shr 8)"
''#define BIT(x,y) (((x) and (1 shl (y))) > 0)
data "BIT", 2, "X", "Y", "(((#X#) and (1 shl (#Y#))) <> 0)"
''#define BITSET(x,y) ((x) or (1 shl (y)))
data "BITSET", 2, "X", "Y", "((#X#) or (1 shl (#Y#)))"
''#define BITRESET(x,y) ((x) and not (y))
data "BITRESET", 2, "X", "Y", "((#X#) and not (1 shl (#Y#)))"
'#endif

'' EOL
data ""


'':::::::::::::::::::::::::::::::::::::::::::::::::::
'' implementation
'':::::::::::::::::::::::::::::::::::::::::::::::::::

#define cntptr(typ,t,cnt)						_
	t = typ                                     : _
	cnt = 0                                     : _
	do while( t >= IR.DATATYPE.POINTER )		: _
		t -= IR.DATATYPE.POINTER				: _
		cnt += 1								: _
	loop


'':::::
private sub hAddIntrinsicProcs
	dim as integer i, typ
	dim as string pname, aname
	dim as integer p, ptype, pmode, pargs
	dim as integer a, atype, alen, amode, optional, ptrcnt
	dim as FBSYMBOL ptr argtail
	dim as FBVALUE optval

	''
	redim ifuncTB( 0 to FB.RTL.MAXFUNCTIONS-1 ) as FBSYMBOL ptr

	restore ifuncdata
	i = 0
	do
		read pname
		if( len( pname ) = 0 ) then
			exit do
		end if

		read aname, ptype, pmode, pargs

		argtail = NULL
		for a = 0 to pargs-1
			read atype, amode, optional

			if( optional ) then
				if( (atype <> IR.DATATYPE.LONGINT) and (atype <> IR.DATATYPE.ULONGINT) ) then
					read optval.value
				else
					read optval.value64
				end if
			end if

			if( atype <> INVALID ) then
				alen = symbCalcArgLen( atype, NULL, amode )
			else
				alen = FB.POINTERSIZE
			end if

			cntptr( atype, typ, ptrcnt )

			argtail = symbAddArg( "", argtail, atype, NULL, ptrcnt, alen, amode, INVALID, optional, @optval )
		next a

		cntptr( ptype, typ, ptrcnt )
		ifuncTB(i) = symbAddPrototype( pname, aname, "fb", ptype, NULL, ptrcnt, 0, pmode, _
									   pargs, argtail, TRUE )
		i = i + 1
	loop

end sub

'':::::
private sub hAddIntrinsicMacros
	dim as integer i, args
	dim as FBDEFARG ptr arghead, lastarg, arg
	dim as string oldname, newname, mname, mtext, aname

	restore imacrodata
	do
		read mname
		if( len( mname ) = 0 ) then
			exit do
		end if

		arghead = NULL
		lastarg = NULL

		'' for each argument, add it
		read args
		for i = 0 to args-1
			read aname

			lastarg = symbAddDefineArg( lastarg, aname )

			if( arghead = NULL ) then
				arghead = lastarg
			end if
		next i

		read mtext

    	'' replace the pattern by the one that Lex expects
    	arg = arghead
    	do while( arg <> NULL )
        	oldname = "#"
        	oldname += arg->name
        	oldname += "#"

        	newname = "\27"
        	newname += hex$( arg )
        	newname += "\27"

        	hReplace( mtext, oldname, newname )

        	arg = arg->r
        loop

        symbAddDefine( mname, mtext, args, arghead )

	loop

end sub

'':::::
sub rtlInit static

    ''
	fbAddDefaultLibs

	''
	hAddIntrinsicProcs

	''
	hAddIntrinsicMacros

	''
	ctx.datainited	= FALSE
	ctx.lastlabel	= NULL
    ctx.labelcnt 	= 0

end sub

'':::::
sub rtlEnd

	'' procs will be deleted when symbEnd is called

	'' ditto with macros

	erase ifuncTB

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' strings
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function hGetFixStrLen( byval expr as integer ) as integer
	dim lgt as integer

	lgt = symbGetLen( astGetSymbol( expr ) ) - 1

	'' if < 0 (ie: a byval as string arg), return 0, the rtlib will take care of the real lenght
	hGetFixStrLen = iif( lgt < 0, 0, lgt )

end function


'':::::
function rtlStrCompare ( byval str1 as integer, byval sdtype1 as integer, _
					     byval str2 as integer, byval sdtype2 as integer ) as integer static
    dim lgt as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim str1len as integer, str2len as integer
    dim s as integer

	rtlStrCompare = INVALID

	''
	f = ifuncTB(FB.RTL.STRCOMPARE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

   	''
	str1len = -1
	if( (sdtype1 = IR.DATATYPE.BYTE) or (sdtype1 = IR.DATATYPE.UBYTE) ) then
		str1len = 0
	elseif( hIsStrFixed( sdtype1 ) ) then
		str1len = hGetFixStrLen( str1 )
	end if

    ''
	str2len = -1
	if( (sdtype2 = IR.DATATYPE.BYTE) or (sdtype2 = IR.DATATYPE.UBYTE) ) then
		str2len = 0
	elseif( hIsStrFixed( sdtype2 ) ) then
		str2len = hGetFixStrLen( str2 )
	end if

    ''
    if( astNewPARAM( proc, str1, sdtype1 ) = INVALID ) then
    	exit function
    end if
    lgt = astNewCONST( str1len, IR.DATATYPE.INTEGER )
    if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, str2, sdtype2 ) = INVALID ) then
    	exit function
    end if
    lgt = astNewCONST( str2len, IR.DATATYPE.INTEGER )
    if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

    rtlStrCompare = proc

end function

'':::::
function rtlStrConcat( byval str1 as integer, byval sdtype1 as integer, _
					   byval str2 as integer, byval sdtype2 as integer ) as integer static
    dim lgt as integer, tstr as FBSYMBOL ptr
    dim proc as integer, f as FBSYMBOL ptr
    dim str1len as integer, str2len as integer
    dim s as integer

	rtlStrConcat = INVALID

	''
	f = ifuncTB(FB.RTL.STRCONCAT)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' dst as string
    tstr = symbAddTempVar( FB.SYMBTYPE.STRING )
    if( astNewPARAM( proc, astNewVAR( tstr, NULL, 0, IR.DATATYPE.STRING ), IR.DATATYPE.STRING ) = INVALID ) then
    	exit function
    end if

   	''
	str1len = -1
	if( (sdtype1 = IR.DATATYPE.BYTE) or (sdtype1 = IR.DATATYPE.UBYTE) ) then
		str1len = 0
	elseif( hIsStrFixed( sdtype1 ) ) then
		str1len = hGetFixStrLen( str1 )
	end if

    ''
	str2len = -1
	if( (sdtype2 = IR.DATATYPE.BYTE) or (sdtype2 = IR.DATATYPE.UBYTE) ) then
		str2len = 0
	elseif( hIsStrFixed( sdtype2 ) ) then
		str2len = hGetFixStrLen( str2 )
	end if

    ''
    if( astNewPARAM( proc, str1, sdtype1 ) = INVALID ) then
    	exit function
    end if
    lgt = astNewCONST( str1len, IR.DATATYPE.INTEGER )
    if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, str2, sdtype2 ) = INVALID ) then
    	exit function
    end if
    lgt = astNewCONST( str2len, IR.DATATYPE.INTEGER )
    if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

    rtlStrConcat = proc

end function

'':::::
function rtlStrConcatAssign( byval dst as integer, byval src as integer ) as integer static
    dim lgt as integer, dtype as integer
    dim f as FBSYMBOL ptr, proc as integer
    dim s as integer

	rtlStrConcatAssign = INVALID

	''
	f = ifuncTB(FB.RTL.STRCONCATASSIGN)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
   	dtype = astGetDataType( dst )

	lgt = -1
	if( (dtype = IR.DATATYPE.BYTE) or (dtype = IR.DATATYPE.UBYTE) ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( dst )
	end if
	if( astNewPARAM( proc, dst, dtype ) = INVALID ) then
    	exit function
    end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

   	''
   	dtype = astGetDataType( src )

	lgt = -1
	if( (dtype = IR.DATATYPE.BYTE) or (dtype = IR.DATATYPE.UBYTE) ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( src )
	end if
	if( astNewPARAM( proc, src, dtype ) = INVALID ) then
    	exit function
    end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

	''
	rtlStrConcatAssign = proc

end function

'':::::
function rtlStrAssign( byval dst as integer, byval src as integer ) as integer static
    dim lgt as integer, dtype as integer
    dim f as FBSYMBOL ptr, proc as integer
    dim s as integer

	rtlStrAssign = INVALID

	''
	f = ifuncTB(FB.RTL.STRASSIGN)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
   	dtype = astGetDataType( dst )

	lgt = -1
	if( (dtype = IR.DATATYPE.BYTE) or (dtype = IR.DATATYPE.UBYTE) ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( dst )
	end if
	if( astNewPARAM( proc, dst, dtype ) = INVALID ) then
    	exit function
    end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

   	''
   	dtype = astGetDataType( src )

	lgt = -1
	if( (dtype = IR.DATATYPE.BYTE) or (dtype = IR.DATATYPE.UBYTE) ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( src )
	end if
	if( astNewPARAM( proc, src, dtype ) = INVALID ) then
    	exit function
    end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

	''
	rtlStrAssign = proc

end function

'':::::
function rtlStrDelete( byval strg as integer ) as integer static
    dim lgt as integer
    dim proc as integer, f as FBSYMBOL ptr

	rtlStrDelete = INVALID

	''
	f = ifuncTB(FB.RTL.STRDELETE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' str as ANY
    if( astNewPARAM( proc, strg, IR.DATATYPE.STRING ) = INVALID ) then
    	exit function
    end if

    rtlStrDelete = proc

end function

'':::::
function rtlStrAllocTmpResult( byval strg as integer ) as integer static
    dim lgt as integer
    dim proc as integer, f as FBSYMBOL ptr

	rtlStrAllocTmpResult = INVALID

	''
	f = ifuncTB(FB.RTL.STRALLOCTMPRES)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' src as string
    if( astNewPARAM( proc, strg, IR.DATATYPE.STRING ) = INVALID ) then
    	exit function
    end if

	rtlStrAllocTmpResult = proc

end function

'':::::
function rtlStrAllocTmpDesc	( byval strg as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr
    dim s as integer, lgt as integer, dtype as integer

    rtlStrAllocTmpDesc = INVALID

	''
	f = ifuncTB(FB.RTL.STRALLOCTMPDESC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' str as any
    if( astNewPARAM( proc, strg, IR.DATATYPE.STRING ) = INVALID ) then
    	exit function
    end if

    '' byval strlen as integer
   	dtype = astGetDataType( strg )

	lgt = -1
	if( (dtype = IR.DATATYPE.BYTE) or (dtype = IR.DATATYPE.UBYTE) ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( strg )
	end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

	''
	rtlStrAllocTmpDesc = proc

end function

'':::::
function rtlToStr( byval expr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr

    rtlToStr = INVALID

    ''
	select case astGetDataClass( expr )
	case IR.DATACLASS.INTEGER

		select case as const astGetDataType( expr )
		case IR.DATATYPE.LONGINT
			f = ifuncTB(FB.RTL.LONGINT2STR)
		case IR.DATATYPE.ULONGINT
			f = ifuncTB(FB.RTL.ULONGINT2STR)
		case IR.DATATYPE.BYTE, IR.DATATYPE.SHORT, IR.DATATYPE.INTEGER
			f = ifuncTB(FB.RTL.INT2STR)
		case IR.DATATYPE.UBYTE, IR.DATATYPE.USHORT, IR.DATATYPE.UINT
			f = ifuncTB(FB.RTL.UINT2STR)
		case else
			f = ifuncTB(FB.RTL.UINT2STR)
		end select

	case IR.DATACLASS.FPOINT
		if( astGetDataType( expr ) = IR.DATATYPE.SINGLE ) then
			f = ifuncTB(FB.RTL.FLT2STR)
		else
			f = ifuncTB(FB.RTL.DBL2STR)
		end if
	case else
		rtlToStr = INVALID
		exit function
	end select

	''
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
    if( astNewPARAM( proc, expr, INVALID ) = INVALID ) then
    	exit function
    end if

    rtlToStr = proc

end function

'':::::
function rtlStrInstr( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr

	rtlStrInstr = INVALID

	''
	f = ifuncTB(FB.RTL.STRINSTR)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
    if( astNewPARAM( proc, expr1, INVALID ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr2, INVALID ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr3, INVALID ) = INVALID ) then
    	exit function
    end if

    rtlStrInstr = proc

end function

'':::::
function rtlStrMid( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr

    rtlStrMid = INVALID

	''
	f = ifuncTB(FB.RTL.STRMID)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
    if( astNewPARAM( proc, expr1, INVALID ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr2, INVALID ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr3, INVALID ) = INVALID ) then
    	exit function
    end if

    rtlStrMid = proc

end function

'':::::
function rtlStrAssignMid( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer, _
						  byval expr4 as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

    rtlStrAssignMid = INVALID

	''
	f = ifuncTB(FB.RTL.STRASSIGNMID)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
    if( astNewPARAM( proc, expr1, INVALID ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr2, INVALID ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr3, INVALID ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr4, INVALID ) = INVALID ) then
    	exit function
    end if

    ''
    astFlush proc, vr

    rtlStrAssignMid = proc

end function

'':::::
function rtlStrFill( byval expr1 as integer, byval expr2 as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr

    rtlStrFill = INVALID

	select case astGetDataClass( expr2 )
	case IR.DATACLASS.INTEGER, IR.DATACLASS.FPOINT
		f = ifuncTB(FB.RTL.STRFILL1)
	case else
		f = ifuncTB(FB.RTL.STRFILL2)
	end select

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
    if( astNewPARAM( proc, expr1, INVALID ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, expr2, INVALID ) = INVALID ) then
    	exit function
    end if

    rtlStrFill = proc

end function

'':::::
function rtlStrAsc( byval expr as integer, byval posexpr as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr

	rtlStrAsc = INVALID

	f = ifuncTB(FB.RTL.STRASC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' src as string
    if( astNewPARAM( proc, expr, INVALID ) = INVALID ) then
    	exit function
    end if

    '' byval pos as integer
    if( posexpr = INVALID ) then
    	posexpr = astNewCONST( 1, IR.DATATYPE.INTEGER )
    end if

    if( astNewPARAM( proc, posexpr, INVALID ) = INVALID ) then
    	exit function
    end if

    rtlStrAsc = proc

end function

'':::::
function rtlStrChr( byval args as integer, exprtb() as integer ) as integer static
	dim i as integer, expr as integer
    dim proc as integer, f as FBSYMBOL ptr

	rtlStrChr = INVALID

	f = ifuncTB(FB.RTL.STRCHR)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval args as integer
    if( astNewPARAM( proc, astNewCONST( args, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
    	exit function
    end if

    '' ...
    for i = 0 to args-1
    	expr = exprtb(i)

    	'' convert to int
    	if( astGetDataType( expr ) <> IR.DATATYPE.INTEGER ) then
    		expr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, expr )
    	end if

    	if( astNewPARAM( proc, expr, IR.DATATYPE.INTEGER ) = INVALID ) then
    		exit function
    	end if
    next i

    rtlStrChr = proc

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' arrays
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlArrayRedim( byval s as FBSYMBOL ptr, byval elementlen as integer, byval dimensions as integer, _
				        exprTB() as integer, byval dopreserve as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, expr as integer, isvarlen as integer
    dim i as integer
    dim reslabel as FBSYMBOL ptr

    rtlArrayRedim = FALSE

	''
	f = ifuncTB(FB.RTL.ARRAYREDIM)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' array() as ANY
    dtype =  symbGetType( s )
	expr = astNewVAR( s, NULL, 0, dtype )
    if( astNewPARAM( proc, expr, dtype ) = INVALID ) then
    	exit function
    end if

	'' byval element_len as integer
	expr = astNewCONST( elementlen, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, expr, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

	'' byval isvarlen as integer
	isvarlen = FALSE
	if( symbIsString( s ) ) then
		isvarlen = not hIsStrFixed( dtype )
	end if
	expr = astNewCONST( isvarlen, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, expr, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

	'' byval preserve as integer
	expr = astNewCONST( dopreserve, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, expr, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

	'' byval dimensions as integer
	expr = astNewCONST( dimensions, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, expr, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

	'' ...
	for i = 0 to dimensions-1

		'' lbound
		expr = exprTB(i, 0)

    	'' convert to int
    	if( astGetDataType( expr ) <> IR.DATATYPE.INTEGER ) then
    		expr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, expr )
    	end if

		if( astNewPARAM( proc, expr, IR.DATATYPE.INTEGER ) = INVALID ) then
    		exit function
    	end if

		'' ubound
		expr = exprTB(i, 1)

    	'' convert to int
    	if( astGetDataType( expr ) <> IR.DATATYPE.INTEGER ) then
    		expr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, expr )
    	end if

		if( astNewPARAM( proc, expr, IR.DATATYPE.INTEGER ) = INVALID ) then
    		exit function
    	end if
	next i

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
	rtlArrayRedim = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlArrayErase( byval arrayexpr as integer ) as integer static
    dim s as FBSYMBOL ptr
    dim proc as integer, f as FBSYMBOL ptr
    dim typ as integer, dtype as integer, t as integer, isvarlen as integer
    dim vr as integer

	rtlArrayErase = FALSE

	''
	f = ifuncTB(FB.RTL.ARRAYERASE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' array() as ANY
    if( astNewPARAM( proc, arrayexpr, astGetDataType( arrayexpr ) ) = INVALID ) then
    	exit function
    end if

	'' byval isvarlen as integer
	isvarlen = FALSE
	if( symbIsString( astGetSymbol( arrayexpr ) ) ) then
		isvarlen = not hIsStrFixed( dtype )
	end if
	t = astNewCONST( isvarlen, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

    ''
	astFlush proc, vr

	rtlArrayErase = TRUE

end function

'':::::
function rtlArrayClear( byval arrayexpr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim isvarlen as integer, dtype as integer
    dim vr as integer

    rtlArrayClear = FALSE

	''
	f = ifuncTB(FB.RTL.ARRAYCLEAR)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' array() as ANY
    if( astNewPARAM( proc, arrayexpr, astGetDataType( arrayexpr ) ) = INVALID ) then
    	exit function
    end if

	'' byval isvarlen as integer
	dtype = symbGetType( astGetSymbol( arrayexpr ) )

    isvarlen = FALSE
	if( hIsString( dtype ) ) then
		isvarlen = not hIsStrFixed( dtype )
	end if
	if( astNewPARAM( proc, astNewCONST( isvarlen, IR.DATATYPE.INTEGER ), IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

    ''
	astFlush proc, vr

	rtlArrayClear = TRUE

end function

'':::::
function rtlArrayStrErase( byval s as FBSYMBOL ptr ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, t as integer, isvarlen as integer
    dim vr as integer

	rtlArrayStrErase = FALSE

	''
	f = ifuncTB(FB.RTL.ARRAYSTRERASE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' array() as ANY
    dtype = symbGetType( s )
	t = astNewVAR( s, NULL, 0, dtype )
    if( astNewPARAM( proc, t, dtype ) = INVALID ) then
    	exit function
    end if

    ''
	astFlush proc, vr

	rtlArrayStrErase = TRUE

end function

'':::::
function rtlArrayBound( byval sexpr as integer, byval dimexpr as integer, byval islbound as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlArrayBound = INVALID

	''
	if( islbound ) then
		f = ifuncTB(FB.RTL.ARRAYLBOUND)
	else
		f = ifuncTB(FB.RTL.ARRAYUBOUND)
	end if
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' array() as ANY
    if( astNewPARAM( proc, sexpr, INVALID ) = INVALID ) then
    	exit function
    end if

	'' byval dimension as integer
	if( astNewPARAM( proc, dimexpr, INVALID ) = INVALID ) then
		exit function
	end if

    ''
    rtlArrayBound = proc

end function

'':::::
function rtlArraySetDesc( byval s as FBSYMBOL ptr, byval elementlen as integer, _
					      byval dimensions as integer, dTB() as FBARRAYDIM ) as integer static

    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, t as integer
    dim i as integer, vr as integer

    rtlArraySetDesc = FALSE

	f = ifuncTB(FB.RTL.ARRAYSETDESC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' array() as ANY
    dtype =  symbGetType( s )
	t = astNewVAR( s, NULL, 0, dtype )
    if( astNewPARAM( proc, t, dtype ) = INVALID ) then
		exit function
	end if

	'' arraydata as any
	t = astNewVAR( s, NULL, 0, dtype )
    if( astNewPARAM( proc, t, dtype ) = INVALID ) then
		exit function
	end if

	'' byval element_len as integer
	t = astNewCONST( elementlen, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
		exit function
	end if

	'' byval dimensions as integer
	t = astNewCONST( dimensions, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
		exit function
	end if

	'' ...
	for i = 0 to dimensions-1
		'' lbound
		t = astNewCONST( dTB(i).lower, IR.DATATYPE.INTEGER )
		if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
			exit function
		end if

		'' ubound
		t = astNewCONST( dTB(i).upper, IR.DATATYPE.INTEGER )
		if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
			exit function
		end if
	next i

    ''
	astFlush proc, vr

	rtlArraySetDesc = TRUE

end function

'':::::
function rtlArrayAllocTmpDesc( byval arrayexpr as integer, byval pdesc as FBSYMBOL ptr ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, t as integer
    dim s as FBSYMBOL ptr
    dim d as FBVARDIM ptr
    dim dimensions as integer

	rtlArrayAllocTmpDesc = INVALID

	s = astGetSymbol( arrayexpr )

	dimensions = symbGetArrayDimensions( s )

	f = ifuncTB(FB.RTL.ARRAYALLOCTMPDESC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byref pdesc as any ptr
	t = astNewVAR( pdesc, NULL, 0, IR.DATATYPE.POINTER+IR.DATATYPE.VOID )
    if( astNewPARAM( proc, t, IR.DATATYPE.POINTER+IR.DATATYPE.VOID ) = INVALID ) then
    	exit function
    end if

    '' byref arraydata as any
    if( astNewPARAM( proc, arrayexpr, IR.DATATYPE.VOID ) = INVALID ) then
    	exit function
    end if

	'' byval element_len as integer
	t = astNewCONST( symbGetLen( s ), IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

	'' byval dimensions as integer
	t = astNewCONST( dimensions, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

	'' ...
    d = symbGetArrayFirstDim( s )
    do while( d <> NULL )
		'' lbound
		t = astNewCONST( d->lower, IR.DATATYPE.INTEGER )
		if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
    		exit function
    	end if

		'' ubound
		t = astNewCONST( d->upper, IR.DATATYPE.INTEGER )
		if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
    		exit function
    	end if

		'' next
		d = d->r
	loop

	rtlArrayAllocTmpDesc = proc

end function

'':::::
function rtlArrayFreeTempDesc( byval pdesc as FBSYMBOL ptr ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer

	rtlArrayFreeTempDesc = INVALID

	f = ifuncTB(FB.RTL.ARRAYFREETMPDESC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval pdesc as any ptr
	t = astNewVAR( pdesc, NULL, 0, IR.DATATYPE.POINTER+IR.DATATYPE.VOID )
    if( astNewPARAM( proc, t, IR.DATATYPE.POINTER+IR.DATATYPE.VOID ) = INVALID ) then
    	exit function
    end if

    rtlArrayFreeTempDesc = proc

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' data
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlDataRead( byval varexpr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr, args as integer
    dim vr as integer, dtype as integer, lgt as integer

    rtlDataRead = FALSE

	f = NULL
	args = 1
	select case as const astGetDataType( varexpr )
	case IR.DATATYPE.STRING, IR.DATATYPE.FIXSTR
		f = ifuncTB(FB.RTL.DATAREADSTR)
		args = 2
	case IR.DATATYPE.BYTE
		f = ifuncTB(FB.RTL.DATAREADBYTE)
	case IR.DATATYPE.UBYTE
		f = ifuncTB(FB.RTL.DATAREADUBYTE)
	case IR.DATATYPE.SHORT
		f = ifuncTB(FB.RTL.DATAREADSHORT)
	case IR.DATATYPE.USHORT
		f = ifuncTB(FB.RTL.DATAREADUSHORT)
	case IR.DATATYPE.INTEGER
		f = ifuncTB(FB.RTL.DATAREADINT)
	case IR.DATATYPE.UINT
		f = ifuncTB(FB.RTL.DATAREADUINT)
	case IR.DATATYPE.LONGINT
		f = ifuncTB(FB.RTL.DATAREADLONGINT)
	case IR.DATATYPE.ULONGINT
		f = ifuncTB(FB.RTL.DATAREADULONGINT)
	case IR.DATATYPE.SINGLE
		f = ifuncTB(FB.RTL.DATAREADSINGLE)
	case IR.DATATYPE.DOUBLE
		f = ifuncTB(FB.RTL.DATAREADDOUBLE)
	case IR.DATATYPE.USERDEF
		exit function						'' illegal
	case else
		f = ifuncTB(FB.RTL.DATAREADUINT)
	end select

    if( f = NULL ) then
    	exit function
    end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byref var as any
    if( astNewPARAM( proc, varexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    if( args = 2 ) then
		'' byval dst_size as integer
		lgt = -1
		dtype = astGetDataType( varexpr )
		if( hIsStrFixed( dtype ) ) then
			lgt = hGetFixStrLen( varexpr )
		end if
		lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
		if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
 			exit function
 		end if
    end if

    ''
    astFlush proc, vr

    rtlDataRead = TRUE

end function

'':::::
function rtlDataRestore( byval label as FBSYMBOL ptr ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer
    dim lname as string
    dim s as FBSYMBOL ptr

    rtlDataRestore = FALSE

	f = ifuncTB(FB.RTL.DATARESTORE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' begin of data or start from label?
    if( label <> NULL ) then
    	lname = FB.DATALABELPREFIX + symbGetName( label )
    else
    	lname = FB.DATALABELNAME
    end if

    '' label already declared?
    s = symbFindByNameAndClass( lname, FB.SYMBCLASS.LABEL )
    if( s = NULL ) then
       	s = symbAddLabel( lname, TRUE, TRUE )
    end if

    '' byval labeladdrs as void ptr
    label = astNewADDR( IR.OP.ADDROF, astNewVAR( s, NULL, 0, IR.DATATYPE.UINT ), s )

    if( astNewPARAM( proc, label, INVALID ) = INVALID ) then
 		exit function
 	end if

	''
	astFlush proc, vr

	rtlDataRestore = TRUE

end function

'':::::
sub rtlDataStoreBegin static
    dim label as FBSYMBOL ptr, lname as string
    dim l as FBSYMBOL ptr

	''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
	irFlush

	'' switch section, can't be code coz it will screw up debugging
	emitSECTION EMIT.SECTYPE.CONST

	'' emit default label if not yet emited
	if( not ctx.datainited ) then
		ctx.datainited = TRUE

		l = symbAddLabel( FB.DATALABELNAME, TRUE, TRUE )
		if( l = NULL ) then
			l = symbFindByNameAndClass( FB.DATALABELNAME, FB.SYMBCLASS.LABEL )
		end if

		lname = symbGetName( l )
		emitLABEL lname

	else
		lname = symbGetName( symbFindByNameAndClass( FB.DATALABELNAME, FB.SYMBCLASS.LABEL ) )
	end if

	'' emit last label as a label in const section
	'' if any defined already, otherwise it will be the default
	label = symbGetLastLabel
	if( label <> NULL ) then
    	''
    	lname = FB.DATALABELPREFIX + symbGetName( label )
    	l = symbFindByNameAndClass( lname, FB.SYMBCLASS.LABEL )
    	if( l = NULL ) then
       		l = symbAddLabel( lname, TRUE, TRUE )
    	end if

    	lname = symbGetName( l )

    	'' stills the same label as before? incrase counter to link DATA's
    	if( ctx.lastlabel = label ) then
    		ctx.labelcnt = ctx.labelcnt + 1
    		lname = lname + "_" + ltrim$( str$( ctx.labelcnt ) )
    	else
    		ctx.lastlabel = label
    		ctx.labelcnt = 0
    	end if

    	emitLABEL lname

    else
    	symbSetLastLabel symbFindByNameAndClass( FB.DATALABELNAME, FB.SYMBCLASS.LABEL )
    end if

	'' emit will link the last DATA with this one if any exists
	emitDATABEGIN lname

end sub

'':::::
function rtlDataStore( littext as string, byval litlen as integer, byval typ as integer ) as integer static

	'' emit will take care of all dirty details
	emitDATA littext, litlen, typ

	rtlDataStore = TRUE

end function

'':::::
sub rtlDataStoreEnd static

	'' emit end of data (will be repatched be emit if more DATA stmts follow)
	emitDATAEND

	'' back to code section
	emitSECTION EMIT.SECTYPE.CODE

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' math
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlMathPow	( byval xexpr as integer, byval yexpr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr

	''
	f = ifuncTB(FB.RTL.POW)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval x as double
    astNewPARAM( proc, xexpr, INVALID )

    '' byval y as double
    astNewPARAM( proc, yexpr, INVALID )

    ''
    rtlMathPow = proc

end function

'':::::
function rtlMathFSGN ( byval expr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr

	''
	if( astGetDataType( expr ) = IR.DATATYPE.SINGLE ) then
		f = ifuncTB(FB.RTL.SGNSINGLE)
	else
		f = ifuncTB(FB.RTL.SGNDOUBLE)
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval x as single|double
    astNewPARAM( proc, expr, INVALID )

    ''
    rtlMathFSGN = proc

end function

'':::::
function rtlMathFIX ( byval expr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr

	''
	select case astGetDataClass( expr )
	case IR.DATACLASS.FPOINT
		if( astGetDataType( expr ) = IR.DATATYPE.SINGLE ) then
			f = ifuncTB(FB.RTL.FIXSINGLE)
		else
			f = ifuncTB(FB.RTL.FIXDOUBLE)
		end if

	case IR.DATACLASS.INTEGER
		rtlMathFIX = expr
		exit function

	case else
		rtlMathFIX = INVALID
		exit function
	end select

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval x as single|double
    astNewPARAM( proc, expr, INVALID )

    ''
    rtlMathFIX = proc

end function

'':::::
private function hCalcExprLen( byval expr as integer, byval realsize as integer = TRUE ) as integer static
	dim lgt as integer, s as FBSYMBOL ptr
	dim dtype as integer

	lgt = -1

	dtype = astGetDataType( expr )
	select case as const dtype
	case IR.DATATYPE.BYTE, IR.DATATYPE.UBYTE
		lgt = 1

	case IR.DATATYPE.SHORT, IR.DATATYPE.USHORT
		lgt = 2

	case IR.DATATYPE.INTEGER, IR.DATATYPE.UINT
		lgt = FB.INTEGERSIZE

	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		lgt = FB.INTEGERSIZE*2

	case IR.DATATYPE.SINGLE
		lgt = 4

	case IR.DATATYPE.DOUBLE
		lgt = 8

	case IR.DATATYPE.USERDEF
		s = astGetSymbol( expr )
		'' if it's a type field that's an udt, no pad is ever added, realsize is always TRUE
		if( s->class = FB.SYMBCLASS.UDTELM ) then
			realsize = TRUE
		end if
		lgt = symbGetUDTLen( symbGetSubtype( s ), realsize )

	case else
		if( dtype >= IR.DATATYPE.POINTER ) then
			lgt = FB.POINTERSIZE
		end if
	end select

	hCalcExprLen = lgt

end function

'':::::
function rtlMathLen( byval expr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, lgt as integer, s as integer


	dtype = astGetDataType( expr )

	if( hIsString( dtype ) ) then
		f = ifuncTB(FB.RTL.STRLEN)
    	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    	'' str as any
    	astNewPARAM( proc, expr, IR.DATATYPE.STRING )

    	'' byval strlen as integer
		lgt = -1
		if( hIsStrFixed( dtype ) ) then
			lgt = hGetFixStrLen( expr )
		end if
		lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
		astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

		rtlMathLen = proc
		exit function
	end if

	''
	lgt = hCalcExprLen( expr, FALSE )
	astDelTree expr

	rtlMathLen = astNewCONST( lgt, IR.DATATYPE.INTEGER )

end function

'':::::
function rtlMathLongintDIV( byval dtype as integer, _
							byval lexpr as integer, byval ldtype as integer, _
					        byval rexpr as integer, byval rdtype as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr

	rtlMathLongintDIV = INVALID

	if( dtype = IR.DATATYPE.LONGINT ) then
		f = ifuncTB(FB.RTL.LONGINTDIV)
	else
		f = ifuncTB(FB.RTL.ULONGINTDIV)
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
    if( astNewPARAM( proc, lexpr, ldtype ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, rexpr, rdtype ) = INVALID ) then
    	exit function
    end if

    rtlMathLongintDIV = proc

end function

'':::::
function rtlMathLongintMOD( byval dtype as integer, _
							byval lexpr as integer, byval ldtype as integer, _
					        byval rexpr as integer, byval rdtype as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr

	rtlMathLongintMOD = INVALID

	if( dtype = IR.DATATYPE.LONGINT ) then
		f = ifuncTB(FB.RTL.LONGINTMOD)
	else
		f = ifuncTB(FB.RTL.ULONGINTMOD)
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
    if( astNewPARAM( proc, lexpr, ldtype ) = INVALID ) then
    	exit function
    end if

    if( astNewPARAM( proc, rexpr, rdtype ) = INVALID ) then
    	exit function
    end if

    rtlMathLongintMOD = proc

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' console
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlPrint( byval fileexpr as integer, byval iscomma as integer, byval issemicolon as integer, _
				   byval expr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer, mask as integer, args as integer
    dim vr as integer, dtype as integer

    rtlPrint = FALSE

	if( expr = INVALID ) then
		f = ifuncTB(FB.RTL.PRINTVOID)
		args = 2
	else

		dtype = astGetDataType( expr )
		select case as const dtype
		case IR.DATATYPE.FIXSTR, IR.DATATYPE.STRING
			f = ifuncTB(FB.RTL.PRINTSTR)
		case IR.DATATYPE.BYTE
			f = ifuncTB(FB.RTL.PRINTBYTE)
		case IR.DATATYPE.UBYTE
			f = ifuncTB(FB.RTL.PRINTUBYTE)
		case IR.DATATYPE.SHORT
			f = ifuncTB(FB.RTL.PRINTSHORT)
		case IR.DATATYPE.USHORT
			f = ifuncTB(FB.RTL.PRINTUSHORT)
		case IR.DATATYPE.INTEGER
			f = ifuncTB(FB.RTL.PRINTINT)
		case IR.DATATYPE.UINT
			f = ifuncTB(FB.RTL.PRINTUINT)
		case IR.DATATYPE.LONGINT
			f = ifuncTB(FB.RTL.PRINTLONGINT)
		case IR.DATATYPE.ULONGINT
			f = ifuncTB(FB.RTL.PRINTULONGINT)
		case IR.DATATYPE.SINGLE
			f = ifuncTB(FB.RTL.PRINTSINGLE)
		case IR.DATATYPE.DOUBLE
			f = ifuncTB(FB.RTL.PRINTDOUBLE)
		case IR.DATATYPE.USERDEF
			exit function						'' illegal
		case else
			if( dtype >= IR.DATATYPE.POINTER ) then
				f = ifuncTB(FB.RTL.PRINTUINT)
			end if
		end select

		args = 3
	end if

    ''
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    if( expr <> INVALID ) then
    	'' byval? x as ???
    	if( astNewPARAM( proc, expr, INVALID ) = INVALID ) then
 			exit function
 		end if
    end if

    '' byval mask as integer
	mask = 0
	if( iscomma ) then
		mask = mask or FB.PRINTMASK.PAD
	elseif( not issemicolon ) then
		mask = mask or FB.PRINTMASK.NEWLINE
	end if

	t = astNewCONST( mask, IR.DATATYPE.INTEGER )
    if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
 		exit function
 	end if

    ''
    astFlush proc, vr

    rtlPrint = TRUE

end function

'':::::
function rtlPrintSPC( byval fileexpr as integer, byval expr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlPrintSPC = FALSE

	''
	f = ifuncTB(FB.RTL.PRINTSPC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval n as integer
    if( astNewPARAM( proc, expr, INVALID ) = INVALID ) then
 		exit function
 	end if

    astFlush proc, vr

    rtlPrintSPC = TRUE

end function

'':::::
function rtlPrintTab( byval fileexpr as integer, byval expr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlPrintTab = FALSE

	''
	f = ifuncTB(FB.RTL.PRINTTAB)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval newcol as integer
    if( astNewPARAM( proc, expr, INVALID ) = INVALID ) then
 		exit function
 	end if

    astFlush proc, vr

    rtlPrintTab = TRUE

end function

'':::::
function rtlWrite( byval fileexpr as integer, byval iscomma as integer, byval expr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer, mask as integer, args as integer
    dim vr as integer, dtype as integer

	rtlWrite = FALSE

	if( expr = INVALID ) then
		f = ifuncTB(FB.RTL.WRITEVOID)
		args = 2
	else

		dtype = astGetDataType( expr )
		select case as const dtype
		case IR.DATATYPE.FIXSTR, IR.DATATYPE.STRING
			f = ifuncTB(FB.RTL.WRITESTR)
		case IR.DATATYPE.BYTE
			f = ifuncTB(FB.RTL.WRITEBYTE)
		case IR.DATATYPE.UBYTE
			f = ifuncTB(FB.RTL.WRITEUBYTE)
		case IR.DATATYPE.SHORT
			f = ifuncTB(FB.RTL.WRITESHORT)
		case IR.DATATYPE.USHORT
			f = ifuncTB(FB.RTL.WRITEUSHORT)
		case IR.DATATYPE.INTEGER
			f = ifuncTB(FB.RTL.WRITEINT)
		case IR.DATATYPE.UINT
			f = ifuncTB(FB.RTL.WRITEUINT)
		case IR.DATATYPE.LONGINT
			f = ifuncTB(FB.RTL.WRITELONGINT)
		case IR.DATATYPE.ULONGINT
			f = ifuncTB(FB.RTL.WRITEULONGINT)
		case IR.DATATYPE.SINGLE
			f = ifuncTB(FB.RTL.WRITESINGLE)
		case IR.DATATYPE.DOUBLE
			f = ifuncTB(FB.RTL.WRITEDOUBLE)
		case IR.DATATYPE.USERDEF
			exit function						'' illegal
		case else
			if( dtype >= IR.DATATYPE.POINTER ) then
				f = ifuncTB(FB.RTL.WRITEUINT)
			end if
		end select

		args = 3
	end if

    ''
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    if( expr <> INVALID ) then
    	'' byval? x as ???
    	if( astNewPARAM( proc, expr, INVALID ) = INVALID ) then
 			exit function
 		end if
    end if

    '' byval mask as integer
	mask = 0
	if( iscomma ) then
		mask = mask or FB.PRINTMASK.PAD
	else
		mask = mask or FB.PRINTMASK.NEWLINE
	end if

	t = astNewCONST( mask, IR.DATATYPE.INTEGER )
    if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
 		exit function
 	end if

    ''
    astFlush proc, vr

    rtlWrite = FALSE

end function

'':::::
function rtlPrintUsingInit( byval usingexpr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlPrintUsingInit = FALSE

	''
	f = ifuncTB(FB.RTL.PRINTUSGINIT)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' fmtstr as string
    if( astNewPARAM( proc, usingexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    astFlush proc, vr

    rtlPrintUsingInit = TRUE

end function

'':::::
function rtlPrintUsingEnd( byval fileexpr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlPrintUsingEnd = FALSE

	''
	f = ifuncTB(FB.RTL.PRINTUSGEND)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    astFlush proc, vr

    rtlPrintUsingEnd = TRUE

end function

'':::::
function rtlPrintUsing( byval fileexpr as integer, byval expr as integer, _
						byval issemicolon as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer, mask as integer
    dim vr as integer

	rtlPrintUsing = FALSE

	select case astGetDataType( expr )
	case IR.DATATYPE.FIXSTR, IR.DATATYPE.STRING
		f = ifuncTB(FB.RTL.PRINTUSGSTR)
	case else
		f = ifuncTB(FB.RTL.PRINTUSGVAL)
	end select

    ''
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' s as string or byval v as double
    if( astNewPARAM( proc, expr, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval mask as integer
	mask = 0
	if( not issemicolon ) then
		mask = mask or FB.PRINTMASK.NEWLINE or FB.PRINTMASK.ISLAST
	end if

	t = astNewCONST( mask, IR.DATATYPE.INTEGER )
    if( astNewPARAM( proc, t, IR.DATATYPE.INTEGER ) = INVALID ) then
 		exit function
 	end if

    ''
    astFlush proc, vr

    rtlPrintUsing = TRUE

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlExit( byval errlevel as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlExit = FALSE

	''
	f = ifuncTB(FB.RTL.END)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' errlevel
    if( errlevel = INVALID ) then
    	errlevel = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    if( astNewPARAM( proc, errlevel, INVALID ) = INVALID ) then
    	exit function
    end if

    astFlush proc, vr

    rtlExit = TRUE

end function

'':::::
function rtlMemCopy( byval dst as integer, byval src as integer, byval bytes as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer

	rtlMemCopy = INVALID

	''
	f = ifuncTB(FB.RTL.MEMCOPY)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' dst as any
    if( astNewPARAM( proc, dst, INVALID ) = INVALID ) then
    	exit function
    end if

    '' src as any
    if( astNewPARAM( proc, src, INVALID ) = INVALID ) then
    	exit function
    end if

    '' byval bytes as integer
    t = astNewCONST( bytes, IR.DATATYPE.INTEGER )
    if( astNewPARAM( proc, t, INVALID ) = INVALID ) then
    	exit function
    end if

    ''
    rtlMemCopy = proc

end function

'':::::
function rtlMemSwap( byval dst as integer, byval src as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer, bytes as integer
    dim vr as integer, vs as integer
    dim s as FBSYMBOL ptr, d as FBSYMBOL ptr
    dim dtype as integer, typ as integer

    rtlMemSwap = FALSE

	'' simple type?
	dtype = astGetDataType( dst )
	if( (dtype <> IR.DATATYPE.USERDEF) and (astGetClass( dst ) = AST.NODECLASS.VAR) ) then

		''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
		d = astGetSymbol( dst )
		s = astGetSymbol( src )

		'' push src
		vr = irAllocVRVAR( dtype, s, s->ofs )
		irEmitPUSH vr

		'' src = dst
		vr = irAllocVRVAR( dtype, s, s->ofs )
		vs = irAllocVRVAR( dtype, d, d->ofs )
		irEmitSTORE vr, vs

		'' pop dst
		vr = irAllocVRVAR( dtype, d, d->ofs )
		irEmitPOP vr

		exit sub
	end if

	''
	f = ifuncTB(FB.RTL.MEMSWAP)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' dst as any
    if( astNewPARAM( proc, dst, INVALID ) = INVALID ) then
    	exit function
    end if

    '' src as any
    if( astNewPARAM( proc, src, INVALID ) = INVALID ) then
    	exit function
    end if

    '' byval bytes as integer
	bytes = hCalcExprLen( dst )

    t = astNewCONST( bytes, IR.DATATYPE.INTEGER )
    if( astNewPARAM( proc, t, INVALID ) = INVALID ) then
    	exit function
    end if

    ''
    astFlush proc, vr

    rtlMemSwap = TRUE

end function

'':::::
function rtlStrSwap( byval str1 as integer, byval str2 as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim lgt as integer, s as integer, dtype as integer
    dim vr as integer

	rtlStrSwap = FALSE

	''
	f = ifuncTB(FB.RTL.STRSWAP)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' str1 as any
    if( astNewPARAM( proc, str1, IR.DATATYPE.STRING ) = INVALID ) then
    	exit function
    end if

    '' byval str1len as integer
	dtype = astGetDataType( str1 )
	lgt = -1
	if( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( str1 )
	end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

    '' str2 as any
    if( astNewPARAM( proc, str2, IR.DATATYPE.STRING ) = INVALID ) then
    	exit function
    end if

    '' byval str1len as integer
	dtype = astGetDataType( str2 )
	lgt = -1
	if( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( str2 )
	end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
    	exit function
    end if

    ''
    astFlush proc, vr

    rtlStrSwap = TRUE

end function

'':::::
function rtlConsoleView ( byval topexpr as integer, byval botexpr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlConsoleView = FALSE

	''
	f = ifuncTB(FB.RTL.CONSOLEVIEW)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval toprow as integer
    if( astNewPARAM( proc, topexpr, INVALID ) = INVALID ) then
    	exit function
    end if

    '' byval botrow as integer
    if( astNewPARAM( proc, botexpr, INVALID ) = INVALID ) then
    	exit function
    end if

    astFlush proc, vr

    rtlConsoleView = TRUE

end function

'':::::
function rtlConsoleReadXY ( byval rowexpr as integer, byval columnexpr as integer, byval colorflagexpr as integer )
	dim proc as integer, f as FBSYMBOL ptr

	''
	f = ifuncTB(FB.RTL.CONSOLEREADXY)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

	'' byval column as integer
	astNewPARAM( proc, columnexpr, INVALID )

	'' byval row as integer
	astNewPARAM( proc, rowexpr, INVALID )

	'' byval colorflag as integer
	if( colorflagexpr = INVALID ) then
		colorflagexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )
	end if
	astNewPARAM( proc, colorflagexpr, INVALID)

	rtlConsoleReadXY = proc

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' error
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function rtlCheckError( byval resexpr as integer, byval reslabel as FBSYMBOL ptr ) as integer static
	dim proc as integer, f as FBSYMBOL ptr
	dim nxtlabel as FBSYMBOL ptr
	dim param as integer, dst as integer
	dim vr as integer

	rtlCheckError = FALSE

	if( not env.clopt.errorcheck ) then
		astFlush resexpr, vr
		rtlCheckError = TRUE
		exit function
	end if

	''
	f = ifuncTB(FB.RTL.ERRORTHROW)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

	''
	nxtlabel = symbAddLabel( hMakeTmpStr )

	'' result == FB_RTERROR_OK? skip..
	resexpr = astNewBOP( IR.OP.EQ, resexpr, astNewCONST( 0, IR.DATATYPE.INTEGER ), nxtlabel, FALSE )

	astFlush resexpr, vr

	'' else, fb_ErrorThrow( reslabel, resnxtlabel ); -- CDECL

	'' reslabel
	if( reslabel <> NULL ) then
		param = astNewADDR( IR.OP.ADDROF, astNewVAR( reslabel, NULL, 0, IR.DATATYPE.UINT ) )
	else
		param = astNewCONST( NULL, IR.DATATYPE.UINT )
	end if
	if( astNewPARAM( proc, param ) = INVALID ) then
		exit function
	end if

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDR( IR.OP.ADDROF, astNewVAR( nxtlabel, NULL, 0, IR.DATATYPE.UINT ) )
	else
		param = astNewCONST( NULL, IR.DATATYPE.UINT )
	end if
	if( astNewPARAM( proc, param ) = INVALID ) then
		exit function
	end if

    '' dst
    dst = astNewBRANCH( IR.OP.JUMPPTR, NULL, proc )

    astFlush dst, vr

	''
	irEmitLABEL nxtlabel, FALSE

	'''''symbDelLabel nxtlabel
	'''''symbDelLabel reslabel

	rtlCheckError = TRUE

end function

'':::::
sub rtlErrorThrow( byval errexpr as integer ) static
	dim proc as integer, f as FBSYMBOL ptr
	dim nxtlabel as FBSYMBOL ptr, reslabel as FBSYMBOL ptr
	dim param as integer, dst as integer
	dim vr as integer

	''
	f = ifuncTB(FB.RTL.ERRORTHROWEX)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

	''
    reslabel = symbAddLabel( hMakeTmpStr )
    irEmitLABEL reslabel, FALSE

	nxtlabel = symbAddLabel( hMakeTmpStr )

	'' fb_ErrorThrowEx( errnum, reslabel, resnxtlabel ); -- CDECL

	'' errnum
	if( astNewPARAM( proc, errexpr ) = INVALID ) then
		exit sub
	end if

	'' reslabel
	if( env.clopt.resumeerr ) then
		param = astNewADDR( IR.OP.ADDROF, astNewVAR( reslabel, NULL, 0, IR.DATATYPE.UINT ) )
	else
		param = astNewCONST( NULL, IR.DATATYPE.UINT )
	end if
	if( astNewPARAM( proc, param ) = INVALID ) then
		exit function
	end if

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDR( IR.OP.ADDROF, astNewVAR( nxtlabel, NULL, 0, IR.DATATYPE.UINT ) )
	else
		param = astNewCONST( NULL, IR.DATATYPE.UINT )
	end if
	if( astNewPARAM( proc, param ) = INVALID ) then
		exit function
	end if

    '' dst
    dst = astNewBRANCH( IR.OP.JUMPPTR, NULL, proc )

    astFlush dst, vr

	''
	irEmitLABEL nxtlabel, FALSE

	'''''symbDelLabel nxtlabel
	'''''symbDelLabel reslabel

end sub

'':::::
sub rtlErrorSetHandler( byval newhandler as integer, byval savecurrent as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim v as integer, vr as integer

	''
	f = ifuncTB(FB.RTL.ERRORSETHANDLER)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval newhandler as uint
    astNewPARAM( proc, newhandler, INVALID )

    ''
    v = INVALID
    if( savecurrent ) then
    	if( env.scope > 0 ) then
    		if( env.procerrorhnd = NULL ) then
				env.procerrorhnd = symbAddTempVar( IR.DATATYPE.UINT )
                v = astNewVAR( env.procerrorhnd, NULL, 0, IR.DATATYPE.UINT )
                astFlush astNewASSIGN( v, proc ), vr
    		end if
		end if
    end if

    if( v = INVALID ) then
    	astFlush proc, vr
    end if

end sub

'':::::
function rtlErrorGetNum as integer static
    dim proc as integer, f as FBSYMBOL ptr


	''
	f = ifuncTB(FB.RTL.ERRORGETNUM)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
    rtlErrorGetNum = proc

end function

'':::::
sub rtlErrorSetNum( byval errexpr as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.ERRORSETNUM)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval errnum as integer
    astNewPARAM( proc, errexpr, INVALID )

    ''
    astFlush proc, vr

end sub

'':::::
sub rtlErrorResume( byval isnext as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer
    dim dst as integer

	''
	if( not isnext ) then
		f = ifuncTB(FB.RTL.ERRORRESUME)
	else
		f = ifuncTB(FB.RTL.ERRORRESUMENEXT)
	end if

	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    ''
    dst = astNewBRANCH( IR.OP.JUMPPTR, NULL, proc )

    astFlush dst, vr

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' file
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function rtlFileOpen( byval filename as integer, byval fmode as integer, byval faccess as integer, _
				      byval flock, byval filenum as integer, byval flen as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim reslabel as FBSYMBOL ptr

	rtlFileOpen = FALSE

	''
	f = ifuncTB(FB.RTL.FILEOPEN)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' filename as string
    if( astNewPARAM( proc, filename, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval mode as integer
    if( astNewPARAM( proc, fmode, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval access as integer
    if( astNewPARAM( proc, faccess, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval lock as integer
    if( astNewPARAM( proc, flock, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval len as integer
    if( astNewPARAM( proc, flen, INVALID ) = INVALID ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    rtlFileOpen = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlFileClose( byval filenum as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim reslabel as FBSYMBOL ptr

	rtlFileClose = FALSE

	''
	f = ifuncTB(FB.RTL.FILECLOSE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    rtlFileClose = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlFileSeek( byval filenum as integer, byval newpos as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim reslabel as FBSYMBOL ptr

	rtlFileSeek = FALSE

	''
	f = ifuncTB(FB.RTL.FILESEEK)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval newpos as integer
    if( astNewPARAM( proc, newpos, INVALID ) = INVALID ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    rtlFileSeek = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlFileTell( byval filenum as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

    rtlFileTell = INVALID

	''
	f = ifuncTB(FB.RTL.FILETELL)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    ''
    rtlFileTell = proc

end function

'':::::
function rtlFilePut( byval filenum as integer, byval offset as integer, _
					 byval src as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, args as integer, lgt as integer
    dim reslabel as FBSYMBOL ptr

    rtlFilePut = FALSE

	''
	dtype = astGetDataType( src )
	if( hIsString( dtype ) ) then
		f = ifuncTB(FB.RTL.FILEPUTSTR)
		args = 3
	else
		f = ifuncTB(FB.RTL.FILEPUT)
		args = 4
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = INVALID ) then
    	offset = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    if( astNewPARAM( proc, offset, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' value as any | s as string
    if( astNewPARAM( proc, src, INVALID ) = INVALID ) then
 		exit function
 	end if

    if( args = 4 ) then
    	'' byval valuelen as integer
    	lgt = hCalcExprLen( src )
    	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
    	if( astNewPARAM( proc, lgt, INVALID ) = INVALID ) then
 			exit function
 		end if
    end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    rtlFilePut = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlFilePutArray( byval filenum as integer, byval offset as integer, _
						  byval src as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer
    dim reslabel as FBSYMBOL ptr

    rtlFilePutArray = FALSE

	''
	f = ifuncTB(FB.RTL.FILEPUTARRAY)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = INVALID ) then
    	offset = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    if( astNewPARAM( proc, offset, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' array() as any
    if( astNewPARAM( proc, src, INVALID ) = INVALID ) then
    	exit function
    end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    rtlFilePutArray = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlFileGet( byval filenum as integer, byval offset as integer, _
					 byval dst as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, args as integer, lgt as integer
    dim reslabel as FBSYMBOL ptr

    rtlFileGet = FALSE

	''
	dtype = astGetDataType( dst )
	if( hIsString( dtype ) ) then
		f = ifuncTB(FB.RTL.FILEGETSTR)
		args = 3
	else
		f = ifuncTB(FB.RTL.FILEGET)
		args = 4
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = INVALID ) then
    	offset = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    if( astNewPARAM( proc, offset, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' value as any | s as string
    if( astNewPARAM( proc, dst, INVALID ) = INVALID ) then
 		exit function
 	end if

    if( args = 4 ) then
    	'' byval valuelen as integer
    	lgt = hCalcExprLen( dst )
    	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
    	if( astNewPARAM( proc, lgt, INVALID ) = INVALID ) then
 			exit function
 		end if
    end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    rtlFileGet = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlFileGetArray( byval filenum as integer, byval offset as integer, _
						  byval dst as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer
    dim reslabel as FBSYMBOL ptr

	rtlFileGetArray = FALSE

	''
	f = ifuncTB(FB.RTL.FILEGETARRAY)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = INVALID ) then
    	offset = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    if( astNewPARAM( proc, offset, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' array() as any
    if( astNewPARAM( proc, dst, INVALID ) = INVALID ) then
    	exit function
    end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    rtlFileGetArray = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlFileStrInput( byval bytesexpr as integer, byval filenum as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr

    rtlFileStrInput = INVALID

	''
	f = ifuncTB(FB.RTL.FILESTRINPUT)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval bytes as integer
    if( astNewPARAM( proc, bytesexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    ''
    rtlFileStrInput = proc

end function

'':::::
function rtlFileLineInput( byval isfile as integer, byval expr as integer, byval dstexpr as integer, _
					       byval addquestion as integer, byval addnewline as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr, args as integer
    dim vr as integer
	dim lgt as integer

	rtlFileLineInput = FALSE

	''
	if( isfile ) then
		f = ifuncTB(FB.RTL.FILELINEINPUT)
		args = 3
	else
		f = ifuncTB(FB.RTL.CONSOLELINEINPUT)
		args = 5
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' "byval filenum as integer" or "text as string "
    if( (not isfile) and (expr = INVALID) ) then
		expr = astNewVAR( hAllocStringConst( "", 0 ), NULL, 0, IR.DATATYPE.FIXSTR )
	end if

    if( astNewPARAM( proc, expr, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' dst as any
    if( astNewPARAM( proc, dstexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

	'' byval dstlen as integer
	lgt = -1
	if( hIsStrFixed( astGetDataType( dstexpr ) ) ) then
		lgt = hGetFixStrLen( dstexpr )
	end if
	if( astNewPARAM( proc, astNewCONST( lgt, IR.DATATYPE.INTEGER ), IR.DATATYPE.INTEGER ) = INVALID ) then
 		exit function
 	end if

    if( args = 5 ) then
    	'' byval addquestion as integer
 		if( astNewPARAM( proc, astNewCONST( addquestion, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 			exit function
 		end if

    	'' byval addnewline as integer
    	if( astNewPARAM( proc, astNewCONST( addnewline, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 			exit function
 		end if
    end if

    astFlush proc, vr

    rtlFileLineInput = TRUE

end function

'':::::
function rtlFileInput( byval isfile as integer, byval expr as integer, _
				       byval addquestion as integer, byval addnewline as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr, args as integer
    dim vr as integer

	rtlFileInput = FALSE

	''
	if( isfile ) then
		f = ifuncTB(FB.RTL.FILEINPUT)
		args = 1
	else
		f = ifuncTB(FB.RTL.CONSOLEINPUT)
		args = 3
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' "byval filenum as integer" or "text as string "
    if( (not isfile) and (expr = INVALID) ) then
		expr = astNewVAR( hAllocStringConst( "", 0 ), NULL, 0, IR.DATATYPE.FIXSTR )
	end if

	if( astNewPARAM( proc, expr, INVALID ) = INVALID ) then
 		exit function
 	end if

    if( args = 3 ) then
    	'' byval addquestion as integer
    	if( astNewPARAM( proc, astNewCONST( addquestion, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 			exit function
 		end if

    	'' byval addnewline as integer
    	if( astNewPARAM( proc, astNewCONST( addnewline, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 			exit function
 		end if
    end if

    astFlush proc, vr

    rtlFileInput = TRUE

end function

'':::::
function rtlFileInputGet( byval dstexpr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr, args as integer
    dim vr as integer, lgt as integer

	rtlFileInputGet = FALSE

	''
	args = 1
	select case astGetDataType( dstexpr )
	case IR.DATATYPE.FIXSTR, IR.DATATYPE.STRING
		f = ifuncTB(FB.RTL.INPUTSTR)
		args = 2
	case IR.DATATYPE.BYTE, IR.DATATYPE.UBYTE
		f = ifuncTB(FB.RTL.INPUTBYTE)
	case IR.DATATYPE.SHORT, IR.DATATYPE.USHORT
		f = ifuncTB(FB.RTL.INPUTSHORT)
	case IR.DATATYPE.INTEGER, IR.DATATYPE.UINT, is >= IR.DATATYPE.POINTER
		f = ifuncTB(FB.RTL.INPUTINT)
	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		f = ifuncTB(FB.RTL.INPUTLONGINT)
	case IR.DATATYPE.SINGLE
		f = ifuncTB(FB.RTL.INPUTSINGLE)
	case IR.DATATYPE.DOUBLE
		f = ifuncTB(FB.RTL.INPUTDOUBLE)
	case IR.DATATYPE.USERDEF
		exit function							'' illegal
	end select

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' dst as any
    if( astNewPARAM( proc, dstexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    if( args > 1 ) then
		lgt = -1
		if( hIsStrFixed( astGetDataType( dstexpr ) ) ) then
			lgt = hGetFixStrLen( dstexpr )
		end if
		lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
		if( astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER ) = INVALID ) then
 			exit function
 		end if
    end if

    astFlush proc, vr

    rtlFileInputGet = TRUE

end function

'':::::
function rtlFileLock( byval islock as integer, byval filenum as integer, _
					  byval iniexpr as integer, byval endexpr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlFileLock = FALSE

	''
	if( islock ) then
		f = ifuncTB(FB.RTL.FILELOCK)
	else
		f = ifuncTB(FB.RTL.FILEUNLOCK)
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, filenum, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval inipos as integer
    if( astNewPARAM( proc, iniexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval endpos as integer
    if( astNewPARAM( proc, endexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    astFlush proc, vr

    rtlFileLock = TRUE

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' gfx
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#ifdef AUTOADDGFXLIBS
private sub hAddGfxLibs
	symbAddLib( "fbgfx" )
#ifdef TARGET_WIN32
	symbAddLib( "user32" )
	symbAddLib( "gdi32" )
#elseif defined(TARGET_LINUX)
	fbAddLibPath( "/usr/X11R6/lib" )
	symbAddLib( "X11" )
	symbAddLib( "Xext" )
	symbAddLib( "Xpm" )
	symbAddLib( "Xxf86vm" )
	symbAddLib( "pthread" )
#endif
end sub
#endif

'':::::
function rtlGfxPset( byval target as integer, byval targetisptr as integer, _
					 byval xexpr as integer, byval yexpr as integer, byval cexpr as integer, _
					 byval coordtype as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer, targetmode as integer

	rtlGfxPset = FALSE

	f = ifuncTB(FB.RTL.GFXPSET)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byref target as any
 	if( target = INVALID ) then
 		target = astNewCONST( 0, IR.DATATYPE.INTEGER )
 		targetmode = INVALID
 	else
		if( targetisptr ) then
			targetmode = FB.ARGMODE.BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = INVALID ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval color as uinteger
 	if( astNewPARAM( proc, cexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxPset = TRUE

end function

'':::::
function rtlGfxPoint( byval target as integer, byval targetisptr as integer, byval xexpr as integer, byval yexpr as integer )
	dim proc as integer, f as FBSYMBOL ptr
	dim vr as integer, targetmode as integer

	rtlGfxPoint = FALSE

	f = ifuncTB(FB.RTL.GFXPOINT)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

	'' byref target as any
	if( target = INVALID ) then
 		target = astNewCONST( 0, IR.DATATYPE.INTEGER )
 		targetmode = INVALID
 	else
		if( targetisptr ) then
			targetmode = FB.ARGMODE.BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = INVALID ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y as single
 	if( yexpr = INVALID ) then
 		yexpr = astNewCONST( -1, IR.DATATYPE.SINGLE )
 	end if
 	if( astNewPARAM( proc, yexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

	rtlGfxPoint = proc

end function

'':::::
function rtlGfxLine( byval target as integer, byval targetisptr as integer, _
					 byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, _
					 byval y2expr as integer, byval cexpr as integer, byval linetype as integer, _
					 byval styleexpr as integer, byval coordtype as integer ) as integer

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer, targetmode as integer

	rtlGfxLine = FALSE

	f = ifuncTB(FB.RTL.GFXLINE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byref target as any
 	if( target = INVALID ) then
 		target = astNewCONST( 0, IR.DATATYPE.INTEGER )
 		targetmode = INVALID
 	else
		if( targetisptr ) then
			targetmode = FB.ARGMODE.BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = INVALID ) then
 		exit function
 	end if

 	'' byval x1 as single
 	if( astNewPARAM( proc, x1expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y1 as single
 	if( astNewPARAM( proc, y1expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval x2 as single
 	if( astNewPARAM( proc, x2expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y2 as single
 	if( astNewPARAM( proc, y2expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval color as uinteger
 	if( astNewPARAM( proc, cexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval linetype as integer
 	if( astNewPARAM( proc, astNewCONST( linetype, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval style as uinteger
 	if( styleexpr = INVALID ) then
 		styleexpr = astNewCONST( &h0000FFFF, IR.DATATYPE.UINT )
 	end if
 	if( astNewPARAM( proc, styleexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxLine = TRUE

end function

'':::::
function rtlGfxCircle( byval target as integer, byval targetisptr as integer, _
					   byval xexpr as integer, byval yexpr as integer, byval radexpr as integer, _
					   byval cexpr as integer, byval aspexpr as integer, byval iniexpr as integer, _
					   byval endexpr as integer, byval fillflag as integer, byval coordtype as integer ) as integer

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer, targetmode as integer

	rtlGfxCircle = FALSE

	f = ifuncTB(FB.RTL.GFXCIRCLE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byref target as any
 	if( target = INVALID ) then
 		target = astNewCONST( 0, IR.DATATYPE.INTEGER )
 		targetmode = INVALID
 	else
		if( targetisptr ) then
			targetmode = FB.ARGMODE.BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = INVALID ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval radians as single
 	if( astNewPARAM( proc, radexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval color as uinteger
 	if( astNewPARAM( proc, cexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval aspect as single
 	if( aspexpr = INVALID ) then
 		aspexpr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
 	end if
 	if( astNewPARAM( proc, aspexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval arcini as single
 	if( iniexpr = INVALID ) then
 		iniexpr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
 	end if
 	if( astNewPARAM( proc, iniexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval arcend as single
 	if( endexpr = INVALID ) then
 		endexpr = astNewCONST( 3.141593*2, IR.DATATYPE.SINGLE )
 	end if
 	if( astNewPARAM( proc, endexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval fillflag as integer
 	if( astNewPARAM( proc, astNewCONST( fillflag, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxCircle = TRUE

end function

'':::::
function rtlGfxPaint( byval target as integer, byval targetisptr as integer, _
					  byval xexpr as integer, byval yexpr as integer, byval pexpr as integer, _
					  byval bexpr as integer, byval coord_type as integer ) as integer

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer, targetmode as integer
    dim pattern as integer

    rtlGfxPaint = FALSE

	f = ifuncTB(FB.RTL.GFXPAINT)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byref target as any
 	if( target = INVALID ) then
 		target = astNewCONST( 0, IR.DATATYPE.INTEGER )
 		targetmode = INVALID
 	else
		if( targetisptr ) then
			targetmode = FB.ARGMODE.BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = INVALID ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

	'' byval color as uinteger
	pattern = astGetDataType( pexpr )
	if( ( pattern = IR.DATATYPE.FIXSTR ) or ( pattern = IR.DATATYPE.STRING ) ) then
		pattern = TRUE
		if( astNewPARAM( proc, astNewCONST( &hFFFF0000, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 			exit function
 		end if
	else
		pattern = FALSE
		if( astNewPARAM( proc, pexpr ) = INVALID ) then
 			exit function
 		end if
	end if

	'' byval border_color as uinteger
	if( astNewPARAM( proc, bexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

	'' pattern as string, byval mode as integer
	if( pattern = TRUE ) then
		if( astNewPARAM( proc, pexpr, INVALID ) = INVALID ) then
 			exit function
 		end if
		if( astNewPARAM( proc, astNewCONST( 1, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 			exit function
 		end if
	else
    	if( astNewPARAM( proc, astNewVAR( hAllocStringConst( "", 0 ), NULL, 0, IR.DATATYPE.FIXSTR ), INVALID ) = INVALID ) then
 			exit function
 		end if
		if( astNewPARAM( proc, astNewCONST( 0, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 			exit function
 		end if
	end if

	'' byval coord_type as integer
	if( astNewPARAM( proc, astNewCONST( coord_type, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxPaint = TRUE

end function

'':::::
function rtlGfxDraw( byval target as integer, byval targetisptr as integer, byval cexpr as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer, targetmode as integer

	rtlGfxDraw = FALSE

	f = ifuncTB(FB.RTL.GFXDRAW)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byref target as any
 	if( target = INVALID ) then
 		target = astNewCONST( 0, IR.DATATYPE.INTEGER )
 		targetmode = INVALID
 	else
		if( targetisptr ) then
			targetmode = FB.ARGMODE.BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = INVALID ) then
 		exit function
 	end if

 	'' cmd as string
 	if( astNewPARAM( proc, cexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxDraw = TRUE

end function

'':::::
function rtlGfxView( byval x1expr as integer, byval y1expr as integer, _
					 byval x2expr as integer, byval y2expr as integer, _
			    	 byval fillexpr as integer, byval bordexpr as integer, _
			    	 byval screenflag as integer ) as integer

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlGfxView = FALSE

	f = ifuncTB(FB.RTL.GFXVIEW)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byval x1 as integer
 	if( x1expr = INVALID ) then
        x1expr = astNewCONST( -32768, IR.DATATYPE.INTEGER )
    end if
 	if( astNewPARAM( proc, x1expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y1 as integer
 	if( y1expr = INVALID ) then
        y1expr = astNewCONST( -32768, IR.DATATYPE.INTEGER )
    end if
 	if( astNewPARAM( proc, y1expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval x2 as integer
 	if( x2expr = INVALID ) then
        x2expr = astNewCONST( -32768, IR.DATATYPE.INTEGER )
    end if
 	if( astNewPARAM( proc, x2expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y2 as integer
 	if( y2expr = INVALID ) then
        y2expr = astNewCONST( -32768, IR.DATATYPE.INTEGER )
    end if
 	if( astNewPARAM( proc, y2expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval fillcolor as uinteger
 	if( fillexpr = INVALID ) then
 		fillexpr = astNewCONST( &hffff0000, IR.DATATYPE.UINT )
 	end if
 	if( astNewPARAM( proc, fillexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval bordercolor as uinteger
 	if( bordexpr = INVALID ) then
 		bordexpr = astNewCONST( &hffff0000, IR.DATATYPE.UINT )
 	end if
 	if( astNewPARAM( proc, bordexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval screenflag as integer
 	if( astNewPARAM( proc, astNewCONST( screenflag, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxView = TRUE

end function

'':::::
function rtlGfxWindow( byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, _
					   byval y2expr as integer, byval screenflag as integer ) as integer

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlGfxWindow = FALSE

	f = ifuncTB(FB.RTL.GFXWINDOW)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byval x1 as single
 	if( x1expr = INVALID ) then
        x1expr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
    end if
 	if( astNewPARAM( proc, x1expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y1 as single
 	if( y1expr = INVALID ) then
        y1expr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
    end if
 	if( astNewPARAM( proc, y1expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval x2 as single
 	if( x2expr = INVALID ) then
        x2expr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
    end if
 	if( astNewPARAM( proc, x2expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y2 as single
 	if( y2expr = INVALID ) then
        y2expr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
    end if
 	if( astNewPARAM( proc, y2expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval screenflag as integer
 	if( astNewPARAM( proc, astNewCONST( screenflag, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxWindow = TRUE

end function

'':::::
function rtlGfxPalette ( byval attexpr as integer, byval rexpr as integer, _
						 byval gexpr as integer, byval bexpr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlGfxPalette = FALSE

    f = ifuncTB(FB.RTL.GFXPALETTE)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byval attr as integer
 	if( attexpr = INVALID ) then
        attexpr = astNewCONST( -1, IR.DATATYPE.INTEGER )
    end if
 	if( astNewPARAM( proc, attexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval r as integer
 	if( rexpr = INVALID ) then
        rexpr = astNewCONST( -1, IR.DATATYPE.INTEGER )
    end if
 	if( astNewPARAM( proc, rexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval g as integer
 	if( gexpr = INVALID ) then
        gexpr = astNewCONST( -1, IR.DATATYPE.INTEGER )
    end if
 	if( astNewPARAM( proc, gexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval b as integer
 	if( bexpr = INVALID ) then
        bexpr = astNewCONST( -1, IR.DATATYPE.INTEGER )
    end if
 	if( astNewPARAM( proc, bexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxPalette = TRUE

end function

'':::::
function rtlGfxPaletteUsing ( byval arrayexpr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	rtlGfxPaletteUsing = FALSE

    f = ifuncTB(FB.RTL.GFXPALETTEUSING)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byref array as integer
 	if( astNewPARAM( proc, arrayexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxPaletteUsing = TRUE

end function

'':::::
function rtlGfxPut( byval target as integer, byval targetisptr as integer, _
					byval xexpr as integer, byval yexpr as integer, _
			   		byval arrayexpr as integer, byval isptr as integer, _
			   		byval mode as integer, byval coordtype as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer, targetmode as integer
    dim argmode as integer

    rtlGfxPut = FALSE

	f = ifuncTB(FB.RTL.GFXPUT)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byref target as any
 	if( target = INVALID ) then
 		target = astNewCONST( 0, IR.DATATYPE.INTEGER )
 		targetmode = INVALID
 	else
		if( targetisptr ) then
			targetmode = FB.ARGMODE.BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = INVALID ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byref array as any
	if( isptr ) then
		argmode = FB.ARGMODE.BYVAL
	else
		argmode = INVALID
	end if
 	if( astNewPARAM( proc, arrayexpr, INVALID, argmode ) = INVALID ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval mode as integer
 	if( astNewPARAM( proc, astNewCONST( mode, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxPut = TRUE

end function

'':::::
function rtlGfxGet( byval target as integer, byval targetisptr as integer, _
					byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, byval y2expr as integer, _
			   		byval arrayexpr as integer, byval isptr as integer, byval symbol as FBSYMBOL ptr, _
			   		byval coordtype as integer ) as integer

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer, targetmode as integer
    dim argmode as integer
    dim reslabel as FBSYMBOL ptr

    rtlGfxGet = FALSE

	f = ifuncTB(FB.RTL.GFXGET)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byref target as any
 	if( target = INVALID ) then
 		target = astNewCONST( 0, IR.DATATYPE.INTEGER )
 		targetmode = INVALID
 	else
		if( targetisptr ) then
			targetmode = FB.ARGMODE.BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = INVALID ) then
 		exit function
 	end if

 	'' byval x1 as single
 	if( astNewPARAM( proc, x1expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y1 as single
 	if( astNewPARAM( proc, y1expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval x2 as single
 	if( astNewPARAM( proc, x2expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval y2 as single
 	if( astNewPARAM( proc, y2expr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byref array as any
	if( isptr ) then
		argmode = FB.ARGMODE.BYVAL
	else
		argmode = INVALID
	end if
 	if( astNewPARAM( proc, arrayexpr, INVALID, argmode ) = INVALID ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' array() as any
 	if( not isptr ) then
 		arrayexpr = astNewVAR( symbol, NULL, 0, symbGetType( symbol ) )
 	else
 		arrayexpr = astNewCONST( NULL, IR.DATATYPE.UINT )
 	end if
 	if( astNewPARAM( proc, arrayexpr, INVALID, argmode ) = INVALID ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxGet = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlGfxScreenSet( byval wexpr as integer, byval hexpr as integer, byval dexpr as integer, _
						  byval pexpr as integer, byval fexpr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim reslabel as FBSYMBOL ptr

	rtlGfxScreenSet = FALSE

	f = ifuncTB( iif( hexpr = INVALID, FB.RTL.GFXSCREENSET, FB.RTL.GFXSCREENRES ) )
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

 	'' byval m as integer
 	if( astNewPARAM( proc, wexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

	if( hexpr <> INVALID) then
		if (astNewPARAM( proc, hexpr, INVALID ) = INVALID ) then
			exit function
		end if
	end if

 	'' byval d as integer
 	if( dexpr = INVALID ) then
 		dexpr = astNewCONST( 8, IR.DATATYPE.INTEGER )
 	end if
 	if( astNewPARAM( proc, dexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval depth as integer
 	if( pexpr = INVALID ) then
 		pexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )
 	end if
 	if( astNewPARAM( proc, pexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

 	'' byval fullscreen s integer
 	if( fexpr = INVALID ) then
 		fexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )
 	end if
 	if( astNewPARAM( proc, fexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxScreenSet = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlGfxBload( byval filename as integer, byval dexpr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim reslabel as FBSYMBOL ptr

    rtlGfxBload = FALSE

	''
	f = ifuncTB(FB.RTL.GFXBLOAD)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' filename as string
    if( astNewPARAM( proc, filename, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval dexpr as integer
    if( dexpr = INVALID ) then
    	dexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    if( astNewPARAM( proc, dexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

    ''
	rtlGfxBload = rtlCheckError( proc, reslabel )

end function

'':::::
function rtlGfxBsave( byval filename as integer, byval sexpr as integer, byval lexpr as integer ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim reslabel as FBSYMBOL ptr

	rtlGfxBsave = FALSE

	''
	f = ifuncTB(FB.RTL.GFXBSAVE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ) )

    '' filename as string
    if( astNewPARAM( proc, filename, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval sexpr as integer
    if( astNewPARAM( proc, sexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    '' byval lexpr as integer
    if( astNewPARAM( proc, lexpr, INVALID ) = INVALID ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

	rtlGfxBsave = rtlCheckError( proc, reslabel )

end function
