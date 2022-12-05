'' [A]bstract [S]yntax [T]ree core
''
'' obs: 1) each AST only stores a single expression and its atoms (inc. arrays and functions)
''      2) after the AST is optimized (constants folding, arithmetic associations, etc),
''         its sent to IR, where the expression becomes three-address-codes
''      3) AST optimizations don't include common-sub-expression/dead-code elimination,
''         that must be done by the DAG module
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "ir.bi"
#include once "ast.bi"

dim shared as ASTCTX ast

type AST_LOADCALLBACK as function( byval n as ASTNODE ptr ) as IRVREG ptr

'' same order as AST_NODECLASS
dim shared as AST_LOADCALLBACK ast_loadcallbacks( 0 to AST_CLASSES-1 ) => _
{ _
	@astLoadNOP           , _    '' AST_NODECLASS_NOP
	@astLoadLOAD          , _    '' AST_NODECLASS_LOAD
	@astLoadASSIGN        , _    '' AST_NODECLASS_ASSIGN
	@astLoadBOP           , _    '' AST_NODECLASS_BOP
	@astLoadUOP           , _    '' AST_NODECLASS_UOP
	@astLoadCONV          , _    '' AST_NODECLASS_CONV
	@astLoadADDROF        , _    '' AST_NODECLASS_ADDROF
	@astLoadBRANCH        , _    '' AST_NODECLASS_BRANCH
	@astLoadJMPTB         , _    '' AST_NODECLASS_JMPTB
	@astLoadCALL          , _    '' AST_NODECLASS_CALL
	@astLoadCALLCTOR      , _    '' AST_NODECLASS_CALLCTOR
	@astLoadSTACK         , _    '' AST_NODECLASS_STACK
	@astLoadMEM           , _    '' AST_NODECLASS_MEM
	@astLoadLOOP          , _    '' AST_NODECLASS_LOOP
	NULL                  , _    '' AST_NODECLASS_COMP
	@astLoadLINK          , _    '' AST_NODECLASS_LINK
	@astLoadCONST         , _    '' AST_NODECLASS_CONST
	@astLoadVAR           , _    '' AST_NODECLASS_VAR
	@astLoadIDX           , _    '' AST_NODECLASS_IDX
	@astLoadFIELD         , _    '' AST_NODECLASS_FIELD
	@astLoadDEREF         , _    '' AST_NODECLASS_DEREF
	@astLoadLABEL         , _    '' AST_NODECLASS_LABEL
	NULL                  , _    '' AST_NODECLASS_ARG
	@astLoadOFFSET        , _    '' AST_NODECLASS_OFFSET
	@astLoadDECL          , _    '' AST_NODECLASS_DECL
	@astLoadNIDXARRAY     , _    '' AST_NODECLASS_NIDXARRAY
	@astLoadIIF           , _    '' AST_NODECLASS_IIF
	@astLoadLIT           , _    '' AST_NODECLASS_LIT
	@astLoadASM           , _    '' AST_NODECLASS_ASM
	NULL                  , _    '' AST_NODECLASS_DATASTMT
	@astLoadDBG           , _    '' AST_NODECLASS_DBG
	@astLoadBOUNDCHK      , _    '' AST_NODECLASS_BOUNDCHK
	@astLoadPTRCHK        , _    '' AST_NODECLASS_PTRCHK
	@astLoadSCOPEBEGIN    , _    '' AST_NODECLASS_SCOPEBEGIN
	@astLoadSCOPEEND      , _    '' AST_NODECLASS_SCOPEEND
	NULL                  , _    '' AST_NODECLASS_SCOPE_BREAK
	NULL                  , _    '' AST_NODECLASS_TYPEINI
	NULL                  , _    '' AST_NODECLASS_TYPEINI_PAD
	NULL                  , _    '' AST_NODECLASS_TYPEINI_ASSIGN
	NULL                  , _    '' AST_NODECLASS_TYPEINI_CTORCALL
	NULL                  , _    '' AST_NODECLASS_TYPEINI_CTORLIST
	NULL                  , _    '' AST_NODECLASS_TYPEINI_SCOPEINI
	NULL                  , _    '' AST_NODECLASS_TYPEINI_SCOPEEND
	NULL                  , _    '' AST_NODECLASS_PROC
	@astLoadMACRO           _    '' AST_NODECLASS_MACRO
}

