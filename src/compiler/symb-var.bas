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

declare function hAddArrayDescriptorType _
	( _
		byval dims as integer, _
		byval id as zstring ptr _
	) as FBSYMBOL ptr
declare sub hAddGlobalArrayDescriptorTypes( )

sub symbVarInit( )
	'' assuming it's safe to create UDT symbols here, the array
	'' dimension type must be allocated at module-level or it
	'' would be removed when going out scope
	hAddGlobalArrayDescriptorTypes( )
end sub

sub symbVarEnd( )
end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private sub hAddGlobalArrayDescriptorTypes( )
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr fld = any

	'' type FBARRAYDIM
	symb.fbarraydim = symbStructBegin( NULL, NULL, "__FB_ARRAYDIMTB$", NULL, FALSE, 0, NULL, 0 )

	'' elements		as integer
	symbAddField( symb.fbarraydim, "elements", 0, dTB(), _
	              FB_DATATYPE_INTEGER, NULL, 0, 0, 0 )

	'' lbound		as integer
	symbAddField( symb.fbarraydim, "lbound", 0, dTB(), _
	              FB_DATATYPE_INTEGER, NULL, 0, 0, 0 )

	'' ubound		as integer
	symbAddField( symb.fbarraydim, "ubound", 0, dTB(), _
	              FB_DATATYPE_INTEGER, NULL, 0, 0, 0 )

	'' end type
	symbStructEnd( symb.fbarraydim )

	'' type FBARRAY
	''     ...
	'' end type
	for i as integer = 1 to FB_MAXARRAYDIMS
		symb.fbarray(i) = hAddArrayDescriptorType( i, "__FB_ARRAYDESC" & i & "$" )
	next
	symb.fbarray(0) = NULL
	symb.fbarray(-1) = symb.fbarray(FB_MAXARRAYDIMS)

	''
	'' Store some field offsets into globals for easy access
	''

	'' FBARRAY
	fld = symbUdtGetFirstField( symb.fbarray(-1) )  '' data
	symb.fbarray_data = symbGetOfs( fld )
	fld = symbUdtGetNextField( fld )         '' ptr
	symb.fbarray_ptr = symbGetOfs( fld )
	fld = symbUdtGetNextField( fld )         '' size
	symb.fbarray_size = symbGetOfs( fld )
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

