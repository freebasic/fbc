'' symbol table module for variables (scalars and arrays)
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "ast.bi"

declare sub hCreateArrayDescriptorType( )
declare function hCreateDescType _
	( _
		byval symtb as FBSYMBOLTB ptr, _
		byval dims as integer, _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer _
	) as FBSYMBOL ptr

sub symbVarInit( )
	listInit( @symb.dimlist, FB_INITDIMNODES, len( FBVARDIM ), LIST_FLAGS_NOCLEAR )

	'' assuming it's safe to create UDT symbols here, the array
	'' dimension type must be allocated at module-level or it
	'' would be removed when going out scope
	hCreateArrayDescriptorType( )
end sub

sub symbVarEnd( )
	listEnd( @symb.dimlist )
end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private sub hCreateArrayDescriptorType( )
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr fld = any

	'' type FBARRAYDIM
	symb.fbarraydim = symbStructBegin( NULL, NULL, "__FB_ARRAYDIMTB$", NULL, FALSE, 0, NULL, 0 )

	'' elements		as integer
	symbAddField( symb.fbarraydim, "elements", 0, dTB(), _
	              FB_DATATYPE_INTEGER, NULL, 0, 0 )

	'' lbound		as integer
	symbAddField( symb.fbarraydim, "lbound", 0, dTB(), _
	              FB_DATATYPE_INTEGER, NULL, 0, 0 )

	'' ubound		as integer
	symbAddField( symb.fbarraydim, "ubound", 0, dTB(), _
	              FB_DATATYPE_INTEGER, NULL, 0, 0 )

	'' end type
	symbStructEnd( symb.fbarraydim )

	'' type FBARRAY
	''     ...
	'' end type
	symb.fbarray = hCreateDescType( NULL, -1, "__FB_ARRAYDESC$", FB_DATATYPE_VOID, NULL, 0 )

	''
	'' Store some field offsets into globals for easy access
	''

	'' FBARRAY
	fld = symbUdtGetFirstField( symb.fbarray )  '' data
	symb.fbarray_data = symbGetOfs( fld )
	fld = symbUdtGetNextField( fld )         '' ptr
	fld = symbUdtGetNextField( fld )         '' size
	fld = symbUdtGetNextField( fld )         '' element_len
	fld = symbUdtGetNextField( fld )         '' dimensions
	fld = symbUdtGetNextField( fld )         '' dimTB
	symb.fbarray_dimtb = symbGetOfs( fld )

	'' FBVARDIM
	fld = symbUdtGetFirstField( symb.fbarraydim )  '' elements
	fld = symbUdtGetNextField( fld )                  '' lbound
	symb.fbarraydim_lbound = symbGetOfs( fld )
	fld = symbUdtGetNextField( fld )                  '' ubound
	symb.fbarraydim_ubound = symbGetOfs( fld )
end sub

