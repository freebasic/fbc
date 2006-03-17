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


#include once "inc\ast.bi"
#include once "inc\fbint.bi"

'' NOTE: when adding any RTL proc that will be called from rtl*.bas,
'' always update the FB_RTL_IDX enum below

#define FB_RTL_STRCONCAT 				"fb_StrConcat"
#define FB_RTL_STRCOMPARE				"fb_StrCompare"
#define FB_RTL_STRASSIGN				"fb_StrAssign"
#define FB_RTL_STRCONCATASSIGN			"fb_StrConcatAssign"
#define FB_RTL_STRDELETE				"fb_StrDelete"
#define FB_RTL_STRALLOCTMPRES			"fb_StrAllocTempResult"
#define FB_RTL_STRALLOCTMPDESCV			"fb_StrAllocTempDescV"
#define FB_RTL_STRALLOCTMPDESCF			"fb_StrAllocTempDescF"
#define FB_RTL_STRALLOCTMPDESCZ			"fb_StrAllocTempDescZ"
#define FB_RTL_STRALLOCTMPDESCZEX		"fb_StrAllocTempDescZEx"

#define FB_RTL_INT2STR					"fb_IntToStr"
#define FB_RTL_UINT2STR					"fb_UIntToStr"
#define FB_RTL_LONGINT2STR				"fb_LongintToStr"
#define FB_RTL_ULONGINT2STR				"fb_ULongintToStr"
#define FB_RTL_FLT2STR					"fb_FloatToStr"
#define FB_RTL_DBL2STR					"fb_DoubleToStr"
#define FB_RTL_WSTR2STR					"fb_WstrToStr"

#define FB_RTL_STR2INT					"valint"
#define FB_RTL_STR2UINT					"valuint"
#define FB_RTL_STR2LNG					"vallng"
#define FB_RTL_STR2ULNG					"valulng"
#define FB_RTL_STR2DBL					"val"

#define FB_RTL_STRMID					"fb_StrMid"
#define FB_RTL_STRASSIGNMID				"fb_StrAssignMid"
#define FB_RTL_STRFILL1					"fb_StrFill1"
#define FB_RTL_STRFILL2 				"fb_StrFill2"
#define FB_RTL_STRLEN 					"fb_StrLen"
#define FB_RTL_STRLSET 					"fb_StrLset"
#define FB_RTL_STRASC 					"fb_ASC"
#define FB_RTL_STRCHR 					"fb_CHR"
#define FB_RTL_STRINSTR 				"fb_StrInstr"
#define FB_RTL_STRINSTRANY				"fb_StrInstrAny"
#define FB_RTL_STRTRIM 					"fb_TRIM"
#define FB_RTL_STRTRIMANY 				"fb_TrimAny"
#define FB_RTL_STRTRIMEX 				"fb_TrimEx"
#define FB_RTL_STRRTRIM 				"fb_RTRIM"
#define FB_RTL_STRRTRIMANY 				"fb_RTrimAny"
#define FB_RTL_STRRTRIMEX 				"fb_RTrimEx"
#define FB_RTL_STRLTRIM 				"fb_LTRIM"
#define FB_RTL_STRLTRIMANY 				"fb_LTrimAny"
#define FB_RTL_STRLTRIMEX 				"fb_LTrimEx"
#define FB_RTL_STRSWAP 					"fb_StrSwap"

#define FB_RTL_WSTRCONCAT 				"fb_WstrConcat"
#define FB_RTL_WSTRCONCATWA				"fb_WstrConcatWA"
#define FB_RTL_WSTRCONCATAW				"fb_WstrConcatAW"
#define FB_RTL_WSTRCOMPARE				"fb_WstrCompare"
#define FB_RTL_WSTRASSIGN				"fb_WstrAssign"
#define FB_RTL_WSTRASSIGNWA				"fb_WstrAssignFromA"
#define FB_RTL_WSTRASSIGNAW				"fb_WstrAssignToA"
#define FB_RTL_WSTRCONCATASSIGN			"fb_WstrConcatAssign"
#define FB_RTL_WSTRDELETE				"fb_WstrDelete"
#define FB_RTL_WSTRALLOC				"fb_WstrAlloc"

#define FB_RTL_INT2WSTR					"fb_IntToWstr"
#define FB_RTL_UINT2WSTR				"fb_UIntToWstr"
#define FB_RTL_LONGINT2WSTR				"fb_LongintToWstr"
#define FB_RTL_ULONGINT2WSTR			"fb_ULongintToWstr"
#define FB_RTL_FLT2WSTR					"fb_FloatToWstr"
#define FB_RTL_DBL2WSTR					"fb_DoubleToWstr"
#define FB_RTL_STR2WSTR					"fb_StrToWstr"

#define FB_RTL_WSTRMID					"fb_WstrMid"
#define FB_RTL_WSTRASSIGNMID			"fb_WstrAssignMid"
#define FB_RTL_WSTRFILL1				"fb_WstrFill1"
#define FB_RTL_WSTRFILL2 				"fb_WstrFill2"
#define FB_RTL_WSTRLEN 					"fb_WstrLen"
#define FB_RTL_WSTRLSET 				"fb_WstrLset"
#define FB_RTL_WSTRASC 					"fb_WstrAsc"
#define FB_RTL_WSTRCHR 					"fb_WstrChr"
#define FB_RTL_WSTRINSTR 				"fb_WstrInstr"
#define FB_RTL_WSTRINSTRANY				"fb_WstrInstrAny"
#define FB_RTL_WSTRTRIM 				"fb_WstrTrim"
#define FB_RTL_WSTRTRIMANY 				"fb_WstrTrimAny"
#define FB_RTL_WSTRTRIMEX 				"fb_WstrTrimEx"
#define FB_RTL_WSTRRTRIM 				"fb_WstrRTrim"
#define FB_RTL_WSTRRTRIMANY 			"fb_WstrRTrimAny"
#define FB_RTL_WSTRRTRIMEX 				"fb_WstrRTrimEx"
#define FB_RTL_WSTRLTRIM 				"fb_WstrLTrim"
#define FB_RTL_WSTRLTRIMANY 			"fb_WstrLTrimAny"
#define FB_RTL_WSTRLTRIMEX 				"fb_WstrLTrimEx"
#define FB_RTL_WSTRSWAP 				"fb_WstrSwap"

#define FB_RTL_LONGINTDIV				"__divdi3"
#define FB_RTL_ULONGINTDIV				"__udivdi3"
#define FB_RTL_LONGINTMOD				"__moddi3"
#define FB_RTL_ULONGINTMOD				"__umoddi3"
#define FB_RTL_DBL2ULONGINT				"__fixunsdfdi"

