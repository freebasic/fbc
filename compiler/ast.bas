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
''		4) module looks much ugly than it should, thanks to all hacking needed to support
''		   QB's var-length strings
''
'' chng: sep/2004 written [v1ctor]

defint a-z
option explicit

'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\ast.bi'

type ASTCTX
	head		as integer
	tail		as integer
	fhead		as integer
	nodes		as integer

	tempstrs		as integer
end Type

type ASTTEMPSYMBOL
	symbol		as integer
	ofs			as integer
	elm			as integer
end type

type ASTTEMPSTR
	tmp			as integer
	src			as ASTTEMPSYMBOL
end type



'' globals
	dim shared ctx as ASTCTX

	redim shared astTB( 0 ) as ASTNODE

	redim shared tempstrTB( 0 ) as ASTTEMPSTR

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constant folding optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
Sub astCopy( byval d as integer, byval s as integer ) Static
	Dim p as integer, n as integer

	p = astTB(d).prv
	n = astTB(d).nxt

	astTB(d) = astTB(s)

	astTB(d).prv = p
	astTB(d).nxt = n

End Sub

'':::::
Sub astCopyEX( d as ASTNODE, s as ASTNODE ) Static
	Dim p as integer, n as integer

	p = d.prv
	n = d.nxt

	d = s

	d.prv = p
	d.nxt = n

End Sub

'':::::
Sub astSwap( byval d as integer, byval s as integer ) Static
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
Sub astOptConstRmNeg( byval n as integer, byval p as integer )
	static tmp as ASTNODE
	Dim l as integer, r as integer, o as integer

	'' check any UOP node, and if its of the kind "-var + const" convert to "const - var"
	If( astTB(n).typ = AST.NODETYPE.UOP ) Then
		if( p <> INVALID ) then
			if( astTB(n).op = IR.OP.NEG ) then
				l = astTB(n).l
				if( astTB(l).typ = AST.NODETYPE.VAR ) then
					If( astTB(p).typ = AST.NODETYPE.BOP ) Then
						If( astTB(p).op = IR.OP.ADD ) Then
							r = astTB(p).r
							If( astTB(r).defined ) Then
								tmp = astTB(r)
								astCopy r, l
								astCopyEx astTB(n), tmp
								astTB(p).op = IR.OP.SUB
								astDel l
							end if
						end if
					end if
				End If
		    end if
		end if
	End If

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astOptConstRmNeg l, n
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astOptConstRmNeg r, n
	End If

End Sub

'':::::
Sub asthConstAccumADDSUB( byval n as integer, c as double, op as integer )
	Dim l as integer, r as integer, o as integer

	If( n = INVALID ) Then
		exit sub
	end if
	If( astTB(n).typ <> AST.NODETYPE.BOP ) Then
		exit sub
	end if

	l = astTB(n).l
	r = astTB(n).r
    o = astTB(n).op

	select case o
	case IR.OP.ADD, IR.OP.SUB
		If( astTB(r).defined ) Then

			if( op < 0 ) then
				if( o = IR.OP.ADD ) then
					o = IR.OP.SUB
				else
					o = IR.OP.ADD
				end if
			end if

			select case o
			case IR.OP.ADD
				c = c + astTB(r).value
			case IR.OP.SUB
				c = c - astTB(r).value
			end select

			astDel r
			astCopy n, l
			astDel l
			asthConstAccumADDSUB n, c, op

		Else
			asthConstAccumADDSUB l, c, op
			if( o = IR.OP.SUB ) then op = -op
			asthConstAccumADDSUB r, c, op
			if( o = IR.OP.SUB ) then op = -op
		End If
	end select

End Sub

'':::::
Sub asthConstAccumMUL( byval n as integer, c as double )
	Dim l as integer, r as integer, o as integer

	If( n = INVALID ) Then
		exit sub
	end if
	If( astTB(n).typ <> AST.NODETYPE.BOP ) Then
		exit sub
	end if

	l = astTB(n).l
	r = astTB(n).r
    o = astTB(n).op

	select case o
	case IR.OP.MUL
		If( astTB(r).defined ) Then
			c = c * astTB(r).value

			astDel r
			astCopy n, l
			astDel l
			asthConstAccumMUL n, c

		Else
			asthConstAccumMUL l, c
			asthConstAccumMUL r, c
		End If
	end select

End Sub

