'' AST misc helpers/builders
''
'' chng: sep/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"
#include once "lex.bi"
#include once "rtl.bi"

''
'' vars
''


'':::::
private function astSetBitField _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr s = any

	s = l->subtype

	'' remap type
	astGetFullType( l ) = symbGetFullType( s )
	l->subtype = NULL

	l = astNewBOP( AST_OP_AND, astCloneTree( l ), _
				   astNewCONSTi( not (ast_bitmaskTB(s->bitfld.bits) shl s->bitfld.bitpos), _
				   				 FB_DATATYPE_UINT ) )

	'' make sure result will fit in destination...
	r = astNewBOP( AST_OP_AND, r, _
				   astNewCONSTi( ast_bitmaskTB(s->bitfld.bits), FB_DATATYPE_UINT ) )

	if( s->bitfld.bitpos > 0 ) then
		r = astNewBOP( AST_OP_SHL, r, _
				   	   astNewCONSTi( s->bitfld.bitpos, FB_DATATYPE_UINT ) )
	end if

	function = astNewBOP( AST_OP_OR, l, r )

end function

'':::::
sub astUpdateBitfieldAssignment _
	( _
		byref l as ASTNODE ptr, _
		byref r as ASTNODE ptr _
	)

    dim as ASTNODE ptr lchild = any

	'' handle bitfields..
	if( l->class = AST_NODECLASS_FIELD ) then
        lchild = astGetLeft( l )
		if( astGetDataType( lchild ) = FB_DATATYPE_BITFIELD ) then
			'' l is a field node, use its left child instead
			r = astSetBitField( lchild, r )
			'' the field node can be removed
			astDelNode( l )
			l = lchild
		end if
	end if

end sub

'':::::
function astBuildVarAssign _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer _
	) as ASTNODE ptr

	function = astNewASSIGN( astNewVAR( lhs, _
            							0, _
            							symbGetFullType( lhs ), _
            							symbGetSubtype( lhs ) ), _
            				 astNewCONSTi( rhs, _
            				 			   FB_DATATYPE_INTEGER ) )

end function

'':::::
function astBuildVarAssign _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as ASTNODE ptr _
	) as ASTNODE ptr

	function = astNewASSIGN( astNewVAR( lhs, _
            							0, _
            							symbGetFullType( lhs ), _
            							symbGetSubtype( lhs ) ), _
            				 rhs )

end function

'':::::
function astBuildVarInc _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer _
	) as ASTNODE ptr

	dim as AST_OPOPT options = any
	dim as AST_OP op = any

	options = AST_OPOPT_DEFAULT
	if( typeIsPtr( symbGetType( lhs ) ) ) then
		options or= AST_OPOPT_LPTRARITH
	end if

	if( rhs > 0 ) then
		op = AST_OP_ADD_SELF
	else
		op = AST_OP_SUB_SELF
		rhs = -rhs
	end if

	function = astNewSelfBOP( op, _
						   	  astNewVAR( lhs, _
						   	  			 0, _
						   	  			 symbGetFullType( lhs ), _
						   	  			 symbGetSubtype( lhs ) ), _
            			   	  astNewCONSTi( rhs, _
            			   	  				FB_DATATYPE_INTEGER ), _
            			   	  NULL, _
            			   	  options )

end function

'':::::
function astBuildVarDeref _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	function = astNewDEREF( astNewVAR( sym, _
            						   0, _
            						   symbGetFullType( sym ), _
            						   symbGetSubtype( sym ) ), _
            			  	           typeDeref(symbGetType( sym )), _
            			  	symbGetSubtype( sym ) )

end function

'':::::
function astBuildVarAddrof _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	function = astNewADDROF( astNewVAR( sym, _
            						  	0, _
            						  	symbGetFullType( sym ), _
            						  	symbGetSubtype( sym ) ) )

end function

