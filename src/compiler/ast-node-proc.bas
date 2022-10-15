''
'' AST proc body nodes
'' l = head node; r = tail node
''
'' note: an implicit scope block isn't created, because the
''       implicit main() function (inside scope blocks only
''       non-decl statements are allowed)
''


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "lex.bi"
#include once "parser.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

type FB_GLOBINSTANCE
	sym             as FBSYMBOL_ ptr            '' for symbol
	initree         as ASTNODE ptr              '' can't store in sym, or emit will use it
	call_dtor       as integer
end type

declare function hModLevelIsEmpty( byval p as ASTNODE ptr ) as integer
declare sub hLoadProcResult( byval proc as FBSYMBOL ptr )
declare function hDeclVarsForProcParams( byval proc as FBSYMBOL ptr ) as integer
declare function hInitVptr _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr
declare sub hCallCtors( byval n as ASTNODE ptr, byval sym as FBSYMBOL ptr )
declare sub hCallDtors( byval proc as FBSYMBOL ptr )
declare sub hCallDeleteDtor( byval proc as FBSYMBOL ptr )
declare sub hGenStaticInstancesDtors( byval proc as FBSYMBOL ptr )
declare sub hGenGlobalInstancesCtor( )

''::::
sub astProcListInit( )

	ast.proc.head = NULL
	ast.proc.tail = NULL
	ast.proc.curr = NULL

	''
	listInit( @ast.globinst.list, 32, len( FB_GLOBINSTANCE ), LIST_FLAGS_NOCLEAR )
	ast.globinst.ctorcnt = 0
	ast.globinst.dtorcnt = 0

end sub

''::::
sub astProcListEnd( )

	ast.globinst.dtorcnt = 0
	ast.globinst.ctorcnt = 0
	listEnd( @ast.globinst.list )

	''
	ast.proc.head = NULL
	ast.proc.tail = NULL
	ast.proc.curr = NULL

end sub

private function hNewProcNode( ) as ASTNODE ptr
	dim as ASTNODE ptr n = any

	n = astNewNode( AST_NODECLASS_PROC, FB_DATATYPE_INVALID, NULL )

	'' add to list
	if( ast.proc.tail <> NULL ) then
		ast.proc.tail->next = n
	else
		ast.proc.head = n
	end if

	n->prev = ast.proc.tail
	n->next = NULL
	ast.proc.tail = n

	function = n
end function

private sub hDelProcNode( byval n as ASTNODE ptr )
	n->l = NULL
	n->r = NULL

	'' remove from list
	if( n->prev <> NULL ) then
		n->prev->next = n->next
	else
		ast.proc.head = n->next
	end If

	if( n->next <> NULL ) then
		n->next->prev = n->prev
	else
		ast.proc.tail = n->prev
	end If

	astDelNode( n )
end sub

''::::
private sub hProcFlush _
	( _
		byval p as ASTNODE ptr, _
		byval doemit as integer _
	)

	dim as ASTNODE ptr n = any, nxt = any
	dim as FBSYMBOL ptr sym = any

	sym = p->sym

	if( doemit ) then
		'' emit the static dtor wrappers
		hGenStaticInstancesDtors( sym )
	end if

	''
	ast.proc.curr = p
	ast.currblock = p
	ast.doemit = doemit

	''
	parser.scope = iif( p->block.proc.ismain, FB_MAINSCOPE, FB_MAINSCOPE+1 )
	parser.currproc = sym
	parser.currblock = sym

	''
	symbNestBegin( sym, FALSE )

	'' emit header
	if( ast.doemit ) then
		symbSetProcIsEmitted( sym )

		irEmitPROCBEGIN( sym, p->block.initlabel )

		'' allocate the non-static local variables on stack
		astScopeAllocLocals(symbGetProcSymbTbHead(sym))
	end if

	'' flush nodes
	n = p->l
	do while( n <> NULL )
		nxt = n->next
		astLoad( n )
		astDelNode( n )
		n = nxt
	loop

	'' emit footer
	if( ast.doemit ) then
		irEmitPROCEND( sym, p->block.initlabel, p->block.exitlabel )

		'' Emit static local variables
		irProcAllocStaticVars( symbGetProcSymbTbHead( sym ) )
	end if

	'' del symbols from hash and symbol tb's
	symbDelSymbolTb( @sym->proc.symtb, FALSE )

	''
	symbNestEnd( FALSE )

	hDelProcNode( p )

	ast.doemit = TRUE

end sub

''::::
private sub hProcFlushAll _
	( _
		_
	)

	dim as ASTNODE ptr n = any
	dim as integer doemit = any
	dim as FBSYMBOL ptr sym = any

	'' procs should be sorted by include file

	'' gen the global ctors/dtors, if any (done before emitting main()
	'' because the ctors/dtors could be private and not called yet)
	hGenGlobalInstancesCtor( )

	do
		n = ast.proc.head
		if( n = NULL ) then
			exit do
		end if

		sym = n->sym

		'' fully parsed?
		if( symbGetIsParsed( sym ) ) then
			doemit = TRUE
			'' private?
			if( symbIsPrivate( sym ) ) then
				'' never called? skip
				if( symbGetIsAccessed( sym ) = FALSE ) then
					doemit = FALSE

				'' module-level?
				elseif( symbGetIsModLevelProc( sym ) ) then
					doemit = (hModLevelIsEmpty( n ) = FALSE)
				end if
			end if

		else
			doemit = FALSE
		end if

		hProcFlush( n, doemit )
	loop

end sub

