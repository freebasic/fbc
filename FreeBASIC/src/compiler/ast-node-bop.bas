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

'' AST binary operation nodes
'' l = left operand expression; r = right operand expression
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\dstr.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private function hStrLiteralConcat _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr s, ls, rs

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	'' new len = both strings' len less the 2 null-chars
	s = symbAllocStrConst( *symbGetVarLitText( ls ) + *symbGetVarLitText( rs ), _
						   symbGetStrLen( ls ) - 1 + symbGetStrLen( rs ) - 1 )

	function = astNewVAR( s, 0, FB_DATATYPE_CHAR )

	astDelNode( r )
	astDelNode( l )

end function

'':::::
private function hWstrLiteralConcat _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr s, ls, rs

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	if( symbGetType( ls ) <> FB_DATATYPE_WCHAR ) then
		'' new len = both strings' len less the 2 null-chars
		s = symbAllocWstrConst( wstr( *symbGetVarLitText( ls ) ) + *symbGetVarLitTextW( rs ), _
						    	symbGetStrLen( ls ) - 1 + symbGetWstrLen( rs ) - 1 )

	elseif( symbGetType( rs ) <> FB_DATATYPE_WCHAR ) then
		s = symbAllocWstrConst( *symbGetVarLitTextW( ls ) + wstr( *symbGetVarLitText( rs ) ), _
						    	symbGetWstrLen( ls ) - 1 + symbGetStrLen( rs ) - 1 )

	else
		s = symbAllocWstrConst( *symbGetVarLitTextW( ls ) + *symbGetVarLitTextW( rs ), _
						    	symbGetWstrLen( ls ) - 1 + symbGetWstrLen( rs ) - 1 )
    end if

	function = astNewVAR( s, 0, FB_DATATYPE_WCHAR )

	astDelNode( r )
	astDelNode( l )

end function

'':::::
private function hStrLiteralCompare _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr static

    static as DZSTRING ltext, rtext
    dim as integer res

   	DZstrAssign( ltext, hUnescape( symbGetVarLitText( astGetSymbol( l ) ) ) )
   	DZstrAssign( rtext, hUnescape( symbGetVarLitText( astGetSymbol( r ) ) ) )

   	select case as const op
   	case AST_OP_EQ
   		res = (*ltext.data = *rtext.data)
   	case AST_OP_GT
   		res = (*ltext.data > *rtext.data)
   	case AST_OP_LT
   		res = (*ltext.data < *rtext.data)
   	case AST_OP_NE
   		res = (*ltext.data <> *rtext.data)
   	case AST_OP_LE
   		res = (*ltext.data <= *rtext.data)
   	case AST_OP_GE
   		res = (*ltext.data >= *rtext.data)
   	end select

	function = astNewCONSTi( res, FB_DATATYPE_INTEGER )

	astDelNode( r )
	astDelNode( l )

end function

'':::::
private function hWStrLiteralCompare _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr static

    dim as FBSYMBOL ptr ls, rs
    static as DZSTRING textz
    static as DWSTRING ltextw, rtextw
    dim as integer res

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	'' left operand not a wstring?
	if( symbGetType( ls ) <> FB_DATATYPE_WCHAR ) then
   		DZstrAssign( textz, hUnescape( symbGetVarLitText( ls ) ) )
   		DWstrAssign( rtextw, hUnescapeW( symbGetVarLitTextW( rs ) ) )

   		select case as const op
   		case AST_OP_EQ
   			res = (*textz.data = *rtextw.data)
   		case AST_OP_GT
   			res = (*textz.data > *rtextw.data)
   		case AST_OP_LT
   			res = (*textz.data < *rtextw.data)
   		case AST_OP_NE
   			res = (*textz.data <> *rtextw.data)
   		case AST_OP_LE
   			res = (*textz.data <= *rtextw.data)
   		case AST_OP_GE
   			res = (*textz.data >= *rtextw.data)
   		end select

   	'' right operand?
   	elseif( symbGetType( rs ) <> FB_DATATYPE_WCHAR ) then
   		DWstrAssign( ltextw, hUnescapeW( symbGetVarLitTextW( ls ) ) )
   		DZstrAssign( textz, hUnescape( symbGetVarLitText( rs ) ) )

   		select case as const op
   		case AST_OP_EQ
   			res = (*ltextw.data = *textz.data)
   		case AST_OP_GT
   			res = (*ltextw.data > *textz.data)
   		case AST_OP_LT
   			res = (*ltextw.data < *textz.data)
   		case AST_OP_NE
   			res = (*ltextw.data <> *textz.data)
   		case AST_OP_LE
   			res = (*ltextw.data <= *textz.data)
   		case AST_OP_GE
   			res = (*ltextw.data >= *textz.data)
   		end select

   	'' both wstrings..
   	else
   		DWstrAssign( ltextw, hUnescapeW( symbGetVarLitTextW( ls ) ) )
   		DWstrAssign( rtextw, hUnescapeW( symbGetVarLitTextW( rs ) ) )

   		select case as const op
   		case AST_OP_EQ
   			res = (*ltextw.data = *rtextw.data)
   		case AST_OP_GT
   			res = (*ltextw.data > *rtextw.data)
   		case AST_OP_LT
   			res = (*ltextw.data < *rtextw.data)
   		case AST_OP_NE
   			res = (*ltextw.data <> *rtextw.data)
   		case AST_OP_LE
   			res = (*ltextw.data <= *rtextw.data)
   		case AST_OP_GE
   			res = (*ltextw.data >= *rtextw.data)
   		end select

   	end if

	function = astNewCONSTi( res, FB_DATATYPE_INTEGER )

	astDelNode( r )
	astDelNode( l )

