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


'' symbol mangling module (compatible with the GCC 3.x ABI)
''
'' chng: may/2006 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\hash.bi"
#include once "inc\emit.bi"

type FB_MANGLEABBR
	idx			as integer
	sig			as zstring ptr
	item		as HASHITEM ptr
	hash		as uinteger
end type

type FB_MANGLECTX
	list		as TLIST					'' of FB_MANGLEABBR
	hashtb		as THASH
	cnt			as integer
end type

const FB_INITMANGARGS = 96


declare function 	hDoCppMangling 			( _
												byval sym as FBSYMBOL ptr, _
												byval mangling as FB_MANGLING _
											) as integer

declare function	hMangleProc  			( _
												byval sym as FBSYMBOL ptr _
											) as zstring ptr

declare function	hMangleVariable  		( _
												byval sym as FBSYMBOL ptr _
											) as zstring ptr

declare function	hMangleCompType			( _
												byval sym as FBSYMBOL ptr, _
												byval checkhash as integer, _
												byval checkns as integer _
											) as zstring ptr

declare function 	hGetProcParamsTypeCode 	( _
												byval sym as FBSYMBOL ptr _
											) as string

'' globals

	dim shared as FB_MANGLECTX ctx

	dim shared as zstring * 1+1 typecodeTB( 0 to FB_DATATYPES-1 ) => _
	{ _
		"v", _					'' void
		"a", _					'' byte
		"b", _					'' ubyte
		"c", _                  '' char
		"s", _                  '' short
		"t", _                  '' ushort
		"w", _                  '' wchar
		"i", _                  '' integer
		"j", _                  '' uinteger
		"!", _                  '' enum
		"!", _                  '' bitfield
		"x", _                  '' longint
		"y", _                  '' ulongint
		"f", _                  '' single
		"d", _                  '' double
		"r", _                  '' var-len string
		"!", _                  '' fix-len string
		"!", _                  '' udt
		"F", _					'' function
		"!", _                  '' fwd-ref
		"P" _                   '' pointer
	}

'':::::
sub symbMangleInit( )

	hashNew( @ctx.hashtb, FB_INITMANGARGS )

	listNew( @ctx.list, FB_INITMANGARGS, len( FB_MANGLEABBR ), LIST_FLAGS_NOCLEAR )

	ctx.cnt = 0

end sub

'':::::
sub symbMangleEnd( )

	listFree( @ctx.list  )

	hashFree( @ctx.hashtb  )

end sub

'':::::
function symbGetDBGName _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr

    '' GDB will demangle the symbols automatically
	if( hDoCppMangling( sym, symbGetMangling( sym ) ) ) then
		function = symbGetMangledName( sym )
	else
		function = sym->name
	end if

end function

'':::::
sub symbSetName _
	( _
		byval s as FBSYMBOL ptr, _
		byval name_ as zstring ptr _
	) static

	dim as integer slen

	'' assuming only params will change names, no mangling reseted

	if( s->name <> NULL ) then
		poolDelItem( @symb.namepool, s->name ) 'ZstrFree( s->name )
	end if

	slen = len( *name_ )
	if( slen = 0 ) then
		s->name = NULL
	else
		s->name = poolNewItem( @symb.namepool, slen + 1 ) 'ZStrAllocate( slen )
		*s->name = *name_
	end if

end sub

'':::::
function symbGetMangledNameEx _
	( _
		byval sym as FBSYMBOL ptr, _
		byval checkhash as integer _
	) as zstring ptr

	dim as zstring ptr id_alias = any

	if( (sym->stats and FB_SYMBSTATS_MANGLED) <> 0 ) then
		return sym->alias
	end if

    select case as const sym->class
    case FB_SYMBCLASS_PROC
		id_alias = hMangleProc( sym )

	case FB_SYMBCLASS_ENUM, FB_SYMBCLASS_UDT
    	id_alias = hMangleCompType( sym, checkhash, FALSE )

	case FB_SYMBCLASS_NAMESPACE
    	id_alias = hMangleCompType( sym, checkhash, TRUE )

	case FB_SYMBCLASS_VAR
    	id_alias = hMangleVariable( sym )

	case else
    	return sym->alias
	end select

	if( sym->alias <> NULL ) then
		ZStrFree( sym->alias )
	end if

	sym->alias = id_alias

	sym->stats or= FB_SYMBSTATS_MANGLED

	function = id_alias

