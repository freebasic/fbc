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
									byval r as ASTNODE ptr ) as ASTNODE ptr
    dim as FBSYMBOL ptr s, ls, rs

	ls = astGetSymbolOrElm( l )
	rs = astGetSymbolOrElm( r )

	'' new len = both strings' len less the 2 null-chars
	s = hAllocStringConst( symbGetVarText( ls ) + symbGetVarText( rs ), _
						   symbGetStrLen( ls ) - 1 + symbGetStrLen( rs ) - 1 )

	function = astNewVAR( s, NULL, 0, IR_DATATYPE_FIXSTR )

	astDel( r )
	astDel( l )

end function

'':::::
private sub hBOPConstFoldInt( byval op as integer, _
							  byval l as ASTNODE ptr, _
							  byval r as ASTNODE ptr ) static

	dim as integer issigned

	select case as const l->dtype
	case IR_DATATYPE_BYTE, IR_DATATYPE_SHORT, IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
		issigned = TRUE
	case else
		issigned = FALSE
	end select

	select case as const op
	case IR_OP_ADD
		l->val.int = l->val.int + r->val.int

	case IR_OP_SUB
		l->val.int = l->val.int - r->val.int

	case IR_OP_MUL
		if( issigned ) then
			l->val.int = l->val.int * r->val.int
		else
			l->val.int = cunsg(l->val.int) * cunsg(r->val.int)
		end if

	case IR_OP_INTDIV
		if( r->val.int <> 0 ) then
			if( issigned ) then
				l->val.int = l->val.int \ r->val.int
			else
				l->val.int = cunsg( l->val.int ) \ cunsg( r->val.int )
			end if
		else
			l->val.int = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_MOD
		if( r->val.int <> 0 ) then
			if( issigned ) then
				l->val.int = l->val.int mod r->val.int
			else
				l->val.int = cunsg( l->val.int ) mod cunsg( r->val.int )
			end if
		else
			l->val.int = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_SHL
		if( issigned ) then
			l->val.int = l->val.int shl r->val.int
		else
			l->val.int = cunsg( l->val.int ) shl r->val.int
		end if

	case IR_OP_SHR
		if( issigned ) then
			l->val.int = l->val.int shr r->val.int
		else
			l->val.int = cunsg( l->val.int ) shr r->val.int
		end if

	case IR_OP_AND
		l->val.int = l->val.int and r->val.int

	case IR_OP_OR
		l->val.int = l->val.int or r->val.int

	case IR_OP_XOR
		l->val.int = l->val.int xor r->val.int

	case IR_OP_EQV
		l->val.int = l->val.int eqv r->val.int

	case IR_OP_IMP
		l->val.int = l->val.int imp r->val.int

	case IR_OP_NE
		l->val.int = l->val.int <> r->val.int

	case IR_OP_EQ
		l->val.int = l->val.int = r->val.int

	case IR_OP_GT
		if( issigned ) then
			l->val.int = l->val.int > r->val.int
		else
			l->val.int = cunsg( l->val.int ) > cunsg( r->val.int )
		end if

	case IR_OP_LT
		if( issigned ) then
			l->val.int = l->val.int < r->val.int
		else
			l->val.int = cunsg( l->val.int ) < cunsg( r->val.int )
		end if

	case IR_OP_LE
		if( issigned ) then
			l->val.int = l->val.int <= r->val.int
		else
			l->val.int = cunsg( l->val.int ) <= cunsg( r->val.int )
		end if

	case IR_OP_GE
		if( issigned ) then
			l->val.int = l->val.int >= r->val.int
		else
			l->val.int = cunsg( l->val.int ) >= cunsg( r->val.int )
		end if
	end select

end sub

