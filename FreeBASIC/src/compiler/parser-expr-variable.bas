''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
function cFieldArray( byval sym as FBSYMBOL ptr, _
					  byval typ as integer, _
					  byref idxexpr as ASTNODE ptr ) as integer

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
			hReportError( FB_ERRMSG_WRONGDIMENSIONS )
			exit function
    	end if

    	'' Expression
		if( cExpression( dimexpr ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> FB_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				exit function
			end if
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
    		dimexpr = astNewBOUNDCHK( dimexpr, _
    								  astNewCONSTi( d->lower, FB_DATATYPE_INTEGER ), _
    								  astNewCONSTi( d->upper, FB_DATATYPE_INTEGER ), _
    								  lexLineNum( ) )

			if( dimexpr = NULL ) then
				hReportError( FB_ERRMSG_ARRAYOUTOFBOUNDS )
				exit function
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
			hReportError( FB_ERRMSG_WRONGDIMENSIONS )
			exit function
    	end if

    	constexpr = astNewCONSTi( (d->upper - d->lower)+1, FB_DATATYPE_INTEGER )
    	expr = astNewBOP( AST_OP_MUL, expr, constexpr )
	loop

    ''
    if( dims < maxdims ) then
		hReportError( FB_ERRMSG_WRONGDIMENSIONS )
		exit function
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

    ''
    function = TRUE

end function

'':::::
''TypeField       =   ArrayIdx? ('.' ID ArrayIdx?)*
''
function cTypeField( byref sym as FBSYMBOL ptr, _
					 byref typ as integer, _
					 byref subtype as FBSYMBOL ptr, _
					 byref expr as ASTNODE ptr, _
					 byval isderef as integer, _
					 byval checkarray as integer ) as integer

    dim as zstring ptr fields
    dim as ASTNODE ptr constexpr
    dim as integer ofs

	function = FALSE

	do
		if( lexGetToken( ) <> CHAR_LPRNT ) then

			if( typ <> FB_DATATYPE_USERDEF ) then
				exit function
			end if

			fields = lexGetText( )
			if( fields[0] = 0 ) then				'' len( *fields )
				exit function
			end if

			if( isderef = FALSE ) then

				if( fields[0] <> CHAR_DOT ) then
					exit function
				end if

				fields += 1 						'' mid$( *fields, 2 )

			else
				isderef = FALSE
			end if

    		ofs = symbGetUDTElmOffset( sym, typ, subtype, fields )
    		if( ofs < 0 ) then
    			hReportError( FB_ERRMSG_ELEMENTNOTDEFINED )
    			return FALSE
    		else
				lexSkipToken( )
    		end if

    		if( ofs <> 0 ) then
    			constexpr = astNewCONSTi( ofs, FB_DATATYPE_INTEGER )
    			if( expr = NULL ) then
    				expr = constexpr
    			else
	    			expr = astNewBOP( AST_OP_ADD, expr, constexpr )
    			end if
    		end if

		end if

    	function = TRUE

		''
		if( sym = NULL ) then
			exit function
		end if

    	'' ArrayIdx?
    	if( lexGetToken( ) = CHAR_LPRNT ) then
    		'' '('')'?
    		if( lexGetLookAhead(1) = CHAR_RPRNT ) then
    			exit do
    		end if

			'' if field isn't an array, it can be function field, exit
			if( symbGetArrayDimensions( sym ) = 0 ) then
				exit do
			end if

    		lexSkipToken( )
    	else
			'' array and no index?
			if( symbGetArrayDimensions( sym ) <> 0 ) then
    			if( checkarray ) then
    				hReportError( FB_ERRMSG_EXPECTEDINDEX )
   					return FALSE
    			end if
			end if

    		exit do
    	end if

    	if( cFieldArray( sym, typ, expr ) = FALSE ) then
    		exit function
    	end if

    	if( hMatch( CHAR_RPRNT ) = FALSE ) then
    		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
   			return FALSE
    	end if

    loop

end function

'':::::
''DerefFields	=   ((FIELDDEREF DREF* | '[' Expression ']') TypeField)* .
''
function cDerefFields( byref dtype as integer, _
					   byref subtype as FBSYMBOL ptr, _
					   byref varexpr as ASTNODE ptr, _
					   byval checkarray as integer ) as integer

	dim as integer cnt, lgt
	dim as ASTNODE ptr expr, idxexpr
	dim as integer isfieldderef
	dim as FBSYMBOL ptr sym

	function = FALSE

	do

		idxexpr = NULL
		isfieldderef = FALSE
		cnt	= 0

        select case lexGetToken( )
        '' (FIELDDEREF DREF* TypeField)*
        case FB_TK_FIELDDEREF
        	lexSkipToken( )
        	isfieldderef = TRUE

        	'' DREF*
			do while( lexGetToken( ) = FB_TK_DEREFCHAR )
				lexSkipToken( )
				cnt += 1
			loop

		'' '['
		case CHAR_LBRACKET
			lexSkipToken( )

			'' Expression
			if( cExpression( idxexpr ) = FALSE ) then
				hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if

			'' if index isn't an integer, convert
			if( (astGetDataClass( idxexpr ) <> FB_DATACLASS_INTEGER) or _
				(astGetDataSize( idxexpr ) <> FB_POINTERSIZE) ) then
				idxexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, idxexpr )
				if( idxexpr = NULL ) then
					hReportError( FB_ERRMSG_INVALIDDATATYPES )
					exit function
				end if
			end if

			'' ']'
			if( hMatch( CHAR_RBRACKET ) = FALSE ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				return FALSE
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
					hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
					return FALSE
				end select

			end if

			'' times length
			lgt = symbCalcLen( dtype - FB_DATATYPE_POINTER, subtype )

			if( lgt = 0 ) then
				hReportError( FB_ERRMSG_INCOMPLETETYPE, TRUE )
				exit function
			end if

			idxexpr = astNewBOP( AST_OP_MUL, idxexpr, astNewCONSTi( lgt, FB_DATATYPE_INTEGER ) )

		case else

			exit do

		end select

		if( dtype < FB_DATATYPE_POINTER ) then
			hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
			return FALSE
		end if

		dtype -= FB_DATATYPE_POINTER

		'' incomplete type?
		if( (dtype = FB_DATATYPE_VOID) or (dtype = FB_DATATYPE_FWDREF) ) then
			hReportError( FB_ERRMSG_INCOMPLETETYPE, TRUE )
			return FALSE
		end if

		'' TypeField
		expr = NULL
		sym = astGetSymbol( varexpr )
		if( cTypeField( sym, dtype, subtype, expr, isfieldderef, checkarray ) = FALSE ) then

			if( idxexpr = NULL ) then
				hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
				return FALSE
			end if

			sym = NULL
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
		do while( cnt > 0 )
			if( dtype < FB_DATATYPE_POINTER ) then
				hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
				return FALSE
			end if

			dtype -= FB_DATATYPE_POINTER

			'' incomplete type?
			if( (dtype = FB_DATATYPE_VOID) or (dtype = FB_DATATYPE_FWDREF) ) then
				hReportError( FB_ERRMSG_INCOMPLETETYPE, TRUE )
				return FALSE
			end if

			'' null pointer checking
			if( env.clopt.extraerrchk ) then
				varexpr = astNewPTRCHK( varexpr, lexLineNum( ) )
			end if

			varexpr = astNewPTR( 0, varexpr, dtype, subtype )

			cnt -= 1
		loop

		function = TRUE
	loop

end function

'':::::
''FuncPtrOrDeref	=   FuncPtr '(' Args? ')'
''					|   DerefFields .
''
function cFuncPtrOrDerefFields( byval typ as integer, _
					      		byval subtype as FBSYMBOL ptr, _
					      		byref varexpr as ASTNODE ptr, _
					      		byval isfuncptr as integer, _
					      		byval checkarray as integer ) as integer

	dim as ASTNODE ptr funcexpr

	function = FALSE

	''
	if( isfuncptr = FALSE ) then
		'' DerefFields?
		cDerefFields( typ, subtype, varexpr, checkarray )

		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

   		'' check for functions called through pointers
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( typ = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
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
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end if
		end if

		varexpr = funcexpr

	end if

	function = TRUE

end function

'':::::
private function hDynArrayBoundChk( byval expr as ASTNODE ptr, _
									byval desc as FBSYMBOL ptr, _
									byval idx as integer ) as ASTNODE ptr

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
function cDynArrayIdx( byval sym as FBSYMBOL ptr, _
					   byref idxexpr as ASTNODE ptr ) as integer

    dim as FBSYMBOL ptr d
    dim as integer i, dims, maxdims
    dim as ASTNODE ptr expr, dimexpr, constexpr, varexpr

    function = FALSE

    d = symbGetArrayDescriptor( sym )
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
    	if( maxdims <> INVALID ) then
    		if( dims > maxdims ) then
				hReportError( FB_ERRMSG_WRONGDIMENSIONS )
				exit function
    		end if
    	end if

    	'' Expression
		if( cExpression( dimexpr ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> FB_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				exit function
			end if
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
            dimexpr = hDynArrayBoundChk( dimexpr, d, i )
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
    	varexpr = astNewVAR( d, _
    						 FB_ARRAYDESCLEN + i*FB_ARRAYDESC_DIMLEN, _
    						 FB_DATATYPE_INTEGER )
    	expr = astNewBOP( AST_OP_MUL, expr, varexpr )
	loop

	'' times length
	constexpr = astNewCONSTi( symbGetLen( sym ), FB_DATATYPE_INTEGER )
	expr = astNewBOP( AST_OP_MUL, expr, constexpr )

    '' check dimensions, if not common
    if( maxdims <> INVALID ) then
    	if( dims < maxdims ) then
			hReportError( FB_ERRMSG_WRONGDIMENSIONS )
			exit function
    	end if
    end if

   	'' plus dsc->data (= ptr + diff)
    varexpr = astNewVAR( d, FB_ARRAYDESC_DATAOFFS, FB_DATATYPE_INTEGER )
    expr = astNewBOP( AST_OP_ADD, expr, varexpr )

    idxexpr = expr

    ''
    function = TRUE

end function

'':::::
private function hArgArrayBoundChk( byval expr as ASTNODE ptr, _
									byval desc as FBSYMBOL ptr, _
									byval idx as integer ) as ASTNODE ptr

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
function cArgArrayIdx( byval sym as FBSYMBOL ptr, _
					   byref idxexpr as ASTNODE ptr ) as integer

    dim as integer i
    dim as ASTNODE ptr expr, dimexpr, constexpr, varexpr, t

    function = FALSE

    ''
    i = 0
    expr = NULL
    do
    	'' Expression
		if( cExpression( dimexpr ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> FB_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				exit function
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
function cArrayIdx( byval s as FBSYMBOL ptr, _
					byref idxexpr as ASTNODE ptr ) as integer

    dim as FBVARDIM ptr d
    dim as integer dtype, dims, maxdims
    dim as ASTNODE ptr expr, dimexpr, constexpr, varexpr

    function = FALSE

    ''  argument passed by descriptor?
    if( symbIsArgByDesc( s ) ) then
    	return cArgArrayIdx( s, idxexpr )

    '' dynamic array? (will handle common's too)
    elseif( symbGetIsDynamic( s ) ) then
    	return cDynArrayIdx( s, idxexpr )

    end if

    ''
    maxdims = symbGetArrayDimensions( s )
    dims = 0

    ''
    d = symbGetArrayFirstDim( s )
    expr = NULL
    do
    	dims += 1
    	if( dims > maxdims ) then
			hReportError( FB_ERRMSG_WRONGDIMENSIONS )
			exit function
    	end if

    	'' Expression
		if( cExpression( dimexpr ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> FB_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_INTEGERSIZE) ) then
			dimexpr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				exit function
			end if
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
    		dimexpr = astNewBOUNDCHK( dimexpr, _
    								  astNewCONSTi( d->lower, FB_DATATYPE_INTEGER ), _
    								  astNewCONSTi( d->upper, FB_DATATYPE_INTEGER ), _
    								  lexLineNum( ) )

			if( dimexpr = NULL ) then
				hReportError( FB_ERRMSG_ARRAYOUTOFBOUNDS )
				exit function
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
			hReportError( FB_ERRMSG_WRONGDIMENSIONS )
			exit function
    	end if

    	constexpr = astNewCONSTi( (d->upper - d->lower) + 1, FB_DATATYPE_INTEGER )
    	expr = astNewBOP( AST_OP_MUL, expr, constexpr )
	loop

    ''
    if( dims < maxdims ) then
		hReportError( FB_ERRMSG_WRONGDIMENSIONS )
		exit function
    end if

	'' times length (this will be optimized if len < 10 and there's
	'' no arrays on following fields)
	constexpr = astNewCONSTi( symbGetLen( s ), FB_DATATYPE_INTEGER )
	expr = astNewBOP( AST_OP_MUL, expr, constexpr )

	idxexpr = expr

	''
	function = TRUE

end function

'':::::
function hVarAddUndecl( byval id as zstring ptr, _
						byval typ as integer ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
	dim as integer attrib

	function = NULL

	if( env.isprocstatic ) then
		attrib = FB_SYMBATTRIB_STATIC
	else
		attrib = 0
	end if

    s = symbAddVar( id, typ, NULL, 0, 0, dTB(), attrib )
    if( s = NULL ) then
		exit function
	end if

	function = s

end function

'':::::
''Variable        =   ID ArrayIdx? TypeField? FuncPtrOrDerefFields? .
''
function cVariable( byref varexpr as ASTNODE ptr, _
					byval checkarray as integer = TRUE _
				  ) as integer

	dim as zstring ptr id
	dim as integer typ, deftyp, ofs
	dim as ASTNODE ptr idxexpr
	dim as FBSYMBOL ptr sym, elm, subtype
	dim as integer isbyref, isfuncptr, isbydesc, isimport, isarray

	function = FALSE

	'' ID
	if( lexGetToken( ) <> FB_TK_ID ) then
		exit function
	end if

	''
	isfuncptr 	= FALSE
	ofs 		= 0
	elm			= NULL
	subtype 	= NULL
	typ			= lexGetType( )
	id			= lexGetText( )

    '' no suffix? lookup the default type (last DEF###) in the
    '' case symbol could not be found..
    if( typ = INVALID ) then
    	deftyp = hGetDefType( id )
    else
    	deftyp = INVALID
    end if

    sym = symbFindBySuffix( lexGetSymbol( ), typ, deftyp )
	if( sym <> NULL ) then
		typ 	= sym->typ
		subtype = sym->subtype

	else

		'' it can be also an UDT, as periods can be part of symbol names..
		sym = symbLookupUDTElm( id, lexGetPeriodPos( ), typ, subtype, ofs, elm )
		if( sym = NULL ) then
			'' add undeclared variable
			if( hGetLastError( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			'' add undeclared var
			if( env.opt.explicit = FALSE ) then
				if( typ = INVALID ) then
					typ = hGetDefType( id )
				end if

				sym = hVarAddUndecl( id, typ )
				if( sym = NULL ) then
					hReportError( FB_ERRMSG_DUPDEFINITION )
					exit function
				end if

				'' show warning if inside an expression (ie: var was never set)
				if( env.isexpr ) then
					hReportWarning( FB_WARNINGMSG_IMPLICITALLOCATION, id )
				end if

				subtype = symbGetSubtype( sym )
			else
				hReportError( FB_ERRMSG_VARIABLENOTDECLARED )
				exit function
			end if
		end if
	end if

    ''
	lexSkipToken( )

	if( typ = INVALID ) then
		typ = symbGetType( sym )
	end if

    ''
    isbyref = symbIsArgByRef( sym )

	'' check if it's an import (only set if target is Windows)
	isimport = symbIsImport( sym )

    ''
    idxexpr  = NULL
    isbydesc = FALSE
    isarray  = symbIsArray( sym )

    '' check for '('')', it's not an array, just passing by desc
    if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead( 1 ) <> CHAR_RPRNT ) then

    		'' ArrayIdx?
    		if( (elm = NULL) and isarray ) then
    			'' '('
    			lexSkipToken( )

    			cArrayIdx( sym, idxexpr )

				'' ')'
    			if( hMatch( CHAR_RPRNT ) = FALSE ) then
    				hReportError( FB_ERRMSG_EXPECTEDRPRNT )
    				exit function
    			end if

    		else
   				'' check if calling functions through pointers
   				if( typ = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
	   				isfuncptr = TRUE
    			end if

    			'' using (...) with scalars?
    			if( elm = NULL ) then
    				if( (isarray = FALSE) and (isfuncptr = FALSE) ) then
    					hReportError( FB_ERRMSG_ARRAYNOTALLOCATED, TRUE )
    					exit function
    				end if
    			end if

    		end if

    	else
    		isbydesc = TRUE
    	end if
    end if

   	''
   	if( isfuncptr = FALSE ) then

   		'' TypeField?
   		cTypeField( elm, typ, subtype, idxexpr, FALSE, checkarray )

		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

   		'' check for calling functions through pointers
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( typ = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
	   			isfuncptr = TRUE
   			end if
   		end if
   	end if

	'' AST will handle descriptor pointers
	if( isbyref or isimport ) then
		'' byref or import? by now it's a pointer var, the real type will be set bellow
		varexpr = astNewVAR( sym, 0, FB_DATATYPE_POINTER, NULL )
	else
		varexpr = astNewVAR( sym, ofs, typ, subtype )
	end if

	'' has index?
	if( idxexpr <> NULL ) then
		'' byref or import's are already pointers
		if( isbyref or isimport ) then
			varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )
		else
			varexpr = astNewIDX( varexpr, idxexpr, typ, subtype )
		end if
	else
		'' array and no index?
		if( isbydesc = FALSE ) then
  			if( isarray ) then
  				if( checkarray ) then
   					hReportError( FB_ERRMSG_EXPECTEDINDEX, TRUE )
   					exit function
   				end if
   			end if
    	end if
	end if

	'' check arguments passed by reference (implicity pointer's)
	if( isbyref or isimport ) then
   		varexpr = astNewPTR( ofs, varexpr, typ, subtype )
	end if

    if( elm <> NULL ) then
    	varexpr = astNewFIELD( varexpr, elm, typ, subtype )
    end if

    '' FuncPtrOrDerefFields?
	cFuncPtrOrDerefFields( typ, subtype, varexpr, isfuncptr, checkarray )

	function = (hGetLastError( ) = FB_ERRMSG_OK)

end function

'':::::
''cVarOrDeref		= 	Deref | PtrTypeCasting | AddrOf | Variable
''
function cVarOrDeref( byref varexpr as ASTNODE ptr, _
					  byval checkarray as integer, _
					  byval checkaddrof as integer ) as integer

	dim as integer res

	swap env.checkarray, checkarray

	res = cHighestPrecExpr( varexpr )

	swap env.checkarray, checkarray

	if( res ) then
		if( varexpr <> NULL ) then
			select case as const astGetClass( varexpr )
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FIELD, _
				 AST_NODECLASS_PTR, AST_NODECLASS_FUNCT

			case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
				if( checkaddrof = FALSE ) then
					hReportError( FB_ERRMSG_INVALIDDATATYPES )
					exit function
				end if

			case else
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				exit function
			end select
		end if
	end if

	function = res

end function
