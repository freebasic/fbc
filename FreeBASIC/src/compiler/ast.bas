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
option escape

'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\ast.bi'

type ASTCTX
	head			as integer
	tail			as integer
	fhead			as integer
	nodes			as integer

	tempstrings		as integer
	temparraydescs	as integer
end Type

type ASTTEMPSTR
	tmp			as FBSYMBOL ptr
	srctree		as integer
end type

type ASTTEMPARRAYDESC
	pdesc		as FBSYMBOL ptr
end type

declare sub 		astUpdStrConcat		( byval n as integer )

'' globals
	dim shared ctx as ASTCTX

	dim shared tempstrTB( 0 to AST.MAXTEMPSTRINGS-1 ) as ASTTEMPSTR
	dim shared temparraydescTB( 0 to AST.MAXTEMPARRAYDESCS-1 ) as ASTTEMPARRAYDESC

	redim shared astTB( 0 ) as ASTNODE

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc node copy/swap
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

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constant folding optimizations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
Sub astOptConstRmNeg( byval n as integer, byval p as integer )
	static tmp as ASTNODE
	Dim l as integer, r as integer, o as integer

	'' check any UOP node, and if its of the kind "-var + const" convert to "const - var"
	If( astTB(n).class = AST.NODECLASS.UOP ) Then
		if( p <> INVALID ) then
			if( astTB(n).op = IR.OP.NEG ) then
				l = astTB(n).l
				if( astTB(l).class = AST.NODECLASS.VAR ) then
					If( astTB(p).class = AST.NODECLASS.BOP ) Then
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
	If( astTB(n).class <> AST.NODECLASS.BOP ) Then
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
	If( astTB(n).class <> AST.NODECLASS.BOP ) Then
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
	If( astTB(n).class = AST.NODECLASS.BOP ) Then
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

	select case astTB(n).class
	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		if( astTB(n).proc.p <> INVALID ) then
			astOptConstAccum1 astTB(n).proc.p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		if( astTB(n).param.nxt <> INVALID ) then
			astOptConstAccum1 astTB(n).param.nxt
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
	If( astTB(n).class = AST.NODECLASS.BOP ) Then
		select case astTB(n).op
		case IR.OP.ADD
			if( irGetDataClass( astTB(n).dtype ) <> IR.DATACLASS.STRING ) then
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

	select case astTB(n).class
	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		if( astTB(n).proc.p <> INVALID ) then
			astOptConstAccum2 astTB(n).proc.p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		if( astTB(n).param.nxt <> INVALID ) then
			astOptConstAccum2 astTB(n).param.nxt
		end if
	end select

End Sub

'':::::
Sub asthConstDistMUL( byval m as double, byval n as integer, c as double )
	Dim l as integer, r as integer

	If( n = INVALID ) Then
		exit sub
	end if
	If( astTB(n).class <> AST.NODECLASS.BOP ) Then
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
	If( astTB(n).class = AST.NODECLASS.BOP ) Then
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

	select case astTB(n).class
	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		if( astTB(n).proc.p <> INVALID ) then
			astOptConstDistMUL astTB(n).proc.p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		if( astTB(n).param.nxt <> INVALID ) then
			astOptConstDistMUL astTB(n).param.nxt
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
	select case astTB(n).class
	case AST.NODECLASS.IDX, AST.NODECLASS.PTR
		l = astTB(n).l
		if( l <> INVALID ) then
			c = 0
			op = 1
			asthConstAccumADDSUB l, c, op

        	if( astTB(n).class = AST.NODECLASS.IDX ) then
        		astTB(n).idx.ofs  = astTB(n).idx.ofs + cint( c )
        	else
        		astTB(n).ptr.ofs  = astTB(n).ptr.ofs + cint( c )
        	end if

        	if( astTB(l).class = AST.NODECLASS.CONST ) then

				if( astTB(n).class = AST.NODECLASS.IDX ) then
					astTB(n).idx.ofs = astTB(n).idx.ofs + cint( astTB(l).value )
				else
					astTB(n).ptr.ofs = astTB(n).ptr.ofs + cint( astTB(l).value )
				end if

				astDel astTB(n).l
			end if
		end if
	end select

	if( astTB(n).class = AST.NODECLASS.IDX ) Then
		l = astTB(n).l
		if( l <> INVALID ) then
			'' if top of tree = idx * lgt, and lgt < 10, save lgt and delete * node
			if( astTB(l).class = AST.NODECLASS.BOP ) Then
				if( astTB(l).op = IR.OP.MUL ) then
					lr = astTB(l).r
					if( astTB(lr).defined ) then
						v = cint( astTB(lr).value )
						if( (v < 10) and (v <> 6) and (v <> 7) ) then
				    		astTB(n).idx.mult = v
				    		astDel lr

							ll = astTB(l).l
							astCopy l, ll
							astDel ll
						end if
				    end if
				end if
			end if

			'' convert to integer if needed
			if( (irGetDataClass( astTB(l).dtype ) <> IR.DATACLASS.INTEGER) or _
			    (irGetDataSize( astTB(l).dtype ) <> FB.POINTERSIZE) ) then
				ll = astNew( INVALID, INVALID )
				astCopy ll, l
				ll = astNewCONV( INVALID, IR.DATATYPE.INTEGER, ll )
				astCopy l, ll
				astDel ll
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

	select case astTB(n).class
	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		if( astTB(n).proc.p <> INVALID ) then
			astOptConstIDX astTB(n).proc.p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		if( astTB(n).param.nxt <> INVALID ) then
			astOptConstIDX astTB(n).param.nxt
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
	If( astTB(n).class = AST.NODECLASS.BOP ) Then
		op = astTB(n).op
		if( op = IR.OP.ADD or op = IR.OP.SUB ) then
			if( irGetDataClass( astTB(n).dtype ) <> IR.DATACLASS.STRING ) then
				r = astTB(n).r
				If( astTB(r).class = AST.NODECLASS.BOP ) Then
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

	select case astTB(n).class
	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		if( astTB(n).proc.p <> INVALID ) then
			astOptAssocADD astTB(n).proc.p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		if( astTB(n).param.nxt <> INVALID ) then
			astOptAssocADD astTB(n).param.nxt
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
	If( astTB(n).class = AST.NODECLASS.BOP ) Then
		if( astTB(n).op = IR.OP.MUL ) then
			r = astTB(n).r
			If( astTB(r).class = AST.NODECLASS.BOP ) Then
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

	select case astTB(n).class
	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		if( astTB(n).proc.p <> INVALID ) then
			astOptAssocMUL astTB(n).proc.p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		if( astTB(n).param.nxt <> INVALID ) then
			astOptAssocMUL astTB(n).param.nxt
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

	'' convert 'a * pow2 imm'   to 'a SHL pow2',
	''         'a \ pow2 imm'   to 'a SHR pow2' and
	''         'a MOD pow2 imm' to 'a AND pow2-1'
	If( astTB(n).class = AST.NODECLASS.BOP ) Then
		op = astTB(n).op
		select case op
		case IR.OP.MUL, IR.OP.INTDIV, IR.OP.MOD
			r = astTB(n).r
			if( astTB(r).defined ) Then
				if( irGetDataClass( astTB(n).dtype ) = IR.DATACLASS.INTEGER ) then
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
								astTB(r).value = astTB(r).value - 1
							end select
						end if
					end if
				end if
			end if
		end select
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

	select case astTB(n).class
	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		if( astTB(n).proc.p <> INVALID ) then
			astOptToShift astTB(n).proc.p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		if( astTB(n).param.nxt <> INVALID ) then
			astOptToShift astTB(n).param.nxt
		end if
	end select

