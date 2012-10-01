'' symbol mangling module (compatible with the GCC 3.x ABI)
''
'' chng: may/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "flist.bi"
#include once "hash.bi"
#include once "ir.bi"

type FB_MANGLEABBR
	idx				as integer
	dtype			as integer
	subtype			as FBSYMBOL ptr
end type

type FB_MANGLECTX
	flist			as TFLIST					'' of FB_MANGLEABBR
	cnt				as integer

	tempstr			as zstring * 6 + 10 + 1
	uniqueidcount		as integer
	uniquelabelcount	as integer
	profilelabelcount	as integer
end type

const FB_INITMANGARGS = 96


declare function hDoCppMangling _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

declare function hMangleProc _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr

declare function hMangleVariable _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr

declare function hGetProcParamsTypeCode _
	( _
		byval sym as FBSYMBOL ptr _
	) as string

'' globals

	dim shared as FB_MANGLECTX ctx

	dim shared as zstring * 1+1 typecodeTB( 0 to FB_DATATYPES-1 ) => _
	{ _
		"v", _					'' void
		"a", _					'' byte
		"h", _					'' ubyte
		"c", _                  '' char
		"s", _                  '' short
		"t", _                  '' ushort
		"w", _                  '' wchar
		"i", _                  '' integer
		"j", _                  '' uinteger
		"!", _                  '' enum
		"!", _                  '' bitfield
		"l", _                  '' long
		"m", _                  '' ulong
		"x", _                  '' longint
		"y", _                  '' ulongint
		"f", _                  '' single
		"d", _                  '' double
		"r", _                  '' var-len string
		"!", _                  '' fix-len string
		"!", _                  '' struct
		"!", _                  '' namespace
		"F", _					'' function
		"!", _                  '' fwd-ref
		"P" _                   '' pointer
	}

sub symbMangleInit( )
	flistInit( @ctx.flist, FB_INITMANGARGS, len( FB_MANGLEABBR ) )
	ctx.cnt = 0
	ctx.uniqueidcount = 0
	ctx.uniquelabelcount = 0
	ctx.profilelabelcount = 0
end sub

sub symbMangleEnd( )
	flistEnd( @ctx.flist  )
end sub

function symbUniqueId( ) as zstring ptr
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		ctx.tempstr = "tmp$"
		ctx.tempstr += str( ctx.uniqueidcount )
	else
		ctx.tempstr = "Lt_"
		ctx.tempstr += *hHexUInt( ctx.uniqueidcount )
	end if

	ctx.uniqueidcount += 1

	function = @ctx.tempstr
end function

function symbUniqueLabel( ) as zstring ptr
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		ctx.tempstr = "label$"
		ctx.tempstr += str( ctx.uniquelabelcount )
		ctx.uniquelabelcount += 1
	else
		ctx.tempstr = ".Lt_"
		ctx.tempstr += *hHexUInt( ctx.uniqueidcount )
		ctx.uniqueidcount += 1
	end if

	function = @ctx.tempstr
end function

function symbMakeProfileLabelName( ) as zstring ptr
	ctx.tempstr = "LP_" + *hHexUInt( ctx.profilelabelcount )
	ctx.profilelabelcount += 1
	function = @ctx.tempstr
end function

'':::::
function symbGetDBGName _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr

    '' GDB will demangle the symbols automatically
	if( hDoCppMangling( sym ) ) then

		select case as const symbGetClass( sym )
		'' but UDT's, they shouldn't include any mangling at all..
		case FB_SYMBCLASS_ENUM, FB_SYMBCLASS_STRUCT, _
			 FB_SYMBCLASS_CLASS, FB_SYMBCLASS_NAMESPACE

    		'' check if an alias wasn't given
    		dim as zstring ptr res = sym->id.alias
    		if( res = NULL ) then
    			res = sym->id.name
    		end if

    		return res

		case else
			return symbGetMangledName( sym )
		end select
	end if

	'' no mangling, return as-is
	function = sym->id.name

end function

