''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


'' [A]bstract [S]yntax [T]ree core
''
'' obs: 1) each AST only stores a single expression and its atoms (inc. arrays and functions)
''      2) after the AST is optimized (constants folding, arithmetic associations, etc),
''         its sent to IR, where the expression becomes three-address-codes
''		3) AST optimizations don't include common-sub-expression/dead-code elimination,
''         that must be done by the DAG module
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

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

declare function astLoadIIF _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

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

declare sub astSetTypeFIELD _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

declare sub astSetTypeLINK _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

declare sub hSetType _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

declare sub astCloneCALL _
	( _
		byval n as ASTNODE ptr, _
		byval c as ASTNODE ptr _
	)

declare sub astDelCALL _
	( _
		byval n as ASTNODE ptr _
	)

declare sub astReplaceSymbolOnCALL _
	( _
		byval n as ASTNODE ptr, _
		byval old_sym as FBSYMBOL ptr, _
		byval new_sym as FBSYMBOL ptr _
	)


'' globals
	dim shared as ASTCTX ast

	'' same order as AST_NODECLASS
	dim shared ast_classTB( 0 to AST_CLASSES-1 ) as AST_CLASSINFO => _
	{ _
		( @astLoadNOP		, @hSetType			, FALSE	), _	'' AST_NODECLASS_NOP
		( @astLoadLOAD		, @hSetType			, TRUE	), _	'' AST_NODECLASS_LOAD
		( @astLoadASSIGN	, @hSetType			, TRUE	), _	'' AST_NODECLASS_ASSIGN
		( @astLoadBOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_BOP
		( @astLoadUOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_UOP
		( @astLoadCONV		, @hSetType			, TRUE	), _	'' AST_NODECLASS_CONV
		( @astLoadADDROF	, @hSetType			, TRUE	), _	'' AST_NODECLASS_ADDR
		( @astLoadBRANCH	, @hSetType			, TRUE	), _	'' AST_NODECLASS_BRANCH
		( @astLoadCALL		, @hSetType			, TRUE	), _	'' AST_NODECLASS_CALL
		( @astLoadCALLCTOR	, @hSetType			, TRUE	), _	'' AST_NODECLASS_CALLCTOR
		( @astLoadSTACK		, @hSetType			, TRUE	), _	'' AST_NODECLASS_STACK
		( @astLoadMEM		, @hSetType			, TRUE	), _	'' AST_NODECLASS_MEM
		( @astLoadNOP		, @hSetType			, FALSE	), _	'' AST_NODECLASS_COMP
		( @astLoadLINK		, @astSetTypeLINK	, FALSE	), _	'' AST_NODECLASS_LINK
		( @astLoadCONST		, @hSetType			, FALSE	), _	'' AST_NODECLASS_CONST
		( @astLoadVAR		, @hSetType			, TRUE	), _	'' AST_NODECLASS_VAR
		( @astLoadIDX		, @hSetType			, TRUE	), _	'' AST_NODECLASS_IDX
		( @astLoadFIELD		, @astSetTypeFIELD	, TRUE	), _	'' AST_NODECLASS_FIELD
		( @astLoadENUM		, @hSetType			, FALSE	), _	'' AST_NODECLASS_ENUM
		( @astLoadDEREF		, @hSetType			, TRUE	), _	'' AST_NODECLASS_DEREF
		( @astLoadLABEL		, @hSetType			, FALSE	), _	'' AST_NODECLASS_LABEL
		( @astLoadNOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_ARG
		( @astLoadOFFSET	, @hSetType			, FALSE	), _	'' AST_NODECLASS_OFFSET
		( @astLoadDECL		, @hSetType			, FALSE	), _	'' AST_NODECLASS_DECL
		( @astLoadNIDXARRAY	, @hSetType			, TRUE	), _	'' AST_NODECLASS_NIDXARRAY
		( @astLoadIIF		, @hSetType			, TRUE	), _	'' AST_NODECLASS_IIF
		( @astLoadLIT		, @hSetType			, FALSE	), _	'' AST_NODECLASS_LIT
		( @astLoadASM		, @hSetType			, TRUE	), _	'' AST_NODECLASS_ASM
		( @astLoadJMPTB		, @hSetType			, TRUE	), _	'' AST_NODECLASS_JMPTB
		( @astLoadNOP		, @hSetType			, FALSE	), _	'' AST_NODECLASS_DATASTMT
		( @astLoadDBG		, @hSetType			, FALSE	), _	'' AST_NODECLASS_DBG
		( @astLoadBOUNDCHK	, @hSetType			, TRUE	), _	'' AST_NODECLASS_BOUNDCHK
		( @astLoadPTRCHK	, @hSetType			, TRUE	), _	'' AST_NODECLASS_PTRCHK
		( @astLoadSCOPEBEGIN, @hSetType			, TRUE	), _	'' AST_NODECLASS_SCOPEBEGIN
		( @astLoadSCOPEEND	, @hSetType			, TRUE	), _	'' AST_NODECLASS_SCOPEEND
		( @astLoadNOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_SCOPE_BREAK
		( @astLoadNOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_TYPEINI
		( @astLoadNOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_TYPEINI_PAD
		( @astLoadNOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_TYPEINI_ASSIGN
		( @astLoadNOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_TYPEINI_CTORCALL
		( @astLoadNOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_TYPEINI_CTORLIST
		( @astLoadNOP		, @hSetType			, TRUE	), _	'' AST_NODECLASS_PROC
		( @astLoadNOP		, @hSetType			, FALSE	) _		'' AST_NODECLASS_NAMESPC
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
			AST_NODECLASS_ADDR, _
			AST_OPFLAGS_SELF, _
			@"@" _
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
		/' AST_OP_LOG '/ _
		( _
			AST_NODECLASS_UOP, _
			AST_OPFLAGS_NONE, _
			@"log" _
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
		/' AST_OP_DEREF '/ _
		( _
			AST_NODECLASS_ADDR, _
			AST_OPFLAGS_NONE, _
			@"*" _
		), _
		/' AST_OP_FLDDEREF '/ _
		( _
			AST_NODECLASS_ADDR, _
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

	dim shared as uinteger ast_bitmaskTB( 0 to 32 ) = _
	{ _
		0, _
		1, 3, 7, 15, 31, 63, 127, 255, _
		511, 1023, 2047, 4095, 8191, 16383, 32767, 65535, _
        131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215, _
        33554431, 67108863, 134217727, 268435455, 536870911, 1073741823, 2147483647, 4294967295 _
	}

	dim shared as longint ast_minlimitTB( FB_DATATYPE_BYTE to FB_DATATYPE_ULONGINT ) = _
	{ _
		-128LL, _								'' byte
		0LL, _                                  '' ubyte
		0LL, _                                  '' char
		-32768LL, _                             '' short
		0LL, _                                  '' ushort
		0LL, _                                  '' wchar
		-2147483648LL, _                        '' int
		0LL, _                                  '' uint
		-2147483648LL, _                        '' enum
		0LL, _                                  '' bitfield
		-2147483648LL, _                        '' long
		0LL, _                                  '' ulong
		-9223372036854775808LL, _               '' longint
		0LL _                                   '' ulongint
	}

	dim shared as ulongint ast_maxlimitTB( FB_DATATYPE_BYTE to FB_DATATYPE_ULONGINT ) = _
	{ _
		127ULL, _                               '' ubyte
		255ULL, _                               '' byte
		255ULL, _                               '' char
		32767ULL, _                             '' short
		65535ULL, _                             '' ushort
		65535ULL, _                             '' wchar
		2147483647ULL, _                        '' int
		4294967295ULL, _                        '' uint
		2147483647ULL, _                        '' enum
		4294967295ULL, _                        '' bitfield
		2147483647ULL, _                        '' long
		4294967295ULL, _                        '' ulong
		9223372036854775807ULL, _               '' longint
		18446744073709551615ULL _               '' ulongint
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

	'' wchar len depends on the target platform
	ast_minlimitTB(FB_DATATYPE_WCHAR) = ast_minlimitTB(env.target.wchar.type)
	ast_maxlimitTB(FB_DATATYPE_WCHAR) = ast_maxlimitTB(env.target.wchar.type)

    '' !!!FIXME!!! remap [u]long to [u]longint if target = 64-bit

    ''
    astCallInit( )

    astProcListInit( )

    astDataStmtInit( )

end sub

'':::::
sub astEnd static

	''
	astProcListEnd( )

    astCallEnd( )

	''
	listFree( @ast.astTB )

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' node type update
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astUpdStrConcat _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	static as ASTNODE ptr l, r

	function = n

	if( n = NULL ) then
		exit function
	end if

	'' this proc will be called for each function param, same
	'' with assignment -- assuming here that IIF won't
	'' support strings
	select case as const n->dtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_WCHAR

	case else
		exit function
	end select

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = astUpdStrConcat( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = astUpdStrConcat( r )
	end if

	'' convert "string + string" to "StrConcat( string, string )"
	if( n->class = AST_NODECLASS_BOP ) then
		if( n->op.op = AST_OP_ADD ) then
			l = n->l
			r = n->r
			if( n->dtype <> FB_DATATYPE_WCHAR ) then
				function = rtlStrConcat( l, l->dtype, r, r->dtype )
			else
				function = rtlWstrConcat( l, l->dtype, r, r->dtype )
			end if
			astDelNode( n )
		end if
	end if

end function

'':::::
function astUpdComp2Branch _
	( _
		byval n as ASTNODE ptr, _
		byval label as FBSYMBOL ptr, _
		byval isinverse as integer _
	) as ASTNODE ptr

	dim as integer op = any
	dim as ASTNODE ptr l = any, expr = any
	dim as integer dtype = any, istrue = any

	if( n = NULL ) then
		return NULL
	end if

	dtype = n->dtype

	'' string? invalid..
	if( symbGetDataClass( dtype ) = FB_DATACLASS_STRING ) then
		return NULL
	end if

    '' CHAR and WCHAR literals are also from the INTEGER class
    select case dtype
    case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    	'' don't allow, unless it's a deref pointer
    	if( astIsDEREF( n ) = FALSE ) then
    		return NULL
    	end if

	'' UDT or CLASS?
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		dim as FB_ERRMSG err_num = any
		dim as FBSYMBOL ptr ovlProc = any

		'' check for a scalar overload..
		ovlProc = symbFindCastOvlProc( FB_DATATYPE_VOID, NULL, n, @err_num )
		if( ovlProc = NULL ) then
			'' no? try pointers...
			ovlProc = symbFindCastOvlProc( FB_DATATYPE_POINTER + FB_DATATYPE_VOID, NULL, _
										   n, _
										   @err_num )
			if( ovlProc = NULL ) then
				dim as FBSYMBOL ptr subtype = astGetSubtype( n )

				ovlProc = symbGetCompOpOvlHead( subtype, AST_OP_CAST )
				if( ovlProc = NULL ) then
					if( subtype <> NULL ) then
						errReport( FB_ERRMSG_NOMATCHINGPROC, _
								   TRUE, _
								   " """ & *symbGetName( subtype ) & ".cast()""" )
						return NULL
					end if
				end if

				errReport( FB_ERRMSG_NOMATCHINGPROC, TRUE )
				return NULL
			end if
		end if

		'' build cast call
		n = astBuildCall( ovlProc, 1, n )
		dtype = n->dtype

	end select

	'' shortcut "exp logop exp" if it's at top of tree (used to optimize IF/ELSEIF/WHILE/UNTIL)
	if( n->class <> AST_NODECLASS_BOP ) then
#if 0
		'' UOP? check if it's a NOT
		if( n->class = AST_NODECLASS_UOP ) then
			if( n->op.op = AST_OP_NOT ) then
				l = astUpdComp2Branch( n->l, label, isinverse = FALSE )
				astDelNode( n )
				return l
			end if
		end if
#endif

		'' CONST?
		if( n->defined ) then
			if( isinverse = FALSE ) then
				'' branch if false
				select case as const dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					istrue = n->con.val.long = 0

				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					istrue = n->con.val.float = 0

  				case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	   				if( FB_LONGSIZE = len( integer ) ) then
  	   					istrue = n->con.val.int = 0
  	   				else
  	   					istrue = n->con.val.long = 0
  	   				end if

				case else
					istrue = n->con.val.int = 0
				end select

				if( istrue ) then
					astDelNode( n )
					n = astNewBRANCH( AST_OP_JMP, label, NULL )
					if( n = NULL ) then
						return NULL
					end if
				end if
			else
				'' branch if true
				select case as const dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					istrue = n->con.val.long <> 0

				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					istrue = n->con.val.float <> 0

  				case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	   				if( FB_LONGSIZE = len( integer ) ) then
  	   					istrue = n->con.val.int <> 0
  	   				else
  	   					istrue = n->con.val.long <> 0
  	   				end if

				case else
					istrue = n->con.val.int <> 0
				end select

				if( istrue ) then
					astDelNode( n )
					n = astNewBRANCH( AST_OP_JMP, label, NULL )
					if( n = NULL ) then
						return NULL
					end if
				end if
			end if

		else
			'' otherwise, check if zero (ie= FALSE)
			if( isinverse = FALSE ) then
				op = AST_OP_EQ
			else
				op = AST_OP_NE
			end if

			'' zstring? astNewBOP will think both are zstrings..
			select case dtype
			case FB_DATATYPE_CHAR
				dtype = FB_DATATYPE_UINT
			case FB_DATATYPE_WCHAR
				dtype = env.target.wchar.type
			end select

			select case as const dtype
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				expr = astNewCONSTl( 0, dtype )

			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				expr = astNewCONSTf( 0.0, dtype )

  			case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	   			if( FB_LONGSIZE = len( integer ) ) then
  	   				expr = astNewCONSTi( 0, dtype )
  	   			else
  	   				expr = astNewCONSTl( 0, dtype )
  	   			end if

			case else
				expr = astNewCONSTi( 0, dtype )
			end select

			n = astNewBOP( op, n, expr, label, AST_OPOPT_NONE )

			if( n = NULL ) then
				return NULL
			end if
		end if

		'' exit
		return n
	end if

	''
	op 	  = n->op.op

	'' relational operator?
	select case as const op
	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE

		'' invert it
		if( isinverse = FALSE ) then
			n->op.op = astGetInverseLogOp( op )
		end if

		'' tell IR that the destine label is already set
		n->op.ex = label

		return n

	'' binary op that sets the flags?
	case AST_OP_ADD, AST_OP_SUB, AST_OP_SHL, AST_OP_SHR, _
		 AST_OP_AND, AST_OP_OR, AST_OP_XOR, AST_OP_IMP
		 ', AST_OP_EQV -- NOT doesn't set any flags, so EQV can't be optimized (x86 assumption)

		dim as integer doopt = any

		if( symbGetDataClass( dtype ) = FB_DATACLASS_INTEGER ) then
			doopt = irGetOption( IR_OPT_CPU_BOPSETFLAGS )

			if( doopt ) then
				select case dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					'' can't be done with longints either, as flag is set twice
					doopt = irGetOption( IR_OPT_CPU_64BITREGS )
				end select
			end if

		else
			doopt = irGetOption( IR_OPT_FPU_BOPSETFLAGS )
		end if

		if( doopt ) then
			'' check if zero (ie= FALSE)
			if( isinverse = FALSE ) then
				op = AST_OP_JEQ
			else
				op = AST_OP_JNE
			end if

			return astNewBRANCH( op, label, n )
		end if

	end select

	'' if no optimization could be done, check if zero (ie= FALSE)
	if( isinverse = FALSE ) then
		op = AST_OP_EQ
	else
		op = AST_OP_NE
	end if

	select case as const dtype
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		expr = astNewCONSTl( 0, dtype )

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		expr = astNewCONSTf( 0.0, dtype )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	   	if( FB_LONGSIZE = len( integer ) ) then
  	   		expr = astNewCONSTi( 0, dtype )
  	   	else
  	   		expr = astNewCONSTl( 0, dtype )
  	   	end if

	case else
		expr = astNewCONSTi( 0, dtype )
	end select

	function = astNewBOP( op, n, expr, label, AST_OPOPT_NONE )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astPtrCheck _
	( _
		byval pdtype as integer, _
		byval psubtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr _
	) as integer static

	dim as integer edtype, pdtype_np, edtype_np

	function = FALSE

	edtype = astGetDataType( expr )

	select case astGetClass( expr )
	case AST_NODECLASS_CONST, AST_NODECLASS_ENUM
    	'' expr not a pointer?
    	if( edtype < FB_DATATYPE_POINTER ) then
    		'' not NULL?
    		if( astGetValInt( expr ) <> NULL ) then
    			exit function
    		else
    			return TRUE
    		end if
    	end if

	case else
    	'' expr not a pointer?
    	if( edtype < FB_DATATYPE_POINTER ) then
    		exit function
    	end if
	end select

	'' different types?
	if( pdtype <> edtype ) then

    	'' remove the pointers
    	pdtype_np = pdtype mod FB_DATATYPE_POINTER
    	edtype_np = edtype mod FB_DATATYPE_POINTER

    	'' 1st) is one of them an ANY PTR?
    	if( pdtype_np = FB_DATATYPE_VOID ) then
    		return TRUE
    	elseif( edtype_np = FB_DATATYPE_VOID ) then
    		return TRUE
    	end if

    	'' 2nd) same level of indirection?
    	if( (pdtype - pdtype_np) <> (edtype - edtype_np) ) then
    		exit function
    	end if

    	'' 3rd) same size and class?
    	if( (pdtype_np <= FB_DATATYPE_DOUBLE) and _
    		(edtype_np <= FB_DATATYPE_DOUBLE) ) then
    		if( symbGetDataSize( pdtype_np ) = symbGetDataSize( edtype_np ) ) then
    			if( symbGetDataClass( pdtype_np ) = symbGetDataClass( edtype_np ) ) then
    				return TRUE
    			end if
    		end if
    	end if

    	exit function
    end if

	'' check sub types
	function = symbIsEqual( psubtype, astGetSubType( expr ) )

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

'':::::
function astFindTempVarWithDtor _
	( _
		byval n as ASTNODE ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = NULL

	function = NULL

	select case n->class
	case AST_NODECLASS_CALL
		sym = n->call.tmpres

	case AST_NODECLASS_CALLCTOR
       	sym = astGetSymbol( n->r )

	end select

	if( sym <> NULL ) then
		if( symbGetIsTempWithDtor( sym ) ) then
			function = sym
		end if
	end if

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree cloning and deletion
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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
	c = astNewNode( INVALID, INVALID )
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

	dtype = astGetDataType( n )
	subtype = astGetSubType( n )

	select case as const dtype
	'' complex type? convert to pointer..
	case FB_DATATYPE_STRUCT, _ ' FB_DATATYPE_CLASS
		 FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		tmp = symbAddTempVar( FB_DATATYPE_POINTER + dtype, subtype, FALSE, FALSE )

		'' tmp = @b
		t = astNewASSIGN( astNewVAR( tmp, 0, FB_DATATYPE_POINTER + dtype, subtype ), _
				   	  	  astNewADDROF( n ) )

		'' return *tmp
		function = astNewLINK( t, _
						   	   astNewDEREF( 0, _
			   		   			   	  	  	astNewVAR( tmp, _
			   		   			   			  	 	   0, _
			   		   			   			  	 	   FB_DATATYPE_POINTER + dtype, _
			   		   			   			  	 	   subtype ),_
			   		   			   	  	  	dtype, _
			   		   			   	  	  	subtype ) )

		'' repatch node
		n = astNewDEREF( 0, _
					   	 astNewVAR( tmp, 0, FB_DATATYPE_POINTER + dtype, subtype ), _
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

''::::
function astIsTreeEqual _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

    function = FALSE

    if( (l = NULL) or (r = NULL) ) then
    	if( l = r ) then
    		function = TRUE
    	end if
    	exit function
    end if

	if( l->class <> r->class ) then
		exit function
	end if

	if( l->dtype <> r->dtype ) then
		exit function
	end if

	if( l->subtype <> r->subtype ) then
		exit function
	end if

	select case as const l->class
	case AST_NODECLASS_VAR
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->var.ofs <> r->var.ofs ) then
			exit function
		end if

	case AST_NODECLASS_FIELD
		if( l->sym <> r->sym ) then
			exit function
		end if

	case AST_NODECLASS_CONST
		const DBL_EPSILON = 2.2204460492503131e-016

		select case as const l->dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			if( l->con.val.long <> r->con.val.long ) then
				exit function
			end if

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			if( abs( l->con.val.float - r->con.val.float ) > DBL_EPSILON ) then
				exit function
			end if

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    	if( FB_LONGSIZE = len( integer ) ) then
				if( l->con.val.int <> r->con.val.int ) then
					exit function
				end if
  	    	else
				if( l->con.val.long <> r->con.val.long ) then
					exit function
				end if
  	    	end if

		case else
			if( l->con.val.int <> r->con.val.int ) then
				exit function
			end if
		end select

	case AST_NODECLASS_ENUM
		if( l->con.val.int <> r->con.val.int ) then
			exit function
		end if

	case AST_NODECLASS_DEREF
		if( l->ptr.ofs <> r->ptr.ofs ) then
			exit function
		end if

	case AST_NODECLASS_IDX
		if( l->idx.ofs <> r->idx.ofs ) then
			exit function
		end if

		if( l->idx.mult <> r->idx.mult ) then
			exit function
		end if

	case AST_NODECLASS_BOP
		if( l->op.op <> r->op.op ) then
			exit function
		end if

		if( l->op.options <> r->op.options ) then
			exit function
		end if

		if( l->op.ex <> r->op.ex ) then
			exit function
		end if

	case AST_NODECLASS_UOP
		if( l->op.op <> r->op.op ) then
			exit function
		end if

		if( l->op.options <> r->op.options ) then
			exit function
		end if

	case AST_NODECLASS_ADDR
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->op.op <> r->op.op ) then
			exit function
		end if

	case AST_NODECLASS_OFFSET
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->ofs.ofs <> r->ofs.ofs ) then
			exit function
		end if

	case AST_NODECLASS_CONV
		'' do nothing, the l child will be checked below

	case AST_NODECLASS_CALL, AST_NODECLASS_BRANCH, _
		 AST_NODECLASS_LOAD, AST_NODECLASS_ASSIGN, _
		 AST_NODECLASS_LINK
		'' unpredictable nodes
		exit function

	end select

    '' check childs
	if( astIsTreeEqual( l->l, r->l ) = FALSE ) then
		exit function
	end if

	if( astIsTreeEqual( l->r, r->r ) = FALSE ) then
		exit function
	end if

    ''
	function = TRUE

end function

'':::::
function astIsClassOnTree _
	( _
		byval class_ as integer, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr m = any

	''
	if( n = NULL ) then
		return NULL
	end if

	if( n->class = class_ ) then
		return n
	end if

	'' walk
	m = astIsClassOnTree( class_, n->l )
	if( m <> NULL ) then
		return m
	end if

	m = astIsClassOnTree( class_, n->r )
	if( m <> NULL ) then
		return m
	end if

	function = NULL

end function

''::::
function astIsSymbolOnTree _
	( _
		byval sym as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as FBSYMBOL ptr s = any

	if( n = NULL ) then
		return FALSE
	end if

	select case as const n->class
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FIELD, _
		 AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET

		s = astGetSymbol( n )

		'' same symbol?
		if( s = sym ) then
			return TRUE
		end if

		'' passed by ref or by desc? can't do any assumption..
		if( s <> NULL ) then
			if( (s->attrib and _
				(FB_SYMBATTRIB_PARAMBYDESC or FB_SYMBATTRIB_PARAMBYREF)) > 0 ) then
				return TRUE
			end if
		end if

	'' pointer? could be pointing to source symbol too..
	case AST_NODECLASS_DEREF
		return TRUE
	end select

	'' walk
	if( n->l <> NULL ) then
		if( astIsSymbolOnTree( sym, n->l ) ) then
			return TRUE
		end if
	end if

	if( n->r <> NULL ) then
		if( astIsSymbolOnTree( sym, n->r ) ) then
			return TRUE
		end if
	end if

	function = FALSE

end function

'':::::
sub astReplaceSymbolOnTree _
	( _
		byval n as ASTNODE ptr, _
		byval old_sym as FBSYMBOL ptr, _
		byval new_sym as FBSYMBOL ptr _
	)

	if( n = NULL ) then
		return
	end if

	if( n->sym = old_sym ) then
		n->sym = new_sym
	end if

	'' assuming no other complex node will be on the
	'' tree (TypeIniTree's won't have blocks, breaks, etc)

	select case as const n->class
	case AST_NODECLASS_BOP, AST_NODECLASS_UOP
		if( n->op.ex = old_sym ) then
			n->op.ex = new_sym
		end if

	case AST_NODECLASS_IIF
		if( n->iif.falselabel = old_sym ) then
			n->iif.falselabel = new_sym
		end if

	case AST_NODECLASS_CALL
		'' too complex, let a helper function replace the symbols
		astReplaceSymbolOnCALL( n, old_sym, new_sym )

	end select

	'' walk
	if( n->l <> NULL ) then
		astReplaceSymbolOnTree( n->l, old_sym, new_sym )
	end if

	if( n->r <> NULL ) then
		astReplaceSymbolOnTree( n->r, old_sym, new_sym )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree routines
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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
	case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
		return TRUE
	case else
		return FALSE
	end select

end function

'':::::
function astGetValueAsInt _
	( _
		byval n as ASTNODE ptr _
	) as integer

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = cint( astGetValLong( n ) )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = cint( astGetValFloat( n ) )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    if( FB_LONGSIZE = len( integer ) ) then
  	    	function = astGetValInt( n )
  	    else
  	    	function = cint( astGetValLong( n ) )
  	    end if

  	case else
  		function = astGetValInt( n )
  	end select

end function

'':::::
function astGetValueAsStr _
	( _
		byval n as ASTNODE ptr _
	) as string

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT
  		function = str( astGetValLong( n ) )

  	case FB_DATATYPE_ULONGINT
  		function = str( cast( ulongint, astGetValLong( n ) ) )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = str( astGetValFloat( n ) )

  	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
  		function = str( astGetValInt( n ) )

  	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = str( cast( uinteger, astGetValInt( n ) ) )
		else
			function = str( astGetValLong( n ) )
		end if

  	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = str( cast( uinteger, astGetValInt( n ) ) )
		else
			function = str( cast( ulongint, astGetValLong( n ) ) )
		end if

  	case else
  		function = str( cast( uinteger, astGetValInt( n ) ) )
  	end select

end function

'':::::
function astGetValueAsWstr _
	( _
		byval n as ASTNODE ptr _
	) as wstring ptr

    static as wstring * 64+1 res

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT
		res = wstr( astGetValLong( n ) )

	case FB_DATATYPE_ULONGINT
		res = wstr( cast( ulongint, astGetValLong( n ) ) )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		res = wstr( astGetValFloat( n ) )

  	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
  		res = wstr( astGetValInt( n ) )

  	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			res = wstr( cast( uinteger, astGetValInt( n ) ) )
		else
			res = wstr( astGetValLong( n ) )
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			res = wstr( cast( uinteger, astGetValInt( n ) ) )
		else
			res = wstr( cast( ulongint, astGetValLong( n ) ) )
		end if

  	case else
		res = wstr( cast( uinteger, astGetValInt( n ) ) )
  	end select

  	function = @res

end function

'':::::
function astGetValueAsLongInt _
	( _
		byval n as ASTNODE ptr _
	) as longint

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = astGetValLong( n )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = clngint( astGetValFloat( n ) )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    if( FB_LONGSIZE = len( integer ) ) then
  			if( astGetDataType( n ) = FB_DATATYPE_LONG ) then
  				function = clngint( astGetValInt( n ) )
  			else
  				function = clngint( cuint( astGetValInt( n ) ) )
  			end if
  	   	else
  	    	function = astGetValLong( n )
  	    end if

  	case else
  		if( symbIsSigned( astGetDataType( n ) ) ) then
  			function = clngint( astGetValInt( n ) )
  		else
  			function = clngint( cuint( astGetValInt( n ) ) )
  		end if
  	end select

end function

'':::::
function astGetValueAsULongInt _
	( _
		byval n as ASTNODE ptr _
	) as ulongint

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = astGetValLong( n )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = culngint( astGetValFloat( n ) )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    if( FB_LONGSIZE = len( integer ) ) then
  	    	function = culngint( cuint( astGetValInt( n ) ) )
  	    else
  	    	function = astGetValLong( n )
  	    end if

  	case else
  		function = culngint( cuint( astGetValInt( n ) ) )
  	end select

end function

'':::::
function astGetValueAsDouble _
	( _
		byval n as ASTNODE ptr _
	) as double

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = cdbl( astGetValLong( n ) )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = astGetValFloat( n )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    if( FB_LONGSIZE = len( integer ) ) then
  	    	function = cdbl( astGetValLong( n ) )
  	    else
  	    	function = cdbl( astGetValInt( n ) )
  	    end if

  	case else
  		function = cdbl( astGetValInt( n ) )
  	end select

end function

'':::::
function astGetStrLitSymbol _
	( _
		byval n as ASTNODE ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr s

    function = NULL

   	if( astIsVAR( n ) ) then
		s = astGetSymbol( n )
		if( s <> NULL ) then
			if( symbGetIsLiteral( s ) ) then
				function = s
			end if
		end if
	end if

end function

'':::::
sub astConvertValue _
	( _
		byval n as ASTNODE ptr, _
		byval v as FBVALUE ptr, _
		byval todtype as integer _
	) static

	hConvertValue( @n->con.val, n->dtype, v, todtype )

end sub

'':::::
function astCheckConst _
	( _
		byval dtype as integer, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr static

	dim as longint lval
	dim as ulongint ulval
	dim as double dval, dmin, dmax

	'' x86/32-bit assumptions

    select case as const dtype
    case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE

		if( dtype = FB_DATATYPE_SINGLE ) then
			dmin = 1.175494351e-38
			dmax = 3.402823466e+38
		else
			dmin = 2.2250738585072014e-308
			dmax = 1.7976931348623147e+308
		end if

		dval = abs( astGetValueAsDouble( n ) )
    	if( dval <> 0 ) then
    		if( (dval < dmin) or (dval > dmax) ) then
    			errReport( FB_ERRMSG_MATHOVERFLOW, TRUE )
			end if
		end if

	case FB_DATATYPE_LONGINT

chk_long:
		'' unsigned constant?
		if( symbIsSigned( astGetDataType( n ) ) = FALSE ) then
			'' too big?
			if( astGetValueAsULongInt( n ) > 9223372036854775807ULL ) then
				n = astNewCONV( dtype, NULL, n )
				errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
			end if
		end if

	case FB_DATATYPE_ULONGINT

chk_ulong:
		'' signed constant?
		if( symbIsSigned( astGetDataType( n ) ) ) then
			'' too big?
			if( astGetValueAsLongInt( n ) and &h8000000000000000 ) then
				n = astNewCONV( dtype, NULL, n )
				errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
			end if
		end if

    case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, _
    	 FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM

chk_int:
		lval = astGetValueAsLongInt( n )
		if( (lval < ast_minlimitTB( dtype )) or _
			(lval > clngint( ast_maxlimitTB( dtype ) )) ) then
			n = astNewCONV( dtype, NULL, n )
			errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
		end if

    case FB_DATATYPE_UBYTE, FB_DATATYPE_CHAR, _
    	 FB_DATATYPE_USHORT, FB_DATATYPE_WCHAR, _
    	 FB_DATATYPE_UINT

chk_uint:
		ulval = astGetValueAsULongInt( n )
		if( (ulval < culngint( ast_minlimitTB( dtype ) )) or _
			(ulval > ast_maxlimitTB( dtype )) ) then
			n = astNewCONV( dtype, NULL, n )
			errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
		end if

	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			goto chk_int
		else
			goto chk_long
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			goto chk_uint
		else
			goto chk_ulong
		end if

	case FB_DATATYPE_BITFIELD
		'' !!!WRITEME!!! use ->subtype's
	end select

	function = n

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

'':::::
private sub hSetType _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

    n->dtype = dtype
    n->subtype = subtype

end sub

