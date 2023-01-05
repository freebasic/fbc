#ifndef __AST_BI__
#define __AST_BI__

#include once "list.bi"
#include once "ast-op.bi"
#include once "ir.bi"

const AST_INITNODES             = 8192
const AST_INITPROCNODES         = 128

'' when changing, update ast.bas:ast_loadcallbacks() and ast-node-misc.bas:dbg_astNodeClassNames()
enum AST_NODECLASS
	AST_NODECLASS_NOP

	AST_NODECLASS_LOAD
	AST_NODECLASS_ASSIGN
	AST_NODECLASS_BOP
	AST_NODECLASS_UOP
	AST_NODECLASS_CONV
	AST_NODECLASS_ADDROF
	AST_NODECLASS_BRANCH
	AST_NODECLASS_JMPTB
	AST_NODECLASS_CALL
	AST_NODECLASS_CALLCTOR
	AST_NODECLASS_STACK
	AST_NODECLASS_MEM

	'' LOOP nodes, used to wrap loop code (e.g. new[]'s defctor calling)
	'' that needs to be LINKed into expression trees, because it isn't
	'' immediately astAdd()'ed, thus may be cloned. The LOOP wrapper node
	'' allows astCloneTree() to duplicate the loop's LABEL and also update
	'' the corresponding BRANCH.
	AST_NODECLASS_LOOP

	'' Only used to classify comparison operators, there are no COMP nodes.
	AST_NODECLASS_COMP

	AST_NODECLASS_LINK
	AST_NODECLASS_CONST
	AST_NODECLASS_VAR
	AST_NODECLASS_IDX
	AST_NODECLASS_FIELD
	AST_NODECLASS_DEREF
	AST_NODECLASS_LABEL
	AST_NODECLASS_ARG
	AST_NODECLASS_OFFSET
	AST_NODECLASS_DECL

	AST_NODECLASS_NIDXARRAY

	AST_NODECLASS_IIF
	AST_NODECLASS_LIT
	AST_NODECLASS_ASM
	AST_NODECLASS_DATASTMT
	AST_NODECLASS_DBG

	AST_NODECLASS_BOUNDCHK
	AST_NODECLASS_PTRCHK

	AST_NODECLASS_SCOPEBEGIN
	AST_NODECLASS_SCOPEEND
	AST_NODECLASS_SCOPE_BREAK

	AST_NODECLASS_TYPEINI
	AST_NODECLASS_TYPEINI_PAD
	AST_NODECLASS_TYPEINI_ASSIGN
	AST_NODECLASS_TYPEINI_CTORCALL
	AST_NODECLASS_TYPEINI_CTORLIST
	AST_NODECLASS_TYPEINI_SCOPEINI
	AST_NODECLASS_TYPEINI_SCOPEEND

	AST_NODECLASS_PROC
	AST_NODECLASS_MACRO

	AST_CLASSES
end enum

enum AST_OPOPT
	AST_OPOPT_NONE          = &h00000000

	AST_OPOPT_ALLOCRES      = &h00000001
	AST_OPOPT_LPTRARITH     = &h00000002
	AST_OPOPT_RPTRARITH     = &h00000004
	AST_OPOPT_NOCOERCION    = &h00000008
	AST_OPOPT_DONTCHKPTR    = &h00000010
	AST_OPOPT_DONTCHKOPOVL  = &h00000020
	AST_OPOPT_ISINI         = &h00000040

	AST_OPOPT_DOPTRARITH    = AST_OPOPT_LPTRARITH or AST_OPOPT_RPTRARITH

	AST_OPOPT_DEFAULT       = AST_OPOPT_ALLOCRES
end enum

#ifndef ASTNODE_
type ASTNODE_ as ASTNODE
#endif

'' update astCloneCALL( ), astDelCALL() if the next structs are changed
type AST_TMPSTRLIST_ITEM
	sym             as FBSYMBOL ptr
	srctree         as ASTNODE_ ptr
	prev            as AST_TMPSTRLIST_ITEM ptr
end type

type AST_NODE_CALL
	isrtl           as integer
	args            as integer
	currarg         as FBSYMBOL ptr
	argtail         as ASTNODE_ ptr
	strtail         as AST_TMPSTRLIST_ITEM ptr      '' fixed-length string argument copy-back list
	tmpres          as FBSYMBOL ptr                 '' temp result structure, if needed
end type

type AST_NODE_ARG
	mode            as integer                      '' to pass NULL's to byref args, etc
	lgt             as longint                      '' length, used to push UDT's by value
end type

type AST_NODE_VAR
	ofs             as longint                      '' offset
end type

type AST_NODE_IDX
	ofs             as longint                      '' offset
	mult            as integer                      '' multipler
	'' Note: the multiplier field is used in combination with x86 ASM-backend specific
	'' optimizations only, see hOptConstIdxMult().
end type

type AST_NODE_PTR
	ofs             as longint                      '' offset
end type

type AST_NODE_IIF
	falselabel      as FBSYMBOL ptr
end type

type AST_NODE_LOAD
	isres           as integer
end type

type AST_NODE_LABEL
	flush           as integer
end type

type AST_NODE_LIT
	text            as zstring ptr
end type

type AST_NODE_ASM
	tokhead as ASTASMTOK ptr
end type

type AST_NODE_OP  '' used by: bop, uop, addr
	op              as integer
	options         as AST_OPOPT
	ex              as FBSYMBOL ptr                 '' (extra: label, etc)
end type

type AST_NODE_OFFS
	ofs             as longint
end type

type AST_NODE_JMPTB
	'' Dynamically allocated buffer holding the jmptb's value/label pairs
	values              as ulongint ptr
	labels              as FBSYMBOL ptr ptr
	labelcount          as integer

	deflabel            as FBSYMBOL ptr
	bias                as ulongint
	span                as ulongint
end type

type AST_NODE_DBG
	ex              as integer
	filename        as zstring ptr
	op              as integer
end type

type AST_NODE_MEM
	bytes               as longint
	op              as integer
end type

type AST_NODE_STACK
	op              as integer
end type

type AST_NODE_TYPEINI
	ofs             as longint
	union
		bytes       as longint
		elements    as longint            '' TYPEINI_CTORLIST only
	end union
	scp             as FBSYMBOL ptr
	lastscp         as FBSYMBOL ptr
end type

type AST_NODE_TYPEINISCOPE
	'' Whether the typeini scope corresponds to an array initializer or a
	'' UDT initializer.
	'' This matters to the LLVM backend when emitting varinis, because
	'' global array/struct initiializers have different syntax there.
	'' It doesn't matter to the C backend (all initializers use "{...}"
	'' braces) or the ASM backend (varini scopes aren't used at all).
	is_array as integer
end type

type AST_NODE_BREAK
	parent          as ASTNODE_ ptr
	scope           as integer
	linenum         as integer
	stmtnum         as integer                      '' can't use colnum as it's unreliable
end type

type AST_BREAKLIST
	head            as ASTNODE_ ptr
	tail            as ASTNODE_ ptr
end type

type AST_NODE_PROC
	ismain          as integer
	decl_last       as ASTNODE_ ptr                 '' to support implicit variables decl
end type

type AST_NODE_BLOCK
	parent          as ASTNODE_ ptr
	inistmt         as integer
	endstmt         as integer
	initlabel       as FBSYMBOL ptr
	exitlabel       as FBSYMBOL ptr
	breaklist       as AST_BREAKLIST
	proc            as AST_NODE_PROC
end type

type AST_NODE_DATASTMT
	union
		id          as integer
		elmts       as integer
	end union
end type

enum AST_LINK_RETURN
	AST_LINK_RETURN_NONE = 0
	AST_LINK_RETURN_LEFT
	AST_LINK_RETURN_RIGHT
end enum

type AST_NODE_LINK
	ret         as integer
end type

type AST_NODE_CAST
	doconv          as integer  '' do conversion (TRUE or FALSE)
	do_convfd2fs    as integer  '' whether or not to ensure truncation in double2single conversions
	convconst       as integer  '' const qualifier bits discarded/changed in the conversion (TRUE or FALSE)
end type

''
type ASTNODE
	class           as AST_NODECLASS

	dtype           as integer
	subtype         as FBSYMBOL ptr

	sym             as FBSYMBOL ptr                 '' attached symbol

	vector          as integer                      '' 0, 2, 3, or 4 (> 2 for single only)

	union
		val         as FBVALUE    '' CONST nodes
		var_        as AST_NODE_VAR
		idx         as AST_NODE_IDX
		ptr         as AST_NODE_PTR
		call        as AST_NODE_CALL
		arg         as AST_NODE_ARG
		iif         as AST_NODE_IIF
		op          as AST_NODE_OP
		lod         as AST_NODE_LOAD
		lbl         as AST_NODE_LABEL
		ofs         as AST_NODE_OFFS
		lit         as AST_NODE_LIT
		asm         as AST_NODE_ASM
		jmptb       as AST_NODE_JMPTB
		dbg         as AST_NODE_DBG
		mem         as AST_NODE_MEM
		stack       as AST_NODE_STACK
		typeini     as AST_NODE_TYPEINI
		typeiniscope    as AST_NODE_TYPEINISCOPE
		block       as AST_NODE_BLOCK               '' shared by PROC and SCOPE nodes
		break       as AST_NODE_BREAK
		data        as AST_NODE_DATASTMT
		link        as AST_NODE_LINK
		cast        as AST_NODE_CAST
	end union

	l               as ASTNODE ptr                  '' left node
	r               as ASTNODE ptr                  '' right /

	prev            as ASTNODE ptr                  '' used by astAdd()
	next            as ASTNODE ptr                  '' /
end type

type AST_PROC_CTX
	head            as ASTNODE ptr                  '' procs list
	tail            as ASTNODE ptr                  '' /     /
	curr            as ASTNODE ptr                  '' current proc
end type

type AST_CALL_CTX
	tmpstrlist      as TLIST                        '' list of temp strings
end type

type AST_GLOBINST_CTX
	list            as TLIST                        '' global symbols with ctors/dtors
	ctorcnt         as integer                      '' number of ctors in the list above
	dtorcnt         as integer                      ''      /    dtors       /
end type

type AST_DATASTMT_CTX
	desc            as FBSYMBOL ptr
	lastsym         as FBSYMBOL ptr
	firstsym        as FBSYMBOL ptr
	lastlbl         as FBSYMBOL ptr
end type

type AST_DTORLIST_ITEM
	sym             as FBSYMBOL ptr

	'' Some integer used to identify temp vars from expressions nested
	'' inside the true/false expressions of iif()'s, which may have to be
	'' destroyed conditionally, depending on which code path was executed.
	cookie          as integer

	refcount        as integer
end type

type AST_DTORLIST_SCOPESTACK
	'' Grow array; the stack of cookies of the current live dtorlist scopes
	cookies as integer ptr
	count   as integer
	room    as integer
end type

type ASTCTX
	astTB           as TLIST

	proc            as AST_PROC_CTX
	call            as AST_CALL_CTX
	globinst        as AST_GLOBINST_CTX             '' global instances
	data            as AST_DATASTMT_CTX             '' DATA stmt garbage

	currblock       as ASTNODE ptr                  '' current scope block (PROC or SCOPE)

	doemit          as integer

	'' Count of TYPEINI nodes in expressions that are about to be astAdd()ed
	'' (so astAdd() only bothers running astTypeIniUpdate() if it's really
	'' necessary -- another pass besides astOptimizeTree() walking the
	'' whole expression tree during every astAdd() would just be
	'' unnecessarily slow)
	typeinicount        as integer

	'' Same for FIELD with bitfield type (for astUpdateBitfields())
	bitfieldcount       as integer

	'' The counters must always be >= the amount of corresponding nodes that
	'' will be given to astAdd() so that the updating functions don't miss
	'' anything. That's why it's important to update the counters during
	'' astCloneTree() for example. On the other hand, nodes in field or
	'' parameter initializers don't need to be counted, since these
	'' expressions will always be cloned instead of being astAdd()ed
	'' themselves. Unfortunately

	dtorlist        as TLIST                        '' temp dtors list
	dtorlistscopes  as AST_DTORLIST_SCOPESTACK      '' scope stack for astDtorListScope*()
	dtorlistcookies as integer                      '' Cookie counter used to allocate new cookie numbers
	flushdtorlist   as integer

	asmtoklist      as TLIST                        '' inline ASM token nodes

	'' Whether warnings related to CONST nodes (e.g. "const overflow"
	'' warnings from astCheckConst()) should be hidden. Sometimes we do
	'' internal astNew*() operations that cause such warnings, but since
	'' they're part of internal optimizations, they shouldn't be shown to
	'' the user.
	'' This works like a nesting level counter so that the
	'' astBeginHideWarnings()/astEndHideWarnings() functions work like a
	'' push/pop stack.
	''   0 => show warnings
	'' > 0 => hide warnings
	hidewarningslevel   as integer
end type

enum AST_OPFLAGS
	AST_OPFLAGS_NONE        = &h00000000
	AST_OPFLAGS_SELF        = &h00000001            '' op=
	AST_OPFLAGS_COMM        = &h00000002            '' commutative
	AST_OPFLAGS_NORES       = &h00000004            '' no result (it's a SUB)
	AST_OPFLAGS_RELATIONAL  = &h00000008  '' whether it's one of the relational BOPs
end enum

type AST_OPINFO
	class           as AST_NODECLASS
	flags           as AST_OPFLAGS
	id              as const zstring ptr
	selfop          as AST_OP                       '' self version
end type

declare sub astInit( )
declare sub astEnd( )
declare sub astProcListInit( )
declare sub astProcListEnd( )
declare sub astCallInit( )
declare sub astCallEnd( )
declare sub astMiscInit( )
declare sub astMiscEnd( )
declare sub astDataStmtInit( )

declare sub astDelNode _
	( _
		byval n as ASTNODE ptr _
	)

declare function astCloneTree( byval n as ASTNODE ptr ) as ASTNODE ptr

declare sub astDelTree _
	( _
		byval n as ASTNODE ptr _
	)

declare function astIsTreeEqual _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

declare function astIsEqualParamInit _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

declare function astIsConstant( byval expr as ASTNODE ptr ) as integer

declare sub astProcBegin( byval proc as FBSYMBOL ptr, byval ismain as integer )
declare function astProcEnd( byval callrtexit as integer ) as integer

declare sub astProcVectorize _
	( _
		byval p as ASTNODE ptr _
	)

declare function astProcAddStaticInstance _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare sub astProcAddGlobalInstance _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval call_dtor as integer _
	)

declare function astScopeBegin( ) as ASTNODE ptr
declare sub astScopeBreak( byval tolabel as FBSYMBOL ptr )
declare sub astScopeEnd( byval s as ASTNODE ptr )
declare function astScopeUpdBreakList( byval proc as ASTNODE ptr ) as integer
declare sub astScopeDestroyVars( byval symtbtail as FBSYMBOL ptr )
declare sub astScopeAllocLocals( byval symtbhead as FBSYMBOL ptr )
declare function astTempScopeBegin _
	( _
		byref lastscp as FBSYMBOL ptr, _
		byval backnode as ASTNODE ptr _
	) as FBSYMBOL ptr
declare sub astTempScopeEnd _
	( _
		byval scp as FBSYMBOL ptr, _
		byval lastscp as FBSYMBOL ptr _
	)
declare sub astTempScopeClone _
	( _
		byval scp as FBSYMBOL ptr, _
		byval clonetree as ASTNODE ptr _
	)
declare sub astTempScopeDelete( byval scp as FBSYMBOL ptr )

declare function astAdd _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare function astAddAfter _
	( _
		byval n as ASTNODE ptr, _
		byval ref as ASTNODE ptr _
	) as ASTNODE ptr

declare sub astAddUnscoped _
	( _
		byval n as ASTNODE ptr _
	)

declare function astFindFirstCode( byval proc as ASTNODE ptr ) as ASTNODE ptr

declare function astBuildBranch _
	( _
		byval expr as ASTNODE ptr, _
		byval label as FBSYMBOL ptr, _
		byval is_inverse as integer, _
		byval is_iif as integer = FALSE _
	) as ASTNODE ptr

declare function astPtrCheck _
	( _
		byval pdtype as integer, _
		byval psubtype as FBSYMBOL ptr, _
		byval pparammode as integer, _
		byval expr as ASTNODE ptr _
	) as integer

declare function astNewNOP _
	( _
		_
	) as ASTNODE ptr

declare function astNewASSIGN _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval options as AST_OPOPT = AST_OPOPT_NONE _
	) as ASTNODE ptr

