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


enum FBRTL_ENUM
	FB.RTL.STRCONCAT
	FB.RTL.STRCOMPARE
	FB.RTL.STRASSIGN
	FB.RTL.STRCONCATASSIGN
	FB.RTL.STRDELETE
	FB.RTL.STRALLOCTMPRES
	FB.RTL.STRALLOCTMPDESC

	FB.RTL.ARRAYREDIM
	FB.RTL.ARRAYERASE
	FB.RTL.ARRAYCLEAR
	FB.RTL.ARRAYLBOUND
	FB.RTL.ARRAYUBOUND
	FB.RTL.ARRAYSETDESC
	FB.RTL.ARRAYSTRERASE
	FB.RTL.ARRAYALLOCTMPDESC
	FB.RTL.ARRAYFREETMPDESC

	FB.RTL.INT2STR
	FB.RTL.FLT2STR
	FB.RTL.DBL2STR

	FB.RTL.STRINSTR
	FB.RTL.STRMID
	FB.RTL.STRASSIGNMID
	FB.RTL.STRFILL1
	FB.RTL.STRFILL2
	FB.RTL.STRLEN
	FB.RTL.STRASC
	FB.RTL.STRCHR

	FB.RTL.END

	FB.RTL.DATARESTORE
	FB.RTL.DATAREADSTR
	FB.RTL.DATAREADBYTE
	FB.RTL.DATAREADSHORT
	FB.RTL.DATAREADINT
	FB.RTL.DATAREADSINGLE
	FB.RTL.DATAREADDOUBLE

	FB.RTL.POW
	FB.RTL.SGNSINGLE
	FB.RTL.SGNDOUBLE
	FB.RTL.FIXSINGLE
	FB.RTL.FIXDOUBLE

	FB.RTL.PRINTVOID
	FB.RTL.PRINTBYTE
	FB.RTL.PRINTUBYTE
	FB.RTL.PRINTSHORT
	FB.RTL.PRINTUSHORT
	FB.RTL.PRINTINT
	FB.RTL.PRINTUINT
	FB.RTL.PRINTSINGLE
	FB.RTL.PRINTDOUBLE
	FB.RTL.PRINTSTR
	FB.RTL.PRINTSPC
	FB.RTL.PRINTTAB

	FB.RTL.WRITEVOID
	FB.RTL.WRITEBYTE
	FB.RTL.WRITEUBYTE
	FB.RTL.WRITESHORT
	FB.RTL.WRITEUSHORT
	FB.RTL.WRITEINT
	FB.RTL.WRITEUINT
	FB.RTL.WRITESINGLE
	FB.RTL.WRITEDOUBLE
	FB.RTL.WRITESTR

	FB.RTL.PRINTUSGINIT
	FB.RTL.PRINTUSGSTR
	FB.RTL.PRINTUSGVAL
	FB.RTL.PRINTUSGEND

	FB.RTL.CONSOLEVIEW
	FB.RTL.CONSOLEREADXY

	FB.RTL.MEMCOPY
	FB.RTL.MEMSWAP
	FB.RTL.STRSWAP

	FB.RTL.FILEOPEN
	FB.RTL.FILECLOSE
	FB.RTL.FILEPUT
	FB.RTL.FILEPUTSTR
	FB.RTL.FILEPUTARRAY
	FB.RTL.FILEGET
	FB.RTL.FILEGETSTR
	FB.RTL.FILEGETARRAY
	FB.RTL.FILETELL
	FB.RTL.FILESEEK
	FB.RTL.FILESTRINPUT

	FB.RTL.FILELINEINPUT
	FB.RTL.CONSOLELINEINPUT

	FB.RTL.FILEINPUT
	FB.RTL.CONSOLEINPUT

	FB.RTL.INPUTBYTE
	FB.RTL.INPUTSHORT
	FB.RTL.INPUTINT
	FB.RTL.INPUTSINGLE
	FB.RTL.INPUTDOUBLE
	FB.RTL.INPUTSTR

	FB.RTL.FILELOCK
	FB.RTL.FILEUNLOCK

	FB.RTL.ERRORTHROW
	FB.RTL.ERRORTHROWEX
	FB.RTL.ERRORSETHANDLER
	FB.RTL.ERRORGETNUM
	FB.RTL.ERRORSETNUM
	FB.RTL.ERRORRESUME
	FB.RTL.ERRORRESUMENEXT

	FB.RTL.GFXPSET
	FB.RTL.GFXPOINT
	FB.RTL.GFXLINE
	FB.RTL.GFXCIRCLE
	FB.RTL.GFXPAINT
	FB.RTL.GFXDRAW
	FB.RTL.GFXVIEW
	FB.RTL.GFXWINDOW
	FB.RTL.GFXPALETTE
	FB.RTL.GFXPALETTEUSING
	FB.RTL.GFXPUT
	FB.RTL.GFXGET
	FB.RTL.GFXSCREENSET
	FB.RTL.GFXSCREENRES
	FB.RTL.GFXBLOAD
	FB.RTL.GFXBSAVE
