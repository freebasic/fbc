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

'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\emit.bi'

#define AUTOADDGFXLIBS

type RTLCTX
	datainited		as integer
	lastlabel		as FBSYMBOL ptr
    labelcnt 		as integer
end type


''globals
	dim shared ctx as RTLCTX

	redim shared ifuncTB( 0 ) as FBSYMBOL ptr

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

'' fb_ArrayRedim CDECL ( array() as ANY, byval elementlen as integer, _
''					     byval isvarlen as integer, byval preserve as integer, _
''						 byval dimensions as integer, ... ) as void
data "fb_ArrayRedim","", FB.SYMBTYPE.VOID,FB.FUNCMODE.CDECL, 6, _
						 FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						 -1,-1, FALSE
'' fb_ArrayErase ( array() as ANY, byval isvarlen as integer ) as void
data "fb_ArrayErase","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						 FB.SYMBTYPE.VOID,FB.ARGMODE.BYDESC, FALSE, _
						 FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_ArrayClear ( array() as ANY, byval isvarlen as integer ) as void
data "fb_ArrayClear","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
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
						   -1,-1, FALSE
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
						         -1,-1, FALSE
'' fb_ArrayFreeTempDesc ( byval pdesc as any ptr) as void
data "fb_ArrayFreeTempDesc","", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						        FB.SYMBTYPE.POINTER+FB.SYMBTYPE.VOID,FB.ARGMODE.BYVAL, FALSE

''
'' fb_IntToStr ( byval number as integer ) as string
data "fb_IntToStr","", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
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

'' fb_FileLineInput ( byval filenum as integer, dst as string ) as integer
data "fb_FileLineInput", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 2, _
						     FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						     FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
'' fb_LineInput ( text as string, dst as string, byval addquestion as integer, _
''				  byval addnewline as integer ) as integer
data "fb_LineInput", "", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 4, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
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
'' fb_ErrorThrow cdecl( byval errnum as integer, byval reslabel as any ptr, _
''                      byval resnxtlabel as any ptr ) as any ptr
data "fb_ErrorThrow","", FB.SYMBTYPE.UINT,FB.FUNCMODE.CDECL, 3, _
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
'' fb_GfxPset ( byval x as single, byval y as single, byval color as uinteger, byval coordType as integer)
data "fb_GfxPset", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 4, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxLine ( byval x1 as single = 0, byval y1 as single = 0, byval x2 as single = 0, byval y2 as single = 0, _
''              byval color as uinteger = DEFAULT_COLOR, byval line_type as integer = LINE_TYPE_LINE, _
''              byval style as uinteger = &hFFFF, byval coordType as integer = COORD_TYPE_AA ) as integer
data "fb_GfxLine", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 8, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					   FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxEllipse ( byval x as single, byval y as single, byval radius as single, _
''				   byval color as uinteger = DEFAULT_COLOR, byval aspect as single = 0.0, _
''				   byval iniarc as single = 0.0, byval endarc as single = 6.283185, _
''				   byval FillFlag as integer = 0, byval CoordType as integer = COORD_TYPE_A ) as integer
data "fb_GfxEllipse", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 9, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					      FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxPaint ( byval x as single, byval y as single, byval color as uinteger = DEFAULT_COLOR, _
''				 byval border_color as uinteger = DEFAULT_COLOR, pattern as string, _
''				 byval mode as integer = PAINT_TYPE_FILL, byval coord_type as integer = COORD_TYPE_A ) as integer
data "fb_GfxPaint", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 7, _
						FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
						FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

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

'' fb_GfxPalette( byval attribute as uinteger = -1, byval color as uinteger = -1 ) as integer
data "fb_GfxPalette", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 2, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, TRUE,-1

'' fb_GfxPaletteUsing ( array as integer ) as void
data "fb_GfxPaletteUsing", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						       FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYREF, FALSE

'' fb_GfxPut ( byval x as single, byval y as single, byref array as any, _
''			   byval coordType as integer, byval mode as integer )  as void
data "fb_GfxPut", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 5, _
					  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.VOID,FB.ARGMODE.BYREF, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE, _
					  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxGet ( byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, _
''			   byref array as any, byval coordType as integer, array() as any ) as void
data "fb_GfxGet", "", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 7, _
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

'' fb_GfxRgb ( byval r as ubyte, byval g as ubyte, byval b as ubyte ) as uinteger
data "rgb", "fb_GfxRgb", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 3, _
						 FB.SYMBTYPE.UBYTE,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.UBYTE,FB.ARGMODE.BYVAL, FALSE, _
						 FB.SYMBTYPE.UBYTE,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxPoint ( byval x as single, byval y as single ) as uinteger
data "point", "fb_GfxPoint", FB.SYMBTYPE.UINT,FB.FUNCMODE.STDCALL, 2, _
						     FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, FALSE, _
						     FB.SYMBTYPE.SINGLE,FB.ARGMODE.BYVAL, TRUE,-1

'' fb_GfxCursor ( number as integer) as single
data "pointcoord", "fb_GfxCursor", FB.SYMBTYPE.SINGLE,FB.FUNCMODE.STDCALL, 1, _
						           FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE

'' fb_GfxDraw ( cmd as string ) as void
data "draw", "fb_GfxDraw", FB.SYMBTYPE.VOID,FB.FUNCMODE.STDCALL, 1, _
						   FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

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


'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' fb_FileFree ( ) as integer
data "freefile", "fb_FileFree", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 0
'' fb_FileEof ( byval filenum as integer ) as integer
data "eof", "fb_FileEof", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
						  FB.SYMBTYPE.INTEGER,FB.ARGMODE.BYVAL, FALSE
'' fb_FileKill ( s as string ) as integer
data "kill", "fb_FileKill", FB.SYMBTYPE.INTEGER,FB.FUNCMODE.STDCALL, 1, _
							FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' fb_CHR ( byval number as uinteger ) as string
data "chr","fb_CHR", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.UINT,FB.ARGMODE.BYVAL, FALSE
'' fb_ASC ( str as string ) as uinteger
data "asc","fb_ASC", FB.SYMBTYPE.UINT,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE

'' fb_CVD ( str as string ) as double
data "cvd","fb_CVD", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.STDCALL, 1, _
					 FB.SYMBTYPE.STRING,FB.ARGMODE.BYREF, FALSE
data "cvs","fb_CVD", FB.SYMBTYPE.DOUBLE,FB.FUNCMODE.STDCALL, 1, _
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

'' command ( ) as string
data "command","fb_Command", FB.SYMBTYPE.STRING,FB.FUNCMODE.STDCALL, 0
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

'':::::
sub rtlInit static
	dim i as integer, a as integer
	dim p as integer, pname as string, aname as string
	dim args as integer, typ as integer, mode as integer
	dim argv(0 to FB_MAXPROCARGS-1) as FBPROCARG

    ''
	fbAddDefaultLibs

	''
	redim ifuncTB( 0 to FB.RTL.MAXFUNCTIONS-1 ) as FBSYMBOL ptr

	restore ifuncdata
	i = 0
	do
		read pname
		if( len( pname ) = 0 ) then
			exit do
		end if
		read aname
		read typ
		read mode
		read args
		for a = 0 to args-1
			read argv(a).typ
			read argv(a).mode
			read argv(a).optional

			if( argv(a).optional ) then
				read argv(a).defvalue
			end if

			argv(a).nameidx = INVALID
			if( argv(a).typ <> INVALID ) then
				argv(a).lgt	= symbCalcArgLen( argv(a).typ, NULL, argv(a).mode )
			else
				argv(a).lgt	= FB.POINTERSIZE
			end if
		next a

		ifuncTB(i) = symbAddPrototype( pname, aname, "fb", typ, NULL, 0, mode, args, argv(), TRUE )
		i = i + 1
	loop

	''
	ctx.datainited	= FALSE
	ctx.lastlabel	= NULL
    ctx.labelcnt 	= 0

end sub

