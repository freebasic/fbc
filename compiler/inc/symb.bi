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

declare function 	symbLookupVar			( symbol as string, typ as integer, ofs as integer, _
											  elm as integer, typesymbol as integer ) as integer
declare function 	symbLookupVarEx			( symbol as string, typ as integer, ofs as integer, _
											  elm as integer, typesymbol as integer, _
											  byval addsuffix as integer, byval preservecase as integer, _
											  byval clearname as integer ) as integer
declare function 	symbLookupProc			( id as string ) as integer
declare function 	symbLookupLabel			( label as string ) as integer
declare function 	symbLookupConst			( constname as string, byval typ as integer ) as integer
declare function 	symbLookupUDT			( typename as string, lgt as integer ) as integer
declare function 	symbLookupEnum			( id as string ) as integer
declare function 	symbLookupKeyword		( kname as string, class as integer, typ as integer ) as integer
declare function 	symbLookupFunctionResult( byval f as integer ) as integer

declare function 	symbGetLabelName		( byval l as integer ) as string
declare function 	symbGetLabelScope		( byval l as integer ) as integer
declare function 	symbGetLabelIsDeclared	( byval l as integer ) as integer

declare	function 	symbGetFirstNode 		( ) as integer
declare	function 	symbGetNextNode			( byval n as integer ) as integer

declare function 	symbGetVarName			( byval s as integer ) as string
declare function 	symbGetVarText			( byval s as integer ) as string
declare function 	symbGetVarDscName		( byval s as integer ) as string
declare function 	symbGetConstName		( byval c as integer ) as string
declare function 	symbGetProcName			( byval p as integer ) as string
declare function 	symbGetProcLib			( byval p as integer ) as string
declare function 	symbGetConstText		( byval c as integer ) as string
declare function 	symbGetUDTElmOffset		( elm as integer, typesymbol as integer, typ as integer, id as string ) as integer
declare function 	symbGetArgName			( byval f as integer, byval a as integer ) as string
declare function 	symbGetArgType			( byval f as integer, byval a as integer ) as integer
declare function 	symbGetArgSubtype		( byval f as integer, byval a as integer ) as integer
declare function 	symbGetArgDataType		( byval f as integer, byval a as integer ) as integer
declare function 	symbGetArgMode			( byval f as integer, byval a as integer ) as integer
declare function 	symbGetArgSuffix		( byval f as integer, byval a as integer ) as integer
declare function 	symbGetArgsLen			( byval f as integer ) as integer
declare function 	symbGetArgOptional		( byval f as integer, byval a as integer ) as integer
declare function 	symbGetArgDefvalue		( byval f as integer, byval a as integer ) as double
declare function 	symbGetFuncMode			( byval f as integer ) as integer
declare function 	symbGetFuncDataType		( byval f as integer ) as integer

declare function 	symbGetFirstVarDim		( byval s as integer ) as integer
declare function 	symbGetNextVarDim		( byval s as integer, byval d as integer ) as integer
declare sub 		symbGetVarDims			( byval s as integer, byval d as integer, lb as long, ub as long )

declare function 	symbGetLen				( byval s as integer ) as integer
declare function 	symbGetType				( byval s as integer ) as integer
declare function 	symbGetSubType			( byval s as integer ) as integer
declare function 	symbGetAllocType		( byval s as integer ) as integer
declare function 	symbGetClass			( byval s as integer ) as integer
declare function 	symbGetInitialized		( byval s as integer ) as integer
declare function 	symbGetVarIsDynamic		( byval s as integer ) as integer
declare function 	symbGetVarDiff			( byval s as integer ) as long
declare function 	symbGetVarDimensions	( byval s as integer ) as integer
declare function 	symbGetVarDescriptor	( byval s as integer ) as integer
declare function 	symbGetVarDesc			( byval s as integer ) as integer
declare function 	symbGetProcIsDeclared	( byval f as integer ) as integer
declare function 	symbGetProcArgs			( byval p as integer ) as integer
declare function 	symbGetProcFirstArg		( byval f as integer ) as integer
declare function 	symbGetProcLastArg		( byval f as integer ) as integer
declare function 	symbGetProcPrevArg		( byval f as integer, byval a as integer ) as integer
declare function 	symbGetProcNextArg		( byval f as integer, byval a as integer ) as integer
declare function 	symbGetProcTailArg		( byval f as integer ) as integer
declare function 	symbGetName				( byval s as integer ) as string
declare function 	symbGetAlias			( byval s as integer ) as string