'':::::
Sub astOptConstAccum1( byval n as integer )
	Dim l as integer, r as integer, op as integer, c as double
	dim delnode as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' check any ADD|SUB|MUL BOP node with a constant at the right leaf and
	'' then begin accumulating the other constants at the nodes below the
	'' current, deleting any constant leaf that were added
	'' (this will handle for ex. a+1+b+2-3, that will become a+b
	If( astTB(n).typ = AST.NODETYPE.BOP ) Then
		l = astTB(n).l
		r = astTB(n).r
		If( astTB(r).defined ) Then

			delnode = FALSE
			select case astTB(n).op
			case IR.OP.ADD
				c = 0
				op = 1
				asthConstAccumADDSUB l, c, op
				astTB(r).value = astTB(r).value + c
				if( astTB(r).value = 0 ) then delnode = TRUE

			case IR.OP.MUL
				c = 1
				asthConstAccumMUL l, c
				astTB(r).value = astTB(r).value * c
				if( astTB(r).value = 1 ) then delnode = TRUE

            case IR.OP.SUB
				c = 0
				op = -1
				asthConstAccumADDSUB l, c, op
				astTB(r).value = astTB(r).value - c
				if( astTB(r).value = 0 ) then delnode = TRUE

			end select

			c = astTB(r).value
			if( c - int(c) <> 0 ) then
				astTB(r).dtype = IR.DATATYPE.DOUBLE
			else
				astTB(r).dtype = IR.DATATYPE.INTEGER
			end if

			if( delnode ) then
				astDel r
				l = astTB(n).l
				astCopy n, l
				astDel l
				astOptConstAccum1 n
				exit sub
			end if

		end if
	End If

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astOptConstAccum1 l
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astOptConstAccum1 r
	End If

	select case astTB(n).typ
	'' function called through a pointer?
	case AST.NODETYPE.FUNCT
		if( astTB(n).f.p <> INVALID ) then
			astOptConstAccum1 astTB(n).f.p
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		if( astTB(n).p.nxt <> INVALID ) then
			astOptConstAccum1 astTB(n).p.nxt
		end if
	end select

End Sub

'':::::
Sub astOptConstAccum2( byval n as integer )
	Dim l as integer, r as integer, op as integer, c as double, dtype as integer

	'' check any ADD|SUB|MUL BOP node and then go to child leafs accumulating
	'' any constants found there, deleting those nodes and then adding the
	'' result to a new node, at right side of the current one
	'' (this will handle for ex. a+1+(b+2)+(c+3), that will become a+b+c+6)
	If( astTB(n).typ = AST.NODETYPE.BOP ) Then
		select case astTB(n).op
		case IR.OP.ADD
			c = 0
			op = 1
			asthConstAccumADDSUB astTB(n).l, c, op
			op = 1
			asthConstAccumADDSUB astTB(n).r, c, op
			if( c <> 0 ) then
				if( c - int(c) <> 0 ) then dtype = IR.DATATYPE.DOUBLE else dtype = IR.DATATYPE.INTEGER
				astTB(n).l = astNewBOP( IR.OP.ADD, astTB(n).l, astTB(n).r )
				astTB(n).r = astNewCONST( c, dtype )
			end if

		case IR.OP.SUB
			c = 0
			op = -1
			asthConstAccumADDSUB astTB(n).l, c, op
			op = -1
			asthConstAccumADDSUB astTB(n).r, c, op
			if( c <> 0 ) then
				if( c - int(c) <> 0 ) then dtype = IR.DATATYPE.DOUBLE else dtype = IR.DATATYPE.INTEGER
				astTB(n).l = astNewBOP( IR.OP.SUB, astTB(n).l, astTB(n).r )
				astTB(n).r = astNewCONST( c, dtype )
			end if

		case IR.OP.MUL
			c = 1
			asthConstAccumMUL astTB(n).l, c
			asthConstAccumMUL astTB(n).r, c
			if( c <> 1 ) then
				if( c - int(c) <> 0 ) then dtype = IR.DATATYPE.DOUBLE else dtype = IR.DATATYPE.INTEGER
				astTB(n).l = astNewBOP( IR.OP.MUL, astTB(n).l, astTB(n).r )
				astTB(n).r = astNewCONST( c, dtype )
			end if
        end select
	End If

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astOptConstAccum2 l
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astOptConstAccum2 r
	End If

	select case astTB(n).typ
	'' function called through a pointer?
	case AST.NODETYPE.FUNCT
		if( astTB(n).f.p <> INVALID ) then
			astOptConstAccum2 astTB(n).f.p
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		if( astTB(n).p.nxt <> INVALID ) then
			astOptConstAccum2 astTB(n).p.nxt
		end if
	end select

End Sub

'':::::
Sub asthConstDistMUL( byval m as double, byval n as integer, c as double )
	Dim l as integer, r as integer

	If( n = INVALID ) Then
		exit sub
	end if
	If( astTB(n).typ <> AST.NODETYPE.BOP ) Then
		exit sub
	end if

	l = astTB(n).l
	r = astTB(n).r

	if( astTB(n).op = IR.OP.ADD ) then
		If( astTB(r).defined ) Then
			c = c + astTB(r).value * m

			astDel r
			astCopy n, l
			astDel l
			asthConstDistMUL m, n, c

		Else
			asthConstDistMUL m, l, c
			asthConstDistMUL m, r, c
		End If
	end if

End Sub

'':::::
Sub astOptConstDistMUL( byval n as integer )
	Dim l as integer, r as integer, op as integer, c as double, nn as integer, dtype as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' check any MUL BOP node with a constant at the right leaf and then scan
	'' the left leaf for ADD BOP nodes, applying the distributive, deleting those
	'' nodes and adding the result of all sums to a new node
	'' (this will handle for ex. 2 * (3 + a * 2) that will become 6 + a * 4 (with Accum2's help))
	If( astTB(n).typ = AST.NODETYPE.BOP ) Then
		l = astTB(n).l
		r = astTB(n).r
		If( astTB(r).defined ) Then

			if( astTB(n).op = IR.OP.MUL ) then

				c = 0
				asthConstDistMUL astTB(r).value, l, c

				if( c <> 0 ) then
					if( c - int(c) <> 0 ) then dtype = IR.DATATYPE.DOUBLE else dtype = IR.DATATYPE.INTEGER
					nn = astNewCONST( c, dtype )
					nn = astNewBOP( IR.OP.ADD, n, nn )
					astSwap n, nn
					astTB(n).l = nn
				end if

			end if
		end if
	End If

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astOptConstDistMUL l
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astOptConstDistMUL r
	End If

	select case astTB(n).typ
	'' function called through a pointer?
	case AST.NODETYPE.FUNCT
		if( astTB(n).f.p <> INVALID ) then
			astOptConstDistMUL astTB(n).f.p
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		if( astTB(n).p.nxt <> INVALID ) then
			astOptConstDistMUL astTB(n).p.nxt
		end if
	end select

End Sub

'':::::
Sub astOptConstIDX( byval n as integer )
	dim l as integer, r as integer, op as integer, c as double, v as integer
	dim ll as integer, lr as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' opt must be done in this order: addsub accum and then idx * lgt

	select case astTB(n).typ
	case AST.NODETYPE.IDX, AST.NODETYPE.PTR
		l = astTB(n).l
		if( l <> INVALID ) then
			c = 0
			op = 1
			asthConstAccumADDSUB l, c, op
        	astTB(n).v.ofs  = astTB(n).v.ofs + clng( c )

        	if( astTB(l).typ = AST.NODETYPE.CONST ) then
				astTB(n).v.ofs = astTB(n).v.ofs + clng( astTB(l).value )
				astDel astTB(n).l
			end if
		end if
	end select

	if( astTB(n).typ = AST.NODETYPE.IDX ) Then
		l = astTB(n).l
		if( l <> INVALID ) then
			'' if top of tree = idx * lgt, and lgt < 10, save lgt and delete * node
			if( astTB(l).typ = AST.NODETYPE.BOP ) Then
				if( astTB(l).op = IR.OP.MUL ) then
					lr = astTB(l).r
					if( astTB(lr).defined ) then
						v = cint( astTB(lr).value )
						if( (v < 10) and (v <> 6) and (v <> 7) ) then
				    		astTB(n).v.lgt = v
				    		astDel lr

							ll = astTB(l).l
							astCopy l, ll
							astDel ll
						end if
				    end if
				end if
			end if
        end if
	end if

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astOptConstIDX l
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astOptConstIDX r
	End If

	select case astTB(n).typ
	'' function called through a pointer?
	case AST.NODETYPE.FUNCT
		if( astTB(n).f.p <> INVALID ) then
			astOptConstIDX astTB(n).f.p
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		if( astTB(n).p.nxt <> INVALID ) then
			astOptConstIDX astTB(n).p.nxt
		end if
	end select

End Sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' arithmetic association optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
Sub astOptAssocADD( byval n as integer )
	Dim l as integer, r as integer, op as integer, rop as integer

	if( n = INVALID ) then
		exit sub
	end if

    '' convert a+(b+c) to a+b+c and a-(b-c) to a-b+c
	If( astTB(n).typ = AST.NODETYPE.BOP ) Then
		op = astTB(n).op
		if( op = IR.OP.ADD or op = IR.OP.SUB ) then
			r = astTB(n).r
			If( astTB(r).typ = AST.NODETYPE.BOP ) Then
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
	End If

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astOptAssocADD l
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astOptAssocADD r
	End If

	select case astTB(n).typ
	'' function called through a pointer?
	case AST.NODETYPE.FUNCT
		if( astTB(n).f.p <> INVALID ) then
			astOptAssocADD astTB(n).f.p
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		if( astTB(n).p.nxt <> INVALID ) then
			astOptAssocADD astTB(n).p.nxt
		end if
	end select

End Sub

'':::::
Sub astOptAssocMUL( byval n as integer )
	Dim l as integer, r as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' convert a*(b*c) to a*b*c
	If( astTB(n).typ = AST.NODETYPE.BOP ) Then
		if( astTB(n).op = IR.OP.MUL ) then
			r = astTB(n).r
			If( astTB(r).typ = AST.NODETYPE.BOP ) Then
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
	End If

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astOptAssocMUL l
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astOptAssocMUL r
	End If

	select case astTB(n).typ
	'' function called through a pointer?
	case AST.NODETYPE.FUNCT
		if( astTB(n).f.p <> INVALID ) then
			astOptAssocMUL astTB(n).f.p
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		if( astTB(n).p.nxt <> INVALID ) then
			astOptAssocMUL astTB(n).p.nxt
		end if
	end select

End Sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' other optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
Sub astOptToShift( byval n as integer )
	Dim l as integer, r as integer
	dim v as integer, op as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' convert 'a * pow2 imm' to 'a shl pow2' and 'a \ pow2 imm' to 'a shr pow2'
	If( astTB(n).typ = AST.NODETYPE.BOP ) Then
		op = astTB(n).op
		if( (op = IR.OP.MUL) or (op = IR.OP.INTDIV) ) then
			r = astTB(n).r
			if( astTB(r).defined ) Then
				if( irGetDataClass( astTB(n).dtype ) = IR.DATACLASS.INTEGER ) then
					v = cint( astTB(r).value )
					if( v > 0 ) then
						v = hToPow2( v )
						if( (v > 0) and (v <= 32) ) then
							if( op = IR.OP.MUL ) then
								astTB(n).op = IR.OP.SHL
							else
								astTB(n).op = IR.OP.SHR
							end if
							astTB(r).value = v
						end if
					end if
				end if
			end if
		end if
	End If

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astOptToShift l
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astOptToShift r
	End If

	select case astTB(n).typ
	'' function called through a pointer?
	case AST.NODETYPE.FUNCT
		if( astTB(n).f.p <> INVALID ) then
			astOptToShift astTB(n).f.p
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		if( astTB(n).p.nxt <> INVALID ) then
			astOptToShift astTB(n).p.nxt
		end if
	end select

End Sub


''::::
sub astUpdNodeResult( byval n as integer )
	Dim l as integer, r as integer
	static dt1 as integer, dt2 as integer
	static dtype as integer, dclass as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astUpdNodeResult l
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astUpdNodeResult r
	End If

	select case astTB(n).typ
	case AST.NODETYPE.BOP

		dt1 = astTB(l).dtype
		dt2 = astTB(r).dtype

		'' convert byte to integer
		if( irGetDataSize( dt1 ) = 1 ) then
			if( irGetDataClass( dt2 ) = IR.DATACLASS.FPOINT ) then
				dt1 = IR.DATATYPE.INTEGER
			elseif( irGetDataSize( dt2 ) = 1 ) then
				if( irIsSigned( dt1 ) ) then
					dt1 = IR.DATATYPE.INTEGER
				else
					dt1 = IR.DATATYPE.UINT
				end if
			else
				dt1 = dt2
			end if

		end if

		if( irGetDataSize( dt2 ) = 1 ) then
			if( irGetDataClass( dt1 ) = IR.DATACLASS.FPOINT ) then
				dt2 = IR.DATATYPE.INTEGER
			else
				dt2 = dt1
			end if
		end if

		'' different types?
		if( dt1 <> dt2 ) then
			dtype = irMaxDataType( dt1, dt2 )

		    if( dtype = -1 ) then
		    	dtype = dt1

			else
				'' both integers and highest one is a imm? decrase its class
				if( (irGetDataClass( dt1 ) = IR.DATACLASS.INTEGER) and _
					(irGetDataClass( dt2 ) = IR.DATACLASS.INTEGER) ) then
					if( dtype <> dt1 ) then
						if( astTB(r).typ = AST.NODETYPE.CONST ) then
							dt2 = dt1
							dtype = dt1
						end if
					else
						if( astTB(l).typ = AST.NODETYPE.CONST ) then
							dt1 = dt2
							dtype = dt2
						end if
					end if
				end if
			end if

		else
			dtype = dt1
		end if

		dclass = irGetDataClass( dtype )

		select case astTB(n).op
		'' a / b needs both operands as floats
		case IR.OP.DIV
			if( dclass <> IR.DATACLASS.FPOINT ) then
				dtype = IR.DATATYPE.DOUBLE
			end if

		'' bitwise operations, int div (\), modulus and shift only work with integers
		case IR.OP.AND, IR.OP.OR, IR.OP.XOR, IR.OP.EQV, IR.OP.IMP, _
			 IR.OP.INTDIV, IR.OP.MOD, IR.OP.SHL, IR.OP.SHR
			if( dclass <> IR.DATACLASS.INTEGER ) then
				dtype = IR.DATATYPE.INTEGER
			end if

		'' if operands are floats and are been comparated, result must be an integer (boolean)
		case IR.OP.EQ, IR.OP.GT, IR.OP.LT, IR.OP.NE, IR.OP.LE, IR.OP.GE
			if( dclass <> IR.DATACLASS.INTEGER ) then
				dtype = IR.DATATYPE.INTEGER
			end if

		end select


		astTB(n).dtype = dtype


	case AST.NODETYPE.UOP

		dtype = astTB(l).dtype

		dclass = irGetDataClass( dtype )

		'' NOT can only be done with integers
		if( astTB(n).op = IR.OP.NOT ) then
			if( dclass <> IR.DATACLASS.INTEGER ) then
				dtype = IR.DATATYPE.INTEGER
			end if
		end if

		astTB(n).dtype = dtype

	end select

	'' function called through a pointer?
	select case astTB(n).typ
	case AST.NODETYPE.FUNCT
		if( astTB(n).f.p <> INVALID ) then
			astUpdNodeResult astTB(n).f.p
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		if( astTB(n).p.nxt <> INVALID ) then
			astUpdNodeResult astTB(n).p.nxt
		end if
	end select

end sub

''::::
sub astOptAssignament( byval n as integer ) static
	Dim l as integer, r as integer
	Dim rl as integer

	'' try to convert "foo = foo op expr" to "foo op= expr" (including unary ops)
	if( n = INVALID ) then
		exit sub
	end if

	'' there's just one assignament per tree (always at top), so, just check this node
	If( astTB(n).typ <> AST.NODETYPE.ASSIGN ) Then
		exit sub
	end if

	'' integer's only, no way to optimize with a FPU stack (x86 dep.)
	If( irGetDataClass( astTB(n).dtype ) <> IR.DATACLASS.INTEGER ) Then
		exit sub
	end if

	'' can't be byte either, as BOP will do cint(byte) op cint(byte)
	If( irGetDataSize( astTB(n).dtype ) = 1 ) Then
		exit sub
	end if

	'' left side
	l = astTB(n).l

	'' is node a var?
	select case astTB(l).typ
	case AST.NODETYPE.VAR
	case else
		exit sub
	end select

	'' right side
	r = astTB(n).r

	'' is node a bin or unary operation?
	select case astTB(r).typ
	case AST.NODETYPE.UOP, AST.NODETYPE.BOP
	case else
		exit sub
	end select

	'' node result is integer too?
	If( irGetDataClass( astTB(r).dtype ) <> IR.DATACLASS.INTEGER ) Then
		exit sub
	end if

	'' is the left child a var too?
	rl = astTB(r).l
	if( astTB(rl).typ <> AST.NODETYPE.VAR ) then
		exit sub
	end if

	'' are both vars the same?
	if( (astTB(rl).v.s <> astTB(l).v.s) or (astTB(rl).v.ofs <> astTB(l).v.ofs) ) then
		exit sub
	end if

	'' delete assign node and alert UOP/BOP to not allocate a result (IR is aware)
	astTB(r).allocres = FALSE

    astCopy n, r
	astDel l
	astDel r

end sub

'':::::
function astOptComp2Branch( byval n as integer, byval label as integer, byval isinverse as integer ) as integer static
	dim op as integer

	astOptComp2Branch = FALSE

	if( n = INVALID ) then
		exit function
	end if

	'' shortcut "exp logop exp" if it's at top of tree (used to optimize IF/ELSEIF/WHILE/UNTIL)
	if( astTB(n).typ <> AST.NODETYPE.BOP ) then
		exit function
	end if

	'' logical operator?
	op = astTB(n).op
	select case op
	case IR.OP.EQ, IR.OP.NE, IR.OP.GT, IR.OP.LT, IR.OP.GE, IR.OP.LE
	case else
		exit function
	end select

	'' invert it
	if( not isinverse ) then
		astTB(n).op = irGetInverseLogOp( op )
	end if

	'' tell IR that the destine label is already set
	astTB(n).ex = label

	'' warn caller that the operation was optimized
	astOptComp2Branch = TRUE

end function


'':::::
sub astDump1 ( byval p as integer, byval n as integer, byval isleft as integer, _
			   byval ln as integer, byval cn as integer )
'   dim v as string, l as integer, c as integer

'	v = ""
'	select case astTB(n).typ
'	case AST.NODETYPE.BOP
'		select case astTB(n).op
'		case IR.OP.ADD
'			v = "+"
'		case IR.OP.SUB
'			v = "-"
'		case IR.OP.MUL
'			v = "*"
'		case IR.OP.DIV
'			v = "/"
'		case IR.OP.INTDIV
'			v = "\"
'		case IR.OP.AND
'			v = "&"
'		case IR.OP.OR
'			v = "|"
'		case IR.OP.XOR
'			v = "^"
'		end select
'		v = "(" + v + ")"

'	case AST.NODETYPE.UOP
'		select case astTB(n).op
'		case IR.OP.NEG
'			v = "-"
'		case IR.OP.NOT
'			v = "!"
'		end select
'		v = "(" + v + ")"

'	case AST.NODETYPE.VAR
'		v = "[" + rtrim$( mid$( symbGetVarName( astTB(n).v.s ), 2 ) ) + "]"
'	case AST.NODETYPE.CONST
'		v = "[" + ltrim$( str$( astTB(n).value ) ) + "]"
'	case AST.NODETYPE.IDX
'		c = astTB(n).v.s
'		v = "{" + rtrim$( mid$( symbGetVarName( astTB(c).v.s ), 2 ) ) + "}"

'	case AST.NODETYPE.FUNCT
'		v = rtrim$( mid$( symbGetProcName( astTB(n).f.s ), 2 ) ) + "()"

'	case AST.NODETYPE.PARAM
'		v = "(" + ltrim$( str$( astTB(n).l ) ) + ")"
'	end select

'	if( len( v ) > 0 and ln <= 50 ) then

		'v = ltrim$( str$( n ) ) + v
'		if( p <> INVALID ) then
'        	if( isleft ) then
'        		v = v + "/"
'        	else
'        		v = "\" + v
'        	end if
'		end if

'		c = cn - (len(v)\2)
'		if( c > 1 and c + len(v)\2 <= 80 ) then
'			locate ln, c
'			print v;
'		end if
'	end if

'	if( astTB(n).l <> INVALID ) then
'		astDump1 n, astTB(n).l, TRUE, ln+2, cn-4
'	end if

'	if( astTB(n).r <> INVALID ) then
'		astDump1 n, astTB(n).r, FALSE, ln+2, cn+4
'	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree cloning and deletion
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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
	If( p <> INVALID ) Then
		astTB(nn).l = astCloneTree( p )
	End If

	p = astTB(n).r
	If( p <> INVALID ) Then
		astTB(nn).r = astCloneTree( p )
	End If

	select case astTB(n).typ
	'' function called through a pointer?
	case AST.NODETYPE.FUNCT
		p = astTB(n).f.p
		if( p <> INVALID ) then
			astTB(nn).f.p = astCloneTree( p )
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		p = astTB(n).p.nxt
		if( p <> INVALID ) then
			astTB(nn).p.nxt = astCloneTree( p )
		end if
	end select

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
	If( p <> INVALID ) Then
		astDelTree p
	End If

	p = astTB(n).r
	If( p <> INVALID ) Then
		astDelTree p
	End If

	select case astTB(n).typ
	'' function called through a pointer?
	case AST.NODETYPE.FUNCT
		p = astTB(n).f.p
		if( p <> INVALID ) then
			astDelTree p
		end if

	'' param node? call next if any
	case AST.NODETYPE.PARAM
		p = astTB(n).p.nxt
		if( p <> INVALID ) then
			astDelTree p
		end if
	end select

	''
	astDel n

End Sub

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
sub astInit static

	''
	ctx.head 		= INVALID
	ctx.tail 		= INVALID
	ctx.nodes		= 0

    astRealloc AST.INITNODES

	''
	redim tempstrTB( 0 to AST.MAXTEMPSTRINGS-1 ) as ASTTEMPSTR

	ctx.tempstrs	= 0

end sub

'':::::
sub astEnd static

	erase tempstrTB

	erase astTB

	''
	ctx.head 		= INVALID
	ctx.tail 		= INVALID
	ctx.fhead 		= 0
	ctx.nodes		= 0

end sub

'':::::
function astNew( byval typ as integer, byval dtype as integer ) as integer static
	dim n as integer, t as integer

	'' realloc node list if it's full
	If( ctx.fhead = INVALID ) Then
		astRealloc ctx.nodes \ 2
	End If

	'' take from free list
	n = ctx.fhead
	ctx.fhead = astTB(n).nxt

	'' add to used list
	t = ctx.tail
	ctx.tail = n
	If( t <> INVALID ) Then
		astTB(t).nxt = n
	Else
		ctx.head = n
	End If

	astTB(n).prv	= t
	astTB(n).nxt	= INVALID

	''
	astTB(n).typ 	= typ

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT
	astTB(n).dtype 	= dtype

	astTB(n).defined= FALSE
	astTB(n).value	= 0
	astTB(n).op		= INVALID
	astTB(n).l    	= INVALID
	astTB(n).r    	= INVALID

	astNew = n

end function

'':::::
sub astDel( n as integer ) static
	Dim pn as integer, nn as integer

	if( n = INVALID ) Then
		Exit Sub
	End If

	astTB(n).l    = INVALID
	astTB(n).r    = INVALID

	'' remove from used list
	pn = astTB(n).prv
	nn = astTB(n).nxt
	If( pn <> INVALID ) Then
		astTB(pn).nxt = nn
	Else
		ctx.head = nn
	End If

	If( nn <> INVALID ) Then
		astTB(nn).prv = pn
	Else
		ctx.tail = pn
	End If

	'' add to free list
	astTB(n).nxt = ctx.fhead
	ctx.fhead = n

	''
	n = INVALID

end sub

'':::::
function astGetType( byval n as integer ) as integer static

	if( n <> INVALID ) then
		astGetType = astTB(n).typ
	else
		astGetType = INVALID
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
function astGetSymbol( byval n as integer ) as integer static

	astGetSymbol = INVALID

	if( n <> INVALID ) then
		if( astTB(n).typ = AST.NODETYPE.PTR ) then
			astGetSymbol = astTB(n).v.s
			exit function
		end if

		select case astTB(n).typ
		case AST.NODETYPE.VAR, AST.NODETYPE.IDX
			if( astTB(n).typ = AST.NODETYPE.IDX ) then
				n = astTB(n).v.s
			end if
			astGetSymbol = astTB(n).v.s
		end select
	end if

end function

'':::::
function astGetVARElm( byval n as integer ) as integer static

	astGetVARElm = INVALID

	if( n <> INVALID ) then
		if( astTB(n).typ = AST.NODETYPE.PTR ) then
			astGetVARElm = astTB(n).v.e
			exit function
		end if

		select case astTB(n).typ
		case AST.NODETYPE.VAR, AST.NODETYPE.IDX
			if( astTB(n).typ = AST.NODETYPE.IDX ) then
				n = astTB(n).v.s
			end if
			astGetVARElm = astTB(n).v.e
		end select
	end if

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
sub astLoad( byval n as integer, vreg as integer )

	if( n = INVALID ) then
		exit sub
	end if

	select case astTB(n).typ
	case AST.NODETYPE.ASSIGN
		astLoadASSIGN n, vreg

	case AST.NODETYPE.CONV
		astLoadCONV n, vreg

	case AST.NODETYPE.CONST
		astLoadCONST n, vreg

	case AST.NODETYPE.VAR
		astLoadVAR n, vreg

	case AST.NODETYPE.BOP
		astLoadBOP n, vreg

	case AST.NODETYPE.UOP
		astLoadUOP n, vreg

	case AST.NODETYPE.IDX
		astLoadIDX n, vreg

	case AST.NODETYPE.FUNCT
		astLoadFUNCT n, vreg

	case AST.NODETYPE.PTR
		astLoadPTR n, vreg

	case AST.NODETYPE.ADDR
		astLoadADDR n, vreg

	case AST.NODETYPE.LOAD
		astLoadLOAD n, vreg
    end select

end sub

''::::
sub astBinOperation( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer, byval ex as integer ) static

	if( ex <> INVALID ) then					'' hack! ex=label, vr=INV 'll gen better code at IR..
		vr = INVALID
	end if

	irEmitBOPEx op, v1, v2, vr, ex

end sub

''::::
sub astUnaOperation( byval op as integer, byval v1 as integer, byval vr as integer ) static

	irEmitUOP op, v1, vr

end sub

''::::
sub astAddrOperation( byval op as integer, byval v1 as integer, byval vr as integer ) static

	irEmitADDR op, v1, vr

end sub

''::::
sub astOptimize( byval n as integer )

	'' calls must be done in the order below

	astOptAssocADD n

	astOptAssocMUL n

	astOptConstDistMUL n

	astOptConstAccum1 n

	astOptConstAccum2 n

	astOptConstRmNeg n, INVALID

	astOptConstIDX n

	astOptToShift n

	astUpdNodeResult n					'' <-- need even when not optimizing!

	astOptAssignament n

end sub

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

''::::
sub astFlush( byval n as integer, vreg as integer )

	if( n = INVALID ) then
		exit sub
	end if

	astOptimize n

	astLoad n, vreg

	astDel n

end sub

''::::
function astFlushEx( byval n as integer, vreg as integer, byval label as integer, byval isinverse as integer ) as integer

	if( n = INVALID ) then
		astFlushEx = FALSE
		exit function
	end if

	astOptimize n

	astFlushEx = astOptComp2Branch( n, label, isinverse )

	astLoad n, vreg

	astDel n

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' binary operations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewBOPEx( byval op as integer, byval l as integer, r as integer, _
					  byval ex as integer, byval allocres as integer ) as integer static
    dim n as integer
    dim dt1 as integer, dt2 as integer, dtype as integer
    dim dc1 as integer, dc2 as integer

	astNewBOPEx = INVALID

	if( (l = INVALID) or (r = INVALID) ) then
		exit function
	end if

	dt1 = astTB(l).dtype
	dt2 = astTB(r).dtype
	dc1 = irGetDataClass( dt1 )
	dc2 = irGetDataClass( dt2 )

    '' strings?
    if( (dc1 = IR.DATACLASS.STRING) or (dc2 = IR.DATACLASS.STRING) ) then

		if( dc1 <> dc2 ) then
			exit function
		end if

		select case op
		case IR.OP.ADD
			astNewBOPEx = rtlStrConcat( l, dt1, r, dt2 )
			exit function

		case IR.OP.EQ, IR.OP.GT, IR.OP.LT, IR.OP.NE, IR.OP.LE, IR.OP.GE
			l = rtlStrCompare( l, dt1, r, dt2 )
			r = astNewCONST( 0, IR.DATATYPE.INTEGER )

			dt1 = astTB(l).dtype
			dt2 = astTB(r).dtype

		case else
			exit function
		end select
    end if


	'' constant folding (won't handle commutation, ie: "1+a+2+3" will become "1+a+5", not "a+6")
	if( astTB(l).defined and astTB(r).defined ) then

		select case op
		case IR.OP.ADD
			astTB(l).value = astTB(l).value + astTB(r).value
		case IR.OP.SUB
			astTB(l).value = astTB(l).value - astTB(r).value
		case IR.OP.MUL
			astTB(l).value = astTB(l).value * astTB(r).value
		case IR.OP.DIV
			astTB(l).value = astTB(l).value / astTB(r).value
		case IR.OP.INTDIV
			astTB(l).value = int(astTB(l).value) \ int(astTB(r).value)
		case IR.OP.MOD
			astTB(l).value = int(astTB(l).value) mod int(astTB(r).value)

		case IR.OP.SHL
			astTB(l).value = int(astTB(l).value) shl int(astTB(r).value)
		case IR.OP.SHR
			astTB(l).value = int(astTB(l).value) shr int(astTB(r).value)

		case IR.OP.AND
			astTB(l).value = int(astTB(l).value) and int(astTB(r).value)
		case IR.OP.OR
			astTB(l).value = int(astTB(l).value) or int(astTB(r).value)
		case IR.OP.XOR
			astTB(l).value = int(astTB(l).value) xor int(astTB(r).value)
		case IR.OP.EQV
			astTB(l).value = int(astTB(l).value) eqv int(astTB(r).value)
		case IR.OP.IMP
			astTB(l).value = int(astTB(l).value) imp int(astTB(r).value)

		case IR.OP.POW
			astTB(l).value = astTB(l).value ^ astTB(r).value

		case IR.OP.EQ
			astTB(l).value = int(astTB(l).value = astTB(r).value)
		case IR.OP.GT
			astTB(l).value = int(astTB(l).value > astTB(r).value)
		case IR.OP.LT
			astTB(l).value = int(astTB(l).value < astTB(r).value)
		case IR.OP.NE
			astTB(l).value = int(astTB(l).value <> astTB(r).value)
		case IR.OP.LE
			astTB(l).value = int(astTB(l).value <= astTB(r).value)
		case IR.OP.GE
			astTB(l).value = int(astTB(l).value >= astTB(r).value)
		end select


		select case op
		'' for a / b, result is a double
		case IR.OP.DIV, IR.OP.POW
			astTB(l).dtype = IR.DATATYPE.DOUBLE

		'' with bitwise operations, int div (\), modulus and shift, result is an integer
		case IR.OP.AND, IR.OP.OR, IR.OP.XOR, IR.OP.EQV, IR.OP.IMP, _
			 IR.OP.INTDIV, IR.OP.MOD, IR.OP.SHL, IR.OP.SHR
			astTB(l).dtype = IR.DATATYPE.INTEGER

		'' if operands are floats and are been comparated, result will be an integer (boolean)
		case IR.OP.EQ, IR.OP.GT, IR.OP.LT, IR.OP.NE, IR.OP.LE, IR.OP.GE
			astTB(l).dtype = IR.DATATYPE.INTEGER

		'' check most precise type
		case else
			if( astTB(l).dtype <> astTB(r).dtype ) then
				dtype = irMaxDataType( astTB(l).dtype, astTB(r).dtype )
				if( dtype <> -1 ) then astTB(l).dtype = dtype
			end if

		end select

		''
		astDel r

		astNewBOPEx = l
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
			astTB(r).value = -astTB(r).value
			op = IR.OP.ADD
		end select
	end if

	'' handle pow
	if( op = IR.OP.POW ) then
		astNewBOPEx = rtlMathPow( l, r )
		exit function
	end if

	'' check for different data types
	if( dt1 <> dt2 ) then
		dtype = irMaxDataType( dt1, dt2 )
		if( dtype = -1 ) then dtype = dt1
	else
		dtype = dt1
	end if

	'' alloc new node
	n = astNew( AST.NODETYPE.BOP, dtype )
	astNewBOPEx = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).op 		= op
	astTB(n).l  		= l
	astTB(n).r  		= r
	astTB(n).ex 		= ex
	astTB(n).allocres	= allocres

end function

'':::::
function astNewBOP( byval op as integer, byval l as integer, r as integer ) as integer static

	astNewBOP = astNewBOPEx( op, l, r, INVALID, TRUE )

end function

'':::::
function asthBOPConvDataType( byval op as integer, byval l as integer, byval r as integer, v1 as integer, v2 as integer ) as integer static
    dim vt as integer
    dim dt1 as integer, dt2 as integer
    dim dc1 as integer, dc2 as integer

	dt1 = astTB(l).dtype
	dt2 = astTB(r).dtype
	dc1 = irGetDataClass( dt1 )
	dc2 = irGetDataClass( dt2 )
	vt = INVALID

	select case op
	'' a / b needs both operands as floats
	case IR.OP.DIV
		if( dc1 <> IR.DATACLASS.FPOINT ) then
			vt = irAllocVREG( IR.DATATYPE.DOUBLE )
			irEmitCONVERT vt, IR.DATATYPE.DOUBLE, v1, dt1
			v1 = vt
			astTB(l).dtype = IR.DATATYPE.DOUBLE
		end if

		if( dc2 <> IR.DATACLASS.FPOINT ) then
			'' hack! if it's an int var, let the FPU do it..
			if( (not irIsVAR( v2 )) or (dt2 <> IR.DATATYPE.INTEGER) ) then
				vt = irAllocVREG( IR.DATATYPE.DOUBLE )
				irEmitCONVERT vt, IR.DATATYPE.DOUBLE, v2, dt2
				v2 = vt
				astTB(r).dtype = IR.DATATYPE.DOUBLE
			end if
		end if

	'' bitwise operations, int div (\), modulus and shift only work with integers
	case IR.OP.AND, IR.OP.OR, IR.OP.XOR, IR.OP.EQV, IR.OP.IMP, _
		 IR.OP.INTDIV, IR.OP.MOD, IR.OP.SHL, IR.OP.SHR
		if( dc1 <> IR.DATACLASS.INTEGER ) then
			vt = irAllocVREG( IR.DATATYPE.INTEGER )
			irEmitCONVERT vt, IR.DATATYPE.INTEGER, v1, dt1
			v1 = vt
			astTB(l).dtype = IR.DATATYPE.INTEGER
		end if

		if( dc2 <> IR.DATACLASS.INTEGER ) then
			vt = irAllocVREG( IR.DATATYPE.INTEGER )
			irEmitCONVERT vt, IR.DATATYPE.INTEGER, v2, dt2
			v2 = vt
			astTB(r).dtype = IR.DATATYPE.INTEGER
		end if

	end select

	'' any conversion done?
	if( vt <> INVALID ) then
		asthBOPConvDataType = TRUE
	else
		asthBOPConvDataType = FALSE
	end if

end function

'':::::
sub asthBOPCheckDataType( byval l as integer, byval r as integer, v1 as integer, v2 as integer ) static
    dim s as integer, vt as integer, typ as integer
    dim dt1 as integer, dt2 as integer, mpt as integer
    dim dc1 as integer, dc2 as integer

	dt1 = astTB(l).dtype
	dt2 = astTB(r).dtype
	dc1 = irGetDataClass( dt1 )
	dc2 = irGetDataClass( dt2 )

	'' operands with different types? convert to the most precise
	if( dt1 <> dt2 ) then
		mpt = irMaxDataType( dt1, dt2 )

		if( mpt = INVALID ) then
			exit sub
		end if

		if( mpt <> dt1 ) then
			'' both integers and highest one is a imm? decrase its class
			if( (dc1 = IR.DATACLASS.INTEGER) and (dc2 = IR.DATACLASS.INTEGER) ) then
				if( astTB(r).typ = AST.NODETYPE.CONST ) then
					astTB(r).dtype = astTB(l).dtype
					exit sub
				end if
			end if

			'' if int oper is an IMM, allocate a temp var
			if( irIsIMM( v1 ) and (dc2 = IR.DATACLASS.FPOINT) ) then
				typ = hDtype2Stype( dt2 )
				s = hAllocFloatConst( str$( irGetVRValue( v1 ) ), typ )
				v1 = irAllocVRVAR( dt2, s, 0 )
			else
				vt = irAllocVREG( dt2 )
				irEmitCONVERT vt, dt2, v1, dt1
				v1 = vt
			end if

            astTB(l).dtype = dt2

		else
			'' both integers and highest one is a imm? decrase its class
			if( (dc1 = IR.DATACLASS.INTEGER) and (dc2 = IR.DATACLASS.INTEGER) ) then
				if( astTB(l).typ = AST.NODETYPE.CONST ) then
					astTB(l).dtype = astTB(r).dtype
					exit sub
				end if
			end if

			if( irIsIMM( v2 ) and (dc1 = IR.DATACLASS.FPOINT) ) then
				typ = hDtype2Stype( dt1 )
				s = hAllocFloatConst( str$( irGetVRValue( v2 ) ), typ )
				v2 = irAllocVRVAR( dt1, s, 0 )
				astTB(r).dtype = dt1
			else
				'' hack! if it's an int var, let the FPU do it..
				if( (not irIsVAR( v2 )) or (dt2 <> IR.DATATYPE.INTEGER) ) then
					vt = irAllocVREG( dt1 )
					irEmitCONVERT vt, dt1, v2, dt2
					v2 = vt
					astTB(r).dtype = dt1
				end if
			end if

		end if
	end if

end sub

'':::::
sub asthBOPConvByteDataType( byval l as integer, byval r as integer, v1 as integer, v2 as integer ) static
    dim vt as integer, dtype as integer
    dim dt1 as integer, ds1 as integer
    dim dt2 as integer, ds2 as integer

	dt1 = astTB(l).dtype
	ds1 = irGetDataSize( dt1 )
	dt2 = astTB(r).dtype
	ds2 = irGetDataSize( dt2 )

	if( ds1 = 1 ) then

		if( irGetDataClass( dt2 ) = IR.DATACLASS.FPOINT ) then
			dtype = IR.DATATYPE.INTEGER
		elseif( ds2 = 1 ) then
			if( irIsSigned( dt1 ) ) then
				dtype = IR.DATATYPE.INTEGER
			else
				dtype = IR.DATATYPE.UINT
			end if
		else
			dtype = dt2
		end if

		vt = irAllocVREG( dtype )
		irEmitCONVERT vt, dtype, v1, dt1
		astTB(l).dtype = dtype
		dt1 = dtype
	    v1 = vt

	end if

	if( ds2 = 1 ) then

		if( irGetDataClass( dt1 ) = IR.DATACLASS.FPOINT ) then
			dtype = IR.DATATYPE.INTEGER
		else
			dtype = dt1
		end if

		vt = irAllocVREG( dtype )
		irEmitCONVERT vt, dtype, v2, dt2
		astTB(r).dtype = dtype
	    v2 = vt

	end if

end sub

'':::::
sub astLoadBOP( byval n as integer, vr as integer )
    dim l as integer, r as integer, op as integer
    dim v1 as integer, v2 as integer

	op = astTB(n).op
	l  = astTB(n).l
	r  = astTB(n).r

	if( (l = INVALID) or (r = INVALID) ) then
		exit sub
	end if

	'' need some other algo here to select which operand is better to evalutate
	'' first - pay attention to logical ops, "func1(bar) OR func1(foo)" isn't
	'' the same as the inverse if func1 depends on the order..
	astLoad l, v1
	astLoad r, v2

	'' convert data types if needed, or check if operator data types are the same

	asthBOPConvByteDataType l, r, v1, v2

	if( not asthBOPConvDataType( op, l, r, v1, v2 ) ) then
		asthBOPCheckDataType l, r, v1, v2
	end if

	'' result type can be different, with boolean operations on floats
	if( astTB(n).allocres ) then
		vr = irAllocVREG( astTB(n).dtype )
	else
		vr = INVALID
	end if

	'' execute the operation
	astBinOperation op, v1, v2, vr, astTB(n).ex

	'' nodes not needed anymore
	astDel l
	astDel r

	'' "var op= expr" optimizations
	if( vr = INVALID ) then
		vr = v1
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' unary operations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewUOP( byval op as integer, byval o as integer ) as integer static
    dim n as integer, dclass as integer

	astNewUOP = INVALID

	if( o = INVALID ) then
		exit function
	end if

    '' string? can't operate
    dclass = irGetDataClass( astTB(o).dtype )
    if( dclass = IR.DATACLASS.STRING ) then
    	exit function
    end if

	'' constant folding
	if( astTB(o).defined ) then
		select case op
		case IR.OP.NOT
			astTB(o).value = not int(astTB(o).value)
			astTB(o).dtype = IR.DATATYPE.INTEGER
		case IR.OP.NEG
			astTB(o).value = - astTB(o).value

		case IR.OP.ABS
			astTB(o).value = abs( astTB(o).value )
		case IR.OP.SGN
			astTB(o).value = sgn( astTB(o).value )
		end select

		astNewUOP = o
		exit function
	end if

	'' hack! SGN with floats is handled by a function
	if( (op = IR.OP.SGN) and (dclass = IR.DATACLASS.FPOINT) ) then
		astNewUOP = rtlMathFSGN( o )
		astTB(o).dtype = IR.DATATYPE.INTEGER
		exit function
	end if

	'' alloc new node
	n = astNew( AST.NODETYPE.UOP, astTB(o).dtype )
	astNewUOP = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).op 		= op
	astTB(n).l  		= o
	astTB(n).r  		= INVALID
	astTB(n).allocres	= TRUE
	astTB(n).ex 		= INVALID

end function

'':::::
function asthUOPConvDataType( byval op as integer, byval o as integer, v1 as integer ) as integer static
    dim vt as integer
    dim dt1 as integer
    dim dc1 as integer

	dt1 = astTB(o).dtype
	dc1 = irGetDataClass( dt1 )
	vt = INVALID

	'' NOT can only be done with integers
	select case op
	case IR.OP.NOT
		if( dc1 <> IR.DATACLASS.INTEGER ) then
			vt = irAllocVREG( IR.DATATYPE.INTEGER )
			irEmitCONVERT vt, IR.DATATYPE.INTEGER, v1, dt1
			v1 = vt
			astTB(o).dtype = IR.DATATYPE.INTEGER
		end if
	end select

	if( vt <> INVALID ) then
		asthUOPConvDataType = TRUE
	else
		asthUOPConvDataType = FALSE
	end if

end function

'':::::
sub astLoadUOP( byval n as integer, vr as integer )
    dim o as integer, op as integer
    dim v1 as integer

	o  = astTB(n).l
	op = astTB(n).op

	if( o = INVALID ) then
		exit sub
	end if

	astLoad o, v1

	if( asthUOPConvDataType( op, o, v1 ) ) then
		astTB(n).dtype = astTB(o).dtype
	end if

	if( astTB(n).allocres ) then
		vr = irAllocVREG( astTB(o).dtype )
	else
		vr = INVALID
	end if

	astUnaOperation op, v1, vr

	astDel o

	'' "op var" optimizations
	if( vr = INVALID ) then
		vr = v1
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constants
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewCONST( byval value as double, byval dtype as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODETYPE.CONST, dtype )
	astNewCONST = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).value 	= value
	astTB(n).defined= TRUE