private function astUpdate( byval n as ASTNODE ptr ) as ASTNODE ptr
	if( n = NULL ) then
		return NULL
	end if

	'' RTL function and the result was discarded? do not allocate a result
	if( astIsCALL( n ) ) then
		if( n->call.isrtl ) then
			if( astGetFullType( n ) <> FB_DATATYPE_VOID ) then
				astSetType( n, FB_DATATYPE_VOID, NULL )
			end if
		end if
	end if

	'' Note: Any updating here that can create temp vars with dtors (such
	'' as astTypeIniUpdate()) should also be done in astBuildBranch() (for
	'' the condition expression) and astNewIIF() (for the true/false
	'' expressions) since those cases require dtor calls for temp vars to
	'' be in specific locations, not just generically at the end of the
	'' statement (which is what the astDtorListFlush() below will do).

	'' Turn TYPEINI trees into real assignments
	'' Note: This can allocate temporary variables, so it must be done
	'' while in the proper scope context!
	n = astTypeIniUpdate( n )

	'' Bitfield assignment/access updating
	n = astUpdateBitfields( n )

	'' Tree optimizations
	n = astOptimizeTree( n )

	'' Assignment optimizations
	n = astOptAssignment( n )

	'' Update string '+' BOPs to 'fb_StrConcat' CALLs
	n = astUpdStrConcat( n )

	'' Destroy temporaries if needed
	if( ast.flushdtorlist ) then
		n = astNewLINK( n, astDtorListFlush( ), AST_LINK_RETURN_NONE )
	end if

	function = n
end function

''
'' Add a statement to the current procedure.
''
'' This will also
''  * update & optimize the statement (astUpdate())
''  * add clean up code behind the statement for currently-registered temporary
''    variables (astDtorListFlush())
''
'' When calling astAdd(), care must be taken not to destroy any temporaries
'' too early. After parsing an expression (e.g. with cExpression()), the first
'' astAdd() will flush the AST dtor list and add the code for destroying the
'' temp vars used in that expression. Thus, the expression itself *must* be
'' added in this first astAdd(). Otherwise, if the expression is added during a
'' secondary astAdd(), the temp var clean up would occur in front of the
'' expression, which is wrong (it must be emitted behind the expression).
''
'' If there is a statement (or multiple ones) which need to be added in front of
'' the one using the expression, they must all be linked together using
'' astNewLINK(), such that there is only one astAdd, to avoid the dtor list
'' being flushed too early.
''
'' Sometimes it's not obvious where the astAdd's are because some astAdd's
'' are "hidden" inside other functions such as astScopeBegin().
''
'' astAddUnscoped() does not have this problem because it unsets
'' ast.flushdtorlist.
''
function astAdd( byval n as ASTNODE ptr ) as ASTNODE ptr
	n = astUpdate( n )
	if( n = NULL ) then
		return NULL
	end if

	'' Link the tree into the procedure's statement list
	if( ast.proc.curr->r <> NULL ) then
		ast.proc.curr->r->next = n
	else
		ast.proc.curr->l = n
	end if
	n->prev = ast.proc.curr->r
	n->next = NULL
	ast.proc.curr->r = n

	function = n
end function

#if __FB_DEBUG__
private function hNodeIsFromCurrentProc( byval n as ASTNODE ptr ) as integer
	dim as ASTNODE ptr i = any

	i = ast.proc.curr->l
	while( i )

		if( i = n ) then
			function = TRUE
			exit while
		end if

		i = i->next
	wend
end function
#endif

function astAddAfter _
	( _
		byval n as ASTNODE ptr, _
		byval ref as ASTNODE ptr _
	) as ASTNODE ptr

	n = astUpdate( n )
	if( n = NULL ) then
		return NULL
	end if

	if( ref ) then
		assert( hNodeIsFromCurrentProc( ref ) )

		'' Insert behind this reference node in the current procedure
		n->prev = ref
		n->next = ref->next
		if( ref->next ) then
			if( ref->next->prev ) then
				ref->next->prev = n
			end if
		else
			assert( ast.proc.curr->r = ref )
			ast.proc.curr->r = n
		end if
		ref->next = n
	else
		'' Insert at the top of the current procedure
		n->prev = NULL
		n->next = ast.proc.curr->l
		if( ast.proc.curr->l ) then
			ast.proc.curr->l->prev = n
		else
			assert( ast.proc.curr->r = NULL )
			ast.proc.curr->r = n
		end if
		ast.proc.curr->l = n
	end if

	function = n
end function

''::::
sub astAddUnscoped _
	( _
		byval n as ASTNODE ptr _
	)

	dim as ASTNODE ptr last = any

	if( n = NULL ) then
		exit sub
	end if

	last = ast.proc.curr->block.proc.decl_last
	if( last = NULL ) then
		last = ast.proc.curr->l
	end if

	ast.flushdtorlist = FALSE

	if( last = NULL ) then
		n = astAdd( n )
	else
		n = astAddAfter( n, last )
	end if

	ast.flushdtorlist = TRUE

	ast.proc.curr->block.proc.decl_last = n

end sub