#define FB_RTL_ARRAYREDIM				"fb_ArrayRedim"
#define FB_RTL_ARRAYREDIMPRESV			"fb_ArrayRedimPresv"
#define FB_RTL_ARRAYERASE				"fb_ArrayErase"
#define FB_RTL_ARRAYCLEAR				"fb_ArrayClear"
#define FB_RTL_ARRAYLBOUND				"fb_ArrayLBound"
#define FB_RTL_ARRAYUBOUND				"fb_ArrayUBound"
#define FB_RTL_ARRAYSETDESC				"fb_ArraySetDesc"
#define FB_RTL_ARRAYSTRERASE			"fb_ArrayStrErase"
#define FB_RTL_ARRAYALLOCTMPDESC		"fb_ArrayAllocTempDesc"
#define FB_RTL_ARRAYFREETMPDESC			"fb_ArrayFreeTempDesc"
#define FB_RTL_ARRAYSNGBOUNDCHK			"fb_ArraySngBoundChk"
#define FB_RTL_ARRAYBOUNDCHK			"fb_ArrayBoundChk"

#define FB_RTL_NULLPTRCHK				"fb_NullPtrChk"

#define FB_RTL_CPUDETECT 				"fb_CpuDetect"
#define FB_RTL_INIT 					"fb_Init"
#define FB_RTL_RTINIT 					"fb_RtInit"
#define FB_RTL_INITSIGNALS 				"fb_InitSignals"
#define FB_RTL_INITPROFILE 				"fb_InitProfile"
#define FB_RTL_INITCTOR 				"fb_CallCTORS"
#define FB_RTL_INITCRTCTOR 				"__main"
#define FB_RTL_END 						"fb_End"

#define FB_RTL_DATARESTORE 				"fb_DataRestore"
#define FB_RTL_DATAREADSTR 				"fb_DataReadStr"
#define FB_RTL_DATAREADWSTR 			"fb_DataReadWstr"
#define FB_RTL_DATAREADBYTE 			"fb_DataReadByte"
#define FB_RTL_DATAREADSHORT 			"fb_DataReadShort"
#define FB_RTL_DATAREADINT 				"fb_DataReadInt"
#define FB_RTL_DATAREADLONGINT 			"fb_DataReadLongint"
#define FB_RTL_DATAREADUBYTE 			"fb_DataReadUByte"
#define FB_RTL_DATAREADUSHORT 			"fb_DataReadUShort"
#define FB_RTL_DATAREADUINT 			"fb_DataReadUInt"
#define FB_RTL_DATAREADPTR 				"fb_DataReadPtr"
#define FB_RTL_DATAREADULONGINT 		"fb_DataReadULongint"
#define FB_RTL_DATAREADSINGLE 			"fb_DataReadSingle"
#define FB_RTL_DATAREADDOUBLE 			"fb_DataReadDouble"

#define FB_RTL_POW 						"fb_Pow"
#define FB_RTL_SGNSINGLE 				"fb_SGNSingle"
#define FB_RTL_SGNDOUBLE 				"fb_SGNDouble"
#define FB_RTL_FIXSINGLE 				"fb_FIXSingle"
#define FB_RTL_FIXDOUBLE 				"fb_FIXDouble"
#define FB_RTL_ASIN 					"{asin}"
#define FB_RTL_ACOS 					"{acos}"
#define FB_RTL_LOG 						"{log}"

#define FB_RTL_PRINTVOID 				"fb_PrintVoid"
#define FB_RTL_PRINTBYTE 				"fb_PrintByte"
#define FB_RTL_PRINTUBYTE 				"fb_PrintUByte"
#define FB_RTL_PRINTSHORT 				"fb_PrintShort"
#define FB_RTL_PRINTUSHORT 				"fb_PrintUShort"
#define FB_RTL_PRINTINT 				"fb_PrintInt"
#define FB_RTL_PRINTUINT 				"fb_PrintUInt"
#define FB_RTL_PRINTLONGINT 			"fb_PrintLongint"
#define FB_RTL_PRINTULONGINT 			"fb_PrintULongint"
#define FB_RTL_PRINTSINGLE 				"fb_PrintSingle"
#define FB_RTL_PRINTDOUBLE 				"fb_PrintDouble"
#define FB_RTL_PRINTSTR 				"fb_PrintString"
#define FB_RTL_PRINTWSTR 				"fb_PrintWstr"

#define FB_RTL_LPRINTVOID 				"fb_LPrintVoid"
#define FB_RTL_LPRINTBYTE 				"fb_LPrintByte"
#define FB_RTL_LPRINTUBYTE 				"fb_LPrintUByte"
#define FB_RTL_LPRINTSHORT 				"fb_LPrintShort"
#define FB_RTL_LPRINTUSHORT 			"fb_LPrintUShort"
#define FB_RTL_LPRINTINT 				"fb_LPrintInt"
#define FB_RTL_LPRINTUINT 				"fb_LPrintUInt"
#define FB_RTL_LPRINTLONGINT 			"fb_LPrintLongint"
#define FB_RTL_LPRINTULONGINT 			"fb_LPrintULongint"
#define FB_RTL_LPRINTSINGLE 			"fb_LPrintSingle"
#define FB_RTL_LPRINTDOUBLE 			"fb_LPrintDouble"
#define FB_RTL_LPRINTSTR 				"fb_LPrintString"
#define FB_RTL_LPRINTWSTR 				"fb_LPrintWstr"

#define FB_RTL_PRINTSPC 				"fb_PrintSPC"
#define FB_RTL_PRINTTAB 				"fb_PrintTab"

#define FB_RTL_WRITEVOID 				"fb_WriteVoid"
#define FB_RTL_WRITEBYTE 				"fb_WriteByte"
#define FB_RTL_WRITEUBYTE 				"fb_WriteUByte"
#define FB_RTL_WRITESHORT 				"fb_WriteShort"
#define FB_RTL_WRITEUSHORT 				"fb_WriteUShort"
#define FB_RTL_WRITEINT 				"fb_WriteInt"
#define FB_RTL_WRITEUINT 				"fb_WriteUInt"
#define FB_RTL_WRITELONGINT 			"fb_WriteLongint"
#define FB_RTL_WRITEULONGINT 			"fb_WriteULongint"
#define FB_RTL_WRITESINGLE 				"fb_WriteSingle"
#define FB_RTL_WRITEDOUBLE 				"fb_WriteDouble"
#define FB_RTL_WRITESTR 				"fb_WriteString"
#define FB_RTL_WRITEWSTR 				"fb_WriteWstr"