End Sub

''::::
sub astOptStrAssignament( byval n as integer, byval l as integer, byval r as integer ) static
	dim rl as integer, f as integer
	dim optimize as integer

	optimize = FALSE

	'' is left side a var?
	if( astTB(l).class = AST.NODECLASS.VAR ) then

		'' is right side a bin operation?
		if( astTB(r).class = AST.NODECLASS.BOP ) then

			'' is the left child a var too?
			rl = astTB(r).l
			if( astTB(rl).class = AST.NODECLASS.VAR ) then

				'' are both vars the same?
				if( (astTB(rl).var.sym = astTB(l).var.sym) and (astTB(rl).var.ofs = astTB(l).var.ofs) ) then
					optimize = TRUE
				end if
			end if
		end if
	end if

	if( optimize ) then
		''	=            f()
		'' / \           / \
		''d   +    =>   d   s
		''   / \
		''  d   s

		astCopy n, r
		astDel l
		astDel r

		astUpdStrConcat astTB(n).r

		f = rtlStrConcatAssign( astTB(n).l, astTB(n).r )

	else
		''	=            f() -- assign
		'' / \           / \
		''d   +    =>   d   f() -- concat (done by UpdStrConcat)
		''   / \           / \
		''  d   s         d   s

		astUpdStrConcat r

		f = rtlStrAssign( astTB(n).l, astTB(n).r )
	end if

	astCopy n, f
	astDel f

end sub

''::::
sub astOptAssignament( byval n as integer ) static
	dim l as integer, r as integer, rl as integer
	dim dtype as integer, dclass as integer

	'' try to convert "foo = foo op expr" to "foo op= expr" (including unary ops)
	if( n = INVALID ) then
		exit sub
	end if

	'' there's just one assignament per tree (always at top), so, just check this node
	If( astTB(n).class <> AST.NODECLASS.ASSIGN ) Then
		exit sub
	end if

	l = astTB(n).l
	r = astTB(n).r

	dtype = astTB(n).dtype
	dclass = irGetDataClass( dtype )

	'' integer's only, no way to optimize with a FPU stack (x86 dep.)
	If( dclass <> IR.DATACLASS.INTEGER ) Then

		'' strings?
		if( dclass = IR.DATACLASS.STRING ) then
			astOptStrAssignament n, l, r
			exit sub
		end if

		'' try to optimize if a constant is being assigned to a float var
  		if( astTB(r).class = AST.NODECLASS.CONST ) then
  			if( dclass = IR.DATACLASS.FPOINT ) then
				astTB(r).dtype = dtype
			end if
		end if

		exit sub
	end if

	'' can't be byte either, as BOP will do cint(byte) op cint(byte)
	If( irGetDataSize( dtype ) = 1 ) Then
		exit sub
	end if

	'' is left side a var?
	select case astTB(l).class
	case AST.NODECLASS.VAR
	case else
		exit sub
	end select

	'' is right side a bin or unary operation?
	select case astTB(r).class
	case AST.NODECLASS.UOP, AST.NODECLASS.BOP
	case else
		exit sub
	end select

	'' can't be a relative op -- unless EMIT is changed to not assume the res operand is a register
	select case astTB(r).op
	case IR.OP.EQ, IR.OP.GT, IR.OP.LT, IR.OP.NE, IR.OP.LE, IR.OP.GE, _
		 IR.OP.INTDIV, IR.OP.MOD, IR.OP.MUL
		exit sub
	end select

	'' node result is an integer too?
	If( irGetDataClass( astTB(r).dtype ) <> IR.DATACLASS.INTEGER ) Then
		exit sub
	end if

	'' is the left child a var too?
	rl = astTB(r).l
	if( astTB(rl).class <> AST.NODECLASS.VAR ) then
		exit sub
	end if

	'' are both vars the same?
	if( (astTB(rl).var.sym <> astTB(l).var.sym) or (astTB(rl).var.ofs <> astTB(l).var.ofs) ) then
		exit sub
	end if

	'' delete assign node and alert UOP/BOP to not allocate a result (IR is aware)
	astTB(r).allocres = FALSE

	''	=             o
	'' / \           / \
	''d   o     =>  d   s
	''   / \
	''  d   s

    astCopy n, r
	astDel l
	astDel r