end function

'':::::
private sub hBOPConstFoldInt _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) static

	dim as integer issigned

	select case as const l->dtype
	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
		issigned = TRUE
	case else
		issigned = FALSE
	end select

	select case as const op
	case AST_OP_ADD
		l->con.val.int = l->con.val.int + r->con.val.int

	case AST_OP_SUB
		l->con.val.int = l->con.val.int - r->con.val.int

	case AST_OP_MUL
		if( issigned ) then
			l->con.val.int = l->con.val.int * r->con.val.int
		else
			l->con.val.int = cunsg(l->con.val.int) * cunsg(r->con.val.int)
		end if

	case AST_OP_INTDIV
		if( r->con.val.int <> 0 ) then
			if( issigned ) then
				l->con.val.int = l->con.val.int \ r->con.val.int
			else
				l->con.val.int = cunsg( l->con.val.int ) \ cunsg( r->con.val.int )
			end if
		else
			l->con.val.int = 0
			errReport( FB_ERRMSG_DIVBYZERO )
		end if

	case AST_OP_MOD
		if( r->con.val.int <> 0 ) then
			if( issigned ) then
				l->con.val.int = l->con.val.int mod r->con.val.int
			else
				l->con.val.int = cunsg( l->con.val.int ) mod cunsg( r->con.val.int )
			end if
		else
			l->con.val.int = 0
			errReport( FB_ERRMSG_DIVBYZERO )
		end if

	case AST_OP_SHL
		if( issigned ) then
			l->con.val.int = l->con.val.int shl r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) shl r->con.val.int
		end if

	case AST_OP_SHR
		if( issigned ) then
			l->con.val.int = l->con.val.int shr r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) shr r->con.val.int
		end if

	case AST_OP_AND
		l->con.val.int = l->con.val.int and r->con.val.int

	case AST_OP_OR
		l->con.val.int = l->con.val.int or r->con.val.int

	case AST_OP_XOR
		l->con.val.int = l->con.val.int xor r->con.val.int

	case AST_OP_EQV
		l->con.val.int = l->con.val.int eqv r->con.val.int

	case AST_OP_IMP
		l->con.val.int = l->con.val.int imp r->con.val.int

	case AST_OP_NE
		l->con.val.int = l->con.val.int <> r->con.val.int

	case AST_OP_EQ
		l->con.val.int = l->con.val.int = r->con.val.int

	case AST_OP_GT
		if( issigned ) then
			l->con.val.int = l->con.val.int > r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) > cunsg( r->con.val.int )
		end if

	case AST_OP_LT
		if( issigned ) then
			l->con.val.int = l->con.val.int < r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) < cunsg( r->con.val.int )
		end if

	case AST_OP_LE
		if( issigned ) then
			l->con.val.int = l->con.val.int <= r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) <= cunsg( r->con.val.int )
		end if

	case AST_OP_GE
		if( issigned ) then
			l->con.val.int = l->con.val.int >= r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) >= cunsg( r->con.val.int )
		end if
	end select

end sub

