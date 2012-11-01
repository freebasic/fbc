'' AST conditional IF nodes
'' l = cond expr, r = link(true expr, false expr)
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"
#include once "rtl.bi"

private sub hPrepareWstring _
	( _
		byref n       as ASTNODE ptr, _
		byref truexpr as ASTNODE ptr, _
		byref falsexpr as ASTNODE ptr _
	)

	dim as ASTNODE ptr l, r

	'' the wstring must be allocated() but size
	'' is unknown at compile-time, do:

	'' dim temp as wstring ptr
	n->sym = symbAddTempVar( typeAddrOf( FB_DATATYPE_WCHAR ) )

	'' Remove temp flag to have it considered for dtor calling
	symbUnsetIsTemp( n->sym )

	'' Mark it as "dynamic wstring" so it will be deallocated with
	'' WstrFree() at scope breaks/end
	symbSetIsWstring( n->sym )

	'' Pretent "= ANY" was used - even though the fake wstring
	'' is pretended to have a constructor, we don't need the
	'' default clear done by astNewDECL()
	symbSetDontInit( n->sym )

	astAdd( astNewDECL( n->sym, NULL ) )

	'' side-effect?
	if( astIsClassOnTree( AST_NODECLASS_CALL, truexpr ) <> NULL ) then
		astAdd( astRemSideFx( truexpr ) )
	end if

	'' tmp = WstrAlloc( len( expr ) )
	l = astNewASSIGN( astNewVAR( n->sym, 0, typeAddrOf( FB_DATATYPE_WCHAR ) ), _
				rtlWstrAlloc( rtlMathLen( astCloneTree( truexpr ), TRUE ) ) )

	'' *tmp = expr
	r = astNewASSIGN( astNewDEREF( astNewVAR( n->sym, 0, typeAddrOf( FB_DATATYPE_WCHAR ) ) ), _
				truexpr, AST_OPOPT_ISINI )

	truexpr = astNewLink( l, r )

	'' side-effect?
	if( astIsClassOnTree( AST_NODECLASS_CALL, falsexpr ) <> NULL ) then
		astAdd( astRemSideFx( falsexpr ) )
	end if

	'' tmp = WstrAlloc( len( expr ) )
	l =  astNewASSIGN( astNewVAR( n->sym, 0, typeAddrOf( FB_DATATYPE_WCHAR ) ), _
				rtlWstrAlloc( rtlMathLen( astCloneTree( falsexpr ), TRUE ) ) )

	'' *tmp = expr
	r = astNewASSIGN( astNewDEREF( astNewVAR( n->sym, 0, typeAddrOf( FB_DATATYPE_WCHAR ) ) ), _
				falsexpr, AST_OPOPT_ISINI )

	falsexpr = astNewLink( l, r )

end sub

private sub hPrepareString _
	( _
		byref n       as ASTNODE ptr, _
		byref truexpr as ASTNODE ptr, _
		byref falsexpr as ASTNODE ptr _
	)

	'' Remove temp flag to have its dtor called at scope breaks/end
	'' (needed when the temporary is a string)
	symbUnsetIsTemp( n->sym )

	astAdd( astNewDECL( n->sym, NULL ) )

	'' assign true to temp
	truexpr = astNewASSIGN( astNewVAR( n->sym, _
					0, _
					symbGetFullType( n->sym ), _
					symbGetSubType( n->sym ) ), _
				truexpr, AST_OPOPT_ISINI )

	'' assign false to temp
	falsexpr = astNewASSIGN( astNewVAR( n->sym, _
					0, _
					symbGetFullType( n->sym ), _
					symbGetSubType( n->sym ) ), _
				falsexpr, AST_OPOPT_ISINI )

end sub

