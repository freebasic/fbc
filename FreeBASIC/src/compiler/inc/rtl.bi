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

enum FBRTL_ENUM
	FB_RTL_STRCONCAT
	FB_RTL_STRCOMPARE
	FB_RTL_STRASSIGN
	FB_RTL_STRCONCATASSIGN
	FB_RTL_STRDELETE
	FB_RTL_STRALLOCTMPRES
	FB_RTL_STRALLOCTMPDESCV
	FB_RTL_STRALLOCTMPDESCF
	FB_RTL_STRALLOCTMPDESCZ

	FB_RTL_LONGINTDIV
	FB_RTL_ULONGINTDIV
	FB_RTL_LONGINTMOD
	FB_RTL_ULONGINTMOD
	FB_RTL_DBL2ULONGINT

	FB_RTL_ARRAYREDIM
	FB_RTL_ARRAYREDIMPRESV
	FB_RTL_ARRAYERASE
	FB_RTL_ARRAYCLEAR
	FB_RTL_ARRAYLBOUND
	FB_RTL_ARRAYUBOUND
	FB_RTL_ARRAYSETDESC
	FB_RTL_ARRAYSTRERASE
	FB_RTL_ARRAYALLOCTMPDESC
	FB_RTL_ARRAYFREETMPDESC

	FB_RTL_ARRAYSNGBOUNDCHK
    FB_RTL_ARRAYBOUNDCHK
    FB_RTL_NULLPTRCHK

	FB_RTL_INT2STR
	FB_RTL_UINT2STR
	FB_RTL_LONGINT2STR
	FB_RTL_ULONGINT2STR
	FB_RTL_FLT2STR
	FB_RTL_DBL2STR

	FB_RTL_STRMID
	FB_RTL_STRASSIGNMID
	FB_RTL_STRFILL1
	FB_RTL_STRFILL2
	FB_RTL_STRLEN
	FB_RTL_STRLSET
	FB_RTL_STRASC
	FB_RTL_STRCHR
    FB_RTL_STRINSTR
    FB_RTL_STRINSTRANY
    FB_RTL_STRRTRIM
    FB_RTL_STRRTRIMANY
    FB_RTL_STRLTRIM
    FB_RTL_STRLTRIMANY

	FB_RTL_INIT
	FB_RTL_INITSIGNALS
	FB_RTL_INITPROFILE
	FB_RTL_END

	FB_RTL_DATARESTORE
	FB_RTL_DATAREADSTR
	FB_RTL_DATAREADBYTE
	FB_RTL_DATAREADSHORT
	FB_RTL_DATAREADINT
	FB_RTL_DATAREADLONGINT
	FB_RTL_DATAREADUBYTE
	FB_RTL_DATAREADUSHORT
	FB_RTL_DATAREADUINT
	FB_RTL_DATAREADULONGINT
	FB_RTL_DATAREADSINGLE
	FB_RTL_DATAREADDOUBLE

	FB_RTL_POW
	FB_RTL_SGNSINGLE
	FB_RTL_SGNDOUBLE
	FB_RTL_FIXSINGLE
	FB_RTL_FIXDOUBLE
	FB_RTL_ASIN
	FB_RTL_ACOS
	FB_RTL_LOG

	FB_RTL_PRINTVOID
	FB_RTL_PRINTBYTE
	FB_RTL_PRINTUBYTE
	FB_RTL_PRINTSHORT
	FB_RTL_PRINTUSHORT
	FB_RTL_PRINTINT
	FB_RTL_PRINTUINT
	FB_RTL_PRINTLONGINT
	FB_RTL_PRINTULONGINT
	FB_RTL_PRINTSINGLE
	FB_RTL_PRINTDOUBLE
	FB_RTL_PRINTSTR

	FB_RTL_LPRINTVOID
	FB_RTL_LPRINTBYTE
	FB_RTL_LPRINTUBYTE
	FB_RTL_LPRINTSHORT
	FB_RTL_LPRINTUSHORT
	FB_RTL_LPRINTINT
	FB_RTL_LPRINTUINT
	FB_RTL_LPRINTLONGINT
	FB_RTL_LPRINTULONGINT
	FB_RTL_LPRINTSINGLE
	FB_RTL_LPRINTDOUBLE
	FB_RTL_LPRINTSTR

	FB_RTL_PRINTSPC
	FB_RTL_PRINTTAB

	FB_RTL_WRITEVOID
	FB_RTL_WRITEBYTE
	FB_RTL_WRITEUBYTE
	FB_RTL_WRITESHORT
	FB_RTL_WRITEUSHORT
	FB_RTL_WRITEINT
	FB_RTL_WRITEUINT
	FB_RTL_WRITELONGINT
	FB_RTL_WRITEULONGINT
	FB_RTL_WRITESINGLE
	FB_RTL_WRITEDOUBLE
	FB_RTL_WRITESTR

	FB_RTL_PRINTUSGINIT
	FB_RTL_PRINTUSGSTR
	FB_RTL_PRINTUSGVAL
	FB_RTL_PRINTUSGEND

	FB_RTL_LPRINTUSGINIT

	FB_RTL_CONSOLEVIEW
	FB_RTL_CONSOLEREADXY

	FB_RTL_MEMCOPY
	FB_RTL_MEMSWAP
	FB_RTL_STRSWAP
	FB_RTL_MEMCOPYCLEAR

	FB_RTL_FILEOPEN
	FB_RTL_FILEOPEN_SHORT
	FB_RTL_FILEOPEN_CONS
	FB_RTL_FILEOPEN_ERR
	FB_RTL_FILEOPEN_PIPE
	FB_RTL_FILEOPEN_SCRN
	FB_RTL_FILEOPEN_LPT
	FB_RTL_FILECLOSE
	FB_RTL_FILEPUT
	FB_RTL_FILEPUTSTR
	FB_RTL_FILEPUTARRAY
	FB_RTL_FILEGET
	FB_RTL_FILEGETSTR
	FB_RTL_FILEGETARRAY
	FB_RTL_FILETELL
	FB_RTL_FILESEEK
	FB_RTL_FILESTRINPUT

	FB_RTL_FILELINEINPUT
	FB_RTL_CONSOLELINEINPUT

	FB_RTL_FILEINPUT
	FB_RTL_CONSOLEINPUT

	FB_RTL_INPUTBYTE
	FB_RTL_INPUTSHORT
	FB_RTL_INPUTINT
	FB_RTL_INPUTLONGINT
	FB_RTL_INPUTSINGLE
	FB_RTL_INPUTDOUBLE
	FB_RTL_INPUTSTR

	FB_RTL_FILELOCK
	FB_RTL_FILEUNLOCK

    FB_RTL_FILERENAME

    FB_RTL_WIDTH
    FB_RTL_WIDTHDEV
    FB_RTL_WIDTHFILE

	FB_RTL_ERRORTHROW
	FB_RTL_ERRORTHROWEX
	FB_RTL_ERRORSETHANDLER
	FB_RTL_ERRORGETNUM
	FB_RTL_ERRORSETNUM
	FB_RTL_ERRORRESUME
	FB_RTL_ERRORRESUMENEXT

	FB_RTL_GFXPSET
	FB_RTL_GFXPOINT
	FB_RTL_GFXLINE
	FB_RTL_GFXCIRCLE
	FB_RTL_GFXPAINT
	FB_RTL_GFXDRAW
	FB_RTL_GFXVIEW
	FB_RTL_GFXWINDOW
	FB_RTL_GFXPALETTE
	FB_RTL_GFXPALETTEUSING
	FB_RTL_GFXPALETTEGET
	FB_RTL_GFXPALETTEGETUSING
	FB_RTL_GFXPUT
	FB_RTL_GFXGET
	FB_RTL_GFXSCREENSET
	FB_RTL_GFXSCREENRES

	FB_RTL_PROFILEBEGINCALL
	FB_RTL_PROFILEENDCALL
	FB_RTL_PROFILEEND