function astFindFirstCode( byval proc as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr i = any

	assert( proc->class = AST_NODECLASS_PROC )

	i = proc->l
	while( i )
		'' Skip over nodes that don't represent executable code
		select case( i->class )
		case AST_NODECLASS_NOP, AST_NODECLASS_LABEL, _
		     AST_NODECLASS_DECL, AST_NODECLASS_LIT, _
		     AST_NODECLASS_DATASTMT, AST_NODECLASS_DBG _

		case else
			exit while
		end select

		i = i->next
	wend

	function = i
end function

sub astProcBegin( byval sym as FBSYMBOL ptr, byval ismain as integer )
	dim as ASTNODE ptr n = any
	dim as integer enable_implicit_code = any

	n = hNewProcNode( )

	symbSymbTbInit( sym->proc.symtb, sym )

	symbProcAllocExt( sym )

	'' File name where the procedure body was found
	sym->proc.ext->dbg.incfile = env.inf.incfile

	ast.proc.curr = n
	ast.currblock = n

	parser.scope = iif( ismain, FB_MAINSCOPE, FB_MAINSCOPE+1 )
	parser.currproc = sym
	parser.currblock = sym

	symbNestBegin( sym, FALSE )

	'' add init and exit labels (see the note in the top,
	'' procs don't create an implicit scope block)
	n->block.initlabel = symbAddLabel( NULL )
	n->block.exitlabel = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	n->sym = sym
	n->block.proc.ismain = ismain
	n->block.parent = NULL
	n->block.inistmt = parser.stmt.cnt
	n->block.breaklist.head = NULL
	n->block.breaklist.tail = NULL
	n->block.proc.decl_last = NULL

	irProcBegin( sym )

	enable_implicit_code = not symbIsNaked( sym )

	' Don't allocate anything for a naked function, because they will be allowed
	' at ebp-N, which won't exist, no result is needed either
	if( enable_implicit_code ) then
		'' alloc parameters
		hDeclVarsForProcParams( sym )

		'' alloc result local var
		if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then
			symbAddProcResultVar( sym )
		end if
	end if

	'' local error handler
	with sym->proc.ext->err
		.lasthnd = NULL
		.lastmod = NULL
		.lastfun = NULL
	end with

	sym->proc.ext->stmtnum = parser.stmt.cnt

	'' main()?
	if( symbGetIsMainProc( sym ) ) then
		dim as FBSYMBOL ptr argc = any, argv = any

		assert( symbGetProcParams( sym ) = 2 )
		argc = symbGetProcHeadParam( sym )
		argv = symbGetProcTailParam( sym )

		'' fb_Init( argc, argv )
		'' (plus some other calls depending on -exx etc.)
		env.main.initnode = rtlInitApp( _
			astNewVAR( symbGetParamVar( argc ) ), _
			astNewVAR( symbGetParamVar( argv ) ) )

	'' Destructor?
	elseif( (symbIsDestructor0( sym ) or symbIsDestructor1( sym )) and enable_implicit_code ) then
		''
		'' If the UDT has a vptr, reset it at the top of destructors,
		'' such that the vptr always matches the type of object that
		'' we're destructing, as in C++.
		''
		'' For example:
		''    type A extends object
		''    type B extends A
		''
		'' When destroying a B object, the body of B.destructor() runs
		'' before the body of A.destructor() (B.destructor() actually
		'' calls A.destructor() at its end before returning). This means
		'' the B part of the object is destroyed before the A part.
		''
		'' Thus, it's not safe to allow virtual calls from inside
		'' A.destructor() to any of B's methods, and this is prevented
		'' by resetting the vptr at the top of each destructor.
		''
		astAdd( hInitVptr( symbGetNamespace( sym ), sym ) )
	end if

	'' Label at beginning of lexical block, used by debug stabs output
	astAdd( astNewLABEL( n->block.initlabel ) )
end sub

'':::::
private function hCheckErrHnd _
	( _
		byval head_node as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' error check? add to head (must be done only when closing the proc body
	'' or constructor's field would be initialized and break ctor chaining)
	if( env.clopt.errlocation ) then
		head_node = astAddAfter( rtlErrorSetModName( sym, _
		                         astNewCONSTstr( @env.inf.name ) ), head_node )

		head_node = astAddAfter( rtlErrorSetFuncName( sym, _
		                         astNewCONSTstr( symbGetName( sym ) ) ), head_node )
	end if

	with sym->proc.ext->err
		if( .lastfun <> NULL ) then
			astAdd( rtlErrorSetFuncName( NULL, astNewVAR( .lastfun ) ) )
			.lastfun = NULL
		end if

		if( .lastmod <> NULL ) then
			astAdd( rtlErrorSetModName( NULL, astNewVAR( .lastmod ) ) )
			.lastmod = NULL
		end if

		if( .lasthnd <> NULL ) then
			rtlErrorSetHandler( astNewVAR( .lasthnd ), FALSE )
			.lasthnd = NULL
		end if
	end with

	function = head_node

end function

private function hMaybeCallResultCtor _
	( _
		byval head_node as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr res = any, defctor = any

	'' Not returning BYVAL, or BYVAL but not an UDT?
	if( symbIsReturnByRef( sym ) or (symbGetType( sym ) <> FB_DATATYPE_STRUCT) ) then
		return head_node
	end if

	'' Add result ctor call to the top of the function,
	''    a) if FUNCTION= (and/or EXIT FUNCTION) was used,
	''    b) or if neither FUNCTION= nor RETURN was used,
	'' but not if RETURN was used, because that already calls the copy
	'' ctor at every RETURN.
	''
	'' This way the result will be constructed properly,
	'' even if nothing was explicitly returned.

	'' only RETURN used?
	if( (not symbGetProcStatAssignUsed( sym )) and symbGetProcStatReturnUsed( sym ) ) then
		return head_node
	end if

	'' UDT with default ctor? (if there is none, nothing needs to be done)
	defctor = symbGetCompDefCtor( symbGetSubtype( sym ) )
	if( defctor = NULL ) then
		'' No default ctor, but others? Must show an error, because we
		'' cannot leave the result unconstructed. It would be nicer to
		'' detect & show this error at the top of the function already,
		'' but that's not possible because of RETURN which doesn't
		'' require a defctor...
		if( symbHasCtor( sym ) ) then
			errReport( FB_ERRMSG_RESULTHASNODEFCTOR )
		end if
		return head_node
	end if

	res = symbGetProcResult( sym )
	if( res = NULL ) then
		return head_node
	end if

	function = astAddAfter( astBuildCtorCall( symbGetSubtype( sym ), _
	                                          astBuildProcResultVar( sym, res ) ), _
	                        head_node )
end function

'':::::
private function hCallProfiler _
	( _
		byval head_node as ASTNODE ptr _
	) as ASTNODE ptr

	'' on all ports except dos _mcount() is just a normal call
	if( env.clopt.profile ) then
		if( env.clopt.target <> FB_COMPTARGET_DOS ) then
			head_node = astAddAfter( rtlProfileCall_mcount(), head_node )
		end if
	end if

	function = head_node

end function

function astProcEnd( byval callrtexit as integer ) as integer
	static as integer rec_cnt = 0
	dim as integer res = any, do_flush = any, enable_implicit_code = any
	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr n = any

	n = ast.proc.curr
	rec_cnt += 1
	sym = n->sym
	n->block.endstmt = parser.stmt.cnt

	'' No implicit code should be added for naked functions -- i.e. no stack
	'' frame setup, no function result, no error checking, no profiling.
	'' (Any calls would "trash" the stack)
	'' No need to worry about any "explicit" code though (any statements),
	'' including local variables and possibly resulting destructor calls;
	'' they are "the coders fault", not ours.
	enable_implicit_code = not symbIsNaked( sym )

	if( errGetCount( ) = 0 ) then
		'' Constructor?
		if( symbIsConstructor( sym ) and enable_implicit_code ) then
			'' No constructor initialization code yet? (constructor chaining)
			if( symbGetIsCtorInited( sym ) = FALSE ) then
				symbSetIsCtorInited( sym )
				'' Add constructor initialization code
				hCallCtors( n, sym )
			end if
		end if

		astScopeDestroyVars(symbGetProcSymbTb(sym).tail)
	end if

	''
	astAdd( astNewLABEL( n->block.exitlabel ) )

	'' Check for any undefined labels (labels can be forward references)
	res = (symbCheckLabels(symbGetProcSymbTbHead(parser.currproc)) = 0)

	if( res ) then
		'' Complete Destructor? (D1)
		if( symbIsDestructor1( sym ) and enable_implicit_code ) then
			'' Call destructors, behind the exit label, so they'll
			'' always be called, even with early returns.
			hCallDtors( sym )
		end if

		'' Deleting Destructor? (D0)
		if( symbIsDestructor0( sym ) and enable_implicit_code ) then
			hCallDeleteDtor( sym )
		end if

		'' update proc's breaks list, adding calls to destructors when needed
		if( n->block.breaklist.head <> NULL ) then
			res = astScopeUpdBreakList( n )
		end if

		'' gosub used?
		astGosubAddExit( sym )

		dim as ASTNODE ptr head_node = n->l

		if( enable_implicit_code ) then
			head_node = hCallProfiler( head_node )
			head_node = hCheckErrHnd( head_node, sym )
		end if

		'' if main(), END 0 must be called because it's not safe to return to crt if
		'' an ON ERROR module-level handler was called while inside some proc
		if( callrtexit ) then
			if( n->block.proc.ismain ) then
				rtlExitApp( NULL )
			end if
		end if

		if( enable_implicit_code ) then
			'' if it's a function, load result
			if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then
				head_node = hMaybeCallResultCtor( head_node, sym )
				hLoadProcResult( sym )
			end if
		end if
	end if

	''
	irProcEnd( sym )

	do_flush = FALSE
	if( res and (errGetCount( ) = 0) ) then
		symbSetIsParsed( sym )

		'' not into a recursion?
		if( rec_cnt = 1 ) then
			if( n->block.proc.ismain = FALSE ) then
				''
				'' Emit public (non-private) procedures immediately.
				''
				'' Emitting of private ones is delayed until hProcFlushAll(),
				'' so that they're only emitted if actually used.
				''
				'' When using the C/LLVM backends, emitting of procedures containing forward
				'' references in their signature must be delayed aswell, otherwise the C/LLVM
				'' backends would try emitting them with incomplete type.
				''
				if( (not symbIsPrivate( sym )) and _
				    ((not symbProcHasFwdRefInSignature( sym )) or _
				     (env.clopt.backend = FB_BACKEND_GAS)) ) then
					do_flush = TRUE

				'' remove from hash tb only
				else
					symbDelSymbolTb( @sym->proc.symtb, TRUE )
				end if

			'' main? flush all remaining, it's the latest
			else
				do_flush = TRUE
			end if
		end if

	'' errors.. remove everything from hash and symbol tb
	else
		symbDelSymbolTb( @sym->proc.symtb, FALSE )
	end if

	''
	symbNestEnd( FALSE )

	if( env.clopt.vectorize >= FB_VECTORIZE_NORMAL ) then
		'' only gas + SSE will expect AST_OP_HADD or AST_OP_SWZREP
		if( env.clopt.backend = FB_BACKEND_GAS ) then
			astProcVectorize( n->l )
		end if
	end if

	''
	if( do_flush ) then
		if( n->block.proc.ismain = FALSE ) then
			hProcFlush( n, TRUE )
		else
			hProcFlushAll( )
		end if
	end if

	'' back to main (or NULL if main was emitted already)
	ast.proc.curr = ast.proc.head
	ast.currblock = ast.proc.head

	parser.scope = FB_MAINSCOPE
	parser.currproc = env.main.proc
	parser.currblock = env.main.proc

	''
	rec_cnt -= 1

	function = res

end function

private function hDeclVarsForProcParams( byval proc as FBSYMBOL ptr ) as integer
	dim as integer i = any
	dim as FBSYMBOL ptr p = any

	function = FALSE

	'' proc returns an UDT?
	if( symbGetType( proc ) = FB_DATATYPE_STRUCT ) then
		symbAddVarForProcResultParam( proc )
	end if

	'' Param vars must be declared in the order they should be allocated
	'' on stack, i.e. depending on the calling convention
	'' (see also irProcAllocArg())
	i = 1
	p = symbGetProcLastParam( proc )
	do while( p <> NULL )
		if( p->param.mode <> FB_PARAMMODE_VARARG ) then
			p->param.var = symbAddVarForParam( p )
			if( p->param.var = NULL ) then
				errReportParam( proc, i, NULL, FB_ERRMSG_DUPDEFINITION )
				exit function
			end if
		end if

		p = symbGetProcPrevParam( proc, p )
		i += 1
	loop

	function = TRUE
end function

private sub hLoadProcResult( byval proc as FBSYMBOL ptr )
	dim as FBSYMBOL ptr s = any
	dim as ASTNODE ptr n = any

	s = symbGetProcResult( proc )

	'' if result is a string, a temp descriptor is needed, as the current one (on stack)
	'' will be trashed when the function returns (also, the string returned will be
	'' set as temp, so any assignment or when passed as parameter to another proc
	'' will deallocate this string)
	if( (symbGetType( proc ) = FB_DATATYPE_STRING) and (not symbIsReturnByRef( proc )) ) then
		n = rtlStrAllocTmpResult( astNewVAR( s ) )

		if( ( env.clopt.backend = FB_BACKEND_GCC ) or ( env.clopt.backend = FB_BACKEND_LLVM ) or ( env.clopt.backend = FB_BACKEND_GAS64 ) ) then
			n = astNewLOAD( n, symbGetFullType( proc ), TRUE )
		end if
	else
		'' Use the real type, in case it's BYREF return or a UDT result
		n = astNewLOAD( astNewVAR( s, 0, symbGetProcRealType( proc ), _
		                symbGetProcRealSubtype( proc ) ), _
		                symbGetProcRealType( proc ), TRUE )
	end if

	astAdd( n )
end sub

private function hModLevelIsEmpty( byval p as ASTNODE ptr ) as integer
	dim as ASTNODE ptr n = any, nxt = any

	'' an empty module-level proc will have just the
	'' initial and final labels as nodes and nothing else
	'' (note: when debugging it will be emitted even if empty)

	n = p->l
	if( n = NULL ) then
		return TRUE
	end if
	if( n->class <> AST_NODECLASS_LABEL ) then
		return FALSE
	end if

	n = n->next
	if( n = NULL ) then
		return TRUE
	end if
	if( n->class <> AST_NODECLASS_LABEL ) then
		return FALSE
	end if

	n = n->next
	if( n = NULL ) then
		return TRUE
	end if

	return FALSE
end function

private function hCallCtorList _
	( _
		byval is_ctor as integer, _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr cnt = any, label = any, iter = any, subtype = any
	dim as ASTNODE ptr fldexpr = any, tree = any
	dim as integer dtype = any
	dim as longint elements = any

	'' instance? (this function is also used by the static dtor wrapper)
	if( fld <> NULL ) then
		dtype = symbGetType( fld )
		subtype = symbGetSubtype( fld )
		elements = symbGetArrayElements( fld )
	else
		dtype = symbGetType( this_ )
		subtype = symbGetSubtype( this_ )
		elements = symbGetArrayElements( this_ )
	end if

	assert( elements > 0 )
	cnt = symbAddTempVar( FB_DATATYPE_INTEGER )
	label = symbAddLabel( NULL )
	iter = symbAddTempVar( typeAddrOf( dtype ), subtype )

	'' Instance?
	if( fld <> NULL ) then
		if( is_ctor ) then
			'' iter = @this.field(0)
			fldexpr = astBuildVarField( this_, fld )
		else
			'' iter = @this.field(elements-1)
			fldexpr = astBuildVarField( this_, fld, (elements - 1) * symbGetLen( fld ) )
		end if
	else
		if( is_ctor ) then
			'' iter = @symbol(0)
			fldexpr = astBuildVarField( this_, NULL, 0 )
		else
			'' iter = @symbol(0) + (elements - 1)
			fldexpr = astBuildVarField( this_, NULL, (elements - 1) * symbGetLen( subtype ) )
		end if
	end if
	tree = astBuildVarAssign( iter, astNewADDROF( fldexpr ), AST_OPOPT_ISINI )

	'' for cnt = 0 to symbGetArrayElements( fld )-1
	tree = astBuildForBegin( tree, cnt, label, 0 )

	if( is_ctor ) then
		'' ctor( *iter )
		tree = astNewLINK( tree, astBuildCtorCall( subtype, astBuildVarDeref( iter ) ), AST_LINK_RETURN_NONE )
	else
		'' dtor( *iter )
		tree = astNewLINK( tree, astBuildDtorCall( subtype, astBuildVarDeref( iter ) ), AST_LINK_RETURN_NONE )
	end if

	'' iter += 1
	tree = astNewLINK( tree, astBuildVarInc( iter, iif( is_ctor, 1, -1 ) ), AST_LINK_RETURN_NONE )

	'' next
	tree = astBuildForEnd( tree, cnt, label, astNewCONSTi( elements ) )

	function = tree
end function

private function hCallFieldCtor _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	) as ASTNODE ptr

	assert( symbIsDescriptor( fld ) = FALSE )  '' should have had an initree
	assert( symbIsRef( fld ) = FALSE )  '' reference? ditto

	'' Fake dynamic array field that didn't have an initree - nothing to do
	if( symbIsDynamic( fld ) ) then
		assert( symbGetTypeIniTree( fld ) = NULL )
		exit function
	end if

	'' Do not initialize?
	if( symbGetDontInit( fld ) ) then
		exit function
	end if

	'' has a default ctor too?
	if( symbHasDefCtor( fld ) ) then
		'' not an array?
		if( symbGetArrayDimensions( fld ) = 0 ) then
			'' ctor( this.field )
			function = astBuildCtorCall( symbGetSubtype( fld ), astBuildVarField( this_, fld ) )
		'' array..
		else
			function = hCallCtorList( TRUE, this_, fld )
		end if
		exit function
	end if

	'' bitfield?
	if( symbFieldIsBitfield( fld ) ) then
		function = astNewASSIGN( astBuildVarField( this_, fld ), _
		                         astNewCONSTi( 0, FB_DATATYPE_UINT ), _
		                         AST_OPOPT_ISINI )
	else
		function = astNewMEM( AST_OP_MEMCLEAR, _
		                      astBuildVarField( this_, fld ), _
		                      astNewCONSTi( symbGetRealSize( fld ) ) )
	end if
end function

private function hClearUnionFields _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval base_fld as FBSYMBOL ptr, _
		byval pfinalfield as FBSYMBOL ptr ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr fld = any
	dim as longint bytes = any, lgt = any, base_ofs = any

	'' merge all union fields
	fld = base_fld
	bytes = 0
	base_ofs = symbGetOfs( base_fld )

	do
		lgt = symbGetRealSize( fld ) + (symbGetOfs( fld ) - base_ofs)
		if( lgt > bytes ) then
			bytes = lgt
		end if

		'' Visit following union fields (but not any methods/static member vars/etc.)
		fld = fld->next
	loop while( fld andalso symbIsField( fld ) andalso symbGetIsUnionField( fld ) )

	*pfinalfield = fld

	'' clear all them at once
	function = astNewMEM( AST_OP_MEMCLEAR, _
	                      astBuildVarField( this_, base_fld ), _
	                      astNewCONSTi( bytes ) )
end function

private function hInitDynamicArrayField _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr exprTB(0 to FB_MAXARRAYDIMS-1, 0 to 1)
	dim as ASTNODE ptr boundstypeini = any, n = any
	dim as integer dimensions = any

	'' Duplicate the expressions and its temp vars into the current scope
	boundstypeini = astTypeIniClone( symbGetTypeIniTree( fld ) )

	'' Fill the exprTB() with the bounds expressions from the TYPEINI
	dimensions = 0
	assert( astIsTYPEINI( boundstypeini ) )
	n = boundstypeini->l
	do
		assert( dimensions < FB_MAXARRAYDIMS )

		'' lbound
		assert( n->class = AST_NODECLASS_TYPEINI_ASSIGN )
		exprTB(dimensions,0) = n->l
		n->l = NULL  '' so we can astDelTree() the TYPEINI without free'ing the bounds expressions

		'' ubound
		n = n->r
		assert( n->class = AST_NODECLASS_TYPEINI_ASSIGN )
		exprTB(dimensions,1) = n->l
		n->l = NULL  '' ditto

		n = n->r
		dimensions += 1
	loop while( n )

	assert( dimensions = symbGetArrayDimensions( fld ) )

	'' Delete the TYPEINI (but not the bounds expressions), no longer needed
	astDelTree( boundstypeini )

	'' Build the REDIM CALL with the bounds expressions
	function = rtlArrayRedim( astBuildVarField( this_, fld ), dimensions, exprTB(), FALSE, (not symbGetDontInit( fld )) )
end function

private function hCallFieldCtors _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr fld = any, this_ = any
	dim as ASTNODE ptr tree = any, boundstypeini = any
	dim as integer skip = any

	tree = NULL
	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

	'' For all real fields, excluding...
	''  - other members like procedures,
	''  - the base field if any; it's initialized separately already
	''  - fake dynamic array fields
	fld = symbGetCompSymbTb( parent ).head
	while( fld )

		if( symbIsField( fld ) ) then
			if( fld <> parent->udt.base ) then
				'' part of an union?
				if( symbGetIsUnionField( fld ) ) then
					tree = astNewLINK( tree, hClearUnionFields( this_, fld, @fld ), AST_LINK_RETURN_NONE )
					'' hClearUnionFields() already skipped to the next field behind the union
					continue while
				else
					'' not initialized?
					if( symbGetTypeIniTree( fld ) = NULL ) then
						tree = astNewLINK( tree, hCallFieldCtor( this_, fld ), AST_LINK_RETURN_NONE )
					elseif( symbIsDynamic( fld ) ) then
						tree = astNewLINK( tree, hInitDynamicArrayField( this_, fld ), AST_LINK_RETURN_NONE )
					else
						'' Note: flushing the field's TYPEINI against the whole "THIS" instance,
						'' not against "THIS.thefield", because the TYPEINI contains absolute offsets.
						tree = astNewLINK( tree, _
						                   astTypeIniFlush( astBuildVarField( this_ ), _
						                   astTypeIniClone( symbGetTypeIniTree( fld ) ), _
						                   FALSE, AST_OPOPT_ISINI ), AST_LINK_RETURN_NONE )
					end if
				end if
			end if
		end if

		fld = fld->next
	wend

	function = tree
end function

private function hCallBaseCtor _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr initree = any
	dim as FBSYMBOL ptr base_ = any, this_ = any, subtype = any, defctor = any

	base_ = parent->udt.base

	'' No base UDT? Then there's nothing to do.
	if( base_ = NULL ) then
		exit function
	end if

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

	'' Do we have a BASE() ctorcall/initializer?
	initree = proc->proc.ext->base_initree
	if( initree ) then
		proc->proc.ext->base_initree = NULL
		return astTypeIniFlush( astBuildVarField( this_ ), initree, FALSE, AST_OPOPT_ISINI )
	end if

	subtype = symbGetSubtype( base_ )
	defctor = symbGetCompDefCtor( subtype )

	'' Otherwise, try to call a default ctor, if any
	if( defctor ) then
		'' Check access here, because (unlike fields) it's not done
		'' during the TYPE compound parsing
		'' Check visibility of the default construtor
		if( symbCheckAccess( defctor ) = FALSE ) then
			errReport( FB_ERRMSG_NOACCESSTOBASEDEFCTOR )
		end if
	'' No default ctor, but others? Then BASE() should have been used,
	'' since a ctor must be called, but we cannot do it automatically.
	elseif( symbGetCompCtorHead( subtype ) ) then
		errReport( FB_ERRMSG_NOBASEINIT )
	end if

	function = hCallFieldCtor( this_, base_ )
end function

private function hInitVptr _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' Only if there is a vptr
	if( symbGetHasRTTI( parent ) = FALSE ) then
		exit function
	end if

	'' The vtable must be present/known for this
	assert( parent->udt.ext->vtable )

	var this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

	'' this.vptr = cast( any ptr, (cast(byte ptr, @vtable) + sizeof(void *) * 2) )
	'' assuming that everything with a vptr extends fb_Object
	function = astNewASSIGN( _
		astBuildVarField( this_, symbUdtGetFirstField( symb.rtti.fb_object ) ), _
		                  astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, _
		                  astNewADDROF( astNewVAR( parent->udt.ext->vtable, env.pointersize * 2 ) ) ), _
		AST_OPOPT_ISINI )
end function

private sub hCallCtors( byval n as ASTNODE ptr, byval sym as FBSYMBOL ptr )
	dim as ASTNODE ptr tree = any
	dim as FBSYMBOL ptr parent = any

	parent = symbGetNamespace( sym )

	'' 1. base ctor (will set vtable ptr according to base)
	tree = hCallBaseCtor( parent, sym )

	'' 2. fields (each field will be constructed, or initialized, or cleared unless =ANY was used on it)
	tree = astNewLINK( tree, hCallFieldCtors( parent, sym ), AST_LINK_RETURN_NONE )

	'' 3. vtable ptr (to point to this class's vtable instead of the base's)
	tree = astNewLINK( tree, hInitVptr( parent, sym ), AST_LINK_RETURN_NONE )

	'' Find the first statement that is executable code,
	'' and insert the constructor calls above it.
	n = astFindFirstCode( n )
	if( n ) then
		n = n->prev
	end if
	astAddAfter( tree, n )
end sub

private sub hCallFieldDtor _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	)

	assert( symbIsDescriptor( fld ) = FALSE )
	assert( symbIsRef( fld ) = FALSE )

	'' Dynamic array field?
	if( symbIsDynamic( fld ) ) then
		'' Always needs clean up, regardless of dtype
		astAdd( rtlArrayErase( astBuildVarField( this_, fld ), TRUE, FALSE ) )
	elseif( symbGetArrayDimensions( fld ) = 0 ) then
		'' Normal field
		if( symbGetType( fld ) = FB_DATATYPE_STRING ) then
			astAdd( rtlStrDelete( astBuildVarField( this_, fld ) ) )
		elseif( symbHasDtor( fld ) ) then
			'' dtor( this.field )
			astAdd( astBuildDtorCall( symbGetSubtype( fld ), astBuildVarField( this_, fld ) ) )
		end if
	else
		'' Fixed-size array field
		if( symbGetType( fld ) = FB_DATATYPE_STRING ) then
			astAdd( rtlArrayErase( astBuildVarField( this_, fld ), FALSE, FALSE ) )
		elseif( symbHasDtor( fld ) ) then
			astAdd( hCallCtorList( FALSE, this_, fld ) )
		end if
	end if