end function

'':::::
sub astLoadCONST( byval n as integer, vreg as integer ) static
	dim s as integer, typ as integer

  	'' if node is a float, create a temp float var (FPU can't operate on IMM's)
  	if( irGetDataClass( astTB(n).dtype ) = IR.DATACLASS.FPOINT ) then
		typ = hDtype2Stype( astTB(n).dtype )
		s = hAllocFloatConst( str$( astTB(n).value ), typ )
		vreg = irAllocVRVAR( astTB(n).dtype, s, 0 )

	else
		vreg = irAllocVRIMM( astTB(n).dtype, int(astTB(n).value) )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' variables
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewVAREx( byval symbol as integer, byval elm as integer, byval ofs as integer, byval dtype as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODETYPE.VAR, dtype )
	astNewVAREx = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).v.s  	= symbol
	astTB(n).v.e	= elm
	astTB(n).v.ofs 	= ofs

end function

'':::::
function astNewVAR( byval symbol as integer, byval ofs as integer, byval dtype as integer ) as integer static

	astNewVAR = astNewVAREx( symbol, INVALID, ofs, dtype )

end function


'':::::
sub astLoadVAR( byval n as integer, vreg as integer ) static

	vreg = irAllocVRVAR( astTB(n).dtype, astTB(n).v.s, astTB(n).v.ofs )

