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

declare function 	symbLookup				( symbname as string, id as integer, class as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr
declare function 	symbFindByClass			( byval s as FBSYMBOL ptr, byval class as integer ) as FBSYMBOL ptr
declare function 	symbFindBySuffix		( byval s as FBSYMBOL ptr, byval suffix as integer, _
						   					  byval deftyp as integer ) as FBSYMBOL ptr
declare function 	symbFindByNameAndClass	( symbol as string, byval class as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr
declare function 	symbFindByNameAndSuffix	( symbol as string, byval suffix as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbLookupUDTVar		( symbol as string, byval dotpos as integer, _
											  suffix as integer, ofs as integer, _
					       					  elm as FBSYMBOL ptr, subtype as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbLookupProcResult	( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbGetLabelIsDeclared	( byval l as FBSYMBOL ptr ) as integer

declare	function 	symbGetFirstNode 		( ) as FBSYMBOL ptr
declare	function 	symbGetNextNode			( byval n as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbGetVarOfs			( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetVarText			( byval s as FBSYMBOL ptr ) as string
declare function 	symbGetVarDscName		( byval s as FBSYMBOL ptr ) as string
declare function 	symbGetVarInitialized	( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetProcLib			( byval p as FBSYMBOL ptr ) as string
declare function 	symbGetConstText		( byval c as FBSYMBOL ptr ) as string
declare function 	symbGetUDTElmOffset		( elm as FBSYMBOL ptr, typ as integer, subtype as FBSYMBOL ptr, id as string ) as integer
declare function 	symbGetArgMode			( byval f as FBSYMBOL ptr, byval a as FBSYMBOL ptr ) as integer
declare function 	symbGetArgSuffix		( byval f as FBSYMBOL ptr, byval a as FBSYMBOL ptr ) as integer
declare function 	symbGetArgsLen			( byval f as FBSYMBOL ptr ) as integer
declare function 	symbGetArgOptional		( byval f as FBSYMBOL ptr, byval a as FBSYMBOL ptr ) as integer
declare function 	symbGetArgOptval		( byval f as FBSYMBOL ptr, byval a as FBSYMBOL ptr ) as double
declare function 	symbGetArgOptval64		( byval f as FBSYMBOL ptr, byval a as FBSYMBOL ptr ) as longint
declare function 	symbGetFuncMode			( byval f as FBSYMBOL ptr ) as integer
declare function 	symbGetFuncDataType		( byval f as FBSYMBOL ptr ) as integer

declare function 	symbGetArrayFirstDim	( byval s as FBSYMBOL ptr ) as FBVARDIM ptr

declare function 	symbGetName				( byval s as FBSYMBOL ptr ) as string
declare sub 		symbGetNameTo			( byval s as FBSYMBOL ptr, sname as string )
declare function 	symbGetOrgName			( byval s as FBSYMBOL ptr ) as string
declare function 	symbGetAccessCnt		( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetLen				( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetType				( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetSubType			( byval s as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbGetAllocType		( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetClass			( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetIsDynamic		( byval s as FBSYMBOL ptr ) as integer

declare function 	symbGetProcIsDeclared	( byval f as FBSYMBOL ptr ) as integer
declare function 	symbGetProcArgs			( byval p as FBSYMBOL ptr ) as integer
declare function 	symbGetProcFirstArg		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbGetProcLastArg		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbGetProcPrevArg		( byval f as FBSYMBOL ptr, byval a as FBSYMBOL ptr, byval checkconv as integer = TRUE ) as FBSYMBOL ptr
declare function 	symbGetProcNextArg		( byval f as FBSYMBOL ptr, byval a as FBSYMBOL ptr, byval checkconv as integer = TRUE ) as FBSYMBOL ptr
declare function 	symbGetProcHeadArg		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbGetProcTailArg		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbGetArrayDiff		( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetArrayDimensions	( byval s as FBSYMBOL ptr ) as integer
declare function 	symbGetArrayDescriptor	( byval s as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbGetUDTLen			( byval udt as FBSYMBOL ptr, byval realsize as integer = TRUE ) as integer

declare function 	symbGetDefineText		( byval d as FBSYMBOL ptr ) as string
declare function 	symbGetDefineLen		( byval d as FBSYMBOL ptr ) as integer

declare function 	symbCalcArgLen			( byval typ as integer, byval subtype as FBSYMBOL ptr, byval mode as integer ) as integer

declare function 	symbListLibs			( namelist() as string, byval index as integer ) as integer

declare sub 		symbSetArrayDimensions	( byval s as FBSYMBOL ptr, byval dims as integer )
declare sub 		symbSetAllocType		( byval s as FBSYMBOL ptr, byval alloctype as integer )
declare sub 		symbSetProcIsDeclared	( byval f as FBSYMBOL ptr, byval isdeclared as integer )

declare function 	symbAddKeyword			( symbol as string, byval id as integer, byval class as integer ) as FBSYMBOL ptr
declare function 	symbAddDefine			( symbol as string, text as string, _
											  byval args as integer = 0, byval arghead as FBDEFARG ptr = NULL ) as FBSYMBOL ptr
declare function 	symbAddDefineArg		( byval lastarg as FBDEFARG ptr, symbol as string ) as FBDEFARG ptr
declare function 	symbAddFwdRef			( symbol as string ) as FBSYMBOL ptr
declare function 	symbAddTypedef			( symbol as string, byval typ as integer, byval subtype as FBSYMBOL ptr, _
						 					  byval ptrcnt as integer, byval lgt as integer ) as FBSYMBOL ptr
declare function 	symbAddLabel			( symbol as string, byval declaring as integer = TRUE, _
											  byval createalias as integer = FALSE ) as FBSYMBOL ptr
declare function 	symbAddVar				( symbol as string, byval typ as integer, byval subtype as FBSYMBOL ptr, _
					  						  byval ptrcnt as integer, _
					  						  byval dimensions as integer, dTB() as FBARRAYDIM, _
				      						  byval alloctype as integer ) as FBSYMBOL ptr
declare function 	symbAddVarEx			( symbol as string, aliasname as string, _
											  byval typ as integer, byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, byval lgt as integer, _
											  byval dimensions as integer, dTB() as FBARRAYDIM, _
				       						  byval alloctype as integer, _
				       						  byval addsuffix as integer, byval preservecase as integer, _
				       						  byval clearname as integer ) as FBSYMBOL ptr
declare function 	symbAddTempVar			( byval typ as integer ) as FBSYMBOL ptr
declare function 	symbAddConst			( symbol as string, byval typ as integer, text as string, byval lgt as integer ) as FBSYMBOL ptr
declare function 	symbAddUDT				( symbol as string, byval isunion as integer, byval align as integer ) as FBSYMBOL ptr
declare function 	symbAddUDTElement		( byval t as FBSYMBOL ptr, id as string, _
											  byval dimensions as integer, dTB() as FBARRAYDIM, _
											  byval typ as integer, byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, byval lgt as integer, _
											  byval isinnerunion as integer ) as FBSYMBOL ptr
declare function 	symbAddEnum				( symbol as string ) as FBSYMBOL ptr
declare function 	symbAddArg				( symbol as string, byval tail as FBSYMBOL ptr, _
					 						  byval typ as integer, byval subtype as FBSYMBOL ptr, _
					 						  byval ptrcnt as integer, byval lgt as integer, _
					 						  byval mode as integer, byval suffix as integer, _
					 						  byval optional as integer, byval optval as FBVALUE ptr ) as FBSYMBOL ptr
declare function 	symbAddPrototype		( symbol as string, aliasname as string, libname as string, _
											  byval typ as integer, byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, byval alloctype as integer, _
											  byval mode as integer, byval argc as integer, byval argtail as FBSYMBOL ptr, _
											  byval isexternal as integer, byval preservecase as integer = FALSE ) as FBSYMBOL ptr
declare function 	symbAddProc				( symbol as string, aliasname as string, libname as string, _
					  						  byval typ as integer, byval subtype as FBSYMBOL ptr, _
					  						  byval ptrcnt as integer, byval alloctype as integer, _
					  						  byval mode as integer, byval argc as integer, byval argtail as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbAddProcResult		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr
declare function 	symbAddLib				( libname as string ) as FBLIBRARY ptr
declare function 	symbAddArgAsVar			( symbol as string, byval arg as FBSYMBOL ptr ) as FBSYMBOL ptr

declare sub 		symbRoundUDTSize		( byval t as FBSYMBOL ptr )
declare sub 		symbRecalcUDTSize		( byval t as FBSYMBOL ptr )

declare function 	symbGetLastLabel 		( ) as FBSYMBOL ptr
declare sub 		symbSetLastLabel		( byval l as FBSYMBOL ptr )

declare sub 		symbFreeLocalDynSymbols	( byval proc as FBSYMBOL ptr, byval issub as integer )
declare sub 		symbDelLocalSymbols		( )

declare function 	symbDelKeyword			( byval s as FBSYMBOL ptr ) as integer
declare function 	symbDelDefine			( byval s as FBSYMBOL ptr ) as integer
declare sub 		symbDelLabel			( byval s as FBSYMBOL ptr )
declare sub 		symbDelVar				( byval s as FBSYMBOL ptr )
declare sub 		symbDelPrototype		( byval s as FBSYMBOL ptr )
declare sub 		symbDelLib				( byval l as FBLIBRARY ptr )

declare function 	symbCalcLen				( byval typ as integer, byval subtype as FBSYMBOL ptr, _
											  byval realsize as integer = FALSE ) as integer

declare function 	symbIsArray				( byval s as FBSYMBOL ptr ) as integer
declare function 	symbIsString			( byval s as FBSYMBOL ptr ) as integer
declare function 	hIsString				( byval dtype as integer ) as integer

declare function 	hAllocNumericConst		( sname as string, byval typ as integer ) as FBSYMBOL ptr
declare function 	hAllocStringConst		( sname as string, byval lgt as integer ) as FBSYMBOL ptr

declare function 	hCalcElements 			( byval s as FBSYMBOL ptr ) as integer

declare function 	hIsStrFixed				( byval dtype as integer ) as integer

declare function 	symbCheckLabels 		( ) as FBSYMBOL ptr
