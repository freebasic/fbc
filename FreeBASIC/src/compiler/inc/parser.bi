''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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

'' compound statements permissions
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

'' compound statements stats
type FB_CMPSTMTSTK_ as FB_CMPSTMTSTK

type FB_CMPSTMT_DO
	attop			as integer
	inilabel		as FBSYMBOL ptr
	cmplabel		as FBSYMBOL ptr
	endlabel		as FBSYMBOL ptr
	last			as FB_CMPSTMTSTK_ ptr
end type

type FB_CMPSTMT_WHILE
	cmplabel		as FBSYMBOL ptr
	endlabel		as FBSYMBOL ptr
	last			as FB_CMPSTMTSTK_ ptr
end type

type FB_CMPSTMT_FORELM
	sym				as FBSYMBOL ptr				'' if sym = null, value will be used
	value			as FBVALUE
	dtype			as integer
end type

type FB_CMPSTMT_FOR
	outerscopenode	as ASTNODE ptr
	cnt				as FB_CMPSTMT_FORELM
	end            	as FB_CMPSTMT_FORELM
	stp				as FB_CMPSTMT_FORELM
	ispos			as FB_CMPSTMT_FORELM
	testlabel		as FBSYMBOL ptr
	inilabel		as FBSYMBOL ptr
	cmplabel		as FBSYMBOL ptr
	endlabel		as FBSYMBOL ptr
	last			as FB_CMPSTMTSTK_ ptr
	explicit_step   as integer
end type

type FB_CMPSTMT_IF
	issingle		as integer
	nxtlabel		as FBSYMBOL ptr
	endlabel		as FBSYMBOL ptr
	elsecnt			as integer
end type

type FB_CMPSTMT_PROC
	tkn				as FB_TOKEN
	node			as ASTNODE ptr
	is_nested		as integer
	cmplabel		as FBSYMBOL ptr
	endlabel		as FBSYMBOL ptr
	last			as FB_CMPSTMTSTK_ ptr
end type

type FB_CMPSTMT_SELCONST
	base			as integer
	deflabel 		as FBSYMBOL ptr
	minval			as uinteger
	maxval			as uinteger
end type

type FB_CMPSTMT_SELECT
	isconst			as integer
	sym				as FBSYMBOL ptr
	dtype			as FB_DATATYPE
	casecnt			as integer
	const_			as FB_CMPSTMT_SELCONST
	cmplabel		as FBSYMBOL ptr
	endlabel		as FBSYMBOL ptr
	last			as FB_CMPSTMTSTK_ ptr
end type

type FB_CMPSTMT_WITH
	last			as FBSYMBOL ptr
end type

type FB_CMPSTMT_NAMESPACE
	node			as ASTNODE ptr
	levels			as integer					'' nesting level
end type

type FB_CMPSTMT_EXTERN
	lastlib			as FBS_LIB ptr
	lastmang		as FB_MANGLING
end type

type FB_CMPSTMT_SCOPE
	lastis_scope	as integer
end type

type FB_CMPSTMTSTK
	id			as integer
	allowmask	as FB_CMPSTMT_MASK
	scopenode	as ASTNODE ptr
	union
		for		as FB_CMPSTMT_FOR
		do		as FB_CMPSTMT_DO
		while	as FB_CMPSTMT_WHILE
		if		as FB_CMPSTMT_IF
		proc	as FB_CMPSTMT_PROC
		select	as FB_CMPSTMT_SELECT
		with	as FB_CMPSTMT_WITH
		nspc	as FB_CMPSTMT_NAMESPACE
		ext		as FB_CMPSTMT_EXTERN
		scp		as FB_CMPSTMT_SCOPE
	end union
end type

type FBPARSER_STMT_WITH
	sym				as FBSYMBOL ptr
end type

type FB_LETSTMT_NODE
	expr			as ASTNODE ptr
end type

type FBPARSER_STMT_LET
	list			as TLIST					'' of FB_LETSTMT_NODE
end type

'' parser context
type FBPARSER_STMT
	stk				as TSTACK
	id				as FB_TOKEN					'' current compound stmt id

	cnt				as integer		            '' keep track of :'s to help scope break's

	for				as FB_CMPSTMTSTK ptr
	do				as FB_CMPSTMTSTK ptr
	while			as FB_CMPSTMTSTK ptr
	select			as FB_CMPSTMTSTK ptr
	proc			as FB_CMPSTMTSTK ptr
	with			as FBPARSER_STMT_WITH
	let				as FBPARSER_STMT_LET