end sub

'':::::
function astGetVAROfs( byval n as integer ) as long static

	if( n <> INVALID ) then
		astGetVAROfs = astTB(n).v.ofs
	else
		astGetVAROfs = 0
	end if

end function

'':::::
sub astSetVAROfs( byval n as integer, byval ofs as integer ) static

	if( n <> INVALID ) then
		astTB(n).v.ofs = ofs
	end if

end sub


'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' indexes
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewIDX( byval v as integer, byval i as integer, byval dtype as integer ) as integer static
    dim n as integer

	if( dtype = INVALID ) then
		dtype = astGetDataType( i )
	end if

	'' alloc new node
	n = astNew( AST.NODETYPE.IDX, dtype )
	astNewIDX = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).v.s   = v
	astTB(n).v.lgt = 1
	astTB(n).v.ofs = 0

	astTB(n).l 	   = i

end function

'':::::
function asthEmitIDX( byval n as integer, byval ofs as long, byval lgt as long, byval vi as integer ) as integer static
    dim s as integer, vs as integer, vd as integer, vt as integer, dt as integer
    dim mul as string, dif as string
    dim isdyn as integer, diff as long

    s = astTB(n).v.s

    isdyn = symbGetVarIsDynamic( s ) or ((symbGetAllocType( s ) and FB.ALLOCTYPE.ARGUMENTBYDESC) > 0)
    diff  = symbGetVarDiff( s )

	'' ofs * length + difference (non-base 0 indexes) + offset (UDT's offset)
	if( not isdyn ) then
		ofs = ofs + diff + astTB(n).v.ofs
	else
		ofs = ofs + astTB(n).v.ofs
	end if

	''
	if( isdyn ) then
		s = INVALID
	end if

    ''
	if( vi <> INVALID ) then

		if( (lgt >= 10) or (lgt = 6) or (lgt = 7) ) then
			lgt = 1
		end if

		vd = irAllocVRIDX( astTB(n).dtype, s, ofs, lgt, vi )

		if( irIsIDX( vi ) or irIsVAR( vi ) ) then
			irEmitLOAD IR.OP.LOAD, vi
		end if
	else
		vd = irAllocVRVAR( astTB(n).dtype, s, ofs )
	end if

	asthEmitIDX = vd
end function

'':::::
sub astLoadIDX( byval n as integer, vr as integer )
    dim v as integer, i as integer
    dim vi as integer

	v = astTB(n).v.s
	i = astTB(n).l

	if( (v = INVALID) ) then
		exit sub
	end if

	if( i <> INVALID ) then
		astLoad i, vi
	else
		vi = INVALID
	end if

    vr = asthEmitIDX( v, astTB(n).v.ofs, astTB(n).v.lgt, vi )

	astDel i
	astDel v

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' addressing operations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewADDR( byval op as integer, byval p as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODETYPE.ADDR, IR.DATATYPE.UINT )
	astNewADDR = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).op = op
	astTB(n).l  = p
	astTB(n).r  = INVALID