end enum

const FB.RTL.MAXFUNCTIONS%		= 512


declare sub 		rtlInit				( )
declare sub 		rtlEnd				( )

declare function 	rtlStrCompare 		( byval str1 as integer, byval sdtype1 as integer, _
					     			  	  byval str2 as integer, byval sdtype2 as integer ) as integer
declare function 	rtlStrConcat		( byval str1 as integer, byval sdtype1 as integer, _
					   				  	  byval str2 as integer, byval sdtype2 as integer ) as integer
declare function 	rtlStrAssign		( byval dst as integer, byval src as integer ) as integer
declare function 	rtlStrConcatAssign	( byval dst as integer, byval src as integer ) as integer
declare function 	rtlStrDelete		( byval strg as integer ) as integer
declare function 	rtlStrAllocTmpResult( byval strg as integer ) as integer
declare function 	rtlStrAllocTmpDesc	( byval strg as integer ) as integer

declare function 	rtlToStr			( byval expr as integer ) as integer
declare function 	rtlStrInstr			( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer ) as integer
declare function 	rtlStrMid			( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer ) as integer
declare function	rtlStrAssignMid		( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer, byval expr4 as integer ) as integer
declare function 	rtlStrFill			( byval expr1 as integer, byval expr2 as integer ) as integer
declare function 	rtlStrAsc			( byval expr as integer ) as integer
declare function 	rtlStrChr			( byval expr as integer ) as integer

declare function	rtlArrayRedim		( byval s as FBSYMBOL ptr, byval elementlen as integer, _
									  	  byval dimensions as integer, exprTB() as integer, _
									  	  byval dopreserve as integer ) as integer
declare function	rtlArrayErase		( byval arrayexpr as integer ) as integer
declare function	rtlArrayClear		( byval arrayexpr as integer ) as integer
declare function 	rtlArrayBound		( byval sexpr as integer, byval dimexpr as integer, byval islbound as integer ) as integer
declare function	rtlArraySetDesc		( byval s as FBSYMBOL ptr, byval elementlen as integer, _
										  byval dimensions as integer, dTB() as FBARRAYDIM ) as integer
declare function 	rtlArrayStrErase	( byval s as FBSYMBOL ptr ) as integer
declare function 	rtlArrayAllocTmpDesc( byval arrayexpr as integer, byval pdesc as FBSYMBOL ptr ) as integer
declare function 	rtlArrayFreeTempDesc( byval pdesc as FBSYMBOL ptr ) as integer

declare function	rtlDataRestore		( byval label as FBSYMBOL ptr ) as integer
declare function	rtlDataRead			( byval varexpr as integer ) as integer
declare sub 		rtlDataStoreBegin	( )
declare function	rtlDataStore		( littext as string, byval litlen as integer, byval typ as integer ) as integer
declare sub 		rtlDataStoreEnd		( )

declare function	rtlMathPow			( byval xexpr as integer, byval yexpr as integer ) as integer
declare function 	rtlMathFSGN 		( byval expr as integer ) as integer
declare function 	rtlMathFIX 			( byval expr as integer ) as integer
declare function 	rtlMathLen			( byval expr as integer ) as integer

declare function	rtlExit				( byval errlevel as integer ) as integer

declare function 	rtlMemCopy			( byval dst as integer, byval src as integer, byval bytes as integer ) as integer
declare function	rtlMemSwap			( byval dst as integer, byval src as integer ) as integer
declare function	rtlStrSwap			( byval str1 as integer, byval str2 as integer ) as integer

declare function	rtlPrint			( byval fileexpr as integer, byval iscomma as integer, _
										  byval issemicolon as integer, byval expr as integer ) as integer
declare function	rtlPrintSPC			( byval fileexpr as integer, byval expr as integer ) as integer
declare function	rtlPrintTab			( byval fileexpr as integer, byval expr as integer ) as integer
declare function	rtlWrite			( byval fileexpr as integer, byval iscomma as integer, _
										  byval expr as integer ) as integer

declare function	rtlPrintUsingInit	( byval usingexpr as integer ) as integer
declare function	rtlPrintUsingEnd	( byval fileexpr as integer ) as integer
declare function	rtlPrintUsing		( byval fileexpr as integer, byval expr as integer, byval issemicolon as integer ) as integer

declare function	rtlFileOpen			( byval filename as integer, byval fmode as integer, _
										  byval faccess as integer, byval flock, _
										  byval filenum as integer, byval flen as integer ) as integer
declare function	rtlFileClose		( byval filenum as integer ) as integer
declare function	rtlFileSeek			( byval filenum as integer, byval newpos as integer ) as integer
declare function 	rtlFileTell			( byval filenum as integer ) as integer
declare function	rtlFilePut			( byval filenum as integer, byval offset as integer, _
										  byval src as integer ) as integer
