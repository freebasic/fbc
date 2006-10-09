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

'' AST conversion nodes
'' l = expression to convert; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private sub hCONVConstEvalInt _
	( _
		byval to_dtype as integer, _
		byval v as ASTNODE ptr _
	)

	if( to_dtype > FB_DATATYPE_POINTER ) then
		to_dtype = FB_DATATYPE_POINTER
	end if

	select case as const v->dtype
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		select case as const to_dtype
		case FB_DATATYPE_BYTE
			v->con.val.int = cbyte( v->con.val.long )

		case FB_DATATYPE_UBYTE
			v->con.val.int = cubyte( culngint( v->con.val.long ) )

		case FB_DATATYPE_SHORT
			v->con.val.int = cshort( v->con.val.long )

		case FB_DATATYPE_USHORT
			v->con.val.int = cushort( culngint( v->con.val.long ) )

		case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
			v->con.val.int = cint( v->con.val.long )

		case FB_DATATYPE_UINT, FB_DATATYPE_POINTER
			v->con.val.int = cuint( culngint( v->con.val.long ) )

		end select

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE

		select case as const to_dtype
		case FB_DATATYPE_BYTE
			v->con.val.int = cbyte( v->con.val.float )

		case FB_DATATYPE_UBYTE
			v->con.val.int = cubyte( v->con.val.float )

		case FB_DATATYPE_SHORT
			v->con.val.int = cshort( v->con.val.float )

		case FB_DATATYPE_USHORT
			v->con.val.int = cushort( v->con.val.float )

		case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
			v->con.val.int = cint( v->con.val.float )

		case FB_DATATYPE_UINT, FB_DATATYPE_POINTER
			v->con.val.int = cuint( v->con.val.float )

		end select

	case else
		select case as const to_dtype
		case FB_DATATYPE_BYTE
			v->con.val.int = cbyte( v->con.val.int )

		case FB_DATATYPE_UBYTE
			v->con.val.int = cubyte( cuint( v->con.val.int ) )

		case FB_DATATYPE_SHORT
			v->con.val.int = cshort( v->con.val.int )

		case FB_DATATYPE_USHORT
			v->con.val.int = cushort( cuint( v->con.val.int ) )
		end select

	end select

end sub

'':::::
private sub hCONVConstEvalFlt _
	( _
		byval to_dtype as integer, _
		byval v as ASTNODE ptr _
	)

	dim as integer vdtype = any

    vdtype = v->dtype
	if( vdtype > FB_DATATYPE_POINTER ) then
		vdtype = FB_DATATYPE_POINTER
	end if

	select case as const vdtype
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		'' do nothing..

	case FB_DATATYPE_LONGINT

		if( to_dtype = FB_DATATYPE_SINGLE ) then
			v->con.val.float = csng( v->con.val.long )
		else
			v->con.val.float = cdbl( v->con.val.long )
		end if

	case FB_DATATYPE_ULONGINT

		if( to_dtype = FB_DATATYPE_SINGLE ) then
			v->con.val.float = csng( cunsg( v->con.val.long ) )
		else
			v->con.val.float = cdbl( cunsg( v->con.val.long ) )
		end if

	case FB_DATATYPE_UINT, FB_DATATYPE_POINTER

		if( to_dtype = FB_DATATYPE_SINGLE ) then
			v->con.val.float = csng( cunsg( v->con.val.int ) )
		else
			v->con.val.float = cdbl( cunsg( v->con.val.int ) )
		end if

	case else

		if( to_dtype = FB_DATATYPE_SINGLE ) then
			v->con.val.float = csng( v->con.val.int )
		else
			v->con.val.float = cdbl( v->con.val.int )
		end if

	end select

end sub

'':::::
private sub hCONVConstEval64 _
	( _
		byval to_dtype as integer, _
		byval v as ASTNODE ptr _
	)

	select case as const v->dtype
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		'' do nothing

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		if( to_dtype = FB_DATATYPE_LONGINT ) then
			v->con.val.long = clngint( v->con.val.float )
		else
			v->con.val.long = culngint( v->con.val.float )
		end if

	case else
		'' when expanding to 64bit, we must take care of signedness of source operand

		if( to_dtype = FB_DATATYPE_LONGINT ) then
			if( symbIsSigned( v->dtype ) ) then
				v->con.val.long = clngint( v->con.val.int )
			else
				v->con.val.long = clngint( cuint( v->con.val.int ) )
			end if
		else
			if( symbIsSigned( v->dtype ) ) then
				v->con.val.long = culngint( v->con.val.int )
			else
				v->con.val.long = culngint( cuint( v->con.val.int ) )
			end if
		end if

	end select

end sub

'':::::
#macro hCheckPtr _
	( _
		to_dtype, _
		ldtype _
	)

    '' to pointer? only allow integers..
    if( to_dtype >= FB_DATATYPE_POINTER ) then
		select case as const ldtype
		case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_ENUM
		case else
			if( ldtype < FB_DATATYPE_POINTER ) then
				exit function
			end if
		end select

    '' from pointer? only allow integers..
    elseif( ldtype >= FB_DATATYPE_POINTER ) then
		select case as const to_dtype
		case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_ENUM
		case else
			if( to_dtype < FB_DATATYPE_POINTER ) then
				exit function
			end if
		end select
    end if