enum AST_CONVOPT
	AST_CONVOPT_NONE            = &h0
	AST_CONVOPT_SIGNCONV        = &h1
	AST_CONVOPT_CHECKSTR        = &h2
	AST_CONVOPT_PTRONLY         = &h4
	AST_CONVOPT_DONTCHKPTR      = &h8
	AST_CONVOPT_DONTWARNCONST   = &h10
	AST_CONVOPT_DONTWARNFUNCPTR = &h20
	AST_CONVOPT_EXACT_CAST      = &h40
	AST_CONVOPT_NOCONVTOBASE    = &h80
end enum

declare function astTryOvlStringCONV( byref expr as ASTNODE ptr ) as integer

declare function astNewCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr, _
		byval options as AST_CONVOPT = 0, _
		byval perrmsg as integer ptr = NULL _
	) as ASTNODE ptr

declare function astNewOvlCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

declare sub astUpdateCONVFD2FS _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval is_expr as integer _
	)

declare function astSkipConstCASTs( byval n as ASTNODE ptr ) as ASTNODE ptr
declare function astSkipNoConvCAST( byval n as ASTNODE ptr ) as ASTNODE ptr
declare function astRemoveNoConvCAST( byval n as ASTNODE ptr ) as ASTNODE ptr
declare function astSkipCASTs( byval n as ASTNODE ptr ) as ASTNODE ptr
declare function astRemoveCASTs( byval n as ASTNODE ptr ) as ASTNODE ptr