'':::::
sub symbSetName _
	( _
		byval s as FBSYMBOL ptr, _
		byval name_ as zstring ptr _
	) static

	dim as integer slen

	'' assuming only params will change names, no mangling reseted

	if( s->id.name <> NULL ) then
		poolDelItem( @symb.namepool, s->id.name ) 'ZstrFree( s->id.name )
	end if

	slen = len( *name_ )
	if( slen = 0 ) then
		s->id.name = NULL
	else
		s->id.name = poolNewItem( @symb.namepool, slen + 1 ) 'ZStrAllocate( slen )
		*s->id.name = *name_
	end if

end sub

'':::::
private function hMangleCompType _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr

    static as zstring ptr id_str, dst, id_alias
    static as integer id_len

    '' id
    id_str = sym->id.alias
    if( id_str = NULL ) then
    	id_str = sym->id.name
    end if

    id_len = len( *id_str )

	'' concat
	id_alias = ZStrAllocate( id_len + 2 )

	dst = id_alias

	if( id_len < 10 ) then
		*dst = CHAR_0 + id_len
		dst += 1
	else
		*(dst+0) = CHAR_0 + (id_len \ 10)
		*(dst+1) = CHAR_0 + (id_len mod 10)
		dst += 2
	end if

	*dst = *id_str

	function = id_alias

end function

'':::::
function symbGetMangledName _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr

	dim as zstring ptr id_mangled = any

	if( (sym->stats and FB_SYMBSTATS_MANGLED) <> 0 ) then
		return sym->id.mangled
	end if

    select case as const symbGetClass( sym )
    case FB_SYMBCLASS_PROC
		id_mangled = hMangleProc( sym )

	case FB_SYMBCLASS_ENUM, FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_FWDREF, _
		 FB_SYMBCLASS_CLASS, FB_SYMBCLASS_NAMESPACE
    	id_mangled = hMangleCompType( sym )

	case FB_SYMBCLASS_VAR
    	id_mangled = hMangleVariable( sym )

	case else
    	return sym->id.alias
	end select

	sym->stats or= FB_SYMBSTATS_MANGLED

	sym->id.mangled = id_mangled

	'' silly periods..
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			hReplaceChar( id_mangled, asc( "." ), asc( "$" ) )
		end if
	end if

	function = id_mangled

end function

'':::::
sub symbMangleInitAbbrev( )

	ctx.cnt = 0

end sub

'':::::
sub symbMangleEndAbbrev( ) static

	'' reset abbreviation list
	flistReset( @ctx.flist )

	ctx.cnt = 0

end sub

'':::::
private function hAbbrevFind _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer static

	dim as FB_MANGLEABBR ptr n

	if( ctx.cnt = 0 ) then
		return -1
	end if

	'' builtin?
	if( subtype = NULL ) then
		if( typeIsPtr( dtype ) = FALSE ) then
			if( typeGet( dtype ) <> FB_DATATYPE_STRING ) then
				return -1
			end if
		end if
	end if

	'' for each item..
	n = flistGetHead( @ctx.flist )
	do while( n <> NULL )
		'' same type?
		if( n->subtype = subtype ) then
			if( astGetFullType( n ) = dtype ) then
				return n->idx
			end if
		end if

		n = flistGetNext( n )
	loop

	function = -1

end function

'':::::
private function hAbbrevAdd _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as FB_MANGLEABBR ptr static

    dim as FB_MANGLEABBR ptr n

    n = flistNewItem( @ctx.flist )
    n->idx = ctx.cnt

    astGetFullType( n ) = dtype
    n->subtype = subtype

    ctx.cnt += 1

    function = n

end function

'':::::
private function hAbbrevGet _
	( _
		byval idx as integer _
	) as zstring ptr static

    static as string res

    res = "S"

    if( idx > 0 ) then
    	if( idx <= 10 ) then
    		res += chr( asc( "0" ) + (idx - 1) )

    	elseif( idx <= 33 ) then
    		res += chr( asc( "A" ) + (idx - 11) )

    	else
    		'' 2 digits are enough for 333 abbreviations
    		res += chr( idx \ 33 )

    		idx mod= 33
    		if( idx <= 10 ) then
    			res += chr( asc( "0" ) + (idx - 1) )
    		elseif( idx <= 33 ) then
    			res += chr( asc( "A" ) + (idx - 11) )
    		end if
    	end if
    end if

    res += "_"

    function = strptr( res )

