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

declare sub 		symbInit				( )

declare sub 		symbEnd					( )

declare function 	symbLookup				( byval symbol as string, _
											  id as integer, _
											  class as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbFindByClass			( byval s as FBSYMBOL ptr, _
											  byval class as integer ) as FBSYMBOL ptr

declare function 	symbFindBySuffix		( byval s as FBSYMBOL ptr, _
											  byval suffix as integer, _
						   					  byval deftyp as integer ) as FBSYMBOL ptr

declare function 	symbFindByNameAndClass	( byval symbol as string, _
											  byval class as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbFindByNameAndSuffix	( byval symbol as string, _
											  byval suffix as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbFindOverloadProc	( byval proc as FBSYMBOL ptr, _
					   	       				  byval argc as integer, _
					   	       				  byval argtail as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbFindClosestOvlProc	( byval proc as FBSYMBOL ptr, _
					   		    			  byval params as integer, _
					   		    			  exprTB() as ASTNODE ptr, _
					   		    			  modeTB() as integer ) as FBSYMBOL ptr

declare function 	symbLookupUDTVar		( byval symbol as string, _
											  byval dotpos as integer ) as FBSYMBOL ptr

declare function 	symbLookupUDTElm		( byval symbol as string, _
											  byval dotpos as integer, _
											  suffix as integer, _
											  ofs as integer, _
					       					  elm as FBSYMBOL ptr, _
					       					  subtype as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbLookupProcResult	( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare	function 	symbGetGlobalHead 		( ) as FBSYMBOL ptr

declare	function 	symbGetLocalHead 		( ) as FBSYMBOL ptr

declare function 	symbGetVarText			( byval s as FBSYMBOL ptr ) as string

declare function 	symbGetVarDescName		( byval s as FBSYMBOL ptr ) as string

declare function 	symbGetProcLib			( byval p as FBSYMBOL ptr ) as string

declare function 	symbGetUDTElmOffset		( elm as FBSYMBOL ptr, _
											  typ as integer, _
											  subtype as FBSYMBOL ptr, _
											  byval fields as string ) as integer

declare function 	symbGetProcPrevArg		( byval f as FBSYMBOL ptr, _
											  byval a as FBSYMBOL ptr, _
											  byval checkconv as integer = TRUE ) as FBSYMBOL ptr

declare function 	symbGetProcNextArg		( byval f as FBSYMBOL ptr, _
											  byval a as FBSYMBOL ptr, _
											  byval checkconv as integer = TRUE ) as FBSYMBOL ptr

declare function 	symbGetUDTLen			( byval udt as FBSYMBOL ptr, _
											  byval realsize as integer = TRUE ) as integer

declare function 	symbCalcArgLen			( byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval mode as integer ) as integer

declare function 	symbListLibs			( namelist() as string, _
											  byval index as integer ) as integer

declare function 	symbAddKeyword			( byval symbol as string, byval id as integer, byval class as integer ) as FBSYMBOL ptr

declare function 	symbAddDefine			( byval symbol as string, _
											  byval text as string, _
											  byval lgt as integer, _
											  byval args as integer = 0, _
											  byval arghead as FBDEFARG ptr = NULL, _
											  byval isargless as integer = FALSE, _
											  byval proc as function( ) as string = NULL, _
                                              byval flags as integer = 0) as FBSYMBOL ptr

declare function 	symbAddDefineArg		( byval lastarg as FBDEFARG ptr, _
											  byval symbol as string ) as FBDEFARG ptr

declare function 	symbAddFwdRef			( byval symbol as string ) as FBSYMBOL ptr

declare function 	symbAddTypedef			( byval symbol as string, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
						 					  byval ptrcnt as integer, _
						 					  byval lgt as integer ) as FBSYMBOL ptr

declare function 	symbAddLabel			( byval symbol as string, _
											  byval declaring as integer = TRUE, _
											  byval createalias as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbAddVar				( byval symbol as string, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
					  						  byval ptrcnt as integer, _
					  						  byval dimensions as integer, _
					  						  dTB() as FBARRAYDIM, _
				      						  byval alloctype as integer ) as FBSYMBOL ptr

declare function 	symbAddVarEx			( byval symbol as string, _
											  byval aliasname as string, _
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

declare function 	symbAddConst			( byval symbol as string, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval text as string, _
											  byval lgt as integer ) as FBSYMBOL ptr

declare function 	symbAddUDT				( byval symbol as string, _
											  byval isunion as integer, _
											  byval align as integer ) as FBSYMBOL ptr

declare function 	symbAddUDTElement		( byval t as FBSYMBOL ptr, _
											  byval id as string, _
											  byval dimensions as integer, _
											  dTB() as FBARRAYDIM, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, _
											  byval lgt as integer, _
											  byval bits as integer, _
											  byval isinnerunion as integer ) as FBSYMBOL ptr

declare function 	symbAddEnum				( byval symbol as string ) as FBSYMBOL ptr

declare function 	symbAddEnumElement		( byval symbol as string, _
					         				  byval parent as FBSYMBOL ptr, _
					         				  byval value as integer ) as FBSYMBOL ptr

declare function 	symbAddArg				( byval symbol as string, _
											  byval tail as FBSYMBOL ptr, _
					 						  byval typ as integer, _
					 						  byval subtype as FBSYMBOL ptr, _
					 						  byval ptrcnt as integer, _
					 						  byval lgt as integer, _
					 						  byval mode as integer, _
					 						  byval suffix as integer, _
					 						  byval optional as integer, _
					 						  byval optval as FBVALUE ptr ) as FBSYMBOL ptr

declare function 	symbAddPrototype		( byval symbol as string, _
											  byval aliasname as string, _
											  byval libname as string, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, _
											  byval alloctype as integer, _
											  byval mode as integer, _
											  byval argc as integer, _
											  byval argtail as FBSYMBOL ptr, _
											  byval isexternal as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbAddProc				( byval symbol as string, _
											  byval aliasname as string, _
											  byval libname as string, _
					  						  byval typ as integer, _
					  						  byval subtype as FBSYMBOL ptr, _
					  						  byval ptrcnt as integer, _
					  						  byval alloctype as integer, _
					  						  byval mode as integer, _
					  						  byval argc as integer, _
					  						  byval argtail as FBSYMBOL ptr, _
					  						  byval domangle as integer = TRUE, _
					  						  byval ismain as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbAddProcResult		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddProcResArg		( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddLib				( byval libname as string ) as FBLIBRARY ptr

declare function 	symbAddArgAsVar			( byval symbol as string, _
											  byval arg as FBSYMBOL ptr ) as FBSYMBOL ptr

declare sub 		symbRoundUDTSize		( byval t as FBSYMBOL ptr )

declare sub 		symbRecalcUDTSize		( byval t as FBSYMBOL ptr )

declare function 	symbGetLastLabel 		( ) as FBSYMBOL ptr

declare sub 		symbSetLastLabel		( byval l as FBSYMBOL ptr )

declare sub 		symbSetArrayDims		( byval s as FBSYMBOL ptr, _
					  						  byval dimensions as integer, _
					  						  dTB() as FBARRAYDIM )

declare sub 		symbSetLocalTb			( byval tb as FBSYMBOLTB ptr )

declare sub 		symbFreeLocalDynVars	( byval proc as FBSYMBOL ptr, _
											  byval issub as integer )

declare sub 		symbDelLocalTb			( byval hashonly as integer )

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

declare function 	hAllocNumericConst		( byval sname as string, _
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

''
'' getters and setters as macros
''

#define symbGetAccessCnt(s) s->acccnt

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

#define symbGetAllocType(s) s->alloctype

#define symbSetAllocType(s,t) s->alloctype = t

#define symbGetDefineText(d) d->def.text

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

#define symbGetConstText(c) c->con.text

#define symbGetUDTFirstElm(s) s->udt.head

#define symbGetUDTNextElm(e) e->var.elm.next

#define symbGetUDTElmBitOfs(e) (e->var.elm.ofs * 8 + e->var.elm.bitpos)

#define symbGetUDTElmBitLen(e) iif( e->var.elm.bits <> 0, e->var.elm.bits, e->lgt * e->var.array.elms * 8 )

#define symbGetENUMFirstElm(s) s->enum.head

#define symbGetENUMNextElm(e) e->con.eelm.nxt

#define symbGetLabelIsDeclared(l) l->lbl.declared

#define symbGetProcIsDeclared(f) f->proc.isdeclared

#define symbSetProcIsDeclared(f,d) f->proc.isdeclared = d

#define symbGetProcFirstArg(f) iif( f->proc.mode = FB_FUNCMODE_PASCAL, f->proc.arghead, f->proc.argtail )

#define symbGetProcLastArg(f) iif( f->proc.mode = FB_FUNCMODE_PASCAL, f->proc.argtail, f->proc.arghead )

#define symbGetProcHeadArg(f) f->proc.arghead

#define symbGetProcTailArg(f) f->proc.argtail

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

#define symbGetArgMode(f,a) iif( a = NULL, INVALID, a->arg.mode )

#define symbGetArgSuffix(f,a) iif( a = NULL, INVALID, a->arg.suffix )

#define symbGetArgOptional(f,a) a->arg.optional

#define symbGetArgOptvalI(f,a) a->arg.optval.valuei

#define symbGetArgOptvalF(f,a) a->arg.optval.valuef

#define symbGetArgOptval64(f,a) a->arg.optval.value64

#define symbGetArgOptvalStr(f,a) a->arg.optval.valuestr

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

#define symbIsPublic(s) ((s->alloctype and FB_ALLOCTYPE_PUBLIC) > 0)

#define symbIsPrivate(s) ((s->alloctype and FB_ALLOCTYPE_PRIVATE) > 0)

#define symbIsExtern(s) ((s->alloctype and FB_ALLOCTYPE_EXTERN) > 0)

#define symbIsExport(s) ((s->alloctype and FB_ALLOCTYPE_EXPORT) > 0)

#define symbIsImport(s) ((s->alloctype and FB_ALLOCTYPE_IMPORT) > 0)

#define symbIsOverloaded(s) ((s->alloctype and FB_ALLOCTYPE_OVERLOADED) > 0)

#define symbIsJumpTb(s) ((s->alloctype and FB_ALLOCTYPE_JUMPTB) > 0)

#define symbIsMainProc(s) ((s->alloctype and FB_ALLOCTYPE_MAINPROC) > 0)


#define hIsString(t) ((t = IR_DATATYPE_STRING) or (t = IR_DATATYPE_FIXSTR) or (t = IR_DATATYPE_CHAR))



