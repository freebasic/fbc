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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"


'':::::
''FieldArray    =   '(' Expression (',' Expression)* ')' .
''
private function hFieldArray _
	( _
		byval sym as FBSYMBOL ptr, _
		byref idxexpr as ASTNODE ptr _
	) as integer

    dim as FBVARDIM ptr d
    dim as integer maxdims, dims
    dim as ASTNODE ptr expr, dimexpr, constexpr
    dim as integer diff

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

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> FB_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
				end if
			end if
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
private function hTypeField _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref expr as ASTNODE ptr, _
		byref derefcnt as integer, _
		byval checkarray as integer _
	) as FBSYMBOL ptr

    dim as ASTNODE ptr constexpr
    dim as FBSYMBOL ptr sym

	function = NULL

	sym = NULL
	derefcnt = 0

	do while( dtype = FB_DATATYPE_USERDEF )

		select case lexGetToken( )
		'' '.'?
		case CHAR_DOT
			lexSkipToken( LEXCHECK_NOLOOKUP )

       	'' (FIELDDEREF DREF* TypeField)*
       	case FB_TK_FIELDDEREF
       		lexSkipToken( LEXCHECK_NOLOOKUP )

       		'' DREF*
			do while( lexGetToken( ) = FB_TK_DEREFCHAR )
				lexSkipToken( LEXCHECK_NOLOOKUP )
				derefcnt += 1
			loop

		case else
			exit do
		end select

		'' ID?
		select case lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD

		case else
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' no error recovery: caller will take care
			exit function
		end select

    	sym = symbLookupUDTElm( subtype, lexGetText( ) )
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

    		'' function pointer?
    		if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
    			exit do
    		end if

    		'' '('')'?
    		if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
    			exit do
    		end if

			'' if field isn't an array, it can be function field, exit
			if( symbGetArrayDimensions( sym ) = 0 ) then
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
			if( checkarray ) then
				if( symbGetArrayDimensions( sym ) <> 0 ) then
    				if( errReport( FB_ERRMSG_EXPECTEDINDEX ) = FALSE ) then
    					exit function
    				end if
    				'' error recovery: no need to fake an expr, field arrays
    				'' are never dynamic (for now)
   				end if
   			end if
        end if

    loop

    function = sym

end function