declare function	rtlFilePutArray		( byval filenum as integer, byval offset as integer, _
										  byval src as integer ) as integer
declare function	rtlFileGet			( byval filenum as integer, byval offset as integer, _
										  byval dst as integer ) as integer
declare function	rtlFileGetArray		( byval filenum as integer, byval offset as integer, _
										  byval dst as integer ) as integer
declare function 	rtlFileStrInput		( byval bytesexpr as integer, byval filenum as integer ) as integer
declare function	rtlFileLineInput	( byval isfile as integer, byval expr as integer, _
										  byval dstexpr as integer, byval addquestion as integer, _
										  byval addnewline as integer ) as integer
declare function	rtlFileInput		( byval isfile as integer, byval expr as integer, _
										  byval addquestion as integer, byval addnewline as integer ) as integer
declare function	rtlFileInputGet		( byval dstexpr as integer ) as integer
declare function	rtlFileLock			( byval islock as integer, byval filenum as integer, _
										  byval iniexpr as integer, byval endexpr as integer ) as integer

declare sub 		rtlErrorThrow		( byval errexpr as integer )
declare sub 		rtlErrorSetHandler	( byval newhandler as integer, byval savecurrent as integer )
declare function	rtlErrorGetNum		( ) as integer
declare sub 		rtlErrorSetNum		( byval errexpr as integer )
declare sub 		rtlErrorResume		( byval isnext as integer )

declare function	rtlConsoleView		( byval topexpr as integer, byval botexpr as integer ) as integer
declare function	rtlConsoleReadXY	( byval row as integer, byval column as integer, byval colorflag as integer ) as integer

declare function	rtlGfxPset			( byval target as integer, byval targetisptr as integer, byval xexpr as integer, byval yexpr as integer, _
										  byval cexpr as integer, byval coordtype as integer ) as integer
declare function	rtlGfxPoint			( byval target as integer, byval targetisptr as integer, byval xexpr as integer, byval yexpr as integer )
declare function	rtlGfxLine			( byval target as integer, byval targetisptr as integer, byval x1expr as integer, byval y1expr as integer, _
										  byval x2expr as integer, byval y2expr as integer, _
										  byval cexpr as integer, byval linetype as integer, _
										  byval styleexpr as integer, byval coordtype as integer ) as integer
declare function	rtlGfxCircle		( byval target as integer, byval targetisptr as integer, byval xexpr as integer, byval yexpr as integer, _
										  byval radexpr as integer, byval cexpr as integer, _
										  byval aspexpr as integer, byval iniexpr as integer, _
										  byval endexpr as integer, _
										  byval fillflag as integer, byval coordtype as integer ) as integer
declare function	rtlGfxPaint			( byval target as integer, byval targetisptr as integer, byval xexpr as integer, byval yexpr as integer, _
										  byval pexpr as integer, byval bexpr as integer, _
									 	  byval coord_type as integer ) as integer
declare function	rtlGfxDraw			( byval target as integer, byval targetisptr as integer, byval cexpr as integer )
declare function	rtlGfxView			( byval x1expr as integer, byval y1expr as integer, _
										  byval x2expr as integer, byval y2expr as integer, _
			    						  byval fillexpr as integer, byval bordexpr as integer, _
			    						  byval screenflag as integer ) as integer
declare function	rtlGfxWindow		( byval x1expr as integer, byval y1expr as integer, _
										  byval x2expr as integer, byval y2expr as integer, _
			    						  byval screenflag as integer ) as integer
declare function	rtlGfxPalette 		( byval attexpr as integer, byval rexpr as integer, byval gexpr as integer, byval bexpr as integer ) as integer
declare function	rtlGfxPaletteUsing	( byval arrayexpr as integer ) as integer
declare function 	rtlGfxPut			( byval target as integer, byval targetisptr as integer, byval xexpr as integer, byval yexpr as integer, _
										  byval arrayexpr as integer, byval isptr as integer, _
										  byval mode as integer, byval coordtype as integer ) as integer
declare function	rtlGfxGet			( byval target as integer, byval targetisptr as integer, byval x1expr as integer, byval y1expr as integer, _
										  byval x2expr as integer, byval y2expr as integer, _
										  byval arrayexpr as integer, byval isptr as integer, _
										  byval symbol as FBSYMBOL ptr, byval coordtype as integer ) as integer
declare function	rtlGfxScreenSet		( byval wexpr as integer, byval hexpr as integer, byval dexpr as integer, _
										  byval pexpr as integer, byval fexpr as integer ) as integer
declare function	rtlGfxBload			( byval filename as integer, byval dexpr as integer ) as integer
declare function	rtlGfxBsave			( byval filaname as integer, byval sexpr as integer, _
										  byval lexpr as integer ) as integer