end function

'':::::
sub symbMangleInitAbbrev( )

	ctx.cnt = 0

end sub

'':::::
private function hAbbrevAdd _
	( _
		byval sig as zstring ptr, _
		byval slen as integer, _
		byval hash as uinteger _
	) as FB_MANGLEABBR ptr static

    dim as FB_MANGLEABBR ptr n

    n = listNewNode( @ctx.list )
    n->idx = ctx.cnt
    if( slen > 0 ) then
    	n->sig = ZStrAllocate( slen )
    	*n->sig = *sig
    else
    	n->sig = sig
    end if
	n->hash = hash
    n->item = hashAdd( @ctx.hashtb, n->sig, n, hash )

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
sub symbMangleEndAbbrev( ) static
	dim as FB_MANGLEABBR ptr n, nxt

	'' del abbreviation list
	n = listGetHead( @ctx.list )
	do while( n <> NULL )
		nxt = listGetNext( n )

		hashDel( @ctx.hashtb, n->item, n->hash )
		ZstrFree( n->sig )
		listDelNode( @ctx.list, n )

		n = nxt
	loop

	ctx.cnt = 0

end sub

'':::::
private function hAddUnderscore _
	( _
	) as integer static

	static as integer inited = FALSE, res

	if( inited = FALSE ) then
		inited = TRUE

		select case as const env.clopt.target
    	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
        	if( env.clopt.nounderprefix ) then
	        	res = FALSE
    	    else
        		res = TRUE
        	end if

		case FB_COMPTARGET_LINUX
			res = FALSE

		case FB_COMPTARGET_DOS, FB_COMPTARGET_XBOX
        	res = TRUE
    	end select
    end if

	function = res

end function

'':::::
private function hDoCppMangling _
	( _
		byval sym as FBSYMBOL ptr, _
		byval mangling as FB_MANGLING _
	) as integer

    '' C++?
    if( mangling = FB_MANGLING_CPP ) then
    	return TRUE
    end if

    '' explicit alias?
    if( (sym->stats and FB_SYMBSTATS_HASALIAS) <> 0 ) then
    	return FALSE
    end if

    '' inside a namespace or class?
    if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
    	return TRUE
    end if

    if( sym->class = FB_SYMBCLASS_PROC ) then
    	'' overloaded?
    	if( symbIsOverloaded( sym ) ) then
    		return TRUE
    	end if
    end if

	function = FALSE

end function

'':::::
private function hGetNamespace _
	( _
		byval sym as FBSYMBOL ptr, _
		byval checkhash as integer _
	) as zstring ptr static

	dim as FBSYMBOL ptr ns
	dim as zstring ptr id_alias

	ns = symbGetNamespace( sym )
	if( ns = @symbGetGlobalNamespc( ) ) then
		return NULL
	end if

    if( checkhash = FALSE ) then
    	return symbGetMangledNameEx( ns, FALSE )
    end if

    '' can't set or use the UDT alias because the debugging
    '' symbols, emit_stabs will call GetDBGName() recursively
    '' if the UDT types were not emitted yet
    id_alias = hMangleCompType( ns, TRUE, TRUE )

    dim as uinteger hash
    dim as FB_MANGLEABBR ptr n
    hash = hashHash( id_alias )
    n = hashLookupEx( @ctx.hashtb, id_alias, hash )
    if( n = NULL ) then
       	'' don't copy id_alias, pass len as 0
       	hAbbrevAdd( id_alias, 0, hash )
	else
       	ZStrFree( id_alias )
       	id_alias = hAbbrevGet( n->idx )
	end if

	function = id_alias

end function

