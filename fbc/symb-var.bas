''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"

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

declare sub 		hCreateArrayDescriptorType ( _
											_
										)

declare function 	hCreateDescType 	( _
											byval dims as integer, _
											byval id as zstring ptr = NULL, _
											byval dtype as integer = FB_DATATYPE_VOID, _
											byval subtype as FBSYMBOL ptr = NULL _
										) as FBSYMBOL ptr


'' globals
	dim shared as FB_SYMVAR_CTX ctx

'':::::
sub symbVarInit( )

	listNew( @symb.dimlist, FB_INITDIMNODES, len( FBVARDIM ), LIST_FLAGS_NOCLEAR )

	'' assuming it's safe to create UDT symbols here, the array
	'' dimension type must be allocated at module-level or it
	'' would be removed when going out scope
	hCreateArrayDescriptorType( )

end sub

'':::::
sub symbVarEnd( )

	listFree( @symb.dimlist )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hCreateArrayDescriptorType _
	( _
		_
	)

	static as FBARRAYDIM dTB(0)

   	'' type TDimtTb
   	ctx.array_dimtype = symbStructBegin( NULL, "__FB_ARRAYDIMTB$", NULL, FALSE, 0 )

	'' elements		as integer
	symbAddField( ctx.array_dimtype, _
				  "elements", _
				  0, dTB(), _
				  FB_DATATYPE_INTEGER, NULL, _
				  FB_INTEGERSIZE, 0 )

	'' lbound		as integer
	symbAddField( ctx.array_dimtype, _
				  "lbound", _
				  0, dTB(), _
				  FB_DATATYPE_INTEGER, NULL, _
				  FB_INTEGERSIZE, 0 )

	'' ubound		as integer
	symbAddField( ctx.array_dimtype, _
				  "ubound", _
				  0, dTB(), _
				  FB_DATATYPE_INTEGER, NULL, _
				  FB_INTEGERSIZE, 0 )

    ''
	symbStructEnd( ctx.array_dimtype )


	''
   	symb.arrdesctype = hCreateDescType( -1, "__FB_ARRAYDESC$" )


end sub

