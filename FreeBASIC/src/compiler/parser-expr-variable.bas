''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


'' variable parsing (scalars, arrays, fields and anything between)
''
'' chng: sep/2004 written [v1ctor]
''		 oct/2004 arrays on fields [v1c]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
private function hCheckIndex _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	'' if index isn't an integer, convert
	select case astGetDataType( expr )
	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT

	case is >= FB_DATATYPE_POINTER
		if( errReport( FB_ERRMSG_INVALIDARRAYINDEX, TRUE ) = FALSE ) then
			exit function
		else
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

	case else
		expr = astNewCONV( FB_DATATYPE_INTEGER, NULL, expr )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDARRAYINDEX, TRUE ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
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
		byref idxexpr as ASTNODE ptr _
	) as integer

    dim as FBVARDIM ptr d = any
    dim as integer maxdims = any, dims = any, diff = any
    dim as ASTNODE ptr expr = any, dimexpr = any, constexpr = any

    function = FALSE

    ''
    maxdims = symbGetArrayDimensions( sym )
    dims = 0
    d = symbGetArrayFirstDim( sym )
    expr = NULL
    do
    	dims += 1
    	if( dims > maxdims ) then
			if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
				exit function
			else
				exit do
			end if
    	end if

    	'' Expression
		if( cExpression( dimexpr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
			end if
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )
		if( dimexpr = NULL ) then
			exit function
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
    		dimexpr = astNewBOUNDCHK( dimexpr, _
    								  astNewCONSTi( d->lower, FB_DATATYPE_INTEGER ), _
    								  astNewCONSTi( d->upper, FB_DATATYPE_INTEGER ), _
    								  lexLineNum( ) )

			if( dimexpr = NULL ) then
				if( errReport( FB_ERRMSG_ARRAYOUTOFBOUNDS ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
				end if
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
			if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
				exit function
			else
				exit do
			end if
    	end if

    	constexpr = astNewCONSTi( (d->upper - d->lower)+1, FB_DATATYPE_INTEGER )
    	expr = astNewBOP( AST_OP_MUL, expr, constexpr )
	loop

    ''
    if( dims < maxdims ) then
		if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
			exit function
		end if
    end if

	'' times length
	constexpr = astNewCONSTi( symbGetLen( sym ), FB_DATATYPE_INTEGER )
	expr = astNewBOP( AST_OP_MUL, expr, constexpr )

    '' plus difference
    diff = symbGetArrayDiff( sym )
    if( diff <> 0 ) then
    	constexpr = astNewCONSTi( diff, FB_DATATYPE_INTEGER )
    	expr = astNewBOP( AST_OP_ADD, expr, constexpr )
    end if

    '' plus initial expression
    if( idxexpr = NULL ) then
    	idxexpr = expr
    else
    	idxexpr = astNewBOP( AST_OP_ADD, idxexpr, expr )
    end if

    function = TRUE

end function

'':::::
''TypeField       =   ArrayIdx? ('.' ID ArrayIdx?)*
''
function cTypeField _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref expr as ASTNODE ptr, _
		byref derefcnt as integer, _
		byval options as FB_FIELDOPT _
	) as FBSYMBOL ptr

    dim as ASTNODE ptr constexpr = any
    dim as FBSYMBOL ptr sym = any
    dim as integer is_method = any

	function = NULL

	sym = NULL
	derefcnt = 0

	do while( dtype = FB_DATATYPE_STRUCT )

		select case lexGetToken( )
		'' '.'?
		case CHAR_DOT
			lexSkipToken( LEXCHECK_NOPERIOD )

       	'' ('->' DREF* TypeField)*
       	case FB_TK_FIELDDEREF
       		if( (options and FB_FIELDOPT_CHECKDEREF) = 0 ) then
       			exit do
       		end if

       		lexSkipToken( LEXCHECK_NOPERIOD )

       		'' DREF*
			do while( lexGetToken( ) = FB_TK_DEREFCHAR )
				lexSkipToken( LEXCHECK_NOPERIOD )
				derefcnt += 1
			loop

		case else
			if( (options and FB_FIELDOPT_ISMETHOD) = 0 ) then
				exit do
			end if

			'' only once
			options and= not FB_FIELDOPT_ISMETHOD
		end select

		'' ID?
		select case as const lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

		case else
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' no error recovery: caller will take care
			exit function
		end select

    	sym = symbLookupCompField( subtype, lexGetText( ) )
    	if( sym = NULL ) then
    		if( errReportUndef( FB_ERRMSG_ELEMENTNOTDEFINED, lexGetText( ) ) <> FALSE ) then
    			'' no error recovery: caller will take care
    			lexSkipToken( )
    		end if
    		exit function
    	end if

    	if( symbGetOfs( sym ) <> 0 ) then
    		constexpr = astNewCONSTi( symbGetOfs( sym ), FB_DATATYPE_INTEGER )
    		if( expr = NULL ) then
    			expr = constexpr
    		else
	    		expr = astNewBOP( AST_OP_ADD, expr, constexpr )
    		end if
    	end if

    	dtype = symbGetType( sym )
    	subtype = symbGetSubType( sym )

		lexSkipToken( )

		'' '('?
		if( lexGetToken( ) = CHAR_LPRNT ) then

			'' if field isn't an array, it can be function field, exit
			if( symbGetArrayDimensions( sym ) = 0 ) then
				exit do
			end if

    		'' '('')'?
    		if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
    			exit do
    		end if

    		lexSkipToken( )

			if( hFieldArray( sym, expr ) = FALSE ) then
				exit do
			end if

    		'' ')'
    		if( lexGetToken( ) <> CHAR_RPRNT ) then
    			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: skip until next ')'
    				hSkipUntil( CHAR_RPRNT, TRUE )
    			end if

			else
				lexSkipToken( )
			end if

        else
			'' array and no index?
			if( symbGetArrayDimensions( sym ) <> 0 ) then
				if( (options and FB_FIELDOPT_CHECKARRAY) <> 0 ) then
    				if( errReport( FB_ERRMSG_EXPECTEDINDEX ) = FALSE ) then
    					exit function
    				end if
    				'' error recovery: no need to fake an expr, field arrays
    				'' are never dynamic (for now)

   				'' non-indexed array..
   				else
   					expr = astNewNIDXARRAY( expr )
   				end if

   				exit do
   			end if
        end if

    loop

    function = sym

end function

'':::::
''DerefFields	=   (('->' DREF* | '[' Expression ']') TypeField)* .
''
function cDerefFields _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref varexpr as ASTNODE ptr, _
		byval checkarray as integer _
	) as integer

	dim as integer derefcnt = any, isfield = any, lgt = any
	dim as ASTNODE ptr expr = any, idxexpr = any
	dim as FBSYMBOL ptr sym = any

	function = FALSE

	do
		idxexpr = NULL
		derefcnt = 0
		isfield = FALSE

        select case lexGetToken( )
        '' ('->' DREF* TypeField)*
        case FB_TK_FIELDDEREF
        	'' ditto..
        	isfield = TRUE

			if( dtype < FB_DATATYPE_POINTER ) then
				if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
					exit function
				end if

			else
				dtype -= FB_DATATYPE_POINTER
			end if

		'' '['
		case CHAR_LBRACKET
			lexSkipToken( )

			'' Expression
			if( cExpression( idxexpr ) = FALSE ) then
				if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
					exit function
				else
					'' error recovery: faken an expr
					idxexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if

			'' convert index if needed
			idxexpr = hCheckIndex( idxexpr )
			if( idxexpr = NULL ) then
				exit function
			end if

			'' ']'
			if( lexGetToken( ) <> CHAR_RBRACKET ) then
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				else
					'' error recovery: skip until next ']'
					hSkipUntil( CHAR_RBRACKET, TRUE )
				end if

			else
				lexSkipToken( )
			end if

			'' string, fixstr, w|zstring?
			if( dtype < FB_DATATYPE_POINTER ) then

				select case dtype
				case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
					 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

					'' string concatenation is delayed because optimizations..
					varexpr = astUpdStrConcat( varexpr )

					'' function deref?
					if( astIsCALL( varexpr ) ) then
						'' not allowed, STRING and WCHAR results are temporary
						if( errReport( FB_ERRMSG_SYNTAXERROR, TRUE ) = FALSE ) then
							exit function
						end if
					end if

					if( dtype = FB_DATATYPE_STRING ) then
						'' deref
						varexpr = astNewADDR( AST_OP_DEREF, varexpr )
					else
						'' address of
						varexpr = astNewADDR( AST_OP_ADDROF, varexpr )
					end if

					'' add index
					if( dtype = FB_DATATYPE_WCHAR ) then
						'' times sizeof( wchar ) if it's wstring
						idxexpr = astNewBOP( AST_OP_SHL, _
								   			 idxexpr, _
								   			 astNewCONSTi( hToPow2( symbGetDataSize( FB_DATATYPE_WCHAR ) ), _
								   				 		   FB_DATATYPE_INTEGER ) )
					end if

					'' null pointer checking
					if( env.clopt.extraerrchk ) then
						varexpr = astNewPTRCHK( varexpr, lexLineNum( ) )
					end if

					varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )

					'' not a wstring?
					if( dtype <> FB_DATATYPE_WCHAR ) then
						dtype = FB_DATATYPE_UBYTE
					else
						dtype = env.target.wchar.type
					end if

					'' make a pointer
					varexpr = astNewPTR( 0, varexpr, dtype, NULL )

					'' reset type
					subtype = NULL

					return TRUE

				case else
					if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
						exit function
					else
						'' error recovery: fake a pointer
						dtype += FB_DATATYPE_POINTER
					end if
				end select

			end if

			'' times length
			lgt = symbCalcLen( dtype - FB_DATATYPE_POINTER, subtype )

			if( lgt = 0 ) then
				if( errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE ) = FALSE ) then
					exit function
				else
					'' error recovery: fake a type
					dtype = FB_DATATYPE_POINTER + FB_DATATYPE_BYTE
					subtype = NULL
					lgt = 1
				end if
			end if

			idxexpr = astNewBOP( AST_OP_MUL, _
								 idxexpr, _
								 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ) )


			dtype -= FB_DATATYPE_POINTER

		'' exit..
		case else
			exit function

		end select

		select case as const dtype
		'' incomplete type?
		case FB_DATATYPE_VOID, FB_DATATYPE_FWDREF
			if( errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a type
				dtype = FB_DATATYPE_POINTER + FB_DATATYPE_BYTE
				subtype = NULL
			end if

		case FB_DATATYPE_STRUCT

		case else
			if( isfield ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
					exit function
				else
					exit do
				end if
			end if

		end select

		'' TypeField
		expr = NULL
		sym = cTypeField( dtype, subtype, _
						  expr, derefcnt, _
						  iif( checkarray, _
						  	   FB_FIELDOPT_CHECKARRAY or FB_FIELDOPT_CHECKDEREF, _
						  	   FB_FIELDOPT_CHECKDEREF ) )
		if( sym = NULL ) then
			if( isfield ) then
				if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
					exit function
				else
					exit do
				end if
			end if
		end if

		'' null pointer checking
		if( env.clopt.extraerrchk ) then
			varexpr = astNewPTRCHK( varexpr, lexLineNum( ) )
		end if

		'' fields at ofs 0 aren't returned as expressions by cTypeField()
		if( expr <> NULL ) then
			'' this should be optimized by AST, when expr is a constant and
			'' varexpr is a scalar var
			varexpr = astNewBOP( AST_OP_ADD, varexpr, expr )
		end if

		''
		if( idxexpr <> NULL ) then
			varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )
		end if

		''
		varexpr = astNewPTR( 0, varexpr, dtype, subtype )

        ''
		if( sym <> NULL ) then
			varexpr = astNewFIELD( varexpr, sym, dtype, subtype )
 		end if

		''
		do while( derefcnt > 0 )
			if( dtype < FB_DATATYPE_POINTER ) then
				if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
					return FALSE
				else
					exit do
				end if
			end if

			dtype -= FB_DATATYPE_POINTER

			'' incomplete type?
			select case dtype
			case FB_DATATYPE_VOID, FB_DATATYPE_FWDREF
				if( errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE ) = FALSE ) then
					exit function
				else
					'' error recovery: fake a type
					dtype = FB_DATATYPE_BYTE
				end if
			end select

			'' null pointer checking
			if( env.clopt.extraerrchk ) then
				varexpr = astNewPTRCHK( varexpr, lexLineNum( ) )
			end if

			varexpr = astNewPTR( 0, varexpr, dtype, subtype )

			derefcnt -= 1
		loop

	loop

	function = TRUE