end function

'':::::
function symbMangleType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as string

	dim as integer idx = hAbbrevFind( dtype, subtype )
	if( idx <> -1 ) then
		return *hAbbrevGet( idx )
	end if

	dim as string sig

    '' forward type?
    if( typeGet( dtype ) = FB_DATATYPE_FWDREF ) then
    	if( subtype = NULL ) then
    		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
    		dtype = FB_DATATYPE_VOID
    	else
    		dtype = typeJoin( dtype and (not FB_DATATYPE_INVALID), FB_DATATYPE_STRUCT )
    	end if
    end if

    select case as const dtype
    case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS
    	dim as FBSYMBOL ptr ns = symbGetNamespace( subtype )
    	if( ns = @symbGetGlobalNamespc( ) ) then
    		sig = *symbGetMangledName( subtype )
    	else
			sig = "N"
    		sig += symbMangleType( symbGetFullType( ns ), ns )
    		sig += *symbGetMangledName( subtype )
    		sig += "E"
    	end if

    case FB_DATATYPE_NAMESPC
    	if( subtype = @symbGetGlobalNamespc( ) ) then
    		return ""
    	end if

    	dim as FBSYMBOL ptr ns = symbGetNamespace( subtype )
    	if( ns = NULL ) then
    		sig = ""
    	else
    		sig = symbMangleType( FB_DATATYPE_NAMESPC, ns )
    	end if

    	sig += *symbGetMangledName( subtype )

    case FB_DATATYPE_FUNCTION
		'' F(return_type)(params - recursive, reuses hash)E
		sig = "F"
		sig += symbMangleType( symbGetFullType( subtype ), symbGetSubtype( subtype ) )
		sig += hGetProcParamsTypeCode( subtype )
		sig += "E"

    case FB_DATATYPE_STRING
       	sig = "8FBSTRING"

	case else
		'' builtin?
		if( typeGet( dtype ) = dtype ) then
			return typecodeTB( dtype )
		end if

		'' reference?
		if( typeIsRef( dtype ) ) then
			'' const?
			if( typeIsConst( dtype ) ) then
				sig = "RK"
			else
				sig = "R"
			end if
			sig += symbMangleType( typeUnsetIsRef( dtype ), subtype )

		'' array?
		elseif( typeIsArray( dtype ) ) then
			sig = "A"
			sig += symbMangleType( typeUnsetIsArray( dtype ), subtype )

		'' pointer? (must be checked/emitted before CONST)
		elseif( typeIsPtr( dtype ) ) then
			'' const?
			if( typeIsConstAt( dtype, 1 ) ) then
				sig = "PK"
			else
				sig = "P"
			end if

			sig += symbMangleType( typeDeref( dtype ), subtype )

		'' const..
		else
			'' note: nothing is added (as in C++) because it's not a 'const ptr'
			sig += symbMangleType( typeUnsetIsConst( dtype ), subtype )

		end if

    end select

    hAbbrevAdd( dtype, subtype )

    function = sig

end function

''::::::
function symbMangleParam _
	( _
		byval param as FBSYMBOL ptr _
	) as string

	dim as integer dtype = symbGetFullType( param )

	select case as const symbGetParamMode( param )
	'' by reference (or descriptor)?
	case FB_PARAMMODE_BYREF
		dtype = typeSetIsRef( dtype )

	case FB_PARAMMODE_BYDESC
		dtype = typeSetIsRefAndArray( dtype )

       '' var arg?
	case FB_PARAMMODE_VARARG
		return "z"

	end select

	return symbMangleType( dtype, symbGetSubtype( param ) )

end function

'':::::
private function hAddUnderscore _
	( _
	) as integer static

	static as integer inited = FALSE, res

	if( inited = FALSE ) then
		inited = TRUE

		'' C backend? don't add anything..
		if( env.clopt.backend = FB_BACKEND_GCC ) then
			res = FALSE
		else
			res = ((env.target.options and FB_TARGETOPT_UNDERSCORE) <> 0)
		end if
	end if

	function = res