'':::::
private sub hBOPConstFoldFlt( byval op as integer, _
						      byval l as ASTNODE ptr, _
						      byval r as ASTNODE ptr ) static

	select case as const op
	case IR_OP_ADD
		l->val.float = l->val.float + r->val.float

	case IR_OP_SUB
		l->val.float = l->val.float - r->val.float

	case IR_OP_MUL
		l->val.float = l->val.float * r->val.float

	case IR_OP_DIV
		l->val.float = l->val.float / r->val.float

    case IR_OP_POW
		l->val.float = l->val.float ^ r->val.float

	case IR_OP_NE
		l->val.int = l->val.float <> r->val.float

	case IR_OP_EQ
		l->val.int = l->val.float = r->val.float

	case IR_OP_GT
		l->val.int = l->val.float > r->val.float

	case IR_OP_LT
		l->val.int = l->val.float < r->val.float

	case IR_OP_LE
		l->val.int = l->val.float <= r->val.float

	case IR_OP_GE
		l->val.int = l->val.float >= r->val.float

    case IR_OP_ATAN2
		l->val.float = atan2( l->val.float, r->val.float )
	end select

end sub

'':::::
private sub hBOPConstFold64( byval op as integer, _
							 byval l as ASTNODE ptr, _
							 byval r as ASTNODE ptr ) static

	dim as integer issigned

	issigned = (l->dtype = IR_DATATYPE_LONGINT)

	select case as const op
	case IR_OP_ADD
		l->val.long = l->val.long + r->val.long

	case IR_OP_SUB
		l->val.long = l->val.long - r->val.long

	case IR_OP_MUL
		if( issigned ) then
			l->val.long = l->val.long * r->val.long
		else
			l->val.long = cunsg(l->val.long) * cunsg(r->val.long)
		end if

	case IR_OP_INTDIV
		if( r->val.long <> 0 ) then
			if( issigned ) then
				l->val.long = l->val.long \ r->val.long
			else
				l->val.long = cunsg( l->val.long ) \ cunsg( r->val.long )
			end if
		else
			l->val.long = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_MOD
		if( r->val.long <> 0 ) then
			if( issigned ) then
				l->val.long = l->val.long mod r->val.long
			else
				l->val.long = cunsg( l->val.long ) mod cunsg( r->val.long )
			end if
		else
			l->val.long = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_SHL
		if( issigned ) then
			l->val.long = l->val.long shl r->val.int
		else
			l->val.long = cunsg( l->val.long ) shl r->val.int
		end if

	case IR_OP_SHR
		if( issigned ) then
			l->val.long = l->val.long shr r->val.int
		else
			l->val.long = cunsg( l->val.long ) shr r->val.int
		end if

	case IR_OP_AND
		l->val.long = l->val.long and r->val.long

	case IR_OP_OR
		l->val.long = l->val.long or r->val.long

	case IR_OP_XOR
		l->val.long = l->val.long xor r->val.long

	case IR_OP_EQV
		l->val.long = l->val.long eqv r->val.long

	case IR_OP_IMP
		l->val.long = l->val.long imp r->val.long

	case IR_OP_NE
		l->val.int = l->val.long <> r->val.long

	case IR_OP_EQ
		l->val.int = l->val.long = r->val.long

	case IR_OP_GT
		if( issigned ) then
			l->val.int = l->val.long > r->val.long
		else
			l->val.int = cunsg( l->val.long ) > cunsg( r->val.long )
		end if

	case IR_OP_LT
		if( issigned ) then
			l->val.int = l->val.long < r->val.long
		else
			l->val.int = cunsg( l->val.long ) < cunsg( r->val.long )
		end if

	case IR_OP_LE
		if( issigned ) then
			l->val.int = l->val.long <= r->val.long
		else
			l->val.int = cunsg( l->val.long ) <= cunsg( r->val.long )
		end if

	case IR_OP_GE
		if( issigned ) then
			l->val.int = l->val.long >= r->val.long
		else
			l->val.int = cunsg( l->val.long ) >= cunsg( r->val.long )
		end if
	end select

end sub