end function

'':::::
sub astLoadADDR( byval n as integer, vr as integer )
    dim p as integer, op as integer
    dim v1 as integer

	p  = astTB(n).l
	op = astTB(n).op

	if( p = INVALID ) then
		exit sub
	end if

	astLoad p, v1

	vr = irAllocVREG( IR.DATATYPE.UINT )

	astAddrOperation op, v1, vr

	astDel p

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' loading
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLOAD( byval l as integer, byval dtype as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODETYPE.LOAD, dtype )
	astNewLOAD = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l  = l

end function

'':::::
sub astLoadLOAD( byval n as integer, vr as integer )
    dim l as integer

	l = astTB(n).l

	if( l = INVALID ) then
		exit sub
	end if

	astLoad l, vr

	irEmitLOAD IR.OP.LOAD, vr

	astDel l

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' pointers
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewPTREx( byval s as integer, byval elm as integer, byval ofs as integer, byval dtype as integer, byval expr as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODETYPE.PTR, dtype )
	astNewPTREx = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l   	= expr
	astTB(n).v.s 	= s
	astTB(n).v.e 	= elm
	astTB(n).v.ofs 	= ofs

end function

'':::::
function astNewPTR( byval ofs as integer, byval dtype as integer, byval expr as integer ) as integer static

	astNewPTR = astNewPTREx( INVALID, INVALID, ofs, dtype, expr )