#define FB_RTL_PRINTUSGINIT 			"fb_PrintUsingInit"
#define FB_RTL_PRINTUSGSTR 				"fb_PrintUsingStr"
#define FB_RTL_PRINTUSGWSTR 			"fb_PrintUsingWstr"
#define FB_RTL_PRINTUSG_SNG 			"fb_PrintUsingSingle"
#define FB_RTL_PRINTUSG_DBL 			"fb_PrintUsingDouble"
#define FB_RTL_PRINTUSGEND 				"fb_PrintUsingEnd"
#define FB_RTL_LPRINTUSGINIT 			"fb_LPrintUsingInit"

#define FB_RTL_LOCATE_FN 				"fb_Locate"
#define FB_RTL_LOCATE_SUB 				"fb_LocateSub"

#define FB_RTL_CONSOLEVIEW 				"fb_ConsoleView"
#define FB_RTL_CONSOLEREADXY 			"fb_ReadXY"

#define FB_RTL_MEMCOPY 					"fb_MemCopy"
#define FB_RTL_MEMSWAP 					"fb_MemSwap"
#define FB_RTL_MEMCOPYCLEAR 			"fb_MemCopyClear"

#define FB_RTL_FILEOPEN 				"fb_FileOpen"
#define FB_RTL_FILEOPEN_ENCOD			"fb_FileOpenEncod"
#define FB_RTL_FILEOPEN_SHORT 			"fb_FileOpenShort"
#define FB_RTL_FILEOPEN_CONS 			"fb_FileOpenCons"
#define FB_RTL_FILEOPEN_ERR 			"fb_FileOpenErr"
#define FB_RTL_FILEOPEN_PIPE 			"fb_FileOpenPipe"
#define FB_RTL_FILEOPEN_SCRN 			"fb_FileOpenScrn"
#define FB_RTL_FILEOPEN_LPT 			"fb_FileOpenLpt"
#define FB_RTL_FILEOPEN_COM 			"fb_FileOpenCom"
#define FB_RTL_FILECLOSE 				"fb_FileClose"

#define FB_RTL_FILEPUT 					"fb_FilePut"
#define FB_RTL_FILEPUTSTR 				"fb_FilePutStr"
#define FB_RTL_FILEPUTWSTR 				"fb_FilePutWstr"
#define FB_RTL_FILEPUTARRAY 			"fb_FilePutArray"

#define FB_RTL_FILEGET 					"fb_FileGet"
#define FB_RTL_FILEGETSTR 				"fb_FileGetStr"
#define FB_RTL_FILEGETWSTR 				"fb_FileGetWstr"
#define FB_RTL_FILEGETARRAY 			"fb_FileGetArray"

#define FB_RTL_FILETELL 				"fb_FileTell"
#define FB_RTL_FILESEEK 				"fb_FileSeek"

#define FB_RTL_FILESTRINPUT 			"fb_FileStrInput"
#define FB_RTL_FILELINEINPUT 			"fb_FileLineInput"
#define FB_RTL_FILELINEINPUTWSTR		"fb_FileLineInputWstr"
#define FB_RTL_CONSOLELINEINPUT 		"fb_LineInput"
#define FB_RTL_CONSOLELINEINPUTWSTR		"fb_LineInputWstr"

#define FB_RTL_FILEINPUT 				"fb_FileInput"
#define FB_RTL_CONSOLEINPUT 			"fb_ConsoleInput"
#define FB_RTL_INPUTBYTE 				"fb_InputByte"
#define FB_RTL_INPUTSHORT 				"fb_InputShort"
#define FB_RTL_INPUTINT 				"fb_InputInt"
#define FB_RTL_INPUTLONGINT 			"fb_InputLongint"
#define FB_RTL_INPUTSINGLE 				"fb_InputSingle"
#define FB_RTL_INPUTDOUBLE 				"fb_InputDouble"
#define FB_RTL_INPUTSTR 				"fb_InputString"
#define FB_RTL_INPUTWSTR 				"fb_InputWstr"

#define FB_RTL_FILELOCK 				"fb_FileLock"
#define FB_RTL_FILEUNLOCK 				"fb_FileUnlock"
#define FB_RTL_FILERENAME 				"rename"

#define FB_RTL_WIDTH 					"fb_Width"
#define FB_RTL_WIDTHDEV 				"fb_WidthDev"
#define FB_RTL_WIDTHFILE 				"fb_WidthFile"

#define FB_RTL_ERRORTHROW 				"fb_ErrorThrowAt"
#define FB_RTL_ERRORTHROWEX 			"fb_ErrorThrowEx"
#define FB_RTL_ERRORSETHANDLER 			"fb_ErrorSetHandler"
#define FB_RTL_ERRORGETNUM 				"fb_ErrorGetNum"
#define FB_RTL_ERRORSETNUM 				"fb_ErrorSetNum"
#define FB_RTL_ERRORRESUME 				"fb_ErrorResume"
#define FB_RTL_ERRORRESUMENEXT 			"fb_ErrorResumeNext"

#define FB_RTL_GFXPSET 					"fb_GfxPset"
#define FB_RTL_GFXPOINT 				"fb_GfxPoint"
#define FB_RTL_GFXLINE 					"fb_GfxLine"
#define FB_RTL_GFXCIRCLE 				"fb_GfxEllipse"
#define FB_RTL_GFXPAINT 				"fb_GfxPaint"
#define FB_RTL_GFXDRAW 					"fb_GfxDraw"
#define FB_RTL_GFXDRAWSTRING			"fb_GfxDrawString"
#define FB_RTL_GFXVIEW 					"fb_GfxView"
#define FB_RTL_GFXWINDOW 				"fb_GfxWindow"
#define FB_RTL_GFXPALETTE 				"fb_GfxPalette"
#define FB_RTL_GFXPALETTEUSING 			"fb_GfxPaletteUsing"
#define FB_RTL_GFXPALETTEGET 			"fb_GfxPaletteGet"
#define FB_RTL_GFXPALETTEGETUSING 		"fb_GfxPaletteGetUsing"
#define FB_RTL_GFXPUT 					"fb_GfxPut"
#define FB_RTL_GFXGET 					"fb_GfxGet"
#define FB_RTL_GFXSCREENSET 			"fb_GfxScreen"
#define FB_RTL_GFXSCREENRES 			"fb_GfxScreenRes"

#define FB_RTL_PROFILEBEGINCALL 		"fb_ProfileBeginCall"
#define FB_RTL_PROFILEENDCALL 			"fb_ProfileEndCall"
#define FB_RTL_PROFILEEND 				"fb_EndProfile"

