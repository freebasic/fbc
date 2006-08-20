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


'' AST optimizations
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constant folding optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hOptConstRemNeg _
	( _
		byval n as ASTNODE ptr, _
		byval p as ASTNODE ptr _
	)

	static as ASTNODE ptr l, r

	'' check any UOP node, and if its of the kind "-var + const" convert to "const - var"
	if( p <> NULL ) then
		if( n->class = AST_NODECLASS_UOP ) then
			if( n->op.op = AST_OP_NEG ) then
				l = n->l
				if( l->class = AST_NODECLASS_VAR ) then
					if( p->class = AST_NODECLASS_BOP ) then
						if( p->op.op = AST_OP_ADD ) then
							r = p->r
							if( r->defined ) then
								p->op.op = AST_OP_SUB
								p->l = p->r
								p->r = n->l
								astDelNode( n )
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
		hOptConstRemNeg( l, n )
	end if

	r = n->r
	if( r <> NULL ) then
		hOptConstRemNeg( r, n )
	end if

end sub

'':::::
private sub hConvDataType _
	( _
		byval v as FBVALUE ptr, _
		byval vdtype as integer, _
		byval dtype as integer _
	) static

	if( dtype > FB_DATATYPE_POINTER ) then
		dtype = FB_DATATYPE_POINTER
	end if

	select case as const dtype
	''
	case FB_DATATYPE_LONGINT

		select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    '' no conversion
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->long = clngint( v->float )
		case else
			v->long = clngint( v->int )
		end select

	''
	case FB_DATATYPE_ULONGINT

		select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    '' no conversion
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->long = culngint( v->float )
		case else
			v->long = culngint( v->int )
		end select

	''
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE

		if( vdtype > FB_DATATYPE_POINTER ) then
			vdtype = FB_DATATYPE_POINTER
		end if

		select case as const vdtype
		case FB_DATATYPE_LONGINT
		    v->float = cdbl( v->long )
		case FB_DATATYPE_ULONGINT
			v->float = cdbl( cunsg( v->long ) )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			'' do nothing
		case FB_DATATYPE_UINT, FB_DATATYPE_POINTER
			v->float = cdbl( cuint( v->int ) )
		case else
			v->float = cdbl( v->int )
		end select

	''
	case FB_DATATYPE_UINT, FB_DATATYPE_POINTER

	 	select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    v->int = cuint( v->long )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->int = cuint( v->float )
		end select

	''
	case else

		select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    v->int = cint( v->long )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->int = cint( v->float )
		end select

    end select

end sub

''::::::
private function hPrepConst _
	( _
		byval v as ASTVALUE ptr, _
		byval r as ASTNODE ptr _
	) as integer static

	dim as integer dtype

	'' first node? just copy..
	if( v->dtype = INVALID ) then
		v->dtype = r->dtype
		select case as const v->dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			v->val.long = r->con.val.long
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->val.float = r->con.val.float
		case else
            v->val.int = r->con.val.int
		end select

		return INVALID
	end if

    ''
	dtype = symbMaxDataType( v->dtype, r->dtype )

	'' same? don't convert..
	if( dtype = INVALID ) then
		'' an ENUM or POINTER always has the precedence
		if( (r->dtype = FB_DATATYPE_ENUM) or (r->dtype >= FB_DATATYPE_POINTER) ) then
			return r->dtype
		else
			return v->dtype
		end if
	end if

	'' convert r to v's type
	if( dtype = v->dtype ) then
		hConvDataType( @r->con.val, r->dtype, dtype )

	'' convert v to r's type
	else
		hConvDataType( @v->val, v->dtype, dtype )
		v->dtype = dtype
	end if

	return dtype

end function