end sub

private sub hCallFieldDtors _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr fld = any, this_ = any

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

	'' For each field (in inverse order)
	''  - excluding non-field members (e.g. methods)
	''  - excluding the base field, that will be destructed separately
	''  - dynamic array descriptor fields: hCallFieldDtor() frees dynamic
	''    array fields by calling ERASE on the fake dynamic array field,
	''    for which astNewARG() will automagically pass the descriptor.
	''  - excluding references (nothing to clean-up)
	fld = symbGetCompSymbTb( parent ).tail
	while( fld )

		if( symbIsField( fld ) ) then
			if( (not symbIsDescriptor( fld )) and (fld <> parent->udt.base) and (not symbIsRef( fld )) ) then
				hCallFieldDtor( this_, fld )
			end if
		end if

		fld = fld->prev
	wend

end sub

private sub hCallDeleteDtor _
	( _
		byval proc as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr parent = any, dtor1 = any, this_ = any
	dim as ASTNODE ptr thisptr = any, tree = any

	parent = symbGetNamespace( proc )
	dtor1 = symbGetCompDtor1( parent )
	if( dtor1 = NULL ) then
		exit sub
	end if
	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )
	thisptr = astNewADDROF( astBuildVarField( this_ ) )
	tree = astBuildDeleteOp( AST_OP_DEL, thisptr )
	astAdd( tree )