'':::::
private sub hBOPConstFoldFlt _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) static

	select case as const op
	case AST_OP_ADD
		l->con.val.float = l->con.val.float + r->con.val.float

	case AST_OP_SUB
		l->con.val.float = l->con.val.float - r->con.val.float

	case AST_OP_MUL
		l->con.val.float = l->con.val.float * r->con.val.float

	case AST_OP_DIV
		l->con.val.float = l->con.val.float / r->con.val.float

    case AST_OP_POW
		l->con.val.float = l->con.val.float ^ r->con.val.float

	case AST_OP_NE
		l->con.val.int = l->con.val.float <> r->con.val.float

	case AST_OP_EQ
		l->con.val.int = l->con.val.float = r->con.val.float

	case AST_OP_GT
		l->con.val.int = l->con.val.float > r->con.val.float

	case AST_OP_LT
		l->con.val.int = l->con.val.float < r->con.val.float

	case AST_OP_LE
		l->con.val.int = l->con.val.float <= r->con.val.float

	case AST_OP_GE
		l->con.val.int = l->con.val.float >= r->con.val.float

    case AST_OP_ATAN2
		l->con.val.float = atan2( l->con.val.float, r->con.val.float )
	end select

end sub

'':::::
private sub hBOPConstFold64 _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) static

	dim as integer issigned

	issigned = (l->dtype = FB_DATATYPE_LONGINT)

	select case as const op
	case AST_OP_ADD
		l->con.val.long = l->con.val.long + r->con.val.long

	case AST_OP_SUB
		l->con.val.long = l->con.val.long - r->con.val.long

	case AST_OP_MUL
		if( issigned ) then
			l->con.val.long = l->con.val.long * r->con.val.long
		else
			l->con.val.long = cunsg(l->con.val.long) * cunsg(r->con.val.long)
		end if

	case AST_OP_INTDIV
		if( r->con.val.long <> 0 ) then
			if( issigned ) then
				l->con.val.long = l->con.val.long \ r->con.val.long
			else
				l->con.val.long = cunsg( l->con.val.long ) \ cunsg( r->con.val.long )
			end if
		else
			l->con.val.long = 0
			errReport( FB_ERRMSG_DIVBYZERO )
		end if

	case AST_OP_MOD
		if( r->con.val.long <> 0 ) then
			if( issigned ) then
				l->con.val.long = l->con.val.long mod r->con.val.long
			else
				l->con.val.long = cunsg( l->con.val.long ) mod cunsg( r->con.val.long )
			end if
		else
			l->con.val.long = 0
			errReport( FB_ERRMSG_DIVBYZERO )
		end if

	case AST_OP_SHL
		if( issigned ) then
			l->con.val.long = l->con.val.long shl r->con.val.int
		else
			l->con.val.long = cunsg( l->con.val.long ) shl r->con.val.int
		end if

	case AST_OP_SHR
		if( issigned ) then
			l->con.val.long = l->con.val.long shr r->con.val.int
		else
			l->con.val.long = cunsg( l->con.val.long ) shr r->con.val.int
		end if

	case AST_OP_AND
		l->con.val.long = l->con.val.long and r->con.val.long

	case AST_OP_OR
		l->con.val.long = l->con.val.long or r->con.val.long

	case AST_OP_XOR
		l->con.val.long = l->con.val.long xor r->con.val.long

	case AST_OP_EQV
		l->con.val.long = l->con.val.long eqv r->con.val.long

	case AST_OP_IMP
		l->con.val.long = l->con.val.long imp r->con.val.long

	case AST_OP_NE
		l->con.val.int = l->con.val.long <> r->con.val.long

	case AST_OP_EQ
		l->con.val.int = l->con.val.long = r->con.val.long

	case AST_OP_GT
		if( issigned ) then
			l->con.val.int = l->con.val.long > r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) > cunsg( r->con.val.long )
		end if

	case AST_OP_LT
		if( issigned ) then
			l->con.val.int = l->con.val.long < r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) < cunsg( r->con.val.long )
		end if

	case AST_OP_LE
		if( issigned ) then
			l->con.val.int = l->con.val.long <= r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) <= cunsg( r->con.val.long )
		end if

	case AST_OP_GE
		if( issigned ) then
			l->con.val.int = l->con.val.long >= r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) >= cunsg( r->con.val.long )
		end if
	end select

end sub

'':::::
private function hCheckPointer _
	( _
		byval op as integer, _
		byval dtype as integer, _
		byval dclass as integer _
	) as integer

    '' not int?
    if( dclass <> FB_DATACLASS_INTEGER ) then
    	return FALSE

    '' CHAR and WCHAR literals are also from the INTEGER class
    else
    	select case dtype
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		return FALSE
        end select
    end if

    select case op
    '' add op?
    case AST_OP_ADD, AST_OP_SUB

    	'' another pointer?
    	if( dtype >= FB_DATATYPE_POINTER ) then
    		return FALSE
    	end if

    	return TRUE

	'' relational op?
	case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE

    	return TRUE

    case else
    	return FALSE
    end select

end function

