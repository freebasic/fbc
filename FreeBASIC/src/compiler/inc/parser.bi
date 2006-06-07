''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

enum FB_CMPSTMT_MASK
	FB_CMPSTMT_MASK_NOTHING		= &h00000000
	FB_CMPSTMT_MASK_CODE		= &h00000001
	FB_CMPSTMT_MASK_PROC		= &h00000002
	FB_CMPSTMT_MASK_NAMESPC		= &h00000004
	FB_CMPSTMT_MASK_DECL		= &h00000008
	FB_CMPSTMT_MASK_EXTERN		= &h00000010
	FB_CMPSTMT_MASK_DATA		= &h00000020
	FB_CMPSTMT_MASK_ALL 		= &hFFFFFFFF
	FB_CMPSTMT_MASK_DEFAULT		= FB_CMPSTMT_MASK_CODE
end enum

type FB_CMPSTMT_DO
	attop		as integer
	inilabel	as FBSYMBOL ptr
end type

type FB_CMPSTMT_FOR
	inilabel	as FBSYMBOL ptr
	testlabel	as FBSYMBOL ptr
	iscomplex	as integer
	ispositive	as integer
	cnt			as FBSYMBOL ptr
	endc		as FBSYMBOL ptr
	stp			as FBSYMBOL ptr
	eval		as FBVALUE
	sval		as FBVALUE
end type

type FB_CMPSTMT_IF
	issingle	as integer
	nxtlabel	as FBSYMBOL ptr
	endlabel	as FBSYMBOL ptr
	elsecnt		as integer
end type

type FB_CMPSTMT_PROC
	issub		as integer
	node		as ASTNODE ptr
end type

type FB_CMPSTMT_SELCONST
	base		as integer
	deflabel 	as FBSYMBOL ptr
	minval		as uinteger
	maxval		as uinteger
end type

type FB_CMPSTMT_SELECT
	isconst		as integer
	sym			as FBSYMBOL ptr
	dtype		as FB_DATATYPE
	casecnt		as integer
	const		as FB_CMPSTMT_SELCONST
end type

type FB_CMPSTMT_WITH
	last		as FBSYMBOL ptr
end type

type FB_CMPSTMT_NAMESPACE
	lastsymtb	as FBSYMBOLTB ptr
	lasthashtb	as FBHASHTB ptr
	lastns		as FBSYMBOL ptr
end type

type FB_CMPSTMT_EXTERN
	lastlib		as FBLIBRARY ptr
	lastmang	as FB_MANGLING
end type

type FB_CMPSTMTSTK
	id			as integer
	allowmask	as FB_CMPSTMT_MASK
	last		as FBCMPSTMT
	scopenode	as ASTNODE ptr
	union
		do		as FB_CMPSTMT_DO
		for		as FB_CMPSTMT_FOR
		if		as FB_CMPSTMT_IF
		proc	as FB_CMPSTMT_PROC
		select	as FB_CMPSTMT_SELECT
		with	as FB_CMPSTMT_WITH
		nspc	as FB_CMPSTMT_NAMESPACE
		ext		as FB_CMPSTMT_EXTERN
	end union
end type


declare function 	cProgram				( _
												_
											) as integer

declare function 	cLine					( _
												_
											) as integer

declare function 	cLabel                  ( _
												_
											) as integer

declare function 	cComment                ( _
												byval lexflags as LEXCHECK = LEXCHECK_EVERYTHING _
											) as integer

declare function 	cDirective              ( _
												_
											) as integer

declare function 	cStatement              ( _
												_
											) as integer

declare function 	cStmtSeparator 			( _
												byval lexflags as LEXCHECK = LEXCHECK_EVERYTHING _
											) as integer

declare function 	cDeclaration            ( _
												_
											) as integer

declare function 	cConstDecl              ( _
												_
											) as integer

declare function 	cConstAssign            ( _
												byval dtype as integer, _
					   						  	byval subtype as FBSYMBOL ptr _
											) as integer

declare function 	cTypeDecl               ( _
												_
											) as integer

declare function 	cTypedefDecl			( _
												byval id as zstring ptr _
											) as integer

declare function 	cEnumDecl               ( _
												_
											) as integer

declare function 	cVariableDecl           ( _
												_
											) as integer

declare function 	cStaticArrayDecl 		( _
												byref dimensions as integer, _
												dTB() as FBARRAYDIM, _
												byval checkprnts as integer = TRUE _
											) as integer

declare function 	cArrayDecl				( _
												byref dimensions as integer, _
												exprTB() as ASTNODE ptr _
											) as integer

