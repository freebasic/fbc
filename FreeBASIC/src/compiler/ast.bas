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

type ASTCTX
	head			as integer
	tail			as integer
	fhead			as integer
	nodes			as integer

	tempstr			as TLIST
	temparray		as TLIST
end Type

type ASTVALUE
	dtype			as integer
	union
		value		as double
		value64		as longint
	end union
end type


declare function	astUpdStrConcat		( byval n as integer ) as integer

'' globals
	dim shared ctx as ASTCTX

	dim shared astTB( ) as ASTNODE

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constant folding optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astOptConstRmNeg( byval n as integer, _
					  byval p as integer )
	static as integer l, r

	'' check any UOP node, and if its of the kind "-var + const" convert to "const - var"
	if( p <> INVALID ) then
		if( astTB(n).class = AST.NODECLASS.UOP ) then
			if( astTB(n).op = IR.OP.NEG ) then
				l = astTB(n).l
				if( astTB(l).class = AST.NODECLASS.VAR ) then
					if( astTB(p).class = AST.NODECLASS.BOP ) then
						if( astTB(p).op = IR.OP.ADD ) then
							r = astTB(p).r
							if( astTB(r).defined ) then
								astTB(p).op = IR.OP.SUB
								astTB(p).l = astTB(p).r
								astTB(p).r = astTB(n).l
								astDel n
								exit sub
							end if
						end if
					end if
				end if
		    end if
		end if
	end if

	'' walk
	l = astTB(n).l
	if( l <> INVALID ) then
		astOptConstRmNeg( l, n )
	end if

	r = astTB(n).r
	if( r <> INVALID ) then
		astOptConstRmNeg( r, n )
	end if

end sub

''::::::
private function hPrepConst( v as ASTVALUE, _
							 byval r as ASTNODE ptr ) as integer static
	dim as integer dtype

	'' first node? just copy..
	if( v.dtype = INVALID ) then
		v.dtype = r->dtype
		if( (v.dtype = IR.DATATYPE.LONGINT) or (v.dtype = IR.DATATYPE.ULONGINT) ) then
			v.value64 = r->value64
		else
            v.value = r->value
		end if

		return INVALID
	end if

    ''
	dtype = irMaxDataType( v.dtype, r->dtype )

	'' same? don't convert..
	if( dtype = INVALID ) then
		return v.dtype
	end if

	'' convert r to v's type
	if( dtype = v.dtype ) then
		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
			if( (r->dtype <> IR.DATATYPE.LONGINT) and (r->dtype <> IR.DATATYPE.ULONGINT) ) then
				r->value64 = clngint( r->value )
			end if
		else
			if( (r->dtype = IR.DATATYPE.LONGINT) or (r->dtype = IR.DATATYPE.ULONGINT) ) then
				r->value = cdbl( r->value64 )
			end if
		end if

	'' convert v to r's type
	else
		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
			if( (v.dtype <> IR.DATATYPE.LONGINT) and (v.dtype <> IR.DATATYPE.ULONGINT) ) then
				v.value64 = clngint( v.value )
			end if
		else
			if( (v.dtype = IR.DATATYPE.LONGINT) or (v.dtype = IR.DATATYPE.ULONGINT) ) then
				v.value = cdbl( v.value64 )
			end if
		end if

		v.dtype = dtype
	end if

	return dtype

end function

'':::::
function asthConstAccumADDSUB( byval n as integer, _
							   v as ASTVALUE, _
							   byval op as integer ) as integer
	dim as integer l, r, o
	static as integer dtype

	if( n = INVALID ) then
		return INVALID
	end if

	if( astTB(n).class <> AST.NODECLASS.BOP ) then
		return n
	end if

    o = astTB(n).op

	select case o
	case IR.OP.ADD, IR.OP.SUB
		l = astTB(n).l
		r = astTB(n).r

		if( astTB(r).defined ) then

			if( op < 0 ) then
				if( o = IR.OP.ADD ) then
					o = IR.OP.SUB
				else
					o = IR.OP.ADD
				end if
			end if

			dtype = hPrepConst( v, @astTB(r) )

			if( dtype <> INVALID ) then
				select case o
				case IR.OP.ADD
					if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
						v.value64 += astTB(r).value64
					else
				    	v.value += astTB(r).value
					end if

				case IR.OP.SUB
					if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
						v.value64 -= astTB(r).value64
					else
						v.value -= astTB(r).value
					end if
				end select
			end if

			'' del BOP and const node
			astDel r
			astDel n

			'' top node is now the left one
			n = asthConstAccumADDSUB( l, v, op )

		else
			'' walk
			astTB(n).l = asthConstAccumADDSUB( l, v, op )

			if( o = IR.OP.SUB ) then
				op = -op
			end if

			astTB(n).r = asthConstAccumADDSUB( r, v, op )
		end if
	end select

	return n

end function

'':::::
function asthConstAccumMUL( byval n as integer, _
							v as ASTVALUE ) as integer
	dim as integer l, r
	static as integer dtype

	if( n = INVALID ) then
		return INVALID
	end if

	if( astTB(n).class <> AST.NODECLASS.BOP ) then
		return n
	end if

	if( astTB(n).op = IR.OP.MUL ) then
		l = astTB(n).l
		r = astTB(n).r

		if( astTB(r).defined ) then

			dtype = hPrepConst( v, @astTB(r) )

			if( dtype <> INVALID ) then
				if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
					v.value64 *= astTB(r).value64
				else
					v.value *= astTB(r).value
				end if
			end if

			'' del BOP and const node
			astDel r
			astDel n

			'' top node is now the left one
			n = asthConstAccumMUL( l, v )

		else
			'' walk
			astTB(n).l = asthConstAccumMUL( l, v )
			astTB(n).r = asthConstAccumMUL( r, v )
		end if
	end if

	return n

end function

