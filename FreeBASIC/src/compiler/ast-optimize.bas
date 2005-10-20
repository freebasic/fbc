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


'' AST optimizations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constant folding optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hOptConstRmNeg( byval n as ASTNODE ptr, _
					  		byval p as ASTNODE ptr )
	static as ASTNODE ptr l, r

	'' check any UOP node, and if its of the kind "-var + const" convert to "const - var"
	if( p <> NULL ) then
		if( n->class = AST_NODECLASS_UOP ) then
			if( n->op = IR_OP_NEG ) then
				l = n->l
				if( l->class = AST_NODECLASS_VAR ) then
					if( p->class = AST_NODECLASS_BOP ) then
						if( p->op = IR_OP_ADD ) then
							r = p->r
							if( r->defined ) then
								p->op = IR_OP_SUB
								p->l = p->r
								p->r = n->l
								astDel( n )
								exit sub
							end if
						end if
					end if
				end if
		    end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		hOptConstRmNeg( l, n )
	end if

	r = n->r
	if( r <> NULL ) then
		hOptConstRmNeg( r, n )
	end if

end sub

'':::::
private sub hConvDataType( byval v as FBVALUE ptr, _
						   byval vdtype as integer, _
						   byval dtype as integer ) static

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	select case as const dtype
	''
	case IR_DATATYPE_LONGINT

		select case as const vdtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		    '' no conversion
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			v->long = clngint( v->float )
		case else
			v->long = clngint( v->int )
		end select

	''
	case IR_DATATYPE_ULONGINT

		select case as const vdtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		    '' no conversion
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			v->long = culngint( v->float )
		case else
			v->long = culngint( v->int )
		end select

	''
	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE

		if( vdtype > IR_DATATYPE_POINTER ) then
			vdtype = IR_DATATYPE_POINTER
		end if

		select case as const vdtype
		case IR_DATATYPE_LONGINT
		    v->float = cdbl( v->long )
		case IR_DATATYPE_ULONGINT
			v->float = cdbl( cunsg( v->long ) )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			'' do nothing
		case IR_DATATYPE_UINT, IR_DATATYPE_POINTER
			v->float = cdbl( cuint( v->int ) )
		case else
			v->float = cdbl( v->int )
		end select

	''
	case IR_DATATYPE_UINT, IR_DATATYPE_POINTER

	 	select case as const vdtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		    v->int = cuint( v->long )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			v->int = cuint( v->float )
		end select

	''
	case else

		select case as const vdtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		    v->int = cint( v->long )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			v->int = cint( v->float )
		end select

    end select

end sub

''::::::
private function hPrepConst( byval v as ASTVALUE ptr, _
							 byval r as ASTNODE ptr ) as integer static
	dim as integer dtype

	'' first node? just copy..
	if( v->dtype = INVALID ) then
		v->dtype = r->dtype
		select case as const v->dtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			v->val.long = r->val.long
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			v->val.float = r->val.float
		case else
            v->val.int = r->val.int
		end select

		return INVALID
	end if

    ''
	dtype = irMaxDataType( v->dtype, r->dtype )

	'' same? don't convert..
	if( dtype = INVALID ) then
		'' an ENUM or POINTER always has the precedence
		if( (r->dtype = IR_DATATYPE_ENUM) or (r->dtype >= IR_DATATYPE_POINTER) ) then
			return r->dtype
		else
			return v->dtype
		end if
	end if

	'' convert r to v's type
	if( dtype = v->dtype ) then
		hConvDataType( @r->val, r->dtype, dtype )

	'' convert v to r's type
	else
		hConvDataType( @v->val, v->dtype, dtype )
		v->dtype = dtype
	end if

	return dtype

end function

