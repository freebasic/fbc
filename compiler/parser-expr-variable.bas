'' variable parsing (scalars, arrays, fields and anything between)
''
'' chng: sep/2004 written [v1ctor]
''		 oct/2004 arrays on fields [v1c]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
private function hCheckIndex _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	'' if index isn't an integer, convert
	select case as const typeGet( astGetDataType( expr ) )
	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT

	case FB_DATATYPE_POINTER
		errReport( FB_ERRMSG_INVALIDARRAYINDEX, TRUE )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )

	case else
		expr = astNewCONV( FB_DATATYPE_INTEGER, NULL, expr )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_INVALIDARRAYINDEX, TRUE )
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end select

	function = expr

end function

'':::::
''FieldArray    =   '(' Expression (',' Expression)* ')' .
''
private function hFieldArray _
	( _
		byval sym as FBSYMBOL ptr, _
		byval idxexpr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as integer maxdims = any, dims = any, diff = any
    dim as ASTNODE ptr expr = any, dimexpr = any
    dim as FBVARDIM ptr d = any

    function = NULL

    ''
    maxdims = symbGetArrayDimensions( sym )
    dims = 0
    d = symbGetArrayFirstDim( sym )
    expr = NULL
    do
    	dims += 1
    	if( dims > maxdims ) then
			errReport( FB_ERRMSG_WRONGDIMENSIONS )
			'' error recovery: fake an expr
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    	end if

    	'' Expression
		dimexpr = cExpression( )
		if( dimexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake an expr
			dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
    		dimexpr = astNewBOUNDCHK( dimexpr, _
    								  astNewCONSTi( d->lower, FB_DATATYPE_INTEGER ), _
    								  astNewCONSTi( d->upper, FB_DATATYPE_INTEGER ), _
    								  lexLineNum( ) )

			if( dimexpr = NULL ) then
				errReport( FB_ERRMSG_ARRAYOUTOFBOUNDS )
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
			end if
    	end if

    	''
    	if( expr = NULL ) then
    		expr = dimexpr
    	else
    		expr = astNewBOP( AST_OP_ADD, expr, dimexpr )
    	end if

    	'' separator
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	end if

    	lexSkipToken( )

        '' next
        d = d->next
    	if( d = NULL ) then
			errReport( FB_ERRMSG_WRONGDIMENSIONS )
			exit do
    	end if

    	expr = astNewBOP( AST_OP_MUL, expr, astNewCONSTi( (d->upper - d->lower)+1 ) )
	loop

    ''
    if( dims < maxdims ) then
		errReport( FB_ERRMSG_WRONGDIMENSIONS )
    end if

	'' times length
	expr = astNewBOP( AST_OP_MUL, expr, astNewCONSTi( symbGetLen( sym ) ) )

    '' plus difference
    diff = symbGetArrayDiff( sym )
    if( diff <> 0 ) then
    	expr = astNewBOP( AST_OP_ADD, expr, astNewCONSTi( diff ) )
    end if

    '' plus initial expression
    if( idxexpr <> NULL ) then
    	function = astNewBOP( AST_OP_ADD, idxexpr, expr )
    else
    	function = expr
    end if

end function

'':::::
private function hUdtDataMember _
	( _
		byval fld as FBSYMBOL ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr expr = astNewCONSTi( symbGetOfs( fld ), FB_DATATYPE_INTEGER )

	'' '('?
	if( lexGetToken( ) = CHAR_LPRNT ) then

		'' if field isn't an array, it can be function field, exit
		if( symbGetArrayDimensions( fld ) = 0 ) then
			return expr
		end if

    	'' '('')'?
    	if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
    		return expr
    	end if

    	lexSkipToken( )

		expr = hFieldArray( fld, expr )
		if( expr = NULL ) then
			return NULL
		end if

		'' ')'
		if( lexGetToken( ) <> CHAR_RPRNT ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		else
			lexSkipToken( )
		end if

	else
		'' array and no index?
		if( symbGetArrayDimensions( fld ) <> 0 ) then
			if( checkarray ) then
				errReport( FB_ERRMSG_EXPECTEDINDEX )
				'' error recovery: no need to fake an expr, field arrays
				'' are never dynamic (for now)

			'' non-indexed array..
			else
				'' don't let the offset expr be NULL
				if( expr = NULL ) then
					expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if

				expr = astNewNIDXARRAY( expr )
			end if
		end if
	end if

	function = expr

end function

'':::::
private function hUdtStaticMember _
	( _
		byval fld as FBSYMBOL ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

	'' !!!WRITEME!!!!
	return NULL

end function

'':::::
private function hUdtConstMember _
	( _
		byval fld as FBSYMBOL ptr _
	) as ASTNODE ptr

  	'' string constant?
  	select case symbGetType( fld )
  	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
  		function = astNewVAR( symbGetConstValStr( fld ), _
  							  0, _
  							  symbGetFullType( fld ) )

	case else
		function = astNewCONST( @symbGetConstVal( fld ), _
								symbGetFullType( fld ), _
								symbGetSubType( fld ) )

	end select

end function

'':::::
'' MemberId       =   ID ArrayIdx?
''
private function hMemberId _
	( _
		byval parent as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	if( parent = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDUDT, TRUE )
		'' no error recovery: caller will take care
		return NULL
	end if

	'' ID?
	select case as const lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' no error recovery: caller will take care
		return NULL
	end select

    dim as FBSYMBOL ptr res = NULL
    select case as const lexGetToken( )

	case FB_TK_CONSTRUCTOR
		res = symbGetCompCtorHead( parent )
		if( res = NULL ) then
			symbCompAddDefCtor( parent )
			res = symbGetCompCtorHead( parent )
		end if

	case FB_TK_DESTRUCTOR
		res = symbGetCompDtor( parent )
		if( res = NULL ) then
			symbCompAddDefDtor( parent )
			res = symbGetCompDtor( parent )
		end if

    end select

	if( res ) then
		return res
    end if

    dim as FBSYMCHAIN ptr chain_ = symbLookupCompField( parent, lexGetText( ) )
    if( chain_ = NULL ) then
		errReportUndef( FB_ERRMSG_ELEMENTNOTDEFINED, lexGetText( ) )
		'' no error recovery: caller will take care
		lexSkipToken( )
		return NULL
    end if

    '' since methods don't start a new hash, params and local
    '' symbol dups will also be found
	do
		dim as FBSYMBOL ptr sym = chain_->sym
		do
    		if( symbGetScope( sym ) = symbGetScope( parent ) ) then
				select case as const symbGetClass( sym )
				'' const? (enum elmts too)
				case FB_SYMBCLASS_CONST, FB_SYMBCLASS_ENUM
    				'' check visibility					
					if( symbCheckAccess( parent, sym ) = FALSE ) then
						errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
					end if

				'' field?
				case FB_SYMBCLASS_FIELD
    				'' check visibility
					if( symbCheckAccess( parent, sym ) = FALSE ) then
						errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
					end if

				'' static var?
				case FB_SYMBCLASS_VAR
					'' ... handle array access, it can be a dyn array too ...

				'' method?
				case FB_SYMBCLASS_PROC

				case else
					errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
					return NULL
				end select

				return sym
    		end if

			sym = sym->hash.next
		loop while( sym <> NULL )

		chain_ = chain_->next
    loop while( chain_ <> NULL )

    '' nothing found..
    errReportUndef( FB_ERRMSG_ELEMENTNOTDEFINED, lexGetText( ) )
    '' no error recovery: caller will take care
    lexSkipToken( )

    function = NULL

end function

'':::::
'' UdtMember       =   MemberId ('.' MemberId)*
''
function cUdtMember _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval varexpr as ASTNODE ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	'' note: assuming a pointer is being passed to this function
	dim as integer is_ptr = TRUE, mask = typeGetConstMask( dtype )

	do
		dim	as FBSYMBOL	ptr	fld	= hMemberId( subtype )
		if(	fld	= NULL ) then
			return NULL
		end	if

		select case	as const symbGetClass( fld )
		'' const? (enum elmts too), exit
		case FB_SYMBCLASS_CONST
			lexSkipToken( )

			astDeltree(	varexpr	)
			return hUdtConstMember(	fld	)

		'' enum?
		case FB_SYMBCLASS_ENUM
			lexSkipToken( )

			astDeltree(	varexpr	)
			varexpr = NULL

			'' '.'?
			if( lexGetToken( ) <> CHAR_DOT ) then
				return NULL
			end if

		'' field?
		case FB_SYMBCLASS_FIELD
			lexSkipToken( )

			'' make sure the field inherits the parent's constant mask
			dtype =	symbGetFullType( fld ) or mask
			subtype	= symbGetSubType( fld )

			dim	as ASTNODE ptr fldexpr = hUdtDataMember( fld, check_array )
			if(	fldexpr	= NULL ) then
				exit do
			end	if

			'' ugly	hack to	deal with arrays w/o indexes
			dim as integer is_nidxarray = FALSE
			if(	astIsNIDXARRAY(	fldexpr	) )	then
				dim	as ASTNODE ptr tmpexpr = astGetLeft( fldexpr )
				astDelNode(	fldexpr	)
				fldexpr	= tmpexpr
				is_nidxarray = TRUE
			end	if

			'' convert foo.bar to cast( typeof( foo ), (cast( byte ptr, @foo ) + offsetof( foo, bar ) ) )->bar
			if( is_ptr = FALSE ) then
				varexpr	= astNewADDROF(	varexpr	)
			end if

			varexpr	= astNewBOP( AST_OP_ADD, varexpr, fldexpr )

			varexpr	= astNewDEREF( varexpr, dtype, subtype )

			varexpr	= astNewFIELD( varexpr,	fld, dtype, subtype )

			if( is_nidxarray ) then
				return astNewNIDXARRAY( varexpr )
			end if

			select case	typeGet( dtype )
			case FB_DATATYPE_STRUCT	', FB_DATATYPE_CLASS
				'' '.'?
				if( lexGetToken( ) <> CHAR_DOT ) then
					return varexpr
				end if

			case else
				return varexpr
			end	select

			is_ptr = FALSE

		'' static var?
		case FB_SYMBCLASS_VAR
			lexSkipToken( )

			astDeltree(	varexpr	)

			varexpr	= hUdtStaticMember(	fld, check_array )

			'' make sure the field inherits the parent's constant mask
			dtype =	symbGetFullType( fld ) or mask
			subtype	= symbGetSubType( fld )

			select case	typeGet( dtype )
			case FB_DATATYPE_STRUCT	', FB_DATATYPE_CLASS
				if(	lexGetToken( ) <> CHAR_DOT ) then
					return varexpr
				end	if

			case else
				return varexpr
			end	select

			is_ptr = FALSE

		'' method?
		case FB_SYMBCLASS_PROC
			if( is_ptr ) then
				varexpr	= astNewDEREF( varexpr,	dtype, subtype )
			end if

			return cMethodCall( fld, varexpr )

		case else
			errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
			return NULL
		end	select

		lexSkipToken( LEXCHECK_NOPERIOD	)
	loop

	function = varexpr

end function

'':::::
function cMemberAccess _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	'' proc call?
	if( astIsCALL( expr ) ) then
		expr = astGetCALLResUDT( expr )
	end if

 	'' build: cast( udt ptr, (cast( byte ptr, @udt) + fldexpr))->field
	function = cUdtMember( dtype, subtype, astNewADDROF( expr ), TRUE )

end function

'':::::
private function hStrIndexing _
	( _
		byval dtype as integer, _
		byval varexpr as ASTNODE ptr, _
		byval idxexpr as ASTNODE ptr _
	) as ASTNODE ptr

	'' string concatenation is delayed because optimizations..
	varexpr = astUpdStrConcat( varexpr )

	'' function deref?
	if( astIsCALL( varexpr ) ) then
		'' not allowed, STRING and WCHAR results are temporary
		errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
	end if

	if( typeGet( dtype ) = FB_DATATYPE_STRING ) then
		'' deref
		varexpr = astBuildStrPtr( varexpr )
	else
		'' address of
		varexpr = astNewADDROF( varexpr )
	end if

	'' add index
	if( typeGet( dtype ) = FB_DATATYPE_WCHAR ) then
		'' times sizeof( wchar ) if it's wstring
		idxexpr = astNewBOP( AST_OP_SHL, _
				   			 idxexpr, _
				   			 astNewCONSTi( hToPow2( typeGetSize( FB_DATATYPE_WCHAR ) ), _
				   				 		   FB_DATATYPE_INTEGER ) )
	end if

	'' null pointer checking
	if( env.clopt.extraerrchk ) then
		varexpr = astNewPTRCHK( varexpr, lexLineNum( ) )
	end if

	varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )

	'' not a wstring?
	if( typeGet( dtype ) <> FB_DATATYPE_WCHAR ) then
		dtype = typeJoin( dtype, FB_DATATYPE_UBYTE )
	else
		dtype = typeJoin( dtype, env.target.wchar.type )
	end if

	'' make a pointer
	function = astNewDEREF( varexpr, dtype, NULL )

end function

'':::::
''MemberDeref	=   (('->' DREF* | '[' Expression ']' '.'?) UdtMember)* .
''
function cMemberDeref _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval varexpr as ASTNODE ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	dim as integer derefcnt = any, is_field = any, lgt = any
	dim as ASTNODE ptr idxexpr = any

	function = NULL

	do
		idxexpr = NULL
		derefcnt = 0

        select case lexGetToken( )
        '' ('->' DREF* UdtMember)*
        case FB_TK_FIELDDEREF
        	is_field = TRUE

			dim as integer is_ovl = FALSE
			if( typeIsPtr( dtype ) = FALSE ) then
				'' check op overloading
    			if( symb.globOpOvlTb(AST_OP_FLDDEREF).head = NULL ) then
					errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
					exit do
				end if

    			dim as FBSYMBOL ptr proc = any
    			dim as FB_ERRMSG err_num = any

				proc = symbFindUopOvlProc( AST_OP_FLDDEREF, varexpr, @err_num )
				if( proc <> NULL ) then
    				'' build a proc call
					varexpr = astBuildCall( proc, varexpr, NULL )
					if( varexpr = NULL ) then
						exit function
					end if

    				lexSkipToken( LEXCHECK_NOPERIOD )

    				varexpr = cMemberAccess( astGetFullType( varexpr ), _
    										 astGetSubType( varexpr ), _
    										 varexpr )
					if( varexpr = NULL ) then
						exit function
					end if

    				dtype = astGetFullType( varexpr )
    				subtype = astGetSubType( varexpr )
    				is_ovl = TRUE

				else
					errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
					exit do
				end if

			else
       			lexSkipToken( LEXCHECK_NOPERIOD )
				dtype = typeDeref( dtype )
			end if

       		'' DREF*
			do while( lexGetToken( ) = FB_TK_DEREFCHAR )
				lexSkipToken( LEXCHECK_NOPERIOD )
				derefcnt += 1
			loop

			if( is_ovl ) then
				goto check_deref
			end if

		'' '['
		case CHAR_LBRACKET
			lexSkipToken( )

			'' Expression
			idxexpr = cExpression( )
			if( idxexpr = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				'' error recovery: faken an expr
				idxexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if

			'' convert index if needed
			idxexpr = hCheckIndex( idxexpr )

			'' ']'
			if( lexGetToken( ) <> CHAR_RBRACKET ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
				'' error recovery: skip until next ']'
				hSkipUntil( CHAR_RBRACKET, TRUE )
			else
				lexSkipToken( )
			end if

			'' string, fixstr, w|zstring?
			if( typeIsPtr( dtype ) = FALSE ) then
				select case as const typeGet( dtype )
				case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
					 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
					varexpr = hStrIndexing( dtype, varexpr, idxexpr )
				case else
					errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
				end select
				exit do
			end if

			'' times length
			lgt = symbCalcLen( typeDeref( dtype ), subtype )

			if( lgt = 0 ) then
				errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE )
				'' error recovery: fake a type
				dtype = typeAddrOf( FB_DATATYPE_BYTE )
				subtype = NULL
				lgt = 1
			end if

			idxexpr = astNewBOP( AST_OP_MUL, idxexpr, astNewCONSTi( lgt, FB_DATATYPE_INTEGER ) )
			dtype = typeDeref( dtype )

			'' '.'?
			is_field = (lexGetToken( ) = CHAR_DOT)
			if( is_field ) then
				lexSkipToken( LEXCHECK_NOPERIOD )
			end if

		'' exit..
		case else
			exit do

		end select

		select case as const typeGet( dtype )
		'' incomplete type?
		case FB_DATATYPE_VOID, FB_DATATYPE_FWDREF
			errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE )
			'' error recovery: fake a type
			dtype = typeAddrOf( FB_DATATYPE_BYTE )
			subtype = NULL

		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS

		case else
			if( is_field ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				exit do
			end if

		end select

		'' null pointer checking
		if( env.clopt.extraerrchk ) then
			varexpr = astNewPTRCHK( varexpr, lexLineNum( ) )
		end if

		''
		if( idxexpr <> NULL ) then
			varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )
		end if

		if( is_field ) then
			varexpr = cUdtMember( dtype, subtype, varexpr, check_array )
			if( varexpr = NULL ) then
				exit function
			end if

			'' non-indexed array?
			if( astIsNIDXARRAY( varexpr ) ) then
				if( derefcnt > 0 ) then
					errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
				end if

				exit do
			end if

    		dtype = astGetFullType( varexpr )
    		subtype = astGetSubType( varexpr )

		else
			varexpr = astNewDEREF( varexpr, dtype, subtype )
		end if

check_deref:
		if( derefcnt > 0 ) then
			varexpr = astBuildMultiDeref( derefcnt, varexpr, dtype, subtype )
			if( varexpr = NULL ) then
				exit function
			end if

    		dtype = astGetFullType( varexpr )
    		subtype = astGetSubType( varexpr )
		end if
	loop

	function = varexpr

end function

'':::::
''FuncPtrOrDeref	=   FuncPtr '(' Args? ')'
''					|   MemberDeref .
''
function cFuncPtrOrMemberDeref _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval isfuncptr as integer, _
		byval checkarray as integer _
	) as ASTNODE ptr

	function = NULL

	''
	if( isfuncptr = FALSE ) then
		'' MemberDeref?
		expr = 	cMemberDeref( dtype, subtype, expr, checkarray )
		if( expr = NULL ) then
			exit function
		end if

		dtype = astGetDataType( expr )
		subtype = astGetSubType( expr )

   		'' check for functions called through pointers
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( dtype = typeAddrOf( FB_DATATYPE_FUNCTION ) ) then
				isfuncptr = TRUE
   			end if
   		end if
	end if

	'' function pointer dref? call it
	if( isfuncptr = FALSE ) then
		return expr
	end if

	'' function?
	if( symbGetType( subtype ) <> FB_DATATYPE_VOID ) then
		expr = cFunctionCall( NULL, subtype, expr )
		if( expr = NULL ) then
			exit function
		end if

	'' sub..
	else
		if( fbGetIsExpression( ) = FALSE ) then
			expr = cProcCall( NULL, subtype, expr )
		else
			errReport( FB_ERRMSG_SYNTAXERROR )
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if

	function = expr

end function

'':::::
private function hDynArrayBoundChk _
	( _
		byval expr as ASTNODE ptr, _
		byval desc as FBSYMBOL ptr, _
		byval idx as integer _
	) as ASTNODE ptr

    function = astNewBOUNDCHK( expr, _
    						   astNewVAR( desc, _
    								  	  FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_LBOUNDOFS, _
    								  	  FB_DATATYPE_INTEGER ), _
    						   astNewVAR( desc, _
    								  	  FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_UBOUNDOFS, _
    								  	  FB_DATATYPE_INTEGER ), _
    						   lexLineNum( ) )

end function

'':::::
''DynArrayIdx     =   '(' Expression (',' Expression)* ')' .
''
function cDynArrayIdx _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as integer i = any, dims = any, maxdims = any
    dim as ASTNODE ptr expr = any, dimexpr = any
    dim as FBSYMBOL ptr desc = any

    desc = symbGetArrayDescriptor( sym )
    dims = 0

    if( symbIsCommon( sym ) = FALSE ) then
    	maxdims = symbGetArrayDimensions( sym )
    else
    	maxdims = INVALID
    end if

    ''
    i = 0
    expr = NULL
    do
    	dims += 1

    	'' check dimensions, if not common
    	if( maxdims <> -1 ) then
    		if( dims > maxdims ) then
				errReport( FB_ERRMSG_WRONGDIMENSIONS )
    			return NULL
    		end if
    	end if

    	'' Expression
		dimexpr = cExpression( )
		if( dimexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake an expr
			dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
            dimexpr = hDynArrayBoundChk( dimexpr, desc, i )
			if( dimexpr = NULL ) then
				return NULL
			end if
    	end if

    	if( expr = NULL ) then
    		expr = dimexpr
    	else
    		expr = astNewBOP( AST_OP_ADD, expr, dimexpr )
    	end if

    	'' separator
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if

    	i += 1

    	'' times desc(i).elements
    	expr = astNewBOP( AST_OP_MUL, _
    					  expr, _
    					  astNewVAR( desc, _
    						 		 FB_ARRAYDESCLEN + i*FB_ARRAYDESC_DIMLEN, _
    						 		 FB_DATATYPE_INTEGER ) )
	loop

	'' times length
	expr = astNewBOP( AST_OP_MUL, _
					  expr, _
					  astNewCONSTi( symbGetLen( sym ), FB_DATATYPE_INTEGER ) )

    '' check dimensions, if not common
    if( maxdims <> -1 ) then
    	if( dims < maxdims ) then
			errReport( FB_ERRMSG_WRONGDIMENSIONS )
    	end if
    end if

   	'' plus desc.data (= ptr + diff)
    function = astNewBOP( AST_OP_ADD, _
    				  	  expr, _
    				  	  astNewVAR( desc, FB_ARRAYDESC_DATAOFFS, FB_DATATYPE_INTEGER ) )

end function

'':::::
private function hArgArrayBoundChk _
	( _
		byval expr as ASTNODE ptr, _
		byval desc as FBSYMBOL ptr, _
		byval idx as integer _
	) as ASTNODE ptr

    function = astNewBOUNDCHK( expr, _
    						   astNewDEREF( astNewVAR( desc, 0, FB_DATATYPE_INTEGER ), _
    								  	    FB_DATATYPE_INTEGER, _
    								  	    NULL, _
    								  	    FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_LBOUNDOFS ), _
    						   astNewDEREF( astNewVAR( desc, 0, FB_DATATYPE_INTEGER ), _
    								  	    FB_DATATYPE_INTEGER, _
    								  	    NULL, _
    								  	    FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_UBOUNDOFS ), _
    						   lexLineNum( ) )


end function

'':::::
''ArgArrayIdx     =   '(' Expression (',' Expression)* ')' .
''
function cArgArrayIdx _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr expr = any, dimexpr = any
    dim as integer i = any

    ''
    i = 0
    expr = NULL
    do
    	'' Expression
		dimexpr = cExpression( )
		if( dimexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake an expr
			dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
            dimexpr = hArgArrayBoundChk( dimexpr, sym, i )
			if( dimexpr = NULL ) then
				return NULL
			end if
    	end if

    	if( expr = NULL ) then
    		expr = dimexpr
    	else
    		expr = astNewBOP( AST_OP_ADD, expr, dimexpr )
    	end if

    	'' separator
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if

    	i += 1

    	'' it's a descriptor pointer, dereference (only with DAG this will be optimized)

    	'' times desc[i].elements
    	expr = astNewBOP( AST_OP_MUL, _
    					  expr, _
    					  astNewDEREF( astNewVAR( sym, 0, FB_DATATYPE_INTEGER ), _
    						   		   FB_DATATYPE_INTEGER, _
    						   		   NULL, _
    						   		   FB_ARRAYDESCLEN + i*FB_ARRAYDESC_DIMLEN ) )
	loop

	'' times length
	expr = astNewBOP( AST_OP_MUL, expr, astNewCONSTi( symbGetLen( sym ) ) )

   	'' plus desc->data (= ptr + diff)
    function = astNewBOP( AST_OP_ADD, _
    					  expr, _
    					  astNewDEREF( astNewVAR( sym, 0, FB_DATATYPE_INTEGER ), _
    					   			   FB_DATATYPE_INTEGER, _
    					   			   NULL, _
    					   			   FB_ARRAYDESC_DATAOFFS ) )

end function

'':::::
''ArrayIdx        =   '(' Expression (',' Expression)* ')' .
''
function cArrayIdx _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as FBVARDIM ptr d = any
    dim as integer dtype = any, dims = any, maxdims = any
    dim as ASTNODE ptr expr = any, dimexpr = any, varexpr = any

    ''  argument passed by descriptor?
    if( symbIsParamByDesc( sym ) ) then
    	return cArgArrayIdx( sym )

    '' dynamic array? (will handle common's too)
    elseif( symbGetIsDynamic( sym ) ) then
    	return cDynArrayIdx( sym )
    end if

    ''
    maxdims = symbGetArrayDimensions( sym )
    dims = 0

    ''
    d = symbGetArrayFirstDim( sym )
    expr = NULL
    do
    	dims += 1
    	if( dims > maxdims ) then
			errReport( FB_ERRMSG_WRONGDIMENSIONS )
			return NULL
    	end if

    	'' Expression
		dimexpr = cExpression( )
		if( dimexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake an expr
			dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
    		dimexpr = astNewBOUNDCHK( dimexpr, _
    								  astNewCONSTi( d->lower, FB_DATATYPE_INTEGER ), _
    								  astNewCONSTi( d->upper, FB_DATATYPE_INTEGER ), _
    								  lexLineNum( ) )
			if( dimexpr = NULL ) then
				errReport( FB_ERRMSG_ARRAYOUTOFBOUNDS )
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
			end if
    	end if

    	''
    	if( expr = NULL ) then
    		expr = dimexpr
    	else
    		expr = astNewBOP( AST_OP_ADD, expr, dimexpr )
    	end if

    	'' separator
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if

        '' next
        d = d->next
    	if( d = NULL ) then
			errReport( FB_ERRMSG_WRONGDIMENSIONS )
			exit do
    	end if

    	expr = astNewBOP( AST_OP_MUL, _
    					  expr, _
    					  astNewCONSTi( (d->upper - d->lower) + 1 ) )
	loop

    ''
    if( dims < maxdims ) then
		errReport( FB_ERRMSG_WRONGDIMENSIONS )
    end if

	'' times length (this will be optimized if len < 10 and there are
	'' no arrays on following fields)
	function = astNewBOP( AST_OP_MUL, _
					  	  expr, _
					  	  astNewCONSTi( symbGetLen( sym ) ) )

end function

'':::::
private function hVarAddUndecl _
	( _
		byval id as zstring ptr, _
		byval dtype as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any
	dim as FBARRAYDIM dTB(0) = any
	dim as integer attrib = any, options = any
	dim as ASTNODE ptr var_ = any

	function = NULL

	if( symbGetProcStaticLocals( parser.currproc ) ) then
		attrib = FB_SYMBATTRIB_STATIC
	else
		attrib = 0

		'' inside a namespace but outside a proc?
		if( symbIsGlobalNamespc( ) = FALSE ) then
			if( fbIsModLevel( ) ) then
				if( (attrib and (FB_SYMBATTRIB_SHARED or _
								 FB_SYMBATTRIB_COMMON or _
								 FB_SYMBATTRIB_PUBLIC or _
								 FB_SYMBATTRIB_EXTERN)) = 0 ) then
					'' they are never allocated on stack..
					attrib or= FB_SYMBATTRIB_STATIC
				end if
			end if
		end if

	end if

	'' no suffix?
	if( dtype = FB_DATATYPE_INVALID ) then
		dtype = symbGetDefType( id )
	else
		attrib or= FB_SYMBATTRIB_SUFFIXED
	end if

	options = 0

	'' respect scopes?
	if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
		'' deprecated quirk: not inside an explicit SCOPE .. END SCOPE block?
		if( fbGetIsScope( ) = FALSE ) then
 			options or= FB_SYMBOPT_UNSCOPE
		end if

	'' no scopes..
	else
		options or= FB_SYMBOPT_UNSCOPE
	end if

    s = symbAddVarEx( id, NULL, _
    				  dtype, NULL, 0, _
    				  0, dTB(), _
    				  attrib, _
    				  options )

    if( s = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		'' error recovery: fake an id
		s = symbAddVar( hMakeTmpStr( ), dtype, NULL, 0, dTB(), attrib )
	else
		var_ = astNewDECL( s, NULL )

		'' move to function scope?
		if( (options and FB_SYMBOPT_UNSCOPE) <> 0 ) then
			astAddUnscoped( var_ )

		'' respect the scope..
		else
			astAdd( var_ )
		end if
	end if

	function = s

end function

'':::::
private function hMakeArrayIdx _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

    ''  argument passed by descriptor?
    if( symbIsParamByDesc( sym ) ) then
    	'' return descriptor->data
    	return astNewDEREF( astNewVAR( sym, 0, FB_DATATYPE_INTEGER ), _
    					  	FB_DATATYPE_INTEGER, _
    					  	NULL, _
    					  	FB_ARRAYDESC_DATAOFFS )
    end if

    '' dynamic array? (this will handle common's too)
    if( symbGetIsDynamic( sym ) ) then
    	'' return descriptor.data
    	return astNewVAR( symbGetArrayDescriptor( sym ), _
    					  FB_ARRAYDESC_DATAOFFS, _
    					  FB_DATATYPE_INTEGER )
    end if

    '' static array, return lbound( array )
    function = astNewCONSTi( symbGetArrayFirstDim( sym )->lower, _
    						 FB_DATATYPE_INTEGER )

end function

'':::::
''Variable        =   ID ArrayIdx? UdtMember? FuncPtrOrMemberDeref? .
''
function cVariableEx overload _
	( _
		byval sym as FBSYMBOL ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any
	dim as ASTNODE ptr varexpr = any, idxexpr = any
	dim as integer is_byref = any, is_funcptr = any, is_array = any

	function = NULL

	'' ID
	lexSkipToken( )

	dtype = symbGetFullType( sym )
	subtype = symbGetSubtype( sym )

    is_byref = symbIsParamByRef( sym ) or symbIsImport( sym )
	is_array = symbIsArray( sym )
	is_funcptr = FALSE

    varexpr = NULL
    idxexpr = NULL

	dim as integer check_fields = TRUE, is_nidxarray = FALSE

    '' check for '('')', it's not an array, just passing by desc
    if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead( 1 ) <> CHAR_RPRNT ) then

    		'' ArrayIdx?
    		if( is_array ) then
    			'' '('
    			lexSkipToken( )

    			idxexpr = cArrayIdx( sym )

				'' ')'
    			if( hMatch( CHAR_RPRNT ) = FALSE ) then
					errReport( FB_ERRMSG_EXPECTEDRPRNT )
					'' error recovery: skip until next ')'
					hSkipUntil( CHAR_RPRNT, TRUE )
    			end if
    		else
   				'' check if calling functions through pointers
   				is_funcptr = (typeGetDtAndPtrOnly( dtype ) = typeAddrOf( FB_DATATYPE_FUNCTION ))

    			'' using (...) with scalars?
    			if( (is_array = FALSE) and (is_funcptr = FALSE) ) then
					errReport( FB_ERRMSG_ARRAYNOTALLOCATED, TRUE )
					'' error recovery: skip the index
					lexSkipToken( )
					hSkipUntil( CHAR_RPRNT, TRUE )
    			end if
    		end if
    	else
    		'' array? could be a func ptr call too..
    		if( is_array ) then
    			check_fields = FALSE
    		end if
    	end if

    else
		'' array and no index?
		if( is_array ) then
   			if( check_array ) then
				errReport( FB_ERRMSG_EXPECTEDINDEX, TRUE )
				'' error recovery: fake an index
				idxexpr = hMakeArrayIdx( sym )
   			else
   				check_fields = FALSE
   				is_nidxarray = TRUE
   			end if
    	end if
    end if

	'' AST will handle descriptor pointers
	if( is_byref ) then
		'' byref or import? by now it's a pointer var, the real type will be set bellow
		varexpr = astNewVAR( sym, 0, typeAddrOf( dtype ), subtype )
	else
		varexpr = astNewVAR( sym, 0, dtype, subtype )
	end if

	'' array or index?
	if( idxexpr <> NULL ) then
		'' byref or import's are already pointers
		if( is_byref ) then
			varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )
		else
			varexpr = astNewIDX( varexpr, idxexpr, dtype, subtype )
		end if
	end if

	'' check arguments passed by reference (implicity pointer's)
	if( is_byref ) then
		varexpr = astNewDEREF( varexpr, dtype, subtype )
	end if

   	''
   	if( is_funcptr = FALSE ) then
   		if( check_fields ) then
   			'' ('.' UdtMember)?
   			if( lexGetToken( ) = CHAR_DOT ) then

				select case	typeGet( dtype )
				case FB_DATATYPE_STRUCT	', FB_DATATYPE_CLASS

				case else
					errReport( FB_ERRMSG_EXPECTEDUDT, TRUE )
				end select

   				lexSkipToken( LEXCHECK_NOPERIOD )

   				varexpr = cUdtMember( dtype, _
   									  subtype, _
   									  astNewADDROF( varexpr ), _
   									  check_array )
   				if( varexpr = NULL ) then
   					exit function
   				end if

   				'' non-indexed array?
				if( astIsNIDXARRAY( varexpr ) ) then
					return varexpr
				end if

				dtype =	astGetDataType(	varexpr	)
				subtype	= astGetSubType( varexpr )

				'' check if	calling	functions through pointers
				if(	lexGetToken( ) = CHAR_LPRNT	) then
					is_funcptr = (dtype = typeAddrOf( FB_DATATYPE_FUNCTION ))
				end	if

			end if
   		end if
   	end if

    if( check_fields ) then
    	'' FuncPtrOrMemberDeref?
		varexpr = cFuncPtrOrMemberDeref( dtype, _
									  	 subtype, _
									  	 varexpr, _
									  	 is_funcptr, _
									  	 check_array )

	else
		if( is_nidxarray ) then
			varexpr = astNewNIDXARRAY( varexpr )
		end if
	end if

	function = varexpr

end function

'':::::
''Variable        =   ID .
''
function cVariableEx _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	dim as zstring ptr id = any
	dim as integer suffix = any
	dim as FBSYMBOL ptr sym = any

	id = lexGetText( )
	suffix = lexGetType( )

	if( env.clopt.lang = FB_LANG_QB ) then
		'' keyword with no suffix?  Then it can't be a variable
		if( lexGetClass( ) = FB_TKCLASS_KEYWORD ) then
			if( suffix = FB_DATATYPE_INVALID ) then
				return NULL
			end if
		end if
	end if

	if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) ) then
    	'' no suffix? lookup the default type (last DEF###) in the
    	'' case symbol could not be found..
    	if( suffix = FB_DATATYPE_INVALID ) then
    		sym = symbFindVarByDefType( chain_, symbGetDefType( id ) )
    	else
    		sym = symbFindVarBySuffix( chain_, suffix )
    	end if

	else
		if( suffix <> FB_DATATYPE_INVALID ) then
			errReportNotAllowed( FB_LANG_OPT_SUFFIX, FB_ERRMSG_SUFFIXONLYVALIDINLANG )
		end if

		sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
	end if

	if( sym = NULL ) then
		if( env.opt.explicit ) then
			errReportUndef( FB_ERRMSG_VARIABLENOTDECLARED, id )
		end if

		'' don't allow explicit namespaces
    	if( chain_ <> NULL ) then
    		if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) ) then
    			'' variable?
    			sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
    			if( sym <> NULL ) then
    				'' from a different namespace?
    				if( symbGetNamespace( sym ) <> symbGetCurrentNamespc( ) ) then
						errReport( FB_ERRMSG_DECLOUTSIDENAMESPC )
    				end if
    			end if
    		end if
    	end if

		'' add undeclared variable
		sym = hVarAddUndecl( id, suffix )
		if( sym = NULL ) then
			return NULL
		end if

		'' show warning if inside an expression (ie: var was never set)
		if( fbGetIsExpression( ) ) then
			if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
				if( env.opt.explicit = FALSE ) then
					errReportWarn( FB_WARNINGMSG_IMPLICITALLOCATION, id )
				end if
			end if
		end if

	end if

	function = cVariableEx( sym, check_array )

end function

''::::
private function hImpField _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

   	dim as ASTNODE ptr varexpr = cUdtMember( dtype, _
   											 subtype, _
   											 astNewVAR( this_, _
   											 			0, _
   											 			typeAddrOf( dtype ), _
   											 			subtype ), _
   											 check_array )
   	if( varexpr = NULL ) then
   		return NULL
   	end if

   	'' non-indexed array?
   	if( astIsNIDXARRAY( varexpr ) ) then
   		return varexpr
   	end if

	dtype =	astGetFullType( varexpr )
	subtype	= astGetSubType( varexpr )

	'' check if	calling	functions through pointers
	dim as integer is_funcptr = FALSE
	if(	lexGetToken( ) = CHAR_LPRNT	) then
		is_funcptr = (typeGetDtAndPtrOnly( dtype ) = typeAddrOf( FB_DATATYPE_FUNCTION ))
	end	if

    '' FuncPtrOrMemberDeref?
	function = cFuncPtrOrMemberDeref( dtype, _
								 	  subtype, _
								 	  varexpr, _
								 	  is_funcptr, _
								 	  check_array )
end function

'':::::
''WithVariable        =   '.' UdtMember FuncPtrOrMemberDeref? .
''
function cWithVariable _
	( _
		byval sym as FBSYMBOL ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

    '' '.'
    lexSkipToken( LEXCHECK_NOPERIOD )

    function = hImpField( sym, _
    					  typeDeref( symbGetFullType( sym ) ), _
    					  symbGetSubtype( sym ), _
    					  check_array )

end function

'':::::
''Variable        =   '.'? ID ArrayIdx? UdtMember? FuncPtrOrMemberDeref? .
''
function cVariable _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	'' ID
    select case lexGetClass( )
    case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD
	    return cVariableEx( chain_, check_array )

	case else
		if( parser.stmt.with.sym = NULL ) then
			return NULL
		end if

		'' '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			return NULL
		end if

		return cWithVariable( parser.stmt.with.sym, check_array )
	end select

end function

'':::::
''ImplicitDataMember    =   UdtMember? FuncPtrOrMemberDeref? .
''
function cImplicitDataMember _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr this_ = NULL

	dim as FBSYMBOL ptr param = symbGetProcHeadParam( parser.currproc )
	if( symbIsMethod( parser.currproc ) and (param <> NULL) ) then
		this_ = symbGetParamVar( param )
	end if

	if( this_ = NULL ) then
		errReport( FB_ERRMSG_STATICMEMBERHASNOINSTANCEPTR )
		return NULL
	end if
	
	if( base_parent = NULL ) then
		base_parent = symbGetSubtype( this_ )
	End If

    function = hImpField( this_, _
    					  symbGetFullType( this_ ), _
    					  base_parent, _
    					  check_array )

end function

'' cVarOrDeref = Deref | PtrTypeCasting | AddrOf | Variable
function cVarOrDeref _
	( _
		byval options as FB_VAREXPROPT _
	) as ASTNODE ptr

	dim as integer last_isexpr = any
	if( options and FB_VAREXPROPT_ISEXPR ) then
		last_isexpr = fbGetIsExpression( )
		fbSetIsExpression( TRUE )
	end if

	dim as FB_PARSEROPT parseroptions = parser.options
	fbSetCheckArray( ((options and FB_VAREXPROPT_NOARRAYCHECK) = 0) )
	dim as ASTNODE ptr expr = cHighestPrecExpr( NULL, NULL )
	parser.options = parseroptions

	if( expr <> NULL ) then
		'' skip any casting if they won't do any conversion
		dim as ASTNODE ptr t = expr
		if( astIsCAST( expr ) ) then
			if( astGetCASTDoConv( expr ) = FALSE ) then
				t = astGetLeft( expr )
			end if
		end if

		dim as integer complain = TRUE

		select case as const astGetClass( t )
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
		     AST_NODECLASS_FIELD, AST_NODECLASS_DEREF
			complain = FALSE

		case AST_NODECLASS_CALL, AST_NODECLASS_NIDXARRAY
			complain = ((options and FB_VAREXPROPT_ISASSIGN) <> 0)

		case AST_NODECLASS_ADDROF, AST_NODECLASS_OFFSET
			complain = ((options and FB_VAREXPROPT_ALLOWADDROF) = 0)

		case AST_NODECLASS_BOP
			'' allow addresses?
			if( options and FB_VAREXPROPT_ALLOWADDROF ) then
				'' not a pointer? (@foo[bar] will be converted to foo + bar)
				complain = not typeIsPtr( astGetDataType( expr ) )
			end if
		end select

		if( complain ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			astDelTree( expr )
			expr = NULL
			'' no error recovery: caller will take care
		end if
	end if

	function = expr

	if( options and FB_VAREXPROPT_ISEXPR ) then
		fbSetIsExpression( last_isexpr )
	end if

end function