'':::::
function astOptConstAccum1( byval n as integer ) as integer
	static as integer l, r, nn
	static as ASTVALUE v

	if( n = INVALID ) then
		return INVALID
	end if

	'' check any ADD|SUB|MUL BOP node with a constant at the right leaf and
	'' then begin accumulating the other constants at the nodes below the
	'' current, deleting any constant leaf that were added
	'' (this will handle for ex. a+1+b+2-3, that will become a+b
	if( astTB(n).class = AST.NODECLASS.BOP ) then
		r = astTB(n).r
		if( astTB(r).defined ) then

			select case as const astTB(n).op
			case IR.OP.ADD
				v.dtype = INVALID
				n = asthConstAccumADDSUB( n, v, 1 )

				if( (v.dtype = IR.DATATYPE.LONGINT) or (v.dtype = IR.DATATYPE.ULONGINT) ) then
					nn = astNewCONST64( v.value64, v.dtype )
				else
					nn = astNewCONST( v.value, v.dtype )
				end if

				n = astNewBOP( IR.OP.ADD, n, nn )

			case IR.OP.MUL
				v.dtype = INVALID
				n = asthConstAccumMUL( n, v )

				if( (v.dtype = IR.DATATYPE.LONGINT) or (v.dtype = IR.DATATYPE.ULONGINT) ) then
					nn = astNewCONST64( v.value64, v.dtype )
				else
					nn = astNewCONST( v.value, v.dtype )
				end if

				n = astNewBOP( IR.OP.MUL, n, nn )

            case IR.OP.SUB
				v.dtype = INVALID
				n = asthConstAccumADDSUB( n, v, -1 )

				if( (v.dtype = IR.DATATYPE.LONGINT) or (v.dtype = IR.DATATYPE.ULONGINT) ) then
					nn = astNewCONST64( v.value64, v.dtype )
				else
					nn = astNewCONST( v.value, v.dtype )
				end if

				n = astNewBOP( IR.OP.SUB, n, nn )

			end select

		end if
	end if

	'' walk
	l = astTB(n).l
	if( l <> INVALID ) then
		astTB(n).l = astOptConstAccum1( l )
	end if

	r = astTB(n).r
	if( r <> INVALID ) then
		astTB(n).r = astOptConstAccum1( r )
	end if

	return n

end function

'':::::
sub astOptConstAccum2( byval n as integer )
	static as integer l, r, dtype, checktype
	static as ASTVALUE v

	'' check any ADD|SUB|MUL BOP node and then go to child leafs accumulating
	'' any constants found there, deleting those nodes and then adding the
	'' result to a new node, at right side of the current one
	'' (this will handle for ex. a+1+(b+2)+(c+3), that will become a+b+c+6)
	if( astTB(n).class = AST.NODECLASS.BOP ) then

		checktype = FALSE

		select case astTB(n).op
		case IR.OP.ADD
			if( irGetDataClass( astTB(n).dtype ) <> IR.DATACLASS.STRING ) then

				v.dtype = INVALID
				astTB(n).l = asthConstAccumADDSUB( astTB(n).l, v, 1 )
				astTB(n).r = asthConstAccumADDSUB( astTB(n).r, v, 1 )

				if( v.dtype <> INVALID ) then
					astTB(n).l = astNewBOP( IR.OP.ADD, astTB(n).l, astTB(n).r )
					if( (v.dtype = IR.DATATYPE.LONGINT) or (v.dtype = IR.DATATYPE.ULONGINT) ) then
						astTB(n).r = astNewCONST64( v.value64, v.dtype )
					else
						astTB(n).r = astNewCONST( v.value, v.dtype )
					end if
					checktype = TRUE
				end if
			end if

		'case IR.OP.SUB
		'	c = 0
		'	asthConstAccumADDSUB astTB(n).l, c, -1
		'	asthConstAccumADDSUB astTB(n).r, c, -1
		'	if( c <> 0 ) then
		'		if( c - int(c) <> 0 ) then
		'			dtype = IR.DATATYPE.DOUBLE
		'		else
		'			dtype = IR.DATATYPE.INTEGER
		'		end if
		'		astTB(n).l = astNewBOP( IR.OP.SUB, astTB(n).l, astTB(n).r )
		'		astTB(n).op = IR.OP.ADD
		'		astTB(n).r = astNewCONST( c, dtype )
		'		checktype = TRUE
		'	end if

		case IR.OP.MUL

			v.dtype = INVALID
			astTB(n).l = asthConstAccumMUL( astTB(n).l, v )
			astTB(n).r = asthConstAccumMUL( astTB(n).r, v )

			if( v.dtype <> INVALID ) then
				astTB(n).l = astNewBOP( IR.OP.MUL, astTB(n).l, astTB(n).r )
				if( (v.dtype = IR.DATATYPE.LONGINT) or (v.dtype = IR.DATATYPE.ULONGINT) ) then
					astTB(n).r = astNewCONST64( v.value64, v.dtype )
				else
					astTB(n).r = astNewCONST( v.value, v.dtype )
				end if
				checktype = TRUE
			end if
        end select

		if( checktype ) then
			'' update the node data type
			l = astTB(n).l
			r = astTB(n).r
			dtype = irMaxDataType( astTB(l).dtype, astTB(r).dtype )
			if( dtype <> INVALID ) then
				if( dtype <> astTB(l).dtype ) then
					astTB(n).l = astNewCONV( INVALID, dtype, l )
				else
					astTB(n).r = astNewCONV( INVALID, dtype, r )
				end if
				astTB(n).dtype = dtype
			else
				astTB(n).dtype = astTB(l).dtype
			end if
		end if

	end if

	'' walk
	l = astTB(n).l
	if( l <> INVALID ) then
		astOptConstAccum2( l )
	end if

	r = astTB(n).r
	if( r <> INVALID ) then
		astOptConstAccum2( r )
	end if

end sub

'':::::
function asthConstDistMUL( byval n as integer, _
						   v as ASTVALUE ) as integer
	dim as integer l, r
	static as integer dtype

	if( n = INVALID ) then
		return INVALID
	end if

	if( astTB(n).class <> AST.NODECLASS.BOP ) then
		return n
	end if

	if( astTB(n).op = IR.OP.ADD ) then
		l = astTB(n).l
		r = astTB(n).r

		if( astTB(r).defined ) then

			dtype = hPrepConst( v, @astTB(r) )

			if( dtype <> INVALID ) then
				if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
					v.value64 += astTB(r).value64
				else
					v.value += astTB(r).value
				end if
			end if

			'' del BOP and const node
			astDel r
			astDel n

			'' top node is now the left one
			n = asthConstDistMUL( l, v )

		else
			astTB(n).l = asthConstDistMUL( l, v )
			astTB(n).r = asthConstDistMUL( r, v )
		end if
	end if

	return n

end function

'':::::
function astOptConstDistMUL( byval n as integer ) as integer
	static l as integer, r as integer
	static v as ASTVALUE

	if( n = INVALID ) then
		return INVALID
	end if

	'' check any MUL BOP node with a constant at the right leaf and then scan
	'' the left leaf for ADD BOP nodes, applying the distributive, deleting those
	'' nodes and adding the result of all sums to a new node
	'' (this will handle for ex. 2 * (3 + a * 2) that will become 6 + a * 4 (with Accum2's help))
	if( astTB(n).class = AST.NODECLASS.BOP ) then
		r = astTB(n).r
		if( astTB(r).defined ) then
			if( astTB(n).op = IR.OP.MUL ) then

				v.dtype = INVALID
				astTB(n).l = asthConstDistMUL( astTB(n).l, v )

				if( v.dtype <> INVALID ) then
					if( (v.dtype = IR.DATATYPE.LONGINT) or (v.dtype = IR.DATATYPE.ULONGINT) ) then

						if( (astTB(r).dtype = IR.DATATYPE.LONGINT) or (astTB(r).dtype = IR.DATATYPE.ULONGINT) ) then
							v.value64 *= astTB(r).value64
						else
							v.value64 *= clngint( astTB(r).value )
						end if

						n = astNewBOP( IR.OP.ADD, n, astNewCONST64( v.value64, v.dtype ) )

					else
						if( (astTB(r).dtype = IR.DATATYPE.LONGINT) or (astTB(r).dtype = IR.DATATYPE.ULONGINT) ) then
							v.value *= cdbl( astTB(r).value64 )
						else
							v.value *= astTB(r).value
						end if
						n = astNewBOP( IR.OP.ADD, n, astNewCONST( v.value, v.dtype ) )
					end if
				end if

			end if
		end if
	end if

	'' walk
	l = astTB(n).l
	if( l <> INVALID ) then
		astTB(n).l = astOptConstDistMUL( l )
	end if

	r = astTB(n).r
	if( r <> INVALID ) then
		astTB(n).r = astOptConstDistMUL( r )
	end if

	return n

end function

'':::::
sub astOptConstIDX( byval n as integer )
	static l as integer, r as integer, c as integer, lr as integer
	static v as ASTVALUE

	if( n = INVALID ) then
		exit sub
	end if

	'' opt must be done in this order: addsub accum and then idx * lgt
	select case astTB(n).class
	case AST.NODECLASS.IDX, AST.NODECLASS.PTR
		l = astTB(n).l
		if( l <> INVALID ) then
			v.dtype = INVALID
			astTB(n).l = asthConstAccumADDSUB( l, v, 1 )

        	if( v.dtype <> INVALID ) then
        		if( (v.dtype = IR.DATATYPE.LONGINT) or (v.dtype = IR.DATATYPE.ULONGINT) ) then
        			c = cint( v.value64 )
        		else
        			c = cint( v.value )
        		end if

        		if( astTB(n).class = AST.NODECLASS.IDX ) then
        			astTB(n).idx.ofs += c
        		else
        			astTB(n).ptr.ofs += c
        		end if
        	end if

        	'' remove l node if it's a const and add it to parent's offset
        	l = astTB(n).l
        	if( astTB(l).defined ) then
				if( (astTB(l).dtype = IR.DATATYPE.LONGINT) or (astTB(l).dtype = IR.DATATYPE.ULONGINT) ) then
					c = cint( astTB(l).value64 )
				else
					c = cint( astTB(l).value )
				end if

				if( astTB(n).class = AST.NODECLASS.IDX ) then
					astTB(n).idx.ofs += c
				else
					astTB(n).ptr.ofs += c
				end if

				astDel l
				astTB(n).l = INVALID
			end if
		end if
	end select

	if( astTB(n).class = AST.NODECLASS.IDX ) then
		l = astTB(n).l
		if( l <> INVALID ) then
			'' x86 assumption: if top of tree = idx * lgt, and lgt < 10, save lgt and delete * node
			if( astTB(l).class = AST.NODECLASS.BOP ) then
				if( astTB(l).op = IR.OP.MUL ) then
					lr = astTB(l).r
					if( astTB(lr).defined ) then

						if( (astTB(lr).dtype = IR.DATATYPE.LONGINT) or _
							(astTB(lr).dtype = IR.DATATYPE.ULONGINT) ) then
							c = cint( astTB(lr).value64 )
						else
							c = cint( astTB(lr).value )
						end if

						if( c < 10 ) then
				    		if( (c <> 6) and (c <> 7) ) then
				    			astTB(n).idx.mult = c

								'' relink
								astTB(n).l = astTB(l).l

				    			'' del const node and the BOP itself
				    			astDel lr
								astDel l

								l = astTB(n).l
							end if
						end if
				    end if
				end if
			end if

			'' convert to integer if needed
			if( (irGetDataClass( astTB(l).dtype ) <> IR.DATACLASS.INTEGER) or _
			    (irGetDataSize( astTB(l).dtype ) <> FB.POINTERSIZE) ) then
				astTB(n).l = astNewCONV( INVALID, IR.DATATYPE.INTEGER, l )
			end if

        end if
	end if

	'' walk
	l = astTB(n).l
	if( l <> INVALID ) then
		astOptConstIDX( l )
	end if

	r = astTB(n).r
	if( r <> INVALID ) then
		astOptConstIDX( r )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' arithmetic association optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astOptAssocADD( byval n as integer )
	static l as integer, r as integer, op as integer, rop as integer

	if( n = INVALID ) then
		exit sub
	end if

    '' convert a+(b+c) to a+b+c and a-(b-c) to a-b+c
	if( astTB(n).class = AST.NODECLASS.BOP ) then
		op = astTB(n).op
		if( op = IR.OP.ADD or op = IR.OP.SUB ) then
			if( irGetDataClass( astTB(n).dtype ) <> IR.DATACLASS.STRING ) then
				r = astTB(n).r
				if( astTB(r).class = AST.NODECLASS.BOP ) then
					rop = astTB(r).op
					if( rop = IR.OP.ADD or rop = IR.OP.SUB ) then
						astTB(n).r = astTB(r).r
						astTB(r).r = astTB(r).l
						astTB(r).l = astTB(n).l
						astTB(n).l = r

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
						astTB(n).op = op
						astTB(r).op = rop

						astOptAssocADD n
						exit sub
					end if
				end if
			end if
		end if
	end if

	'' walk
	l = astTB(n).l
	if( l <> INVALID ) then
		astOptAssocADD l
	end if

	r = astTB(n).r
	if( r <> INVALID ) then
		astOptAssocADD r
	end if

end sub

'':::::
sub astOptAssocMUL( byval n as integer )
	static l as integer, r as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' convert a*(b*c) to a*b*c
	if( astTB(n).class = AST.NODECLASS.BOP ) then
		if( astTB(n).op = IR.OP.MUL ) then
			r = astTB(n).r
			if( astTB(r).class = AST.NODECLASS.BOP ) then
				if( astTB(r).op = IR.OP.MUL ) then
					astTB(n).r = astTB(r).r
					astTB(r).r = astTB(r).l
					astTB(r).l = astTB(n).l
					astTB(n).l = r
					astOptAssocMUL n
					Exit Sub
				end if
			end if
		end if
	end if

	'' walk
	l = astTB(n).l
	if( l <> INVALID ) then
		astOptAssocMUL l
	end if

	r = astTB(n).r
	if( r <> INVALID ) then
		astOptAssocMUL r
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' other optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astOptToShift( byval n as integer )
	static l as integer, r as integer
	static v as integer, op as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' convert 'a * pow2 imm'   to 'a SHL pow2',
	''         'a \ pow2 imm'   to 'a SHR pow2' and
	''         'a MOD pow2 imm' to 'a AND pow2-1'
	if( astTB(n).class = AST.NODECLASS.BOP ) then
		op = astTB(n).op
		select case op
		case IR.OP.MUL, IR.OP.INTDIV, IR.OP.MOD
			r = astTB(n).r
			if( astTB(r).defined ) then
				if( irGetDataClass( astTB(n).dtype ) = IR.DATACLASS.INTEGER ) then
					if( irGetDataSize( astTB(r).dtype ) <= FB.INTEGERSIZE ) then
						v = cint( astTB(r).value )
						if( v > 0 ) then
							v = hToPow2( v )
							if( v > 0 ) then
								select case op
								case IR.OP.MUL
									if( v <= 32 ) then
										astTB(n).op = IR.OP.SHL
										astTB(r).value = v
									end if
								case IR.OP.INTDIV
									if( v <= 32 ) then
										astTB(n).op = IR.OP.SHR
										astTB(r).value = v
									end if
								case IR.OP.MOD
									astTB(n).op = IR.OP.AND
									astTB(r).value -= 1
								end select
							end if
						end if
					end if
				end if
			end if
		end select
	end if

	'' walk
	l = astTB(n).l
	if( l <> INVALID ) then
		astOptToShift l
	end if

	r = astTB(n).r
	if( r <> INVALID ) then
		astOptToShift r
	end if

end sub

''::::
function astOptStrAssignament( byval n as integer, _
							   byval l as integer, _
							   byval r as integer ) as integer static
	dim optimize as integer

	optimize = FALSE

	'' is right side a bin operation?
	if( astTB(r).class = AST.NODECLASS.BOP ) then
		'' is left side a var?
		select case astTB(l).class
		case AST.NODECLASS.VAR, AST.NODECLASS.PTR, AST.NODECLASS.IDX
			optimize = astIsTreeEqual( l, astTB(r).l )
		end select
	end if

	if( optimize ) then
		''	=            f() -- concatassign
		'' / \           / \
		''d   +    =>   d   expr
		''   / \
		''  d   expr

		astDel n
		astDelTree l
		n = r

		astTB(n).r = astUpdStrConcat( astTB(n).r )

		astOptStrAssignament = rtlStrConcatAssign( astTB(n).l, astTB(n).r )

	else
		''	=            f() -- assign
		'' / \           / \
		''d   +    =>   d   f() -- concat (done by UpdStrConcat)
		''   / \           / \
		''  d   expr      d   expr

		astTB(n).r = astUpdStrConcat( astTB(n).r )

		astOptStrAssignament = rtlStrAssign( astTB(n).l, astTB(n).r )
	end if

end function

''::::
function astOptAssignament( byval n as integer ) as integer static
	dim l as integer, r as integer
	dim dtype as integer, dclass as integer

	astOptAssignament = n

	'' try to convert "foo = foo op expr" to "foo op= expr" (including unary ops)
	if( n = INVALID ) then
		exit function
	end if

	'' there's just one assignament per tree (always at top), so, just check this node
	if( astTB(n).class <> AST.NODECLASS.ASSIGN ) then
		exit function
	end if

	l = astTB(n).l
	r = astTB(n).r

	dtype = astTB(n).dtype
	dclass = irGetDataClass( dtype )

	'' integer's only, no way to optimize with a FPU stack (x86 assumption)
	if( dclass <> IR.DATACLASS.INTEGER ) then

		'' strings?
		if( dclass = IR.DATACLASS.STRING ) then
			astOptAssignament = astOptStrAssignament( n, l, r )
			exit function
		end if

		'' try to optimize if a constant is being assigned to a float var
  		if( astTB(r).class = AST.NODECLASS.CONST ) then
  			if( dclass = IR.DATACLASS.FPOINT ) then
				astTB(r).dtype = dtype
			end if
		end if

		exit function
	end if

	'' can't be byte either, as BOP will do cint(byte) op cint(byte)
	if( irGetDataSize( dtype ) = 1 ) then
		exit function
	end if

	'' is left side a var, idx or ptr?
	select case astTB(l).class
	case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
	case else
		exit function
	end select

	'' is right side a bin or unary operation?
	select case astTB(r).class
	case AST.NODECLASS.UOP, AST.NODECLASS.BOP
	case else
		exit function
	end select

	'' can't be a relative op -- unless EMIT is changed to not assume the res operand is a register
	select case as const astTB(r).op
	case IR.OP.EQ, IR.OP.GT, IR.OP.LT, IR.OP.NE, IR.OP.LE, IR.OP.GE
		exit function
	end select

	'' node result is an integer too?
	if( irGetDataClass( astTB(r).dtype ) <> IR.DATACLASS.INTEGER ) then
		exit function
	end if

	'' is the left child the same?
	if( not astIsTreeEqual( l, astTB(r).l ) ) then
		exit function
	end if

	'' delete assign node and alert UOP/BOP to not allocate a result (IR is aware)
	astTB(r).allocres = FALSE

	''	=             o
	'' / \           / \
	''d   o     =>  d   expr
	''   / \
	''  d   expr

    astDel n
	astDelTree l
    astOptAssignament = r

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' node type update
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astUpdStrConcat( byval n as integer ) as integer
	static l as integer, r as integer
	static f as integer

	astUpdStrConcat = n

	if( n = INVALID ) then
		exit function
	end if

	if( irGetDataClass( astTB(n).dtype ) <> IR.DATACLASS.STRING ) then
		'' this proc will be called for each function param, same
		'' with assignament -- assuming here that IIF won't
		'' support strings
		exit function
	end if

	'' walk
	l = astTB(n).l
	if( l <> INVALID ) then
		astTB(n).l = astUpdStrConcat( l )
	end if

	r = astTB(n).r
	if( r <> INVALID ) then
		astTB(n).r = astUpdStrConcat( r )
	end if

	'' convert "string + string" to "StrConcat( string, string )"
	if( astTB(n).class = AST.NODECLASS.BOP ) then
		if( astTB(n).op = IR.OP.ADD ) then
			l = astTB(n).l
			r = astTB(n).r
			astUpdStrConcat = rtlStrConcat( l, astTB(l).dtype, r, astTB(r).dtype )
			astDel n
		end if
	end if

end function

'':::::
function astUpdComp2Branch( byval n as integer, _
							byval label as FBSYMBOL ptr, _
							byval isinverse as integer ) as integer
	dim as integer op, l
	static as integer dtype, istrue

	if( n = INVALID ) then
		return INVALID
	end if

	dtype = astTB(n).dtype

	'' string? invalid..
	if( irGetDataClass( dtype ) = IR.DATACLASS.STRING ) then
		return INVALID
	end if

	'' UDT? ditto..
	if( dtype = IR.DATATYPE.USERDEF ) then
		return INVALID
	end if

	'' shortcut "exp logop exp" if it's at top of tree (used to optimize IF/ELSEIF/WHILE/UNTIL)
	if( astTB(n).class <> AST.NODECLASS.BOP ) then
		'' UOP? check if it's a NOT
		if( astTB(n).class = AST.NODECLASS.UOP ) then
			if( astTB(n).op = IR.OP.NOT ) then
				l = astTB(n).l
				l = astUpdComp2Branch( l, label, isinverse = FALSE )
				astDel n
				return l
			end if
		end if

		'' CONST?
		if( astTB(n).class = AST.NODECLASS.CONST ) then
			if( not isinverse ) then
				'' branch if false
				if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
					istrue = astTB(n).value64 = 0
				else
					istrue = astTB(n).value = 0
				end if

				if( istrue ) then
					astDel n
					n = astNewBRANCH( IR.OP.JMP, label, INVALID )
					if( n = INVALID ) then
						return INVALID
					end if
				end if
			else
				'' branch if true
				if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
					istrue = astTB(n).value64 <> 0
				else
					istrue = astTB(n).value <> 0
				end if

				if( istrue ) then
					astDel n
					n = astNewBRANCH( IR.OP.JMP, label, INVALID )
					if( n = INVALID ) then
						return INVALID
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

			n = astNewBOP( op, n, astNewCONST( 0, dtype ), label, FALSE )
			if( n = INVALID ) then
				return INVALID
			end if
		end if

		'' exit
		return n
	end if

	''
	op 	  = astTB(n).op

	'' logical operator?
	select case as const op
	case IR.OP.EQ, IR.OP.NE, IR.OP.GT, IR.OP.LT, IR.OP.GE, IR.OP.LE

		'' invert it
		if( not isinverse ) then
			astTB(n).op = irGetInverseLogOp( op )
		end if

		'' tell IR that the destine label is already set
		astTB(n).ex = label

		return n

	'' binary op that sets the flags? (x86 opt, may work on some RISC cpu's)
	case IR.OP.ADD, IR.OP.SUB, IR.OP.SHL, IR.OP.SHR, _
		 IR.OP.AND, IR.OP.OR, IR.OP.XOR, IR.OP.EQV, IR.OP.IMP

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

	return astNewBOP( op, n, astNewCONST( 0, dtype ), label, FALSE )

end function

#if 0
'':::::
sub astDump1 ( byval p as integer, byval n as integer, byval isleft as integer, _
			   byval ln as integer, byval cn as integer )
   dim v as string, l as integer, c as integer

	v = ""
	select case astTB(n).class
	case AST.NODECLASS.BOP
		select case astTB(n).op
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
		select case astTB(n).op
		case IR.OP.NEG
			v = "-"
		case IR.OP.NOT
			v = "!"
		end select
		v = "(" + v + ")"

	case AST.NODECLASS.VAR
		v = "[" + mid$( symbGetName( astTB(n).var.sym ), 2 ) + "]"
	case AST.NODECLASS.CONST
		v = "<" + str$( astTB(n).value ) + ">"
	case AST.NODECLASS.CONV
		v = "{" + str$( astTB(n).dtype ) + "}"
'	case AST.NODECLASS.IDX
'		c = astTB(n).idx.sym
'		v = "{" + rtrim$( mid$( symbGetVarName( astTB(c).idx.sym ), 2 ) ) + "}"

'	case AST.NODECLASS.FUNCT
'		v = rtrim$( mid$( symbGetProcName( astTB(n).proc.s ), 2 ) ) + "()"

'	case AST.NODECLASS.PARAM
'		v = "(" + ltrim$( str$( astTB(n).l ) ) + ")"
	end select

	if( len( v ) > 0 and ln <= 50 ) then

		v = ltrim$( str$( n ) ) + v
		if( p <> INVALID ) then
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

	if( astTB(n).l <> INVALID ) then
		astDump1 n, astTB(n).l, TRUE, ln+2, cn-4
	end if

	if( astTB(n).r <> INVALID ) then
		astDump1 n, astTB(n).r, FALSE, ln+2, cn+4
	end if

end sub
#endif

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree cloning and deletion
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
Sub astCopy( byval d as integer, _
			 byval s as integer ) Static
	Dim p as integer, n as integer

	p = astTB(d).prv
	n = astTB(d).nxt

	astTB(d) = astTB(s)

	astTB(d).prv = p
	astTB(d).nxt = n

End Sub

'':::::
Sub astSwap( byval d as integer, _
			 byval s as integer ) Static
	Dim dp as integer, dn as integer
	Dim sp as integer, sn as integer

	dp = astTB(d).prv
	dn = astTB(d).nxt
	sp = astTB(s).prv
	sn = astTB(s).nxt

	swap astTB(d), astTB(s)

	astTB(d).prv = dp
	astTB(d).nxt = dn
	astTB(s).prv = sp
	astTB(s).nxt = sn

End Sub

'':::::
function astCloneTree( byval n as integer ) as integer
	dim p as integer, nn as integer

	''
	if( n = INVALID ) then
		astCloneTree = INVALID
		exit function
	end if

	''
	nn = astNew( INVALID, INVALID )
	astCopy nn, n

	'' walk
	p = astTB(n).l
	if( p <> INVALID ) then
		astTB(nn).l = astCloneTree( p )
	end if

	p = astTB(n).r
	if( p <> INVALID ) then
		astTB(nn).r = astCloneTree( p )
	end if

	'' IIF has a 3rd tree node..
	if( astTB(n).class = AST.NODECLASS.IIF ) then
		p = astTB(n).iif.cond
		if( p <> INVALID ) then
			astTB(nn).iif.cond = astCloneTree( p )
		end if
	end if

	astCloneTree = nn

end function

'':::::
sub astDelTree ( byval n as integer )
	dim p as integer

	''
	if( n = INVALID ) then
		exit sub
	end if

	'' walk
	p = astTB(n).l
	if( p <> INVALID ) then
		astDelTree p
	end if

	p = astTB(n).r
	if( p <> INVALID ) then
		astDelTree p
	end if

	'' IIF has a 3rd tree node..
	if( astTB(n).class = AST.NODECLASS.IIF ) then
		p = astTB(n).iif.cond
		if( p <> INVALID ) then
			astDelTree p
		end if
	end if

	''
	astDel n

End Sub

''::::
function astIsTreeEqual( byval l as integer, _
						 byval r as integer ) as integer
    dim pl as ASTNode ptr, pr as ASTNode ptr

    astIsTreeEqual = FALSE

    if( (l = INVALID) or (r = INVALID) ) then
    	if( l = r ) then
    		astIsTreeEqual = TRUE
    	end if
    	exit function
    end if

	pl = @astTB(l)
	pr = @astTB(r)

	if( pl->class <> pr->class ) then
		exit function
	end if

	if( pl->dtype <> pr->dtype ) then
		exit function
	end if

	if( pl->subtype <> pr->subtype ) then
		exit function
	end if

	select case as const pl->class
	case AST.NODECLASS.VAR
		if( pl->var.sym <> pr->var.sym ) then
			exit function
		end if

		if( pl->var.elm <> pr->var.elm ) then
			exit function
		end if

		if( pl->var.ofs <> pr->var.ofs ) then
			exit function
		end if

	case AST.NODECLASS.CONST
const DBL_EPSILON# = 2.2204460492503131e-016

		if( (pl->dtype = IR.DATATYPE.LONGINT) or (pl->dtype = IR.DATATYPE.ULONGINT) ) then
			if( pl->value64 <> pr->value64 ) then
				exit function
			end if
		else
			if( abs( pl->value - pr->value ) > DBL_EPSILON ) then
				exit function
			end if
		end if

	case AST.NODECLASS.PTR
		if( pl->ptr.sym <> pr->ptr.sym ) then
			exit function
		end if

		if( pl->ptr.elm <> pr->ptr.elm ) then
			exit function
		end if

		if( pl->ptr.ofs <> pr->ptr.ofs ) then
			exit function
		end if

	case AST.NODECLASS.IDX
		if( pl->idx.ofs <> pr->idx.ofs ) then
			exit function
		end if

		if( pl->idx.mult <> pr->idx.mult ) then
			exit function
		end if

	case AST.NODECLASS.BOP
		if( pl->op <> pr->op ) then
			exit function
		end if

		if( pl->allocres <> pr->allocres ) then
			exit function
		end if

		if( pl->ex <> pr->ex ) then
			exit function
		end if

	case AST.NODECLASS.UOP
		if( pl->op <> pr->op ) then
			exit function
		end if

		if( pl->allocres <> pr->allocres ) then
			exit function
		end if

	case AST.NODECLASS.ADDR
		if( pl->addr.sym <> pr->addr.sym ) then
			exit function
		end if

		if( pl->addr.elm <> pr->addr.elm ) then
			exit function
		end if

		if( pl->op <> pr->op ) then
			exit function
		end if

	case AST.NODECLASS.IIF
		if( not astIsTreeEqual( pl->iif.cond, pr->iif.cond ) ) then
			exit function
		end if

	case AST.NODECLASS.CONV
		'' do nothing, the l child will be checked below

	case AST.NODECLASS.FUNCT, AST.NODECLASS.BRANCH, AST.NODECLASS.LOAD, AST.NODECLASS.ASSIGN
		'' unpredictable nodes
		exit function

	end select

    '' check childs
	if( not astIsTreeEqual( pl->l, pr->l ) ) then
		exit function
	end if

	if( not astIsTreeEqual( pl->r, pr->r ) ) then
		exit function
	end if

    ''
	astIsTreeEqual = TRUE

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree routines
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astRealloc( byval nodes as integer ) static
	dim i as integer
	dim lb as integer, ub as integer

	lb = ctx.nodes
	ub = ctx.nodes + (nodes - 1)

	redim preserve astTB( 0 to ub ) as ASTNODE

	for i = lb to ub
		astTB(i).l    = INVALID
		astTB(i).r    = INVALID

		astTB(i).prv  = i-1
		astTB(i).nxt  = i+1
	next i

	if( lb = 0 ) then
		astTB(lb).prv = INVALID
	end if

	astTB(ub).nxt = INVALID

	''
	ctx.fhead 		= lb
	ctx.nodes 		= ctx.nodes + nodes

end sub

'':::::
private sub astInitTempLists

	listNew( @ctx.tempstr, AST.MAXTEMPSTRINGS, len( ASTTEMPSTR ) )

	listNew( @ctx.temparray, AST.MAXTEMPARRAYS, len( ASTTEMPARRAY ) )

end sub

'':::::
private sub astEndTempLists

	listFree( @ctx.temparray )

	listFree( @ctx.tempstr )

end sub

'':::::
sub astInit static

	''
	ctx.head 		= INVALID
	ctx.tail 		= INVALID
	ctx.nodes		= 0

    astRealloc AST.INITNODES

    ''
    astInitTempLists

end sub

'':::::
sub astEnd static

	''
	astEndTempLists

	''
	erase astTB

	''
	ctx.head 		= INVALID
	ctx.tail 		= INVALID
	ctx.fhead 		= 0
	ctx.nodes		= 0

end sub

'':::::
function astNew( byval class as integer, _
				 byval dtype as integer, _
				 byval subtype as FBSYMBOL ptr = NULL ) as integer static
	dim n as integer, t as integer

	'' realloc node list if it's full
	if( ctx.fhead = INVALID ) then
		astRealloc ctx.nodes \ 2
	end if

	'' take from free list
	n = ctx.fhead
	ctx.fhead = astTB(n).nxt

	'' add to used list
	t = ctx.tail
	ctx.tail = n
	if( t <> INVALID ) then
		astTB(t).nxt = n
	Else
		ctx.head = n
	end if

	astTB(n).prv	= t
	astTB(n).nxt	= INVALID

	''
	astTB(n).class 	= class
	astTB(n).dtype 	= dtype
	astTB(n).subtype= subtype
	astTB(n).defined= FALSE
	astTB(n).op		= INVALID
	astTB(n).l    	= INVALID
	astTB(n).r    	= INVALID

	astNew = n

end function

'':::::
sub astDel( byval n as integer ) static
	Dim pn as integer, nn as integer

	if( n = INVALID ) then
		Exit Sub
	end if

	astTB(n).l    = INVALID
	astTB(n).r    = INVALID

	'' remove from used list
	pn = astTB(n).prv
	nn = astTB(n).nxt
	if( pn <> INVALID ) then
		astTB(pn).nxt = nn
	Else
		ctx.head = nn
	end if

	if( nn <> INVALID ) then
		astTB(nn).prv = pn
	Else
		ctx.tail = pn
	end if

	'' add to free list
	astTB(n).nxt = ctx.fhead
	ctx.fhead = n

end sub

'':::::
function astGetClass( byval n as integer ) as integer static

	if( n <> INVALID ) then
		astGetClass = astTB(n).class
	else
		astGetClass = INVALID
	end if

end function

'':::::
function astGetValue( byval n as integer ) as double static

	astGetValue = 0

	if( n <> INVALID ) then
		if( astTB(n).defined ) then
			astGetValue = astTB(n).value
		end if
	end if

end function

'':::::
function astGetValue64( byval n as integer ) as longint static

	astGetValue64 = 0

	if( n <> INVALID ) then
		if( astTB(n).defined ) then
			astGetValue64 = astTB(n).value64
		end if
	end if

end function

'':::::
function astGetSymbol( byval n as integer ) as FBSYMBOL ptr static
    dim s as FBSYMBOL ptr

	s = NULL

	if( n <> INVALID ) then
		select case as const astTB(n).class
		case AST.NODECLASS.PTR
			s = astTB(n).ptr.elm
			if( s = NULL ) then
				s = astTB(n).ptr.sym
			end if

		case AST.NODECLASS.VAR
			s = astTB(n).var.elm
			if( s = NULL ) then
				s = astTB(n).var.sym
			end if

		case AST.NODECLASS.IDX
			n = astTB(n).r
			if( n <> INVALID ) then
				s = astTB(n).var.elm
				if( s = NULL ) then
					s = astTB(n).var.sym
				end if
			end if

		case AST.NODECLASS.FUNCT
			s = astTB(n).proc.sym

		case AST.NODECLASS.ADDR
			s = astTB(n).addr.elm
			if( s = NULL ) then
				s = astTB(n).addr.sym
			end if
		end select
	end if

	astGetSymbol = s

end function

'':::::
function astGetDataType( byval n as integer ) as integer static

	if( n <> INVALID ) then
		astGetDataType = astTB(n).dtype
	else
		astGetDataType = INVALID
	end if

end function

'':::::
function astGetSubtype( byval n as integer ) as FBSYMBOL ptr static

	if( n <> INVALID ) then
		astGetSubtype = astTB(n).subtype
	else
		astGetSubtype = NULL
	end if

end function

'':::::
function astGetDataClass( byval n as integer ) as integer static

	if( n <> INVALID ) then
		astGetDataClass = irGetDataClass( astTB(n).dtype )
	else
		astGetDataClass = INVALID
	end if

end function

'':::::
function astGetDataSize( byval n as integer ) as integer static

	if( n <> INVALID ) then
		astGetDataSize = irGetDataSize( astTB(n).dtype )
	else
		astGetDataSize = INVALID
	end if

end function

''::::
function astLoad( byval n as integer ) as integer

	if( n = INVALID ) then
		return INVALID
	end if

	select case as const astTB(n).class
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

	case AST.NODECLASS.LOAD
		return astLoadLOAD( n )

	case AST.NODECLASS.BRANCH
		return astLoadBRANCH( n )

    case AST.NODECLASS.IIF
    	return astLoadIIF( n )
    end select

end function

''::::
private function astOptimize( byval n as integer ) as integer

	'' calls must be done in the order below

	astOptAssocADD( n )

	astOptAssocMUL( n )

	n = astOptConstDistMUL( n )

	n = astOptConstAccum1( n )

	astOptConstAccum2( n )

	astOptConstRmNeg( n, INVALID )

	astOptConstIDX( n )

	astOptToShift( n )

	return n

end function

''::::
function astFlush( byval n as integer ) as integer

	''
	if( n = INVALID ) then
		astFlush = INVALID
		exit function
	end if

	''
	n = astOptimize( n )

	n = astOptAssignament( n )					'' needed even when not optimizing

	n = astUpdStrConcat( n )

    ''
	astFlush = astLoad( n )

	astDel n

end function

'':::::
function astCntFreeNodes as integer static
	dim n as integer, c as integer

	c = 0
	n = ctx.fhead
	do while( n <> INVALID  )
		c = c + 1
		n = astTB(n).nxt
	loop

	astCntFreeNodes = c

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' binary operations (l = left operand expression ; r = right operand expression)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hStrLiteralConcat( byval l as integer, _
									byval r as integer ) as integer
    dim s as FBSYMBOL ptr
    dim ls as FBSYMBOL ptr, rs as FBSYMBOL ptr

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	'' new len = both strings' len less the 2 null-chars
	s = hAllocStringConst( symbGetVarText( ls ) + symbGetVarText( rs ), _
						   symbGetLen( ls ) - 1 + symbGetLen( rs ) - 1 )

	hStrLiteralConcat = astNewVAR( s, NULL, 0, IR.DATATYPE.FIXSTR )

	'' delete both vars if they were never accessed before
	if( symbGetAccessCnt( ls ) = 0 ) then
		symbDelVar ls
	end if

	if( symbGetAccessCnt( rs ) = 0 ) then
		symbDelVar rs
	end if

	astDel r
	astDel l

end function

'':::::
private sub hBOPConstFold( byval op as integer, _
						   byval l as ASTNODE ptr, _
						   byval r as ASTNODE ptr ) static
	dim as double lvalue, rvalue

	if( (l->dtype <> IR.DATATYPE.LONGINT) and (l->dtype <> IR.DATATYPE.ULONGINT) ) then
		lvalue = l->value
	else
		lvalue = cdbl( l->value64 )
	end if

	if( (r->dtype <> IR.DATATYPE.LONGINT) and (r->dtype <> IR.DATATYPE.ULONGINT) ) then
		rvalue = r->value
	else
		rvalue = cdbl( r->value64 )
	end if

	''
	select case as const op
	case IR.OP.ADD
		l->value = lvalue + rvalue
	case IR.OP.SUB
		l->value = lvalue - rvalue
	case IR.OP.MUL
		l->value = lvalue * rvalue
	case IR.OP.DIV
		l->value = lvalue / rvalue
	case IR.OP.INTDIV
		l->value = cint( lvalue ) \ cint( rvalue )
	case IR.OP.MOD
		l->value = cint( lvalue ) mod cint( rvalue )

	case IR.OP.SHL
		l->value = cint( lvalue ) shl cint( rvalue )
	case IR.OP.SHR
		l->value = cint( lvalue ) shr cint( rvalue )

	case IR.OP.AND
		l->value = cint( lvalue ) and cint( rvalue )
	case IR.OP.OR
		l->value = cint( lvalue ) or cint( rvalue )
	case IR.OP.XOR
		l->value = cint( lvalue ) xor cint( rvalue )
	case IR.OP.EQV
		l->value = cint( lvalue ) eqv cint( rvalue )
	case IR.OP.IMP
		l->value = cint( lvalue ) imp cint( rvalue )

    case IR.OP.POW
		l->value = lvalue ^ rvalue

	case IR.OP.EQ
		l->value = lvalue = rvalue
	case IR.OP.GT
		l->value = lvalue > rvalue
	case IR.OP.LT
		l->value = lvalue < rvalue
	case IR.OP.NE
		l->value = lvalue <> rvalue
	case IR.OP.LE
		l->value = lvalue <= rvalue
	case IR.OP.GE
		l->value = lvalue >= rvalue
	end select

end sub

'':::::
private sub hBOPConstFold64( byval op as integer, _
							 byval l as ASTNODE ptr, _
							 byval r as ASTNODE ptr ) static
	dim as longint lvalue, rvalue

	if( (l->dtype <> IR.DATATYPE.LONGINT) and (l->dtype <> IR.DATATYPE.ULONGINT) ) then
		lvalue = clngint( l->value )
	else
		lvalue = l->value64
	end if

	if( (r->dtype <> IR.DATATYPE.LONGINT) and (r->dtype <> IR.DATATYPE.ULONGINT) ) then
		rvalue = clngint( r->value )
	else
		rvalue = r->value64
	end if

	''
	select case as const op
	case IR.OP.ADD
		l->value64 = lvalue + rvalue
	case IR.OP.SUB
		l->value64 = lvalue - rvalue
	case IR.OP.MUL
		l->value64 = lvalue * rvalue
	case IR.OP.DIV
		l->value64 = lvalue / rvalue
	case IR.OP.INTDIV
		l->value64 = lvalue \ rvalue
	case IR.OP.MOD
		l->value64 = lvalue mod rvalue

	case IR.OP.SHL
		l->value64 = lvalue shl cint( rvalue )
	case IR.OP.SHR
		l->value64 = lvalue shr cint( rvalue )

	case IR.OP.AND
		l->value64 = lvalue and rvalue
	case IR.OP.OR
		l->value64 = lvalue or rvalue
	case IR.OP.XOR
		l->value64 = lvalue xor rvalue
	case IR.OP.EQV
		l->value64 = lvalue eqv rvalue
	case IR.OP.IMP
		l->value64 = lvalue imp rvalue

    case IR.OP.POW
		l->value64 = lvalue ^ rvalue

	case IR.OP.EQ
		l->value64 = lvalue = rvalue
	case IR.OP.GT
		l->value64 = lvalue > rvalue
	case IR.OP.LT
		l->value64 = lvalue < rvalue
	case IR.OP.NE
		l->value64 = lvalue <> rvalue
	case IR.OP.LE
		l->value64 = lvalue <= rvalue
	case IR.OP.GE
		l->value64 = lvalue >= rvalue
	end select

end sub

'':::::
function astNewBOP( byval op as integer, _
					byval l as integer, _
					r as integer, _
					byval ex as FBSYMBOL ptr = NULL, _
					byval allocres as integer = TRUE ) as integer static
    dim as integer n
    dim as integer dt1, dt2, dtype
    dim as integer dc1, dc2
    dim as integer ispow2, doconv

	astNewBOP = INVALID

	if( (l = INVALID) or (r = INVALID) ) then
		exit function
	end if

	dt1 = astTB(l).dtype
	dt2 = astTB(r).dtype
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
				astNewBOP = rtlMathLongintDIV( dtype, l, dt1, r, dt2 )
				exit function

			case IR.OP.MOD
				astNewBOP = rtlMathLongintMOD( dtype, l, dt1, r, dt2 )
				exit function

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
				if( astTB(l).class = AST.NODECLASS.VAR ) then
					if( astTB(r).class = AST.NODECLASS.VAR ) then
						if( symbGetVarInitialized( astGetSymbol( l ) ) ) then
							if( symbGetVarInitialized( astGetSymbol( r ) ) ) then
								astNewBOP = hStrLiteralConcat( l, r )
								exit function
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
			r = astNewCONST( 0, IR.DATATYPE.INTEGER )

			dt1 = astTB(l).dtype
			dc1 = IR.DATACLASS.INTEGER
			dt2 = astTB(r).dtype
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
			if( (astTB(r).class = AST.NODECLASS.VAR) and (dt2 = IR.DATATYPE.INTEGER) ) then
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

	end select

    '' convert types to the most precise if needed
	if( dt1 <> dt2 ) then

		dtype = irMaxDataType( dt1, dt2 )
		'' don't convert?
		if( dtype = -1 ) then
			dtype = dt1

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
								select case astTB(r).class
								case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
									doconv = FALSE
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
	'' result is always a double with pow()
	case IR.OP.POW
		dtype = IR.DATATYPE.DOUBLE

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
	if( astTB(l).defined and astTB(r).defined ) then

		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		    hBOPConstFold64 op, @astTB(l), @astTB(r)
		else
			hBOPConstFold op, @astTB(l), @astTB(r)
		end if

		astTB(l).dtype = dtype

		''
		astDel r
		r = INVALID

		astNewBOP = l
		exit function

	elseif( astTB(l).defined ) then
		select case op
		case IR.OP.ADD, IR.OP.MUL
			'' ? + c = c + ?  |  ? * c = ? * c
			astSwap r, l

		case IR.OP.SUB
			'' c - ? = -? + c (this will removed later if no const folding can be done)
			r = astNewUOP( IR.OP.NEG, r )
			astSwap r, l
			op = IR.OP.ADD
		end select

	elseif( astTB(r).defined ) then
		select case op
		case IR.OP.SUB
			'' ? - c = ? + -c
			if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
				astTB(r).value64 = -astTB(r).value64
			else
				astTB(r).value = -astTB(r).value
			end if
			op = IR.OP.ADD

		case IR.OP.POW

			'' convert var ^ 2 to var * var
			ispow2 = FALSE
			if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
				if( astTB(r).value64 = 2 ) then
					ispow2 = TRUE
				end if
			else
				if( astTB(r).value = 2 ) then
					ispow2 = TRUE
				end if
			end if

			if( ispow2 ) then
				select case astTB(l).class
				case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
					astDel r
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
		astNewBOP = rtlMathPow( l, r )
		exit function
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.BOP, dtype )
	astNewBOP = n

	if( n = INVALID ) then
		exit function
	end if

	'' fill it
	astTB(n).op 		= op
	astTB(n).l  		= l
	astTB(n).r  		= r
	astTB(n).ex 		= ex
	astTB(n).allocres	= allocres

end function

'':::::
function astLoadBOP( byval n as integer ) as integer
    dim as integer l, r, op
    dim as integer v1, v2, vr

	op = astTB(n).op
	l  = astTB(n).l
	r  = astTB(n).r

	if( (l = INVALID) or (r = INVALID) ) then
		return INVALID
	end if

	'' need some other algo here to select which operand is better to evaluate
	'' first - pay attention to logical ops, "func1(bar) OR func1(foo)" isn't
	'' the same as the inverse if func1 depends on the order..
	v1 = astLoad( l )
	v2 = astLoad( r )

	'' result type can be different, with boolean operations on floats
	if( astTB(n).allocres ) then
		vr = irAllocVREG( astTB(n).dtype )
	else
		vr = INVALID
	end if

	'' execute the operation
	if( astTB(n).ex <> NULL ) then
		'' hack! ex=label, vr being INVALID 'll gen better code at IR..
		irEmitBOPEx op, v1, v2, INVALID, astTB(n).ex
	else
		irEmitBOPEx op, v1, v2, vr, NULL
	end if

	'' nodes not needed anymore
	astDel l
	astDel r

	'' "var op= expr" optimizations
	if( vr = INVALID ) then
		vr = v1
	end if

	return vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' unary operations (l = operand expression; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hUOPConstFold( byval op as integer, _
						   byval o as ASTNODE ptr ) static
	dim as double value

	if( (o->dtype <> IR.DATATYPE.LONGINT) and (o->dtype <> IR.DATATYPE.ULONGINT) ) then
		value = o->value
	else
		value = cdbl( o->value64 )
	end if

	select case as const op
	case IR.OP.NOT
		o->value = not cint( value )

	case IR.OP.NEG
		o->value = -value

	case IR.OP.ABS
		o->value = abs( value )

	case IR.OP.SGN
		o->value = sgn( value )
	end select

end sub

'':::::
private sub hUOPConstFold64( byval op as integer, _
							 byval o as ASTNODE ptr ) static
	dim as longint value

	if( (o->dtype <> IR.DATATYPE.LONGINT) and (o->dtype <> IR.DATATYPE.ULONGINT) ) then
		value = clngint( o->value )
	else
		value = o->value64
	end if

	select case as const op
	case IR.OP.NOT
		o->value64 = not value

	case IR.OP.NEG
		o->value64 = -value

	case IR.OP.ABS
		o->value64 = abs( value )

	case IR.OP.SGN
		o->value64 = sgn( value )
	end select

end sub

'':::::
function astNewUOP( byval op as integer, _
					byval o as integer ) as integer static
    dim n as integer, dclass as integer, dtype as integer

	astNewUOP = INVALID

	if( o = INVALID ) then
		exit function
	end if

	dtype = astTB(o).dtype

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

	select case op
	'' NOT can only be operate on integers
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
	end select

	'' constant folding
	if( astTB(o).defined ) then

		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		    hUOPConstFold64 op, @astTB(o)
		else
			hUOPConstFold op, @astTB(o)
		end if

		astTB(o).dtype = dtype

		astNewUOP = o
		exit function
	end if

	if( op = IR.OP.SGN ) then
		'' hack! SGN with floats is handled by a function
		if( dclass = IR.DATACLASS.FPOINT ) then
			astNewUOP = rtlMathFSGN( o )
			exit function
		end if
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.UOP, dtype )
	astNewUOP = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).op 		= op
	astTB(n).l  		= o
	astTB(n).r  		= INVALID
	astTB(n).allocres	= TRUE
	astTB(n).ex 		= NULL

