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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\emit.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'''''#define DO_STACK_ALIGN

type ASTCTX
	astTB			as TLIST

	proclist		as TLIST
	curproc			as ASTPROCNODE ptr

	doemit			as integer
	isopt			as integer

	tempstr			as TLIST
	temparray		as TLIST
end Type

type ASTVALUE
	dtype			as integer
	val				as FBVALUE
end type


declare function 	hNewProcNode	( byval proc as FBSYMBOL ptr ) as ASTPROCNODE ptr

declare function 	hNewNode		( byval class as integer, _
									  byval dtype as integer, _
									  byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare sub 		hFlush			( byval n as ASTNODE ptr )

declare function	hLoad			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadASSIGN		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadCONV		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadBOP		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadUOP		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadCONST		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadVAR		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadIDX		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadPTR		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadFUNCT		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadADDR		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadLOAD		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadBRANCH		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadIIF		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadOFFSET		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadLINK		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadSTACK		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadENUM		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadLABEL		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadLIT		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadJMPTB		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadDBG		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadMEM		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadBOUNDCHK	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	hLoadPTRCHK		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function	astUpdStrConcat	( byval n as ASTNODE ptr ) as ASTNODE ptr


'' globals
	dim shared ctx as ASTCTX

	dim shared bitmaskTB( 0 to 32 ) as uinteger = { 0, _
		1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65565, _
        131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215, 33554431, _
        67108863, 134217727, 268435455, 536870911, 1073741823, 2147483647, 4294967295 }

	dim shared minlimitTB(IR_DATATYPE_BYTE to IR_DATATYPE_ULONGINT) as longint = { _
		-128LL, 0LL, 0LL, -32768LL, 0LL, -2147483648LL, 0LL, -2147483648LL, -9223372036854775808LL, 0LL }
	dim shared maxlimitTB(IR_DATATYPE_BYTE to IR_DATATYPE_ULONGINT) as longint = { _
		127LL, 255LL, 255LL, 32767LL, 65535LL, 2147483647LL, 4294967295LL, 2147483647LL, 9223372036854775807LL, 18446744073709551615LL }


'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' proc handling
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

''::::
private sub hInitProcList( )

	''
    listNew( @ctx.proclist, AST_INITPROCNODES, len( ASTPROCNODE ), FALSE )

    ctx.curproc = NULL

end sub

''::::
private sub hEndProcList( )

	listFree( @ctx.proclist )

	ctx.curproc = NULL

end sub

'':::::
private function hNewProcNode( byval proc as FBSYMBOL ptr ) as ASTPROCNODE ptr static
	dim as ASTPROCNODE ptr n

	n = listNewNode( @ctx.proclist )

	''
	n->proc = proc
	n->head = NULL
	n->tail = NULL

	function = n

end function

'':::::
private sub hDelProcNode( byval n as ASTPROCNODE ptr ) static

	n->head = NULL
	n->tail = NULL

	listDelNode( @ctx.proclist, cptr(TLISTNODE ptr, n) )

end sub

''::::
private sub hProcFlush( byval p as ASTPROCNODE ptr, _
						byval doemit as integer ) static
    dim as ASTNODE ptr n, nxt
    dim as FBSYMBOLTB ptr oldtb

	''
	ctx.curproc = p
	ctx.doemit 	= doemit

	if( not p->ismain ) then
		env.scope = 1
		env.currproc = p->proc
	else
		env.scope = 0
		env.currproc = NULL
	end if

	env.currproc = p->proc
	oldtb = symbSetSymbolTb( @p->proc->proc.loctb )

	''
	if( ctx.doemit ) then
		irEmitPROCBEGIN( p->proc, p->initlabel )
	end if

	''
	n = p->head
	do while( n <> NULL )
		nxt = n->next
		hFlush( n )
		n = nxt
	loop

    ''
    if( ctx.doemit ) then
    	irEmitPROCEND( p->proc, p->initlabel, p->exitlabel )
    end if

    '' del symbols from hash and symbol tb's
    symbDelSymbolTb( @p->proc->proc.loctb, FALSE )

    '' back to global/module-level/main
    symbSetSymbolTb( NULL )
    env.currproc = NULL
    env.scope = 0

	ctx.doemit  = TRUE
	ctx.curproc = NULL

	''
	hDelProcNode( p )

end sub

''::::
private sub hProcFlushAll( ) static
    dim as ASTPROCNODE ptr p
    dim as integer doemit

	'' procs should be sorted by include file

	do
        p = listGetHead( @ctx.proclist )
        if( p = NULL ) then
        	exit do
        end if

		doemit = TRUE
		'' private?
		if( symbIsPrivate( p->proc ) ) then
			'' never called? skip
			if( not symbGetProcIsCalled( p->proc ) ) then
				doemit = FALSE
			end if
		end if

		hProcFlush( p, doemit )
	loop

end sub

''::::
sub astAdd( byval n as ASTNODE ptr ) static

	if( n = NULL ) then
		exit sub
	end if

	''
	if( ctx.curproc->tail <> NULL ) then
		ctx.curproc->tail->next = n
	else
		ctx.curproc->head = n
	end if

	n->prev = ctx.curproc->tail
	n->next = NULL
	ctx.curproc->tail = n

end sub

''::::
sub astAddAfter( byval n as ASTNODE ptr, _
				 byval p as ASTNODE ptr ) static

	if( (p = NULL) or (n = NULL) ) then
		exit sub
	end if

	''
	if( p->next = NULL ) then
		ctx.curproc->tail = n
	end if

	n->prev = p
	n->next = p->next
	p->next = n

end sub

'':::::
function astProcBegin( byval proc as FBSYMBOL ptr, _
					   byval initlabel as FBSYMBOL ptr, _
					   byval exitlabel as FBSYMBOL ptr, _
					   byval ismain as integer ) as ASTPROCNODE ptr static

    dim as ASTPROCNODE ptr p

	'' alloc new node
	p = hNewProcNode( proc )
	if( p = NULL ) then
		return NULL
	end if

	p->initlabel = initlabel
	p->exitlabel = exitlabel
	p->ismain	 = ismain

	''
	proc->proc.loctb.head = NULL
	proc->proc.loctb.tail = NULL
	symbSetSymbolTb( @proc->proc.loctb )

	ctx.curproc = p

	''
	irProcBegin( proc )

	function = p

end function

'':::::
sub astProcEnd( byval p as ASTPROCNODE ptr ) static

	''
	irProcEnd( p->proc )

	if( not p->ismain ) then
		'' not private or inline? flush it..
		if( not symbIsPrivate( p->proc ) ) then
			hProcFlush( p, TRUE )

		'' remove from hash tb only
		else
			symbDelSymbolTb( @p->proc->proc.loctb, TRUE )
		end if

	'' main? flush all remaining, it's the latest
	else
		hProcFlushAll( )

	end if

	'' back to global table
	symbSetSymbolTb( NULL )

	'' back to main (or NULL)
	ctx.curproc = listGetHead( @ctx.proclist )

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' scope handling
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astScopeBegin( byval s as FBSYMBOL ptr ) static

    '' change to scope's symbol tb
    s->scp.loctb.head = NULL
    s->scp.loctb.tail = NULL

	symbSetSymbolTb( @s->scp.loctb )

	''
	irScopeBegin( s )

	''
	astAdd( astNewDBG( IR_OP_DBG_SCOPEINI, cint( s ) ) )

end sub

'':::::
sub astScopeEnd( byval s as FBSYMBOL ptr ) static

	''
	astAdd( astNewDBG( IR_OP_DBG_SCOPEEND, cint( s ) ) )

	''
	irScopeEnd( s )

	'' back to preview symbol tb
	symbSetSymbolTb( s->symtb )

end sub

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
function astIsSymbolOnTree( byval sym as FBSYMBOL ptr, _
							byval n as ASTNODE ptr ) as integer

	dim as FBSYMBOL ptr s

	if( n = NULL ) then
		return FALSE
	end if

	select case as const n->class
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
		 AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET

		s = astGetSymbolOrElm( n )

		'' same symbol?
		if( s = sym ) then
			return TRUE
		end if

		'' passed by ref or by desc? can't do any assumption..
		if( s <> NULL ) then
			if( (s->alloctype and _
				(FB_ALLOCTYPE_ARGUMENTBYDESC or FB_ALLOCTYPE_ARGUMENTBYREF)) > 0 ) then
				return TRUE
			end if
		end if

	'' pointer? could be pointing to source symbol too..
	case AST_NODECLASS_PTR
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
private function hOptAssignament( byval n as ASTNODE ptr ) as ASTNODE ptr static
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

	if( irGetDataClass( n->dtype ) <> IR_DATACLASS_STRING ) then
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
	if( n->class = AST_NODECLASS_BOP ) then
		if( n->op = IR_OP_ADD ) then
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
	if( irGetDataClass( dtype ) = IR_DATACLASS_STRING ) then
		return NULL
	end if

	'' UDT? ditto..
	if( dtype = IR_DATATYPE_USERDEF ) then
		return NULL
	end if

	'' shortcut "exp logop exp" if it's at top of tree (used to optimize IF/ELSEIF/WHILE/UNTIL)
	if( n->class <> AST_NODECLASS_BOP ) then
		'' UOP? check if it's a NOT
		if( n->class = AST_NODECLASS_UOP ) then
			if( n->op = IR_OP_NOT ) then
				l = astUpdComp2Branch( n->l, label, isinverse = FALSE )
				astDel( n )
				return l
			end if
		end if

		'' CONST?
		if( n->defined ) then
			if( not isinverse ) then
				'' branch if false
				select case as const dtype
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					istrue = n->val.long = 0
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					istrue = n->val.float = 0
				case else
					istrue = n->val.int = 0
				end select

				if( istrue ) then
					astDel( n )
					n = astNewBRANCH( IR_OP_JMP, label, NULL )
					if( n = NULL ) then
						return NULL
					end if
				end if
			else
				'' branch if true
				select case as const dtype
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					istrue = n->val.long <> 0
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					istrue = n->val.float <> 0
				case else
					istrue = n->val.int <> 0
				end select

				if( istrue ) then
					astDel( n )
					n = astNewBRANCH( IR_OP_JMP, label, NULL )
					if( n = NULL ) then
						return NULL
					end if
				end if
			end if

		else
			'' otherwise, check if zero (ie= FALSE)
			if( not isinverse ) then
				op = IR_OP_EQ
			else
				op = IR_OP_NE
			end if

			'' zstring? astNewBOP will think both are zstrings..
			if( dtype = IR_DATATYPE_CHAR ) then
				dtype = IR_DATATYPE_INTEGER
			end if

			select case as const dtype
			case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
				expr = astNewCONST64( 0, dtype )
			case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
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

	'' relational operator?
	select case as const op
	case IR_OP_EQ, IR_OP_NE, IR_OP_GT, IR_OP_LT, IR_OP_GE, IR_OP_LE

		'' invert it
		if( not isinverse ) then
			n->op = irGetInverseLogOp( op )
		end if

		'' tell IR that the destine label is already set
		n->ex = label

		return n

	'' binary op that sets the flags? (x86 opt, may work on some RISC cpu's)
	case IR_OP_ADD, IR_OP_SUB, IR_OP_SHL, IR_OP_SHR, _
		 IR_OP_AND, IR_OP_OR, IR_OP_XOR, IR_OP_IMP
		 ', IR_OP_EQV -- NOT doesn't set any flags, so EQV can't be optimized (x86 assumption)

		'' x86-quirk: only if integers, as FPU will set its own flags, that must copied back
		if( irGetDataClass( dtype ) = IR_DATACLASS_INTEGER ) then
            '' can't be done with longints either, as flag is set twice
            if( (dtype <> IR_DATATYPE_LONGINT) and (dtype <> IR_DATATYPE_ULONGINT) ) then

				'' check if zero (ie= FALSE)
				if( not isinverse ) then
					op = IR_OP_JEQ
				else
					op = IR_OP_JNE
				end if

				return astNewBRANCH( op, label, n )
			end if
		end if

	end select

	'' if no optimization could be done, check if zero (ie= FALSE)
	if( not isinverse ) then
		op = IR_OP_EQ
	else
		op = IR_OP_NE
	end if

	select case as const dtype
	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		expr = astNewCONST64( 0, dtype )
	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		expr = astNewCONSTf( 0.0, dtype )
	case else
		expr = astNewCONSTi( 0, dtype )
	end select

	function = astNewBOP( op, n, expr, label, FALSE )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astPtrCheck( byval pdtype as integer, _
					  byval psubtype as FBSYMBOL ptr, _
					  byval expr as ASTNODE ptr ) as integer static

	dim as integer edtype, pdtype_np, edtype_np

	function = FALSE

	edtype = astGetDataType( expr )

	select case astGetClass( expr )
	case AST_NODECLASS_CONST, AST_NODECLASS_ENUM
    	'' expr not a pointer?
    	if( edtype < IR_DATATYPE_POINTER ) then
    		'' not NULL?
    		if( astGetValInt( expr ) <> NULL ) then
    			exit function
    		else
    			return TRUE
    		end if
    	end if

	case else
    	'' expr not a pointer?
    	if( edtype < IR_DATATYPE_POINTER ) then
    		exit function
    	end if
	end select

	'' different types?
	if( pdtype <> edtype ) then

    	'' remove the pointers
    	pdtype_np mod= IR_DATATYPE_POINTER
    	edtype_np mod= IR_DATATYPE_POINTER

    	'' 1st) one of them is a ANY PTR?
    	if( pdtype_np = IR_DATATYPE_VOID ) then
    		return TRUE
    	elseif( edtype_np = IR_DATATYPE_VOID ) then
    		return TRUE
    	end if

    	'' 2nd) same level of indirection?
    	if( abs( pdtype - edtype ) >= IR_DATATYPE_POINTER ) then
    		exit function
    	end if

    	'' 3rd) same size?
    	if( (pdtype_np <= IR_DATATYPE_DOUBLE) and _
    		(edtype_np <= IR_DATATYPE_DOUBLE) ) then
    		if( irGetDataSize( pdtype_np ) = irGetDataSize( edtype_np ) ) then
    			return TRUE
    		end if
    	end if

    	exit function
    end if

	'' check sub types
	function = symbIsEqual( psubtype, astGetSubType( expr ) )

end function

'':::::
function astFuncPtrCheck( byval pdtype as integer, _
					      byval psubtype as FBSYMBOL ptr, _
					      byval expr as ASTNODE ptr ) as integer static

	dim as FBSYMBOL ptr esubtype

	function = FALSE

    if( psubtype = NULL ) then
    	exit function
    end if

	select case as const astGetClass( expr )
	'' address, func, var, ..
	case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET, _
		 AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FUNCT, AST_NODECLASS_PTR

    	'' not a function pointer?
    	if( astGetDataType( expr ) <> IR_DATATYPE_POINTER + IR_DATATYPE_FUNCTION ) then
    		return astPtrCheck( pdtype, psubtype, expr )
    	end if

    	esubtype = astGetSubType( expr )
    	if( esubtype = NULL ) then
    		exit function
    	end if

    	function = symbIsEqual( psubtype, esubtype )

	'' const, expression, ..
	case else
		function = astPtrCheck( pdtype, psubtype, expr )
	end select

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
	case AST_NODECLASS_BOP
		select case n->op
		case IR_OP_ADD
			v = "+"
		case IR_OP_SUB
			v = "-"
		case IR_OP_MUL
			v = "*"
		case IR_OP_DIV
			v = "/"
		case IR_OP_INTDIV
			v = "\\"
		case IR_OP_AND
			v = "&"
		case IR_OP_OR
			v = "|"
		case IR_OP_XOR
			v = "^"
		case IR_OP_SHL
			v = "<"
		case IR_OP_SHR
			v = ">"
		end select
		v = "(" + v + ")"

	case AST_NODECLASS_UOP
		select case n->op
		case IR_OP_NEG
			v = "-"
		case IR_OP_NOT
			v = "!"
		end select
		v = "(" + v + ")"

	case AST_NODECLASS_VAR
		v = "[" + mid$( symbGetName( n->var.sym ), 2 ) + "]"
	case AST_NODECLASS_CONST
		v = "<" + str$( n->val.int ) + ">"
	case AST_NODECLASS_CONV
		v = "{" + str$( n->dtype ) + "}"
'	case AST_NODECLASS_IDX
'		c = n->idx.sym
'		v = "{" + rtrim$( mid$( symbGetVarName( c->idx.sym ), 2 ) ) + "}"

'	case AST_NODECLASS_FUNCT
'		v = rtrim$( mid$( symbGetProcName( n->proc.s ), 2 ) ) + "()"

'	case AST_NODECLASS_PARAM
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

	p = d->ll_prv
	n = d->ll_nxt

	*d = *s

	d->ll_prv = p
	d->ll_nxt = n

end sub

'':::::
sub astSwap( byval d as ASTNODE ptr, _
			 byval s as ASTNODE ptr ) static

	dim as ASTNODE ptr dp, dn
	dim as ASTNODE ptr sp, sn

	dp = d->ll_prv
	dn = d->ll_nxt
	sp = s->ll_prv
	sn = s->ll_nxt

	swap *d, *s

	d->ll_prv = dp
	d->ll_nxt = dn
	s->ll_prv = sp
	s->ll_nxt = sn

end sub

'':::::
function astCloneTree( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr nn, p

	''
	if( n = NULL ) then
		return NULL
	end if

	''
	nn = hNewNode( INVALID, INVALID )
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

	'' profiled function have sub nodes
	if( n->class = AST_NODECLASS_FUNCT ) then
		p = n->proc.profbegin
		if( p <> NULL ) then
			nn->proc.profbegin = astCloneTree( p )
			nn->proc.profend   = astCloneTree( n->proc.profend )
		end if
	end if

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

	'' profiled function have sub nodes
	if( n->class = AST_NODECLASS_FUNCT ) then
		p = n->proc.profbegin
		if( p <> NULL ) then
			astDelTree( p )
			astDelTree( n->proc.profend )
		end if
	end if

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
	case AST_NODECLASS_VAR
		if( l->var.sym <> r->var.sym ) then
			exit function
		end if

		if( l->var.elm <> r->var.elm ) then
			exit function
		end if

		if( l->var.ofs <> r->var.ofs ) then
			exit function
		end if

	case AST_NODECLASS_CONST
const DBL_EPSILON# = 2.2204460492503131e-016

		select case as const l->dtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			if( l->val.long <> r->val.long ) then
				exit function
			end if
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			if( abs( l->val.float - r->val.float ) > DBL_EPSILON ) then
				exit function
			end if
		case else
			if( l->val.int <> r->val.int ) then
				exit function
			end if
		end select

	case AST_NODECLASS_ENUM
		if( l->val.int <> r->val.int ) then
			exit function
		end if

	case AST_NODECLASS_PTR
		if( l->ptr.sym <> r->ptr.sym ) then
			exit function
		end if

		if( l->ptr.elm <> r->ptr.elm ) then
			exit function
		end if

		if( l->ptr.ofs <> r->ptr.ofs ) then
			exit function
		end if

	case AST_NODECLASS_IDX
		if( l->idx.ofs <> r->idx.ofs ) then
			exit function
		end if

		if( l->idx.mult <> r->idx.mult ) then
			exit function
		end if

	case AST_NODECLASS_BOP
		if( l->op <> r->op ) then
			exit function
		end if

		if( l->allocres <> r->allocres ) then
			exit function
		end if

		if( l->ex <> r->ex ) then
			exit function
		end if

	case AST_NODECLASS_UOP
		if( l->op <> r->op ) then
			exit function
		end if

		if( l->allocres <> r->allocres ) then
			exit function
		end if

	case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
		if( l->addr.sym <> r->addr.sym ) then
			exit function
		end if

		if( l->addr.elm <> r->addr.elm ) then
			exit function
		end if

		if( l->op <> r->op ) then
			exit function
		end if

	case AST_NODECLASS_CONV
		'' do nothing, the l child will be checked below

	case AST_NODECLASS_FUNCT, AST_NODECLASS_BRANCH, _
		 AST_NODECLASS_LOAD, AST_NODECLASS_ASSIGN, _
		 AST_NODECLASS_LINK
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

'':::::
function astIsClassOnTree( byval class as integer, _
						   byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr m

	''
	if( n = NULL ) then
		return NULL
	end if

	if( n->class = class ) then
		return n
	end if

	'' walk
	m = astIsClassOnTree( class, n->l )
	if( m <> NULL ) then
		return m
	end if

	m = astIsClassOnTree( class, n->r )
	if( m <> NULL ) then
		return m
	end if

	'' profiled function have sub nodes
	if( n->class = AST_NODECLASS_FUNCT ) then
		m = astIsClassOnTree( class, n->proc.profbegin )
		if( m <> NULL ) then
			return m
		end if
	end if

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree routines
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub astInitTempLists

	listNew( @ctx.tempstr, AST_INITTEMPSTRINGS, len( ASTTEMPSTR ), FALSE )

	listNew( @ctx.temparray, AST_INITTEMPARRAYS, len( ASTTEMPARRAY ), FALSE )

end sub

'':::::
private sub astEndTempLists

	listFree( @ctx.temparray )

	listFree( @ctx.tempstr )

end sub

'':::::
sub astInit static

	''
    listNew( @ctx.astTB, AST_INITNODES, len( ASTNODE ), FALSE )

    ''
    astInitTempLists( )

    ctx.doemit = TRUE
    ctx.isopt  = FALSE

    ''
    hInitProcList( )

end sub

'':::::
sub astEnd static

	''
	astEndTempLists( )

	''
	hEndProcList( )

	''
	listFree( @ctx.astTB )

end sub

'':::::
private function hNewNode( byval class as integer, _
				 		   byval dtype as integer, _
				 		   byval subtype as FBSYMBOL ptr ) as ASTNODE ptr static

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

	listDelNode( @ctx.astTB, cptr( TLISTNODE ptr, n ) )

end sub

'':::::
function astIsADDR( byval n as ASTNODE ptr ) as integer static

	select case n->class
	case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
		return TRUE
	case else
		return FALSE
	end select

end function

'':::::
function astGetSymbolOrElm( byval n as ASTNODE ptr ) as FBSYMBOL ptr static
    dim s as FBSYMBOL ptr

	s = NULL

	if( n <> NULL ) then
		select case as const n->class
		case AST_NODECLASS_PTR
			s = n->ptr.elm
			if( s = NULL ) then
				s = n->ptr.sym
			end if

		case AST_NODECLASS_VAR
			s = n->var.elm
			if( s = NULL ) then
				s = n->var.sym
			end if

		case AST_NODECLASS_IDX
			n = n->r
			if( n <> NULL ) then
				s = n->var.elm
				if( s = NULL ) then
					s = n->var.sym
				end if
			end if

		case AST_NODECLASS_FUNCT
			s = n->proc.sym

		case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
			s = n->addr.elm
			if( s = NULL ) then
				s = n->addr.sym
			end if
		end select
	end if

	function = s

end function

'':::::
function astGetSymbol( byval n as ASTNODE ptr ) as FBSYMBOL ptr static

	if( n <> NULL ) then
		select case as const n->class
		case AST_NODECLASS_PTR
			return n->ptr.sym

		case AST_NODECLASS_VAR
			return n->var.sym

		case AST_NODECLASS_IDX
			n = n->r
			if( n <> NULL ) then
				return n->var.sym
			end if

		case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
			return n->addr.sym
		end select
	end if

	function = NULL

end function

'':::::
function astGetElm( byval n as ASTNODE ptr ) as FBSYMBOL ptr static

	if( n <> NULL ) then
		select case as const n->class
		case AST_NODECLASS_PTR
			return n->ptr.elm

		case AST_NODECLASS_VAR
			return n->var.elm

		case AST_NODECLASS_IDX
			n = n->r
			if( n <> NULL ) then
				return n->var.elm
			end if

		case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
			return n->addr.elm
		end select
	end if

	function = NULL

end function

'':::::
function astGetValueAsInt( byval n as ASTNODE ptr ) as integer

  	select case as const astGetDataType( n )
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  	    function = cint( astGetValLong( n ) )
  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		function = cint( astGetValFloat( n ) )
  	case else
  		function = astGetValInt( n )
  	end select

end function

'':::::
function astGetValueAsStr( byval n as ASTNODE ptr ) as string

  	select case as const astGetDataType( n )
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  	    function = str( astGetValLong( n ) )
  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		function = str( astGetValFloat( n ) )
  	case else
  		function = str( astGetValInt( n ) )
  	end select

end function

'':::::
function astGetValueAsLongInt( byval n as ASTNODE ptr ) as longint

  	select case as const astGetDataType( n )
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  	    function = astGetValLong( n )
  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		function = clngint( astGetValFloat( n ) )
  	case else
  		if( irIsSigned( astGetDataType( n ) ) ) then
  			function = clngint( astGetValInt( n ) )
  		else
  			function = clngint( cuint( astGetValInt( n ) ) )
  		end if
  	end select

end function

'':::::
function astGetValueAsULongInt( byval n as ASTNODE ptr ) as ulongint

  	select case as const astGetDataType( n )
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  	    function = astGetValLong( n )
  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		function = culngint( astGetValFloat( n ) )
  	case else
  		function = culngint( cuint( astGetValInt( n ) ) )
  	end select

end function

'':::::
function astGetValueAsDouble( byval n as ASTNODE ptr ) as double

  	select case as const astGetDataType( n )
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  	    function = cdbl( astGetValLong( n ) )
  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		function = astGetValFloat( n )
  	case else
  		function = cdbl( astGetValInt( n ) )
  	end select

end function

'':::::
sub astConvertValue( byval n as ASTNODE ptr, _
					 byval v as FBVALUE ptr, _
					 byval todtype as integer ) static

	select case as const n->dtype
	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		select case as const todtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			v->long = n->val.long
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			v->float  = n->val.long
		case else
			v->int  = n->val.long
		end select

	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		select case as const todtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			v->long = n->val.float
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			v->float  = n->val.float
		case else
			v->int  = n->val.float
		end select

	case else
		select case as const todtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			v->long = n->val.int
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			v->float  = n->val.int
		case else
			v->int  = n->val.int
		end select
	end select

end sub

''::::
private function hLoad( byval n as ASTNODE ptr ) as IRVREG ptr

	if( n = NULL ) then
		return NULL
	end if

	select case as const n->class
	case AST_NODECLASS_LINK
		return hLoadLINK( n )

	case AST_NODECLASS_ASSIGN
		return hLoadASSIGN( n )

	case AST_NODECLASS_CONV
		return hLoadCONV( n )

	case AST_NODECLASS_CONST
		return hLoadCONST( n )

	case AST_NODECLASS_VAR
		return hLoadVAR( n )

	case AST_NODECLASS_IDX
		return hLoadIDX( n )

	case AST_NODECLASS_ENUM
		return hLoadENUM( n )

	case AST_NODECLASS_BOP
		return hLoadBOP( n )

	case AST_NODECLASS_UOP
		return hLoadUOP( n )

	case AST_NODECLASS_FUNCT
		return hLoadFUNCT( n )

	case AST_NODECLASS_PTR
		return hLoadPTR( n )

	case AST_NODECLASS_ADDR
		return hLoadADDR( n )

	case AST_NODECLASS_OFFSET
		return hLoadOFFSET( n )

	case AST_NODECLASS_LOAD
		return hLoadLOAD( n )

	case AST_NODECLASS_BRANCH
		return hLoadBRANCH( n )

    case AST_NODECLASS_IIF
    	return hLoadIIF( n )

    case AST_NODECLASS_STACK
    	return hLoadSTACK( n )

    case AST_NODECLASS_LABEL
    	return hLoadLABEL( n )

    case AST_NODECLASS_LIT
    	return hLoadLIT( n )

    case AST_NODECLASS_JMPTB
    	return hLoadJMPTB( n )

    case AST_NODECLASS_DBG
    	return hLoadDBG( n )

    case AST_NODECLASS_MEM
    	return hLoadMEM( n )

    case AST_NODECLASS_BOUNDCHK
    	return hLoadBOUNDCHK( n )

    case AST_NODECLASS_PTRCHK
    	return hLoadPTRCHK( n )
    end select

end function

''::::
private function hOptimize( byval n as ASTNODE ptr ) as ASTNODE ptr

	'' calls must be done in the order below
    ctx.isopt = TRUE

	hOptAssocADD( n )

	hOptAssocMUL( n )

	n = hOptConstDistMUL( n )

	n = hOptConstAccum1( n )

	hOptConstAccum2( n )

	hOptConstRmNeg( n, NULL )

	hOptConstIDX( n )

	hOptToShift( n )

	n = hOptNullOp( n )

	ctx.isopt = FALSE

	function = n

end function

''::::
private sub hFlush( byval n as ASTNODE ptr )

	''
	if( n = NULL ) then
		exit sub
	end if

	''
	n = hOptimize( n )

	n = hOptAssignament( n )					'' needed even when not optimizing

	n = astUpdStrConcat( n )

    ''
	hLoad( n )

	astDel( n )

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' link nodes (l = curr node; r = next link)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLINK( byval l as ASTNODE ptr, _
					 byval r as ASTNODE ptr ) as ASTNODE ptr static

	dim as ASTNODE ptr n
	dim as integer dtype

	if( l = NULL ) then
		if( r = NULL ) then
			return NULL
		end if
		dtype =	r->dtype
	else
		dtype =	l->dtype
	end if

	''
	n = hNewNode( AST_NODECLASS_LINK, dtype )
	if( n = NULL ) then
		return NULL
	end if

	''
	n->l = l
	n->r = r

	function = n

end function

'':::::
private function hLoadLINK( byval n as ASTNODE ptr ) as IRVREG ptr

	if( n = NULL ) then
		return NULL
	end if

	hLoad( n->l )
	astDel( n->l )

	hLoad( n->r )
	astDel( n->r )

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' binary operations (l = left operand expression ; r = right operand expression)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hStrLiteralConcat( byval l as ASTNODE ptr, _
									byval r as ASTNODE ptr ) as ASTNODE ptr
    dim as FBSYMBOL ptr s, ls, rs

	ls = astGetSymbolOrElm( l )
	rs = astGetSymbolOrElm( r )

	'' new len = both strings' len less the 2 null-chars
	s = hAllocStringConst( symbGetVarText( ls ) + symbGetVarText( rs ), _
						   symbGetLen( ls ) - 1 + symbGetLen( rs ) - 1 )

	function = astNewVAR( s, NULL, 0, IR_DATATYPE_FIXSTR )

	astDel( r )
	astDel( l )

end function

'':::::
private sub hBOPConstFoldInt( byval op as integer, _
							  byval l as ASTNODE ptr, _
							  byval r as ASTNODE ptr ) static

	dim as integer issigned

	select case as const l->dtype
	case IR_DATATYPE_BYTE, IR_DATATYPE_SHORT, IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
		issigned = TRUE
	case else
		issigned = FALSE
	end select

	select case as const op
	case IR_OP_ADD
		l->val.int = l->val.int + r->val.int

	case IR_OP_SUB
		l->val.int = l->val.int - r->val.int

	case IR_OP_MUL
		if( issigned ) then
			l->val.int = l->val.int * r->val.int
		else
			l->val.int = cunsg(l->val.int) * cunsg(r->val.int)
		end if

	case IR_OP_INTDIV
		if( r->val.int <> 0 ) then
			if( issigned ) then
				l->val.int = l->val.int \ r->val.int
			else
				l->val.int = cunsg( l->val.int ) \ cunsg( r->val.int )
			end if
		else
			l->val.int = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_MOD
		if( r->val.int <> 0 ) then
			if( issigned ) then
				l->val.int = l->val.int mod r->val.int
			else
				l->val.int = cunsg( l->val.int ) mod cunsg( r->val.int )
			end if
		else
			l->val.int = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_SHL
		if( issigned ) then
			l->val.int = l->val.int shl r->val.int
		else
			l->val.int = cunsg( l->val.int ) shl r->val.int
		end if

	case IR_OP_SHR
		if( issigned ) then
			l->val.int = l->val.int shr r->val.int
		else
			l->val.int = cunsg( l->val.int ) shr r->val.int
		end if

	case IR_OP_AND
		l->val.int = l->val.int and r->val.int

	case IR_OP_OR
		l->val.int = l->val.int or r->val.int

	case IR_OP_XOR
		l->val.int = l->val.int xor r->val.int

	case IR_OP_EQV
		l->val.int = l->val.int eqv r->val.int

	case IR_OP_IMP
		l->val.int = l->val.int imp r->val.int

	case IR_OP_NE
		l->val.int = l->val.int <> r->val.int

	case IR_OP_EQ
		l->val.int = l->val.int = r->val.int

	case IR_OP_GT
		if( issigned ) then
			l->val.int = l->val.int > r->val.int
		else
			l->val.int = cunsg( l->val.int ) > cunsg( r->val.int )
		end if

	case IR_OP_LT
		if( issigned ) then
			l->val.int = l->val.int < r->val.int
		else
			l->val.int = cunsg( l->val.int ) < cunsg( r->val.int )
		end if

	case IR_OP_LE
		if( issigned ) then
			l->val.int = l->val.int <= r->val.int
		else
			l->val.int = cunsg( l->val.int ) <= cunsg( r->val.int )
		end if

	case IR_OP_GE
		if( issigned ) then
			l->val.int = l->val.int >= r->val.int
		else
			l->val.int = cunsg( l->val.int ) >= cunsg( r->val.int )
		end if
	end select

end sub

'':::::
private sub hBOPConstFoldFlt( byval op as integer, _
						      byval l as ASTNODE ptr, _
						      byval r as ASTNODE ptr ) static

	select case as const op
	case IR_OP_ADD
		l->val.float = l->val.float + r->val.float

	case IR_OP_SUB
		l->val.float = l->val.float - r->val.float

	case IR_OP_MUL
		l->val.float = l->val.float * r->val.float

	case IR_OP_DIV
		l->val.float = l->val.float / r->val.float

    case IR_OP_POW
		l->val.float = l->val.float ^ r->val.float

	case IR_OP_NE
		l->val.int = l->val.float <> r->val.float

	case IR_OP_EQ
		l->val.int = l->val.float = r->val.float

	case IR_OP_GT
		l->val.int = l->val.float > r->val.float

	case IR_OP_LT
		l->val.int = l->val.float < r->val.float

	case IR_OP_LE
		l->val.int = l->val.float <= r->val.float

	case IR_OP_GE
		l->val.int = l->val.float >= r->val.float

    case IR_OP_ATAN2
		l->val.float = atan2( l->val.float, r->val.float )
	end select

end sub

'':::::
private sub hBOPConstFold64( byval op as integer, _
							 byval l as ASTNODE ptr, _
							 byval r as ASTNODE ptr ) static

	dim as integer issigned

	issigned = (l->dtype = IR_DATATYPE_LONGINT)

	select case as const op
	case IR_OP_ADD
		l->val.long = l->val.long + r->val.long

	case IR_OP_SUB
		l->val.long = l->val.long - r->val.long

	case IR_OP_MUL
		if( issigned ) then
			l->val.long = l->val.long * r->val.long
		else
			l->val.long = cunsg(l->val.long) * cunsg(r->val.long)
		end if

	case IR_OP_INTDIV
		if( r->val.long <> 0 ) then
			if( issigned ) then
				l->val.long = l->val.long \ r->val.long
			else
				l->val.long = cunsg( l->val.long ) \ cunsg( r->val.long )
			end if
		else
			l->val.long = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_MOD
		if( r->val.long <> 0 ) then
			if( issigned ) then
				l->val.long = l->val.long mod r->val.long
			else
				l->val.long = cunsg( l->val.long ) mod cunsg( r->val.long )
			end if
		else
			l->val.long = 0
			hReportError( FB_ERRMSG_DIVBYZERO )
		end if

	case IR_OP_SHL
		if( issigned ) then
			l->val.long = l->val.long shl r->val.int
		else
			l->val.long = cunsg( l->val.long ) shl r->val.int
		end if

	case IR_OP_SHR
		if( issigned ) then
			l->val.long = l->val.long shr r->val.int
		else
			l->val.long = cunsg( l->val.long ) shr r->val.int
		end if

	case IR_OP_AND
		l->val.long = l->val.long and r->val.long

	case IR_OP_OR
		l->val.long = l->val.long or r->val.long

	case IR_OP_XOR
		l->val.long = l->val.long xor r->val.long

	case IR_OP_EQV
		l->val.long = l->val.long eqv r->val.long

	case IR_OP_IMP
		l->val.long = l->val.long imp r->val.long

	case IR_OP_NE
		l->val.int = l->val.long <> r->val.long

	case IR_OP_EQ
		l->val.int = l->val.long = r->val.long

	case IR_OP_GT
		if( issigned ) then
			l->val.int = l->val.long > r->val.long
		else
			l->val.int = cunsg( l->val.long ) > cunsg( r->val.long )
		end if

	case IR_OP_LT
		if( issigned ) then
			l->val.int = l->val.long < r->val.long
		else
			l->val.int = cunsg( l->val.long ) < cunsg( r->val.long )
		end if

	case IR_OP_LE
		if( issigned ) then
			l->val.int = l->val.long <= r->val.long
		else
			l->val.int = cunsg( l->val.long ) <= cunsg( r->val.long )
		end if

	case IR_OP_GE
		if( issigned ) then
			l->val.int = l->val.long >= r->val.long
		else
			l->val.int = cunsg( l->val.long ) >= cunsg( r->val.long )
		end if
	end select

end sub

'':::::
private function hCheckPointer( byval op as integer, _
								byval dtype as integer, _
								byval dclass as integer ) as integer

    '' not int?
    if( dclass <> IR_DATACLASS_INTEGER ) then
    	return FALSE
    end if

    select case op
    '' add op?
    case IR_OP_ADD, IR_OP_SUB

    	'' another pointer?
    	if( dtype >= IR_DATATYPE_POINTER ) then
    		return FALSE
    	end if

    	return TRUE

	'' relational op?
	case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE

    	return TRUE

    case else
    	return FALSE
    end select

end function

'':::::
function astNewBOP( byval op as integer, _
					byval l as ASTNODE ptr, _
					byval r as ASTNODE ptr, _
					byval ex as FBSYMBOL ptr = NULL, _
					byval allocres as integer = TRUE ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer ldtype, rdtype, dtype
    dim as integer ldclass, rdclass
    dim as integer doconv
    dim as FBSYMBOL ptr s, subtype

	function = NULL

	if( (l = NULL) or (r = NULL) ) then
		exit function
	end if

	ldtype = l->dtype
	rdtype = r->dtype
	ldclass = irGetDataClass( ldtype )
	rdclass = irGetDataClass( rdtype )

	''::::::
    '' pointers?
    if( ldtype >= IR_DATATYPE_POINTER ) then
    	if( not hCheckPointer( op, rdtype, rdclass ) ) then
    		exit function
    	end if
    elseif( rdtype >= IR_DATATYPE_POINTER ) then
    	if( not hCheckPointer( op, ldtype, ldclass ) ) then
    		exit function
    	end if
    end if

	'' UDT's? can't operate
	if( (ldtype = IR_DATATYPE_USERDEF) or (rdtype = IR_DATATYPE_USERDEF) ) then
		exit function
    end if

    '' enums?
    if( (ldtype = IR_DATATYPE_ENUM) or (rdtype = IR_DATATYPE_ENUM) ) then
    	'' not the same?
    	if( ldtype <> rdtype ) then
    		if( (ldclass <> IR_DATACLASS_INTEGER) or (rdclass <> IR_DATACLASS_INTEGER) ) then
    			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
    		end if
    	end if
    end if

	'' longints?
	if( (ldtype = IR_DATATYPE_LONGINT) or (ldtype = IR_DATATYPE_ULONGINT) or _
		(rdtype = IR_DATATYPE_LONGINT) or (rdtype = IR_DATATYPE_ULONGINT) ) then

		'' same type?
		if( ldtype = rdtype ) then
			dtype = ldtype
		else
			dtype = irMaxDataType( ldtype, rdtype )
			'' one of the operands is a float? it has more precedence..
			if( dtype >= IR_DATATYPE_SINGLE ) then
				dtype = INVALID
			'' just the sign is different?
			elseif( dtype = INVALID ) then
				dtype = ldtype
			'' is the left op the longint?
			elseif( (ldtype = IR_DATATYPE_LONGINT) or (ldtype = IR_DATATYPE_ULONGINT) ) then
				dtype = ldtype
			'' then it's the right..
			else
				dtype = rdtype
			end if
		end if

		if( dtype <> INVALID ) then
			select case op
			case IR_OP_INTDIV
				return rtlMathLongintDIV( dtype, l, ldtype, r, rdtype )

			case IR_OP_MOD
				return rtlMathLongintMOD( dtype, l, ldtype, r, rdtype )

			end select
		end if
    end if

    '' both zstrings? treat as string..
    if( (ldtype = IR_DATATYPE_CHAR) and (rdtype = IR_DATATYPE_CHAR) ) then
    	ldclass = IR_DATACLASS_STRING
    	rdclass = ldclass
    end if

    '' strings?
    if( (ldclass = IR_DATACLASS_STRING) or (rdclass = IR_DATACLASS_STRING) ) then

		'' both aren't strings?
		if( ldclass <> rdclass ) then
			if( ldclass = IR_DATACLASS_STRING ) then
				'' not a zstring?
				if( rdtype <> IR_DATATYPE_CHAR ) then
					exit function
				end if
			else
				'' not a zstring?
				if( ldtype <> IR_DATATYPE_CHAR ) then
					exit function
				end if
			end if
		end if

		select case as const op
		case IR_OP_ADD
			'' check for string literals
			if( (ldtype = IR_DATATYPE_FIXSTR) and (rdtype = IR_DATATYPE_FIXSTR) ) then
				if( l->class = AST_NODECLASS_VAR ) then
					if( r->class = AST_NODECLASS_VAR ) then
						s = astGetSymbolOrElm( l )
						if( symbGetVarInitialized( s ) ) then
							s = astGetSymbolOrElm( r )
							if( symbGetVarInitialized( s ) ) then
								return hStrLiteralConcat( l, r )
							end if
						end if
					end if
				end if
			end if

			'' result will be always an var-len string
			ldtype = IR_DATATYPE_STRING
			ldclass = IR_DATACLASS_STRING
			rdtype = ldtype
			rdclass = ldclass

		case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE
			l = rtlStrCompare( l, ldtype, r, rdtype )
			r = astNewCONSTi( 0, IR_DATATYPE_INTEGER )

			ldtype = l->dtype
			ldclass = IR_DATACLASS_INTEGER
			rdtype = r->dtype
			rdclass = IR_DATACLASS_INTEGER

		case else
			exit function
		end select
    end if

    ''::::::

	'' convert byte to int
	if( irGetDataSize( ldtype ) = 1 ) then
		if( irIsSigned( ldtype ) ) then
			ldtype = IR_DATATYPE_INTEGER
		else
			ldtype = IR_DATATYPE_UINT
		end if
		l = astNewCONV( INVALID, ldtype, NULL, l )
	end if

	if( irGetDataSize( rdtype ) = 1 ) then
		if( irIsSigned( rdtype ) ) then
			rdtype = IR_DATATYPE_INTEGER
		else
			rdtype = IR_DATATYPE_UINT
		end if
		r = astNewCONV( INVALID, rdtype, NULL, r )
	end if

    '' convert types
	select case as const op
	'' flt div (/) can only operate on floats
	case IR_OP_DIV

		if( ldclass <> IR_DATACLASS_FPOINT ) then
			ldtype = IR_DATATYPE_DOUBLE
			l = astNewCONV( INVALID, ldtype, NULL, l )
			ldclass = IR_DATACLASS_FPOINT
		end if

		if( rdclass <> IR_DATACLASS_FPOINT ) then
			'' x86 assumption: if it's an int var, let the FPU do it
			if( (r->class = AST_NODECLASS_VAR) and (rdtype = IR_DATATYPE_INTEGER) ) then
				rdtype = IR_DATATYPE_DOUBLE
			else
				rdtype = IR_DATATYPE_DOUBLE
				r = astNewCONV( INVALID, rdtype, NULL, r )
			end if
			rdclass = IR_DATACLASS_FPOINT
		end if

	'' bitwise ops, int div (\), modulus and shift can only operate on integers
	case IR_OP_AND, IR_OP_OR, IR_OP_XOR, IR_OP_EQV, IR_OP_IMP, _
		 IR_OP_INTDIV, IR_OP_MOD, IR_OP_SHL, IR_OP_SHR

		if( ldclass <> IR_DATACLASS_INTEGER ) then
			ldtype = IR_DATATYPE_INTEGER
			l = astNewCONV( INVALID, ldtype, NULL, l )
			ldclass = IR_DATACLASS_INTEGER
		end if

		if( rdclass <> IR_DATACLASS_INTEGER ) then
			rdtype = IR_DATATYPE_INTEGER
			r = astNewCONV( INVALID, rdtype, NULL, r )
			rdclass = IR_DATACLASS_INTEGER
		end if

	'' atan2 can only operate on floats
	case IR_OP_ATAN2, IR_OP_POW

		if( ldclass <> IR_DATACLASS_FPOINT ) then
			ldtype = IR_DATATYPE_DOUBLE
			l = astNewCONV( INVALID, ldtype, NULL, l )
			ldclass = IR_DATACLASS_FPOINT
		end if

		if( rdclass <> IR_DATACLASS_FPOINT ) then
			rdtype = IR_DATATYPE_DOUBLE
			r = astNewCONV( INVALID, rdtype, NULL, r )
			rdclass = IR_DATACLASS_FPOINT
		end if

	end select

    ''::::::

    '' convert types to the most precise if needed
	if( ldtype <> rdtype ) then

		dtype = irMaxDataType( ldtype, rdtype )

		'' don't convert?
		if( dtype = INVALID ) then

			'' as types are different, if class is fp,
			'' the result type will be always a double
			if( ldclass = IR_DATACLASS_FPOINT ) then
				dtype   = IR_DATATYPE_DOUBLE
				subtype = NULL
			else

				'' an ENUM or POINTER always has the precedence
				if( (rdtype = IR_DATATYPE_ENUM) or (rdtype >= IR_DATATYPE_POINTER) ) then
					dtype = rdtype
					subtype = r->subtype
				else
					dtype = ldtype
					subtype = l->subtype
				end if

			end if

		else
			'' convert the l operand?
			if( dtype <> ldtype ) then
				subtype = r->subtype
				l = astNewCONV( INVALID, dtype, subtype, l )
				ldtype = dtype
				ldclass = rdclass

			'' convert the r operand..
			else
				subtype = l->subtype

				'' if it's the src-operand of a shift operation, do nothing
				if( (op = IR_OP_SHL) or (op = IR_OP_SHR) ) then
					'' it's already an integer
				else
					'' x86 assumption: if it's an short|int var, let the FPU do it
					doconv = TRUE
					if( ldclass = IR_DATACLASS_FPOINT ) then
						if( rdclass = IR_DATACLASS_INTEGER ) then
							'' can't be an longint nor a byte (byte operands are converted above)
							if( irGetDataSize( rdtype ) < FB_INTEGERSIZE*2 ) then
								select case r->class
								case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR
									'' can't be unsigned either
									if( irIsSigned( rdtype ) ) then
										doconv = FALSE
									end if
								end select
							end if
						end if
					end if

					if( doconv ) then
						r = astNewCONV( INVALID, dtype, subtype, r )
					end if
				end if

				rdtype = dtype
				rdclass = ldclass
			end if
		end if

	'' no conversion, type's are the same
	else
		dtype   = ldtype
		subtype = l->subtype
	end if

	'' post check
	select case as const op
	'' relative ops, the result is always an integer
	case IR_OP_EQ, IR_OP_GT, IR_OP_LT, IR_OP_NE, IR_OP_LE, IR_OP_GE
		dtype = IR_DATATYPE_INTEGER
		subtype = NULL

	'' right-operand must be an integer, so pow2 opts can be done on longint's
	case IR_OP_SHL, IR_OP_SHR
		if( rdtype <> IR_DATATYPE_INTEGER ) then
			if( rdtype <> IR_DATATYPE_UINT ) then
				rdtype = IR_DATATYPE_INTEGER
				r = astNewCONV( INVALID, rdtype, NULL, r )
				rdclass = IR_DATACLASS_INTEGER
			end if
		end if
	end select

	''::::::

	'' constant folding (won't handle commutation, ie: "1+a+2+3" will become "1+a+5", not "a+6")
	if( l->defined and r->defined ) then

		select case as const ldtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		    hBOPConstFold64( op, l, r )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			hBOPConstFoldFlt( op, l, r )
		case else
			'' byte's, short's, int's and enum's
			hBOPConstFoldInt( op, l, r )
		end select

		l->dtype 	= dtype
		l->subtype  = subtype

		astDel( r )

		return l

	elseif( l->defined ) then
		select case op
		case IR_OP_ADD, IR_OP_MUL
			'' ? + c = c + ?  |  ? * c = ? * c
			astSwap( r, l )

		case IR_OP_SUB
			'' c - ? = -? + c (this will removed later if no const folding can be done)
			r = astNewUOP( IR_OP_NEG, r )
			if( r = NULL ) then
				return NULL
			end if
			astSwap( r, l )
			op = IR_OP_ADD
		end select

	elseif( r->defined ) then
		select case op
		case IR_OP_SUB
			'' ? - c = ? + -c
			select case as const rdtype
			case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
				r->val.long = -r->val.long
			case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
				r->val.float = -r->val.float
			case else
				r->val.int = -r->val.int
			end select
			op = IR_OP_ADD

		case IR_OP_POW

			'' convert var ^ 2 to var * var
			if( r->val.float = 2.0 ) then

				'' operands will be converted to DOUBLE if not floats..
				if( l->class = AST_NODECLASS_CONV ) then
					select case l->l->class
					case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR
						n = l
						l = l->l
						astDel( n )
						ldtype = l->dtype
					end select
				end if

				select case l->class
				case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR
					astDel( r )
					r = astCloneTree( l )
					op = IR_OP_MUL
					dtype = ldtype
				end select
			end if
		end select
	end if

	''::::::
	'' handle pow
	if( op = IR_OP_POW ) then
		return rtlMathPow( l, r )
	end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_BOP, dtype, subtype )
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
private function hLoadBOP( byval n as ASTNODE ptr ) as IRVREG ptr
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
	v1 = hLoad( l )
	v2 = hLoad( r )

	if( ctx.doemit ) then
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

		'' "var op= expr" optimizations
		if( vr = NULL ) then
			vr = v1
		end if
	end if

	'' nodes not needed anymore
	astDel( l )
	astDel( r )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' unary operations (l = operand expression; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hUOPConstFoldInt( byval op as integer, _
						      byval v as ASTNODE ptr ) static

	select case as const op
	case IR_OP_NOT
		v->val.int = not v->val.int

	case IR_OP_NEG
		v->val.int = -v->val.int

	case IR_OP_ABS
		v->val.int = abs( v->val.int )

	case IR_OP_SGN
		v->val.int = sgn( v->val.int )
	end select

end sub

'':::::
private sub hUOPConstFoldFlt( byval op as integer, _
						      byval v as ASTNODE ptr ) static

	select case as const op
	case IR_OP_NOT
		v->val.int = not cint( v->val.float )

	case IR_OP_NEG
		v->val.float = -v->val.float

	case IR_OP_ABS
		v->val.float = abs( v->val.float )

	case IR_OP_SGN
		v->val.int = sgn( v->val.float )

	case IR_OP_SIN
		v->val.float = sin( v->val.float )

	case IR_OP_ASIN
		v->val.float = asin( v->val.float )

	case IR_OP_COS
		v->val.float = cos( v->val.float )

	case IR_OP_ACOS
		v->val.float = acos( v->val.float )

	case IR_OP_TAN
		v->val.float = tan( v->val.float )

	case IR_OP_ATAN
		v->val.float = atn( v->val.float )

	case IR_OP_SQRT
		v->val.float = sqr( v->val.float )

	case IR_OP_LOG
		v->val.float = log( v->val.float )

	case IR_OP_FLOOR
		v->val.float = int( v->val.float )
	end select

end sub

'':::::
private sub hUOPConstFold64( byval op as integer, _
							 byval v as ASTNODE ptr ) static

	select case as const op
	case IR_OP_NOT
		v->val.long = not v->val.long

	case IR_OP_NEG
		v->val.long = -v->val.long

	case IR_OP_ABS
		v->val.long = abs( v->val.long )

	case IR_OP_SGN
		v->val.int = sgn( v->val.long )
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

	dtype 	= o->dtype

    '' string? can't operate
    dclass = irGetDataClass( dtype )
    if( dclass = IR_DATACLASS_STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( dtype = IR_DATATYPE_USERDEF ) then
		exit function
    end if

    '' pointer?
    if( dtype >= IR_DATATYPE_POINTER ) then
    	'' only NOT allowed
    	if( op <> IR_OP_NOT ) then
    		exit function
    	end if
    end if

	'' convert byte to integer
	if( irGetDataSize( dtype ) = 1 ) then
		if( irIsSigned( dtype ) ) then
			dtype = IR_DATATYPE_INTEGER
		else
			dtype = IR_DATATYPE_UINT
		end if
		o = astNewCONV( INVALID, dtype, NULL, o )
	end if

	select case as const op
	'' NOT can only operate on integers
	case IR_OP_NOT
		if( dclass <> IR_DATACLASS_INTEGER ) then
			dtype = IR_DATATYPE_INTEGER
			o = astNewCONV( INVALID, dtype, NULL, o )
		end if

	'' with SGN the result is always signed integer
	case IR_OP_SGN
		if( dclass <> IR_DATACLASS_INTEGER ) then
			dtype = IR_DATATYPE_INTEGER
		else
			dtype = irGetSignedType( dtype )
		end if

	'' transcendental can only operate on floats
	case IR_OP_SIN, IR_OP_ASIN, IR_OP_COS, IR_OP_ACOS, _
		 IR_OP_TAN, IR_OP_ATAN, IR_OP_SQRT, IR_OP_LOG, IR_OP_FLOOR
		if( dclass <> IR_DATACLASS_FPOINT ) then
			dtype = IR_DATATYPE_DOUBLE
			o = astNewCONV( INVALID, dtype, NULL, o )
		end if
	end select

	'' constant folding
	if( o->defined ) then

		if( op = IR_OP_NEG ) then
			if( astGetDataClass( o ) = IR_DATACLASS_INTEGER ) then
				if( not irIsSigned( dtype ) ) then
					'' test overflow
					select case dtype
					case IR_DATATYPE_UINT
						if( astGetValInt( o ) and &h80000000 ) then
							if( astGetValInt( o ) <> &h80000000 ) then
								hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
							end if
						end if

					case IR_DATATYPE_ULONGINT
						if( astGetValLong( o ) and &h8000000000000000 ) then
							if( astGetValLong( o ) <> &h8000000000000000 ) then
								hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
							end if
						end if

					case else
						if( -astGetValueAsLongint( o ) < minlimitTB( o->dtype ) ) then
							hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
						end if
					end select

					dtype = irGetSignedType( dtype )
				end if
			end if
		end if

		select case as const o->dtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		    hUOPConstFold64( op, o )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			hUOPConstFoldFlt( op, o )
		case else
			'' byte's, short's, int's and enum's
			hUOPConstFoldInt( op, o )
		end select

		o->dtype = dtype

		return o
	end if

	select case as const op
	case IR_OP_SGN
		'' hack! SGN with floats is handled by a function
		if( dclass = IR_DATACLASS_FPOINT ) then
			return rtlMathFSGN( o )
		end if

	case IR_OP_ASIN, IR_OP_ACOS, IR_OP_LOG
		return rtlMathTRANS( op, o )
	end select

	'' alloc new node
	n = hNewNode( AST_NODECLASS_UOP, dtype, o->subtype )
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
private function hLoadUOP( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr o
    dim as integer op
    dim as IRVREG ptr v1, vr

	o  = n->l
	op = n->op

	if( o = NULL ) then
		return NULL
	end if

	v1 = hLoad( o )

	if( ctx.doemit ) then
		if( n->allocres ) then
			vr = irAllocVREG( o->dtype )
		else
			vr = NULL
		end if

		irEmitUOP( op, v1, vr )

		'' "op var" optimizations
		if( vr = NULL ) then
			vr = v1
		end if
	end if

	astDel( o )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' conversions (l = expression to convert; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hCONVConstEvalInt( byval dtype as integer, _
							   byval v as ASTNODE ptr ) static

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	select case as const v->dtype
	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		select case as const dtype
		case IR_DATATYPE_BYTE
			v->val.int = cbyte( v->val.long )

		case IR_DATATYPE_UBYTE
			v->val.int = cubyte( culngint( v->val.long ) )

		case IR_DATATYPE_SHORT
			v->val.int = cshort( v->val.long )

		case IR_DATATYPE_USHORT
			v->val.int = cushort( culngint( v->val.long ) )

		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			v->val.int = cint( v->val.long )

		case IR_DATATYPE_UINT, IR_DATATYPE_POINTER
			v->val.int = cuint( culngint( v->val.long ) )

		end select

	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE

		select case as const dtype
		case IR_DATATYPE_BYTE
			v->val.int = cbyte( v->val.float )

		case IR_DATATYPE_UBYTE
			v->val.int = cubyte( v->val.float )

		case IR_DATATYPE_SHORT
			v->val.int = cshort( v->val.float )

		case IR_DATATYPE_USHORT
			v->val.int = cushort( v->val.float )

		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			v->val.int = cint( v->val.float )

		case IR_DATATYPE_UINT, IR_DATATYPE_POINTER
			v->val.int = cuint( v->val.float )

		end select

	case else
		select case as const dtype
		case IR_DATATYPE_BYTE
			v->val.int = cbyte( v->val.int )

		case IR_DATATYPE_UBYTE
			v->val.int = cubyte( cuint( v->val.int ) )

		case IR_DATATYPE_SHORT
			v->val.int = cshort( v->val.int )

		case IR_DATATYPE_USHORT
			v->val.int = cushort( cuint( v->val.int ) )
		end select

	end select

end sub

'':::::
private sub hCONVConstEvalFlt( byval dtype as integer, _
							   byval v as ASTNODE ptr ) static

	dim as integer vdtype

    vdtype = v->dtype
	if( vdtype > IR_DATATYPE_POINTER ) then
		vdtype = IR_DATATYPE_POINTER
	end if

	select case as const vdtype
	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		'' do nothing..

	case IR_DATATYPE_LONGINT

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->val.float = csng( v->val.long )
		else
			v->val.float = cdbl( v->val.long )
		end if

	case IR_DATATYPE_ULONGINT

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->val.float = csng( cunsg( v->val.long ) )
		else
			v->val.float = cdbl( cunsg( v->val.long ) )
		end if

	case IR_DATATYPE_UINT, IR_DATATYPE_POINTER

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->val.float = csng( cunsg( v->val.int ) )
		else
			v->val.float = cdbl( cunsg( v->val.int ) )
		end if

	case else

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->val.float = csng( v->val.int )
		else
			v->val.float = cdbl( v->val.int )
		end if

	end select

end sub

'':::::
private sub hCONVConstEval64( byval dtype as integer, _
							  byval v as ASTNODE ptr ) static

	select case as const v->dtype
	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		'' do nothing

	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		if( dtype = IR_DATATYPE_LONGINT ) then
			v->val.long = clngint( v->val.float )
		else
			v->val.long = culngint( v->val.float )
		end if

	case else
		'' when expanding to 64bit, we must take care of signedness of source operand

		if( dtype = IR_DATATYPE_LONGINT ) then
			if( irIsSigned( v->dtype ) ) then
				v->val.long = clngint( v->val.int )
			else
				v->val.long = clngint( cuint( v->val.int ) )
			end if
		else
			if( irIsSigned( v->dtype ) ) then
				v->val.long = culngint( v->val.int )
			else
				v->val.long = culngint( cuint( v->val.int ) )
			end if
		end if

	end select

end sub

'':::::
function astNewCONV( byval op as integer, _
					 byval dtype as integer, _
					 byval subtype as FBSYMBOL ptr, _
					 byval l as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer dclass, ldtype

	function = NULL

    if( l = NULL ) then
    	exit function
    end if

    '' pointer typecasting?
    if( op = IR_OP_TOPOINTER ) then

		'' assuming all type-checking was done already

    	l->dtype   = dtype
    	l->subtype = subtype

    	return l
    end if

    ''
    ldtype = l->dtype

    dclass = irGetDataClass( ldtype )

    '' string? can't operate
    if( dclass = IR_DATACLASS_STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( ldtype = IR_DATATYPE_USERDEF ) then
		exit function
    end if

	'' if it's just a sign conversion, change node's sign and create no new node
	if( op <> INVALID ) then

		'' float? invalid
		if( dclass <> IR_DATACLASS_INTEGER ) then
			exit function
		end if

		if( op = IR_OP_TOSIGNED ) then
			l->dtype = irGetSignedType( ldtype )
		else
			l->dtype = irGetUnsignedType( ldtype )
		end if

		return l
	end if

	'' constant? evaluate at compile-time
	if( l->defined ) then

		select case as const dtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			hCONVConstEval64( dtype, l )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			hCONVConstEvalFlt( dtype, l )
		case else
			'' byte's, short's, int's and enum's
			hCONVConstEvalInt( dtype, l )
		end select

		if( dtype <> IR_DATATYPE_ENUM ) then
			l->class = AST_NODECLASS_CONST
		else
			l->class = AST_NODECLASS_ENUM
		end if

		l->dtype   = dtype
		l->subtype = subtype

		return l
	end if

	'' only convert if the classes are different (ie, floating<->integer) or
	'' if sizes are different (ie, byte<->int)
	if( (dclass = irGetDataClass( dtype )) and _
		(irGetDataSize( ldtype ) = irGetDataSize( dtype )) ) then

		l->dtype   = dtype
		l->subtype = subtype

		return l
	end if

	'' handle special cases..
	if( dtype = IR_DATATYPE_ULONGINT ) then
		if( dclass = IR_DATACLASS_FPOINT ) then
			return rtlMathFp2ULongint( l, ldtype )
		end if
	end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_CONV, dtype, subtype )
	if( n = NULL ) then
		exit function
	end if

	n->l  = l

	function = n

end function

'':::::
private function hLoadCONV( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as integer dtype
    dim as IRVREG ptr vs, vr

	l  = n->l

	if( l = NULL ) then
		return NULL
	end if

	vs = hLoad( l )

	dtype = n->dtype

	if( ctx.doemit ) then
		vr = irAllocVREG( dtype )
		irEmitCONVERT( vr, dtype, vs, INVALID )
	end if

	astDel( l )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' constants (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function astNewCONSTs( byval v as string ) as ASTNODE ptr static
    dim as FBSYMBOL ptr tc

	tc = hAllocStringConst( v, len( v ) )
    if( tc = NULL ) then
    	exit function
    end if

	function = astNewVAR( tc, NULL, 0, IR_DATATYPE_FIXSTR )

end function

'':::::
function astNewCONSTi( byval value as integer, _
					   byval dtype as integer, _
					   byval subtype as FBSYMBOL ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_CONST, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->val.int= value
	n->defined = TRUE

end function

'':::::
function astNewCONSTf( byval value as double, _
					   byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->val.float= value
	n->defined = TRUE

end function

'':::::
function astNewCONST64( byval value as longint, _
					    byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->val.long = value
	n->defined   = TRUE

end function

'':::::
function astNewCONST( byval v as FBVALUE ptr, _
					  byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	select case as const dtype
	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		n->val.long = v->long
	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		n->val.float = v->float
	case else
		n->val.int = v->int
	end select

	n->defined = TRUE

end function

'':::::
private function hLoadCONST( byval n as ASTNODE ptr ) as IRVREG ptr static
	dim as integer dtype
	dim as FBSYMBOL ptr s

	if( ctx.doemit ) then
		dtype = n->dtype

		select case dtype
		'' longints?
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			return irAllocVRIMM64( dtype, n->val.long )

		'' if node is a float, create a temp float var (x86 assumption)
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			s = hAllocFloatConst( n->val.float, dtype )
			return irAllocVRVAR( dtype, s, s->ofs )

		''
		case else
			return irAllocVRIMM( dtype, n->val.int )
		end select
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
					byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_VAR, dtype, subtype )
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
	c = hNewNode( INVALID, INVALID )
	astCopy( c, n )

	if( s->var.elm.bitpos > 0 ) then
		n = astNewBOP( IR_OP_SHR, c, _
				   	   astNewCONSTi( s->var.elm.bitpos, IR_DATATYPE_UINT ) )
	else
		n = c
	end if

	n = astNewBOP( IR_OP_AND, n, _
				   astNewCONSTi( bitmaskTB(s->var.elm.bits), IR_DATATYPE_UINT ) )

	function = n

end function

'':::::
private function hLoadVAR( byval n as ASTNODE ptr ) as IRVREG ptr static
    dim as FBSYMBOL ptr s

	'' handle bitfields..
	if( n->chkbitfld ) then
		n->chkbitfld = FALSE
		s = n->var.elm
		if( s <> NULL ) then
			if( s->var.elm.bits > 0 ) then
				n = hGetBitField( n, s )
				function = hLoad( n )
				astDel( n )
				exit function
			end if
		end if
	end if

	s = n->var.sym
	if( s <> NULL ) then
		symbIncAccessCnt( s )
	end if

	if( ctx.doemit ) then
		function = irAllocVRVAR( n->dtype, s, n->var.ofs )
	end if

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
	n = hNewNode( AST_NODECLASS_IDX, dtype, subtype )
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
private function hEmitIDX( byval n as ASTNODE ptr, _
						   byval v as ASTNODE ptr, _
					  	   byval vi as IRVREG ptr ) as IRVREG ptr static
    dim as FBSYMBOL ptr s
    dim as IRVREG ptr vd
    dim as integer ofs

	'' ofs * length + difference (non-base 0 indexes) + offset (UDT's offset)
    s = v->var.sym
    ofs = n->idx.ofs
	if( not symbGetIsDynamic( s ) ) then
		ofs += symbGetArrayDiff( s ) + v->var.ofs
	else
		s = NULL
	end if

    ''
    if( ctx.doemit ) then
		if( vi <> NULL ) then
			vd = irAllocVRIDX( n->dtype, s, ofs, n->idx.mult, vi )

			if( irIsIDX( vi ) or irIsVAR( vi ) ) then
				irEmitLOAD( vi )
			end if
		else
			vd = irAllocVRVAR( n->dtype, s, ofs )
		end if
	end if

	function = vd

end function

'':::::
function hLoadIDX( byval n as ASTNODE ptr ) as IRVREG ptr
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
					function = hLoad( n )
					astDel( n )
					exit function
				end if
			end if
		end if
	end if

	i = n->l
	if( i <> NULL ) then
		vi = hLoad( i )
	else
		vi = NULL
	end if

	if( ctx.doemit ) then
    	vr = hEmitIDX( n, v, vi )
    end if

	astDel( i )
	astDel( v )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' enums (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewENUM( byval value as integer, _
					 byval sym as FBSYMBOL ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_ENUM, IR_DATATYPE_ENUM, sym )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->val.int = value
	n->defined	= TRUE

end function

'':::::
private function hLoadENUM( byval n as ASTNODE ptr ) as IRVREG ptr static

	if( ctx.doemit ) then
		function = irAllocVRIMM( IR_DATATYPE_INTEGER, n->val.int )
	end if

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' addressing operations (l = expression; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewOFFSET( byval l as ASTNODE ptr, _
					   byval sym as FBSYMBOL ptr = NULL, _
					   byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr static
	dim as ASTNODE ptr n

	if( l = NULL ) then
		return NULL
	end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_OFFSET, IR_DATATYPE_POINTER + l->dtype, l->subtype )

	if( n = NULL ) then
		return NULL
	end if

	n->l  		= l
	n->addr.sym	= sym
	n->addr.elm	= elm
	n->chkbitfld= elm <> NULL

	'' access counter must be updated here too
	'' because the var initializers used with static strings
	if( sym <> NULL ) then
		symbIncAccessCnt( sym )
	end if

	function = n

end function

'':::::
private function hLoadOFFSET( byval n as ASTNODE ptr ) as IRVREG ptr static
    dim as ASTNODE ptr v
    dim as IRVREG ptr vr
    dim as FBSYMBOL ptr s

	v = n->l
	if( v = NULL ) then
		return NULL
	end if

	s = v->var.sym
	if( s <> NULL ) then
		symbIncAccessCnt( s )
	end if

	if( ctx.doemit ) then
		vr = irAllocVROFS( n->dtype, s )
	end if

	astDel( v )

	function = vr

end function

'':::::
function astNewADDR( byval op as integer, _
					 byval l as ASTNODE ptr, _
					 byval sym as FBSYMBOL ptr = NULL, _
					 byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer delchild, dtype
    dim as FBSYMBOL ptr subtype

	if( l = NULL ) then
		return NULL
	end if

	dtype    = l->dtype
	subtype  = l->subtype
	delchild = FALSE

	if( op = IR_OP_ADDROF ) then
		select case l->class
		'' convert @* to nothing
		case AST_NODECLASS_ADDR
			if( l->op = IR_OP_DEREF ) then
				delchild = TRUE
				dtype -= IR_DATATYPE_POINTER
			end if

		case AST_NODECLASS_PTR
			'' abs address?
			if( l->l->class = AST_NODECLASS_CONST ) then
				n = l->l
				astDel( l )
				return n
			'' not local or field?
			elseif( l->ptr.ofs = 0 ) then
				delchild = TRUE
			end if

		'' static scalar? use offset instead
		case AST_NODECLASS_VAR
			if( l->var.ofs = 0 ) then
				return astNewOFFSET( l, sym, elm )
			end if
		end select

		''
		if( delchild ) then
			n = l->l
			astDel( l )
			l = n
			op = IR_OP_DEREF
		end if

	'' DEREF
	else
		'' convert *@ to nothing
		select case l->class
		case AST_NODECLASS_ADDR
			if( l->op = IR_OP_ADDROF ) then
				delchild = TRUE
			end if
		case AST_NODECLASS_OFFSET
			delchild = TRUE
		end select

		''
		if( delchild ) then
			n = l->l
			n->dtype   = dtype - IR_DATATYPE_POINTER
			n->subtype = subtype
			astDel( l )
			return n
		end if
	end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_ADDR, IR_DATATYPE_POINTER + dtype, subtype )
	if( n = NULL ) then
		exit function
	end if

	n->op 		= op
	n->l  		= l
	n->addr.sym	= sym
	n->addr.elm	= elm
	n->chkbitfld= elm <> NULL

	function = n

end function

'':::::
private function hLoadADDR( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr p
    dim as IRVREG ptr v1, vr

	p  = n->l
	if( p = NULL ) then
		return NULL
	end if

	v1 = hLoad( p )

	if( ctx.doemit ) then
		'' src is not a reg?
		if( (not irIsREG( v1 )) or _
			(irGetVRDataClass( v1 ) <> IR_DATACLASS_INTEGER) or _
			(irGetVRDataSize( v1 ) <> FB_POINTERSIZE) ) then

			vr = irAllocVREG( IR_DATATYPE_POINTER )
			irEmitADDR( n->op, v1, vr )

		else
			vr = v1
		end if
	end if

	astDel( p )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' pointers (l = pointer expression; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewPTR( byval sym as FBSYMBOL ptr, _
					byval elm as FBSYMBOL ptr, _
					byval ofs as integer, _
					byval l as ASTNODE ptr, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr ) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer delchild

	'' alloc new node
	n = hNewNode( AST_NODECLASS_PTR, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	if( l <> NULL ) then
		delchild = FALSE

		'' convert *@ to nothing
		select case l->class
		case AST_NODECLASS_ADDR
			if( l->op = IR_OP_ADDROF ) then
				delchild = TRUE
			end if
		case AST_NODECLASS_OFFSET
			delchild = TRUE
		end select

		''
		if( delchild ) then
			n = l->l
			n->dtype   = dtype
			n->subtype = subtype
			astDel( l )
			return n
		end if
	end if

	n->l   		= l
	n->ptr.sym	= sym
	n->ptr.elm	= elm
	n->ptr.ofs	= ofs
	n->chkbitfld= elm <> NULL

end function

'':::::
private function hLoadPTR( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as integer dtype
    dim as IRVREG ptr v1, vp, vr
    dim as FBSYMBOL ptr s

	l = n->l
	'' no index? can happen with absolute addresses + ptr typecasting
	if( l = NULL ) then
		if( ctx.doemit ) then
			vr = irAllocVRPTR( n->dtype, n->ptr.ofs, NULL )
		end if
		return vr
	end if

	'' handle bitfields..
	if( n->chkbitfld ) then
		n->chkbitfld = FALSE
		s = n->ptr.elm
		if( s <> NULL ) then
			if( s->var.elm.bits > 0 ) then
				n = hGetBitField( n, s )
				function = hLoad( n )
				astDel( n )
				exit function
			end if
		end if
	end if

	v1 = hLoad( l )

	''
	dtype = n->dtype

	if( ctx.doemit ) then
		'' src is not a reg?
		if( (not irIsREG( v1 )) or _
			(irGetVRDataClass( v1 ) <> IR_DATACLASS_INTEGER) or _
			(irGetVRDataSize( v1 ) <> FB_POINTERSIZE) ) then

			vp = irAllocVREG( IR_DATATYPE_POINTER )
			irEmitADDR( IR_OP_DEREF, v1, vp )
		else
			vp = v1
		end if

		vr = irAllocVRPTR( dtype, n->ptr.ofs, vp )
	end if

	astDel( l )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' loading (l = expression to load to a register; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLOAD( byval l as ASTNODE ptr, _
					 byval dtype as integer, _
					 byval isresult as integer ) as ASTNODE ptr static
    dim n as ASTNODE ptr

	'' alloc new node
	n = hNewNode( AST_NODECLASS_LOAD, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l  = l
	n->lod.isres = isresult

end function

'':::::
private function hLoadLOAD( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as IRVREG ptr v1, vr

	l = n->l
	if( l = NULL ) then
		return NULL
	end if

	v1 = hLoad( l )

	if( ctx.doemit ) then
		if( n->lod.isres ) then
			vr = irAllocVREG( irGetVRDataType( v1 ) )
			irEmitLOADRES( v1, vr )
		else
			irEmitLOAD( v1 )
		end if
	end if

	astDel( l )

	function = v1

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' assignaments (l = destine; r = source)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hCheckConst( byval dtype as integer, _
					   		  byval n as ASTNODE ptr ) as ASTNODE ptr static

	dim as longint lval
	dim as ulongint ulval
	dim as double dval, dmin, dmax

	'' x86 assumptions

    select case as const dtype
    case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE

		if( dtype = IR_DATATYPE_SINGLE ) then
			dmin = 1.175494351e-38
			dmax = 3.402823466e+38
		else
			dmin = 2.2250738585072014e-308
			dmax = 1.7976931348623147e+308
		end if

		dval = abs( astGetValueAsDouble( n ) )
    	if( dval <> 0 ) then
    		if( (dval < dmin) or (dval > dmax) ) then
    			hReportError( FB_ERRMSG_MATHOVERFLOW, TRUE )
    			return NULL
			end if
		end if

	case IR_DATATYPE_LONGINT

		'' unsigned constant?
		if( not irIsSigned( astGetDataType( n ) ) ) then
			'' too big?
			if( astGetValueAsULongInt( n ) > 9223372036854775807ULL ) then
				n = astNewCONV( INVALID, dtype, NULL, n )
				hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
			end if
		end if

	case IR_DATATYPE_ULONGINT

		'' signed constant?
		if( irIsSigned( astGetDataType( n ) ) ) then
			'' too big?
			if( astGetValueAsLongInt( n ) and &h8000000000000000 ) then
				n = astNewCONV( INVALID, dtype, NULL, n )
				hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
			end if
		end if

    case IR_DATATYPE_BYTE, IR_DATATYPE_CHAR, IR_DATATYPE_SHORT, _
    	 IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM

		lval = astGetValueAsLongInt( n )
		if( (lval < minlimitTB( dtype )) or _
			(lval > maxlimitTB( dtype )) ) then
			n = astNewCONV( INVALID, dtype, NULL, n )
			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
		end if

    case IR_DATATYPE_UBYTE, IR_DATATYPE_USHORT, IR_DATATYPE_UINT

		ulval = astGetValueAsULongInt( n )
		if( (ulval < culngint( minlimitTB( dtype ) )) or _
			(ulval > culngint( maxlimitTB( dtype ) )) ) then
			n = astNewCONV( INVALID, dtype, NULL, n )
			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
		end if
	end select

	function = n

end function

'':::::
function astNewASSIGN( byval l as ASTNODE ptr, _
					   byval r as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer dtype
    dim as integer ldtype, rdtype
    dim as integer ldclass, rdclass
    dim as FBSYMBOL ptr proc

	function = NULL

	ldtype = l->dtype
	rdtype = r->dtype
	ldclass = irGetDataClass( ldtype )
	rdclass = irGetDataClass( rdtype )

    '' strings?
    if( (ldclass = IR_DATACLASS_STRING) or (rdclass = IR_DATACLASS_STRING) ) then

		'' both not the same?
		if( ldclass <> rdclass ) then
			'' check if it's not a byte ptr
			if( ldclass = IR_DATACLASS_STRING ) then
				'' not a zstring?
				if( rdtype <> IR_DATATYPE_CHAR ) then
					if( r->class <> AST_NODECLASS_PTR ) then
						exit function
					elseif( rdtype <> IR_DATATYPE_BYTE ) then
						if( rdtype <> IR_DATATYPE_UBYTE ) then
							exit function
						end if
					end if
				end if
			else
				'' not a zstring?
				if( ldtype <> IR_DATATYPE_CHAR ) then
					if( l->class <> AST_NODECLASS_PTR ) then
						exit function
					elseif( ldtype <> IR_DATATYPE_BYTE ) then
						if( ldtype <> IR_DATATYPE_UBYTE ) then
							exit function
						end if
					end if
				end if
			end if

			return rtlStrAssign( l, r )

		end if

	'' UDT's?
	elseif( (ldtype = IR_DATATYPE_USERDEF) or (rdtype = IR_DATATYPE_USERDEF) ) then

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
            proc = r->proc.sym
            if( proc->typ <> IR_DATATYPE_USERDEF ) then
            	exit function
            end if

            '' fake l's type
            ldtype = proc->proc.realtype
            l->dtype = ldtype

		'' both are UDT's, do a mem copy..
		else
			return astNewMEM( IR_OP_MEMMOVE, l, r, symbGetUDTLen( l->subtype ) )
		end if

    '' zstrings?
    elseif( (ldtype = IR_DATATYPE_CHAR) or (rdtype = IR_DATATYPE_CHAR) ) then

		'' both not the same? assign as string..
		if( ldtype = rdtype ) then
			return rtlStrAssign( l, r )
		end if

		'' one is not a string, nor a udt, treat as numeric type, let emit
		'' convert them if needed..

    '' enums?
    elseif( (ldtype = IR_DATATYPE_ENUM) or (rdtype = IR_DATATYPE_ENUM) ) then

    	'' not the same?
    	if( ldtype <> rdtype ) then
    		if( (ldclass <> IR_DATACLASS_INTEGER) or _
    			(rdclass <> IR_DATACLASS_INTEGER) ) then
    			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
    		end if
    	end if

	end if

	'' convert types if needed
	if( ldtype <> rdtype ) then
		'' don't convert strings
		if( rdclass <> IR_DATACLASS_STRING ) then
			'' constant?
			if( r->defined ) then
				r = hCheckConst( l->dtype, r )
			else
				'' x86 assumption: let the fpu do the convertion if any operand is a float
				if( (ldclass <> IR_DATACLASS_FPOINT) and _
					(rdclass <> IR_DATACLASS_FPOINT) ) then
					r = astNewCONV( INVALID, ldtype, l->subtype, r )
				end if
			end if

			if( r = NULL ) then
				exit function
			end if
		end if
	end if

    '' check pointers
    if( ldtype >= IR_DATATYPE_POINTER ) then
    	'' function ptr?
    	if( ldtype = IR_DATATYPE_POINTER + IR_DATATYPE_FUNCTION ) then
    		if( not astFuncPtrCheck( ldtype, l->subtype, r ) ) then
   				hReportWarning( FB_WARNINGMSG_SUSPICIOUSPTRASSIGN )
    		end if
    	'' ordinary ptr..
    	else
			if( not astPtrCheck( ldtype, l->subtype, r ) ) then
				hReportWarning( FB_WARNINGMSG_SUSPICIOUSPTRASSIGN )
			end if
		end if

    '' r-side expr is a ptr?
    elseif( rdtype >= IR_DATATYPE_POINTER ) then
    	hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
    end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_ASSIGN, ldtype )

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

	l = astNewBOP( IR_OP_AND, astCloneTree( l ), _
				   astNewCONSTi( not (bitmaskTB(s->var.elm.bits) shl s->var.elm.bitpos), _
				   				 IR_DATATYPE_UINT ) )

	if( s->var.elm.bitpos > 0 ) then
		r = astNewBOP( IR_OP_SHL, r, _
				   	   astNewCONSTi( s->var.elm.bitpos, IR_DATATYPE_UINT ) )
	end if

	function = astNewBOP( IR_OP_OR, l, r )

end function

'':::::
private function hLoadASSIGN( byval n as ASTNODE ptr ) as IRVREG ptr
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
		s = astGetElm( l )
		if( s <> NULL ) then
			if( s->var.elm.bits > 0 ) then
				r = hSetBitField( l, r, s )
			end if
		end if
	end if

	vs = hLoad( r )
	vr = hLoad( l )

	if( ctx.doemit ) then
		irEmitSTORE( vr, vs )
	end if

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
	n = hNewNode( AST_NODECLASS_BRANCH, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l  = l
	n->ex = label
	n->op = op

end function

'':::::
private function hLoadBRANCH( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as IRVREG ptr vr

	l  = n->l

	if( l <> NULL ) then
		vr = hLoad( l )
		astDel( l )
	else
		vr = NULL
	end if

	if( ctx.doemit ) then
		'' pointer?
		if( n->ex = NULL ) then
			'' jump or call?
			select case n->op
			case IR_OP_JUMPPTR
				irEmitJUMPPTR( vr )

			case IR_OP_CALLPTR
				irEmitCALLPTR( vr, NULL, 0 )

			case IR_OP_RET
				irEmitRETURN( 0 )
			end select

		else
			irEmitBRANCH( n->op, n->ex )
		end if
	end if

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' functions (l = pointer node if any; r = first param to be pushed)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewFUNCT( byval sym as FBSYMBOL ptr, _
					  byval ptrexpr as ASTNODE ptr = NULL, _
					  byval isprofiler as integer = FALSE ) as ASTNODE ptr
    dim as ASTNODE ptr n
    dim as FBRTLCALLBACK callback
    dim as integer dtype
    dim as FBSYMBOL ptr subtype

	'' if return type is an UDT, change to the real one
	if( sym <> NULL ) then
		dtype   = symbGetType( sym )
		subtype = symbGetSubType( sym )
		if( dtype = FB_SYMBTYPE_USERDEF ) then
			'' only if it's not a pointer, but a reg (integer or fpoint)
			if( sym->proc.realtype < FB_SYMBTYPE_POINTER ) then
				dtype   = sym->proc.realtype
				subtype = NULL
			end if
		end if

		''
		symbSetProcIsCalled( sym, TRUE )

	else
		if( ptrexpr = NULL ) then
			return NULL
		end if
		dtype   = ptrexpr->dtype
		subtype = ptrexpr->subtype
	end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_FUNCT, dtype, subtype )
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
	n->proc.profbegin = NULL
	n->proc.profend   = NULL
	if( env.clopt.profile ) then
		if( not isprofiler ) then
			n->proc.profbegin = rtlProfileBeginCall( sym )
			if( n->proc.profbegin <> NULL ) then
				n->proc.profend   = rtlProfileEndCall( )
			end if
		end if
	end if

end function


'':::::
private function hReportMakeDesc( byval f as ASTNODE ptr ) as zstring ptr
    static as zstring * FB_MAXINTNAMELEN+32+1 desc

	desc = "at parameter " + str( f->proc.params+1 )
	if( f->proc.sym <> NULL ) then
		desc += " of "
		if( len( symbGetOrgName( f->proc.sym ) ) > 0 ) then
			desc += symbGetOrgName( f->proc.sym )
		else
			desc += symbGetName( f->proc.sym )
		end if
		desc += "()"
	end if

	function = @desc

end function

'':::::
private sub hReportParamError( byval f as ASTNODE ptr, _
							   byval msgnum as integer = FB_ERRMSG_PARAMTYPEMISMATCHAT )

	hReportErrorEx( msgnum, *hReportMakeDesc( f ) )

end sub

'':::::
private sub hReportParamWarning( byval f as ASTNODE ptr, _
								 byval msgnum as integer )

	hReportWarning( msgnum, *hReportMakeDesc( f ) )

end sub

'':::::
private function hAllocTmpArrayDesc( byval f as ASTNODE ptr, _
									 byval n as ASTNODE ptr ) as ASTNODE ptr
	dim s as FBSYMBOL ptr
	dim t as ASTTEMPARRAY ptr

	'' alloc a node
	t = listNewNode( @ctx.temparray )
	t->prev = f->proc.arraytail
	f->proc.arraytail = t

	'' create a pointer
	s = symbAddTempVar( FB_SYMBTYPE_UINT )

	t->pdesc = s

	''
	return rtlArrayAllocTmpDesc( n, s )

end function

'':::::
private function hAllocTmpString( byval f as ASTNODE ptr, _
								  byval n as ASTNODE ptr, _
								  byval copyback as integer ) as ASTNODE ptr
	dim as FBSYMBOL ptr s
	dim as ASTTEMPSTR ptr t

	'' alloc a node
	t = listNewNode( @ctx.tempstr )
	t->prev = f->proc.strtail
	f->proc.strtail = t

	'' create temp string to pass as paramenter
	s = symbAddTempVar( FB_SYMBTYPE_STRING )

	t->tmpsym = s
	if( copyback ) then
		t->srctree = astCloneTree( n )
	else
		t->srctree = NULL
	end if

	'' temp string = src string
	return rtlStrAssign( astNewVAR( s, NULL, 0, IR_DATATYPE_STRING ), n )

end function

'':::::
private function hCheckStringArg( byval f as ASTNODE ptr, _
							      byval arg as FBSYMBOL ptr, _
							      byval p as ASTNODE ptr ) as ASTNODE ptr

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
		if( amode = FB_ARGMODE_BYREF ) then

			'' var-len param: all rtlib procs will delete temps automatically
			if( pdtype = IR_DATATYPE_STRING ) then
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
			if( pclass <> AST_NODECLASS_FUNCT ) then
				exit function
			end if

			'' only if var-len
			if( pdtype <> IR_DATATYPE_STRING ) then
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
	case FB_ARGMODE_BYREF

    	'' fixed-length?
    	select case pdtype
    	case IR_DATATYPE_FIXSTR
    		'' byref arg and fixed-len param: alloc a temp string, copy
    		'' fixed to temp and pass temp
			'' (ast will have to copy temp back to fixed when function
			'' returns and delete temp)

			'' don't copy back if it's a function returning a fixed-len
			if( pclass <> AST_NODECLASS_FUNCT ) then
				copyback = TRUE
			end if

    	'' var-len param..
    	case IR_DATATYPE_STRING
    		'' if not a function's result, skip..
    		if( pclass <> AST_NODECLASS_FUNCT ) then
    			exit function
            end if

    	'' byte/zstring/ptr param..
    	case else
    		'' byref arg and byte/zstring/ptr param: alloc a temp string,
    		'' copy byte ptr to temp and pass temp

    	end select

    '' by value arg?
    case FB_ARGMODE_BYVAL

		'' skip, unless it's a temp var-len (return by functions), that
		'' must be deleted when the called proc returns
		if( pclass <> AST_NODECLASS_FUNCT ) then
			exit function
		end if

		'' only if var-len
		if( pdtype <> IR_DATATYPE_STRING ) then
			exit function
		end if

	end select

	'' create temp string to pass as paramenter
	function = hAllocTmpString( f, p, copyback )

end function

'':::::
private function hStrParamToPtrArg( byval f as ASTNODE ptr, _
									byval n as ASTNODE ptr, _
					   				byval pclass as integer, _
					   				byval pdtype as integer, _
					   				byval pdclass as integer, _
					   				byval checkrtl as integer = FALSE ) as integer

	if( not checkrtl ) then
		'' rtl? don't mess..
		if( f->proc.isrtl ) then
			return TRUE
		end if
	end if

	''
	if( pdclass = IR_DATACLASS_STRING ) then

		'' if it's a function returning a STRING, it will have to be
		'' deleted automagically when the proc been called return
		if( pclass = AST_NODECLASS_FUNCT ) then
			'' create a temp string to pass as paramenter (no copy is
			'' done at rtlib, as the returned string is a temp too)
			n->l = hAllocTmpString( f, n->l, FALSE )
			pdtype = IR_DATATYPE_STRING
        end if

		'' not fixed-len? deref var-len (ptr at offset 0)
		if( pdtype <> IR_DATATYPE_FIXSTR ) then
    		n->l = astNewCONV( IR_OP_TOPOINTER, _
    						   IR_DATATYPE_POINTER + IR_DATATYPE_CHAR, _
    						   NULL, _
    						   astNewADDR( IR_OP_DEREF, n->l ) )

        '' fixed-len..
        else
            '' get the address of
        	if( pclass <> AST_NODECLASS_PTR ) then
				n->l = astNewCONV( IR_OP_TOPOINTER, _
    						   	   IR_DATATYPE_POINTER + IR_DATATYPE_CHAR, _
    						   	   NULL, _
							   	   astNewADDR( IR_OP_ADDROF, n->l ) )
			end if
		end if

		n->dtype = n->l->dtype

	else
    	'' zstring? take the address of
    	if( pdtype = IR_DATATYPE_CHAR ) then
			n->l = astNewADDR( IR_OP_ADDROF, n->l )
			n->dtype = n->l->dtype
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
	s = astGetSymbolOrElm( p )

	if( s = NULL ) then
		hReportParamError( f )
		return FALSE
	end if

	'' same type? (don't check if it's a rtl proc)
	if( not f->proc.isrtl ) then
		if( (adclass <> irGetDataClass( s->typ ) ) or _
			(irGetDataSize( adtype ) <> irGetDataSize( s->typ )) ) then
			hReportParamError( f )
			return FALSE
		end if
	end if

	if( s->class = FB_SYMBCLASS_UDTELM ) then
		'' not an array?
		if( symbGetArrayDimensions( s ) = 0 ) then
			hReportParamError( f )
			return FALSE
		end if

		'' address of?
		if( astIsADDR( p ) ) then
			hReportParamError( f )
			return FALSE
		end if

		'' create a temp array descriptor
		n->l     = hAllocTmpArrayDesc( f, p )
		n->dtype = IR_DATATYPE_POINTER + IR_DATATYPE_VOID

	else

		'' an argument passed by descriptor?
		if( symbIsArgByDesc( s ) ) then
        	'' it's a pointer, but could be seen as anything else
        	'' (ie: if it were "s() as string"), so, create an alias
        	n->l     = astNewVAR( s, NULL, 0, IR_DATATYPE_UINT )
        	n->dtype = IR_DATATYPE_POINTER + IR_DATATYPE_VOID

    	else
			'' not an array?
			d = s->var.array.desc
			if( d = NULL ) then
				hReportParamError( f )
				return FALSE
			end if

        	''
        	n->l     = astNewADDR( IR_OP_ADDROF, astNewVAR( d, NULL, 0, IR_DATATYPE_UINT ) )
        	n->dtype = IR_DATATYPE_POINTER + IR_DATATYPE_VOID

    	end if

    end if

    function = TRUE

end function

'':::::
private function hCheckParam( byval f as ASTNODE ptr, _
							  byval n as ASTNODE ptr ) as integer

    dim as FBSYMBOL ptr proc, arg, s
    dim as integer adtype, adclass, amode, iswarning
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
	if( amode = FB_ARGMODE_BYDESC ) then

        '' param is not an pointer
        if( pmode <> FB_ARGMODE_BYVAL ) then

        	return hCheckArrayParam( f, n, adtype, adclass )

        end if

    '' vararg?
    elseif( amode = FB_ARGMODE_VARARG ) then

		'' string? check..
		if( (pdclass = IR_DATACLASS_STRING) or _
			(pdtype = IR_DATATYPE_CHAR) ) then
			return hStrParamToPtrArg( f, n, pclass, pdtype, pdclass )

		'' float? follow C ABI and convert it to double
		elseif( pdtype = IR_DATATYPE_SINGLE ) then

			p = astNewCONV( INVALID, IR_DATATYPE_DOUBLE, NULL, p )
			if( p = NULL ) then
				return FALSE
			end if

			n->dtype = p->dtype
			n->l     = p

			return TRUE
		end if

	'' as any?
    elseif( adtype = IR_DATATYPE_VOID ) then

		if( pmode = FB_ARGMODE_BYVAL ) then

			'' another quirk: BYVAL strings passed to BYREF ANY args..
			return hStrParamToPtrArg( f, n, pclass, pdtype, pdclass )

		end if

    '' byval or byref (but as any)
    else

    	'' string argument?
    	if( adclass = IR_DATACLASS_STRING ) then

			'' if it's a function returning a STRING, it's actually a pointer
			if( pclass = AST_NODECLASS_FUNCT ) then
				if( pdtype = FB_SYMBTYPE_STRING ) then
					pclass = AST_NODECLASS_PTR
				end if
			end if

			'' param not an string?
			if( pdclass <> IR_DATACLASS_STRING ) then
				'' not a zstring?
				if( pdtype <> IR_DATATYPE_CHAR ) then
					'' check if not a byte ptr
					if( (pclass <> AST_NODECLASS_PTR) or _
						((pdtype <> IR_DATATYPE_BYTE) and (pdtype <> IR_DATATYPE_UBYTE)) ) then

						'' or if passing a ptr as byval to a byval string arg
			    		if( (pdclass <> IR_DATACLASS_INTEGER) or _
			    			(amode <> FB_ARGMODE_BYVAL) or _
			    			(irGetDataSize( pdtype ) <> FB_POINTERSIZE) ) then
							hReportParamError( f )
							exit function
			    		end if

			    		'' the BYVAL modifier was not used?
			    		if( pmode <> FB_ARGMODE_BYVAL ) then
							'' const? only accept if it's NULL
			    			if( p->defined ) then
			    				if( p->val.int <> NULL ) then
									hReportParamError( f )
									exit function
			    				end if

			    			'' not a pointer?
			    			elseif( pdtype < IR_DATATYPE_POINTER ) then
								hReportParamError( f )
								exit function

			    			'' not a pointer to a zstring?
			    			else
								if( not astPtrCheck( IR_DATATYPE_POINTER + IR_DATATYPE_CHAR, _
													 NULL, p ) ) then
				        			hReportParamWarning( f, FB_WARNINGMSG_PASSINGDIFFPOINTERS )
				    			end if

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
				pdtype  = IR_DATATYPE_STRING
				pdclass = IR_DATACLASS_STRING
				pclass	= AST_NODECLASS_PTR

				n->l     = p
				n->dtype = pdtype
			end if

			''
			if( amode = FB_ARGMODE_BYVAL ) then
				'' deref var-len (ptr at offset 0)
				if( pdtype = IR_DATATYPE_STRING ) then
					pdclass = IR_DATACLASS_INTEGER
					pdtype  = IR_DATATYPE_POINTER + IR_DATATYPE_CHAR
					n->l     = astNewADDR( IR_OP_DEREF, p )
					n->dtype = pdtype
				end if
			end if

			'' not a pointer yet?
			if( pclass <> AST_NODECLASS_PTR ) then
				'' descriptor or fixed-len? get the address of
				if( (pdclass = IR_DATACLASS_STRING) or (pdtype = IR_DATATYPE_CHAR) ) then
					n->l     = astNewADDR( IR_OP_ADDROF, p )
					n->dtype = IR_DATATYPE_POINTER + IR_DATATYPE_CHAR
				end if
			end if


		'' anything but strings..
		else
	        '' passing a BYVAL ptr to an BYREF arg?
			if( (pmode = FB_ARGMODE_BYVAL) and (amode = FB_ARGMODE_BYREF) ) then
				if( (pdclass <> IR_DATACLASS_INTEGER) or _
					(irGetDataSize( pdtype ) <> FB_POINTERSIZE) ) then
					hReportParamError( f )
					exit function
				end if

			'' UDT arg? check if the same, can't convert
			elseif( adtype = IR_DATATYPE_USERDEF ) then
				'' not another UDT?
				if( pdtype <> IR_DATATYPE_USERDEF ) then
					'' not a proc? (can be an UDT been returned in registers)
					if( pclass <> AST_NODECLASS_FUNCT ) then
						hReportParamError( f )
						exit function
					end if

					'' it's a proc, but was it originally returning an UDT?
					s = p->proc.sym
					if( s->typ <> FB_SYMBTYPE_USERDEF ) then
						hReportParamError( f )
						exit function
					end if

					'' byref argument? can't create a tempory UDT..
					if( amode = FB_ARGMODE_BYREF ) then
						hReportParamError( f, FB_ERRMSG_CANTPASSUDTRESULTBYREF )
						exit function
					end if

					'' set type..
					n->dtype = pdtype
					s = s->subtype

				else
					if( pclass <> AST_NODECLASS_FUNCT ) then
						s = p->subtype
					else
						s = p->proc.sym->subtype
					end if
				end if

                '' check for invalid UDT's (different subtypes)
				if( symbGetSubtype( arg ) <> s ) then
					hReportParamError( f )
					exit function
				end if

				'' set the length if it's been passed by value
				if( amode = FB_ARGMODE_BYVAL ) then
					if( pdtype = IR_DATATYPE_USERDEF ) then
						n->param.lgt = symbGetUDTLen( s )
					end if
				end if

			''
			else
				'' can't convert UDT's to other types
				if( pdtype = IR_DATATYPE_USERDEF ) then
					hReportParamError( f )
					exit function
				end if

				'' string param? handle z- and w-string ptr arguments
				select case pdtype
				case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR
					'' arg not a zstring ptr?
					if( adtype <> IR_DATATYPE_POINTER + IR_DATATYPE_CHAR ) then
						hReportParamError( f )
						exit function
					end if

					hStrParamToPtrArg( f, n, pclass, pdtype, pdclass, TRUE )
					p 		= n->l
					pdtype  = p->dtype
					pdclass = irGetDataClass( pdtype )
				end select

				'' different types? convert..
				if( (adclass <> pdclass) or _
					(irGetDataSize( adtype ) <> irGetDataSize( pdtype )) ) then

					'' enum args are only allowed to be passed enum or int params
					if( (adtype = IR_DATATYPE_ENUM) or _
						(pdtype = IR_DATATYPE_ENUM) ) then
						if( adclass <> pdclass ) then
							hReportParamWarning( f, FB_WARNINGMSG_IMPLICITCONVERSION )
						end if
					end if

					if( amode = FB_ARGMODE_BYREF ) then
						'' param diff than arg can't passed by ref if it's a var/array/ptr
						select case as const pclass
						case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR
							hReportParamError( f )
							exit function
						end select
					end if

					'' const?
					if( p->defined ) then
						p = hCheckConst( adtype, p )
						if( p = NULL ) then
							exit function
						end if
					end if

					p = astNewCONV( INVALID, adtype, symbGetSubtype( arg ), p )
					n->dtype = p->dtype
					n->l     = p

				end if

				'' pointer checking
				if( adtype >= IR_DATATYPE_POINTER ) then
    				iswarning = FALSE
    				if( adtype = IR_DATATYPE_POINTER + IR_DATATYPE_FUNCTION ) then
    					if( not astFuncPtrCheck( adtype, symbGetSubtype( arg ), p ) ) then
				        	iswarning = TRUE
				    	end if
					else
						if( not astPtrCheck( adtype, symbGetSubtype( arg ), p ) ) then
				        	iswarning = TRUE
				    	end if
					end if

					if( iswarning ) then
						if( p->dtype < IR_DATATYPE_POINTER ) then
							hReportParamWarning( f, FB_WARNINGMSG_PASSINGSCALARASPTR )
						else
							hReportParamWarning( f, FB_WARNINGMSG_PASSINGDIFFPOINTERS )
						end if
					end if

    			'''''elseif( p->dtype >= IR_DATATYPE_POINTER ) then
    			'''''	hReportParamWarning( f, FB_WARNINGMSG_IMPLICITCONVERSION )
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
	n = hNewNode( AST_NODECLASS_PARAM, dtype )
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
	if( proc->proc.mode = FB_FUNCMODE_PASCAL ) then
		if( t = NULL ) then
			f->r = n
		else
			t = f->proc.lastparam
			t->r = n
		end if

		f->proc.lastparam = n
		n->r = NULL

	else
		'' non-pascal, the latest param added will be the first pushed
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
		f->proc.arg = symbGetArgNext( f->proc.arg )
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
		vr = hLoad( p )
		astDel( p )
		if( ctx.doemit ) then
			irEmitCALLPTR( vr, NULL, 0 )
		end if

		return NULL
	end if

	dtype = n->dtype

	'' function returns as string? it's actually a pointer to a string descriptor..
	'' same with UDT's..
	select case dtype
	case IR_DATATYPE_STRING, IR_DATATYPE_USERDEF
		dtype += IR_DATATYPE_POINTER
	end select

	if( ctx.doemit ) then
		vreg = NULL
		if( dtype <> IR_DATATYPE_VOID ) then
			vreg = irAllocVREG( dtype )
		end if
	end if

	if( mode <> FB_FUNCMODE_CDECL ) then
		if( mode = FB_FUNCMODE_STDCALL ) then
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
		if( ctx.doemit ) then
			irEmitCALLFUNCT( proc, bytestopop, vreg )
		end if
	else
		vr = hLoad( p )
		astDel( p )
		if( ctx.doemit ) then
			irEmitCALLPTR( vr, vreg, bytestopop )
		end if
	end if

	if( bytesaligned > 0 ) then
		if( ctx.doemit ) then
			irEmitSTACKALIGN( -bytesaligned )
		end if
	end if

	if( ctx.doemit ) then
		'' handle strings and UDT's returned by functions that are actually pointers to
		'' string descriptors or the hidden pointer passed as the 1st argument
		select case n->dtype
		case IR_DATATYPE_STRING, IR_DATATYPE_USERDEF
			vreg = irAllocVRPTR( n->dtype, 0, vreg )
		end select
	end if

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
        	if( n->srctree->class = AST_NODECLASS_VAR ) then
        	    s = astGetSymbolOrElm( n->srctree )
        	    copyback = symbGetVarInitialized( s ) = FALSE
        	end if

        	if( copyback ) then
				t = rtlStrAssign( n->srctree, astNewVAR( n->tmpsym, NULL, 0, IR_DATATYPE_STRING ) )
				hLoad( t )
				astDel( t )
			end if
		end if

		'' delete the temp string
		t = rtlStrDelete( astNewVAR( n->tmpsym, NULL, 0, IR_DATATYPE_STRING ) )
		hLoad( t )
		astDel( t )

		p = n->prev
		listDelNode( @ctx.tempstr, cptr( TLISTNODE ptr, n ) )
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
			hLoad( t )
			astDel( t )
		end if

		p = n->prev
		listDelNode( @ctx.temparray, cptr( TLISTNODE ptr, n ) )
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
	if( proc->typ = FB_SYMBTYPE_USERDEF ) then
		if( proc->proc.realtype = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_USERDEF ) then
			'' create a temp struct and pass its address
			v = symbAddTempVar( FB_SYMBTYPE_USERDEF, proc->subtype )
        	p = astNewVar( v, NULL, 0, IR_DATATYPE_USERDEF, proc->subtype )
        	vr = hLoad( p )

        	a.typ = IR_DATATYPE_VOID
        	a.arg.mode = FB_ARGMODE_BYREF
        	if( ctx.doemit ) then
        		irEmitPUSHPARAM( proc, @a, vr, INVALID, FB_POINTERSIZE )
        	end if
		end if
	end if

end sub

'':::::
private function hLoadFUNCT( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr p, np, l, pstart, pend
    dim as FBSYMBOL ptr proc, arg, lastarg
    dim as integer mode, bytestopop, toalign
    dim as integer params, inc
    dim as integer args
    dim as IRVREG ptr vr, pcvr

	''
	proc = n->proc.sym

    ''
	pstart = n->proc.profbegin
	pend   = n->proc.profend

	'' ordinary pointer?
	if( proc = NULL ) then

		'' signal function start for profiling
		if( pstart <> NULL ) then
			pcvr = hLoad( pstart )
			astDel( pstart )
		end if

		vr = hCallProc( n, NULL, INVALID, 0, 0 )

		'' signal function end for profiling
		if( pend <> NULL ) then
			if( ctx.doemit ) then
				irEmitPUSH( pcvr )
			end if
			proc = pend->proc.sym
			hCallProc( pend, proc, proc->proc.mode, 0, 0 )
			astDel( pend )
		end if

		return vr
	end if

    ''
    mode = proc->proc.mode
	if( mode = FB_FUNCMODE_PASCAL ) then
		params = 0
		inc = 1
	else
		params = n->proc.params
		inc = -1
	end if

	bytestopop = proc->lgt
	toalign = 0

	''
	args 	= symbGetProcArgs( proc )
	lastarg = symbGetProcTailArg( proc )
	if( params <= args ) then
		arg = symbGetProcFirstArg( proc )
		'' vararg and param not passed?
		if( params < args ) then
			if( mode <> FB_FUNCMODE_PASCAL ) then
				arg = symbGetProcNextArg( proc, arg )
			end if

		else
#ifdef DO_STACK_ALIGN
			toalign = ((FB_INTEGERSIZE*4) - _
					  (bytestopop and (FB_INTEGERSIZE*4-1))) and (FB_INTEGERSIZE*4-1)
			if( toalign > 0 ) then
				if( ctx.doemit ) then
					irEmitSTACKALIGN( toalign )
				end if
			end if
#endif
		end if
	'' vararg
	else
		arg = lastarg
	end if

	'' for each param..
	p = n->r
	do while( p <> NULL )
		np = p->r

		l = p->l

		''
		if( arg = lastarg ) then
			if( symbGetArgMode( proc, arg ) = FB_ARGMODE_VARARG ) then
				bytestopop += (symbCalcLen( l->dtype, NULL ) + _
					 		  (FB_INTEGERSIZE-1)) and _
					 		  not (FB_INTEGERSIZE-1) 		'' x86 assumption!
			end if
		end if

		'' flush the param expression
		vr = hLoad( l )
		astDel( l )

		if( ctx.doemit ) then
			if( not irEmitPUSHPARAM( proc, arg, vr, p->param.mode, p->param.lgt ) ) then
				'''''return NULL
			end if
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
		pcvr = hLoad( pstart )
		astDel( pstart )
	end if

	'' return the result (same type as function ones)
	vr = hCallProc( n, proc, mode, bytestopop, toalign )

	'' signal function end for profiling
	if( pend <> NULL ) then
		if( ctx.doemit ) then
			irEmitPUSH( pcvr )
		end if
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
'' IIF (l = cond expr, r = link(true expr, false expr))
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
    if( irGetDataClass( truedtype ) = IR_DATACLASS_STRING ) then
    	exit function
    elseif( irGetDataClass( falsedtype ) = IR_DATACLASS_STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( truedtype = IR_DATATYPE_USERDEF ) then
		exit function
    elseif( falsedtype = IR_DATATYPE_USERDEF ) then
    	exit function
    end if

    '' are the data types different?
    if( truedtype <> falsedtype ) then
    	if( irMaxDataType( truedtype, falsedtype ) <> INVALID ) then
    		exit function
    	end if
    end if

	falselabel = symbAddLabel( NULL )

	condexpr = astUpdComp2Branch( condexpr, falselabel, FALSE )
	if( condexpr = NULL ) then
		exit function
	end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_IIF, truedtype, truexpr->subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l  			  = condexpr
	n->r  			  = astNewLINK( truexpr, falsexpr )
	n->iif.falselabel = falselabel

end function

'':::::
private function hLoadIIF( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r
    dim as IRVREG ptr vr
    dim as FBSYMBOL ptr exitlabel

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	''
	if( ctx.doemit ) then
		'' IR can't handle inter-blocks and live vregs atm, so any
		'' register used must be spilled now or that could happen in a
		'' function call done in any child trees and also if complex
		'' expressions were used
		'''''if( astIsClassOnTree( AST_NODECLASS_FUNCT, n ) <> NULL ) then
		irEmitSPILLREGS( )
		'''''end if
	end if

	''
	hFLush( l )

	''
	exitlabel = symbAddLabel( NULL )

	'' true expr
	vr = hLoad( r->l )
	if( ctx.doemit ) then
		irEmitPUSH( vr )
		irEmitBRANCH( IR_OP_JMP, exitlabel )
	end if

	'' false expr
	if( ctx.doemit ) then
		irEmitLABELNF( n->iif.falselabel )
	end if

	vr = hLoad( r->r )
    if( ctx.doemit ) then
		irEmitPUSH( vr )

		'' exit
		irEmitLABELNF( exitlabel )
		vr = irAllocVREG( n->dtype )
		irEmitPOP( vr )
	end if

	astDel( r->l )
	astDel( r->r )
	astDel( r )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' stack ops (l = expression; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewSTACK( byval op as integer, _
					  byval l as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

    if( l = NULL ) then
    	return NULL
    end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_STACK, l->dtype, NULL )
	if( n = NULL ) then
		return NULL
	end if

	n->op = op
	n->l  = l

	function = n

end function

'':::::
private function hLoadSTACK( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as IRVREG ptr vr

	l  = n->l
	if( l = NULL ) then
		return NULL
	end if

	vr = hLoad( l )

	if( ctx.doemit ) then
		irEmitSTACK( n->op, vr )
	end if

	astDel( l )

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' labels (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLABEL( byval sym as FBSYMBOL ptr, _
					  byval doflush as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_LABEL, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->lbl.sym	 = sym
	n->lbl.flush = doflush

	function = n

end function

'':::::
private function hLoadLABEL( byval n as ASTNODE ptr ) as IRVREG ptr

	if( ctx.doemit ) then
		if( n->lbl.flush ) then
			irEmitLABEL( n->lbl.sym )
		else
			irEmitLABELNF( n->lbl.sym )
		end if
	end if

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lit (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLIT( byval text as string, _
					byval isasm as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_LIT, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	ZEROSTRDESC( n->lit.text )
	n->lit.text  = text
	n->lit.isasm = isasm

	function = n

end function

'':::::
private function hLoadLIT( byval n as ASTNODE ptr ) as IRVREG ptr

	if( ctx.doemit ) then
		if( n->lit.isasm ) then
			irEmitASM( n->lit.text )
		else
			irEmitCOMMENT( n->lit.text )
		end if
	end if

	n->lit.text = ""

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' JMPTB (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewJMPTB( byval dtype as integer, _
					  byval label as FBSYMBOL ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_JMPTB, dtype )
	if( n = NULL ) then
		return NULL
	end if

	n->jtb.label = label

	function = n

end function

'':::::
private function hLoadJMPTB( byval n as ASTNODE ptr ) as IRVREG ptr

	if( ctx.doemit ) then
		irEmitJMPTB( n->dtype, n->jtb.label )
	end if

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' DBG (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewDBG( byval op as integer, _
				    byval ex as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	if( not env.clopt.debug ) then
		exit function
	end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_DBG, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->op 	   = op
	n->dbg.ex  = ex

	function = n

end function

'':::::
private function hLoadDBG( byval n as ASTNODE ptr ) as IRVREG ptr

	if( ctx.doemit ) then
		irEmitDBG( ctx.curproc->proc, n->op, n->dbg.ex )
	end if

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' memory (l = destine; r = source)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewMEM( byval op as integer, _
					byval l as ASTNODE ptr, _
					byval r as ASTNODE ptr, _
					byval bytes as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_MEM, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->op 	   = op
	n->l	   = l
	n->r	   = r
	n->mem.bytes = bytes

	function = n

end function

'':::::
private function hLoadMEM( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r
    dim as IRVREG ptr v1, v2

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	v1 = hLoad( l )
	v2 = hLoad( r )

	if( ctx.doemit ) then
		irEmitMEM( n->op, v1, v2, n->mem.bytes )
	end if

	astDel( l )
	astDel( r )

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' Bounds checking (l = index; r = link(lb, ub))
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewBOUNDCHK( byval l as ASTNODE ptr, _
					     byval lb as ASTNODE ptr, _
					     byval ub as ASTNODE ptr, _
					     byval linenum as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' lbound is a const?
	if( lb->defined ) then
		'' ubound too?
		if( ub->defined ) then
			'' index also?
			if( l->defined ) then
				'' i < lbound?
				if( l->val.int < lb->val.int ) then
					return NULL
				end if
				'' i > ubound?
				if( l->val.int > ub->val.int ) then
					return NULL
				end if

				astDel( lb )
				astDel( ub )
				return l
			end if
		end if

		'' 0? del it
		if( lb->val.int = 0 ) then
			astDel( lb )
			lb = NULL
		end if
	end if

	'' alloc new node
	n = hNewNode( AST_NODECLASS_BOUNDCHK, INVALID )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l 			= l
	n->r 			= astNewLINK( lb, ub )
	n->bchk.linenum = linenum

end function

'':::::
private function hLoadBOUNDCHK( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r, c, f
    dim as FBSYMBOL ptr label
    dim as IRVREG ptr vr

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' make a copy, can't reuse the same vreg or registers could
	'' be spilled as IR can't handle inter-blocks
	c = astCloneTree( l )

    '' check must be done using a function because calling ErrorThrow
    '' would spill used regs only if it was called, causing wrong
    '' assumptions after the branches
    f = rtlArrayBoundsCheck( l, r->l, r->r, n->bchk.linenum )
    vr = hLoad( f )
    astDel( f )

    if( ctx.doemit ) then
    	'' handler = boundchk( ... ): if handler <> NULL then handler( )
    	label = symbAddLabel( NULL )
    	irEmitBOPEx( IR_OP_EQ, vr, irAllocVRIMM( IR_DATATYPE_INTEGER, 0 ), NULL, label )
    	irEmitJUMPPTR( vr )
    	irEmitLABELNF( label )
    end if

	''
	astDel( r )

	'' re-load, see above
	function = hLoad( c )
	astDel( c )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' null pointer checking (l = index; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewPTRCHK( byval l as ASTNODE ptr, _
					   byval linenum as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = hNewNode( AST_NODECLASS_PTRCHK, INVALID )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l 			= l
	n->pchk.linenum = linenum

end function

'':::::
private function hLoadPTRCHK( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, c, f
    dim as FBSYMBOL ptr label
    dim as IRVREG ptr vr

	l = n->l

	if( l = NULL ) then
		return NULL
	end if

	'' make a copy, can't reuse the same vreg or registers could
	'' be spilled as IR can't handle inter-blocks
	c = astCloneTree( l )

    '' check must be done using a function, see bounds checking
    f = rtlNullPtrCheck( l, n->pchk.linenum )
    vr = hLoad( f )
    astDel( f )

    if( ctx.doemit ) then
    	'' handler = ptrchk( ... ): if handler <> NULL then handler( )
    	label = symbAddLabel( NULL )
    	irEmitBOPEx( IR_OP_EQ, vr, irAllocVRIMM( IR_DATATYPE_INTEGER, 0 ), NULL, label )
    	irEmitJUMPPTR( vr )
    	irEmitLABELNF( label )
    end if

	'' re-load, see above
	function = hLoad( c )
	astDel( c )

end function