end function

'':::::
'' inside a namespace or class?
#define hIsNested(s) (symbGetNamespace( s ) <> @symbGetGlobalNamespc( ))

'':::::
private function hDoCppMangling _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

    '' C++?
    if( symbGetMangling( sym ) = FB_MANGLING_CPP ) then
    	return TRUE
    end if

    '' RTL or exclude parent?
    if( (symbGetStats( sym ) and (FB_SYMBSTATS_RTL or _
    							  FB_SYMBSTATS_EXCLPARENT)) <> 0 ) then
    	return FALSE
    end if

    '' inside a namespace or class?
    if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
    	return TRUE
    end if

    if( sym->class = FB_SYMBCLASS_PROC ) then
    	'' overloaded? (this will handle operators too)
    	if( symbIsOverloaded( sym ) ) then
    		return TRUE
    	end if
    end if

	function = FALSE

end function

'':::::
private function hMangleNamespace _
	( _
		byval ns as FBSYMBOL ptr, _
		byval dohashing as integer = TRUE, _
		byval isconst as integer = FALSE _
	) as zstring ptr static

	static as string res
	static as FBSYMBOL ptr nsStk(0 to FB_MAXNAMESPCRECLEVEL-1)
	dim as integer tos

   	if( ns = NULL ) then
   		return NULL
   	end if

	if( ns = @symbGetGlobalNamespc( ) ) then
		return NULL
	end if

	if( dohashing ) then
		res = symbMangleType( symbGetFullType( ns ), ns )
	end if

	'' create a stack
	tos = -1
	do
		tos += 1
		nsStk(tos) = ns
		ns = symbGetNamespace( ns )
    loop until( ns = @symbGetGlobalNamespc( ) )

	'' return the chain starting from base parent
	if( isconst ) then
		res = "NK"
	else
		res = "N"
	end if
	do
		ns = nsStk(tos)
		res += *symbGetMangledName( ns )
		tos -= 1
    loop until( tos < 0 )

    function = strptr( res )

end function

'':::::
private function hGetVarPrefix _
	( _
		byval sym as FBSYMBOL ptr, _
		byval docpp as integer _
	) as const zstring ptr

	static as integer isimport = FALSE

	'' not global or public? no prefix
	if( (sym->attrib and (FB_SYMBATTRIB_PUBLIC or _
			 		   	  FB_SYMBATTRIB_EXTERN or _
			 			  FB_SYMBATTRIB_SHARED or _
			 			  FB_SYMBATTRIB_COMMON or _
			 			  FB_SYMBATTRIB_STATIC)) = 0 ) then
		return NULL
	end if

	'' imported? Windows only..
	if( env.clopt.backend = FB_BACKEND_GAS ) then
		isimport = symbIsImport( sym )
	end if

	'' no C++? do nothing..
	if( docpp = FALSE ) then
		if( isimport ) then
			function = @"__imp__"

		else
			if( hAddUnderscore( ) ) then
				function = @"_"
			else
				function = NULL
			end if
		end if

	else
		'' Note: This adds the _Z prefix to all global variables,
		'' unlike GCC, which does C++ mangling only for globals inside
		'' namespaces, but not globals from the toplevel namespace.
		if( isimport ) then
			'' win32 import prefix + win32 underscore + C++ prefix
			'' __imp_ + _ + _Z
			function = @"__imp___Z"
		else
			if( hAddUnderscore( ) ) then
				function = @"__Z"
			else
				function = @"_Z"
			end if
		end if
	end if

end function

'':::::
private function hGetVarIdentifier _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as const zstring ptr, _
		byref id_len as integer, _
		byval suffix_len as integer _
	) as zstring ptr static

    static as string res

    res = str( id_len + suffix_len )
    id_len += len( res )
    res += *id

    function = strptr( res )

end function