end function

'':::::
function astLoadUOP( byval n as integer ) as integer
    dim as integer o, op
    dim as integer v1, vr

	o  = astTB(n).l
	op = astTB(n).op

	if( o = INVALID ) then
		return INVALID
	end if

	v1 = astLoad( o )

	if( astTB(n).allocres ) then
		vr = irAllocVREG( astTB(o).dtype )
	else
		vr = INVALID
	end if

	irEmitUOP op, v1, vr

	astDel o

	'' "op var" optimizations
	if( vr = INVALID ) then
		vr = v1
	end if

	return vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constants (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewCONST( byval value as double, _
					  byval dtype as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODECLASS.CONST, dtype )
	astNewCONST = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).value 	= value
	astTB(n).defined= TRUE

end function

'':::::
function astNewCONST64( byval value as longint, _
						byval dtype as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODECLASS.CONST, dtype )
	astNewCONST64 = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).value64 = value
	astTB(n).defined = TRUE

end function

'':::::
function astLoadCONST( byval n as integer ) as integer static
	dim as FBSYMBOL ptr s
	dim as integer dtype

	dtype = astTB(n).dtype

  	'' if node is a float, create a temp float var (x86 assumption)
  	if( irGetDataClass( dtype ) = IR.DATACLASS.FPOINT ) then
		s = hAllocNumericConst( str$( astTB(n).value ), dtype )
		return irAllocVRVAR( dtype, s, s->ofs )

	else
		'' longints?
		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
			return irAllocVRIMM64( dtype, astTB(n).value64 )
		else
			return irAllocVRIMM( dtype, cint( astTB(n).value ) )
		end if

	end if

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' variables (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewVAR( byval sym as FBSYMBOL ptr, _
					byval elm as FBSYMBOL ptr, _
					byval ofs as integer, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr = NULL ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODECLASS.VAR, dtype, subtype )
	astNewVAR = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).var.sym 	= sym
	astTB(n).var.elm 	= elm
	if( sym <> NULL ) then
		ofs += sym->ofs
	end if
	astTB(n).var.ofs	= ofs

