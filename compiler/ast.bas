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

declare sub astProcListInit _
	( _
	)

declare sub astProcListEnd _
	( _
	)

declare sub astCallInit _
	( _
	)

declare sub astCallEnd _
	( _
	)

declare sub astMiscInit _
	( _
	)

declare sub astMiscEnd _
	( _
	)

declare sub astDataStmtInit _
	( _
	)

declare function astLoadNOP _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadASSIGN _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadCONV _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadBOP _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadUOP _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadCONST _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadVAR _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadIDX _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadDEREF _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadCALL _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadCALLCTOR _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadADDROF _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadLOAD _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadBRANCH _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

/'
declare function astLoadIIF _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr
'/

declare function astLoadOFFSET _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadLINK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadSTACK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadENUM _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadLABEL _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadLIT _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadASM _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadJMPTB _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadDBG _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadMEM _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadBOUNDCHK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadPTRCHK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadFIELD _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadSCOPEBEGIN _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadSCOPEEND _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadDECL _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare function astLoadNIDXARRAY _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

declare sub astCloneCALL _
	( _
		byval n as ASTNODE ptr, _
		byval c as ASTNODE ptr _
	)

declare sub astDelCALL _
	( _
		byval n as ASTNODE ptr _
	)



'' globals
	dim shared as ASTCTX ast

	'' same order as AST_NODECLASS
	dim shared ast_classTB( 0 to AST_CLASSES-1 ) as AST_CLASSINFO => _
	{ _
		( @astLoadNOP           , FALSE ), _    '' AST_NODECLASS_NOP
		( @astLoadLOAD          , TRUE  ), _    '' AST_NODECLASS_LOAD
		( @astLoadASSIGN        , TRUE  ), _    '' AST_NODECLASS_ASSIGN
		( @astLoadBOP           , TRUE  ), _    '' AST_NODECLASS_BOP
		( @astLoadUOP           , TRUE  ), _    '' AST_NODECLASS_UOP
		( @astLoadCONV          , TRUE  ), _    '' AST_NODECLASS_CONV
		( @astLoadADDROF        , TRUE  ), _    '' AST_NODECLASS_ADDROF
		( @astLoadBRANCH        , TRUE  ), _    '' AST_NODECLASS_BRANCH
		( @astLoadCALL          , TRUE  ), _    '' AST_NODECLASS_CALL
		( @astLoadCALLCTOR      , TRUE  ), _    '' AST_NODECLASS_CALLCTOR
		( @astLoadSTACK         , TRUE  ), _    '' AST_NODECLASS_STACK
		( @astLoadMEM           , TRUE  ), _    '' AST_NODECLASS_MEM
		( @astLoadNOP           , FALSE ), _    '' AST_NODECLASS_COMP
		( @astLoadLINK          , TRUE  ), _    '' AST_NODECLASS_LINK
		( @astLoadCONST         , FALSE ), _    '' AST_NODECLASS_CONST
		( @astLoadVAR           , TRUE  ), _    '' AST_NODECLASS_VAR
		( @astLoadIDX           , TRUE  ), _    '' AST_NODECLASS_IDX
		( @astLoadFIELD         , TRUE  ), _    '' AST_NODECLASS_FIELD
		( @astLoadENUM          , FALSE ), _    '' AST_NODECLASS_ENUM
		( @astLoadDEREF         , TRUE  ), _    '' AST_NODECLASS_DEREF
		( @astLoadLABEL         , FALSE ), _    '' AST_NODECLASS_LABEL
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_ARG
		( @astLoadOFFSET        , FALSE ), _    '' AST_NODECLASS_OFFSET
		( @astLoadDECL          , FALSE ), _    '' AST_NODECLASS_DECL
		( @astLoadNIDXARRAY     , TRUE  ), _    '' AST_NODECLASS_NIDXARRAY
		( @astLoadIIF           , TRUE  ), _    '' AST_NODECLASS_IIF
		( @astLoadLIT           , FALSE ), _    '' AST_NODECLASS_LIT
		( @astLoadASM           , TRUE  ), _    '' AST_NODECLASS_ASM
		( @astLoadJMPTB         , TRUE  ), _    '' AST_NODECLASS_JMPTB
		( @astLoadNOP           , FALSE ), _    '' AST_NODECLASS_DATASTMT
		( @astLoadDBG           , FALSE ), _    '' AST_NODECLASS_DBG
		( @astLoadBOUNDCHK      , TRUE  ), _    '' AST_NODECLASS_BOUNDCHK
		( @astLoadPTRCHK        , TRUE  ), _    '' AST_NODECLASS_PTRCHK
		( @astLoadSCOPEBEGIN    , TRUE  ), _    '' AST_NODECLASS_SCOPEBEGIN
		( @astLoadSCOPEEND      , TRUE  ), _    '' AST_NODECLASS_SCOPEEND
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_SCOPE_BREAK
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_TYPEINI
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_TYPEINI_PAD
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_TYPEINI_ASSIGN
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_TYPEINI_CTORCALL
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_TYPEINI_CTORLIST
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_TYPEINI_SCOPEINI
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_TYPEINI_SCOPEEND
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_TYPEINI_SEPARATOR
		( @astLoadNOP           , TRUE  ), _    '' AST_NODECLASS_PROC
		( @astLoadNOP           , FALSE ) _     '' AST_NODECLASS_NAMESPC
	}

	'' same order as AST_OP
	dim shared ast_opTB( 0 to AST_OPCODES-1 ) as AST_OPINFO => _
	{ _
		/' AST_OP_ASSIGN '/ _
		( _
			AST_NODECLASS_ASSIGN, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"let" _
		), _
		/' AST_OP_ADD_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"+=", _
			AST_OP_ADD _
		), _
		/' AST_OP_SUB_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"-=", _
			AST_OP_SUB _
		), _
		/' AST_OP_MUL_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"*=", _
			AST_OP_MUL _
		), _
		/' AST_OP_DIV_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"/=", _
			AST_OP_DIV _
		), _
		/' AST_OP_INTDIV_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"/=", _
			AST_OP_INTDIV _
		), _
		/' AST_OP_MOD_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"mod=", _
			AST_OP_MOD _
		), _
		/' AST_OP_AND_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"and=", _
			AST_OP_AND _
		), _
		/' AST_OP_OR_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"or=", _
			AST_OP_OR _
		), _
		/' AST_OP_ANDALSO_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"andalso=", _
			AST_OP_ANDALSO _
		), _
		/' AST_OP_ORELSE_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"orelse=", _
			AST_OP_ORELSE _
		), _
		/' AST_OP_XOR_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"xor=", _
			AST_OP_XOR _
		), _
		/' AST_OP_EQV_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"eqv=", _
			AST_OP_EQV _
		), _
		/' AST_OP_IMP_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"imp=", _
			AST_OP_IMP _
		), _
		/' AST_OP_SHL_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"shl=", _
			AST_OP_SHL _
		), _
		/' AST_OP_SHR_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"shr=", _
			AST_OP_SHR _
		), _
		/' AST_OP_POW_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"pow=", _
			AST_OP_POW _
		), _
		/' AST_OP_CONCAT_SELF '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"&=", _
			AST_OP_CONCAT _
		), _
		/' AST_OP_NEW_SELF '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_SELF, _
			@"new" _
		), _
		/' AST_OP_NEW_VEC_SELF '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_SELF, _
			@"new[]" _
		), _
		/' AST_OP_DEL_SELF '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"delete" _
		), _
		/' AST_OP_DEL_VEC_SELF '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"delete[]" _
		), _
		/' AST_OP_ADDROF '/ _
		( _
			AST_NODECLASS_ADDROF, _
			AST_OPFLAGS_SELF, _
			@"@" _
		), _
		/' AST_OP_FOR '/ _
		( _
			AST_NODECLASS_COMP, _
			AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
			@"for" _
		), _
		/' AST_OP_STEP '/ _
        ( _
        	AST_NODECLASS_COMP, _
            AST_OPFLAGS_SELF or AST_OPFLAGS_NORES, _
            @"step" _
		), _
		/' AST_OP_NEXT '/ _
		( _
			AST_NODECLASS_COMP, _
			AST_OPFLAGS_SELF, _
			@"next" _
		), _
		/' AST_OP_CAST '/ _
		( _
			AST_NODECLASS_CONV, _
			AST_OPFLAGS_SELF, _
			@"cast" _
		), _
		/' AST_OP_ADD '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_COMM, _
			@"+", _
			AST_OP_ADD_SELF _
		), _
		/' AST_OP_SUB '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"-", _
			AST_OP_SUB_SELF _
		), _
		/' AST_OP_MUL '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_COMM, _
			@"*", _
			AST_OP_MUL_SELF _
		), _
		/' AST_OP_DIV '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"/", _
			AST_OP_DIV_SELF _
		), _
		/' AST_OP_INTDIV '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"/", _
			AST_OP_INTDIV_SELF _
		), _
		/' AST_OP_MOD '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"mod", _
			AST_OP_MOD_SELF _
		), _
		/' AST_OP_AND '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_COMM, _
			@"and", _
			AST_OP_AND_SELF _
		), _
		/' AST_OP_OR '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_COMM, _
			@"or", _
			AST_OP_OR_SELF _
		), _
		/' AST_OP_ANDALSO '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_COMM, _
			@"andalso", _
			AST_OP_ANDALSO_SELF _
		), _
		/' AST_OP_ORELSE '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_COMM, _
			@"orelse", _
			AST_OP_ORELSE_SELF _
		), _
		/' AST_OP_XOR '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_COMM, _
			@"xor", _
			AST_OP_XOR_SELF _
		), _
		/' AST_OP_EQV '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"eqv", _
			AST_OP_EQV_SELF _
		), _
		/' AST_OP_IMP '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"imp", _
			AST_OP_IMP_SELF _
		), _
		/' AST_OP_SHL '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"shl", _
			AST_OP_SHL_SELF _
		), _
		/' AST_OP_SHR '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"shr", _
			AST_OP_SHR_SELF _
		), _
		/' AST_OP_POW '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"pow", _
			AST_OP_POW_SELF _
		), _
		/' AST_OP_CONCAT '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"&", _
			AST_OP_CONCAT_SELF _
		), _
		/' AST_OP_EQ '/ _
		( _
			AST_NODECLASS_COMP, _
			AST_OPFLAGS_COMM, _
			@"=" _
		), _
		/' AST_OP_GT '/ _
		( _
			AST_NODECLASS_COMP, _
			AST_OPFLAGS_NONE, _
			@">" _
		), _
		/' AST_OP_LT '/ _
		( _
			AST_NODECLASS_COMP, _
			AST_OPFLAGS_NONE, _
			@"<" _
		), _
		/' AST_OP_NE '/ _
		( _
			AST_NODECLASS_COMP, _
			AST_OPFLAGS_COMM, _
			@"<>" _
		), _
		/' AST_OP_GE '/ _
		( _
			AST_NODECLASS_COMP, _
			AST_OPFLAGS_NONE, _
			@">=" _
		), _
		/' AST_OP_LE '/ _
		( _
			AST_NODECLASS_COMP, _
			AST_OPFLAGS_NONE, _
			@"<=" _
		), _
		/' AST_OP_NOT '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"not" _
		), _
		/' AST_OP_PLUS '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"+" _
		), _
		/' AST_OP_NEG '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"-" _
		), _
		/' AST_OP_HADD '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"HADD" _
		), _
		/' AST_OP_ABS '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"abs" _
		), _
		/' AST_OP_SGN '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"sgn" _
		), _
		/' AST_OP_SIN '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"sin" _
		), _
		/' AST_OP_ASIN '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"asin" _
		), _
		/' AST_OP_COS '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"cos" _
		), _
		/' AST_OP_ACOS '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"acos" _
		), _
		/' AST_OP_TAN '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"tan" _
		), _
		/' AST_OP_ATAN '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"atan" _
		), _
		/' AST_OP_ATN2 '/ _
		( _
			AST_NODECLASS_BOP, _
			AST_OPFLAGS_NONE, _
			@"atn2" _
		), _
		/' AST_OP_SQRT '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"sqr" _
		), _
		/' AST_OP_RSQRT '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"rsqrt" _
		), _
		/' AST_OP_RCP '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"rcp" _
		), _
		/' AST_OP_LOG '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"log" _
		), _
		/' AST_OP_EXP '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"exp" _
		), _
		/' AST_OP_FLOOR '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"int" _
		), _
		/' AST_OP_FIX '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"fix" _
		), _
		/' AST_OP_FRAC '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"frac" _
		), _
		/' AST_OP_SWZ_REPEAT '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"swzrep" _
		), _
		/' AST_OP_DEREF '/ _
		( _
			AST_NODECLASS_ADDROF, _
			AST_OPFLAGS_NONE, _
			@"*" _
		), _
		/' AST_OP_FLDDEREF '/ _
		( _
			AST_NODECLASS_ADDROF, _
			AST_OPFLAGS_NONE, _
			@"->" _
		), _
		/' AST_OP_NEW '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_NONE, _
			@"new" _
		), _
		/' AST_OP_NEW_VEC '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_NONE, _
			@"new[]" _
		), _
		/' AST_OP_DEL '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_NONE, _
			@"delete" _
		), _
		/' AST_OP_DEL_VEC '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_NONE, _
			@"delete[]" _
		), _
		/' AST_OP_TOINT '/ _
		( _
			AST_NODECLASS_CONV, _
			AST_OPFLAGS_NONE, _
			@"cint" _
		), _
		/' AST_OP_TOFLT '/ _
		( _
			AST_NODECLASS_CONV, _
			AST_OPFLAGS_NONE, _
			@"cflt" _
		), _
		/' AST_OP_LOAD '/ _
		( _
			AST_NODECLASS_LOAD, _
			AST_OPFLAGS_NONE, _
			@"load" _
		), _
		/' AST_OP_LOADRES '/ _
		( _
			AST_NODECLASS_LOAD, _
			AST_OPFLAGS_NONE, _
			@"lres" _
		), _
		/' AST_OP_SPILLREGS '/ _
		( _
			AST_NODECLASS_ASSIGN, _
			AST_OPFLAGS_NONE, _
			@"spill" _
		), _
		/' AST_OP_PUSH '/ _
		( _
			AST_NODECLASS_STACK, _
			AST_OPFLAGS_NONE, _
			@"push" _
		), _
		/' AST_OP_POP '/ _
		( _
			AST_NODECLASS_STACK, _
			AST_OPFLAGS_NONE, _
			@"pop" _
		), _
		/' AST_OP_PUSHUDT '/ _
		( _
			AST_NODECLASS_STACK, _
			AST_OPFLAGS_NONE, _
			@"pudt" _
		), _
		/' AST_OP_STACKALIGN '/ _
		( _
			AST_NODECLASS_STACK, _
			AST_OPFLAGS_NONE, _
			@"stka" _
		), _
		/' AST_OP_JEQ '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"jeq" _
		), _
		/' AST_OP_JGT '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"jgt" _
		), _
		/' AST_OP_JLT '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"jlt" _
		), _
		/' AST_OP_JNE '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"jne" _
		), _
		/' AST_OP_JGE '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"jge" _
		), _
		/' AST_OP_JLE '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"jle" _
		), _
		/' AST_OP_JMP '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"jmp" _
		), _
		/' AST_OP_CALL '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"call" _
		), _
		/' AST_OP_LABEL '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"lbl" _
		), _
		/' AST_OP_RET '/ _
		( _
			AST_NODECLASS_BRANCH, _
			AST_OPFLAGS_NONE, _
			@"ret" _
		), _
		/' AST_OP_CALLFUNC '/ _
		( _
			AST_NODECLASS_CALL, _
			AST_OPFLAGS_NONE, _
			@"calf" _
		), _
		/' AST_OP_CALLPTR '/ _
		( _
			AST_NODECLASS_CALL, _
			AST_OPFLAGS_NONE, _
			@"calp" _
		), _
		/' AST_OP_JUMPPTR '/ _
		( _
			AST_NODECLASS_CALL, _
			AST_OPFLAGS_NONE, _
			@"jmpp" _
		), _
		/' AST_OP_MEMMOVE '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_NONE, _
			@"mmov" _
		), _
		/' AST_OP_MEMSWAP '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_NONE, _
			@"mswp" _
		), _
		/' AST_OP_MEMCLEAR '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_NONE, _
			@"mclr" _
		), _
		/' AST_OP_STKCLEAR '/ _
		( _
			AST_NODECLASS_MEM, _
			AST_OPFLAGS_NONE, _
			@"stkc" _
		), _
		/' AST_OP_DBG_LINEINI '/ _
		( _
			AST_NODECLASS_DBG, _
			AST_OPFLAGS_NONE, _
			@"lini" _
		), _
		/' AST_OP_DBG_LINEEND '/ _
		( _
			AST_NODECLASS_DBG, _
			AST_OPFLAGS_NONE, _
			@"lend" _
		), _
		/' AST_OP_DBG_SCOPEINI '/ _
		( _
			AST_NODECLASS_DBG, _
			AST_OPFLAGS_NONE, _
			@"sini" _
		), _
		/' AST_OP_DBG_SCOPEEND '/ _
		( _
			AST_NODECLASS_DBG, _
			AST_OPFLAGS_NONE, _
			@"send" _
		), _
		/' AST_OP_LIT_COMMENT '/ _
		( _
			AST_NODECLASS_LIT, _
			AST_OPFLAGS_NONE, _
			@"rem" _
		), _
		/' AST_OP_LIT_ASM '/ _
		( _
			AST_NODECLASS_LIT, _
			AST_OPFLAGS_NONE, _
			@"asm" _
		) _
	}

	dim shared as uinteger ast_bitmaskTB( 0 to ... ) = _
	{ _
		0, _
		1, 3, 7, 15, 31, 63, 127, 255, _
		511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, _
        131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215, _
        33554431, 67108863, 134217727, 268435455, 536870911, 1073741823, 2147483647, 4294967295 _
	}