end sub

'':::::
function astOptComp2Branch( byval n as integer, byval label as FBSYMBOL ptr, byval isinverse as integer ) as integer static
	dim op as integer

	astOptComp2Branch = FALSE

	if( n = INVALID ) then
		exit function
	end if

	'' shortcut "exp logop exp" if it's at top of tree (used to optimize IF/ELSEIF/WHILE/UNTIL)
	if( astTB(n).class <> AST.NODECLASS.BOP ) then
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

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' node type update (must be done before any loading)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astUpdStrConcat( byval n as integer )
	Dim l as integer, r as integer
	dim f as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' walk
	l = astTB(n).l
	If( l <> INVALID ) Then
		astUpdStrConcat l
	End If

	r = astTB(n).r
	If( r <> INVALID ) Then
		astUpdStrConcat r
	End If

	select case astTB(n).class
	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		if( astTB(n).proc.p <> INVALID ) then
			astUpdStrConcat astTB(n).proc.p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		if( astTB(n).param.nxt <> INVALID ) then
			astUpdStrConcat astTB(n).param.nxt
		end if
	end select

	'' convert "string + string" to  "StrConcat( string, string )"
	If( astTB(n).class = AST.NODECLASS.BOP ) Then
		if( astTB(n).op = IR.OP.ADD ) then
			'' strings?
			l = astTB(n).l
			if( irGetDataClass( astTB(l).dtype ) = IR.DATACLASS.STRING ) then
				r = astTB(n).r
				f = rtlStrConcat( l, astTB(l).dtype, r, astTB(r).dtype )
				astCopy n, f
				astDel f
			end if
		end if
	end if

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

	select case astTB(n).class
	case AST.NODECLASS.BOP

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
						if( astTB(r).class = AST.NODECLASS.CONST ) then
							astTB(r).dtype = dt1
							dtype = dt1
						end if
					else
						if( astTB(l).class = AST.NODECLASS.CONST ) then
							astTB(l).dtype = dt2
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


	case AST.NODECLASS.UOP

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
	select case astTB(n).class
	case AST.NODECLASS.FUNCT
		if( astTB(n).proc.p <> INVALID ) then
			astUpdNodeResult astTB(n).proc.p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		if( astTB(n).param.nxt <> INVALID ) then
			astUpdNodeResult astTB(n).param.nxt
		end if
	end select

end sub


'':::::
sub astDump1 ( byval p as integer, byval n as integer, byval isleft as integer, _
			   byval ln as integer, byval cn as integer )
'   dim v as string, l as integer, c as integer

'	v = ""
'	select case astTB(n).class
'	case AST.NODECLASS.BOP
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

'	case AST.NODECLASS.UOP
'		select case astTB(n).op
'		case IR.OP.NEG
'			v = "-"
'		case IR.OP.NOT
'			v = "!"
'		end select
'		v = "(" + v + ")"

'	case AST.NODECLASS.VAR
'		v = "[" + rtrim$( mid$( symbGetVarName( astTB(n).var.sym ), 2 ) ) + "]"
'	case AST.NODECLASS.CONST
'		v = "[" + ltrim$( str$( astTB(n).value ) ) + "]"
'	case AST.NODECLASS.IDX
'		c = astTB(n).idx.sym
'		v = "{" + rtrim$( mid$( symbGetVarName( astTB(c).idx.sym ), 2 ) ) + "}"

'	case AST.NODECLASS.FUNCT
'		v = rtrim$( mid$( symbGetProcName( astTB(n).proc.s ), 2 ) ) + "()"

'	case AST.NODECLASS.PARAM
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

	select case astTB(n).class
	'' array?
	case AST.NODECLASS.IDX
		p = astTB(n).idx.var
		if( p <> INVALID ) then
			astTB(nn).idx.var = astCloneTree( p )
		end if

	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		p = astTB(n).proc.p
		if( p <> INVALID ) then
			astTB(nn).proc.p = astCloneTree( p )
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		p = astTB(n).param.nxt
		if( p <> INVALID ) then
			astTB(nn).param.nxt = astCloneTree( p )
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

	select case astTB(n).class
	'' array?
	case AST.NODECLASS.IDX
		p = astTB(n).idx.var
		if( p <> INVALID ) then
			astDelTree p
		end if

	'' function called through a pointer?
	case AST.NODECLASS.FUNCT
		p = astTB(n).proc.p
		if( p <> INVALID ) then
			astDelTree p
		end if

	'' param node? call next if any
	case AST.NODECLASS.PARAM
		p = astTB(n).param.nxt
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
	ctx.tempstrings		= 0
	ctx.temparraydescs	= 0

end sub

'':::::
sub astEnd static

	erase astTB

	''
	ctx.head 		= INVALID
	ctx.tail 		= INVALID
	ctx.fhead 		= 0
	ctx.nodes		= 0

end sub