private function hCreateDescType _
	( _
		byval symtb as FBSYMBOLTB ptr, _
		byval dims as integer, _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer _
	) as FBSYMBOL ptr

	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr sym = any

	sym = symbStructBegin( symtb, NULL, id, NULL, FALSE, 0, NULL, attrib )

	'' data			as any ptr
	symbAddField( sym, "data", 0, dTB(), _
	              typeAddrOf( dtype ), subtype, 0, 0 )

	'' ptr			as any ptr
	symbAddField( sym, "ptr", 0, dTB(), _
	              typeAddrOf( dtype ), subtype, 0, 0 )

	'' size			as integer
	symbAddField( sym, "size", 0, dTB(), _
	              FB_DATATYPE_INTEGER, NULL, 0, 0 )

	'' element_len		as integer
	symbAddField( sym, "element_len", 0, dTB(), _
	              FB_DATATYPE_INTEGER, NULL, 0, 0 )

	'' dimensions		as integer
	symbAddField( sym, "dimensions", 0, dTB(), _
	              FB_DATATYPE_INTEGER, NULL, 0, 0 )

	'' If the dimension count is unknown, reserve room for the max amount
	if( dims = -1 ) then
		dims = FB_MAXARRAYDIMS
	end if

	'' dimTB(0 to dims-1) as FBARRAYDIM
	dTB(0).lower = 0
	dTB(0).upper = dims-1

	symbAddField( sym, "dimTB", 1, dTB(), FB_DATATYPE_STRUCT, _
	              symb.fbarraydim, 0, 0 )

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
	dim as FBSYMBOLTB ptr symtb = any
	dim as integer isdynamic = any, ispubext = any, stats = any

	function = NULL

	'' don't add if it's a jump table
	if( (env.clopt.backend = FB_BACKEND_GAS) and symbGetIsJumpTb( array ) ) then
		exit function
	end if

	id_alias = NULL
	stats = 0

	'' field?
	if( symbIsField( array ) ) then
		static as string tmp
		tmp = *symbUniqueId( )
		id = strptr( tmp )
		'' Only store an alias if in BASIC mangling
		if( array->mangling <> FB_MANGLING_BASIC ) then
			id_alias = id
		end if

		attrib = FB_SYMBATTRIB_LOCAL
		stats = FB_SYMBSTATS_IMPLICIT

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
			'' Preserve FB_SYMBSTATS_HASALIAS stat too
			stats = array->stats and FB_SYMBSTATS_HASALIAS

		'' otherwise, create a temporary name..
		else
			static as string tmp
			tmp = *symbUniqueId( )
			id = strptr( tmp )
			'' Only store an alias if in BASIC mangling
			if( array->mangling <> FB_MANGLING_BASIC ) then
				id_alias = id
			end if
			stats = FB_SYMBSTATS_IMPLICIT
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

	'' field?
	if( symbIsField( array ) ) then
		'' if at mod-level, it can't be static, alloc on main()'s stack
		if( parser.scope = FB_MAINSCOPE ) then
			symtb = @symbGetProcSymbTb( parser.currproc )

		'' otherwise, let newSymbol() set it, we could be inside an
		'' scope block (ie: a var initializer)
		else
			symtb = NULL
		end if

	'' use the same symb tb as the array
	else
		symtb = array->symtb
	end if

	'' Create descriptor UDT in same symtb, and preserving the
	'' FB_SYMBATTRIB_LOCAL too if the descriptor has it.
	desctype = hCreateDescType( symtb, dimensions, symbUniqueId( ), _
	                            symbGetType( array ), symbGetSubType( array ), _
	                            attrib and FB_SYMBATTRIB_LOCAL )

	desc = symbNewSymbol( FB_SYMBOPT_PRESERVECASE, NULL, symtb, NULL, _
	                      FB_SYMBCLASS_VAR, id, id_alias, _
	                      FB_DATATYPE_STRUCT, desctype, attrib )
	if( desc = NULL ) then
		exit function
	end if

	desc->lgt = symbGetLen( desctype )
	desc->ofs = 0

	desc->stats = stats or (array->stats and (FB_SYMBSTATS_VARALLOCATED or FB_SYMBSTATS_ACCESSED))

	desc->var_.initree = NULL
	desc->var_.array.dims = 0
	desc->var_.array.dimhead = NULL
	desc->var_.array.dimtail = NULL
	desc->var_.array.dif = 0
	desc->var_.array.elms = 1
	desc->var_.array.desc = NULL
	desc->var_.array.has_ellipsis = FALSE
	desc->var_.desc.array = array '' back link
	desc->var_.stmtnum = parser.stmt.cnt
	desc->var_.align = 0	'' default alignment
	desc->var_.data.prev = NULL

	function = desc
end function

sub symbAddArrayDim _
	( _
		byval s as FBSYMBOL ptr, _
		byval lower as longint, _
		byval upper as longint _
	)

    dim as FBVARDIM ptr d = any, n = any

    d = listNewNode( @symb.dimlist )

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

end sub

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

			symbDelVarDims( s )

			for i = 0 to dimensions-1
				symbAddArrayDim( s, dTB(i).lower, dTB(i).upper )

				'' If any dimension size is unknown yet (ellipsis), hold off on the actual build
				'' until called later when it's known.
				if( dTB(i).upper = FB_ARRAYDIM_UNKNOWN ) then do_build = FALSE
			next
		else
			d = s->var_.array.dimhead
			for i = 0 to dimensions-1
				d->lower = dTB(i).lower
				d->upper = dTB(i).upper
				'' If any dimension size is unknown yet (ellipsis), hold off on the actual build
				'' until called later when it's known.
				if( d->upper = FB_ARRAYDIM_UNKNOWN ) then do_build = FALSE
				d = d->next
			next
		end if

		s->var_.array.elms = symbCalcArrayElements( s )
	else
		s->var_.array.dif = 0
		s->var_.array.elms = 1
	end if

	s->var_.array.dims = dimensions

	'' dims can be -1 with COMMON arrays..
	if( dimensions <> 0 ) then
		if( do_build ) then
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