'':::::
private function hConstAccumADDSUB( byval n as ASTNODE ptr, _
							   		byval v as ASTVALUE ptr, _
							   		byval op as integer ) as ASTNODE ptr
	dim as ASTNODE ptr l, r
	dim as integer o
	static as integer dtype

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST_NODECLASS_BOP ) then
		return n
	end if

    o = n->op

	select case o
	case IR_OP_ADD, IR_OP_SUB
		l = n->l
		r = n->r

		if( r->defined ) then

			if( op < 0 ) then
				if( o = IR_OP_ADD ) then
					o = IR_OP_SUB
				else
					o = IR_OP_ADD
				end if
			end if

			dtype = hPrepConst( v, r )

			if( dtype <> INVALID ) then
				select case o
				case IR_OP_ADD
					select case as const dtype
					case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
						v->val.long += r->val.long
					case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
						v->val.float += r->val.float
					case else
				    	v->val.int += r->val.int
					end select

				case IR_OP_SUB
					select case as const dtype
					case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
						v->val.long -= r->val.long
					case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
						v->val.float -= r->val.float
					case else
						v->val.int -= r->val.int
					end select
				end select
			end if

			'' del BOP and const node
			astDel( r )
			astDel( n )

			'' top node is now the left one
			n = hConstAccumADDSUB( l, v, op )

		else
			'' walk
			n->l = hConstAccumADDSUB( l, v, op )

			if( o = IR_OP_SUB ) then
				op = -op
			end if

			n->r = hConstAccumADDSUB( r, v, op )
		end if
	end select

	function = n

end function

'':::::
private function hConstAccumMUL( byval n as ASTNODE ptr, _
								 byval v as ASTVALUE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l, r
	static as integer dtype

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST_NODECLASS_BOP ) then
		return n
	end if

	if( n->op = IR_OP_MUL ) then
		l = n->l
		r = n->r

		if( r->defined ) then

			dtype = hPrepConst( v, r )

			if( dtype <> INVALID ) then
				select case as const dtype
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					v->val.long *= r->val.long
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					v->val.float *= r->val.float
				case else
					v->val.int *= r->val.int
				end select
			end if

			'' del BOP and const node
			astDel( r )
			astDel( n )

			'' top node is now the left one
			n = hConstAccumMUL( l, v )

		else
			'' walk
			n->l = hConstAccumMUL( l, v )
			n->r = hConstAccumMUL( r, v )
		end if
	end if

	function = n

end function

