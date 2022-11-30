'' DATA stmt nodes (l = head; r = tail)
''
'' chng: dec/2006 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

declare sub hCreateDataDesc( )

sub astDataStmtInit( )
	ast.data.lastsym = NULL
	ast.data.firstsym = NULL
	ast.data.lastlbl = NULL

	'' assuming it's safe to call symb* from here (the desc must be
	'' allocated at module-level or it would be removed if RESTORE
	'' was used with a forward-label inside a proc)
	hCreateDataDesc( )
end sub

function astDataStmtBegin( ) as ASTNODE ptr
	dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_DATASTMT, FB_DATATYPE_INVALID )

	n->data.elmts = 0

	function = n
end function

function astDataStmtStore _
	( _
		byval tree as ASTNODE ptr, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_DATASTMT, FB_DATATYPE_INVALID )

	n->l = expr
	n->r = NULL

	if( tree->l = NULL ) then
		tree->l = n
	else
		tree->r->r = n
	end if

	tree->r = n

	'' check type
	if( expr = NULL ) then
		n->data.id = FB_DATASTMT_ID_LINK

	else
		dim as FBSYMBOL ptr litsym = any

		select case astGetDataType( expr )
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			litsym = astGetStrLitSymbol( expr )
		case else
			litsym = NULL
		end select

		'' string?
		if( litsym <> NULL ) then
			'' not a wstring?
			if( astGetDataType( expr ) <> FB_DATATYPE_WCHAR ) then
				n->data.id = FB_DATASTMT_ID_ZSTR
			'' wstring..
			else
				n->data.id = FB_DATASTMT_ID_WSTR
			end if

		'' scalar..
		else
			'' address of?
			if( astIsOFFSET( expr ) ) then
				n->data.id = FB_DATASTMT_ID_OFFSET
			else
				n->data.id = FB_DATASTMT_ID_CONST
			end if
		end if
	end if

	tree->data.elmts += 1

	function = n

end function

sub astDataStmtEnd( byval tree as ASTNODE ptr )

	dim as FBSYMBOL ptr array = any, elm = any
	dim as integer i = any, id = any
	dim as ASTNODE ptr n = any, expr = any, initree = any
	dim as string littext

	'' add the last node: the link
	astDataStmtStore( tree, NULL )

	'' create/lookup the datadesc array symbol for the last symbol

	array = astDataStmtAdd( NULL, tree->data.elmts )

	'' initialize it
	initree = astTypeIniBegin( FB_DATATYPE_STRUCT, ast.data.desc, TRUE )

	astTypeIniScopeBegin( initree, array, TRUE )

	'' for each node..
	n = tree->l
	for i = 0 to tree->data.elmts - 1
		id = n->data.id
		expr = n->l

		astTypeIniScopeBegin( initree, array, FALSE )

		select case n->data.id
		case FB_DATASTMT_ID_ZSTR
			id = symbGetStrLen( astGetStrLitSymbol( expr ) ) - 1
			expr = astNewADDROF( expr )

		case FB_DATASTMT_ID_WSTR
			id = FB_DATASTMT_ID_WSTR + _
				 (symbGetWstrLen( astGetStrLitSymbol( expr ) ) - 1)
			expr = astNewADDROF( expr )

		case FB_DATASTMT_ID_CONST
			littext = astConstFlushToStr( expr )
			id = len( littext )
			expr = astNewADDROF( astNewCONSTstr( littext ) )

		case FB_DATASTMT_ID_NULL, FB_DATASTMT_ID_LINK
			expr = astNewCONSTi( 0 )

		end select

		'' .id = id
		elm = symbGetUDTSymbTbHead( ast.data.desc )
		astTypeIniAddAssign( initree, _
							 astNewCONSTi( id, FB_DATATYPE_SHORT ), _
							 elm )

		elm = symbGetNext( elm )

		'' .node = expr
		astTypeIniAddAssign( initree, expr, elm )

		astTypeIniScopeEnd( initree, array )

		'' next
		dim as ASTNODE ptr nxt = n->r
		astDelNode( n )
		n = nxt
	next

	''
	astTypeIniScopeEnd( initree, array )

	astTypeIniEnd( initree, TRUE )

	symbSetTypeIniTree( array, initree )

	'' Link the previous DATA stmt to this new one
	if( ast.data.lastsym <> NULL ) then
		'' lastarray(ubound(lastarray)).next = @array(0)
		initree = symbGetTypeIniTree( astGetLastDataStmtSymbol( ) )

		n = initree->l
		var tn = n
		do while( n->r <> NULL )
			if( n->class = AST_NODECLASS_TYPEINI_ASSIGN ) then
				tn = n
			end if
			n = n->r
		loop

		'' del the NULL expr
		astDelNode( tn->l )

		'' replace the node
		tn->l = astNewADDROF( astNewVAR( array ) )
	end if

	'' datadesc arrays can reference the next datadesc array (link to next
	'' DATA stmt as patched in above) or previous ones (those that were
	'' pre-declared for RESTORE <label>).
	'' For the C backend we must set up a reverse linked list allowing it to
	'' cleanly emit the datadesc arrays without running into declaration
	'' order issues.
	array->var_.data.prev = ast.data.lastsym

	ast.data.lastsym = array
	if( ast.data.firstsym = NULL ) then
		ast.data.firstsym = array
	end if

