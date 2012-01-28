''
'' parser protos
''

#include once "lex.bi"
#include once "ast.bi"

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
	outerscopenode		as ASTNODE ptr '' Big scope around the whole SELECT compound (to destroy its temp var)
end type

type FB_CMPSTMT_WITH
	last			as FBSYMBOL ptr
end type

type FB_CMPSTMT_NAMESPACE
	as FBSYMBOL ptr sym '' Namespace symbol
	as integer levels   '' a.b.c nesting level (multiple nested namespaces in this namespace compound block)
end type

type FB_CMPSTMT_EXTERN
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
	FB_PARSEROPT_CHKARRAY		= &h00000002	'' used by LEN() to handle expr's and ()-less arrays (while set, there will be "array access, index expected" errors, unsetting allows to have no-index arrays, e.g. as bydesc arguments, or in l/ubound())
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

'' cVarOrDeref flags
enum FB_VAREXPROPT
	FB_VAREXPROPT_NONE         = &h00000000
	FB_VAREXPROPT_NOARRAYCHECK = &h00000001
	FB_VAREXPROPT_ALLOWADDROF  = &h00000002
	FB_VAREXPROPT_ISEXPR       = &h00000004
	FB_VAREXPROPT_ISASSIGN     = &h00000010  '' Used by SWAP to disallow CALLs etc.
end enum

declare sub cProgram()

declare function cLabel _
	( _
		_
	) as integer

declare function cComment _
	( _
		byval lexflags as LEXCHECK = LEXCHECK_EVERYTHING _
	) as integer

declare sub cDirective()
declare sub cStatement()

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

declare sub cTypedefMultDecl()
declare sub cTypedefSingleDecl(byval pid as zstring ptr)
declare sub cEnumDecl(byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE)
declare function hCheckScope() as integer

declare function cVariableDecl _
	( _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

declare sub cAutoVarDecl(byval attrib as FB_SYMBATTRIB)

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

declare sub cTypeOf _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as integer = NULL _
	)

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

declare sub cCurrentParentId()

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

declare sub cParameters _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval procmode as integer, _
		byval isproto as integer _
	)

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

declare sub cIfStmtBegin()

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

declare sub cDoStmtBegin()

declare function cDoStmtEnd _
	( _
		_
	) as integer

declare sub cWhileStmtBegin()

declare function cWhileStmtEnd _
	( _
		_
	) as integer

declare sub cSelectStmtBegin()

declare function cSelectStmtNext _
	( _
		_
	) as integer

declare function cSelectStmtEnd _
	( _
		_
	) as integer

declare sub cSelConstStmtBegin()
declare sub cSelConstStmtNext(byval stk as FB_CMPSTMTSTK ptr)
declare sub cSelConstStmtEnd(byval stk as FB_CMPSTMTSTK ptr)

declare function cProcStmtBegin _
	( _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

declare function cProcStmtEnd _
	( _
		_
	) as integer

declare sub cExitStatement()

declare function cEndStatement _
	( _
		_
	) as integer

declare sub cContinueStatement()
declare sub cWithStmtBegin()

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
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

declare function cVarOrDeref _
	( _
		byval options as FB_VAREXPROPT = FB_VAREXPROPT_NONE _
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

declare function cAliasAttribute() as zstring ptr
declare sub cLibAttribute()

declare function cProcReturnMethod _
	( _
		byval dtype as FB_DATATYPE _
	) as FB_PROC_RETURN_METHOD

declare function cProcCallingConv _
	( _
		byval default as FB_FUNCMODE = FB_USE_FUNCMODE_FBCALL _
	) as FB_FUNCMODE

declare function cFunctionCall _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr = NULL _
	) as ASTNODE ptr

declare sub hMethodCallAddInstPtrOvlArg _
    ( _
        byval proc as FBSYMBOL ptr, _
        byval thisexpr as ASTNODE ptr, _
        byval arg_list as FB_CALL_ARG_LIST ptr, _
        byval options as FB_PARSEROPT ptr _
    )

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

declare sub cAssignment(byval assgexpr as ASTNODE ptr)

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

declare function cWriteStmt() as integer
declare function cErrorStmt() as integer
declare function cErrSetStmt() as integer
declare function cViewStmt(byval is_func as integer) as ASTNODE ptr
declare function cMidStmt() as integer
declare function cLRSetStmt(byval tk as FB_TOKEN) as integer
declare function cWidthStmt(byval isfunc as integer) as ASTNODE ptr
declare function cColorStmt(byval isfunc as integer) as ASTNODE ptr
declare function cStringFunct(byval tk as FB_TOKEN) as ASTNODE ptr
declare function cCVXFunct(byval tk as FB_TOKEN) as ASTNODE ptr
declare function cMKXFunct(byval tk as FB_TOKEN) as ASTNODE ptr
declare function cMathFunct _
	( _
		byval tk as FB_TOKEN, _
		byval isasm as integer _
	) as ASTNODE ptr
declare function cPeekFunct() as ASTNODE ptr
declare function cArrayFunct(byval tk as FB_TOKEN) as ASTNODE ptr
declare function cFileFunct(byval tk as FB_TOKEN) as ASTNODE ptr
declare function cErrorFunct() as ASTNODE ptr
declare function cIIFFunct() as ASTNODE ptr
declare function cVAFunct() as ASTNODE ptr
declare function cScreenFunct() as ASTNODE ptr
declare function cAnonUDT() as ASTNODE ptr
declare sub cConstExprValue(byref value as integer)

declare function cOperatorNew _
	( _
		_
	) as ASTNODE ptr

declare sub cOperatorDelete()

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

declare function hVarDeclEx _
	( _
		byval attrib as integer, _
		byval dopreserve as integer, _
        byval token as integer, _
        byval is_fordecl as integer _
	) as FBSYMBOL ptr

declare sub hSymbolType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as integer _
	)

declare function hCheckForDefiniteTypes _
	( _
		_
	) as integer

declare function hCheckForDefiniteExprs _
	( _
		_
	) as integer

declare function cThreadCallFunc() as ASTNODE ptr
    
''
'' macros
''
#define cCompSetAllowmask(s, v) s->allowmask = v

#define hSkipStmt( ) _
	hSkipUntil( INVALID, FALSE )

'':::::
#macro hMatchLPRNT()
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDLPRNT )
	else
		lexSkipToken( )
	end if
#endmacro

'':::::
#macro hMatchRPRNT()
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDRPRNT )
		hSkipUntil( CHAR_RPRNT, TRUE )
	else
		lexSkipToken( )
	end if
#endmacro

'':::::
#macro hMatchCOMMA()
	if( lexGetToken( ) <> CHAR_COMMA ) then
		errReport( FB_ERRMSG_EXPECTEDCOMMA )
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

