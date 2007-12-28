''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private function hCheckStringOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldclass as FB_DATACLASS, _
		byval r as ASTNODE ptr, _
		byval rdclass as FB_DATACLASS _
	) as integer

	function = FALSE

	'' check if it's not a byte ptr
	if( ldclass = FB_DATACLASS_STRING ) then
		'' not a w|zstring?
		select case r->dtype
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		case else
			if( r->class <> AST_NODECLASS_DEREF ) then
				exit function
			elseif( r->dtype <> FB_DATATYPE_BYTE ) then
				if( r->dtype <> FB_DATATYPE_UBYTE ) then
					exit function
				end if
			end if
		end select

	else
		'' not a w|zstring?
		select case l->dtype
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		case else
			if( l->class <> AST_NODECLASS_DEREF ) then
				exit function
			elseif( l->dtype <> FB_DATATYPE_BYTE ) then
				if( l->dtype <> FB_DATATYPE_UBYTE ) then
					exit function
				end if
			end if
		end select
	end if

	function = TRUE

end function

'':::::
private function hCheckUDTOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldclass as FB_DATACLASS, _
		byval r as ASTNODE ptr, _
		byval rdclass as FB_DATACLASS _
	) as integer

	dim as FBSYMBOL ptr proc = any

	function = FALSE

	'' l node must be an UDT's,
	if( l->dtype <> FB_DATATYPE_STRUCT ) then
		exit function
	else
		'' "udtfunct() = udt" is not allowed, l node must be a variable
		if( l->class = AST_NODECLASS_CALL ) then
			exit function
		end if
	end if

    '' is r an UDT?
	if( r->dtype <> FB_DATATYPE_STRUCT ) then
		exit function
	end if

   	'' different subtypes?
	if( l->subtype <> r->subtype ) then
		exit function
	end if

	function = TRUE

end function

'':::::
private function hCheckWstringOps _
	( _
		byval l as ASTNODE ptr, _
		byref ldtype as FB_DATATYPE, _
		byval r as ASTNODE ptr, _
		byref rdtype as FB_DATATYPE, _
		byref is_zstr as integer _
	) as integer

	function = FALSE

    '' left?
	if( ldtype = FB_DATATYPE_WCHAR ) then
		'' is right a zstring? (fixed- or
		'' var-len strings won't reach here)
		is_zstr = ( rdtype = FB_DATATYPE_CHAR )

	'' right?
	else
		'' is left a zstring?
		is_zstr = ( ldtype = FB_DATATYPE_CHAR )
	end if

	if( is_zstr ) then
		return TRUE
	end if

	'' one is not a string, nor a udt, treat as
	'' numeric type, let emit convert them if needed..
	if( ldtype = FB_DATATYPE_WCHAR ) then
		'' don't allow, unless it's a pointer
		if( l->class <> AST_NODECLASS_DEREF ) then
			exit function
		end if

		'' remap the type or the optimizer will
		'' assume it's a string assignment
		ldtype = env.target.wchar.type

	else
		'' same as above..
		if( r->class <> AST_NODECLASS_DEREF ) then
			exit function
		end if

		rdtype = env.target.wchar.type
	end if

	function = TRUE

end function

'':::::
private function hCheckZstringOps _
	( _
		byval l as ASTNODE ptr, _
		byref ldtype as FB_DATATYPE, _
		byval r as ASTNODE ptr, _
		byref rdtype as FB_DATATYPE _
	) as integer

	function = FALSE

	'' same as for wstring's..
	if( ldtype = FB_DATATYPE_CHAR ) then
		'' don't allow, unless it's a pointer
		if( l->class <> AST_NODECLASS_DEREF ) then
			exit function
		end if

		ldtype = FB_DATATYPE_UBYTE

	else
		'' same as above..
		if( r->class <> AST_NODECLASS_DEREF ) then
			exit function
		end if

		rdtype = FB_DATATYPE_UBYTE
	end if

	function = TRUE

end function

'':::::
private function hCheckEnumOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldclass as FB_DATACLASS, _
		byval r as ASTNODE ptr, _
		byval rdclass as FB_DATACLASS _
	) as integer

	function = FALSE

    '' not the same?
    if( l->dtype <> r->dtype ) then
    	if( (ldclass <> FB_DATACLASS_INTEGER) or _
    		(rdclass <> FB_DATACLASS_INTEGER) ) then
    		errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
    	end if
    end if

    function = TRUE