end function

'':::::
function astLoadVAR( byval n as integer ) as integer static

	return irAllocVRVAR( astTB(n).dtype, astTB(n).var.sym, astTB(n).var.ofs )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' indexes (l = index expression; r = var expression)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewIDX( byval v as integer, _
					byval i as integer, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr ) as integer static
    dim n as integer

	if( dtype = INVALID ) then
		dtype = astGetDataType( i )
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.IDX, dtype, subtype )
	astNewIDX = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l 			= i
	astTB(n).r 			= v
	astTB(n).idx.mult 	= 1
	astTB(n).idx.ofs 	= 0

end function

'':::::
function asthEmitIDX( byval v as integer, _
					  byval ofs as integer, _
					  byval mult as integer, _
					  byval vi as integer ) as integer static
    dim s as FBSYMBOL ptr, vd as integer

    s = astTB(v).var.sym

	'' ofs * length + difference (non-base 0 indexes) + offset (UDT's offset)
	if( not symbGetIsDynamic( s ) ) then
		ofs = ofs + symbGetArrayDiff( s ) + astTB(v).var.ofs
	else
		s = NULL
	end if

    ''
	if( vi <> INVALID ) then

		if( (mult >= 10) or (mult = 6) or (mult = 7) ) then
			mult = 1
		end if

		vd = irAllocVRIDX( astTB(v).dtype, s, ofs, mult, vi )

		if( irIsIDX( vi ) or irIsVAR( vi ) ) then
			irEmitLOAD IR.OP.LOAD, vi
		end if

	else
		vd = irAllocVRVAR( astTB(v).dtype, s, ofs )
	end if

	asthEmitIDX = vd

end function

'':::::
function astLoadIDX( byval n as integer ) as integer
    dim as integer v, i
    dim as integer vi, vr

	v = astTB(n).r
	i = astTB(n).l

	if( v = INVALID ) then
		return INVALID
	end if

	if( i <> INVALID ) then
		vi = astLoad( i )
	else
		vi = INVALID
	end if

    vr = asthEmitIDX( v, astTB(n).idx.ofs, astTB(n).idx.mult, vi )

	astDel i
	astDel v

	return vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' addressing operations (l = expression to call the address of; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewADDR( byval op as integer, _
					 byval p as integer, _
					 byval sym as FBSYMBOL ptr = NULL, _
					 byval elm as FBSYMBOL ptr = NULL, _
					 byval dtype as integer = INVALID, _
					 byval subtype as FBSYMBOL ptr = NULL ) as integer static
    dim n as integer

	if( p = INVALID ) then
		astNewADDR = INVALID
		exit function
	end if

	if( dtype = INVALID ) then
		dtype = astTB(p).dtype
	end if

	if( subtype = NULL ) then
		subtype = astTB(p).subtype
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.ADDR, IR.DATATYPE.POINTER + dtype, subtype )
	astNewADDR = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).op 		= op
	astTB(n).l  		= p
	astTB(n).addr.sym	= sym
	astTB(n).addr.elm	= elm