declare function 	symbGetUDTElmDiff		( byval t as integer ) as long
declare sub 		symbGetUDTElmDims		( byval t as integer, byval d as integer, lb as long, ub as long )
declare function 	symbGetFirstUDTElmDim	( byval t as integer ) as integer
declare function 	symbGetNextUDTElmDim	( byval t as integer, byval d as integer ) as integer
declare function 	symbGetUDTElmDimensions	( byval t as integer ) as integer
declare function 	symbGetUDTElmLen		( byval t as integer ) as integer
declare function 	symbGetUDTElmName		( byval t as integer ) as string
declare function 	symbGetUDTElmSubType	( byval t as integer ) as integer

declare function 	symbCalcArgsLen			( byval f as integer, byval args as integer ) as integer
declare function 	symbListLibs			( namelist() as string, byval index as integer ) as integer

declare sub 		symbSetArgType			( byval f as integer, byval a as integer, byval typ as integer )
declare sub 		symbSetArgSubType		( byval f as integer, byval a as integer, byval subtype as integer )
declare sub 		symbSetArgName			( byval f as integer, byval a as integer, byval nameidx as integer )
declare sub 		symbSetVarDimensions	( byval s as integer, byval dims as integer )

declare function 	symbIsProc				( id as string ) as integer
declare function 	symbIsConst				( constname as string ) as integer

declare function 	symbAddLabel			( label as string ) as integer
declare function 	symbAddLabelEx			( label as string, byval declaring as integer ) as integer
declare function 	symbAddVar				( symbol as string, byval typ as integer, byval subtype as integer, _
					  						  byval dimensions as integer, dTB() as FBARRAYDIM, _
				      						  byval alloctype as integer ) as integer
declare function 	symbAddVarEx			( symbol as string, aliasname as string, byval typ as integer, byval subtype as integer, _
											  byval lgt as integer, byval dimensions as integer, dTB() as FBARRAYDIM, _
				       						  byval alloctype as integer, _
				       						  byval addsuffix as integer, byval preservecase as integer, _
				       						  byval clearname as integer ) as integer
declare function 	symbAddTempVar			( byval typ as integer ) as integer
declare function 	symbAddConst			( id as string, byval typ as integer, text as string ) as integer
declare function 	symbAddUDT				( id as string, byval isunion as integer, byval align as integer ) as integer
declare function 	symbAddUDTElement		( byval t as integer, id as string, _
											  byval dimensions as integer, dTB() as FBARRAYDIM, _
											  byval typ as integer, byval subtype as integer, byval lgt as integer, _
											  byval isinnerunion as integer ) as integer
declare function 	symbAddEnum				( id as string ) as integer
declare function 	symbAddProc				( id as string, aliasname as string, libname as string, _
											  byval typ as integer, byval mode as integer, _
											  byval args as integer, argv() as FBPROCARG, _
											  byval declaring as integer ) as integer
declare function 	symbAddProcResult		( byval f as integer ) as integer
declare function 	symbAddLib				( libname as string ) as integer

declare sub 		symbRoundUDTSize		( byval t as integer )
declare sub 		symbRecalcUDTSize		( byval t as integer )

declare function 	symbGetLastLabel 		( ) as integer
declare sub 		symbSetLastLabel		( byval l as integer )

declare sub 		symbFreeLocalDynSymbols	( byval proc as integer, byval issub as integer )
declare sub 		symbDelLocalSymbols		( )

declare sub 		symbDelLabel			( byval l as integer )

declare function 	symbCalcLen				( byval typ as integer, byval subtype as integer ) as integer

declare function 	symbIsArray				( byval s as integer ) as integer
declare function 	symbIsString			( byval s as integer ) as integer
declare function 	hIsString				( byval dtype as integer ) as integer

declare function 	hAllocFloatConst		( sname as string, byval typ as integer ) as integer
declare function 	hAllocStringConst		( sname as string ) as integer

declare function 	hCalcElements 			( byval s as integer ) as long
declare function 	hStyp2Dtype				( byval typ as integer ) as integer
declare function 	hDtype2Stype			( byval dtype as integer ) as integer

declare function 	hIsStrFixed				( byval dtype as integer ) as integer

declare function 	symbCheckLabels 		( ) as integer
