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


'' symbol table module for variables (scalars and arrays)
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"
#include once "inc\emit.bi"

type FB_SYMVAR_CTX
	array_dimtype		as FBSYMBOL ptr
end type

declare function 	hCalcArrayElements	( _
											byval dimensions as integer, _
									  	  	dTB() as FBARRAYDIM _
									  	) as integer

declare sub 		hDelVarDims			( _
											byval s as FBSYMBOL ptr _
										)

declare sub 		hCreateDescDimType  ( _
											_
										)

'' globals
	dim shared as FB_SYMVAR_CTX ctx

'':::::
sub symbVarInit( )

	listNew( @symb.dimlist, FB_INITDIMNODES, len( FBVARDIM ), LIST_FLAGS_NOCLEAR )

	'' assuming it's safe to create UDT symbols here, the array
	'' dimension type must be allocated at module-level or it
	'' would be removed when going out scope
	hCreateDescDimType( )

end sub

'':::::
sub symbVarEnd( )

	listFree( @symb.dimlist )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hCreateDescDimType _
	( _
		_
	) static

	static as FBARRAYDIM dTB(0)

   	''
   	ctx.array_dimtype = symbAddUDT( NULL, NULL, NULL, FALSE, 0 )

	'' elements		as integer
	symbAddUDTElement( ctx.array_dimtype, _
				   	   NULL, _
				   	   0, dTB(), _
				   	   FB_DATATYPE_INTEGER, NULL, 0, _
				   	   FB_INTEGERSIZE, 0 )

	'' lbound		as integer
	symbAddUDTElement( ctx.array_dimtype, _
				   	   NULL, _
				   	   0, dTB(), _
				   	   FB_DATATYPE_INTEGER, NULL, 0, _
				   	   FB_INTEGERSIZE, 0 )

	'' ubound		as integer
	symbAddUDTElement( ctx.array_dimtype, _
				   	   NULL, _
				   	   0, dTB(), _
				   	   FB_DATATYPE_INTEGER, NULL, 0, _
				   	   FB_INTEGERSIZE, 0 )

    ''
	symbRoundUDTSize( ctx.array_dimtype )

end sub

'':::::
private function hCreateDescType _
	( _
		byval dims as integer _
	) as FBSYMBOL ptr static

	static as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr sym, dimtype

    ''
    sym = symbAddUDT( NULL, NULL, NULL, FALSE, 0 )

    '' data			as any ptr
	symbAddUDTElement( sym, _
					   NULL, _
					   0, dTB(), _
					   FB_DATATYPE_POINTER+FB_DATATYPE_VOID, NULL, 1, _
					   FB_POINTERSIZE, 0 )

	'' ptr			as any ptr
	symbAddUDTElement( sym, _
					   NULL, _
					   0, dTB(), _
					   FB_DATATYPE_POINTER+FB_DATATYPE_VOID, NULL, 1, _
					   FB_POINTERSIZE, 0 )

    '' size			as integer
	symbAddUDTElement( sym, _
					   NULL, _
					   0, dTB(), _
					   FB_DATATYPE_INTEGER, NULL, 0, _
					   FB_INTEGERSIZE, 0 )

    '' element_len	as integer
	symbAddUDTElement( sym, _
					   NULL, _
					   0, dTB(), _
					   FB_DATATYPE_INTEGER, NULL, 0, _
					   FB_INTEGERSIZE, 0 )

    '' dimensions	as integer
	symbAddUDTElement( sym, _
					   NULL, _
					   0, dTB(), _
					   FB_DATATYPE_INTEGER, NULL, 0, _
					   FB_INTEGERSIZE, 0 )


	if( dims = -1 ) then
		dims = FB_MAXARRAYDIMS
	end if

    '' dimTB(0 to dims-1) as FBARRAYDIM
	dTB(0).lower = 0
	dTB(0).upper = dims-1

	dimtype = ctx.array_dimtype

	symbAddUDTElement( sym, _
				   	   NULL, _
				   	   1, dTB(), _
					   FB_DATATYPE_USERDEF, dimtype, 0, _
					   symbGetLen( dimtype ), 0 )

	''
	symbRoundUDTSize( sym )

	function = sym

end function

