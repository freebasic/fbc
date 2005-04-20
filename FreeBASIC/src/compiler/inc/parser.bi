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

'$include once:'inc\lex.bi'

declare sub 		parser4Init				( )

declare sub 		parser4End				( )

declare function 	cProgram				( ) as integer

declare function 	cLine					( ) as integer

declare function 	cSimpleLine             ( ) as integer

declare function 	cLabel                  ( ) as integer

declare function 	cComment                ( byval lexflags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	cDirective              ( ) as integer

declare function 	cStatement              ( ) as integer

declare function 	cSimpleStatement        ( ) as integer

declare function 	cSttSeparator 			( byval lexflags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	cDeclaration            ( ) as integer

declare function 	cConstDecl              ( ) as integer

declare function 	cConstAssign            ( ) as integer

declare function 	cTypeDecl               ( ) as integer

declare function 	cEnumDecl               ( ) as integer

declare function 	cSymbolDecl             ( ) as integer

declare function 	cSymbolDef 				( byval alloctype as integer, _
											  byval dopreserve as integer = FALSE ) as integer

declare function 	cDynArrayDef			( id as string, _
											  idlias as string, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, _
											  byval istypeless as integer, _
											  byval lgt as integer, _
											  byval addsuffix as integer, _
											  byval alloctype as integer, _
											  byval dopreserve as integer, _
											  byval dimensions as integer, _
											  exprTB() as integer ) as FBSYMBOL ptr

declare function 	cStaticArrayDecl 		( dimensions as integer, _
											  dTB() as FBARRAYDIM ) as integer

declare function 	cArrayDecl				( dimensions as integer, _
											  exprTB() as integer ) as integer

declare function 	cSymbolInit				( byval s as FBSYMBOL ptr ) as integer

declare function 	cSymbolType 			( typ as integer, _
											  subtype as FBSYMBOL ptr, _
											  lgt as integer, _
											  ptrcnt as integer ) as integer

declare function 	cProcDecl               ( ) as integer

declare function 	cSubOrFuncDecl 			( byval isSub as integer ) as integer

declare function 	cArguments              ( byval procmode as integer, _
											  argc as integer, byval argtail as FBSYMBOL ptr, _
											  byval isproto as integer ) as FBSYMBOL ptr

declare function 	cArgDecl				( byval procmode as integer, _
				   							  byval argc as integer, byval argtail as FBSYMBOL ptr, _
				   							  byval isproto as integer ) as FBSYMBOL ptr

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

declare function 	cNegNotExpression		( negexpr as integer ) as integer

declare function 	cHighestPresExpr		( highexpr as integer ) as integer

declare function 	cDerefExpression		( derefexpr as integer ) as integer

declare function 	cAddrOfExpression		( addrofexpr as integer, _
											  sym as FBSYMBOL ptr, _
											  elm as FBSYMBOL ptr ) as integer

declare function 	cTypeConvExpr			( tconvexpr as integer ) as integer

declare function 	cParentExpression		( parexpr as integer ) as integer

declare function 	cAtom					( atom as integer ) as integer

declare function 	cVariable				( varexpr as integer, _
											  sym as FBSYMBOL ptr, _
											  elm as FBSYMBOL ptr, _
											  byval checkarray as integer = TRUE )

declare function 	cVarOrDeref				( varexpr as integer, _
											  byval checkarray as integer = TRUE, _
											  byval checkaddrof as integer = FALSE )

declare function 	cFunction				( funcexpr as integer, _
											  sym as FBSYMBOL ptr, _
											  elm as FBSYMBOL ptr ) as integer

declare function 	cQuirkFunction			( funcexpr as integer ) as integer

declare function 	cConstant				( constexpr as integer ) as integer

declare function 	cLiteral 				( litexpr as integer ) as integer

declare function 	cFuncParamList			( byval proc as FBSYMBOL ptr, _
											  byval procexpr as integer, _
											  byval optonly as integer ) as integer

declare function 	cFuncParam				( byval proc as FBSYMBOL ptr, _
											  byval arg as FBSYMBOL ptr, _
											  byval procexpr as integer, _
											  byval optonly as integer ) as integer

declare function 	cProcParamList			( byval proc as FBSYMBOL ptr, _
											  byval procexpr as integer ) as integer

declare function 	cProcParam				( byval proc as FBSYMBOL ptr, _
											  byval arg as FBSYMBOL ptr, _
											  byval param as integer, _
											  expr as integer, _
											  pmode as integer, _
											  byval optonly as integer ) as integer

declare function 	cAsmBlock				( ) as integer

declare function 	cFunctionMode 			( ) as integer

declare function 	cFunctionCall			( byval sym as FBSYMBOL ptr, _
											  elm as FBSYMBOL ptr, _
											  funcexpr as integer, _
											  byval ptrexpr as integer ) as integer

declare function 	cProcCall				( byval sym as FBSYMBOL ptr, _
											  procexpr as integer, _
											  byval ptrexpr as integer, _
											  byval checkparents as integer = FALSE ) as integer

declare function 	cDerefFields			( byval sym as FBSYMBOL ptr, _
											  elm as FBSYMBOL ptr, _
											  typ as integer, _
											  subtype as FBSYMBOL ptr, _
					   						  varexpr as integer, _
					   						  byval isderef as integer, _
					   						  byval checkarray as integer ) as integer

declare function    cFuncPtrOrDerefFields	( sym as FBSYMBOL ptr, _
					      					  elm as FBSYMBOL ptr, _
					      					  byval typ as integer, _
					      					  byval subtype as FBSYMBOL ptr, _
					      					  varexpr as integer, _
					      					  byval isfuncptr as integer, _
					      					  byval checkarray as integer ) as integer

declare function 	hIsSttSeparatorOrComment( byval token as integer ) as integer

declare function 	hAssignFunctResult		( byval proc as FBSYMBOL ptr, _
											  byval expr as integer ) as integer

declare function 	cGfxStmt 				( ) as integer

declare function 	cGfxFunct				( funcexpr as integer ) as integer


'':::::
#define hMatchLPRNT()											 _
	if( not hMatch( CHAR_LPRNT ) ) then							:_
		hReportError FB.ERRMSG.EXPECTEDLPRNT                    :_
		exit function											:_
	end if

'':::::
#define hMatchRPRNT()											 _
	if( not hMatch( CHAR_RPRNT ) ) then							:_
		hReportError FB.ERRMSG.EXPECTEDRPRNT                    :_
		exit function											:_
	end if

'':::::
#define hMatchCOMMA()											 _
	if( not hMatch( CHAR_COMMA ) ) then							:_
		hReportError FB.ERRMSG.EXPECTEDCOMMA                    :_
		exit function											:_
	end if

'':::::
#define hMatchExpression(e)										 _
	if( not cExpression( e ) ) then                         	:_
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION				:_
		exit function											:_
	end if