'':::::
function astNew( byval typ as integer, byval dtype as integer, _
				 byval subtype as FBSYMBOL ptr = NULL ) as integer static
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
	astTB(n).class 	= typ
	astTB(n).dtype 	= dtype
	astTB(n).subtype= subtype
	astTB(n).defined= FALSE
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
function astGetSymbol( byval n as integer ) as FBSYMBOL ptr static
    dim s as FBSYMBOL ptr

	s = NULL

	if( n <> INVALID ) then
		select case astTB(n).class
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
			n = astTB(n).idx.var
			if( n <> INVALID ) then
				s = astTB(n).var.elm
				if( s = NULL ) then
					s = astTB(n).var.sym
				end if
			end if

		case AST.NODECLASS.FUNCT
			s = astTB(n).proc.sym
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
sub astLoad( byval n as integer, vreg as integer )

	if( n = INVALID ) then
		exit sub
	end if

	select case astTB(n).class
	case AST.NODECLASS.ASSIGN
		astLoadASSIGN n, vreg

	case AST.NODECLASS.CONV
		astLoadCONV n, vreg

	case AST.NODECLASS.CONST
		astLoadCONST n, vreg

	case AST.NODECLASS.VAR
		astLoadVAR n, vreg

	case AST.NODECLASS.BOP
		astLoadBOP n, vreg

	case AST.NODECLASS.UOP
		astLoadUOP n, vreg

	case AST.NODECLASS.IDX
		astLoadIDX n, vreg

	case AST.NODECLASS.FUNCT
		astLoadFUNCT n, vreg

	case AST.NODECLASS.PTR
		astLoadPTR n, vreg

	case AST.NODECLASS.ADDR
		astLoadADDR n, vreg

	case AST.NODECLASS.LOAD
		astLoadLOAD n, vreg
    end select

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

	astUpdStrConcat n

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
function astFlush( byval n as integer, vreg as integer, byval label as FBSYMBOL ptr = NULL, _
				   byval isinverse as integer = FALSE ) as integer

	astFlush = FALSE

	if( n = INVALID ) then
		exit function
	end if

	astOptimize n

	if( label <> NULL ) then
		astFlush = astOptComp2Branch( n, label, isinverse )
	else
		astFlush = TRUE
	end if

	astLoad n, vreg

	astDel n

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' binary operations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hStrLiteralConcat( byval l as integer, byval r as integer ) as integer
    dim s as FBSYMBOL ptr
    dim ls as FBSYMBOL ptr, rs as FBSYMBOL ptr

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	s = hAllocStringConst( symbGetVarText( ls ) + symbGetVarText( rs ), _
						   symbGetLen( ls ) + symbGetLen( rs ) )

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
function astNewBOP( byval op as integer, byval l as integer, r as integer, _
					byval ex as FBSYMBOL ptr = NULL, byval allocres as integer = TRUE ) as integer static
    dim n as integer
    dim dt1 as integer, dt2 as integer, dtype as integer
    dim dc1 as integer, dc2 as integer

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

    '' strings?
    if( (dc1 = IR.DATACLASS.STRING) or (dc2 = IR.DATACLASS.STRING) ) then

		if( dc1 <> dc2 ) then
			exit function
		end if

		select case op
		case IR.OP.ADD
			'' check for string literals
			if( (dt1 = IR.DATATYPE.FIXSTR) and (dt2 = IR.DATATYPE.FIXSTR) ) then
				if( astTB(l).class = AST.NODECLASS.VAR ) then
					if( astTB(r).class = AST.NODECLASS.VAR ) then
						if( symbGetInitialized( astGetSymbol( l ) ) ) then
							if( symbGetInitialized( astGetSymbol( r ) ) ) then
								astNewBOP = hStrLiteralConcat( l, r )
								exit function
							end if
						end if
					end if
				end if
			end if

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
			astTB(r).value = -astTB(r).value
			op = IR.OP.ADD

		case IR.OP.POW
			'' convert var ^ 2 to var * var
			if( astTB(r).value = 2 ) then
				select case astTB(l).class
				case AST.NODECLASS.VAR, AST.NODECLASS.IDX
					astDel r
					r = astCloneTree( l )
					op = IR.OP.MUL
					dt2 = dt1
				end select
			end if
		end select
	end if

	'' handle pow
	if( op = IR.OP.POW ) then
		astNewBOP = rtlMathPow( l, r )
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
	n = astNew( AST.NODECLASS.BOP, dtype )
	astNewBOP = n

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
    dim s as FBSYMBOL ptr, vt as integer, typ as integer
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
				if( astTB(r).class = AST.NODECLASS.CONST ) then
					astTB(r).dtype = astTB(l).dtype
					exit sub
				end if
			end if

			'' if int oper is an IMM, allocate a temp var
			if( irIsIMM( v1 ) and (dc2 = IR.DATACLASS.FPOINT) ) then
				s = hAllocFloatConst( str$( irGetVRValue( v1 ) ), dt2 )
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
				if( astTB(l).class = AST.NODECLASS.CONST ) then
					astTB(l).dtype = astTB(r).dtype
					exit sub
				end if
			end if

			if( irIsIMM( v2 ) and (dc1 = IR.DATACLASS.FPOINT) ) then
				s = hAllocFloatConst( str$( irGetVRValue( v2 ) ), dt1 )
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

	'' need some other algo here to select which operand is better to evaluate
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
	if( astTB(n).ex <> NULL ) then				'' hack! ex=label, vr=INV 'll gen better code at IR..
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

	'' UDT's? ditto
	if( astTB(o).dtype = IR.DATATYPE.USERDEF ) then
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
	n = astNew( AST.NODECLASS.UOP, astTB(o).dtype )
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

	irEmitUOP op, v1, vr

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
	n = astNew( AST.NODECLASS.CONST, dtype )
	astNewCONST = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).value 	= value
	astTB(n).defined= TRUE

end function

'':::::
sub astLoadCONST( byval n as integer, vreg as integer ) static
	dim s as FBSYMBOL ptr

  	'' if node is a float, create a temp float var (FPU can't operate on IMM's)
  	if( irGetDataClass( astTB(n).dtype ) = IR.DATACLASS.FPOINT ) then
		s = hAllocFloatConst( str$( astTB(n).value ), astTB(n).dtype )
		vreg = irAllocVRVAR( astTB(n).dtype, s, 0 )

	else
		vreg = irAllocVRIMM( astTB(n).dtype, int(astTB(n).value) )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' variables
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewVAR( byval sym as FBSYMBOL ptr, byval elm as FBSYMBOL ptr, _
					byval ofs as integer, _
					byval dtype as integer, byval subtype as FBSYMBOL ptr = NULL ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODECLASS.VAR, dtype, subtype )
	astNewVAR = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).var.sym 	= sym
	astTB(n).var.elm 	= elm
	astTB(n).var.ofs	= ofs