'':::::
private function hCreateDescIniTree _
	( _
		byval desc as FBSYMBOL ptr, _
		byval array as FBSYMBOL ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr tree, array_expr
    dim as integer dtype, dims
    dim as FBSYMBOL ptr elm, dimtb, subtype

    '' COMMON?
    if( symbIsCommon( array ) ) then
    	return NULL
    end if

    ''
    tree = astTypeIniBegin( symbGetType( desc ), symbGetSubtype( desc ) )

    dtype = symbGetType( array )
    subtype = symbGetSubType( array )
    dims = symbGetArrayDimensions( array )

	'' unknown dimensions? use max..
	if( dims = -1 ) then
		dims = FB_MAXARRAYDIMS
	end if

	elm = symbGetUDTFirstElm( symbGetSubtype( desc ) )

    if( symbGetIsDynamic( array ) ) then
    	array_expr = astNewCONSTi( 0, FB_DATATYPE_POINTER+FB_DATATYPE_VOID )
    else
    	array_expr = astNewADDR( AST_OP_ADDROF, astNewVAR( array, 0, dtype, subtype ) )
    end if

    '' .data = @array(0) + diff
	astTypeIniAddExpr( tree, _
					   astNewBOP( AST_OP_ADD, _
								  astCloneTree( array_expr ), _
					   			  astNewCONSTi( symbGetArrayOffset( array ), _
					   			  				FB_DATATYPE_INTEGER ) ), _
					   elm )

	elm = symbGetUDTNextElm( elm )

	'' .ptr	= @array(0)
	astTypeIniAddExpr( tree, array_expr, elm )

    elm = symbGetUDTNextElm( elm )

    '' .size = len( array ) * elements( array )
    astTypeIniAddExpr( tree, _
    				   astNewCONSTi( symbGetLen( array ) * symbGetArrayElements( array ), _
    				   				 FB_DATATYPE_INTEGER ), _
    				   elm )

    elm = symbGetUDTNextElm( elm )

    '' .element_len	= len( array )
    astTypeIniAddExpr( tree, _
    				   astNewCONSTi( symbGetLen( array ), _
    				   				 FB_DATATYPE_INTEGER ), _
    				   elm )

    elm = symbGetUDTNextElm( elm )

    '' .dimensions = dims( array )
    astTypeIniAddExpr( tree, _
    				   astNewCONSTi( dims, _
    				   				 FB_DATATYPE_INTEGER ), _
    				   elm )

    elm = symbGetUDTNextElm( elm )

    '' setup dimTB
    dimtb = symbGetUDTFirstElm( symbGetSubtype( elm ) )

    '' static array?
    if( symbGetIsDynamic( array ) = FALSE ) then
    	dim as FBVARDIM ptr d

    	d = symbGetArrayFirstDim( array )
    	do while( d <> NULL )
			elm = dimtb

			'' .elements = (ubound( array, d ) - lbound( array, d )) + 1
    		astTypeIniAddExpr( tree, _
    				   		   astNewCONSTi( d->upper - d->lower + 1, _
    				   				 		 FB_DATATYPE_INTEGER ), _
    				   		   elm )

			elm = symbGetUDTNextElm( elm )

			'' .lbound = lbound( array, d )
    		astTypeIniAddExpr( tree, _
    				   		   astNewCONSTi( d->lower, _
    				   				 		 FB_DATATYPE_INTEGER ), _
    				   		   elm )

			elm = symbGetUDTNextElm( elm )

			'' .ubound = ubound( array, d )
    		astTypeIniAddExpr( tree, _
    				   		   astNewCONSTi( d->upper, _
    				   				 		 FB_DATATYPE_INTEGER ), _
    				   		   elm )

			d = d->next
    	loop

    '' dynamic..
    else
        '' just fill with 0's
        astTypeIniAddPad( tree, dims * len( FB_ARRAYDESCDIM ) )
    end if

    ''
    astTypeIniEnd( tree, TRUE )

    ''
    symbSetIsInitialized( desc )

    function = tree

end function

'':::::
private function hCreateArrayDesc _
	( _
		byval array as FBSYMBOL ptr, _
		byval dimensions as integer _
	) as FBSYMBOL ptr static

    dim as zstring ptr id, id_alias
    dim as FBSYMBOL ptr desc, desctype
    dim as integer isshared, isstatic, isdynamic, iscommon, ispubext

	function = NULL

    '' don't add if it's a jump table
    if( symbIsJumpTb( array ) ) then
    	exit function
    end if

	isshared = symbIsShared( array )
	isstatic = symbIsStatic( array )
	isdynamic = symbIsDynamic( array )
	iscommon = symbIsCommon( array )
	ispubext = (array->attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN)) <> 0

	'' common or public and dynamic? use the array name for the descriptor,
	'' as only it will be allocated or seen by other modules
	if( iscommon or (ispubext and isdynamic) ) then
		id = array->id.name
		id_alias = array->id.alias

	'' otherwise, create a temporary name..
	else
		id = hMakeTmpStr( FALSE )
		id_alias = NULL
	end if

	desctype = hCreateDescType( dimensions )

	desc = symbNewSymbol( NULL, _
					   	  array->symtb, NULL, symbIsLocal( array ) = FALSE, _
					   	  FB_SYMBCLASS_VAR, _
					   	  FALSE, id, id_alias, _
					   	  FB_DATATYPE_USERDEF, desctype, 0, _
					   	  TRUE )
    if( desc = NULL ) then
    	exit function
    end if

	''
	desc->lgt = symbGetLen( desctype )
	desc->ofs = 0

	desc->attrib = (array->attrib and _
				    (FB_SYMBATTRIB_SHARED or _
				     FB_SYMBATTRIB_COMMON or _
				     FB_SYMBATTRIB_STATIC or _
				     FB_SYMBATTRIB_EXTERN or _
				     FB_SYMBATTRIB_PUBLIC or _
				     FB_SYMBATTRIB_LOCAL)) or _
				   FB_SYMBATTRIB_DESCRIPTOR

	'' not dynamic?
	if( isdynamic = FALSE ) then
		'' extern? always emit the descriptor (if accessed),
		'' because the original one won't be accessible (or may don't
		'' exist, if it's a "C" extern array)
		if( symbIsExtern( array ) ) then
			desc->attrib and= not FB_SYMBATTRIB_EXTERN
		end if

		'' if not-dynamic, the descriptor can't be ever public
		desc->attrib and= not FB_SYMBATTRIB_PUBLIC
	end if

	desc->stats = array->stats and (FB_SYMBSTATS_ALLOCATED or _
									FB_SYMBSTATS_ACCESSED or _
									FB_SYMBSTATS_HASALIAS)

	'' as desc is also a var, clear the var fields
	desc->var.array.desc = NULL
	desc->var.array.dif = 0
	desc->var.array.dims = 0
	desc->var.array.dimhead = NULL
	desc->var.array.dimtail = NULL
	desc->var.array.elms = 1
    desc->var.suffix = INVALID
    desc->var.initree = hCreateDescIniTree( desc, array )

	''
	function = desc

