'' AST optimizations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"
#include once "hlp.bi"


'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constant folding optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private sub hOptConstRemNeg( byval n as ASTNODE ptr )

	dim as ASTNODE ptr l = any, r = any, ll = any

	'' walk
	l = n->l
	if( l <> NULL ) then
		hOptConstRemNeg( l )
	end if

	r = n->r
	if( r <> NULL ) then
		hOptConstRemNeg( r )
	end if

	''
	''    -var + const        ->     const - var
	''
	''         BOP(+)                  BOP(-)
	''         /     \                 /   \
	''     UOP(-)    CONST    ->    CONST  VAR
	''      /
	''    VAR
	''

	if( astIsBOP( n, AST_OP_ADD ) ) then
		l = n->l
		r = n->r
		if( astIsUOP( l, AST_OP_NEG ) and astIsCONST( r ) ) then
			ll = n->l->l
			if( astIsVAR( ll ) ) then
				'' BOP(+) -> BOP(-)
				n->op.op = AST_OP_SUB
				n->l = r
				n->r = ll
				astDelNode( l )
			end if
		end if
	end if

end sub

private function hConstAccumADDSUB _
	( _
		byval n as ASTNODE ptr, _
		byref accumval as ASTNODE ptr, _
		byval sign as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	dim as integer dtype = any, o = any, rsign = any

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

		'' Inverse operation (+ vs. -) for rhs tree of '-' BOPs
		if( o = AST_OP_SUB ) then
			rsign = -sign
		else
			rsign = sign
		end if

		if( astIsCONST( r ) ) then
			'' re-using 'r'
			if( accumval ) then
				'' Do inverse op if inside the rhs tree of a '-' BOP
				if( rsign < 0 ) then
					if( o = AST_OP_ADD ) then
						o = AST_OP_SUB
					else
						o = AST_OP_ADD
					end if
				end if
				accumval = astNewBOP( o, accumval, r )
			else
				accumval = r

				'' Negate if inside the rhs of a '-' BOP
				if( rsign < 0 ) then
					accumval = astNewUOP( AST_OP_NEG, accumval )
				end if
			end if

			'' Delete the BOP node, while 'l' and 'r' are re-used
			astDelNode( n )

			'' 'l' becomes the new top node
			n = hConstAccumADDSUB( l, accumval, sign )
		else
			'' walk
			n->l = hConstAccumADDSUB( l, accumval, sign )
			n->r = hConstAccumADDSUB( r, accumval, rsign )
		end if
	end select

	function = n
end function

'':::::
private function hConstAccumMUL _
	( _
		byval n as ASTNODE ptr, _
		byref accumval as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	dim as integer dtype = any

	if( n = NULL ) then
		return NULL
	end if

	if( astIsBOP( n, AST_OP_MUL ) ) then
		l = n->l
		r = n->r

		if( astIsCONST( r ) ) then
			'' re-using 'r'
			if( accumval ) then
				accumval = astNewBOP( AST_OP_MUL, accumval, r )
			else
				accumval = r
			end if

			'' Delete the BOP node, while 'l' and 'r' are re-used
			astDelNode( n )

			'' 'l' becomes the new top node
			n = hConstAccumMUL( l, accumval )
		else
			'' walk
			n->l = hConstAccumMUL( l, accumval )
			n->r = hConstAccumMUL( r, accumval )
		end if
	end if

	function = n
end function

private function hOptConstAccum1( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l = any, r = any, accumval = any
	dim as integer o = any

	'' walk
	if( n->l ) then
		n->l = hOptConstAccum1( n->l )
	end if

	if( n->r ) then
		n->r = hOptConstAccum1( n->r )
	end if

	'' check any ADD|SUB|MUL BOP node with a constant at the right leaf and
	'' then begin accumulating the other constants at the nodes below the
	'' current, deleting any constant leaf that was added
	'' (this will handle for ex. a+1+b+2-3, that will become a+b
	if( n->class = AST_NODECLASS_BOP ) then
		r = n->r
		if( astIsCONST( r ) ) then
			accumval = NULL
			o = n->op.op

			select case( o )
			case AST_OP_ADD, AST_OP_SUB
				n = hConstAccumADDSUB( n, accumval, 1 )

				'' We checked astIsCONST( r ) above, so we'll always have an accumulated value here,
				'' but just for safety...
				if( accumval ) then
					'' (shouldn't pass hConstAccumADDSUB() as argument to astNewBOP() directly,
					'' because that could cause problems due to argument evaluation order)
					n = astNewBOP( o, n, accumval )
				end if

			case AST_OP_MUL
				n = hConstAccumMUL( n, accumval )
				if( accumval ) then
					n = astNewBOP( AST_OP_MUL, n, accumval )
				end if

			end select
		end if
	end if

	function = n
end function

private function hOptConstAccum2( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l = any, r = any, accumval = any

	'' walk
	if( n->l ) then
		n->l = hOptConstAccum2( n->l )
	end if

	if( n->r ) then
		n->r = hOptConstAccum2( n->r )
	end if

	'' check any ADD|SUB|MUL BOP node and then go to child leafs accumulating
	'' any constants found there, deleting those nodes and then add the
	'' result to a new node, at right side of the current one
	'' (this will handle for ex. a+1+(b+2)+(c+3), that will become a+b+c+6)
	if( n->class = AST_NODECLASS_BOP ) then
		accumval = NULL

		select case n->op.op
		case AST_OP_ADD
			'' don't mess with strings..
			select case as const astGetDataType( n )
			case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
				 FB_DATATYPE_WCHAR

			case else
				n = hConstAccumADDSUB( n, accumval, 1 )
				if( accumval ) then
					n = astNewBOP( AST_OP_ADD, n, accumval )
				end if
			end select

		case AST_OP_MUL
			n = hConstAccumMUL( n, accumval )
			if( accumval ) then
				n = astNewBOP( AST_OP_MUL, n, accumval )
			end if

		end select
	end if

	function = n
end function

private function hConstDistMUL _
	( _
		byval n as ASTNODE ptr, _
		byref accumval as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, r = any
	dim as integer dtype = any

	if( n = NULL ) then
		return NULL
	end if

	if( astIsBOP( n, AST_OP_ADD ) ) then
		l = n->l
		r = n->r

		if( astIsCONST( r ) ) then
			if( accumval ) then
				accumval = astNewBOP( AST_OP_ADD, accumval, r )
			else
				accumval = r
			end if

			'' Delete the BOP node, while 'l' and 'r' are re-used
			astDelNode( n )

			'' 'l' becomes the new top node
			n = hConstDistMUL( l, accumval )
		else
			n->l = hConstDistMUL( l, accumval )
			n->r = hConstDistMUL( r, accumval )
		end if
	end if

	function = n
end function

private function hOptConstDistMUL( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr accumval = any

	if( n = NULL ) then
		return NULL
	end if

	'' walk, bottom-up, to optimize children first, potentially making the
	'' transformation possible here.
	if( n->l ) then
		n->l = hOptConstDistMUL( n->l )
	end if

	if( n->r ) then
		n->r = hOptConstDistMUL( n->r )
	end if

	''
	'' Multiplication is distributive, i.e.
	''
	''      (a + b) * c
	''    = a * c + b * c
	''
	'' This optimization does exactly that transformation,
	'' but only for constant summands:
	''
	''      (a + 3 + b) * 2
	''    = (a + b) * 2 + 3 * 2
	''    = (a + b) * 2 + 6
	''
	''      (1 + a + 2 + b) * 3
	''    = (a + b) * 3 + (1 + 2) * 3
	''    = (a + b) * 3 + 3 * 3
	''    = (a + b) * 3 + 9
	''
	'' i.e. constant summands are pulled out of the inner expression,
	'' then multiplicated with the constant factor of the MUL, and then
	'' that value is ADDed back on top. The MUL is left in to handle the
	'' part of the expression with non-constant summands.
	'' (We know there are non-constant summands, because any fully constant
	'' ADD BOPs were precalculated by astNewBOP()'s constant folding)
	''
	'' This transformation can open up further optimization possibilities,
	'' for example, this:
	''      (a * 2 + 3) * 2
	''    = a * 2 * 2 + 3 * 2
	''    = a * 2 * 2 + 6
	'' will be turned into
	''    = a * 4 + 6
	'' by the constant accumulation optimizations.
	''
	'' Or, as another example, this:
	''      ((a + 1) * 2) * 3
	''    = (a * 2 + 1 * 2) * 3
	''    = (a * 2 + 2) * 3
	'' allows for the same transformation to be applied again, as a result
	'' of applying it the first time, to get:
	''    = a * 2 * 3 + 2 * 3
	''    = a * 2 * 3 + 6
	'' which will be turned into
	''    = a * 6 + 6
	'' by the constant accumulation optimizations.
	'' Applying this transformation repeatedly on the same tree however
	'' can only work when walking the tree bottom-up.
	''

	'' 1. Check for a MUL BOP node with a CONST rhs (assuming astNewBOP()
	''    swapped lhs/rhs if the CONST was on lhs, so only one thing has
	''    to be checked here)
	if( n->class = AST_NODECLASS_BOP ) then
		if( astIsCONST( n->r ) ) then
			if( n->op.op = AST_OP_MUL ) then
				'' 2. Scan the lhs for ADD BOPs with CONST rhs (hConstDistMUL())
				''  - Sums up the CONST summands of all such ADDs
				''  - Removes these ADDs (possibly leaving in other non-const summands)
				accumval = NULL
				n->l = hConstDistMUL( n->l, accumval )

				if( accumval ) then
					'' 3. Multiplicate the sum with the MUL's CONST rhs
					accumval = astNewBOP( AST_OP_MUL, accumval, astCloneTree( n->r ) )

					'' 4. Use an ADD BOP to add the result on top
					n = astNewBOP( AST_OP_ADD, n, accumval )
				end if
			end if
		end if
	end if

	function = n
end function

private sub hOptConstIdxMult( byval n as ASTNODE ptr )
	dim as integer optimize = any, c = any
	dim as ASTNODE ptr l = n->l

	''
	'' If top of tree = idx * lgt, and lgt is in the 1..9 range,
	'' then the length multiplier can be put into ASTNODE.idx.mult,
	'' allowing the x86 ASM emitter to generate better code.
	''
	'' This only works if the multiplier is 1..9 and neither 6 nor 7,
	'' see also hPrepOperand() and hGetIdxName().
	''

	if( astIsBOP(l, AST_OP_MUL ) ) then
		dim as ASTNODE ptr lr = l->r
		if( astIsCONST( lr ) ) then
			'' ASM backend?
			if( irGetOption( IR_OPT_ADDRCISC ) ) then
				'' Check whether the constant is in usable range
				'' (just casting to 32bit could break if 64bit
				'' values are given)
				c = astConstGetInt( lr )
				if( (c >= 1) and (c <= 9) ) then
					select case as const( c )
					case 1, 2, 4, 8
						'' The main multipliers supported by x86
						optimize = TRUE

					case 3, 5, 9
						'' The x86 ASM backend additionally supports 3, 5, 9,
						'' but only when accessing a global symbol, instead of one on stack.
						optimize = TRUE
						dim as FBSYMBOL ptr s = astGetSymbol( n->r )
						if( symbIsParamVar( s ) ) then
							optimize = FALSE
						elseif( symbIsLocal( s ) ) then
							if( symbIsStatic( s ) = FALSE ) then
								optimize = FALSE
							end if
						end if

					case else
						optimize = FALSE
					end select

					if( optimize ) then
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
	if( (typeGetClass( astGetDataType( l ) ) <> FB_DATACLASS_INTEGER) or _
	    (typeGetSize( astGetDataType( l ) ) <> env.pointersize) ) then
		n->l = astNewCONV( FB_DATATYPE_INTEGER, NULL, l )
	end if

end sub

function astIncOffset( byval n as ASTNODE ptr, byval ofs as longint ) as integer
	select case as const n->class
	case AST_NODECLASS_VAR
		n->var_.ofs += ofs
		function = TRUE

	case AST_NODECLASS_IDX
		n->idx.ofs += ofs
		function = TRUE

	case AST_NODECLASS_DEREF
		n->ptr.ofs += ofs
		function = TRUE

	case AST_NODECLASS_LINK
		select case n->link.ret
		case AST_LINK_RETURN_LEFT
			function = astIncOffset( n->l, ofs )
		case AST_LINK_RETURN_RIGHT
			function = astIncOffset( n->r, ofs )
		end select

	case AST_NODECLASS_FIELD, AST_NODECLASS_IIF
		function = astIncOffset( n->l, ofs )

	case AST_NODECLASS_CONV
		'' There can be CONV nodes here, in cases like:
		''      dim as integer i(0 to 1)
		''      print *(@cast(long, i(0)) + offset)
		''
		'' (when 1. the cast() is added because it's a different dtype,
		'' and 2. the @ accepts the cast() because it's doconv = FALSE
		'' because the dtypes are similar enough/have the same size,
		'' and 3. the offset is <> 0)
		''
		'' but also field access after upcasting of derived UDTs:
		''      print cast(BaseUDT, udt).foo
		'' if foo's offset is <> 0.

		if (n->cast.doconv = FALSE) then
			function = astIncOffset( n->l, ofs )
		else
			function = FALSE
		end if

	case else
		function = FALSE
	end select
end function

private function hOptDerefAddr( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l = n->l
	dim as longint ofs = 0

	select case l->class
	case AST_NODECLASS_OFFSET
		'' newBOP() will optimize ofs + const nodes, but we can't use the full
		'' ofs.ofs value because it has computed already the child's (var/idx) ofs
		ofs = l->ofs.ofs - astGetOFFSETChildOfs( l->l )

	case AST_NODECLASS_ADDROF

	case else
		return n
	end select

	assert( astIsDEREF(n) )
	ofs += n->ptr.ofs

	'' DEREF(ADDROF(VAR(x, ofs=A)       ), ofs=B)    =>    VAR(x, ofs=A+B)
	'' DEREF(OFFSET(VAR(x, ofs=A), ofs=C), ofs=B)    =>    VAR(x, ofs=A+B+C)
	'' (also, astIncOffset() handles more than just VARs)

	'' If the deref uses an <> 0 offset then try to include that into
	'' any child var/idx/deref nodes. If that's not possible, then this
	'' optimization can't be done.
	'' Note: we must do this check even if ofs = 0, to ensure it's ok to
	'' do the astSetType() below.
	if( astIncOffset( l->l, ofs ) = FALSE ) then
		return n
	end if

	dim as integer dtype = astGetFullType( n )
	dim as FBSYMBOL ptr subtype = n->subtype

	astDelNode( n )
	n = l->l
	astDelNode( l )

	astSetType( n, dtype, subtype )

	function = n
end function

private function hOptConstIDX( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l = any, r = any, accumval = any
	dim as longint c = any

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
		if( n->l ) then
			accumval = NULL
			n->l = hConstAccumADDSUB( n->l, accumval, 1 )

			if( accumval ) then
				c = astConstFlushToInt( accumval )
				if( n->class = AST_NODECLASS_IDX ) then
					n->idx.ofs += c * n->idx.mult
				else
					n->ptr.ofs += c
				end if
			end if

			'' remove l node if it's a const and add it to parent's offset
			if( astIsCONST( n->l ) ) then
				c = astConstFlushToInt( n->l )
				n->l = NULL
				if( n->class = AST_NODECLASS_IDX ) then
					n->idx.ofs += c * n->idx.mult
				else
					n->ptr.ofs += c
				end if
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
	if( astIsBOP( n, AST_OP_MUL ) ) then
		r = n->r
		if( astIsBOP( r, AST_OP_MUL ) ) then
			n_old = n

			'' n = (( n->l, r->l ), r->r)
			n = astNewBOP( AST_OP_MUL, _
			               astNewBOP( AST_OP_MUL, n->l, r->l ), _
			               r->r )

			astDelNode( r )
			astDelNode( n_old )
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

	bits = typeGetBits( dtype ) - 1
	'' bytes are converted to int's..
	if( bits = 7 ) then
		bits = typeGetBits( FB_DATATYPE_INTEGER ) - 1
	end if

	l_cpy = astCloneTree( l )

	if( const_val = 1 ) then
		'' n + ( cunsg(n) shr bits )
		n->l = astNewCONV( dtype, NULL, _
				astNewBOP( AST_OP_ADD, _
					l_cpy, _
					astNewBOP( AST_OP_SHR, _
						astNewCONV( typeToUnsigned( dtype ), NULL, l, AST_CONVOPT_SIGNCONV ), _
						astNewCONSTi( bits ) ) ), _
				AST_CONVOPT_SIGNCONV )
	else
		'' n + ( (n shr bits) and (1 shl const_val - 1) )
		n->l = astNewCONV( dtype, NULL, _
				astNewBOP( AST_OP_ADD, _
					l_cpy, _
					astNewBOP( AST_OP_AND, _
						astNewBOP( AST_OP_SHR, _
							l, _
							astNewCONSTi( bits ) ), _
						astNewCONSTi( 1 shl const_val - 1 ) ) ), _
				AST_CONVOPT_SIGNCONV )
	end if

	n->op.op = AST_OP_SHR
	astConstGetInt( n->r ) = const_val

end sub

private function hToPow2( byval v as ulongint ) as integer
	'' Is it a power of 2? (2/4/8/16/32/...)
	for i as integer = 1 to 63
		if( v = (1ull shl i) ) then
			'' return the exponent of the power of 2 (1/2/3/4/5/...)
			return i
		end if
	next
	function = 0
end function

private sub hOptToShift( byval n as ASTNODE ptr )
	dim as ASTNODE ptr l = any, r = any
	dim as integer op = any, exponent = any
	dim as longint value = any

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

			'' BOP result must be an integer, so no floats are involved
			if( typeGetClass( n->dtype ) <> FB_DATACLASS_INTEGER ) then
				exit select
			end if

			'' The rhs must be an integer constant > 0
			'' (doesn't matter whether it's signed or unsigned)
			if( astIsCONST( r ) = FALSE ) then
				exit select
			end if
			value = astConstGetInt( r )
			if( (value = 0) or _
			    ((value < 0) and typeIsSigned( astGetFullType( r ) )) ) then
				exit select
			end if

			'' Get the exponent if it's a power of 2
			exponent = hToPow2( value )
			if( exponent <= 0 ) then
				exit select
			end if

			select case op
			case AST_OP_MUL
				if( exponent > typeGetBits( n->l->dtype ) ) then
					exit select, select
				end if

				n->op.op = AST_OP_SHL
				astConstGetInt( r ) = exponent

			case AST_OP_INTDIV
				if( exponent > typeGetBits( n->l->dtype ) ) then
					exit select, select
				end if

				if( typeIsSigned( n->l->dtype ) = FALSE ) then
					n->op.op = AST_OP_SHR
					astConstGetInt( r ) = exponent
				else
					hDivToShift_Signed( n, exponent )
				end if

			case AST_OP_MOD
				'' unsigned types only
				if( typeIsSigned( astGetDataType( n->l ) ) ) then
					exit select, select
				end if

				n->op.op = AST_OP_AND
				astConstGetInt( r ) -= 1
			end select
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
private function hOptConstCONV _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, n_old = any
	dim as longint v = any

	if( n = NULL ) then
		return NULL
	end if

	'' hOptNullOp() might leave behind some conversion nodes
	'' after elimintating the NULL operations
	''
	'' convert CAST( <int-type2>, <int-type1>0 ) to ( <int-type2>0 )
	''
	'' no need to call recursively since hOptNullOp() will do that

	if( n->class = AST_NODECLASS_CONV ) then
		l = n->l
		if( l->class = AST_NODECLASS_CONST ) then
			if( typeGetClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then
				if( typeGetClass( astGetDataType( l ) ) = FB_DATACLASS_INTEGER ) then
					if( astIsCONST( l ) ) then
						v = astConstGetInt( l )

						if( v = 0 ) then
							n_old = n

							n = astNewCONSTi( v, n->dtype, n->subtype )

							astDelNode( l )
							astDelNode( n_old )
						end if
					end if
				end if
			end if
		end if
	end if
	function = n

end function

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
		return NULL
	end if

	'' Eliminate nops in child nodes first, then perhaps we can eliminate
	'' the current (parent) one too.
	n->l = hOptNullOp( n->l )
	n->r = hOptNullOp( n->r )

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
		keep_l = astHasSideFx( l )
		keep_r = astHasSideFx( r )

		if( typeGetClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then
			if( astIsCONST( r ) ) then
				v = astConstGetInt( r )

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
						return l
					end if

				case AST_OP_MOD
					if( ( v = 1 ) or ( ( v = -1 ) and ( typeIsSigned( astGetDataType( r ) ) <> FALSE ) ) ) then
						if( keep_l = FALSE ) then
							astConstGetInt( r ) = 0
							astDelTree( l )
							astDelNode( n )
							return r
						end if

					end if

				case AST_OP_INTDIV
					if( v = 1 ) then
						astDelNode( r )
						astDelNode( n )
						return l
					end if

				case AST_OP_ADD, AST_OP_SUB, _
					 AST_OP_SHR, AST_OP_SHL, _
					 AST_OP_XOR
					if( v = 0 ) then
						astDelNode( r )
						astDelNode( n )
						return l
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
						return l
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
						return l
					elseif( v = 0 ) then
						if( keep_l = FALSE ) then
							astDelTree( l )
							astDelNode( n )
							return r
						end if
					end if

				end select

			elseif( astIsCONST( l ) ) then
				v = astConstGetInt( l )

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

	function = hOptConstCONV( n )
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

	if( typeGetClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then
		if( astIsUOP( n, AST_OP_NOT ) ) then
			if( astIsUOP( l, AST_OP_NOT ) ) then
				'' convert NOT NOT x to x
				m = l->l
				astDelNode( l )
				astDelNode( n )
				n = hOptLogic( m )
			elseif( astIsBOP( l, AST_OP_XOR ) ) then
				if( typeGetClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then
					if( astIsCONST( l->l ) ) then
						'' convert:
						'' not (const xor x)    to    (not const) xor x
						astConstGetInt( l->l ) = not astConstGetInt( l->l )
						astDelNode( n )
						n = hOptLogic( l )
					elseif( astIsCONST( l->r ) ) then
						'' convert:
						'' not (x xor const)    to    x xor (not const)
						astConstGetInt( l->r ) = not astConstGetInt( l->r )
						astDelNode( n )
						n = hOptLogic( l )
					end if
				end if
			end if
		elseif( n->class = AST_NODECLASS_BOP ) then
			if( typeGetClass( astGetDataType( n ) ) = FB_DATACLASS_INTEGER ) then
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

					if( astIsUOP(l, AST_OP_NOT) and astIsUOP(r, AST_OP_NOT) ) then

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

					elseif( astIsCONST( l ) and astisUOP(r, AST_OP_NOT) ) then
						'' convert:
						'' const and (not x)    to    not ((not const) or  x)
						'' const or  (not x)    to    not ((not const) and x)
						'' const xor (not x)    to    (not const) xor x

						v = astConstGetInt( l )
						m = astNewBOP( op, l, r->l )
						astConstGetInt( l ) = not v

						if( op <> AST_OP_XOR ) then
							m = astNewUOP( AST_OP_NOT, m )
						end if

						astDelNode( r )
						astDelNode( n )
						n = m

					elseif( astIsConst( r ) and astIsUOP(l, AST_OP_NOT) ) then
						'' convert:
						'' (not x) and const    to    not (x or  (not const))
						'' (not x) or  const    to    not (x and (not const))
						'' (not x) xor const    to    x xor (not const)

						v = astConstGetInt( r )
						m = astNewBOP( op, l->l, r )
						astConstGetInt( r ) = not v

						if( op <> AST_OP_XOR ) then
							m = astNewUOP( AST_OP_NOT, m )
						end if

						astDelNode( l )
						astDelNode( n )
						n = m

					elseif( (op = AST_OP_XOR) and astIsUOP(l, AST_OP_NOT) ) then
						'' convert:
						'' (not x) xor y    to    not (x xor y)
						m = astNewUOP( AST_OP_NOT, n )
						n->l = l->l
						astDelNode( l )
						n = m
					elseif( (op = AST_OP_XOR) and astIsUOP(r, AST_OP_NOT) ) then
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

private function hDoOptRemConv( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l = any, r = any
	dim as integer dorem = any

	if( n = NULL ) then
		return NULL
	end if

	'' convert l{float} op cast(float, r{var}) to l op r
	''
	'' For example:
	''    dim f as single, i as integer
	''    print f + cast( single, i )
	''
	'' The cast can be optimized out, because the x86 FPU's fiadd, fisub,
	'' fimul, fidiv instructions can work with integer operands directly,
	'' so we don't need to convert integer to float first and then do
	'' regular float+float BOPs afterwards.
	''
	'' Apparently these instructions only support 16bit and 32bit memory
	'' operands though, thus BYTEs and LONGINTs have to be disallowed below.
	''
	'' This all is only useful for the ASM backend since it's making
	'' assumptions about the x86 FPU. For the other backends, we can aswell
	'' do the cast, ensure we're getting the behaviour we want, and let
	'' gcc/llvm worry about good code generation.

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

						'' Note: should not skip noconv CASTs here,
						'' because it could be a sign conversion such as
						'' from integer VAR to uinteger. Without that CAST
						'' to unsigned, it would pass the signed check below,
						'' and then a signed operation would be done while
						'' an unsigned one was intended.

						'' Disallow BYTEs and LONGINTs
						select case( typeGetSize( astGetDataType( l ) ) )
						case 2, 4
							dorem = FALSE

							select case( l->class )
							case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
								 AST_NODECLASS_FIELD, AST_NODECLASS_DEREF
								'' can't be unsigned either
								if( typeIsSigned( astGetDataType( l ) ) ) then
									dorem = TRUE
								end if
							end select

							if( dorem ) then
								astDelNode( r )
								n->r = l
							end if
						end select
					end select
				end if
			end if
		end select
	end if

	'' walk
	n->l = hDoOptRemConv( n->l )
	n->r = hDoOptRemConv( n->r )

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
					lnk = astNewLINK( lnk, _
						rtlStrConcatAssign( astCloneTree( dst ), _
						n->l ), AST_LINK_RETURN_NONE )
				else
					lnk = astNewLINK( lnk, _
						rtlWstrConcatAssign( astCloneTree( dst ), _
						n->l ), AST_LINK_RETURN_NONE )
				end if
			end if
		end if

		if( n->r <> NULL ) then
			if( is_wstr = FALSE ) then
				lnk = astNewLINK( lnk, _
					rtlStrConcatAssign( astCloneTree( dst ), _
					n->r ), AST_LINK_RETURN_NONE )
			else
				lnk = astNewLINK( lnk, _
					rtlWstrConcatAssign( astCloneTree( dst ), _
					n->r ), AST_LINK_RETURN_NONE )
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
					n ), AST_LINK_RETURN_NONE )
			else
				lnk = astNewLINK( lnk, _
					rtlWstrConcatAssign( astCloneTree( dst ), _
					n ), AST_LINK_RETURN_NONE )
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
				if (symbIsParamVarBydescOrByref(sym) = FALSE) then
					function = (astIsSymbolOnTree( sym, r ) = FALSE)
				end if
			end if

		case AST_NODECLASS_FIELD, AST_NODECLASS_IIF
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

private function hOptStrAssignment _
	( _
		byval n as ASTNODE ptr, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

	dim as integer optimize = any, is_byref = any, is_wstr = any

	optimize = FALSE
	is_byref = FALSE

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
					if (symbIsParamVarBydescOrByref(sym) = FALSE) then
						optimize = astIsSymbolOnTree( sym, r->r ) = FALSE
					end if
				end if
			end if

		case AST_NODECLASS_DEREF
			'' check if we can optimize to fb_StrConcatByref()
			'' - look specifically for a = a + b where both a & b are STRINGS where we
			''   won't necessarily know until run time if a & b could be the same descriptorknow until run time if a and b could be the same descriptor.
			'' - but don't optimize a = a + a since we must make a copy anyway
			''
			''
			if( astIsTreeEqual( l, r->l ) ) then
				sym = astGetSymbol( l->l )
				if( sym <> NULL ) then
					if( astGetDataType( l ) = FB_DATATYPE_STRING ) then
						optimize = astIsSymbolOnTree( sym, r->r ) = FALSE
						is_byref = TRUE
					end if
				end if
			end if

		case AST_NODECLASS_FIELD, AST_NODECLASS_IIF
			select case as const l->l->class
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX

				if( astIsTreeEqual( l, r->l ) ) then
					sym = astGetSymbol( l )
					if( sym <> NULL ) then
						if( astGetDataType( l ) = FB_DATATYPE_STRING ) then
							is_byref = TRUE
						end if
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
			''  =            f() -- concatassign | concatbyref
			'' / \           / \
			''a   +    =>   a   expr
			''   / \
			''  a   expr
			if( is_wstr = FALSE ) then
				function = rtlStrConcatAssign( l, astUpdStrConcat( r ), is_byref )
			else
				function = rtlWstrConcatAssign( l, astUpdStrConcat( r ) )
			end if
		end if
	else
		'' convert "a = b + c + d" to "a = b: a += c: a += d"
		if( hIsMultStrConcat( l, r ) ) then
			function = hOptStrMultConcat( NULL, l, r, is_wstr )
		else
			''  =            f() -- assign
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

function astOptAssignment( byval n as ASTNODE ptr ) as ASTNODE ptr
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
	case AST_NODECLASS_LINK, AST_NODECLASS_LOOP
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

	dclass = typeGetClass( dtype )
	if( dclass = FB_DATACLASS_INTEGER ) then
		if( irGetOption( IR_OPT_CPUSELFBOPS ) = FALSE ) then
			exit function
		end if
	else
		if( irGetOption( IR_OPT_FPUSELFBOPS ) = FALSE ) then
			'' try to optimize if a constant is being assigned to a float var
			if( astIsCONST( r ) ) then
				if( dclass = FB_DATACLASS_FPOINT ) then
					if( typeGetClass( astGetDataType( r ) ) <> FB_DATACLASS_FPOINT ) then
						n->r = astNewCONV( dtype, NULL, r )
					end if
				end if
			end if

			exit function
		end if
	end if

	'' can't be byte either, as BOP will do cint(byte) op cint(byte)
	if( typeGetSize( dtype ) = 1 ) then
		exit function
	end if

	'' is left side a var, idx or ptr?

	'' We can do the optimization even if there are casts, but only if they are no-conv casts
	''    dim i as integer = ...
	'' rhs cast examples (common):
	''    i = cbyte(i + 1)   <- should not just become i += 1
	''    i = clng(i + 1)    <- this is a noconv cast on 32bit, but not 64bit
	''    i = cuint(i + 1)   <- noconv cast
	'' lhs cast examples (uncommon):
	''    cbyte(i) = i + 1   <- syntax error
	''    cuint(i) = i + 1   <- allowed noconv cast
	''    clng(i) = i + 1    <- allowed noconv cast on 32bit, syntax error on 64bit
	var lnocast = astSkipNoConvCAST( l )
	var rnocast = astSkipNoConvCAST( r )

	select case as const lnocast->class
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_DEREF, _
	     AST_NODECLASS_IIF

	case AST_NODECLASS_FIELD
		'' isn't it a bitfield?
		if( symbFieldIsBitfield( lnocast->sym ) ) then
			exit function
		end if

	case else
		exit function
	end select

	'' is right side an unary or binary operation?
	select case rnocast->class
	case AST_NODECLASS_UOP

	case AST_NODECLASS_BOP
		'' can't be a relative op -- unless EMIT is changed to not assume
		'' the res operand is a reg
		if( astOpIsRelational( rnocast->op.op ) ) then
			exit function
		end if

	case else
		exit function
	end select

	'' node result is an integer too?
	if( typeGetClass( astGetDataType( rnocast ) ) <> FB_DATACLASS_INTEGER ) then
		exit function
	end if

	'' is the UOP/BOP's lhs operand the same as the ASSIGN's lhs?
	'' There may be a noconv cast here too, for example:
	''    i = cuint(i) + 1
	if( astIsTreeEqual( lnocast, astSkipNoConvCAST( rnocast->l ) ) = FALSE ) then
		exit function
	end if

	'' delete assign node and alert UOP/BOP to not allocate a result (IR is aware)
	rnocast->op.options and= not AST_OPOPT_ALLOCRES

	''  =             o
	'' / \           / \
	''d   o     =>  d   expr
	''   / \
	''  d   expr

	astDelNode( n )
	astDelTree( l )
	if( r <> rnocast ) then
		'' If r had a noconv cast, delete that too, so the UOP/BOP ends up at toplevel
		astDelNode( r )
		r = rnocast
	end if

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
	if( astIsBOP( n, AST_OP_DIV ) ) then
		l = n->l
		if( astIsCONST( l ) ) then
			if( (astGetDataType( l ) = FB_DATATYPE_SINGLE) andalso (astConstGetFloat( l ) = 1.0) ) then
				r = n->r
				select case as const astGetDataClass( r )
				case FB_DATACLASS_INTEGER, FB_DATACLASS_FPOINT
					if( astIsUOP( r, AST_OP_SQRT ) ) then
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
				end select
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

function astOptimizeTree( byval n as ASTNODE ptr ) as ASTNODE ptr
	'' The order of calls below matters!

	astBeginHideWarnings( )

	n = hOptAssocADD( n )

	n = hOptAssocMUL( n )

	n = hOptConstDistMUL( n )

	n = hOptConstAccum1( n )

	n = hOptConstAccum2( n )

	hOptConstRemNeg( n )

	n = hOptConstIDX( n )

	hOptToShift( n )

	n = hOptLogic( n )

	n = hOptNullOp( n )

	n = hOptSelfAssign( n )

	n = hOptSelfCompare( n )

	if( (irGetOption( IR_OPT_FPUCONV ) = FALSE) and _
	    (env.clopt.backend = FB_BACKEND_GAS) ) then
		n = hDoOptRemConv( n )
	end if

	'' (not even checking irSupportsOp() here, because neither
	'' C/LLVM backends support reciprocal ops)
	if( irGetOption( IR_OPT_MISSINGOPS ) = FALSE ) then
		if( env.clopt.fpmode = FB_FPMODE_FAST ) then
			n = hOptReciprocal( n )
		end if
	end if

	astEndHideWarnings( )

	function = n
end function