function symbAddVar _
	( _
		byval id as const zstring ptr, _
		byval id_alias as const zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as longint, _
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

	s = symbNewSymbol( options or FB_SYMBOPT_DOHASH, NULL, symtb, hashtb, _
	                   FB_SYMBCLASS_VAR, id, id_alias, dtype, subtype, attrib )
	if( s = NULL ) then
		exit function
	end if

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
		s->var_.array.dims = 0
		s->var_.array.dif = 0
		s->var_.array.elms = 1
	end if
	s->var_.array.has_ellipsis = FALSE
	s->var_.desc.array = NULL
	s->var_.initree = NULL
	s->var_.align = 0	'' default alignment
	s->var_.stmtnum = parser.stmt.cnt
	s->var_.data.prev = NULL

	'' QB quirk: see above
	if( (options and FB_SYMBOPT_UNSCOPE) <> 0 ) then
		s->var_.stmtnum = parser.currproc->proc.ext->stmtnum + 1

	'' move to global?
	elseif( (options and FB_SYMBOPT_MOVETOGLOB) <> 0 ) then
		s->scope = FB_MAINSCOPE
	end if

	function = s
end function

'' For implicit variables that should live only in the current statement
'' - Will be marked with FB_SYMBATTRIB_TEMP, so it will not be destroyed
''   at scope breaks, but instead via the AST's dtor list and astAdd()
'' - Using a unique id, to avoid conflicts with the user's code
'' - As a positive side-effect, creating the var will always succeed
'' - FB_SYMBOPT_UNSCOPE is allowed, probably to ensure that temp vars used in
''   the user's var initializers will be unscoped just like the user's vars and
''   their initializers
'' - Temp vars should never be made STATIC automatically, e.g. due to
''   symbGetProcStaticLocals(), because they are hidden to the user, and making
''   them STATIC could cause hidden bugs with recursion or multi-threading.
function symbAddTempVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	static as FBARRAYDIM dTB(0)
	dim as FB_SYMBOPT options = FB_SYMBOPT_NONE

	'' Cannot create temp z/wstrings this way, since the length is unknown
	assert( typeGetDtAndPtrOnly( dtype ) <> FB_DATATYPE_CHAR )
	assert( typeGetDtAndPtrOnly( dtype ) <> FB_DATATYPE_WCHAR )

	if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
		options or= FB_SYMBOPT_UNSCOPE
	end if

	var sym = symbAddVar( symbUniqueId( ), NULL, dtype, subtype, 0, 0, _
	                      dTB(), FB_SYMBATTRIB_TEMP, options )
	symbSetIsImplicit( sym )

	function = sym
end function

'' For implicit variables that should live in the current scope, longer than
'' just the current statement.
'' - not marked with FB_SYMBATTRIB_TEMP, so the var will be destroyed properly
''   at scope breaks in the current scope, and at the end of the current scope
'' - just like a user-defined variable, just with an auto-generated name
'' - ditto regarding symbGetProcStaticLocals()
function symbAddImplicitVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval options as integer _
	) as FBSYMBOL ptr

	static as FBARRAYDIM dTB(0)

	'' Cannot create temp z/wstrings this way, since the length is unknown
	assert( typeGetDtAndPtrOnly( dtype ) <> FB_DATATYPE_CHAR )
	assert( typeGetDtAndPtrOnly( dtype ) <> FB_DATATYPE_WCHAR )

	var sym = symbAddVar( symbUniqueId( ), NULL, dtype, subtype, 0, 0, _
	                      dTB(), 0, options )
	symbSetIsImplicit( sym )

	function = sym
end function

function symbAddAndAllocateTempVar( byval dtype as integer ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr s = any

	s = symbAddTempVar( dtype )

	assert( env.clopt.backend = FB_BACKEND_GAS )

	irProcAllocLocal( parser.currproc, s )

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
		byval lgt as longint _
	) as longint

	dim as integer d = any
	dim as longint diff = any, elms = any

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

function symbCalcArrayElements _
	( _
		byval s as FBSYMBOL ptr, _
		byval n as FBVARDIM ptr = NULL _
	) as longint

	dim as longint e = any, d = any

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

function symbCalcArrayElements _
	( _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	) as longint

	dim as longint e = any, d = any

	e = 1
	for i as integer = 0 to dimensions-1
		d = (dTB(i).upper - dTB(i).lower) + 1
		e = e * d
	next

	function = e
end function