'':::::
private function hMangleVariable  _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr static

    static as const zstring ptr prefix_str, nspc_str, id_str, suffix_str
    static as integer prefix_len, nspc_len, id_len, suffix_len, docpp, isglobal

	'' local? no mangling
	if( sym->scope > FB_MAINSCOPE ) then
		docpp = FALSE
	else
		docpp = hDoCppMangling( sym )
	end if

    '' prefix
    prefix_len = 0
    prefix_str = hGetVarPrefix( sym, docpp )
	if( prefix_str <> NULL ) then
		prefix_len = len( *prefix_str )
	end if

    '' namespace
    nspc_len = 0
	if( docpp ) then
    	nspc_str = hMangleNamespace( symbGetNamespace( sym ), FALSE )
    	if( nspc_str <> NULL ) then
    		nspc_len = len( *nspc_str )
    	end if
    end if

    '' class
    ''class_str = hGetClass( sym )

	'' id
	suffix_str = NULL
	suffix_len = 0

	'' alias explicitly given?
	if( (sym->stats and FB_SYMBSTATS_HASALIAS) <> 0 ) then
		id_str = sym->id.alias
	else
		'' shared, public, extern or inside a ns?
		isglobal = (sym->attrib and (FB_SYMBATTRIB_PUBLIC or _
			 			   	  		 FB_SYMBATTRIB_EXTERN or _
			 				  		 FB_SYMBATTRIB_SHARED or _
			 				  		 FB_SYMBATTRIB_COMMON)) <> 0

		if( isglobal or docpp ) then
			suffix_len = 0

			'' BASIC? use the upper-cased name
			if( symbGetMangling( sym ) = FB_MANGLING_BASIC ) then
				'' C backend?
				if( env.clopt.backend = FB_BACKEND_GCC ) then
					suffix_str = @"$"
					suffix_len = 1
				end if

				id_str = sym->id.name
			'' else, the case-sensitive name saved in the alias..
			else
				id_str = sym->id.alias
			end if

			'' suffixed?
			if( symbIsSuffixed( sym ) ) then
				if( suffix_len = 0 ) then
					suffix_str = @typecodeTB( symbGetType( sym ) )
				else
					static as string tmp
					tmp = typecodeTB( symbGetType( sym ) ) + "$"
					suffix_str = strptr( tmp )
				end if
				suffix_len += 1
			end if
		else
			'' C backend?
			if( env.clopt.backend = FB_BACKEND_GCC ) then
				'' ir-hlc emits statics with dtors as globals,
				'' so they need a unique name. Other statics are
				'' still emitted locally, so they can keep their
				'' own name, like other local vars.
				if( symbIsStatic( sym ) and symbHasDtor( sym ) ) then
					id_str = symbUniqueId( )
				else
					'' BASIC? use the upper-cased name
					if( symbGetMangling( sym ) = FB_MANGLING_BASIC ) then
						id_str = sym->id.name

						static as string tmp

						'' Using '$' to prevent collision with C keywords etc.
						'' ('$' isn't allowed as part of FB ids)
						tmp = "$"

						'' Type suffix?
						if( symbIsSuffixed( sym ) ) then
							'' Encode the type to prevent collisions with other variables
							'' using the same base id but different type suffix.
							tmp += typecodeTB( symbGetType( sym ) ) + "$"
						end if

						'' Append the scope level to prevent collisions with symbols
						'' from parent scopes or from the toplevel namespace.
						'' Note: locals from the main scope will start at level 0,
						'' while locals from procedures start at level 1,
						'' but that's ok as long as globals aren't suffixed with
						'' a level at all.
						tmp += str( sym->scope )

						suffix_str = strptr( tmp )
						suffix_len = len( tmp )

					'' else, the case-sensitive name saved in the alias..
					else
						id_str = sym->id.alias
					end if
				end if
			else
				'' static?
				if( symbIsStatic( sym ) ) then
					id_str = symbUniqueId( )
				'' local..
				else
					id_str = irProcGetFrameRegName( )
				end if
			end if
		end if
	end if

	id_len = len( *id_str )

	if( docpp ) then
		id_str = hGetVarIdentifier( sym, id_str, id_len, suffix_len )
	end if

	'' concat
	dim as zstring ptr dst, id_alias

	id_alias = ZStrAllocate( prefix_len + nspc_len + _
							 id_len + suffix_len + 1 ) '' +1 for the "E"

	dst = id_alias
	if( prefix_str <> NULL ) then
		*dst = *prefix_str
		dst += prefix_len
	end if

	if( nspc_len <> 0 ) then
		*dst = *nspc_str
		dst += nspc_len
	end if

	*dst = *id_str
	dst += id_len

	if( suffix_str <> NULL ) then
		*dst = *suffix_str
		dst += suffix_len
	end if

	'' nested? (namespace or class) close..
	if(	nspc_len <> 0 ) then
		dst[0] = asc( "E" )
		dst[1] = 0
	end if

	function = id_alias

end function

'':::::
private function hGetProcIdentifier _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as const zstring ptr _
	) as zstring ptr static

    static as string res

    '' property?
    if( symbIsProperty( sym ) ) then
    	static as string tmp
    	tmp = *id

    	'' GET?
    	if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then
    		tmp += "__get__"
    	else
    		tmp += "__set__"
    	end if

    	id = strptr( tmp )
    end if

    res = str( len( *id ) )
    res += *id

    function = strptr( res )