end function

'':::::
private function hCheckPointerOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldtype as FB_DATATYPE, _
		byval r as ASTNODE ptr, _
		byval rdtype as FB_DATATYPE _
	) as integer

	function = FALSE

    if( typeGetDatatype( ldtype ) = FB_DATATYPE_POINTER ) then
		if( astPtrCheck( ldtype, l->subtype, r ) = FALSE ) then
			errReportWarn( FB_WARNINGMSG_SUSPICIOUSPTRASSIGN )
		end if

    '' r-side expr is a ptr?
    elseif( typeGetDatatype( rdtype ) = FB_DATATYPE_POINTER ) then
    	errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
    end if

    function = TRUE

end function

'':::::
function astCheckASSIGN _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr n = any
    dim as FB_DATATYPE ldtype = any, rdtype = any
    dim as FB_DATACLASS ldclass = any, rdclass = any

	function = FALSE

	ldtype = l->dtype
	rdtype = r->dtype
	ldclass = symbGetDataClass( ldtype )
	rdclass = symbGetDataClass( rdtype )

    '' strings?
    if( (ldclass = FB_DATACLASS_STRING) or _
    	(rdclass = FB_DATACLASS_STRING) ) then

		'' both not strings?
		if( ldclass <> rdclass ) then
			if( hCheckStringOps( l, ldclass, r, rdclass ) = FALSE ) then
				exit function
			end if
		end if

		return TRUE

	'' UDT's?
	elseif( (ldtype = FB_DATATYPE_STRUCT) or _
			(rdtype = FB_DATATYPE_STRUCT) ) then

		if( hCheckUDTOps( l, ldclass, r, rdclass ) = FALSE ) then
			exit function
		end if

		return TRUE

    '' wstrings?
    elseif( (ldtype = FB_DATATYPE_WCHAR) or _
    		(rdtype = FB_DATATYPE_WCHAR) ) then

		'' both = wstrings?
		if( ldtype <> rdtype ) then
    		dim as integer is_zstr
			if( hCheckWstringOps( l, ldtype, r, rdtype, is_zstr ) = FALSE ) then
				exit function
			end if

			if( is_zstr ) then
				return TRUE
			end if
		end if

    '' zstrings?
    elseif( (ldtype = FB_DATATYPE_CHAR) or _
    		(rdtype = FB_DATATYPE_CHAR) ) then

		'' both zstrings?
		if( ldtype = rdtype ) then
			return TRUE
		end if

		if( hCheckZstringOps( l, ldtype, r, rdtype ) = FALSE ) then
			exit function
		end if

    '' enums?
    elseif( (ldtype = FB_DATATYPE_ENUM) or _
    		(rdtype = FB_DATATYPE_ENUM) ) then

		if( hCheckEnumOps( l, ldclass, r, rdclass ) = FALSE ) then
			exit function
		end if

	end if

    '' check pointers
	if( hCheckPointerOps( l, ldtype, r, rdtype ) = FALSE ) then
		exit function
	end if

	'' convert types if needed
	if( ldtype <> rdtype ) then
		'' don't convert strings
		if( rdclass <> FB_DATACLASS_STRING ) then
			'' constant?
			if( astIsCONST( r ) ) then
				r = astCheckConst( l->dtype, r )
				if( r = NULL ) then
					exit function
				end if
			end if

			if( astCheckCONV( ldtype, l->subtype, r ) = FALSE ) then
				exit function
			end if
		end if
	end if

	function = TRUE

