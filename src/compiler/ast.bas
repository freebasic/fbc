'' [A]bstract [S]yntax [T]ree core
''
'' obs: 1) each AST only stores a single expression and its atoms (inc. arrays and functions)
''      2) after the AST is optimized (constants folding, arithmetic associations, etc),
''         its sent to IR, where the expression becomes three-address-codes
''		3) AST optimizations don't include common-sub-expression/dead-code elimination,
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
	NULL                  , _    '' AST_NODECLASS_COMP
	@astLoadLINK          , _    '' AST_NODECLASS_LINK
	@astLoadCONST         , _    '' AST_NODECLASS_CONST
	@astLoadVAR           , _    '' AST_NODECLASS_VAR
	@astLoadIDX           , _    '' AST_NODECLASS_IDX
	NULL                  , _    '' AST_NODECLASS_FIELD
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
	NULL                    _    '' AST_NODECLASS_PROC
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
	(AST_NODECLASS_COMP  , AST_OPFLAGS_COMM, @"="       ), _ '' AST_OP_EQ
	(AST_NODECLASS_COMP  , AST_OPFLAGS_NONE, @">"       ), _ '' AST_OP_GT
	(AST_NODECLASS_COMP  , AST_OPFLAGS_NONE, @"<"       ), _ '' AST_OP_LT
	(AST_NODECLASS_COMP  , AST_OPFLAGS_COMM, @"<>"      ), _ '' AST_OP_NE
	(AST_NODECLASS_COMP  , AST_OPFLAGS_NONE, @">="      ), _ '' AST_OP_GE
	(AST_NODECLASS_COMP  , AST_OPFLAGS_NONE, @"<="      ), _ '' AST_OP_LE
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
	(AST_NODECLASS_DBG   , AST_OPFLAGS_NONE, @"lini"    ), _ '' AST_OP_DBG_LINEINI
	(AST_NODECLASS_DBG   , AST_OPFLAGS_NONE, @"lend"    ), _ '' AST_OP_DBG_LINEEND
	(AST_NODECLASS_DBG   , AST_OPFLAGS_NONE, @"sini"    ), _ '' AST_OP_DBG_SCOPEINI
	(AST_NODECLASS_DBG   , AST_OPFLAGS_NONE, @"send"    ), _ '' AST_OP_DBG_SCOPEEND
	(AST_NODECLASS_LIT   , AST_OPFLAGS_NONE, @"rem"     ), _ '' AST_OP_LIT_COMMENT
	(AST_NODECLASS_LIT   , AST_OPFLAGS_NONE, @"asm"     )  _ '' AST_OP_ASM
}

dim shared as uinteger ast_bitmaskTB( 0 to ... ) = _
{ _
	0, _
	1, 3, 7, 15, 31, 63, 127, 255, _
	511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, _
	131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215, _
	33554431, 67108863, 134217727, 268435455, 536870911, 1073741823, 2147483647, 4294967295 _
}

sub astInit( )
    listInit( @ast.astTB, AST_INITNODES, len( ASTNODE ), LIST_FLAGS_NOCLEAR )

    ast.doemit = TRUE
    ast.typeinicnt = 0
    ast.currblock = NULL

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

'':::::
function astCloneTree _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	'' note: never clone a tree with side-effects (ie: function call nodes)

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

	'' call nodes are too complex, let a helper function clone it
	if( n->class = AST_NODECLASS_CALL ) then
		astCloneCALL( n, c )
	end if

	'' IIF nodes have labels, that can't be just cloned or you get dupes
	'' at the assembler.
	if( n->class = AST_NODECLASS_IIF ) then
		c->iif.falselabel = symbAddLabel( NULL )
		c->l->op.ex = c->iif.falselabel
	end if

	function = c

end function

'':::::
function astRemSideFx _
	( _
		byref n as ASTNODE ptr _
	) as ASTNODE ptr

	'' note: this should only be done with VAR, IDX, PTR and FIELD nodes

	dim as FBSYMBOL ptr tmp = any, subtype = any
	dim as integer dtype = any
	dim as ASTNODE ptr t = any

	dtype = astGetFullType( n )
	subtype = astGetSubType( n )

	select case as const typeGet( dtype )
	'' complex type? convert to pointer..
	case FB_DATATYPE_STRUCT, _ ' FB_DATATYPE_CLASS
		 FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		tmp = symbAddTempVar( typeAddrOf( dtype ), subtype, FALSE )

		'' tmp = @b
		t = astNewASSIGN( astNewVAR( tmp, 0, typeAddrOf( dtype ), subtype ), _
				   	  	  astNewADDROF( n ) )

		'' return *tmp
		function = astNewLINK( t, _
						   	   astNewDEREF( astNewVAR( tmp, _
			   		   			   			  	 	   0, _
			   		   			   			  	 	   typeAddrOf( dtype ), _
			   		   			   			  	 	   subtype ),_
			   		   			   	  	  	dtype, _
			   		   			   	  	  	subtype ) )

		'' repatch node
		n = astNewDEREF( astNewVAR( tmp, 0, typeAddrOf( dtype ), subtype ), _
			   		   	 dtype, _
			   		   	 subtype )

	'' simple type..
	case else
		tmp = symbAddTempVar( dtype, subtype, FALSE )

		'' tmp = n
		t = astNewASSIGN( astNewVAR( tmp, 0, dtype, subtype ), n )

		'' return tmp
		function = astNewLINK( t, astNewVAR( tmp, 0, dtype, subtype ) )

		'' repatch node
		n = astNewVAR( tmp, 0, dtype, subtype )

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
