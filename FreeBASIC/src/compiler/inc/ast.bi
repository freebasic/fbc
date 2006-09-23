#ifndef __AST_BI__
#define __AST_BI__

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


#include once "inc\list.bi"
#include once "inc\ast-op.bi"

const AST_INITTEMPSTRINGS		= 32*4

const AST_INITNODES				= 8192
const AST_INITPROCNODES			= 128

'' if changed, update ast_classTB at ast.bas
enum AST_NODECLASS
	AST_NODECLASS_NOP

	AST_NODECLASS_LOAD
	AST_NODECLASS_ASSIGN
	AST_NODECLASS_BOP
	AST_NODECLASS_UOP
	AST_NODECLASS_CONV
	AST_NODECLASS_ADDR
	AST_NODECLASS_BRANCH
	AST_NODECLASS_CALL
	AST_NODECLASS_CALLCTOR
	AST_NODECLASS_STACK
	AST_NODECLASS_MEM
	AST_NODECLASS_COMP							'' used by IR only

	AST_NODECLASS_LINK
	AST_NODECLASS_CONST
	AST_NODECLASS_VAR
	AST_NODECLASS_IDX
	AST_NODECLASS_FIELD
	AST_NODECLASS_ENUM
	AST_NODECLASS_PTR
	AST_NODECLASS_LABEL
	AST_NODECLASS_ARG
	AST_NODECLASS_OFFSET
	AST_NODECLASS_DECL

	AST_NODECLASS_NIDXARRAY

	AST_NODECLASS_IIF
	AST_NODECLASS_LIT
	AST_NODECLASS_ASM
	AST_NODECLASS_JMPTB
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

	AST_NODECLASS_PROC
	AST_NODECLASS_NAMESPC

	AST_CLASSES
end enum

enum AST_OPOPT
	AST_OPOPT_NONE  		= &h00000000

	AST_OPOPT_ALLOCRES		= &h00000001
	AST_OPOPT_LPTRARITH		= &h00000002
	AST_OPOPT_RPTRARITH		= &h00000004
	AST_OPOPT_NOCOERCION	= &h00000008
	AST_OPOPT_DONTCHKPTR	= &h00000010
	AST_OPOPT_DONTCHKOPOVL	= &h00000020

	AST_OPOPT_DOPTRARITH	= AST_OPOPT_LPTRARITH or AST_OPOPT_RPTRARITH

	AST_OPOPT_DEFAULT		= AST_OPOPT_ALLOCRES
end enum

#ifndef ASTNODE_
type ASTNODE_ as ASTNODE
#endif

type ASTTEMPSTR
	tmpsym			as FBSYMBOL ptr
	srctree			as ASTNODE_ ptr
	prev			as ASTTEMPSTR ptr
end type

''
type AST_NODE_CALL
	isrtl			as integer
	args			as integer
	currarg			as FBSYMBOL ptr
	lastarg			as ASTNODE_ ptr					'' used to speed up PASCAL conv. only
	strtail 		as ASTTEMPSTR ptr
	res             as FBSYMBOL ptr					'' temp result structure, if needed
	profbegin		as ASTNODE_ ptr
	profend			as ASTNODE_ ptr
end type

type AST_NODE_ARG
	mode			as integer						'' to pass NULL's to byref args, etc
	lgt				as integer						'' length, used to push UDT's by value
end type

type AST_NODE_VAR
	ofs				as integer						'' offset
end type

type AST_NODE_IDX
	ofs				as integer						'' offset
	mult			as integer						'' multipler
end type

type AST_NODE_PTR
	ofs				as integer						'' offset
end type

type AST_NODE_IIF
	falselabel 		as FBSYMBOL ptr
end type

type AST_NODE_LOAD
	isres			as integer
end type

type AST_NODE_LABEL
	flush			as integer
end type

type AST_NODE_LIT
	text			as zstring ptr
end type

type FB_ASMTOK_ as FB_ASMTOK

type AST_NODE_ASM
	head			as FB_ASMTOK_ ptr
end type

type AST_NODE_OP                                  	'' used by: bop, uop, conv & addr
	op				as integer
	options 		as AST_OPOPT
	ex				as FBSYMBOL ptr					'' (extra: label, etc)