end type

enum FB_PARSEROPT
	FB_PARSEROPT_NONE			= &h00000000
	FB_PARSEROPT_PRNTOPT		= &h00000001
	FB_PARSEROPT_CHKARRAY		= &h00000002	'' used by LEN() to handle expr's and ()-less arrays
	FB_PARSEROPT_ISEXPR			= &h00000004	'' parsing an expression?
	FB_PARSEROPT_ISSCOPE		= &h00000008
	FB_PARSEROPT_ISFUNC			= &h00000010
	FB_PARSEROPT_OPTONLY		= &h00000020
	FB_PARSEROPT_HASINSTPTR		= &h00000040
	FB_PARSEROPT_ISPROPGET		= &h00000080
	FB_PARSEROPT_EQINPARENTSONLY= &h00000100	'' only check for '=' if inside parentheses
end enum

type PARSERCTX
	'' stmt recursion
	stmt			as FBPARSER_STMT
	nspcrec			as integer					'' namespace recursion

	'' globals
	scope			as uinteger					'' current scope (0=main module)

	mangling		as FB_MANGLING				'' current EXTERN's mangling
	currlib			as FBS_LIB ptr				'' current EXTERN's library

	currproc 		as FBSYMBOL ptr				'' current proc
	currblock 		as FBSYMBOL ptr				'' current scope block (= proc if outside any block)

	asmtoklist		as TLIST					'' inline ASM list

	ovlarglist		as TLIST					'' used to resolve calls to overloaded functions

	'' hacks
	prntcnt			as integer					'' ()'s count, to allow optional ()'s on SUB's
	options			as FB_PARSEROPT
	ctx_dtype       as integer                  '' used to resolve the address of overloaded procs
	ctxsym			as FBSYMBOL ptr				'' /
end type

'' cSymbolType flags
enum FB_SYMBTYPEOPT
	FB_SYMBTYPEOPT_NONE			= &h00000000

	FB_SYMBTYPEOPT_CHECKSTRPTR	= &h00000001
	FB_SYMBTYPEOPT_ALLOWFORWARD	= &h00000002

	FB_SYMBTYPEOPT_DEFAULT		= FB_SYMBTYPEOPT_CHECKSTRPTR
end enum

'' cOperator flags
enum FB_OPEROPTS
	FB_OPEROPTS_NONE			= &h00000000

	FB_OPEROPTS_UNARY			= &h00000001
	FB_OPEROPTS_SELF			= &h00000002
	FB_OPEROPTS_ASSIGN			= &h00000004
	FB_OPEROPTS_RELATIVE		= &h00000008

	FB_OPEROPTS_DEFAULT			= &hffffffff
end enum

'' cIdentifier flags
enum FB_IDOPT
	FB_IDOPT_NONE				= &h00000000

	FB_IDOPT_DONTCHKPERIOD		= &h00000001
	FB_IDOPT_SHOWERROR			= &h00000002
	FB_IDOPT_ISDECL				= &h00000004
	FB_IDOPT_ISOPERATOR			= &h00000008
	FB_IDOPT_ALLOWSTRUCT		= &h00000010
	FB_IDOPT_CHECKSTATIC        = &h00000020

	FB_IDOPT_DEFAULT			= FB_IDOPT_SHOWERROR or FB_IDOPT_CHECKSTATIC
end enum

'' cInitializer flags
enum FB_INIOPT
	FB_INIOPT_NONE              = &h00000000

	FB_INIOPT_ISINI             = &h00000001
	FB_INIOPT_DODEREF           = &h00000002
	FB_INIOPT_ISOBJ             = &h00000004
end enum

'' cProcHead flags
enum FB_PROCOPT
	FB_PROCOPT_NONE				= &h00000000

	FB_PROCOPT_ISSUB			= &h00000001
	FB_PROCOPT_ISPROTO			= &h00000002
	FB_PROCOPT_HASPARENT		= &h00000004
end enum


declare function cProgram _
	( _
		_
	) as integer

declare function cLine _
	( _
		_
	) as integer