end function

'':::::
function astLoadADDR( byval n as integer ) as integer
    dim as integer p, op
    dim as integer v1, vr

	p  = astTB(n).l
	op = astTB(n).op

	if( p = INVALID ) then
		return INVALID
	end if

	v1 = astLoad( p )

	'' !!!WRITEME!!! if v1 is already a ptr with no ofs or other attached regs,
	'' convert it to a simple reg (not a ptr) and change type to UINT

	vr = irAllocVREG( IR.DATATYPE.UINT )

	irEmitADDR op, v1, vr

	astDel p

	return vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' loading (l = expression to load to a register; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLOAD( byval l as integer, _
					 byval dtype as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODECLASS.LOAD, dtype )
	astNewLOAD = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l  = l

end function

'':::::
function astLoadLOAD( byval n as integer ) as integer
    dim as integer l
    dim as integer vr

	l = astTB(n).l

	if( l = INVALID ) then
		return INVALID
	end if

	vr = astLoad( l )

	irEmitLOAD IR.OP.LOAD, vr

	astDel l

	return vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' pointers (l = pointer expression; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewPTR( byval sym as FBSYMBOL ptr, _
					byval elm as FBSYMBOL ptr, _
					byval ofs as integer, _
					byval expr as integer, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODECLASS.PTR, dtype, subtype )
	astNewPTR = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l   		= expr
	astTB(n).ptr.sym	= sym
	astTB(n).ptr.elm	= elm
	astTB(n).ptr.ofs	= ofs