end function

'':::::
private function hGetProcPrefix _
	( _
		byval sym as FBSYMBOL ptr, _
		byval docpp as integer _
	) as const zstring ptr static

	'' no C++? do nothing..
	if( docpp = FALSE ) then
		if( hAddUnderscore( ) ) then
			function = @"_"
		else
			function = NULL
		end if
	else
		if( hAddUnderscore( ) ) then
			function = @"__Z"
		else
			function = @"_Z"
		end if
	end if

end function

'':::::
private function hGetProcSuffix _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr static

	static as zstring * 1 + 10 + 1 suffix = "@"

    '' Only add the @N suffix for STDCALL.
	if( sym->proc.mode <> FB_FUNCMODE_STDCALL ) then
		return NULL
	end if

	'' C backend? don't add anything..
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		return NULL
	end if

	*(@suffix + 1) = str( sym->proc.lgt )

	function = @suffix

end function

'':::::
private function hGetProcParamsTypeCode _
	( _
		byval sym as FBSYMBOL ptr _
	) as string

    dim as FBSYMBOL ptr param = any
    dim as string res
    dim as integer dtype = any

	param = symbGetProcHeadParam( sym )

	if( param <> NULL ) then
		'' instance pointer? skip..
		if( symbIsParamInstance( param ) ) then
			param = symbGetParamNext( param )
		end if
	end if

	'' no params?
	if( param = NULL ) then
		'' void
		res = "v"

	else
		res = ""

    	do
            res += symbMangleParam( param )

    		'' next
    		param = symbGetParamNext( param )
    	loop while( param <> NULL )
    end if

    function = res

end function

'':::::
private function hMangleProcParams _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr static

    static as string res

	'' nested? (namespace or class)
	if( hIsNested( sym ) ) then
		res = "E"
		res += hGetProcParamsTypeCode( sym )

	else
		res = hGetProcParamsTypeCode( sym )
	end if

	function = strptr( res )

end function