end type

type AST_NODE_CONST
	val				as FBVALUE
end type

type AST_NODE_OFFS
	ofs				as integer
end type

type AST_NODE_JMPTB
	label			as FBSYMBOL ptr
end type

type AST_NODE_DBG
	ex				as integer
	op				as integer
end type

type AST_NODE_MEM
	bytes			as integer
	op				as integer
end type

type AST_NODE_STACK
	op				as integer
end type

type AST_NODE_TYPEINI
	ofs				as integer
    union
    	bytes		as integer
    	elements	as integer
    end union
end type

type AST_NODE_BREAK
	parent			as ASTNODE_ ptr
	scope			as integer
	linenum			as integer
	stmtnum			as integer						'' can't use colnum as it's unreliable
end type

type AST_BREAKLIST
	head			as ASTNODE_ ptr
	tail			as ASTNODE_ ptr
end type

type AST_NODE_PROC
	ismain			as integer
	decl_last		as ASTNODE_ ptr					'' to support implicit variables decl
end type

type AST_NODE_BLOCK
	parent			as ASTNODE_ ptr
	inistmt			as integer
	endstmt			as integer
	initlabel		as FBSYMBOL ptr
	exitlabel		as FBSYMBOL ptr
	breaklist		as AST_BREAKLIST
	proc			as AST_NODE_PROC
end type

''
type ASTNODE
	class			as integer						'' CONST, VAR, BOP, UOP, IDX, FUNCT, etc

	dtype			as integer
	subtype			as FBSYMBOL ptr					'' if dtype is an USERDEF or ENUM

	defined 		as integer						'' only true for constants

	sym				as FBSYMBOL ptr					'' attached symbol

	union
		con			as AST_NODE_CONST
		var			as AST_NODE_VAR
		idx			as AST_NODE_IDX
		ptr			as AST_NODE_PTR
		call		as AST_NODE_CALL
		arg			as AST_NODE_ARG
		iif			as AST_NODE_IIF
		op			as AST_NODE_OP
		lod			as AST_NODE_LOAD
		lbl			as AST_NODE_LABEL
		ofs			as AST_NODE_OFFS
		lit			as AST_NODE_LIT
		asm			as AST_NODE_ASM
		jmptb		as AST_NODE_JMPTB
		dbg			as AST_NODE_DBG
		mem			as AST_NODE_MEM
		stack		as AST_NODE_STACK
		typeini		as AST_NODE_TYPEINI
		block		as AST_NODE_BLOCK				'' shared by PROC and SCOPE nodes
		break		as AST_NODE_BREAK
	end union

	prev			as ASTNODE ptr					'' used by Add
	next			as ASTNODE ptr					'' /

	l				as ASTNODE ptr					'' left node, index of ast tb
	r				as ASTNODE ptr					'' right /     /
end type

type AST_PROCCTX
	head			as ASTNODE ptr					'' procs list
	tail			as ASTNODE ptr					'' /     /
	curr			as ASTNODE ptr					'' current proc
end type

type ASTVALUE
	dtype			as integer
	val				as FBVALUE
end type

type AST_GLOBINSTCTX
	list			as TLIST						'' global symbols with ctors/dtors
	ctorcnt			as integer						'' number of ctors in the list above
	dtorcnt			as integer						''      /    dtors       /
end type

type ASTCTX
	astTB			as TLIST

	proc			as AST_PROCCTX

	currblock		as ASTNODE ptr					'' current scope block (PROC or SCOPE)

	globinst		as AST_GLOBINSTCTX				'' global instances

	doemit			as integer
	isopt			as integer

	tempstr			as TLIST

	typeinicnt		as integer
end Type

#include once "inc\ir.bi"

enum AST_OPFLAGS
	AST_OPFLAGS_NONE		= &h00000000
	AST_OPFLAGS_SELF		= &h00000001			'' op=
	AST_OPFLAGS_COMM		= &h00000002			'' commutative
end enum

type AST_OPINFO
	class			as AST_NODECLASS
	flags 			as AST_OPFLAGS
	id				as zstring ptr
	selfop			as AST_OP						'' self version