'':::::
private function hOptConstAccum1( byval n as ASTNODE ptr ) as ASTNODE ptr
	static as ASTNODE ptr l, r, nn
	static as ASTVALUE v

	if( n = NULL ) then
		return NULL
	end if

	'' check any ADD|SUB|MUL BOP node with a constant at the right leaf and
	'' then begin accumulating the other constants at the nodes below the
	'' current, deleting any constant leaf that were added
	'' (this will handle for ex. a+1+b+2-3, that will become a+b
	if( n->class = AST_NODECLASS_BOP ) then
		r = n->r
		if( r->defined ) then
			select case as const n->op
			case IR_OP_ADD
				v.dtype = INVALID
				n = hConstAccumADDSUB( n, @v, 1 )

				select case as const v.dtype
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					nn = astNewCONST64( v.val.long, v.dtype )
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			    	nn = astNewCONSTf( v.val.float, v.dtype )
				case else
					nn = astNewCONSTi( v.val.int, v.dtype )
				end select

				n = astNewBOP( IR_OP_ADD, n, nn )

			case IR_OP_MUL
				v.dtype = INVALID
				n = hConstAccumMUL( n, @v )

				select case as const v.dtype
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					nn = astNewCONST64( v.val.long, v.dtype )
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					nn = astNewCONSTf( v.val.float, v.dtype )
				case else
					nn = astNewCONSTi( v.val.int, v.dtype )
				end select

				n = astNewBOP( IR_OP_MUL, n, nn )

           	case IR_OP_SUB
				v.dtype = INVALID
				n = hConstAccumADDSUB( n, @v, -1 )

				select case as const v.dtype
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					nn = astNewCONST64( v.val.long, v.dtype )
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					nn = astNewCONSTf( v.val.float, v.dtype )
				case else
					nn = astNewCONSTi( v.val.int, v.dtype )
				end select

				n = astNewBOP( IR_OP_SUB, n, nn )
			end select
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptConstAccum1( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptConstAccum1( r )
	end if

	function = n

end function

'':::::
private sub hOptConstAccum2( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r
	static as integer dtype, checktype
	static as ASTVALUE v

	'' check any ADD|SUB|MUL BOP node and then go to child leafs accumulating
	'' any constants found there, deleting those nodes and then adding the
	'' result to a new node, at right side of the current one
	'' (this will handle for ex. a+1+(b+2)+(c+3), that will become a+b+c+6)
	if( n->class = AST_NODECLASS_BOP ) then
		checktype = FALSE

		select case n->op
		case IR_OP_ADD
			if( irGetDataClass( n->dtype ) <> IR_DATACLASS_STRING ) then

				v.dtype = INVALID
				n->l = hConstAccumADDSUB( n->l, @v, 1 )
				n->r = hConstAccumADDSUB( n->r, @v, 1 )

				if( v.dtype <> INVALID ) then
					n->l = astNewBOP( IR_OP_ADD, n->l, n->r )
					select case as const v.dtype
					case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
						n->r = astNewCONST64( v.val.long, v.dtype )
					case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
						n->r = astNewCONSTf( v.val.float, v.dtype )
					case else
						n->r = astNewCONSTi( v.val.int, v.dtype )
					end select
					checktype = TRUE
				end if
			end if

		case IR_OP_MUL
			v.dtype = INVALID
			n->l = hConstAccumMUL( n->l, @v )
			n->r = hConstAccumMUL( n->r, @v )

			if( v.dtype <> INVALID ) then
				n->l = astNewBOP( IR_OP_MUL, n->l, n->r )
				select case as const v.dtype
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					n->r = astNewCONST64( v.val.long, v.dtype )
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					n->r = astNewCONSTf( v.val.float, v.dtype )
				case else
					n->r = astNewCONSTi( v.val.int, v.dtype )
				end select
				checktype = TRUE
			end if
       	end select

		if( checktype ) then
			'' update the node data type
			l = n->l
			r = n->r
			dtype = irMaxDataType( l->dtype, r->dtype )
			if( dtype <> INVALID ) then
				if( dtype <> l->dtype ) then
					n->l = astNewCONV( INVALID, dtype, r->subtype, l )
				else
					n->r = astNewCONV( INVALID, dtype, l->subtype, r )
				end if
				n->dtype = dtype
			else
				'' an ENUM or POINTER always has the precedence
				if( (r->dtype = IR_DATATYPE_ENUM) or (r->dtype >= IR_DATATYPE_POINTER) ) then
					n->dtype = r->dtype
				else
					n->dtype = l->dtype
				end if
			end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		hOptConstAccum2( l )
	end if

	r = n->r
	if( r <> NULL ) then
		hOptConstAccum2( r )
	end if

end sub

'':::::
private function hConstDistMUL( byval n as ASTNODE ptr, _
						 		byval v as ASTVALUE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l, r
	static as integer dtype

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST_NODECLASS_BOP ) then
		return n
	end if

	if( n->op = IR_OP_ADD ) then
		l = n->l
		r = n->r

		if( r->defined ) then

			dtype = hPrepConst( v, r )

			if( dtype <> INVALID ) then
				select case as const dtype
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					v->val.long += r->val.long
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					v->val.float += r->val.float
				case else
					v->val.int += r->val.int
				end select
			end if

			'' del BOP and const node
			astDel( r )
			astDel( n )

			'' top node is now the left one
			n = hConstDistMUL( l, v )

		else
			n->l = hConstDistMUL( l, v )
			n->r = hConstDistMUL( r, v )
		end if
	end if

	function = n

end function

'':::::
private function hOptConstDistMUL( byval n as ASTNODE ptr ) as ASTNODE ptr
	static as ASTNODE ptr l, r
	static as ASTVALUE v

	if( n = NULL ) then
		return NULL
	end if

	'' check any MUL BOP node with a constant at the right leaf and then scan
	'' the left leaf for ADD BOP nodes, applying the distributive, deleting those
	'' nodes and adding the result of all sums to a new node
	'' (this will handle for ex. 2 * (3 + a * 2) that will become 6 + a * 4 (with Accum2's help))
	if( n->class = AST_NODECLASS_BOP ) then
		r = n->r
		if( r->defined ) then
			if( n->op = IR_OP_MUL ) then

				v.dtype = INVALID
				n->l = hConstDistMUL( n->l, @v )

				if( v.dtype <> INVALID ) then
					select case as const v.dtype
					''
					case IR_DATATYPE_LONGINT
						select case as const r->dtype
						case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
							v.val.long *= r->val.long
						case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
							v.val.long *= clngint( r->val.float )
						case else
							v.val.long *= clngint( r->val.int )
						end select

						r = astNewCONST64( v.val.long, v.dtype )

					''
					case IR_DATATYPE_ULONGINT
						select case as const r->dtype
						case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
							v.val.long *= cunsg( r->val.long )
						case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
							v.val.long *= culngint( r->val.float )
						case else
							v.val.long *= culngint( r->val.int )
						end select

						r = astNewCONST64( v.val.long, v.dtype )

					''
					case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
						select case as const r->dtype
						case IR_DATATYPE_LONGINT
							v.val.float *= cdbl( r->val.long )
						case IR_DATATYPE_ULONGINT
							v.val.float *= cdbl( cunsg( r->val.long ) )
						case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
							v.val.float *= r->val.float
						case IR_DATATYPE_UINT
							v.val.float *= cdbl( cunsg( r->val.int ) )
						case else
							v.val.float *= cdbl( r->val.int )
						end select

						r = astNewCONSTf( v.val.float, v.dtype )

					''
					case else
						select case as const r->dtype
						case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
							v.val.int *= cint( r->val.long )
						case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
							v.val.int *= cint( r->val.float )
						case else
							v.val.int *= r->val.int
						end select

						r = astNewCONSTi( v.val.int, v.dtype )
					end select

					n = astNewBOP( IR_OP_ADD, n, r )
				end if

			end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptConstDistMUL( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptConstDistMUL( r )
	end if

	function = n

end function

'':::::
private sub hOptConstIDX( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r, lr
	static as integer c, delnode
	static as ASTVALUE v
	static as FBSYMBOL ptr s

	if( n = NULL ) then
		exit sub
	end if

	'' opt must be done in this order: addsub accum and then idx * lgt
	select case n->class
	case AST_NODECLASS_IDX, AST_NODECLASS_PTR
		l = n->l
		if( l <> NULL ) then
			v.dtype = INVALID
			n->l = hConstAccumADDSUB( l, @v, 1 )

        	if( v.dtype <> INVALID ) then
        		select case as const v.dtype
        		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
        			c = cint( v.val.long )
        		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
        			c = cint( v.val.float )
        		case else
        			c = v.val.int
        		end select

        		if( n->class = AST_NODECLASS_IDX ) then
        			n->idx.ofs += c
        		else
        			n->ptr.ofs += c
        		end if
        	end if

        	'' remove l node if it's a const and add it to parent's offset
        	l = n->l
        	if( l->defined ) then
				select case as const l->dtype
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					c = cint( l->val.long )
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					c = cint( l->val.float )
				case else
					c = cint( l->val.int )
				end select

				if( n->class = AST_NODECLASS_IDX ) then
					n->idx.ofs += c
				else
					n->ptr.ofs += c
				end if

				astDel( l )
				n->l = NULL
			end if
		end if
	end select

	if( n->class = AST_NODECLASS_IDX ) then
		l = n->l
		if( l <> NULL ) then
			'' x86 assumption: if top of tree = idx * lgt, and lgt < 10,
			''                 save lgt and delete the * node
			if( l->class = AST_NODECLASS_BOP ) then
				if( l->op = IR_OP_MUL ) then
					lr = l->r
					if( lr->defined ) then

						select case as const lr->dtype
						case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
							c = cint( lr->val.long )
						case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
							c = cint( lr->val.float )
						case else
							c = cint( lr->val.int )
						end select

						if( c < 10 ) then
							select case as const c
							case 6, 7
								delnode = FALSE
							case 3, 5, 9
								delnode = TRUE
								'' not possible if there's already an index (EBP)
								s = astGetSymbol( n->r )
								if( symbIsArg( s ) ) then
									delnode = FALSE
								elseif( symbIsLocal( s ) ) then
									if( not symbIsStatic( s ) ) then
										delnode = FALSE
									end if
								end if
							case else
								delnode = TRUE
							end select

				    		if( delnode ) then
				    			n->idx.mult = c

								'' relink
								n->l = l->l

				    			'' del const node and the BOP itself
				    			astDel( lr )
								astDel( l )

								l = n->l
							end if
						end if
				    end if
				end if
			end if

			'' convert to integer if needed
			if( (irGetDataClass( l->dtype ) <> IR_DATACLASS_INTEGER) or _
			    (irGetDataSize( l->dtype ) <> FB_POINTERSIZE) ) then
				n->l = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, l )
			end if

        end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		hOptConstIDX( l )
	end if

	r = n->r
	if( r <> NULL ) then
		hOptConstIDX( r )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' arithmetic association optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hOptAssocADD( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r
	static as integer op, rop

	if( n = NULL ) then
		exit sub
	end if

    '' convert a+(b+c) to a+b+c and a-(b-c) to a-b+c
	if( n->class = AST_NODECLASS_BOP ) then
		op = n->op
		if( op = IR_OP_ADD or op = IR_OP_SUB ) then
			if( irGetDataClass( n->dtype ) <> IR_DATACLASS_STRING ) then
				r = n->r
				if( r->class = AST_NODECLASS_BOP ) then
					rop = r->op
					if( rop = IR_OP_ADD or rop = IR_OP_SUB ) then
						n->r = r->r
						r->r = r->l
						r->l = n->l
						n->l = r

						if( op = IR_OP_SUB ) then
							if( rop = IR_OP_SUB ) then
								op = IR_OP_ADD
							else
								rop = IR_OP_SUB
							end if
						else
							if( rop = IR_OP_SUB ) then
								op = IR_OP_SUB
								rop = IR_OP_ADD
							end if
						end if
						n->op = op
						r->op = rop

						hOptAssocADD( n )
						exit sub
					end if
				end if
			end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		hOptAssocADD( l )
	end if

	r = n->r
	if( r <> NULL ) then
		hOptAssocADD( r )
	end if

end sub

'':::::
private sub hOptAssocMUL( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r

	if( n = NULL ) then
		exit sub
	end if

	'' convert a*(b*c) to a*b*c
	if( n->class = AST_NODECLASS_BOP ) then
		if( n->op = IR_OP_MUL ) then
			r = n->r
			if( r->class = AST_NODECLASS_BOP ) then
				if( r->op = IR_OP_MUL ) then
					n->r = r->r
					r->r = r->l
					r->l = n->l
					n->l = r
					hOptAssocMUL( n )
					Exit Sub
				end if
			end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		hOptAssocMUL( l )
	end if

	r = n->r
	if( r <> NULL ) then
		hOptAssocMUL( r )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' other optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hOptToShift( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r
	static as integer v, op

	if( n = NULL ) then
		exit sub
	end if

	'' convert 'a * pow2 imm'   to 'a SHL pow2',
	''         'a \ pow2 imm'   to 'a SHR pow2' and
	''         'a MOD pow2 imm' to 'a AND pow2-1'
	if( n->class = AST_NODECLASS_BOP ) then
		op = n->op
		select case op
		case IR_OP_MUL, IR_OP_INTDIV, IR_OP_MOD
			r = n->r
			if( r->defined ) then
				if( irGetDataClass( n->dtype ) = IR_DATACLASS_INTEGER ) then
					if( irGetDataSize( r->dtype ) <= FB_INTEGERSIZE ) then
						v = r->val.int
						if( v > 0 ) then
							v = hToPow2( v )
							if( v > 0 ) then
								select case op
								case IR_OP_MUL
									if( v <= 32 ) then
										n->op = IR_OP_SHL
										r->val.int = v
									end if
								case IR_OP_INTDIV
									if( v <= 32 ) then
										n->op = IR_OP_SHR
										r->val.int = v
									end if
								case IR_OP_MOD
									n->op = IR_OP_AND
									r->val.int -= 1
								end select
							end if
						end if
					end if
				end if
			end if
		end select
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		hOptToShift( l )
	end if

	r = n->r
	if( r <> NULL ) then
		hOptToShift( r )
	end if

end sub

''::::
private function hOptNullOp( byval n as ASTNODE ptr ) as ASTNODE ptr static
	dim as ASTNODE ptr l, r
	dim as integer v, op

	if( n = NULL ) then
		return n
	end if

	'' convert 'a * 0'   to '0'
	''         'a MOD 1' to '0'
	''         'a * 1'   to 'a'
	''         'a \ 1'   to 'a'
	''         'a + 0'   to 'a'
	''         'a - 0'   to 'a'
	''         'a SHR 0' to 'a'
	''         'a SHL 0' to 'a'
	''         'a OR 0'  to 'a'
	''         'a XOR 0' to 'a'
	''         'a AND -1' to 'a'
	if( n->class = AST_NODECLASS_BOP ) then
		op = n->op
		l = n->l
		r = n->r
		if( r->defined ) then
			if( irGetDataClass( n->dtype ) = IR_DATACLASS_INTEGER ) then
				if( irGetDataSize( r->dtype ) <= FB_INTEGERSIZE ) then
					v = r->val.int
					select case as const op
					case IR_OP_MUL
						if( v = 0 ) then
							astDelTree( l )
							astDel( n )
							return r
						elseif( v = 1 ) then
							astDel( r )
							astDel( n )
							return hOptNullOp( l )
						end if

					case IR_OP_MOD
						if( v = 1 ) then
							r->val.int = 0
							astDelTree( l )
							astDel( n )
							return r
						end if

					case IR_OP_INTDIV
						if( v = 1 ) then
							astDel( r )
							astDel( n )
							return hOptNullOp( l )
						end if

					case IR_OP_ADD, IR_OP_SUB, IR_OP_SHR, IR_OP_SHL, IR_OP_OR, IR_OP_XOR
						if( v = 0 ) then
							astDel( r )
							astDel( n )
							return hOptNullOp( l )
						end if

					case IR_OP_AND
						if( v = -1 ) then
							astDel( r )
							astDel( n )
							return hOptNullOp( l )
						end if
					end select
				end if
		 	end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptNullOp( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptNullOp( r )
	end if

	function = n

end function

'':::::
private function hOptStrMultConcat( byval lnk as ASTNODE ptr, _
							  		byval dst as ASTNODE ptr, _
							  		byval n as ASTNODE ptr ) as ASTNODE ptr

	if( n = NULL ) then
		return NULL
	end if

	''     +
	''    / \           f(:=) --> f(+=) --> f(+=)
	''   +   d   =>    /  \      / \       / \
	''  / \           a    b    a   c     a   d
	'' b   c

	'' lowest node first..
	if( n->l <> NULL ) then
		if( n->l->class = AST_NODECLASS_BOP ) then
			lnk = hOptStrMultConcat( lnk, dst, n->l )
			n->l = NULL
		end if
	end if

    '' concat?
    if( n->class = AST_NODECLASS_BOP ) then
    	if( n->l <> NULL ) then
    	    '' first concatenation? do an assignament..
    	    if( lnk = NULL ) then
    	    	lnk = rtlStrAssign( astCloneTree( dst ), n->l )
    	    else
    	    	lnk = astNewLINK( lnk, rtlStrConcatAssign( astCloneTree( dst ), n->l ) )
    	    end if
    	end if

    	if( n->r <> NULL ) then
    	    lnk = astNewLINK( lnk, rtlStrConcatAssign( astCloneTree( dst ), n->r ) )
    	end if

    	astDel( n )

    '' string..
    else
		if( lnk = NULL ) then
    		lnk = rtlStrAssign( astCloneTree( dst ), n )
		else
    		lnk = astNewLINK( lnk, rtlStrConcatAssign( astCloneTree( dst ), n ) )
		end if
    end if

    function = lnk

end function

''::::
private function hIsMultStrConcat( byval l as ASTNODE ptr, _
								   byval r as ASTNODE ptr ) as integer

	dim as FBSYMBOL ptr sym

	function = FALSE

	if( r->class = AST_NODECLASS_BOP ) then
		select case l->class
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX
			sym = astGetSymbolOrElm( l )
			if( sym <> NULL ) then
				if( (sym->alloctype and _
					(FB_ALLOCTYPE_ARGUMENTBYDESC or FB_ALLOCTYPE_ARGUMENTBYREF)) = 0 ) then

					if( not astIsSymbolOnTree( sym, r ) ) then
						function = TRUE
					end if

				end if
			end if
		end select
	end if

end function

''::::
private function hOptStrAssignament( byval n as ASTNODE ptr, _
							   		 byval l as ASTNODE ptr, _
							   		 byval r as ASTNODE ptr ) as ASTNODE ptr static

	dim as integer optimize

	optimize = FALSE

	'' is right side a bin operation?
	if( r->class = AST_NODECLASS_BOP ) then
		'' is left side a var?
		select case l->class
		case AST_NODECLASS_VAR, AST_NODECLASS_PTR, AST_NODECLASS_IDX
			optimize = astIsTreeEqual( l, r->l )
		end select
	end if

	if( optimize ) then
		astDel( n )
		n = r
		astDelTree( l )
		l = n->l
		r = n->r

		if( hIsMultStrConcat( l, r ) ) then
			function = hOptStrMultConcat( l, l, r )

		else
			''	=            f() -- concatassign
			'' / \           / \
			''a   +    =>   a   expr
			''   / \
			''  a   expr

			function = rtlStrConcatAssign( l, astUpdStrConcat( r ) )
		end if

	else

		'' convert "a = b + c + d" to "a = b: a += c: a += d"
		if( hIsMultStrConcat( l, r ) ) then

			function = hOptStrMultConcat( NULL, l, r )

		else
			''	=            f() -- assign
			'' / \           / \
			''a   +    =>   a   f() -- concat (done by UpdStrConcat)
			''   / \           / \
			''  b   expr      b   expr

			function = rtlStrAssign( l, astUpdStrConcat( r ) )
		end if
	end if

	astDel( n )

end function

''::::
function astOptAssignament( byval n as ASTNODE ptr ) as ASTNODE ptr static
	dim as ASTNODE ptr l, r
	dim as integer dtype, dclass
	dim as FBSYMBOL ptr s

	function = n

	'' try to convert "foo = foo op expr" to "foo op= expr" (including unary ops)
	if( n = NULL ) then
		exit function
	end if

	'' there's just one assignament per tree (always at top), so, just check this node
	if( n->class <> AST_NODECLASS_ASSIGN ) then
		exit function
	end if

	l = n->l
	r = n->r

	dtype = n->dtype
	dclass = irGetDataClass( dtype )

	'' integer's only, no way to optimize with a FPU stack (x86 assumption)
	if( dclass <> IR_DATACLASS_INTEGER ) then

		'' strings?
		if( dclass = IR_DATACLASS_STRING ) then
			return hOptStrAssignament( n, l, r )
		end if

		'' try to optimize if a constant is being assigned to a float var
  		if( r->defined ) then
  			if( dclass = IR_DATACLASS_FPOINT ) then
				if( irGetDataClass( r->dtype ) <> IR_DATACLASS_FPOINT ) then
					n->r = astNewCONV( INVALID, dtype, NULL, r )
				end if
			end if
		end if

		exit function
	end if

	'' can't be byte either, as BOP will do cint(byte) op cint(byte)
	if( irGetDataSize( dtype ) = 1 ) then
		exit function
	end if

	'' is left side a var, idx or ptr?
	select case l->class
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR
	case else
		exit function
	end select

	'' is right side a bin or unary operation?
	select case r->class
	case AST_NODECLASS_UOP, AST_NODECLASS_BOP
	case else
		exit function
	end select

	'' can't be a relative op -- unless EMIT is changed to not assume the res operand is a reg
	select case as const r->op
	case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE
		exit function
	end select

	'' node result is an integer too?
	if( irGetDataClass( r->dtype ) <> IR_DATACLASS_INTEGER ) then
		exit function
	end if

	'' is the left child the same?
	if( not astIsTreeEqual( l, r->l ) ) then
		exit function
	end if

	'' isn't it a bitfield?
	if( l->chkbitfld ) then
		s = astGetElm( l )
		if( s <> NULL ) then
			if( s->var.elm.bits > 0 ) then
				exit function
			end if
		end if
	end if

	'' delete assign node and alert UOP/BOP to not allocate a result (IR is aware)
	r->allocres = FALSE

	''	=             o
	'' / \           / \
	''d   o     =>  d   expr
	''   / \
	''  d   expr

    astDel( n )
	astDelTree( l )

    function = r

end function

''::::
function astOptimize( byval n as ASTNODE ptr ) as ASTNODE ptr

	'' calls must be done in the order below
    ast.isopt = TRUE

	hOptAssocADD( n )

	hOptAssocMUL( n )

	n = hOptConstDistMUL( n )

	n = hOptConstAccum1( n )

	hOptConstAccum2( n )

	hOptConstRmNeg( n, NULL )

	hOptConstIDX( n )

	hOptToShift( n )

	n = hOptNullOp( n )

	ast.isopt = FALSE

	function = n

end function