'':::::
private function hMangleCompType _
	( _
		byval sym as FBSYMBOL ptr, _
		byval checkhash as integer, _
		byval checkns as integer _
	) as zstring ptr static

    dim as zstring ptr id_str, nspc_str, dst, id_alias
    dim as integer id_len, nspc_len, addprefix

    nspc_len = 0
    if( checkns ) then
    	'' namespace
    	nspc_str = hGetNamespace( sym, checkhash )
    	if( nspc_str <> NULL ) then
    		nspc_len = len( *nspc_str )
    	end if
    else
    	nspc_str = NULL
    end if

    '' id
    id_str = sym->alias
    if( id_str = NULL ) then
    	id_str = sym->name
    	addprefix = TRUE
    else
    	'' only add the prefix if not mangled already
    	addprefix = (sym->stats and FB_SYMBSTATS_MANGLED) = 0
    end if

    id_len = len( *id_str )

	'' concat
	id_alias = ZStrAllocate( nspc_len + id_len + 2 )

	dst = id_alias
	if( nspc_str <> NULL ) then
		*dst = *nspc_str
		dst += nspc_len
	end if

	if( checkns and addprefix ) then
		if( id_len < 10 ) then
			*dst = CHAR_0 + id_len
			dst += 1
		else
			*(dst+0) = CHAR_0 + (id_len \ 10)
			*(dst+1) = CHAR_0 + (id_len mod 10)
			dst += 2
		end if
	end if

	*dst = *id_str

	function = id_alias

end function

'':::::
private function hGetVarPrefix _
	( _
		byval sym as FBSYMBOL ptr, _
		byval docpp as integer _
	) as zstring ptr static

	dim as integer isimport

	'' local or argument? no prefix
	if( (sym->attrib and (FB_SYMBATTRIB_PUBLIC or _
			 		   	  FB_SYMBATTRIB_EXTERN or _
			 			  FB_SYMBATTRIB_SHARED or _
			 			  FB_SYMBATTRIB_COMMON or _
			 			  FB_SYMBATTRIB_STATIC)) = 0 ) then
		return NULL
	end if

	'' imported? Windows only..
	isimport = FALSE
	select case env.clopt.target
    case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
		isimport = symbIsImport( sym )
	end select

	'' no C++? do nothing..
	if( docpp = FALSE ) then
		if( isimport ) then
			return @"__imp__"

		else
			if( hAddUnderscore( ) ) then
				return @"_"
			else
				return NULL
			end if
		end if
	end if

	'' inside a namespace or class?
	if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
		if( isimport ) then
			return @"__imp__ZN"

		else
			if( hAddUnderscore( ) ) then
				return @"__ZN"
			else
				return @"_ZN"
			end if
		end if
	end if

	'' not nested..
	if( isimport ) then
		return @"__imp__Z"

	else
		if( hAddUnderscore( ) ) then
			return @"__Z"
		else
			return @"_Z"
		end if
	end if

end function