declare function cLabel _
	( _
		_
	) as integer

declare function cComment _
	( _
		byval lexflags as LEXCHECK = LEXCHECK_EVERYTHING _
	) as integer

declare function cDirective _
	( _
		_
	) as integer

declare function cStatement _
	( _
		_
	) as integer

declare function cStmtSeparator _
	( _
		byval lexflags as LEXCHECK = LEXCHECK_EVERYTHING _
	) as integer

declare function cDeclaration _
	( _
		_
	) as integer

declare function cConstDecl _
	( _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

declare function cConstAssign _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

declare function cTypeDecl _
	( _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

declare function cTypedefDecl _
	( _
		byval id as zstring ptr _
	) as integer

declare function cEnumDecl _
	( _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

declare function cVariableDecl _
	( _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

declare function cAutoVarDecl _
	( _
		byval attrib as FB_SYMBATTRIB _
	) as integer

declare function cStaticArrayDecl _
	( _
		byref dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval checkprnts as integer = TRUE, _
		byval allow_ellipsis as integer = TRUE _
	) as integer

declare function cArrayDecl _
	( _
		byref dimensions as integer, _
		exprTB() as ASTNODE ptr _
	) as integer

declare function cInitializer _
	( _
		byval s as FBSYMBOL ptr, _
		byval options as FB_INIOPT _
	) as ASTNODE ptr

declare function cTypeOf _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as integer = NULL _
	) as integer

declare function cSymbolType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as integer, _
		byval options as FB_SYMBTYPEOPT = FB_SYMBTYPEOPT_DEFAULT _
	) as integer

declare function cIdentifier _
	( _
		byref base_parent as FBSYMBOL ptr, _
		byval options as FB_IDOPT = FB_IDOPT_DEFAULT _
	) as FBSYMCHAIN ptr

declare function cParentId _
	( _
		byval options as FB_IDOPT = FB_IDOPT_NONE _
	) as FBSYMBOL ptr

declare function cProcDecl _
	( _
		_
	) as integer

declare function cProcHeader _
	( _
		byval attrib as FB_SYMBATTRIB, _
		byref is_nested as integer, _
		byval options as FB_PROCOPT _
	) as FBSYMBOL ptr

declare function cOperatorHeader _
	( _
		byval attrib as FB_SYMBATTRIB, _
		byref is_nested as integer, _
		byval options as FB_PROCOPT _
	) as FBSYMBOL ptr

declare function cCtorHeader _
	( _
		byval attrib as FB_SYMBATTRIB, _
		byref is_nested as integer, _
		byval is_prototype as integer _
	) as FBSYMBOL ptr

declare function cPropertyHeader _
	( _
		byval attrib as FB_SYMBATTRIB, _
		byref is_nested as integer, _
		byval is_prototype as integer _
	) as FBSYMBOL ptr

declare function cParameters _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval procmode as integer, _
		byval isproto as integer _
	) as FBSYMBOL ptr

declare function cDefDecl _
	( _
		_
	) as integer

declare function cOptDecl _
	( _
		_
	) as integer

declare function cProcCallOrAssign _
	( _
		_
	) as integer

declare function cQuirkStmt _
	( _
		byval tk as FB_TOKEN = INVALID _
	) as integer

declare function cCompoundStmt _
	( _
		_
	) as integer

declare function cCompStmtCheck _
	( _
		_
	) as integer

declare function cCompStmtPush _
	( _
		byval id as FB_TOKEN, _
		byval allowmask as FB_CMPSTMT_MASK = FB_CMPSTMT_MASK_DEFAULT _
	) as FB_CMPSTMTSTK ptr

declare function cCompStmtGetTOS _
	( _
		byval forid as FB_TOKEN, _
		byval showerror as integer = TRUE _
	) as FB_CMPSTMTSTK ptr

declare sub cCompStmtPop _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	)

declare function cCompStmtIsAllowed _
	( _
		byval allowmask as FB_CMPSTMT_MASK _
	) as integer

declare function cIfStmtBegin _
	( _
		_
	) as integer

declare function cIfStmtNext _
	( _
		_
	) as integer

declare function cIfStmtEnd _
	( _
		_
	) as integer

declare function cForStmtBegin _
	( _
		_
	) as integer

declare function cForStmtEnd _
	( _
		_
	) as integer

