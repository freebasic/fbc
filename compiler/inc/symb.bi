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

declare function 	symbLookupSentinel		( id as string, byval class as integer, byval islocal as integer ) as FBSENTINEL ptr
declare function 	symbLookupDefine		( id as string ) as FBDEFINE ptr
declare function 	symbLookupVar			( symbol as string, typ as integer, ofs as integer, _
											  elm as FBTYPELEMENT ptr, typesymbol as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbLookupVarEx			( symbol as string, typ as integer, ofs as integer, _
											  elm as FBTYPELEMENT ptr, typesymbol as FBSYMBOL ptr, _
											  byval addsuffix as integer, byval preservecase as integer, _
											  byval clearname as integer ) as FBSYMBOL ptr
declare function 	symbLookupProc			( id as string ) as FBSYMBOL ptr
declare function 	symbLookupLabel			( label as string ) as FBSYMBOL ptr
declare function 	symbLookupConst			( constname as string, byval typ as integer ) as FBSYMBOL ptr
declare function 	symbLookupUDT			( typename as string, lgt as integer ) as FBSYMBOL ptr
declare function 	symbLookupEnum			( id as string ) as FBSYMBOL ptr
declare function 	symbLookupKeyword		( kname as string, class as integer, typ as integer ) as integer
declare function 	symbLookupFunctionResult( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbGetLabelName		( byval l as FBSYMBOL ptr ) as string
declare function 	symbGetLabelScope		( byval l as FBSYMBOL ptr ) as integer
declare function 	symbGetLabelIsDeclared	( byval l as FBSYMBOL ptr ) as integer

declare	function 	symbGetFirstNode 		( ) as FBSYMBOL ptr
declare	function 	symbGetNextNode			( byval n as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbGetVarName			( byval s as FBSYMBOL ptr ) as string
declare function 	symbGetVarText			( byval s as FBSYMBOL ptr ) as string
declare function 	symbGetVarDscName		( byval s as FBSYMBOL ptr ) as string
declare function 	symbGetConstName		( byval c as FBSYMBOL ptr ) as string
declare function 	symbGetProcName			( byval p as FBSYMBOL ptr ) as string
declare function 	symbGetProcLib			( byval p as FBSYMBOL ptr ) as string
declare function 	symbGetConstText		( byval c as FBSYMBOL ptr ) as string
declare function 	symbGetUDTElmOffset		( elm as FBTYPELEMENT ptr, typesymbol as FBSYMBOL ptr, typ as integer, id as string ) as integer
declare function 	symbGetArgName			( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr ) as string
declare function 	symbGetArgType			( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr ) as integer
declare function 	symbGetArgSubtype		( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr ) as FBSYMBOL ptr
declare function 	symbGetArgDataType		( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr ) as integer
declare function 	symbGetArgMode			( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr ) as integer
declare function 	symbGetArgSuffix		( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr ) as integer
declare function 	symbGetArgsLen			( byval f as FBSYMBOL ptr ) as integer
declare function 	symbGetArgOptional		( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr ) as integer
declare function 	symbGetArgDefvalue		( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr ) as double
declare function 	symbGetFuncMode			( byval f as FBSYMBOL ptr ) as integer
declare function 	symbGetFuncDataType		( byval f as FBSYMBOL ptr ) as integer

declare function 	symbGetFirstVarDim		( byval s as FBSYMBOL ptr ) as FBVARDIM ptr
declare function 	symbGetNextVarDim		( byval s as FBSYMBOL ptr, byval d as FBVARDIM ptr ) as integer
declare sub 		symbGetVarDims			( byval s as FBSYMBOL ptr, byval d as FBVARDIM ptr, lb as integer, ub as integer )

declare function 	symbGetAccessCnt		( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetLen				( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetType				( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetSubType			( byval s as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbGetAllocType		( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetClass			( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetInitialized		( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetVarIsDynamic		( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetVarDiff			( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetVarDimensions	( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetVarDescriptor	( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetProcIsDeclared	( byval f as FBSYMBOL ptr ) as integer
declare function 	symbGetProcArgs			( byval p as FBSYMBOL ptr ) as integer
declare function 	symbGetProcFirstArg		( byval f as FBSYMBOL ptr ) as FBPROCARG ptr
declare function 	symbGetProcLastArg		( byval f as FBSYMBOL ptr ) as FBPROCARG ptr
declare function 	symbGetProcPrevArg		( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr, byval checkconv as integer = TRUE ) as FBPROCARG ptr
declare function 	symbGetProcNextArg		( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr, byval checkconv as integer = TRUE ) as FBPROCARG ptr
declare function 	symbGetProcHeadArg		( byval f as FBSYMBOL ptr ) as FBPROCARG ptr
declare function 	symbGetProcTailArg		( byval f as FBSYMBOL ptr ) as FBPROCARG ptr
declare function 	symbGetName				( byval s as FBSYMBOL ptr ) as string
declare function 	symbGetAlias			( byval s as FBSYMBOL ptr ) as string

declare function 	symbGetUDTLen			( byval s as FBSYMBOL ptr, byval realUDTsize as integer = TRUE ) as integer
declare function 	symbGetUDTElmType		( byval e as FBTYPELEMENT ptr ) as FBSYMBOL ptr
declare function 	symbGetUDTElmDiff		( byval e as FBTYPELEMENT ptr ) as integer
declare sub 		symbGetUDTElmDims		( byval e as FBTYPELEMENT ptr, byval d as FBVARDIM ptr, lb as integer, ub as integer )
declare function 	symbGetFirstUDTElmDim	( byval e as FBTYPELEMENT ptr ) as FBVARDIM ptr
declare function 	symbGetNextUDTElmDim	( byval e as FBTYPELEMENT ptr, byval d as FBVARDIM ptr ) as FBVARDIM ptr
declare function 	symbGetUDTElmDimensions	( byval e as FBTYPELEMENT ptr ) as integer
declare function 	symbGetUDTElmLen		( byval e as FBTYPELEMENT ptr ) as integer
declare function 	symbGetUDTElmName		( byval e as FBTYPELEMENT ptr ) as string
declare function 	symbGetUDTElmSubType	( byval e as FBTYPELEMENT ptr ) as FBSYMBOL ptr

declare function 	symbGetDefineText		( byval d as FBDEFINE ptr ) as string
declare function 	symbGetDefineLen		( byval d as FBDEFINE ptr ) as integer

declare function 	symbCalcArgsLen			( byval f as FBSYMBOL ptr, byval args as integer ) as integer
declare function 	symbCalcArgLen			( byval typ as integer, byval subtype as FBSYMBOL ptr, byval mode as integer ) as integer

declare function 	symbListLibs			( namelist() as string, byval index as integer ) as integer

declare sub 		symbSetArgMode			( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr, byval mode as integer )
declare sub 		symbSetArgType			( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr, byval typ as integer )
declare sub 		symbSetArgSubType		( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr, byval subtype as FBSYMBOL ptr )
declare sub 		symbSetArgName			( byval f as FBSYMBOL ptr, byval a as FBPROCARG ptr, byval nameidx as integer )
declare sub 		symbSetVarDimensions	( byval s as FBSYMBOL ptr, byval dims as integer )

declare function 	symbIsProc				( id as string ) as integer
declare function 	symbIsConst				( constname as string ) as integer

declare function 	symbAddDefine			( id as string, text as string ) as FBDEFINE ptr
declare function 	symbAddLabel			( label as string ) as FBSYMBOL ptr
declare function 	symbAddLabelEx			( label as string, byval declaring as integer, byval createalias as integer = FALSE ) as FBSYMBOL ptr
declare function 	symbAddVar				( symbol as string, byval typ as integer, byval subtype as FBSYMBOL ptr, _
					  						  byval dimensions as integer, dTB() as FBARRAYDIM, _
				      						  byval alloctype as integer ) as FBSYMBOL ptr
declare function 	symbAddVarEx			( symbol as string, aliasname as string, byval typ as integer, byval subtype as FBSYMBOL ptr, _
											  byval lgt as integer, byval dimensions as integer, dTB() as FBARRAYDIM, _
				       						  byval alloctype as integer, _
				       						  byval addsuffix as integer, byval preservecase as integer, _
				       						  byval clearname as integer ) as FBSYMBOL ptr
declare function 	symbAddTempVar			( byval typ as integer ) as FBSYMBOL ptr
declare function 	symbAddConst			( id as string, byval typ as integer, text as string, byval lgt as integer ) as FBSYMBOL ptr
declare function 	symbAddUDT				( id as string, byval isunion as integer, byval align as integer ) as FBSYMBOL ptr
declare function 	symbAddUDTElement		( byval t as FBSYMBOL ptr, id as string, _
											  byval dimensions as integer, dTB() as FBARRAYDIM, _
											  byval typ as integer, byval subtype as FBSYMBOL ptr, byval lgt as integer, _
											  byval isinnerunion as integer ) as FBTYPELEMENT ptr
declare function 	symbAddEnum				( id as string ) as FBSYMBOL ptr
declare function 	symbAddPrototype		( id as string, aliasname as string, libname as string, _
											  byval typ as integer, byval mode as integer, _
											  byval argc as integer, argv() as FBPROCARG, _
											  byval isexternal as integer ) as FBSYMBOL ptr
declare function 	symbAddProc				( id as string, aliasname as string, libname as string, _
					  						  byval typ as integer, byval mode as integer, _
					  						  byval argc as integer, argv() as FBPROCARG ) as FBSYMBOL ptr
declare function 	symbAddProcResult		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbAddLib				( libname as string ) as FBLIBRARY ptr
declare function 	symbAddArg				( byval f as FBSYMBOL ptr, byval arg as FBPROCARG ptr ) as FBSYMBOL ptr

declare sub 		symbRoundUDTSize		( byval t as FBSYMBOL ptr )
declare sub 		symbRecalcUDTSize		( byval t as FBSYMBOL ptr )

declare function 	symbGetLastLabel 		( ) as FBSYMBOL ptr
declare sub 		symbSetLastLabel		( byval l as FBSYMBOL ptr )

declare sub 		symbFreeLocalDynSymbols	( byval proc as FBSYMBOL ptr, byval issub as integer )
declare sub 		symbDelLocalSymbols		( )

declare function 	symbDelDefine			( id as string ) as integer
declare sub 		symbDelLabel			( byval l as FBSYMBOL ptr )
declare sub 		symbDelVar				( byval s as FBSYMBOL ptr )

declare function 	symbCalcLen				( byval typ as integer, byval subtype as FBSYMBOL ptr, _
											  byval realUDTlen as integer = FALSE ) as integer

declare function 	symbIsArray				( byval s as FBSYMBOL ptr ) as integer
declare function 	symbIsString			( byval s as FBSYMBOL ptr ) as integer
declare function 	hIsString				( byval dtype as integer ) as integer

declare function 	hAllocFloatConst		( sname as string, byval typ as integer ) as FBSYMBOL ptr
declare function 	hAllocStringConst		( sname as string, byval lgt as integer ) as FBSYMBOL ptr

declare function 	hCalcElements 			( byval s as FBSYMBOL ptr ) as integer
declare function 	hStyp2Dtype				( byval typ as integer ) as integer
declare function 	hDtype2Stype			( byval dtype as integer ) as integer

declare function 	hIsStrFixed				( byval dtype as integer ) as integer

declare function 	symbCheckLabels 		( ) as FBSYMBOL ptr