function symbCheckArraySize _
	( _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval lgt as longint, _
		byval is_on_stack as integer, _
		byval allow_ellipsis as integer _
	) as integer

	dim as ulongint allelements = any
	dim as ulongint elements = any
	dim as integer found_too_big = any

	found_too_big = FALSE
	allelements = 1

	for i as integer = 0 to dimensions-1
		'' ellipsis upper bound?
		if( allow_ellipsis and (dTB(i).upper = FB_ARRAYDIM_UNKNOWN) ) then
			'' Each dimension using ellipsis will have at least 1 element,
			'' this is what can be assumed for now. (The check will need
			'' to be repeated later when the real size is known)
			elements = 1
		else
			'' elements for this array dimension
			elements = (dTB(i).upper - dTB(i).lower) + 1
		end if

		'' Too many elements in this dimension?
		if( elements > &h7FFFFFFFu ) then
			found_too_big = TRUE
			exit for
		end if

		allelements *= elements

		'' Too many elements overall after adding this dimension?
		if( allelements > &h7FFFFFFFull ) then
			found_too_big = TRUE
			exit for
		end if
	next

	if( found_too_big = FALSE ) then
		'' Apply data type size
		allelements *= lgt
		if( allelements > &h7FFFFFFFull ) then
			found_too_big = TRUE
		end if
	end if

	if( found_too_big ) then
		function = FALSE
	else
		if( is_on_stack and (allelements > env.clopt.stacksize) ) then
			errReportWarn( FB_WARNINGMSG_HUGEARRAYONSTACK )
		end if
		function = TRUE
	end if

end function

function symbGetVarHasCtor( byval s as FBSYMBOL ptr ) as integer
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

	select case( symbGetType( s ) )
	'' var-len string?
	case FB_DATATYPE_STRING
		return TRUE

	'' wchar ptr marked as "dynamic wstring"?
	case typeAddrOf( FB_DATATYPE_WCHAR )
		if( symbGetIsWstring( s ) ) then
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

	'' UDT var with ctor?
	function = symbHasCtor( s )
end function

function symbGetVarHasDtor( byval s as FBSYMBOL ptr ) as integer
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

	select case( symbGetType( s ) )
	'' var-len string?
	case FB_DATATYPE_STRING
		return TRUE

	'' wchar ptr marked as "dynamic wstring"?
	case typeAddrOf( FB_DATATYPE_WCHAR )
		if( symbGetIsWstring(s) ) then
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

	'' UDT var with dtor?
	function = symbHasDtor( s )
end function

function symbCloneVar( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
	dim as FBVARDIM ptr d = any
	dim as integer dimensions = any

	'' assuming only temp vars or temp array descs will be cloned
	if( symbIsDescriptor( sym ) ) then
		function = symbAddArrayDesc( sym->var_.desc.array, _
				symbGetArrayDimensions( sym->var_.desc.array ) )
		'' no need to dup desc.initree, it was flushed in newARG() and
		'' should be fixed up with the new symbol in TypeIniFlush()
	elseif( symbIsTemp( sym ) ) then
		function = symbAddTempVar( symbGetType( sym ), symbGetSubType( sym ) )
	else
		'' Fill the dTB() with the array's dimensions, if any
		dimensions = symbGetArrayDimensions( sym )
		d = symbGetArrayFirstDim( sym )
		for i as integer = 0 to dimensions-1
			dTB(i).lower = d->lower
			dTB(i).upper = d->upper
			d = d->next
		next

		function = symbAddVar( symbGetName( sym ), NULL, _
				symbGetType( sym ), symbGetSubType( sym ), 0, _
				dimensions, dTB(), symbGetAttrib( sym ), 0 )
	end if
end function

function symbVarCheckAccess( byval sym as FBSYMBOL ptr ) as integer
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

sub symbDelVarDims( byval s as FBSYMBOL ptr )
    dim as FBVARDIM ptr n = any, nxt = any

    n = s->var_.array.dimhead
    do while( n <> NULL )
    	nxt = n->next

    	listDelNode( @symb.dimlist, n )

    	n = nxt
    loop

	s->var_.array.dimhead = NULL
	s->var_.array.dimtail = NULL
	s->var_.array.dims = 0
end sub

sub symbDelVar( byval s as FBSYMBOL ptr, byval is_tbdel as integer )
	if( symbGetArrayDimensions( s ) > 0 ) then
		symbDelVarDims( s )
		if( is_tbdel = FALSE ) then
			'' del the array descriptor, recursively
			if( s->var_.array.desc ) then
				symbDelSymbol( s->var_.array.desc, FALSE )
			end if
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
		'' Note: astEnd() will already free the initree
    end if

    ''
    symbFreeSymbol( s )
end sub