end enum

const FB_RTL_MAXFUNCTIONS		= 512


declare sub 		rtlInit				( )

declare sub 		rtlEnd				( )

declare function 	rtlStrCompare 		( byval str1 as ASTNODE ptr, _
										  byval sdtype1 as integer, _
					     			  	  byval str2 as ASTNODE ptr, _
					     			  	  byval sdtype2 as integer ) as ASTNODE ptr

declare function 	rtlStrConcat		( byval str1 as ASTNODE ptr, _
										  byval sdtype1 as integer, _
					   				  	  byval str2 as ASTNODE ptr, _
					   				  	  byval sdtype2 as integer ) as ASTNODE ptr

declare function 	rtlStrAssign		( byval dst as ASTNODE ptr, _
										  byval src as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrConcatAssign	( byval dst as ASTNODE ptr, _
										  byval src as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrDelete		( byval strg as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrAllocTmpResult( byval strg as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrAllocTmpDesc	( byval strg as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlToStr			( byval expr as ASTNODE ptr ) as ASTNODE ptr

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

declare function 	rtlStrAsc			( byval expr as ASTNODE ptr, _
										  byval posexpr as ASTNODE ptr ) as ASTNODE ptr

declare function 	rtlStrChr			( byval args as integer, _
										  exprtb() as ASTNODE ptr ) as ASTNODE ptr

declare function    rtlStrInstr         ( byval nd_start as ASTNODE ptr, _
					                      byval nd_text as ASTNODE ptr, _
					                      byval nd_pattern as ASTNODE ptr, _
                                          byval search_any as integer ) as ASTNODE ptr

declare function    rtlStrRTrim         ( byval nd_text as ASTNODE ptr, _
					                      byval nd_pattern as ASTNODE ptr ) as ASTNODE ptr

declare function    rtlStrLTrim         ( byval nd_text as ASTNODE ptr, _
					                      byval nd_pattern as ASTNODE ptr ) as ASTNODE ptr

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
							  			  byval linenum as integer ) as ASTNODE ptr

declare function 	rtlNullPtrCheck		( byval p as ASTNODE ptr, _
							  			  byval linenum as integer ) as ASTNODE ptr

declare function	rtlDataRestore		( byval label as FBSYMBOL ptr, _
										  byval afternode as ASTNODE ptr = NULL, _
										  byval isprofiler as integer = FALSE ) as integer

declare function	rtlDataRead			( byval varexpr as ASTNODE ptr ) as integer

declare sub 		rtlDataStoreBegin	( )

declare function	rtlDataStore		( byval littext as string, _
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

declare function 	rtlInitRt			( byval argc as ASTNODE ptr, _
										  byval argv as ASTNODE ptr, _
										  byval isdllmain as integer ) as ASTNODE ptr

declare function	rtlExitRt			( byval errlevel as ASTNODE ptr ) as integer

declare function 	rtlMemCopy			( byval dst as ASTNODE ptr, _
										  byval src as ASTNODE ptr, _
										  byval bytes as integer ) as ASTNODE ptr

declare function	rtlMemSwap			( byval dst as ASTNODE ptr, _
										  byval src as ASTNODE ptr ) as integer

declare function	rtlStrSwap			( byval str1 as ASTNODE ptr, _
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
										  byval isfunc as integer, _
                                          byval openkind as FBOPENKIND ) as ASTNODE ptr

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
										  byval isfunc as integer ) as ASTNODE ptr

declare function	rtlFilePutArray		( byval filenum as ASTNODE ptr, _
										  byval offset as ASTNODE ptr, _
										  byval src as ASTNODE ptr, _
										  byval isfunc as integer ) as ASTNODE ptr

declare function	rtlFileGet			( byval filenum as ASTNODE ptr, _
										  byval offset as ASTNODE ptr, _
										  byval dst as ASTNODE ptr, _
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
										  byval linenum as integer )

declare sub 		rtlErrorSetHandler	( byval newhandler as ASTNODE ptr, _
										  byval savecurrent as integer )

declare function	rtlErrorGetNum		( ) as ASTNODE ptr

declare sub 		rtlErrorSetNum		( byval errexpr as ASTNODE ptr )

declare sub 		rtlErrorResume		( byval isnext as integer )

declare function	rtlConsoleView		( byval topexpr as ASTNODE ptr, _
										  byval botexpr as ASTNODE ptr ) as ASTNODE ptr

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
