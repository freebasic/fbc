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

'' AST binary operation nodes
'' l = left operand expression; r = right operand expression
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private function hStrLiteralConcat( byval l as ASTNODE ptr, _
									byval r as ASTNODE ptr _
								  ) as ASTNODE ptr

    dim as FBSYMBOL ptr s, ls, rs

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	'' new len = both strings' len less the 2 null-chars
	s = symbAllocStrConst( *symbGetVarText( ls ) + *symbGetVarText( rs ), _
						   symbGetStrLen( ls ) - 1 + symbGetStrLen( rs ) - 1 )

	function = astNewVAR( s, 0, FB_DATATYPE_CHAR )

	astDel( r )
	astDel( l )

end function

'':::::
private function hWstrLiteralConcat( byval l as ASTNODE ptr, _
									 byval r as ASTNODE ptr _
								   ) as ASTNODE ptr

    dim as FBSYMBOL ptr s, ls, rs

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	if( symbGetType( ls ) <> FB_DATATYPE_WCHAR ) then
		'' new len = both strings' len less the 2 null-chars
		s = symbAllocWstrConst( wstr( *symbGetVarText( ls ) ) + *symbGetVarTextW( rs ), _
						    	symbGetStrLen( ls ) - 1 + symbGetWstrLen( rs ) - 1 )

	elseif( symbGetType( rs ) <> FB_DATATYPE_WCHAR ) then
		s = symbAllocWstrConst( *symbGetVarTextW( ls ) + wstr( *symbGetVarText( rs ) ), _
						    	symbGetWstrLen( ls ) - 1 + symbGetStrLen( rs ) - 1 )

	else
		s = symbAllocWstrConst( *symbGetVarTextW( ls ) + *symbGetVarTextW( rs ), _
						    	symbGetWstrLen( ls ) - 1 + symbGetWstrLen( rs ) - 1 )
    end if

	function = astNewVAR( s, 0, FB_DATATYPE_WCHAR )

	astDel( r )
	astDel( l )

end function

'':::::
private function hStrLiteralCompare( byval op as integer, _
									 byval l as ASTNODE ptr, _
									 byval r as ASTNODE ptr _
								   ) as ASTNODE ptr static

    dim as zstring ptr ltext, rtext
    dim as integer res

   	ltext = symbGetVarText( astGetSymbol( l ) )
   	rtext = symbGetVarText( astGetSymbol( r ) )

   	select case as const op
   	case IR_OP_EQ
   		res = (*ltext = *rtext)
   	case IR_OP_GT
   		res = (*ltext > *rtext)
   	case IR_OP_LT
   		res = (*ltext < *rtext)
   	case IR_OP_NE
   		res = (*ltext <> *rtext)
   	case IR_OP_LE
   		res = (*ltext <= *rtext)
   	case IR_OP_GE
   		res = (*ltext >= *rtext)
   	end select

	function = astNewCONSTi( res, FB_DATATYPE_INTEGER )

	astDel( r )
	astDel( l )

end function

'':::::
private function hWStrLiteralCompare( byval op as integer, _
									  byval l as ASTNODE ptr, _
									  byval r as ASTNODE ptr _
								    ) as ASTNODE ptr static

    dim as FBSYMBOL ptr ls, rs
    dim as zstring ptr textz
    dim as wstring ptr ltextw, rtextw
    dim as integer res

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	'' left operand not a wstring?
	if( symbGetType( ls ) <> FB_DATATYPE_WCHAR ) then
   		textz = symbGetVarText( ls )
   		rtextw = symbGetVarTextW( rs )

   		select case as const op
   		case IR_OP_EQ
   			res = (*textz = *rtextw)
   		case IR_OP_GT
   			res = (*textz > *rtextw)
   		case IR_OP_LT
   			res = (*textz < *rtextw)
   		case IR_OP_NE
   			res = (*textz <> *rtextw)
   		case IR_OP_LE
   			res = (*textz <= *rtextw)
   		case IR_OP_GE
   			res = (*textz >= *rtextw)
   		end select

   	'' right operand?
   	elseif( symbGetType( rs ) <> FB_DATATYPE_WCHAR ) then
   		ltextw = symbGetVarTextW( ls )
   		textz = symbGetVarText( rs )

   		select case as const op
   		case IR_OP_EQ
   			res = (*ltextw = *textz)
   		case IR_OP_GT
   			res = (*ltextw > *textz)
   		case IR_OP_LT
   			res = (*ltextw < *textz)
   		case IR_OP_NE
   			res = (*ltextw <> *textz)
   		case IR_OP_LE
   			res = (*ltextw <= *textz)
   		case IR_OP_GE
   			res = (*ltextw >= *textz)
   		end select

   	'' both wstrings..
   	else
   		ltextw = symbGetVarTextW( ls )
   		rtextw = symbGetVarTextW( rs )

   		select case as const op
   		case IR_OP_EQ
   			res = (*ltextw = *rtextw)
   		case IR_OP_GT
   			res = (*ltextw > *rtextw)
   		case IR_OP_LT
   			res = (*ltextw < *rtextw)
   		case IR_OP_NE
   			res = (*ltextw <> *rtextw)
   		case IR_OP_LE
   			res = (*ltextw <= *rtextw)
   		case IR_OP_GE
   			res = (*ltextw >= *rtextw)
   		end select

   	end if

	function = astNewCONSTi( res, FB_DATATYPE_INTEGER )

	astDel( r )
	astDel( l )