'':::::
function astBuildVarDtorCall _
	( _
		byval s as FBSYMBOL ptr, _
		byval check_access as integer _
	) as ASTNODE ptr

	dim as integer do_free = any
	dim as ASTNODE ptr expr = any

	'' assuming conditions were checked already
	function = NULL

	'' array? dims can be -1 with "DIM foo()" arrays..
	if( symbGetArrayDimensions( s ) <> 0 ) then
		do_free = FALSE

		'' dynamic?
		if( symbIsDynamic( s ) ) then
			do_free = TRUE

		else
		     '' has dtor?
		     select case symbGetType( s )
		     case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			 	do_free = symbGetHasDtor( symbGetSubtype( s ) )
			 end select
		end if

		if( do_free ) then
			expr = astNewVAR( s, 0, symbGetFullType( s ), symbGetSubtype( s ) )

			if( symbIsDynamic( s ) ) then
				function = rtlArrayErase( expr, check_access )
			else
				function = rtlArrayClear( expr, FALSE, check_access )
			end if

		'' array of dyn strings?
		elseif( symbGetType( s ) = FB_DATATYPE_STRING ) then
			function = rtlArrayStrErase( astNewVAR( s, 0, FB_DATATYPE_STRING ) )
		end if

	else
		select case symbGetType( s )
		'' dyn string?
		case FB_DATATYPE_STRING
			function = rtlStrDelete( astNewVAR( s, 0, FB_DATATYPE_STRING ) )

		'' wchar ptr marked as "dynamic wstring"?
		case typeAddrOf( FB_DATATYPE_WCHAR )
			assert(symbGetIsWstring(s)) '' This check should be done in symbGetVarHasDtor() already
			'' It points to a dynamically allocated wchar buffer
			'' that must be deallocated.
			function = rtlStrDelete( astNewVAR( s, 0, typeAddrOf( FB_DATATYPE_WCHAR ) ) )

		'' struct or class?
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			'' has dtor?
			if( symbGetHasDtor( symbGetSubtype( s ) ) ) then
                dim as FBSYMBOL ptr subtype = symbGetSubtype( s )

                if( check_access ) then
					if( symbCheckAccess( subtype, _
										 symbGetCompDtor( subtype ) ) = FALSE ) then
						errReport( FB_ERRMSG_NOACCESSTODTOR )
                	end if
                end if

                function = astBuildDtorCall( subtype, _
                							 astNewVAR( s, _
                							 			0, _
                							 			symbGetFullType( s ), _
                							 			subtype ) )

			end if

		end select
	end if

end function

'':::::
function astBuildVarField _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr, _
		byval ofs as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any

	if( fld <> NULL ) then
		ofs += symbGetOfs( fld )
	end if

	'' byref or import?
	if( symbIsParamByRef( sym ) or symbIsImport( sym ) ) then
		expr = astNewDEREF( astNewVAR( sym, _
						    		   0, _
						    		   typeAddrOf( symbGetFullType( sym ) ), _
						    		   symbGetSubtype( sym ) ), _
						    symbGetFullType( sym ), _
						    symbGetSubtype( sym ), _
						    ofs )
	else
		expr = astNewVAR( sym, _
						  ofs, _
						  symbGetFullType( sym ), _
						  symbGetSubtype( sym ) )
	end if

	if( fld <> NULL ) then
		expr = astNewFIELD( expr, fld, symbGetFullType( fld ), symbGetSubtype( fld ) )
	end if

	function = expr

end function

''
'' loops
''

'':::::
function astBuildForBeginEx _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval inivalue as integer _
	) as ASTNODE ptr

	'' cnt = 0
    tree = astNewLINK( tree, astBuildVarAssign( cnt, inivalue ) )

    '' do
    tree = astNewLINK( tree, astNewLABEL( label ) )

    function = tree

end function

'':::::
sub astBuildForBegin _
	( _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval inivalue as integer _
	)

    astAdd( astBuildForBeginEx( NULL, cnt, label, inivalue ) )

end sub

'':::::
function astBuildForEndEx _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval stepvalue as integer, _
		byval endvalue as ASTNODE ptr _
	) as ASTNODE ptr

	'' next
    tree = astNewLINK( tree, astBuildVarInc( cnt, stepvalue ) )

    '' next
    tree = astNewLINK( tree, astUpdComp2Branch( astNewBOP( AST_OP_EQ, _
    									  				   astNewVAR( cnt, _
            										 	   			  0, _
            										 	   			  FB_DATATYPE_INTEGER ), _
            							  				   endvalue ), _
            				   					label, _
            				   					FALSE ) )

	function = tree

end function