'' same order as AST_OP
dim shared ast_opTB( 0 to AST_OPCODES-1 ) as AST_OPINFO => _
{ _
	(AST_NODECLASS_ASSIGN, AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"let"                     ), _ '' AST_OP_ASSIGN
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"+="      , AST_OP_ADD    ), _ '' AST_OP_ADD_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"-="      , AST_OP_SUB    ), _ '' AST_OP_SUB_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"*="      , AST_OP_MUL    ), _ '' AST_OP_MUL_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"/="      , AST_OP_DIV    ), _ '' AST_OP_DIV_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"/="      , AST_OP_INTDIV ), _ '' AST_OP_INTDIV_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"mod="    , AST_OP_MOD    ), _ '' AST_OP_MOD_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"and="    , AST_OP_AND    ), _ '' AST_OP_AND_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"or="     , AST_OP_OR     ), _ '' AST_OP_OR_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"andalso=", AST_OP_ANDALSO), _ '' AST_OP_ANDALSO_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"orelse=" , AST_OP_ORELSE ), _ '' AST_OP_ORELSE_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"xor="    , AST_OP_XOR    ), _ '' AST_OP_XOR_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"eqv="    , AST_OP_EQV    ), _ '' AST_OP_EQV_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"imp="    , AST_OP_IMP    ), _ '' AST_OP_IMP_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"shl="    , AST_OP_SHL    ), _ '' AST_OP_SHL_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"shr="    , AST_OP_SHR    ), _ '' AST_OP_SHR_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"pow="    , AST_OP_POW    ), _ '' AST_OP_POW_SELF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"&="      , AST_OP_CONCAT ), _ '' AST_OP_CONCAT_SELF
	(AST_NODECLASS_MEM   , AST_OPFLAGS_SELF, @"new"                          ), _ '' AST_OP_NEW_SELF
	(AST_NODECLASS_MEM   , AST_OPFLAGS_SELF, @"new[]"                        ), _ '' AST_OP_NEW_VEC_SELF
	(AST_NODECLASS_MEM   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"delete"  ), _ '' AST_OP_DEL_SELF
	(AST_NODECLASS_MEM   , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"delete[]"), _ '' AST_OP_DEL_VEC_SELF
	(AST_NODECLASS_ADDROF, AST_OPFLAGS_SELF, @"@"                            ), _ '' AST_OP_ADDROF
	(AST_NODECLASS_BOP   , AST_OPFLAGS_SELF, @"[]"                           ), _ '' AST_OP_PTRINDEX
	(AST_NODECLASS_COMP  , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"for"     ), _ '' AST_OP_FOR
	(AST_NODECLASS_COMP  , AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, @"step"    ), _ '' AST_OP_STEP
	(AST_NODECLASS_COMP  , AST_OPFLAGS_SELF, @"next"                         ), _ '' AST_OP_NEXT
	(AST_NODECLASS_CONV  , AST_OPFLAGS_SELF, @"cast"                         ), _ '' AST_OP_CAST
	(AST_NODECLASS_BOP   , AST_OPFLAGS_COMM, @"+"      , AST_OP_ADD_SELF     ), _ '' AST_OP_ADD
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"-"      , AST_OP_SUB_SELF     ), _ '' AST_OP_SUB
	(AST_NODECLASS_BOP   , AST_OPFLAGS_COMM, @"*"      , AST_OP_MUL_SELF     ), _ '' AST_OP_MUL
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"/"      , AST_OP_DIV_SELF     ), _ '' AST_OP_DIV
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"/"      , AST_OP_INTDIV_SELF  ), _ '' AST_OP_INTDIV
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"mod"    , AST_OP_MOD_SELF     ), _ '' AST_OP_MOD
	(AST_NODECLASS_BOP   , AST_OPFLAGS_COMM, @"and"    , AST_OP_AND_SELF     ), _ '' AST_OP_AND
	(AST_NODECLASS_BOP   , AST_OPFLAGS_COMM, @"or"     , AST_OP_OR_SELF      ), _ '' AST_OP_OR
	(AST_NODECLASS_BOP   , AST_OPFLAGS_COMM, @"andalso", AST_OP_ANDALSO_SELF ), _ '' AST_OP_ANDALSO
	(AST_NODECLASS_BOP   , AST_OPFLAGS_COMM, @"orelse" , AST_OP_ORELSE_SELF  ), _ '' AST_OP_ORELSE
	(AST_NODECLASS_BOP   , AST_OPFLAGS_COMM, @"xor"    , AST_OP_XOR_SELF     ), _ '' AST_OP_XOR
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"eqv"    , AST_OP_EQV_SELF     ), _ '' AST_OP_EQV
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"imp"    , AST_OP_IMP_SELF     ), _ '' AST_OP_IMP
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"shl"    , AST_OP_SHL_SELF     ), _ '' AST_OP_SHL
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"shr"    , AST_OP_SHR_SELF     ), _ '' AST_OP_SHR
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"pow"    , AST_OP_POW_SELF     ), _ '' AST_OP_POW
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"&"      , AST_OP_CONCAT_SELF  ), _ '' AST_OP_CONCAT
	(AST_NODECLASS_COMP  , AST_OPFLAGS_COMM or AST_OPFLAGS_RELATIONAL, @"="  ), _ '' AST_OP_EQ
	(AST_NODECLASS_COMP  , AST_OPFLAGS_NONE or AST_OPFLAGS_RELATIONAL, @">"  ), _ '' AST_OP_GT
	(AST_NODECLASS_COMP  , AST_OPFLAGS_NONE or AST_OPFLAGS_RELATIONAL, @"<"  ), _ '' AST_OP_LT
	(AST_NODECLASS_COMP  , AST_OPFLAGS_COMM or AST_OPFLAGS_RELATIONAL, @"<>" ), _ '' AST_OP_NE
	(AST_NODECLASS_COMP  , AST_OPFLAGS_NONE or AST_OPFLAGS_RELATIONAL, @">=" ), _ '' AST_OP_GE
	(AST_NODECLASS_COMP  , AST_OPFLAGS_NONE or AST_OPFLAGS_RELATIONAL, @"<=" ), _ '' AST_OP_LE
	(AST_NODECLASS_COMP  , AST_OPFLAGS_NONE, @"is"      ), _ '' AST_OP_IS
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"not"     ), _ '' AST_OP_NOT
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"+"       ), _ '' AST_OP_PLUS
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"-"       ), _ '' AST_OP_NEG
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"HADD"    ), _ '' AST_OP_HADD
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"abs"     ), _ '' AST_OP_ABS
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"sgn"     ), _ '' AST_OP_SGN
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"sin"     ), _ '' AST_OP_SIN
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"asin"    ), _ '' AST_OP_ASIN
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"cos"     ), _ '' AST_OP_COS
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"acos"    ), _ '' AST_OP_ACOS
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"tan"     ), _ '' AST_OP_TAN
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"atan"    ), _ '' AST_OP_ATAN
	(AST_NODECLASS_BOP   , AST_OPFLAGS_NONE, @"atn2"    ), _ '' AST_OP_ATAN2
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"sqr"     ), _ '' AST_OP_SQRT
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"rsqrt"   ), _ '' AST_OP_RSQRT
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"rcp"     ), _ '' AST_OP_RCP
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"log"     ), _ '' AST_OP_LOG
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"exp"     ), _ '' AST_OP_EXP
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"int"     ), _ '' AST_OP_FLOOR
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"fix"     ), _ '' AST_OP_FIX
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"frac"    ), _ '' AST_OP_FRAC
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"len"     ), _ '' AST_OP_LEN
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"convd2s" ), _ '' AST_OP_CONVFD2FS
	(AST_NODECLASS_UOP   , AST_OPFLAGS_NONE, @"swzrep"  ), _ '' AST_OP_SWZ_REPEAT
	(AST_NODECLASS_ADDROF, AST_OPFLAGS_NONE, @"*"       ), _ '' AST_OP_DEREF
	(AST_NODECLASS_ADDROF, AST_OPFLAGS_NONE, @"->"      ), _ '' AST_OP_FLDDEREF
	(AST_NODECLASS_MEM   , AST_OPFLAGS_NONE, @"new"     , AST_OP_NEW_SELF    ), _ '' AST_OP_NEW
	(AST_NODECLASS_MEM   , AST_OPFLAGS_NONE, @"new[]"   , AST_OP_NEW_VEC_SELF), _ '' AST_OP_NEW_VEC
	(AST_NODECLASS_MEM   , AST_OPFLAGS_NONE, @"delete"  , AST_OP_DEL_SELF    ), _ '' AST_OP_DEL
	(AST_NODECLASS_MEM   , AST_OPFLAGS_NONE, @"delete[]", AST_OP_DEL_VEC_SELF), _ '' AST_OP_DEL_VEC
	(AST_NODECLASS_CONV  , AST_OPFLAGS_NONE, @"cint"    ), _ '' AST_OP_TOINT
	(AST_NODECLASS_CONV  , AST_OPFLAGS_NONE, @"cflt"    ), _ '' AST_OP_TOFLT
	(AST_NODECLASS_CONV  , AST_OPFLAGS_NONE, @"cbool"   ), _ '' AST_OP_TOBOOL
	(AST_NODECLASS_LOAD  , AST_OPFLAGS_NONE, @"load"    ), _ '' AST_OP_LOAD
	(AST_NODECLASS_LOAD  , AST_OPFLAGS_NONE, @"lres"    ), _ '' AST_OP_LOADRES
	(AST_NODECLASS_ASSIGN, AST_OPFLAGS_NONE, @"spill"   ), _ '' AST_OP_SPILLREGS
	(AST_NODECLASS_STACK , AST_OPFLAGS_NONE, @"push"    ), _ '' AST_OP_PUSH
	(AST_NODECLASS_STACK , AST_OPFLAGS_NONE, @"pop"     ), _ '' AST_OP_POP
	(AST_NODECLASS_STACK , AST_OPFLAGS_NONE, @"pudt"    ), _ '' AST_OP_PUSHUDT
	(AST_NODECLASS_STACK , AST_OPFLAGS_NONE, @"stka"    ), _ '' AST_OP_STACKALIGN
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"jeq"     ), _ '' AST_OP_JEQ
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"jgt"     ), _ '' AST_OP_JGT
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"jlt"     ), _ '' AST_OP_JLT
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"jne"     ), _ '' AST_OP_JNE
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"jge"     ), _ '' AST_OP_JGE
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"jle"     ), _ '' AST_OP_JLE
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"jmp"     ), _ '' AST_OP_JMP
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"call"    ), _ '' AST_OP_CALL
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"lbl"     ), _ '' AST_OP_LABEL
	(AST_NODECLASS_BRANCH, AST_OPFLAGS_NONE, @"ret"     ), _ '' AST_OP_RET
	(AST_NODECLASS_CALL  , AST_OPFLAGS_NONE, @"calf"    ), _ '' AST_OP_CALLFUNC
	(AST_NODECLASS_CALL  , AST_OPFLAGS_NONE, @"calp"    ), _ '' AST_OP_CALLPTR
	(AST_NODECLASS_CALL  , AST_OPFLAGS_NONE, @"jmpp"    ), _ '' AST_OP_JUMPPTR
	(AST_NODECLASS_MEM   , AST_OPFLAGS_NONE, @"mmov"    ), _ '' AST_OP_MEMMOVE
	(AST_NODECLASS_MEM   , AST_OPFLAGS_NONE, @"mswp"    ), _ '' AST_OP_MEMSWAP
	(AST_NODECLASS_MEM   , AST_OPFLAGS_NONE, @"mclr"    ), _ '' AST_OP_MEMCLEAR
	(AST_NODECLASS_MEM   , AST_OPFLAGS_NONE, @"stkc"    ), _ '' AST_OP_STKCLEAR
	(AST_NODECLASS_MACRO , AST_OPFLAGS_NONE, @"va_start"), _ '' AST_OP_VA_START
	(AST_NODECLASS_MACRO , AST_OPFLAGS_NONE, @"va_end"  ), _ '' AST_OP_VA_END
	(AST_NODECLASS_MACRO , AST_OPFLAGS_NONE, @"va_copy" ), _ '' AST_OP_VA_COPY
	(AST_NODECLASS_MACRO , AST_OPFLAGS_NONE, @"va_arg"  ), _ '' AST_OP_VA_ARG
	(AST_NODECLASS_DBG   , AST_OPFLAGS_NONE, @"lini"    ), _ '' AST_OP_DBG_LINEINI
	(AST_NODECLASS_DBG   , AST_OPFLAGS_NONE, @"lend"    ), _ '' AST_OP_DBG_LINEEND
	(AST_NODECLASS_DBG   , AST_OPFLAGS_NONE, @"sini"    ), _ '' AST_OP_DBG_SCOPEINI
	(AST_NODECLASS_DBG   , AST_OPFLAGS_NONE, @"send"    ), _ '' AST_OP_DBG_SCOPEEND
	(AST_NODECLASS_LIT   , AST_OPFLAGS_NONE, @"rem"     ), _ '' AST_OP_LIT_COMMENT
	(AST_NODECLASS_LIT   , AST_OPFLAGS_NONE, @"asm"     )  _ '' AST_OP_ASM
}

