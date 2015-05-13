'' AST conditional IF nodes
'' l = cond expr, r = link(true expr, false expr)
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
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

    '' string? invalid
    select case typeGetClass( true_dtype )
    case FB_DATACLASS_STRING
    	exit function
    case FB_DATACLASS_INTEGER
    	select case typeGet( true_dtype )
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		exit function
    	end select
    end select

    select case typeGetClass( false_dtype )
    case FB_DATACLASS_STRING
    	exit function
    case FB_DATACLASS_INTEGER
    	select case typeGet( false_dtype )
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		exit function
    	end select
    end select

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

	'' alloc new node
	n = astNewNode( AST_NODECLASS_IIF, true_dtype, truexpr->subtype )
	function = n

	n->sym = symbAddTempVar( true_dtype, _
							 truexpr->subtype, _
							 FALSE, _
							 FALSE )
	n->l = condexpr

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

	t = astNewVAR( n->sym, 0, symbGetFullType( n->sym ), symbGetSubType( n->sym ) )
	function = astLoad( t )
	astDelNode( t )

	astDelNode( r->l )
	astDelNode( r->r )
	astDelNode( r )

end function