end function

'':::::
function astLoadPTR( byval n as integer ) as integer
    dim as integer l, ofs, dtype
    dim as integer v1, vp, vr

	l 	= astTB(n).l
	ofs = astTB(n).ptr.ofs

	if( l = INVALID ) then
		return INVALID
	end if

	v1 = astLoad( l )

	''
	dtype = astTB(n).dtype

	'' src is already a reg?
	if( (not irIsREG( v1 )) or _
		(irGetVRDataClass( v1 ) <> IR.DATACLASS.INTEGER) or _
		(irGetVRDataSize( v1 ) <> FB.POINTERSIZE) ) then

		vp = irAllocVREG( IR.DATATYPE.UINT )
		irEmitADDR IR.OP.DEREF, v1, vp
	else
		vp = v1
	end if

	vr = irAllocVRPTR( dtype, ofs, vp )

	astDel l

	return vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' assignaments (l = destine; r = source)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewASSIGN( byval l as integer, _
					   byval r as integer ) as integer static
    dim as integer n, dtype, lgt
    dim as integer dt1, dt2
    dim as integer dc1, dc2
    dim as FBSYMBOL ptr proc

	astNewASSIGN = INVALID

	dt1 = astTB(l).dtype
	dt2 = astTB(r).dtype
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
					if( astTB(r).class <> AST.NODECLASS.PTR ) then
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
					if( astTB(l).class <> AST.NODECLASS.PTR ) then
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

		'' both not UDT's?
		if( dt1 <> IR.DATATYPE.USERDEF ) then
			exit function
		end if

		lgt = symbGetUDTLen( astGetSubtype( l ) )

		if( dt2 <> IR.DATATYPE.USERDEF ) then
			if( astTB(r).class <> AST.NODECLASS.FUNCT ) then
				exit function
			end if

            '' handle functions returning UDT's when type isn't a pointer,
            '' but an integer or fpoint register
            proc = astTB(r).proc.sym
            if( proc->typ <> IR.DATATYPE.USERDEF ) then
            	exit function
            end if

            dt1 = proc->proc.realtype
            astTB(l).dtype = dt1

		else
			return rtlMemCopy( l, r, lgt )
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

	'' alloc new node
	n = astNew( AST.NODECLASS.ASSIGN, dt1 )

	if( n = INVALID ) then
		return INVALID
	end if

	astTB(n).l  = l
	astTB(n).r  = r

	return n

end function

'':::::
function astLoadASSIGN( byval n as integer ) as integer
    dim as integer l, r
    dim as integer vs, vr

	l = astTB(n).l
	r = astTB(n).r

	if( (l = INVALID) or (r = INVALID) ) then
		return INVALID
	end if

	vs = astLoad( r )
	vr = astLoad( l )

	irEmitSTORE vr, vs

	astDel l
	astDel r

	return vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' conversions (l = expression to convert; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hCONVConstEval( byval dtype as integer, _
							byval l as ASTNODE ptr ) static

	if( (l->dtype <> IR.DATATYPE.LONGINT) and (l->dtype <> IR.DATATYPE.ULONGINT) ) then
		select case as const dtype
		case IR.DATATYPE.BYTE
			l->value = cbyte( l->value )

		case IR.DATATYPE.UBYTE
			l->value = cubyte( l->value )

		case IR.DATATYPE.SHORT
			l->value = cshort( l->value )

		case IR.DATATYPE.USHORT
			l->value = cushort( l->value )

		case IR.DATATYPE.INTEGER
			l->value = cint( l->value )

		case IR.DATATYPE.UINT
			l->value = cuint( l->value )

		case IR.DATATYPE.SINGLE
			l->value = csng( l->value )

		case IR.DATATYPE.DOUBLE
			l->value = cdbl( l->value )
		end select

	else
		select case as const dtype
		case IR.DATATYPE.BYTE
			l->value = cbyte( l->value64 )

		case IR.DATATYPE.UBYTE
			l->value = cubyte( l->value64 )

		case IR.DATATYPE.SHORT
			l->value = cshort( l->value64 )

		case IR.DATATYPE.USHORT
			l->value = cushort( l->value64 )

		case IR.DATATYPE.INTEGER
			l->value = cint( l->value64 )

		case IR.DATATYPE.UINT
			l->value = cuint( l->value64 )

		case IR.DATATYPE.SINGLE
			l->value = csng( l->value64 )

		case IR.DATATYPE.DOUBLE
			l->value = cdbl( l->value64 )
		end select

	end if

end sub

'':::::
private sub hCONVConstEval64( byval dtype as integer, _
							  byval l as ASTNODE ptr ) static

	if( (l->dtype <> IR.DATATYPE.LONGINT) and (l->dtype <> IR.DATATYPE.ULONGINT) ) then
		if( dtype = IR.DATATYPE.LONGINT ) then
			l->value64 = clngint( l->value )
		else
			l->value64 = culngint( l->value )
		end if
	end if

end sub

'':::::
function astNewCONV( byval op as integer, _
					 byval dtype as integer, _
					 byval l as integer ) as integer static
    dim n as integer
    dim dclass as integer

	astNewCONV = INVALID

    if( l = INVALID ) then
    	exit function
    end if

    dclass = irGetDataClass( astTB(l).dtype )

    '' string? can't operate
    if( dclass = IR.DATACLASS.STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( astTB(l).dtype = IR.DATATYPE.USERDEF ) then
		exit function
    end if

	'' if it's just a sign conversion, change node's sign and create no new node
	if( op <> INVALID ) then

		'' float? invalid
		if( dclass <> IR.DATACLASS.INTEGER ) then
			exit function
		end if

		if( op = IR.OP.TOSIGNED ) then
			astTB(l).dtype = irGetSignedType( astTB(l).dtype )
		else
			astTB(l).dtype = irGetUnsignedType( astTB(l).dtype )
		end if

		astNewCONV = l
		exit function
	end if

	'' only convert if the classes are different (ie, floating<->integer) or
	'' if sizes are different (ie, byte<->int)
	if( (dclass = irGetDataClass( dtype )) and _
		(irGetDataSize( astTB(l).dtype ) = irGetDataSize( dtype )) ) then

		astTB(l).dtype = dtype

		astNewCONV = l
		exit function
	end if

	'' constant? evaluate at compile-time
	if( astTB(l).defined ) then

		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
			hCONVConstEval64 dtype, @astTB(l)
		else
			hCONVConstEval dtype, @astTB(l)
		end if

		astTB(l).dtype = dtype

		astNewCONV = l
		exit function
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.CONV, dtype )
	astNewCONV = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l  = l