end function

'':::::
sub astLoadVAR( byval n as integer, vreg as integer ) static

	vreg = irAllocVRVAR( astTB(n).dtype, astTB(n).var.sym, astTB(n).var.ofs )

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' indexes
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewIDX( byval v as integer, byval i as integer, _
					byval dtype as integer, byval subtype as FBSYMBOL ptr ) as integer static
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

	astTB(n).idx.var = v
	astTB(n).idx.mult = 1
	astTB(n).idx.ofs = 0

	astTB(n).l 	   = i

end function

'':::::
function asthEmitIDX( byval v as integer, byval ofs as integer, byval mult as integer, byval vi as integer ) as integer static
    dim s as FBSYMBOL ptr, vs as integer, vd as integer, vt as integer, dt as integer
    dim mul as string, dif as string
    dim isdyn as integer, diff as integer

    s = astTB(v).var.sym

    isdyn = symbGetIsDynamic( s )
    diff  = symbGetArrayDiff( s )

	'' ofs * length + difference (non-base 0 indexes) + offset (UDT's offset)
	if( not isdyn ) then
		ofs = ofs + diff + astTB(v).var.ofs
	else
		ofs = ofs + astTB(v).var.ofs
	end if

	''
	if( isdyn ) then
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
sub astLoadIDX( byval n as integer, vr as integer )
    dim v as integer, i as integer
    dim vi as integer

	v = astTB(n).idx.var
	i = astTB(n).l

	if( v = INVALID ) then
		exit sub
	end if

	if( i <> INVALID ) then
		astLoad i, vi
	else
		vi = INVALID
	end if

    vr = asthEmitIDX( v, astTB(n).idx.ofs, astTB(n).idx.mult, vi )

	astDel i
	astDel v

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' addressing operations
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewADDR( byval op as integer, byval p as integer, _
					 byval dtype as integer = INVALID, byval subtype as FBSYMBOL ptr = NULL ) as integer static
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

	'' !!!WRITEME!!! if v1 is already a ptr with no ofs or other attached regs,
	'' convert it to a simple reg (not a ptr) and change type to UINT

	vr = irAllocVREG( IR.DATATYPE.UINT )

	irEmitADDR op, v1, vr

	astDel p

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' loading
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLOAD( byval l as integer, byval dtype as integer ) as integer static
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
function astNewPTR( byval sym as FBSYMBOL ptr, byval elm as FBSYMBOL ptr, _
					byval ofs as integer, byval expr as integer, _
					byval dtype as integer, byval subtype as FBSYMBOL ptr ) as integer static
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
sub astLoadPTR( byval n as integer, vreg as integer )
    dim l as integer, ofs as integer
    dim v1 as integer, vp as integer
    dim dtype as integer

	l 	= astTB(n).l
	ofs = astTB(n).ptr.ofs

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
				if( (dt2 <> IR.DATATYPE.BYTE) or (astTB(r).class <> AST.NODECLASS.PTR) ) then
					exit function
				end if
			else
				if( (dt1 <> IR.DATATYPE.BYTE) or (astTB(l).class <> AST.NODECLASS.PTR) ) then
					exit function
				end if
			end if

			astNewASSIGN = rtlStrAssign( l, r )
			exit function

		end if

	'' UDT's?
	elseif( (dt1 = IR.DATATYPE.USERDEF) or (dt2 = IR.DATATYPE.USERDEF) ) then

		'' both not UDT's?
		if( dt1 <> dt2 ) then
			exit function
		end if

		astNewASSIGN = rtlMemCopy( l, r, symbGetUDTLen( astGetSubtype( l ) ) )
		exit function
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.ASSIGN, dt1 )
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

	astNewCONV = INVALID

    if( l = INVALID ) then
    	exit function
    end if

    '' string? can't operate
    if( irGetDataClass( astTB(l).dtype ) = IR.DATACLASS.STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( astTB(l).dtype = IR.DATATYPE.USERDEF ) then
		exit function
    end if

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
	n = astNew( AST.NODECLASS.CONV, dtype )
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

	'' only convert if the classes are different (ie, floating<->integer) or
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

function astNewFUNCTEx( byval ptrexpr as integer, byval sym as FBSYMBOL ptr, _
						byval dtype as integer, byval args as integer ) as integer static
    dim n as integer

	'' alloc new node
	n = astNew( AST.NODECLASS.FUNCT, dtype )
	astNewFUNCTEx = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).proc.sym 		= sym
	astTB(n).proc.p 		= ptrexpr
	astTB(n).proc.args 		= args
	if( sym <> NULL ) then
		astTB(n).proc.arg	= symbGetProcHeadArg( sym )
	else
		astTB(n).proc.arg	= NULL
	end if
	astTB(n).proc.argnum 	= 0
	astTB(n).proc.tmparraybase = INVALID

end function

'':::::
function astNewFUNCT( byval sym as FBSYMBOL ptr, byval dtype as integer, byval args as integer ) as integer static

	astNewFUNCT = astNewFUNCTEx( INVALID, sym, dtype, args )

end function

'':::::
function astNewFUNCTPTR( byval ptrexpr as integer, byval symbol as FBSYMBOL ptr, _
						 byval dtype as integer, byval args as integer ) as integer static

	astNewFUNCTPTR = astNewFUNCTEx( ptrexpr, symbol, dtype, args )