'':::::
private function hGetOperatorName _
	( _
		byval proc as FBSYMBOL ptr _
	) as const zstring ptr static

	''
	'' Most operators follow the "Operator Encodings" section of the
	'' Itanium C++ ABI.
	''
	'' However, FB has some operators that C++ doesn't have, these "custom"
	'' operators should use the predefined scheme of the ABI, to allow
	'' C++-compatible tools to demangle them:
	''    v <num-args> <length> <name>
	'' where <num-args> is the operand count as a single decimal
	'' digit, and <length> is the length of <name>.
	''
	select case as const symbGetProcOpOvl( proc )
	case AST_OP_ASSIGN
		function = @"aS"

	case AST_OP_ADD
		function = @"pl"

	case AST_OP_ADD_SELF
		function = @"pL"

	case AST_OP_SUB
		function = @"mi"

	case AST_OP_SUB_SELF
		function = @"mI"

	case AST_OP_MUL
		function = @"ml"

	case AST_OP_MUL_SELF
		function = @"mL"

	case AST_OP_DIV
		function = @"dv"

	case AST_OP_DIV_SELF
		function = @"dV"

	case AST_OP_INTDIV
		function = @"v24idiv"

	case AST_OP_INTDIV_SELF
		function = @"v28selfidiv"

	case AST_OP_MOD
		function = @"rm"

	case AST_OP_MOD_SELF
		function = @"rM"

	case AST_OP_AND
		function = @"an"

	case AST_OP_AND_SELF
		function = @"aN"

	case AST_OP_OR
		function = @"or"

	case AST_OP_OR_SELF
		function = @"oR"

	'' Note: The ANDALSO/ORELSE operators can't currently be
	'' overloaded, much less the self versions
	case AST_OP_ANDALSO
		function = @"aa"

	case AST_OP_ANDALSO_SELF
		function = @"aA" '' FB-specific

	case AST_OP_ORELSE
		function = @"oo"

	case AST_OP_ORELSE_SELF
		function = @"oO" '' FB-specific

	case AST_OP_XOR
		function = @"eo"

	case AST_OP_XOR_SELF
		function = @"eO"

	case AST_OP_EQV
		function = @"v23eqv"

	case AST_OP_EQV_SELF
		function = @"v27selfeqv"

	case AST_OP_IMP
		function = @"v23imp"

	case AST_OP_IMP_SELF
		function = @"v27selfimp"

	case AST_OP_SHL
		function = @"ls"

	case AST_OP_SHL_SELF
		function = @"lS"

	case AST_OP_SHR
		function = @"rs"

	case AST_OP_SHR_SELF
		function = @"rS"

	case AST_OP_POW
		function = @"v23pow"

	case AST_OP_POW_SELF
		function = @"v27selfpow"

	case AST_OP_CONCAT
		function = @"v23cat"

	case AST_OP_CONCAT_SELF
		function = @"v27selfcat"

	case AST_OP_EQ
		function = @"eq"

	case AST_OP_GT
		function = @"gt"

	case AST_OP_LT
		function = @"lt"

	case AST_OP_NE
		function = @"ne"

	case AST_OP_GE
		function = @"ge"

	case AST_OP_LE
		function = @"le"

	case AST_OP_NOT
		function = @"co"

	case AST_OP_NEG
		function = @"ng"

	case AST_OP_PLUS
		function = @"ps"

	case AST_OP_ABS
		function = @"v13abs"

	case AST_OP_FIX
		function = @"v13fix"

	case AST_OP_FRAC
		function = @"v14frac"

	case AST_OP_SGN
		function = @"v13sgn"

	case AST_OP_FLOOR
		function = @"v13int"

	case AST_OP_EXP
		function = @"v13exp"

	case AST_OP_LOG
		function = @"v13log"

	case AST_OP_SIN
		function = @"v13sin"

	case AST_OP_ASIN
		function = @"v14asin"

	case AST_OP_COS
		function = @"v13cos"

	case AST_OP_ACOS
		function = @"v14acos"

	case AST_OP_TAN
		function = @"v13tan"

	case AST_OP_ATAN
		function = @"v13atn"

	case AST_OP_NEW, AST_OP_NEW_SELF
		function = @"nw"

	case AST_OP_NEW_VEC, AST_OP_NEW_VEC_SELF
		function = @"na"

	case AST_OP_DEL, AST_OP_DEL_SELF
		function = @"dl"

	case AST_OP_DEL_VEC, AST_OP_DEL_VEC_SELF
		function = @"da"

	case AST_OP_DEREF
		function = @"de"

	case AST_OP_FLDDEREF
		function = @"pt"

	case AST_OP_ADDROF
		function = @"ad"

	case AST_OP_FOR
		'' operator T.for( [ as T ] )
		if( symbGetProcParams( proc ) = 2 ) then
			function = @"v13for"
		else
			assert( symbGetProcParams( proc ) = 1 )
			function = @"v03for"
		end if

	case AST_OP_STEP
		'' operator T.step( [ as T ] )
		if( symbGetProcParams( proc ) = 2 ) then
			function = @"v14step"
		else
			assert( symbGetProcParams( proc ) = 1 )
			function = @"v04step"
		end if

	case AST_OP_NEXT
		'' operator T.next( as T [ , as T ] )
		if( symbGetProcParams( proc ) = 3 ) then
			function = @"v24next"
		else
			assert( symbGetProcParams( proc ) = 2 )
			function = @"v14next"
		end if

	case AST_OP_CAST
		static as string res

		res = "cv"

		'' mangle the return type
		res += symbMangleType( symbGetFullType( proc ), symbGetSubtype( proc ) )

		function = strptr( res )

	end select

