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


'' [A]bstract [S]yntax [T]ree core
''
'' obs: 1) each AST only stores a single expression and its atoms (inc. arrays and functions)
''      2) after the AST is optimized (constants folding, arithmetic associations, etc),
''         its sent to IR, where the expression becomes three-address-codes
''		3) AST optimizations don't include common-sub-expression/dead-code elimination,
''         that must be done by the DAG module
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


declare sub 		astProcListInit	( )

declare sub 		astProcListEnd	( )

declare function 	astLoadASSIGN	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadCONV		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadBOP		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadUOP		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadCONST	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadVAR		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadIDX		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadPTR		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadCALL		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadADDR		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadLOAD		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadBRANCH	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadIIF		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadOFFSET	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadLINK		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadSTACK	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadENUM		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadLABEL	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadLIT		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadASM		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadJMPTB	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadDBG		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadMEM		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadBOUNDCHK	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadPTRCHK	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadFIELD	( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astLoadSCOPE	( byval n as ASTNODE ptr ) as IRVREG ptr

'' globals
	dim shared ast as ASTCTX

	dim shared ast_bitmaskTB( 0 to 32 ) as uinteger = _
	{ _
		0, _
		1, 3, 7, 15, 31, 63, 127, 255, _
		511, 1023, 2047, 4095, 8191, 16383, 32767, 65565, _
        131071, 262143, 524287, 1048575, 2097151, 4194303, 8388607, 16777215, _
        33554431, 67108863, 134217727, 268435455, 536870911, 1073741823, 2147483647, 4294967295 _
	}

	dim shared ast_minlimitTB( FB_DATATYPE_BYTE to FB_DATATYPE_ULONGINT ) as longint = _
	{ _
		-128LL, _								'' byte
		0LL, _                                  '' ubyte
		0LL, _                                  '' char
		-32768LL, _                             '' short
		0LL, _                                  '' ushort
		0LL, _                                  '' wchar
		-2147483648LL, _                        '' int
		0LL, _                                  '' uint
		-2147483648LL, _                        '' enum
		0LL, _                                  '' bitfield
		-9223372036854775808LL, _               '' longint
		0LL _                                   '' ulongint
	}

	dim shared ast_maxlimitTB( FB_DATATYPE_BYTE to FB_DATATYPE_ULONGINT ) as longint = _
	{ _
		127LL, _                                '' ubyte
		255LL, _                                '' byte
		255LL, _                                '' char
		32767LL, _                              '' short
		65535LL, _                              '' ushort
		65535LL, _                              '' wchar
		2147483647LL, _                         '' int
		4294967295LL, _                         '' uint
		2147483647LL, _                         '' enum
		4294967295LL, _                         '' bitfield
		9223372036854775807LL, _                '' longint
		18446744073709551615LL _                '' ulongint
	}


'':::::
private sub hInitTempLists

	listNew( @ast.tempstr, AST_INITTEMPSTRINGS, len( ASTTEMPSTR ), FALSE )

	listNew( @ast.temparray, AST_INITTEMPARRAYS, len( ASTTEMPARRAY ), FALSE )

end sub

'':::::
private sub hEndTempLists

	listFree( @ast.temparray )

	listFree( @ast.tempstr )

end sub

'':::::
sub astInit static

	''
    listNew( @ast.astTB, AST_INITNODES, len( ASTNODE ), FALSE )

    ''
    hInitTempLists( )

    ast.doemit = TRUE
    ast.isopt = FALSE
    ast.typeinicnt = 0

	'' wchar len depends on the target platform
	ast_minlimitTB(FB_DATATYPE_WCHAR) = ast_minlimitTB(env.target.wchar.type)
	ast_maxlimitTB(FB_DATATYPE_WCHAR) = ast_maxlimitTB(env.target.wchar.type)

    ''
    astProcListInit( )

end sub

'':::::
sub astEnd static

	''
	hEndTempLists( )

	''
	astProcListEnd( )

	''
	listFree( @ast.astTB )

end sub

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

	'' this proc will be called for each function param, same
	'' with assignment -- assuming here that IIF won't
	'' support strings
	select case n->dtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_WCHAR

	case else
		exit function
	end select

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
		if( n->op.op = AST_OP_ADD ) then
			l = n->l
			r = n->r
			if( n->dtype <> FB_DATATYPE_WCHAR ) then
				function = rtlStrConcat( l, l->dtype, r, r->dtype )
			else
				function = rtlWstrConcat( l, l->dtype, r, r->dtype )
			end if
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
	if( symbGetDataClass( dtype ) = FB_DATACLASS_STRING ) then
		return NULL
	end if

    '' CHAR and WCHAR literals are also from the INTEGER class
    select case dtype
    case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    	'' don't allow, unless it's a deref pointer
    	if( astIsPTR( n ) = FALSE ) then
    		return NULL
    	end if

	'' UDT?
	case FB_DATATYPE_USERDEF
		return NULL
	end select

	'' shortcut "exp logop exp" if it's at top of tree (used to optimize IF/ELSEIF/WHILE/UNTIL)
	if( n->class <> AST_NODECLASS_BOP ) then
#if 0
		'' UOP? check if it's a NOT
		if( n->class = AST_NODECLASS_UOP ) then
			if( n->op.op = AST_OP_NOT ) then
				l = astUpdComp2Branch( n->l, label, isinverse = FALSE )
				astDel( n )
				return l
			end if
		end if
#endif

		'' CONST?
		if( n->defined ) then
			if( isinverse = FALSE ) then
				'' branch if false
				select case as const dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					istrue = n->con.val.long = 0
				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					istrue = n->con.val.float = 0
				case else
					istrue = n->con.val.int = 0
				end select

				if( istrue ) then
					astDel( n )
					n = astNewBRANCH( AST_OP_JMP, label, NULL )
					if( n = NULL ) then
						return NULL
					end if
				end if
			else
				'' branch if true
				select case as const dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					istrue = n->con.val.long <> 0
				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					istrue = n->con.val.float <> 0
				case else
					istrue = n->con.val.int <> 0
				end select

				if( istrue ) then
					astDel( n )
					n = astNewBRANCH( AST_OP_JMP, label, NULL )
					if( n = NULL ) then
						return NULL
					end if
				end if
			end if

		else
			'' otherwise, check if zero (ie= FALSE)
			if( isinverse = FALSE ) then
				op = AST_OP_EQ
			else
				op = AST_OP_NE
			end if

			'' zstring? astNewBOP will think both are zstrings..
			select case dtype
			case FB_DATATYPE_CHAR
				dtype = FB_DATATYPE_UINT
			case FB_DATATYPE_WCHAR
				dtype = env.target.wchar.type
			end select

			select case as const dtype
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				expr = astNewCONSTl( 0, dtype )
			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
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
	op 	  = n->op.op

	'' relational operator?
	select case as const op
	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE

		'' invert it
		if( isinverse = FALSE ) then
			n->op.op = irGetInverseLogOp( op )
		end if

		'' tell IR that the destine label is already set
		n->op.ex = label

		return n

	'' binary op that sets the flags? (x86 opt, may work on some RISC cpu's)
	case AST_OP_ADD, AST_OP_SUB, AST_OP_SHL, AST_OP_SHR, _
		 AST_OP_AND, AST_OP_OR, AST_OP_XOR, AST_OP_IMP
		 ', AST_OP_EQV -- NOT doesn't set any flags, so EQV can't be optimized (x86 assumption)

		'' x86-quirk: only if integers, as FPU will set its own flags, that must copied back
		if( symbGetDataClass( dtype ) = FB_DATACLASS_INTEGER ) then
            '' can't be done with longints either, as flag is set twice
            if( (dtype <> FB_DATATYPE_LONGINT) and (dtype <> FB_DATATYPE_ULONGINT) ) then

				'' check if zero (ie= FALSE)
				if( isinverse = FALSE ) then
					op = AST_OP_JEQ
				else
					op = AST_OP_JNE
				end if

				return astNewBRANCH( op, label, n )
			end if
		end if

	end select

	'' if no optimization could be done, check if zero (ie= FALSE)
	if( isinverse = FALSE ) then
		op = AST_OP_EQ
	else
		op = AST_OP_NE
	end if

	select case as const dtype
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		expr = astNewCONSTl( 0, dtype )
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
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
    	if( edtype < FB_DATATYPE_POINTER ) then
    		'' not NULL?
    		if( astGetValInt( expr ) <> NULL ) then
    			exit function
    		else
    			return TRUE
    		end if
    	end if

	case else
    	'' expr not a pointer?
    	if( edtype < FB_DATATYPE_POINTER ) then
    		exit function
    	end if
	end select

	'' different types?
	if( pdtype <> edtype ) then

    	'' remove the pointers
    	pdtype_np = pdtype mod FB_DATATYPE_POINTER
    	edtype_np = edtype mod FB_DATATYPE_POINTER

    	'' 1st) is one of them an ANY PTR?
    	if( pdtype_np = FB_DATATYPE_VOID ) then
    		return TRUE
    	elseif( edtype_np = FB_DATATYPE_VOID ) then
    		return TRUE
    	end if

    	'' 2nd) same level of indirection?
    	if( abs( pdtype - edtype ) >= FB_DATATYPE_POINTER ) then
    		exit function
    	end if

    	'' 3rd) same size and class?
    	if( (pdtype_np <= FB_DATATYPE_DOUBLE) and _
    		(edtype_np <= FB_DATATYPE_DOUBLE) ) then
    		if( symbGetDataSize( pdtype_np ) = symbGetDataSize( edtype_np ) ) then
    			if( symbGetDataClass( pdtype_np ) = symbGetDataClass( edtype_np ) ) then
    				return TRUE
    			end if
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
		 AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FIELD, _
		 AST_NODECLASS_CALL, AST_NODECLASS_PTR

    	'' not a function pointer?
    	if( astGetDataType( expr ) <> FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
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
	nn = astNewNode( INVALID, INVALID )
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
	if( n->class = AST_NODECLASS_CALL ) then
		p = n->call.profbegin
		if( p <> NULL ) then
			nn->call.profbegin = astCloneTree( p )
			nn->call.profend   = astCloneTree( n->call.profend )
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
	if( n->class = AST_NODECLASS_CALL ) then
		p = n->call.profbegin
		if( p <> NULL ) then
			astDelTree( p )
			astDelTree( n->call.profend )
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
	case AST_NODECLASS_VAR, AST_NODECLASS_FIELD
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->var.ofs <> r->var.ofs ) then
			exit function
		end if

	case AST_NODECLASS_CONST
