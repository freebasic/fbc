'' AST type initializer nodes
'' tree	    : l = head; r = (when constructing: tail, when updating: base var)
'' expr node: l = expr; r = next
'' pad node : l = NULL; r = next
''
'' chng: mar/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
function astTypeIniBegin _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval is_local as integer, _
		byval ofs as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_TYPEINI, _
					dtype, _
					subtype )
	function = n

	n->typeini.ofs = ofs

	dim as integer add_scope = FALSE
	if( is_local = FALSE ) then
		if( symbIsScope( parser.currblock ) ) then
			add_scope = astGetClass( parser.currblock->scp.backnode ) <> AST_NODECLASS_TYPEINI
		else
		    add_scope = TRUE
		end if
	end if

	if( add_scope ) then
		'' create a new scope block to handle temp vars allocated inside the
		'' tree - with shared vars, the temps must be moved to another function
    	dim as FBSYMBOL ptr s = symbAddScope( n )

		n->typeini.scp = s
		n->typeini.lastscp = parser.currblock

		parser.scope += 1
		parser.currblock = s

		symbSetCurrentSymTb( @s->scp.symtb )

	else
		n->typeini.scp = NULL
	end if

end function

'':::::
sub astTypeIniEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval is_initializer as integer _
	)

    dim as ASTNODE ptr n = any, p = any, l = any, r = any
    dim as integer ofs = any

	'' can't leave r pointing to the any node as the
	'' tail node is linked already
	tree->r = NULL

	if( is_initializer = FALSE ) then
		ast.typeinicnt += 1
	end if

	'' merge nested type ini trees
    p = NULL
    n = tree->l
    do while( n <> NULL )
    	'' expression node?
    	if( n->class = AST_NODECLASS_TYPEINI_ASSIGN ) then
			l = n->l
			'' is it an ini tree too?
			if( l->class = AST_NODECLASS_TYPEINI ) then
				ast.typeinicnt -= 1

    			ofs = n->typeini.ofs

    			r = n->r
    			astDelNode( n )
    			n = l->l
    			astDelNode( l )

    			'' relink
    			if( p <> NULL ) then
    				p->r = n
    			else
    				tree->l = n
    			end if

    			'' update the offset, using the parent's
    			do while( n->r <> NULL )
    				n->typeini.ofs += ofs
    				n = n->r
    			loop
    			n->typeini.ofs += ofs

    			n->r = r
			end if
		end if

		'' next
		p = n
		n = n->r
	loop

	'' close the scope block
	if( tree->typeini.scp <> NULL ) then
		'' remove symbols from hash table
		symbDelScopeTb( tree->typeini.scp )

		'' back to preview symbol tb
		symbSetCurrentSymTb( tree->typeini.scp->symtb )

		symbFreeSymbol_UnlinkOnly( tree->typeini.scp )

		parser.currblock = tree->typeini.lastscp
		parser.scope -= 1
	end if

end sub