end function

'':::::
function astLoadCONV( byval n as integer ) as integer
    dim as integer l, dtype
    dim as integer vs, vr

	l  = astTB(n).l

	if( l = INVALID ) then
		return INVALID
	end if

	vs = astLoad( l )

	dtype = astTB(n).dtype

	vr = irAllocVREG( dtype )
	irEmitCONVERT vr, dtype, vs, INVALID

	astDel l

	return vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' branches (l = link to the stream to be also flushed, if any; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewBRANCH( byval op as integer, _
					   byval label as FBSYMBOL ptr, _
					   byval l as integer = INVALID ) as integer static
    dim n as integer
    dim dtype as integer

	astNewBRANCH = INVALID

    if( l = INVALID ) then
    	dtype = INVALID
    else
    	dtype = astTB(l).dtype
    end if

	'' alloc new node
	n = astNew( AST.NODECLASS.BRANCH, dtype )
	astNewBRANCH = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l	= l
	astTB(n).ex = label
	astTB(n).op	= op

end function

'':::::
function astLoadBRANCH( byval n as integer ) as integer
    dim as integer l
    dim as integer vr

	l  = astTB(n).l

	if( l <> INVALID ) then
		vr = astLoad( l )
		astDel l
	else
		vr = INVALID
	end if

	'' pointer?
	if( astTB(n).ex = NULL ) then
		'' jump or call?
		if( astTB(n).op = IR.OP.JUMPPTR ) then
			irEmitBRANCHPTR vr
		else
			irEmitCALLPTR vr, INVALID, 0
		end if
	else
		irEmitBRANCH astTB(n).op, astTB(n).ex
	end if

	return vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' functions (l = pointer node if any; r = first param to be pushed)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewFUNCT( byval sym as FBSYMBOL ptr, _
					  byval dtype as integer, _
					  byval ptrexpr as integer = INVALID ) as integer static
    dim n as integer

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
	astNewFUNCT = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).proc.sym 		= sym
	astTB(n).l 				= ptrexpr
	astTB(n).proc.params 	= 0

	if( sym <> NULL ) then
		astTB(n).proc.arg	= symbGetProcHeadArg( sym )
		astTB(n).proc.isrtl = symbGetProcLib( sym ) = "fb"
	else
		astTB(n).proc.arg	= NULL
		astTB(n).proc.isrtl = FALSE
	end if

	astTB(n).proc.arraytail = NULL
	astTB(n).proc.strtail = NULL

end function

'':::::
private sub hReportParamError( byval f as integer )

	hReportErrorEx FB.ERRMSG.PARAMTYPEMISMATCHAT, "at parameter: " + str$( astTB(f).proc.params+1 )

end sub

'':::::
private sub hReportParamWarning( byval f as integer, _
								 byval msgnum as integer )

	hReportWarning msgnum, "at parameter: " + str$( astTB(f).proc.params+1 )

end sub

'':::::
private function hAllocTmpArrayDesc( byval f as integer, _
									 byval n as integer ) as integer
	dim s as FBSYMBOL ptr
	dim t as ASTTEMPARRAY ptr

	'' alloc a node
	t = listNewNode( @ctx.temparray )
	t->left = astTB(f).proc.arraytail
	astTB(f).proc.arraytail = t

	'' create a pointer
	s = symbAddTempVar( FB.SYMBTYPE.UINT )

	t->pdesc = s

	''
	return rtlArrayAllocTmpDesc( n, s )

end function

'':::::
private function hAllocTmpString( byval f as integer, _
								  byval n as integer, _
								  byval copyback as integer ) as integer
	dim s as FBSYMBOL ptr
	dim t as ASTTEMPSTR ptr

	'' alloc a node
	t = listNewNode( @ctx.tempstr )
	t->left = astTB(f).proc.strtail
	astTB(f).proc.strtail = t

	'' create temp string to pass as paramenter
	s = symbAddTempVar( FB.SYMBTYPE.STRING )

	t->tmpsym = s
	if( copyback ) then
		t->srctree = astCloneTree( n )
	else
		t->srctree = INVALID
	end if

	'' temp string = src string
	return rtlStrAssign( astNewVAR( s, NULL, 0, IR.DATATYPE.STRING ), n )

end function

'':::::
private function hCheckStringArg( byval f as integer, _
							      byval arg as FBSYMBOL ptr, _
							      byval p as integer ) as integer

    dim as integer adtype, pdtype, pclass, copyback

	hCheckStringArg = p

	copyback = FALSE

	'' get param and arg data types
	adtype  = symbGetType( arg )
	pdtype  = astTB(p).dtype

	'' calling the runtime lib?
	if( astTB(f).proc.isrtl ) then

		'' byref arg (rtlib str args are ALWAYS byref), fixed-len param: just alloc a temp descriptor
		'' (assuming here that no rtlib function will EVER change the strings passed as param)
		select case pdtype
		case IR.DATATYPE.FIXSTR, IR.DATATYPE.CHAR, IR.DATATYPE.BYTE, IR.DATATYPE.UBYTE
			return rtlStrAllocTmpDesc( p )
		case else
			'' all rtlib procs that accept strings will delete temps automatically
			exit function
		end select

	end if


	'' param class
	pclass = astTB(p).class

	''
	select case symbGetArgMode( astTB(f).proc.sym, arg )

	'' passing by reference?
	case FB.ARGMODE.BYREF

    	'' fixed-length?
    	select case pdtype
    	case IR.DATATYPE.FIXSTR
    		'' byref and fixed: alloc a temp string, copy fixed to temp and pass temp
			'' (ast will have to copy temp back to fixed when function returns and delete temp)

			'' don't copy back if it's a function returning a fixed-len
			if( pclass <> AST.NODECLASS.FUNCT ) then
				copyback = TRUE
			end if

    	'' zstring or byte ptr?
    	case IR.DATATYPE.CHAR, IR.DATATYPE.BYTE, IR.DATATYPE.UBYTE
    		'' byref and byte ptr: alloc a temp string, copy byte ptr to temp and pass temp

    	'' string descriptor..
    	case else
    		'' if not a function's result, skip..
    		if( pclass <> AST.NODECLASS.FUNCT ) then
    			exit function
            end if
    	end select

    '' byval?
    case FB.ARGMODE.BYVAL

		'' skip, unless it's a temp string, that must be deleted when the called proc returns
		if( pclass <> AST.NODECLASS.FUNCT ) then
			exit function
		end if

	end select

	'' create temp string to pass as paramenter
	return hAllocTmpString( f, p, copyback )

end function

'':::::
private function hCheckStringParam( byval f as integer, _
									byval n as integer, _
					   				byval pclass as integer, _
					   				byval pdtype as integer, _
					   				byval pdclass as integer )

	'' rtl? don't mess..
	if( astTB(f).proc.isrtl ) then
		return TRUE
	end if

	''
	if( pdclass = IR.DATACLASS.STRING ) then

		'' if it's a function returning a STRING, it will have to be
		'' deleted automagically when the proc been called return
		if( pclass = AST.NODECLASS.FUNCT ) then
			'' create temp string to pass as paramenter (no copy is
			'' done at rtlib, as the returned string is a temp one)
			astTB(n).l = hAllocTmpString( f, astTB(n).l, FALSE )
			pdtype = IR.DATATYPE.STRING
			pclass = AST.NODECLASS.PTR
			astTB(n).dtype = pdtype
		end if

		'' not fixed-len? deref var-len (ptr at offset 0)
		if( pdtype <> IR.DATATYPE.FIXSTR ) then
    		astTB(n).l 	   = astNewADDR( IR.OP.DEREF, astTB(n).l )
			astTB(n).dtype = IR.DATATYPE.POINTER + IR.DATATYPE.CHAR

        '' fixed-len? get the address of
        elseif( pclass <> AST.NODECLASS.PTR ) then
			astTB(n).l 	   = astNewADDR( IR.OP.ADDROF, astTB(n).l )
			astTB(n).dtype = IR.DATATYPE.POINTER + IR.DATATYPE.CHAR
		end if

	else
    	'' zstring? if not a ptr yet, get the address of
    	if( pdtype = IR.DATATYPE.CHAR ) then
			if( pclass <> AST.NODECLASS.PTR ) then
				astTB(n).l 	   = astNewADDR( IR.OP.ADDROF, astTB(n).l )
				astTB(n).dtype = IR.DATATYPE.POINTER + IR.DATATYPE.CHAR
			end if
		end if

	end if

	return TRUE

end function

'':::::
private function hCheckArrayParam( byval f as integer, _
								   byval n as integer, _
					   	   		   byval adtype as integer, _
					   	   		   byval adclass as integer )

	dim as FBSYMBOL ptr s, d
    dim as integer p

	p = astTB(n).l

	'' type field?
	s = astGetSymbol( p )

	if( s = NULL ) then
		hReportParamError f
		return FALSE
	end if

	'' same type? (don't check if it's a rtl proc)
	if( not astTB(f).proc.isrtl ) then
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
		if( astTB(p).class = AST.NODECLASS.ADDR ) then
			hReportParamError f
			return FALSE
		end if

		'' create a temp array descriptor
		astTB(n).l = hAllocTmpArrayDesc( f, p )
		astTB(n).dtype = IR.DATATYPE.POINTER + IR.DATATYPE.VOID

	else

		'' not an argument passed by descriptor?
		if ( (s->alloctype and FB.ALLOCTYPE.ARGUMENTBYDESC) = 0 ) then

			'' not an array?
			d = s->var.array.desc
			if( d = NULL ) then
				hReportParamError f
				return FALSE
			end if

        	''
        	astTB(n).l = astNewADDR( IR.OP.ADDROF, astNewVAR( d, NULL, 0, IR.DATATYPE.UINT ) )
        	astTB(n).dtype = IR.DATATYPE.POINTER + IR.DATATYPE.VOID

    	else
        	'' it's a pointer, but could be seen as anything else
        	'' (ie: if it were "s() as string"), so, create an alias
        	astTB(n).l = astNewVAR( s, NULL, 0, IR.DATATYPE.UINT )
        	astTB(n).dtype = IR.DATATYPE.POINTER + IR.DATATYPE.VOID
    	end if

    end if

    return TRUE

end function

