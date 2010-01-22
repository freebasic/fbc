''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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

declare sub astDumpTree _
	( _
		byval n as ASTNODE ptr, _
		byval col as integer = 0 _
	)

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constant folding optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hOptConstRemNeg _
	( _
		byval n as ASTNODE ptr, _
		byval p as ASTNODE ptr _
	)

	dim as ASTNODE ptr l = any, r = any

	'' check any UOP node, and if its of the kind "-var + const" convert to "const - var"
	if( p <> NULL ) then
		if( n->class = AST_NODECLASS_UOP ) then
			if( n->op.op = AST_OP_NEG ) then
				l = n->l
				if( l->class = AST_NODECLASS_VAR ) then
					if( p->class = AST_NODECLASS_BOP ) then
						if( p->op.op = AST_OP_ADD ) then
							r = p->r
							if( astIsCONST( r ) ) then
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
		byval to_dtype as integer _
	)

	vdtype = typeGet( vdtype )
	to_dtype = typeGet( to_dtype )

	select case as const to_dtype
	case FB_DATATYPE_LONGINT

		select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    '' no conversion

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->long = clngint( v->float )

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		    if( FB_LONGSIZE <> len( integer ) ) then
		    	v->long = clngint( v->int )
		    end if

		case else
			v->long = clngint( v->int )
		end select

	case FB_DATATYPE_ULONGINT

		select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    '' no conversion

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->long = culngint( v->float )

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		    if( FB_LONGSIZE <> len( integer ) ) then
		    	v->long = culngint( v->int )
		    end if

		case else
			v->long = culngint( v->int )
		end select

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE

		select case as const vdtype
		case FB_DATATYPE_LONGINT
		    v->float = cdbl( v->long )

		case FB_DATATYPE_ULONGINT
			v->float = cdbl( cunsg( v->long ) )

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			'' do nothing

		case FB_DATATYPE_UINT, FB_DATATYPE_POINTER
			v->float = cdbl( cuint( v->int ) )

		case FB_DATATYPE_LONG
		    if( FB_LONGSIZE = len( integer ) ) then
		    	v->float = cdbl( v->int )
		   	else
		    	v->float = cdbl( v->long )
		    end if

		case FB_DATATYPE_ULONG
		    if( FB_LONGSIZE = len( integer ) ) then
		    	v->float = cdbl( cuint( v->int ) )
		   	else
				v->float = cdbl( cunsg( v->long ) )
			end if

		case else
			v->float = cdbl( v->int )
		end select

	case FB_DATATYPE_LONG

		select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    if( FB_LONGSIZE <> len( integer ) ) then
		    	v->int = cint( v->long )
		    end if

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			if( FB_LONGSIZE = len( integer ) ) then
				v->int = cint( v->float )
			else
				v->long = clngint( v->float )
			end if

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		    '' do nothing

		case else
			if( FB_LONGSIZE <> len( integer ) ) then
				v->long = clngint( v->int )
			end if
		end select

	case FB_DATATYPE_ULONG

		select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    if( FB_LONGSIZE <> len( integer ) ) then
		    	v->int = cuint( v->long )
		    end if

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			if( FB_LONGSIZE = len( integer ) ) then
				v->int = cuint( v->float )
			else
				v->long = culngint( v->float )
			end if

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		    '' do nothing

		case else
			if( FB_LONGSIZE <> len( integer ) ) then
				v->long = culngint( v->int )
			end if
		end select

	case FB_DATATYPE_UINT, FB_DATATYPE_POINTER

	 	select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    v->int = cuint( v->long )

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->int = cuint( v->float )

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		    if( FB_LONGSIZE <> len( integer ) ) then
		    	v->int = cuint( v->long )
		    end if
		end select

	case else

		select case as const vdtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    v->int = cint( v->long )

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->int = cint( v->float )

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		    if( FB_LONGSIZE <> len( integer ) ) then
		    	v->int = cint( v->long )
        	end if
		end select

    end select

end sub

