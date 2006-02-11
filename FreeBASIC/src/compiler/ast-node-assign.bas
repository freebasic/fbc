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

'' AST assignment nodes
'' l = destine; r = source
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
function astNewASSIGN( byval l as ASTNODE ptr, _
					   byval r as ASTNODE ptr, _
					   byval checktypes as integer = TRUE ) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer dtype
    dim as integer ldtype, rdtype
    dim as integer ldclass, rdclass
    dim as FBSYMBOL ptr lsubtype, proc
    dim as integer is_str

	function = NULL

	ldtype   = l->dtype
	lsubtype = l->subtype
	rdtype   = r->dtype
	ldclass  = irGetDataClass( ldtype )
	rdclass	 = irGetDataClass( rdtype )

    '' strings?
    if( (ldclass = IR_DATACLASS_STRING) or _
    	(rdclass = IR_DATACLASS_STRING) ) then

		'' both strings?
		if( ldclass = rdclass ) then
			'' don't do any assignment by now to allow optimizations..

		'' nope..
		else
			'' check if it's not a byte ptr
			if( ldclass = IR_DATACLASS_STRING ) then
				'' not a w|zstring?
				select case rdtype
				case IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR

				case else
					if( r->class <> AST_NODECLASS_PTR ) then
						exit function
					elseif( rdtype <> IR_DATATYPE_BYTE ) then
						if( rdtype <> IR_DATATYPE_UBYTE ) then
							exit function
						end if
					end if
				end select

			else
				'' not a w|zstring?
				select case ldtype
				case IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR

				case else
					if( l->class <> AST_NODECLASS_PTR ) then
						exit function
					elseif( ldtype <> IR_DATATYPE_BYTE ) then
						if( ldtype <> IR_DATATYPE_UBYTE ) then
							exit function
						end if
					end if
				end select
			end if

			return rtlStrAssign( l, r )

		end if


	'' UDT's?
	elseif( (ldtype = IR_DATATYPE_USERDEF) or _
			(rdtype = IR_DATATYPE_USERDEF) ) then

		'' l node must be an UDT's,
		if( ldtype <> IR_DATATYPE_USERDEF ) then
			exit function
		else
			'' "udtfunct() = udt" is not allowed, l node must be a variable
			if( l->class = AST_NODECLASS_FUNCT ) then
				exit function
			end if
		end if

        '' r is not an UDT?
		if( rdtype <> IR_DATATYPE_USERDEF ) then
			'' not a function returning an UDT on regs?
			if( r->class <> AST_NODECLASS_FUNCT ) then
				exit function
			end if

            '' handle functions returning UDT's when type isn't a pointer,
            '' but an integer or fpoint register
            proc = r->sym
            if( proc->typ <> IR_DATATYPE_USERDEF ) then
            	exit function
            end if

        	'' different subtypes?
			if( l->subtype <> proc->subtype ) then
				exit function
			end if

			'' any pointer fields?
			if( symbGetUDTDynCnt( l->subtype ) <> 0 ) then
				hReportWarning( FB_WARNINGMSG_DYNAMICFIELDS )
			end if

            '' fake l's type
            ldtype   = proc->proc.realtype
            lsubtype = NULL
            astSetDataType( l, ldtype )

		'' both are UDT's, do a mem copy..
		else

        	'' different subtypes?
			if( l->subtype <> r->subtype ) then
				exit function
			end if

			'' any dynamic fields?
			if( symbGetUDTDynCnt( l->subtype ) <> 0 ) then
				hReportWarning( FB_WARNINGMSG_DYNAMICFIELDS )
			end if

			return astNewMEM( IR_OP_MEMMOVE, l, r, symbGetUDTLen( l->subtype ) )
		end if

    '' wstrings?
    elseif( (ldtype = IR_DATATYPE_WCHAR) or _
    		(rdtype = IR_DATATYPE_WCHAR) ) then

		'' both wstrings?
		if( ldtype = rdtype ) then
			'' don't do any assignment by now to allow optimizations..

		else
		    '' left?
			if( ldtype = IR_DATATYPE_WCHAR ) then
				'' is right a zstring? (fixed- or
				'' var-len strings won't reach here)
				is_str = ( rdtype = IR_DATATYPE_CHAR )

			'' right?
			else
				'' is left a zstring?
				is_str = ( ldtype = IR_DATATYPE_CHAR )
			end if

			if( is_str ) then
				return rtlWstrAssign( l, r )

			'' one is not a string, nor a udt, treat as
			'' numeric type, let emit convert them if needed..
			else

				if( ldtype = IR_DATATYPE_WCHAR ) then
					'' don't allow, unless it's a pointer
					if( l->class <> AST_NODECLASS_PTR ) then
						exit function
					end if

					'' remap the type or the optimizer will
					'' assume it's a string assignment
					ldtype = env.target.wchar.type

				else
					'' same as above..
					if( r->class <> AST_NODECLASS_PTR ) then
						exit function
					end if

					rdtype = env.target.wchar.type
				end if

			end if
		end if

    '' zstrings?
    elseif( (ldtype = IR_DATATYPE_CHAR) or _
    		(rdtype = IR_DATATYPE_CHAR) ) then

		'' both the same? assign as string..
		if( ldtype = rdtype ) then
			return rtlStrAssign( l, r )
		end if

		'' same as for wstring's..
		if( ldtype = IR_DATATYPE_CHAR ) then
			'' don't allow, unless it's a pointer
			if( l->class <> AST_NODECLASS_PTR ) then
				exit function
			end if

			ldtype = IR_DATATYPE_UBYTE

		else
			'' same as above..
			if( r->class <> AST_NODECLASS_PTR ) then
				exit function
			end if

			rdtype = IR_DATATYPE_UBYTE
		end if

    '' enums?
    elseif( (ldtype = IR_DATATYPE_ENUM) or _
    		(rdtype = IR_DATATYPE_ENUM) ) then

    	'' not the same?
    	if( ldtype <> rdtype ) then
    		if( (ldclass <> IR_DATACLASS_INTEGER) or _
    			(rdclass <> IR_DATACLASS_INTEGER) ) then
    			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
    		end if
    	end if

	end if


    '' check pointers
    if( checktypes ) then
    	if( ldtype >= IR_DATATYPE_POINTER ) then
	    	'' function ptr?
    		if( ldtype = IR_DATATYPE_POINTER + IR_DATATYPE_FUNCTION ) then
    			if( astFuncPtrCheck( ldtype, l->subtype, r ) = FALSE ) then
   					hReportWarning( FB_WARNINGMSG_SUSPICIOUSPTRASSIGN )
    			end if

    		'' ordinary ptr..
    		else
				if( astPtrCheck( ldtype, l->subtype, r ) = FALSE ) then
					hReportWarning( FB_WARNINGMSG_SUSPICIOUSPTRASSIGN )
				end if
			end if

    	'' r-side expr is a ptr?
    	elseif( rdtype >= IR_DATATYPE_POINTER ) then
    		hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
    	end if
    end if

	'' convert types if needed
	if( ldtype <> rdtype ) then
		'' don't convert strings
		if( rdclass <> IR_DATACLASS_STRING ) then
			'' constant?
			if( r->defined ) then
				r = astCheckConst( l->dtype, r )
				if( r = NULL ) then
					exit function
				end if
			end if

			'' x86 assumption: let the fpu do the convertion if any operand
			''				   is a float (unless a special case must be handled)
			if( ((ldclass <> IR_DATACLASS_FPOINT) and _
				 (rdclass <> IR_DATACLASS_FPOINT)) or _
				(ldtype = IR_DATATYPE_ULONGINT) ) then
				r = astNewCONV( INVALID, ldtype, l->subtype, r )
				if( r = NULL ) then
					exit function
				end if
			end if
		end if
	end if


	'' alloc new node
	n = astNewNode( AST_NODECLASS_ASSIGN, ldtype, lsubtype )

	if( n = NULL ) then
		return NULL
	end if

	n->l  = l
	n->r  = r

	function = n

end function

'':::::
private function hSetBitField( byval l as ASTNODE ptr, _
							   byval r as ASTNODE ptr _
							 ) as ASTNODE ptr static

	dim as FBSYMBOL ptr s

	s = l->subtype

	l->dtype = s->typ
	l->subtype = NULL

	l = astNewBOP( IR_OP_AND, astCloneTree( l ), _
				   astNewCONSTi( not (ast_bitmaskTB(s->bitfld.bits) shl s->bitfld.bitpos), _
				   				 IR_DATATYPE_UINT ) )

	if( s->bitfld.bitpos > 0 ) then
		r = astNewBOP( IR_OP_SHL, r, _
				   	   astNewCONSTi( s->bitfld.bitpos, IR_DATATYPE_UINT ) )
	end if

	function = astNewBOP( IR_OP_OR, l, r )

end function

'':::::
function astLoadASSIGN( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r
    dim as IRVREG ptr vs, vr

	l = n->l
	r = n->r
	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' handle bitfields..
	if( l->dtype = IR_DATATYPE_BITFIELD ) then
		'' l is a field node, use its left child instead
		r = hSetBitField( l->l, r )
		'' the field node can be removed
		astDel( l )
		l = l->l
	end if

	vs = astLoad( r )
	vr = astLoad( l )

	if( ast.doemit ) then
		irEmitSTORE( vr, vs )
	end if

	astDel( l )
	astDel( r )

	function = vr

end function