end type

type AST_LOADCB as function _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

type AST_SETTYPECB as sub _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

type AST_CLASSINFO
	loadcb			as AST_LOADCB
	settypecb		as AST_SETTYPECB
	iscode			as integer
end type

declare sub astInit _
	( _
		_
	)

declare sub astEnd _
	( _
		_
	)

declare sub astDelNode _
	( _
		byval n as ASTNODE ptr _
	)

declare function astCloneTree _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare sub astDelTree _
	( _
		byval n as ASTNODE ptr _
	)

declare function astIsTreeEqual _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

declare function astIsADDR _
	( _
		byval n as ASTNODE ptr _
	) as integer

declare sub astConvertValue _
	( _
		byval n as ASTNODE ptr, _
		byval v as FBVALUE ptr, _
		byval todtype as integer _
	)

declare function astGetValueAsInt _
	( _
		byval n as ASTNODE ptr _
	) as integer

declare function astGetValueAsLongInt _
	( _
		byval n as ASTNODE ptr _
	) as longint

declare function astGetValueAsULongInt _
	( _
		byval n as ASTNODE ptr _
	) as ulongint

declare function astGetValueAsDouble _
	( _
		byval n as ASTNODE ptr _
	) as double

declare function astGetValueAsStr _
	( _
		byval n as ASTNODE ptr _
	) as string

declare function astGetValueAsWstr _
	( _
		byval n as ASTNODE ptr _
	) as wstring ptr

declare function astProcBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval ismain as integer = FALSE _
	) as ASTNODE ptr

declare function astProcEnd _
	( _
		byval p as ASTNODE ptr, _
		byval callrtexit as integer = FALSE _
	) as integer

declare function astProcAddStaticInstance _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare sub astProcAddGlobalInstance _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval has_dtor as integer _
	)

declare function astScopeBegin _
	( _
		_
	) as ASTNODE ptr

declare sub astScopeEnd _
	( _
		byval s as ASTNODE ptr _
	)

declare function astScopeBreak _
	( _
		byval tolabel as FBSYMBOL ptr _
	) as integer

declare function astScopeUpdBreakList _
	( _
		byval proc as ASTNODE ptr _
	) as integer

declare function astNamespaceBegin _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare sub astNamespaceEnd _
	( _
		byval n as ASTNODE ptr _
	)

declare function astAdd _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare function astAddAfter _
	( _
		byval n as ASTNODE ptr, _
		byval p as ASTNODE ptr _
	) as ASTNODE ptr

declare sub astAddUnscoped _
	( _
		byval n as ASTNODE ptr _
	)

declare function astUpdComp2Branch _
	( _
		byval n as ASTNODE ptr, _
		byval label as FBSYMBOL ptr, _
		byval isinverse as integer _
	) as ASTNODE ptr

declare function astPtrCheck _
	( _
		byval pdtype as integer, _
		byval psubtype as FBSYMBOL ptr, _
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

declare function astNewCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr, _
		byval op as AST_OP = INVALID, _
		byval check_str as integer = FALSE _
	) as ASTNODE ptr

declare function astNewOvlCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

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
		byval value as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astNewCONSTf _
	( _
		byval value as double, _
		byval dtype as integer _
	) as ASTNODE ptr

declare function astNewCONSTl _
	( _
		byval value as longint, _
		byval dtype as integer _
	) as ASTNODE ptr

declare function astNewCONSTz _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astNewVAR _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ofs as integer = 0, _
		byval dtype as integer = FB_DATATYPE_INTEGER, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare sub astBuildVAR _
	( _
		byval n as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval ofs as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL _
	)