end function

'':::::
private sub hBOPConstFoldInt( byval op as integer, _
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
	case IR_OP_ADD
		l->con.val.int = l->con.val.int + r->con.val.int

	case IR_OP_SUB
		l->con.val.int = l->con.val.int - r->con.val.int

	case IR_OP_MUL
		if( issigned ) then
			l->con.val.int = l->con.val.int * r->con.val.int
		else
			l->con.val.int = cunsg(l->con.val.int) * cunsg(r->con.val.int)
		end if

	case IR_OP_INTDIV
		if( r->con.val.int <> 0 ) then
			if( issigned ) then
				l->con.val.int = l->con.val.int \ r->con.val.int
			else
				l->con.val.int = cunsg( l->con.val.int ) \ cunsg( r->con.val.int )
			end if
		else
			l->con.val.int = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_MOD
		if( r->con.val.int <> 0 ) then
			if( issigned ) then
				l->con.val.int = l->con.val.int mod r->con.val.int
			else
				l->con.val.int = cunsg( l->con.val.int ) mod cunsg( r->con.val.int )
			end if
		else
			l->con.val.int = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_SHL
		if( issigned ) then
			l->con.val.int = l->con.val.int shl r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) shl r->con.val.int
		end if

	case IR_OP_SHR
		if( issigned ) then
			l->con.val.int = l->con.val.int shr r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) shr r->con.val.int
		end if

	case IR_OP_AND
		l->con.val.int = l->con.val.int and r->con.val.int

	case IR_OP_OR
		l->con.val.int = l->con.val.int or r->con.val.int

	case IR_OP_XOR
		l->con.val.int = l->con.val.int xor r->con.val.int

	case IR_OP_EQV
		l->con.val.int = l->con.val.int eqv r->con.val.int

	case IR_OP_IMP
		l->con.val.int = l->con.val.int imp r->con.val.int

	case IR_OP_NE
		l->con.val.int = l->con.val.int <> r->con.val.int

	case IR_OP_EQ
		l->con.val.int = l->con.val.int = r->con.val.int

	case IR_OP_GT
		if( issigned ) then
			l->con.val.int = l->con.val.int > r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) > cunsg( r->con.val.int )
		end if

	case IR_OP_LT
		if( issigned ) then
			l->con.val.int = l->con.val.int < r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) < cunsg( r->con.val.int )
		end if

	case IR_OP_LE
		if( issigned ) then
			l->con.val.int = l->con.val.int <= r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) <= cunsg( r->con.val.int )
		end if

	case IR_OP_GE
		if( issigned ) then
			l->con.val.int = l->con.val.int >= r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) >= cunsg( r->con.val.int )
		end if
	end select

end sub

