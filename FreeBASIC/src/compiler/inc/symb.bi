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
'' symbol table protos
''

#include once "inc\ast.bi"

declare sub 		symbInit				( byval ismain as integer )

declare sub 		symbEnd					( )

declare function 	symbLookup				( byval symbol as zstring ptr, _
											  id as integer, _
											  class as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbFindByClass			( byval s as FBSYMBOL ptr, _
											  byval class as integer ) as FBSYMBOL ptr

declare function 	symbFindBySuffix		( byval s as FBSYMBOL ptr, _
											  byval suffix as integer, _
						   					  byval deftyp as integer ) as FBSYMBOL ptr

declare function 	symbFindByNameAndClass	( byval symbol as zstring ptr, _
											  byval class as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbFindByNameAndSuffix	( byval symbol as zstring ptr, _
											  byval suffix as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbFindOverloadProc	( byval parent as FBSYMBOL ptr, _
											  byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbFindClosestOvlProc	( byval proc as FBSYMBOL ptr, _
					   		    			  byval params as integer, _
					   		    			  exprTB() as ASTNODE ptr, _
					   		    			  modeTB() as integer ) as FBSYMBOL ptr

declare function 	symbLookupUDTVar		( byval symbol as zstring ptr, _
											  byval dotpos as integer ) as FBSYMBOL ptr

declare function 	symbLookupUDTElm		( byval symbol as zstring ptr, _
											  byval dotpos as integer, _
											  suffix as integer, _
											  ofs as integer, _
					       					  elm as FBSYMBOL ptr, _
					       					  subtype as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbLookupProcResult	( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare	function 	symbGetGlobalTbHead		( ) as FBSYMBOL ptr

declare	function 	symbGetSymbolTbHead 	( ) as FBSYMBOL ptr

declare function 	symbGetVarText			( byval s as FBSYMBOL ptr ) as string

declare function 	symbGetVarDescName		( byval s as FBSYMBOL ptr ) as string

declare function 	symbGetProcLib			( byval p as FBSYMBOL ptr ) as string

declare function 	symbGetUDTElmOffset		( elm as FBSYMBOL ptr, _
											  typ as integer, _
											  subtype as FBSYMBOL ptr, _
											  byval fields as zstring ptr ) as integer

declare function 	symbGetUDTLen			( byval udt as FBSYMBOL ptr, _
											  byval realsize as integer = TRUE ) as integer

declare function 	symbGetConstValueAsStr	( byval s as FBSYMBOL ptr ) as string

declare function 	symbCalcArgLen			( byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval mode as integer ) as integer

declare function 	symbListLibs			( namelist() as string, _
											  byval index as integer ) as integer

declare function 	symbAddKeyword			( byval symbol as zstring ptr, _
											  byval id as integer, _
											  byval class as integer ) as FBSYMBOL ptr

declare function 	symbAddDefine			( byval symbol as zstring ptr, _
											  byval text as zstring ptr, _
											  byval lgt as integer, _
											  byval isargless as integer = FALSE, _
											  byval proc as function( ) as string = NULL, _
                        					  byval flags as integer = 0 ) as FBSYMBOL ptr

declare function 	symbAddDefineMacro		( byval symbol as zstring ptr, _
							 				  byval tokhead as FBDEFTOK ptr, _
							 				  byval args as integer, _
						 	 				  byval arghead as FBDEFARG ptr ) as FBSYMBOL ptr

declare function 	symbAddDefineArg		( byval lastarg as FBDEFARG ptr, _
											  byval symbol as zstring ptr ) as FBDEFARG ptr

declare function 	symbAddDefineTok		( byval lasttok as FBDEFTOK ptr, _
						     				  byval typ as FB_DEFTOK_TYPE ) as FBDEFTOK ptr

declare function 	symbAddFwdRef			( byval symbol as zstring ptr ) as FBSYMBOL ptr

declare function 	symbAddTypedef			( byval symbol as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
						 					  byval ptrcnt as integer, _
						 					  byval lgt as integer ) as FBSYMBOL ptr

declare function 	symbAddLabel			( byval symbol as zstring ptr, _
											  byval declaring as integer = TRUE, _
											  byval createalias as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbAddVar				( byval symbol as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
					  						  byval ptrcnt as integer, _
					  						  byval dimensions as integer, _
					  						  dTB() as FBARRAYDIM, _
				      						  byval alloctype as integer ) as FBSYMBOL ptr

declare function 	symbAddVarEx			( byval symbol as zstring ptr, _
											  byval aliasname as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, _
											  byval lgt as integer, _
											  byval dimensions as integer, _
											  dTB() as FBARRAYDIM, _
				       						  byval alloctype as integer, _
				       						  byval addsuffix as integer, _
				       						  byval preservecase as integer, _
				       						  byval clearname as integer ) as FBSYMBOL ptr

declare function 	symbAddTempVar			( byval typ as integer, _
											  byval subtype as FBSYMBOL ptr = NULL ) as FBSYMBOL ptr

declare function 	symbAddConst			( byval symbol as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval value as FBVALUE ptr ) as FBSYMBOL ptr

declare function 	symbAddUDT				( byval parent as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
											  byval isunion as integer, _
											  byval align as integer ) as FBSYMBOL ptr

declare function 	symbAddUDTElement		( byval t as FBSYMBOL ptr, _
											  byval id as zstring ptr, _
											  byval dimensions as integer, _
											  dTB() as FBARRAYDIM, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, _
											  byval lgt as integer, _
											  byval bits as integer ) as FBSYMBOL ptr

declare sub 		symbInsertInnerUDT		( byval t as FBSYMBOL ptr, _
							 				  byval inner as FBSYMBOL ptr )

declare function 	symbAddEnum				( byval symbol as zstring ptr ) as FBSYMBOL ptr

declare function 	symbAddEnumElement		( byval parent as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
					         				  byval value as integer ) as FBSYMBOL ptr

declare function 	symbAddArg				( byval proc as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
											  byval typ as integer, _
					 						  byval subtype as FBSYMBOL ptr, _
					 						  byval ptrcnt as integer, _
					 						  byval lgt as integer, _
					 						  byval mode as integer, _
					 						  byval suffix as integer, _
					 						  byval optional as integer, _
					 						  byval optval as FBVALUE ptr ) as FBSYMBOL ptr

declare function 	symbAddPrototype		( byval proc as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
											  byval aliasname as zstring ptr, _
											  byval libname as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, _
											  byval alloctype as integer, _
											  byval mode as integer, _
											  byval isexternal as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbAddProc				( byval proc as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
											  byval aliasname as zstring ptr, _
											  byval libname as zstring ptr, _
					  						  byval typ as integer, _
					  						  byval subtype as FBSYMBOL ptr, _
					  						  byval ptrcnt as integer, _
					  						  byval alloctype as integer, _
					  						  byval mode as integer ) as FBSYMBOL ptr

declare function 	symbPreAddProc			( ) as FBSYMBOL ptr

declare function 	symbAddProcResult		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddProcResArg		( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddLib				( byval libname as string ) as FBLIBRARY ptr

declare function 	symbAddArgAsVar			( byval symbol as zstring ptr, _
											  byval arg as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddScope			( ) as FBSYMBOL ptr

declare sub 		symbRoundUDTSize		( byval t as FBSYMBOL ptr )

declare sub 		symbRecalcUDTSize		( byval t as FBSYMBOL ptr )

declare function 	symbGetLastLabel 		( ) as FBSYMBOL ptr

declare sub 		symbSetLastLabel		( byval l as FBSYMBOL ptr )

declare sub 		symbSetArrayDims		( byval s as FBSYMBOL ptr, _
					  						  byval dimensions as integer, _
					  						  dTB() as FBARRAYDIM )

declare function 	symbSetSymbolTb			( byval tb as FBSYMBOLTB ptr ) as FBSYMBOLTB ptr

declare sub 		symbFreeLocalDynVars	( byval proc as FBSYMBOL ptr, _
											  byval issub as integer )


declare sub 		symbFreeScopeDynVars 	( byval scp as FBSYMBOL ptr )

declare sub 		symbDelSymbolTb			( byval tb as FBSYMBOLTB ptr, _
											  byval hashonly as integer )

declare sub 		symbDelScopeTb			( byval scp as FBSYMBOL ptr )

declare sub 		symbDelSymbol			( byval s as FBSYMBOL ptr )

declare function 	symbDelKeyword			( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE ) as integer

declare function 	symbDelDefine			( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE ) as integer

declare sub 		symbDelLabel			( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub			symbDelVar				( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelPrototype		( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelEnum				( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelUDT				( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelConst			( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelLib				( byval l as FBLIBRARY ptr )

declare function 	symbCalcLen				( byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval realsize as integer = FALSE ) as integer

declare function 	hAllocFloatConst		( byval value as double, _
											  byval typ as integer ) as FBSYMBOL ptr

declare function 	hAllocStringConst		( byval sname as string, _
											  byval lgt as integer ) as FBSYMBOL ptr

declare function 	hCalcElements 			( byval s as FBSYMBOL ptr, _
											  byval n as FBVARDIM ptr = NULL ) as integer

declare function 	symbCheckLabels 		( ) as integer

declare function 	symbCheckLocalLabels 	( ) as integer

declare function 	symbCheckBitField		( byval udt as FBSYMBOL ptr, _
											  byval typ as integer, _
											  byval lgt as integer, _
											  byval bits as integer ) as integer

declare function 	symbIsEqual				( byval sym1 as FBSYMBOL ptr, _
					  						  byval sym2 as FBSYMBOL ptr ) as integer

declare function 	symbIsProcOverloadOf	( byval proc as FBSYMBOL ptr, _
							   				  byval parent as FBSYMBOL ptr ) as integer
''
'' getters and setters as macros
''

#define symbGetAccessCnt(s) s->acccnt

#define symbIncAccessCnt(s) s->acccnt += 1

#define symbGetLen(s) iif( s <> NULL, s->lgt, 0 )

#define symbGetType(s) s->typ

#define symbGetSubType(s) s->subtype

#define symbGetClass(s) s->class

#define symbIsVar(s) (s->class = FB_SYMBCLASS_VAR)

#define symbIsConst(s) (s->class = FB_SYMBCLASS_CONST)

#define symbIsProc(s) (s->class = FB_SYMBCLASS_PROC)

#define symbIsProcArg(s) (s->class = FB_SYMBCLASS_PROCARG)

#define symbIsDefine(s) (s->class = FB_SYMBCLASS_DEFINE)

#define symbIsKeyword(s) (s->class = FB_SYMBCLASS_KEYWORD)

#define symbIsLabel(s) (s->class = FB_SYMBCLASS_LABEL)

#define symbIsEnum(s) (s->class = FB_SYMBCLASS_ENUM)

#define symbIsUDT(s) (s->class = FB_SYMBCLASS_UDT)

#define symbIsUDTElm(s) (s->class = FB_SYMBCLASS_UDTELM)

#define symbIsTypedef(s) (s->class = FB_SYMBCLASS_TYPEDEF)

#define symbIsFwdRef(s) (s->class = FB_SYMBCLASS_FWDREF)

#define symbIsScope(s) (s->class = FB_SYMBCLASS_SCOPE)

#define symbGetAllocType(s) s->alloctype

#define symbSetAllocType(s,t) s->alloctype = t

#define symbGetConstValStr(s) s->con.val.str

#define symbGetConstValInt(s) s->con.val.int

#define symbGetConstValFloat(s) s->con.val.float

#define symbGetConstValLong(s) s->con.val.long

#define symbGetDefineText(d) d->def.text

#define symbGetDefineHeadToken(d) d->def.tokhead

#define symbGetDefTokNext(t) t->next

#define symbGetDefTokType(t) t->type

#define symbSetDefTokType(t,_typ) t->type = _typ

#define symbGetDefTokText(t) t->text

#define symbGetDefTokArgNum(t) t->argnum

#define symbSetDefTokArgNum(t,n) t->argnum = n

#define symbGetDefineArgs(d) d->def.args

#define symbGetDefineHeadArg(d) d->def.arghead

#define symbGetDefArgNext(a) a->next

#define symbGetDefArgName(a) a->name

#define symbGetDefineCallback(d) d->def.proc

#define symbGetDefineIsArgless(d) d->def.isargless

#define symbGetDefineFlags(d) d->def.flags

#define symbGetVarInitialized(s) s->var.initialized

#define symbGetVarEmited(s) s->var.emited

#define symbSetVarEmited(s,v) s->var.emited = v

#define symbGetArrayDiff(s) s->var.array.dif

#define symbGetArrayDimensions(s) s->var.array.dims

#define symbSetArrayDimensions(s,d) s->var.array.dims = d

#define symbGetArrayDescriptor(s) s->var.array.desc

#define symbGetArrayOffset(s) s->var.array.dif

#define symbGetArrayFirstDim(s) s->var.array.dimhead

#define symbGetProcArgs(f) f->proc.args

#define symbGetFuncMode(f) f->proc.mode

#define symbGetOrgName(s) s->name

#define symbGetName(s) s->alias

#define symbGetVarOfs(s) s->ofs

#define symbGetUDTFirstElm(s) s->udt.fldtb.head

#define symbGetUDTNextElm(e) e->next

#define symbGetUDTElmBitOfs(e) (e->var.elm.ofs * 8 + e->var.elm.bitpos)

#define symbGetUDTElmBitLen(e) iif( e->var.elm.bits <> 0, e->var.elm.bits, e->lgt * e->var.array.elms * 8 )

#define symbGetUDTIsUnion(s) s->udt.isunion

#define symbGetUDTAlign(s) s->udt.align

#define symbGetUDTElements(s) s->udt.elements

#define symbGetENUMFirstElm(s) s->enum.elmtb.head

#define symbGetENUMNextElm(e) e->next

#define symbGetEnumElements(s) s->enum.elements

#define symbGetScopeTb(s) s->scp.loctb

#define symbGetScopeTbHead(s) s->scp.loctb.head

#define symbGetLabelIsDeclared(l) l->lbl.declared

#define symbGetProcIsDeclared(f) f->proc.isdeclared

#define symbSetProcIsDeclared(f,d) f->proc.isdeclared = d

#define symbGetProcFirstArg(f) iif( f->proc.mode = FB_FUNCMODE_PASCAL, f->proc.argtb.head, f->proc.argtb.tail )

#define symbGetProcLastArg(f) iif( f->proc.mode = FB_FUNCMODE_PASCAL, f->proc.argtb.tail, f->proc.argtb.head )

#define symbGetProcPrevArg(f,a) iif( f->proc.mode = FB_FUNCMODE_PASCAL, a->prev, a->next )

#define symbGetProcNextArg(f,a) iif( f->proc.mode = FB_FUNCMODE_PASCAL, a->next, a->prev )

#define symbGetProcHeadArg(f) f->proc.argtb.head

#define symbGetProcTailArg(f) f->proc.argtb.tail

#define symbGetProcCallback(f) f->proc.rtlcallback

#define symbSetProcCallback(f,cb) f->proc.rtlcallback = cb

#define symbGetProcIsRTL(f) f->proc.isrtl

#define symbSetProcIsRTL(f,v) f->proc.isrtl = v

#define symbGetProcErrorCheck(f) f->proc.doerrorcheck

#define symbSetProcErrorCheck(f,v) f->proc.doerrorcheck = v

#define symbGetProcIsOverloaded(f) ((f->alloctype and FB_ALLOCTYPE_OVERLOADED) > 0)

#define symGetProcOvlMaxArgs(f) f->proc.ovl.maxargs

#define symbGetProcIsCalled(f) f->proc.iscalled

#define symbSetProcIsCalled(f,v) f->proc.iscalled = v

#define symbGetProcIncFile(f) f->proc.dbg.incfile

#define symbSetProcIncFile(f,v) f->proc.dbg.incfile = v

#define symbGetProcRealType(f) f->proc.realtype

#define symbGetProcLocTb(f) f->proc.loctb

#define symbGetProcLocTbHead(f) f->proc.loctb.head

#define symbGetArgMode(f,a) a->arg.mode

#define symbGetArgSuffix(f,a) a->arg.suffix

#define symbGetArgOptional(f,a) a->arg.optional

#define symbGetArgOptValInt(f,a) a->arg.optval.int

#define symbGetArgOptValFloat(f,a) a->arg.optval.float

#define symbGetArgOptValLong(f,a) a->arg.optval.long

#define symbGetArgOptValStr(f,a) a->arg.optval.str

#define symbGetArgPrev(a) a->prev

#define symbGetArgNext(a) a->next

#define symbGetIsDynamic(s) iif( s->class = FB_SYMBCLASS_UDTELM, FALSE, (s->alloctype and (FB_ALLOCTYPE_DYNAMIC or FB_ALLOCTYPE_ARGUMENTBYDESC)) > 0 )

#define symbIsArray(s) iif( (s->alloctype and (FB_ALLOCTYPE_DYNAMIC or FB_ALLOCTYPE_ARGUMENTBYDESC)) > 0, TRUE, s->var.array.dims > 0 )

#define symbIsShared(s) ((s->alloctype and FB_ALLOCTYPE_SHARED) > 0)

#define symbIsStatic(s) ((s->alloctype and FB_ALLOCTYPE_STATIC) > 0)

#define symbIsDynamic(s) ((s->alloctype and FB_ALLOCTYPE_DYNAMIC) > 0)

#define symbIsCommon(s) ((s->alloctype and FB_ALLOCTYPE_COMMON) > 0)

#define symbIsTemp(s) ((s->alloctype and FB_ALLOCTYPE_TEMP) > 0)

#define symbIsArgByDesc(s) ((s->alloctype and FB_ALLOCTYPE_ARGUMENTBYDESC) > 0)

#define symbIsArgByVal(s) ((s->alloctype and FB_ALLOCTYPE_ARGUMENTBYVAL) > 0)

#define symbIsArgByRef(s) ((s->alloctype and FB_ALLOCTYPE_ARGUMENTBYREF) > 0)

#define symbIsArg(s) ((s->alloctype and (FB_ALLOCTYPE_ARGUMENTBYREF or FB_ALLOCTYPE_ARGUMENTBYVAL or FB_ALLOCTYPE_ARGUMENTBYDESC)) > 0)

#define symbIsLocal(s) ((s->alloctype and FB_ALLOCTYPE_LOCAL) > 0)

#define symbIsPublic(s) ((s->alloctype and FB_ALLOCTYPE_PUBLIC) > 0)

#define symbIsPrivate(s) ((s->alloctype and FB_ALLOCTYPE_PRIVATE) > 0)

#define symbIsExtern(s) ((s->alloctype and FB_ALLOCTYPE_EXTERN) > 0)

#define symbIsExport(s) ((s->alloctype and FB_ALLOCTYPE_EXPORT) > 0)

#define symbIsImport(s) ((s->alloctype and FB_ALLOCTYPE_IMPORT) > 0)

#define symbIsOverloaded(s) ((s->alloctype and FB_ALLOCTYPE_OVERLOADED) > 0)

#define symbIsJumpTb(s) ((s->alloctype and FB_ALLOCTYPE_JUMPTB) > 0)

#define symbIsMainProc(s) ((s->alloctype and FB_ALLOCTYPE_MAINPROC) > 0)

#define symbIsConstructor(s) ((s->alloctype and FB_ALLOCTYPE_CONSTRUCTOR) > 0)

#define symbIsDestructor(s) ((s->alloctype and FB_ALLOCTYPE_DESTRUCTOR) > 0)


#define hIsString(t) ((t = IR_DATATYPE_STRING) or (t = IR_DATATYPE_FIXSTR) or (t = IR_DATATYPE_CHAR))