end function

'':::::
private sub hReportParamError( byval proc as FBSYMBOL ptr, byval f as integer )

	hReportErrorEx FB.ERRMSG.PARAMTYPEMISMATCHAT, "at parameter: " + str$( astTB(f).proc.argnum+1 )

end sub

'':::::
private sub hReportParamWarning( byval proc as FBSYMBOL ptr, byval f as integer, byval msgnum as integer )

	hReportWarning msgnum, "at parameter: " + str$( astTB(f).proc.argnum+1 )

end sub

'':::::
private function hAllocTmpArrayDesc( byval f as integer, byval n as integer ) as integer static
	dim s as FBSYMBOL ptr

	s = symbAddTempVar( FB.SYMBTYPE.UINT )

	if( astTB(f).proc.tmparraybase = INVALID ) then
		astTB(f).proc.tmparraybase = ctx.temparraydescs
	end if

	temparraydescTB(ctx.temparraydescs).pdesc = s
	ctx.temparraydescs = ctx.temparraydescs + 1

	''
	hAllocTmpArrayDesc = rtlArrayAllocTmpDesc( n, s )

end function

'':::::
private function hCheckParam( byval f as integer, byval n as integer )
    dim proc as FBSYMBOL ptr, arg as FBPROCARG ptr, s as FBSYMBOL ptr
    dim p as integer, typ as integer, t as integer
    dim adtype as integer, adclass as integer, pmode as integer
    dim pdtype as integer, pdclass as integer, amode as integer

    hCheckParam = FALSE

	''
	proc = astTB(f).proc.sym

	if( astTB(f).proc.argnum >= symbGetProcArgs( proc ) ) then
		arg = symbGetProcTailArg( proc )
	else
		arg = astTB(f).proc.arg
	end if

	p = astTB(n).l

	''
	adtype  = symbGetArgDataType( proc, arg )
	adclass = irGetDataClass( adtype )
	amode   = symbGetArgMode( proc, arg )

	pdtype  = astTB(n).dtype
	pdclass = irGetDataClass( pdtype )
	pmode   = astTB(n).param.mode

	typ		= astTB(p).class

	'' process by descriptor arguments..
	if( amode = FB.ARGMODE.BYDESC ) then

        '' param is not an pointer
        if( pmode <> FB.ARGMODE.BYVAL ) then

			'' type field?
			s = astGetSymbol( p )
			if( s->class = FB.SYMBCLASS.UDTELM ) then
				'' not an array?
				if( symbGetArrayDimensions( s ) = 0 ) then
					hReportParamError proc, f
					exit function
				end if

				'' create a temp array descriptor
				astTB(n).l = hAllocTmpArrayDesc( f, p )
				astTB(n).param.mode = FB.ARGMODE.BYVAL

			else

				if( s = NULL ) then
					hReportParamError proc, f
					exit function
				end if

				'' not an argument passed by descriptor?
				if ( (symbGetAllocType( s ) and FB.ALLOCTYPE.ARGUMENTBYDESC) = 0 ) then
					if( symbGetArrayDescriptor( s ) = NULL ) then
						hReportParamError proc, f
						exit function
					end if
        		end if
        	end if

        end if

    ''
    elseif( adtype <> IR.DATATYPE.VOID ) then

    	'' string argument?
    	if( adclass = IR.DATACLASS.STRING ) then
			'' param not an string?
			if( pdclass <> IR.DATACLASS.STRING ) then
				'' check if not a byte ptr
				if( (pdtype <> IR.DATATYPE.BYTE) or (typ <> AST.NODECLASS.PTR) ) then
					'' or if passing a ptr to a BYVAL string arg
			    	if( (pdclass <> IR.DATACLASS.INTEGER) or _
			    		(amode <> FB.ARGMODE.BYVAL) or _
			    		(irGetDataSize( pdtype ) <> FB.POINTERSIZE) ) then
						hReportParamError proc, f
						exit function
			    	end if
			    end if
			end if

		else
	        '' passing a BYVAL ptr to an BYREF arg?
			if( (pmode = FB.ARGMODE.BYVAL) and (amode = FB.ARGMODE.BYREF) ) then
				if( (pdclass <> IR.DATACLASS.INTEGER) or _
					(irGetDataSize( pdtype ) <> FB.POINTERSIZE) ) then
					hReportParamError proc, f
					exit function
				end if

			'' UDT arg? check if the same, can't convert
			elseif( adtype = IR.DATATYPE.USERDEF ) then
				if( pdtype <> IR.DATATYPE.USERDEF ) then
					hReportParamError proc, f
					exit function
				end if

				'' check for invalid UDT's (different subtypes)
				s = astGetSubtype( p )

				if( symbGetArgSubtype( proc, arg ) <> s ) then
					hReportParamError proc, f
					exit function
				end if

				'' set the length if it's been passed by value
				if( amode = FB.ARGMODE.BYVAL ) then
					astTB(n).param.lgt = symbGetUDTLen( s )
				end if

			''
			else
				'' can't convert strings/UDT's to other types
				if( (pdclass = IR.DATACLASS.STRING) or (pdtype = IR.DATATYPE.USERDEF) ) then
					hReportParamError proc, f
					exit function
				end if

				'' param diff than arg can't passed by ref if a var/array/ptr
				if( amode = FB.ARGMODE.BYREF ) then
					select case typ
					case AST.NODECLASS.VAR, AST.NODECLASS.IDX, AST.NODECLASS.PTR, AST.NODECLASS.CONST

						if( (adclass <> pdclass) or _
							(irGetDataSize( adtype ) <> irGetDataSize( pdtype )) ) then

							'' unless it's a constant
							if( typ = AST.NODECLASS.CONST ) then
								'' change const data type to arg data type
								'' !!!FIXME!!! check if value is too big
								astTB(p).dtype = adtype
								astTB(n).dtype = adtype
							else
								hReportParamError proc, f
								exit function
							end if

						end if
					end select
				end if

				'' pointer checking
				if( adtype >= IR.DATATYPE.POINTER ) then
					if( pdtype < IR.DATATYPE.POINTER ) then

						if( typ = AST.NODECLASS.CONST ) then
							if( astTB(p).value <> 0 ) then
								hReportParamWarning proc, f, FB.WARNINGMSG.INVALIDPOINTER
							end if
						else
							hReportParamWarning proc, f, FB.WARNINGMSG.INVALIDPOINTER
						end if

					end if
				end if
			end if
		end if


    end if


    hCheckParam = TRUE

