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


''
'' parser protos
''

'$include:'inc\lex.bi'

declare function 	cProgram				( ) as integer
declare function 	cLine					( ) as integer
declare function 	cSimpleLine             ( ) as integer
declare function 	cLabel                  ( ) as integer
declare function 	cComment                ( ) as integer
declare function 	cDirective              ( ) as integer
declare function 	cStatement              ( ) as integer
declare function 	cSimpleStatement        ( ) as integer
declare function 	cSttSeparator 			( ) as integer
declare function 	cDeclaration            ( ) as integer
declare function 	cConstDecl              ( ) as integer
declare function 	cConstAssign            ( ) as integer
declare function 	cTypeDecl               ( ) as integer
declare function 	cEnumDecl               ( ) as integer
declare function 	cSymbolDecl             ( ) as integer
declare function 	cSymbolDef 				( byval alloctype as integer, byval dopreserve as integer = FALSE ) as integer
declare function 	cDynArrayDef			( id as string, idlias as string, _
											  byval typ as integer, byval subtype as FBSYMBOL ptr, _
											  byval lgt as integer, byval addsuffix as integer, _
											  byval alloctype as integer, byval dopreserve as integer, _
					   						  byval dimensions as integer, exprTB() as integer ) as FBSYMBOL ptr
declare function 	cStaticArrayDecl 		( dimensions as integer, dTB() as FBARRAYDIM ) as integer
declare function 	cArrayDecl				( dimensions as integer, exprTB() as integer ) as integer
declare function 	cSymbolInit				( byval s as FBSYMBOL ptr ) as integer
declare function 	cSymbolType 			( typ as integer, subtype as FBSYMBOL ptr, lgt as integer ) as integer
declare function 	cProcDecl               ( ) as integer
declare function 	cSubOrFuncDecl 			( byval isSub as integer ) as integer
declare function 	cArguments              ( argc as integer, argv() as FBPROCARG, byval isproto as integer ) as integer
declare function 	cArgDecl                ( byval argc as integer, arg as FBPROCARG, byval isproto as integer ) as integer
declare function 	cDefDecl				( ) as integer
declare function 	cOptDecl				( ) as integer
declare function 	cProcCallOrAssign		( ) as integer
declare function 	cQuirkStmt				( ) as integer
declare function 	cCompoundStmt           ( ) as integer
declare function 	cIfStatement			( ) as integer
declare function 	cSingleIfStatement		( byval expr as integer ) as integer
declare function 	cBlockIfStatement		( byval expr as integer ) as integer
declare function 	cForStatement          	( ) as integer
declare function 	cDoStatement           	( ) as integer
declare function 	cWhileStatement        	( ) as integer
declare function 	cSelectStatement       	( ) as integer
declare function 	cCaseStatement         	( byval s as FBSYMBOL ptr, byval sdtype as integer, byval exitlabel as FBSYMBOL ptr ) as integer
declare function 	cCaseExpression        	( byval s as FBSYMBOL ptr, byval sdtype as integer, byval initlabel as FBSYMBOL ptr, byval nextlabel as FBSYMBOL ptr ) as integer
declare function 	cSelectLine 			( )as integer
declare function 	cCompoundStmtElm		( ) as integer
declare function 	cProcStatement         	( ) as integer
declare function 	cExitStatement			( ) as integer
declare function 	cEndStatement			( ) as integer
declare function 	cContinueStatement		( ) as integer
declare function 	cWithStatement          ( ) as integer
declare function 	cAssignmentOrPtrCall	( ) as integer
declare function 	cExpression				( expr as integer ) as integer
declare function 	cLogExpression			( logexpr as integer ) as integer
declare function 	cRelExpression			( relexpr as integer ) as integer
declare function 	cAddExpression			( addexpr as integer ) as integer
declare function 	cShiftExpression		( shiftexpr as integer ) as integer
declare function 	cModExpression			( modexpr as integer ) as integer
declare function 	cIntDivExpression		( idivexpr as integer ) as integer
declare function 	cMultExpression			( mulexpr as integer ) as integer
declare function 	cExpExpression 			( expexpr as integer ) as integer
declare function 	cNegExpression			( negexpr as integer ) as integer
declare function 	cHighestPresExpr		( highexpr as integer ) as integer
declare function 	cDerefExpression		( derefexpr as integer ) as integer
declare function 	cAddrOfExpression		( addrofexpr as integer, sym as FBSYMBOL ptr, elm as FBSYMBOL ptr ) as integer
declare function 	cTypeConvExpr			( tconvexpr as integer ) as integer
declare function 	cParentExpression		( parexpr as integer ) as integer
declare function 	cAtom					( atom as integer ) as integer
declare function 	cVariable				( varexpr as integer, _
											  sym as FBSYMBOL ptr, elm as FBSYMBOL ptr, _
											  byval checkarray as integer = TRUE )
declare function 	cVarOrDeref				( varexpr as integer, byval checkarray as integer = TRUE )
declare function 	cFunction				( funcexpr as integer, sym as FBSYMBOL ptr ) as integer
declare function 	cQuirkFunction			( funcexpr as integer ) as integer
declare function 	cConstant				( constexpr as integer ) as integer
declare function 	cLiteral 				( litexpr as integer ) as integer
declare function 	cFuncParamList			( byval proc as FBSYMBOL ptr, byval procexpr as integer, _
											  byval optonly as integer ) as integer
declare function 	cFuncParam				( byval proc as FBSYMBOL ptr, byval arg as FBPROCARG ptr, _
											  byval procexpr as integer, byval optonly as integer ) as integer
declare function 	cProcParamList			( byval proc as FBSYMBOL ptr, byval procexpr as integer ) as integer
declare function 	cProcParam				( byval proc as FBSYMBOL ptr, byval arg as FBPROCARG ptr, _
											  byval param as integer, expr as integer, pmode as integer, byval optonly as integer ) as integer
declare function 	cAsmBlock				( ) as integer
declare function 	cFunctionMode 			( ) as integer
declare function 	cFunctionCall			( byval proc as FBSYMBOL ptr, funcexpr as integer, byval ptrexpr as integer ) as integer
declare function 	cProcCall				( byval proc as FBSYMBOL ptr, byval ptrexpr as integer, _
											  byval checkparents as integer = FALSE ) as integer

declare function 	cDerefFields			( byval sym as FBSYMBOL ptr, elm as FBSYMBOL ptr, _
											  typ as integer, subtype as FBSYMBOL ptr, _
					   						  varexpr as integer, byval isderef as integer, _
					   						  byval checkarray as integer ) as integer

declare function 	hIsSttSeparatorOrComment( byval token as integer ) as integer

declare function 	cGfxStmt 				( ) as integer
declare function 	cGfxFunct				( funcexpr as integer ) as integer