end function

'':::::
sub astLoadPTR( byval n as integer, vreg as integer )
    dim l as integer, ofs as integer
    dim v1 as integer, vp as integer
    dim dtype as integer

	l 	= astTB(n).l
	ofs = astTB(n).v.ofs

	if( l = INVALID ) then
		exit sub
	end if

	astLoad l, v1

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

	vreg = irAllocVRPTR( dtype, ofs, vp )

	astDel l

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' assignaments
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewASSIGN( byval l as integer, byval r as integer ) as integer static
    dim n as integer
    dim dt1 as integer, dt2 as integer
    dim dc1 as integer, dc2 as integer
    dim s as integer, lgt as integer, e as integer

	astNewASSIGN = INVALID

	dt1 = astTB(l).dtype
	dt2 = astTB(r).dtype
	dc1 = irGetDataClass( dt1 )
	dc2 = irGetDataClass( dt2 )

    '' strings?
    if( (dc1 = IR.DATACLASS.STRING) or (dc2 = IR.DATACLASS.STRING) ) then

		if( dc1 <> dc2 ) then
			exit function
		end if

		astNewASSIGN = rtlStrAssign( l, r )
		exit function

	'' UDT's?
	elseif( (dt1 = IR.DATATYPE.USERDEF) or (dt2 = IR.DATATYPE.USERDEF) ) then

		if( dt1 <> dt2 ) then
			exit function
		end if

		e = astGetVARElm( l )
		if( e <> INVALID ) then
			lgt = symbGetUDTELmLen( e )
		else
			s = astGetSymbol( l )
			s = symbGetSubtype( s )
			lgt = symbGetLen( s )
		end if

		astNewASSIGN = rtlMemCopy( l, r, lgt )
		exit function
	end if

	'' alloc new node
	n = astNew( AST.NODETYPE.ASSIGN, dt1 )
	astNewASSIGN = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l  = l
	astTB(n).r  = r

