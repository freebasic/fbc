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


'' [A]bstract [S]yntax [T]ree - tree handling and optimizations
''
'' obs: 1) each AST only stores a single expression and its atoms (inc. arrays and functions)
''      2) after the AST is optimized (constants folding, arithmetic associations, etc),
''         its sent to IR, where the expression becomes three-address-codes
''		3) AST optimizations don't include common-sub-expression/dead-code elimination,
''         that must be done by the DAG module
''		4) module looks much uglier than it should, thanks to all hacking needed to support
''		   QB's var-length strings, arrays passed by descriptor and byref arguments..
''
'' chng: sep/2004 written [v1ctor]

defint a-z
option explicit
option escape

'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\rtl.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\list.bi'

'''''#define DO_STACK_ALIGN

type ASTCTX
	astTB			as TLIST

	tempstr			as TLIST
	temparray		as TLIST
end Type

type ASTVALUE
	dtype			as integer
	v				as FBVALUE
end type

declare function	astUpdStrConcat		( byval n as ASTNODE ptr ) as ASTNODE ptr

declare function 	astGetUDTElm		( byval n as ASTNODE ptr ) as FBSYMBOL ptr

'' globals
	dim shared ctx as ASTCTX

	dim shared bitmaskTB( 0 to 32 ) as uinteger = { 0, _
		1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65565, _
        131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215, 33554431, _
        67108863, 134217727, 268435455, 536870911, 1073741823, 2147483647, 4294967295 }


'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constant folding optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astOptConstRmNeg( byval n as ASTNODE ptr, _
					  byval p as ASTNODE ptr )
	static as ASTNODE ptr l, r

	'' check any UOP node, and if its of the kind "-var + const" convert to "const - var"
	if( p <> NULL ) then
		if( n->class = AST.NODECLASS.UOP ) then
			if( n->op = IR.OP.NEG ) then
				l = n->l
				if( l->class = AST.NODECLASS.VAR ) then
					if( p->class = AST.NODECLASS.BOP ) then
						if( p->op = IR.OP.ADD ) then
							r = p->r
							if( r->defined ) then
								p->op = IR.OP.SUB
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
		astOptConstRmNeg( l, n )
	end if

	r = n->r
	if( r <> NULL ) then
		astOptConstRmNeg( r, n )
	end if

end sub

'':::::
private sub hConvDataType( byval v as FBVALUE ptr, _
						   byval vdtype as integer, _
						   byval dtype as integer ) static


	select case as const dtype
	''
	case IR.DATATYPE.LONGINT

		select case as const vdtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		    '' no conversion
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			v->value64 = clngint( v->valuef )
		case else
			v->value64 = clngint( v->valuei )
		end select

	''
	case IR.DATATYPE.ULONGINT

		select case as const vdtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		    '' no conversion
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			v->value64 = culngint( v->valuef )
		case else
			v->value64 = culngint( v->valuei )
		end select

	''
	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE

		select case as const vdtype
		case IR.DATATYPE.LONGINT
		    v->valuef = cdbl( v->value64 )
		case IR.DATATYPE.ULONGINT
			v->valuef = cdbl( cunsg( v->value64 ) )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			'' do nothing
		case IR.DATATYPE.UINT
			v->valuef = cdbl( cuint( v->valuei ) )
		case else
			v->valuef = cdbl( v->valuei )
		end select

	''
	case IR.DATATYPE.UINT

	 	select case as const vdtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		    v->valuei = cuint( v->value64 )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			v->valuei = cuint( v->valuef )
		end select

	''
	case else

		select case as const vdtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		    v->valuei = cint( v->value64 )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			v->valuei = cint( v->valuef )
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
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			v->v.value64 = r->v.value64
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			v->v.valuef = r->v.valuef
		case else
            v->v.valuei = r->v.valuei
		end select

		return INVALID
	end if

    ''
	dtype = irMaxDataType( v->dtype, r->dtype )

	'' same? don't convert..
	if( dtype = INVALID ) then
		return v->dtype
	end if

	'' convert r to v's type
	if( dtype = v->dtype ) then
		hConvDataType( @r->v, r->dtype, dtype )

	'' convert v to r's type
	else
		hConvDataType( @v->v, v->dtype, dtype )
		v->dtype = dtype
	end if

	return dtype

end function

'':::::
function asthConstAccumADDSUB( byval n as ASTNODE ptr, _
							   byval v as ASTVALUE ptr, _
							   byval op as integer ) as ASTNODE ptr
	dim as ASTNODE ptr l, r
	dim as integer o
	static as integer dtype

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST.NODECLASS.BOP ) then
		return n
	end if

    o = n->op

	select case o
	case IR.OP.ADD, IR.OP.SUB
		l = n->l
		r = n->r

		if( r->defined ) then

			if( op < 0 ) then
				if( o = IR.OP.ADD ) then
					o = IR.OP.SUB
				else
					o = IR.OP.ADD
				end if
			end if

			dtype = hPrepConst( v, r )

			if( dtype <> INVALID ) then
				select case o
				case IR.OP.ADD
					select case as const dtype
					case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
						v->v.value64 += r->v.value64
					case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
						v->v.valuef += r->v.valuef
					case else
				    	v->v.valuei += r->v.valuei
					end select

				case IR.OP.SUB
					select case as const dtype
					case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
						v->v.value64 -= r->v.value64
					case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
						v->v.valuef -= r->v.valuef
					case else
						v->v.valuei -= r->v.valuei
					end select
				end select
			end if

			'' del BOP and const node
			astDel( r )
			astDel( n )

			'' top node is now the left one
			n = asthConstAccumADDSUB( l, v, op )

		else
			'' walk
			n->l = asthConstAccumADDSUB( l, v, op )

			if( o = IR.OP.SUB ) then
				op = -op
			end if

			n->r = asthConstAccumADDSUB( r, v, op )
		end if
	end select

	function = n

end function

'':::::
function asthConstAccumMUL( byval n as ASTNODE ptr, _
							byval v as ASTVALUE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l, r
	static as integer dtype

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST.NODECLASS.BOP ) then
		return n
	end if

	if( n->op = IR.OP.MUL ) then
		l = n->l
		r = n->r

		if( r->defined ) then

			dtype = hPrepConst( v, r )

			if( dtype <> INVALID ) then
				select case as const dtype
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					v->v.value64 *= r->v.value64
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
					v->v.valuef *= r->v.valuef
				case else
					v->v.valuei *= r->v.valuei
				end select
			end if

			'' del BOP and const node
			astDel( r )
			astDel( n )

			'' top node is now the left one
			n = asthConstAccumMUL( l, v )

		else
			'' walk
			n->l = asthConstAccumMUL( l, v )
			n->r = asthConstAccumMUL( r, v )
		end if
	end if

	function = n

end function

'':::::
function astOptConstAccum1( byval n as ASTNODE ptr ) as ASTNODE ptr
	static as ASTNODE ptr l, r, nn
	static as ASTVALUE v

	if( n = NULL ) then
		return NULL
	end if

	'' check any ADD|SUB|MUL BOP node with a constant at the right leaf and
	'' then begin accumulating the other constants at the nodes below the
	'' current, deleting any constant leaf that were added
	'' (this will handle for ex. a+1+b+2-3, that will become a+b
	if( n->class = AST.NODECLASS.BOP ) then
		r = n->r
		if( r->defined ) then

			select case as const n->op
			case IR.OP.ADD
				v.dtype = INVALID
				n = asthConstAccumADDSUB( n, @v, 1 )

				select case as const v.dtype
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					nn = astNewCONST64( v.v.value64, v.dtype )
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
				    nn = astNewCONSTf( v.v.valuef, v.dtype )
				case else
					nn = astNewCONSTi( v.v.valuei, v.dtype )
				end select

				n = astNewBOP( IR.OP.ADD, n, nn )

			case IR.OP.MUL
				v.dtype = INVALID
				n = asthConstAccumMUL( n, @v )

				select case as const v.dtype
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					nn = astNewCONST64( v.v.value64, v.dtype )
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
					nn = astNewCONSTf( v.v.valuef, v.dtype )
				case else
					nn = astNewCONSTi( v.v.valuei, v.dtype )
				end select

				n = astNewBOP( IR.OP.MUL, n, nn )

            case IR.OP.SUB
				v.dtype = INVALID
				n = asthConstAccumADDSUB( n, @v, -1 )

				select case as const v.dtype
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					nn = astNewCONST64( v.v.value64, v.dtype )
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
					nn = astNewCONSTf( v.v.valuef, v.dtype )
				case else
					nn = astNewCONSTi( v.v.valuei, v.dtype )
				end select

				n = astNewBOP( IR.OP.SUB, n, nn )

			end select

		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = astOptConstAccum1( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = astOptConstAccum1( r )
	end if

	function = n

end function

'':::::
sub astOptConstAccum2( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r
	static as integer dtype, checktype
	static as ASTVALUE v

	'' check any ADD|SUB|MUL BOP node and then go to child leafs accumulating
	'' any constants found there, deleting those nodes and then adding the
	'' result to a new node, at right side of the current one
	'' (this will handle for ex. a+1+(b+2)+(c+3), that will become a+b+c+6)
	if( n->class = AST.NODECLASS.BOP ) then

		checktype = FALSE

		select case n->op
		case IR.OP.ADD
			if( irGetDataClass( n->dtype ) <> IR.DATACLASS.STRING ) then

				v.dtype = INVALID
				n->l = asthConstAccumADDSUB( n->l, @v, 1 )
				n->r = asthConstAccumADDSUB( n->r, @v, 1 )

				if( v.dtype <> INVALID ) then
					n->l = astNewBOP( IR.OP.ADD, n->l, n->r )
					select case as const v.dtype
					case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
						n->r = astNewCONST64( v.v.value64, v.dtype )
					case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
						n->r = astNewCONSTf( v.v.valuef, v.dtype )
					case else
						n->r = astNewCONSTi( v.v.valuei, v.dtype )
					end select
					checktype = TRUE
				end if
			end if

		'case IR.OP.SUB
		'	c = 0
		'	asthConstAccumADDSUB n->l, c, -1
		'	asthConstAccumADDSUB n->r, c, -1
		'	if( c <> 0 ) then
		'		if( c - int(c) <> 0 ) then
		'			dtype = IR.DATATYPE.DOUBLE
		'		else
		'			dtype = IR.DATATYPE.INTEGER
		'		end if
		'		n->l = astNewBOP( IR.OP.SUB, n->l, n->r )
		'		n->op = IR.OP.ADD
		'		n->r = astNewCONST( c, dtype )
		'		checktype = TRUE
		'	end if

		case IR.OP.MUL

			v.dtype = INVALID
			n->l = asthConstAccumMUL( n->l, @v )
			n->r = asthConstAccumMUL( n->r, @v )

			if( v.dtype <> INVALID ) then
				n->l = astNewBOP( IR.OP.MUL, n->l, n->r )
				select case as const v.dtype
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					n->r = astNewCONST64( v.v.value64, v.dtype )
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
					n->r = astNewCONSTf( v.v.valuef, v.dtype )
				case else
					n->r = astNewCONSTi( v.v.valuei, v.dtype )
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
					n->l = astNewCONV( INVALID, dtype, l )
				else
					n->r = astNewCONV( INVALID, dtype, r )
				end if
				n->dtype = dtype
			else
				n->dtype = l->dtype
			end if
		end if

	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		astOptConstAccum2( l )
	end if

	r = n->r
	if( r <> NULL ) then
		astOptConstAccum2( r )
	end if

end sub

'':::::
function asthConstDistMUL( byval n as ASTNODE ptr, _
						   byval v as ASTVALUE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l, r
	static as integer dtype

	if( n = NULL ) then
		return NULL
	end if

	if( n->class <> AST.NODECLASS.BOP ) then
		return n
	end if

	if( n->op = IR.OP.ADD ) then
		l = n->l
		r = n->r

		if( r->defined ) then

			dtype = hPrepConst( v, r )

			if( dtype <> INVALID ) then
				select case as const dtype
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					v->v.value64 += r->v.value64
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
					v->v.valuef += r->v.valuef
				case else
					v->v.valuei += r->v.valuei
				end select
			end if

			'' del BOP and const node
			astDel( r )
			astDel( n )

			'' top node is now the left one
			n = asthConstDistMUL( l, v )

		else
			n->l = asthConstDistMUL( l, v )
			n->r = asthConstDistMUL( r, v )
		end if
	end if

	function = n

end function

'':::::
function astOptConstDistMUL( byval n as ASTNODE ptr ) as ASTNODE ptr
	static as ASTNODE ptr l, r
	static as ASTVALUE v

	if( n = NULL ) then
		return NULL
	end if

	'' check any MUL BOP node with a constant at the right leaf and then scan
	'' the left leaf for ADD BOP nodes, applying the distributive, deleting those
	'' nodes and adding the result of all sums to a new node
	'' (this will handle for ex. 2 * (3 + a * 2) that will become 6 + a * 4 (with Accum2's help))
	if( n->class = AST.NODECLASS.BOP ) then
		r = n->r
		if( r->defined ) then
			if( n->op = IR.OP.MUL ) then

				v.dtype = INVALID
				n->l = asthConstDistMUL( n->l, @v )

				if( v.dtype <> INVALID ) then
					select case as const v.dtype
					''
					case IR.DATATYPE.LONGINT
						select case as const r->dtype
						case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
							v.v.value64 *= r->v.value64
						case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
							v.v.value64 *= clngint( r->v.valuef )
						case else
							v.v.value64 *= clngint( r->v.valuei )
						end select

						r = astNewCONST64( v.v.value64, v.dtype )

					''
					case IR.DATATYPE.ULONGINT
						select case as const r->dtype
						case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
							v.v.value64 *= cunsg( r->v.value64 )
						case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
							v.v.value64 *= culngint( r->v.valuef )
						case else
							v.v.value64 *= culngint( r->v.valuei )
						end select

						r = astNewCONST64( v.v.value64, v.dtype )

					''
					case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
						select case as const r->dtype
						case IR.DATATYPE.LONGINT
							v.v.valuef *= cdbl( r->v.value64 )
						case IR.DATATYPE.ULONGINT
							v.v.valuef *= cdbl( cunsg( r->v.value64 ) )
						case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
							v.v.valuef *= r->v.valuef
						case IR.DATATYPE.UINT
							v.v.valuef *= cdbl( cunsg( r->v.valuei ) )
						case else
							v.v.valuef *= cdbl( r->v.valuei )
						end select

						r = astNewCONSTf( v.v.valuef, v.dtype )

					''
					case else
						select case as const r->dtype
						case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
							v.v.valuei *= cint( r->v.value64 )
						case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
							v.v.valuei *= cint( r->v.valuef )
						case else
							v.v.valuei *= r->v.valuei
						end select

						r = astNewCONSTi( v.v.valuei, v.dtype )
					end select

					n = astNewBOP( IR.OP.ADD, n, r )
				end if

			end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = astOptConstDistMUL( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = astOptConstDistMUL( r )
	end if

	function = n

end function

'':::::
sub astOptConstIDX( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r, lr
	static as integer c
	static as ASTVALUE v

	if( n = NULL ) then
		exit sub
	end if

	'' opt must be done in this order: addsub accum and then idx * lgt
	select case n->class
	case AST.NODECLASS.IDX, AST.NODECLASS.PTR
		l = n->l
		if( l <> NULL ) then
			v.dtype = INVALID
			n->l = asthConstAccumADDSUB( l, @v, 1 )

        	if( v.dtype <> INVALID ) then
        		select case as const v.dtype
        		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
        			c = cint( v.v.value64 )
        		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
        			c = cint( v.v.valuef )
        		case else
        			c = v.v.valuei
        		end select

        		if( n->class = AST.NODECLASS.IDX ) then
        			n->idx.ofs += c
        		else
        			n->ptr.ofs += c
        		end if
        	end if

        	'' remove l node if it's a const and add it to parent's offset
        	l = n->l
        	if( l->defined ) then
				select case as const l->dtype
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					c = cint( l->v.value64 )
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
					c = cint( l->v.valuef )
				case else
					c = cint( l->v.valuei )
				end select

				if( n->class = AST.NODECLASS.IDX ) then
					n->idx.ofs += c
				else
					n->ptr.ofs += c
				end if

				astDel( l )
				n->l = NULL
			end if
		end if
	end select

	if( n->class = AST.NODECLASS.IDX ) then
		l = n->l
		if( l <> NULL ) then
			'' x86 assumption: if top of tree = idx * lgt, and lgt < 10, save lgt and delete * node
			if( l->class = AST.NODECLASS.BOP ) then
				if( l->op = IR.OP.MUL ) then
					lr = l->r
					if( lr->defined ) then

						select case as const lr->dtype
						case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
							c = cint( lr->v.value64 )
						case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
							c = cint( lr->v.valuef )
						case else
							c = cint( lr->v.valuei )
						end select

						if( c < 10 ) then
				    		if( (c <> 6) and (c <> 7) ) then
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
			if( (irGetDataClass( l->dtype ) <> IR.DATACLASS.INTEGER) or _
			    (irGetDataSize( l->dtype ) <> FB.POINTERSIZE) ) then
				n->l = astNewCONV( INVALID, IR.DATATYPE.INTEGER, l )
			end if

        end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		astOptConstIDX( l )
	end if

	r = n->r
	if( r <> NULL ) then
		astOptConstIDX( r )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' arithmetic association optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astOptAssocADD( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r
	static as integer op, rop

	if( n = NULL ) then
		exit sub
	end if

    '' convert a+(b+c) to a+b+c and a-(b-c) to a-b+c
	if( n->class = AST.NODECLASS.BOP ) then
		op = n->op
		if( op = IR.OP.ADD or op = IR.OP.SUB ) then
			if( irGetDataClass( n->dtype ) <> IR.DATACLASS.STRING ) then
				r = n->r
				if( r->class = AST.NODECLASS.BOP ) then
					rop = r->op
					if( rop = IR.OP.ADD or rop = IR.OP.SUB ) then
						n->r = r->r
						r->r = r->l
						r->l = n->l
						n->l = r

						if( op = IR.OP.SUB ) then
							if( rop = IR.OP.SUB ) then
								op = IR.OP.ADD
							else
								rop = IR.OP.SUB
							end if
						else
							if( rop = IR.OP.SUB ) then
								op = IR.OP.SUB
								rop = IR.OP.ADD
							end if
						end if
						n->op = op
						r->op = rop

						astOptAssocADD( n )
						exit sub
					end if
				end if
			end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		astOptAssocADD( l )
	end if

	r = n->r
	if( r <> NULL ) then
		astOptAssocADD( r )
	end if

end sub

'':::::
sub astOptAssocMUL( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r

	if( n = NULL ) then
		exit sub
	end if

	'' convert a*(b*c) to a*b*c
	if( n->class = AST.NODECLASS.BOP ) then
		if( n->op = IR.OP.MUL ) then
			r = n->r
			if( r->class = AST.NODECLASS.BOP ) then
				if( r->op = IR.OP.MUL ) then
					n->r = r->r
					r->r = r->l
					r->l = n->l
					n->l = r
					astOptAssocMUL( n )
					Exit Sub
				end if
			end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		astOptAssocMUL( l )
	end if

	r = n->r
	if( r <> NULL ) then
		astOptAssocMUL( r )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' other optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astOptToShift( byval n as ASTNODE ptr )
	static as ASTNODE ptr l, r
	static as integer v, op

	if( n = NULL ) then
		exit sub
	end if

	'' convert 'a * pow2 imm'   to 'a SHL pow2',
	''         'a \ pow2 imm'   to 'a SHR pow2' and
	''         'a MOD pow2 imm' to 'a AND pow2-1'
	if( n->class = AST.NODECLASS.BOP ) then
		op = n->op
		select case op
		case IR.OP.MUL, IR.OP.INTDIV, IR.OP.MOD
			r = n->r
			if( r->defined ) then
				if( irGetDataClass( n->dtype ) = IR.DATACLASS.INTEGER ) then
					if( irGetDataSize( r->dtype ) <= FB.INTEGERSIZE ) then
						v = r->v.valuei
						if( v > 0 ) then
							v = hToPow2( v )
							if( v > 0 ) then
								select case op
								case IR.OP.MUL
									if( v <= 32 ) then
										n->op = IR.OP.SHL
										r->v.valuei = v
									end if
								case IR.OP.INTDIV
									if( v <= 32 ) then
										n->op = IR.OP.SHR
										r->v.valuei = v
									end if
								case IR.OP.MOD
									n->op = IR.OP.AND
									r->v.valuei -= 1
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
		astOptToShift( l )
	end if

	r = n->r
	if( r <> NULL ) then
		astOptToShift( r )
	end if

end sub

''::::
function astOptNullOp( byval n as ASTNODE ptr ) as ASTNODE ptr static
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
	if( n->class = AST.NODECLASS.BOP ) then
		op = n->op
		l = n->l
		r = n->r
		if( r->defined ) then
			if( irGetDataClass( n->dtype ) = IR.DATACLASS.INTEGER ) then
				if( irGetDataSize( r->dtype ) <= FB.INTEGERSIZE ) then
					v = r->v.valuei
					select case as const op
					case IR.OP.MUL
						if( v = 0 ) then
							astDelTree( l )
							astDel( n )
							return r
						elseif( v = 1 ) then
							astDel( r )
							astDel( n )
							return astOptNullOp( l )
						end if

					case IR.OP.MOD
						if( v = 1 ) then
							r->v.valuei = 0
							astDelTree( l )
							astDel( n )
							return r
						end if

					case IR.OP.INTDIV
						if( v = 1 ) then
							astDel( r )
							astDel( n )
							return astOptNullOp( l )
						end if

					case IR.OP.ADD, IR.OP.SUB, IR.OP.SHR, IR.OP.SHL, IR.OP.OR, IR.OP.XOR
						if( v = 0 ) then
							astDel( r )
							astDel( n )
							return astOptNullOp( l )
						end if

					case IR.OP.AND
						if( v = -1 ) then
							astDel( r )
							astDel( n )
							return astOptNullOp( l )
						end if
					end select
				end if
		 	end if
		end if
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = astOptNullOp( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = astOptNullOp( r )
	end if

	function = n

end function

'':::::
function astOptStrMultConcat( byval lnk as ASTNODE ptr, _
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
		if( n->l->class = AST.NODECLASS.BOP ) then
			lnk = astOptStrMultConcat( lnk, dst, n->l )
			n->l = NULL
		end if
	end if

    '' concat?
    if( n->class = AST.NODECLASS.BOP ) then
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
function astIsSymbolOnTree( byval sym as FBSYMBOL ptr, _
							byval n as ASTNODE ptr ) as integer

	dim as FBSYMBOL ptr s

	if( n = NULL ) then
		return FALSE
	end if

	select case as const n->class
	case AST.NODECLASS.VAR, AST.NODECLASS.IDX, _
		 AST.NODECLASS.ADDR, AST.NODECLASS.OFFSET

		s = astGetSymbol( n )

		'' same symbol?
		if( s = sym ) then
			return TRUE
		end if

		'' passed by ref or by desc? can't do any assumption..
		if( s <> NULL ) then
			if( (s->alloctype and _
				(FB.ALLOCTYPE.ARGUMENTBYDESC or FB.ALLOCTYPE.ARGUMENTBYREF)) > 0 ) then
				return TRUE
			end if
		end if

	'' pointer? could be pointing to source symbol too..
	case AST.NODECLASS.PTR
		return TRUE
	end select

	'' walk
	if( n->l <> NULL ) then
		if( astIsSymbolOnTree( sym, n->l ) ) then
			return TRUE
		end if
	end if

	if( n->r <> NULL ) then
		if( astIsSymbolOnTree( sym, n->r ) ) then
			return TRUE
		end if
	end if

	function = FALSE

end function

''::::
private function hIsMultStrConcat( byval l as ASTNODE ptr, _
								   byval r as ASTNODE ptr ) as integer

	dim as FBSYMBOL ptr sym

	function = FALSE

	if( r->class = AST.NODECLASS.BOP ) then
		select case l->class
		case AST.NODECLASS.VAR, AST.NODECLASS.IDX
			sym = astGetSymbol( l )
			if( sym <> NULL ) then
				if( (sym->alloctype and _
					(FB.ALLOCTYPE.ARGUMENTBYDESC or FB.ALLOCTYPE.ARGUMENTBYREF)) = 0 ) then

					if( not astIsSymbolOnTree( sym, r ) ) then
						function = TRUE
					end if

				end if
			end if
		end select
	end if

end function

''::::
function astOptStrAssignament( byval n as ASTNODE ptr, _
							   byval l as ASTNODE ptr, _
							   byval r as ASTNODE ptr ) as ASTNODE ptr static

	dim as integer optimize

	optimize = FALSE

	'' is right side a bin operation?
	if( r->class = AST.NODECLASS.BOP ) then
		'' is left side a var?
		select case l->class
		case AST.NODECLASS.VAR, AST.NODECLASS.PTR, AST.NODECLASS.IDX
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
			function = astOptStrMultConcat( l, l, r )

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

			function = astOptStrMultConcat( NULL, l, r )

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
	if( n->class <> AST.NODECLASS.ASSIGN ) then
		exit function
	end if

	l = n->l
	r = n->r

	dtype = n->dtype
	dclass = irGetDataClass( dtype )

	'' integer's only, no way to optimize with a FPU stack (x86 assumption)
	if( dclass <> IR.DATACLASS.INTEGER ) then

		'' strings?
		if( dclass = IR.DATACLASS.STRING ) then
			return astOptStrAssignament( n, l, r )
		end if

		'' try to optimize if a constant is being assigned to a float var
  		if( r->class = AST.NODECLASS.CONST ) then
  			if( dclass = IR.DATACLASS.FPOINT ) then
				r->dtype = dtype
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
	case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
	case else
		exit function
	end select

	'' is right side a bin or unary operation?
	select case r->class
	case AST.NODECLASS.UOP, AST.NODECLASS.BOP
	case else
		exit function
	end select

	'' can't be a relative op -- unless EMIT is changed to not assume the res operand is a register
	select case as const r->op
	case IR.OP.EQ, IR.OP.GT, IR.OP.LT, IR.OP.NE, IR.OP.LE, IR.OP.GE
		exit function
	end select

	'' node result is an integer too?
	if( irGetDataClass( r->dtype ) <> IR.DATACLASS.INTEGER ) then
		exit function
	end if

	'' is the left child the same?
	if( not astIsTreeEqual( l, r->l ) ) then
		exit function
	end if

	'' isn't it a bitfield?
	if( l->chkbitfld ) then
		s = astGetUDTElm( l )
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

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' node type update
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astUpdStrConcat( byval n as ASTNODE ptr ) as ASTNODE ptr
	static as ASTNODE ptr l, r

	function = n

	if( n = NULL ) then
		exit function
	end if

	if( irGetDataClass( n->dtype ) <> IR.DATACLASS.STRING ) then
		'' this proc will be called for each function param, same
		'' with assignament -- assuming here that IIF won't
		'' support strings
		exit function
	end if

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = astUpdStrConcat( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = astUpdStrConcat( r )
	end if

	'' convert "string + string" to "StrConcat( string, string )"
	if( n->class = AST.NODECLASS.BOP ) then
		if( n->op = IR.OP.ADD ) then
			l = n->l
			r = n->r
			function = rtlStrConcat( l, l->dtype, r, r->dtype )
			astDel( n )
		end if
	end if

end function

'':::::
function astUpdComp2Branch( byval n as ASTNODE ptr, _
							byval label as FBSYMBOL ptr, _
							byval isinverse as integer ) as ASTNODE ptr
	dim as integer op
	dim as ASTNODE ptr l, expr
	static as integer dtype, istrue

	if( n = NULL ) then
		return NULL
	end if

	dtype = n->dtype

	'' string? invalid..
	if( irGetDataClass( dtype ) = IR.DATACLASS.STRING ) then
		return NULL
	end if

	'' UDT? ditto..
	if( dtype = IR.DATATYPE.USERDEF ) then
		return NULL
	end if

	'' shortcut "exp logop exp" if it's at top of tree (used to optimize IF/ELSEIF/WHILE/UNTIL)
	if( n->class <> AST.NODECLASS.BOP ) then
		'' UOP? check if it's a NOT
		if( n->class = AST.NODECLASS.UOP ) then
			if( n->op = IR.OP.NOT ) then
				l = astUpdComp2Branch( n->l, label, isinverse = FALSE )
				astDel( n )
				return l
			end if
		end if

		'' CONST?
		if( n->class = AST.NODECLASS.CONST ) then
			if( not isinverse ) then
				'' branch if false
				select case as const dtype
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					istrue = n->v.value64 = 0
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
					istrue = n->v.valuef = 0
				case else
					istrue = n->v.valuei = 0
				end select

				if( istrue ) then
					astDel( n )
					n = astNewBRANCH( IR.OP.JMP, label, NULL )
					if( n = NULL ) then
						return NULL
					end if
				end if
			else
				'' branch if true
				select case as const dtype
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					istrue = n->v.value64 <> 0
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
					istrue = n->v.valuef <> 0
				case else
					istrue = n->v.valuei <> 0
				end select

				if( istrue ) then
					astDel( n )
					n = astNewBRANCH( IR.OP.JMP, label, NULL )
					if( n = NULL ) then
						return NULL
					end if
				end if
			end if

		else
			'' otherwise, check if zero (ie= FALSE)
			if( not isinverse ) then
				op = IR.OP.EQ
			else
				op = IR.OP.NE
			end if

			'' zstring? astNewBOP will think both are zstrings..
			if( dtype = IR.DATATYPE.CHAR ) then
				dtype = IR.DATATYPE.INTEGER
			end if

			select case as const dtype
			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
				expr = astNewCONST64( 0, dtype )
			case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
				expr = astNewCONSTf( 0.0, dtype )
			case else
				expr = astNewCONSTi( 0, dtype )
			end select

			n = astNewBOP( op, n, expr, label, FALSE )

			if( n = NULL ) then
				return NULL
			end if
		end if

		'' exit
		return n
	end if

	''
	op 	  = n->op

	'' logical operator?
	select case as const op
	case IR.OP.EQ, IR.OP.NE, IR.OP.GT, IR.OP.LT, IR.OP.GE, IR.OP.LE

		'' invert it
		if( not isinverse ) then
			n->op = irGetInverseLogOp( op )
		end if

		'' tell IR that the destine label is already set
		n->ex = label

		return n

	'' binary op that sets the flags? (x86 opt, may work on some RISC cpu's)
	case IR.OP.ADD, IR.OP.SUB, IR.OP.SHL, IR.OP.SHR, _
		 IR.OP.AND, IR.OP.OR, IR.OP.XOR, IR.OP.IMP
		 ', IR.OP.EQV -- NOT doesn't set any flags, so EQV can't be optimized (x86 assumption)

		'' x86-quirk: only if integers, as FPU will set its own flags, that must copied back
		if( irGetDataClass( dtype ) = IR.DATACLASS.INTEGER ) then
            '' can't be done with longints either, as flag is set twice
            if( (dtype <> IR.DATATYPE.LONGINT) and (dtype <> IR.DATATYPE.ULONGINT) ) then

				'' check if zero (ie= FALSE)
				if( not isinverse ) then
					op = IR.OP.JEQ
				else
					op = IR.OP.JNE
				end if

				return astNewBRANCH( op, label, n )
			end if
		end if

	end select

	'' if no optimization could be done, check if zero (ie= FALSE)
	if( not isinverse ) then
		op = IR.OP.EQ
	else
		op = IR.OP.NE
	end if

	select case as const dtype
	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		expr = astNewCONST64( 0, dtype )
	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
		expr = astNewCONSTf( 0.0, dtype )
	case else
		expr = astNewCONSTi( 0, dtype )
	end select

	function = astNewBOP( op, n, expr, label, FALSE )

end function

#if 0
'':::::
sub astDump ( byval p as ASTNODE ptr, _
			  byval n as ASTNODE ptr, _
			  byval isleft as integer, _
			  byval ln as integer, _
			  byval cn as integer )

   dim as string v
   dim as integer c

	v = ""
	select case n->class
	case AST.NODECLASS.BOP
		select case n->op
		case IR.OP.ADD
			v = "+"
		case IR.OP.SUB
			v = "-"
		case IR.OP.MUL
			v = "*"
		case IR.OP.DIV
			v = "/"
		case IR.OP.INTDIV
			v = "\\"
		case IR.OP.AND
			v = "&"
		case IR.OP.OR
			v = "|"
		case IR.OP.XOR
			v = "^"
		case IR.OP.SHL
			v = "<"
		case IR.OP.SHR
			v = ">"
		end select
		v = "(" + v + ")"

	case AST.NODECLASS.UOP
		select case n->op
		case IR.OP.NEG
			v = "-"
		case IR.OP.NOT
			v = "!"
		end select
		v = "(" + v + ")"

	case AST.NODECLASS.VAR
		v = "[" + mid$( symbGetName( n->var.sym ), 2 ) + "]"
	case AST.NODECLASS.CONST
		v = "<" + str$( n->v.valuei ) + ">"
	case AST.NODECLASS.CONV
		v = "{" + str$( n->dtype ) + "}"
'	case AST.NODECLASS.IDX
'		c = n->idx.sym
'		v = "{" + rtrim$( mid$( symbGetVarName( c->idx.sym ), 2 ) ) + "}"

'	case AST.NODECLASS.FUNCT
'		v = rtrim$( mid$( symbGetProcName( n->proc.s ), 2 ) ) + "()"

'	case AST.NODECLASS.PARAM
'		v = "(" + ltrim$( str$( n->l ) ) + ")"
	end select

	if( len( v ) > 0 and ln <= 50 ) then

		'v = str$( n ) + v
		if( p <> NULL ) then
        	if( isleft ) then
        		v = v + "/"
        	else
        		v = "\\" + v
        	end if
		end if

		c = cn - (len(v)\2)
		if( c > 1 and c + len(v)\2 <= 80 ) then
			locate ln, c
			print v;
		end if
	end if

	if( n->l <> NULL ) then
		astDump( n, n->l, TRUE, ln+2, cn-4 )
	end if

	if( n->r <> NULL ) then
		astDump( n, n->r, FALSE, ln+2, cn+4 )
	end if

end sub
#endif

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree cloning and deletion
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astCopy( byval d as ASTNODE ptr, _
			 byval s as ASTNODE ptr ) static

	dim as ASTNODE ptr p, n

	p = d->prv
	n = d->nxt

	*d = *s

	d->prv = p
	d->nxt = n

end sub

'':::::
sub astSwap( byval d as ASTNODE ptr, _
			 byval s as ASTNODE ptr ) static

	dim as ASTNODE ptr dp, dn
	dim as ASTNODE ptr sp, sn

	dp = d->prv
	dn = d->nxt
	sp = s->prv
	sn = s->nxt

	swap *d, *s

	d->prv = dp
	d->nxt = dn
	s->prv = sp
	s->nxt = sn

end sub

'':::::
function astCloneTree( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr nn, p

	''
	if( n = NULL ) then
		return NULL
	end if

	''
	nn = astNew( INVALID, INVALID )
	astCopy( nn, n )

	'' walk
	p = n->l
	if( p <> NULL ) then
		nn->l = astCloneTree( p )
	end if

	p = n->r
	if( p <> NULL ) then
		nn->r = astCloneTree( p )
	end if

	'' special nodes
	select case n->class
	'' IIF has a 3rd tree node..
	case AST.NODECLASS.IIF
		p = n->iif.cond
		if( p <> NULL ) then
			nn->iif.cond = astCloneTree( p )
		end if

	'' Profiled function have sub nodes
	case AST.NODECLASS.FUNCT
		p = n->proc.profstart
		if( p <> NULL ) then
			nn->proc.profstart = astCloneTree( p )
			nn->proc.profend = astCloneTree( n->proc.profend )
		end if
	end select

	function = nn

end function

'':::::
sub astDelTree ( byval n as ASTNODE ptr )
	dim as ASTNODE ptr p

	''
	if( n = NULL ) then
		exit sub
	end if

	'' walk
	p = n->l
	if( p <> NULL ) then
		astDelTree( p )
	end if

	p = n->r
	if( p <> NULL ) then
		astDelTree( p )
	end if

	'' special nodes
	select case n->class
	'' IIF has a 3rd tree node..
	case AST.NODECLASS.IIF
		p = n->iif.cond
		if( p <> NULL ) then
			astDelTree( p )
		end if

	'' Profiled functions have sub nodes
	case AST.NODECLASS.FUNCT
		p = n->proc.profstart
		if( p <> NULL ) then
			astDelTree( p )
			astDelTree( n->proc.profend )
		end if
	end select

	''
	astDel( n )

End Sub

''::::
function astIsTreeEqual( byval l as ASTNODE ptr, _
						 byval r as ASTNODE ptr ) as integer

    function = FALSE

    if( (l = NULL) or (r = NULL) ) then
    	if( l = r ) then
    		function = TRUE
    	end if
    	exit function
    end if

	if( l->class <> r->class ) then
		exit function
	end if

	if( l->dtype <> r->dtype ) then
		exit function
	end if

	if( l->subtype <> r->subtype ) then
		exit function
	end if

	select case as const l->class
	case AST.NODECLASS.VAR
		if( l->var.sym <> r->var.sym ) then
			exit function
		end if

		if( l->var.elm <> r->var.elm ) then
			exit function
		end if

		if( l->var.ofs <> r->var.ofs ) then
			exit function
		end if

	case AST.NODECLASS.CONST
const DBL_EPSILON# = 2.2204460492503131e-016

		select case as const l->dtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			if( l->v.value64 <> r->v.value64 ) then
				exit function
			end if
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			if( abs( l->v.valuef - r->v.valuef ) > DBL_EPSILON ) then
				exit function
			end if
		case else
			if( l->v.valuei <> r->v.valuei ) then
				exit function
			end if
		end select

	case AST.NODECLASS.PTR
		if( l->ptr.sym <> r->ptr.sym ) then
			exit function
		end if

		if( l->ptr.elm <> r->ptr.elm ) then
			exit function
		end if

		if( l->ptr.ofs <> r->ptr.ofs ) then
			exit function
		end if

	case AST.NODECLASS.IDX
		if( l->idx.ofs <> r->idx.ofs ) then
			exit function
		end if

		if( l->idx.mult <> r->idx.mult ) then
			exit function
		end if

	case AST.NODECLASS.BOP
		if( l->op <> r->op ) then
			exit function
		end if

		if( l->allocres <> r->allocres ) then
			exit function
		end if

		if( l->ex <> r->ex ) then
			exit function
		end if

	case AST.NODECLASS.UOP
		if( l->op <> r->op ) then
			exit function
		end if

		if( l->allocres <> r->allocres ) then
			exit function
		end if

	case AST.NODECLASS.ADDR, AST.NODECLASS.OFFSET
		if( l->addr.sym <> r->addr.sym ) then
			exit function
		end if

		if( l->addr.elm <> r->addr.elm ) then
			exit function
		end if

		if( l->op <> r->op ) then
			exit function
		end if

	case AST.NODECLASS.IIF
		if( not astIsTreeEqual( l->iif.cond, r->iif.cond ) ) then
			exit function
		end if

	case AST.NODECLASS.CONV
		'' do nothing, the l child will be checked below

	case AST.NODECLASS.FUNCT, AST.NODECLASS.BRANCH, _
		 AST.NODECLASS.LOAD, AST.NODECLASS.ASSIGN, _
		 AST.NODECLASS.LINK
		'' unpredictable nodes
		exit function

	end select

    '' check childs
	if( not astIsTreeEqual( l->l, r->l ) ) then
		exit function
	end if

	if( not astIsTreeEqual( l->r, r->r ) ) then
		exit function
	end if

    ''
	function = TRUE

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree routines
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub astInitTempLists

	listNew( @ctx.tempstr, AST.INITTEMPSTRINGS, len( ASTTEMPSTR ), FALSE )

	listNew( @ctx.temparray, AST.INITTEMPARRAYS, len( ASTTEMPARRAY ), FALSE )

end sub

'':::::
private sub astEndTempLists

	listFree( @ctx.temparray )

	listFree( @ctx.tempstr )

end sub

'':::::
sub astInit static

	''
    listNew( @ctx.astTB, AST.INITNODES, len( ASTNODE ), FALSE )

    ''
    astInitTempLists( )

end sub

'':::::
sub astEnd static

	''
	astEndTempLists( )

	''
	listFree( @ctx.astTB )

end sub

'':::::
function astNew( byval class as integer, _
				 byval dtype as integer, _
				 byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr static

	dim as ASTNODE ptr n

	n = listNewNode( @ctx.astTB )

	''
	n->class 		= class
	n->dtype 		= dtype
	n->subtype		= subtype
	n->defined		= FALSE
	n->op			= INVALID
	n->l    		= NULL
	n->r    		= NULL
	n->chkbitfld	= FALSE

	function = n

end function

'':::::
sub astDel( byval n as ASTNODE ptr ) static

	if( n = NULL ) then
		exit sub
	end if

	listDelNode( @ctx.astTB, n )

end sub

'':::::
function astIsADDR( byval n as ASTNODE ptr ) as integer static

	select case n->class
	case AST.NODECLASS.ADDR, AST.NODECLASS.OFFSET
		return TRUE
	case else
		return FALSE
	end select

end function

'':::::
function astGetSymbol( byval n as ASTNODE ptr ) as FBSYMBOL ptr static
    dim s as FBSYMBOL ptr

	s = NULL

	if( n <> NULL ) then
		select case as const n->class
		case AST.NODECLASS.PTR
			s = n->ptr.elm
			if( s = NULL ) then
				s = n->ptr.sym
			end if

		case AST.NODECLASS.VAR
			s = n->var.elm
			if( s = NULL ) then
				s = n->var.sym
			end if

		case AST.NODECLASS.IDX
			n = n->r
			if( n <> NULL ) then
				s = n->var.elm
				if( s = NULL ) then
					s = n->var.sym
				end if
			end if

		case AST.NODECLASS.FUNCT
			s = n->proc.sym

		case AST.NODECLASS.ADDR, AST.NODECLASS.OFFSET
			s = n->addr.elm
			if( s = NULL ) then
				s = n->addr.sym
			end if
		end select
	end if

	function = s

end function

'':::::
private function astGetUDTElm( byval n as ASTNODE ptr ) as FBSYMBOL ptr static

	if( n <> NULL ) then
		select case as const n->class
		case AST.NODECLASS.PTR
			return n->ptr.elm

		case AST.NODECLASS.VAR
			return n->var.elm

		case AST.NODECLASS.IDX
			n = n->r
			if( n <> NULL ) then
				return n->var.elm
			end if

		case AST.NODECLASS.ADDR, AST.NODECLASS.OFFSET
			return n->addr.elm
		end select
	end if

	function = NULL

end function

'':::::
sub astConvertValue( byval n as ASTNODE ptr, _
					 byval v as FBVALUE ptr, _
					 byval todtype as integer ) static

	select case as const n->dtype
	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		select case as const todtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			v->value64 = n->v.value64
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			v->valuef  = n->v.value64
		case else
			v->valuei  = n->v.value64
		end select

	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
		select case as const todtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			v->value64 = n->v.valuef
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			v->valuef  = n->v.valuef
		case else
			v->valuei  = n->v.valuef
		end select

	case else
		select case as const todtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			v->value64 = n->v.valuei
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			v->valuef  = n->v.valuei
		case else
			v->valuei  = n->v.valuei
		end select
	end select

end sub

''::::
function astLoad( byval n as ASTNODE ptr ) as IRVREG ptr

	if( n = NULL ) then
		return NULL
	end if

	select case as const n->class
	case AST.NODECLASS.LINK
		return astLoadLINK( n )

	case AST.NODECLASS.ASSIGN
		return astLoadASSIGN( n )

	case AST.NODECLASS.CONV
		return astLoadCONV( n )

	case AST.NODECLASS.CONST
		return astLoadCONST( n )

	case AST.NODECLASS.VAR
		return astLoadVAR( n )

	case AST.NODECLASS.BOP
		return astLoadBOP( n )

	case AST.NODECLASS.UOP
		return astLoadUOP( n )

	case AST.NODECLASS.IDX
		return astLoadIDX( n )

	case AST.NODECLASS.FUNCT
		return astLoadFUNCT( n )

	case AST.NODECLASS.PTR
		return astLoadPTR( n )

	case AST.NODECLASS.ADDR
		return astLoadADDR( n )

	case AST.NODECLASS.OFFSET
		return astLoadOFFSET( n )

	case AST.NODECLASS.LOAD
		return astLoadLOAD( n )

	case AST.NODECLASS.BRANCH
		return astLoadBRANCH( n )

    case AST.NODECLASS.IIF
    	return astLoadIIF( n )
    end select

end function

''::::
private function astOptimize( byval n as ASTNODE ptr ) as integer

	'' calls must be done in the order below

	astOptAssocADD( n )

	astOptAssocMUL( n )

	n = astOptConstDistMUL( n )

	n = astOptConstAccum1( n )

	astOptConstAccum2( n )

	astOptConstRmNeg( n, NULL )

	astOptConstIDX( n )

	astOptToShift( n )

	n = astOptNullOp( n )

	function = n

end function

''::::
function astFlush( byval n as ASTNODE ptr ) as IRVREG ptr

	''
	if( n = NULL ) then
		return NULL
	end if

	''
	n = astOptimize( n )

	n = astOptAssignament( n )					'' needed even when not optimizing

	n = astUpdStrConcat( n )

    ''
	function = astLoad( n )

	astDel( n )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' link nodes (l = curr node; r = next link)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLINK( byval l as ASTNODE ptr, _
					 byval r as ASTNODE ptr ) as ASTNODE ptr static

	dim as ASTNODE ptr n

	''
	n = astNew( AST.NODECLASS.LINK, l->dtype )
	if( n = NULL ) then
		return NULL
	end if

	''
	n->l = l
	n->r = r

	function = n

end function

'':::::
function astLoadLINK( byval n as ASTNODE ptr ) as IRVREG ptr

	if( n = NULL ) then
		return NULL
	end if

	function = astLoad( n->l )
	astDel( n->l )

	astLoad( n->r )
	astDel( n->r )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' binary operations (l = left operand expression ; r = right operand expression)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hStrLiteralConcat( byval l as ASTNODE ptr, _
									byval r as ASTNODE ptr ) as ASTNODE ptr
    dim as FBSYMBOL ptr s, ls, rs

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	'' new len = both strings' len less the 2 null-chars
	s = hAllocStringConst( symbGetVarText( ls ) + symbGetVarText( rs ), _
						   symbGetLen( ls ) - 1 + symbGetLen( rs ) - 1 )

	function = astNewVAR( s, NULL, 0, IR.DATATYPE.FIXSTR )

	'' delete both vars if they were never accessed before
	if( symbGetAccessCnt( ls ) = 0 ) then
		symbDelVar( ls )
	end if

	if( symbGetAccessCnt( rs ) = 0 ) then
		symbDelVar( rs )
	end if

	astDel( r )
	astDel( l )

end function

'':::::
private sub hBOPConstFoldInt( byval op as integer, _
							  byval l as ASTNODE ptr, _
							  byval r as ASTNODE ptr ) static

	dim as integer issigned

	select case as const l->dtype
	case IR.DATATYPE.UBYTE, IR.DATATYPE.USHORT, IR.DATATYPE.UINT
		issigned = FALSE
	case else
		issigned = TRUE
	end select

	select case as const op
	case IR.OP.ADD
		l->v.valuei = l->v.valuei + r->v.valuei

	case IR.OP.SUB
		l->v.valuei = l->v.valuei - r->v.valuei

	case IR.OP.MUL
		if( issigned ) then
			l->v.valuei = l->v.valuei * r->v.valuei
		else
			l->v.valuei = cunsg(l->v.valuei) * cunsg(r->v.valuei)
		end if

	case IR.OP.INTDIV
		if( issigned ) then
			l->v.valuei = l->v.valuei \ r->v.valuei
		else
			l->v.valuei = cunsg( l->v.valuei ) \ cunsg( r->v.valuei )
		end if

	case IR.OP.MOD
		if( issigned ) then
			l->v.valuei = l->v.valuei mod r->v.valuei
		else
			l->v.valuei = cunsg( l->v.valuei ) mod cunsg( r->v.valuei )
		end if

	case IR.OP.SHL
		if( issigned ) then
			l->v.valuei = l->v.valuei shl r->v.valuei
		else
			l->v.valuei = cunsg( l->v.valuei ) shl r->v.valuei
		end if

	case IR.OP.SHR
		if( issigned ) then
			l->v.valuei = l->v.valuei shr r->v.valuei
		else
			l->v.valuei = cunsg( l->v.valuei ) shr r->v.valuei
		end if

	case IR.OP.AND
		l->v.valuei = l->v.valuei and r->v.valuei

	case IR.OP.OR
		l->v.valuei = l->v.valuei or r->v.valuei

	case IR.OP.XOR
		l->v.valuei = l->v.valuei xor r->v.valuei

	case IR.OP.EQV
		l->v.valuei = l->v.valuei eqv r->v.valuei

	case IR.OP.IMP
		l->v.valuei = l->v.valuei imp r->v.valuei

	case IR.OP.NE
		l->v.valuei = l->v.valuei <> r->v.valuei

	case IR.OP.EQ
		l->v.valuei = l->v.valuei = r->v.valuei

	case IR.OP.GT
		if( issigned ) then
			l->v.valuei = l->v.valuei > r->v.valuei
		else
			l->v.valuei = cunsg( l->v.valuei ) > cunsg( r->v.valuei )
		end if

	case IR.OP.LT
		if( issigned ) then
			l->v.valuei = l->v.valuei < r->v.valuei
		else
			l->v.valuei = cunsg( l->v.valuei ) < cunsg( r->v.valuei )
		end if

	case IR.OP.LE
		if( issigned ) then
			l->v.valuei = l->v.valuei <= r->v.valuei
		else
			l->v.valuei = cunsg( l->v.valuei ) <= cunsg( r->v.valuei )
		end if

	case IR.OP.GE
		if( issigned ) then
			l->v.valuei = l->v.valuei >= r->v.valuei
		else
			l->v.valuei = cunsg( l->v.valuei ) >= cunsg( r->v.valuei )
		end if
	end select

end sub

'':::::
private sub hBOPConstFoldFlt( byval op as integer, _
						      byval l as ASTNODE ptr, _
						      byval r as ASTNODE ptr ) static

	select case as const op
	case IR.OP.ADD
		l->v.valuef = l->v.valuef + r->v.valuef

	case IR.OP.SUB
		l->v.valuef = l->v.valuef - r->v.valuef

	case IR.OP.MUL
		l->v.valuef = l->v.valuef * r->v.valuef

	case IR.OP.DIV
		l->v.valuef = l->v.valuef / r->v.valuef

    case IR.OP.POW
		l->v.valuef = l->v.valuef ^ r->v.valuef

	case IR.OP.NE
		l->v.valuei = l->v.valuef <> r->v.valuef

	case IR.OP.EQ
		l->v.valuei = l->v.valuef = r->v.valuef

	case IR.OP.GT
		l->v.valuei = l->v.valuef > r->v.valuef

	case IR.OP.LT
		l->v.valuei = l->v.valuef < r->v.valuef

	case IR.OP.LE
		l->v.valuei = l->v.valuef <= r->v.valuef

	case IR.OP.GE
		l->v.valuei = l->v.valuef >= r->v.valuef

    case IR.OP.ATAN2
		l->v.valuef = atan2( l->v.valuef, r->v.valuef )
	end select

end sub

'':::::
private sub hBOPConstFold64( byval op as integer, _
							 byval l as ASTNODE ptr, _
							 byval r as ASTNODE ptr ) static

	dim as integer issigned

	issigned = (l->dtype = IR.DATATYPE.LONGINT)

	select case as const op
	case IR.OP.ADD
		l->v.value64 = l->v.value64 + r->v.value64

	case IR.OP.SUB
		l->v.value64 = l->v.value64 - r->v.value64

	case IR.OP.MUL
		if( issigned ) then
			l->v.value64 = l->v.value64 * r->v.value64
		else
			l->v.value64 = cunsg(l->v.value64) * cunsg(r->v.value64)
		end if

	case IR.OP.INTDIV
		if( issigned ) then
			l->v.value64 = l->v.value64 \ r->v.value64
		else
			l->v.value64 = cunsg( l->v.value64 ) \ cunsg( r->v.value64 )
		end if

	case IR.OP.MOD
		if( issigned ) then
			l->v.value64 = l->v.value64 mod r->v.value64
		else
			l->v.value64 = cunsg( l->v.value64 ) mod cunsg( r->v.value64 )
		end if

	case IR.OP.SHL
		if( issigned ) then
			l->v.value64 = l->v.value64 shl r->v.valuei
		else
			l->v.value64 = cunsg( l->v.value64 ) shl r->v.valuei
		end if

	case IR.OP.SHR
		if( issigned ) then
			l->v.value64 = l->v.value64 shr r->v.valuei
		else
			l->v.value64 = cunsg( l->v.value64 ) shr r->v.valuei
		end if

	case IR.OP.AND
		l->v.value64 = l->v.value64 and r->v.value64

	case IR.OP.OR
		l->v.value64 = l->v.value64 or r->v.value64

	case IR.OP.XOR
		l->v.value64 = l->v.value64 xor r->v.value64

	case IR.OP.EQV
		l->v.value64 = l->v.value64 eqv r->v.value64

	case IR.OP.IMP
		l->v.value64 = l->v.value64 imp r->v.value64

	case IR.OP.NE
		l->v.valuei = l->v.value64 <> r->v.value64

	case IR.OP.EQ
		l->v.valuei = l->v.value64 = r->v.value64

	case IR.OP.GT
		if( issigned ) then
			l->v.valuei = l->v.value64 > r->v.value64
		else
			l->v.valuei = cunsg( l->v.value64 ) > cunsg( r->v.value64 )
		end if

	case IR.OP.LT
		if( issigned ) then
			l->v.valuei = l->v.value64 < r->v.value64
		else
			l->v.valuei = cunsg( l->v.value64 ) < cunsg( r->v.value64 )
		end if

	case IR.OP.LE
		if( issigned ) then
			l->v.valuei = l->v.value64 <= r->v.value64
		else
			l->v.valuei = cunsg( l->v.value64 ) <= cunsg( r->v.value64 )
		end if

	case IR.OP.GE
		if( issigned ) then
			l->v.valuei = l->v.value64 >= r->v.value64
		else
			l->v.valuei = cunsg( l->v.value64 ) >= cunsg( r->v.value64 )
		end if
	end select

end sub

'':::::
function astNewBOP( byval op as integer, _
					byval l as ASTNODE ptr, _
					r as ASTNODE ptr, _
					byval ex as FBSYMBOL ptr = NULL, _
					byval allocres as integer = TRUE ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer dt1, dt2, dtype
    dim as integer dc1, dc2
    dim as integer doconv
    dim as FBSYMBOL ptr s

	function = NULL

	if( (l = NULL) or (r = NULL) ) then
		exit function
	end if

	dt1 = l->dtype
	dt2 = r->dtype
	dc1 = irGetDataClass( dt1 )
	dc2 = irGetDataClass( dt2 )

	'' UDT's? can't operate
	if( (dt1 = IR.DATATYPE.USERDEF) or (dt2 = IR.DATATYPE.USERDEF) ) then
		exit function
    end if

	''::::::

	'' longints?
	if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) or _
		(dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then

		'' same type?
		if( dt1 = dt2 ) then
			dtype = dt1
		else
			dtype = irMaxDataType( dt1, dt2 )
			'' one of the operands is a float? it has more precedence..
			if( dtype >= IR.DATATYPE.SINGLE ) then
				dtype = INVALID
			'' just the sign is different?
			elseif( dtype = INVALID ) then
				dtype = dt1
			'' is the left op the longint?
			elseif( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
				dtype = dt1
			'' then it's the right..
			else
				dtype = dt2
			end if
		end if

		if( dtype <> INVALID ) then
			select case op
			case IR.OP.INTDIV
				return rtlMathLongintDIV( dtype, l, dt1, r, dt2 )

			case IR.OP.MOD
				return rtlMathLongintMOD( dtype, l, dt1, r, dt2 )

			end select
		end if
    end if

    ''::::::
    '' zstrings?
    if( (dt1 = IR.DATATYPE.CHAR) or (dt2 = IR.DATATYPE.CHAR) ) then
    	'' same? treat as string..
    	if( dt1 = dt2 ) then
    		dc1 = IR.DATACLASS.STRING
    		dc2 = dc1
    	end if
    end if

    '' strings?
    if( (dc1 = IR.DATACLASS.STRING) or (dc2 = IR.DATACLASS.STRING) ) then

		if( dc1 <> dc2 ) then
			if( dc1 = IR.DATACLASS.STRING ) then
				'' not a zstring?
				if( dt2 <> IR.DATATYPE.CHAR ) then
					exit function
				end if
			else
				'' not a zstring?
				if( dt1 <> IR.DATATYPE.CHAR ) then
					exit function
				end if
			end if
		end if

		select case as const op
		case IR.OP.ADD
			'' check for string literals
			if( (dt1 = IR.DATATYPE.FIXSTR) and (dt2 = IR.DATATYPE.FIXSTR) ) then
				if( l->class = AST.NODECLASS.VAR ) then
					if( r->class = AST.NODECLASS.VAR ) then
						s = astGetSymbol( l )
						if( symbGetVarInitialized( s ) ) then
							s = astGetSymbol( r )
							if( symbGetVarInitialized( s ) ) then
								return hStrLiteralConcat( l, r )
							end if
						end if
					end if
				end if
			end if

			'' result will be always an var-len string
			dt1 = IR.DATATYPE.STRING
			dc1 = IR.DATACLASS.STRING
			dt2 = dt1
			dc2 = dc1

		case IR.OP.EQ, IR.OP.GT, IR.OP.LT, IR.OP.NE, IR.OP.LE, IR.OP.GE
			l = rtlStrCompare( l, dt1, r, dt2 )
			r = astNewCONSTi( 0, IR.DATATYPE.INTEGER )

			dt1 = l->dtype
			dc1 = IR.DATACLASS.INTEGER
			dt2 = r->dtype
			dc2 = IR.DATACLASS.INTEGER

		case else
			exit function
		end select
    end if

    ''::::::

	'' convert byte to int
	if( irGetDataSize( dt1 ) = 1 ) then
		if( irIsSigned( dt1 ) ) then
			dt1 = IR.DATATYPE.INTEGER
		else
			dt1 = IR.DATATYPE.UINT
		end if
		l = astNewCONV( INVALID, dt1, l )
	end if

	if( irGetDataSize( dt2 ) = 1 ) then
		if( irIsSigned( dt2 ) ) then
			dt2 = IR.DATATYPE.INTEGER
		else
			dt2 = IR.DATATYPE.UINT
		end if
		r = astNewCONV( INVALID, dt2, r )
	end if

    '' convert types
	select case as const op
	'' flt div (/) can only operate on floats
	case IR.OP.DIV

		if( dc1 <> IR.DATACLASS.FPOINT ) then
			dt1 = IR.DATATYPE.DOUBLE
			l = astNewCONV( INVALID, dt1, l )
			dc1 = IR.DATACLASS.FPOINT
		end if

		if( dc2 <> IR.DATACLASS.FPOINT ) then
			'' x86 assumption: if it's an int var, let the FPU do it
			if( (r->class = AST.NODECLASS.VAR) and (dt2 = IR.DATATYPE.INTEGER) ) then
				dt2 = IR.DATATYPE.DOUBLE
			else
				dt2 = IR.DATATYPE.DOUBLE
				r = astNewCONV( INVALID, dt2, r )
			end if
			dc2 = IR.DATACLASS.FPOINT
		end if

	'' bitwise ops, int div (\), modulus and shift can only operate on integers
	case IR.OP.AND, IR.OP.OR, IR.OP.XOR, IR.OP.EQV, IR.OP.IMP, _
		 IR.OP.INTDIV, IR.OP.MOD, IR.OP.SHL, IR.OP.SHR

		if( dc1 <> IR.DATACLASS.INTEGER ) then
			dt1 = IR.DATATYPE.INTEGER
			l = astNewCONV( INVALID, dt1, l )
			dc1 = IR.DATACLASS.INTEGER
		end if

		if( dc2 <> IR.DATACLASS.INTEGER ) then
			dt2 = IR.DATATYPE.INTEGER
			r = astNewCONV( INVALID, dt2, r )
			dc2 = IR.DATACLASS.INTEGER
		end if

	'' atan2 can only operate on floats
	case IR.OP.ATAN2, IR.OP.POW

		if( dc1 <> IR.DATACLASS.FPOINT ) then
			dt1 = IR.DATATYPE.DOUBLE
			l = astNewCONV( INVALID, dt1, l )
			dc1 = IR.DATACLASS.FPOINT
		end if

		if( dc2 <> IR.DATACLASS.FPOINT ) then
			dt2 = IR.DATATYPE.DOUBLE
			r = astNewCONV( INVALID, dt2, r )
			dc2 = IR.DATACLASS.FPOINT
		end if

	end select

    '' convert types to the most precise if needed
	if( dt1 <> dt2 ) then

		dtype = irMaxDataType( dt1, dt2 )
		'' don't convert?
		if( dtype = -1 ) then
			'' as type are different, if class is fp,
			'' the result type will be always a double
			if( dc1 = IR.DATACLASS.FPOINT ) then
				dtype = IR.DATATYPE.DOUBLE
			else
				dtype = dt1
			end if

		else
			'' convert the l operand?
			if( dtype <> dt1 ) then
				l = astNewCONV( INVALID, dtype, l )
				dt1 = dtype
				dc1 = dc2

			'' convert the r operand..
			else
				'' if it's the src-operand of a shift operation, do nothing
				if( (op = IR.OP.SHL) or (op = IR.OP.SHR) ) then
					'' it's already an integer
				else
					'' x86 assumption: if it's an short|int var, let the FPU do it
					doconv = TRUE
					if( dc1 = IR.DATACLASS.FPOINT ) then
						if( dc2 = IR.DATACLASS.INTEGER ) then
							'' can't be an longint nor a byte (byte operands are converted above)
							if( irGetDataSize( dt2 ) < FB.INTEGERSIZE*2 ) then
								select case r->class
								case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
									'' can't be unsigned either
									if( irIsSigned( dt2 ) ) then
										doconv = FALSE
									end if
								end select
							end if
						end if
					end if

					if( doconv ) then
						r = astNewCONV( INVALID, dtype, r )
					end if
				end if
				dt2 = dtype
				dc2 = dc1

			end if
		end if

	'' no conversion, type's are the same
	else
		dtype = dt1
	end if

	'' post check
	select case as const op
	'' relative ops, the result is always an integer
	case IR.OP.EQ, IR.OP.GT, IR.OP.LT, IR.OP.NE, IR.OP.LE, IR.OP.GE
		dtype = IR.DATATYPE.INTEGER

	'' right-operand must be an integer, so pow2 opts can be done on longint's
	case IR.OP.SHL, IR.OP.SHR
		if( dt2 <> IR.DATATYPE.INTEGER ) then
			if( dt2 <> IR.DATATYPE.UINT ) then
				dt2 = IR.DATATYPE.INTEGER
				r = astNewCONV( INVALID, dt2, r )
				dc2 = IR.DATACLASS.INTEGER
			end if
		end if
	end select

	''::::::

	'' constant folding (won't handle commutation, ie: "1+a+2+3" will become "1+a+5", not "a+6")
	if( l->defined and r->defined ) then

		select case as const dt1
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		    hBOPConstFold64( op, l, r )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			hBOPConstFoldFlt( op, l, r )
		case else
			hBOPConstFoldInt( op, l, r )
		end select

		l->dtype = dtype

		''
		astDel( r )
		r = NULL

		return l

	elseif( l->defined ) then
		select case op
		case IR.OP.ADD, IR.OP.MUL
			'' ? + c = c + ?  |  ? * c = ? * c
			astSwap( r, l )

		case IR.OP.SUB
			'' c - ? = -? + c (this will removed later if no const folding can be done)
			r = astNewUOP( IR.OP.NEG, r )
			astSwap( r, l )
			op = IR.OP.ADD
		end select

	elseif( r->defined ) then
		select case op
		case IR.OP.SUB
			'' ? - c = ? + -c
			select case as const dt2
			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
				r->v.value64 = -r->v.value64
			case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
				r->v.valuef = -r->v.valuef
			case else
				r->v.valuei = -r->v.valuei
			end select
			op = IR.OP.ADD

		case IR.OP.POW

			'' convert var ^ 2 to var * var
			if( r->v.valuef = 2.0 ) then

				'' operands will be converted to DOUBLE if not floats..
				if( l->class = AST.NODECLASS.CONV ) then
					select case l->l->class
					case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
						n = l
						l = l->l
						astDel( n )
						dt1 = l->dtype
					end select
				end if

				select case l->class
				case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
					astDel( r )
					r = astCloneTree( l )
					op = IR.OP.MUL
					dtype = dt1
				end select
			end if
		end select
	end if

	''::::::
	'' handle pow
	if( op = IR.OP.POW ) then
		return rtlMathPow( l, r )
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.BOP, dtype )
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

	'' nodes not needed anymore
	astDel( l )
	astDel( r )

	'' "var op= expr" optimizations
	if( vr = NULL ) then
		vr = v1
	end if

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' unary operations (l = operand expression; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hUOPConstFoldInt( byval op as integer, _
						      byval v as ASTNODE ptr ) static

	select case as const op
	case IR.OP.NOT
		v->v.valuei = not v->v.valuei

	case IR.OP.NEG
		v->v.valuei = -v->v.valuei

	case IR.OP.ABS
		v->v.valuei = abs( v->v.valuei )

	case IR.OP.SGN
		v->v.valuei = sgn( v->v.valuei )
	end select

end sub

'':::::
private sub hUOPConstFoldFlt( byval op as integer, _
						      byval v as ASTNODE ptr ) static

	select case as const op
	case IR.OP.NOT
		v->v.valuei = not cint( v->v.valuef )

	case IR.OP.NEG
		v->v.valuef = -v->v.valuef

	case IR.OP.ABS
		v->v.valuef = abs( v->v.valuef )

	case IR.OP.SGN
		v->v.valuei = sgn( v->v.valuef )

	case IR.OP.SIN
		v->v.valuef = sin( v->v.valuef )

	case IR.OP.ASIN
		v->v.valuef = asin( v->v.valuef )

	case IR.OP.COS
		v->v.valuef = cos( v->v.valuef )

	case IR.OP.ACOS
		v->v.valuef = acos( v->v.valuef )

	case IR.OP.TAN
		v->v.valuef = tan( v->v.valuef )

	case IR.OP.ATAN
		v->v.valuef = atn( v->v.valuef )

	case IR.OP.SQRT
		v->v.valuef = sqr( v->v.valuef )

	case IR.OP.LOG
		v->v.valuef = log( v->v.valuef )

	case IR.OP.FLOOR
		v->v.valuef = int( v->v.valuef )
	end select

end sub

'':::::
private sub hUOPConstFold64( byval op as integer, _
							 byval v as ASTNODE ptr ) static

	select case as const op
	case IR.OP.NOT
		v->v.value64 = not v->v.value64

	case IR.OP.NEG
		v->v.value64 = -v->v.value64

	case IR.OP.ABS
		v->v.value64 = abs( v->v.value64 )

	case IR.OP.SGN
		v->v.valuei = sgn( v->v.value64 )
	end select

end sub

'':::::
function astNewUOP( byval op as integer, _
					byval o as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer dclass, dtype

	function = NULL

	if( o = NULL ) then
		exit function
	end if

	dtype = o->dtype

    '' string? can't operate
    dclass = irGetDataClass( dtype )
    if( dclass = IR.DATACLASS.STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( dtype = IR.DATATYPE.USERDEF ) then
		exit function
    end if

	'' convert byte to integer
	if( irGetDataSize( dtype ) = 1 ) then
		if( irIsSigned( dtype ) ) then
			dtype = IR.DATATYPE.INTEGER
		else
			dtype = IR.DATATYPE.UINT
		end if
		o = astNewCONV( INVALID, dtype, o )
	end if

	select case as const op
	'' NOT can only operate on integers
	case IR.OP.NOT
		if( dclass <> IR.DATACLASS.INTEGER ) then
			dtype = IR.DATATYPE.INTEGER
			o = astNewCONV( INVALID, dtype, o )
		end if

	'' with SGN the result is always signed integer
	case IR.OP.SGN
		if( dclass <> IR.DATACLASS.INTEGER ) then
			dtype = IR.DATATYPE.INTEGER
		else
			dtype = irGetSignedType( dtype )
		end if

	'' transcendental can only operate on floats
	case IR.OP.SIN, IR.OP.ASIN, IR.OP.COS, IR.OP.ACOS, _
		 IR.OP.TAN, IR.OP.ATAN, IR.OP.SQRT, IR.OP.LOG, IR.OP.FLOOR
		if( dclass <> IR.DATACLASS.FPOINT ) then
			dtype = IR.DATATYPE.DOUBLE
			o = astNewCONV( INVALID, dtype, o )
		end if
	end select

	'' constant folding
	if( o->defined ) then

		select case as const o->dtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		    hUOPConstFold64( op, o )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			hUOPConstFoldFlt( op, o )
		case else
			hUOPConstFoldInt( op, o )
		end select

		o->dtype = dtype

		return o
	end if

	if( op = IR.OP.SGN ) then
		'' hack! SGN with floats is handled by a function
		if( dclass = IR.DATACLASS.FPOINT ) then
			return rtlMathFSGN( o )
		end if
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.UOP, dtype )
	if( n = NULL ) then
		exit function
	end if

	n->op 		= op
	n->l  		= o
	n->r  		= NULL
	n->allocres	= TRUE
	n->ex 		= NULL

	function = n

end function

'':::::
function astLoadUOP( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr o
    dim as integer op
    dim as IRVREG ptr v1, vr

	o  = n->l
	op = n->op

	if( o = NULL ) then
		return NULL
	end if

	v1 = astLoad( o )

	if( n->allocres ) then
		vr = irAllocVREG( o->dtype )
	else
		vr = NULL
	end if

	irEmitUOP( op, v1, vr )

	astDel( o )

	'' "op var" optimizations
	if( vr = NULL ) then
		vr = v1
	end if

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' conversions (l = expression to convert; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hCONVConstEvalInt( byval dtype as integer, _
							   byval v as ASTNODE ptr ) static

	select case as const v->dtype
	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT

		select case as const dtype
		case IR.DATATYPE.BYTE
			v->v.valuei = cbyte( v->v.value64 )

		case IR.DATATYPE.UBYTE
			v->v.valuei = cubyte( v->v.value64 )

		case IR.DATATYPE.SHORT
			v->v.valuei = cshort( v->v.value64 )

		case IR.DATATYPE.USHORT
			v->v.valuei = cushort( v->v.value64 )

		case IR.DATATYPE.INTEGER
			v->v.valuei = cint( v->v.value64 )

		case IR.DATATYPE.UINT
			v->v.valuei = cuint( v->v.value64 )
		end select

	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE

		select case as const dtype
		case IR.DATATYPE.BYTE
			v->v.valuei = cbyte( v->v.valuef )

		case IR.DATATYPE.UBYTE
			v->v.valuei = cubyte( v->v.valuef )

		case IR.DATATYPE.SHORT
			v->v.valuei = cshort( v->v.valuef )

		case IR.DATATYPE.USHORT
			v->v.valuei = cushort( v->v.valuef )

		case IR.DATATYPE.INTEGER
			v->v.valuei = cint( v->v.valuef )

		case IR.DATATYPE.UINT
			v->v.valuei = cuint( v->v.valuef )
		end select

	end select

end sub

'':::::
private sub hCONVConstEvalFlt( byval dtype as integer, _
							   byval v as ASTNODE ptr ) static

	select case as const v->dtype
	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
	    '' do nothing..

	case IR.DATATYPE.LONGINT

		if( dtype = IR.DATATYPE.SINGLE ) then
			v->v.valuef = csng( v->v.value64 )
		else
			v->v.valuef = cdbl( v->v.value64 )
		end if

	case IR.DATATYPE.ULONGINT

		if( dtype = IR.DATATYPE.SINGLE ) then
			v->v.valuef = csng( cunsg( v->v.value64 ) )
		else
			v->v.valuef = cdbl( cunsg( v->v.value64 ) )
		end if

	case IR.DATATYPE.UINT

		if( dtype = IR.DATATYPE.SINGLE ) then
			v->v.valuef = csng( cunsg( v->v.valuei ) )
		else
			v->v.valuef = cdbl( cunsg( v->v.valuei ) )
		end if

	case else

		if( dtype = IR.DATATYPE.SINGLE ) then
			v->v.valuef = csng( v->v.valuei )
		else
			v->v.valuef = cdbl( v->v.valuei )
		end if

	end select

end sub

'':::::
private sub hCONVConstEval64( byval dtype as integer, _
							  byval v as ASTNODE ptr ) static

	select case as const v->dtype
	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		'' do nothing

	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
		if( dtype = IR.DATATYPE.LONGINT ) then
			v->v.value64 = clngint( v->v.valuef )
		else
			v->v.value64 = culngint( v->v.valuef )
		end if

	case else
		if( dtype = IR.DATATYPE.LONGINT ) then
			v->v.value64 = clngint( v->v.valuei )
		else
			v->v.value64 = culngint( v->v.valuei )
		end if

	end select

end sub

'':::::
function astNewCONV( byval op as integer, _
					 byval dtype as integer, _
					 byval l as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer dclass, ldtype

	function = NULL

    if( l = NULL ) then
    	exit function
    end if

    ldtype = l->dtype

    dclass = irGetDataClass( ldtype )

    '' string? can't operate
    if( dclass = IR.DATACLASS.STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( ldtype = IR.DATATYPE.USERDEF ) then
		exit function
    end if

	'' if it's just a sign conversion, change node's sign and create no new node
	if( op <> INVALID ) then

		'' float? invalid
		if( dclass <> IR.DATACLASS.INTEGER ) then
			exit function
		end if

		if( op = IR.OP.TOSIGNED ) then
			l->dtype = irGetSignedType( ldtype )
		else
			l->dtype = irGetUnsignedType( ldtype )
		end if

		return l
	end if

	'' only convert if the classes are different (ie, floating<->integer) or
	'' if sizes are different (ie, byte<->int)
	if( (dclass = irGetDataClass( dtype )) and _
		(irGetDataSize( ldtype ) = irGetDataSize( dtype )) ) then

		l->dtype = dtype

		return l
	end if

	'' constant? evaluate at compile-time
	if( l->defined ) then

		select case as const dtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			hCONVConstEval64( dtype, l )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			hCONVConstEvalFlt( dtype, l )
		case else
			hCONVConstEvalInt( dtype, l )
		end select

		l->dtype = dtype

		return l
	end if

	'' handle special cases..
	if( dtype = IR.DATATYPE.ULONGINT ) then
		if( dclass = IR.DATACLASS.FPOINT ) then
			return rtlMathFp2ULongint( l, ldtype )
		end if
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.CONV, dtype )
	if( n = NULL ) then
		exit function
	end if

	n->l  = l

	function = n

end function

'':::::
function astLoadCONV( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as integer dtype
    dim as IRVREG ptr vs, vr

	l  = n->l

	if( l = NULL ) then
		return NULL
	end if

	vs = astLoad( l )

	dtype = n->dtype

	vr = irAllocVREG( dtype )
	irEmitCONVERT( vr, dtype, vs, INVALID )

	astDel( l )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constants (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewCONSTi( byval value as integer, _
					   byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNew( AST.NODECLASS.CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->v.valuei= value
	n->defined = TRUE

end function

'':::::
function astNewCONSTf( byval value as double, _
					   byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNew( AST.NODECLASS.CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->v.valuef= value
	n->defined = TRUE

end function

'':::::
function astNewCONST64( byval value as longint, _
					    byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNew( AST.NODECLASS.CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->v.value64 = value
	n->defined   = TRUE

end function

'':::::
function astNewCONST( byval v as FBVALUE ptr, _
					  byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNew( AST.NODECLASS.CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	select case as const dtype
	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		n->v.value64 = v->value64
	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
		n->v.valuef = v->valuef
	case else
		n->v.valuei = v->valuei
	end select

	n->defined = TRUE

end function

'':::::
function astLoadCONST( byval n as ASTNODE ptr ) as IRVREG ptr static
	dim as FBSYMBOL ptr s
	dim as integer dtype

	dtype = n->dtype

	select case dtype
	'' longints?
	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		return irAllocVRIMM64( dtype, n->v.value64 )

	'' if node is a float, create a temp float var (x86 assumption)
	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
		s = hAllocNumericConst( str$( n->v.valuef ), dtype )
		return irAllocVRVAR( dtype, s, s->ofs )

	''
	case else
		return irAllocVRIMM( dtype, n->v.valuei )
	end select

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' variables (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewVAR( byval sym as FBSYMBOL ptr, _
					byval elm as FBSYMBOL ptr, _
					byval ofs as integer, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNew( AST.NODECLASS.VAR, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->var.sym 	= sym
	n->var.elm 	= elm
	if( sym <> NULL ) then
		ofs += sym->ofs
	end if
	n->var.ofs	= ofs
	n->chkbitfld= elm <> NULL

end function

'':::::
private function hGetBitField( byval n as ASTNODE ptr, _
							   byval s as FBSYMBOL ptr ) as ASTNODE ptr static

	dim as ASTNODE ptr c

	'' make a copy, the node itself can't be used or it will be deleted twice
	c = astNew( INVALID, INVALID )
	astCopy( c, n )

	if( s->var.elm.bitpos > 0 ) then
		n = astNewBOP( IR.OP.SHR, c, _
				   	   astNewCONSTi( s->var.elm.bitpos, IR.DATATYPE.UINT ) )
	else
		n = c
	end if

	n = astNewBOP( IR.OP.AND, n, _
				   astNewCONSTi( bitmaskTB(s->var.elm.bits), IR.DATATYPE.UINT ) )

	function = n

end function

'':::::
function astLoadVAR( byval n as ASTNODE ptr ) as IRVREG ptr static
    dim as FBSYMBOL ptr s

	'' handle bitfields..
	if( n->chkbitfld ) then
		n->chkbitfld = FALSE
		s = n->var.elm
		if( s <> NULL ) then
			if( s->var.elm.bits > 0 ) then
				n = hGetBitField( n, s )
				function = astLoad( n )
				astDel( n )
				exit function
			end if
		end if
	end if

	function = irAllocVRVAR( n->dtype, n->var.sym, n->var.ofs )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' indexes (l = index expression; r = var expression)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewIDX( byval v as ASTNODE ptr, _
					byval i as ASTNODE ptr, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	if( dtype = INVALID ) then
		dtype = astGetDataType( i )
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.IDX, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l 			= i
	n->r 			= v
	n->idx.mult 	= 1
	n->idx.ofs 		= 0
	n->chkbitfld  	= v <> NULL

end function

'':::::
function asthEmitIDX( byval v as ASTNODE ptr, _
					  byval ofs as integer, _
					  byval mult as integer, _
					  byval vi as IRVREG ptr ) as IRVREG ptr static
    dim as FBSYMBOL ptr s
    dim as IRVREG ptr vd

    s = v->var.sym

	'' ofs * length + difference (non-base 0 indexes) + offset (UDT's offset)
	if( not symbGetIsDynamic( s ) ) then
		ofs = ofs + symbGetArrayDiff( s ) + v->var.ofs
	else
		s = NULL
	end if

    ''
	if( vi <> NULL ) then

		if( (mult >= 10) or (mult = 6) or (mult = 7) ) then
			mult = 1
		end if

		vd = irAllocVRIDX( v->dtype, s, ofs, mult, vi )

		if( irIsIDX( vi ) or irIsVAR( vi ) ) then
			irEmitLOAD( IR.OP.LOAD, vi )
		end if

	else
		vd = irAllocVRVAR( v->dtype, s, ofs )
	end if

	function = vd

end function

'':::::
function astLoadIDX( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr v, i
    dim as IRVREG ptr vi, vr
    dim as FBSYMBOL ptr s

	v = n->r
	if( v = NULL ) then
		return NULL
	end if

	'' handle bitfields..
	if( n->chkbitfld ) then
		n->chkbitfld = FALSE
		if( v->chkbitfld ) then
			v->chkbitfld = FALSE
			s = v->var.elm
			if( s <> NULL ) then
				if( s->var.elm.bits > 0 ) then
					n = hGetBitField( n, s )
					function = astLoad( n )
					astDel( n )
					exit function
				end if
			end if
		end if
	end if

	i = n->l
	if( i <> NULL ) then
		vi = astLoad( i )
	else
		vi = NULL
	end if

    vr = asthEmitIDX( v, n->idx.ofs, n->idx.mult, vi )

	astDel( i )
	astDel( v )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' addressing operations (l = expression to call the address of; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewOFFSET( byval v as ASTNODE ptr, _
					   byval sym as FBSYMBOL ptr = NULL, _
					   byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr static
	dim as ASTNODE ptr n

	if( v = NULL ) then
		return NULL
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.OFFSET, IR.DATATYPE.POINTER + IR.DATATYPE.VOID, NULL )

	if( n = NULL ) then
		return NULL
	end if

	n->l  		= v
	n->addr.sym	= sym
	n->addr.elm	= elm
	n->chkbitfld= elm <> NULL

	function = n

end function

'':::::
function astLoadOFFSET( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr v
    dim as IRVREG ptr vr

	v  = n->l
	if( v = NULL ) then
		return NULL
	end if

	vr = irAllocVROFS( n->dtype, v->var.sym )

	astDel( v )

	function = vr

end function

'':::::
function astNewADDR( byval op as integer, _
					 byval p as ASTNODE ptr, _
					 byval sym as FBSYMBOL ptr = NULL, _
					 byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	if( p = NULL ) then
		return NULL
	end if

	if( op = IR.OP.ADDROF ) then
		if( p->class = AST.NODECLASS.VAR ) then
			if( p->var.ofs = 0 ) then
				return astNewOFFSET( p, sym, elm )
			end if
		end if
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.ADDR, IR.DATATYPE.POINTER + IR.DATATYPE.VOID, NULL )
	if( n = NULL ) then
		exit function
	end if

	n->op 		= op
	n->l  		= p
	n->addr.sym	= sym
	n->addr.elm	= elm
	n->chkbitfld= elm <> NULL

	function = n

end function

'':::::
function astLoadADDR( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr p
    dim as IRVREG ptr v1, vr

	p  = n->l
	if( p = NULL ) then
		return NULL
	end if

	v1 = astLoad( p )

	'' !!!WRITEME!!! if v1 is already a ptr with no ofs or other attached regs,
	'' convert it to a simple reg (not a ptr) and change type to UINT

	vr = irAllocVREG( IR.DATATYPE.UINT )

	irEmitADDR( n->op, v1, vr )

	astDel( p )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' loading (l = expression to load to a register; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLOAD( byval l as ASTNODE ptr, _
					 byval dtype as integer ) as ASTNODE ptr static
    dim n as ASTNODE ptr

	'' alloc new node
	n = astNew( AST.NODECLASS.LOAD, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l  = l

end function

'':::::
function astLoadLOAD( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as IRVREG ptr vr

	l = n->l
	if( l = NULL ) then
		return NULL
	end if

	vr = astLoad( l )

	irEmitLOAD( IR.OP.LOAD, vr )

	astDel( l )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' pointers (l = pointer expression; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewPTR( byval sym as FBSYMBOL ptr, _
					byval elm as FBSYMBOL ptr, _
					byval ofs as integer, _
					byval expr as ASTNODE ptr, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNew( AST.NODECLASS.PTR, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l   		= expr
	n->ptr.sym	= sym
	n->ptr.elm	= elm
	n->ptr.ofs	= ofs
	n->chkbitfld= elm <> NULL

end function

'':::::
function astLoadPTR( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as integer dtype
    dim as IRVREG ptr v1, vp, vr
    dim as FBSYMBOL ptr s

	l = n->l
	if( l = NULL ) then
		return NULL
	end if

	'' handle bitfields..
	if( n->chkbitfld ) then
		n->chkbitfld = FALSE
		s = n->ptr.elm
		if( s <> NULL ) then
			if( s->var.elm.bits > 0 ) then
				n = hGetBitField( n, s )
				function = astLoad( n )
				astDel( n )
				exit function
			end if
		end if
	end if

	v1 = astLoad( l )

	''
	dtype = n->dtype

	'' src is already a reg?
	if( (not irIsREG( v1 )) or _
		(irGetVRDataClass( v1 ) <> IR.DATACLASS.INTEGER) or _
		(irGetVRDataSize( v1 ) <> FB.POINTERSIZE) ) then

		vp = irAllocVREG( IR.DATATYPE.UINT )
		irEmitADDR( IR.OP.DEREF, v1, vp )
	else
		vp = v1
	end if

	vr = irAllocVRPTR( dtype, n->ptr.ofs, vp )

	astDel( l )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' assignaments (l = destine; r = source)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewASSIGN( byval l as ASTNODE ptr, _
					   byval r as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer dtype
    dim as integer dt1, dt2
    dim as integer dc1, dc2
    dim as FBSYMBOL ptr proc

	function = NULL

	dt1 = l->dtype
	dt2 = r->dtype
	dc1 = irGetDataClass( dt1 )
	dc2 = irGetDataClass( dt2 )

    '' strings?
    if( (dc1 = IR.DATACLASS.STRING) or (dc2 = IR.DATACLASS.STRING) ) then

		'' both not the same?
		if( dc1 <> dc2 ) then
			'' check if it's not a byte ptr
			if( dc1 = IR.DATACLASS.STRING ) then
				'' not a zstring?
				if( dt2 <> IR.DATATYPE.CHAR ) then
					if( r->class <> AST.NODECLASS.PTR ) then
						exit function
					elseif( dt2 <> IR.DATATYPE.BYTE ) then
						if( dt2 <> IR.DATATYPE.UBYTE ) then
							exit function
						end if
					end if
				end if
			else
				'' not a zstring?
				if( dt1 <> IR.DATATYPE.CHAR ) then
					if( l->class <> AST.NODECLASS.PTR ) then
						exit function
					elseif( dt1 <> IR.DATATYPE.BYTE ) then
						if( dt1 <> IR.DATATYPE.UBYTE ) then
							exit function
						end if
					end if
				end if
			end if

			return rtlStrAssign( l, r )

		end if

	'' UDT's?
	elseif( (dt1 = IR.DATATYPE.USERDEF) or (dt2 = IR.DATATYPE.USERDEF) ) then

		'' l node must be an UDT's,
		if( dt1 <> IR.DATATYPE.USERDEF ) then
			exit function
		else
			'' "udtfunct() = udt" is not allowed, l node must be a variable
			if( l->class = AST.NODECLASS.FUNCT ) then
				exit function
			end if
		end if

        '' r is not an UDT?
		if( dt2 <> IR.DATATYPE.USERDEF ) then
			'' not a function returning an UDT on regs?
			if( r->class <> AST.NODECLASS.FUNCT ) then
				exit function
			end if

            '' handle functions returning UDT's when type isn't a pointer,
            '' but an integer or fpoint register
            proc = r->proc.sym
            if( proc->typ <> IR.DATATYPE.USERDEF ) then
            	exit function
            end if

            '' fake l's type
            dt1 = proc->proc.realtype
            l->dtype = dt1

		'' both are UDT's, do a mem copy..
		else
			return rtlMemCopy( l, r, symbGetUDTLen( l->subtype ) )
		end if

    '' zstrings?
    elseif( (dt1 = IR.DATATYPE.CHAR) or (dt2 = IR.DATATYPE.CHAR) ) then

		'' both not the same? assign as string..
		if( dt1 = dt2 ) then
			return rtlStrAssign( l, r )
		end if

		'' one is not a string, nor a udt, treat as numeric type, let emit
		'' convert then if needed..

	end if

	'' convert types if needed
	if( dt1 <> dt2 ) then
		'' don't convert strings
		if( dc2 <> IR.DATACLASS.STRING ) then
			r = astNewCONV( INVALID, dt1, r )
		end if
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.ASSIGN, dt1 )

	if( n = NULL ) then
		return NULL
	end if

	n->l  = l
	n->r  = r

	function = n

end function

'':::::
private function hSetBitField( byval l as ASTNODE ptr, _
							   byval r as ASTNODE ptr, _
							   byval s as FBSYMBOL ptr ) as ASTNODE ptr static

	l = astNewBOP( IR.OP.AND, astCloneTree( l ), _
				   astNewCONSTi( not (bitmaskTB(s->var.elm.bits) shl s->var.elm.bitpos), _
				   				 IR.DATATYPE.UINT ) )

	if( s->var.elm.bitpos > 0 ) then
		r = astNewBOP( IR.OP.SHL, r, _
				   	   astNewCONSTi( s->var.elm.bitpos, IR.DATATYPE.UINT ) )
	end if

	function = astNewBOP( IR.OP.OR, l, r )

end function

'':::::
function astLoadASSIGN( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r
    dim as IRVREG ptr vs, vr
    dim as FBSYMBOL ptr s

	l = n->l
	r = n->r
	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' handle bitfields..
	if( l->chkbitfld ) then
		l->chkbitfld = FALSE
		s = astGetUDTElm( l )
		if( s <> NULL ) then
			if( s->var.elm.bits > 0 ) then
				r = hSetBitField( l, r, s )
			end if
		end if
	end if

	vs = astLoad( r )
	vr = astLoad( l )

	irEmitSTORE( vr, vs )

	astDel( l )
	astDel( r )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' branches (l = link to the stream to be also flushed, if any; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewBRANCH( byval op as integer, _
					   byval label as FBSYMBOL ptr, _
					   byval l as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer dtype

    if( l = NULL ) then
    	dtype = INVALID
    else
    	dtype = l->dtype
    end if

	'' alloc new node
	n = astNew( AST.NODECLASS.BRANCH, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l  = l
	n->ex = label
	n->op = op

end function

'':::::
function astLoadBRANCH( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as IRVREG ptr vr

	l  = n->l

	if( l <> NULL ) then
		vr = astLoad( l )
		astDel( l )
	else
		vr = NULL
	end if

	'' pointer?
	if( n->ex = NULL ) then
		'' jump or call?
		if( n->op = IR.OP.JUMPPTR ) then
			irEmitBRANCHPTR( vr )
		else
			irEmitCALLPTR( vr, NULL, 0 )
		end if
	else
		irEmitBRANCH( n->op, n->ex )
	end if

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' functions (l = pointer node if any; r = first param to be pushed)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewFUNCT( byval sym as FBSYMBOL ptr, _
					  byval dtype as integer, _
					  byval ptrexpr as ASTNODE ptr = NULL, _
					  byval isprofiler as integer = FALSE ) as ASTNODE ptr
    dim as ASTNODE ptr n
    dim as FBRTLCALLBACK callback

	'' if return type is an UDT, change to the real one
	if( sym <> NULL ) then
		if( sym->typ = FB.SYMBTYPE.USERDEF ) then
			if( dtype = sym->typ ) then
				'' only if it's not a pointer, but a reg (integer or fpoint)
				if( sym->proc.realtype < FB.SYMBTYPE.POINTER ) then
					dtype = sym->proc.realtype
				end if
			end if
		end if
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.FUNCT, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->proc.sym 	= sym
	n->l 			= ptrexpr
	n->proc.params 	= 0

	if( sym <> NULL ) then
		n->proc.arg	= symbGetProcHeadArg( sym )
		n->proc.isrtl = symbGetProcIsRTL( sym )

		callback = symbGetProcCallback( sym )
		if( callback <> NULL ) then
			callback( sym )
		end if
	else
		n->proc.arg	= NULL
		n->proc.isrtl = FALSE
	end if

	n->proc.arraytail = NULL
	n->proc.strtail = NULL

	'' function profiling
	n->proc.profstart = NULL
	n->proc.profend   = NULL
	if( env.clopt.profile ) then
		if( not isprofiler ) then
			n->proc.profstart = rtlProfileStartCall( sym )
			if( n->proc.profstart <> NULL ) then
				n->proc.profend   = rtlProfileEndCall( )
			end if
		end if
	end if

end function

'':::::
private sub hReportParamError( byval f as ASTNODE ptr )

	hReportErrorEx FB.ERRMSG.PARAMTYPEMISMATCHAT, "at parameter: " + str$( f->proc.params+1 )

end sub

'':::::
private sub hReportParamWarning( byval f as ASTNODE ptr, _
								 byval msgnum as integer )

	hReportWarning msgnum, "at parameter: " + str$( f->proc.params+1 )

end sub

'':::::
private function hAllocTmpArrayDesc( byval f as ASTNODE ptr, _
									 byval n as ASTNODE ptr ) as integer
	dim s as FBSYMBOL ptr
	dim t as ASTTEMPARRAY ptr

	'' alloc a node
	t = listNewNode( @ctx.temparray )
	t->left = f->proc.arraytail
	f->proc.arraytail = t

	'' create a pointer
	s = symbAddTempVar( FB.SYMBTYPE.UINT )

	t->pdesc = s

	''
	return rtlArrayAllocTmpDesc( n, s )

end function

'':::::
private function hAllocTmpString( byval f as ASTNODE ptr, _
								  byval n as ASTNODE ptr, _
								  byval copyback as integer ) as integer
	dim as FBSYMBOL ptr s
	dim as ASTTEMPSTR ptr t

	'' alloc a node
	t = listNewNode( @ctx.tempstr )
	t->left = f->proc.strtail
	f->proc.strtail = t

	'' create temp string to pass as paramenter
	s = symbAddTempVar( FB.SYMBTYPE.STRING )

	t->tmpsym = s
	if( copyback ) then
		t->srctree = astCloneTree( n )
	else
		t->srctree = NULL
	end if

	'' temp string = src string
	return rtlStrAssign( astNewVAR( s, NULL, 0, IR.DATATYPE.STRING ), n )

end function

'':::::
private function hCheckStringArg( byval f as ASTNODE ptr, _
							      byval arg as FBSYMBOL ptr, _
							      byval p as ASTNODE ptr ) as integer

    dim as integer adtype, pdtype, pclass, copyback, amode

	function = p

	copyback = FALSE

	'' get param and arg data types
	adtype  = symbGetType( arg )
	pdtype  = p->dtype

	amode = symbGetArgMode( f->proc.sym, arg )

	'' calling the runtime lib?
	if( f->proc.isrtl ) then

		'' byref arg?
		if( amode = FB.ARGMODE.BYREF ) then

			'' var-len param: all rtlib procs will delete temps automatically
			if( pdtype = IR.DATATYPE.STRING ) then
				exit function

			'' fixed-len/byte/zstring/ptr param: just alloc a temp descriptor
			'' (assuming here that no rtlib function will EVER change the strings
			'' passed as param)
			else
				return rtlStrAllocTmpDesc( p )
			end if

		else

			'' skip, unless it's a temp var-len (return by functions), that
			'' must be deleted when the called proc returns
			if( pclass <> AST.NODECLASS.FUNCT ) then
				exit function
			end if

			'' only if var-len
			if( pdtype <> IR.DATATYPE.STRING ) then
				exit function
			end if

			'' create temp string to pass as paramenter
			return hAllocTmpString( f, p, FALSE )
		end if

	end if


	'' param class
	pclass = p->class

	''
	select case amode

	'' by reference arg?
	case FB.ARGMODE.BYREF

    	'' fixed-length?
    	select case pdtype
    	case IR.DATATYPE.FIXSTR
    		'' byref arg and fixed-len param: alloc a temp string, copy
    		'' fixed to temp and pass temp
			'' (ast will have to copy temp back to fixed when function
			'' returns and delete temp)

			'' don't copy back if it's a function returning a fixed-len
			if( pclass <> AST.NODECLASS.FUNCT ) then
				copyback = TRUE
			end if

    	'' var-len param..
    	case IR.DATATYPE.STRING
    		'' if not a function's result, skip..
    		if( pclass <> AST.NODECLASS.FUNCT ) then
    			exit function
            end if

    	'' byte/zstring/ptr param..
    	case else
    		'' byref arg and byte/zstring/ptr param: alloc a temp string,
    		'' copy byte ptr to temp and pass temp

    	end select

    '' by value arg?
    case FB.ARGMODE.BYVAL

		'' skip, unless it's a temp var-len (return by functions), that
		'' must be deleted when the called proc returns
		if( pclass <> AST.NODECLASS.FUNCT ) then
			exit function
		end if

		'' only if var-len
		if( pdtype <> IR.DATATYPE.STRING ) then
			exit function
		end if

	end select

	'' create temp string to pass as paramenter
	function = hAllocTmpString( f, p, copyback )

end function

'':::::
private function hCheckStringParam( byval f as ASTNODE ptr, _
									byval n as ASTNODE ptr, _
					   				byval pclass as integer, _
					   				byval pdtype as integer, _
					   				byval pdclass as integer ) as integer

	'' rtl? don't mess..
	if( f->proc.isrtl ) then
		return TRUE
	end if

	''
	if( pdclass = IR.DATACLASS.STRING ) then

		'' if it's a function returning a STRING, it will have to be
		'' deleted automagically when the proc been called return
		if( pclass = AST.NODECLASS.FUNCT ) then
			'' create temp string to pass as paramenter (no copy is
			'' done at rtlib, as the returned string is a temp one)
			n->l = hAllocTmpString( f, n->l, FALSE )
			pdtype = IR.DATATYPE.STRING
			pclass = AST.NODECLASS.PTR
			n->dtype = pdtype
		end if

		'' not fixed-len? deref var-len (ptr at offset 0)
		if( pdtype <> IR.DATATYPE.FIXSTR ) then
    		n->l     = astNewADDR( IR.OP.DEREF, n->l )
			n->dtype = IR.DATATYPE.POINTER + IR.DATATYPE.CHAR

        '' fixed-len? get the address of
        elseif( pclass <> AST.NODECLASS.PTR ) then
			n->l     = astNewADDR( IR.OP.ADDROF, n->l )
			n->dtype = IR.DATATYPE.POINTER + IR.DATATYPE.CHAR
		end if

	else
    	'' zstring? if not a ptr yet, get the address of
    	if( pdtype = IR.DATATYPE.CHAR ) then
			if( pclass <> AST.NODECLASS.PTR ) then
				n->l     = astNewADDR( IR.OP.ADDROF, n->l )
				n->dtype = IR.DATATYPE.POINTER + IR.DATATYPE.CHAR
			end if
		end if

	end if

	function = TRUE

end function

'':::::
private function hCheckArrayParam( byval f as ASTNODE ptr, _
								   byval n as ASTNODE ptr, _
					   	   		   byval adtype as integer, _
					   	   		   byval adclass as integer ) as integer

	dim as FBSYMBOL ptr s, d
    dim as ASTNODE ptr p

	p = n->l

	'' type field?
	s = astGetSymbol( p )

	if( s = NULL ) then
		hReportParamError f
		return FALSE
	end if

	'' same type? (don't check if it's a rtl proc)
	if( not f->proc.isrtl ) then
		if( (adclass <> irGetDataClass( s->typ ) ) or _
			(irGetDataSize( adtype ) <> irGetDataSize( s->typ )) ) then
			hReportParamError f
			return FALSE
		end if
	end if

	if( s->class = FB.SYMBCLASS.UDTELM ) then
		'' not an array?
		if( symbGetArrayDimensions( s ) = 0 ) then
			hReportParamError f
			return FALSE
		end if

		'' address of?
		if( astIsADDR( p ) ) then
			hReportParamError f
			return FALSE
		end if

		'' create a temp array descriptor
		n->l     = hAllocTmpArrayDesc( f, p )
		n->dtype = IR.DATATYPE.POINTER + IR.DATATYPE.VOID

	else

		'' an argument passed by descriptor?
		if( symbIsArgByDesc( s ) ) then
        	'' it's a pointer, but could be seen as anything else
        	'' (ie: if it were "s() as string"), so, create an alias
        	n->l     = astNewVAR( s, NULL, 0, IR.DATATYPE.UINT )
        	n->dtype = IR.DATATYPE.POINTER + IR.DATATYPE.VOID

    	else
			'' not an array?
			d = s->var.array.desc
			if( d = NULL ) then
				hReportParamError f
				return FALSE
			end if

        	''
        	n->l     = astNewADDR( IR.OP.ADDROF, astNewVAR( d, NULL, 0, IR.DATATYPE.UINT ) )
        	n->dtype = IR.DATATYPE.POINTER + IR.DATATYPE.VOID

    	end if

    end if

    function = TRUE

end function

'':::::
private function hCheckParam( byval f as ASTNODE ptr, _
							  byval n as ASTNODE ptr ) as integer

    dim as FBSYMBOL ptr proc, arg, s
    dim as integer adtype, adclass, amode
    dim as ASTNODE ptr p
    dim as integer pdtype, pdclass, pmode, pclass

    function = FALSE

	''
	proc = f->proc.sym

	if( f->proc.params >= proc->proc.args ) then
		arg = symbGetProcTailArg( proc )
	else
		arg = f->proc.arg
	end if

	'' argument
	amode   	= symbGetArgMode( proc, arg )
	adtype  	= symbGetType( arg )
	if( adtype <> INVALID ) then
		adclass = irGetDataClass( adtype )
	end if

	'' string concatenation is delayed for optimization reasons..
	n->l = astUpdStrConcat( n->l )

    '' parameter
	p = n->l
	pmode    	= n->param.mode
	pdtype   	= p->dtype
	pdclass  	= irGetDataClass( pdtype )
	pclass	 	= p->class

	'' by descriptor?
	if( amode = FB.ARGMODE.BYDESC ) then

        '' param is not an pointer
        if( pmode <> FB.ARGMODE.BYVAL ) then

        	return hCheckArrayParam( f, n, adtype, adclass )

        end if

    '' vararg?
    elseif( amode = FB.ARGMODE.VARARG ) then

		return hCheckStringParam( f, n, pclass, pdtype, pdclass )

	'' as any?
    elseif( adtype = IR.DATATYPE.VOID ) then

		if( pmode = FB.ARGMODE.BYVAL ) then

			'' another quirk: BYVAL strings passed to BYREF ANY args..
			return hCheckStringParam( f, n, pclass, pdtype, pdclass )

		end if

    '' byval or byref (but as any)
    else

		'' if it's a function returning a STRING, it's actually a pointer
		if( pclass = AST.NODECLASS.FUNCT ) then
			if( pdtype = FB.SYMBTYPE.STRING ) then
				pclass = AST.NODECLASS.PTR
			end if
		end if

    	'' string argument?
    	if( adclass = IR.DATACLASS.STRING ) then

			'' param not an string?
			if( pdclass <> IR.DATACLASS.STRING ) then
				'' not a zstring?
				if( pdtype <> IR.DATATYPE.CHAR ) then
					'' check if not a byte ptr
					if( (pclass <> AST.NODECLASS.PTR) or _
						((pdtype <> IR.DATATYPE.BYTE) and (pdtype <> IR.DATATYPE.UBYTE)) ) then

						'' or if passing a ptr as byval to a byval string arg
			    		if( (pdclass <> IR.DATACLASS.INTEGER) or _
			    			(amode <> FB.ARGMODE.BYVAL) or _
			    			(irGetDataSize( pdtype ) <> FB.POINTERSIZE) ) then
							hReportParamError( f )
							exit function
			    		end if

			    		'' the BYVAL modifier was not used?
			    		if( pmode <> FB.ARGMODE.BYVAL ) then
							'' const? only accept if it's NULL
			    			if( pclass = AST.NODECLASS.CONST ) then
			    				if( p->v.valuei <> NULL ) then
									hReportParamError( f )
									exit function
			    				end if

			    			'' not a pointer?
			    			elseif( pdtype < IR.DATATYPE.POINTER ) then
								hReportParamError( f )
								exit function
			    			end if
			    		end if

			    	end if
				end if
			end if

			'' byval and fixed/byte ptr/ptr : pass the pointer as-is
			'' byval and variable			: pass the pointer at ofs 0 of the string descriptor
			'' byref and variable			: pass the pointer to descriptor
			'' byref and fixed/byte ptr   	: alloc a temp string, copy fixed to temp, pass temp,
			''					   			  copy temp back to fixed when func returns, del temp

			'' alloc a temp string if needed
			p = hCheckStringArg( f, arg, p )
			if( p <> n->l ) then
				'' node will be a function returning a PTR to a string descriptor
				pdtype  = IR.DATATYPE.STRING
				pdclass = IR.DATACLASS.STRING
				pclass	= AST.NODECLASS.PTR

				n->l     = p
				n->dtype = pdtype
			end if

			''
			if( amode = FB.ARGMODE.BYVAL ) then
				'' deref var-len (ptr at offset 0)
				if( pdtype = IR.DATATYPE.STRING ) then
					n->l     = astNewADDR( IR.OP.DEREF, p )
					n->dtype = IR.DATATYPE.UINT
					pdclass = IR.DATACLASS.INTEGER
					pdtype  = IR.DATATYPE.UINT
				end if
			end if

			'' not a pointer yet?
			if( pclass <> AST.NODECLASS.PTR ) then
				'' descriptor or fixed-len? get the address of
				if( (pdclass = IR.DATACLASS.STRING) or (pdtype = IR.DATATYPE.CHAR) ) then
					n->l     = astNewADDR( IR.OP.ADDROF, p )
					n->dtype = IR.DATATYPE.UINT
				end if
			end if


		'' anything but strings..
		else
	        '' passing a BYVAL ptr to an BYREF arg?
			if( (pmode = FB.ARGMODE.BYVAL) and (amode = FB.ARGMODE.BYREF) ) then
				if( (pdclass <> IR.DATACLASS.INTEGER) or _
					(irGetDataSize( pdtype ) <> FB.POINTERSIZE) ) then
					hReportParamError f
					exit function
				end if

			'' UDT arg? check if the same, can't convert
			elseif( adtype = IR.DATATYPE.USERDEF ) then
				if( pdtype <> IR.DATATYPE.USERDEF ) then
					if( pclass <> AST.NODECLASS.FUNCT ) then
						hReportParamError f
						exit function
					end if

					s = p->proc.sym
					if( s->typ <> FB.SYMBTYPE.USERDEF ) then
						hReportParamError f
						exit function
					end if

					n->dtype = pdtype
					s = s->subtype

				else
					if( pclass <> AST.NODECLASS.FUNCT ) then
						s = p->subtype
					else
						s = p->proc.sym->subtype
					end if
				end if

                '' check for invalid UDT's (different subtypes)
				if( symbGetSubtype( arg ) <> s ) then
					hReportParamError f
					exit function
				end if

				'' set the length if it's been passed by value
				if( amode = FB.ARGMODE.BYVAL ) then
					if( pdtype = IR.DATATYPE.USERDEF ) then
						n->param.lgt = symbGetUDTLen( s )
					end if
				end if

			''
			else
				'' can't convert strings/UDT's to other types
				if( (pdclass = IR.DATACLASS.STRING) or (pdtype = IR.DATATYPE.USERDEF) ) then
					hReportParamError f
					exit function
				end if

				'' different types? convert..
				if( (adclass <> pdclass) or _
					(irGetDataSize( adtype ) <> irGetDataSize( pdtype )) ) then

					if( amode = FB.ARGMODE.BYREF ) then
						'' param diff than arg can't passed by ref if it's a var/array/ptr
						select case as const pclass
						case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
							hReportParamError f
							exit function
						end select
					end if

					p = astNewCONV( INVALID, adtype, p )
					n->dtype = p->dtype
					n->l     = p

				end if

				'' pointer checking
				if( adtype >= IR.DATATYPE.POINTER ) then
					if( p->dtype < IR.DATATYPE.POINTER ) then
						select case as const pclass
						case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
							hReportParamWarning( f, FB.WARNINGMSG.INVALIDPOINTER )
						end select
					end if
				end if

			end if

		end if

    end if


    function = TRUE

end function

'':::::
function astNewPARAM( byval f as ASTNODE ptr, _
					  byval p as ASTNODE ptr, _
					  byval dtype as integer = INVALID, _
					  byval mode as integer = INVALID ) as ASTNODE ptr
    dim as ASTNODE ptr n, t
    dim proc as FBSYMBOL ptr

	if( dtype = INVALID ) then
		dtype = astGetDataType( p )
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.PARAM, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l 		  = p
	n->param.mode = mode
	n->param.lgt  = 0

	'' add param node to function's list
	proc = f->proc.sym

	t = f->r

	'' pascal mode, first param added will be the first pushed
	if( proc->proc.mode = FB.FUNCMODE.PASCAL ) then
		if( t = NULL ) then
			f->r = n
		else
			t = f->proc.lastparam
			t->r = n
		end if

		f->proc.lastparam = n
		n->r = NULL

	else
		'' non-pascal, the lastest param added will be the first pushed
		f->r = n
		n->r = t
	end if

	''
	if( not hCheckParam( f, n ) ) then
		return NULL
	end if

	''
	f->proc.params += 1

	if( f->proc.params < proc->proc.args ) then
		f->proc.arg = symbGetProcNextArg( proc, f->proc.arg, FALSE )
	end if

end function

'':::::
private function hCallProc( byval n as ASTNODE ptr, _
					   		byval proc as FBSYMBOL ptr, _
					   		byval mode as integer, _
					   		byval bytestopop as integer, _
					   		byval bytesaligned as integer ) as IRVREG ptr static
    dim as IRVREG ptr vreg, vr
    dim as ASTNODE ptr p
    dim as integer dtype

	'' ordinary pointer?
	if( proc = NULL ) then
		p = n->l
		vr = astLoad( p )
		astDel( p )
		irEmitCALLPTR( vr, NULL, 0 )

		return NULL
	end if

	dtype = n->dtype

	'' function returns as string? it's actually a pointer to a string descriptor..
	'' same with UDT's..
	select case dtype
	case IR.DATATYPE.STRING, IR.DATATYPE.USERDEF
		dtype += IR.DATATYPE.POINTER
	end select

	if( dtype <> IR.DATATYPE.VOID ) then
		vreg = irAllocVREG( dtype )
	else
		vreg = NULL
	end if

	if( mode <> FB.FUNCMODE.CDECL ) then
		if( mode = FB.FUNCMODE.STDCALL ) then
			if( not env.clopt.nostdcall ) then
				bytestopop = 0
			end if
		else
			bytestopop = 0
		end if
	else
		bytestopop += bytesaligned
		bytesaligned = 0
	end if

	'' call function or ptr
	p = n->l
	if( p = NULL ) then
		irEmitCALLFUNCT( proc, bytestopop, vreg )
	else
		vr = astLoad( p )
		astDel( p )
		irEmitCALLPTR( vr, vreg, bytestopop )
	end if

	if( bytesaligned > 0 ) then
		irEmitSTACKALIGN( -bytesaligned )
	end if

	'' handle strings and UDT's returned by functions that are actually pointers to
	'' string descriptors or the hidden pointer passed as the 1st argument
	select case n->dtype
	case IR.DATATYPE.STRING, IR.DATATYPE.USERDEF
		vreg = irAllocVRPTR( n->dtype, 0, vreg )
	end select

	function = vreg

end function

'':::::
private sub hCheckTmpStrings( byval f as ASTNODE ptr )
    dim as ASTNODE ptr t
    dim as integer copyback
    dim as ASTTEMPSTR ptr n, p
    dim as FBSYMBOL ptr s

	'' copy-back any fix-len string passed as parameter and
	'' delete all temp strings used as parameters
	n = f->proc.strtail
	do while( n <> NULL )

		'' copy back if needed
		if( n->srctree <> NULL ) then
        	'' only if not a literal string passed a fixed-len
        	copyback = TRUE
        	if( n->srctree->class = AST.NODECLASS.VAR ) then
        	    s = astGetSymbol( n->srctree )
        	    copyback = symbGetVarInitialized( s ) = FALSE
        	end if

        	if( copyback ) then
				t = rtlStrAssign( n->srctree, astNewVAR( n->tmpsym, NULL, 0, IR.DATATYPE.STRING ) )
				astLoad( t )
				astDel t
			end if
		end if

		'' delete the temp string
		t = rtlStrDelete( astNewVAR( n->tmpsym, NULL, 0, IR.DATATYPE.STRING ) )
		astLoad( t )
		astDel( t )

		p = n->left
		listDelNode( @ctx.tempstr, n )
		n = p
	loop

end sub

'':::::
private sub hFreeTempArrayDescs( byval f as ASTNODE ptr )
    dim as ASTNODE ptr t
    dim as ASTTEMPARRAY ptr n, p

	n = f->proc.arraytail
	do while( n <> NULL )

		t = rtlArrayFreeTempDesc( n->pdesc )
		if( t <> NULL ) then
			astLoad( t )
			astDel( t )
		end if

		p = n->left
		listDelNode( @ctx.temparray, n )
		n = p
	loop

end sub

'':::::
private sub hAllocTempStruct( byval n as ASTNODE ptr, _
							  byval proc as FBSYMBOL ptr ) static
	dim as FBSYMBOL ptr v
	dim as ASTNODE ptr p
	dim as IRVREG ptr vr
	dim as FBSYMBOL a

	'' follow GCC 3.x's ABI
	if( proc->typ = FB.SYMBTYPE.USERDEF ) then
		if( proc->proc.realtype = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.USERDEF ) then
			'' create a temp struct and pass it's address
			v = symbAddTempVar( FB.SYMBTYPE.USERDEF, proc->subtype )
        	p = astNewVar( v, NULL, 0, IR.DATATYPE.USERDEF, proc->subtype )
        	vr = astLoad( p )

        	a.typ = IR.DATATYPE.VOID
        	a.arg.mode = FB.ARGMODE.BYREF
        	irEmitPUSHPARAM( proc, @a, vr, INVALID, FB.POINTERSIZE )
		end if
	end if

end sub

'':::::
function astLoadFUNCT( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr p, np, l, pstart, pend
    dim as FBSYMBOL ptr proc, arg, lastarg
    dim as integer mode, bytestopop, toalign
    dim as integer params, inc
    dim as integer args
    dim as IRVREG ptr vr, pcvr

	'' execute each param and push the result
	proc = n->proc.sym

	pstart = n->proc.profstart
	pend   = n->proc.profend

	'' ordinary pointer?
	if( proc = NULL ) then

		'' signal function start for profiling
		if( pstart <> NULL ) then
			pcvr = astLoad( pstart )
			astDel( pstart )
		end if

		vr = hCallProc( n, NULL, INVALID, 0, 0 )

		'' signal function end for profiling
		if( pend <> NULL ) then
			irEmitPUSH( pcvr )
			proc = pend->proc.sym
			hCallProc( pend, proc, proc->proc.mode, 0, 0 )
			astDel( pend )
		end if

		return vr
	end if

    mode = proc->proc.mode

    ''
	if( mode = FB.FUNCMODE.PASCAL ) then
		params = 0
		inc = 1
	else
		params = n->proc.params
		inc = -1
	end if

	bytestopop = proc->lgt
	toalign = 0

	''
	args 	= proc->proc.args
	lastarg = proc->proc.argtail
	if( params <= args ) then
		arg = symbGetProcFirstArg( proc )
		'' vararg and param not passed?
		if( params < args ) then
			if( mode <> FB.FUNCMODE.PASCAL ) then
				arg = symbGetProcNextArg( proc, arg )
			end if

		else
#ifdef DO_STACK_ALIGN
			toalign = (16 - (bytestopop and 15)) and 15
			if( toalign > 0 ) then
				irEmitSTACKALIGN( toalign )
			end if
#endif
		end if
	'' vararg
	else
		arg = lastarg
	end if

	p = n->r
	do while( p <> NULL )
		np = p->r

		l = p->l

		''
		if( arg = lastarg ) then
			if( arg->arg.mode = FB.ARGMODE.VARARG ) then
				bytestopop += (symbCalcLen( l->dtype, NULL ) + 3) and not 3 '' x86 assumption!
			end if
		end if

		'' flush the param expression
		vr = astLoad( l )
		astDel( l )

		if( not irEmitPUSHPARAM( proc, arg, vr, p->param.mode, p->param.lgt ) ) then
			'''''return NULL
		end if

		astDel( p )

		params += inc

		if( params < args ) then
			arg = symbGetProcNextArg( proc, arg )
		end if

		p = np
	loop

	'' handle functions returning structs
	hAllocTempStruct( n, proc )

	'' signal function start for profiling
	if( pstart <> NULL ) then
		pcvr = astLoad( pstart )
		astDel( pstart )
	end if

	'' return the result (same type as function ones)
	vr = hCallProc( n, proc, mode, bytestopop, toalign )

	'' signal function end for profiling
	if( pend <> NULL ) then
		irEmitPUSH( pcvr )
		proc = pend->proc.sym
		hCallProc( pend, proc, proc->proc.mode, 0, 0 )
		astDel( pend )
	end if

	'' del temp strings and copy back if needed
	hCheckTmpStrings( n )

	'' del temp arrays descriptors created for array fields passed by desc
	hFreeTempArrayDescs( n )

    function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' IIF
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewIIF( byval condexpr as ASTNODE ptr, _
					byval truexpr as ASTNODE ptr, _
					byval falsexpr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer truedtype, falsedtype
    dim as FBSYMBOL ptr falselabel

	function = NULL

	if( condexpr = NULL ) then
		exit function
	end if

	truedtype = truexpr->dtype
	falsedtype = falsexpr->dtype

    '' string? invalid
    if( irGetDataClass( truedtype ) = IR.DATACLASS.STRING ) then
    	exit function
    elseif( irGetDataClass( falsedtype ) = IR.DATACLASS.STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( truedtype = IR.DATATYPE.USERDEF ) then
		exit function
    elseif( falsedtype = IR.DATATYPE.USERDEF ) then
    	exit function
    end if

    '' are the data types different?
    if( truedtype <> falsedtype ) then
    	if( irMaxDataType( truedtype, falsedtype ) <> INVALID ) then
    		exit function
    	end if
    end if

	falselabel = symbAddLabel( "" )

	condexpr = astUpdComp2Branch( condexpr, falselabel, FALSE )
	if( condexpr = NULL ) then
		exit function
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.IIF, truedtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l  			= truexpr
	n->r  			= falsexpr
	n->iif.falselabel = falselabel
	n->iif.cond		= condexpr

end function

'':::::
function astLoadIIF( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r
    dim as IRVREG ptr vr
    dim as FBSYMBOL ptr exitlabel

	l = n->l
	r = n->r

	exitlabel  = symbAddLabel( "" )

	''
	astFlush( n->iif.cond )

	''
	irEmitPUSH( astLoad( l ) )
	irEmitBRANCH( IR.OP.JMP, exitlabel )

    irEmitLABELNF( n->iif.falselabel )
	irEmitPUSH( astLoad( r ) )

	irEmitLABELNF( exitlabel )
	vr = irAllocVREG( n->dtype )
	irEmitPOP( vr )

	astDel( l )
	astDel( r )

	function = vr

end function