end function

'':::::
''FuncPtrOrDeref	=   FuncPtr '(' Args? ')'
''					|   DerefFields .
''
function cFuncPtrOrDerefFields _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byref varexpr as ASTNODE ptr, _
		byval isfuncptr as integer, _
		byval checkarray as integer _
	) as integer

	dim as ASTNODE ptr funcexpr = any

	function = FALSE

	''
	if( isfuncptr = FALSE ) then
		'' DerefFields?
		cDerefFields( dtype, subtype, varexpr, checkarray )

		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

   		'' check for functions called through pointers
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if
	end if

	'' function pointer dref? call it
	if( isfuncptr ) then

		'' function?
		if( symbGetType( subtype ) <> FB_DATATYPE_VOID ) then
			if( cFunctionCall( subtype, funcexpr, varexpr ) = FALSE ) then
				exit function
			end if

		'' sub..
		else
			if( fbGetIsExpression( ) = FALSE ) then
				if( cProcCall( subtype, funcexpr, varexpr ) = FALSE ) then
					exit function
				end if

			else
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if
		end if

		varexpr = funcexpr

	end if

	function = TRUE

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
		byval sym as FBSYMBOL ptr, _
		byref idxexpr as ASTNODE ptr _
	) as integer

    dim as FBSYMBOL ptr desc = any
    dim as integer i = any, dims = any, maxdims = any
    dim as ASTNODE ptr expr = any, dimexpr = any, constexpr = any, varexpr = any

    function = FALSE

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
				if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
					exit function
				else
					exit do
				end if
    		end if
    	end if

    	'' Expression
		if( cExpression( dimexpr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )
		if( dimexpr = NULL ) then
			exit function
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
            dimexpr = hDynArrayBoundChk( dimexpr, desc, i )
			if( dimexpr = NULL ) then
				exit function
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
    	varexpr = astNewVAR( desc, _
    						 FB_ARRAYDESCLEN + i*FB_ARRAYDESC_DIMLEN, _
    						 FB_DATATYPE_INTEGER )
    	expr = astNewBOP( AST_OP_MUL, expr, varexpr )
	loop

	'' times length
	constexpr = astNewCONSTi( symbGetLen( sym ), FB_DATATYPE_INTEGER )
	expr = astNewBOP( AST_OP_MUL, expr, constexpr )

    '' check dimensions, if not common
    if( maxdims <> -1 ) then
    	if( dims < maxdims ) then
			if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
				exit function
			end if
    	end if
    end if

   	'' plus desc.data (= ptr + diff)
    varexpr = astNewVAR( desc, FB_ARRAYDESC_DATAOFFS, FB_DATATYPE_INTEGER )
    expr = astNewBOP( AST_OP_ADD, expr, varexpr )

    idxexpr = expr

    ''
    function = TRUE

end function

'':::::
private function hArgArrayBoundChk _
	( _
		byval expr as ASTNODE ptr, _
		byval desc as FBSYMBOL ptr, _
		byval idx as integer _
	) as ASTNODE ptr

    function = astNewBOUNDCHK( expr, _
    						   astNewPTR( FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_LBOUNDOFS, _
    								  	  astNewVAR( desc, 0, FB_DATATYPE_INTEGER ), _
    								  	  FB_DATATYPE_INTEGER, _
    								  	  NULL ), _
    						   astNewPTR( FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_UBOUNDOFS, _
    								  	  astNewVAR( desc, 0, FB_DATATYPE_INTEGER ), _
    								  	  FB_DATATYPE_INTEGER, _
    								  	  NULL ), _
    						   lexLineNum( ) )


end function

'':::::
''ArgArrayIdx     =   '(' Expression (',' Expression)* ')' .
''
function cArgArrayIdx _
	( _
		byval sym as FBSYMBOL ptr, _
		byref idxexpr as ASTNODE ptr _
	) as integer

    dim as integer i = any
    dim as ASTNODE ptr expr = any, dimexpr = any, constexpr = any, varexpr = any
    dim as ASTNODE ptr t = any

    function = FALSE

    ''
    i = 0
    expr = NULL
    do
    	'' Expression
		if( cExpression( dimexpr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )
		if( dimexpr = NULL ) then
			exit function
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
            dimexpr = hArgArrayBoundChk( dimexpr, sym, i )
			if( dimexpr = NULL ) then
				exit function
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
    	t = astNewVAR( sym, 0, FB_DATATYPE_INTEGER )
    	'' times desc[i].elements
    	varexpr = astNewPTR( FB_ARRAYDESCLEN + i*FB_ARRAYDESC_DIMLEN, _
    						 t, _
    						 FB_DATATYPE_INTEGER, _
    						 NULL )
    	expr = astNewBOP( AST_OP_MUL, expr, varexpr )
	loop

	'' times length
	constexpr = astNewCONSTi( symbGetLen( sym ), FB_DATATYPE_INTEGER )
	expr = astNewBOP( AST_OP_MUL, expr, constexpr )

   	'' plus desc->data (= ptr + diff)
    t = astNewVAR( sym, 0, FB_DATATYPE_INTEGER )
    varexpr = astNewPTR( FB_ARRAYDESC_DATAOFFS, t, FB_DATATYPE_INTEGER, NULL )
    expr = astNewBOP( AST_OP_ADD, expr, varexpr )

    idxexpr = expr

	''
	function = TRUE

end function

'':::::
''ArrayIdx        =   '(' Expression (',' Expression)* ')' .
''
function cArrayIdx _
	( _
		byval sym as FBSYMBOL ptr, _
		byref idxexpr as ASTNODE ptr _
	) as integer

    dim as FBVARDIM ptr d = any
    dim as integer dtype = any, dims = any, maxdims = any
    dim as ASTNODE ptr expr = any, dimexpr = any, constexpr = any, varexpr = any

    function = FALSE

    ''  argument passed by descriptor?
    if( symbIsParamByDesc( sym ) ) then
    	return cArgArrayIdx( sym, idxexpr )

    '' dynamic array? (will handle common's too)
    elseif( symbGetIsDynamic( sym ) ) then
    	return cDynArrayIdx( sym, idxexpr )

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
			if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
				exit function
			else
				exit do
			end if
    	end if

    	'' Expression
		if( cExpression( dimexpr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
			end if
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )
		if( dimexpr = NULL ) then
			exit function
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
    		dimexpr = astNewBOUNDCHK( dimexpr, _
    								  astNewCONSTi( d->lower, FB_DATATYPE_INTEGER ), _
    								  astNewCONSTi( d->upper, FB_DATATYPE_INTEGER ), _
    								  lexLineNum( ) )

			if( dimexpr = NULL ) then
				if( errReport( FB_ERRMSG_ARRAYOUTOFBOUNDS ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
				end if
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
			if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
				exit function
			else
				exit do
			end if
    	end if

    	constexpr = astNewCONSTi( (d->upper - d->lower) + 1, FB_DATATYPE_INTEGER )
    	expr = astNewBOP( AST_OP_MUL, expr, constexpr )
	loop

    ''
    if( dims < maxdims ) then
		if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
			exit function
		end if
    end if

	'' times length (this will be optimized if len < 10 and there's
	'' no arrays on following fields)
	constexpr = astNewCONSTi( symbGetLen( sym ), FB_DATATYPE_INTEGER )
	expr = astNewBOP( AST_OP_MUL, expr, constexpr )

	idxexpr = expr

	''
	function = TRUE

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
	dim as ASTNODE ptr var = any

	function = NULL

	if( symbIsStatic( parser.currproc ) ) then
		attrib = FB_SYMBATTRIB_STATIC
	else
		attrib = 0
	end if

	options = FB_SYMBOPT_ADDSUFFIX

	if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
		options or= FB_SYMBOPT_UNSCOPE
	end if

    s = symbAddVarEx( id, NULL, _
    				  dtype, NULL, 0, 0, _
    				  0, dTB(), _
    				  attrib, _
    				  options )

    if( s = NULL ) then
		if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
			exit function
		else
			'' error recovery: fake an id
			s = symbAddVar( hMakeTmpStr( ), dtype, NULL, 0, 0, dTB(), attrib )
		end if

	else
		var = astNewDECL( FB_SYMBCLASS_VAR, s, NULL )

		'' respect scopes?
		if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
			astAdd( var )
		'' move to function scope..
		else
			astAddUnscoped( var )
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
    	return astNewPTR( FB_ARRAYDESC_DATAOFFS, _
    					  astNewVAR( sym, 0, FB_DATATYPE_INTEGER ), _
    					  FB_DATATYPE_INTEGER, _
    					  NULL )
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
''Variable        =   ID ArrayIdx? TypeField? FuncPtrOrDerefFields? .
''
function cVariableEx _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byref varexpr as ASTNODE ptr, _
		byval checkarray as integer _
	) as integer

	dim as zstring ptr id = any
	dim as integer dtype = any, deftyp = any, drefcnt = any
	dim as FBSYMBOL ptr sym = any, elm = any, subtype = any
	dim as ASTNODE ptr idxexpr = any

	''
	id = lexGetText( )

	dtype = lexGetType( )
	hCheckSuffix( dtype )

	subtype = NULL

    '' no suffix? lookup the default type (last DEF###) in the
    '' case symbol could not be found..
    if( dtype = INVALID ) then
    	deftyp = symbGetDefType( id )
    else
    	deftyp = INVALID
    end if

    sym = symbFindBySuffix( chain_, dtype, deftyp )
	if( sym <> NULL ) then
		dtype = sym->typ
		subtype = sym->subtype

	else
		if( env.opt.explicit ) then
			if( errReportUndef( FB_ERRMSG_VARIABLENOTDECLARED, id ) = FALSE ) then
				exit function
			end if
		end if

		'' don't allow explicit namespaces
    	if( chain_ <> NULL ) then
    		'' variable?
    		sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
    		if( sym <> NULL ) then
    			'' from a different namespace?
    			if( symbGetNamespace( sym ) <> symbGetCurrentNamespc( ) ) then
    				if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
    					exit function
    				end if
    			end if
    		end if
    	end if

		'' add undeclared variable
		if( dtype = INVALID ) then
			dtype = symbGetDefType( id )
		end if

		sym = hVarAddUndecl( id, dtype )
		if( sym = NULL ) then
			exit function
		end if

		'' show warning if inside an expression (ie: var was never set)
		if( fbGetIsExpression( ) ) then
			if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
				errReportWarn( FB_WARNINGMSG_IMPLICITALLOCATION, id )
			end if
		end if

		subtype = symbGetSubtype( sym )
	end if

	lexSkipToken( )

	if( dtype = INVALID ) then
		dtype = symbGetType( sym )
	end if

    ''
	dim as integer is_byref = any, is_funcptr = any, is_import = any
	dim as integer is_array = any, checkfields = any, is_nidxarray = any

	elm	= NULL

    is_byref = symbIsParamByRef( sym )
	is_import = symbIsImport( sym )
	is_array = symbIsArray( sym )
	is_funcptr = FALSE
	is_nidxarray = FALSE

    idxexpr = NULL
	checkfields = TRUE

    '' check for '('')', it's not an array, just passing by desc
    if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead( 1 ) <> CHAR_RPRNT ) then

    		'' ArrayIdx?
    		if( is_array ) then
    			'' '('
    			lexSkipToken( )

    			cArrayIdx( sym, idxexpr )

				'' ')'
    			if( hMatch( CHAR_RPRNT ) = FALSE ) then
    				if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
    					exit function
    				else
    					'' error recovery: skip until next ')'
    					hSkipUntil( CHAR_RPRNT, TRUE )
    				end if
    			end if

    		else
   				'' check if calling functions through pointers
   				if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
	   				is_funcptr = TRUE
    			end if

    			'' using (...) with scalars?
    			if( (is_array = FALSE) and (is_funcptr = FALSE) ) then
    				if( errReport( FB_ERRMSG_ARRAYNOTALLOCATED, TRUE ) = FALSE ) then
    					exit function
    				else
    					'' error recovery: skip the index
    					lexSkipToken( )
    					hSkipUntil( CHAR_RPRNT, TRUE )
    				end if
    			end if
    		end if

    	else
    		'' array? could be a func ptr call too..
    		if( is_array ) then
    			checkfields = FALSE
    		end if
    	end if

    else
		'' array and no index?
		if( is_array ) then
   			if( checkarray ) then
   				if( errReport( FB_ERRMSG_EXPECTEDINDEX, TRUE ) = FALSE ) then
   					exit function
   				else
   					'' error recovery: fake an index
   					idxexpr = hMakeArrayIdx( sym )
   				end if
   			else
   				checkfields = FALSE
   				is_nidxarray = TRUE
   			end if
    	end if
    end if

   	''
   	if( is_funcptr = FALSE ) then
   		if( checkfields ) then
   			'' TypeField?
   			elm = cTypeField( dtype, subtype, _
   							  idxexpr, drefcnt, _
   							  iif( checkarray, FB_FIELDOPT_CHECKARRAY, FB_FIELDOPT_NONE ) )

			if( elm = NULL ) then
				if( errGetLast( ) <> FB_ERRMSG_OK ) then
					exit function
				end if
			else
				if( idxexpr <> NULL ) then
					'' ugly hack to deal with arrays w/o indexes
					if( astIsNIDXARRAY( idxexpr ) ) then
						varexpr = astGetLeft( idxexpr )
						astDelNode( idxexpr )
						idxexpr = varexpr

						checkfields = FALSE
						is_nidxarray = TRUE
					end if
				end if
			end if

   			'' check for calling functions through pointers
   			if( lexGetToken( ) = CHAR_LPRNT ) then
   				if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
	   				is_funcptr = TRUE
   				end if
   			end if
   		end if
   	end if

	'' AST will handle descriptor pointers
	if( is_byref or is_import ) then
		'' byref or import? by now it's a pointer var, the real type will be set bellow
		varexpr = astNewVAR( sym, 0, FB_DATATYPE_POINTER, NULL )
	else
		varexpr = astNewVAR( sym, 0, dtype, subtype )
	end if

	'' has index?
	if( idxexpr <> NULL ) then
		'' byref or import's are already pointers
		if( is_byref or is_import ) then
			varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )
		else
			varexpr = astNewIDX( varexpr, idxexpr, dtype, subtype )
		end if
	end if

	'' check arguments passed by reference (implicity pointer's)
	if( is_byref or is_import ) then
   		varexpr = astNewPTR( 0, varexpr, dtype, subtype )
	end if

    if( elm <> NULL ) then
    	varexpr = astNewFIELD( varexpr, elm, dtype, subtype )
    end if

    if( checkfields ) then
    	'' FuncPtrOrDerefFields?
		cFuncPtrOrDerefFields( dtype, subtype, varexpr, is_funcptr, checkarray )

	'' non-indexed array?
	elseif( is_nidxarray ) then
        varexpr = astNewNIDXARRAY( varexpr )
	end if

	function = (errGetLast( ) = FB_ERRMSG_OK)

end function

'':::::
''WithVariable        =   '.' TypeField FuncPtrOrDerefFields? .
''
function cWithVariable _
	( _
		byval sym as FBSYMBOL ptr, _
		byref varexpr as ASTNODE ptr, _
		byval checkarray as integer _
	) as integer

	dim as integer dtype = any, drefcnt = any, isfuncptr = any
	dim as FBSYMBOL ptr fld = any, subtype = any

	function = FALSE

   	dtype = symbGetType( sym )
   	subtype = symbGetSubtype( sym )

   	varexpr = astNewVAR( sym, 0, dtype, subtype )

   	'' TypeField
   	dtype -= FB_DATATYPE_POINTER
   	fld = cTypeField( dtype, subtype, _
   					  varexpr, drefcnt, _
   					  iif( checkarray, FB_FIELDOPT_CHECKARRAY, FB_FIELDOPT_NONE ) )
	if( fld = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' no error recovery: caller will take care
		exit function
	end if

   	'' check if calling functions through pointers
   	isfuncptr = FALSE
   	if( lexGetToken( ) = CHAR_LPRNT ) then
   		if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
	  		isfuncptr = TRUE
   		end if
   	end if

	'' deref the with temp pointer
	varexpr = astNewPTR( 0, varexpr, dtype, subtype )

    if( fld <> NULL ) then
    	varexpr = astNewFIELD( varexpr, fld, dtype, subtype )
    end if

    '' FuncPtrOrDerefFields?
	cFuncPtrOrDerefFields( dtype, subtype, varexpr, isfuncptr, checkarray )

	function = (errGetLast( ) = FB_ERRMSG_OK)

end function

'':::::
''Variable        =   '.'? ID ArrayIdx? TypeField? FuncPtrOrDerefFields? .
''
function cVariable _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byref varexpr as ASTNODE ptr, _
		byval checkarray as integer = TRUE _
	) as integer

	'' ID
    select case lexGetClass( )
    case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD
	    function = cVariableEx( chain_, varexpr, checkarray )

	case else
		if( parser.stmt.with.sym = NULL ) then
			return FALSE
		end if

		'' '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			return FALSE
		end if

		function = cWithVariable( parser.stmt.with.sym, varexpr, checkarray )
	end select

end function

'':::::
''FieldVariable    =   TypeField? FuncPtrOrDerefFields? .
''
function cFieldVariable _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr, _
		byref varexpr as ASTNODE ptr, _
		byval checkarray as integer _
	) as integer

	dim as integer dtype = any, drefcnt = any, isfuncptr = any
	dim as FBSYMBOL ptr fld = any, subtype = any
	dim as ASTNODE ptr fldexpr = NULL

	function = FALSE

	if( this_ = NULL ) then
		this_ = symbGetParamVar( symbGetProcHeadParam( parser.currproc ) )
	end if

   	dtype = symbGetType( this_ )
   	subtype = symbGetSubtype( this_ )

   	'' TypeField
   	fld = cTypeField( dtype, subtype, _
   					  fldexpr, drefcnt, _
   					  iif( checkarray, _
   					  	   FB_FIELDOPT_ISMETHOD or FB_FIELDOPT_CHECKARRAY, _
   					  	   FB_FIELDOPT_ISMETHOD ) )
	if( fld = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' no error recovery: caller will take care
		exit function
	end if

   	'' check if calling functions through pointers
   	isfuncptr = FALSE
   	if( lexGetToken( ) = CHAR_LPRNT ) then
   		if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
	  		isfuncptr = TRUE
   		end if
   	end if

   	'' build this.field
   	varexpr = astNewVAR( this_, 0, FB_DATATYPE_POINTER, NULL )

	if( fldexpr <> NULL ) then
		varexpr = astNewBOP( AST_OP_ADD, varexpr, fldexpr )
	end if

	'' deref the with temp pointer
	varexpr = astNewPTR( 0, varexpr, dtype, subtype )

    if( fld <> NULL ) then
    	varexpr = astNewFIELD( varexpr, fld, dtype, subtype )
    end if

    '' FuncPtrOrDerefFields?
	cFuncPtrOrDerefFields( dtype, subtype, varexpr, isfuncptr, TRUE )

	function = (errGetLast( ) = FB_ERRMSG_OK)

end function

'':::::
''cVarOrDeref		= 	Deref | PtrTypeCasting | AddrOf | Variable
''
function cVarOrDeref _
	( _
		byref varexpr as ASTNODE ptr, _
		byval check_array as integer, _
		byval check_addrof as integer _
	) as integer

	dim as integer res = any
	dim as FB_PARSEROPT options = any

	options = parser.options
	fbSetCheckArray( check_array )

	res = cHighestPrecExpr( NULL, varexpr )

	parser.options = options

	if( res ) then
		if( varexpr <> NULL ) then
			select case as const astGetClass( varexpr )
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FIELD, _
				 AST_NODECLASS_PTR, AST_NODECLASS_CALL, AST_NODECLASS_NIDXARRAY

			case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
				if( check_addrof = FALSE ) then
					astDelTree( varexpr )
					varexpr = NULL
					errReport( FB_ERRMSG_INVALIDDATATYPES )
					'' no error recovery: caller will take care
					exit function
				end if

			case else
				astDelTree( varexpr )
				varexpr = NULL
				errReport( FB_ERRMSG_INVALIDDATATYPES )
				'' no error recovery: ditto
				exit function
			end select
		end if
	end if

	function = res

end function