declare function cDoStmtBegin _
	( _
		_
	) as integer

declare function cDoStmtEnd _
	( _
		_
	) as integer

declare function cWhileStmtBegin _
	( _
		_
	) as integer

declare function cWhileStmtEnd _
	( _
		_
	) as integer

declare function cSelectStmtBegin _
	( _
		_
	) as integer

declare function cSelectStmtNext _
	( _
		_
	) as integer

declare function cSelectStmtEnd _
	( _
		_
	) as integer

declare function cSelConstStmtBegin _
	( _
		_
	) as integer

declare function cSelConstStmtNext _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	) as integer

declare function cSelConstStmtEnd _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	) as integer

declare function cProcStmtBegin _
	( _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

declare function cProcStmtEnd _
	( _
		_
	) as integer

declare function cExitStatement _
	( _
		_
	) as integer

declare function cEndStatement _
	( _
		_
	) as integer

declare function cContinueStatement _
	( _
		_
	) as integer

declare function cWithStmtBegin _
	( _
		_
	) as integer

declare function cWithStmtEnd _
	( _
		_
	) as integer

declare function cScopeStmtBegin _
	( _
		_
	) as integer

declare function cScopeStmtEnd _
	( _
		_
	) as integer

declare function cNamespaceStmtBegin _
	( _
		_
	) as integer

declare function cNamespaceStmtEnd _
	( _
		_
	) as integer

declare function cUsingStmt _
	( _
		_
	) as integer

declare function cExternStmtBegin _
	( _
		_
	) as integer

declare function cExternStmtEnd _
	( _
		_
	) as integer

declare function cAssignmentOrPtrCall _
	( _
		_
	) as integer

declare function cAssignmentOrPtrCallEx _
	( _
		byval expr as ASTNODE ptr _
	) as integer

declare function cOperator _
	( _
		byval options as FB_OPEROPTS = FB_OPEROPTS_DEFAULT _
	) as integer

declare function cExpression _
	( _
		_
	) as ASTNODE ptr

declare function cCatExpression _
	( _
		_
	) as ASTNODE ptr

declare function cBoolExpression _
	( _
		_
	) as ASTNODE ptr

declare function cLogExpression _
	( _
		_
	) as ASTNODE ptr

declare function cRelExpression _
	( _
		_
	) as ASTNODE ptr

declare function cAddExpression _
	( _
		_
	) as ASTNODE ptr

declare function cShiftExpression _
	( _
		_
	) as ASTNODE ptr

declare function cModExpression _
	( _
		_
	) as ASTNODE ptr

declare function cIntDivExpression _
	( _
		_
	) as ASTNODE ptr

declare function cMultExpression _
	( _
		_
	) as ASTNODE ptr

declare function cExpExpression _
	( _
		_
	) as ASTNODE ptr

declare function cNegNotExpression _
	( _
		_
	) as ASTNODE ptr

declare function cHighestPrecExpr _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr _
	) as ASTNODE ptr

declare function cPtrTypeCastingExpr _
	( _
		_
	) as ASTNODE ptr

declare function cDerefExpression _
	( _
		_
	) as ASTNODE ptr

declare function cAddrOfExpression _
	( _
		_
	) as ASTNODE ptr

declare function cTypeConvExpr _
	( _
		byval tk as FB_TOKEN, _
		byval isASM as integer = FALSE _
	) as ASTNODE ptr

declare function cEqInParentsOnlyExpr _
	( _
		_
	) as ASTNODE ptr

declare function cParentExpression _
	( _
		_
	) as ASTNODE ptr

declare function cAtom _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr _
	) as ASTNODE ptr

declare function cVariable _
	( _
		byval chain as FBSYMCHAIN ptr, _
		byval checkarray as integer = TRUE _
	) as ASTNODE ptr