end function

'':::::
sub astLoadASSIGN( byval n as integer, vr as integer )
    dim l as integer, r as integer
    dim vs as integer

	l = astTB(n).l
	r = astTB(n).r

	if( (l = INVALID) or (r = INVALID) ) then
		exit sub
	end if

	astLoad r, vs
	astLoad l, vr

	irEmitSTORE vr, vs

	astDel l
	astDel r

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' conversions
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewCONV( byval op as integer, byval dtype as integer, byval l as integer ) as integer static
    dim n as integer

	'' if it's just a sign conversion, change node's sign and create no new node
	if( op <> INVALID ) then
		if( op = IR.OP.TOSIGNED ) then
			astTB(l).dtype = irGetSignedType( astTB(l).dtype )
		else
			astTB(l).dtype = irGetUnsignedType( astTB(l).dtype )
		end if

		astNewCONV = l
		exit function
	end if

	'' alloc new node
	n = astNew( AST.NODETYPE.CONV, dtype )
	astNewCONV = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l  = l

end function

'':::::
sub astLoadCONV( byval n as integer, vr as integer )
    dim l as integer, dtype as integer
    dim vs as integer

	l  = astTB(n).l

	if( l = INVALID ) then
		exit sub
	end if

	astLoad l, vs

	dtype = astTB(n).dtype

	'' only convert file class are different (ie, floating<->integer) or
	'' if sizes are different (ie, byte<->int)
	if( (irGetVRDataClass( vs ) <> irGetDataClass( dtype )) or _
		(irGetVRDataSize( vs ) <> irGetDataSize( dtype )) ) then
		vr = irAllocVREG( dtype )
		irEmitCONVERT vr, dtype, vs, INVALID
	else
		vr = vs
	end if

	astDel l

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' functions
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function astNewFUNCTEx( byval ptrexpr as integer, byval symbol as integer, byval dtype as integer, byval args as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODETYPE.FUNCT, dtype )
	astNewFUNCTEx = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).f.s 		= symbol
	astTB(n).f.p 		= ptrexpr
	astTB(n).f.args 	= args

	if( symbGetFuncMode( symbol ) = FB.FUNCMODE.PASCAL ) then
		astTB(n).f.arg = 0
	else
		astTB(n).f.arg = args-1
	end if

end function

'':::::
function astNewFUNCT( byval symbol as integer, byval dtype as integer, byval args as integer ) as integer static

	astNewFUNCT = astNewFUNCTEx( INVALID, symbol, dtype, args )

end function

'':::::
function astNewFUNCTPTR( byval ptrexpr as integer, byval symbol as integer, byval dtype as integer, byval args as integer ) as integer static

	astNewFUNCTPTR = astNewFUNCTEx( ptrexpr, symbol, dtype, args )

end function

'':::::
function astNewPARAMEx( byval f as integer, byval p as integer, byval dtype as integer, byval mode as integer ) as integer static
    dim n as integer
    dim t as integer

	if( dtype = INVALID ) then
		dtype = astGetDataType( p )
	end if

	'' alloc new node
	n = astNew( AST.NODETYPE.PARAM, dtype )
	astNewPARAMEx = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l = p

	'' add param node to function's list
	t = astTB(f).r
	astTB(f).r = n								'' func tail= node
	''
	astTB(n).p.prv 	= t							'' node prev= tail
	astTB(n).p.nxt 	= INVALID					'' node next= NULL
	astTB(n).p.mode = mode

	if( t <> INVALID ) then
		astTB(t).p.nxt = n						'' tail next= node
	else
		astTB(f).l = n							'' func head= node
	end if

	''
	if( symbGetFuncMode( astTB(f).f.s ) = FB.FUNCMODE.PASCAL ) then
		astTB(f).f.arg = astTB(f).f.arg + 1
	else
		astTB(f).f.arg = astTB(f).f.arg - 1
	end if