'':::::
sub astInit static

	''
    listNew( @ast.astTB, AST_INITNODES, len( ASTNODE ), LIST_FLAGS_NOCLEAR )

    ''
    ast.doemit = TRUE
    ast.isopt = FALSE
    ast.typeinicnt = 0
    ast.currblock = NULL

    ''
    astCallInit( )

    astProcListInit( )

    astDataStmtInit( )

    astMiscInit( )

end sub

'':::::
sub astEnd static

	''
	astMiscEnd( )

	astProcListEnd( )

    astCallEnd( )

	''
	listFree( @ast.astTB )

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

		tmp = symbAddTempVar( typeAddrOf( dtype ), subtype, FALSE, FALSE )

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
		tmp = symbAddTempVar( dtype, subtype, FALSE, FALSE )

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
	) as ASTNODE ptr static

	dim as ASTNODE ptr n

	n = listNewNode( @ast.astTB )

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
function astIsADDR _
	( _
		byval n as ASTNODE ptr _
	) as integer static

	select case n->class
	case AST_NODECLASS_ADDROF, AST_NODECLASS_OFFSET
		return TRUE
	case else
		return FALSE
	end select

end function

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

''::::
function astLoad _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	if( n = NULL ) then
		return NULL
	end if

	function = astGetClassLoadCB( n->class )( n )

end function