''::::::
private function hPrepConst _
	( _
		byval v as ASTVALUE ptr, _
		byval r as ASTNODE ptr _
	) as integer

	dim as integer dtype = any

	'' first node? just copy..
	if( v->dtype = FB_DATATYPE_INVALID ) then
		v->dtype = astGetDataType( r )

		select case as const v->dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			v->val.long = r->con.val.long

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			v->val.float = r->con.val.float

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
			if( FB_LONGSIZE = len( integer ) ) then
				v->val.int = r->con.val.int
			else
				v->val.long = r->con.val.long
			end if

		case else
            v->val.int = r->con.val.int
		end select

		return FB_DATATYPE_INVALID
	end if

    ''
	dtype = symbMaxDataType( v->dtype, astGetDataType( r ) )

	'' same? don't convert..
	if( dtype = FB_DATATYPE_INVALID ) then
		'' an ENUM or POINTER always has the precedence
		select case typeGet( astGetDataType( r ) )
		case FB_DATATYPE_ENUM, FB_DATATYPE_POINTER
			return astGetFullType( r )
		case else
			return v->dtype
		end select
	end if

	'' convert r to v's type
	if( dtype = v->dtype ) then
		hConvDataType( @r->con.val, astGetDataType( r ), dtype )

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
	dim as integer dtype = any

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

		if( astIsCONST( r ) ) then

			if( op < 0 ) then
				if( o = AST_OP_ADD ) then
					o = AST_OP_SUB
				else
					o = AST_OP_ADD
				end if
			end if

			dtype = hPrepConst( v, r )

			if( dtype <> FB_DATATYPE_INVALID ) then
				select case o
				case AST_OP_ADD
					select case as const typeGEt( dtype )
					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
						v->val.long += r->con.val.long

					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						v->val.float += r->con.val.float

					case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
						if( FB_LONGSIZE = len( integer ) ) then
							v->val.int += r->con.val.int
						else
							v->val.long += r->con.val.long
						end if

					case else
				    	v->val.int += r->con.val.int
					end select

				case AST_OP_SUB
					select case as const typeGet( dtype )
					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
						v->val.long -= r->con.val.long

					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						v->val.float -= r->con.val.float

					case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
						if( FB_LONGSIZE = len( integer ) ) then
							v->val.int -= r->con.val.int
						else
							v->val.long -= r->con.val.long
						end if

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
	dim as integer dtype = any

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST_NODECLASS_BOP ) then
		return n
	end if

	if( n->op.op = AST_OP_MUL ) then
		l = n->l
		r = n->r

		if( astIsCONST( r ) ) then

			dtype = hPrepConst( v, r )

			if( dtype <> FB_DATATYPE_INVALID ) then
				select case as const typeGet( dtype )
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					v->val.long *= r->con.val.long

				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					v->val.float *= r->con.val.float

				case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
					if( FB_LONGSIZE = len( integer ) ) then
						v->val.int *= r->con.val.int
					else
						v->val.long *= r->con.val.long
					end if

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

	dim as ASTNODE ptr l = any, r = any

	if( n = NULL ) then
		return NULL
	end if

	'' check any ADD|SUB|MUL BOP node with a constant at the right leaf and
	'' then begin accumulating the other constants at the nodes below the
	'' current, deleting any constant leaf that was added
	'' (this will handle for ex. a+1+b+2-3, that will become a+b
	if( n->class = AST_NODECLASS_BOP ) then
		r = n->r
		if( astIsCONST( r ) ) then
			dim as ASTVALUE v = any

			select case as const n->op.op
			case AST_OP_ADD
				v.dtype = FB_DATATYPE_INVALID
				n = hConstAccumADDSUB( n, @v, 1 )
				'' can't pass ConstAccumADDSUB() to newBOP, the order of
				'' the params should't matter
				n = astNewBOP( AST_OP_ADD, n, astNewCONST( @v.val, v.dtype ) )

			case AST_OP_MUL
				v.dtype = FB_DATATYPE_INVALID
				n = hConstAccumMUL( n, @v )
				n = astNewBOP( AST_OP_MUL, n, astNewCONST( @v.val, v.dtype ) )

           	case AST_OP_SUB
				v.dtype = FB_DATATYPE_INVALID
				n = hConstAccumADDSUB( n, @v, -1 )
				n = astNewBOP( AST_OP_SUB, n, astNewCONST( @v.val, v.dtype ) )
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

	dim as ASTNODE ptr l = any, r = any
	dim as integer dtype = any, checktype = any
	dim as ASTVALUE v = any

	'' check any ADD|SUB|MUL BOP node and then go to child leafs accumulating
	'' any constants found there, deleting those nodes and then add the
	'' result to a new node, at right side of the current one
	'' (this will handle for ex. a+1+(b+2)+(c+3), that will become a+b+c+6)
	if( n->class = AST_NODECLASS_BOP ) then
		checktype = FALSE

		select case n->op.op
		case AST_OP_ADD
			'' don't mess with strings..
			select case as const astGetDataType( n )
			case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
				 FB_DATATYPE_WCHAR

			case else
				v.dtype = FB_DATATYPE_INVALID
				n->l = hConstAccumADDSUB( n->l, @v, 1 )
				n->r = hConstAccumADDSUB( n->r, @v, 1 )

				if( v.dtype <> FB_DATATYPE_INVALID ) then
					n->l = astNewBOP( AST_OP_ADD, n->l, n->r )
					n->r = astNewCONST( @v.val, v.dtype )
					checktype = TRUE
				end if
			end select

		case AST_OP_MUL
			v.dtype = FB_DATATYPE_INVALID
			n->l = hConstAccumMUL( n->l, @v )
			n->r = hConstAccumMUL( n->r, @v )

			if( v.dtype <> FB_DATATYPE_INVALID ) then
				n->l = astNewBOP( AST_OP_MUL, n->l, n->r )
				n->r = astNewCONST( @v.val, v.dtype )
				checktype = TRUE
			end if
       	end select

		if( checktype ) then
			'' update the node data type
			l = n->l
			r = n->r
			dtype = symbMaxDataType( astGetDataType( l ), astGetDataType( r ) )
			if( dtype <> FB_DATATYPE_INVALID ) then
				if( typeGet( dtype ) <> typeGet( l->dtype ) ) then
					n->l = astNewCONV( dtype, r->subtype, l )
				else
					n->r = astNewCONV( dtype, l->subtype, r )
				end if
				astGetFullType( n ) = dtype

			else
				'' an ENUM or POINTER always have the precedence
				select case typeGet( astGetDataType( r ) )
				case FB_DATATYPE_ENUM, FB_DATATYPE_POINTER
					astGetFullType( n ) = astGetFullType( r )
				case else
					astGetFullType( n ) = astGetFullType( l )
				end select
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
	dim as integer dtype = any

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST_NODECLASS_BOP ) then
		return n
	end if

	if( n->op.op = AST_OP_ADD ) then
		l = n->l
		r = n->r

		if( astIsCONST( r ) ) then

			dtype = hPrepConst( v, r )

			if( dtype <> FB_DATATYPE_INVALID ) then
				select case as const typeGet( dtype )
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					v->val.long += r->con.val.long

				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					v->val.float += r->con.val.float

				case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
					if( FB_LONGSIZE = len( integer ) ) then
						v->val.int += r->con.val.int
					else
						v->val.long += r->con.val.long
					end if

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

	dim as ASTNODE ptr l = any, r = any
	dim as ASTVALUE v = any

	if( n = NULL ) then
		return NULL
	end if

	'' check any MUL BOP node with a constant at the right leaf and then scan
	'' the left leaf for ADD BOP nodes, applying the distributive, deleting those
	'' nodes and adding the result of all sums to a new node
	'' (this will handle for ex. 2 * (3 + a * 2) that will become 6 + a * 4 (with Accum2's help))
	if( n->class = AST_NODECLASS_BOP ) then
		r = n->r
		if( astIsCONST( r ) ) then
			if( n->op.op = AST_OP_MUL ) then

				v.dtype = FB_DATATYPE_INVALID
				n->l = hConstDistMUL( n->l, @v )

				if( v.dtype <> FB_DATATYPE_INVALID ) then
					select case as const v.dtype
					case FB_DATATYPE_LONGINT

mul_long:				select case as const astGetDataType( r )
						case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
							v.val.long *= r->con.val.long

						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							v.val.long *= clngint( r->con.val.float )

						case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
							if( FB_LONGSIZE = len( integer ) ) then
								v.val.long *= clngint( r->con.val.int )
							else
								v.val.long *= r->con.val.long
							end if

						case else
							v.val.long *= clngint( r->con.val.int )
						end select

						r = astNewCONSTl( v.val.long, v.dtype )

					case FB_DATATYPE_ULONGINT

mul_ulong:				select case as const astGetDataType( r )
						case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
							v.val.long *= cunsg( r->con.val.long )

						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							v.val.long *= culngint( r->con.val.float )

						case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
							if( FB_LONGSIZE = len( integer ) ) then
								v.val.long *= culngint( r->con.val.int )
							else
								v.val.long *= cunsg( r->con.val.long )
							end if

						case else
							v.val.long *= culngint( r->con.val.int )
						end select

						r = astNewCONSTl( v.val.long, v.dtype )

					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						select case as const astGetDataType( r )
						case FB_DATATYPE_LONGINT
							v.val.float *= cdbl( r->con.val.long )

						case FB_DATATYPE_ULONGINT
							v.val.float *= cdbl( cunsg( r->con.val.long ) )

						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							v.val.float *= r->con.val.float

						case FB_DATATYPE_LONG
							if( FB_LONGSIZE = len( integer ) ) then
								v.val.float *= cdbl( r->con.val.int )
							else
								v.val.float *= cdbl( r->con.val.long )
							end if

						case FB_DATATYPE_ULONG
							if( FB_LONGSIZE = len( integer ) ) then
								v.val.float *= cdbl( cunsg( r->con.val.int ) )
							else
								v.val.float *= cdbl( cunsg( r->con.val.long ) )
							end if

						case FB_DATATYPE_UINT
							v.val.float *= cdbl( cunsg( r->con.val.int ) )

						case else
							v.val.float *= cdbl( r->con.val.int )
						end select

						r = astNewCONSTf( v.val.float, v.dtype )

					case FB_DATATYPE_LONG
						if( FB_LONGSIZE = len( integer ) ) then
							goto mul_int
						else
							goto mul_long
						end if

					case FB_DATATYPE_ULONG
						if( FB_LONGSIZE = len( integer ) ) then
							goto mul_int
						else
							goto mul_ulong
						end if

					case else

mul_int:				select case as const astGetDataType( r )
						case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
							v.val.int *= cint( r->con.val.long )

						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							v.val.int *= cint( r->con.val.float )

						case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
							if( FB_LONGSIZE = len( integer ) ) then
								v.val.int *= r->con.val.int
							else
								v.val.int *= cint( r->con.val.long )
							end if

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
private sub hOptConstIdxMult _
	( _
		byval n as ASTNODE ptr _
	)

	dim as ASTNODE ptr l = n->l

	'' if top of tree = idx * lgt, and lgt < 10, save lgt and delete the * node
	if( l->class = AST_NODECLASS_BOP ) then
		if( l->op.op = AST_OP_MUL ) then
			dim as ASTNODE ptr lr = l->r
			if( astIsCONST( lr ) ) then
				if( irGetOption( IR_OPT_ADDRCISC ) ) then
					dim as integer c = any
					select case as const astGetDataType( lr )
					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
						c = cint( lr->con.val.long )

					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						c = cint( lr->con.val.float )

    				case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
    					if( FB_LONGSIZE = len( integer ) ) then
    						c = cint( lr->con.val.int )
    					else
    						c = cint( lr->con.val.long )
    					end if

					case else
						c = cint( lr->con.val.int )
					end select

					if( c < 10 ) then
						dim as integer delnode = any
						select case as const c
						case 6, 7
							delnode = FALSE
						case 3, 5, 9
							delnode = TRUE
							'' x86 assumption: not possible if there's already an index (EBP)
							dim as FBSYMBOL ptr s = astGetSymbol( n->r )
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
	end if

	'' convert to integer if needed
	if( (symbGetDataClass( astGetDataType( l ) ) <> FB_DATACLASS_INTEGER) or _
	    (symbGetDataSize( astGetDataType( l ) ) <> FB_POINTERSIZE) ) then
		n->l = astNewCONV( FB_DATATYPE_INTEGER, NULL, l )
	end if

end sub

'':::::
private function hOptDerefAddr _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = n->l

	select case l->class
	case AST_NODECLASS_OFFSET
		dim as integer dtype = astGetFullType( n )
		dim as FBSYMBOL ptr subtype = n->subtype

		'' newBOP() will optimize ofs + const nodes, but we can't use the full
		'' ofs.ofs value because it has computed already the child's (var/idx) ofs
		dim as integer ofs = n->ptr.ofs + _
							 l->ofs.ofs - astGetOFFSETChildOfs( l->l )

		astDelNode( n )
		n = l->l
		astDelNode( l )

		astSetType( n, dtype, subtype )
		if( ofs <> 0 ) then
			astIncOffset( n, ofs )
		end if

	'' convert *@expr to expr
	case AST_NODECLASS_ADDROF
		dim as integer dtype = astGetFullType( n )
		dim as FBSYMBOL ptr subtype = n->subtype
		dim as integer ofs = n->ptr.ofs

		astDelNode( n )
		n = l->l
		astDelNode( l )

		astSetType( n, dtype, subtype )
		if( ofs <> 0 ) then
			astIncOffset( n, ofs )
		end if

	end select

	function = n

end function

'':::::
private function hOptConstIDX _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any

	if( n = NULL ) then
		return NULL
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptConstIDX( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptConstIDX( r )
	end if

	'' opt must be done in this order: addsub accum and then idx * lgt
	select case n->class
	case AST_NODECLASS_IDX, AST_NODECLASS_DEREF
		l = n->l
		if( l <> NULL ) then

			dim as ASTVALUE v = any
			v.dtype = FB_DATATYPE_INVALID
			n->l = hConstAccumADDSUB( l, @v, 1 )

        	if( v.dtype <> FB_DATATYPE_INVALID ) then
        		dim as integer c = any
        		select case as const v.dtype
        		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
        			c = cint( v.val.long )

        		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
        			c = cint( v.val.float )

        		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
        			if( FB_LONGSIZE = len( integer ) ) then
        				c = v.val.int
        			else
        				c = cint( v.val.long )
        			end if

        		case else
        			c = v.val.int
        		end select

        		if( n->class = AST_NODECLASS_IDX ) then
        			n->idx.ofs += c * n->idx.mult
        		else
        			n->ptr.ofs += c
        		end if
        	end if

        	'' remove l node if it's a const and add it to parent's offset
        	l = n->l
        	if( astIsCONST( l ) ) then
				dim as integer c = any
				select case as const astGetDataType( l )
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					c = cint( l->con.val.long )

				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					c = cint( l->con.val.float )

        		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
        			if( FB_LONGSIZE = len( integer ) ) then
        				c = cint( l->con.val.int )
        			else
        				c = cint( l->con.val.long )
        			end if

				case else
					c = cint( l->con.val.int )
				end select

				if( n->class = AST_NODECLASS_IDX ) then
					n->idx.ofs += c * n->idx.mult
				else
					n->ptr.ofs += c
				end if

				astDelNode( l )
				n->l = NULL

			else
				'' indexing?
				if( n->class = AST_NODECLASS_IDX ) then
					hOptConstIdxMult( n )

				'' deref..
				else
					n = hOptDerefAddr( n )
				end if
			end if
		end if
	end select

	function = n

end function

'':::::
private function hOptFieldsCalc _
	( _
		byval n as ASTNODE ptr, _
		byval parent as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptFieldsCalc( l, n )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptFieldsCalc( r, n )
	end if

	'' (@((@foo + offsetof(bar))->bar) + offsetof(baz)))->baz to
    if( n->class = AST_NODECLASS_FIELD ) then
    	l = n->l

    	if( l->class = AST_NODECLASS_DEREF ) then
	    	dim as ASTNODE ptr ll = l->l
	    	if( ll->class = AST_NODECLASS_BOP ) then
	    		dim as ASTNODE ptr lll = ll->l
	    		if( lll->class = AST_NODECLASS_ADDROF ) then
	    			dim as ASTNODE ptr llll = lll->l
	    			if( llll->class = AST_NODECLASS_FIELD ) then
		    			dim as ASTNODE ptr lllll = llll->l
		    			if( lllll->class = AST_NODECLASS_DEREF ) then
		    				l->l = astNewBOP( AST_OP_ADD, _
		    						   	   	  lllll->l, _
		    						   	   	  ll->r )
		    				astDelNode( ll )
		    				astDelNode( lll )
		    				astDelNode( llll )
		    				astDelNode( lllll )
		    			end if
		    		end if
	    		end if
	    	end if
    	else

	    	'' resolve bitfields before deleting the field, because
	    	'' otherwise that'd only happen in LoadFIELD, which won't
	    	'' get called since the field node is destroyed

	    	'' don't touch assignments though, they'll be handled in
	    	'' LoadASSIGN... this feels hackish
	    	if( iif( parent, parent->class <> AST_NODECLASS_ASSIGN, FALSE ) ) then
	    		astUpdateBitfieldAccess( l )
	    	end if

    		astDelNode( n )
    		n = l
    	end if
    end if

	function = n

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' arithmetic association optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hOptAssocADD _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any, n_old = any
	dim as integer op = any, rop = any

	if( n = NULL ) then
		return NULL
	end if

    '' convert a+(b+c) to a+b+c and a-(b-c) to a-b+c
	if( n->class = AST_NODECLASS_BOP ) then
		op = n->op.op
		select case op
		case AST_OP_ADD, AST_OP_SUB

			'' don't mess with strings..
			select case astGetDataType( n )
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

	dim as ASTNODE ptr l = any, r = any, n_old = any

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
private sub hDivToShift_Signed _
	( _
		byval n as ASTNODE ptr, _
		byval const_val as integer _
	)

	dim as ASTNODE ptr l = any, l_cpy = any
	dim as integer dtype = any, bits = any

	l = n->l

	'' !!!FIXME!!! while there's no common sub-expr elimination, only allow VAR nodes
	if( l->class <> AST_NODECLASS_VAR ) then
		exit sub
	end if

	dtype = astGetFullType( l )

	bits = symbGetDataBits( dtype ) - 1
	'' bytes are converted to int's..
	if( bits = 7 ) then
		bits = symbGetDataBits( FB_DATATYPE_INTEGER ) - 1
	end if

	l_cpy = astCloneTree( l )

	if( const_val = 1 ) then
		'' n + ( cunsg(n) shr bits )
		n->l = astNewCONV( dtype, _
						   NULL, _
						   astNewBOP( AST_OP_ADD, _
									  l_cpy, _
									  astNewBOP( AST_OP_SHR, _
												 astNewCONV( symbGetUnsignedType( dtype ), _
															 NULL, _
															 l, _
															 AST_OP_TOUNSIGNED _
														   ), _
												 astNewCONSTi( bits, _
															   FB_DATATYPE_INTEGER ), _
											   ), _
									), _
						   AST_OP_TOSIGNED _
						 )
	else
		'' n + ( (n shr bits) and (1 shl const_val - 1) )
		n->l = astNewCONV( dtype, _
						   NULL, _
						   astNewBOP( AST_OP_ADD, _
									  l_cpy, _
									  astNewBOP( AST_OP_AND, _
												 astNewBOP( AST_OP_SHR, _
															l, _
															astNewCONSTi( bits, _
																		  FB_DATATYPE_INTEGER ) _
														  ), _
												 astNewCONSTi( 1 shl const_val - 1, _
															   FB_DATATYPE_INTEGER ), _
											   ), _
									), _
						   AST_OP_TOSIGNED _
						 )
	end if

	n->op.op = AST_OP_SHR
	n->r->con.val.int = const_val

end sub

'':::::
private sub hOptToShift _
	( _
		byval n as ASTNODE ptr _
	)

	dim as ASTNODE ptr l = any, r = any
	dim as integer const_val = any, op = any

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
			if( astIsCONST( r ) ) then
				if( symbGetDataClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then
					if( symbGetDataSize( astGetDataType( r ) ) <= FB_INTEGERSIZE ) then
						const_val = r->con.val.int
						if( const_val > 0 ) then
							const_val = hToPow2( const_val )
							if( const_val > 0 ) then
								select case op
								case AST_OP_MUL
									if( const_val <= 32 ) then
										n->op.op = AST_OP_SHL
										r->con.val.int = const_val
									end if

								case AST_OP_INTDIV
									if( const_val <= 32 ) then
										l = n->l
										if( symbIsSigned( astGetDataType( l ) ) = FALSE ) then
											n->op.op = AST_OP_SHR
											r->con.val.int = const_val
										else
                                            hDivToShift_Signed( n, const_val )
										end if
									end if

								case AST_OP_MOD
									'' unsigned types only
									if( symbIsSigned( astGetDataType( n->l ) ) = FALSE ) then
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
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	dim as integer op = any
	dim as longint v = any
	dim as integer keep_l = any, keep_r = any

	if( n = NULL ) then
		return n
	end if

	'' convert 'a * 0'    to '0'**
	''         'a MOD 1'  to '0'*
	''         'a MOD -1' to '0'*
	''         'a * 1'    to 'a'
	''         'a \ 1'    to 'a'
	''         'a + 0'    to 'a'
	''         'a - 0'    to 'a'
	''         'a SHR 0'  to 'a'
	''         'a SHL 0'  to 'a'
	''         'a IMP -1' to '-1'*
	''         'a OR -1'  to '-1'*
	''         'a OR 0'   to 'a'
	''         'a XOR 0'  to 'a'
	''         'a AND -1' to 'a'
	''         'a AND 0'  to '0'*

	''         '0 * a'    to '0'*
	''         '0 \ a'    to '0'*
	''         '0 MOD a'  to '0'*
	''         '0 SHR a'  to '0'*
	''         '0 SHL a'  to '0'*

	''*  'a' can't be deleted if it has side-effects
	''** convert 'a * 0' to 'a AND 0' to optimize speed without changing side-effects

	if( n->class = AST_NODECLASS_BOP ) then

		op = n->op.op
		l = n->l
		r = n->r

		'' don't allow exprs with side-effects to be deleted
		keep_l = ( astIsClassOnTree( AST_NODECLASS_CALL, l ) <> NULL )
		keep_r = ( astIsClassOnTree( AST_NODECLASS_CALL, r ) <> NULL )

		if( symbGetDataClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then
			if( astIsCONST( r ) ) then
				if( symbGetDataSize( astGetDataType( r ) ) <= FB_INTEGERSIZE ) then
					v = r->con.val.int
				else
					v = r->con.val.long
				end if

				select case as const op
				case AST_OP_MUL
					if( v = 0 ) then
						if( keep_l = FALSE ) then
							astDelTree( l )
							astDelNode( n )
							return r
						else
							'' optimize '* 0' to 'AND 0'
							n->op.op = AST_OP_AND
						end if
					elseif( v = 1 ) then
						astDelNode( r )
						astDelNode( n )
						return hOptNullOp( l )
					end if

				case AST_OP_MOD
					if( ( v = 1 ) or ( ( v = -1 ) and ( symbIsSigned( astGetDataType( r ) ) <> FALSE ) ) ) then
						if( keep_l = FALSE ) then
							r->con.val.int = 0
							astDelTree( l )
							astDelNode( n )
							return r
						end if

					end if

				case AST_OP_INTDIV
					if( v = 1 ) then
						astDelNode( r )
						astDelNode( n )
						return hOptNullOp( l )
					end if

				case AST_OP_ADD, AST_OP_SUB, _
					 AST_OP_SHR, AST_OP_SHL, _
					 AST_OP_XOR
					if( v = 0 ) then
						astDelNode( r )
						astDelNode( n )
						return hOptNullOp( l )
					end if

				case AST_OP_IMP
					if( v = -1 ) then
						if( keep_l = FALSE ) then
							astDelTree( l )
							astDelNode( n )
							return r
						end if
					end if

				case AST_OP_OR
					if( v = 0 ) then
						astDelNode( r )
						astDelNode( n )
						return hOptNullOp( l )
					elseif( v = -1 ) then
						if( keep_l = FALSE ) then
							astDelTree( l )
							astDelNode( n )
							return r
						end if
					end if

				case AST_OP_AND
					if( v = -1 ) then
						astDelNode( r )
						astDelNode( n )
						return hOptNullOp( l )
					elseif( v = 0 ) then
						if( keep_l = FALSE ) then
							astDelTree( l )
							astDelNode( n )
							return r
						end if
					end if

				end select

			elseif( astIsCONST( l ) ) then
				if( symbGetDataSize( astGetDataType( l ) ) <= FB_INTEGERSIZE ) then
					v = l->con.val.int
				else
					v = l->con.val.long
				end if

				select case as const op
				case AST_OP_MUL, AST_OP_INTDIV, AST_OP_MOD, _
				     AST_OP_SHR, AST_OP_SHL
					if( v = 0 ) then
						if( keep_r = FALSE ) then
							astDelTree( r )
							astDelNode( n )
							return l
						end if
					end if

				end select
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

''::::
private function hOptLogic _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr m = any
	dim as ASTNODE ptr l = any, r = any
	dim as integer op = any
	dim as longint v = any

	if( n = NULL ) then
		return n
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptLogic( l )
		l = n->l
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptLogic( r )
		r = n->r
	end if

	if( symbGetDataClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then

		if( n->class = AST_NODECLASS_UOP ) then
			if( n->op.op = AST_OP_NOT ) then
				if( l->class = AST_NODECLASS_UOP ) then
					if( l->op.op = AST_OP_NOT ) then

						'' convert NOT NOT x to x

						m = l->l
						astDelNode( l )
						astDelNode( n )
						n = hOptLogic( m )
					end if

				elseif( l->class = AST_NODECLASS_BOP ) then
					if( symbGetDataClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then
						if( l->op.op = AST_OP_XOR ) then
							if( astIsCONST( l->l ) ) then
								'' convert:
								'' not (const xor x)    to    (not const) xor x

								if( symbGetDataSize( astGetDataType( l->l ) ) <= FB_INTEGERSIZE ) then
									v = l->l->con.val.int
								else
									v = l->l->con.val.long
								end if

								l->l->con.val.long = not v
								astDelNode( n )
								n = hOptLogic( l )

							elseif( astIsCONST( l->r ) ) then
								'' convert:
								'' not (x xor const)    to    x xor (not const)

								if( symbGetDataSize( astGetDataType( l->r ) ) <= FB_INTEGERSIZE ) then
									v = l->r->con.val.int
								else
									v = l->r->con.val.long
								end if

								l->r->con.val.long = not v
								astDelNode( n )
								n = hOptLogic( l )

							end if
						end if
					end if
				end if
			end if

		elseif( n->class = AST_NODECLASS_BOP ) then

			if( symbGetDataClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then
				op = n->op.op
				select case op
				case AST_OP_OR, AST_OP_AND, AST_OP_XOR

					if( op = AST_OP_AND ) then
						op = AST_OP_OR
					elseif( op = AST_OP_OR ) then
						op = AST_OP_AND
					end if

					'' convert:
					'' (not x) and (not y)      to        not (x or  y)
					'' (not x) or  (not y)      to        not (x and y)
					'' (not x) xor (not y)      to        x xor y

					''  (op)           NOT (for AND/OR)
					''  /   \     =>    |
					'' NOT  NOT        (op) (opposite for AND/OR)
					''  |    |         /  \
					''  x    y        x    y

					if( (l->op.op = AST_OP_NOT) and (l->class = AST_NODECLASS_UOP) and (r->op.op = AST_OP_NOT) and (r->class = AST_NODECLASS_UOP) ) then

						l = hOptLogic( l->l )
						r = hOptLogic( r->l )

						m = astNewBOP( op, l, r )

						if( op <> AST_OP_XOR ) then
							m = astNewUOP( AST_OP_NOT, m )
						end if

						astDelNode( n->l )
						astDelNode( n->r )
						astDelNode( n )

						n = m

					'' pull out NOTs inside BOPs involving constants to allow further optimization
					'' (removal of NOT NOT, etc.)

					'' also, XOR involving const and NOT expr can be reduced to NOT on the const
					'' (instead of the other expr) to allow compile-time evaluation
					'' since x XOR y is equivalent to (not x) XOR (not y)

					elseif( astIsCONST( l ) and (r->class = AST_NODECLASS_UOP) and (r->op.op = AST_OP_NOT) ) then
						'' convert:
						'' const and (not x)    to    not ((not const) or  x)
						'' const or  (not x)    to    not ((not const) and x)
						'' const xor (not x)    to    (not const) xor x

						if( symbGetDataSize( astGetDataType( l ) ) <= FB_INTEGERSIZE ) then
							v = l->con.val.int
						else
							v = l->con.val.long
						end if

						m = astNewBOP( op, l, r->l )
						l->con.val.long = not v

						if( op <> AST_OP_XOR ) then
							m = astNewUOP( AST_OP_NOT, m )
						end if

						astDelNode( r )
						astDelNode( n )

						n = m

					elseif( astIsConst( r ) and (l->class = AST_NODECLASS_UOP) and (l->op.op = AST_OP_NOT) ) then
						'' convert:
						'' (not x) and const    to    not (x or  (not const))
						'' (not x) or  const    to    not (x and (not const))
						'' (not x) xor const    to    x xor (not const)

						if( symbGetDataSize( astGetDataType( r ) ) <= FB_INTEGERSIZE ) then
							v = r->con.val.int
						else
							v = r->con.val.long
						end if

						m = astNewBOP( op, l->l, r )
						r->con.val.long = not v

						if( op <> AST_OP_XOR ) then
							m = astNewUOP( AST_OP_NOT, m )
						end if

						astDelNode( l )
						astDelNode( n )

						n = m

					elseif( (op = AST_OP_XOR) and (l->class = AST_NODECLASS_UOP) and (l->op.op = AST_OP_NOT) ) then
						'' convert:
						'' (not x) xor y    to    not (x xor y)

						m = astNewUOP( AST_OP_NOT, n )

						n->l = l->l

						astDelNode( l )

						n = m

					elseif( (op = AST_OP_XOR) and (r->class = AST_NODECLASS_UOP) and (r->op.op = AST_OP_NOT) ) then
						'' convert:
						'' x xor (not y)    to    not (x xor y)

						m = astNewUOP( AST_OP_NOT, n)

						n->r = r->l

						astDelNode( r )

						n = m

					end if
				end select
			end if
		end if
	end if

	function = n

end function


'':::::
private function hDoOptRemConv _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	dim as integer dorem = any

	'' convert l{float} op cast(float, r{var}) to l op r
	if( n->class = AST_NODECLASS_BOP ) then
		select case astGetDataType( n )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			r = n->r
			if( r->class = AST_NODECLASS_CONV ) then
				'' left node can't be a cast() too
				if( n->l->class <> AST_NODECLASS_CONV ) then
					select case astGetDataType( r )
					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
						l = r->l

						'' skip any casting if they won't do any conversion
						dim as ASTNODE ptr t = l
						if( l->class = AST_NODECLASS_CONV ) then
							if( l->cast.doconv = FALSE ) then
								t = l->l
							end if
						end if

						'' can't be a longint
						if( symbGetDataSize( astGetDataType( t ) ) < FB_INTEGERSIZE*2 ) then
							dorem = FALSE

							select case as const t->class
							case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
								 AST_NODECLASS_FIELD, AST_NODECLASS_DEREF
								'' can't be unsigned either
								if( symbIsSigned( astGetDataType( t ) ) ) then
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
		n->l = hDoOptRemConv( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hDoOptRemConv( r )
	end if

	function = n

end function

'':::::
private function hOptRemConv _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	if( irGetOption( IR_OPT_FPU_CONVERTOPER ) ) then
		return n
	end if

	if( n = NULL ) then
		return NULL
	end if

	function = hDoOptRemConv( n )

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
    	    		lnk = astNewLINK( lnk, _
    	    						  rtlStrConcatAssign( astCloneTree( dst ), _
    	    						  					  n->l ) )
    	    	else
    	    		lnk = astNewLINK( lnk, _
    	    						  rtlWstrConcatAssign( astCloneTree( dst ), _
    	    						  					   n->l ) )
    	    	end if
    	    end if
    	end if

    	if( n->r <> NULL ) then
    	    if( is_wstr = FALSE ) then
    	    	lnk = astNewLINK( lnk, _
    	    					  rtlStrConcatAssign( astCloneTree( dst ), _
    	    					  					  n->r ) )
    	    else
    	    	lnk = astNewLINK( lnk, _
    	    					  rtlWstrConcatAssign( astCloneTree( dst ), _
    	    					  					   n->r ) )
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
    			lnk = astNewLINK( lnk, _
    							  rtlStrConcatAssign( astCloneTree( dst ), _
    							  					  n ) )
    		else
    			lnk = astNewLINK( lnk, _
    							  rtlWstrConcatAssign( astCloneTree( dst ), _
    							  					   n ) )
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
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX
			sym = astGetSymbol( l )
			if( sym <> NULL ) then
				if( (sym->attrib and _
					(FB_SYMBATTRIB_PARAMBYDESC or FB_SYMBATTRIB_PARAMBYREF)) = 0 ) then

					function = (astIsSymbolOnTree( sym, r ) = FALSE)

				end if
			end if

		case AST_NODECLASS_FIELD
			select case l->l->class
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX

				'' byref params would be AST_NODECLASS_DEREF

				sym = astGetSymbol( l )
				if( sym <> NULL ) then
					function = (astIsSymbolOnTree( sym, r ) = FALSE)
				end if
			end select
		end select
	end if

end function

''::::
private function hOptStrAssignment _
	( _
		byval n as ASTNODE ptr, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

	dim as integer optimize = any, is_wstr = any

	optimize = FALSE

	'' is right side a bin operation?
	if( r->class = AST_NODECLASS_BOP ) then
		dim as FBSYMBOL ptr sym

		'' is left side a var?
		select case as const l->class
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX
			'' !!!FIXME!!! can't include AST_NODECLASS_DEREF, unless -noaliasing is added

			if( astIsTreeEqual( l, r->l ) ) then
				sym = astGetSymbol( l )
				if( sym <> NULL ) then
					if( (sym->attrib and _
						(FB_SYMBATTRIB_PARAMBYDESC or FB_SYMBATTRIB_PARAMBYREF)) = 0 ) then

						optimize = astIsSymbolOnTree( sym, r->r ) = FALSE
					end if
				end if
			end if

		case AST_NODECLASS_FIELD
			select case as const l->l->class
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX

				if( astIsTreeEqual( l, r->l ) ) then
					sym = astGetSymbol( l )
					if( sym <> NULL ) then
						optimize = astIsSymbolOnTree( sym, r->r ) = FALSE
					end if
				end if

			end select
		end select
	end if

	is_wstr = ( astGetDataType( n ) = FB_DATATYPE_WCHAR )

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
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	dim as integer dtype = any, dclass = any

	function = n

	if( n = NULL ) then
		exit function
	end if

	'' try to convert "foo = foo op expr" to "foo op= expr" (including unary ops)

	select case n->class
	'' there's just one assignment per tree (always at top), so, just check this node
	case AST_NODECLASS_ASSIGN

	'' SelfBOP and TypeIniFlush will create links to emit trees
	case AST_NODECLASS_LINK
		n->l = astOptAssignment( n->l )
		n->r = astOptAssignment( n->r )
		exit function

	case else
		exit function
	end select

	l = n->l
	r = n->r

	dtype = astGetFullType( n )

	'' strings?
	select case typeGet( dtype )
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_WCHAR
		return hOptStrAssignment( n, l, r )
	end select

	dclass = symbGetDataClass( dtype )
	if( dclass = FB_DATACLASS_INTEGER ) then
		if( irGetOption( IR_OPT_CPU_BOPSELF ) = FALSE ) then
			exit function
		end if

	else
		if( irGetOption( IR_OPT_FPU_BOPSELF ) = FALSE ) then
			'' try to optimize if a constant is being assigned to a float var
  			if( astIsCONST( r ) ) then
  				if( dclass = FB_DATACLASS_FPOINT ) then
					if( symbGetDataClass( astGetDataType( r ) ) <> FB_DATACLASS_FPOINT ) then
						n->r = astNewCONV( dtype, NULL, r )
					end if
				end if
			end if

			exit function
		end if
	end if

	'' can't be byte either, as BOP will do cint(byte) op cint(byte)
	if( symbGetDataSize( dtype ) = 1 ) then
		exit function
	end if

	'' is left side a var, idx or ptr?

	'' skip any casting if they won't do any conversion
	dim as ASTNODE ptr t = l
	if( l->class = AST_NODECLASS_CONV ) then
		if( l->cast.doconv = FALSE ) then
			t = l->l
		end if
	end if

	select case as const t->class
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_DEREF

	case AST_NODECLASS_FIELD
		'' isn't it a bitfield?
		if( astGetDataType( t->l ) = FB_DATATYPE_BITFIELD ) then
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
	if( symbGetDataClass( astGetDataType( r ) ) <> FB_DATACLASS_INTEGER ) then
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
function hOptSelfAssign _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	''  =           NOP
	'' / \   =>
	'' d  d

	dim as ASTNODE ptr l = any, r = any
	dim as integer dtype = any, dclass = any

	function = n

	if( n = NULL ) then
		exit function
	end if

	if n->class <> AST_NODECLASS_ASSIGN then
		exit function
	end if

	l = n->l
	r = n->r

	if( astIsTreeEqual( l, r ) = FALSE ) then
		exit function
	end if

	astDelNode( n )
	astDelTree( l )
	astDelTree( r )

	function = astNewNOP( )
end function

''::::
function hOptSelfCompare _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	dim as integer dtype = any, dclass = any

	function = n

	if( n = NULL ) then
		exit function
	end if

	if n->class <> AST_NODECLASS_BOP then
		exit function
	end if

	l = n->l
	r = n->r

	if( astIsTreeEqual( l, r ) = FALSE ) then
		exit function
	end if

	dim as integer c

	select case as const n->op.op
	case AST_OP_EQ, AST_OP_LE, AST_OP_GE
		c = -1
	case AST_OP_NE, AST_OP_GT, AST_OP_LT
		c = 0
	case else
		exit function
	end select

	astDelNode( n )
	astDelTree( l )
	astDelTree( r )

	function = astNewCONSTi( c )
end function

'':::::
private function hOptReciprocal _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	dim as single v = Any

	if( n = NULL ) then
		return NULL
	end if

	'' first check if the op is a divide
	if( n->class = AST_NODECLASS_BOP ) AndAlso ( n->op.op = AST_OP_DIV ) then
		l = n->l
		if( astIsCONST( l ) ) then
			if( ( astGetDataType( l ) = FB_DATATYPE_SINGLE ) AndAlso ( l->con.val.float = 1.0f ) ) then
				r = n->r
				if( ( r->class = AST_NODECLASS_UOP ) AndAlso ( r->op.op = AST_OP_SQRT ) ) then
					'' change this to a rsqrt
					*n = *r
					n->class = AST_NODECLASS_UOP
					n->op.op = AST_OP_RSQRT
					astDelNode( r )
					astDelNode( l )
				elseif( astGetDataType( r ) = FB_DATATYPE_SINGLE ) then
					'' change this to a rcp
					astDelNode( n )
					n = astNewUOP( AST_OP_RCP, r )
					astDelNode( l )
				end if
			end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = hOptReciprocal( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = hOptReciprocal( r )
	end if

	function = n

end function

''::::
function astOptimizeTree _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	'' high-level IR? don't do anything..
	if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
		return hOptConstIDX( n )
	end if

	'' calls must be done in the order below
	ast.isopt = TRUE

	/'
	if( irGetOption( IR_OPT_REMCASTING ) ) then
		n = hOptRemCasting( n )
	end if
	'/

	if( irGetOption( IR_OPT_NESTEDFIELDS ) ) then
		n = hOptFieldsCalc( n, NULL )
	end if

	n = hOptAssocADD( n )

	n = hOptAssocMUL( n )

	n = hOptConstDistMUL( n )

	n = hOptConstAccum1( n )

	hOptConstAccum2( n )

	hOptConstRemNeg( n, NULL )

	n = hOptConstIDX( n )

	hOptToShift( n )

	n = hOptLogic( n )

	n = hOptNullOp( n )

	n = hOptSelfAssign( n )

	n = hOptSelfCompare( n )

 	n = hOptRemConv( n )

	if( env.clopt.fpmode = FB_FPMODE_FAST ) then
		n = hOptReciprocal( n )
	end if

	ast.isopt = FALSE

	function = n

end function