end function

'':::::
function astNewASSIGN _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval options as AST_OPOPT _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as FB_DATATYPE ldtype = any, rdtype = any
    dim as FB_DATACLASS ldclass = any, rdclass = any
    dim as FBSYMBOL ptr lsubtype = any, proc = any
	dim as FB_ERRMSG err_num = any

	function = NULL

	if( (options and AST_OPOPT_DONTCHKOPOVL) = 0 ) then
		'' 1st) check assign op overloading
		proc = symbFindSelfBopOvlProc( AST_OP_ASSIGN, l, r, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			return astBuildCall( proc, 2, l, r )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				return NULL
			end if
		end if
	end if

	ldtype = l->dtype
	ldclass = symbGetDataClass( ldtype )
	lsubtype = l->subtype

	if( (options and AST_OPOPT_DONTCHKOPOVL) = 0 ) then
		'' 2nd) implicit casting op overloading
		proc = symbFindCastOvlProc( ldtype, lsubtype, r, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			r = astBuildCall( proc, 1, r )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				return NULL
			end if
		end if
	end if

	rdtype = r->dtype
	rdclass = symbGetDataClass( rdtype )

    '' strings?
    if( (ldclass = FB_DATACLASS_STRING) or _
    	(rdclass = FB_DATACLASS_STRING) ) then

		'' both not strings?
		if( ldclass <> rdclass ) then
			if( hCheckStringOps( l, ldclass, r, rdclass ) = FALSE ) then
				exit function
			end if

			return rtlStrAssign( l, r, (options and AST_OPOPT_ISINI) <> 0 )
		end if

		'' otherwise, don't do any assignment by now to allow optimizations..
		if( (options and AST_OPOPT_ISINI) <> 0 ) then
			'' unless it's an initialization
			return rtlStrAssign( l, r, TRUE )
		end if

	'' UDT's?
	elseif( (ldtype = FB_DATATYPE_STRUCT) or _
			(rdtype = FB_DATATYPE_STRUCT) ) then

		if( hCheckUDTOps( l, ldclass, r, rdclass ) = FALSE ) then
			exit function
		end if

        '' is r an UDT too?
        dim as integer is_udt = TRUE
        if( astIsCALL( r ) ) then
        	is_udt = typeIsPtrTo( symbGetUDTRetType( r->subtype ), 1, FB_DATATYPE_STRUCT )
        end if

		if( is_udt ) then
			'' type ini tree?
			if( r->class = AST_NODECLASS_TYPEINI ) then
				'' skip any casting if they won't do any conversion
				dim as ASTNODE ptr t = l
				if( l->class = AST_NODECLASS_CONV ) then
					if( l->cast.doconv = FALSE ) then
						t = l->l
					end if
				end if

				'' !!FIXME!! can't be used with complex l-hand side expressions
				if( t->class = AST_NODECLASS_VAR ) then
					'' no double assign, just flush the tree
					return astTypeIniFlush( r, l->sym, AST_INIOPT_NONE )
				end if
			end if

			'' do a shallow copy..

			'' call? deref the pointer
			if( astIsCALL( r ) ) then
				r = astBuildCallHiddenResVar( r )
			end if

			return astNewMEM( AST_OP_MEMMOVE, _
							  l, _
							  r, _
							  symbGetUDTUnpadLen( l->subtype ) )

		'' r is function returning an UDT on registers
		else
            '' patch both type
            ldtype = symbGetUDTRetType( r->subtype )
            lsubtype = NULL
            ldclass = symbGetDataClass( ldtype )
            astSetType( l, ldtype, NULL )

            rdtype = ldtype
            rdclass = ldclass
            astSetType( r, rdtype, NULL )
		end if

    '' wstrings?
    elseif( (ldtype = FB_DATATYPE_WCHAR) or _
    		(rdtype = FB_DATATYPE_WCHAR) ) then

		'' both not wstrings? otherwise don't do any assignment by now
		'' to allow optimizations..
		if( ldtype <> rdtype ) then
    		dim as integer is_zstr

			if( hCheckWstringOps( l, ldtype, r, rdtype, is_zstr ) = FALSE ) then
				exit function
			end if

			'' one of them is an ascii string, just assign
			if( is_zstr ) then
				return rtlWstrAssign( l, r, (options and AST_OPOPT_ISINI) <> 0 )
			end if
		end if

		'' unless it's an initialization
		if( (options and AST_OPOPT_ISINI) <> 0 ) then
			return rtlWstrAssign( l, r, TRUE )
		end if

    '' zstrings?
    elseif( (ldtype = FB_DATATYPE_CHAR) or _
    		(rdtype = FB_DATATYPE_CHAR) ) then

		'' both the same? assign as string..
		if( ldtype = rdtype ) then
			return rtlStrAssign( l, r )
		end if

		if( hCheckZstringOps( l, ldtype, r, rdtype ) = FALSE ) then
			exit function
		end if

    '' enums?
    elseif( (ldtype = FB_DATATYPE_ENUM) or _
    		(rdtype = FB_DATATYPE_ENUM) ) then

		if( hCheckEnumOps( l, ldclass, r, rdclass ) = FALSE ) then
			exit function
		end if

	end if

    '' check pointers
    if( (options and AST_OPOPT_DONTCHKPTR) = 0 ) then
		if( hCheckPointerOps( l, ldtype, r, rdtype ) = FALSE ) then
			exit function
		end if
    end if

	'' convert types if needed
	if( ldtype <> rdtype ) then
		'' don't convert strings
		if( rdclass <> FB_DATACLASS_STRING ) then
			'' constant?
			if( astIsCONST( r ) ) then
				r = astCheckConst( l->dtype, r )
				if( r = NULL ) then
					exit function
				end if
			end if

			'' let the fpu do the convertion if any operand
			'' is a float (unless a special case must be handled)
			dim as integer doconv = TRUE
			if( (ldclass = FB_DATACLASS_FPOINT) or (rdclass = FB_DATACLASS_FPOINT) ) then
				if( ldtype <> FB_DATATYPE_ULONGINT ) then
					doconv = irGetOption( IR_OPT_FPU_CONVERTOPER )
				end if
			end if

			if( doconv ) then
				r = astNewCONV( ldtype, l->subtype, r )
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

	n->l = l
	n->r = r

	function = n

end function

'':::::
private function hSetBitField _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr s = any

	s = l->subtype

	'' remap type
	l->dtype = s->typ
	l->subtype = NULL

	l = astNewBOP( AST_OP_AND, astCloneTree( l ), _
				   astNewCONSTi( not (ast_bitmaskTB(s->bitfld.bits) shl s->bitfld.bitpos), _
				   				 FB_DATATYPE_UINT ) )

	if( s->bitfld.bitpos > 0 ) then
		r = astNewBOP( AST_OP_SHL, r, _
				   	   astNewCONSTi( s->bitfld.bitpos, FB_DATATYPE_UINT ) )
	end if

	function = astNewBOP( AST_OP_OR, l, r )

end function

'':::::
function astLoadASSIGN _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any, r = any
    dim as IRVREG ptr vs = any, vr = any

	l = n->l
	r = n->r
	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' handle bitfields..
	if( l->class = AST_NODECLASS_FIELD ) then
		if( l->l->dtype = FB_DATATYPE_BITFIELD ) then
			'' l is a field node, use its left child instead
			r = hSetBitField( l->l, r )
			'' the field node can be removed
			astDelNode( l )
			l = l->l
		end if
	end if

	vs = astLoad( r )
	vr = astLoad( l )

	if( ast.doemit ) then
		irEmitSTORE( vr, vs )
	end if

	astDelNode( l )
	astDelNode( r )

	function = vr

end function