'':::::
''DerefFields	=   ((FIELDDEREF DREF* | '[' Expression ']') TypeField)* .
''
function cDerefFields _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref varexpr as ASTNODE ptr, _
		byval checkarray as integer _
	) as integer

	dim as integer derefcnt, isderef, lgt
	dim as ASTNODE ptr expr, idxexpr
	dim as FBSYMBOL ptr sym

	function = FALSE

	do
		idxexpr = NULL
		derefcnt = 0
		isderef = FALSE

        select case lexGetToken( )
        '' (FIELDDEREF DREF* TypeField)*
        case FB_TK_FIELDDEREF
        	'' hTypeField will do the rest..
        	isderef = TRUE

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

			'' if index isn't an integer, convert
			if( (astGetDataClass( idxexpr ) <> FB_DATACLASS_INTEGER) or _
				(astGetDataSize( idxexpr ) <> FB_POINTERSIZE) ) then
				idxexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, idxexpr )
				if( idxexpr = NULL ) then
					if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
						exit function
					else
						'' error recovery: faken an expr
						idxexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
					end if
				end if
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

		'' exit..
		case else
			exit function

		end select

		if( dtype < FB_DATATYPE_POINTER ) then
			if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a pointer
				dtype += FB_DATATYPE_POINTER
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
				dtype = FB_DATATYPE_POINTER + FB_DATATYPE_BYTE
				subtype = NULL
			end if
		end select

		'' TypeField
		expr = NULL
		sym = hTypeField( dtype, subtype, expr, derefcnt, checkarray )
		if( sym = NULL ) then
			if( isderef ) then
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

		'' fields at ofs 0 aren't returned as expressions by hTypeField()
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

	dim as ASTNODE ptr funcexpr

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
			if( env.isexpr = FALSE ) then
				if( cProcCall( subtype, funcexpr, varexpr ) = FALSE ) then
					exit function
				end if
			else
				astDelTree( funcexpr )
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

    dim as FBSYMBOL ptr desc
    dim as integer i, dims, maxdims
    dim as ASTNODE ptr expr, dimexpr, constexpr, varexpr

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

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> FB_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_POINTERSIZE) ) then

			dimexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if
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

    dim as integer i
    dim as ASTNODE ptr expr, dimexpr, constexpr, varexpr, t

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

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> FB_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_POINTERSIZE) ) then

			dimexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if
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

    dim as FBVARDIM ptr d
    dim as integer dtype, dims, maxdims
    dim as ASTNODE ptr expr, dimexpr, constexpr, varexpr

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

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> FB_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_INTEGERSIZE) ) then

			dimexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
            	end if
			end if
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

	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
	dim as integer attrib, options

	function = NULL

	if( symbIsStatic( env.currproc ) ) then
		attrib = FB_SYMBATTRIB_STATIC
	else
		attrib = 0
	end if

	options = FB_VAROPT_ADDSUFFIX

	'' not inside an explicit SCOPE .. END SCOPE block?
	if( env.isscope = FALSE ) then
		options or= FB_VAROPT_UNSCOPE
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
		'' not inside an explicit SCOPE .. END SCOPE block?
		if( env.isscope = FALSE ) then
			'' QB quirk: declare it at function scope
			astAddDecl( astNewDECL( FB_SYMBCLASS_VAR, s, NULL ) )

		'' explicit scope..
		else
			astAdd( astNewDECL( FB_SYMBCLASS_VAR, s, NULL ) )
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

	dim as zstring ptr id
	dim as integer dtype, deftyp, drefcnt, checkfields
	dim as ASTNODE ptr idxexpr
	dim as FBSYMBOL ptr sym, elm, subtype
	dim as integer isbyref, isfuncptr, isimport, isarray

	''
	dtype = lexGetType( )
	id = lexGetText( )
	subtype = NULL

    '' no suffix? lookup the default type (last DEF###) in the
    '' case symbol could not be found..
    if( dtype = INVALID ) then
    	deftyp = hGetDefType( id )
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
			dtype = hGetDefType( id )
		end if

		sym = hVarAddUndecl( id, dtype )
		if( sym = NULL ) then
			exit function
		end if

		'' show warning if inside an expression (ie: var was never set)
		if( env.isexpr ) then
			errReportWarn( FB_WARNINGMSG_IMPLICITALLOCATION, id )
		end if

		subtype = symbGetSubtype( sym )
	end if

	lexSkipToken( )

	if( dtype = INVALID ) then
		dtype = symbGetType( sym )
	end if

    ''
	elm	= NULL
    isbyref = symbIsParamByRef( sym )
	isimport = symbIsImport( sym )
	isarray = symbIsArray( sym )

    '' check for '('')', it's not an array, just passing by desc
    idxexpr = NULL
    isfuncptr = FALSE
	checkfields = TRUE
    if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead( 1 ) <> CHAR_RPRNT ) then

    		'' ArrayIdx?
    		if( isarray ) then
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
	   				isfuncptr = TRUE
    			end if

    			'' using (...) with scalars?
    			if( (isarray = FALSE) and (isfuncptr = FALSE) ) then
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
    		if( isarray ) then
    			checkfields = FALSE
    		end if
    	end if

    else
		'' array and no index?
		if( isarray ) then
   			if( checkarray ) then
   				if( errReport( FB_ERRMSG_EXPECTEDINDEX, TRUE ) = FALSE ) then
   					exit function
   				else
   					'' error recovery: fake an index
   					idxexpr = hMakeArrayIdx( sym )
   				end if
   			else
   				checkfields = FALSE
   			end if
    	end if
    end if

   	''
   	if( isfuncptr = FALSE ) then
   		if( checkfields ) then
   			'' TypeField?
   			elm = hTypeField( dtype, subtype, idxexpr, drefcnt, checkarray )
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

   			'' check for calling functions through pointers
   			if( lexGetToken( ) = CHAR_LPRNT ) then
   				if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
	   				isfuncptr = TRUE
   				end if
   			end if
   		end if
   	end if

	'' AST will handle descriptor pointers
	if( isbyref or isimport ) then
		'' byref or import? by now it's a pointer var, the real type will be set bellow
		varexpr = astNewVAR( sym, 0, FB_DATATYPE_POINTER, NULL )
	else
		varexpr = astNewVAR( sym, 0, dtype, subtype )
	end if

	'' has index?
	if( idxexpr <> NULL ) then
		'' byref or import's are already pointers
		if( isbyref or isimport ) then
			varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )
		else
			varexpr = astNewIDX( varexpr, idxexpr, dtype, subtype )
		end if
	end if

	'' check arguments passed by reference (implicity pointer's)
	if( isbyref or isimport ) then
   		varexpr = astNewPTR( 0, varexpr, dtype, subtype )
	end if

    if( elm <> NULL ) then
    	varexpr = astNewFIELD( varexpr, elm, dtype, subtype )
    end if

    if( checkfields ) then
    	'' FuncPtrOrDerefFields?
		cFuncPtrOrDerefFields( dtype, subtype, varexpr, isfuncptr, checkarray )
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

	dim as integer dtype, drefcnt, isfuncptr
	dim as FBSYMBOL ptr elm, subtype

	function = FALSE

   	dtype = symbGetType( sym )
   	subtype = symbGetSubtype( sym )

   	varexpr = astNewVAR( sym, 0, dtype, subtype )

   	'' TypeField
   	dtype -= FB_DATATYPE_POINTER
   	elm = hTypeField( dtype, subtype, varexpr, drefcnt, checkarray )
	if( elm = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' no error recovery: caller will take care
		exit function
	end if

   	'' check for calling functions through pointers
   	isfuncptr = FALSE
   	if( lexGetToken( ) = CHAR_LPRNT ) then
   		if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
	  		isfuncptr = TRUE
   		end if
   	end if

	'' deref the with temp pointer
	varexpr = astNewPTR( 0, varexpr, dtype, subtype )

    if( elm <> NULL ) then
    	varexpr = astNewFIELD( varexpr, elm, dtype, subtype )
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
	if( lexGetToken( ) <> FB_TK_ID ) then
		if( env.stmt.with.sym = NULL ) then
			return FALSE
		end if

		'' '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			return FALSE
		end if

		function = cWithVariable( env.stmt.with.sym, varexpr, checkarray )

	else
		function = cVariableEx( chain_, varexpr, checkarray )
	end if

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

	dim as integer res

	swap env.checkarray, check_array

	res = cHighestPrecExpr( NULL, varexpr )

	swap env.checkarray, check_array

	if( res ) then
		if( varexpr <> NULL ) then
			select case as const astGetClass( varexpr )
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FIELD, _
				 AST_NODECLASS_PTR, AST_NODECLASS_CALL

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
