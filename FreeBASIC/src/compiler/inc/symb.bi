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

declare function 	symbLookupUDTVar		( byval symbol as string, _
											  byval dotpos as integer, _
											  suffix as integer, _
											  ofs as integer, _
					       					  elm as FBSYMBOL ptr, _
					       					  subtype as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbLookupProcResult	( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare	function 	symbGetFirstNode 		( ) as FBSYMBOL ptr

declare	function 	symbGetNextNode			( byval n as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbGetVarText			( byval s as FBSYMBOL ptr ) as string

declare function 	symbGetVarDscName		( byval s as FBSYMBOL ptr ) as string

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
											  byval args as integer = 0, _
											  byval arghead as FBDEFARG ptr = NULL, _
											  byval isargless as integer = FALSE, _
											  byval proc as function( ) as string = NULL ) as FBSYMBOL ptr

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
					  						  byval argtail as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddProcResult		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddLib				( byval libname as string ) as FBLIBRARY ptr

declare function 	symbAddArgAsVar			( byval symbol as string, _
											  byval arg as FBSYMBOL ptr ) as FBSYMBOL ptr

declare sub 		symbRoundUDTSize		( byval t as FBSYMBOL ptr )

declare sub 		symbRecalcUDTSize		( byval t as FBSYMBOL ptr )

declare function 	symbGetLastLabel 		( ) as FBSYMBOL ptr

declare sub 		symbSetLastLabel		( byval l as FBSYMBOL ptr )

declare sub 		symbFreeLocalDynSymbols	( byval proc as FBSYMBOL ptr, _
											  byval issub as integer )

declare sub 		symbDelLocalSymbols		( )

declare function 	symbDelKeyword			( byval s as FBSYMBOL ptr ) as integer

declare function 	symbDelDefine			( byval s as FBSYMBOL ptr ) as integer

declare sub 		symbDelLabel			( byval s as FBSYMBOL ptr )

declare sub 		symbDelVar				( byval s as FBSYMBOL ptr )

declare sub 		symbDelPrototype		( byval s as FBSYMBOL ptr )

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

declare function 	symbCheckLabels 		( ) as FBSYMBOL ptr

declare function 	symbCheckBitField		( byval udt as FBSYMBOL ptr, _
											  byval typ as integer, _
											  byval bits as integer ) as integer


''
'' getters and setters as macros
''

#define symbGetAccessCnt(s) s->acccnt

#define symbGetLen(s) s->lgt

#define symbGetType(s) s->typ

#define symbGetSubType(s) s->subtype

#define symbGetClass(s) s->class

#define symbGetAllocType(s) s->alloctype

#define symbSetAllocType(s,t) s->alloctype = t

#define symbGetDefineText(d) d->def.text

#define symbGetDefineLen(d) len( d->def.text )

#define symbGetVarInitialized(s) s->var.initialized

#define symbGetArrayDiff(s) s->var.array.dif

#define symbGetArrayDimensions(s) s->var.array.dims

#define symbSetArrayDimensions(s,d) s->var.array.dims = d

#define symbGetArrayDescriptor(s) s->var.array.desc

#define symbGetProcArgs(f) f->proc.args

#define symbGetArrayFirstDim(s) s->var.array.dimhead

#define symbGetFuncMode(f) f->proc.mode

#define symbGetOrgName(s) s->hashitem->name

#define symbGetName(s) s->alias

#define symbGetVarOfs(s) s->ofs

#define symbGetConstText(c) c->con.text

#define symbGetLabelIsDeclared(l) l->lbl.declared

#define symbGetProcIsDeclared(f) f->proc.isdeclared

#define symbSetProcIsDeclared(f,d) f->proc.isdeclared = d

#define symbGetProcFirstArg(f) iif( f->proc.mode = FB.FUNCMODE.PASCAL, f->proc.arghead, f->proc.argtail )

#define symbGetProcLastArg(f) iif( f->proc.mode = FB.FUNCMODE.PASCAL, f->proc.argtail, f->proc.arghead )

#define symbGetProcHeadArg(f) f->proc.arghead

#define symbGetProcTailArg(f) f->proc.argtail

#define symbGetArgMode(f,a) iif( a = NULL, INVALID, a->arg.mode )

#define symbGetArgSuffix(f,a) iif( a = NULL, INVALID, a->arg.suffix )

#define symbGetArgOptional(f,a) a->arg.optional

#define symbGetArgOptval(f,a) a->arg.optval.value

#define symbGetArgOptval64(f,a) a->arg.optval.value64

#define symbGetArgOptvalStr(f,a) a->arg.optval.valuestr

#define symbGetIsDynamic(s) iif( s->class = FB.SYMBCLASS.UDTELM, FALSE, (s->alloctype and (FB.ALLOCTYPE.DYNAMIC or FB.ALLOCTYPE.ARGUMENTBYDESC)) > 0 )

#define symbIsArray(s) iif( (s->alloctype and (FB.ALLOCTYPE.DYNAMIC or FB.ALLOCTYPE.ARGUMENTBYDESC)) > 0, TRUE, s->var.array.dims > 0 )


#define hIsString(t) ((t = IR.DATATYPE.STRING) or (t = IR.DATATYPE.FIXSTR) or (t = IR.DATATYPE.CHAR))


declare function symbGetLen2(byval s as FBSYMBOL ptr) as integer