'':::::
private function hAddNode _
	( _
		byval tree as ASTNODE ptr, _
		byval class_ as AST_NODECLASS, _
		byval dtype as FB_DATATYPE, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr static

	dim as ASTNODE ptr n

	n = astNewNode( class_, dtype, subtype )

	if( tree->r <> NULL ) then
		tree->r->r = n
	else
		tree->l = n
	end if

    tree->r = n

    function = n

end function

'':::::
function astTypeIniAddPad _
	( _
		byval tree as ASTNODE ptr, _
		byval bytes as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = hAddNode( tree, _
				  AST_NODECLASS_TYPEINI_PAD, _
				  FB_DATATYPE_INVALID, _
				  NULL )

	n->typeini.bytes = bytes
	n->typeini.ofs = tree->typeini.ofs

	function = n

end function

'':::::
function astTypeIniAddAssign _
	( _
		byval tree as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = hAddNode( tree, _
				  AST_NODECLASS_TYPEINI_ASSIGN, _
				  symbGetFullType( sym ), _
				  symbGetSubtype( sym ) )

	n->l = expr
	n->sym = sym
	n->typeini.ofs = tree->typeini.ofs

	tree->typeini.ofs += symbGetLen( sym )

	function = n

end function

'':::::
function astTypeIniAddCtorCall _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval procexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = hAddNode( tree, _
				  AST_NODECLASS_TYPEINI_CTORCALL, _
				  symbGetFullType( sym ), _
				  symbGetSubtype( sym ) )

	n->sym = sym
	n->typeini.ofs = tree->typeini.ofs
	n->l = procexpr

	tree->typeini.ofs += symbGetLen( sym )

	function = n

end function

'':::::
function astTypeIniAddCtorList _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval elements as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = hAddNode( tree, _
				  AST_NODECLASS_TYPEINI_CTORLIST, _
				  symbGetFullType( sym ), _
				  symbGetSubtype( sym ) )

	n->sym = sym
	n->typeini.ofs = tree->typeini.ofs
	n->typeini.elements = elements

	tree->typeini.ofs += symbGetLen( sym ) * elements

	function = n

end function

'':::::
function astTypeIniScopeBegin _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = hAddNode( tree, _
				  AST_NODECLASS_TYPEINI_SCOPEINI, _
				  FB_DATATYPE_INVALID, _
				  NULL )

	n->sym = sym

	function = n

end function

'':::::
function astTypeIniScopeEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = hAddNode( tree, _
				  AST_NODECLASS_TYPEINI_SCOPEEND, _
				  FB_DATATYPE_INVALID, _
				  NULL )

	n->sym = sym

	function = n

end function

'' Takes an array elements initializer and adds the same TYPEINI_ASSIGN's to
'' the new typeini tree (duplicating the expressions),
'' but not the TYPEINI_SCOPEINI/TYPEINI_SCOPEEND,
'' and assuming there are only TYPEINI_ASSIGN's and no ctorcalls or padding etc.
'' "beginindex" is the index of the first TYPEINI_ASSIGN that should be copied,
'' this allows to skip some array elements at the front.
sub astTypeIniCopyElements _
	( _
		byval tree as ASTNODE ptr, _
		byval source as ASTNODE ptr, _
		byval beginindex as integer _
	)

	dim as integer i = any

	assert( source->class = AST_NODECLASS_TYPEINI )
	source = source->l

	assert( source->class = AST_NODECLASS_TYPEINI_SCOPEINI )
	source = source->r

	i = 0
	while( source->class = AST_NODECLASS_TYPEINI_ASSIGN )
		if( i >= beginindex ) then
			astTypeIniAddAssign( tree, astCloneTree( source->l ), source->sym )
		end if
		source = source->r
		i += 1
	wend

	assert( source->class = AST_NODECLASS_TYPEINI_SCOPEEND )
end sub

sub astTypeIniReplaceElement _
	( _
		byval tree as ASTNODE ptr, _
		byval element as integer, _
		byval expr as ASTNODE ptr _
	)

	'' Walk through the TYPEINI tree until the assign at index "element"
	'' is reached, then replace the expression.
	'' assumptions:
	''    - tree is an array initializer,
	''    - there are only TYPEINI_ASSIGN's, no ctorcalls/padding

	dim as integer i = any

	assert( tree->class = AST_NODECLASS_TYPEINI )
	tree = tree->l

	assert( tree->class = AST_NODECLASS_TYPEINI_SCOPEINI )
	tree = tree->r

	i = 0
	while( tree->class = AST_NODECLASS_TYPEINI_ASSIGN )
		if( i = element ) then
			astDelTree( tree->l )
			tree->l = expr
			exit sub
		end if
		tree = tree->r
		i += 1
	wend

	'' should always be found
	assert( FALSE )
end sub

'':::::
private function hCallCtor _
	( _
		byval flush_tree as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr fld = any
	dim as integer ofs = n->typeini.ofs

	fld = n->sym
	if( fld <> NULL ) then
		if( symbIsField( fld ) = FALSE ) then
			fld = NULL
		else
			'' Hack'ish, but astBuildVarField() adds
			'' this back on if fld <> NULL even
			'' n->typeini.ofs is the offset needed.
			ofs -= symbGetOfs( fld )
		end if
	end if

	'' replace the instance pointer
	n->l = astPatchCtorCall( n->l, _
							 astBuildVarField( basesym, fld, ofs ) )

	'' do call
	flush_tree = astNewLINK( flush_tree, n->l )

	function = flush_tree

end function

'':::::
private function hCallCtorList _
	( _
		byval flush_tree as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr subtype = any, fld = any
	dim as ASTNODE ptr fldexpr = any
	dim as integer dtype = any, elements = any

	fld = n->sym
	if( fld <> NULL ) then
		if( symbIsField( fld ) = FALSE ) then
			fld = NULL
		end if
	end if

	dtype = astGetDataType( n )
	subtype = n->subtype
	elements = n->typeini.elements

	'' iter = *cast( subtype ptr, cast( byte ptr, @array(0) ) + ofs) )
	fldexpr = astBuildVarField( basesym, fld, n->typeini.ofs )

	if( elements > 1 ) then
		dim as FBSYMBOL ptr cnt, label, iter

		cnt = symbAddTempVar( FB_DATATYPE_INTEGER, NULL, FALSE )
		label = symbAddLabel( NULL )
		iter = symbAddTempVar( typeAddrOf( dtype ), subtype, FALSE )

		flush_tree = astNewLINK( flush_tree, astBuildVarAssign( iter, astNewADDROF( fldexpr ) ) )

		'' for cnt = 0 to elements-1
		flush_tree = astBuildForBegin( flush_tree, cnt, label, 0 )

		'' ctor( *iter )
		flush_tree = astNewLINK( flush_tree, astBuildCtorCall( subtype, astBuildVarDeref( iter ) ) )

		'' iter += 1
		flush_tree = astNewLINK( flush_tree, astBuildVarInc( iter, 1 ) )

		'' next
		flush_tree = astBuildForEnd( flush_tree, cnt, label, 1, astNewCONSTi( elements ) )
	else
		'' ctor( this )
		flush_tree = astNewLINK( flush_tree, astBuildCtorCall( subtype, fldexpr ) )
	end if

	function = flush_tree

end function

'':::::
private function hFlushTree _
	( _
		byval tree as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr, _
		byval do_deref as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any, nxt = any, flush_tree = any, lside = any
	dim as FBSYMBOL ptr bitfield = any
	dim as integer dtype = any

	flush_tree = NULL
	n = tree->l
	do while( n <> NULL )
		nxt = n->r

		select case as const n->class
		case AST_NODECLASS_TYPEINI_ASSIGN
			''
			'' basesym is the initialization target,
			'' either the object itself or a pointer to the target.
			''
			'' n->sym (symbol associated with the TYPEINI_ASSIGN) is
			'' the symbol that's directly initialized by this
			'' TYPEINI_ASSIGN.
			'' It can be the same as basesym, e.g. when initializing
			'' a simple integer, or it can be a field while basesym
			'' is the UDT or a pointer to it, and it can be NULL too,
			'' at least with some parameter initializers.
			''

			if( symbIsParamInstance( basesym ) ) then
				'' Assigning to object through THIS pointer, a DEREF is done.
				lside = astBuildInstPtrAtOffset( basesym, n->sym, n->typeini.ofs )
			else
				if( do_deref ) then
					'' Assigning to object through pointer, a DEREF is done.
					assert( n->sym )

					''
					'' Must make sure to have the proper type on the DEREF,
					'' otherwise the ASSIGN to it will fail or be wrong and
					'' possibly cause trouble with the backends.
					''
					'' We need to do a typeDeref() if it's the basesym pointer,
					'' but not if it's something else (e.g. a field).
					'' TODO: is this check correct/enough?
					''
					dtype = n->dtype
					if( n->sym = basesym ) then
						assert( typeIsPtr( dtype ) )
						dtype = typeDeref( dtype )
					end if

					lside = astNewDEREF( astNewVAR( basesym ), dtype, n->subtype, n->typeini.ofs )
				else
					'' Assigning to object directly
					'' Note: n->sym may be NULL (from a astReplaceSymbolOnTree(), so n's dtype/subtype are used instead.
					lside = astNewVAR( basesym, n->typeini.ofs, astGetFullType( n ), n->subtype )
				end if

				if( n->sym ) then
					'' Field?
					if( symbIsField( n->sym ) ) then
						'' If it's a bitfield, clear the whole field containing this bitfield,
						'' otherwise the bitfield assignment(s) would leave unused bits
						'' uninitialized.

						'' Bitfield?
						if( astGetDataType( lside ) = FB_DATATYPE_BITFIELD ) then
							bitfield = astGetSubType( lside )
							assert( symbIsBitfield( bitfield ) )
							assert( typeGetClass( symbGetType( bitfield ) ) = FB_DATACLASS_INTEGER )

							'' Beginning of a field containing one or more bitfields?
							if( bitfield->bitfld.bitpos = 0 ) then
								flush_tree = astNewLINK( flush_tree, _
									astNewMEM( AST_OP_MEMCLEAR, _
										astCloneTree( lside ), _
										astNewCONSTi( typeGetSize( symbGetType( bitfield ) ) ) ) )
							end if
						end if

						lside = astNewFIELD( lside, n->sym, astGetFullType( n ), n->subtype )
					end if
				end if
			end if

			lside = astNewASSIGN( lside, n->l, AST_OPOPT_ISINI or AST_OPOPT_DONTCHKPTR )
			assert( lside <> NULL )
			flush_tree = astNewLINK( flush_tree, lside )

		case AST_NODECLASS_TYPEINI_PAD
			'' Clear some padding bytes...
			if( symbIsParamInstance( basesym ) ) then
				'' through THIS pointer
				lside = astBuildInstPtrAtOffset( basesym, NULL, n->typeini.ofs )
			else
				dtype = symbGetFullType( basesym )

				if( do_deref ) then
					'' through a pointer
					assert( typeIsPtr( dtype ) )
					lside = astNewDEREF( astNewVAR( basesym ), typeDeref( dtype ), symbGetSubtype( basesym ), n->typeini.ofs )
				else
					'' directly
					lside = astNewVAR( basesym, n->typeini.ofs )
				end if
			end if

			flush_tree = astNewLINK( flush_tree, _
				astNewMEM( AST_OP_MEMCLEAR, lside, astNewCONSTi( n->typeini.bytes ) ) )

		case AST_NODECLASS_TYPEINI_CTORCALL
			flush_tree = hCallCtor( flush_tree, n, basesym )

		case AST_NODECLASS_TYPEINI_CTORLIST
			flush_tree = hCallCtorList( flush_tree, n, basesym )

		end select

		astDelNode( n )
		n = nxt
	loop

	function = flush_tree
end function

'':::::
private function hFlushExprStatic _
	( _
		byval n as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr _
	) as integer

	dim as ASTNODE ptr expr = any
	dim as integer edtype = any, sdtype = any
	dim as FBSYMBOL ptr sym = any, litsym = any

	function = FALSE

	expr = n->l
	sym = n->sym
	edtype = astGetDataType( expr )
	sdtype = symbGetType( sym )

	litsym = NULL
	select case edtype
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr )
	end select

	'' not a literal string?
	if( litsym = NULL ) then

    	'' offset?
		if( astIsOFFSET( expr ) ) then
			irEmitVARINIOFS( astGetSymbol( expr ), expr->ofs.ofs )

		'' anything else
		else
			'' different types?
			if( edtype <> sdtype ) then
				if( typeIsPtr( symbGetFullType( sym ) ) ) then
					'' Cast pointers to ANY PTR first to prevent issues with derived UDT ptrs,
					'' which astNewCONV() currently doesn't allow to be casted to/from other ptr
					'' types directly. Used at least by array descriptor initialization.
					'' Pointer is pointer anyways, it shouldn't make a difference to the backend.
					expr = astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, expr )
				end if

				expr = astNewCONV( symbGetFullType( sym ), symbGetSubtype( sym ), expr )
				assert( expr <> NULL )

				'' shouldn't happen, but..
				if( expr = NULL ) then
					errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
					expr = astNewCONSTi( 0 )
				end if
			end if

			select case as const( sdtype )
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				irEmitVARINI64( sdtype, astGetValLong( expr ) )

			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				irEmitVARINIf( sdtype, astGetValFloat( expr ) )

			case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
				if( FB_LONGSIZE = len( integer ) ) then
					irEmitVARINIi( sdtype, astGetValInt( expr ) )
				else
					irEmitVARINI64( sdtype, astGetValLong( expr ) )
				end if

			case else
				irEmitVARINIi( sdtype, astGetValInt( expr ) )
			end select
		end if

	'' literal string..
	else
		'' not a wstring?
		if( sdtype <> FB_DATATYPE_WCHAR ) then

			'' convert?
			if( edtype <> FB_DATATYPE_WCHAR ) then
				'' less the null-char
				irEmitVARINISTR( symbGetStrLen( sym ) - 1, _
						 	 	 symbGetVarLitText( litsym ), _
						 	 	 symbGetStrLen( litsym ) - 1 )
			else
				'' ditto
				irEmitVARINISTR( symbGetStrLen( sym ) - 1, _
						 	 	 str( *symbGetVarLitTextW( litsym ) ), _
						 	 	 symbGetWstrLen( litsym ) - 1 )
			end if


		'' wstring..
		else

			'' convert?
			if( edtype <> FB_DATATYPE_WCHAR ) then
				'' less the null-char
				irEmitVARINIWSTR( symbGetWstrLen( sym ) - 1, _
						 	  	  wstr( *symbGetVarLitText( litsym ) ), _
						 	  	  symbGetStrLen( litsym ) - 1 )
			else
				'' ditto
				irEmitVARINIWSTR( symbGetWstrLen( sym ) - 1, _
						 	  	  symbGetVarLitTextW( litsym ), _
						 	  	  symbGetWstrLen( litsym ) - 1 )
			end if

		end if

	end if

	astDelTree( n->l )
	n->l = NULL

	function = TRUE

end function

'':::::
private function hFlushTreeStatic _
	( _
		byval tree as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr _
	) as integer

    dim as ASTNODE ptr n = any, nxt = any

	function = FALSE

	irEmitVARINIBEGIN( basesym )

    n = tree->l
    do while( n <> NULL )
        nxt = n->r

    	select case as const n->class
    	case AST_NODECLASS_TYPEINI_PAD
    		irEmitVARINIPAD( n->typeini.bytes )

    	case AST_NODECLASS_TYPEINI_SCOPEINI
			irEmitVARINISCOPEBEGIN( )

    	case AST_NODECLASS_TYPEINI_SCOPEEND
			irEmitVARINISCOPEEND( )

    	case else
			hFlushExprStatic( n, basesym )
    	end select

        astDelNode( n )
    	n = nxt
    loop

	irEmitVARINIEND( basesym )

	function = TRUE

end function

'':::::
private sub hRelinkTemps _
	( _
		byval tree as ASTNODE ptr, _
		byval clone_tree as ASTNODE ptr _
	) static

	if( tree->typeini.scp = NULL ) then
		exit sub
	end if

	dim as FBSYMBOL ptr sym = any

	'' different trees?
	if( clone_tree <> NULL ) then
		sym = symbGetScopeSymbTbHead( tree->typeini.scp )
		do while( sym <> NULL )
			astReplaceSymbolOnTree( clone_tree, sym, symbCloneSymbol( sym ) )

			sym = sym->next
		loop

	'' same tree, don't let the old symbols leak..
	else
		dim as FBSYMBOL ptr nxt = any

		sym = symbGetScopeSymbTbHead( tree->typeini.scp )
		do while( sym <> NULL )
			nxt = sym->next

			astReplaceSymbolOnTree( tree, sym, symbCloneSymbol( sym ) )

			symbFreeSymbol_RemOnly( sym )

			sym = nxt
		loop

		symbFreeSymbol_RemOnly( tree->typeini.scp )

		tree->typeini.scp = NULL
	end if

end sub

'':::::
private sub hDelTemps _
	( _
		byval tree as ASTNODE ptr _
	) static

	dim as FBSYMBOL ptr sym_head = any

	if( tree->typeini.scp = NULL ) then
		exit sub
	end if

	dim as FBSYMBOL ptr sym = any, nxt = any

	sym = symbGetScopeSymbTbHead( tree->typeini.scp )
	do while( sym <> NULL )
		nxt = sym->next

		symbFreeSymbol_RemOnly( sym )

		sym = nxt
	loop

	''
	symbFreeSymbol_RemOnly( tree->typeini.scp )

	tree->typeini.scp = NULL

end sub

'':::::
function astTypeIniFlush _
	( _
		byval tree as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr, _
		byval options as AST_INIOPT _
	) as ASTNODE ptr

	'' quick workaround for #2688314: tree can be null in some cases, so can't do assert
	'' TODO: find out why, but for now, only cases seem to be when errors exceed -maxerr
	#if 0
	assert( tree <> NULL )
	#else
	if( tree = NULL ) then return NULL
	#endif

	if( (options and AST_INIOPT_ISINI) = 0 ) then
		ast.typeinicnt -= 1
	end if

	if( (options and AST_INIOPT_RELINK) <> 0 ) then
		hRelinkTemps( tree, NULL )
	end if

	if( (options and AST_INIOPT_ISSTATIC) <> 0 ) then
		hFlushTreeStatic( tree, basesym )
		function = NULL
	else
		function = hFlushTree( tree, basesym, ((options and AST_INIOPT_DODEREF) <> 0) )
	end if

	if( (options and AST_INIOPT_RELINK) <> 0 ) then
		hDelTemps( tree )
	end if

	astDelNode( tree )

end function

'':::::
private function hExprIsConst _
	( _
		byval n as ASTNODE ptr _
	) as integer

    dim as FBSYMBOL ptr sym = any, litsym = any
    dim as ASTNODE ptr expr = any
    dim as integer sdtype = any, edtype = any

    sym = n->sym
    expr = n->l

    sdtype = symbGetType( sym )
    edtype = astGetDataType( expr )

	'' check if it's a literal string
	litsym = NULL
	select case edtype
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr )
	end select

	'' not a literal string?
	if( litsym = NULL ) then

		'' string?
		if( symbIsString( sdtype ) ) then
			if( symbIsString( edtype ) ) then
				errReport( FB_ERRMSG_EXPECTEDCONST, TRUE )
			else
				errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			end if
			exit function

		elseif( symbIsString( edtype ) ) then
		    errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			exit function
		end if

		'' bit field?
		if( symbIsField( sym ) ) then
		    if( symbGetType( sym ) = FB_DATATYPE_BITFIELD ) then
		    	errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				exit function
			end if
		end if

		'' offset?
		if( astIsOFFSET( expr ) ) then

			'' different types?
			if( (typeGetClass( sdtype ) <> FB_DATACLASS_INTEGER) or _
				(typeGetSize( sdtype ) <> FB_POINTERSIZE) ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				exit function
			end if

		else
			'' not a constant?
			if( astIsCONST( expr ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTEDCONST, TRUE )
				exit function
			end if

		end if

	'' literal string..
	else
		'' not a string?
		if( symbIsString( sdtype ) = FALSE ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			exit function
		end if

		'' can't be a variable-len string
		if( sdtype = FB_DATATYPE_STRING ) then
			errReport( FB_ERRMSG_CANTINITDYNAMICSTRINGS, TRUE )
			exit function
		end if

	end if

	function = TRUE

end function

'':::::
function astTypeIniIsConst _
	( _
		byval tree as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr n = any

	function = FALSE

    n = tree->l
    do while( n <> NULL )

    	select case n->class
    	case AST_NODECLASS_TYPEINI_ASSIGN
			if( hExprIsConst( n ) = FALSE ) then
				exit function
			end if

    	case AST_NODECLASS_TYPEINI_CTORCALL, AST_NODECLASS_TYPEINI_CTORLIST
    		exit function
    	end select

    	n = n->r
    loop

	function = TRUE

end function

'':::::
function astTypeIniCheckScope _
	( _
		byval n as ASTNODE ptr _
	) as integer

	dim as FBSYMBOL ptr sym = any

	function = FALSE

	if( n <> NULL ) then

    	select case n->class
		case AST_NODECLASS_VAR, AST_NODECLASS_CONST

			sym = astGetSymbol( n )
			if( sym <> NULL ) then

				if( ((symbGetAttrib( sym ) and (FB_SYMBATTRIB_SHARED or _
				 						   FB_SYMBATTRIB_COMMON or _
				 						   FB_SYMBATTRIB_STATIC or _
										   FB_SYMBATTRIB_DESCRIPTOR or _
				 						   FB_SYMBATTRIB_TEMP)) = 0) ) then
					return TRUE
				end if

			end if

		end select

		if( n->l <> NULL ) then
			if( astTypeIniCheckScope( n->l ) ) then
				return TRUE
			end if
		end if

		if( n->r <> NULL ) then
			if( astTypeIniCheckScope( n->r ) ) then
				return TRUE
			end if
		end if

	end if

end function

private function hWalk _
	( _
		byval n as ASTNODE ptr, _
		byval parent as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any
	dim as FBSYMBOL ptr sym = any

	if( n = NULL ) then
		return NULL
	end if

	if( n->class = AST_NODECLASS_TYPEINI ) then
		'' Create a temporary variable which is initialized by the
		'' astTypeIniFlush() below.
		sym = symbAddTempVar( astGetFullType( n ), n->subtype, FALSE )

		'' Update the parent node in the original tree to access the
		'' temporary variable, instead of the TYPEINI. (it could be an
		'' ASSIGN, ADDROF, ARG, etc...)
		if( parent ) then
			expr = astNewVAR( sym )
			if( parent->l = n ) then
				parent->l = expr
			else
				parent->r = expr
			end if
		end if

		return astTypeIniFlush( n, sym, AST_INIOPT_NONE )
	end if

	'' walk
	return astNewLINK( hWalk( n->l, n ), hWalk( n->r, n ) )
end function

function astTypeIniUpdate( byval tree as ASTNODE ptr ) as ASTNODE ptr
	if( ast.typeinicnt <= 0 ) then
		return tree
	end if

	'' Walk to expand any TYPEINIs. Note that the original tree will be
	'' updated too, and both are needed.
	return astNewLINK( hWalk( tree, NULL ), tree )
end function

'':::::
sub astTypeIniUpdCnt _
	( _
		byval tree as ASTNODE ptr _
	)

	if( tree->class = AST_NODECLASS_TYPEINI ) then
		ast.typeinicnt += 1
	end if

	'' walk
	if( tree->l <> NULL ) then
		astTypeIniUpdCnt( tree->l )
	end if

	if( tree->r <> NULL ) then
		astTypeIniUpdCnt( tree->r )
	end if

end sub

'':::::
function astTypeIniClone _
	( _
		byval tree as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr clone_tree = astCloneTree( tree )

	clone_tree->typeini.scp = NULL

	hRelinkTemps( tree, clone_tree )

	function = clone_tree

end function