declare function astNewIDX _
	( _
		byval v as ASTNODE ptr, _
		byval i as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astNewFIELD _
	( _
		byval p as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval dtype as integer = FB_DATATYPE_INTEGER, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

declare function astNewPTR _
	( _
		byval ofs as integer, _
		byval l as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astNewCALL _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr = NULL, _
		byval isprofiler as integer = FALSE _
	) as ASTNODE ptr

declare function astNewCALLCTOR _
	( _
		byval procexpr as ASTNODE ptr, _
		byval instptr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewARG _
	( _
		byval f as ASTNODE ptr, _
		byval p as ASTNODE ptr, _
		byval dtype as integer = INVALID, _
		byval mode as integer = INVALID _
	) as ASTNODE ptr

declare function astReplaceARG _
	( _
		byval parent as ASTNODE ptr, _
		byval argnum as integer, _
		byval expr as ASTNODE ptr, _
		byval dtype as integer = INVALID, _
		byval mode as integer = INVALID _
	) as ASTNODE ptr

declare function astNewADDR _
	( _
		byval op as integer, _
		byval p as ASTNODE ptr _
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

declare function astNewIIF _
	( _
		byval condexpr as ASTNODE ptr, _
		byval truexpr as ASTNODE ptr, _
		byval falsexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewOFFSET _
	( _
		byval v as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewLINK _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewSTACK _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewENUM _
	( _
		byval value as integer, _
		byval enum as FBSYMBOL ptr _
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

declare function astNewASM _
	( _
		byval listhead as FB_ASMTOK_ ptr _
	) as ASTNODE ptr

declare function astNewJMPTB _
	( _
		byval dtype as integer, _
		byval label as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astNewDBG _
	( _
		byval op as integer, _
		byval ex as integer = 0 _
	) as ASTNODE ptr

declare function astNewMEM _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval bytes as integer _
	) as ASTNODE ptr

declare function astNewBOUNDCHK _
	( _
		byval l as ASTNODE ptr, _
		byval lb as ASTNODE ptr, _
		byval ub as ASTNODE ptr, _
		byval linenum as integer _
	) as ASTNODE ptr

declare function astNewPTRCHK _
	( _
		byval l as ASTNODE ptr, _
		byval linenum as integer _
	) as ASTNODE ptr

declare function astNewDECL _
	( _
		byval symclass as FB_SYMBCLASS, _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr _
	) as ASTNODE ptr

declare function astNewNIDXARRAY _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

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

declare function astOptimize _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare function astOptAssignment _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare function astCheckConst _
	( _
		byval dtype as integer, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare function astCheckASSIGN _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

declare function astCheckCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as integer

declare function astUpdStrConcat _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare function astIsClassOnTree _
	( _
		byval class_ as integer, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

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
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

declare sub astTypeIniEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval isinitializer as integer _
	)

declare function astTypeIniAddPad _
	( _
		byval tree as ASTNODE ptr, _
		byval bytes as integer _
	) as ASTNODE ptr

declare function astTypeIniAddAssign _
	( _
		byval tree as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astTypeIniAddCtorCall _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval procexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astTypeIniAddCtorList _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval elements as integer _
	) as ASTNODE ptr

declare function astTypeIniFlush _
	( _
		byval tree as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr, _
		byval isstatic as integer, _
		byval isinitializer as integer _
	) as integer

declare function astTypeIniIsConst _
	( _
		byval tree as ASTNODE ptr _
	) as integer

declare function astTypeIniUpdate _
	( _
		byval tree as ASTNODE ptr _
	) as ASTNODE ptr

declare sub astTypeIniUpdCnt _
	( _
		byval tree as ASTNODE ptr _
	)

declare function astTypeIniGetHead _
	( _
		byval tree as ASTNODE ptr _
	) as ASTNODE ptr

declare function astGetInverseLogOp _
	( _
		byval op as integer _
	) as integer

declare function astBuildVarAddrof _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astBuildVarDeref _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astBuildVarInc _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer _
	) as ASTNODE ptr

declare function astBuildVarAssign overload _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer _
	) as ASTNODE ptr

declare function astBuildVarAssign _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildVarField _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr = NULL, _
		byval ofs as integer = 0 _
	) as ASTNODE ptr

declare function astBuildCall cdecl _
	( _
		byval proc as FBSYMBOL ptr, _
		byval args as integer, _
		... _
	) as ASTNODE ptr

declare function astBuildCtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildDtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildCopyCtorCall _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr _
	) as ASTNODE ptr

declare sub astBuildForBegin _
	( _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval inivalue as integer _
	)

declare sub astBuildForEnd _
	( _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval stepvalue as integer, _
		byval endvalue as integer _
	)

declare function astBuildInstPtr _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr = NULL, _
		byval idxexpr as ASTNODE ptr = NULL, _
		byval ofs as integer = 0 _
	) as ASTNODE ptr

declare function astBuildMockInstPtr _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astBuildVarDtorCall _
	( _
		byval s as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astBuildTypeIniCtorList _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astBuildProcAddrof _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

declare function astBuildProcBegin _
	( _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

declare sub astBuildProcEnd _
	( _
		byval n as ASTNODE ptr _
	)

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

declare function astCallCtorToCall _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

declare function astBuildImplicitCtorCall _
	( _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byref is_ctorcall as integer _
	) as ASTNODE ptr

declare function astBuildImplicitCtorCallEx _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byref is_ctorcall as integer _
	) as ASTNODE ptr

''
'' macros
''
#define astInitNode(n, class_, dtype, subtype)		:_
	n->class 		= class_						:_
	n->dtype 		= dtype							:_
	n->subtype		= subtype						:_
	n->defined		= FALSE							:_
	n->l    		= NULL							:_
	n->r    		= NULL							:_
	n->sym			= NULL

#define astCopy(dst, src) *dst = *src

#define astSwap(dst, src) swap *dst, *src

#define astGetClass(n) n->class

#define astGetLeft( n ) n->l

#define astGetRight( n ) n->r

#define astGetPrev( n ) n->prev

#define astGetNext( n ) n->next

#define astIsCONST(n) n->defined

#define astIsVAR(n) (n->class = AST_NODECLASS_VAR)

#define astIsIDX(n) (n->class = AST_NODECLASS_IDX)

#define astIsCALL(n) (n->class = AST_NODECLASS_CALL)

#define astIsCALLCTOR(n) (n->class = AST_NODECLASS_CALLCTOR)

#define astIsPTR(n) (n->class = AST_NODECLASS_PTR)

#define astIsOFFSET(n) (n->class = AST_NODECLASS_OFFSET)

#define astIsFIELD(n) (n->class = AST_NODECLASS_FIELD)

#define astIsBITFIELD(n) iif( astIsFIELD(n), (n->l->dtype = FB_DATATYPE_BITFIELD), FALSE )

#define astIsNIDXARRAY(n) (n->class = AST_NODECLASS_NIDXARRAY)

#define astGetValue(n) n->con.val

#define astGetValInt(n) n->con.val.int

#define astGetValFloat(n) n->con.val.float

#define astGetValLong(n) n->con.val.long

#define astGetDataType(n) n->dtype

#define astGetSubtype(n) n->subtype

#define astGetDataClass(n) symbGetDataClass( n->dtype )

#define astGetDataSize(n) symbGetDataSize( n->dtype )

#define astGetSymbol(n)	n->sym

#define astGetProcInitlabel(n) n->block.initlabel

#define astGetProcExitlabel(n) n->block.exitlabel

#define astSetType(n, dtype, subtype) ast_classTB(n->class).settypecb( n, dtype, subtype )

#define astTypeIniGetOfs( n ) n->typeini.ofs

#define astGetOpClass( op ) ast_opTB(op).class

#define astGetOpIsCommutative( op ) ((ast_opTB(op).flags and AST_OPFLAGS_COMM) <> 0)

#define astGetOpIsSelf( op ) ((ast_opTB(op).flags and AST_OPFLAGS_SELF) <> 0)

#define astGetOpSelfVer( op ) ast_opTB(op).selfop

#define astGetOpId( op ) ast_opTB(op).id

#define astGetClassLoadCB( cl ) ast_classTB(cl).loadcb

#define astGetClassIsCode( cl ) ast_classTB(cl).iscode

''
'' inter-module globals
''
extern ast as ASTCTX

extern ast_bitmaskTB( 0 to 32 ) as uinteger

extern ast_minlimitTB( FB_DATATYPE_BYTE to FB_DATATYPE_ULONGINT ) as longint

extern ast_classTB( 0 to AST_CLASSES-1 ) as AST_CLASSINFO

extern ast_opTB( 0 to AST_OPCODES-1 ) as AST_OPINFO

#endif '' __AST_BI__