'':::::
private function hCheckParam( byval f as integer, _
							  byval n as integer )

    dim as FBSYMBOL ptr proc, arg, s
    dim as integer adtype, adclass, amode
    dim as integer p, pdtype, pdclass, pmode, pclass

    hCheckParam = FALSE

	''
	proc = astTB(f).proc.sym

	if( astTB(f).proc.params >= proc->proc.args ) then
		arg = symbGetProcTailArg( proc )
	else
		arg = astTB(f).proc.arg
	end if

	'' argument
	amode   	= symbGetArgMode( proc, arg )
	adtype  	= symbGetType( arg )
	if( adtype <> INVALID ) then
		adclass = irGetDataClass( adtype )
	end if

	'' string concatenation is delayed for optimization reasons..
	astTB(n).l = astUpdStrConcat( astTB(n).l )

    '' parameter
	p = astTB(n).l
	pmode    	= astTB(n).param.mode
	pdtype   	= astTB(p).dtype
	pdclass  	= irGetDataClass( pdtype )
	pclass	 	= astTB(p).class

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
						'' or if passing a ptr to a BYVAL string arg
			    		if( (pdclass <> IR.DATACLASS.INTEGER) or _
			    			(amode <> FB.ARGMODE.BYVAL) or _
			    			(irGetDataSize( pdtype ) <> FB.POINTERSIZE) ) then
							hReportParamError f
							exit function
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
			if( p <> astTB(n).l ) then
				'' node will be a function returning a PTR to a string descriptor
				pdtype  = IR.DATATYPE.STRING
				pdclass = IR.DATACLASS.STRING
				pclass	= AST.NODECLASS.PTR

				astTB(n).l = p
				astTB(n).dtype = pdtype
			end if

			''
			if( amode = FB.ARGMODE.BYVAL ) then
				'' deref var-len (ptr at offset 0)
				if( pdtype = IR.DATATYPE.STRING ) then
					astTB(n).l 	   = astNewADDR( IR.OP.DEREF, p )
					astTB(n).dtype = IR.DATATYPE.UINT
					pdclass = IR.DATACLASS.INTEGER
					pdtype  = IR.DATATYPE.UINT
				end if
			end if

			'' not a pointer yet?
			if( pclass <> AST.NODECLASS.PTR ) then
				'' descriptor or fixed-len? get the address of
				if( (pdclass = IR.DATACLASS.STRING) or (pdtype = IR.DATATYPE.CHAR) ) then
					astTB(n).l = astNewADDR( IR.OP.ADDROF, p )
					astTB(n).dtype = IR.DATATYPE.UINT
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

					s = astTB(p).proc.sym
					if( s->typ <> FB.SYMBTYPE.USERDEF ) then
						hReportParamError f
						exit function
					end if

					astTB(n).dtype = pdtype
					s = s->subtype

				else
					if( pclass <> AST.NODECLASS.FUNCT ) then
						s = astGetSubtype( p )
					else
						s = astTB(p).proc.sym->subtype
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
						astTB(n).param.lgt = symbGetUDTLen( s )
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
					astTB(n).dtype = astTB(p).dtype
					astTB(n).l = p

				end if

				'' pointer checking
				if( adtype >= IR.DATATYPE.POINTER ) then
					if( astTB(p).dtype < IR.DATATYPE.POINTER ) then
						select case as const pclass
						case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR
							hReportParamWarning f, FB.WARNINGMSG.INVALIDPOINTER
						end select
					end if
				end if

			end if

		end if

    end if


    hCheckParam = TRUE

end function

'':::::
function astNewPARAM( byval f as integer, _
					  byval p as integer, _
					  byval dtype as integer = INVALID, _
					  byval mode as integer = INVALID ) as integer
    dim n as integer
    dim t as integer
    dim proc as FBSYMBOL ptr

	if( dtype = INVALID ) then
		dtype = astGetDataType( p )
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.PARAM, dtype )
	astNewPARAM = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l = p
	astTB(n).param.mode = mode
	astTB(n).param.lgt	= 0

	'' add param node to function's list
	proc = astTB(f).proc.sym

	t = astTB(f).r

	'' pascal mode, first param added will be the first pushed
	if( proc->proc.mode = FB.FUNCMODE.PASCAL ) then
		if( t = INVALID ) then
			astTB(f).r = n
		else
			t = astTB(f).proc.lastparam
			astTB(t).r = n
		end if

		astTB(f).proc.lastparam = n
		astTB(n).r = INVALID

	else
		'' non-pascal, the lastest param added will be the first pushed
		astTB(f).r = n
		astTB(n).r = t
	end if

	''
	if( not hCheckParam( f, n ) ) then
		astNewPARAM = INVALID
		exit function
	end if

	''
	astTB(f).proc.params += 1

	if( astTB(f).proc.params < proc->proc.args ) then
		astTB(f).proc.arg = symbGetProcNextArg( proc, astTB(f).proc.arg, FALSE )
	end if

end function

'':::::
private function hCallProc( byval n as integer, _
					   		byval proc as FBSYMBOL ptr, _
					   		byval mode as integer, _
					   		byval bytestopop as integer ) static
    dim as integer vreg, vr, p, dtype

	'' ordinary pointer?
	if( proc = NULL ) then
		p = astTB(n).l
		vr = astLoad( p )
		astDel p
		irEmitCALLPTR vr, INVALID, 0
		return INVALID
	end if

	dtype = astTB(n).dtype

	'' function returns as string? it's actually a pointer to a string descriptor..
	'' same with UDT's..
	select case dtype
	case IR.DATATYPE.STRING, IR.DATATYPE.USERDEF
		dtype += IR.DATATYPE.POINTER
	end select

	if( dtype <> IR.DATATYPE.VOID ) then
		vreg = irAllocVREG( dtype )
	else
		vreg = INVALID
	end if

	if( mode <> FB.FUNCMODE.CDECL ) then
		if( mode = FB.FUNCMODE.STDCALL ) then
			if( not env.clopt.nostdcall ) then
				bytestopop = 0
			end if
		else
			bytestopop = 0
		end if
	end if

	'' call function or ptr
	p = astTB(n).l
	if( p = INVALID ) then
		irEmitCALLFUNCT proc, bytestopop, vreg
	else
		vr = astLoad( p )
		astDel p
		irEmitCALLPTR vr, vreg, bytestopop
	end if

	'' handle strings and UDT's returned by functions that are actually pointers to
	'' string descriptors or the hidden pointer passed as the 1st argument
	select case astTB(n).dtype
	case IR.DATATYPE.STRING, IR.DATATYPE.USERDEF
		vreg = irAllocVRPTR( astTB(n).dtype, 0, vreg )
	end select

	return vreg

end function

'':::::
private sub hCheckTmpStrings( byval f as integer )
    dim as integer t, copyback
    dim as ASTTEMPSTR ptr n, p

	'' copy-back any fix-len string passed as parameter and
	'' delete all temp strings used as parameters
	n = astTB(f).proc.strtail
	do while( n <> NULL )

		'' copy back if needed
		if( n->srctree <> INVALID ) then
        	'' only if not a literal string passed a fixed-len
        	copyback = TRUE
        	if( astTB(n->srctree).class = AST.NODECLASS.VAR ) then
        	    copyback = symbGetVarInitialized( astGetSymbol( n->srctree ) ) = FALSE
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
		astDel t

		p = n->left
		listDelNode( @ctx.tempstr, n )
		n = p
	loop

end sub

'':::::
private sub hFreeTempArrayDescs( byval f as integer )
    dim as integer t
    dim as ASTTEMPARRAY ptr n, p

	n = astTB(f).proc.arraytail
	do while( n <> NULL )

		t = rtlArrayFreeTempDesc( n->pdesc )
		if( t <> INVALID ) then
			astLoad( t )
			astDel t
		end if

		p = n->left
		listDelNode( @ctx.temparray, n )
		n = p
	loop

end sub

'':::::
private sub hAllocTempStruct( byval n as integer, byval proc as FBSYMBOL ptr ) static
	dim as FBSYMBOL ptr v
	dim as integer p, vr
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
function astLoadFUNCT( byval n as integer ) as integer
    dim as integer p, np
    dim as FBSYMBOL ptr proc
    dim as integer mode, bytestopop
    dim as integer params, inc, l
    dim as FBSYMBOL ptr arg, lastarg
    dim as integer args, vr

	'' execute each param and push the result
	proc = astTB(n).proc.sym

	'' ordinary pointer?
	if( proc = NULL ) then
		return hCallProc( n, NULL, INVALID, 0 )
	end if

    mode = proc->proc.mode

    ''
	if( mode = FB.FUNCMODE.PASCAL ) then
		params = 0
		inc = 1
	else
		params = astTB(n).proc.params
		inc = -1
	end if

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
		end if
	'' vararg
	else
		arg = lastarg
	end if

	bytestopop = proc->lgt

	p = astTB(n).r
	do while( p <> INVALID )
		np = astTB(p).r

		l = astTB(p).l

		''
		if( arg = lastarg ) then
			if( arg->arg.mode = FB.ARGMODE.VARARG ) then
				bytestopop += (symbCalcLen( astTB(l).dtype, NULL ) + 3) and not 3 '' x86 assumption!
			end if
		end if

		'' flush the param expression
		vr = astLoad( l )
		astDel l

		if( not irEmitPUSHPARAM( proc, arg, vr, astTB(p).param.mode, astTB(p).param.lgt ) ) then
			'''''return INVALID
		end if

		astDel p

		params += inc

		if( params < args ) then
			arg = symbGetProcNextArg( proc, arg )
		end if

		p = np
	loop

	'' handle functions returning structs
	hAllocTempStruct( n, proc )

	'' return the result (same type as function ones)
	vr = hCallProc( n, proc, mode, bytestopop )

	'' del temp strings and copy back if needed
	hCheckTmpStrings( n )

	'' del temp arrays descriptors created for array fields passed by desc
	hFreeTempArrayDescs( n )

    return vr

end function


'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' IIF
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewIIF( byval condexpr as integer, _
					byval truexpr as integer, _
					byval falsexpr as integer ) as integer static
    dim n as integer
    dim falselabel as FBSYMBOL ptr

	astNewIIF = INVALID

	if( condexpr = INVALID ) then
		exit function
	end if

    '' string? invalid
    if( irGetDataClass( astTB(truexpr).dtype ) = IR.DATACLASS.STRING ) then
    	exit function
    elseif( irGetDataClass( astTB(falsexpr).dtype ) = IR.DATACLASS.STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( astTB(truexpr).dtype = IR.DATATYPE.USERDEF ) then
		exit function
    elseif( astTB(falsexpr).dtype = IR.DATATYPE.USERDEF ) then
    	exit function
    end if

    '' are the data types different?
    if( astTB(truexpr).dtype <> astTB(falsexpr).dtype ) then
    	if( irMaxDataType( astTB(truexpr).dtype, astTB(falsexpr).dtype ) <> INVALID ) then
    		exit function
    	end if
    end if

	falselabel = symbAddLabel( hMakeTmpStr )

	condexpr = astUpdComp2Branch( condexpr, falselabel, FALSE )
	if( condexpr = INVALID ) then
		exit function
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.IIF, astTB(truexpr).dtype )
	astNewIIF = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l  			= truexpr
	astTB(n).r  			= falsexpr
	astTB(n).iif.falselabel = falselabel
	astTB(n).iif.cond		= condexpr

end function

'':::::
function astLoadIIF( byval n as integer ) as integer
    dim as integer l, r
    dim as integer v1, vr
    dim as FBSYMBOL ptr exitlabel

	l = astTB(n).l
	r = astTB(n).r

	exitlabel  = symbAddLabel( hMakeTmpStr )

	''
	astFlush( astTB(n).iif.cond )

	''
	v1 = astLoad( l )
	irEmitLOAD IR.OP.LOAD, v1
	irEmitBRANCH IR.OP.JMP, exitlabel

    irEmitLABELNF astTB(n).iif.falselabel
	v1 = astLoad( r )
	irEmitLOAD IR.OP.LOAD, v1

	irEmitLABELNF exitlabel

	vr = v1

	astDel l
	astDel r

	return vr

end function