const DBL_EPSILON# = 2.2204460492503131e-016

		select case as const l->dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			if( l->con.val.long <> r->con.val.long ) then
				exit function
			end if
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			if( abs( l->con.val.float - r->con.val.float ) > DBL_EPSILON ) then
				exit function
			end if
		case else
			if( l->con.val.int <> r->con.val.int ) then
				exit function
			end if
		end select

	case AST_NODECLASS_ENUM
		if( l->con.val.int <> r->con.val.int ) then
			exit function
		end if

	case AST_NODECLASS_PTR
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
		if( l->op.op <> r->op.op ) then
			exit function
		end if

		if( l->op.allocres <> r->op.allocres ) then
			exit function
		end if

		if( l->op.ex <> r->op.ex ) then
			exit function
		end if

	case AST_NODECLASS_UOP
		if( l->op.op <> r->op.op ) then
			exit function
		end if

		if( l->op.allocres <> r->op.allocres ) then
			exit function
		end if

	case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->op.op <> r->op.op ) then
			exit function
		end if

	case AST_NODECLASS_CONV
		'' do nothing, the l child will be checked below

	case AST_NODECLASS_CALL, AST_NODECLASS_BRANCH, _
		 AST_NODECLASS_LOAD, AST_NODECLASS_ASSIGN, _
		 AST_NODECLASS_LINK
		'' unpredictable nodes
		exit function

	end select

    '' check childs
	if( astIsTreeEqual( l->l, r->l ) = FALSE ) then
		exit function
	end if

	if( astIsTreeEqual( l->r, r->r ) = FALSE ) then
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
	if( n->class = AST_NODECLASS_CALL ) then
		m = astIsClassOnTree( class, n->call.profbegin )
		if( m <> NULL ) then
			return m
		end if
	end if

	function = NULL