end function

'':::::
function symbNewArrayDim _
	( _
		byval s as FBSYMBOL ptr, _
		byval lower as integer, _
		byval upper as integer _
	) as FBVARDIM ptr static

    dim as FBVARDIM ptr d, n

    function = NULL

    d = listNewNode( @symb.dimlist )
    if( d = NULL ) then
    	exit function
    end if

    d->lower = lower
    d->upper = upper

	n = s->var.array.dimtail
	if( n <> NULL ) then
		n->next = d
	else
		s->var.array.dimhead = d
	end if

	d->next = NULL
	s->var.array.dimtail = d

    function = d

end function

'':::::
sub symbSetArrayDimTb _
	( _
		byval s as FBSYMBOL ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	)

    dim as integer i
    dim as FBVARDIM ptr d

	if( dimensions > 0 ) then
		s->var.array.dif = symbCalcArrayDiff( dimensions, dTB(), s->lgt )

		if( (s->var.array.dimhead = NULL) or _
			(s->var.array.dims <> dimensions) ) then

            hDelVarDims( s )

			for i = 0 to dimensions-1
				if( symbNewArrayDim( s, dTB(i).lower, dTB(i).upper ) = NULL ) then
				end if
			next

		else
			d = s->var.array.dimhead
			for i = 0 to dimensions-1
				d->lower = dTB(i).lower
				d->upper = dTB(i).upper
				d = d->next
			next
		end if

		s->var.array.elms = symbCalcArrayElements( s )

	else
		s->var.array.dif = 0
		s->var.array.elms = 1
	end if

	s->var.array.dims = dimensions

	'' dims can be -1 with COMMON arrays..
	if( dimensions <> 0 ) then
		if( s->var.array.desc = NULL ) then
			s->var.array.desc = hCreateArrayDesc( s, dimensions )
		end if
	else
		s->var.array.desc = NULL
	end if

end sub