'':::::
private function hConstAccumADDSUB _
	( _
		byval n as ASTNODE ptr, _
		byval v as ASTVALUE ptr, _
		byval op as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	dim as integer o = any
	static as integer dtype

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST_NODECLASS_BOP ) then
		return n
	end if

    o = n->op.op

	select case o
	case AST_OP_ADD, AST_OP_SUB
		l = n->l
		r = n->r

		if( r->defined ) then

			if( op < 0 ) then
				if( o = AST_OP_ADD ) then
					o = AST_OP_SUB
				else
					o = AST_OP_ADD
				end if
			end if

			dtype = hPrepConst( v, r )

			if( dtype <> INVALID ) then
				select case o
				case AST_OP_ADD
					select case as const dtype
					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
						v->val.long += r->con.val.long
					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						v->val.float += r->con.val.float
					case else
				    	v->val.int += r->con.val.int
					end select

				case AST_OP_SUB
					select case as const dtype
					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
						v->val.long -= r->con.val.long
					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						v->val.float -= r->con.val.float
					case else
						v->val.int -= r->con.val.int
					end select
				end select
			end if

			'' del BOP and const node
			astDelNode( r )
			astDelNode( n )

			'' top node is now the left one
			n = hConstAccumADDSUB( l, v, op )

		else
			'' walk
			n->l = hConstAccumADDSUB( l, v, op )

			if( o = AST_OP_SUB ) then
				op = -op
			end if

			n->r = hConstAccumADDSUB( r, v, op )
		end if
	end select

	function = n

end function

