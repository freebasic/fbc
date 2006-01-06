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

#include once "inc\lex.bi"
#include once "inc\ast.bi"

declare function 	cProgram				( ) as integer

declare function 	cLine					( ) as integer

declare function 	cSimpleLine             ( ) as integer

declare function 	cLabel                  ( ) as integer

declare function 	cComment                ( byval lexflags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	cDirective              ( ) as integer

declare function 	cStatement              ( ) as integer

declare function 	cSimpleStatement        ( ) as integer

declare function 	cStmtSeparator 			( byval lexflags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	cDeclaration            ( ) as integer

declare function 	cConstDecl              ( ) as integer

declare function 	cConstAssign            ( ) as integer

declare function 	cTypeDecl               ( ) as integer

declare function 	cTypedefDecl			( byval id as zstring ptr ) as integer

declare function 	cEnumDecl               ( ) as integer

declare function 	cSymbolDecl             ( ) as integer

declare function 	cSymbolDef 				( byval alloctype as integer, _
											  byval dopreserve as integer = FALSE, _
                                              byval is_dim as integer = FALSE) as integer

declare function 	cStaticArrayDecl 		( byref dimensions as integer, _
											  dTB() as FBARRAYDIM ) as integer

declare function 	cArrayDecl				( byref dimensions as integer, _
											  exprTB() as ASTNODE ptr ) as integer

declare function 	cSymbolInit				( byval s as FBSYMBOL ptr ) as integer

declare function 	cSymbolType 			( byref typ as integer, _
											  byref subtype as FBSYMBOL ptr, _
											  byref lgt as integer, _
											  byref ptrcnt as integer, _
											  byval checkptr as integer = TRUE ) as integer

declare function 	cProcDecl               ( ) as integer

declare function 	cSubOrFuncDecl 			( byval isSub as integer ) as integer

declare function 	cArguments              ( byval proc as FBSYMBOL ptr, _
											  byval procmode as integer, _
											  byval isproto as integer ) as FBSYMBOL ptr

declare function 	cArgDecl				( byval proc as FBSYMBOL ptr, _
											  byval procmode as integer, _
				   							  byval isproto as integer ) as FBSYMBOL ptr

declare function 	cDefDecl				( ) as integer

declare function 	cOptDecl				( ) as integer

declare function 	cProcCallOrAssign		( ) as integer

declare function 	cQuirkStmt				( ) as integer

declare function 	cCompoundStmt           ( ) as integer

declare function 	cIfStatement			( ) as integer

declare function 	cSingleIfStatement		( byval expr as ASTNODE ptr ) as integer

declare function 	cBlockIfStatement		( byval expr as ASTNODE ptr ) as integer

declare function 	cForStatement          	( ) as integer

declare function 	cDoStatement           	( ) as integer

declare function 	cWhileStatement        	( ) as integer

declare function 	cSelectStatement       	( ) as integer

declare function 	cCaseStatement         	( byval s as FBSYMBOL ptr, _
											  byval sdtype as integer, _
											  byval exitlabel as FBSYMBOL ptr ) as integer

declare function 	cSelectConstStmt 		( ) as integer

declare function 	cCompoundStmtElm		( ) as integer

declare function 	cProcStatement         	( ) as integer

declare function 	cExitStatement			( ) as integer

declare function 	cEndStatement			( ) as integer

declare function 	cContinueStatement		( ) as integer

declare function 	cWithStatement          ( ) as integer

declare function 	cScopeStatement			( ) as integer

declare function 	cAssignmentOrPtrCall	( ) as integer

declare function 	cExpression				( byref expr as ASTNODE ptr ) as integer

declare function 	cCatExpression			( byref catexpr as ASTNODE ptr ) as integer

declare function 	cLogExpression			( byref logexpr as ASTNODE ptr ) as integer

declare function 	cRelExpression			( byref relexpr as ASTNODE ptr ) as integer

declare function 	cAddExpression			( byref addexpr as ASTNODE ptr ) as integer

declare function 	cShiftExpression		( byref shiftexpr as ASTNODE ptr ) as integer

declare function 	cModExpression			( byref modexpr as ASTNODE ptr ) as integer

declare function 	cIntDivExpression		( byref idivexpr as ASTNODE ptr ) as integer

declare function 	cMultExpression			( byref mulexpr as ASTNODE ptr ) as integer

declare function 	cExpExpression 			( byref expexpr as ASTNODE ptr ) as integer

declare function 	cNegNotExpression		( byref negexpr as ASTNODE ptr ) as integer

declare function 	cHighestPrecExpr		( byref highexpr as ASTNODE ptr ) as integer

declare function 	cPtrTypeCastingExpr		( byref castexpr as ASTNODE ptr ) as integer

declare function 	cDerefExpression		( byref derefexpr as ASTNODE ptr ) as integer

declare function 	cAddrOfExpression		( byref addrofexpr as ASTNODE ptr ) as integer

declare function 	cTypeConvExpr			( byref tconvexpr as ASTNODE ptr ) as integer

declare function 	cParentExpression		( byref parexpr as ASTNODE ptr ) as integer

declare function 	cAtom					( byref atom as ASTNODE ptr ) as integer

declare function 	cVariable				( byref varexpr as ASTNODE ptr, _
											  byval checkarray as integer = TRUE ) as integer

declare function 	cVarOrDeref				( byref varexpr as ASTNODE ptr, _
											  byval checkarray as integer = TRUE, _
											  byval checkaddrof as integer = FALSE ) as integer

declare function 	cFunction				( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cQuirkFunction			( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cConstant				( byref constexpr as ASTNODE ptr ) as integer

declare function 	cLiteral 				( byref litexpr as ASTNODE ptr ) as integer

declare function 	cProcParamList			( byval proc as FBSYMBOL ptr, _
						 					  byval ptrexpr as ASTNODE ptr, _
						 					  byval isfunc as integer, _
						 					  byval optonly as integer ) as ASTNODE ptr

declare function 	cAsmBlock				( ) as integer

declare function 	cFunctionMode 			( ) as integer

declare function 	cFunctionCall			( byval sym as FBSYMBOL ptr, _
											  byref funcexpr as ASTNODE ptr, _
											  byval ptrexpr as ASTNODE ptr ) as integer

declare function 	cProcCall				( byval sym as FBSYMBOL ptr, _
											  byref procexpr as ASTNODE ptr, _
											  byval ptrexpr as ASTNODE ptr, _
											  byval checkparents as integer = FALSE ) as integer

declare function 	cDerefFields			( byref typ as integer, _
											  byref subtype as FBSYMBOL ptr, _
					   						  byref varexpr as ASTNODE ptr, _
					   						  byval checkarray as integer ) as integer

declare function    cFuncPtrOrDerefFields	( byval typ as integer, _
					      					  byval subtype as FBSYMBOL ptr, _
					      					  byref varexpr as ASTNODE ptr, _
					      					  byval isfuncptr as integer, _
					      					  byval checkarray as integer ) as integer

declare function	cUpdPointer				( byval op as integer, _
					  						  byval p as ASTNODE ptr, _
					  						  byval e as ASTNODE ptr ) as ASTNODE ptr

declare function 	cAssignment				( byval assgexpr as ASTNODE ptr ) as integer

declare function 	hAssignFunctResult		( byval proc as FBSYMBOL ptr ) as integer

declare function 	cGfxStmt 				( ) as integer

declare function 	cGfxFunct				( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cGotoStmt				( ) as integer

declare function 	cPrintStmt				( ) as integer

declare function 	cDataStmt				( ) as integer

declare function 	cArrayStmt				( ) as integer

declare function 	cLineInputStmt			( ) as integer

declare function 	cInputStmt				( ) as integer

declare function 	cPokeStmt				( ) as integer

declare function 	cFileStmt				( ) as integer

declare function 	cLocateStmt				( byval isfunc as integer ) as ASTNODE ptr

declare function 	cOnStmt					( ) as integer

declare function 	cWriteStmt				( ) as integer

declare function 	cErrorStmt				( ) as integer

declare function 	cViewStmt				( byval is_func as integer = FALSE, _
                   							 byref funcexpr as ASTNODE ptr = NULL ) as integer

declare function 	cMidStmt				( ) as integer

declare function 	cLSetStmt				( ) as integer

declare function 	cWidthStmt				( byval isfunc as integer ) as ASTNODE ptr

declare function 	cStringFunct			( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cMathFunct				( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cPeekFunct				( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cArrayFunct				( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cFileFunct				( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cErrorFunct				( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cIIFFunct				( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cVAFunct				( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cScreenFunct			( byref funcexpr as ASTNODE ptr ) as integer

declare function 	cConstExprValue			( byref value as integer ) as integer

'':::::
#define hMatchToken(token, errcode)							 _
	if( hMatch( token ) = FALSE ) then							:_
		hReportError errcode								:_
		exit function										:_
	end if

'':::::
#define hMatchLPRNT()											 _
    hMatchToken( CHAR_LPRNT, FB_ERRMSG_EXPECTEDLPRNT )

'':::::
#define hMatchRPRNT()											 _
    hMatchToken( CHAR_RPRNT, FB_ERRMSG_EXPECTEDRPRNT )

'':::::
#define hMatchCOMMA()											 _
    hMatchToken( CHAR_COMMA, FB_ERRMSG_EXPECTEDCOMMA )

'':::::
#define hMatchExpression(e)										 _
	if( cExpression( e ) = FALSE ) then                         	:_
		hReportError FB_ERRMSG_EXPECTEDEXPRESSION				:_
		exit function											:_
	end if