declare function 	cVariableInit			( _
												byval s as FBSYMBOL ptr, _
												byval isinitializer as integer _
											) as ASTNODE ptr

declare function 	cSymbolType 			( _
												byref dtype as integer, _
												byref subtype as FBSYMBOL ptr, _
												byref lgt as integer, _
												byref ptrcnt as integer, _
												byval checkptr as integer = TRUE _
											) as integer

declare function 	cIdentifier				( _
												byval isdecl as integer = FALSE, _
												byval showerror as integer = TRUE _
											) as FBSYMCHAIN ptr

declare function 	cNamespace				( _
												_
											) as FBSYMBOL ptr

declare function 	cProcDecl               ( _
												_
											) as integer

declare function 	cSubOrFuncDecl 			( _
												byval isSub as integer _
											) as integer

declare function 	cParameters             ( _
												byval proc as FBSYMBOL ptr, _
												byval procmode as integer, _
												byval isproto as integer _
											) as FBSYMBOL ptr

declare function 	cDefDecl				( _
												_
											) as integer

declare function 	cOptDecl				( _
												_
											) as integer

declare function 	cProcCallOrAssign		( _
												_
											) as integer

declare function 	cQuirkStmt				( _
												_
											) as integer

declare function 	cCompoundStmt           ( _
												_
											) as integer

declare function 	cCompStmtCheck      	( _
												_
											) as integer

declare function 	cCompStmtPush 			( _
												byval id as FB_TOKEN, _
												byval allowmask as FB_CMPSTMT_MASK = FB_CMPSTMT_MASK_DEFAULT _
											) as FB_CMPSTMTSTK ptr

declare function 	cCompStmtGetTOS  		( _
												byval forid as FB_TOKEN, _
												byval showerror as integer = TRUE _
											) as FB_CMPSTMTSTK ptr

declare sub 		cCompStmtPop 			( _
												byval stk as FB_CMPSTMTSTK ptr _
											)

declare function 	cCompStmtIsAllowed 		( _
												byval allowmask as FB_CMPSTMT_MASK _
											) as integer

declare function 	cIfStmtBegin			( _
												_
											) as integer

declare function 	cIfStmtNext				( _
												_
											) as integer

declare function 	cIfStmtEnd				( _
												_
											) as integer

declare function 	cSingleIfStatement		( _
												byval expr as ASTNODE ptr _
											) as integer

declare function 	cBlockIfStatement		( _
												byval expr as ASTNODE ptr _
											) as integer

declare function 	cForStmtBegin          	( _
												_
											) as integer

declare function 	cForStmtEnd          	( _
												_
											) as integer

declare function 	cDoStmtBegin           	( _
												_
											) as integer

declare function 	cDoStmtEnd           	( _
												_
											) as integer

declare function 	cWhileStmtBegin        	( _
												_
											) as integer

declare function 	cWhileStmtEnd        	( _
												_
											) as integer

declare function 	cSelectStmtBegin       	( _
												_
											) as integer

declare function 	cSelectStmtNext       	( _
												_
											) as integer

declare function 	cSelectStmtEnd       	( _
												_
											) as integer

declare function 	cSelConstStmtBegin 		( _
												_
											) as integer

declare function 	cSelConstStmtNext		( _
												byval stk as FB_CMPSTMTSTK ptr _
											) as integer

declare function 	cSelConstStmtEnd		( _
												byval stk as FB_CMPSTMTSTK ptr _
											) as integer

declare function 	cProcStmtBegin         	( _
												_
											) as integer

declare function 	cProcStmtEnd         	( _
												_
											) as integer

declare function 	cExitStatement			( _
												_
											) as integer

declare function 	cEndStatement			( _
												_
											) as integer

declare function 	cContinueStatement		( _
												_
											) as integer

declare function 	cWithStmtBegin          ( _
												_
											) as integer

declare function 	cWithStmtEnd            ( _
												_
											) as integer

declare function 	cScopeStmtBegin			( _
												_
											) as integer

declare function 	cScopeStmtEnd			( _
												_
											) as integer

declare function 	cNamespaceStmtBegin		( _
												_
											) as integer

declare function 	cNamespaceStmtEnd		( _
												_
											) as integer

declare function 	cUsingStmt 				( _
												_
											) as integer

declare function 	cExternStmtBegin		( _
												_
											) as integer

declare function 	cExternStmtEnd			( _
												_
											) as integer

declare function 	cAssignmentOrPtrCall	( _
												_
											) as integer

declare function 	cAssignmentOrPtrCallEx	( _
												byval expr as ASTNODE ptr _
											) as integer