end sub

private sub hCallBaseDtor _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr base_ = any, dtor = any, this_ = any

	base_ = parent->udt.base

	'' No base UDT? Then there's nothing to do.
	if( base_ = NULL ) then
		exit sub
	end if

	'' Call its dtor, if there is any.
	''
	'' Note: As in C++, the base class' destructor implementation is called
	'' from this derived class destructor, and no vtable lookup is done
	'' for this (it would just result in infinite recursion anyways).
	''
	'' Just like derived classes are not responsible for initializing their
	'' base class, they shouldn't be made responsible for cleaning it up.

	dtor = symbGetCompDtor1( symbGetSubtype( base_ ) )
	if( dtor = NULL ) then
		exit sub
	end if

	'' Check access here, because (unlike fields) it's not done
	'' during the TYPE compound parsing
	'' Check visibility of the default destructor
	if( symbCheckAccess( dtor ) = FALSE ) then
		errReport( FB_ERRMSG_NOACCESSTOBASEDTOR )
	end if

	'' The only exception is if the base class' destructor is ABSTRACT,
	'' then there is no implementation to call.
	if( symbIsAbstract( dtor ) ) then
		exit sub
	end if

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )
	astAdd( astBuildDtorCall( symbGetSubtype( base_ ), _
	        astBuildVarField( this_, base_ ), _
	        TRUE ) )