'':::::
private function hDoPointerArith _
	( _
		byval op as integer, _
		byval p as ASTNODE ptr, _
		byval e as ASTNODE ptr _
	) as ASTNODE ptr static

    dim as integer edtype
    dim as integer lgt

    function = NULL

    edtype = astGetDataType( e )

    '' not integer class?
    if( symbGetDataClass( edtype ) <> FB_DATACLASS_INTEGER ) then
    	exit function

    '' CHAR and WCHAR literals are also from the INTEGER class (to allow *p = 0 etc)
    else
    	select case edtype
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		exit function
    	end select
    end if

    '' calc len( *p )
    lgt = symbCalcLen( astGetDataType( p ) - FB_DATATYPE_POINTER, astGetSubType( p ) )

	'' incomplete type?
	if( lgt = 0 ) then
		'' unless it's a void ptr.. pretend it's a byte ptr
		if( astGetDataType( p ) <> FB_DATATYPE_POINTER + FB_DATATYPE_VOID ) then
			exit function
		end if
		lgt = 1
	end if

    '' another pointer?
    if( edtype >= FB_DATATYPE_POINTER ) then
    	'' only allow if it's a subtraction
    	if( op = AST_OP_SUB ) then
    		'' types can't be different..
    		if( (edtype <> astGetDataType( p )) or _
    			(astGetSubType( e ) <> astGetSubType( p )) ) then
    			exit function
    		end if

    		'' convert to uint or BOP will complain..
    		p = astNewCONV( FB_DATATYPE_UINT, NULL, p )
    		e = astNewCONV( FB_DATATYPE_UINT, NULL, e )

 			'' subtract..
 			e = astNewBOP( AST_OP_SUB, p, e )

 			'' and divide by length
 			function = astNewBOP( AST_OP_INTDIV, e, astNewCONSTi( lgt, FB_DATATYPE_INTEGER ) )
    	end if

    	exit function
    end if

    '' not integer? convert
    if( edtype <> FB_DATATYPE_INTEGER ) then
    	e = astNewCONV( FB_DATATYPE_INTEGER, NULL, e )
    end if

    '' any op but +|-?
    select case op
    case AST_OP_ADD, AST_OP_SUB
    	'' multiple by length
		e = astNewBOP( AST_OP_MUL, e, astNewCONSTi( lgt, FB_DATATYPE_INTEGER ) )

		'' do op
		function = astNewBOP( op, p, e )

    case else
    	'' allow AND and OR??
    	exit function
    end select

end function

'':::::
#macro hDoGlobOpOverload _
	( _
		op, l, r _
	)

	if( symb.globOpOvlTb(op).head <> NULL ) then
		dim as FBSYMBOL ptr proc
		dim as integer is_ambiguous

		proc = symbFindBopOvlProc( op, l, r, @is_ambiguous )
		if( proc <> NULL ) then
			'' build a proc call
			return astBuildCALL( proc, 2, l, r )
		else
			if( is_ambiguous ) then
				return NULL
			end if

			'' commutative?
			if( astGetOpIsCommutative( op ) ) then
				'' try (r, l) too
				proc = symbFindBopOvlProc( op, r, l, @is_ambiguous )
				if( proc <> NULL ) then
					'' build a proc call
					return astBuildCALL( proc, 2, r, l )
				else
					if( is_ambiguous ) then
						return NULL
					end if
				end if
			end if
		end if
	end if

#endmacro