function astNewIIF _
	( _
		byval condexpr as ASTNODE ptr, _
		byval truexpr as ASTNODE ptr, _
		byval falsexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any
	dim as integer true_dtype = any, false_dtype = any
	dim as FBSYMBOL ptr falselabel = any

	function = NULL

	if( condexpr = NULL ) then
		exit function
	end if

	'' Constant condition?
	if( astIsCONST( condexpr ) ) then
		if( astCONSTIsTrue( condexpr ) ) then
			astDelTree( falsexpr )
			function = truexpr
		else
			astDelTree( truexpr )
			function = falsexpr
		end if
		astDelTree( condexpr )
		exit function
	end if

	true_dtype = astGetFullType( truexpr )
	false_dtype = astGetFullType( falsexpr )

	'' UDT's? ditto
	if( typeGet( true_dtype ) = FB_DATATYPE_STRUCT ) then
		exit function
	end if

	if( typeGet( false_dtype ) = FB_DATATYPE_STRUCT ) then
		exit function
	end if

	'' are the data types different?
	if( true_dtype <> false_dtype ) then
		'' throw different consts away
		if( typeGetConstMask( true_dtype ) <> typeGetConstMask( false_dtype ) ) then
			exit function
		end if

		if( typeMax( true_dtype, false_dtype ) <> FB_DATATYPE_INVALID ) then
			exit function
		end if
	end if

	falselabel = symbAddLabel( NULL )

	condexpr = astUpdComp2Branch( condexpr, falselabel, FALSE )
	if( condexpr = NULL ) then
		exit function
	end if

	' Special treatment for fixed-len/zstrings, promote to real FBSTRING
	select case typeGet( true_dtype )
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		true_dtype  = FB_DATATYPE_STRING
		false_dtype = FB_DATATYPE_STRING
	end select

	'' alloc new node
	n = astNewNode( AST_NODECLASS_IIF, true_dtype, truexpr->subtype )
	function = n

	n->l = condexpr

	if( typeGet( true_dtype ) = FB_DATATYPE_WCHAR ) then
		hPrepareWstring( n, truexpr, falsexpr )
	elseif typeGetClass( true_dtype ) = FB_DATACLASS_STRING then
		n->sym = symbAddTempVar( true_dtype, truexpr->subtype, FALSE )
		hPrepareString( n, truexpr, falsexpr )
	else
		n->sym = symbAddTempVar( true_dtype, truexpr->subtype, FALSE )
		'' assign true to temp
		truexpr = astNewASSIGN( astNewVAR( n->sym, _
						0, _
						symbGetFullType( n->sym ), _
						symbGetSubType( n->sym ) ), _
					truexpr )

		'' assign false to temp
		falsexpr = astNewASSIGN( astNewVAR( n->sym, _
						0, _
						symbGetFullType( n->sym ), _
						symbGetSubType( n->sym ) ), _
					falsexpr )
	end if

	n->r = astNewLINK( truexpr, falsexpr )

	n->iif.falselabel = falselabel

end function

'':::::
function astLoadIIF _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	dim as ASTNODE ptr l = any, r = any, t = any
	dim as FBSYMBOL ptr exitlabel = any

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	if( ast.doemit ) then
		'' IR can't handle inter-blocks and live vregs atm, so any
		'' register used must be spilled now or that could happen in a
		'' function call done in any child trees and also if complex
		'' expressions were used
		'''''if( astIsClassOnTree( AST_NODECLASS_CALL, r->l ) <> NULL ) then
		irEmitSPILLREGS( )
		'''''end if
	end if

	'' condition
	astLoad( l )
	astDelNode( l )

	''
	exitlabel = symbAddLabel( NULL )

	'' true expr
	astLoad( r->l )

	if( ast.doemit ) then
		irEmitBRANCH( AST_OP_JMP, exitlabel )
	end if

	'' false expr
	if( ast.doemit ) then
		irEmitLABELNF( n->iif.falselabel )
	end if

	if( ast.doemit ) then
		'' see above
		'''''if( astIsClassOnTree( AST_NODECLASS_CALL, r->r ) <> NULL ) then
		irEmitSPILLREGS( )
		'''''end if
	end if

	astLoad( r->r )

	if( ast.doemit ) then
		'' exit
		irEmitLABELNF( exitlabel )
	end if

	if( symbGetIsWstring( n->sym ) ) then
		t = astNewDEREF( astNewVAR( n->sym, 0, typeAddrOf( FB_DATATYPE_WCHAR ) ) )
	else
		t = astNewVAR( n->sym, 0, symbGetFullType( n->sym ), symbGetSubType( n->sym ) )
	end if

	' If assigning to a string, it needs to be forced to an address of string
	if typeGetClass( astGetFullType( t ) ) = FB_DATACLASS_STRING then
		t = astNewADDROF( t )
	end if

	function = astLoad( t )
	astDelNode( t )

	astDelNode( r->l )
	astDelNode( r->r )
	astDelNode( r )

end function