declare function astNewBOP _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as FBSYMBOL ptr = NULL, _
		byval options as AST_OPOPT = AST_OPOPT_DEFAULT _
	) as ASTNODE ptr

declare function astNewSelfBOP _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as FBSYMBOL ptr = NULL, _
		byval options as AST_OPOPT = AST_OPOPT_DEFAULT _
	) as ASTNODE ptr

declare function astNewUOP _
	( _
		byval op as integer, _
		byval o as ASTNODE ptr _
	) as ASTNODE ptr

declare function astConstEqZero( byval n as ASTNODE ptr ) as integer
declare function astConstGeZero( byval n as ASTNODE ptr ) as integer
declare function astIsConst0OrMinus1( byval n as ASTNODE ptr ) as integer

declare function astNewCONST _
	( _
		byval v as FBVALUE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astNewCONSTstr _
	( _
		byval v as zstring ptr _
	) as ASTNODE ptr

declare function astNewCONSTwstr _
	( _
		byval v as wstring ptr _
	) as ASTNODE ptr

declare function astNewCONSTi _
	( _
		byval value as longint, _
		byval dtype as integer = FB_DATATYPE_INTEGER, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astNewCONSTf _
	( _
		byval value as double, _
		byval dtype as integer = FB_DATATYPE_DOUBLE _
	) as ASTNODE ptr

declare function astNewCONSTz _
	( _
		byval dtype as integer = FB_DATATYPE_CHAR, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astConstFlushToInt _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer = FB_DATATYPE_INTEGER _
	) as longint

declare function astConstFlushToStr( byval n as ASTNODE ptr ) as string
declare function astConstFlushToWstr( byval n as ASTNODE ptr ) as wstring ptr
declare function astConstGetAsInt64( byval n as ASTNODE ptr ) as longint
declare function astConstGetAsDouble( byval n as ASTNODE ptr ) as double
declare function astBuildConst( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
declare function astConvertRawCONSTi _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewVAR _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ofs as longint = 0, _
		byval dtype as integer = FB_DATATYPE_INVALID, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astNewIDX( byval var_ as ASTNODE ptr, byval idx as ASTNODE ptr ) as ASTNODE ptr

declare function astNewFIELD _
	( _
		byval l as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr
declare sub astForgetBitfields( byval n as ASTNODE ptr )
declare function astUpdateBitfields( byval n as ASTNODE ptr ) as ASTNODE ptr

declare function astNewDEREF _
	( _
		byval l as ASTNODE ptr, _
		byval dtype as integer = FB_DATATYPE_INVALID, _
		byval subtype as FBSYMBOL ptr = NULL, _
		byval ofs as longint = 0 _
	) as ASTNODE ptr

declare function astNewCALL _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr = NULL _
	) as ASTNODE ptr

declare function astNewCALLCTOR _
	( _
		byval procexpr as ASTNODE ptr, _
		byval instptr as ASTNODE ptr _
	) as ASTNODE ptr

declare sub astCloneCALL _
	( _
		byval n as ASTNODE ptr, _
		byval c as ASTNODE ptr _
	)

declare sub astDelCALL _
	( _
		byval n as ASTNODE ptr _
	)

declare function astNewARG _
	( _
		byval f as ASTNODE ptr, _
		byval p as ASTNODE ptr, _
		byval dtype as integer = FB_DATATYPE_INVALID, _
		byval mode as integer = INVALID _
	) as ASTNODE ptr

declare sub astReplaceInstanceArg _
	( _
		byval parent as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
		byval mode as integer = INVALID _
	)

declare function astNewADDROF _
	( _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewLOAD _
	( _
		byval l as ASTNODE ptr, _
		byval dtype as integer, _
		byval isresult as integer = FALSE _
	) as ASTNODE ptr

declare function astNewBRANCH _
	( _
		byval op as integer, _
		byval label as FBSYMBOL ptr, _
		byval l as ASTNODE ptr = NULL _
	) as ASTNODE ptr

declare function astBuildJMPTB _
	( _
		byval tempvar as FBSYMBOL ptr, _
		byval values1 as ulongint ptr, _
		byval labels1 as FBSYMBOL ptr ptr, _
		byval labelcount as integer, _
		byval deflabel as FBSYMBOL ptr, _
		byval bias as ulongint, _
		byval span as ulongint _
	) as ASTNODE ptr

declare function astNewLOOP _
	( _
		byval label as FBSYMBOL ptr, _
		byval tree as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewIIF _
	( _
		byval condexpr as ASTNODE ptr, _
		byval truexpr as ASTNODE ptr, _
		byval truecookie as integer, _
		byval falsexpr as ASTNODE ptr, _
		byval falsecookie as integer _
	) as ASTNODE ptr

declare function astNewLINK _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ret as AST_LINK_RETURN _
	) as ASTNODE ptr

declare function astNewSTACK _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewLABEL _
	( _
		byval sym as FBSYMBOL ptr, _
		byval doflush as integer = TRUE _
	) as ASTNODE ptr

declare function astNewLIT _
	( _
		byval text as zstring ptr _
	) as ASTNODE ptr

declare function astAsmAppendText _
	( _
		byval tail as ASTASMTOK ptr, _
		byval text as zstring ptr _
	) as ASTASMTOK ptr

declare function astAsmAppendSymb _
	( _
		byval tail as ASTASMTOK ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTASMTOK ptr

declare function astNewASM( byval asmtokhead as ASTASMTOK ptr ) as ASTNODE ptr

declare function astNewDBG _
	( _
		byval op as integer, _
		byval ex as integer = 0, _
		byval filename as zstring ptr = 0 _
	) as ASTNODE ptr

declare function astNewMEM _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval bytes as longint = 0 _
	) as ASTNODE ptr

declare function astNewMACRO _
	( _
		byval op as AST_OP, _
		byval arg1 as ASTNODE ptr, _
		byval arg2 as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astBuildNewOp _
	( _
		byval op as AST_OP, _
		byval tmp as FBSYMBOL ptr, _
		byval elementsexpr as ASTNODE ptr, _
		byval initexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval do_clear as integer, _
		byval newexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildDeleteOp _
	( _
		byval op as AST_OP, _
		byval ptrexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewBOUNDCHK _
	( _
		byval l as ASTNODE ptr, _
		byval lb as ASTNODE ptr, _
		byval ub as ASTNODE ptr, _
		byval linenum as integer, _
		byval filename as zstring ptr _
	) as ASTNODE ptr

declare function astBuildBOUNDCHK _
	( _
		byval expr as ASTNODE ptr, _
		byval lb as ASTNODE ptr, _
		byval ub as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewPTRCHK _
	( _
		byval l as ASTNODE ptr, _
		byval linenum as integer, _
		byval filename as zstring ptr _
	) as ASTNODE ptr

declare function astBuildPTRCHK( byval expr as ASTNODE ptr ) as ASTNODE ptr

declare function astNewDECL _
	( _
		byval sym as FBSYMBOL ptr, _
		byval do_defaultinit as integer _
	) as ASTNODE ptr

declare function astNewNIDXARRAY _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astRemoveNIDXARRAY( byval n as ASTNODE ptr ) as ASTNODE ptr

declare function astNewNode _
	( _
		byval class_ as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astLoad _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astIncOffset( byval n as ASTNODE ptr, byval ofs as longint ) as integer

declare function astOptimizeTree _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare function astOptAssignment _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare sub astCheckConst _
	( _
		byval dtype as integer, _
		byval n as ASTNODE ptr _
	)

declare function astCheckASSIGN _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval no_upcast as integer _
	) as integer

declare function astCheckASSIGNToType _
	( _
		byval ldtype as integer, _
		byval lsubtype as FBSYMBOL ptr, _
		byval r as ASTNODE ptr, _
		byval no_upcast as integer _
	) as integer

declare function astCheckByrefAssign _
	( _
		byval ldtype as integer, _
		byval lsubtype as FBSYMBOL ptr, _
		byval r as ASTNODE ptr _
	) as integer

declare function astCheckConvNonPtrToPtr _
	( _
		byval to_dtype as integer, _
		byval expr_dtype as integer, _
		byval expr as ASTNODE ptr, _
		byval options as AST_CONVOPT _
	) as integer

declare function astCheckCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as integer

declare function astUpdStrConcat( byval n as ASTNODE ptr ) as ASTNODE ptr

declare function astHasSideFx( byval n as ASTNODE ptr ) as integer

declare function astIsSymbolOnTree _
	( _
		byval sym as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

declare function astGetStrLitSymbol _
	( _
		byval n as ASTNODE ptr _
	) as FBSYMBOL ptr

declare function astTypeIniBegin _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval is_local as integer, _
		byval ofs as longint = 0 _
	) as ASTNODE ptr

declare sub astTypeIniEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval is_initializer as integer _
	)

declare sub astTypeIniRemoveLastNode( byval tree as ASTNODE ptr )

declare function astTypeIniAddPad _
	( _
		byval tree as ASTNODE ptr, _
		byval bytes as longint _
	) as ASTNODE ptr

declare function astTypeIniAddAssign _
	( _
		byval tree as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval dtype as integer = FB_DATATYPE_INVALID, _
		byval subtype as FBSYMBOL ptr = NULL, _
		byval check_upcast as integer = FALSE _
	) as ASTNODE ptr

declare function astTypeIniAddCtorCall _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval procexpr as ASTNODE ptr, _
		byval dtype as integer = FB_DATATYPE_INVALID, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astTypeIniAddCtorList _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval elements as longint, _
		byval dtype as integer = FB_DATATYPE_INVALID, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astTypeIniScopeBegin _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval is_array as integer _
	) as ASTNODE ptr

declare function astTypeIniScopeEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare sub astTypeIniCopyElements _
	( _
		byval tree as ASTNODE ptr, _
		byval source as ASTNODE ptr, _
		byval beginindex as integer _
	)

declare sub astTypeIniReplaceElement _
	( _
		byval tree as ASTNODE ptr, _
		byval element as integer, _
		byval expr as ASTNODE ptr _
	)

declare sub astLoadStaticInitializer _
	( _
		byval tree as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr _
	)

declare function astTypeIniFlush overload _
	( _
		byval target as ASTNODE ptr, _
		byval initree as ASTNODE ptr, _
		byval update_typeinicount as integer, _
		byval assignoptions as integer _
	) as ASTNODE ptr

declare function astTypeIniFlush overload _
	( _
		byval target as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval update_typeinicount as integer, _
		byval assignoptions as integer _
	) as ASTNODE ptr

declare function astTypeIniIsConst _
	( _
		byval tree as ASTNODE ptr _
	) as integer

declare function astTypeIniUsesLocals _
	( _
		byval n as ASTNODE ptr, _
		byval ignoreattrib as integer _
	) as integer

declare function astTypeIniUpdate _
	( _
		byval tree as ASTNODE ptr _
	) as ASTNODE ptr

declare function astTypeIniClone( byval tree as ASTNODE ptr ) as ASTNODE ptr
declare function astTypeIniTryRemove( byval tree as ASTNODE ptr ) as ASTNODE ptr
declare sub astTypeIniDelete( byval tree as ASTNODE ptr )

declare function astDataStmtBegin( ) as ASTNODE ptr

declare function astDataStmtStore _
	( _
		byval tree as ASTNODE ptr, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

declare sub astDataStmtEnd( byval tree as ASTNODE ptr )

declare function astDataStmtAdd _
	( _
		byval label as FBSYMBOL ptr, _
		byval elements as integer _
	) as FBSYMBOL ptr

declare function astGetInverseLogOp _
	( _
		byval op as integer _
	) as integer

declare function astGetEffectiveNode( byval n as ASTNODE ptr ) as ASTNODE ptr
declare function astGetEffectiveClass( byval n as ASTNODE ptr ) as integer
declare function astRebuildWithoutEffectivePart( byval n as ASTNODE ptr ) as ASTNODE ptr
declare function astCanTakeAddrOf( byval n as ASTNODE ptr ) as integer
declare function astMakeRef( byref expr as ASTNODE ptr ) as ASTNODE ptr
declare function astRemSideFx( byref n as ASTNODE ptr ) as ASTNODE ptr

declare function astBuildVarDeref( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
declare function astBuildVarAddrof( byval sym as FBSYMBOL ptr ) as ASTNODE ptr

declare function astBuildVarInc _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer _
	) as ASTNODE ptr

declare function astBuildVarAssign overload _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer, _
		byval options as integer = 0 _
	) as ASTNODE ptr

declare function astBuildVarAssign _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as ASTNODE ptr, _
		byval options as integer = 0 _
	) as ASTNODE ptr

declare function astBuildFakeWstringAccess( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
declare function astBuildFakeWstringAssign _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval options as integer = 0 _
	) as ASTNODE ptr

declare function astBuildDerefAddrOf overload _
	( _
		byval n as ASTNODE ptr, _
		byval offsetexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval maybeafield as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astBuildDerefAddrOf overload _
	( _
		byval n as ASTNODE ptr, _
		byval offset as longint, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval maybeafield as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astBuildVarField _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr = NULL, _
		byval offset as longint = 0 _
	) as ASTNODE ptr

declare function astBuildTempVarClear( byval sym as FBSYMBOL ptr ) as ASTNODE ptr

declare function astBuildCall _
	( _
		byval proc as FBSYMBOL ptr, _
		byval arg1 as ASTNODE ptr = NULL, _
		byval arg2 as ASTNODE ptr = NULL, _
		byval arg3 as ASTNODE ptr = NULL _
	) as ASTNODE ptr

declare function astBuildVtableLookup _
	( _
		byval proc as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildCtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildDtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr, _
		byval ignore_virtual as integer = FALSE _
	) as ASTNODE ptr

declare function astBuildWhileCounterBegin _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr, _
		byval initexpr as ASTNODE ptr, _
		byval flush_label as integer = TRUE _
	) as ASTNODE ptr

declare function astBuildWhileCounterEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr, _
		byval flush_label as integer = TRUE _
	) as ASTNODE ptr

declare function astBuildForBegin _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval inivalue as integer, _
		byval flush_label as integer = TRUE _
	) as ASTNODE ptr

declare function astBuildForEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval endvalue as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildVarDtorCall overload _
	( _
		byval varexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildVarDtorCall overload _
	( _
		byval s as FBSYMBOL ptr, _
		byval check_access as integer = FALSE _
	) as ASTNODE ptr

declare function astBuildTypeIniCtorList _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astBuildProcAddrof( byval proc as FBSYMBOL ptr ) as ASTNODE ptr

declare function astBuildProcResultVar _
	( _
		byval proc as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astPatchCtorCall _
	( _
		byval procexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astCALLCTORToCALL _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildImplicitCtorCall _
	( _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval arg_mode as FB_PARAMMODE, _
		byref is_ctorcall as integer _
	) as ASTNODE ptr

declare function astBuildImplicitCtorCallEx _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval arg_mode as FB_PARAMMODE, _
		byref is_ctorcall as integer _
	) as ASTNODE ptr

declare function astBuildArrayDescIniTree _
	( _
		byval desc as FBSYMBOL ptr, _
		byval array as FBSYMBOL ptr, _
		byval array_expr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildArrayBound _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval dimexpr as ASTNODE ptr, _
		byval tk as integer _
	) as ASTNODE ptr

declare function astBuildStrPtr( byval lhs as ASTNODE ptr ) as ASTNODE ptr

declare function astBuildMultiDeref _
	( _
		byval cnt as integer, _
		byval expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

declare sub astReplaceSymbolOnTree _
	( _
		byval n as ASTNODE ptr, _
		byval old_sym as FBSYMBOL ptr, _
		byval new_sym as FBSYMBOL ptr _
	)

declare sub astReplaceFwdref _
	( _
		byval n as ASTNODE ptr, _
		byval oldsubtype as FBSYMBOL ptr, _
		byval newdtype as integer, _
		byval newsubtype as FBSYMBOL ptr _
	)

#if __FB_DEBUG__
declare sub astDtorListDump( )
#endif
declare sub astDtorListAdd( byval sym as FBSYMBOL ptr )
declare sub astDtorListAddRef( byval sym as FBSYMBOL ptr )
declare sub astDtorListRemoveRef( byval sym as FBSYMBOL ptr )
declare function astDtorListFlush( byval cookie as integer = 0 ) as ASTNODE ptr
declare sub astDtorListDel( byval sym as FBSYMBOL ptr )
declare sub astDtorListScopeBegin( byval cookie as integer = 0 )
declare function astDtorListScopeEnd( ) as integer
declare sub astDtorListUnscope( byval cookie as integer )
declare sub astDtorListScopeDelete( byval cookie as integer )

declare sub astSetType _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

declare function astSizeOf( byval n as ASTNODE ptr, byref is_fixlenstr as integer = FALSE ) as longint
declare function astIsAccessToLocal( byval expr as ASTNODE ptr ) as integer
declare function astIsRelationalBop( byval n as ASTNODE ptr ) as integer

declare function astGetOFFSETChildOfs( byval l as ASTNODE ptr ) as longint

declare function astBuildCallResultVar( byval expr as ASTNODE ptr ) as ASTNODE ptr
declare function astBuildCallResultUdt( byval expr as ASTNODE ptr ) as ASTNODE ptr
declare function astBuildByrefResultDeref( byval expr as ASTNODE ptr ) as ASTNODE ptr
declare function astIsByrefResultDeref( byval expr as ASTNODE ptr ) as integer
declare function astRemoveByrefResultDeref( byval expr as ASTNODE ptr ) as ASTNODE ptr
declare function astIgnoreCallResult( byval n as ASTNODE ptr ) as ASTNODE ptr
declare function astBuildFakeCall( byval proc as FBSYMBOL ptr ) as ASTNODE ptr

declare sub astGosubAddInit( byval proc as FBSYMBOL ptr )

declare sub astGosubAddJmp _
	( _
		byval proc as FBSYMBOL ptr, _
		byval l as FBSYMBOL ptr _
	)

declare sub astGosubAddJumpPtr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval exitlabel as FBSYMBOL ptr _
	)

declare function astGosubAddReturn _
	( _
		byval proc as FBSYMBOL ptr, _
		byval l as FBSYMBOL ptr _
	) as integer

declare sub astGosubAddExit(byval proc as FBSYMBOL ptr)

declare function astLoadNOP( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadASSIGN( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadCONV( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadBOP( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadUOP( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadCONST( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadVAR( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadIDX( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadDEREF( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadCALL( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadCALLCTOR( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadADDROF( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadLOAD( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadBRANCH( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadIIF( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadOFFSET( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadLINK( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadFIELD( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadSTACK( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadLABEL( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadLIT( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadASM( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadJMPTB( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadLOOP( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadDBG( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadMEM( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadBOUNDCHK( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadPTRCHK( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadSCOPEBEGIN( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadSCOPEEND( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadDECL( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadNIDXARRAY( byval n as ASTNODE ptr ) as IRVREG ptr
declare function astLoadMACRO( byval n as ASTNODE ptr ) as IRVREG ptr

''
'' macros
''

#define astBeginHideWarnings( ) ast.hidewarningslevel += 1
#define astEndHideWarnings( )   ast.hidewarningslevel -= 1
#define astShouldShowWarnings( ) (ast.hidewarningslevel = 0)

#macro astInitNode( n, class_, dtype_, subtype_ )
	(n)->class = class_
	(n)->dtype = dtype_
	(n)->subtype = subtype_
	(n)->l = NULL
	(n)->r = NULL
	(n)->sym = NULL
	(n)->vector = 0
#endmacro

#define astCopy(dst, src) *dst = *src

#define astGetClass(n) n->class

#define astGetLeft( n ) n->l

#define astGetRight( n ) n->r

#define astGetPrev( n ) n->prev

#define astGetNext( n ) n->next

#define astIsCONST(n) (n->class = AST_NODECLASS_CONST)

#define astIsVAR(n) (n->class = AST_NODECLASS_VAR)

#define astIsIDX(n) (n->class = AST_NODECLASS_IDX)

#define astIsCALL(n) (n->class = AST_NODECLASS_CALL)

#define astIsCALLCTOR(n) (n->class = AST_NODECLASS_CALLCTOR)

#define astIsDEREF(n) (n->class = AST_NODECLASS_DEREF)

#define astIsOFFSET(n) (n->class = AST_NODECLASS_OFFSET)

#define astIsFIELD(n) (n->class = AST_NODECLASS_FIELD)

#define astIsBITFIELD(n) iif( astIsFIELD( n ), symbFieldIsBitfield( (n)->sym ), FALSE )

#define astIsNIDXARRAY(n) (n->class = AST_NODECLASS_NIDXARRAY)

#define astIsTYPEINI(n) (n->class = AST_NODECLASS_TYPEINI)

#define astIsCAST(n) (n->class = AST_NODECLASS_CONV)

#define astConstGetVal( n ) (@(n)->val)
#define astConstGetFloat( n ) ((n)->val.f)
#define astConstGetInt( n ) ((n)->val.i)
#define astConstGetUint( n ) cunsg( (n)->val.i )

#define astGetFullType(n) n->dtype
#define astGetDataType(n) typeGetDtAndPtrOnly( astGetFullType( n ) )

#define astGetSubtype(n) n->subtype

#define astGetDataClass(n) typeGetClass( astGetDataType( n ) )

#define astGetSymbol(n) n->sym

#define astGetProcExitlabel(n) n->block.exitlabel

#define astGetProc() ast.proc.curr

#define astGetProcTailNode() ast.proc.curr->r

#define astTypeIniGetOfs( n ) n->typeini.ofs

#define astGetOpClass( op ) ast_opTB(op).class
#define astGetOpIsCommutative( op ) ((ast_opTB(op).flags and AST_OPFLAGS_COMM) <> 0)
#define astGetOpIsSelf( op ) ((ast_opTB(op).flags and AST_OPFLAGS_SELF) <> 0)
#define astGetOpNoResult( op ) ((ast_opTB(op).flags and AST_OPFLAGS_NORES) <> 0)
#define astOpIsRelational( op ) ((ast_opTB(op).flags and AST_OPFLAGS_RELATIONAL) <> 0)
#define astGetOpSelfVer( op ) ast_opTB(op).selfop

#define astGetOpId( op ) ast_opTB(op).id

#define astGetFirstDataStmtSymbol( ) ast.data.firstsym

#define astGetLastDataStmtSymbol( ) ast.data.lastsym

#define astDTorListIsEmpty( ) (listGetHead( @ast.dtorlist ) = NULL)

#define astIsUOP( n, uop ) ( ((n)->class = AST_NODECLASS_UOP) andalso ((n)->op.op = (uop)) )

#define astIsBOP( n, bop ) ( ((n)->class = AST_NODECLASS_BOP) andalso ((n)->op.op = (bop)) )

''
'' inter-module globals
''
extern ast as ASTCTX

extern ast_opTB( 0 to AST_OPCODES-1 ) as AST_OPINFO

declare function astDumpOpToStr( byval op as AST_OP ) as string

declare sub astDumpTree _
	( _
		byval n as ASTNODE ptr, _
		byval col as integer = 0 _
	)

declare sub astDumpList _
	( _
		byval n as ASTNODE ptr, _
		byval col as integer = 0 _
	)

#if __FB_DEBUG__
declare function astDumpInline( byval n as ASTNODE ptr ) as string
declare sub astDumpSmall( byval n as ASTNODE ptr, byref prefix as string = "" )
#endif

#endif '' __AST_BI__