end function

'':::::
private function hGetCtorName _
	( _
		byval sym as FBSYMBOL ptr _
	) as const zstring ptr static

	'' !!!FIXME!!! g++ will emit two ctors/dtors if the base
	'' class is virtual

	'' ctor?
	if( symbIsConstructor( sym ) ) then
		function = @"C1"

	'' dtor..
	else
		function = @"D1"
	end if

end function

'':::::
private function hMangleProc  _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr

    dim as const zstring ptr prefix_str = any, nspc_str = any, id_str = any, param_str = any, suffix_str = any
    dim as integer prefix_len = any, nspc_len = any, id_len = any, param_len = any, suffix_len = any, add_len = any
    dim as integer docpp = any

    docpp = hDoCppMangling( sym )

    symbMangleInitAbbrev( )

    '' prefix
    prefix_len = 0
    prefix_str = hGetProcPrefix( sym, docpp )
	if( prefix_str <> NULL ) then
		prefix_len = len( *prefix_str )
	end if

    '' namespace or class
	nspc_len = 0
	if( docpp ) then
    	nspc_str = hMangleNamespace( symbGetNamespace( sym ), , symbIsConstant( sym ) )
    	if( nspc_str <> NULL ) then
    		nspc_len = len( *nspc_str )
    	end if
    end if

    '' id
    add_len = docpp

    '' alias explicitly given?
    if( (sym->stats and FB_SYMBSTATS_HASALIAS) <> 0 ) then
    	id_str = sym->id.alias

    else
    	'' operator?
    	if( symbIsOperator( sym ) ) then
            id_str = hGetOperatorName( sym )
            add_len = FALSE

    	else
    		'' ctor/dtor?
    		if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_CONSTRUCTOR or _
    								   	   FB_SYMBATTRIB_DESTRUCTOR)) <> 0 ) then
            	id_str = hGetCtorName( sym )
            	add_len = FALSE

			else
    			'' BASIC? use the upper-cased name
    			if( symbGetMangling( sym ) = FB_MANGLING_BASIC ) then
					id_str = sym->id.name
				'' else, the case-sensitive name saved in the alias..
				else
	    			id_str = sym->id.alias
				end if
			end if
		end if
	end if

	if( add_len ) then
		id_str = hGetProcIdentifier( sym, id_str )
	end if

	id_len = len( *id_str )

	'' params
	param_len = 0
	if( docpp ) then
		param_str = hMangleProcParams( sym )
		if( param_str <> NULL ) then
			param_len = len( *param_str )
		end if
	else
		param_str = NULL
	end if

    '' suffix
    suffix_len = 0
    suffix_str = hGetProcSuffix( sym )
    if( suffix_str <> NULL ) then
    	suffix_len = len( *suffix_str )
    end if

	'' concat
	dim as zstring ptr dst = any, id_alias = any

	var tlen = prefix_len + nspc_len + id_len + param_len + suffix_len
	if tlen = 0 then
		id_alias = NULL

	else
		id_alias = ZStrAllocate( tlen )

		dst = id_alias
		if( prefix_str <> NULL ) then
			*dst = *prefix_str
			dst += prefix_len
		end if

		if( nspc_len <> 0 ) then
			*dst = *nspc_str
			dst += nspc_len
		end if

		*dst = *id_str
		dst += id_len

		if( param_str <> NULL ) then
			*dst = *param_str
			dst += param_len
		end if

		if( suffix_str <> NULL ) then
			*dst = *suffix_str
		end if
    end if

	function = id_alias

   	symbMangleEndAbbrev( )

end function