'':::::
private function hGetVarIdentifier _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as zstring ptr, _
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

    dim as zstring ptr prefix_str, nspc_str, id_str, suffix_str
    dim as integer prefix_len, nspc_len, id_len, suffix_len, docpp, isglobal
    dim as FB_MANGLING mangling

    mangling = symbGetMangling( sym )

	'' local? no mangling
	if( sym->scope > FB_MAINSCOPE ) then
		docpp = FALSE
	else
		docpp = hDoCppMangling( sym, mangling )
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
    	nspc_str = hGetNamespace( sym, FALSE )
    	if(	nspc_str <> NULL ) then
    		nspc_len = len( *nspc_str )
    	end if
    else
    	nspc_str = NULL
    end if

    '' class
    ''class_str = hGetClass( sym )

    '' id
    suffix_str = NULL
    suffix_len = 0

    '' alias explicitly given?
    if( (sym->stats and FB_SYMBSTATS_HASALIAS) <> 0 ) then
    	id_str = sym->alias

    else
		'' shared, public, extern or inside a n?
		isglobal = (sym->attrib and (FB_SYMBATTRIB_PUBLIC or _
			 			   	  		 FB_SYMBATTRIB_EXTERN or _
			 				  		 FB_SYMBATTRIB_SHARED or _
			 				  		 FB_SYMBATTRIB_COMMON)) <> 0


		if( isglobal or docpp ) then

    		'' BASIC? use the upper-cased name
    		if( mangling = FB_MANGLING_BASIC ) then
				id_str = sym->name

			'' else, the case-sensitive name saved in the alias..
			else
	    		id_str = sym->alias
			end if

    		'' suffixed?
    		if( sym->var.suffix <> INVALID ) then
    			suffix_str = @typecodeTB( sym->var.suffix )
    			suffix_len = 1
    		end if

		'' static?
		elseif( symbIsStatic( sym ) ) then
			id_str = hMakeTmpStr( FALSE )

		'' local..
		else
			id_str = emitGetFramePtrName( )
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

	if( nspc_str <> NULL ) then
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
	if(	nspc_str <> NULL ) then
		dst[0] = asc( "E" )
		dst[1] = 0
	end if

	function = id_alias

end function

'':::::
private function hGetProcIdentifier _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as zstring ptr _
	) as zstring ptr static

    static as string res

    res = str( len( *id ) )
    res += *id

    function = strptr( res )

end function

'':::::
private function hGetProcPrefix _
	( _
		byval sym as FBSYMBOL ptr, _
		byval docpp as integer _
	) as zstring ptr static

	'' no C++? do nothing..
	if( docpp = FALSE ) then
		if( hAddUnderscore( ) ) then
			return @"_"
		else
			return NULL
		end if
	end if

	'' inside a namespace or class?
	if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
		if( hAddUnderscore( ) ) then
			return @"__ZN"
		else
			return @"_ZN"
		end if
	end if

	'' not nested..
	if( hAddUnderscore( ) ) then
		return @"__Z"
	else
		return @"_Z"
	end if

end function

'':::::
private function hGetProcSuffix _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr static

	static as zstring * 1 + 10 + 1 suffix = "@"

    if( env.clopt.nostdcall ) then
    	return NULL
    end if

    if( sym->proc.mode <> FB_FUNCMODE_STDCALL ) then
    	return NULL
    end if

	*(@suffix + 1) = str( sym->proc.lgt )

	function = @suffix

end function

'':::::
function symbMangleType _
	( _
		byval sym as FBSYMBOL ptr _
	) as string

    dim as string sig
    dim as uinteger hash = any
    dim as integer dtype = any, slen = any, pcnt = any, idx = any, issimple = any
    dim as FB_MANGLEABBR ptr n = any

    '' follow the GCC 3.x ABI..

    sig = ""

    dtype = sym->typ
    do while( dtype >= FB_DATATYPE_POINTER )
    	sig += "P"
    	dtype -= FB_DATATYPE_POINTER
    loop

    issimple = FALSE

    '' forward type?
    if( dtype = FB_DATATYPE_FWDREF ) then
    	if( sym->subtype = NULL ) then
    		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
    		dtype = FB_DATATYPE_VOID
    	else
    		dtype = FB_DATATYPE_USERDEF
    	end if
    end if

    select case as const dtype
    case FB_DATATYPE_USERDEF, FB_DATATYPE_ENUM
    	dim as zstring ptr id_alias

		'' nested (namespace or class)? open..
		if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
			sig += "N"
		end if

    	'' can't set or use the UDT alias because the debugging
    	'' symbols, emit_stabs will call GetDBGName() recursively
    	'' if the UDT types were not emitted yet
    	id_alias = hMangleCompType( sym->subtype, TRUE, TRUE )
    	sig += *id_alias
    	ZStrFree( id_alias )

		'' nested (namespace or class)? close..
		if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
			sig += "E"
		end if

    case FB_DATATYPE_FUNCTION
		'' F(return_type)(params - recursive, reuses hash)E
		sig += "F"
		sig += symbMangleType( sym->subtype )
		sig += hGetProcParamsTypeCode( sym->subtype )
		sig += "E"

    case FB_DATATYPE_STRING
       	sig += "8FBSTRING"

    case else
    	if( sym->ptrcnt = 0 ) then
    		return typecodeTB( dtype )
    	end if

    	sig += typecodeTB( dtype )
    	issimple = TRUE
    end select

    '' not repeated symbol?
    hash = hashHash( sig )
    n = hashLookupEx( @ctx.hashtb, sig, hash )
    if( n = NULL ) then
    	dim as zstring ptr sig2
    	dim as uinteger hash2

		'' add the this symbol w/o the indirection levels, one by one
		slen = len( sig )
		pcnt = sym->ptrcnt
    	do while( pcnt > 0 )

    		if( (issimple = FALSE) or (pcnt < sym->ptrcnt) ) then
    			sig2 = strptr( sig ) + pcnt
    			hash2 = hashHash( sig2 )
    			if( hashLookupEx( @ctx.hashtb, sig2, hash2 ) = NULL ) then
    				hAbbrevAdd( sig2, slen - pcnt, hash2 )
    			end if
    		end if

    		pcnt -= 1
    	loop

    	'' the main node
    	hAbbrevAdd( sig, slen, hash )

    	return sig
    end if

    '' already defined, use an abbreviation..
    function = *hAbbrevGet( n->idx )