end sub

private sub hCallDtors( byval proc as FBSYMBOL ptr )
	dim as FBSYMBOL ptr parent = any

	parent = symbGetNamespace( proc )

	'' 1st) fields dtors
	hCallFieldDtors( parent, proc )

	'' 2nd) base dtor
	hCallBaseDtor( parent, proc )
end sub

private sub hCallStaticCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr _
	)

	astAdd( astTypeIniFlush( sym, astTypeIniClone( initree ), FALSE, AST_OPOPT_ISINI ) )
	astTypeIniDelete( initree )

end sub

private sub hCallStaticDtor( byval sym as FBSYMBOL ptr )
	assert( symbIsReturnByRef( sym ) = FALSE )

	'' dynamic?
	if( symbIsDynamic( sym ) ) then
		astAdd( rtlArrayErase( astBuildVarField( sym, NULL, 0 ), TRUE, FALSE ) )
	else
		'' not an array?
		if( symbGetArrayDimensions( sym ) = 0 ) then
			'' dtor( var )
			astAdd( astBuildDtorCall( symbGetSubtype( sym ), astBuildVarField( sym, NULL, 0 ) ) )
		else
			astAdd( hCallCtorList( FALSE, sym, NULL ) )
		end if
	end if
end sub

private sub hGenStaticInstancesDtors( byval proc as FBSYMBOL ptr )
	dim as TLIST ptr dtorlist = any
	dim as FB_DTORWRAPPER ptr wrap = any
	dim as ASTNODE ptr n = any

	dtorlist = proc->proc.ext->statdtor

	if( dtorlist = NULL ) then
		exit sub
	end if

	'' for each node..
	wrap = listGetHead( dtorlist )
	do while( wrap <> NULL )
		astProcBegin( wrap->proc, FALSE )
		n = ast.proc.curr

		'' call the dtor
		hCallStaticDtor( wrap->sym )

		astProcEnd( FALSE )

		'' must be flushed before the proc that has the static vars, because
		'' they will be removed from hash and symbols table right-after that
		'' proc is flushed
		hProcFlush( n, TRUE )

		wrap = listGetNext( wrap )
	loop

	'' destroy list
	listEnd( dtorlist )
	deallocate( proc->proc.ext->statdtor )
	proc->proc.ext->statdtor = NULL