'':::::
function astNewBOP _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as FBSYMBOL ptr, _
		byval options as AST_OPOPT _
	) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer ldtype, rdtype, dtype
    dim as integer ldclass, rdclass
    dim as integer is_str
    dim as FBSYMBOL ptr litsym, subtype

	function = NULL

	'' check op overloading
	hDoGlobOpOverload( op, l, r )

	is_str = FALSE

	ldtype = l->dtype
	rdtype = r->dtype
	ldclass = symbGetDataClass( ldtype )
	rdclass = symbGetDataClass( rdtype )

	''::::::
    '' pointers?
    if( ldtype >= FB_DATATYPE_POINTER ) then
		'' do arithmetics?
		if( (options and AST_OPOPT_LPTRARITH) <> 0 ) then
    		return hDoPointerArith( op, l, r )
		else
    		if( hCheckPointer( op, rdtype, rdclass ) = FALSE ) then
    			exit function
    		end if
		end if

    elseif( rdtype >= FB_DATATYPE_POINTER ) then
		'' do arithmetics?
		if( (options and AST_OPOPT_RPTRARITH) <> 0 ) then
			return hDoPointerArith( op, r, l )
		else
    		if( hCheckPointer( op, ldtype, ldclass ) = FALSE ) then
    			exit function
    		end if
		end if
    end if

	'' UDT's? can't operate
	if( (ldtype = FB_DATATYPE_STRUCT) or _
		(rdtype = FB_DATATYPE_STRUCT) ) then
		exit function
    end if

    '' enums?
    if( (ldtype = FB_DATATYPE_ENUM) or _
    	(rdtype = FB_DATATYPE_ENUM) ) then
    	'' not the same?
    	if( ldtype <> rdtype ) then
    		if( (ldclass <> FB_DATACLASS_INTEGER) or _
    			(rdclass <> FB_DATACLASS_INTEGER) ) then
    			errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
    		end if
    	end if
    end if

    '' both zstrings? treat as string..
    if( (ldtype = FB_DATATYPE_CHAR) and _
    	(rdtype = FB_DATATYPE_CHAR) ) then
    	ldclass = FB_DATACLASS_STRING
    	rdclass = ldclass
    end if

    '' wstrings?
    if( (ldtype = FB_DATATYPE_WCHAR) or _
    	(rdtype = FB_DATATYPE_WCHAR) ) then

		'' aren't both wstrings?
		if( ldtype <> rdtype ) then
			if( ldtype = FB_DATATYPE_WCHAR ) then
				'' is right a string?
				is_str = (rdclass = FB_DATACLASS_STRING) or (rdtype = FB_DATATYPE_CHAR)
			else
				'' is left a string?
				is_str = (ldclass = FB_DATACLASS_STRING) or (ldtype = FB_DATATYPE_CHAR)
			end if
		else
			is_str = TRUE
		end if

		if( is_str ) then

			'' check for string literals
			litsym = NULL
			select case ldtype
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				litsym = astGetStrLitSymbol( l )
				if( litsym <> NULL ) then
					select case rdtype
					case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
						litsym = astGetStrLitSymbol( r )
					case else
						litsym = NULL
					end select
				end if
			end select

			select case as const op
			'' concatenation?
			case AST_OP_ADD

				'' both literals?
				if( litsym <> NULL ) then
					'' ok to convert at compile-time?
					if( (ldtype = rdtype) or _
						(env.target.wchar.doconv) ) then
						return hWstrLiteralConcat( l, r )
					end if
				end if

				'' both aren't wstrings?
				if( ldtype <> rdtype ) then
					return rtlWstrConcat( l, ldtype, r, rdtype )
				end if

				'' result will be always a wstring
				ldtype = FB_DATATYPE_WCHAR
				ldclass = FB_DATACLASS_INTEGER
				rdtype = ldtype
				rdclass = ldclass
				is_str = TRUE

				'' concatenation will only be done when loading,
				'' to allow optimizations..

			'' comparation?
			case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE
				'' both literals?
				if( litsym <> NULL ) then
					return hWstrLiteralCompare( op, l, r )
				end if

				'' convert to: wstrcmp(l,r) op 0
				l = rtlWstrCompare( l, r )
				r = astNewCONSTi( 0, FB_DATATYPE_INTEGER )

				ldtype = l->dtype
				rdtype = r->dtype
				ldclass = FB_DATACLASS_INTEGER
				rdclass = FB_DATACLASS_INTEGER

			'' no other operation allowed
			case else
				exit function
			end select

		'' one is not a string..
		else
			if( ldtype = FB_DATATYPE_WCHAR ) then
				'' don't allow, unless it's a deref pointer
				if( l->class <> AST_NODECLASS_PTR ) then
					exit function
				end if
				'' remap the type or the optimizer can
				'' make a wrong assumption
				ldtype = env.target.wchar.type

			else
				'' same as above..
				if( r->class <> AST_NODECLASS_PTR ) then
					exit function
				end if
				rdtype = env.target.wchar.type
			end if
		end if

    '' strings?
    elseif( (ldclass = FB_DATACLASS_STRING) or _
    		(rdclass = FB_DATACLASS_STRING) ) then

		'' aren't both strings?
		if( ldclass <> rdclass ) then
			if( ldclass = FB_DATACLASS_STRING ) then
				'' not a zstring?
				if( rdtype <> FB_DATATYPE_CHAR ) then
					exit function
				end if
			else
				'' not a zstring?
				if( ldtype <> FB_DATATYPE_CHAR ) then
					exit function
				end if
			end if
		end if

		'' check for string literals
		litsym = NULL
		if( ldtype = FB_DATATYPE_CHAR ) then
			if( rdtype = FB_DATATYPE_CHAR ) then
				litsym = astGetStrLitSymbol( l )
				if( litsym <> NULL ) then
					litsym = astGetStrLitSymbol( r )
				end if
			end if
		end if

		select case as const op
		'' concatenation?
		case AST_OP_ADD
			'' both literals?
			if( litsym <> NULL ) then
				return hStrLiteralConcat( l, r )
			end if

			'' result will be always an var-len string
			ldtype = FB_DATATYPE_STRING
			ldclass = FB_DATACLASS_STRING
			rdtype = ldtype
			rdclass = ldclass
			is_str = TRUE

			'' concatenation will only be done when loading,
			'' to allow optimizations..

		'' comparation?
		case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE
			'' both literals?
			if( litsym <> NULL ) then
				return hStrLiteralCompare( op, l, r )
			end if

			'' convert to: strcmp(l,r) op 0
			l = rtlStrCompare( l, ldtype, r, rdtype )
			r = astNewCONSTi( 0, FB_DATATYPE_INTEGER )

			ldtype = l->dtype
			ldclass = FB_DATACLASS_INTEGER
			rdtype = r->dtype
			rdclass = FB_DATACLASS_INTEGER

		'' no other operation allowed
		case else
			exit function
		end select

    '' zstrings?
    elseif( (ldtype = FB_DATATYPE_CHAR) or _
    	    (rdtype = FB_DATATYPE_CHAR) ) then

   		'' one is not a string (not fixed, var-len, z- or w-string,
   		'' or the tests above would catch them)
		if( ldtype = FB_DATATYPE_CHAR ) then
			'' don't allow, unless it's a deref pointer
			if( l->class <> AST_NODECLASS_PTR ) then
				exit function
			end if
			'' remap the type or the optimizer can
			'' make a wrong assumption
			ldtype = FB_DATATYPE_UBYTE

		else
			'' same as above..
			if( r->class <> AST_NODECLASS_PTR ) then
				exit function
			end if
			rdtype = FB_DATATYPE_UBYTE
		end if

    end if

    ''::::::

	'' convert byte to int
	if( symbGetDataSize( ldtype ) = 1 ) then
		if( is_str = FALSE ) then
			if( symbIsSigned( ldtype ) ) then
				ldtype = FB_DATATYPE_INTEGER
			else
				ldtype = FB_DATATYPE_UINT
			end if
			l = astNewCONV( ldtype, NULL, l )
		end if
	end if

	if( symbGetDataSize( rdtype ) = 1 ) then
		if( is_str = FALSE ) then
			if( symbIsSigned( rdtype ) ) then
				rdtype = FB_DATATYPE_INTEGER
			else
				rdtype = FB_DATATYPE_UINT
			end if
			r = astNewCONV( rdtype, NULL, r )
		end if
	end if

    '' convert types
	select case as const op
	'' flt div (/) can only operate on floats
	case AST_OP_DIV

		if( ldclass <> FB_DATACLASS_FPOINT ) then
			ldtype = FB_DATATYPE_DOUBLE
			l = astNewCONV( ldtype, NULL, l )
			ldclass = FB_DATACLASS_FPOINT
		end if

		if( rdclass <> FB_DATACLASS_FPOINT ) then
			'' x86 assumption: if it's an int var, let the FPU do it
			if( (r->class = AST_NODECLASS_VAR) and (rdtype = FB_DATATYPE_INTEGER) ) then
				rdtype = FB_DATATYPE_DOUBLE
			else
				rdtype = FB_DATATYPE_DOUBLE
				r = astNewCONV( rdtype, NULL, r )
			end if
			rdclass = FB_DATACLASS_FPOINT
		end if

	'' bitwise ops, int div (\), modulus and shift can only operate on integers
	case AST_OP_AND, AST_OP_OR, AST_OP_XOR, AST_OP_EQV, AST_OP_IMP, _
		 AST_OP_INTDIV, AST_OP_MOD, AST_OP_SHL, AST_OP_SHR

		if( ldclass <> FB_DATACLASS_INTEGER ) then
			ldtype = FB_DATATYPE_INTEGER
			l = astNewCONV( ldtype, NULL, l )
			ldclass = FB_DATACLASS_INTEGER
		end if

		if( rdclass <> FB_DATACLASS_INTEGER ) then
			rdtype = FB_DATATYPE_INTEGER
			r = astNewCONV( rdtype, NULL, r )
			rdclass = FB_DATACLASS_INTEGER
		end if

	'' atan2 can only operate on floats
	case AST_OP_ATAN2, AST_OP_POW

		if( ldclass <> FB_DATACLASS_FPOINT ) then
			ldtype = FB_DATATYPE_DOUBLE
			l = astNewCONV( ldtype, NULL, l )
			ldclass = FB_DATACLASS_FPOINT
		end if

		if( rdclass <> FB_DATACLASS_FPOINT ) then
			rdtype = FB_DATATYPE_DOUBLE
			r = astNewCONV( rdtype, NULL, r )
			rdclass = FB_DATACLASS_FPOINT
		end if

	end select

    ''::::::

    '' convert types to the most precise if needed
	if( ldtype <> rdtype ) then

		dtype = symbMaxDataType( ldtype, rdtype )

		'' don't convert?
		if( dtype = INVALID ) then

			'' as types are different, if class is fp,
			'' the result type will be always a double
			if( ldclass = FB_DATACLASS_FPOINT ) then
				dtype   = FB_DATATYPE_DOUBLE
				subtype = NULL
			else

				'' an ENUM or POINTER always has the precedence
				if( (rdtype = FB_DATATYPE_ENUM) or _
					(rdtype >= FB_DATATYPE_POINTER) ) then
					dtype = rdtype
					subtype = r->subtype
				else
					dtype = ldtype
					subtype = l->subtype
				end if

			end if

		else
			'' convert the l operand?
			if( dtype <> ldtype ) then
				subtype = r->subtype
				l = astNewCONV( dtype, subtype, l )
				ldtype = dtype
				ldclass = rdclass

			'' convert the r operand..
			else
				subtype = l->subtype

				'' if it's the src-operand of a shift operation, do nothing
				select case op
				case AST_OP_SHL, AST_OP_SHR
					'' it's already an integer

				case else
					r = astNewCONV( dtype, subtype, r )
					rdtype = dtype
					rdclass = ldclass
				end select

			end if
		end if

	'' no conversion, same types
	else
		dtype   = ldtype
		subtype = l->subtype
	end if

	'' post check
	select case as const op
	'' relative ops, the result is always an integer
	case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE
		dtype = FB_DATATYPE_INTEGER
		subtype = NULL

	'' right-operand must be an integer, so pow2 opts can be done on longint's
	case AST_OP_SHL, AST_OP_SHR
		if( rdtype <> FB_DATATYPE_INTEGER ) then
			if( rdtype <> FB_DATATYPE_UINT ) then
				rdtype = FB_DATATYPE_INTEGER
				r = astNewCONV( rdtype, NULL, r )
				rdclass = FB_DATACLASS_INTEGER
			end if
		end if
	end select

	''::::::

	'' constant folding (won't handle commutation, ie: "1+a+2+3" will become "1+a+5", not "a+6")
	if( l->defined and r->defined ) then

		select case as const ldtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    hBOPConstFold64( op, l, r )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			hBOPConstFoldFlt( op, l, r )
		case else
			'' byte's, short's, int's and enum's
			hBOPConstFoldInt( op, l, r )
		end select

		astSetType( l, dtype, subtype )

		astDelNode( r )

		return l

	elseif( l->defined ) then
		select case op
		case AST_OP_ADD, AST_OP_MUL
			'' ? + c = c + ?  |  ? * c = ? * c
			astSwap( r, l )

		case AST_OP_SUB
			'' c - ? = -? + c (this will removed later if no const folding can be done)
			r = astNewUOP( AST_OP_NEG, r )
			if( r = NULL ) then
				return NULL
			end if
			astSwap( r, l )
			op = AST_OP_ADD
		end select

	elseif( r->defined ) then
		select case op
		case AST_OP_ADD
			'' offset?
			if( l->class = AST_NODECLASS_OFFSET ) then
				'' no need to check for other values, floats aren't
				'' allowed and if longints were used, this wouldn't be
				'' an ofs node
				l->ofs.ofs += r->con.val.int
				astDelNode( r )

				return l
			end if

		case AST_OP_SUB
			'' offset?
			if( l->class = AST_NODECLASS_OFFSET ) then
				'' see above
				l->ofs.ofs -= r->con.val.int
				astDelNode( r )

				return l
			end if

			'' ? - c = ? + -c
			select case as const rdtype
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				r->con.val.long = -r->con.val.long
			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				r->con.val.float = -r->con.val.float
			case else
				r->con.val.int = -r->con.val.int
			end select
			op = AST_OP_ADD

		case AST_OP_POW

			'' convert var ^ 2 to var * var
			if( r->con.val.float = 2.0 ) then

				'' operands will be converted to DOUBLE if not floats..
				if( l->class = AST_NODECLASS_CONV ) then
					select case l->l->class
					case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
						 AST_NODECLASS_FIELD, AST_NODECLASS_PTR
						n = l
						l = l->l
						astDelNode( n )
						ldtype = l->dtype
					end select
				end if

				select case l->class
				case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
					 AST_NODECLASS_FIELD, AST_NODECLASS_PTR
					astDelNode( r )
					r = astCloneTree( l )
					op = AST_OP_MUL
					dtype = ldtype
				end select
			end if
		end select
	end if

	''::::::
	'' handle special cases

	select case op
	case AST_OP_POW
	    return rtlMathPow( l, r )

	case AST_OP_INTDIV
		'' longint?
		if( (dtype = FB_DATATYPE_LONGINT) or _
			(dtype = FB_DATATYPE_ULONGINT) ) then
			return rtlMathLongintDIV( dtype, l, ldtype, r, rdtype )
		end if

	case AST_OP_MOD
		'' longint?
		if( (dtype = FB_DATATYPE_LONGINT) or _
			(dtype = FB_DATATYPE_ULONGINT) ) then
			return rtlMathLongintMOD( dtype, l, ldtype, r, rdtype )
		end if

	end select

	'' alloc new node
	n = astNewNode( AST_NODECLASS_BOP, dtype, subtype )
	if( n = NULL ) then
		exit function
	end if

	'' fill it
	n->l = l
	n->r = r
	n->op.ex = ex
	n->op.op = op
	n->op.options = options

	function = n

end function

'':::::
function astNewSelfBOP _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as FBSYMBOL ptr, _
		byval options as AST_OPOPT _
	) as ASTNODE ptr static

	function = NULL

	'' check op overloading
	hDoGlobOpOverload( op, l, r )

	'' assuming _SELF comes right-after the binary op

	'' if there's a function call in lvalue, convert to tmp = @lvalue, *tmp = *tmp op rhs:
	if( astIsClassOnTree( AST_NODECLASS_CALL, l ) ) then
		dim as FBSYMBOL ptr tmp, subtype
		dim as integer dtype
		dim as ASTNODE ptr ll, lr

		dtype = astGetDataType( l )
		subtype = astGetSubType( l )
		tmp = symbAddTempVar( FB_DATATYPE_POINTER + dtype, subtype )

		'' tmp = @lvalue
		ll = astNewASSIGN( astNewVAR( tmp, 0, FB_DATATYPE_POINTER + dtype, subtype ), _
					   	   astNewADDR( AST_OP_ADDROF, l ) )

		'' *tmp = *tmp op expr
		lr = astNewASSIGN( astNewPTR( 0, _
				   		   			   astNewVAR( tmp, _
				   		   			   			  0, _
				   		   			   			  FB_DATATYPE_POINTER + dtype, _
				   		   			   			  subtype ),_
				   		   			   dtype, _
				   		   			   subtype ), _
						   astNewBOP( op - 1, _
				   		   			  astNewPTR( 0, _
				   		   			   			  astNewVAR( tmp, _
				   		   			   			  			 0, _
				   		   			   			  			 FB_DATATYPE_POINTER + dtype, _
				   		   			   			  			 subtype ), _
				   		   			   			  dtype, _
				   		   			   			  subtype ), _
					   	   			  r, _
					   	   			  ex, _
					   	   			  options or AST_OPOPT_ALLOCRES ) )

		function = astNewLink( ll, lr )

	'' no side-effects, convert it to lvalue = lvalue op rhs and let it be optimized later
	else
		r = astNewBOP( op - 1, astCloneTree( l ), r, ex, options or AST_OPOPT_ALLOCRES )

 		if( r = NULL ) then
 			exit function
 		end if

 		'' do the assignment
		function = astNewASSIGN( l, r )
	end if

end function

'':::::
function astLoadBOP _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any, r = any
    dim as integer op = any
    dim as IRVREG ptr v1 = any, v2 = any, vr = any

	op = n->op.op
	l  = n->l
	r  = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' need some other algo here to select which operand is better to evaluate
	'' first - pay attention to logical ops, "func1(bar) OR func1(foo)" isn't
	'' the same as the inverse if func1 depends on the order..
	v1 = astLoad( l )
	v2 = astLoad( r )

	if( ast.doemit ) then
		'' result type can be different, with boolean operations on floats
		if( (n->op.options and AST_OPOPT_ALLOCRES) <> 0 ) then
			vr = irAllocVREG( n->dtype )
		else
			vr = NULL
		end if

		'' execute the operation
		if( n->op.ex <> NULL ) then
			'' hack! ex=label, vr being NULL 'll gen better code at IR..
			irEmitBOPEx( op, v1, v2, NULL, n->op.ex )
		else
			irEmitBOPEx( op, v1, v2, vr, NULL )
		end if

		'' "var op= expr" optimizations
		if( vr = NULL ) then
			vr = v1
		end if
	end if

	'' nodes not needed anymore
	astDelNode( l )
	astDelNode( r )

	function = vr

end function