'':::::
private function hCheckPointer( byval op as integer, _
								byval dtype as integer, _
								byval dclass as integer ) as integer

    '' not int?
    if( dclass <> IR_DATACLASS_INTEGER ) then
    	return FALSE
    end if

    select case op
    '' add op?
    case IR_OP_ADD, IR_OP_SUB

    	'' another pointer?
    	if( dtype >= IR_DATATYPE_POINTER ) then
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
					byval allocres as integer = TRUE ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer ldtype, rdtype, dtype
    dim as integer ldclass, rdclass
    dim as integer doconv
    dim as FBSYMBOL ptr s, subtype

	function = NULL

	if( (l = NULL) or (r = NULL) ) then
		exit function
	end if

	ldtype = l->dtype
	rdtype = r->dtype
	ldclass = irGetDataClass( ldtype )
	rdclass = irGetDataClass( rdtype )

	''::::::
    '' pointers?
    if( ldtype >= IR_DATATYPE_POINTER ) then
    	if( not hCheckPointer( op, rdtype, rdclass ) ) then
    		exit function
    	end if
    elseif( rdtype >= IR_DATATYPE_POINTER ) then
    	if( not hCheckPointer( op, ldtype, ldclass ) ) then
    		exit function
    	end if
    end if

	'' UDT's? can't operate
	if( (ldtype = IR_DATATYPE_USERDEF) or _
		(rdtype = IR_DATATYPE_USERDEF) ) then
		exit function
    end if

    '' enums?
    if( (ldtype = IR_DATATYPE_ENUM) or _
    	(rdtype = IR_DATATYPE_ENUM) ) then
    	'' not the same?
    	if( ldtype <> rdtype ) then
    		if( (ldclass <> IR_DATACLASS_INTEGER) or _
    			(rdclass <> IR_DATACLASS_INTEGER) ) then
    			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
    		end if
    	end if
    end if

	'' longints?
	if( (ldtype = IR_DATATYPE_LONGINT) or _
		(ldtype = IR_DATATYPE_ULONGINT) or _
		(rdtype = IR_DATATYPE_LONGINT) or _
		(rdtype = IR_DATATYPE_ULONGINT) ) then

		'' same type?
		if( ldtype = rdtype ) then
			dtype = ldtype
		else
			dtype = irMaxDataType( ldtype, rdtype )
			'' one of the operands is a float? it has more precedence..
			if( dtype >= IR_DATATYPE_SINGLE ) then
				dtype = INVALID

			'' just the sign is different?
			elseif( dtype = INVALID ) then
				dtype = ldtype

			'' is the left op the longint?
			elseif( (ldtype = IR_DATATYPE_LONGINT) or _
					(ldtype = IR_DATATYPE_ULONGINT) ) then
				dtype = ldtype

			'' then it's the right..
			else
				dtype = rdtype
			end if
		end if

		if( dtype <> INVALID ) then
			select case op
			case IR_OP_INTDIV
				return rtlMathLongintDIV( dtype, l, ldtype, r, rdtype )

			case IR_OP_MOD
				return rtlMathLongintMOD( dtype, l, ldtype, r, rdtype )

			end select
		end if
    end if

    '' both zstrings? treat as string..
    if( (ldtype = IR_DATATYPE_CHAR) and _
    	(rdtype = IR_DATATYPE_CHAR) ) then
    	ldclass = IR_DATACLASS_STRING
    	rdclass = ldclass
    end if

    '' wstrings?
    if( (ldtype = IR_DATATYPE_WCHAR) or _
    	(rdtype = IR_DATATYPE_WCHAR) ) then

		'' both aren't wstrings?
		if( ldtype <> rdtype ) then
			if( ldtype = IR_DATATYPE_WCHAR ) then
				'' not a string?
				if( rdclass <> IR_DATACLASS_STRING ) then
					exit function
				end if
			else
				'' not a string?
				if( ldclass <> IR_DATACLASS_STRING ) then
					exit function
				end if
			end if
		end if

		select case as const op
		'' concatenation?
		case IR_OP_ADD
			return rtlWstrConcat( l, ldtype, r, rdtype )

		'' comparation?
		case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE
			'' convert to: wstrcmp(l,r) op 0
			l = rtlWstrCompare( l, r )
			r = astNewCONSTi( 0, IR_DATATYPE_INTEGER )

			ldtype = l->dtype
			rdtype = r->dtype
			ldclass = IR_DATACLASS_INTEGER
			rdclass = IR_DATACLASS_INTEGER

		'' no other operation allowed
		case else
			exit function
		end select

    '' strings?
    elseif( (ldclass = IR_DATACLASS_STRING) or _
    		(rdclass = IR_DATACLASS_STRING) ) then

		'' both aren't strings?
		if( ldclass <> rdclass ) then
			if( ldclass = IR_DATACLASS_STRING ) then
				'' not a zstring?
				if( rdtype <> IR_DATATYPE_CHAR ) then
					exit function
				end if
			else
				'' not a zstring?
				if( ldtype <> IR_DATATYPE_CHAR ) then
					exit function
				end if
			end if
		end if

		select case as const op
		'' concatenation?
		case IR_OP_ADD
			'' check for string literals
			if( (ldtype = IR_DATATYPE_FIXSTR) and _
				(rdtype = IR_DATATYPE_FIXSTR) ) then
				if( l->class = AST_NODECLASS_VAR ) then
					if( r->class = AST_NODECLASS_VAR ) then
						s = astGetSymbolOrElm( l )
						if( symbGetVarInitialized( s ) ) then
							s = astGetSymbolOrElm( r )
							if( symbGetVarInitialized( s ) ) then
								return hStrLiteralConcat( l, r )
							end if
						end if
					end if
				end if
			end if

			'' result will be always an var-len string
			ldtype = IR_DATATYPE_STRING
			ldclass = IR_DATACLASS_STRING
			rdtype = ldtype
			rdclass = ldclass

			'' concatenation will only be done when loading,
			'' to allow optimizations..

		'' comparation?
		case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE
			'' convert to: strcmp(l,r) op 0
			l = rtlStrCompare( l, ldtype, r, rdtype )
			r = astNewCONSTi( 0, IR_DATATYPE_INTEGER )

			ldtype = l->dtype
			ldclass = IR_DATACLASS_INTEGER
			rdtype = r->dtype
			rdclass = IR_DATACLASS_INTEGER

		'' no other operation allowed
		case else
			exit function
		end select
    end if

    ''::::::

	'' convert byte to int
	if( irGetDataSize( ldtype ) = 1 ) then
		if( irIsSigned( ldtype ) ) then
			ldtype = IR_DATATYPE_INTEGER
		else
			ldtype = IR_DATATYPE_UINT
		end if
		l = astNewCONV( INVALID, ldtype, NULL, l )
	end if

	if( irGetDataSize( rdtype ) = 1 ) then
		if( irIsSigned( rdtype ) ) then
			rdtype = IR_DATATYPE_INTEGER
		else
			rdtype = IR_DATATYPE_UINT
		end if
		r = astNewCONV( INVALID, rdtype, NULL, r )
	end if

    '' convert types
	select case as const op
	'' flt div (/) can only operate on floats
	case IR_OP_DIV

		if( ldclass <> IR_DATACLASS_FPOINT ) then
			ldtype = IR_DATATYPE_DOUBLE
			l = astNewCONV( INVALID, ldtype, NULL, l )
			ldclass = IR_DATACLASS_FPOINT
		end if

		if( rdclass <> IR_DATACLASS_FPOINT ) then
			'' x86 assumption: if it's an int var, let the FPU do it
			if( (r->class = AST_NODECLASS_VAR) and (rdtype = IR_DATATYPE_INTEGER) ) then
				rdtype = IR_DATATYPE_DOUBLE
			else
				rdtype = IR_DATATYPE_DOUBLE
				r = astNewCONV( INVALID, rdtype, NULL, r )
			end if
			rdclass = IR_DATACLASS_FPOINT
		end if

	'' bitwise ops, int div (\), modulus and shift can only operate on integers
	case IR_OP_AND, IR_OP_OR, IR_OP_XOR, IR_OP_EQV, IR_OP_IMP, _
		 IR_OP_INTDIV, IR_OP_MOD, IR_OP_SHL, IR_OP_SHR

		if( ldclass <> IR_DATACLASS_INTEGER ) then
			ldtype = IR_DATATYPE_INTEGER
			l = astNewCONV( INVALID, ldtype, NULL, l )
			ldclass = IR_DATACLASS_INTEGER
		end if

		if( rdclass <> IR_DATACLASS_INTEGER ) then
			rdtype = IR_DATATYPE_INTEGER
			r = astNewCONV( INVALID, rdtype, NULL, r )
			rdclass = IR_DATACLASS_INTEGER
		end if

	'' atan2 can only operate on floats
	case IR_OP_ATAN2, IR_OP_POW

		if( ldclass <> IR_DATACLASS_FPOINT ) then
			ldtype = IR_DATATYPE_DOUBLE
			l = astNewCONV( INVALID, ldtype, NULL, l )
			ldclass = IR_DATACLASS_FPOINT
		end if

		if( rdclass <> IR_DATACLASS_FPOINT ) then
			rdtype = IR_DATATYPE_DOUBLE
			r = astNewCONV( INVALID, rdtype, NULL, r )
			rdclass = IR_DATACLASS_FPOINT
		end if

	end select

    ''::::::

    '' convert types to the most precise if needed
	if( ldtype <> rdtype ) then

		dtype = irMaxDataType( ldtype, rdtype )

		'' don't convert?
		if( dtype = INVALID ) then

			'' as types are different, if class is fp,
			'' the result type will be always a double
			if( ldclass = IR_DATACLASS_FPOINT ) then
				dtype   = IR_DATATYPE_DOUBLE
				subtype = NULL
			else

				'' an ENUM or POINTER always has the precedence
				if( (rdtype = IR_DATATYPE_ENUM) or _
					(rdtype >= IR_DATATYPE_POINTER) ) then
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
					if( ldclass = IR_DATACLASS_FPOINT ) then
						if( rdclass = IR_DATACLASS_INTEGER ) then
							'' can't be an longint nor a byte (byte operands are converted above)
							if( irGetDataSize( rdtype ) < FB_INTEGERSIZE*2 ) then
								select case r->class
								case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR
									'' can't be unsigned either
									if( irIsSigned( rdtype ) ) then
										doconv = FALSE
									end if
								end select
							end if
						end if
					end if

					if( doconv ) then
						r = astNewCONV( INVALID, dtype, subtype, r )
					end if
				end select

				rdtype = dtype
				rdclass = ldclass
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
		dtype = IR_DATATYPE_INTEGER
		subtype = NULL

	'' right-operand must be an integer, so pow2 opts can be done on longint's
	case IR_OP_SHL, IR_OP_SHR
		if( rdtype <> IR_DATATYPE_INTEGER ) then
			if( rdtype <> IR_DATATYPE_UINT ) then
				rdtype = IR_DATATYPE_INTEGER
				r = astNewCONV( INVALID, rdtype, NULL, r )
				rdclass = IR_DATACLASS_INTEGER
			end if
		end if
	end select

	''::::::

	'' constant folding (won't handle commutation, ie: "1+a+2+3" will become "1+a+5", not "a+6")
	if( l->defined and r->defined ) then

		select case as const ldtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		    hBOPConstFold64( op, l, r )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			hBOPConstFoldFlt( op, l, r )
		case else
			'' byte's, short's, int's and enum's
			hBOPConstFoldInt( op, l, r )
		end select

		l->dtype 	= dtype
		l->subtype  = subtype

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
			case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
				r->val.long = -r->val.long
			case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
				r->val.float = -r->val.float
			case else
				r->val.int = -r->val.int
			end select
			op = IR_OP_ADD

		case IR_OP_POW

			'' convert var ^ 2 to var * var
			if( r->val.float = 2.0 ) then

				'' operands will be converted to DOUBLE if not floats..
				if( l->class = AST_NODECLASS_CONV ) then
					select case l->l->class
					case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR
						n = l
						l = l->l
						astDel( n )
						ldtype = l->dtype
					end select
				end if

				select case l->class
				case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR
					astDel( r )
					r = astCloneTree( l )
					op = IR_OP_MUL
					dtype = ldtype
				end select
			end if
		end select
	end if

	''::::::
	'' handle pow
	if( op = IR_OP_POW ) then
		return rtlMathPow( l, r )
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_BOP, dtype, subtype )
	if( n = NULL ) then
		exit function
	end if

	'' fill it
	n->op 		= op
	n->l  		= l
	n->r  		= r
	n->ex 		= ex
	n->allocres	= allocres

	function = n

end function

'':::::
function astLoadBOP( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r
    dim as integer op
    dim as IRVREG ptr v1, v2, vr

	op = n->op
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
		if( n->allocres ) then
			vr = irAllocVREG( n->dtype )
		else
			vr = NULL
		end if

		'' execute the operation
		if( n->ex <> NULL ) then
			'' hack! ex=label, vr being NULL 'll gen better code at IR..
			irEmitBOPEx( op, v1, v2, NULL, n->ex )
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

