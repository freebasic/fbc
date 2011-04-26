'' DATA stmt nodes (l = head; r = tail)
''
'' chng: dec/2006 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

declare sub hCreateDataDesc _
	( _
	)

'':::::
sub astDataStmtInit _
	( _
	)

	ast.data.lastsym = NULL
	ast.data.firstsym = NULL
	ast.data.lastlbl = NULL

	'' assuming it's safe to call symb* from here (the desc must be
	'' allocated at module-level or it would be removed if RESTORE
	'' was used with a forward-label inside a proc)
	hCreateDataDesc( )

end sub

'':::::
function astDataStmtBegin _
	( _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_DATASTMT, FB_DATATYPE_INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->data.elmts = 0

	function = n

end function

'':::::
function astDataStmtStore _
	( _
		byval tree as ASTNODE ptr, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_DATASTMT, FB_DATATYPE_INVALID )
	if( n = NULL ) then
		return NULL
	end if

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

'':::::
sub astDataStmtEnd _
	( _
		byval tree as ASTNODE ptr _
	)

    dim as FBSYMBOL ptr array = any, elm = any
    dim as integer i = any, id = any
    dim as ASTNODE ptr n = any, expr = any, initree = any
    dim as string littext

    '' add the last node: the link
    astDataStmtStore( tree, NULL )

    '' create a static shared array(0 to data->elements-1) as FB_DATASTMT symbol

	array = astDataStmtAdd( NULL, tree->data.elmts )

	'' initialize it
	initree = astTypeIniBegin( FB_DATATYPE_STRUCT, ast.data.desc, TRUE )

	astTypeIniScopeBegin( initree, NULL )

	'' for each node..
	n = tree->l
	for i = 0 to tree->data.elmts - 1
		id = n->data.id
		expr = n->l

		astTypeIniScopeBegin( initree, NULL )

		select case n->data.id
		case FB_DATASTMT_ID_ZSTR
			id = symbGetStrLen( astGetStrLitSymbol( expr ) ) - 1
			expr = astNewADDROF( expr )

		case FB_DATASTMT_ID_WSTR
			id = FB_DATASTMT_ID_WSTR + _
				 (symbGetWstrLen( astGetStrLitSymbol( expr ) ) - 1)
			expr = astNewADDROF( expr )

		case FB_DATASTMT_ID_CONST
			littext = astGetValueAsStr( expr )
			id = len( littext )
			expr = astNewADDROF( astNewCONSTstr( littext ) )

		case FB_DATASTMT_ID_NULL, FB_DATASTMT_ID_LINK
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )

		end select

		'' .id = id
		elm = symbGetUDTSymbTbHead( ast.data.desc )
		astTypeIniAddAssign( initree, _
							 astNewCONSTi( id, FB_DATATYPE_SHORT ), _
							 elm )

    	astTypeIniSeparator( initree, NULL )
    	elm = symbGetNext( elm )

        '' .node = expr
		astTypeIniAddAssign( initree, expr, elm )

    	astTypeIniScopeEnd( initree, NULL )

    	'' next
		dim as ASTNODE ptr nxt = n->r
		astDelNode( n )
		n = nxt

		if( n ) then
			astTypeIniSeparator( initree, NULL )
		end if
	next

    ''
    astTypeIniScopeEnd( initree, NULL )

    astTypeIniEnd( initree, TRUE )

    symbSetTypeIniTree( array, initree )
    symbSetIsInitialized( array )

	'' link the last data to this one
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
    	tn->l = astNewADDROF( astNewVAR( array, _
    									 0, _
    									 FB_DATATYPE_STRUCT, _
    									 ast.data.desc ) )
	end if

	ast.data.lastsym = array

	if( ast.data.firstsym = NULL ) then
		ast.data.firstsym = array
	end if

end sub

'':::::
private function hCreateDataId _
	( _
	) as zstring ptr

    static as string id

    dim as FBSYMBOL ptr label = symbGetLastLabel( )

    if( (label = NULL) or (ast.data.lastlbl = label) ) then
    	return hMakeTmpStr( )
    end if

    ast.data.lastlbl = label

    '' create a id that can be lookup by RESTORE later
    id = FB_DATASTMT_PREFIX + *symbGetName( label )

    function = strptr( id )

end function

'':::::
function astDataStmtAdd _
	( _
		byval label as FBSYMBOL ptr, _
		byval elements as integer _
	) as FBSYMBOL ptr

	static as string id
    static as FBARRAYDIM dTB(0 to 0)
    dim as FBSYMBOL ptr sym = any

	if( label = NULL ) then
		id = *hCreateDataId( )
		dTB(0).upper = elements - 1

	else
		id = FB_DATASTMT_PREFIX + *symbGetName( label )
		dTB(0).upper = 0
	end if

    sym = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), _
    						    	id, _
    						    	FB_SYMBCLASS_VAR, _
    						    	TRUE, _
    						    	FALSE )
    '' already declared?
	if( sym <> NULL ) then
    	if( label = NULL ) then
			'' reset the array dimensions
    		symbSetArrayDimTb( sym, 1, dTB() )
    	end if

		return sym
	end if

	sym = symbAddVarEx( id, _
					  	hMakeTmpStr( ), _
					  	FB_DATATYPE_STRUCT, _
					  	ast.data.desc, _
					  	len( FB_DATADESC ), _
					  	1, _
					  	dTB(), _
					  	FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC, _
					  	FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE )

	sym->var_.data.prev = astGetLastDataStmtSymbol( )

	function = sym

end function

'':::::
private sub hCreateDataDesc _
	( _
	)

	static as FBARRAYDIM dTB(0)

   	ast.data.desc = symbStructBegin( NULL, "__FB_DATADESC$", NULL, FALSE, 1 )

	'' type	as short
	symbAddField( ast.data.desc, _
				  "type", _
				  0, dTB(), _
				  FB_DATATYPE_SHORT, NULL, _
				  2, 0 )

	'' node	as FB_DATASTMT_NODE (no need to create an UNION, all fields are pointers)
	symbAddField( ast.data.desc, _
				  "node", _
				  0, dTB(), _
				  typeAddrOf( FB_DATATYPE_VOID ), NULL, _
				  FB_POINTERSIZE, 0 )

    ''
	symbStructEnd( ast.data.desc )

end sub