declare function 	cExpression				( _
												byref expr as ASTNODE ptr _
											) as integer

declare function 	cCatExpression			( _
												byref catexpr as ASTNODE ptr _
											) as integer

declare function 	cLogExpression			( _
												byref logexpr as ASTNODE ptr _
											) as integer

declare function 	cRelExpression			( _
												byref relexpr as ASTNODE ptr _
											) as integer

declare function 	cAddExpression			( _
												byref addexpr as ASTNODE ptr _
											) as integer

declare function 	cShiftExpression		( _
												byref shiftexpr as ASTNODE ptr _
											) as integer

declare function 	cModExpression			( _
												byref modexpr as ASTNODE ptr _
											) as integer

declare function 	cIntDivExpression		( _
												byref idivexpr as ASTNODE ptr _
											) as integer

declare function 	cMultExpression			( _
												byref mulexpr as ASTNODE ptr _
											) as integer

declare function 	cExpExpression 			( _
												byref expexpr as ASTNODE ptr _
											) as integer

declare function 	cNegNotExpression		( _
												byref negexpr as ASTNODE ptr _
											) as integer

declare function 	cHighestPrecExpr		( _
												byval chain_ as FBSYMCHAIN ptr, _
												byref highexpr as ASTNODE ptr _
											) as integer

declare function 	cPtrTypeCastingExpr		( _
												byref castexpr as ASTNODE ptr _
											) as integer

declare function 	cDerefExpression		( _
												byref derefexpr as ASTNODE ptr _
											) as integer

declare function 	cAddrOfExpression		( _
												byref addrofexpr as ASTNODE ptr _
											) as integer

declare function 	cTypeConvExpr			( _
												byref tconvexpr as ASTNODE ptr _
											) as integer

declare function 	cParentExpression		( _
												byref parexpr as ASTNODE ptr _
											) as integer

declare function 	cAtom					( _
												byval chain_ as FBSYMCHAIN ptr, _
												byref atom as ASTNODE ptr _
											) as integer

declare function 	cVariable				( _
												byval chain as FBSYMCHAIN ptr, _
												byref varexpr as ASTNODE ptr, _
												byval checkarray as integer = TRUE _
											) as integer

declare function 	cVariableEx				( _
												byval chain as FBSYMCHAIN ptr, _
					  						  	byref varexpr as ASTNODE ptr, _
					  						  	byval checkarray as integer _
											) as integer

declare function 	cWithVariable			( _
												byval sym as FBSYMBOL ptr, _
					   					  	  	byref varexpr as ASTNODE ptr, _
					    				  	  	byval checkarray as integer _
											) as integer

declare function 	cVarOrDeref				( _
												byref varexpr as ASTNODE ptr, _
												byval checkarray as integer = TRUE, _
												byval checkaddrof as integer = FALSE _
											) as integer