end function

'':::::
function astNewPARAM( byval f as integer, byval p as integer, byval dtype as integer ) as integer static

	astNewPARAM = astNewPARAMEx( f, p, dtype, INVALID )

end function

'':::::
function asthCheckStrArg( byval proc as integer, byval isrtl as integer, byval arg as integer, _
						  byval n as integer, src as ASTTEMPSYMBOL, isexpr as integer ) as integer
    dim adtype as integer, adclass as integer, amode as integer
    dim pdtype as integer, pdclass as integer, ptype as integer
    dim tempstr as integer, t as integer

	''
	asthCheckStrArg = INVALID

	src.symbol = INVALID
	isexpr = FALSE


	'' get param and arg data types
	adtype  = symbGetArgDataType( proc, arg )
	pdtype  = astTB(n).dtype

   	'' if arg type = ANY, pass anything
   	if( adtype = IR.DATATYPE.VOID ) then
   		exit function
   	end if

	'' classes
	adclass = irGetDataClass( adtype )
	pdclass = irGetDataClass( pdtype )

   	'' if both aren't strings, skip..
   	if( (adclass <> IR.DATACLASS.STRING) or (pdclass <> IR.DATACLASS.STRING) ) then
   		exit function
   	end if


	'' calling rt lib?
	if( isrtl ) then

		'' byref arg (rtlib str args are ALWAYS byref), fixed-len param: just alloc a temp descriptor
		'' (assuming here that no rtlib function will EVER change the strings passed as param)
		if( pdtype = IR.DATATYPE.FIXSTR ) then
			asthCheckStrArg = rtlStrAllocTmpDesc( n )
			isexpr = TRUE
		    exit function
		else
			'' all rtlib procs that accept strings will delete temps automatically
			exit function
		end if

	end if


	'' param type
	ptype = astTB(n).typ

	''
	select case symbGetArgMode( proc, arg )

	'' passing by reference?
	case FB.ARGMODE.BYREF

    	'' fixed-length string?
    	if( pdtype = IR.DATATYPE.FIXSTR ) then
    		'' byref and fixed: alloc a temp string, copy fixed to temp and pass temp
			'' (ast will have to copy temp back to fixed when function returns and delete temp)

			'' don't copy back if it's a function returning a fixed-len (ie: C functions)
			if( ptype <> AST.NODETYPE.FUNCT ) then
				''!!!FIXME!!! can only handle scalar fixed-len strings, not arrays (as in QB4.5)
				src.symbol = astGetSymbol( n )
				src.ofs    = astGetVarOfs( n )
				src.elm	   = astGetVARElm( n )
			end if

    	else
    		'' if not a function's result, skip..
    		if( ptype <> AST.NODETYPE.FUNCT ) then
    			exit function
            end if
    	end if

    '' byval?
    case FB.ARGMODE.BYVAL

		'' skip, unless it's a temp string, that must be deleted when the called proc returns
		if( ptype <> AST.NODETYPE.FUNCT ) then
			exit function
		end if

	'' bydesc, skip..
	case else
		exit function
	end select


	'' create temp string to pass as paramenter
	tempstr = symbAddTempVar( FB.SYMBTYPE.STRING )
	t = astNewVAR( tempstr, 0, IR.DATATYPE.STRING )

	'' temp string = src string
	n = rtlStrAssign( t, n )
	astLoad n, t
	astDel n

	''
	asthCheckStrArg = tempstr

end function

'':::::
sub astLoadFUNCT( byval n as integer, vreg as integer )
    dim p as integer, np as integer, pmode as integer
    dim proc as integer, mode as integer, bytestopop as integer, isrtl as integer
    dim i as integer, inc as integer, t as integer, l as integer, dtype as integer
    dim a as integer, arg as integer, lastarg as integer, args as integer
    dim vr as integer
    dim tempstrs_base as integer, tsrc as ASTTEMPSYMBOL, s as integer, d as integer, isexpr as integer

	'' execute each param and push the result
	proc = astTB(n).f.s
    mode = symbGetFuncMode( proc )

	isrtl = symbGetProcLib( proc ) = "fb"

	tempstrs_base = ctx.tempstrs

    ''
	if( mode = FB.FUNCMODE.PASCAL ) then
		p = astTB(n).l								'' param= func head
		i = 0
		inc = 1
	else
		p = astTB(n).r								'' param= func tail
		i = astTB(n).f.args-1
		inc = -1
	end if

	''
	args 	= symbGetProcArgs( proc )
	lastarg = symbGetProcTailArg( proc )
	arg 	= symbGetProcFirstArg( proc )

	do while( p <> INVALID )
		if( mode = FB.FUNCMODE.PASCAL ) then
			np = astTB(p).p.nxt
		else
			np = astTB(p).p.prv
		end if

		if( i < args ) then
			a = arg
		else
			a = lastarg
		end if

		t = asthCheckStrArg( proc, isrtl, a, astTB(p).l, tsrc, isexpr )

		'' param had to be loaded to a temp string?
		pmode = INVALID
		if( t <> INVALID ) then
			if( not isexpr ) then
				tempstrTB(ctx.tempstrs).tmp = t
				tempstrTB(ctx.tempstrs).src = tsrc
				ctx.tempstrs = ctx.tempstrs + 1
				l = astNewVAR( t, 0, IR.DATATYPE.STRING )
			else
				l = t
			end if
		else
			l = astTB(p).l
			pmode = astTB(p).p.mode
		end if

		'' try to optimize if a constant is being pushed and the arg is a float
  		if( astTB(l).typ = AST.NODETYPE.CONST ) then
  			dtype = symbGetArgDataType( proc, a )
  			if( irGetDataClass( dtype ) = IR.DATACLASS.FPOINT ) then
				astTB(l).dtype = dtype
			end if
		end if

		'' flush the param expression
		astLoad l, vr
		astDel l

		if( not irEmitPUSHPARAM( proc, a, vr, pmode ) ) then
		'''''exit sub
		end if

		astDel p

		if( i < args ) then
			arg = symbGetProcNextArg( proc, arg )
		end if
		i = i + inc
		p = np
	loop

	'' return the result (same type as function ones)
	dtype = astTB(n).dtype
	if( dtype = IR.DATATYPE.STRING ) then dtype = IR.DATATYPE.UINT

	if( dtype <> IR.DATATYPE.VOID ) then
		vreg = irAllocVREG( dtype )
	else
		vreg = INVALID
	end if

	if( mode = FB.FUNCMODE.CDECL ) then
		bytestopop = symbCalcArgsLen( proc, astTB(n).f.args )
	else
		bytestopop = 0
	end if

	'' call function or ptr
	p = astTB(n).f.p
	if( p = INVALID ) then
		irEmitCALLFUNCT proc, bytestopop, vreg
	else
		astLoad p, vr
		astDel p
		irEmitCALLPTR vr, vreg, bytestopop
	end if

	'' handle string returned by functions that are actually pointers to string descriptors,
	'' but when you do foo$ = bar$(), you are not assigning ptrs, but the contents...
	if( astTB(n).dtype = IR.DATATYPE.STRING ) then
		vreg = irAllocVRPTR( IR.DATATYPE.STRING, 0, vreg )
	end if


	'' copy-back any fix-len string passed as parameter and
	'' delete all temp strings used as parameters
	do while( ctx.tempstrs > tempstrs_base )
        ctx.tempstrs = ctx.tempstrs - 1

		'' copy back if needed
		d = tempstrTB(ctx.tempstrs).src.symbol
		if( d <> INVALID ) then
        	'' only if not a literal string passed a fixed-len
        	if( symbGetInitialized( d ) = FALSE ) then
        		''!!!FIXME!!! can only handle scalar fixed-len strings, not arrays (as in QB4.5)
        		s = astNewVAR( tempstrTB(ctx.tempstrs).tmp, 0, IR.DATATYPE.STRING )
        		d = astNewVAREx( d, tempstrTB(ctx.tempstrs).src.elm, _
        						 tempstrTB(ctx.tempstrs).src.ofs, IR.DATATYPE.FIXSTR )
				t = rtlStrAssign( d, s )
				astLoad t, vr
				astDel t
			end if
		end if

		'' delete the temp string
		t = astNewVAR( tempstrTB(ctx.tempstrs).tmp, 0, IR.DATATYPE.STRING )
		t = rtlStrDelete( t )
		astLoad t, vr
		astDel t
	loop

end sub