'':::::
private function hCreateDescType _
	( _
		byval dims as integer, _
		byval id as zstring ptr = NULL, _
		byval dtype as integer = FB_DATATYPE_VOID, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as FBSYMBOL ptr

	static as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr sym = any, dimtype = any

    ''
    if( id = NULL ) then
    	static as string tmp
    	tmp = *hMakeTmpStrNL( )
    	id = strptr( tmp )
    end if

    sym = symbStructBegin( NULL, id, NULL, FALSE, 0 )

    '' data			as any ptr
	symbAddField( sym, _
				  "data", _
				  0, dTB(), _
				  typeAddrOf( dtype ), subtype, _
				  FB_POINTERSIZE, 0 )

	'' ptr			as any ptr
	symbAddField( sym, _
				  "ptr", _
				  0, dTB(), _
				  typeAddrOf( dtype ), subtype, _
				  FB_POINTERSIZE, 0 )

    '' size			as integer
	symbAddField( sym, _
				  "size", _
				  0, dTB(), _
				  FB_DATATYPE_INTEGER, NULL, _
				  FB_INTEGERSIZE, 0 )

    '' element_len	as integer
	symbAddField( sym, _
				  "element_len", _
				  0, dTB(), _
				  FB_DATATYPE_INTEGER, NULL, _
				  FB_INTEGERSIZE, 0 )

    '' dimensions	as integer
	symbAddField( sym, _
				  "dimensions", _
				  0, dTB(), _
				  FB_DATATYPE_INTEGER, NULL, _
				  FB_INTEGERSIZE, 0 )


	if( dims = -1 ) then
		dims = FB_MAXARRAYDIMS
	end if

    '' dimTB(0 to dims-1) as FBARRAYDIM
	dTB(0).lower = 0
	dTB(0).upper = dims-1

	dimtype = ctx.array_dimtype

	symbAddField( sym, _
				  "dimTB", _
				  1, dTB(), _
				  FB_DATATYPE_STRUCT, dimtype, _
				  symbGetLen( dimtype ), 0 )

	''
	symbStructEnd( sym )

	function = sym

end function

'':::::
function symbAddArrayDesc _
	( _
		byval array as FBSYMBOL ptr, _
		byval dimensions as integer _
	) as FBSYMBOL ptr

    dim as zstring ptr id = any, id_alias = any
    dim as FBSYMBOL ptr desc = any, desctype = any
    dim as FB_SYMBATTRIB attrib = any
    dim as FBSYMBOLTB ptr symbtb = any
    dim as integer isdynamic = any, ispubext = any

	function = NULL

    '' don't add if it's a jump table
    if( symbGetIsJumpTb( array ) ) then
    	exit function
    end if

	id_alias = NULL

	'' field?
	if( symbIsField( array ) ) then
		static as string tmp
		tmp = *hMakeTmpStrNL( )
		id = strptr( tmp )

		attrib = FB_SYMBATTRIB_LOCAL

		'' can't be ever static, the address has to be always
		'' calculated at runtime

	'' var_..
	else
		isdynamic = symbIsDynamic( array )
		ispubext = (array->attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN)) <> 0

		'' common or public and dynamic? use the array name for the descriptor,
		'' as only it will be allocated or seen by other modules
		if( symbIsCommon( array ) or (ispubext and isdynamic) ) then
			id = array->id.name
			id_alias = array->id.alias

		'' otherwise, create a temporary name..
		else
			static as string tmp
			tmp = *hMakeTmpStrNL( )
			id = strptr( tmp )
		end if

		attrib = array->attrib and (FB_SYMBATTRIB_SHARED or _
				     			 	FB_SYMBATTRIB_COMMON or _
				     			 	FB_SYMBATTRIB_STATIC or _
				     			 	FB_SYMBATTRIB_EXTERN or _
				     			 	FB_SYMBATTRIB_PUBLIC or _
				     			 	FB_SYMBATTRIB_LOCAL)

		'' not dynamic?
		if( isdynamic = FALSE ) then
			'' extern? always emit the descriptor (if accessed),
			'' because the original one won't be accessible (or may don't
			'' exist, if it's a "C" extern array)
			if( symbIsExtern( array ) ) then
				attrib and= not FB_SYMBATTRIB_EXTERN
			end if

			'' if not-dynamic, the descriptor can't be ever public
			attrib and= not FB_SYMBATTRIB_PUBLIC
		end if
	end if

	attrib or= FB_SYMBATTRIB_DESCRIPTOR

	desctype = hCreateDescType( dimensions, NULL, symbGetType( array ), symbGetSubType( array ) )

	'' field?
	if( symbIsField( array ) ) then
		'' if at mod-level, it can't be static, alloc on main()'s stack
		if( parser.scope = FB_MAINSCOPE ) then
			symbtb = @symbGetProcSymbTb( parser.currproc )

		'' otherwise, let newSymbol() set it, we could be inside an
		'' scope block (ie: a var initializer)
		else
			symbtb = NULL
		end if

	'' use the same symb tb as the array
	else
		symbtb = array->symtb
	end if

	desc = symbNewSymbol( FB_SYMBOPT_PRESERVECASE, _
						  NULL, _
					   	  symbtb, NULL, _
					   	  FB_SYMBCLASS_VAR, _
					   	  id, id_alias, _
					   	  FB_DATATYPE_STRUCT, desctype, _
					   	  attrib )
    if( desc = NULL ) then
    	exit function
    end if

	''
	desc->lgt = symbGetLen( desctype )
	desc->ofs = 0

	desc->stats = array->stats and (FB_SYMBSTATS_VARALLOCATED or _
									FB_SYMBSTATS_ACCESSED or _
									FB_SYMBSTATS_HASALIAS)

	'' as desc is also a var, clear the var fields
	desc->var_.array.desc = NULL
	desc->var_.array.dif = 0
	symbSetArrayDimensions( desc, 0 )
	desc->var_.array.dimhead = NULL
	desc->var_.array.dimtail = NULL
	desc->var_.array.elms = 1

    '' should be set elsewhere
    desc->var_.initree = NULL

    '' back link
    desc->var_.desc.array = array

	''
	function = desc