'':::::
private sub hBOPConstFoldFlt( byval op as integer, _
						      byval l as ASTNODE ptr, _
						      byval r as ASTNODE ptr _
						    ) static

	select case as const op
	case IR_OP_ADD
		l->con.val.float = l->con.val.float + r->con.val.float

	case IR_OP_SUB
		l->con.val.float = l->con.val.float - r->con.val.float

	case IR_OP_MUL
		l->con.val.float = l->con.val.float * r->con.val.float

	case IR_OP_DIV
		l->con.val.float = l->con.val.float / r->con.val.float

    case IR_OP_POW
		l->con.val.float = l->con.val.float ^ r->con.val.float

	case IR_OP_NE
		l->con.val.int = l->con.val.float <> r->con.val.float

	case IR_OP_EQ
		l->con.val.int = l->con.val.float = r->con.val.float

	case IR_OP_GT
		l->con.val.int = l->con.val.float > r->con.val.float

	case IR_OP_LT
		l->con.val.int = l->con.val.float < r->con.val.float

	case IR_OP_LE
		l->con.val.int = l->con.val.float <= r->con.val.float

	case IR_OP_GE
		l->con.val.int = l->con.val.float >= r->con.val.float

    case IR_OP_ATAN2
		l->con.val.float = atan2( l->con.val.float, r->con.val.float )
	end select

end sub

'':::::
private sub hBOPConstFold64( byval op as integer, _
							 byval l as ASTNODE ptr, _
							 byval r as ASTNODE ptr _
						   ) static

	dim as integer issigned

	issigned = (l->dtype = FB_DATATYPE_LONGINT)

	select case as const op
	case IR_OP_ADD
		l->con.val.long = l->con.val.long + r->con.val.long

	case IR_OP_SUB
		l->con.val.long = l->con.val.long - r->con.val.long

	case IR_OP_MUL
		if( issigned ) then
			l->con.val.long = l->con.val.long * r->con.val.long
		else
			l->con.val.long = cunsg(l->con.val.long) * cunsg(r->con.val.long)
		end if

	case IR_OP_INTDIV
		if( r->con.val.long <> 0 ) then
			if( issigned ) then
				l->con.val.long = l->con.val.long \ r->con.val.long
			else
				l->con.val.long = cunsg( l->con.val.long ) \ cunsg( r->con.val.long )
			end if
		else
			l->con.val.long = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_MOD
		if( r->con.val.long <> 0 ) then
			if( issigned ) then
				l->con.val.long = l->con.val.long mod r->con.val.long
			else
				l->con.val.long = cunsg( l->con.val.long ) mod cunsg( r->con.val.long )
			end if
		else
			l->con.val.long = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_SHL
		if( issigned ) then
			l->con.val.long = l->con.val.long shl r->con.val.int
		else
			l->con.val.long = cunsg( l->con.val.long ) shl r->con.val.int
		end if

	case IR_OP_SHR
		if( issigned ) then
			l->con.val.long = l->con.val.long shr r->con.val.int
		else
			l->con.val.long = cunsg( l->con.val.long ) shr r->con.val.int
		end if

	case IR_OP_AND
		l->con.val.long = l->con.val.long and r->con.val.long

	case IR_OP_OR
		l->con.val.long = l->con.val.long or r->con.val.long

	case IR_OP_XOR
		l->con.val.long = l->con.val.long xor r->con.val.long

	case IR_OP_EQV
		l->con.val.long = l->con.val.long eqv r->con.val.long

	case IR_OP_IMP
		l->con.val.long = l->con.val.long imp r->con.val.long

	case IR_OP_NE
		l->con.val.int = l->con.val.long <> r->con.val.long

	case IR_OP_EQ
		l->con.val.int = l->con.val.long = r->con.val.long

	case IR_OP_GT
		if( issigned ) then
			l->con.val.int = l->con.val.long > r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) > cunsg( r->con.val.long )
		end if

	case IR_OP_LT
		if( issigned ) then
			l->con.val.int = l->con.val.long < r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) < cunsg( r->con.val.long )
		end if

	case IR_OP_LE
		if( issigned ) then
			l->con.val.int = l->con.val.long <= r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) <= cunsg( r->con.val.long )
		end if

	case IR_OP_GE
		if( issigned ) then
			l->con.val.int = l->con.val.long >= r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) >= cunsg( r->con.val.long )
		end if
	end select

end sub