declare function cVariableEx overload _
	( _
		byval sym as FBSYMBOL ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

declare function cVariableEx _
	( _
		byval chain as FBSYMCHAIN ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

declare function cWithVariable _
	( _
		byval sym as FBSYMBOL ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

declare function cImplicitDataMember _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

declare function cVarOrDerefEx _
	( _
		byval checkarray as integer = TRUE, _
		byval checkaddrof as integer = FALSE _
	) as ASTNODE ptr

declare function cVarOrDeref _
	( _
		byval checkarray as integer = TRUE, _
		byval checkaddrof as integer = FALSE, _
		byval force_expr as integer = FALSE _
	) as ASTNODE ptr

declare function cFunctionEx _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function cQuirkFunction _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function cConstant _
	( _
		byval chain as FBSYMCHAIN ptr _
	) as ASTNODE ptr

declare function cConstantEx _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function cEnumConstant _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function cLiteral _
	( _
		_
	) as ASTNODE ptr

declare function cNumLiteral _
	( _
		byval skiptoken as integer = TRUE _
	) as ASTNODE ptr

declare function cStrLiteral _
	( _
		byval skiptoken as integer = TRUE _
	) as ASTNODE ptr

declare function cProcArgList _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval arg_list as FB_CALL_ARG_LIST ptr, _
		byval options as FB_PARSEROPT _
	) as ASTNODE ptr

declare function cAsmBlock _
	( _
		_
	) as integer

declare function cProcReturnMethod _
	( _
		byval dtype as FB_DATATYPE _
	) as FB_PROC_RETURN_METHOD

declare function cProcCallingConv _
	( _
		byval default as FB_FUNCMODE = FB_FUNCMODE_DEFAULT _
	) as FB_FUNCMODE

declare function cFunctionCall _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr = NULL _
	) as ASTNODE ptr

declare function cProcCall _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr = NULL, _
		byval checkprnts as integer = FALSE _
	) as ASTNODE ptr

declare function cMethodCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function cCtorCall _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function cUdtMember _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval varexpr as ASTNODE ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

declare function cMemberAccess _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

declare function cMemberDeref _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval varexpr as ASTNODE ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

declare function cFuncPtrOrMemberDeref _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval varexpr as ASTNODE ptr, _
		byval isfuncptr as integer, _
		byval checkarray as integer _
	) as ASTNODE ptr

declare function cStrIdxOrMemberDeref _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

declare function cAssignment _
	( _
		byval assgexpr as ASTNODE ptr _
	) as integer

declare function cAssignFunctResult _
	( _
		byval proc as FBSYMBOL ptr, _
		byval is_return as integer _
	) as integer

declare function cGfxStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

declare function cGfxFunct _
	( _
		byval tk as FB_TOKEN _
	) as ASTNODE ptr

declare function cGotoStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

declare function cPrintStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

declare function cDataStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

declare function cArrayStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

declare function cLineInputStmt _
	( _
		_
	) as integer

declare function cInputStmt _
	( _
		_
	) as integer

declare function cPokeStmt _
	( _
		_
	) as integer

declare function cFileStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

declare function cOnStmt _
	( _
		_
	) as integer

declare function cWriteStmt _
	( _
		_
	) as integer

declare function cErrorStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

declare function cViewStmt _
	( _
		byval is_func as integer = FALSE, _
		byref funcexpr as ASTNODE ptr = NULL _
	) as integer

declare function cMidStmt _
	( _
		_
	) as integer

declare function cLRSetStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

declare function cWidthStmt _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

declare function cColorStmt _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