end function

'':::::
function symbNewArrayDim _
	( _
		byval s as FBSYMBOL ptr, _
		byval lower as integer, _
		byval upper as integer _
	) as FBVARDIM ptr

    dim as FBVARDIM ptr d = any, n = any

    function = NULL

    d = listNewNode( @symb.dimlist )
    if( d = NULL ) then
    	exit function
    end if

    d->lower = lower
    d->upper = upper

	n = s->var_.array.dimtail
	if( n <> NULL ) then
		n->next = d
	else
		s->var_.array.dimhead = d
	end if

	d->next = NULL
	s->var_.array.dimtail = d

    function = d

end function

'':::::
sub symbSetArrayDimTb _
	( _
		byval s as FBSYMBOL ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	)

    dim as integer i = any
    dim as FBVARDIM ptr d = any
	dim as integer do_build = TRUE

	if( dimensions > 0 ) then
		s->var_.array.dif = symbCalcArrayDiff( dimensions, dTB(), s->lgt )

		if( (s->var_.array.dimhead = NULL) or _
			(symbGetArrayDimensions( s ) <> dimensions) ) then

            hDelVarDims( s )

			for i = 0 to dimensions-1
				if( symbNewArrayDim( s, dTB(i).lower, dTB(i).upper ) = NULL ) then
				end if
				' If any dimension size is unknown yet (ellipsis), hold off on the actual build
				' until called later when it's known.
				if dTB(i).upper = -1 then do_build = FALSE
			next

		else
			d = s->var_.array.dimhead
			for i = 0 to dimensions-1
				d->lower = dTB(i).lower
				d->upper = dTB(i).upper
				' If any dimension size is unknown yet (ellipsis), hold off on the actual build
				' until called later when it's known.
				if d->upper = -1 then do_build = FALSE
				d = d->next
			next
		end if

		s->var_.array.elms = symbCalcArrayElements( s )

	else
		s->var_.array.dif = 0
		s->var_.array.elms = 1
	end if

    symbSetArrayDimensions( s, dimensions )

	'' dims can be -1 with COMMON arrays..
	if( dimensions <> 0 ) then
		if do_build = TRUE then
			if( s->var_.array.desc = NULL ) then
				s->var_.array.desc = symbAddArrayDesc( s, dimensions )

				s->var_.array.desc->var_.initree = _
					astBuildArrayDescIniTree( s->var_.array.desc, s, NULL )

			end if
		end if
	else
		s->var_.array.desc = NULL
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
		byval stats as integer _
	)

	''
	s->stats or= stats

	s->lgt = lgt
	s->ofs = 0

	'' array fields
	s->var_.array.dimhead = NULL
	s->var_.array.dimtail = NULL
	s->var_.array.desc = NULL

	if( dimensions <> 0 ) then
		symbSetArrayDimTb( s, dimensions, dTB() )
	else
		symbSetArrayDimensions( s, 0 )
		s->var_.array.dif = 0
		s->var_.array.elms = 1
	end if

	s->var_.array.has_ellipsis = FALSE

	s->var_.initree = NULL

	s->var_.align = 0	'' default alignment

	s->var_.stmtnum = parser.stmt.cnt

end sub