end sub

function astDataStmtAdd _
	( _
		byval label as FBSYMBOL ptr, _
		byval elements as integer _
	) as FBSYMBOL ptr

	static as string id
	static as FBARRAYDIM dTB(0 to 0)
	dim as FBSYMBOL ptr sym = any, lastlabel = any

	if( label = NULL ) then
		'' Called for DATA statement end, or RESTORE without label
		'' Create the static datadesc array
		lastlabel = symbGetLastLabel( )

		if( (lastlabel = NULL) or (ast.data.lastlbl = lastlabel) ) then
			'' no label at all/still under the same label
			id = *symbUniqueLabel( )
		else
			ast.data.lastlbl = lastlabel

			'' static datadesc array id specifically for that label
			'' (it may be looked up by RESTORE later, see below)
			id = FB_DATASTMT_PREFIX + *symbGetName( lastlabel )
		end if

		dTB(0).upper = elements - 1
	else
		'' Called for RESTORE <label>
		'' static datadesc array id specifically for that label
		'' (if <label> is a forward reference, then this datadesc array
		'' may be looked up by astDataStmtEnd() later,
		'' when the corresponding DATA is found)
		id = FB_DATASTMT_PREFIX + *symbGetName( label )
		dTB(0).upper = 0
	end if

	sym = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), id, FB_SYMBCLASS_VAR, TRUE, FALSE )

	'' already declared?
	if( sym <> NULL ) then
		if( label = NULL ) then
			'' reset the array dimensions
			symbSetArrayDimTb( sym, 1, dTB() )
			symbMaybeAddArrayDesc( sym )
		end if
		return sym
	end if

	sym = symbAddVar( id, symbUniqueLabel( ), _
	                  FB_DATATYPE_STRUCT, ast.data.desc, 0, _
	                  1, dTB(), _
	                  FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC, _
	                  FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE )

	'' (set by astDataStmtEnd())
	sym->var_.data.prev = NULL

	function = sym
end function

private sub hCreateDataDesc( )
	static as FBARRAYDIM dTB(0)

	'' Using FIELD = 1, to pack it as done by the rtlib
	ast.data.desc = symbStructBegin( NULL, NULL, NULL, "__FB_DATADESC$", NULL, FALSE, 1, FALSE, 0, 0 )

	'' type as short
	symbAddField( ast.data.desc, "type", 0, dTB(), _
	              FB_DATATYPE_SHORT, NULL, 0, 0, 0 )

	'' node as FB_DATASTMT_NODE (no need to create an UNION, all fields are pointers)
	symbAddField( ast.data.desc, "node", 0, dTB(), _
	              typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

	symbStructEnd( ast.data.desc )
end sub