'':::::
private function hConstAccumMUL _
	( _
		byval n as ASTNODE ptr, _
		byval v as ASTVALUE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	static as integer dtype

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST_NODECLASS_BOP ) then
		return n
	end if

	if( n->op.op = AST_OP_MUL ) then
		l = n->l
		r = n->r

		if( r->defined ) then

			dtype = hPrepConst( v, r )

			if( dtype <> INVALID ) then
				select case as const dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					v->val.long *= r->con.val.long
				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					v->val.float *= r->con.val.float
				case else
					v->val.int *= r->con.val.int
				end select
			end if

			'' del BOP and const node
			astDelNode( r )
			astDelNode( n )

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
private function hOptConstAccum1 _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

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
			select case as const n->op.op
			case AST_OP_ADD
				v.dtype = INVALID
				n = hConstAccumADDSUB( n, @v, 1 )

				select case as const v.dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					nn = astNewCONSTl( v.val.long, v.dtype )
				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			    	nn = astNewCONSTf( v.val.float, v.dtype )
				case else
					nn = astNewCONSTi( v.val.int, v.dtype )
				end select

				n = astNewBOP( AST_OP_ADD, n, nn )

			case AST_OP_MUL
				v.dtype = INVALID
				n = hConstAccumMUL( n, @v )

				select case as const v.dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					nn = astNewCONSTl( v.val.long, v.dtype )
				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					nn = astNewCONSTf( v.val.float, v.dtype )
				case else
					nn = astNewCONSTi( v.val.int, v.dtype )
				end select

				n = astNewBOP( AST_OP_MUL, n, nn )

           	case AST_OP_SUB
				v.dtype = INVALID
				n = hConstAccumADDSUB( n, @v, -1 )

				select case as const v.dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					nn = astNewCONSTl( v.val.long, v.dtype )
				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					nn = astNewCONSTf( v.val.float, v.dtype )
				case else
					nn = astNewCONSTi( v.val.int, v.dtype )
				end select

				n = astNewBOP( AST_OP_SUB, n, nn )
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
private sub hOptConstAccum2 _
	( _
		byval n as ASTNODE ptr _
	)

	static as ASTNODE ptr l, r
	static as integer dtype, checktype
	static as ASTVALUE v

	'' check any ADD|SUB|MUL BOP node and then go to child leafs accumulating
	'' any constants found there, deleting those nodes and then adding the
	'' result to a new node, at right side of the current one
	'' (this will handle for ex. a+1+(b+2)+(c+3), that will become a+b+c+6)
	if( n->class = AST_NODECLASS_BOP ) then
		checktype = FALSE

		select case n->op.op
		case AST_OP_ADD
			'' don't mess with strings..
			select case n->dtype
			case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
				 FB_DATATYPE_WCHAR

			case else
				v.dtype = INVALID
				n->l = hConstAccumADDSUB( n->l, @v, 1 )
				n->r = hConstAccumADDSUB( n->r, @v, 1 )

				if( v.dtype <> INVALID ) then
					n->l = astNewBOP( AST_OP_ADD, n->l, n->r )
					select case as const v.dtype
					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
						n->r = astNewCONSTl( v.val.long, v.dtype )
					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						n->r = astNewCONSTf( v.val.float, v.dtype )
					case else
						n->r = astNewCONSTi( v.val.int, v.dtype )
					end select
					checktype = TRUE
				end if
			end select

		case AST_OP_MUL
			v.dtype = INVALID
			n->l = hConstAccumMUL( n->l, @v )
			n->r = hConstAccumMUL( n->r, @v )

			if( v.dtype <> INVALID ) then
				n->l = astNewBOP( AST_OP_MUL, n->l, n->r )
				select case as const v.dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					n->r = astNewCONSTl( v.val.long, v.dtype )
				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
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
			dtype = symbMaxDataType( l->dtype, r->dtype )
			if( dtype <> INVALID ) then
				if( dtype <> l->dtype ) then
					n->l = astNewCONV( INVALID, dtype, r->subtype, l )
				else
					n->r = astNewCONV( INVALID, dtype, l->subtype, r )
				end if
				n->dtype = dtype
			else
				'' an ENUM or POINTER always has the precedence
				if( (r->dtype = FB_DATATYPE_ENUM) or (r->dtype >= FB_DATATYPE_POINTER) ) then
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
private function hConstDistMUL _
	( _
		byval n as ASTNODE ptr, _
		byval v as ASTVALUE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	static as integer dtype

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST_NODECLASS_BOP ) then
		return n
	end if

	if( n->op.op = AST_OP_ADD ) then
		l = n->l
		r = n->r

		if( r->defined ) then

			dtype = hPrepConst( v, r )

			if( dtype <> INVALID ) then
				select case as const dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					v->val.long += r->con.val.long
				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					v->val.float += r->con.val.float
				case else
					v->val.int += r->con.val.int
				end select
			end if

			'' del BOP and const node
			astDelNode( r )
			astDelNode( n )

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
private function hOptConstDistMUL _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

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
			if( n->op.op = AST_OP_MUL ) then

				v.dtype = INVALID
				n->l = hConstDistMUL( n->l, @v )

				if( v.dtype <> INVALID ) then
					select case as const v.dtype
					''
					case FB_DATATYPE_LONGINT
						select case as const r->dtype
						case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
							v.val.long *= r->con.val.long
						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							v.val.long *= clngint( r->con.val.float )
						case else
							v.val.long *= clngint( r->con.val.int )
						end select

						r = astNewCONSTl( v.val.long, v.dtype )

					''
					case FB_DATATYPE_ULONGINT
						select case as const r->dtype
						case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
							v.val.long *= cunsg( r->con.val.long )
						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							v.val.long *= culngint( r->con.val.float )
						case else
							v.val.long *= culngint( r->con.val.int )
						end select

						r = astNewCONSTl( v.val.long, v.dtype )

					''
					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						select case as const r->dtype
						case FB_DATATYPE_LONGINT
							v.val.float *= cdbl( r->con.val.long )
						case FB_DATATYPE_ULONGINT
							v.val.float *= cdbl( cunsg( r->con.val.long ) )
						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							v.val.float *= r->con.val.float
						case FB_DATATYPE_UINT
							v.val.float *= cdbl( cunsg( r->con.val.int ) )
						case else
							v.val.float *= cdbl( r->con.val.int )
						end select

						r = astNewCONSTf( v.val.float, v.dtype )

					''
					case else
						select case as const r->dtype
						case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
							v.val.int *= cint( r->con.val.long )
						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							v.val.int *= cint( r->con.val.float )
						case else
							v.val.int *= r->con.val.int
						end select

						r = astNewCONSTi( v.val.int, v.dtype )
					end select

					n = astNewBOP( AST_OP_ADD, n, r )
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
private sub hOptConstIDX _
	( _
		byval n as ASTNODE ptr _
	)

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
        		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
        			c = cint( v.val.long )
        		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
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
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					c = cint( l->con.val.long )
				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					c = cint( l->con.val.float )
				case else
					c = cint( l->con.val.int )
				end select

				if( n->class = AST_NODECLASS_IDX ) then
					n->idx.ofs += c
				else
					n->ptr.ofs += c
				end if

				astDelNode( l )
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
				if( l->op.op = AST_OP_MUL ) then
					lr = l->r
					if( lr->defined ) then

						select case as const lr->dtype
						case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
							c = cint( lr->con.val.long )
						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							c = cint( lr->con.val.float )
						case else
							c = cint( lr->con.val.int )
						end select

						if( c < 10 ) then
							select case as const c
							case 6, 7
								delnode = FALSE
							case 3, 5, 9
								delnode = TRUE
								'' not possible if there's already an index (EBP)
								s = astGetSymbol( n->r )
								if( symbIsParam( s ) ) then
									delnode = FALSE
								elseif( symbIsLocal( s ) ) then
									if( symbIsStatic( s ) = FALSE ) then
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
				    			astDelNode( lr )
								astDelNode( l )

								l = n->l
							end if
						end if
				    end if
				end if
			end if

			'' convert to integer if needed
			if( (symbGetDataClass( l->dtype ) <> FB_DATACLASS_INTEGER) or _
			    (symbGetDataSize( l->dtype ) <> FB_POINTERSIZE) ) then
				n->l = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, l )
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
private function hOptAssocADD _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	static as ASTNODE ptr l, r, n_old
	static as integer op, rop

	if( n = NULL ) then
		return NULL
	end if

    '' convert a+(b+c) to a+b+c and a-(b-c) to a-b+c
	if( n->class = AST_NODECLASS_BOP ) then
		op = n->op.op
		select case op
		case AST_OP_ADD, AST_OP_SUB

			'' don't mess with strings..
			select case n->dtype
			case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
				 FB_DATATYPE_WCHAR

			case else
				r = n->r
				if( r->class = AST_NODECLASS_BOP ) then
					rop = r->op.op
					select case rop
					case AST_OP_ADD, AST_OP_SUB
						if( op = AST_OP_SUB ) then
							if( rop = AST_OP_SUB ) then
								op = AST_OP_ADD
							else
								rop = AST_OP_SUB
							end if
						else
							if( rop = AST_OP_SUB ) then
								op = AST_OP_SUB
								rop = AST_OP_ADD
							end if
						end if

						n_old = n

						'' n = (( n->l, r->l ), r->r)
						n = astNewBOP( op, _
									   astNewBOP( rop, n->l, r->l ), _
									   r->r )

						astDelNode( r )
						astDelNode( n_old )
					end select
				end if
			end select

		end select
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptAssocADD( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptAssocADD( r )
	end if

	function = n

end function

'':::::
private function hOptAssocMUL _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	static as ASTNODE ptr l, r, n_old

	if( n = NULL ) then
		return NULL
	end if

	'' convert a*(b*c) to a*b*c
	if( n->class = AST_NODECLASS_BOP ) then
		if( n->op.op = AST_OP_MUL ) then
			r = n->r
			if( r->class = AST_NODECLASS_BOP ) then
				if( r->op.op = AST_OP_MUL ) then
					n_old = n

					'' n = (( n->l, r->l ), r->r)
					n = astNewBOP( AST_OP_MUL, _
							   	   astNewBOP( AST_OP_MUL, n->l, r->l ), _
							   	   r->r )

					astDelNode( r )
					astDelNode( n_old )
				end if
			end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptAssocMUL( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptAssocMUL( r )
	end if

	function = n

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' other optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hOptToShift _
	( _
		byval n as ASTNODE ptr _
	)

	static as ASTNODE ptr l, r
	static as integer v, op
	static as integer bits

	if( n = NULL ) then
		exit sub
	end if

	'' convert '     a  *  pow2 imm' to 'a SHL pow2',
	''         'unsg(a) \  pow2 imm' to 'a SHR pow2',
	''         'sign(a) \  pow2 imm' to '((a SHR 31) + a) SAR pow2',
	''         '     a MOD pow2 imm' to 'a AND pow2-1'
	if( n->class = AST_NODECLASS_BOP ) then
		op = n->op.op
		select case op
		case AST_OP_MUL, AST_OP_INTDIV, AST_OP_MOD
			r = n->r
			if( r->defined ) then
				if( symbGetDataClass( n->dtype ) = FB_DATACLASS_INTEGER ) then
					if( symbGetDataSize( r->dtype ) <= FB_INTEGERSIZE ) then
						v = r->con.val.int
						if( v > 0 ) then
							v = hToPow2( v )
							if( v > 0 ) then
								select case op
								case AST_OP_MUL
									if( v <= 32 ) then
										n->op.op = AST_OP_SHL
										r->con.val.int = v
									end if

								case AST_OP_INTDIV
									if( v <= 32 ) then
										l = n->l
										if( symbIsSigned( l->dtype ) = FALSE ) then
											n->op.op = AST_OP_SHR
											r->con.val.int = v
										else
											'' !!FIXME!!! while there's no common sub-expr
											'' 	          elimination, only allow VAR nodes
											if( l->class = AST_NODECLASS_VAR ) then
												bits = symbGetDataBits( l->dtype ) - 1
												'' bytes are converted to int's..
												if( bits = 7 ) then
													bits = symbGetDataBits( FB_DATATYPE_INTEGER ) - 1
												end if

												n->l = astNewCONV( AST_OP_TOSIGNED, _
																   0, _
																   NULL, _
																   astNewBOP( AST_OP_ADD, _
															       			  astCloneTree( l ), _
															       			  astNewBOP( AST_OP_SHR, _
																  			  			 astNewCONV( AST_OP_TOUNSIGNED, _
																  			  			  			 0, _
																  			  			  			 NULL, _
																  			  			  			 l ), _
																  			  			 astNewCONSTi( bits, _
																  									   FB_DATATYPE_INTEGER ), _
																					   ), _
																   			) _
																 )

												n->op.op = AST_OP_SHR
												r->con.val.int = v
											end if
										end if
									end if

								case AST_OP_MOD
									'' unsigned types only
									if( symbIsSigned( n->l->dtype ) = FALSE ) then
										n->op.op = AST_OP_AND
										r->con.val.int -= 1
									end if
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
private function hOptNullOp _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr static

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
		op = n->op.op
		l = n->l
		r = n->r
		if( r->defined ) then
			if( symbGetDataClass( n->dtype ) = FB_DATACLASS_INTEGER ) then
				if( symbGetDataSize( r->dtype ) <= FB_INTEGERSIZE ) then
					v = r->con.val.int
					select case as const op
					case AST_OP_MUL
						if( v = 0 ) then
							astDelTree( l )
							astDelNode( n )
							return r
						elseif( v = 1 ) then
							astDelNode( r )
							astDelNode( n )
							return hOptNullOp( l )
						end if

					case AST_OP_MOD
						if( v = 1 ) then
							r->con.val.int = 0
							astDelTree( l )
							astDelNode( n )
							return r
						end if

					case AST_OP_INTDIV
						if( v = 1 ) then
							astDelNode( r )
							astDelNode( n )
							return hOptNullOp( l )
						end if

					case AST_OP_ADD, AST_OP_SUB, AST_OP_SHR, AST_OP_SHL, AST_OP_OR, AST_OP_XOR
						if( v = 0 ) then
							astDelNode( r )
							astDelNode( n )
							return hOptNullOp( l )
						end if

					case AST_OP_AND
						if( v = -1 ) then
							astDelNode( r )
							astDelNode( n )
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
private function hOptRemConv _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	static as ASTNODE ptr l, r
	static as integer dorem

	if( n = NULL ) then
		return NULL
	end if

	'' '' x86 assumption: convert l{float} op cast(float, r{var}) to l op r
	if( n->class = AST_NODECLASS_BOP ) then
		select case n->dtype
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			r = n->r
			if( r->class = AST_NODECLASS_CONV ) then
				'' left node can't be a cast() too
				if( n->l->class <> AST_NODECLASS_CONV ) then
					select case r->dtype
					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						l = r->l

						'' can't be a longint
						if( symbGetDataSize( l->dtype ) < FB_INTEGERSIZE*2 ) then
							dorem = FALSE

							select case as const l->class
							case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
								 AST_NODECLASS_FIELD, AST_NODECLASS_PTR
								'' can't be unsigned either
								if( symbIsSigned( l->dtype ) ) then
									dorem = TRUE
								end if
							end select

							if( dorem ) then
								astDelNode( r )
								n->r = l
							end if

						end if
					end select
				end if
			end if
		end select
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptRemConv( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptRemConv( r )
	end if

	function = n

end function

'':::::
private function hOptStrMultConcat _
	( _
		byval lnk as ASTNODE ptr, _
		byval dst as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval is_wstr as integer _
	) as ASTNODE ptr

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
			lnk = hOptStrMultConcat( lnk, dst, n->l, is_wstr )
			n->l = NULL
		end if
	end if

    '' concat?
    if( n->class = AST_NODECLASS_BOP ) then
    	if( n->l <> NULL ) then
    	    '' first concatenation? do an assignment..
    	    if( lnk = NULL ) then
    	    	if( is_wstr = FALSE ) then
    	    		lnk = rtlStrAssign( astCloneTree( dst ), n->l )
    	    	else
    	    		lnk = rtlWstrAssign( astCloneTree( dst ), n->l )
    	    	end if
    	    else
    	    	if( is_wstr = FALSE ) then
    	    		lnk = astNewLINK( lnk, rtlStrConcatAssign( astCloneTree( dst ), n->l ) )
    	    	else
    	    		lnk = astNewLINK( lnk, rtlWstrConcatAssign( astCloneTree( dst ), n->l ) )
    	    	end if
    	    end if
    	end if

    	if( n->r <> NULL ) then
    	    if( is_wstr = FALSE ) then
    	    	lnk = astNewLINK( lnk, rtlStrConcatAssign( astCloneTree( dst ), n->r ) )
    	    else
    	    	lnk = astNewLINK( lnk, rtlWstrConcatAssign( astCloneTree( dst ), n->r ) )
    	    end if
    	end if

    	astDelNode( n )

    '' string..
    else
		if( lnk = NULL ) then
    		if( is_wstr = FALSE ) then
    			lnk = rtlStrAssign( astCloneTree( dst ), n )
    		else
    			lnk = rtlWstrAssign( astCloneTree( dst ), n )
    		end if
		else
    		if( is_wstr = FALSE ) then
    			lnk = astNewLINK( lnk, rtlStrConcatAssign( astCloneTree( dst ), n ) )
    		else
    			lnk = astNewLINK( lnk, rtlWstrConcatAssign( astCloneTree( dst ), n ) )
    		end if
		end if
    end if

    function = lnk

end function

''::::
private function hIsMultStrConcat _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

	dim as FBSYMBOL ptr sym = any

	function = FALSE

	if( r->class = AST_NODECLASS_BOP ) then
		select case l->class
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
			 AST_NODECLASS_FIELD	'' !!!FIXME!!! check if this is okay w/ pointers
			sym = astGetSymbol( l )
			if( sym <> NULL ) then
				if( (sym->attrib and _
					(FB_SYMBATTRIB_PARAMBYDESC or FB_SYMBATTRIB_PARAMBYREF)) = 0 ) then

					if( astIsSymbolOnTree( sym, r ) = FALSE ) then
						function = TRUE
					end if

				end if
			end if
		end select
	end if

end function

''::::
private function hOptStrAssignment _
	( _
		byval n as ASTNODE ptr, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr static

	dim as integer optimize, is_wstr

	optimize = FALSE

	'' is right side a bin operation?
	if( r->class = AST_NODECLASS_BOP ) then
		'' is left side a var?
		select case as const l->class
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
			 AST_NODECLASS_FIELD, AST_NODECLASS_PTR
			optimize = astIsTreeEqual( l, r->l )
		end select
	end if

	is_wstr = ( n->dtype = FB_DATATYPE_WCHAR )

	if( optimize ) then
		astDelNode( n )
		n = r
		astDelTree( l )
		l = n->l
		r = n->r

		if( hIsMultStrConcat( l, r ) ) then

			function = hOptStrMultConcat( l, l, r, is_wstr )

		else
			''	=            f() -- concatassign
			'' / \           / \
			''a   +    =>   a   expr
			''   / \
			''  a   expr

            if( is_wstr = FALSE ) then
				function = rtlStrConcatAssign( l, astUpdStrConcat( r ) )
			else
				function = rtlWstrConcatAssign( l, astUpdStrConcat( r ) )
			end if
		end if

	else

		'' convert "a = b + c + d" to "a = b: a += c: a += d"
		if( hIsMultStrConcat( l, r ) ) then

			function = hOptStrMultConcat( NULL, l, r, is_wstr )

		else
			''	=            f() -- assign
			'' / \           / \
			''a   +    =>   a   f() -- concat (done by UpdStrConcat)
			''   / \           / \
			''  b   expr      b   expr

			if( is_wstr = FALSE ) then
				function = rtlStrAssign( l, astUpdStrConcat( r ) )
			else
				function = rtlWstrAssign( l, astUpdStrConcat( r ) )
			end if
		end if
	end if

	astDelNode( n )

end function

''::::
function astOptAssignment _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr static

	dim as ASTNODE ptr l, r
	dim as integer dtype, dclass
	dim as FBSYMBOL ptr s

	function = n

	'' try to convert "foo = foo op expr" to "foo op= expr" (including unary ops)

	select case n->class
	'' there's just one assignment per tree (always at top), so, just check this node
	case AST_NODECLASS_ASSIGN

	'' SelfBOP will have to use link( l, r ) to handle side-effects
	case AST_NODECLASS_LINK
		n->r = astOptAssignment( n->r )
		exit function

	case else
		exit function
	end select

	l = n->l
	r = n->r

	dtype = n->dtype

	'' strings?
	select case dtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_WCHAR
		return hOptStrAssignment( n, l, r )
	end select

	'' integer's only, no way to optimize with a FPU stack (x86 assumption)
	dclass = symbGetDataClass( dtype )
	if( dclass <> FB_DATACLASS_INTEGER ) then

		'' try to optimize if a constant is being assigned to a float var
  		if( r->defined ) then
  			if( dclass = FB_DATACLASS_FPOINT ) then
				if( symbGetDataClass( r->dtype ) <> FB_DATACLASS_FPOINT ) then
					n->r = astNewCONV( INVALID, dtype, NULL, r )
				end if
			end if
		end if

		exit function
	end if

	'' can't be byte either, as BOP will do cint(byte) op cint(byte)
	if( symbGetDataSize( dtype ) = 1 ) then
		exit function
	end if

	'' is left side a var, idx or ptr?
	select case as const l->class
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR

	case AST_NODECLASS_FIELD
		'' isn't it a bitfield?
		if( l->l->dtype = FB_DATATYPE_BITFIELD ) then
			exit function
		end if

	case else
		exit function
	end select

	'' is right side an unary or binary operation?
	select case r->class
	case AST_NODECLASS_UOP

	case AST_NODECLASS_BOP
		'' can't be a relative op -- unless EMIT is changed to not assume
		'' the res operand is a reg
		select case as const r->op.op
		case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE
			exit function
		end select

	case else
		exit function
	end select

	'' node result is an integer too?
	if( symbGetDataClass( r->dtype ) <> FB_DATACLASS_INTEGER ) then
		exit function
	end if

	'' is the left child the same?
	if( astIsTreeEqual( l, r->l ) = FALSE ) then
		exit function
	end if

	'' delete assign node and alert UOP/BOP to not allocate a result (IR is aware)
	r->op.options and= not AST_OPOPT_ALLOCRES

	''	=             o
	'' / \           / \
	''d   o     =>  d   expr
	''   / \
	''  d   expr

    astDelNode( n )
	astDelTree( l )

    function = r

end function

''::::
function astOptimize _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	'' calls must be done in the order below
    ast.isopt = TRUE

	n = hOptAssocADD( n )

	n = hOptAssocMUL( n )

	n = hOptConstDistMUL( n )

	n = hOptConstAccum1( n )

	hOptConstAccum2( n )

	hOptConstRemNeg( n, NULL )

	hOptConstIDX( n )

	hOptToShift( n )

	n = hOptNullOp( n )

    n = hOptRemConv( n )

	ast.isopt = FALSE

	function = n

end function

