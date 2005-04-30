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


'$include once:'inc\ast.bi'

enum FBRTL_ENUM
	FB.RTL.STRCONCAT
	FB.RTL.STRCOMPARE
	FB.RTL.STRASSIGN
	FB.RTL.STRCONCATASSIGN
	FB.RTL.STRDELETE
	FB.RTL.STRALLOCTMPRES
	FB.RTL.STRALLOCTMPDESC

	FB.RTL.LONGINTDIV
	FB.RTL.ULONGINTDIV
	FB.RTL.LONGINTMOD
	FB.RTL.ULONGINTMOD
	FB.RTL.DBL2ULONGINT

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
	FB.RTL.UINT2STR
	FB.RTL.LONGINT2STR
	FB.RTL.ULONGINT2STR
	FB.RTL.FLT2STR
	FB.RTL.DBL2STR

	FB.RTL.STRMID
	FB.RTL.STRASSIGNMID
	FB.RTL.STRFILL1
	FB.RTL.STRFILL2
	FB.RTL.STRLEN
	FB.RTL.STRLSET
	FB.RTL.STRASC
	FB.RTL.STRCHR

	FB.RTL.END

	FB.RTL.DATARESTORE
	FB.RTL.DATAREADSTR
	FB.RTL.DATAREADBYTE
	FB.RTL.DATAREADSHORT
	FB.RTL.DATAREADINT
	FB.RTL.DATAREADLONGINT
	FB.RTL.DATAREADUBYTE
	FB.RTL.DATAREADUSHORT
	FB.RTL.DATAREADUINT
	FB.RTL.DATAREADULONGINT
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
	FB.RTL.PRINTLONGINT
	FB.RTL.PRINTULONGINT
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
	FB.RTL.WRITELONGINT
	FB.RTL.WRITEULONGINT
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
	FB.RTL.MEMCOPYCLEAR

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
	FB.RTL.INPUTLONGINT
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

	FB.RTL.PROFILESETPROC
	FB.RTL.PROFILESTARTCALL
	FB.RTL.PROFILEENDCALL
	FB.RTL.PROFILEEND
end enum

const FB.RTL.MAXFUNCTIONS		= 512


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


declare function	rtlDataRestore		( byval label as FBSYMBOL ptr ) as integer

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

declare function	rtlExit				( byval errlevel as ASTNODE ptr ) as integer

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
										  byval expr as ASTNODE ptr ) as integer

declare function	rtlPrintSPC			( byval fileexpr as ASTNODE ptr, _
										  byval expr as ASTNODE ptr ) as integer

declare function	rtlPrintTab			( byval fileexpr as ASTNODE ptr, _
										  byval expr as ASTNODE ptr ) as integer

declare function	rtlWrite			( byval fileexpr as ASTNODE ptr, _
										  byval iscomma as integer, _
										  byval expr as ASTNODE ptr ) as integer

declare function	rtlPrintUsingInit	( byval usingexpr as ASTNODE ptr ) as integer

declare function	rtlPrintUsingEnd	( byval fileexpr as ASTNODE ptr ) as integer

declare function	rtlPrintUsing		( byval fileexpr as ASTNODE ptr, _
										  byval expr as ASTNODE ptr, _
										  byval issemicolon as integer ) as integer

declare function	rtlFileOpen			( byval filename as ASTNODE ptr, _
										  byval fmode as ASTNODE ptr, _
										  byval faccess as ASTNODE ptr, _
										  byval flock as ASTNODE ptr, _
										  byval filenum as ASTNODE ptr, _
										  byval flen as ASTNODE ptr, _
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
										  byval reslabel as FBSYMBOL ptr ) as integer

declare sub 		rtlErrorThrow		( byval errexpr as ASTNODE ptr )

declare sub 		rtlErrorSetHandler	( byval newhandler as ASTNODE ptr, _
										  byval savecurrent as integer )

declare function	rtlErrorGetNum		( ) as ASTNODE ptr

declare sub 		rtlErrorSetNum		( byval errexpr as ASTNODE ptr )

declare sub 		rtlErrorResume		( byval isnext as integer )

declare function	rtlConsoleView		( byval topexpr as ASTNODE ptr, _
										  byval botexpr as ASTNODE ptr ) as integer

declare function	rtlConsoleReadXY	( byval rowexpr as ASTNODE ptr, _
										  byval columnexpr as ASTNODE ptr, _
										  byval colorflagexpr as ASTNODE ptr ) as ASTNODE ptr

declare function	rtlGfxPset			( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval xexpr as ASTNODE ptr, _
										  byval yexpr as ASTNODE ptr, _
										  byval cexpr as ASTNODE ptr, _
										  byval coordtype as integer ) as integer

declare function	rtlGfxPoint			( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval xexpr as ASTNODE ptr, _
										  byval yexpr as ASTNODE ptr )

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
										  byval bexpr as ASTNODE ptr ) as integer

declare function	rtlGfxPaletteUsing	( byval arrayexpr as ASTNODE ptr ) as integer

declare function 	rtlGfxPut			( byval target as ASTNODE ptr, _
										  byval targetisptr as integer, _
										  byval xexpr as ASTNODE ptr, _
										  byval yexpr as ASTNODE ptr, _
										  byval arrayexpr as ASTNODE ptr, _
										  byval isptr as integer, _
										  byval mode as integer, _
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

declare function	rtlProfileSetProc	( byval symbol as FBSYMBOL ptr ) as integer

declare function	rtlProfileStartCall ( byval symbol as FBSYMBOL ptr ) as ASTNODE ptr

declare function	rtlProfileEndCall	( ) as ASTNODE ptr
