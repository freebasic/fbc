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
	FB.RTL.ERRORSETHANDLER
	FB.RTL.ERRORGETNUM
	FB.RTL.ERRORSETNUM
	FB.RTL.ERRORRESUME
	FB.RTL.ERRORRESUMENEXT

	FB.RTL.GFXPSET
	FB.RTL.GFXLINE
	FB.RTL.GFXCIRCLE
	FB.RTL.GFXPAINT
	FB.RTL.GFXVIEW
	FB.RTL.GFXWINDOW
	FB.RTL.GFXPALETTE
	FB.RTL.GFXPALETTEUSING
	FB.RTL.GFXPUT
	FB.RTL.GFXGET
	FB.RTL.GFXSCREENSET
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
declare sub 		rtlStrAssignMid		( byval expr1 as integer, byval expr2 as integer, byval expr3 as integer, byval expr4 as integer )
declare function 	rtlStrFill			( byval expr1 as integer, byval expr2 as integer ) as integer

declare sub 		rtlArrayRedim		( byval s as FBSYMBOL ptr, byval elementlen as integer, _
									  	  byval dimensions as integer, exprTB() as integer, _
									  	  byval dopreserve as integer )
declare sub 		rtlArrayErase		( byval s as FBSYMBOL ptr )
declare function 	rtlArrayBound		( byval sexpr as integer, byval dimexpr as integer, byval islbound as integer ) as integer
declare sub 		rtlArraySetDesc		( byval s as FBSYMBOL ptr, byval elementlen as integer, _
										  byval dimensions as integer, dTB() as FBARRAYDIM )
declare sub 		rtlArrayStrErase	( byval s as FBSYMBOL ptr )
declare function 	rtlArrayAllocTmpDesc( byval arrayexpr as integer, byval pdesc as FBSYMBOL ptr ) as integer
declare function 	rtlArrayFreeTempDesc( byval pdesc as FBSYMBOL ptr ) as integer

declare sub 		rtlDataRestore		( byval label as FBSYMBOL ptr )
declare sub 		rtlDataRead			( byval varexpr as integer )
declare sub 		rtlDataStoreBegin	( )
declare sub 		rtlDataStore		( littext as string, byval litlen as integer, byval typ as integer )
declare sub 		rtlDataStoreEnd		( )

declare function	rtlMathPow			( byval xexpr as integer, byval yexpr as integer ) as integer
declare function 	rtlMathFSGN 		( byval expr as integer ) as integer
declare function 	rtlMathFIX 			( byval expr as integer ) as integer
declare function 	rtlMathLen			( byval expr as integer ) as integer

declare sub 		rtlExit				( byval errlevel as integer )

declare function 	rtlMemCopy			( byval dst as integer, byval src as integer, byval bytes as integer ) as integer
declare sub 		rtlMemSwap			( byval dst as integer, byval src as integer )
declare sub 		rtlStrSwap			( byval str1 as integer, byval str2 as integer )

declare sub 		rtlPrint			( byval fileexpr as integer, byval iscomma as integer, _
										  byval issemicolon as integer, byval expr as integer )
declare sub 		rtlPrintSPC			( byval fileexpr as integer, byval expr as integer )
declare sub 		rtlPrintTab			( byval fileexpr as integer, byval expr as integer )
declare sub 		rtlWrite			( byval fileexpr as integer, byval iscomma as integer, _
										  byval expr as integer )

declare sub 		rtlPrintUsingInit	( byval usingexpr as integer )
declare sub 		rtlPrintUsingEnd	( byval fileexpr as integer )
declare sub 		rtlPrintUsing		( byval fileexpr as integer, byval expr as integer, byval issemicolon as integer )

declare sub 		rtlFileOpen			( byval filename as integer, byval fmode as integer, byval faccess as integer, _
				 						  byval flock, byval filenum as integer, byval flen as integer )
declare sub 		rtlFileClose		( byval filenum as integer )
declare sub 		rtlFileSeek			( byval filenum as integer, byval newpos as integer )
declare function 	rtlFileTell			( byval filenum as integer ) as integer
declare sub 		rtlFilePut			( byval filenum as integer, byval offset as integer, byval src as integer )
declare sub 		rtlFilePutArray		( byval filenum as integer, byval offset as integer, byval src as integer )
declare sub 		rtlFileGet			( byval filenum as integer, byval offset as integer, byval dst as integer )
declare sub 		rtlFileGetArray		( byval filenum as integer, byval offset as integer, byval dst as integer )
declare function 	rtlFileStrInput		( byval bytesexpr as integer, byval filenum as integer ) as integer
declare sub 		rtlFileLineInput	( byval isfile as integer, byval expr as integer, byval dstexpr as integer, byval addquestion as integer, byval addnewline as integer )
declare sub 		rtlFileInput		( byval isfile as integer, byval expr as integer, byval addquestion as integer, byval addnewline as integer )
declare sub 		rtlFileInputGet		( byval dstexpr as integer )
declare sub 		rtlFileLock			( byval islock as integer, byval filenum as integer, byval iniexpr as integer, byval endexpr as integer )

declare sub 		rtlErrorThrow		( byval errexpr as integer )
declare sub 		rtlErrorSetHandler	( byval newhandler as integer, byval savecurrent as integer )
declare function	rtlErrorGetNum		( ) as integer
declare sub 		rtlErrorSetNum		( byval errexpr as integer )
declare sub 		rtlErrorResume		( byval isnext as integer )

declare sub 		rtlConsoleView		( byval topexpr as integer, byval botexpr as integer )

declare sub 		rtlGfxPset			( byval xexpr as integer, byval yexpr as integer, byval cexpr as integer, byval coordtype as integer )
declare sub 		rtlGfxLine			( byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, byval y2expr as integer, _
										  byval cexpr as integer, byval linetype as integer, byval styleexpr as integer, byval coordtype as integer )
declare sub 		rtlGfxCircle		( byval xexpr as integer, byval yexpr as integer, byval radexpr as integer, byval cexpr as integer, _
										  byval aspexpr as integer, byval iniexpr as integer, byval endexpr as integer, _
										  byval fillflag as integer, byval coordtype as integer )
declare sub		rtlGfxPaint		( byval xexpr as integer, byval yexpr as integer, byval pexpr as integer, byval bexpr as integer, _
									 byval coord_type as integer )
declare sub 		rtlGfxView			( byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, byval y2expr as integer, _
			    						  byval fillexpr as integer, byval bordexpr as integer, byval screenflag as integer )
declare sub 		rtlGfxWindow		( byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, byval y2expr as integer, _
			    						  byval screenflag as integer )
declare sub 		rtlGfxPalette 		( byval attexpr as integer, byval colexpr as integer )
declare sub 		rtlGfxPaletteUsing	( byval arrayexpr as integer )
declare sub 		rtlGfxPut			( byval xexpr as integer, byval yexpr as integer, byval arrayexpr as integer, byval mode as integer, byval coordtype as integer )
declare sub 		rtlGfxGet			( byval x1expr as integer, byval y1expr as integer, byval x2expr as integer, byval y2expr as integer, _
										  byval arrayexpr as integer, byval symbol as FBSYMBOL ptr, byval coordtype as integer )
declare sub 		rtlGfxScreenSet		( byval wexpr as integer, byval hexpr as integer, byval dexpr as integer, byval fexpr as integer )
