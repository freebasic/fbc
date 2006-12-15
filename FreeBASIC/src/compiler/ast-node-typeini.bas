''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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

'' AST type initializer nodes
'' tree	    : l = head; r = (when constructing: tail, when updating: base var)
'' expr node: l = expr; r = next
'' pad node : l = NULL; r = next
''
'' chng: mar/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astTypeIniBegin _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval is_local as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_TYPEINI, _
					dtype, _
					subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->typeini.ofs = 0

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
				  INVALID, _
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
				  expr->dtype, _
				  expr->subtype )

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
				  INVALID, _
				  NULL )

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
				  INVALID, _
				  NULL )

	n->sym = sym
	n->typeini.ofs = tree->typeini.ofs
	n->typeini.elements = elements

	tree->typeini.ofs += symbGetLen( sym ) * elements

	function = n

end function

'':::::
private function hCallCtor _
	( _
		byval flush_tree as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr fld = any

	fld = n->sym
	if( symbIsField( fld ) = FALSE ) then
		fld = NULL
	end if

	'' replace the instance pointer
	n->l = astPatchCtorCall( n->l, _
							 astBuildVarField( basesym, fld, n->typeini.ofs ) )

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

	dtype = symbGetType( fld )
	subtype = symbGetSubtype( fld )

	if( symbIsField( fld ) = FALSE ) then
		fld = NULL
	end if

	elements = n->typeini.elements

	'' iter = *cast( subtype ptr, cast( byte ptr, @array(0) ) + ofs) )
	fldexpr = astBuildVarField( basesym, fld, n->typeini.ofs )

	if( elements > 1 ) then
    	dim as FBSYMBOL ptr cnt, label, iter

    	cnt = symbAddTempVar( FB_DATATYPE_INTEGER, NULL, FALSE, FALSE )
    	label = symbAddLabel( NULL )
    	iter = symbAddTempVar( FB_DATATYPE_POINTER + dtype, subtype, FALSE, FALSE )

		flush_tree = astNewLINK( flush_tree, _
								 astBuildVarAssign( iter, _
								 					astNewADDROF( fldexpr ) ) )

		'' for cnt = 0 to elements-1
		flush_tree = astBuildForBeginEx( flush_tree, cnt, label, 0 )

		'' ctor( *iter )
		flush_tree = astNewLINK( flush_tree, _
								 astBuildCtorCall( subtype, astBuildVarDeref( iter ) ) )

		'' iter += 1
    	flush_tree = astNewLINK( flush_tree, _
    							 astBuildVarInc( iter, 1 ) )

    	'' next
    	flush_tree = astBuildForEndEx( flush_tree, cnt, label, 1, elements )

    else
    	'' ctor( this )
    	flush_tree = astNewLINK( flush_tree, _
    							 astBuildCtorCall( subtype, fldexpr ) )
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

    dim as ASTNODE ptr lside = any, n = any, nxt = any, flush_tree = NULL
    dim as FBSYMBOL ptr sym = any, subtype = any
    dim as integer dtype = any

	function = NULL

    n = tree->l
    do while( n <> NULL )
        nxt = n->r

    	select case as const n->class
    	case AST_NODECLASS_TYPEINI_ASSIGN
        	sym = n->sym

        	if( symbIsParamInstance( basesym ) ) then
        		'' offset is always 0
        		lside = astBuildInstPtr( basesym, _
        							 	 sym, _
        							 	 NULL, _
        							 	 0 )
        	else
        		dtype = symbGetType( sym )
        		subtype = symbGetSubtype( sym )

        		'' var?
        		if( do_deref = FALSE ) then
        			lside = astNewVAR( basesym, _
        				   	   	   	   n->typeini.ofs, _
	       				   	   	   	   dtype, _
        				   	   	   	   subtype )

        		'' deref..
        		else
        			lside = astNewDEREF( n->typeini.ofs, _
        							     astNewVAR( basesym, _
        				   	   	   	   			    0, _
	       				   	   	   	   			  	symbGetType( basesym ), _
        				   	   	   	   			  	symbGetSubtype( basesym ) ), _
        							   	 dtype, _
        							   	 subtype )
        		end if

        		'' field?
        		if( symbIsField( sym ) ) then
        			lside = astNewFIELD( lside, _
        					 	 	 	 sym, _
        					 	 	 	 dtype, _
        					 	 	 	 subtype )
        		end if
            end if

			flush_tree = astNewLINK( flush_tree, _
									 astNewASSIGN( lside, n->l, AST_OPOPT_DONTCHKPTR ) )

    	case AST_NODECLASS_TYPEINI_PAD
        	if( symbIsParamInstance( basesym ) ) then
        		lside = astBuildInstPtr( basesym, _
        							 	 NULL, _
        							 	 NULL, _
        							 	 n->typeini.ofs )
            else
				dtype = symbGetType( basesym )
				subtype = symbGetSubtype( basesym )

				if( do_deref = FALSE ) then
					lside = astNewVAR( basesym, _
								   	   n->typeini.ofs, _
        				  	   	   	   dtype, _
        				  	   	   	   subtype )

        		else
        			lside = astNewDEREF( n->typeini.ofs, _
        							   	 astNewVAR( basesym, _
        				   	   	   	   			  	0, _
	       				   	   	   	   			  	dtype, _
        				   	   	   	   			  	subtype ), _
        							     dtype - FB_DATATYPE_POINTER, _
        							     subtype )
        		end if
    		end if

    		flush_tree = astNewLINK( flush_tree, _
    								 astNewMEM( AST_OP_MEMCLEAR, _
    						   		 			lside, _
    						   		 			NULL, _
    						   		 			n->typeini.bytes ) )

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
				expr = astNewCONV( sdtype, _
								   symbGetSubtype( sym ), _
								   expr )

                '' shouldn't happen, but..
				if( expr = NULL ) then
			   		errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				end if
			end if

			if( expr <> NULL ) then
				select case as const sdtype
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

    	if( n->class = AST_NODECLASS_TYPEINI_PAD ) then
    		irEmitVARINIPAD( n->typeini.bytes )
    	else
			hFlushExprStatic( n, basesym )
    	end if

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

	assert( tree <> NULL )

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
		function = hFlushTree( tree, _
							   basesym, _
							   (options and AST_INIOPT_DODEREF) <> 0 )
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
			if( (symbGetDataClass( sdtype ) <> FB_DATACLASS_INTEGER) or _
				(symbGetDataSize( sdtype ) <> FB_POINTERSIZE) ) then
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
private sub hWalk _
	( _
		byval node as ASTNODE ptr, _
		byval parent as ASTNODE ptr _
	)

    dim as ASTNODE ptr expr = any
    dim as FBSYMBOL ptr sym = any

	if( node->class = AST_NODECLASS_TYPEINI ) then
		sym = symbAddTempVar( node->dtype, _
							  node->subtype, _
							  FALSE, _
							  FALSE )

		expr = astNewVAR( sym, 0, node->dtype, node->subtype )
		if( parent->l = node ) then
			parent->l = expr
		else
			parent->r = expr
		end if

		astAdd( astTypeIniFlush( node, _
								 sym, _
								 AST_INIOPT_NONE ) )

    	exit sub
    end if

	'' walk
	expr = node->l
	if( expr <> NULL ) then
		hWalk( expr, node )
	end if

	expr = node->r
	if( expr <> NULL ) then
		hWalk( expr, node )
	end if

end sub

'':::::
function astTypeIniUpdate _
	( _
		byval tree as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr expr = any

	function = tree

    if( ast.typeinicnt <= 0 ) then
    	exit function
    end if

	'' walk
	expr = tree->l
	if( expr <> NULL ) then
		hWalk( expr, tree )
	end if

	expr = tree->r
	if( expr <> NULL ) then
		hWalk( expr, tree )
	end if

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
function astTypeIniGetHead _
	( _
		byval tree as ASTNODE ptr _
	) as ASTNODE ptr

	'' head node will be always an EXPR
	function = tree->l->l

end function

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