'':::::
sub rtlEnd

	'' procs will be deleted when symbEnd is called

	erase ifuncTB

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' strings
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function hGetFixStrLen( byval expr as integer ) as integer
	dim s as FBSYMBOL ptr, e as FBSYMBOL ptr

	e = astGetUDTElm( expr )
	if( e <> NULL ) then
		hGetFixStrLen = symbGetLen( e ) - 1
	else
		s = astGetSymbol( expr )
		hGetFixStrLen = symbGetLen( s ) - 1
	end if

end function


'':::::
function rtlStrCompare ( byval str1 as integer, byval sdtype1 as integer, _
					     byval str2 as integer, byval sdtype2 as integer ) as integer static
    dim lgt as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim str1len as integer, str2len as integer
    dim s as integer

	''
	f = ifuncTB(FB.RTL.STRCOMPARE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4 )

   	''
	str1len = -1
	if( hIsStrFixed( sdtype1 ) ) then
		str1len = hGetFixStrLen( str1 )
		if( str1len < 0 ) then str1len = 0
	end if

    ''
	str2len = -1
	if( hIsStrFixed( sdtype2 ) ) then
		str2len = hGetFixStrLen( str2 )
		if( str2len < 0 ) then str2len = 0
	end if

    ''
    astNewPARAM( proc, str1, sdtype1 )
    lgt = astNewCONST( str1len, IR.DATATYPE.INTEGER )
    astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

    astNewPARAM( proc, str2, sdtype2 )
    lgt = astNewCONST( str2len, IR.DATATYPE.INTEGER )
    astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

    rtlStrCompare = proc

end function

'':::::
function rtlStrConcat( byval str1 as integer, byval sdtype1 as integer, _
					   byval str2 as integer, byval sdtype2 as integer ) as integer static
    dim lgt as integer, tstr as FBSYMBOL ptr
    dim proc as integer, f as FBSYMBOL ptr
    dim str1len as integer, str2len as integer
    dim s as integer

	''
	f = ifuncTB(FB.RTL.STRCONCAT)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 5 )

    '' dst as string
    tstr = symbAddTempVar( FB.SYMBTYPE.STRING )
    astNewPARAM( proc, astNewVAR( tstr, 0, IR.DATATYPE.STRING ), IR.DATATYPE.STRING )

   	''
	str1len = -1
	if( hIsStrFixed( sdtype1 ) ) then
		str1len = hGetFixStrLen( str1 )
		if( str1len < 0 ) then str1len = 0
	end if

    ''
	str2len = -1
	if( hIsStrFixed( sdtype2 ) ) then
		str2len = hGetFixStrLen( str2 )
		if( str2len < 0 ) then str2len = 0
	end if

    ''
    astNewPARAM( proc, str1, sdtype1 )
    lgt = astNewCONST( str1len, IR.DATATYPE.INTEGER )
    astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

    astNewPARAM( proc, str2, sdtype2 )
    lgt = astNewCONST( str2len, IR.DATATYPE.INTEGER )
    astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

    rtlStrConcat = proc

end function

