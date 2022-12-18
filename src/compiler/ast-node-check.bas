'' AST bound and null-pointer checking nodes
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"
#include once "lex.bi"

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' Bounds checking (l = index; r = call to checking func(lb, ub))
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function astNewBOUNDCHK _
	( _
		byval l as ASTNODE ptr, _
		byval lb as ASTNODE ptr, _
		byval ub as ASTNODE ptr, _
		byval linenum as integer, _
		byval filename as zstring ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	'' If one of lbound/ubound is CONST, the other should be too -- either
	'' both are known at compile-time, or neither is.
	assert( astIsCONST( lb ) = astIsCONST( ub ) )

	'' CONST l/ubound?
	if( astIsCONST( lb ) ) then
		'' CONST index?
		if( astIsCONST( l ) ) then
			'' i < lbound?
			if( astConstGetInt( l ) < astConstGetInt( lb ) ) then
				return NULL
			end if
			'' i > ubound?
			if( astConstGetInt( l ) > astConstGetInt( ub ) ) then
				return NULL
			end if

			astDelNode( lb )
			astDelNode( ub )
			return l
		end if

		'' 0? Delete it so rtlArrayBoundsCheck() will use fb_ArraySngBoundChk()
		if( astConstGetInt( lb ) = 0 ) then
			astDelNode( lb )
			lb = NULL
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_BOUNDCHK, l->dtype, l->subtype )
	function = n

	n->l = l

	n->sym = symbAddTempVar( l->dtype, l->subtype )

	'' check must be done using a function because calling ErrorThrow
	'' would spill used regs only if it was called, causing wrong
	'' assumptions after the branches
	n->r = rtlArrayBoundsCheck( astNewVAR( n->sym ), lb, ub, linenum, filename )

end function

'':::::
function astLoadBOUNDCHK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	dim as ASTNODE ptr l = any, r = any, t = any
	dim as FBSYMBOL ptr label = any
	dim as IRVREG ptr vr = any

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' assign to a temp, can't reuse the same vreg or registers could
	'' be spilled as IR can't handle inter-blocks
	t = astNewASSIGN( astNewVAR( n->sym ), l, AST_OPOPT_ISINI )
	astLoad( t )
	astDelNode( t )

	vr = astLoad( r )
	astDelNode( r )

	if( ast.doemit ) then
		'' handler = boundchk( ... ): if handler <> NULL then handler( )
		label = symbAddLabel( NULL )
		irEmitBOP( AST_OP_EQ, _
		           vr, _
		           irAllocVRIMM( FB_DATATYPE_INTEGER, NULL, 0 ), _
		           NULL, _
		           label )
		irEmitJUMPPTR( vr )
		irEmitLABELNF( label )
	end if

	''
	'' re-load, see above
	t = astNewVAR( n->sym )
	function = astLoad( t )
	astDelNode( t )

end function

function astBuildBOUNDCHK _
	( _
		byval expr as ASTNODE ptr, _
		byval lb as ASTNODE ptr, _
		byval ub as ASTNODE ptr _
	) as ASTNODE ptr
	function = astNewBOUNDCHK( expr, lb, ub, lexLineNum( ), env.inf.name )
end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' null pointer checking (l = index; r = call to checking func)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function astNewPTRCHK _
	( _
		byval l as ASTNODE ptr, _
		byval linenum as integer, _
		byval filename as zstring ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	'' constant? don't break OffsetOf() when used with Const's..
	if( l->class = AST_NODECLASS_CONST ) then
		return l
	end if

	'' alloc new node
	dtype = astGetFullType( l )
	subtype = l->subtype
	n = astNewNode( AST_NODECLASS_PTRCHK, dtype, subtype )
	function = n

	n->l = l

	n->sym = symbAddTempVar( dtype, subtype )

	'' check must be done using a function, see bounds checking
	n->r = rtlNullPtrCheck( astNewVAR( n->sym ), linenum, filename )

end function

'':::::
function astLoadPTRCHK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	dim as ASTNODE ptr l = any, r = any, t = any
	dim as FBSYMBOL ptr label = any
	dim as IRVREG ptr vr = any

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' assign to a temp, can't reuse the same vreg or registers could
	'' be spilled as IR can't handle inter-blocks.
	'' And don't generate pointer warnings for this internal assignment; as
	'' in the case where datatypes differ by mangle modifier only.
	t = astNewASSIGN( astNewVAR( n->sym ), l, AST_OPOPT_ISINI or AST_OPOPT_DONTCHKPTR )
	astLoad( t )
	astDelNode( t )

	''
	vr = astLoad( r )
	astDelNode( r )

	if( ast.doemit ) then
		'' handler = ptrchk( ... ): if handler <> NULL then handler( )
		label = symbAddLabel( NULL )
		irEmitBOP( AST_OP_EQ, _
		           vr, _
		           irAllocVRIMM( FB_DATATYPE_INTEGER, NULL, 0 ), _
		           NULL, _
		           label )
		irEmitJUMPPTR( vr )
		irEmitLABELNF( label )
	end if

	'' re-load, see above
	t = astNewVAR( n->sym )
	function = astLoad( t )
	astDelNode( t )

end function

function astBuildPTRCHK( byval expr as ASTNODE ptr ) as ASTNODE ptr
	function = astNewPTRCHK( expr, lexLineNum( ), env.inf.name )
end function