end function

'':::::
private function hGetProcParamsTypeCode _
	( _
		byval sym as FBSYMBOL ptr _
	) as string

    dim as FBSYMBOL ptr param = any
    dim as string res

	param = sym->proc.paramtb.head

	'' no params?
	if( param = NULL ) then
		'' void
		res = "v"

	else
		res = ""

    	do
			select case symbGetParamMode( param )
			'' var arg?
			case FB_PARAMMODE_VARARG
				res += "z"
				exit do

			'' by reference (or descriptor)?
			case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
				res += "R"

			end select

			res += symbMangleType( param )

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
	if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
		res = "E"
		res += hGetProcParamsTypeCode( sym )

	else
		res = hGetProcParamsTypeCode( sym )
	end if

	function = strptr( res )

end function

'':::::
private function hMangleProc  _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr static

    dim as zstring ptr prefix_str, nspc_str, id_str, param_str, suffix_str
    dim as integer docpp, prefix_len, nspc_len, id_len, param_len, suffix_len
    dim as FB_MANGLING mangling

    mangling = symbGetMangling( sym )

    docpp = hDoCppMangling( sym, mangling )

    symbMangleInitAbbrev( )

    '' prefix
    prefix_len = 0
    prefix_str = hGetProcPrefix( sym, docpp )
	if( prefix_str <> NULL ) then
		prefix_len = len( *prefix_str )
	end if

    '' namespace
    nspc_len = 0
	if( docpp ) then
    	nspc_str = hGetNamespace( sym, TRUE )
    	if(	nspc_str <> NULL ) then
    		nspc_len = len( *nspc_str )
    	end if
    else
    	nspc_str = NULL
    end if

    '' class
    ''class_str = hGetClass( sym )

    '' id
    '' alias explicitly given?
    if( (sym->stats and FB_SYMBSTATS_HASALIAS) <> 0 ) then
    	id_str = sym->alias

    else
    	'' BASIC? use the upper-cased name
    	if( mangling = FB_MANGLING_BASIC ) then
			id_str = sym->name
		'' else, the case-sensitive name saved in the alias..
		else
	    	id_str = sym->alias
		end if
	end if

	if( docpp ) then
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
	dim as zstring ptr dst, id_alias

	id_alias = ZStrAllocate( prefix_len + nspc_len + id_len + param_len + suffix_len )

	dst = id_alias
	if( prefix_str <> NULL ) then
		*dst = *prefix_str
		dst += prefix_len
	end if

	if( nspc_str <> NULL ) then
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

	function = id_alias

   	symbMangleEndAbbrev( )

end function