end sub

'':::::
function astProcAddStaticInstance _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as TLIST ptr dtorlist = any
	dim as FB_DTORWRAPPER ptr wrap = any
	dim as FBSYMBOL ptr proc = any

	assert( symbIsReturnByRef( sym ) = FALSE )

	dtorlist = parser.currproc->proc.ext->statdtor

	'' create a new list
	if( dtorlist = NULL ) then
		dtorlist = xcallocate( len( TLIST ) )
		parser.currproc->proc.ext->statdtor = dtorlist

		listInit( dtorlist, 16, len( FB_DTORWRAPPER ), LIST_FLAGS_NOCLEAR )
	end if

	''
	wrap = listNewNode( dtorlist )

	proc = symbAddProc( symbPreAddProc( NULL ), symbUniqueLabel( ), NULL, FB_DATATYPE_VOID, NULL, _
	                    FB_SYMBATTRIB_PRIVATE, FB_PROCATTRIB_NONE, FB_FUNCMODE_CDECL, FB_SYMBOPT_DECLARING )

	wrap->proc = proc
	wrap->sym = sym

	'' can't be undefined
	symbSetCantUndef( sym )

	function = proc

end function

'':::::
sub astProcAddGlobalInstance _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval call_dtor as integer _
	)

	dim as FB_GLOBINSTANCE ptr wrap = any

	''
	wrap = listNewNode( @ast.globinst.list )

	wrap->sym = sym
	wrap->initree = initree
	wrap->call_dtor = call_dtor

	'' can't be undefined
	symbSetCantUndef( sym )

	if( initree <> NULL ) then
		ast.globinst.ctorcnt += 1
	end if

	if( call_dtor ) then
		ast.globinst.dtorcnt += 1
	end if