'' the order doesn't matter but it makes more sense to follow the same
'' order as the FB_RTL_* defines above
enum FB_RTL_IDX
	FB_RTL_IDX_STRCONCAT
	FB_RTL_IDX_STRCOMPARE
	FB_RTL_IDX_STRASSIGN
	FB_RTL_IDX_STRCONCATASSIGN
	FB_RTL_IDX_STRDELETE
	FB_RTL_IDX_STRALLOCTMPRES
	FB_RTL_IDX_STRALLOCTMPDESCV
	FB_RTL_IDX_STRALLOCTMPDESCF
	FB_RTL_IDX_STRALLOCTMPDESCZ
	FB_RTL_IDX_STRALLOCTMPDESCZEX

	FB_RTL_IDX_INT2STR
	FB_RTL_IDX_UINT2STR
	FB_RTL_IDX_LONGINT2STR
	FB_RTL_IDX_ULONGINT2STR
	FB_RTL_IDX_FLT2STR
	FB_RTL_IDX_DBL2STR
	FB_RTL_IDX_WSTR2STR

	FB_RTL_IDX_STR2INT
	FB_RTL_IDX_STR2UINT
	FB_RTL_IDX_STR2LNG
	FB_RTL_IDX_STR2ULNG
	FB_RTL_IDX_STR2DBL

	FB_RTL_IDX_STRMID
	FB_RTL_IDX_STRASSIGNMID
	FB_RTL_IDX_STRFILL1
	FB_RTL_IDX_STRFILL2
	FB_RTL_IDX_STRLEN
	FB_RTL_IDX_STRLSET
	FB_RTL_IDX_STRASC
	FB_RTL_IDX_STRCHR
	FB_RTL_IDX_STRINSTR
	FB_RTL_IDX_STRINSTRANY
	FB_RTL_IDX_STRTRIM
	FB_RTL_IDX_STRTRIMANY
	FB_RTL_IDX_STRTRIMEX
	FB_RTL_IDX_STRRTRIM
	FB_RTL_IDX_STRRTRIMANY
	FB_RTL_IDX_STRRTRIMEX
	FB_RTL_IDX_STRLTRIM
	FB_RTL_IDX_STRLTRIMANY
	FB_RTL_IDX_STRLTRIMEX
	FB_RTL_IDX_STRSWAP

	FB_RTL_IDX_WSTRCONCAT
	FB_RTL_IDX_WSTRCONCATWA
	FB_RTL_IDX_WSTRCONCATAW
	FB_RTL_IDX_WSTRCOMPARE
	FB_RTL_IDX_WSTRASSIGN
	FB_RTL_IDX_WSTRASSIGNWA
	FB_RTL_IDX_WSTRASSIGNAW
	FB_RTL_IDX_WSTRCONCATASSIGN
	FB_RTL_IDX_WSTRDELETE
	FB_RTL_IDX_WSTRALLOC

	FB_RTL_IDX_INT2WSTR
	FB_RTL_IDX_UINT2WSTR
	FB_RTL_IDX_LONGINT2WSTR
	FB_RTL_IDX_ULONGINT2WSTR
	FB_RTL_IDX_FLT2WSTR
	FB_RTL_IDX_DBL2WSTR
	FB_RTL_IDX_STR2WSTR

	FB_RTL_IDX_WSTRMID
	FB_RTL_IDX_WSTRASSIGNMID
	FB_RTL_IDX_WSTRFILL1
	FB_RTL_IDX_WSTRFILL2
	FB_RTL_IDX_WSTRLEN
	FB_RTL_IDX_WSTRLSET
	FB_RTL_IDX_WSTRASC
	FB_RTL_IDX_WSTRCHR
	FB_RTL_IDX_WSTRINSTR
	FB_RTL_IDX_WSTRINSTRANY
	FB_RTL_IDX_WSTRTRIM
	FB_RTL_IDX_WSTRTRIMANY
	FB_RTL_IDX_WSTRTRIMEX
	FB_RTL_IDX_WSTRRTRIM
	FB_RTL_IDX_WSTRRTRIMANY
	FB_RTL_IDX_WSTRRTRIMEX
	FB_RTL_IDX_WSTRLTRIM
	FB_RTL_IDX_WSTRLTRIMANY
	FB_RTL_IDX_WSTRLTRIMEX
	FB_RTL_IDX_WSTRSWAP

	FB_RTL_IDX_LONGINTDIV
	FB_RTL_IDX_ULONGINTDIV
	FB_RTL_IDX_LONGINTMOD
	FB_RTL_IDX_ULONGINTMOD
	FB_RTL_IDX_DBL2ULONGINT

	FB_RTL_IDX_ARRAYREDIM
	FB_RTL_IDX_ARRAYREDIMPRESV
	FB_RTL_IDX_ARRAYERASE
	FB_RTL_IDX_ARRAYCLEAR
	FB_RTL_IDX_ARRAYLBOUND
	FB_RTL_IDX_ARRAYUBOUND
	FB_RTL_IDX_ARRAYSETDESC
	FB_RTL_IDX_ARRAYSTRERASE
	FB_RTL_IDX_ARRAYALLOCTMPDESC
	FB_RTL_IDX_ARRAYFREETMPDESC
	FB_RTL_IDX_ARRAYSNGBOUNDCHK
	FB_RTL_IDX_ARRAYBOUNDCHK

	FB_RTL_IDX_NULLPTRCHK

	FB_RTL_IDX_CPUDETECT
	FB_RTL_IDX_INIT
	FB_RTL_IDX_RTINIT
	FB_RTL_IDX_INITSIGNALS
	FB_RTL_IDX_INITPROFILE
	FB_RTL_IDX_INITCTOR
	FB_RTL_IDX_INITCRTCTOR
	FB_RTL_IDX_END

	FB_RTL_IDX_DATARESTORE
	FB_RTL_IDX_DATAREADSTR
	FB_RTL_IDX_DATAREADWSTR
	FB_RTL_IDX_DATAREADBYTE
	FB_RTL_IDX_DATAREADSHORT
	FB_RTL_IDX_DATAREADINT
	FB_RTL_IDX_DATAREADLONGINT
	FB_RTL_IDX_DATAREADUBYTE
	FB_RTL_IDX_DATAREADUSHORT
	FB_RTL_IDX_DATAREADUINT
	FB_RTL_IDX_DATAREADPTR
	FB_RTL_IDX_DATAREADULONGINT
	FB_RTL_IDX_DATAREADSINGLE
	FB_RTL_IDX_DATAREADDOUBLE

	FB_RTL_IDX_POW
	FB_RTL_IDX_SGNSINGLE
	FB_RTL_IDX_SGNDOUBLE
	FB_RTL_IDX_FIXSINGLE
	FB_RTL_IDX_FIXDOUBLE
	FB_RTL_IDX_ASIN
	FB_RTL_IDX_ACOS
	FB_RTL_IDX_LOG

	FB_RTL_IDX_PRINTVOID
	FB_RTL_IDX_PRINTBYTE
	FB_RTL_IDX_PRINTUBYTE
	FB_RTL_IDX_PRINTSHORT
	FB_RTL_IDX_PRINTUSHORT
	FB_RTL_IDX_PRINTINT
	FB_RTL_IDX_PRINTUINT
	FB_RTL_IDX_PRINTLONGINT
	FB_RTL_IDX_PRINTULONGINT
	FB_RTL_IDX_PRINTSINGLE
	FB_RTL_IDX_PRINTDOUBLE
	FB_RTL_IDX_PRINTSTR
	FB_RTL_IDX_PRINTWSTR

	FB_RTL_IDX_LPRINTVOID
	FB_RTL_IDX_LPRINTBYTE
	FB_RTL_IDX_LPRINTUBYTE
	FB_RTL_IDX_LPRINTSHORT
	FB_RTL_IDX_LPRINTUSHORT
	FB_RTL_IDX_LPRINTINT
	FB_RTL_IDX_LPRINTUINT
	FB_RTL_IDX_LPRINTLONGINT
	FB_RTL_IDX_LPRINTULONGINT
	FB_RTL_IDX_LPRINTSINGLE
	FB_RTL_IDX_LPRINTDOUBLE
	FB_RTL_IDX_LPRINTSTR
	FB_RTL_IDX_LPRINTWSTR

	FB_RTL_IDX_PRINTSPC
	FB_RTL_IDX_PRINTTAB

	FB_RTL_IDX_WRITEVOID
	FB_RTL_IDX_WRITEBYTE
	FB_RTL_IDX_WRITEUBYTE
	FB_RTL_IDX_WRITESHORT
	FB_RTL_IDX_WRITEUSHORT
	FB_RTL_IDX_WRITEINT
	FB_RTL_IDX_WRITEUINT
	FB_RTL_IDX_WRITELONGINT
	FB_RTL_IDX_WRITEULONGINT
	FB_RTL_IDX_WRITESINGLE
	FB_RTL_IDX_WRITEDOUBLE
	FB_RTL_IDX_WRITESTR
	FB_RTL_IDX_WRITEWSTR

	FB_RTL_IDX_PRINTUSGINIT
	FB_RTL_IDX_PRINTUSGSTR
	FB_RTL_IDX_PRINTUSGWSTR
	FB_RTL_IDX_PRINTUSG_SNG
	FB_RTL_IDX_PRINTUSG_DBL
	FB_RTL_IDX_PRINTUSGEND
	FB_RTL_IDX_LPRINTUSGINIT

	FB_RTL_IDX_LOCATE_FN
	FB_RTL_IDX_LOCATE_SUB

	FB_RTL_IDX_CONSOLEVIEW
	FB_RTL_IDX_CONSOLEREADXY

	FB_RTL_IDX_MEMCOPY
	FB_RTL_IDX_MEMSWAP
	FB_RTL_IDX_MEMCOPYCLEAR

	FB_RTL_IDX_FILEOPEN
	FB_RTL_IDX_FILEOPEN_ENCOD
	FB_RTL_IDX_FILEOPEN_SHORT
	FB_RTL_IDX_FILEOPEN_CONS
	FB_RTL_IDX_FILEOPEN_ERR
	FB_RTL_IDX_FILEOPEN_PIPE
	FB_RTL_IDX_FILEOPEN_SCRN
	FB_RTL_IDX_FILEOPEN_LPT
	FB_RTL_IDX_FILEOPEN_COM
	FB_RTL_IDX_FILECLOSE

	FB_RTL_IDX_FILEPUT
	FB_RTL_IDX_FILEPUTSTR
	FB_RTL_IDX_FILEPUTWSTR
	FB_RTL_IDX_FILEPUTARRAY

	FB_RTL_IDX_FILEGET
	FB_RTL_IDX_FILEGETSTR
	FB_RTL_IDX_FILEGETWSTR
	FB_RTL_IDX_FILEGETARRAY

	FB_RTL_IDX_FILETELL
	FB_RTL_IDX_FILESEEK

	FB_RTL_IDX_FILESTRINPUT
	FB_RTL_IDX_FILELINEINPUT
	FB_RTL_IDX_FILELINEINPUTWSTR
	FB_RTL_IDX_CONSOLELINEINPUT
	FB_RTL_IDX_CONSOLELINEINPUTWSTR

	FB_RTL_IDX_FILEINPUT
	FB_RTL_IDX_CONSOLEINPUT
	FB_RTL_IDX_INPUTBYTE
	FB_RTL_IDX_INPUTSHORT
	FB_RTL_IDX_INPUTINT
	FB_RTL_IDX_INPUTLONGINT
	FB_RTL_IDX_INPUTSINGLE
	FB_RTL_IDX_INPUTDOUBLE
	FB_RTL_IDX_INPUTSTR
	FB_RTL_IDX_INPUTWSTR

	FB_RTL_IDX_FILELOCK
	FB_RTL_IDX_FILEUNLOCK
	FB_RTL_IDX_FILERENAME

	FB_RTL_IDX_WIDTH
	FB_RTL_IDX_WIDTHDEV
	FB_RTL_IDX_WIDTHFILE

	FB_RTL_IDX_ERRORTHROW
	FB_RTL_IDX_ERRORTHROWEX
	FB_RTL_IDX_ERRORSETHANDLER
	FB_RTL_IDX_ERRORGETNUM
	FB_RTL_IDX_ERRORSETNUM
	FB_RTL_IDX_ERRORRESUME
	FB_RTL_IDX_ERRORRESUMENEXT

	FB_RTL_IDX_GFXPSET
	FB_RTL_IDX_GFXPOINT
	FB_RTL_IDX_GFXLINE
	FB_RTL_IDX_GFXCIRCLE
	FB_RTL_IDX_GFXPAINT
	FB_RTL_IDX_GFXDRAW
	FB_RTL_IDX_GFXDRAWSTRING
	FB_RTL_IDX_GFXVIEW
	FB_RTL_IDX_GFXWINDOW
	FB_RTL_IDX_GFXPALETTE
	FB_RTL_IDX_GFXPALETTEUSING
	FB_RTL_IDX_GFXPALETTEGET
	FB_RTL_IDX_GFXPALETTEGETUSING
	FB_RTL_IDX_GFXPUT
	FB_RTL_IDX_GFXGET
	FB_RTL_IDX_GFXSCREENSET
	FB_RTL_IDX_GFXSCREENRES

	FB_RTL_IDX_PROFILEBEGINCALL
	FB_RTL_IDX_PROFILEENDCALL
	FB_RTL_IDX_PROFILEEND

	FB_RTL_INDEXES