declare function cStringFunct _
	( _
		byval tk as FB_TOKEN, _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cCVXFunct _
	( _
		byval tk as FB_TOKEN, _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cMKXFunct _
	( _
		byval tk as FB_TOKEN, _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cMathFunct _
	( _
		byval tk as FB_TOKEN, _
		byref funcexpr as ASTNODE ptr, _
		byval isasm as integer = FALSE _
	) as integer

declare function cPeekFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cArrayFunct _
	( _
		byval tk as FB_TOKEN, _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cFileFunct _
	( _
		byval tk as FB_TOKEN, _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cErrorFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cIIFFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cVAFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cScreenFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

declare function cAnonUDT _
	( _
		_
	) as ASTNODE ptr

declare function cConstExprValue _
	( _
		byref value as integer _
	) as integer

declare function cOperatorNew _
	( _
		_
	) as ASTNODE ptr

declare function cOperatorDelete _
	( _
		_
	) as integer

declare sub hSkipUntil _
	( _
		byval token as integer, _
		byval doeat as integer = FALSE, _
		byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
	)

declare sub hSkipCompound _
	( _
		byval for_token as integer, _
		byval until_token as integer = INVALID, _
		byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
	)

declare function hMatchExpr _
	( _
		byval dtype as integer _
	) as ASTNODE ptr


declare function hDeclCheckParent _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

declare function hVarDeclEx _
	( _
		byval attrib as integer, _
		byval dopreserve as integer, _
        byval token as integer, _
        byval is_fordecl as integer _
	) as FBSYMBOL ptr

declare function hSymbolType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as integer _
	) as integer

declare function hCheckForDefiniteTypes _
	( _
		_
	) as integer

declare function hCheckForDefiniteExprs _
	( _
		_
	) as integer

''
'' macros
''
#define cCompSetAllowmask(s, v) s->allowmask = v

#define hSkipStmt( ) _
	hSkipUntil( INVALID, FALSE )

'':::::
#macro hMatchLPRNT()
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
			exit function
		end if
	else
		lexSkipToken( )
	end if
#endmacro

'':::::
#macro hMatchRPRNT()
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
			exit function
		else
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	else
		lexSkipToken( )
	end if
#endmacro

'':::::
#macro hMatchCOMMA()
	if( lexGetToken( ) <> CHAR_COMMA ) then
		if( errReport( FB_ERRMSG_EXPECTEDCOMMA ) = FALSE ) then
			exit function
		end if
	else
		lexSkipToken( )
	end if
#endmacro

'':::::
#macro hMatchExpression(e)
	e = hMatchExpr( INVALID )
	if( e = NULL ) then
		exit function
	end if
#endmacro

'':::::
#macro hMatchExpressionEx(e, dtype)
	e = hMatchExpr( dtype )
	if( e = NULL ) then
		exit function
	end if
#endmacro

'':::::
#macro hCheckSuffix(suffix)
	if( suffix <> FB_DATATYPE_INVALID ) then
		if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_SUFFIX, FB_ERRMSG_SUFFIXONLYVALIDINLANG )
		end if
	end if
#endmacro

'':::::
#macro hEmitCurrLine( )
	if( env.clopt.debug ) then
		if( env.includerec = 0 ) then
			astAdd( astNewLIT( lexCurrLineGet( ) ) )
			lexCurrLineReset( )
		end if
	end if
#endmacro

#define hGetInstPtrMode(ip) iif( astIsCONST( ip ), FB_PARAMMODE_BYVAL, INVALID )

#define fbIsModLevel( ) (parser.currproc = env.main.proc)

#define fbGetCompStmtId( ) parser.stmt.id

#define fbGetPrntOptional( ) ((parser.options and FB_PARSEROPT_PRNTOPT) <> 0)

#macro fbSetPrntOptional( _bool )
	if( _bool ) then
		parser.options or= FB_PARSEROPT_PRNTOPT
	else
		parser.options and= not FB_PARSEROPT_PRNTOPT
	end if
#endmacro

#define fbGetCheckArray( ) ((parser.options and FB_PARSEROPT_CHKARRAY) <> 0)

#macro fbSetCheckArray( _bool )
	if( _bool ) then
		parser.options or= FB_PARSEROPT_CHKARRAY
	else
		parser.options and= not FB_PARSEROPT_CHKARRAY
	end if
#endmacro

#define fbGetIsExpression( ) ((parser.options and FB_PARSEROPT_ISEXPR) <> 0)

#macro fbSetIsExpression( _bool )
	if( _bool ) then
		parser.options or= FB_PARSEROPT_ISEXPR
	else
		parser.options and= not FB_PARSEROPT_ISEXPR
	end if
#endmacro

#define fbGetIsScope( ) ((parser.options and FB_PARSEROPT_ISSCOPE) <> 0)

#macro fbSetIsScope( _bool )
	if( _bool ) then
		parser.options or= FB_PARSEROPT_ISSCOPE
	else
		parser.options and= not FB_PARSEROPT_ISSCOPE
	end if
#endmacro

#define fbGetEqInParentsOnly( ) ((parser.options and FB_PARSEROPT_EQINPARENTSONLY) <> 0)

#macro fbSetEqInParentsOnly( _bool )
	if( _bool ) then
		parser.options or= FB_PARSEROPT_EQINPARENTSONLY
	else
		parser.options and= not FB_PARSEROPT_EQINPARENTSONLY
	end if
#endmacro

''
'' inter-module globals
''
extern parser as PARSERCTX