end function

''::::
function astIsSymbolOnTree( byval sym as FBSYMBOL ptr, _
							byval n as ASTNODE ptr ) as integer

	dim as FBSYMBOL ptr s

	if( n = NULL ) then
		return FALSE
	end if

	select case as const n->class
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FIELD, _
		 AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET

		s = astGetSymbol( n )

		'' same symbol?
		if( s = sym ) then
			return TRUE
		end if

		'' passed by ref or by desc? can't do any assumption..
		if( s <> NULL ) then
			if( (s->attrib and _
				(FB_SYMBATTRIB_PARAMBYDESC or FB_SYMBATTRIB_PARAMBYREF)) > 0 ) then
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

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree routines
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


'':::::
function astNewNode( byval class_ as integer, _
				 	 byval dtype as integer, _
				 	 byval subtype as FBSYMBOL ptr _
				   ) as ASTNODE ptr static

	dim as ASTNODE ptr n

	n = listNewNode( @ast.astTB )

	astInitNode( n, class_, dtype, subtype )

	function = n

end function

'':::::
sub astDel( byval n as ASTNODE ptr ) static

	if( n = NULL ) then
		exit sub
	end if

	listDelNode( @ast.astTB, cast( TLISTNODE ptr, n ) )

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
function astGetValueAsInt( byval n as ASTNODE ptr ) as integer

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = cint( astGetValLong( n ) )
  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = cint( astGetValFloat( n ) )
  	case else
  		function = astGetValInt( n )
  	end select