end enum

declare sub 		rtlInit				( )

declare sub 		rtlEnd				( )

declare sub 		rtlAddIntrinsicProcs( )

declare function 	rtlProcLookup		( byval pname as zstring ptr, _
			   							  byval pidx as integer ) as FBSYMBOL ptr

declare function 	rtlCalcExprLen		( byval expr as ASTNODE ptr, _
						 				  byval realsize as integer = TRUE ) as integer

declare function 	rtlCalcStrLen		( byval expr as ASTNODE ptr, _
										  byval dtype as integer ) as integer

declare function 	rtlStrCompare 		( byval str1 as ASTNODE ptr, _
										  byval sdtype1 as integer, _
					     			  	  byval str2 as ASTNODE ptr, _
					     			  	  byval sdtype2 as integer ) as ASTNODE ptr

declare function 	rtlWstrCompare		( byval str1 as ASTNODE ptr, _
					     				  byval str2 as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrConcat		( byval str1 as ASTNODE ptr, _
										  byval sdtype1 as integer, _
					   				  	  byval str2 as ASTNODE ptr, _
					   				  	  byval sdtype2 as integer ) as ASTNODE ptr

declare function 	rtlWstrConcat		( byval str1 as ASTNODE ptr, _
					    				  byval sdtype1 as integer, _
					    				  byval str2 as ASTNODE ptr, _
					    				  byval sdtype2 as integer ) as ASTNODE ptr

declare function 	rtlStrAssign		( byval dst as ASTNODE ptr, _
										  byval src as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlWstrAssign		( byval dst as ASTNODE ptr, _
					    				  byval src as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrConcatAssign	( byval dst as ASTNODE ptr, _
										  byval src as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlWstrConcatAssign	( byval dst as ASTNODE ptr, _
							 			  byval src as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrDelete		( byval strg as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrAllocTmpResult( byval strg as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrAllocTmpDesc	( byval strg as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlWstrAlloc		( byval lenexpr as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlToStr			( byval expr as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlToWstr			( byval expr as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrToVal			( byval expr as ASTNODE ptr, _
					  					  byval to_dtype as integer ) as ASTNODE ptr

declare function 	rtlStrMid			( byval expr1 as ASTNODE ptr, _
										  byval expr2 as ASTNODE ptr, _
										  byval expr3 as ASTNODE ptr ) as ASTNODE ptr

declare function	rtlStrAssignMid		( byval expr1 as ASTNODE ptr, _
										  byval expr2 as ASTNODE ptr, _
										  byval expr3 as ASTNODE ptr, _
										  byval expr4 as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrLSet			( byval dstexpr as ASTNODE ptr, _
					 					  byval srcexpr as ASTNODE ptr ) as integer

declare function 	rtlStrFill			( byval expr1 as ASTNODE ptr, _
										  byval expr2 as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlWstrFill			( byval expr1 as ASTNODE ptr, _
										  byval expr2 as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrAsc			( byval expr as ASTNODE ptr, _
										  byval posexpr as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrChr			( byval args as integer, _
										  exprtb() as ASTNODE ptr, _
										  byval is_wstr as integer ) as ASTNODE ptr

declare function    rtlStrInstr         ( byval nd_start as ASTNODE ptr, _
					                      byval nd_text as ASTNODE ptr, _
					                      byval nd_pattern as ASTNODE ptr, _
                                          byval search_any as integer ) as ASTNODE ptr

declare function    rtlStrTrim          ( byval nd_text as ASTNODE ptr, _
					                      byval nd_pattern as ASTNODE ptr, _
                                          byval is_any as integer ) as ASTNODE ptr

declare function    rtlStrRTrim         ( byval nd_text as ASTNODE ptr, _
					                      byval nd_pattern as ASTNODE ptr, _
                                          byval is_any as integer ) as ASTNODE ptr

declare function    rtlStrLTrim         ( byval nd_text as ASTNODE ptr, _
					                      byval nd_pattern as ASTNODE ptr, _
                                          byval is_any as integer ) as ASTNODE ptr

declare function	rtlArrayRedim		( byval s as FBSYMBOL ptr, _
										  byval elementlen as integer, _
									  	  byval dimensions as integer, _
									  	  exprTB() as ASTNODE ptr, _
									  	  byval dopreserve as integer ) as integer

declare function	rtlArrayErase		( byval arrayexpr as ASTNODE ptr ) as integer

declare function	rtlArrayClear		( byval arrayexpr as ASTNODE ptr ) as integer

declare function 	rtlArrayBound		( byval sexpr as ASTNODE ptr, _
										  byval dimexpr as ASTNODE ptr, _
										  byval islbound as integer ) as ASTNODE ptr

declare function	rtlArraySetDesc		( byval s as FBSYMBOL ptr, _
										  byval elementlen as integer, _
										  byval dimensions as integer, _
										  dTB() as FBARRAYDIM ) as integer

declare function 	rtlArrayStrErase	( byval s as FBSYMBOL ptr ) as integer

declare function 	rtlArrayAllocTmpDesc( byval arrayexpr as ASTNODE ptr, _
										  byval pdesc as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	rtlArrayFreeTempDesc( byval pdesc as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	rtlArrayBoundsCheck	( byval idx as ASTNODE ptr, _
							  			  byval lb as ASTNODE ptr, _
							  			  byval rb as ASTNODE ptr, _
							  			  byval linenum as integer, _
							  			  byval module as zstring ptr ) as ASTNODE ptr

declare function 	rtlNullPtrCheck		( byval p as ASTNODE ptr, _
							  			  byval linenum as integer, _
							  			  byval module as zstring ptr ) as ASTNODE ptr

declare function	rtlDataRestore		( byval label as FBSYMBOL ptr, _
										  byval afternode as ASTNODE ptr = NULL, _
										  byval isprofiler as integer = FALSE ) as integer

declare function	rtlDataRead			( byval varexpr as ASTNODE ptr ) as integer

declare sub 		rtlDataStoreBegin	( )

declare function	rtlDataStore		( byval littext as zstring ptr, _
										  byval litlen as integer, _
										  byval typ as integer ) as integer

declare function 	rtlDataStoreW		( byval littext as wstring ptr, _
					    				  byval litlen as integer, _
					    				  byval typ as integer ) as integer

declare function 	rtlDataStoreOFS		( byval sym as FBSYMBOL ptr ) as integer

declare sub 		rtlDataStoreEnd		( )

declare function 	rtlMathPow			( byval xexpr as ASTNODE ptr, _
					  					  byval yexpr as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlMathFSGN 		( byval expr as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlMathFIX 			( byval expr as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlMathTRANS		( byval op as integer, _
					   					  byval expr as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlMathLen			( byval expr as ASTNODE ptr, _
										  byval checkstrings as integer = TRUE ) as ASTNODE ptr

declare function 	rtlMathLongintCMP	( byval op as integer, _
										  byval dtype as integer, _
										  byval lexpr as ASTNODE ptr, _
										  byval ldtype as integer, _
					        			  byval rexpr as ASTNODE ptr, _
					        			  byval rdtype as integer ) as ASTNODE ptr

declare function 	rtlMathLongintDIV	( byval dtype as integer, _
										  byval lexpr as ASTNODE ptr, _
										  byval ldtype as integer, _
					        			  byval rexpr as ASTNODE ptr, _
					        			  byval rdtype as integer ) as ASTNODE ptr

declare function 	rtlMathLongintMUL	( byval dtype as integer, _
										  byval lexpr as ASTNODE ptr, _
										  byval ldtype as integer, _
					        			  byval rexpr as ASTNODE ptr, _
					        			  byval rdtype as integer ) as ASTNODE ptr

declare function 	rtlMathLongintMOD	( byval dtype as integer, _
										  byval lexpr as ASTNODE ptr, _
										  byval ldtype as integer, _
					        			  byval rexpr as ASTNODE ptr, _
					        			  byval rdtype as integer ) as ASTNODE ptr

declare function 	rtlMathFp2ULongint	( byval expr as ASTNODE ptr, _
										  byval dtype as integer ) as ASTNODE ptr

declare function    rtlInitMain         ( ) as integer

declare function 	rtlInitApp			( byval argc as ASTNODE ptr, _
										  byval argv as ASTNODE ptr, _
										  byval isdllmain as integer ) as ASTNODE ptr

declare function 	rtlInitRt			( ) as ASTNODE ptr

declare function	rtlExitApp			( byval errlevel as ASTNODE ptr ) as integer

declare function 	rtlMemCopy			( byval dst as ASTNODE ptr, _
										  byval src as ASTNODE ptr, _
										  byval bytes as integer ) as ASTNODE ptr

declare function	rtlMemSwap			( byval dst as ASTNODE ptr, _
										  byval src as ASTNODE ptr ) as integer

declare function	rtlStrSwap			( byval str1 as ASTNODE ptr, _
										  byval str2 as ASTNODE ptr ) as integer

declare function	rtlWstrSwap			( byval str1 as ASTNODE ptr, _
										  byval str2 as ASTNODE ptr ) as integer

declare function 	rtlMemCopyClear		( byval dstexpr as ASTNODE ptr, _
					      				  byval dstlen as integer, _
					      				  byval srcexpr as ASTNODE ptr, _
					      				  byval srclen as integer ) as integer

declare function	rtlPrint			( byval fileexpr as ASTNODE ptr, _
										  byval iscomma as integer, _
										  byval issemicolon as integer, _
										  byval expr as ASTNODE ptr, _
                                          byval islprint as integer = FALSE ) as integer

declare function	rtlPrintSPC			( byval fileexpr as ASTNODE ptr, _
										  byval expr as ASTNODE ptr, _
                                          byval islprint as integer = FALSE ) as integer

declare function	rtlPrintTab			( byval fileexpr as ASTNODE ptr, _
										  byval expr as ASTNODE ptr, _
                                          byval islprint as integer = FALSE ) as integer

declare function	rtlWrite			( byval fileexpr as ASTNODE ptr, _
										  byval iscomma as integer, _
										  byval expr as ASTNODE ptr ) as integer

declare function	rtlPrintUsingInit	( byval usingexpr as ASTNODE ptr, _
                                          byval islprint as integer = FALSE ) as integer

declare function	rtlPrintUsingEnd	( byval fileexpr as ASTNODE ptr, _
                                          byval islprint as integer = FALSE ) as integer

declare function	rtlPrintUsing		( byval fileexpr as ASTNODE ptr, _
										  byval expr as ASTNODE ptr, _
										  byval iscomma as integer, _
										  byval issemicolon as integer, _
                                          byval islprint as integer = FALSE ) as integer

declare function	rtlFileOpen			( byval filename as ASTNODE ptr, _
										  byval fmode as ASTNODE ptr, _
										  byval faccess as ASTNODE ptr, _
										  byval flock as ASTNODE ptr, _
										  byval filenum as ASTNODE ptr, _
										  byval flen as ASTNODE ptr, _
										  byval fencoding as ASTNODE ptr, _
										  byval isfunc as integer, _
                                          byval openkind as FBOPENKIND ) as ASTNODE ptr

declare function	rtlFileOpenShort	( byval filename as ASTNODE ptr, _
										  byval fmode as ASTNODE ptr, _
										  byval faccess as ASTNODE ptr, _
										  byval flock as ASTNODE ptr, _
										  byval filenum as ASTNODE ptr, _
										  byval flen as ASTNODE ptr, _
										  byval isfunc as integer ) as ASTNODE ptr

declare function	rtlFileRename		( byval filename_new as ASTNODE ptr, _
										  byval filename_old as ASTNODE ptr, _
                                          byval isfunc as integer ) as ASTNODE ptr

declare function    rtlWidthScreen      ( byval width_arg as ASTNODE ptr, _
                                          byval height_arg as ASTNODE ptr, _
                                          byval isfunc as integer ) as ASTNODE ptr
declare function    rtlWidthDev         ( byval device as ASTNODE ptr, _
                                          byval width_arg as ASTNODE ptr, _
                                          byval isfunc as integer ) as ASTNODE ptr
declare function    rtlWidthFile        ( byval fnum as ASTNODE ptr, _
                                          byval width_arg as ASTNODE ptr, _
                                          byval isfunc as integer ) as ASTNODE ptr

declare function	rtlFileClose		( byval filenum as ASTNODE ptr, _
										  byval isfunc as integer ) as ASTNODE ptr

declare function	rtlFileSeek			( byval filenum as ASTNODE ptr, _
										  byval newpos as ASTNODE ptr ) as integer

declare function 	rtlFileTell			( byval filenum as ASTNODE ptr ) as ASTNODE ptr

declare function	rtlFilePut			( byval filenum as ASTNODE ptr, _
										  byval offset as ASTNODE ptr, _
										  byval src as ASTNODE ptr, _
										  byval bytes as ASTNODE ptr, _
										  byval isfunc as integer ) as ASTNODE ptr

declare function	rtlFilePutArray		( byval filenum as ASTNODE ptr, _
										  byval offset as ASTNODE ptr, _
										  byval src as ASTNODE ptr, _
										  byval isfunc as integer ) as ASTNODE ptr

declare function	rtlFileGet			( byval filenum as ASTNODE ptr, _
										  byval offset as ASTNODE ptr, _
										  byval dst as ASTNODE ptr, _
										  byval bytes as ASTNODE ptr, _
										  byval isfunc as integer ) as ASTNODE ptr

declare function	rtlFileGetArray		( byval filenum as ASTNODE ptr, _
										  byval offset as ASTNODE ptr, _
										  byval dst as ASTNODE ptr, _
										  byval isfunc as integer ) as ASTNODE ptr

declare function 	rtlFileStrInput		( byval bytesexpr as ASTNODE ptr, _
										  byval filenum as ASTNODE ptr ) as ASTNODE ptr

declare function	rtlFileLineInput	( byval isfile as integer, _
										  byval expr as ASTNODE ptr, _
										  byval dstexpr as ASTNODE ptr, _
										  byval addquestion as integer, _
										  byval addnewline as integer ) as integer

declare function 	rtlFileLineInputWstr( byval isfile as integer, _
						   	   			  byval expr as ASTNODE ptr, _
						   	   			  byval dstexpr as ASTNODE ptr, _
					       	   			  byval addquestion as integer, _
					       	   			  byval addnewline as integer ) as integer

declare function	rtlFileInput		( byval isfile as integer, _
										  byval expr as ASTNODE ptr, _
										  byval addquestion as integer, _
										  byval addnewline as integer ) as integer

declare function	rtlFileInputGet		( byval dstexpr as ASTNODE ptr ) as integer

declare function	rtlFileLock			( byval islock as integer, _
										  byval filenum as ASTNODE ptr, _
										  byval iniexpr as ASTNODE ptr, _
										  byval endexpr as ASTNODE ptr ) as integer

declare function	rtlErrorCheck		( byval resexpr as ASTNODE ptr, _
										  byval reslabel as FBSYMBOL ptr, _
										  byval linenum as integer ) as integer

declare sub 		rtlErrorThrow		( byval errexpr as ASTNODE ptr, _
										  byval linenum as integer, _
										  byval module as zstring ptr )

declare sub 		rtlErrorSetHandler	( byval newhandler as ASTNODE ptr, _
										  byval savecurrent as integer )

declare function	rtlErrorGetNum		( ) as ASTNODE ptr

declare sub 		rtlErrorSetNum		( byval errexpr as ASTNODE ptr )

declare sub 		rtlErrorResume		( byval isnext as integer )

declare function	rtlConsoleView		( byval topexpr as ASTNODE ptr, _
										  byval botexpr as ASTNODE ptr ) as ASTNODE ptr

declare function    rtlLocate           ( byval row_arg as ASTNODE ptr, _
                                          byval col_arg as ASTNODE ptr, _
                                          byval cursor_vis_arg as ASTNODE ptr, _
                                          byval isfunc as integer ) as ASTNODE ptr

declare function	rtlConsoleReadXY	( byval rowexpr as ASTNODE ptr, _
										  byval columnexpr as ASTNODE ptr, _
										  byval colorflagexpr as ASTNODE ptr ) as ASTNODE ptr

declare function	rtlGfxPset			( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval xexpr as ASTNODE ptr, _
										  byval yexpr as ASTNODE ptr, _
										  byval cexpr as ASTNODE ptr, _
										  byval coordtype as integer, _
										  byval ispreset as integer ) as integer

declare function	rtlGfxPoint			( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval xexpr as ASTNODE ptr, _
										  byval yexpr as ASTNODE ptr ) as ASTNODE ptr

declare function	rtlGfxLine			( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval x1expr as ASTNODE ptr, _
										  byval y1expr as ASTNODE ptr, _
										  byval x2expr as ASTNODE ptr, _
										  byval y2expr as ASTNODE ptr, _
										  byval cexpr as ASTNODE ptr, _
										  byval linetype as integer, _
										  byval styleexpr as ASTNODE ptr, _
										  byval coordtype as integer ) as integer

declare function	rtlGfxCircle		( byval target as ASTNODE ptr, _
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

declare function	rtlGfxPaint			( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval xexpr as ASTNODE ptr, _
										  byval yexpr as ASTNODE ptr, _
										  byval pexpr as ASTNODE ptr, _
										  byval bexpr as ASTNODE ptr, _
									 	  byval coord_type as integer ) as integer

declare function	rtlGfxDraw			( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval cexpr as ASTNODE ptr )

declare function	rtlGfxDrawString	( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval xexpr as ASTNODE ptr, _
										  byval texpr as ASTNODE ptr, _
										  byval sexpr as ASTNODE ptr, _
										  byval cexpr as ASTNODE ptr, _
										  byval fexpr as ASTNODE ptr, _
										  byval fisptr as integer, _
										  byval coord_type as integer, _
										  byval mode as integer, _
										  byval alphaexpr as ASTNODE ptr, _
										  byval funcexpr as ASTNODE ptr ) as integer

declare function	rtlGfxView			( byval x1expr as ASTNODE ptr, _
										  byval y1expr as ASTNODE ptr, _
										  byval x2expr as ASTNODE ptr, _
										  byval y2expr as ASTNODE ptr, _
			    						  byval fillexpr as ASTNODE ptr, _
			    						  byval bordexpr as ASTNODE ptr, _
			    						  byval screenflag as integer ) as integer

declare function	rtlGfxWindow		( byval x1expr as ASTNODE ptr, _
										  byval y1expr as ASTNODE ptr, _
										  byval x2expr as ASTNODE ptr, _
										  byval y2expr as ASTNODE ptr, _
			    						  byval screenflag as integer ) as integer

declare function	rtlGfxPalette 		( byval attexpr as ASTNODE ptr, _
										  byval rexpr as ASTNODE ptr, _
										  byval gexpr as ASTNODE ptr, _
										  byval bexpr as ASTNODE ptr, _
										  byval isget as integer ) as integer

declare function	rtlGfxPaletteUsing	( byval arrayexpr as ASTNODE ptr, _
										  byval isptr as integer, _
										  byval isget as integer ) as integer

declare function 	rtlGfxPut			( byval target as ASTNODE ptr, _
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

declare function	rtlGfxGet			( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval x1expr as ASTNODE ptr, _
										  byval y1expr as ASTNODE ptr, _
										  byval x2expr as ASTNODE ptr, _
										  byval y2expr as ASTNODE ptr, _
										  byval arrayexpr as ASTNODE ptr, _
										  byval isptr as integer, _
										  byval symbol as FBSYMBOL ptr, _
										  byval coordtype as integer ) as integer

declare function	rtlGfxScreenSet		( byval wexpr as ASTNODE ptr, _
										  byval hexpr as ASTNODE ptr, _
										  byval dexpr as ASTNODE ptr, _
										  byval pexpr as ASTNODE ptr, _
										  byval fexpr as ASTNODE ptr, _
										  byval rexpr as ASTNODE ptr ) as integer

declare function	rtlProfileBeginCall ( byval symbol as FBSYMBOL ptr ) as ASTNODE ptr

declare function	rtlProfileEndCall	( ) as ASTNODE ptr


declare function 	rtlMultinput_cb		( byval sym as FBSYMBOL ptr ) as integer

declare function    rtlPrinter_cb       ( byval sym as FBSYMBOL ptr ) as integer

''
'' macros
''

#define PROCLOOKUP(id) rtlProcLookup( strptr( FB_RTL_##id ), FB_RTL_IDX_##id )