'':::::
function symbAddVarEx _
	( _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval attrib as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr s = any
    dim as FBSYMBOLTB ptr symtb = any
    dim as FBHASHTB ptr hashtb = any
    dim as integer isglobal = any, stats = any

    function = NULL

    ''
    isglobal = (attrib and (FB_SYMBATTRIB_PUBLIC or _
			 				FB_SYMBATTRIB_EXTERN or _
			 				FB_SYMBATTRIB_SHARED or _
			 				FB_SYMBATTRIB_COMMON)) <> 0

    ''
    if( lgt <= 0 ) then
    	lgt	= symbCalcLen( dtype, subtype )
    end if

    '' no explict alias?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( parser.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    	stats = 0

    else
		stats = FB_SYMBSTATS_HASALIAS
	end if

	'' local? add to local symb & hash tbs
	if( isglobal = FALSE ) then
		attrib or= FB_SYMBATTRIB_LOCAL

		'' QB quirk: implicit variables are moved to the function scope..
		if( (options and FB_SYMBOPT_UNSCOPE) = 0 ) then
			symtb = symb.symtb
		else
			symtb = @symbGetProcSymbTb( parser.currproc )
		end if

		hashtb = symb.hashtb

		'' can't add local static vars to global list because
		'' symbDelSymbolTb() will miss them when flushing the
		'' proc/scope block, and also because the GDB info

	'' global..
	else
		symtb = @symbGetGlobalTb( )
		hashtb = @symbGetGlobalHashTb( )

		'' inside a namespace?
		if( symbIsGlobalNamespc( ) = FALSE ) then
			'' respect namespaces?
			if( (options and FB_SYMBOPT_MOVETOGLOB) = 0 ) then
				symtb = @symbGetCompSymbTb( symbGetCurrentNamespc( ) )
				hashtb = @symbGetCompHashTb( symbGetCurrentNamespc( ) )
			end if
		end if
	end if

	s = symbNewSymbol( options or FB_SYMBOPT_DOHASH, _
					   NULL, _
					   symtb, hashtb, _
					   FB_SYMBCLASS_VAR, _
					   id, id_alias, _
					   dtype, subtype, _
					   attrib )

	if( s = NULL ) then
		exit function
	end if

	''
	hSetupVar( s, id, dtype, subtype, lgt, dimensions, dTB(), stats )

	'' QB quirk: see above
	if( (options and FB_SYMBOPT_UNSCOPE) <> 0 ) then
		s->var_.stmtnum = parser.currproc->proc.ext->stmtnum + 1

	'' move to global?
	elseif( (options and FB_SYMBOPT_MOVETOGLOB) <> 0 ) then
		s->scope = FB_MAINSCOPE
	end if

	function = s

end function

'':::::
function symbAddVar _
	( _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval attrib as integer _
	) as FBSYMBOL ptr

    function = symbAddVarEx( id, NULL, dtype, subtype, _
    		  			     0, dimensions, dTB(), _
    						 attrib )

end function

'':::::
function symbAddTempVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval doalloc as integer, _
		byval checkstatic as integer _
	) as FBSYMBOL ptr

	static as zstring * FB_MAXNAMELEN+1 id
    static as FBARRAYDIM dTB(0)
	dim as integer attrib = any
    dim as FBSYMBOL ptr s = any
	dim as FB_SYMBOPT options = FB_SYMBOPT_NONE

	id = *hMakeTmpStrNL( )

	attrib = FB_SYMBATTRIB_TEMP
	if( checkstatic ) then
		if( fbIsModLevel( ) = FALSE ) then
			if( symbGetProcStaticLocals( parser.currproc ) ) then
				attrib or= FB_SYMBATTRIB_STATIC
			end if
		end if
	end if

	if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
		options or= FB_SYMBOPT_UNSCOPE
	end if

	s = symbAddVarEx( id, NULL, _
					  dtype, subtype, 0, _
					  0, dTB(), _
					  attrib, options )
    if( s = NULL ) then
    	return NULL
    end if

	'' alloc? (should be used by IR only)
	if( doalloc ) then
    	'' not static?
    	if( (s->attrib and FB_SYMBATTRIB_STATIC) = 0 or irGetOption( IR_OPT_HIGHLEVEL ) ) then

			s->ofs = irProcAllocLocal( parser.currproc, s, s->lgt )

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

    dim as integer d = any, diff = any, elms = any, mult = any

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
	) as integer

    dim as integer e = any, d = any

	if( n = NULL ) then
		n = s->var_.array.dimhead
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
function symbCalcArrayElements _
	( _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	) as integer

    dim as integer e = any, i = any, d = any

	e = 1
	for i = 0 to dimensions-1
		d = (dTB(i).upper - dTB(i).lower) + 1
		e = e * d
	next i

	function = e