end sub

private sub hGlobCtorBegin( byval is_ctor as integer )
	dim as FBSYMBOL ptr proc = any

	'' sub ctorname|dtorname cdecl( ) constructor|destructor
	proc = symbAddProc( symbPreAddProc( NULL ), symbUniqueLabel( ), _
	                    iif( is_ctor, @FB_GLOBCTORNAME, @FB_GLOBDTORNAME ), _
	                    FB_DATATYPE_VOID, NULL, FB_SYMBATTRIB_PRIVATE, FB_PROCATTRIB_NONE, _
	                    FB_FUNCMODE_CDECL, FB_SYMBOPT_DECLARING )

	if( is_ctor ) then
		symbAddGlobalCtor( proc )
	else
		symbAddGlobalDtor( proc )
	end if
	symbSetIsAccessed( proc )
	symbSetIsParsed( proc )

	astProcBegin( proc, FALSE )
end sub

private sub hGenGlobalInstancesCtor( )
	dim as FB_GLOBINSTANCE ptr inst = any
	dim as FBSYMBOL ptr sym = any

	'' any global instance with ctors?
	if( ast.globinst.ctorcnt > 0 ) then
		'' sub ctor cdecl( ) constructor
		hGlobCtorBegin( TRUE )

		'' for each node..
		inst = listGetHead( @ast.globinst.list )
		while( inst )
			'' has ctor/initializer?
			if( inst->initree <> NULL ) then
				hCallStaticCtor( inst->sym, inst->initree )
				inst->initree = NULL
			end if

			inst = listGetNext( inst )
		wend

		'' end sub
		astProcEnd( FALSE )
	end if

	'' any global instance with dtors?
	if( ast.globinst.dtorcnt > 0 ) then
		'' sub dtor cdecl( ) destructor
		hGlobCtorBegin( FALSE )

		'' for each node (in inverse order)..
		inst = listGetTail( @ast.globinst.list )
		while( inst )
			'' need to call dtor?
			if( inst->call_dtor ) then
				hCallStaticDtor( inst->sym )
			end if

			inst = listGetPrev( inst )
		wend

		'' end sub
		astProcEnd( FALSE )
	end if

	'' list will be deleted by astProcListEnd( )
end sub