'':::::
function astBuildForEndEx _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval stepvalue as integer, _
		byval endvalue as integer _
	) as ASTNODE ptr

	function = astBuildForEndEx( tree, _
								 cnt, _
								 label, _
								 stepvalue, _
								 astNewCONSTi( endvalue, FB_DATATYPE_INTEGER ) )

end function

'':::::
sub astBuildForEnd _
	( _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval stepvalue as integer, _
		byval endvalue as ASTNODE ptr _
	)

    astAdd( astBuildForEndEx( NULL, cnt, label, stepvalue, endvalue ) )

end sub

'':::::
sub astBuildForEnd _
	( _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval stepvalue as integer, _
		byval endvalue as integer _
	)

    astBuildForEnd( cnt, _
    				label, _
    				stepvalue, _
    				astNewCONSTi( endvalue, FB_DATATYPE_INTEGER ) )

end sub

''
'' calls
''

'':::::
function astBuildCall _
	( _
		byval proc as FBSYMBOL ptr, _
		byval arg1 as ASTNODE ptr, _
		byval arg2 as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr p = any

    p = astNewCALL( proc )

	if( arg1 ) then
		if( astNewARG( p, arg1 ) = NULL ) then
			return NULL
		end if
	end if
	if( arg2 ) then
		if( astNewARG( p, arg2 ) = NULL ) then
			return NULL
		end if
	end if

    function = p

end function

'':::::
function astBuildCtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr ctor = any
    dim as ASTNODE ptr proc = any
    dim as integer params = any

    ctor = symbGetCompDefCtor( sym )
    if( ctor = NULL ) then
    	return NULL
    end if

    proc = astNewCALL( ctor )

    astNewARG( proc, thisexpr )

    '' add the optional params, if any
    params = symbGetProcParams( ctor ) - 1
    do while( params > 0 )
    	astNewARG( proc, NULL )
    	params -= 1
    loop

    function = proc

end function

'':::::
function astBuildDtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

    proc = astNewCALL( symbGetCompDtor( sym ) )

    astNewARG( proc, thisexpr )

    function = proc

end function

'':::::
function astBuildCopyCtorCall _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr copyctor = any

	copyctor = symbGetCompCopyCtor( astGetSubtype( dst ) )

	'' no copy ctor? do a shallow copy..
	if( copyctor = NULL ) then
    	return astNewASSIGN( dst, src, AST_OPOPT_DONTCHKPTR )
    end if

    '' call the copy ctor
    proc = astNewCALL( copyctor )

    astNewARG( proc, dst )
    astNewARG( proc, src )

    function = proc

end function

'':::::
function astPatchCtorCall _
	( _
		byval procexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

	if( procexpr <> NULL ) then
		'' replace the instance pointer
		astReplaceARG( procexpr, 0, thisexpr )
	end if

	function = procexpr

end function

'':::::
function astCALLCTORToCALL _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr procexpr = any

	sym = astGetSymbol( n->r )

	'' the function call is in the left leaf
	procexpr = n->l

	'' remove right leaf
	astDelTree( n->r )

	'' remove anon symbol
	if( symbGetHasDtor( symbGetSubtype( sym ) ) ) then
		'' if the temp has a dtor it was added to the dtor list,
		'' remove it too
		astDtorListDel( sym )
	end if

	symbDelSymbol( sym )

	'' remove the node
	astDelNode( n )

	function = procexpr

end function

''::::
function astBuildImplicitCtorCall _
	( _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval arg_mode as FB_PARAMMODE, _
		byref is_ctorcall as integer _
	) as ASTNODE ptr

 	dim as integer err_num = any
    dim as FBSYMBOL ptr proc = any

	proc = symbFindCtorOvlProc( subtype, expr, arg_mode, @err_num )
	if( proc = NULL ) then
		is_ctorcall = FALSE

		if( err_num <> FB_ERRMSG_OK ) then
			errReportParam( symbGetCompCtorHead( subtype ), 0, NULL, err_num )
			return NULL
		end if

		'' could be a shallow copy..
        return expr
	end if

    '' check visibility
	if( symbCheckAccess( subtype, proc ) = FALSE ) then
		errReport( FB_ERRMSG_NOACCESSTOCTOR )
	end if

    '' build a ctor call
    dim as ASTNODE ptr procexpr = astNewCALL( proc )

    '' push the mock instance ptr
    astNewARG( procexpr, astBuildMockInstPtr( subtype ), FB_DATATYPE_INVALID, FB_PARAMMODE_BYVAL )

    astNewARG( procexpr, expr, FB_DATATYPE_INVALID, arg_mode )

    '' add the optional params, if any
    dim as integer params = symbGetProcParams( proc ) - 2
    do while( params > 0 )
    	astNewARG( procexpr, NULL )
    	params -= 1
    loop

    is_ctorcall = TRUE
    function = procexpr

end function

'':::::
function astBuildImplicitCtorCallEx _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval arg_mode as FB_PARAMMODE, _
		byref is_ctorcall as integer _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr subtype = any

	subtype = symbGetSubType( sym )

    '' check ctor call
    if( astIsCALLCTOR( expr ) ) then
    	if( symbGetSubtype( expr ) = subtype ) then
    		is_ctorcall = TRUE
    		'' remove the the anon/temp instance
    		return astCALLCTORToCALL( expr )
    	end if
    end if

    '' try calling any ctor with the expression
    function = astBuildImplicitCtorCall( subtype, expr, arg_mode, is_ctorcall )

end function

''
'' procs
''

function astBuildProcAddrof(byval proc as FBSYMBOL ptr) as ASTNODE ptr
	symbSetIsCalled(proc)
	function = astNewADDROF(astNewVAR(proc, 0, FB_DATATYPE_FUNCTION, proc))
end function

'':::::
function astBuildProcBegin _
	( _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = astProcBegin( proc, FALSE )

    symbSetProcIncFile( proc, env.inf.incfile )

   	astAdd( astNewLABEL( astGetProcInitlabel( n ) ) )

   	function = n

end function

'':::::
sub astBuildProcEnd _
	( _
		byval n as ASTNODE ptr _
	)

	astProcEnd( n, FALSE )

end sub

'':::::
function astBuildProcResultVar _
	( _
		byval proc as FBSYMBOL ptr, _
		byval res as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE PTR lhs = any

    lhs = astNewVAR( res, 0, symbGetFullType( res ), symbGetSubtype( res ) )

	'' proc returns an UDT?
    select case symbGetType( proc )
    case FB_DATATYPE_STRUCT
		'' pointer? deref
		if( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ) = typeAddrOf( FB_DATATYPE_STRUCT ) ) then
			lhs = astNewDEREF( lhs, FB_DATATYPE_STRUCT, symbGetSubtype( res ) )
		end if
	'case FB_DATATYPE_CLASS
		' ...
	end select

	function = lhs

end function

'':::::
function astBuildCallHiddenResVar _
	( _
		byval callexpr as ASTNODE ptr _
	) as ASTNODE ptr

    function = astNewLINK( callexpr, _
						   astNewVAR( callexpr->call.tmpres, _
        							  0, _
        							  astGetFullType( callexpr ), _
        							  astGetSubtype( callexpr ) ), _
        				   FALSE )

end function

''
'' instance ptr
''

'':::::
function astBuildInstPtr _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr, _
		byval idxexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any
	dim as integer dtype = any, ofs = any
	dim as FBSYMBOL ptr subtype = any

	dtype = symbGetFullType( sym )
	subtype = symbGetSubtype( sym )

	'' it's always a param
	expr = astNewVAR( sym, 0, typeAddrOf( dtype ), subtype )

	if( fld <> NULL ) then
		dtype = symbGetFullType( fld )
		subtype = symbGetSubtype( fld )

		'' build sym.field( index )

		ofs = symbGetOfs( fld )
		if( ofs <> 0 ) then
			expr = astNewBOP( AST_OP_ADD, _
							  expr, _
							  astNewCONSTi( ofs, FB_DATATYPE_INTEGER ) )
		end if

		'' array access?
		if( idxexpr <> NULL ) then
			'' times length
			expr = astNewBOP( AST_OP_ADD, _
							  expr, _
							  astNewBOP( AST_OP_MUL, _
										 idxexpr, _
										 astNewCONSTi( symbGetLen( fld ), _
													   FB_DATATYPE_INTEGER ) ) )
		end if

	end if

	expr = astNewDEREF( expr, dtype, subtype )

	if( fld <> NULL ) then
		expr = astNewFIELD( expr, fld, dtype, subtype )
	end if

	function = expr

end function

'':::::
function astBuildInstPtrAtOffset _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr, _
		byval ofs as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	dtype = symbGetFullType( sym )
	subtype = symbGetSubtype( sym )

	'' it's always a param
	expr = astNewVAR( sym, 0, typeAddrOf( dtype ), subtype )

	if( fld <> NULL ) then
		dtype = symbGetFullType( fld )
		subtype = symbGetSubtype( fld )
	end if

	if( ofs <> 0 ) then
		expr = astNewBOP( AST_OP_ADD, _
						  expr, _
						  astNewCONSTi( ofs, FB_DATATYPE_INTEGER ) )
	end if

	expr = astNewDEREF( expr, dtype, subtype )

	if( fld <> NULL ) then
		expr = astNewFIELD( expr, fld, dtype, subtype )
	end if

	function = expr

end function

'':::::
function astBuildMockInstPtr _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	function = astNewCONSTi( 0, _
							 typeAddrOf( symbGetType( sym ) ), _
							 sym )

end function

''
'' misc
''

'':::::
function astBuildTypeIniCtorList _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tree

	tree = astTypeIniBegin( symbGetFullType( sym ), symbGetSubtype( sym ), TRUE )

	astTypeIniAddCtorList( tree, sym, symbGetArrayElements( sym ) )

	astTypeIniEnd( tree, TRUE )

	function = tree

end function

'':::::
function astBuildMultiDeref _
	( _
		byval cnt as integer, _
		byval expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	do while( cnt > 0 )
		if( typeIsPtr( dtype ) = FALSE ) then
			if( symb.globOpOvlTb(AST_OP_DEREF).head = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
				exit do
			end if

			'' check op overloading
    		dim as FBSYMBOL ptr proc = any
    		dim as FB_ERRMSG err_num = any

			proc = symbFindUopOvlProc( AST_OP_DEREF, expr, @err_num )
			if( proc <> NULL ) then
    			'' build a proc call
				expr = astBuildCall( proc, expr, NULL )
				if( expr = NULL ) then
					return NULL
				end if

				dtype = astGetFullType( expr )
				subtype = astGetSubType( expr )

			else
				errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
				exit do
			end if
		else
			dtype = typeDeref( dtype )

			'' incomplete type?
			select case typeGet( dtype )
			case FB_DATATYPE_VOID, FB_DATATYPE_FWDREF
				errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE )
				'' error recovery: fake a type
				dtype = FB_DATATYPE_BYTE
			end select

			'' null pointer checking
			if( env.clopt.extraerrchk ) then
				expr = astNewPTRCHK( expr, lexLineNum( ) )
			end if

			expr = astNewDEREF( expr, dtype, subtype )
		end if

		cnt -= 1
	loop

	function = expr

end function

''
'' arrays
''

'':::::
function astBuildArrayDescIniTree _
	( _
		byval desc as FBSYMBOL ptr, _
		byval array as FBSYMBOL ptr, _
		byval array_expr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr tree = any
    dim as integer dtype = any, dims = any
    dim as FBSYMBOL ptr elm = any, dimtb = any, subtype = any

    '' COMMON?
    if( symbIsCommon( array ) ) then
    	return NULL
    end if

    ''
    tree = astTypeIniBegin( symbGetFullType( desc ), symbGetSubtype( desc ), TRUE )

    dtype = symbGetFullType( array )
    subtype = symbGetSubType( array )
    dims = symbGetArrayDimensions( array )

	'' unknown dimensions? use max..
	if( dims = -1 ) then
		dims = FB_MAXARRAYDIMS
	end if

	'' note: assuming the arrays descriptors won't be objects with methods
	elm = symbGetUDTSymbTbHead( symbGetSubtype( desc ) )

    if( array_expr = NULL ) then
    	if( symbGetIsDynamic( array ) ) then
    		array_expr = astNewCONSTi( 0, typeAddrOf( dtype ), subtype )
    	else
    		array_expr = astNewADDROF( astNewVAR( array, 0, dtype, subtype ) )
    	end if

    else
    	array_expr = astNewADDROF( array_expr )
    end if

    astTypeIniScopeBegin( tree, NULL )

    '' .data = @array(0) + diff
	astTypeIniAddAssign( tree, _
					   	 astNewBOP( AST_OP_ADD, _
								  	astCloneTree( array_expr ), _
					   			  	astNewCONSTi( symbGetArrayOffset( array ), _
					   			  				  FB_DATATYPE_INTEGER ) ), _
					   	 elm )

	astTypeIniSeparator( tree, NULL )
	elm = symbGetNext( elm )

	'' .ptr	= @array(0)
	astTypeIniAddAssign( tree, array_expr, elm )

    astTypeIniSeparator( tree, NULL )
    elm = symbGetNext( elm )

    '' .size = len( array ) * elements( array )
    astTypeIniAddAssign( tree, _
    				   	 astNewCONSTi( symbGetLen( array ) * symbGetArrayElements( array ), _
    				   				   FB_DATATYPE_INTEGER ), _
    				   	 elm )

    astTypeIniSeparator( tree, NULL )
    elm = symbGetNext( elm )

    '' .element_len	= len( array )
    astTypeIniAddAssign( tree, _
    				   	 astNewCONSTi( symbGetLen( array ), _
    				   				   FB_DATATYPE_INTEGER ), _
    				   	 elm )

    astTypeIniSeparator( tree, NULL )
    elm = symbGetNext( elm )

    '' .dimensions = dims( array )
    astTypeIniAddAssign( tree, _
    				   	 astNewCONSTi( dims, _
    				   				   FB_DATATYPE_INTEGER ), _
    				   	 elm )

    astTypeIniSeparator( tree, NULL )
    elm = symbGetNext( elm )

    '' setup dimTB
    dimtb = symbGetUDTSymbTbHead( symbGetSubtype( elm ) )

    astTypeIniScopeBegin( tree, NULL )

    '' static array?
    if( symbGetIsDynamic( array ) = FALSE ) then
    	dim as FBVARDIM ptr d

    	d = symbGetArrayFirstDim( array )
    	do while( d <> NULL )
			elm = dimtb

			astTypeIniScopeBegin( tree, NULL )

			'' .elements = (ubound( array, d ) - lbound( array, d )) + 1
    		astTypeIniAddAssign( tree, _
    				   		     astNewCONSTi( d->upper - d->lower + 1, _
    				   				 		   FB_DATATYPE_INTEGER ), _
    				   		     elm )

			astTypeIniSeparator( tree, NULL )
			elm = symbGetNext( elm )

			'' .lbound = lbound( array, d )
    		astTypeIniAddAssign( tree, _
    				   		     astNewCONSTi( d->lower, _
    				   				 		   FB_DATATYPE_INTEGER ), _
    				   		     elm )

			astTypeIniSeparator( tree, NULL )
			elm = symbGetNext( elm )

			'' .ubound = ubound( array, d )
    		astTypeIniAddAssign( tree, _
    				   		     astNewCONSTi( d->upper, _
    				   				 		   FB_DATATYPE_INTEGER ), _
    				   		     elm )

			astTypeIniScopeEnd( tree, NULL )

			d = d->next

			if( d ) then
				astTypeIniSeparator( tree, NULL )
			end if
    	loop

    '' dynamic..
    else
        '' just fill with 0's
        astTypeIniAddPad( tree, dims * len( FB_ARRAYDESCDIM ) )
    end if

    astTypeIniScopeEnd( tree, NULL )

    ''
    astTypeIniScopeEnd( tree, NULL )

    astTypeIniEnd( tree, TRUE )

    ''
    symbSetIsInitialized( desc )

    function = tree

end function

''
'' strings
''

'':::::
function astBuildStrPtr _
	( _
		byval lhs as ASTNODE ptr _
	) as ASTNODE ptr

	'' note: only var-len strings expressions should be passed

	dim as ASTNODE ptr expr = any

	'' *cast( zstring ptr ptr, @lhs )
	expr = astNewDEREF( astNewCONV( typeMultAddrOf( FB_DATATYPE_CHAR, 2 ), _
	                                NULL, _
	                                astNewADDROF( lhs ) ), _
	                                typeAddrOf( FB_DATATYPE_CHAR ), _
	                    NULL )

	'' HACK: make it return an immutable value by returning (expr + 0)
	'' in order to prevent things like STRPTR(s) = 0
	'' (TODO: find a better way of doing this?)
	expr = astNewBOP( AST_OP_ADD, _
	                  expr, _
	                  astNewCONSTi( 0, FB_DATATYPE_INTEGER ), _
	                  NULL )

	return expr

end function