end function

'':::::
function symbGetVarHasCtor _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

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

   	select case symbGetType( s )
	'' var-len string?
	case FB_DATATYPE_STRING
		return TRUE

   	'' has a default ctor?
   	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
   		if( symbGetCompDefCtor( symbGetSubtype( s ) ) <> NULL ) then
   			return TRUE
   		end if

   	end select

	'' array? dims can be -1 with "DIM foo()" arrays..
	if( symbGetArrayDimensions( s ) <> 0 ) then
		'' (note: it doesn't matter if it's dynamic array or not, local
		'' 		  non-dynamic array allocations will have to fill
		''        the descriptor, so arrays can't be accessed before that)
		return TRUE
	end if

	function = FALSE

end function

'':::::
function symbGetVarHasDtor _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

    '' shared, static, param or temporary?
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

   	select case symbGetType( s )
	'' var-len string?
	case FB_DATATYPE_STRING
    	return TRUE

   	'' has dtor?
   	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
   		if( symbGetHasDtor( symbGetSubtype( s ) ) ) then
   			return TRUE
   		end if

   	end select

	'' array? dims can be -1 with "DIM foo()" arrays..
	if( symbGetArrayDimensions( s ) <> 0 ) then
		'' dynamic?
		if( symbIsDynamic( s ) ) then
			return TRUE
		end if
	end if

	function = FALSE

end function

'':::::
function symbCloneVar _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	'' assuming only temp vars or temp array descs will be cloned

	if( symbIsDescriptor( sym ) ) then
    	function = symbAddArrayDesc( sym->var_.desc.array, _
    								 symbGetArrayDimensions( sym->var_.desc.array ) )

		'' no need to dup desc.initree, it was flushed in newARG() and
		'' should be fixed up with the new symbol in TypeIniFlush()

	else
		function = symbAddTempVar( symbGetType( sym ), _
					    	   	   symbGetSubType( sym ), _
					   		   	   FALSE, _
					   		   	   FALSE )
	end if

end function

'':::::
function symbVarCheckAccess _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	'' inside a proc?
	if( fbIsModLevel( ) = FALSE ) then
		'' local?
		if( symbIsLocal( sym ) ) then
			'' not a main()'s local?
			if( symbGetScope( sym ) = FB_MAINSCOPE ) then
				return FALSE
		    end if
		'' not shared?
		elseif( symbIsShared( sym ) = FALSE ) then
			return FALSE
		end if
	end if

	function = TRUE

end function


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hDelVarDims _
	( _
		byval s as FBSYMBOL ptr _
	)

    dim as FBVARDIM ptr n = any, nxt = any

    n = s->var_.array.dimhead
    do while( n <> NULL )
    	nxt = n->next

    	listDelNode( @symb.dimlist, n )

    	n = nxt
    loop

    s->var_.array.dimhead = NULL
    s->var_.array.dimtail = NULL
    symbSetArrayDimensions( s, 0 )

end sub

'':::::
sub symbDelVar _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer _
	)

    if( s = NULL ) then
    	exit sub
    end if

    if( symbGetArrayDimensions( s ) > 0 ) then
    	hDelVarDims( s )
    	if( is_tbdel = FALSE ) then
    		'' del the array descriptor, recursively
    		symbDelVar( s->var_.array.desc, FALSE )
    	end if
    end if

    if( symbGetIsLiteral( s ) ) then
    	s->attrib and= not FB_SYMBATTRIB_LITERAL

    	'' not a wchar literal?
    	if( s->typ <> FB_DATATYPE_WCHAR ) then
    		if( s->var_.littext <> NULL ) then
    			ZstrFree( s->var_.littext )
    		end if
    	else
    		if( s->var_.littextw <> NULL ) then
    			WstrFree( s->var_.littextw )
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