'':::::
function rtlStrConcatAssign( byval dst as integer, byval src as integer ) as integer static
    dim lgt as integer, dtype as integer
    dim f as FBSYMBOL ptr, proc as integer
    dim s as integer

	''
	f = ifuncTB(FB.RTL.STRCONCATASSIGN)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4 )

    ''
   	dtype = astGetDataType( dst )

	lgt = -1
	if( dtype = IR.DATATYPE.BYTE ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( dst )
		if( lgt < 0 ) then lgt = 0
	end if
	astNewPARAM( proc, dst, dtype )
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

   	''
   	dtype = astGetDataType( src )

	lgt = -1
	if( dtype = IR.DATATYPE.BYTE ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( src )
		if( lgt < 0 ) then lgt = 0
	end if
	astNewPARAM( proc, src, dtype )
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

	''
	rtlStrConcatAssign = proc

end function

'':::::
function rtlStrAssign( byval dst as integer, byval src as integer ) as integer static
    dim lgt as integer, dtype as integer
    dim f as FBSYMBOL ptr, proc as integer
    dim s as integer

	''
	f = ifuncTB(FB.RTL.STRASSIGN)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4 )

    ''
   	dtype = astGetDataType( dst )

	lgt = -1
	if( dtype = IR.DATATYPE.BYTE ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( dst )
		if( lgt < 0 ) then lgt = 0
	end if
	astNewPARAM( proc, dst, dtype )
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

   	''
   	dtype = astGetDataType( src )

	lgt = -1
	if( dtype = IR.DATATYPE.BYTE ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( src )
		if( lgt < 0 ) then lgt = 0
	end if
	astNewPARAM( proc, src, dtype )
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

	''
	rtlStrAssign = proc

end function

'':::::
function rtlStrDelete( byval strg as integer ) as integer static
    dim lgt as integer
    dim proc as integer, f as FBSYMBOL ptr

	''
	f = ifuncTB(FB.RTL.STRDELETE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' str as ANY
    astNewPARAM( proc, strg, IR.DATATYPE.STRING )

    rtlStrDelete = proc

end function

'':::::
function rtlStrAllocTmpResult( byval strg as integer ) as integer static
    dim lgt as integer
    dim proc as integer, f as FBSYMBOL ptr

	''
	f = ifuncTB(FB.RTL.STRALLOCTMPRES)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' src as string
    astNewPARAM( proc, strg, IR.DATATYPE.STRING )


	rtlStrAllocTmpResult = proc

end function

'':::::
function rtlStrAllocTmpDesc	( byval strg as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr
    dim s as integer, lgt as integer, dtype as integer

	''
	f = ifuncTB(FB.RTL.STRALLOCTMPDESC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    '' str as any
    astNewPARAM( proc, strg, IR.DATATYPE.STRING )

    '' byval strlen as integer
   	dtype = astGetDataType( strg )

	lgt = -1
	if( dtype = IR.DATATYPE.BYTE ) then
		lgt = 0
	elseif( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( strg )
		if( lgt < 0 ) then lgt = 0
	end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

	''
	rtlStrAllocTmpDesc = proc

end function

'':::::
function rtlToStr( byval expr as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr


	select case astGetDataClass( expr )
	case IR.DATACLASS.INTEGER
		f = ifuncTB(FB.RTL.INT2STR)
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
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    ''
    astNewPARAM( proc, expr, INVALID )

    rtlToStr = proc

end function

'':::::
function rtlStrInstr( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr

	''
	f = ifuncTB(FB.RTL.STRINSTR)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 3 )

    ''
    astNewPARAM( proc, expr1, INVALID )

    astNewPARAM( proc, expr2, INVALID )

    astNewPARAM( proc, expr3, INVALID )

    rtlStrInstr = proc

end function

'':::::
function rtlStrMid( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr

	''
	f = ifuncTB(FB.RTL.STRMID)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 3 )

    ''
    astNewPARAM( proc, expr1, INVALID )

    astNewPARAM( proc, expr2, INVALID )

    astNewPARAM( proc, expr3, INVALID )

    rtlStrMid = proc

end function

'':::::
sub rtlStrAssignMid( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer, byval expr4 as integer ) static

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.STRASSIGNMID)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4 )

    ''
    astNewPARAM( proc, expr1, INVALID )

    astNewPARAM( proc, expr2, INVALID )

    astNewPARAM( proc, expr3, INVALID )

    astNewPARAM( proc, expr4, INVALID )

    ''
    astFlush proc, vr

end sub

'':::::
function rtlStrFill( byval expr1 as integer, byval expr2 as integer ) as integer static

    dim proc as integer, f as FBSYMBOL ptr

	select case astGetDataClass( expr2 )
	case IR.DATACLASS.INTEGER, IR.DATACLASS.FPOINT
		f = ifuncTB(FB.RTL.STRFILL1)
	case else
		f = ifuncTB(FB.RTL.STRFILL2)
	end select

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    ''
    astNewPARAM( proc, expr1, INVALID )

    astNewPARAM( proc, expr2, INVALID )

    rtlStrFill = proc

end function


'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' arrays
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub rtlArrayRedim( byval s as FBSYMBOL ptr, byval elementlen as integer, byval dimensions as integer, _
				   exprTB() as integer, byval dopreserve as integer ) static

    dim proc as integer, f as FBSYMBOL ptr
    dim typ as integer, dtype as integer, t as integer, isvarlen as integer
    dim i as integer, vr as integer

	''
	f = ifuncTB(FB.RTL.ARRAYREDIM)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 5+dimensions*2 )

    '' array() as ANY
    typ = symbGetType( s )
    dtype =  hStyp2Dtype( typ )
	t = astNewVAR( s, 0, dtype )
    astNewPARAM( proc, t, dtype )

	'' byval element_len as integer
	t = astNewCONST( elementlen, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

	'' byval isvarlen as integer
	isvarlen = FALSE
	if( symbIsString( s ) ) then
		isvarlen = not hIsStrFixed( dtype )
	end if
	t = astNewCONST( isvarlen, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

	'' byval preserve as integer
	t = astNewCONST( dopreserve, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

	'' byval dimensions as integer
	t = astNewCONST( dimensions, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

	'' ...
	for i = 0 to dimensions-1
		t = exprTB(i,0)
		dtype = astGetDataType( t )
		astNewPARAM( proc, t, dtype )

		t = exprTB(i,1)
		dtype = astGetDataType( t )
		astNewPARAM( proc, t, dtype )
	next i

    ''
	astFlush proc, vr

end sub

'':::::
sub rtlArrayErase( byval arrayexpr as integer ) static
    dim s as FBSYMBOL ptr
    dim proc as integer, f as FBSYMBOL ptr
    dim typ as integer, dtype as integer, t as integer, isvarlen as integer
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.ARRAYERASE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    '' array() as ANY
    if( astNewPARAM( proc, arrayexpr, astGetDataType( arrayexpr ) ) = INVALID ) then
    	exit sub
    end if

	'' byval isvarlen as integer
	isvarlen = FALSE
	if( symbIsString( astGetSymbol( arrayexpr ) ) ) then
		isvarlen = not hIsStrFixed( dtype )
	end if
	t = astNewCONST( isvarlen, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

    ''
	astFlush proc, vr

end sub

'':::::
sub rtlArrayClear( byval arrayexpr as integer ) static
    dim e as FBSYMBOL ptr
    dim proc as integer, f as FBSYMBOL ptr
    dim isvarlen as integer, dtype as integer
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.ARRAYCLEAR)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    '' array() as ANY
    if( astNewPARAM( proc, arrayexpr, astGetDataType( arrayexpr ) ) = INVALID ) then
    	exit sub
    end if

	'' byval isvarlen as integer
	e = astGetUDTElm( arrayexpr )
	if( e <> NULL ) then
		dtype = symbGetType( e )
	else
		dtype = symbGetType( astGetSymbol( arrayexpr ) )
	end if

    isvarlen = FALSE
	if( hIsString( dtype ) ) then
		isvarlen = not hIsStrFixed( dtype )
	end if
	astNewPARAM( proc, astNewCONST( isvarlen, IR.DATATYPE.INTEGER ), IR.DATATYPE.INTEGER )

    ''
	astFlush proc, vr

end sub

'':::::
sub rtlArrayStrErase( byval s as FBSYMBOL ptr ) static

    dim proc as integer, f as FBSYMBOL ptr
    dim typ as integer, dtype as integer, t as integer, isvarlen as integer
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.ARRAYSTRERASE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' array() as ANY
    typ = symbGetType( s )
    dtype =  hStyp2Dtype( typ )
	t = astNewVAR( s, 0, dtype )
    astNewPARAM( proc, t, dtype )

    ''
	astFlush proc, vr

end sub

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
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

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
sub rtlArraySetDesc( byval s as FBSYMBOL ptr, byval elementlen as integer, _
					 byval dimensions as integer, dTB() as FBARRAYDIM ) static

    dim proc as integer, f as FBSYMBOL ptr
    dim typ as integer, dtype as integer, t as integer
    dim i as integer, vr as integer

	f = ifuncTB(FB.RTL.ARRAYSETDESC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4+dimensions*2 )

    '' array() as ANY
    typ = symbGetType( s )
    dtype =  hStyp2Dtype( typ )
	t = astNewVAR( s, 0, dtype )
    astNewPARAM( proc, t, dtype )

	'' arraydata as any
	t = astNewVAR( s, 0, dtype )
    astNewPARAM( proc, t, dtype )

	'' byval element_len as integer
	t = astNewCONST( elementlen, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

	'' byval dimensions as integer
	t = astNewCONST( dimensions, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

	'' ...
	for i = 0 to dimensions-1
		t = astNewCONST( dTB(i).lower, IR.DATATYPE.INTEGER )
		astNewPARAM( proc, t, IR.DATATYPE.INTEGER )
		t = astNewCONST( dTB(i).upper, IR.DATATYPE.INTEGER )
		astNewPARAM( proc, t, IR.DATATYPE.INTEGER )
	next i

    ''
	astFlush proc, vr

end sub

'':::::
function rtlArrayAllocTmpDesc( byval arrayexpr as integer, byval pdesc as FBSYMBOL ptr ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, t as integer
    dim s as FBSYMBOL ptr, e as FBSYMBOL ptr
    dim d as FBVARDIM ptr
    dim dimensions as integer

	s = astGetSymbol( arrayexpr )
	e = astGetUDTElm( arrayexpr )

	dimensions = symbGetArrayDimensions( e )

	f = ifuncTB(FB.RTL.ARRAYALLOCTMPDESC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4+dimensions*2 )

    '' byref pdesc as any ptr
	t = astNewVAR( pdesc, 0, IR.DATATYPE.POINTER+IR.DATATYPE.VOID )
    astNewPARAM( proc, t, IR.DATATYPE.POINTER+IR.DATATYPE.VOID )

    '' byref arraydata as any
    astNewPARAM( proc, arrayexpr, IR.DATATYPE.VOID )

	'' byval element_len as integer
	t = astNewCONST( symbGetLen( e ), IR.DATATYPE.INTEGER )
	astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

	'' byval dimensions as integer
	t = astNewCONST( dimensions, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

	'' ...
    d = symbGetArrayFirstDim( e )
    do while( d <> NULL )
		t = astNewCONST( d->lower, IR.DATATYPE.INTEGER )
		astNewPARAM( proc, t, IR.DATATYPE.INTEGER )
		t = astNewCONST( d->upper, IR.DATATYPE.INTEGER )
		astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

		'' next
		d = d->r
	loop

	rtlArrayAllocTmpDesc = proc

end function

'':::::
function rtlArrayFreeTempDesc( byval pdesc as FBSYMBOL ptr ) as integer
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer

	f = ifuncTB(FB.RTL.ARRAYFREETMPDESC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' byval pdesc as any ptr
	t = astNewVAR( pdesc, 0, IR.DATATYPE.POINTER+IR.DATATYPE.VOID )
    astNewPARAM( proc, t, IR.DATATYPE.POINTER+IR.DATATYPE.VOID )

    rtlArrayFreeTempDesc = proc

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' data
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub rtlDataRead( byval varexpr as integer ) static

    dim proc as integer, f as FBSYMBOL ptr, args as integer
    dim vr as integer, dtype as integer, lgt as integer

	f = NULL
	select case astGetDataClass( varexpr )
	case IR.DATACLASS.INTEGER
		select case astGetDataSize( varexpr )
		case 1
			f = ifuncTB(FB.RTL.DATAREADBYTE)
		case 2
			f = ifuncTB(FB.RTL.DATAREADSHORT)
		case 4
			f = ifuncTB(FB.RTL.DATAREADINT)
		end select
		args = 1

	case IR.DATACLASS.FPOINT
		select case astGetDataSize( varexpr )
		case 4
			f = ifuncTB(FB.RTL.DATAREADSINGLE)
		case 8
			f = ifuncTB(FB.RTL.DATAREADDOUBLE)
		end select
		args = 1

	case else
		f = ifuncTB(FB.RTL.DATAREADSTR)
		args = 2
	end select

    if( f = NULL ) then
    	exit sub
    end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), args )

    '' byref var as any
    astNewPARAM( proc, varexpr, INVALID )

    if( args = 2 ) then
		'' byval dst_size as integer
		lgt = -1
		dtype = astGetDataType( varexpr )
		if( hIsStrFixed( dtype ) ) then
			lgt = hGetFixStrLen( varexpr )
			if( lgt < 0 ) then lgt = 0
		end if
		lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
		astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )
    end if

    ''
    astFlush proc, vr

end sub

'':::::
sub rtlDataRestore( byval label as FBSYMBOL ptr ) static

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer
    dim lname as string
    dim s as FBSYMBOL ptr

	f = ifuncTB(FB.RTL.DATARESTORE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' begin of data or start from label?
    if( label <> NULL ) then
    	lname = FB.DATALABELPREFIX + symbGetLabelName( label )
    else
    	lname = FB.DATALABELNAME
    end if

    '' label already declared?
    s = symbLookupLabel( lname )
    if( s = NULL ) then
       	s = symbAddLabelEx( lname, TRUE, TRUE )
    end if

    '' byval labeladdrs as void ptr
    s = astNewVAR( s, 0, IR.DATATYPE.UINT )
    label = astNewADDR( IR.OP.ADDROF, s )

    astNewPARAM( proc, label, INVALID )

	''
	astFlush proc, vr

end sub

'':::::
sub rtlDataStoreBegin static
    dim label as FBSYMBOL ptr, lname as string
    dim l as FBSYMBOL ptr

	irFlush

	'' switch section, can't be code coz it will screw up debugging
	emitSECTION EMIT.SECTYPE.CONST

	'' emit default label if not yet emited
	if( not ctx.datainited ) then
		ctx.datainited = TRUE

		l = symbAddLabelEx( FB.DATALABELNAME, TRUE, TRUE )
		if( l = NULL ) then
			l = symbLookupLabel( FB.DATALABELNAME )
		end if

		lname = symbGetLabelName( l )
		emitLABEL lname, TRUE

	else
		lname = symbGetLabelName( symbLookupLabel( FB.DATALABELNAME ) )
	end if

	'' emit last label as a label in const section
	'' if any defined already, otherwise it will be the default
	label = symbGetLastLabel
	if( label <> NULL ) then
    	''
    	lname = FB.DATALABELPREFIX + symbGetLabelName( label )
    	l = symbLookupLabel( lname )
    	if( l = NULL ) then
       		l = symbAddLabelEx( lname, TRUE, TRUE )
    	end if

    	lname = symbGetLabelName( l )

    	'' stills the same label as before? incrase counter to link DATA's
    	if( ctx.lastlabel = label ) then
    		ctx.labelcnt = ctx.labelcnt + 1
    		lname = lname + "_" + ltrim$( str$( ctx.labelcnt ) )
    	else
    		ctx.lastlabel = label
    		ctx.labelcnt = 0
    	end if

    	emitLABEL lname, TRUE

    else
    	symbSetLastLabel symbLookupLabel( FB.DATALABELNAME )
    end if

	'' emit will link the last DATA with this one if any exists
	emitDATABEGIN lname

end sub

'':::::
sub rtlDataStore( littext as string, byval litlen as integer, byval typ as integer ) static

	'' emit will take care of all dirty details
	emitDATA littext, litlen, typ

end sub

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
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

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

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

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

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' byval x as single|double
    astNewPARAM( proc, expr, INVALID )

    ''
    rtlMathFIX = proc

end function

'':::::
private function hCalcExprLen( byval expr as integer, byval realUDTsize as integer = TRUE ) as integer static
	dim lgt as integer, elm as FBSYMBOL ptr

	lgt = -1

	select case astGetDataType( expr )
	case IR.DATATYPE.BYTE, IR.DATATYPE.UBYTE
		lgt = 1
	case IR.DATATYPE.SHORT, IR.DATATYPE.USHORT
		lgt = 2
	case IR.DATATYPE.INTEGER, IR.DATATYPE.UINT
		lgt = FB.INTEGERSIZE
	case IR.DATATYPE.SINGLE
		lgt = 4
	case IR.DATATYPE.DOUBLE
		lgt = 8
	case is >= IR.DATATYPE.POINTER
		lgt = FB.POINTERSIZE
	case IR.DATATYPE.USERDEF
		elm = astGetUDTElm( expr )
		if( elm <> NULL ) then
			'' if it's a type field that's also a type, no pad is ever added, then
			'' readUDTsize is always true
			lgt = symbGetUDTLen( symbGetSubtype( elm ) )
		else
			lgt = symbGetUDTLen( symbGetSubtype( astGetSymbol( expr ) ), realUDTsize )
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
    	proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    	'' str as any
    	astNewPARAM( proc, expr, IR.DATATYPE.STRING )

    	'' byval strlen as integer
		lgt = -1
		if( hIsStrFixed( dtype ) ) then
			lgt = hGetFixStrLen( expr )
			if( lgt < 0 ) then lgt = 0
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

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' console
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub rtlPrint( byval fileexpr as integer, byval iscomma as integer, byval issemicolon as integer, byval expr as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer, mask as integer, args as integer
    dim vr as integer

	if( expr = INVALID ) then
		f = ifuncTB(FB.RTL.PRINTVOID)
		args = 2
	else
        astUpdNodeResult expr

		select case astGetDataType( expr )
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
		case IR.DATATYPE.UINT, is >= IR.DATATYPE.POINTER
			f = ifuncTB(FB.RTL.PRINTUINT)
		case IR.DATATYPE.SINGLE
			f = ifuncTB(FB.RTL.PRINTSINGLE)
		case IR.DATATYPE.DOUBLE
			f = ifuncTB(FB.RTL.PRINTDOUBLE)
		end select

		args = 3
	end if

    ''
	proc = astNewFUNCT( f, symbGetFuncDataType( f ), args )

    '' byval filenum as integer
    astNewPARAM( proc, fileexpr, INVALID )

    if( expr <> INVALID ) then
    	'' byval? x as ???
    	astNewPARAM( proc, expr, INVALID )
    end if

    '' byval mask as integer
	mask = 0
	if( iscomma ) then
		mask = mask or FB.PRINTMASK.PAD
	elseif( not issemicolon ) then
		mask = mask or FB.PRINTMASK.NEWLINE
	end if

	t = astNewCONST( mask, IR.DATATYPE.INTEGER )
    astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

    ''
    astFlush proc, vr

end sub

'':::::
sub rtlPrintSPC( byval fileexpr as integer, byval expr as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	''
	f = ifuncTB(FB.RTL.PRINTSPC)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    '' byval filenum as integer
    astNewPARAM( proc, fileexpr, INVALID )

    '' byval n as integer
    astNewPARAM( proc, expr, INVALID )

    astFlush proc, vr

end sub

'':::::
sub rtlPrintTab( byval fileexpr as integer, byval expr as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	''
	f = ifuncTB(FB.RTL.PRINTTAB)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    '' byval filenum as integer
    astNewPARAM( proc, fileexpr, INVALID )

    '' byval newcol as integer
    astNewPARAM( proc, expr, INVALID )

    astFlush proc, vr

end sub

'':::::
sub rtlWrite( byval fileexpr as integer, byval iscomma as integer, byval expr as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer, mask as integer, args as integer
    dim vr as integer

	if( expr = INVALID ) then
		f = ifuncTB(FB.RTL.WRITEVOID)
		args = 2
	else
        astUpdNodeResult expr

		select case astGetDataType( expr )
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
		case IR.DATATYPE.UINT, is >= IR.DATATYPE.POINTER
			f = ifuncTB(FB.RTL.WRITEUINT)
		case IR.DATATYPE.SINGLE
			f = ifuncTB(FB.RTL.WRITESINGLE)
		case IR.DATATYPE.DOUBLE
			f = ifuncTB(FB.RTL.WRITEDOUBLE)
		end select

		args = 3
	end if

    ''
	proc = astNewFUNCT( f, symbGetFuncDataType( f ), args )

    '' byval filenum as integer
    astNewPARAM( proc, fileexpr, INVALID )

    if( expr <> INVALID ) then
    	'' byval? x as ???
    	astNewPARAM( proc, expr, INVALID )
    end if

    '' byval mask as integer
	mask = 0
	if( iscomma ) then
		mask = mask or FB.PRINTMASK.PAD
	else
		mask = mask or FB.PRINTMASK.NEWLINE
	end if

	t = astNewCONST( mask, IR.DATATYPE.INTEGER )
    astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

    ''
    astFlush proc, vr

end sub

'':::::
sub rtlPrintUsingInit( byval usingexpr as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	''
	f = ifuncTB(FB.RTL.PRINTUSGINIT)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' fmtstr as string
    astNewPARAM( proc, usingexpr, INVALID )

    astFlush proc, vr

end sub

'':::::
sub rtlPrintUsingEnd( byval fileexpr as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	''
	f = ifuncTB(FB.RTL.PRINTUSGEND)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' byval filenum as integer
    astNewPARAM( proc, fileexpr, INVALID )

    astFlush proc, vr

end sub

'':::::
sub rtlPrintUsing( byval fileexpr as integer, byval expr as integer, byval issemicolon as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer, mask as integer
    dim vr as integer

	astUpdNodeResult expr

	select case astGetDataType( expr )
	case IR.DATATYPE.FIXSTR, IR.DATATYPE.STRING
		f = ifuncTB(FB.RTL.PRINTUSGSTR)
	case else
		f = ifuncTB(FB.RTL.PRINTUSGVAL)
	end select

    ''
	proc = astNewFUNCT( f, symbGetFuncDataType( f ), 3 )

    '' byval filenum as integer
    astNewPARAM( proc, fileexpr, INVALID )

    '' s as string or byval v as double
    astNewPARAM( proc, expr, INVALID )

    '' byval mask as integer
	mask = 0
	if( not issemicolon ) then
		mask = mask or FB.PRINTMASK.NEWLINE or FB.PRINTMASK.ISLAST
	end if

	t = astNewCONST( mask, IR.DATATYPE.INTEGER )
    astNewPARAM( proc, t, IR.DATATYPE.INTEGER )

    ''
    astFlush proc, vr

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub rtlExit( byval errlevel as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	''
	f = ifuncTB(FB.RTL.END)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' errlevel
    if( errlevel = INVALID ) then
    	errlevel = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    astNewPARAM( proc, errlevel, INVALID )

    astFlush proc, vr

end sub

'':::::
function rtlMemCopy( byval dst as integer, byval src as integer, byval bytes as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer

	''
	f = ifuncTB(FB.RTL.MEMCOPY)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 3 )

    '' dst as any
    astNewPARAM( proc, dst, INVALID )

    '' src as any
    astNewPARAM( proc, src, INVALID )

    '' byval bytes as integer
    t = astNewCONST( bytes, IR.DATATYPE.INTEGER )
    astNewPARAM( proc, t, INVALID )

    ''
    rtlMemCopy = proc

end function

'':::::
sub rtlMemSwap( byval dst as integer, byval src as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim t as integer, bytes as integer
    dim vr as integer, vs as integer
    dim s as FBSYMBOL ptr, d as FBSYMBOL ptr
    dim dtype as integer, typ as integer

	'' simple type?
	dtype = astGetDataType( dst )
	if( (dtype <> IR.DATATYPE.USERDEF) and (astGetType( dst ) = AST.NODETYPE.VAR) ) then

		d = astGetSymbol( dst )
		s = astGetSymbol( src )

		'' push src
		vr = irAllocVRVAR( dtype, s, 0 )
		irEmitPUSH vr

		'' src = dst
		vr = irAllocVRVAR( dtype, s, 0 )
		vs = irAllocVRVAR( dtype, d, 0 )
		irEmitSTORE vr, vs

		'' pop dst
		vr = irAllocVRVAR( dtype, d, 0 )
		irEmitPOP vr

		exit sub
	end if

	''
	f = ifuncTB(FB.RTL.MEMSWAP)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 3 )

    '' dst as any
    astNewPARAM( proc, dst, INVALID )

    '' src as any
    astNewPARAM( proc, src, INVALID )

    '' byval bytes as integer
	bytes = hCalcExprLen( dst )

    t = astNewCONST( bytes, IR.DATATYPE.INTEGER )
    astNewPARAM( proc, t, INVALID )

    ''
    astFlush proc, vr

end sub

'':::::
sub rtlStrSwap( byval str1 as integer, byval str2 as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim lgt as integer, s as integer, dtype as integer
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.STRSWAP)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4 )

    '' str1 as any
    astNewPARAM( proc, str1, IR.DATATYPE.STRING )

    '' byval str1len as integer
	dtype = astGetDataType( str1 )
	lgt = -1
	if( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( str1 )
		if( lgt < 0 ) then lgt = 0
	end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

    '' str2 as any
    astNewPARAM( proc, str2, IR.DATATYPE.STRING )

    '' byval str1len as integer
	dtype = astGetDataType( str2 )
	lgt = -1
	if( hIsStrFixed( dtype ) ) then
		lgt = hGetFixStrLen( str2 )
		if( lgt < 0 ) then lgt = 0
	end if
	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )

    ''
    astFlush proc, vr

end sub

'':::::
sub rtlConsoleView ( byval topexpr as integer, byval botexpr as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	''
	f = ifuncTB(FB.RTL.CONSOLEVIEW)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    '' byval toprow as integer
    astNewPARAM( proc, topexpr, INVALID )

    '' byval botrow as integer
    astNewPARAM( proc, botexpr, INVALID )

    astFlush proc, vr

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' error
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

sub rtlCheckError( byval vr as integer, byval reslabel as FBSYMBOL ptr ) static
	dim nxtlabel as FBSYMBOL ptr
	dim cr as integer, vt as integer

	if( not env.clopt.errorcheck ) then
		exit function
	end if

	''
	nxtlabel = symbAddLabel( hMakeTmpStr )

	'' result == FB_RTERROR_OK? skip..
	cr = irAllocVRIMM( IR.DATATYPE.INTEGER, 0 )
	irEmitCOMPBRANCHNF IR.OP.EQ, vr, cr, nxtlabel

	'' else, fb_ErrorThrow( result, reslabel, resnxtlabel ); -- CDECL

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		vt = irAllocVREG( IR.DATATYPE.UINT )
		irEmitBOP IR.OP.ADDROF, irAllocVRVAR( IR.DATATYPE.UINT, nxtlabel, 0 ), INVALID, vt
	else
		vt = irAllocVRIMM( IR.DATATYPE.UINT, NULL )
	end if
	irEmitPUSH vt

	'' reslabel
	if( reslabel <> NULL ) then
		vt = irAllocVREG( IR.DATATYPE.UINT )
		irEmitBOP IR.OP.ADDROF, irAllocVRVAR( IR.DATATYPE.UINT, reslabel, 0 ), INVALID, vt
	else
		vt = irAllocVRIMM( IR.DATATYPE.UINT, NULL )
	end if
	irEmitPUSH vt

	'' result
	irEmitPUSH vr

	vr = irAllocVREG( IR.DATATYPE.UINT )
	irEmitCALLFUNCT ifuncTB(FB.RTL.ERRORTHROW), 0, vr

	irEmitBRANCHPTR vr

	irEmitLABEL nxtlabel, FALSE

	'''''symbDelLabel nxtlabel
	'''''symbDelLabel reslabel

end sub

'':::::
sub rtlErrorThrow( byval errexpr as integer ) static
	dim nxtlabel as FBSYMBOL ptr, reslabel as FBSYMBOL ptr
	dim vr as integer, vt as integer

	''
    reslabel = symbAddLabel( hMakeTmpStr )
    irEmitLABEL reslabel, FALSE

	nxtlabel = symbAddLabel( hMakeTmpStr )

	'' fb_ErrorThrow( result, reslabel, resnxtlabel ); -- CDECL

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		vt = irAllocVREG( IR.DATATYPE.UINT )
		irEmitBOP IR.OP.ADDROF, irAllocVRVAR( IR.DATATYPE.UINT, nxtlabel, 0 ), INVALID, vt
	else
		vt = irAllocVRIMM( IR.DATATYPE.UINT, NULL )
	end if
	irEmitPUSH vt

	'' reslabel
	if( env.clopt.resumeerr ) then
		vt = irAllocVREG( IR.DATATYPE.UINT )
		irEmitBOP IR.OP.ADDROF, irAllocVRVAR( IR.DATATYPE.UINT, reslabel, 0 ), INVALID, vt
	else
		vt = irAllocVRIMM( IR.DATATYPE.UINT, NULL )
	end if
	irEmitPUSH vt

	'' result
	astLoad errexpr, vt
	irEmitPUSH vt

	vr = irAllocVREG( IR.DATATYPE.UINT )
	irEmitCALLFUNCT ifuncTB(FB.RTL.ERRORTHROW), 0, vr

	irEmitBRANCHPTR vr

	irEmitLABEL nxtlabel, FALSE

	'''''symbDelLabel nxtlabel
	'''''symbDelLabel reslabel

end sub

'':::::
sub rtlErrorSetHandler( byval newhandler as integer, byval savecurrent as integer ) static
    dim proc as integer, f as FBSYMBOL ptr

    dim vr as integer, vs as integer

	''
	f = ifuncTB(FB.RTL.ERRORSETHANDLER)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' byval newhandler as uint
    astNewPARAM( proc, newhandler, INVALID )

    ''
    astFlush proc, vr

    if( savecurrent ) then
    	if( env.scope > 0 ) then
    		if( env.procerrorhnd = NULL ) then
				env.procerrorhnd = symbAddTempVar( IR.DATATYPE.UINT )

				vs = irAllocVRVAR( IR.DATATYPE.UINT, env.procerrorhnd, 0 )
				irEmitSTORE vs, vr
    		end if
		end if
    end if

end sub

'':::::
function rtlErrorGetNum as integer static
    dim proc as integer, f as FBSYMBOL ptr


	''
	f = ifuncTB(FB.RTL.ERRORGETNUM)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 0 )

    ''
    rtlErrorGetNum = proc

end function

'':::::
sub rtlErrorSetNum( byval errexpr as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.ERRORSETNUM)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' byval errnum as integer
    astNewPARAM( proc, errexpr, INVALID )

    ''
    astFlush proc, vr

end sub

'':::::
sub rtlErrorResume( byval isnext as integer )
    dim f as FBSYMBOL ptr
    dim vr as integer

	''
	if( not isnext ) then
		f = ifuncTB(FB.RTL.ERRORRESUME)
	else
		f = ifuncTB(FB.RTL.ERRORRESUMENEXT)
	end if

    ''
	vr = irAllocVREG( IR.DATATYPE.INTEGER )
	irEmitCALLFUNCT f, 0, vr

    irEmitBRANCHPTR vr

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' file
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub rtlFileOpen( byval filename as integer, byval fmode as integer, byval faccess as integer, _
				 byval flock, byval filenum as integer, byval flen as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim reslabel as FBSYMBOL ptr
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.FILEOPEN)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 6 )

    '' filename as string
    astNewPARAM( proc, filename, INVALID )

    '' byval mode as integer
    astNewPARAM( proc, fmode, INVALID )

    '' byval access as integer
    astNewPARAM( proc, faccess, INVALID )

    '' byval lock as integer
    astNewPARAM( proc, flock, INVALID )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    '' byval len as integer
    astNewPARAM( proc, flen, INVALID )

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    astFlush proc, vr

    rtlCheckError vr, reslabel

end sub

'':::::
sub rtlFileClose( byval filenum as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim reslabel as FBSYMBOL ptr
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.FILECLOSE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    astFlush proc, vr

    rtlCheckError vr, reslabel

end sub

'':::::
sub rtlFileSeek( byval filenum as integer, byval newpos as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim reslabel as FBSYMBOL ptr
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.FILESEEK)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    '' byval newpos as integer
    astNewPARAM( proc, newpos, INVALID )

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    astFlush proc, vr

    rtlCheckError vr, reslabel

end sub

'':::::
function rtlFileTell( byval filenum as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr

    dim vr as integer

	''
	f = ifuncTB(FB.RTL.FILETELL)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    ''
    rtlFileTell = proc

end function

'':::::
sub rtlFilePut( byval filenum as integer, byval offset as integer, byval src as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, args as integer, lgt as integer
    dim reslabel as FBSYMBOL ptr
    dim vr as integer

	''
	dtype = astGetDataType( src )
	if( hIsString( dtype ) ) then
		f = ifuncTB(FB.RTL.FILEPUTSTR)
		args = 3
	else
		f = ifuncTB(FB.RTL.FILEPUT)
		args = 4
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), args )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    '' byval offset as integer
    if( offset = INVALID ) then
    	offset = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    astNewPARAM( proc, offset, INVALID )

    '' value as any | s as string
    astNewPARAM( proc, src, INVALID )

    if( args = 4 ) then
    	'' byval valuelen as integer
    	lgt = hCalcExprLen( src )
    	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
    	astNewPARAM( proc, lgt, INVALID )
    end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    astFlush proc, vr

    rtlCheckError vr, reslabel

end sub

'':::::
sub rtlFilePutArray( byval filenum as integer, byval offset as integer, byval src as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer
    dim reslabel as FBSYMBOL ptr
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.FILEPUTARRAY)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 3 )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    '' byval offset as integer
    if( offset = INVALID ) then
    	offset = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    astNewPARAM( proc, offset, INVALID )

    '' array() as any
    if( astNewPARAM( proc, src, INVALID ) = INVALID ) then
    	exit sub
    end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    astFlush proc, vr

    rtlCheckError vr, reslabel

end sub

'':::::
sub rtlFileGet( byval filenum as integer, byval offset as integer, byval dst as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer, args as integer, lgt as integer
    dim reslabel as FBSYMBOL ptr
    dim vr as integer

	''
	dtype = astGetDataType( dst )
	if( hIsString( dtype ) ) then
		f = ifuncTB(FB.RTL.FILEGETSTR)
		args = 3
	else
		f = ifuncTB(FB.RTL.FILEGET)
		args = 4
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), args )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    '' byval offset as integer
    if( offset = INVALID ) then
    	offset = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    astNewPARAM( proc, offset, INVALID )

    '' value as any | s as string
    astNewPARAM( proc, dst, INVALID )

    if( args = 4 ) then
    	'' byval valuelen as integer
    	lgt = hCalcExprLen( dst )
    	lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
    	astNewPARAM( proc, lgt, INVALID )
    end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    astFlush proc, vr

    rtlCheckError vr, reslabel

end sub

'':::::
sub rtlFileGetArray( byval filenum as integer, byval offset as integer, byval dst as integer ) static
    dim proc as integer, f as FBSYMBOL ptr
    dim dtype as integer
    dim reslabel as FBSYMBOL ptr
    dim vr as integer

	''
	f = ifuncTB(FB.RTL.FILEGETARRAY)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 3 )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    '' byval offset as integer
    if( offset = INVALID ) then
    	offset = astNewCONST( 0, IR.DATATYPE.INTEGER )
    end if
    astNewPARAM( proc, offset, INVALID )

    '' array() as any
    if( astNewPARAM( proc, dst, INVALID ) = INVALID ) then
    	exit sub
    end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( hMakeTmpStr )
    	irEmitLABEL reslabel, FALSE
    else
    	reslabel = NULL
    end if

    ''
    astFlush proc, vr

    rtlCheckError vr, reslabel

end sub

'':::::
function rtlFileStrInput( byval bytesexpr as integer, byval filenum as integer ) as integer static
    dim proc as integer, f as FBSYMBOL ptr


	''
	f = ifuncTB(FB.RTL.FILESTRINPUT)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

    '' byval bytes as integer
    astNewPARAM( proc, bytesexpr, INVALID )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    ''
    rtlFileStrInput = proc

end function

'':::::
sub rtlFileLineInput( byval isfile as integer, byval expr as integer, byval dstexpr as integer, _
					  byval addquestion as integer, byval addnewline as integer )
    dim proc as integer, f as FBSYMBOL ptr, args as integer
    dim vr as integer


	''
	if( isfile ) then
		f = ifuncTB(FB.RTL.FILELINEINPUT)
		args = 2
	else
		f = ifuncTB(FB.RTL.CONSOLELINEINPUT)
		args = 4
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), args )

    '' "byval filenum as integer" or "text as string "
    if( (not isfile) and (expr = INVALID) ) then
		expr = astNewVAR( hAllocStringConst( "", 0 ), 0, IR.DATATYPE.FIXSTR )
	end if

    astNewPARAM( proc, expr, INVALID )

    '' dst as string
    astNewPARAM( proc, dstexpr, INVALID )

    if( args = 4 ) then
    	'' byval addquestion as integer
    	astNewPARAM( proc, astNewCONST( addquestion, IR.DATATYPE.INTEGER ), INVALID )

    	'' byval addnewline as integer
    	astNewPARAM( proc, astNewCONST( addnewline, IR.DATATYPE.INTEGER ), INVALID )
    end if

    astFlush proc, vr

end sub

'':::::
sub rtlFileInput( byval isfile as integer, byval expr as integer, _
				  byval addquestion as integer, byval addnewline as integer )
    dim proc as integer, f as FBSYMBOL ptr, args as integer
    dim vr as integer


	''
	if( isfile ) then
		f = ifuncTB(FB.RTL.FILEINPUT)
		args = 1
	else
		f = ifuncTB(FB.RTL.CONSOLEINPUT)
		args = 3
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), args )

    '' "byval filenum as integer" or "text as string "
    if( (not isfile) and (expr = INVALID) ) then
		expr = astNewVAR( hAllocStringConst( "", 0 ), 0, IR.DATATYPE.FIXSTR )
	end if

	astNewPARAM( proc, expr, INVALID )

    if( args = 3 ) then
    	'' byval addquestion as integer
    	astNewPARAM( proc, astNewCONST( addquestion, IR.DATATYPE.INTEGER ), INVALID )

    	'' byval addnewline as integer
    	astNewPARAM( proc, astNewCONST( addnewline, IR.DATATYPE.INTEGER ), INVALID )
    end if

    astFlush proc, vr

end sub

'':::::
sub rtlFileInputGet( byval dstexpr as integer )
    dim proc as integer, f as FBSYMBOL ptr, args as integer
    dim vr as integer, lgt as integer


	''
    astUpdNodeResult dstexpr

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
	case IR.DATATYPE.SINGLE
		f = ifuncTB(FB.RTL.INPUTSINGLE)
	case IR.DATATYPE.DOUBLE
		f = ifuncTB(FB.RTL.INPUTDOUBLE)
	end select

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), args )

    '' dst as any
    astNewPARAM( proc, dstexpr, INVALID )

    if( args > 1 ) then
		lgt = -1
		if( hIsStrFixed( astGetDataType( dstexpr ) ) ) then
			lgt = hGetFixStrLen( dstexpr )
			if( lgt < 0 ) then lgt = 0
		end if
		lgt = astNewCONST( lgt, IR.DATATYPE.INTEGER )
		astNewPARAM( proc, lgt, IR.DATATYPE.INTEGER )
    end if

    astFlush proc, vr

end sub

'':::::
sub rtlFileLock( byval islock as integer, byval filenum as integer, byval iniexpr as integer, byval endexpr as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	''
	if( islock ) then
		f = ifuncTB(FB.RTL.FILELOCK)
	else
		f = ifuncTB(FB.RTL.FILEUNLOCK)
	end if

    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 3 )

    '' byval filenum as integer
    astNewPARAM( proc, filenum, INVALID )

    '' byval inipos as integer
    astNewPARAM( proc, iniexpr, INVALID )

    '' byval endpos as integer
    astNewPARAM( proc, endexpr, INVALID )

    astFlush proc, vr

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' gfx
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#ifdef AUTOADDGFXLIBS
private sub hAddGfxLibs
	dim temp as integer
	
	symbAddLib( "fbgfx" )
#ifdef TARGET_WIN32
	symbAddLib( "user32" )
#elseif defined(TARGET_LINUX)
	temp = fbAddLibPath( "/usr/X11R6/lib" )
	symbAddLib( "X11" )
	symbAddLib( "Xext" )
	symbAddLib( "Xxf86vm" )
	symbAddLib( "pthread" )
#endif
end sub
#endif

'':::::
sub rtlGfxPset( byval xexpr as integer, byval yexpr as integer, byval cexpr as integer, byval coordtype as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	f = ifuncTB(FB.RTL.GFXPSET)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4 )

 	'' byval x as single
 	astNewPARAM( proc, xexpr, INVALID )

 	'' byval y as single
 	astNewPARAM( proc, yexpr, INVALID )

 	'' byval color as uinteger
 	astNewPARAM( proc, cexpr, INVALID )

 	'' byval coordtype as integer
 	astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxLine( byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, byval y2expr as integer, _
			    byval cexpr as integer, byval linetype as integer, byval styleexpr as integer, byval coordtype as integer )

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	f = ifuncTB(FB.RTL.GFXLINE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 8 )

 	'' byval x1 as single
 	astNewPARAM( proc, x1expr, INVALID )

 	'' byval y1 as single
 	astNewPARAM( proc, y1expr, INVALID )

 	'' byval x2 as single
 	astNewPARAM( proc, x2expr, INVALID )

 	'' byval y2 as single
 	astNewPARAM( proc, y2expr, INVALID )

 	'' byval color as uinteger
 	astNewPARAM( proc, cexpr, INVALID )

 	'' byval linetype as integer
 	astNewPARAM( proc, astNewCONST( linetype, IR.DATATYPE.INTEGER ), INVALID )

 	'' byval style as uinteger
 	if( styleexpr = INVALID ) then
 		styleexpr = astNewCONST( &h0000FFFF, IR.DATATYPE.UINT )
 	end if
 	astNewPARAM( proc, styleexpr, INVALID )

 	'' byval coordtype as integer
 	astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxCircle( byval xexpr as integer, byval yexpr as integer, byval radexpr as integer, byval cexpr as integer, _
                  byval aspexpr as integer, byval iniexpr as integer, byval endexpr as integer, _
                  byval fillflag as integer, byval coordtype as integer )

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	f = ifuncTB(FB.RTL.GFXCIRCLE)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 9 )

 	'' byval x as single
 	astNewPARAM( proc, xexpr, INVALID )

 	'' byval y as single
 	astNewPARAM( proc, yexpr, INVALID )

 	'' byval radians as single
 	astNewPARAM( proc, radexpr, INVALID )

 	'' byval color as uinteger
 	astNewPARAM( proc, cexpr, INVALID )

 	'' byval aspect as single
 	if( aspexpr = INVALID ) then
 		aspexpr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
 	end if
 	astNewPARAM( proc, aspexpr, INVALID )

 	'' byval arcini as single
 	if( iniexpr = INVALID ) then
 		iniexpr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
 	end if
 	astNewPARAM( proc, iniexpr, INVALID )

 	'' byval arcend as single
 	if( endexpr = INVALID ) then
 		endexpr = astNewCONST( 3.141593*2, IR.DATATYPE.SINGLE )
 	end if
 	astNewPARAM( proc, endexpr, INVALID )

 	'' byval fillflag as integer
 	astNewPARAM( proc, astNewCONST( fillflag, IR.DATATYPE.INTEGER ), INVALID )

 	'' byval coordtype as integer
 	astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxPaint( byval xexpr as integer, byval yexpr as integer, byval pexpr as integer, byval bexpr as integer, _
				 byval coord_type as integer )

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer
    dim pattern as integer

	f = ifuncTB(FB.RTL.GFXPAINT)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4 )

 	'' byval x as single
 	astNewPARAM( proc, xexpr, INVALID )

 	'' byval y as single
 	astNewPARAM( proc, yexpr, INVALID )

	'' byval color as uinteger
	pattern = astGetDataType( pexpr )
	if( ( pattern = IR.DATATYPE.FIXSTR ) or ( pattern = IR.DATATYPE.STRING ) ) then
		pattern = TRUE
		astNewPARAM( proc, astNewCONST( &hFFFF0000, IR.DATATYPE.INTEGER ), INVALID )
	else
		pattern = FALSE
		astNewPARAM( proc, pexpr )
	end if

	'' byval border_color as uinteger
	astNewPARAM( proc, bexpr, INVALID )

	'' pattern as string, byval mode as integer
	if( pattern = TRUE ) then
		astNewPARAM( proc, pexpr, INVALID )
		astNewPARAM( proc, astNewCONST( 1, IR.DATATYPE.INTEGER ), INVALID )
	else
    	astNewPARAM( proc, astNewVAR( hAllocStringConst( "", 0 ), 0, IR.DATATYPE.FIXSTR ), INVALID )
		astNewPARAM( proc, astNewCONST( 0, IR.DATATYPE.INTEGER ), INVALID )
	end if

	'' byval coord_type as integer
	astNewPARAM( proc, astNewCONST( coord_type, IR.DATATYPE.INTEGER ), INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxView( byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, byval y2expr as integer, _
			    byval fillexpr as integer, byval bordexpr as integer, byval screenflag as integer )

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	f = ifuncTB(FB.RTL.GFXVIEW)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 7 )

 	'' byval x1 as integer
 	if( x1expr = INVALID ) then
        x1expr = astNewCONST( -32768, IR.DATATYPE.INTEGER )
    end if
 	astNewPARAM( proc, x1expr, INVALID )

 	'' byval y1 as integer
 	if( y1expr = INVALID ) then
        y1expr = astNewCONST( -32768, IR.DATATYPE.INTEGER )
    end if
 	astNewPARAM( proc, y1expr, INVALID )

 	'' byval x2 as integer
 	if( x2expr = INVALID ) then
        x2expr = astNewCONST( -32768, IR.DATATYPE.INTEGER )
    end if
 	astNewPARAM( proc, x2expr, INVALID )

 	'' byval y2 as integer
 	if( y2expr = INVALID ) then
        y2expr = astNewCONST( -32768, IR.DATATYPE.INTEGER )
    end if
 	astNewPARAM( proc, y2expr, INVALID )

 	'' byval fillcolor as uinteger
 	if( fillexpr = INVALID ) then
 		fillexpr = astNewCONST( &hffff0000, IR.DATATYPE.UINT )
 	end if
 	astNewPARAM( proc, fillexpr, INVALID )

 	'' byval bordercolor as uinteger
 	if( bordexpr = INVALID ) then
 		bordexpr = astNewCONST( &hffff0000, IR.DATATYPE.UINT )
 	end if
 	astNewPARAM( proc, bordexpr, INVALID )

 	'' byval screenflag as integer
 	astNewPARAM( proc, astNewCONST( screenflag, IR.DATATYPE.INTEGER ), INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxWindow( byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, byval y2expr as integer, _
			      byval screenflag as integer )

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	f = ifuncTB(FB.RTL.GFXWINDOW)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 5 )

 	'' byval x1 as single
 	if( x1expr = INVALID ) then
        x1expr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
    end if
 	astNewPARAM( proc, x1expr, INVALID )

 	'' byval y1 as single
 	if( y1expr = INVALID ) then
        y1expr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
    end if
 	astNewPARAM( proc, y1expr, INVALID )

 	'' byval x2 as single
 	if( x2expr = INVALID ) then
        x2expr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
    end if
 	astNewPARAM( proc, x2expr, INVALID )

 	'' byval y2 as single
 	if( y2expr = INVALID ) then
        y2expr = astNewCONST( 0.0, IR.DATATYPE.SINGLE )
    end if
 	astNewPARAM( proc, y2expr, INVALID )

 	'' byval screenflag as integer
 	astNewPARAM( proc, astNewCONST( screenflag, IR.DATATYPE.INTEGER ), INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxPalette ( byval attexpr as integer, byval colexpr as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


    f = ifuncTB(FB.RTL.GFXPALETTE)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ), 2 )

 	'' byval attr as uinteger
 	if( attexpr = INVALID ) then
        attexpr = astNewCONST( -1, IR.DATATYPE.UINT )
    end if
 	astNewPARAM( proc, attexpr, INVALID )

 	'' byval color as uinteger
 	if( colexpr = INVALID ) then
        colexpr = astNewCONST( -1, IR.DATATYPE.UINT )
    end if
 	astNewPARAM( proc, colexpr, INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxPaletteUsing ( byval arrayexpr as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


    f = ifuncTB(FB.RTL.GFXPALETTEUSING)
	proc = astNewFUNCT( f, symbGetFuncDataType( f ), 1 )

 	'' byref array as integer
 	astNewPARAM( proc, arrayexpr, INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxPut( byval xexpr as integer, byval yexpr as integer, byval arrayexpr as integer, byval mode as integer, byval coordtype as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	f = ifuncTB(FB.RTL.GFXPUT)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 5 )

 	'' byval x as single
 	astNewPARAM( proc, xexpr, INVALID )

 	'' byval y as single
 	astNewPARAM( proc, yexpr, INVALID )

 	'' byref array as any
 	astNewPARAM( proc, arrayexpr, INVALID )

 	'' byval coordtype as integer
 	astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID )

 	'' byval mode as integer
 	astNewPARAM( proc, astNewCONST( mode, IR.DATATYPE.INTEGER ), INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxGet( byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, byval y2expr as integer, _
			   byval arrayexpr as integer, byval symbol as FBSYMBOL ptr, byval coordtype as integer )

    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer


	f = ifuncTB(FB.RTL.GFXGET)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 7 )

 	'' byval x1 as single
 	astNewPARAM( proc, x1expr, INVALID )

 	'' byval y1 as single
 	astNewPARAM( proc, y1expr, INVALID )

 	'' byval x2 as single
 	astNewPARAM( proc, x2expr, INVALID )

 	'' byval y2 as single
 	astNewPARAM( proc, y2expr, INVALID )

 	'' byref array as any
 	astNewPARAM( proc, arrayexpr, INVALID )

 	'' byval coordtype as integer
 	astNewPARAM( proc, astNewCONST( coordtype, IR.DATATYPE.INTEGER ), INVALID )

 	'' array() as any
 	arrayexpr = astNewVAR( symbol, 0, symbGetType( symbol ) )
 	astNewPARAM( proc, arrayexpr, INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub

'':::::
sub rtlGfxScreenSet( byval wexpr as integer, byval hexpr as integer, byval dexpr as integer, byval fexpr as integer )
    dim proc as integer, f as FBSYMBOL ptr
    dim vr as integer

	f = ifuncTB(FB.RTL.GFXSCREENSET)
    proc = astNewFUNCT( f, symbGetFuncDataType( f ), 4 )

 	'' byval w as integer
 	astNewPARAM( proc, wexpr, INVALID )

 	'' byval h as integer
 	if( hexpr = INVALID ) then
 		hexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )
 	end if
 	astNewPARAM( proc, hexpr, INVALID )

 	'' byval depth as integer
 	if( dexpr = INVALID ) then
 		dexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )
 	end if
 	astNewPARAM( proc, dexpr, INVALID )

 	'' byval fullscreen s integer
 	if( fexpr = INVALID ) then
 		fexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )
 	end if
 	astNewPARAM( proc, fexpr, INVALID )

 	''
 	astFlush proc, vr

 	''
#ifdef AUTOADDGFXLIBS
 	hAddGfxLibs
#endif

end sub