'':::::
private function hCheckPointer( byval op as integer, _
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
    case IR_OP_ADD, IR_OP_SUB

    	'' another pointer?
    	if( dtype >= FB_DATATYPE_POINTER ) then
    		return FALSE
    	end if

    	return TRUE

	'' relational op?
	case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE

    	return TRUE

    case else
    	return FALSE
    end select

end function

'':::::
function astNewBOP( byval op as integer, _
					byval l as ASTNODE ptr, _
					byval r as ASTNODE ptr, _
					byval ex as FBSYMBOL ptr = NULL, _
					byval allocres as integer = TRUE _
				  ) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer ldtype, rdtype, dtype
    dim as integer ldclass, rdclass
    dim as integer doconv, is_str
    dim as FBSYMBOL ptr litsym, subtype

	function = NULL

	if( (l = NULL) or (r = NULL) ) then
		exit function
	end if

	is_str = FALSE

	ldtype = l->dtype
	rdtype = r->dtype
	ldclass = symbGetDataClass( ldtype )
	rdclass = symbGetDataClass( rdtype )

	''::::::
    '' pointers?
    if( ldtype >= FB_DATATYPE_POINTER ) then
    	if( hCheckPointer( op, rdtype, rdclass ) = FALSE ) then
    		exit function
    	end if
    elseif( rdtype >= FB_DATATYPE_POINTER ) then
    	if( hCheckPointer( op, ldtype, ldclass ) = FALSE ) then
    		exit function
    	end if
    end if

	'' UDT's? can't operate
	if( (ldtype = FB_DATATYPE_USERDEF) or _
		(rdtype = FB_DATATYPE_USERDEF) ) then
		exit function
    end if

    '' enums?
    if( (ldtype = FB_DATATYPE_ENUM) or _
    	(rdtype = FB_DATATYPE_ENUM) ) then
    	'' not the same?
    	if( ldtype <> rdtype ) then
    		if( (ldclass <> FB_DATACLASS_INTEGER) or _
    			(rdclass <> FB_DATACLASS_INTEGER) ) then
    			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
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
					end select
				end if
			end select

			select case as const op
			'' concatenation?
			case IR_OP_ADD

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
			case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE
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
		case IR_OP_ADD
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
		case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE
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
			l = astNewCONV( INVALID, ldtype, NULL, l )
		end if
	end if

	if( symbGetDataSize( rdtype ) = 1 ) then
		if( is_str = FALSE ) then
			if( symbIsSigned( rdtype ) ) then
				rdtype = FB_DATATYPE_INTEGER
			else
				rdtype = FB_DATATYPE_UINT
			end if
			r = astNewCONV( INVALID, rdtype, NULL, r )
		end if
	end if

    '' convert types
	select case as const op
	'' flt div (/) can only operate on floats
	case IR_OP_DIV

		if( ldclass <> FB_DATACLASS_FPOINT ) then
			ldtype = FB_DATATYPE_DOUBLE
			l = astNewCONV( INVALID, ldtype, NULL, l )
			ldclass = FB_DATACLASS_FPOINT
		end if

		if( rdclass <> FB_DATACLASS_FPOINT ) then
			'' x86 assumption: if it's an int var, let the FPU do it
			if( (r->class = AST_NODECLASS_VAR) and (rdtype = FB_DATATYPE_INTEGER) ) then
				rdtype = FB_DATATYPE_DOUBLE
			else
				rdtype = FB_DATATYPE_DOUBLE
				r = astNewCONV( INVALID, rdtype, NULL, r )
			end if
			rdclass = FB_DATACLASS_FPOINT
		end if

	'' bitwise ops, int div (\), modulus and shift can only operate on integers
	case IR_OP_AND, IR_OP_OR, IR_OP_XOR, IR_OP_EQV, IR_OP_IMP, _
		 IR_OP_INTDIV, IR_OP_MOD, IR_OP_SHL, IR_OP_SHR

		if( ldclass <> FB_DATACLASS_INTEGER ) then
			ldtype = FB_DATATYPE_INTEGER
			l = astNewCONV( INVALID, ldtype, NULL, l )
			ldclass = FB_DATACLASS_INTEGER
		end if

		if( rdclass <> FB_DATACLASS_INTEGER ) then
			rdtype = FB_DATATYPE_INTEGER
			r = astNewCONV( INVALID, rdtype, NULL, r )
			rdclass = FB_DATACLASS_INTEGER
		end if

	'' atan2 can only operate on floats
	case IR_OP_ATAN2, IR_OP_POW

		if( ldclass <> FB_DATACLASS_FPOINT ) then
			ldtype = FB_DATATYPE_DOUBLE
			l = astNewCONV( INVALID, ldtype, NULL, l )
			ldclass = FB_DATACLASS_FPOINT
		end if

		if( rdclass <> FB_DATACLASS_FPOINT ) then
			rdtype = FB_DATATYPE_DOUBLE
			r = astNewCONV( INVALID, rdtype, NULL, r )
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
				l = astNewCONV( INVALID, dtype, subtype, l )
				ldtype = dtype
				ldclass = rdclass

			'' convert the r operand..
			else
				subtype = l->subtype

				'' if it's the src-operand of a shift operation, do nothing
				select case op
				case IR_OP_SHL, IR_OP_SHR
					'' it's already an integer

				case else
					'' x86 assumption: if it's an short|int var, let the FPU do it
					doconv = TRUE
					if( ldclass = FB_DATACLASS_FPOINT ) then
						if( rdclass = FB_DATACLASS_INTEGER ) then
							'' can't be an longint nor a byte (byte operands are converted above)
							if( symbGetDataSize( rdtype ) < FB_INTEGERSIZE*2 ) then
								select case as const r->class
								case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
									 AST_NODECLASS_FIELD, AST_NODECLASS_PTR
									'' can't be unsigned either
									if( symbIsSigned( rdtype ) ) then
										doconv = FALSE
									end if
								end select
							end if
						end if
					end if

					if( doconv ) then
						r = astNewCONV( INVALID, dtype, subtype, r )
						rdtype = dtype
						rdclass = ldclass
					end if
				end select

			end if
		end if

	'' no conversion, type's are the same
	else
		dtype   = ldtype
		subtype = l->subtype
	end if

	'' post check
	select case as const op
	'' relative ops, the result is always an integer
	case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE
		dtype = FB_DATATYPE_INTEGER
		subtype = NULL

	'' right-operand must be an integer, so pow2 opts can be done on longint's
	case IR_OP_SHL, IR_OP_SHR
		if( rdtype <> FB_DATATYPE_INTEGER ) then
			if( rdtype <> FB_DATATYPE_UINT ) then
				rdtype = FB_DATATYPE_INTEGER
				r = astNewCONV( INVALID, rdtype, NULL, r )
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

		astDel( r )

		return l

	elseif( l->defined ) then
		select case op
		case IR_OP_ADD, IR_OP_MUL
			'' ? + c = c + ?  |  ? * c = ? * c
			astSwap( r, l )

		case IR_OP_SUB
			'' c - ? = -? + c (this will removed later if no const folding can be done)
			r = astNewUOP( IR_OP_NEG, r )
			if( r = NULL ) then
				return NULL
			end if
			astSwap( r, l )
			op = IR_OP_ADD
		end select

	elseif( r->defined ) then
		select case op
		case IR_OP_SUB
			'' ? - c = ? + -c
			select case as const rdtype
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				r->con.val.long = -r->con.val.long
			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				r->con.val.float = -r->con.val.float
			case else
				r->con.val.int = -r->con.val.int
			end select
			op = IR_OP_ADD

		case IR_OP_POW

			'' convert var ^ 2 to var * var
			if( r->con.val.float = 2.0 ) then

				'' operands will be converted to DOUBLE if not floats..
				if( l->class = AST_NODECLASS_CONV ) then
					select case l->l->class
					case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
						 AST_NODECLASS_FIELD, AST_NODECLASS_PTR
						n = l
						l = l->l
						astDel( n )
						ldtype = l->dtype
					end select
				end if

				select case l->class
				case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
					 AST_NODECLASS_FIELD, AST_NODECLASS_PTR
					astDel( r )
					r = astCloneTree( l )
					op = IR_OP_MUL
					dtype = ldtype
				end select
			end if
		end select
	end if

	''::::::
	'' handle special cases

	select case op
	case IR_OP_POW
	    return rtlMathPow( l, r )

	case IR_OP_INTDIV
		'' longint?
		if( (dtype = FB_DATATYPE_LONGINT) or _
			(dtype = FB_DATATYPE_ULONGINT) ) then
			return rtlMathLongintDIV( dtype, l, ldtype, r, rdtype )
		end if

	case IR_OP_MOD
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
	n->l  		= l
	n->r  		= r
	n->op.ex 	= ex
	n->op.op 	= op
	n->op.allocres = allocres

	function = n

end function

'':::::
function astLoadBOP( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r
    dim as integer op
    dim as IRVREG ptr v1, v2, vr

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
		if( n->op.allocres ) then
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
	astDel( l )
	astDel( r )

	function = vr

end function