end function

'':::::
function astNewPARAM( byval f as integer, byval p as integer, _
					  byval dtype as integer = INVALID, byval mode as integer = INVALID ) as integer
    dim n as integer
    dim t as integer

	if( dtype = INVALID ) then
		astUpdNodeResult p
		dtype = astGetDataType( p )
	end if

	'' alloc new node
	n = astNew( AST.NODECLASS.PARAM, dtype )
	astNewPARAM = n

	if( n = INVALID ) then
		exit function
	end if

	astTB(n).l = p

	'' add param node to function's list
	t = astTB(f).r
	astTB(f).r = n								'' func tail= node
	''
	astTB(n).param.prv 	= t						'' node prev= tail
	astTB(n).param.nxt 	= INVALID				'' node next= NULL
	astTB(n).param.mode = mode
	astTB(n).param.lgt	= 0

	if( t <> INVALID ) then
		astTB(t).param.nxt = n					'' tail next= node
	else
		astTB(f).l = n							'' func head= node
	end if

	''
	if( not hCheckParam( f, n ) ) then
		astNewPARAM = INVALID
		exit function
	end if

	''
	if( astTB(f).proc.argnum < symbGetProcArgs( astTB(f).proc.sym ) ) then
		astTB(f).proc.arg = symbGetProcNextArg( astTB(f).proc.sym, astTB(f).proc.arg, FALSE )
	end if

	astTB(f).proc.argnum = astTB(f).proc.argnum + 1

end function

'':::::
private function hCheckStrArg( byval proc as FBSYMBOL ptr, byval isrtl as integer, byval arg as FBPROCARG ptr, _
						       byval n as integer, srctree as integer, isexpr as integer ) as FBSYMBOL ptr
    dim adtype as integer, adclass as integer, amode as integer
    dim pdtype as integer, pdclass as integer, ptype as integer
    dim tempstr as FBSYMBOL ptr, t as integer

	''
	hCheckStrArg = NULL

	srctree = INVALID
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
   	if( adclass <> IR.DATACLASS.STRING ) then
   		exit function
   	elseif( pdclass <> IR.DATACLASS.STRING ) then
   		'' check if it's not a byte ptr param
   		if( pdtype <> IR.DATATYPE.BYTE ) then
   			exit function
   		else
   			if( astTB(n).class <> AST.NODECLASS.PTR ) then
   				exit function
   			end if
   		end if
   	end if


	'' calling rt lib?
	if( isrtl ) then

		'' byref arg (rtlib str args are ALWAYS byref), fixed-len param: just alloc a temp descriptor
		'' (assuming here that no rtlib function will EVER change the strings passed as param)
		select case pdtype
		case IR.DATATYPE.FIXSTR, IR.DATATYPE.BYTE
			hCheckStrArg = rtlStrAllocTmpDesc( n )
			isexpr = TRUE
		    exit function
		case else
			'' all rtlib procs that accept strings will delete temps automatically
			exit function
		end select

	end if


	'' param type
	ptype = astTB(n).class

	''
	select case symbGetArgMode( proc, arg )

	'' passing by reference?
	case FB.ARGMODE.BYREF

    	'' fixed-length string?
    	select case pdtype
    	case IR.DATATYPE.FIXSTR
    		'' byref and fixed: alloc a temp string, copy fixed to temp and pass temp
			'' (ast will have to copy temp back to fixed when function returns and delete temp)

			'' don't copy back if it's a function returning a fixed-len (ie: C functions)
			if( ptype <> AST.NODECLASS.FUNCT ) then
				srctree = astCloneTree( n )
			end if

    	'' byte ptr?
    	case IR.DATATYPE.BYTE
    		'' byref and byte ptr: alloc a temp string, copy byte ptr to temp and pass temp

    	'' string descriptor..
    	case else
    		'' if not a function's result, skip..
    		if( ptype <> AST.NODECLASS.FUNCT ) then
    			exit function
            end if
    	end select

    '' byval?
    case FB.ARGMODE.BYVAL

		'' skip, unless it's a temp string, that must be deleted when the called proc returns
		if( ptype <> AST.NODECLASS.FUNCT ) then
			exit function
		end if

	'' bydesc, skip..
	case else
		exit function
	end select


	'' create temp string to pass as paramenter
	tempstr = symbAddTempVar( FB.SYMBTYPE.STRING )
	t = astNewVAR( tempstr, NULL, 0, IR.DATATYPE.STRING )

	'' temp string = src string
	n = rtlStrAssign( t, n )
	astLoad n, t
	astDel n

	''
	hCheckStrArg = tempstr

end function