#endmacro

'':::::
function astCheckCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as integer

	dim as integer ldtype = any

	function = FALSE

	'' UDT? can't convert..
	if( to_dtype = FB_DATATYPE_STRUCT ) then
		exit function
	end if

	ldtype = l->dtype

    '' string? neither
    if( symbGetDataClass( ldtype ) = FB_DATACLASS_STRING ) then
    	exit function
	end if

	'' check pointers
	hCheckPtr( to_dtype, ldtype )

	select case ldtype
	'' CHAR and WCHAR literals are also from the INTEGER class
    case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    	'' don't allow, unless it's a deref pointer
    	if( astIsPTR( l ) = FALSE ) then
    		exit function
    	end if

    '' UDT's? ditto
    case FB_DATATYPE_STRUCT
    	exit function
    end select

	function = TRUE

end function

'':::::
#macro hDoGlobOpOverload( to_dtype, to_subtype, node )
	scope
		dim as FBSYMBOL ptr proc = any
		dim as FB_ERRMSG err_num = any

		proc = symbFindCastOvlProc( to_dtype, to_subtype, node, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			return astBuildCall( proc, 1, l )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				return NULL
			end if
		end if
	end scope
#endmacro

'':::::
function astNewCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr, _
		byval op as AST_OP, _
		byval check_str as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as integer ldclass = any, ldtype = any

	function = NULL

	'' try casting op overloading
	hDoGlobOpOverload( to_dtype, to_subtype, l )

    ldtype = l->dtype

	select case as const to_dtype
	'' to UDT? as op overloading failed, refuse.. ditto with void (used by uop/bop
	'' to cast to be most precise possible) and strings
	case FB_DATATYPE_VOID, FB_DATATYPE_STRING, _
		 FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		exit function

	case else
		select case ldtype
		'' from UDT? ditto..
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			exit function
		end select

	end select

    ldclass = symbGetDataClass( ldtype )

    select case op
    '' pointer typecasting?
    case AST_OP_TOPOINTER
		'' assuming all type-checking was done already
    	astSetType( l, to_dtype, to_subtype )

    	return l

	'' sign conversion?
	case AST_OP_TOSIGNED, AST_OP_TOUNSIGNED
		'' float? invalid
		if( ldclass <> FB_DATACLASS_INTEGER ) then
			exit function
		end if
    end select

	'' check pointers
	hCheckPtr( to_dtype, ldtype )

    '' string?
	if( check_str ) then
		select case as const ldtype
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		return rtlStrToVal( l, to_dtype )
    	end select

    else
    	if( ldclass = FB_DATACLASS_STRING ) then
    		exit function

    	'' CHAR and WCHAR literals are also from the INTEGER class
    	else
    		select case ldtype
    		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    			'' don't allow, unless it's a deref pointer
    			if( astIsPTR( l ) = FALSE ) then
    				exit function
    			end if
    	    end select
    	end if
    end if

	'' constant? evaluate at compile-time
	if( l->defined ) then

		select case as const to_dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			hCONVConstEval64( to_dtype, l )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			hCONVConstEvalFlt( to_dtype, l )
		case else
			'' byte's, short's, int's and enum's
			hCONVConstEvalInt( to_dtype, l )
		end select

		if( to_dtype <> FB_DATATYPE_ENUM ) then
			l->class = AST_NODECLASS_CONST
		else
			l->class = AST_NODECLASS_ENUM
		end if

		astSetType( l, to_dtype, to_subtype )

		return l
	end if

	'' only convert if the classes are different (ie, floating<->integer) or
	'' if sizes are different (ie, byte<->int)
	if( ldclass = symbGetDataClass( to_dtype ) ) then
		if( symbGetDataSize( ldtype ) = symbGetDataSize( to_dtype ) ) then
			'' check bitfields..
			if( l->class = AST_NODECLASS_FIELD ) then
				if( l->l->dtype = FB_DATATYPE_BITFIELD ) then
					'' only change the top node type
					l->dtype = to_dtype
					return l
				end if
			end if

			astSetType( l, to_dtype, to_subtype )
			return l
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONV, to_dtype, to_subtype )
	if( n = NULL ) then
		exit function
	end if

	n->l = l

	function = n

end function

'':::::
function astNewOvlCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

	'' try casting op overloading only
	hDoGlobOpOverload( to_dtype, to_subtype, l )

	'' nothing to do
	function = l

end function

'':::::
function astLoadCONV _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any
    dim as IRVREG ptr vs = any, vr = any

	l = n->l

	if( l = NULL ) then
		return NULL
	end if

	vs = astLoad( l )

	if( ast.doemit ) then
		vr = irAllocVREG( n->dtype )
		irEmitCONVERT( vr, n->dtype, vs, INVALID )
	end if

	astDelNode( l )

	function = vr

end function