'':::::
private sub hSetupVar _
	( _
		byval s as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval attrib as integer, _
		byval stats as integer _
	) static

	if( dtype = INVALID ) then
		dtype = hGetDefType( id )
	end if

	''
	s->attrib or= attrib
	s->stats or= stats

	s->lgt = lgt
	s->ofs = 0

	'' array fields
	s->var.array.dimhead = NULL
	s->var.array.dimtail = NULL
	s->var.array.desc = NULL

	if( dimensions <> 0 ) then
		symbSetArrayDimTb( s, dimensions, dTB() )
	else
		s->var.array.dims = 0
		s->var.array.dif = 0
		s->var.array.elms = 1
	end if

	s->var.initree = NULL

	s->var.stmtnum = env.stmtcnt

end sub

'':::::
function symbAddVarEx _
	( _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval lgt as integer, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval attrib as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s
    dim as FBSYMBOLTB ptr symtb
    dim as FBHASHTB ptr hashtb
    dim as integer isglobal, suffix, stats

    function = NULL

    ''
    isglobal = (attrib and (FB_SYMBATTRIB_PUBLIC or _
			 				FB_SYMBATTRIB_EXTERN or _
			 				FB_SYMBATTRIB_SHARED or _
			 				FB_SYMBATTRIB_COMMON)) <> 0

	'' inside a namespace but outside a proc?
	if( symbIsGlobalNamespc() = FALSE ) then
		if( fbIsModLevel( ) ) then
			'' they are never allocated on stack..
			attrib or= FB_SYMBATTRIB_STATIC
		end if
	end if

    ''
    if( lgt <= 0 ) then
		if( dtype = INVALID ) then
			suffix = hGetDefType( id )
		else
			suffix = dtype
 		end if
    	lgt	= symbCalcLen( suffix, subtype )
    end if

    ''
    if( (options and FB_SYMBOPT_ADDSUFFIX) <> 0 ) then
    	suffix = dtype
    else
    	suffix = INVALID
    end if

    '' no explict alias?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( env.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    	stats = 0

    else
		stats = FB_SYMBSTATS_HASALIAS
	end if

	'' local? add to local symb & hash tbs
	if( isglobal = FALSE ) then
		'' QB quirk: implicit variables are moved to the function scope..
		if( (options and FB_SYMBOPT_UNSCOPE) = 0 ) then
			symtb = symb.symtb
		else
			symtb = @symbGetProcLocTb( env.currproc )
		end if

		hashtb = symb.hashtb

		'' can't add local static vars to global list because
		'' symbDelSymbolTb() will miss them when flushing the
		'' proc/scope block, and also because the the dbg info

	'' global..
	else
		'' inside a namespace and not a literal-constant?
		if( (symbIsGlobalNamespc( ) = FALSE) and _
			((attrib and FB_SYMBATTRIB_LITCONST) = 0) ) then

			symtb = @symbGetNamespaceTb( symb.namespc )
			hashtb = @symbGetNamespaceHashTb( symb.namespc )

		'' module-level..
		else
			symtb = @symbGetGlobalTb( )
			hashtb = @symbGetGlobalHashTb( )
		end if
	end if

	s = symbNewSymbol( NULL, _
					   symtb, hashtb, isglobal, _
					   FB_SYMBCLASS_VAR, _
					   TRUE, id, id_alias, _
					   dtype, subtype, ptrcnt, _
					   (options and FB_SYMBOPT_PRESERVECASE) <> 0, _
					   suffix )

	if( s = NULL ) then
		exit function
	end if

	''
	hSetupVar( s, id, dtype, subtype, lgt, dimensions, dTB(), attrib, stats )

	'' QB quirk: see the above
	if( (options and FB_SYMBOPT_UNSCOPE) <> 0 ) then
		if( (env.currproc->attrib and (FB_SYMBATTRIB_MAINPROC or _
									   FB_SYMBATTRIB_MODLEVELPROC)) <> 0 ) then
			s->scope = FB_MAINSCOPE
		else
			s->scope = env.currproc->scope + 1
		end if

		s->var.stmtnum = env.currproc->proc.ext->stmtnum + 1
	end if

	function = s

end function

'':::::
function symbAddVar _
	( _
		byval symbol as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval attrib as integer _
	) as FBSYMBOL ptr static

    function = symbAddVarEx( symbol, NULL, dtype, subtype, ptrcnt, _
    		  			     0, dimensions, dTB(), _
    						 attrib, _
    						 FB_SYMBOPT_ADDSUFFIX )

end function

'':::::
function symbAddTempVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval doalloc as integer, _
		byval checkstatic as integer _
	) as FBSYMBOL ptr static

	static as zstring * FB_MAXNAMELEN+1 id
	dim as integer attrib
    dim as FBSYMBOL ptr s
    dim as FBARRAYDIM dTB(0)

	id = *hMakeTmpStr( FALSE )

	attrib = FB_SYMBATTRIB_TEMP
	if( checkstatic ) then
		if( fbIsModLevel( ) = FALSE ) then
			if( symbIsStatic( env.currproc ) ) then
				attrib or= FB_SYMBATTRIB_STATIC
			end if
		end if
	end if

	s = symbAddVarEx( id, NULL, dtype, subtype, 0, _
					  0, 0, dTB(), _
					  attrib )
    if( s = NULL ) then
    	return NULL
    end if

	'' alloc? (should be used only by IR)
	if( doalloc ) then
    	'' not static?
    	if( (s->attrib and FB_SYMBATTRIB_STATIC) = 0 ) then

			s->ofs = emitAllocLocal( env.currproc, s->lgt )

		end if
	end if

    function = s

end function

'':::::
function symbAddTempVarEx _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval doalloc as integer, _
		byval checkstatic as integer _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr s
	dim as integer lgt

	s = symbAddTempVar( dtype, subtype, doalloc, checkstatic )

	'' not static?
	if( (symbGetAttrib( s ) and FB_SYMBATTRIB_STATIC) = 0 ) then

		lgt = 0

		select case dtype
		'' var-len string?
		case FB_DATATYPE_STRING
			lgt = FB_STRDESCLEN

		'' UDT with var-len string fields?
		case FB_DATATYPE_USERDEF
            if( symbGetUDTDynCnt( subtype ) <> 0 ) then
            	lgt = symbGetLen( s )
            end if

		end select

        if( lgt > 0 ) then
			'' clear memory
			astAdd( astNewMEM( AST_OP_MEMCLEAR, _
							   astNewVAR( s, 0, dtype, subtype ), _
							   NULL, _
							   lgt ) )
		end if
	end if

	function = s

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCalcArrayDiff _
	( _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval lgt as integer _
	) as integer

    dim as integer d, diff, elms, mult

	if( dimensions <= 0 ) then
		return 0
	end if

	diff = 0
	for d = 0 to (dimensions-1)-1
		elms = (dTB(d+1).upper - dTB(d+1).lower) + 1
		diff = (diff+dTB(d).lower) * elms
	next

	diff += dTB(dimensions-1).lower

	diff *= lgt

	function = -diff

end function

'':::::
function symbCalcArrayElements _
	( _
		byval s as FBSYMBOL ptr, _
		byval n as FBVARDIM ptr = NULL _
	) as integer static

    dim as integer e, d

	if( n = NULL ) then
		n = s->var.array.dimhead
	end if

	e = 1
	do while( n <> NULL )
		d = (n->upper - n->lower) + 1
		e = e * d
		n = n->next
	loop

	function = e

end function

'':::::
private function hCalcArrayElements _
	( _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	) as integer static

    dim as integer e, i, d

	e = 1
	for i = 0 to dimensions-1
		d = (dTB(i).upper - dTB(i).lower) + 1
		e = e * d
	next i

	function = e

end function

'':::::
function symbVarIsLocalDyn _
	( _
		byval s as FBSYMBOL ptr _
	) as integer static

    function = FALSE

    '' shared, static, param or temp?
    if( (s->attrib and (FB_SYMBATTRIB_SHARED or _
    					FB_SYMBATTRIB_STATIC or _
    					FB_SYMBATTRIB_COMMON or _
    					FB_SYMBATTRIB_PARAMBYDESC or _
    		  			FB_SYMBATTRIB_PARAMBYVAL or _
    		  			FB_SYMBATTRIB_PARAMBYREF or _
    		  			FB_SYMBATTRIB_TEMP or _
    		  			FB_SYMBATTRIB_FUNCRESULT)) <> 0 ) then
		exit function
	end if

	'' dyn string?
	if( s->typ = FB_DATATYPE_STRING ) then
		function = TRUE

	'' array? dims can be -1 with "DIM foo()" arrays..
	elseif( s->var.array.dims <> 0 ) then
		'' dynamic?
		function = symbIsDynamic( s )
	end if

end function

'':::::
function symbVarIsLocalObj _
	( _
		byval s as FBSYMBOL ptr _
	) as integer static

    '' shared, static, param or temp?
    if( (s->attrib and (FB_SYMBATTRIB_SHARED or _
    					FB_SYMBATTRIB_STATIC or _
    					FB_SYMBATTRIB_COMMON or _
    					FB_SYMBATTRIB_PARAMBYDESC or _
    		  			FB_SYMBATTRIB_PARAMBYVAL or _
    		  			FB_SYMBATTRIB_PARAMBYREF or _
    		  			FB_SYMBATTRIB_TEMP or _
    		  			FB_SYMBATTRIB_FUNCRESULT)) <> 0 ) then

		return FALSE
	end if

	'' dyn string?
	if( s->typ = FB_DATATYPE_STRING ) then
		function = TRUE

	else
		'' array? dims can be -1 with "DIM foo()" arrays..
		'' (note: it doesn't matter if it's dynamic array or not, local
		'' 		  non-dynamic array allocations will do calls to
		''        ArraySetDesc, so arrays can't be accessed before that)

		function = (s->var.array.dims <> 0)
	end if

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hDelVarDims _
	( _
		byval s as FBSYMBOL ptr _
	) static

    dim as FBVARDIM ptr n, nxt

    n = s->var.array.dimhead
    do while( n <> NULL )
    	nxt = n->next

    	listDelNode( @symb.dimlist, n )

    	n = nxt
    loop

    s->var.array.dimhead = NULL
    s->var.array.dimtail = NULL
    s->var.array.dims	  = 0

end sub

'':::::
sub symbDelVar _
	( _
		byval s as FBSYMBOL ptr _
	)

    if( s = NULL ) then
    	exit sub
    end if

    if( s->var.array.dims > 0 ) then
    	hDelVarDims( s )
    	'' del the array descriptor, recursively
    	symbDelVar( s->var.array.desc )
    end if

    if( symbGetIsLiteral( s ) ) then
    	s->attrib and= not FB_SYMBATTRIB_LITERAL

    	'' not a wchar literal?
    	if( s->typ <> FB_DATATYPE_WCHAR ) then
    		if( s->var.littext <> NULL ) then
    			ZstrFree( s->var.littext )
    		end if
    	else
    		if( s->var.littextw <> NULL ) then
    			WstrFree( s->var.littextw )
    		end if
    	end if

    ''
    elseif( symbGetIsInitialized( s ) ) then
    	s->stats and= not FB_SYMBSTATS_INITIALIZED
    	'' astEnd will free the nodes..
    end if

    ''
    symbFreeSymbol( s )

end sub

'':::::
function symbFreeDynVar _
	( _
		byval s as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' assuming conditions were checked already

	'' array? dims can be -1 with "DIM foo()" arrays..
	if( s->var.array.dims <> 0 ) then
		'' dynamic?
		if( symbIsDynamic( s ) ) then
			function = rtlArrayErase( astNewVAR( s, 0, s->typ ) )

		'' array of dyn strings?
		elseif( s->typ = FB_DATATYPE_STRING ) then
			function = rtlArrayStrErase( s )
		end if

	'' dyn string?
	elseif( s->typ = FB_DATATYPE_STRING ) then
		function = rtlStrDelete( astNewVAR( s, 0, FB_DATATYPE_STRING ) )

	else
		function = NULL
	end if

end function

'':::::
sub symbFreeLocalDynVars _
	( _
		byval proc as FBSYMBOL ptr _
	) static

    dim as FBSYMBOL ptr s

	s = symb.symtb->head
    do while( s <> NULL )
    	'' variable?
    	if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared, static, param or temp?
    		if( (s->attrib and (FB_SYMBATTRIB_SHARED or _
    							FB_SYMBATTRIB_STATIC or _
    							FB_SYMBATTRIB_COMMON or _
    							FB_SYMBATTRIB_PARAMBYDESC or _
    				  			FB_SYMBATTRIB_PARAMBYVAL or _
    				  			FB_SYMBATTRIB_PARAMBYREF or _
    				  			FB_SYMBATTRIB_TEMP or _
    				  			FB_SYMBATTRIB_FUNCRESULT)) = 0 ) then

				astAdd( symbFreeDynVar( s ) )

			end if
    	end if

    	s = s->next
    loop

end sub