sub astInit( )
	listInit( @ast.astTB, AST_INITNODES, len( ASTNODE ), LIST_FLAGS_NOCLEAR )

	ast.doemit = TRUE
	ast.typeinicount = 0
	ast.bitfieldcount = 0
	ast.currblock = NULL
	ast.hidewarningslevel = 0

	astCallInit( )
	astProcListInit( )
	astDataStmtInit( )
	astMiscInit( )

	listInit( @ast.asmtoklist, 16, sizeof( ASTASMTOK ), LIST_FLAGS_NOCLEAR )
end sub

sub astEnd( )
	listEnd( @ast.asmtoklist )

	astMiscEnd( )
	astProcListEnd( )
	astCallEnd( )

	listEnd( @ast.astTB )
end sub

function astCloneTree( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr c = any, t = any

	''
	if( n = NULL ) then
		return NULL
	end if

	''
	c = astNewNode( INVALID, FB_DATATYPE_INVALID )
	astCopy( c, n )

	'' walk
	t = n->l
	if( t <> NULL ) then
		c->l = astCloneTree( t )
	end if

	t = n->r
	if( t <> NULL ) then
		c->r = astCloneTree( t )
	end if

	select case( n->class )
	case AST_NODECLASS_VAR
		'' When cloning a temp VAR access, the AST dtorlist must be
		'' told about the additional reference
		if( c->sym ) then
			if( symbIsVar( c->sym ) and symbIsTemp( c->sym ) ) then
				astDtorListAddRef( c->sym )
			end if
		end if

	'' call nodes are too complex, let a helper function clone it
	case AST_NODECLASS_CALL
		astCloneCALL( n, c )

	'' IIF nodes have labels, that can't be just cloned or you get dupes
	'' at the assembler.
	case AST_NODECLASS_IIF
		astReplaceSymbolOnTree( c, c->iif.falselabel, symbAddLabel( NULL ) )

	case AST_NODECLASS_LOOP
		astReplaceSymbolOnTree( c, c->op.ex, symbAddLabel( NULL ) )

	case AST_NODECLASS_TYPEINI
		ast.typeinicount += 1

		'' The scope that some TYPEINI have is not duplicated,
		'' much less the temp vars (astTypeIniClone() should be used
		'' for that), so better not leave a dangling pointer...
		c->typeini.scp = NULL

	case AST_NODECLASS_FIELD
		if( symbFieldIsBitfield( c->sym ) ) then
			ast.bitfieldcount += 1
		end if

#if __FB_DEBUG__
	case AST_NODECLASS_LIT, AST_NODECLASS_JMPTB
		'' These nodes contain dynamically allocated memory,
		'' which currently isn't handled here
		assert( FALSE )
#endif

	end select

	function = c
end function

'' Determine the expression effectively returned by the given tree. Usually it's
'' just the toplevel node, except if there are LINKs involved which return
'' either their lhs or rhs.
function astGetEffectiveNode( byval n as ASTNODE ptr ) as ASTNODE ptr
	if( n->class = AST_NODECLASS_LINK ) then
		select case n->link.ret
		case AST_LINK_RETURN_LEFT
			function = astGetEffectiveNode( n->l )
		case AST_LINK_RETURN_RIGHT
			function = astGetEffectiveNode( n->r )
		case else '' AST_LINK_RETURN_NONE
			function = NULL
		end select
	else
		function = n
	end if
end function

'' Determine the AST_NODECLASS_* of the given expression, while transparently
'' handling LINKs.
function astGetEffectiveClass( byval n as ASTNODE ptr ) as integer
	function = astGetEffectiveNode( n )->class
end function

''
'' Rebuild an expression with its effective part removed.
''
'' This will rebuild the expression tree, conceptually preserving all LINKed
'' subexpressions except the one that is returned as effective result.
'' LINK nodes which become unnecessary as a result of the removal of the
'' subexpression are removed too.
''
'' The other side of the LINK from which the effective part was removed becomes
'' the new effective part.
''
'' If there are no LINKs in the given tree, i.e. the effective part is the only
'' thing contained in the tree, then NULL will be returned (and the operation is
'' the same as just doing astDelTree()).
''
'' Example 1: (effective part marked with **)
''
''      LINK(ret_left=FALSE)
''      /  \                    =>     *DECL*
''   DECL  *VAR*
''
'' Example 2:
''
''             LINK(ret_left=TRUE)
''              /                \                  LINK(ret_left=TRUE)
''       LINK(ret_left=FALSE)    CALL       =>       /            \
''      /                   \                     *DECL*          CALL
''   DECL                 *DEREF*
''                         /
''                       VAR
''
'' Example 3:
''
''        *VAR*        =>      <NULL>
''
function astRebuildWithoutEffectivePart( byval n as ASTNODE ptr ) as ASTNODE ptr
	if( n->class = AST_NODECLASS_LINK ) then
		var l = n->l
		var r = n->r
		select case n->link.ret
		case AST_LINK_RETURN_LEFT
			l = astRebuildWithoutEffectivePart( l )
		case AST_LINK_RETURN_RIGHT
			r = astRebuildWithoutEffectivePart( r )
		case else '' AST_LINK_RETURN_NONE
		end select
		function = astNewLINK( l, r, n->link.ret )
		astDelNode( n )
	else
		astDelTree( n )
		function = NULL
	end if
end function

'' Address-of can only be taken on variables/derefs, or iif/typeini nodes which
'' are eventually replaced by temp var accesses (i.e. the address-of will
'' ultimately be done on the iif's/typeini's temp var), but not of
'' CALLs/bitfields/etc.
function astCanTakeAddrOf( byval n as ASTNODE ptr ) as integer
	select case as const( n->class )
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_DEREF, _
	     AST_NODECLASS_IIF, AST_NODECLASS_TYPEINI, AST_NODECLASS_CALLCTOR
		function = TRUE
	case AST_NODECLASS_FIELD
		function = (not symbFieldIsBitfield( n->sym ))
	case AST_NODECLASS_LINK
		select case n->link.ret
		case AST_LINK_RETURN_LEFT
			function = astCanTakeAddrOf( n->l )
		case AST_LINK_RETURN_RIGHT
			function = astCanTakeAddrOf( n->r )
		case else
			function = FALSE
		end select
	case else
		function = FALSE
	end select
end function

''
'' Build a reference to an expression, such that the expression is used only
'' once and the reference can be used multiple times. (work-around if an
'' expression is needed multiple times but has side-effects that mustn't be
'' duplicated)
''
'' This only works with certain expressions, because we can't take the address
'' of (for example) a CALL or a bitfield.
''
'' Luckily, there should only be few such cases that should ever reach here
'' from code calling astMakeRef() directly (currently it seems like it's
'' bitfields only, but we can give them special treatment here), because usually
'' they should have been disallowed earlier, e.g. in cVarOrDeref().
''
'' astRemSideFx() also uses astMakeRef() to handle UDTs/strings, which usually
'' can only appear in form of variables, except string/wstring CALLs, but we can
'' give those special treatment here too. Most non-variable expressions,
'' especially BOPs, will be handled by astRemSideFx()'s integer/pointer/float
'' handling and thus are never passed to astMakeRef().
''
function astMakeRef( byref expr as ASTNODE ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr temp = any
	dim as ASTNODE ptr container = any

	if( astIsBITFIELD( expr ) ) then
		'' It's a bitfield; we can't just take the address-of, so
		'' work-around by eliminating side-effects higher up in the
		'' expression tree.

		'' The FIELD's lhs should be the container field access. We can
		'' build the reference to that, then do the bitfield access(es)
		'' through that reference.
		assert( astIsFIELD( expr ) )
		container = expr->l
		temp = expr->sym  '' the (bit)field symbol
		astDelNode( expr )

		function = astMakeRef( container )
		expr = astNewFIELD( container, temp )

		exit function
	end if

	if( astIsCALL( expr ) ) then
		'' Functions returning [w]strings really return a
		'' pointer; remap the type and then don't do addrof
		select case( astGetDataType( expr ) )
		case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
			astSetType( expr, typeAddrOf( expr->dtype ), expr->subtype )

			function = astRemSideFx( expr )
			expr = astNewDEREF( expr )

			exit function
		end select
	end if

	assert( astCanTakeAddrOf( expr ) )

	'' dim temp as DATATYPE ptr
	temp = symbAddTempVar( typeAddrOf( expr->dtype ), expr->subtype )

	'' temp = @expr
	function = astNewASSIGN( astNewVAR( temp ), astNewADDROF( expr ), AST_OPOPT_ISINI )

	'' Use *temp instead of the original expr
	expr = astNewDEREF( astNewVAR( temp ) )

end function

'' Better side-effect removal than astMakeRef(), where possible
function astRemSideFx( byref n as ASTNODE ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr tmp = any

	'' Handle string concatenation here. Since the expression will be taken
	'' out of its original context (e.g. string ASSIGN or ARG), we are now
	'' responsible for doing this.
	n = astUpdStrConcat( n )

	select case as const( astGetDataType( n ) )
	'' complex type? convert to pointer..
	case FB_DATATYPE_STRUCT, _ ' FB_DATATYPE_CLASS
		 FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		function = astMakeRef( n )

	'' simple type..
	case else
		'' dim temp as DATATYPE
		tmp = symbAddTempVar( n->dtype, n->subtype )

		'' tmp = n
		function = astNewASSIGN( astNewVAR( tmp ), n, AST_OPOPT_ISINI )

		'' repatch original expression to just access the temp var
		n = astNewVAR( tmp )
	end select
end function

'':::::
sub astDelTree _
	( _
		byval n as ASTNODE ptr _
	)

	dim as ASTNODE ptr t = any

	''
	if( n = NULL ) then
		exit sub
	end if

	'' call nodes are too complex, let a helper function del it
	if( n->class = AST_NODECLASS_CALL ) then
		astDelCALL( n )
	end if

	'' walk
	t = n->l
	if( t <> NULL ) then
		astDelTree( t )
	end if

	t = n->r
	if( t <> NULL ) then
		astDelTree( t )
	end if

	''
	astDelNode( n )

end sub

'':::::
function astNewNode _
	( _
		byval class_ as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = listNewNode( @ast.astTB )

	astInitNode( n, class_, dtype, subtype )

	function = n

end function

'':::::
sub astDelNode _
	( _
		byval n as ASTNODE ptr _
	) static

	if( n = NULL ) then
		exit sub
	end if

	if( astIsVAR( n ) ) then
		if( n->sym ) then
			if( symbIsVar( n->sym ) and symbIsTemp( n->sym ) ) then
				astDtorListRemoveRef( n->sym )
			end if
		end if
	end if

	listDelNode( @ast.astTB, n )

end sub

'':::::
function astGetInverseLogOp _
	( _
		byval op as integer _
	) as integer static

	select case as const op
	case AST_OP_EQ
		op = AST_OP_NE
	case AST_OP_NE
		op = AST_OP_EQ
	case AST_OP_GT
		op = AST_OP_LE
	case AST_OP_LT
		op = AST_OP_GE
	case AST_OP_GE
		op = AST_OP_LT
	case AST_OP_LE
		op = AST_OP_GT
	end select

	function = op

end function

function astLoad( byval n as ASTNODE ptr ) as IRVREG ptr
	if( n ) then
		function = ast_loadcallbacks(n->class)( n )
	end if
end function