'':::::
private sub hCallProc( byval n as integer, byval proc as FBSYMBOL ptr, byval mode as integer, vreg as integer )
    dim bytestopop as integer
    dim dtype as integer
    dim vr as integer, p as integer

	'' ordinary pointer?
	if( proc = NULL ) then
		p = astTB(n).proc.p
		astLoad p, vr
		astDel p
		irEmitBRANCHPTR vr
		exit sub
	end if

	dtype = astTB(n).dtype
	if( dtype = IR.DATATYPE.STRING ) then dtype = IR.DATATYPE.UINT

	if( dtype <> IR.DATATYPE.VOID ) then
		vreg = irAllocVREG( dtype )
	else
		vreg = INVALID
	end if

	if( (mode = FB.FUNCMODE.CDECL) or ((mode = FB.FUNCMODE.STDCALL) and (env.clopt.nostdcall)) ) then
		bytestopop = symbCalcArgsLen( proc, astTB(n).proc.args )
	else
		bytestopop = 0
	end if

	'' call function or ptr
	p = astTB(n).proc.p
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

end sub

'':::::
private sub hCheckTmpStrings( byval inibase as integer )
	dim srctree as integer, s as integer, t as integer, docopy as integer
	dim vr as integer

	'' copy-back any fix-len string passed as parameter and
	'' delete all temp strings used as parameters
	do while( ctx.tempstrings > inibase )
        ctx.tempstrings = ctx.tempstrings - 1

		'' copy back if needed
		srctree = tempstrTB(ctx.tempstrings).srctree
		if( srctree <> INVALID ) then
        	'' only if not a literal string passed a fixed-len
        	if( astTB(srctree).class = AST.NODECLASS.VAR ) then
        	    docopy = symbGetInitialized( astGetSymbol( srctree ) ) = FALSE
        	else
        		docopy = TRUE
        	end if

        	if( docopy ) then
        		s = astNewVAR( tempstrTB(ctx.tempstrings).tmp, NULL, 0, IR.DATATYPE.STRING )
				t = rtlStrAssign( srctree, s )
				astLoad t, vr
				astDel t
			end if
		end if

		'' delete the temp string
		t = astNewVAR( tempstrTB(ctx.tempstrings).tmp, NULL, 0, IR.DATATYPE.STRING )
		t = rtlStrDelete( t )
		astLoad t, vr
		astDel t
	loop

end sub

'':::::
private function hPrepParam( byval proc as FBSYMBOL ptr, byval isrtl as integer, byval arg as FBPROCARG ptr, _
				             byval param as integer, pmode as integer ) as integer
    dim srctree as integer, isexpr as integer
    dim t as FBSYMBOL ptr

	'' check string parameters
	t = hCheckStrArg( proc, isrtl, arg, astTB(param).l, srctree, isexpr )

	'' param had to be loaded to a temp string?
	pmode = INVALID
	if( isexpr ) then
		hPrepParam = t
	else
		if( t <> NULL ) then
			tempstrTB(ctx.tempstrings).tmp 		= t
			tempstrTB(ctx.tempstrings).srctree 	= srctree
			ctx.tempstrings = ctx.tempstrings + 1
			hPrepParam = astNewVAR( t, NULL, 0, IR.DATATYPE.STRING )

		else
			hPrepParam = astTB(param).l
			pmode = astTB(param).param.mode
		end if
	end if

end function

'':::::
private sub hFreeTempArrayDescs( byval f as integer )
    dim arraybase as integer
    dim t as integer, vr as integer

	arraybase = astTB(f).proc.tmparraybase

	'' any?
	if( arraybase = INVALID ) then
		exit sub
	end if

	do while( ctx.temparraydescs > arraybase )
		ctx.temparraydescs = ctx.temparraydescs - 1

		t = rtlArrayFreeTempDesc( temparraydescTB(ctx.temparraydescs).pdesc )
		astLoad t, vr
		astDel t
	loop

end sub

'':::::
sub astLoadFUNCT( byval n as integer, vreg as integer )
    dim p as integer, np as integer, pmode as integer
    dim proc as FBSYMBOL ptr, mode as integer, isrtl as integer
    dim i as integer, inc as integer, l as integer, dtype as integer
    dim a as FBPROCARG ptr, arg as FBPROCARG ptr, lastarg as FBPROCARG ptr, args as integer
    dim vr as integer
    dim tempstrs_base as integer

	'' execute each param and push the result
	proc = astTB(n).proc.sym

	'' ordinary pointer?
	if( proc = NULL ) then
		hCallProc n, NULL, INVALID, vreg
		exit sub
	end if

    mode = symbGetFuncMode( proc )

	isrtl = symbGetProcLib( proc ) = "fb"

	tempstrs_base = ctx.tempstrings

    ''
	if( mode = FB.FUNCMODE.PASCAL ) then
		p = astTB(n).l								'' param= func head
		i = 0
		inc = 1
	else
		p = astTB(n).r								'' param= func tail
		i = astTB(n).proc.args-1
		inc = -1
	end if

	''
	args 	= symbGetProcArgs( proc )
	lastarg = symbGetProcTailArg( proc )
	arg 	= symbGetProcFirstArg( proc )

	do while( p <> INVALID )
		if( mode = FB.FUNCMODE.PASCAL ) then
			np = astTB(p).param.nxt
		else
			np = astTB(p).param.prv
		end if

		if( i < args ) then
			a = arg
		else
			a = lastarg
		end if

		'' check the parameter
		l = hPrepParam( proc, isrtl, a, p, pmode )

		'' try to optimize if a constant is being pushed and the arg is a float
  		if( astTB(l).class = AST.NODECLASS.CONST ) then
  			dtype = symbGetArgDataType( proc, a )
  			if( irGetDataClass( dtype ) = IR.DATACLASS.FPOINT ) then
				astTB(l).dtype = dtype
			end if
		end if

		'' flush the param expression
		astLoad l, vr
		astDel l

		if( not irEmitPUSHPARAM( proc, a, vr, pmode, astTB(p).param.lgt ) ) then
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
	hCallProc n, proc, mode, vreg

	'' del temp strings and copy back if needed
	hCheckTmpStrings tempstrs_base

	'' del temp arrays descriptors created for array fields passed by desc
	hFreeTempArrayDescs n

end sub