declare function 	cFunctionEx				( _
												byval sym as FBSYMBOL ptr, _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cQuirkFunction			( _
												byval sym as FBSYMBOL ptr, _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cConstant				( _
												byval chain as FBSYMCHAIN ptr, _
												byref constexpr as ASTNODE ptr _
											) as integer

declare function 	cConstantEx				( _
												byval sym as FBSYMBOL ptr, _
					  						  	byref expr as ASTNODE ptr _
											) as integer

declare function 	cEnumConstant			( _
												byval sym as FBSYMBOL ptr, _
				  							  	byref expr as ASTNODE ptr _
											) as integer

declare function 	cLiteral 				( _
												byref litexpr as ASTNODE ptr _
											) as integer

declare function 	cNumLiteral				( _
												byref expr as ASTNODE ptr _
											) as integer

declare function 	cStrLiteral				( _
												byref expr as ASTNODE ptr, _
					  						  	byval checkescape as integer _
											) as integer

declare function 	cProcArgList			( _
												byval proc as FBSYMBOL ptr, _
						 					  	byval ptrexpr as ASTNODE ptr, _
						 					  	byval isfunc as integer, _
						 					  	byval optonly as integer _
											) as ASTNODE ptr

declare function 	cAsmBlock				( _
												_
											) as integer

declare function 	cFunctionMode 			( _
												_
											) as integer

declare function 	cFunctionCall			( _
												byval sym as FBSYMBOL ptr, _
												byref funcexpr as ASTNODE ptr, _
												byval ptrexpr as ASTNODE ptr _
											) as integer

declare function 	cProcCall				( _
												byval sym as FBSYMBOL ptr, _
												byref procexpr as ASTNODE ptr, _
												byval ptrexpr as ASTNODE ptr, _
												byval checkparents as integer = FALSE _
											) as integer

declare function 	cDerefFields			( _
												byref typ as integer, _
												byref subtype as FBSYMBOL ptr, _
					   						  	byref varexpr as ASTNODE ptr, _
					   						  	byval checkarray as integer _
											) as integer

declare function    cFuncPtrOrDerefFields	( _
												byval typ as integer, _
					      					  	byval subtype as FBSYMBOL ptr, _
					      					  	byref varexpr as ASTNODE ptr, _
					      					  	byval isfuncptr as integer, _
					      					  	byval checkarray as integer _
											) as integer

declare function	cUpdPointer				( _
												byval op as integer, _
					  						  	byval p as ASTNODE ptr, _
					  						  	byval e as ASTNODE ptr _
											) as ASTNODE ptr

declare function 	cAssignment				( _
												byval assgexpr as ASTNODE ptr _
											) as integer

declare function 	cAssignFunctResult		( _
												byval proc as FBSYMBOL ptr _
											) as integer

declare function 	cGfxStmt 				( _
												_
											) as integer

declare function 	cGfxFunct				( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cGotoStmt				( _
												_
											) as integer

declare function 	cPrintStmt				( _
												_
											) as integer

declare function 	cDataStmt				( _
												_
											) as integer

declare function 	cArrayStmt				( _
												_
											) as integer

declare function 	cLineInputStmt			( _
												_
											) as integer

declare function 	cInputStmt				( _
												_
											) as integer

declare function 	cPokeStmt				( _
												_
											) as integer

declare function 	cFileStmt				( _
												_
											) as integer

declare function 	cLocateStmt				( _
												byval isfunc as integer _
											) as ASTNODE ptr

declare function 	cOnStmt					( _
												_
											) as integer

declare function 	cWriteStmt				( _
												_
											) as integer

declare function 	cErrorStmt				( _
												_
											) as integer

declare function 	cViewStmt				( _
												byval is_func as integer = FALSE, _
                   							 	byref funcexpr as ASTNODE ptr = NULL _
											) as integer

declare function 	cMidStmt				( _
												_
											) as integer

declare function 	cLSetStmt				( _
												_
											) as integer

declare function 	cWidthStmt				( _
												byval isfunc as integer _
											) as ASTNODE ptr

declare function 	cStringFunct			( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cMathFunct				( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cPeekFunct				( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cArrayFunct				( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cFileFunct				( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cErrorFunct				( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cIIFFunct				( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cVAFunct				( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cScreenFunct			( _
												byref funcexpr as ASTNODE ptr _
											) as integer

declare function 	cConstExprValue			( _
												byref value as integer _
											) as integer

declare sub 		hSkipUntil				( _
												byval token as integer, _
												byval doeat as integer = FALSE, _
												byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
											)

declare sub 		hSkipCompound 			( _
												byval for_token as integer, _
												byval until_token as integer = INVALID, _
												byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
											)

declare function 	hMatchExpr 				( _
												byval dtype as integer _
											) as ASTNODE ptr


''
'' macros
''
#define cCompSetAllowmask(s, v) s->allowmask = v

#define hSkipStmt( ) 													_
	hSkipUntil( INVALID, FALSE )

'':::::
#define hMatchLPRNT()													_
	if( lexGetToken( ) <> CHAR_LPRNT ) then								:_
		if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then		:_
			exit function												:_
		end if                                                          :_
	else																:_
		lexSkipToken( )                                                 :_
	end if

'':::::
#define hMatchRPRNT()													_
	if( lexGetToken( ) <> CHAR_RPRNT ) then								:_
		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then		:_
			exit function												:_
		else															:_
			hSkipUntil( CHAR_RPRNT, TRUE )								:_
		end if                                                          :_
	else																:_
		lexSkipToken( )                                                 :_
	end if

'':::::
#define hMatchCOMMA()													_
	if( lexGetToken( ) <> CHAR_COMMA ) then								:_
		if( errReport( FB_ERRMSG_EXPECTEDCOMMA ) = FALSE ) then		:_
			exit function												:_
		end if                                                          :_
	else																:_
		lexSkipToken( )                                                 :_
	end if

'':::::
#define hMatchExpression(e)									 			_
	e = hMatchExpr( INVALID )											:_
	if( e = NULL ) then													:_
		exit function													:_
	end if

'':::::
#define hMatchExpressionEx(e, dtype)						 			_
	e = hMatchExpr( dtype )												:_
	if( e = NULL ) then													:_
		exit function													:_
	end if