end function

'':::::
function astGetValueAsStr( byval n as ASTNODE ptr ) as string

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = str( astGetValLong( n ) )
  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = str( astGetValFloat( n ) )
  	case else
  		function = str( astGetValInt( n ) )
  	end select

end function

'':::::
function astGetValueAsWstr( byval n as ASTNODE ptr ) as wstring ptr
    static as wstring * 64+1 res

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		res = wstr( astGetValLong( n ) )
  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		res = wstr( astGetValFloat( n ) )
  	case else
		res = wstr( astGetValInt( n ) )
  	end select

  	function = @res

end function

'':::::
function astGetValueAsLongInt( byval n as ASTNODE ptr ) as longint

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = astGetValLong( n )
  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = clngint( astGetValFloat( n ) )
  	case else
  		if( symbIsSigned( astGetDataType( n ) ) ) then
  			function = clngint( astGetValInt( n ) )
  		else
  			function = clngint( cuint( astGetValInt( n ) ) )
  		end if
  	end select

end function

'':::::
function astGetValueAsULongInt( byval n as ASTNODE ptr ) as ulongint

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = astGetValLong( n )
  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = culngint( astGetValFloat( n ) )
  	case else
  		function = culngint( cuint( astGetValInt( n ) ) )
  	end select

end function

'':::::
function astGetValueAsDouble( byval n as ASTNODE ptr ) as double

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = cdbl( astGetValLong( n ) )
  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = astGetValFloat( n )
  	case else
  		function = cdbl( astGetValInt( n ) )
  	end select

end function

'':::::
function astGetStrLitSymbol( byval n as ASTNODE ptr ) as FBSYMBOL ptr static
	dim as FBSYMBOL ptr s

    function = NULL

   	if( astIsVAR( n ) ) then
		s = astGetSymbol( n )
		if( s <> NULL ) then
			if( symbGetIsLiteral( s ) ) then
				function = s
			end if
		end if
	end if

end function

'':::::
sub astConvertValue( byval n as ASTNODE ptr, _
					 byval v as FBVALUE ptr, _
					 byval todtype as integer ) static

	hConvertValue( @n->con.val, n->dtype, v, todtype )

end sub