private function hAddArrayDescriptorType _
	( _
		byval dims as integer, _
		byval id as zstring ptr _
	) as FBSYMBOL ptr

	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr sym = any

	sym = symbStructBegin( NULL, NULL, id, NULL, FALSE, 0, NULL, 0 )

	'' data			as any ptr
	symbAddField( sym, "data", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

	'' ptr			as any ptr
	symbAddField( sym, "ptr", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

	'' size			as integer
	symbAddField( sym, "size", 0, dTB(), FB_DATATYPE_INTEGER, NULL, 0, 0, 0 )

	'' element_len		as integer
	symbAddField( sym, "element_len", 0, dTB(), FB_DATATYPE_INTEGER, NULL, 0, 0, 0 )

	'' dimensions		as integer
	symbAddField( sym, "dimensions", 0, dTB(), FB_DATATYPE_INTEGER, NULL, 0, 0, 0 )

	'' dimTB(0 to dims-1) as FBARRAYDIM
	assert( (dims >= 1) and (dims <= FB_MAXARRAYDIMS) )
	dTB(0).lower = 0
	dTB(0).upper = dims-1

	symbAddField( sym, "dimTB", 1, dTB(), FB_DATATYPE_STRUCT, symb.fbarraydim, 0, 0, 0 )

	symbStructEnd( sym )

	function = sym
end function

function symbAddArrayDesc( byval array as FBSYMBOL ptr ) as FBSYMBOL ptr
	static as string tempid

	dim as zstring ptr id = any, id_alias = any
	dim as FBSYMBOL ptr desc = any, desctype = any
	dim as FB_SYMBATTRIB attrib = any
	dim as FBSYMBOLTB ptr symtb = any
	dim as integer isdynamic = any, ispubext = any, stats = any

	function = NULL

	id_alias = NULL
	stats = 0

	'' field?
	if( symbIsField( array ) ) then
		id = symbUniqueId( )
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

		'' common or dynamic? Use the array's name/alias for the
		'' descriptor, allowing it to be a from other modules if
		'' Extern, and making debugging nicer.
		if( symbIsCommon( array ) or isdynamic ) then
			id = array->id.name
			id_alias = array->id.alias
			'' Preserve FB_SYMBSTATS_HASALIAS stat too
			stats = array->stats and FB_SYMBSTATS_HASALIAS

			'' If the array had a type suffix, there may be others
			'' with the same id. We must prevent their descriptors
			'' from colliding with each-other (it probably only
			'' matters for -gen gcc), and since we can't preserve
			'' FB_SYMBATTRIB_SUFFIXED on the descriptor (it has a
			'' different dtype than the array anyways), we must do
			'' that part of the mangling here because
			'' hMangleVariable() won't do it.
			if( symbIsSuffixed( array ) ) then
				tempid = *id
				tempid += *hMangleBuiltInType( symbGetType( array ) )
				if( env.clopt.backend = FB_BACKEND_GCC ) then
					tempid += "$"
				end if
				id = strptr( tempid )
			end if

		'' otherwise, create a temporary name for the descriptor,
		'' as it will be used privately only, and must co-exist with
		'' the static array symbol.
		else
			id = symbUniqueId( )
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

	desctype = symb.fbarray(symbGetArrayDimensions( array ))

	desc = symbNewSymbol( FB_SYMBOPT_PRESERVECASE, NULL, symtb, NULL, _
	                      FB_SYMBCLASS_VAR, id, id_alias, _
	                      FB_DATATYPE_STRUCT, desctype, attrib )
	if( desc = NULL ) then
		exit function
	end if

	desc->lgt = symbGetLen( desctype )
	desc->ofs = 0

	desc->stats = stats or (array->stats and (FB_SYMBSTATS_VARALLOCATED or FB_SYMBSTATS_ACCESSED))

	symbVarInitFields( desc )
	desc->var_.desc.array = array '' back link

	function = desc
end function

private sub symbDropArrayDims( byval s as FBSYMBOL ptr )
	deallocate( s->var_.array.dimtb )
	s->var_.array.dimtb = NULL
end sub

private sub symbRecalcArrayDiff( byval sym as FBSYMBOL ptr )
	dim as longint diff = any, elements = any
	dim as integer last = any
	dim as FBARRAYDIM ptr dimtb = any

	assert( symbIsDynamic( sym ) = FALSE )
	assert( symbGetArrayDimensions( sym ) > 0 )

	dimtb = sym->var_.array.dimtb
	diff = 0
	last = sym->var_.array.dimensions - 1
	for i as integer = 0 to last - 1
		elements = (dimtb[i+1].upper - dimtb[i+1].lower) + 1
		diff = (diff + dimtb[i].lower) * elements
	next

	diff = (diff + dimtb[last].lower) * sym->lgt

	sym->var_.array.diff = -diff
end sub

private sub symbRecalcArrayDiffAndElements( byval sym as FBSYMBOL ptr )
	assert( symbGetIsDynamic( sym ) = FALSE )
	if( symbGetArrayDimensions( sym ) > 0 ) then
		symbRecalcArrayDiff( sym )
		sym->var_.array.elements = symbCalcArrayElements( sym, 0 )
	else
		sym->var_.array.diff = 0
		sym->var_.array.elements = 1
	end if
end sub

function symbArrayHasUnknownBounds( byval sym as FBSYMBOL ptr ) as integer
	assert( symbIsVar( sym ) or symbIsField( sym ) )

	function = FALSE

	if( symbGetIsDynamic( sym ) ) then
		exit function
	end if

	for i as integer = 0 to symbGetArrayDimensions( sym ) - 1
		if( symbArrayUbound( sym, i ) = FB_ARRAYDIM_UNKNOWN ) then
			return TRUE
		end if
	next
end function

''
'' Allocate the companion array descriptor for VARs, if there are no more
'' FB_ARRAYDIM_UNKNOWN's in the dimensions. VARs are "unique", they map to
'' runtime memory 1:1, it's ok to have exactly 1 descriptor per VAR.
''
'' But not for FIELDs, because they are not unique: There can be many instances
'' of a field in memory at runtime, so there is no single descriptor per FIELD
'' symbol. Instead, astNewARG() has to call symbAddArrayDesc() on-demand and
'' create a new descriptor everytime. And dynamic array fields have their own
'' descriptor associated anyways.
''
sub symbMaybeAddArrayDesc( byval sym as FBSYMBOL ptr )
	assert( symbIsField( sym ) = FALSE )
	assert( symbIsParamBydesc( sym ) = FALSE )

	if( symbGetArrayDimensions( sym ) = 0 ) then
		exit sub
	end if

	if( symbArrayHasUnknownBounds( sym ) ) then
		'' Not yet; there still are unknown array dimensions
		exit sub
	end if

	if( sym->var_.array.desc = NULL ) then
		sym->var_.array.desc = symbAddArrayDesc( sym )
		sym->var_.array.desc->var_.initree = _
			astBuildArrayDescIniTree( sym->var_.array.desc, sym, NULL )
	end if
end sub

sub symbSetArrayDimTb _
	( _
		byval sym as FBSYMBOL ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	)

	assert( symbGetIsDynamic( sym ) = FALSE )
	assert( dimensions > 0 )

	'' Delete existing dimensions, if any
	symbDropArrayDims( sym )

	sym->var_.array.dimensions = dimensions

	'' Copy the dTB() into the FBSYMBOL
	sym->var_.array.dimtb = xallocate( dimensions * sizeof( FBARRAYDIM ) )
	for i as integer = 0 to dimensions - 1
		sym->var_.array.dimtb[i] = dTB(i)
	next

	symbRecalcArrayDiffAndElements( sym )

end sub

sub symbSetFixedSizeArrayDimensionElements _
	( _
		byval sym as FBSYMBOL ptr, _
		byval dimension as integer, _
		byval elements as longint _
	)

	assert( symbGetIsDynamic( sym ) = FALSE )
	assert( (dimension >= 0) and (dimension < symbGetArrayDimensions( sym )) )

	with( symbGetArrayDim( sym, dimension ) )
		.upper = .lower + elements - 1
	end with

	symbRecalcArrayDiffAndElements( sym )

end sub

'' Used to fill in the dimension count for dynamic array variables (not
'' parameters) declared with (), i.e. unknown dimension count, when the parser
'' sees the first REDIM or array access and can tell the dimension count based
'' on it.
sub symbCheckDynamicArrayDimensions _
	( _
		byval sym as FBSYMBOL ptr, _
		byval dimensions as integer _
	)

	dim as FBSYMBOL ptr desc = any

	assert( symbIsDynamic( sym ) )

	'' Secondary declarations with dimensions = -1 don't make a difference.
	if( dimensions = -1 ) then
		exit sub
	end if

	if( symbGetArrayDimensions( sym ) = -1 ) then
		sym->var_.array.dimensions = dimensions

		''
		'' Note: Ideally we would resize the array descriptor, now that
		'' the exact dimensions are known. Unfortunately, it's too late
		'' for that...
		''
		'' Local descriptors (on stack): The initializer for the
		'' descriptor has already been emitted via a DECL node. We'd
		'' have to exchange this for the new initializer code...
		''
		'' If '()' were allowed on dynamic array fields: We couldn't
		'' resize the descriptor field after the fact either. That would
		'' require re-calculate the struct layout, all sizeof()s, etc.
		''
		'' COMMON descriptors: They can't be initialized due to being
		'' emitted into BSS; the descriptor's "dimensions" field will
		'' end up being initially 0, causing the rtlib to expect room
		'' for FB_MAXARRAYDIMS anyways.
		''
		'' Thus shrinking the descriptor could only be done for
		'' non-COMMON globals, though even then it'd be risky, because
		'' fbc wasn't designed for this kind of "multi-pass" things...
		''
		assert( symbGetType( symbGetArrayDescriptor( sym ) ) = FB_DATATYPE_STRUCT )
		assert( symbGetArrayDescriptor( sym )->subtype = symb.fbarray(-1) )
		assert( symbIsField( sym ) = FALSE )
		assert( symbIsField( symbGetArrayDescriptor( sym ) ) = FALSE )
		#if 0
		if( symbIsVar( sym ) and _
		    (not symbIsCommon( sym )) and _
		    ((not symbIsLocal( sym )) or symbIsStatic( sym )) ) then
			assert( symbGetVarIsAllocated( desc ) = FALSE )
			symbSetType( desc, FB_DATATYPE_STRUCT, symb.fbarray(dimensions) )

			'' Must also switch to a new, compatible initializer
			'' (there now are less fields to initialize)
			astDelTree( desc->var_.initree )
			desc->var_.initree = NULL
			desc->var_.initree = astBuildArrayDescIniTree( desc, sym, NULL )
		end if
		#endif

	'' The array's dimension count is known; complain about mismatching dimension counts.
	elseif( symbGetArrayDimensions( sym ) <> dimensions ) then
		errReportEx( FB_ERRMSG_WRONGDIMENSIONS, symbGetName( sym ) )
	end if

end sub

sub symbVarInitFields( byval sym as FBSYMBOL ptr )
	sym->var_.initree = NULL
	sym->var_.array.dimensions = 0
	sym->var_.array.dimtb = NULL
	sym->var_.array.diff = 0
	sym->var_.array.elements = 1
	sym->var_.array.desc = NULL
	sym->var_.desc.array = NULL
	sym->var_.stmtnum = parser.stmt.cnt
	sym->var_.align = 0
	sym->var_.data.prev = NULL
	sym->var_.bitpos = 0
	sym->var_.bits = 0
end sub

sub symbVarInitArrayDimensions _
	( _
		byval sym as FBSYMBOL ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	)

	if( dimensions <> 0 ) then
		if( symbGetIsDynamic( sym ) ) then
			sym->var_.array.dimensions = dimensions
		else
			symbSetArrayDimTb( sym, dimensions, dTB() )
		end if

		if( (not symbIsField( sym )) and (not symbIsParamBydesc( sym )) ) then
			symbMaybeAddArrayDesc( sym )
		end if
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
	symbVarInitFields( s )
	symbVarInitArrayDimensions( s, dimensions, dTB() )

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

'' Calculate a static array's total number of elements, all dimensions together.
'' <first> may be specified to calculate only the elements for <first> and the
'' following dimensions.
function symbCalcArrayElements _
	( _
		byval sym as FBSYMBOL ptr, _
		byval first as integer _
	) as longint

	dim as longint totalelements = any

	totalelements = 1
	for i as integer = first to sym->var_.array.dimensions - 1
		totalelements *= (sym->var_.array.dimtb[i].upper - sym->var_.array.dimtb[i].lower) + 1
	next

	function = totalelements
end function

function symbCheckArraySize _
	( _
		byval dimensions as integer, _
		byval dimtb as FBARRAYDIM ptr, _
		byval lgt as longint, _
		byval is_on_stack as integer _
	) as integer

	dim as ulongint allelements = any
	dim as ulongint elements = any
	dim as integer found_too_big = any

	found_too_big = FALSE
	allelements = 1

	for i as integer = 0 to dimensions - 1
		'' ellipsis upper bound?
		if( dimtb[i].upper = FB_ARRAYDIM_UNKNOWN ) then
			'' Each dimension using ellipsis will have at least 1 element,
			'' this is what can be assumed for now. (The check will need
			'' to be repeated later when the real size is known)
			elements = 1
		else
			'' elements for this array dimension
			elements = (dimtb[i].upper - dimtb[i].lower) + 1
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
		if( is_on_stack and (allelements > culngint( env.clopt.stacksize )) ) then
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

	'' assuming only temp vars or temp array descs will be cloned
	if( symbIsDescriptor( sym ) ) then
		function = symbAddArrayDesc( sym->var_.desc.array )
		'' no need to dup desc.initree, it was flushed in newARG() and
		'' should be fixed up with the new symbol in TypeIniFlush()
	elseif( symbIsTemp( sym ) ) then
		function = symbAddTempVar( symbGetType( sym ), symbGetSubType( sym ) )
	else
		if( symbIsDynamic( sym ) = FALSE ) then
			'' Fill the dTB() with the array's dimensions, if any
			for i as integer = 0 to symbGetArrayDimensions( sym ) - 1
				dTB(i) = symbGetArrayDim( sym, i )
			next
		end if

		function = symbAddVar( symbGetName( sym ), NULL, _
				symbGetType( sym ), symbGetSubType( sym ), 0, _
				symbGetArrayDimensions( sym ), dTB(), symbGetAttrib( sym ), 0 )
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

sub symbDelVar( byval s as FBSYMBOL ptr, byval is_tbdel as integer )
	symbDropArrayDims( s )
	if( is_tbdel = FALSE ) then
		'' del the array descriptor, recursively
		if( s->var_.array.desc ) then
			symbDelSymbol( s->var_.array.desc, FALSE )
		end if
	end if

	if( symbGetIsLiteral( s ) ) then
		if( typeGetDtAndPtrOnly( s->typ ) = FB_DATATYPE_WCHAR ) then
			if( s->var_.littextw <> NULL ) then
				WstrFree( s->var_.littextw )
			end if
		else
			if( s->var_.littext <> NULL ) then
				ZstrFree( s->var_.littext )
			end if
		end if
	end if

	'' Note: FBSYMBOL.var_.initree will be free'ed by astEnd() already

	symbFreeSymbol( s )
end sub