'':::::
function astCheckConst( byval dtype as integer, _
					    byval n as ASTNODE ptr ) as ASTNODE ptr static

	dim as longint lval
	dim as ulongint ulval
	dim as double dval, dmin, dmax

	'' x86 assumptions

    select case as const dtype
    case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE

		if( dtype = FB_DATATYPE_SINGLE ) then
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

	case FB_DATATYPE_LONGINT

		'' unsigned constant?
		if( symbIsSigned( astGetDataType( n ) ) = FALSE ) then
			'' too big?
			if( astGetValueAsULongInt( n ) > 9223372036854775807ULL ) then
				n = astNewCONV( INVALID, dtype, NULL, n )
				hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
			end if
		end if

	case FB_DATATYPE_ULONGINT

		'' signed constant?
		if( symbIsSigned( astGetDataType( n ) ) ) then
			'' too big?
			if( astGetValueAsLongInt( n ) and &h8000000000000000 ) then
				n = astNewCONV( INVALID, dtype, NULL, n )
				hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
			end if
		end if

    case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, _
    	 FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM

		lval = astGetValueAsLongInt( n )
		if( (lval < ast_minlimitTB( dtype )) or _
			(lval > ast_maxlimitTB( dtype )) ) then
			n = astNewCONV( INVALID, dtype, NULL, n )
			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
		end if

    case FB_DATATYPE_UBYTE, FB_DATATYPE_CHAR, _
    	 FB_DATATYPE_USHORT, FB_DATATYPE_WCHAR, _
    	 FB_DATATYPE_UINT

		ulval = astGetValueAsULongInt( n )
		if( (ulval < culngint( ast_minlimitTB( dtype ) )) or _
			(ulval > culngint( ast_maxlimitTB( dtype ) )) ) then
			n = astNewCONV( INVALID, dtype, NULL, n )
			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
		end if

	case FB_DATATYPE_BITFIELD
		'' !!!WRITEME!!! use ->subtype's
	end select

	function = n

end function

''::::
function astLoad( byval n as ASTNODE ptr ) as IRVREG ptr

	if( n = NULL ) then
		return NULL
	end if

	select case as const n->class
	case AST_NODECLASS_NOP
		return NULL

	case AST_NODECLASS_LINK
		return astLoadLINK( n )

	case AST_NODECLASS_ASSIGN
		return astLoadASSIGN( n )

	case AST_NODECLASS_CONV
		return astLoadCONV( n )

	case AST_NODECLASS_CONST
		return astLoadCONST( n )

	case AST_NODECLASS_VAR
		return astLoadVAR( n )

	case AST_NODECLASS_IDX
		return astLoadIDX( n )

    case AST_NODECLASS_FIELD
    	return astLoadFIELD( n )

	case AST_NODECLASS_ENUM
		return astLoadENUM( n )

	case AST_NODECLASS_BOP
		return astLoadBOP( n )

	case AST_NODECLASS_UOP
		return astLoadUOP( n )

	case AST_NODECLASS_CALL
		return astLoadCALL( n )

	case AST_NODECLASS_PTR
		return astLoadPTR( n )

	case AST_NODECLASS_ADDR
		return astLoadADDR( n )

	case AST_NODECLASS_OFFSET
		return astLoadOFFSET( n )

	case AST_NODECLASS_LOAD
		return astLoadLOAD( n )

	case AST_NODECLASS_BRANCH
		return astLoadBRANCH( n )

    case AST_NODECLASS_IIF
    	return astLoadIIF( n )

    case AST_NODECLASS_STACK
    	return astLoadSTACK( n )

    case AST_NODECLASS_LABEL
    	return astLoadLABEL( n )

    case AST_NODECLASS_LIT
    	return astLoadLIT( n )

    case AST_NODECLASS_ASM
    	return astLoadASM( n )

    case AST_NODECLASS_JMPTB
    	return astLoadJMPTB( n )

    case AST_NODECLASS_DBG
    	return astLoadDBG( n )

    case AST_NODECLASS_MEM
    	return astLoadMEM( n )

    case AST_NODECLASS_BOUNDCHK
    	return astLoadBOUNDCHK( n )

    case AST_NODECLASS_PTRCHK
    	return astLoadPTRCHK( n )

    case AST_NODECLASS_SCOPE
    	return astLoadSCOPE( n )

    end select

end function



