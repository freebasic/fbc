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
function cFieldArray( byval elm as FBSYMBOL ptr, _
					  byval typ as integer, _
					  byref idxexpr as ASTNODE ptr ) as integer

    dim as FBVARDIM ptr d
    dim as integer maxdims, dims
    dim as ASTNODE ptr expr, dimexpr, constexpr
    dim as integer diff

    function = FALSE

    ''
    maxdims = symbGetArrayDimensions( elm )
    dims = 0
    d = symbGetArrayFirstDim( elm )
    expr = NULL
    do
    	dims += 1
    	if( dims > maxdims ) then
			hReportError( FB_ERRMSG_WRONGDIMENSIONS )
			exit function
    	end if

    	'' Expression
		if( not cExpression( dimexpr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> IR_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				exit function
			end if
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
    		dimexpr = astNewBOUNDCHK( dimexpr, _
    								  astNewCONSTi( d->lower, IR_DATATYPE_INTEGER ), _
    								  astNewCONSTi( d->upper, IR_DATATYPE_INTEGER ), _
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
    		expr = astNewBOP( IR_OP_ADD, expr, dimexpr )
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

    	constexpr = astNewCONSTi( (d->upper - d->lower)+1, IR_DATATYPE_INTEGER )
    	expr = astNewBOP( IR_OP_MUL, expr, constexpr )
	loop

    ''
    if( dims < maxdims ) then
		hReportError( FB_ERRMSG_WRONGDIMENSIONS )
		exit function
    end if

	'' times length
	constexpr = astNewCONSTi( symbGetLen( elm ), IR_DATATYPE_INTEGER )
	expr = astNewBOP( IR_OP_MUL, expr, constexpr )

    '' plus difference
    diff = symbGetArrayDiff( elm )
    if( diff <> 0 ) then
    	constexpr = astNewCONSTi( diff, IR_DATATYPE_INTEGER )
    	expr = astNewBOP( IR_OP_ADD, expr, constexpr )
    end if

    '' plus initial expression
    if( idxexpr = NULL ) then
    	idxexpr = expr
    else
    	idxexpr = astNewBOP( IR_OP_ADD, idxexpr, expr )
    end if

    ''
    function = TRUE

end function

'':::::
''TypeField       =   ArrayIdx? ('.' ID ArrayIdx?)*
''
function cTypeField( byref elm as FBSYMBOL ptr, _
					 byref typ as integer, _
					 byref subtype as FBSYMBOL ptr, _
					 byref idxexpr as ASTNODE ptr, _
					 byval isderef as integer, _
					 byval checkarray as integer ) as integer

    dim as zstring ptr fields
    dim as ASTNODE ptr constexpr
    dim as integer ofs

	function = FALSE

	do
		if( lexGetToken( ) <> CHAR_LPRNT ) then

			if( typ <> FB_SYMBTYPE_USERDEF ) then
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

    		ofs = symbGetUDTElmOffset( elm, typ, subtype, fields )
    		if( ofs < 0 ) then
    			hReportError( FB_ERRMSG_ELEMENTNOTDEFINED )
    			return FALSE
    		else
				lexSkipToken( )
    		end if

    		if( ofs <> 0 ) then
    			constexpr = astNewCONSTi( ofs, IR_DATATYPE_INTEGER )
    			if( idxexpr = NULL ) then
    				idxexpr = constexpr
    			else
	    			idxexpr = astNewBOP( IR_OP_ADD, idxexpr, constexpr )
    			end if
    		end if

		end if

    	function = TRUE

		''
		if( elm = NULL ) then
			exit function
		end if

    	'' ArrayIdx?
    	if( lexGetToken( ) = CHAR_LPRNT ) then
    		'' '('')'?
    		if( lexGetLookAhead(1) = CHAR_RPRNT ) then
    			exit do
    		end if

			'' if field isn't an array, it can be function field, exit
			if( symbGetArrayDimensions( elm ) = 0 ) then
				exit do
			end if

    		lexSkipToken( )
    	else
			'' array and no index?
			if( symbGetArrayDimensions( elm ) <> 0 ) then
    			if( checkarray ) then
    				hReportError( FB_ERRMSG_EXPECTEDINDEX )
   					return FALSE
    			end if
			end if

    		exit do
    	end if

    	if( not cFieldArray( elm, typ, idxexpr ) ) then
    		exit function
    	end if

    	if( not hMatch( CHAR_RPRNT ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
   			return FALSE
    	end if

    loop

end function

'':::::
''DerefFields	=   ((FIELDDEREF DREF* | '[' Expression ']') TypeField)* .
''
function cDerefFields( byval sym as FBSYMBOL ptr, _
					   byref elm as FBSYMBOL ptr, _
					   byref dtype as integer, _
					   byref subtype as FBSYMBOL ptr, _
					   byref varexpr as ASTNODE ptr, _
					   byval checkarray as integer ) as integer

	dim as integer cnt, lgt
	dim as ASTNODE ptr expr, idxexpr
	dim as integer isfieldderef

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
			if( not cExpression( idxexpr ) ) then
				hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if

			'' if index isn't an integer, convert
			if( (astGetDataClass( idxexpr ) <> IR_DATACLASS_INTEGER) or _
				(astGetDataSize( idxexpr ) <> FB_POINTERSIZE) ) then
				idxexpr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, idxexpr )
				if( idxexpr = NULL ) then
					hReportError( FB_ERRMSG_INVALIDDATATYPES )
					exit function
				end if
			end if

			'' ']'
			if( not hMatch( CHAR_RBRACKET ) ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				return FALSE
			end if

			'' string, fixstr, w|zstring?
			if( dtype < FB_SYMBTYPE_POINTER ) then

				select case dtype
				case FB_SYMBTYPE_STRING, FB_SYMBTYPE_FIXSTR, _
					 FB_SYMBTYPE_CHAR, FB_SYMBTYPE_WCHAR

					if( dtype = FB_SYMBTYPE_STRING ) then
						'' deref
						varexpr = astNewADDR( IR_OP_DEREF, varexpr, sym, elm )
					else
						'' address of
						varexpr = astNewADDR( IR_OP_ADDROF, varexpr, sym, elm )
					end if

					'' add index
					varexpr = astNewBOP( IR_OP_ADD, varexpr, idxexpr )

					'' not a wstring?
					if( dtype <> FB_SYMBTYPE_WCHAR ) then
						dtype = IR_DATATYPE_UBYTE
					else
						dtype = env.target.wchar.type
					end if

					'' make a pointer
					varexpr = astNewPTR( NULL, NULL, 0, varexpr, dtype, NULL )

					'' reset type
					subtype = NULL
					elm = NULL

					return TRUE

				case else
					hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
					return FALSE
				end select

			end if

			'' times length
			lgt = symbCalcLen( dtype - FB_SYMBTYPE_POINTER, subtype )

			if( lgt = 0 ) then
				hReportError( FB_ERRMSG_INCOMPLETETYPE, TRUE )
				exit function
			end if

			idxexpr = astNewBOP( IR_OP_MUL, idxexpr, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ) )

		case else

			exit do

		end select

		if( dtype < FB_SYMBTYPE_POINTER ) then
			hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
			return FALSE
		end if

		dtype -= FB_SYMBTYPE_POINTER

		'' incomplete type?
		if( (dtype = FB_SYMBTYPE_VOID) or (dtype = FB_SYMBTYPE_FWDREF) ) then
			hReportError( FB_ERRMSG_INCOMPLETETYPE, TRUE )
			return FALSE
		end if

		'' TypeField
		expr = NULL
		if( not cTypeField( elm, dtype, subtype, expr, isfieldderef, checkarray ) ) then
			if( idxexpr = NULL ) then
				hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
				return FALSE
			end if
		end if

		'' this should be optimized by AST, when expr is a constant and varexpr is a scalar var
		if( expr <> NULL ) then
			varexpr = astNewBOP( IR_OP_ADD, varexpr, expr )
		end if

		''
		if( idxexpr <> NULL ) then
			varexpr = astNewBOP( IR_OP_ADD, varexpr, idxexpr )
		end if

		'' null pointer checking
		if( env.clopt.extraerrchk ) then
			varexpr = astNewPTRCHK( varexpr, lexLineNum( ) )
		end if

		varexpr = astNewPTR( sym, elm, 0, varexpr, dtype, subtype )

		''
		do while( cnt > 0 )
			if( dtype < FB_SYMBTYPE_POINTER ) then
				hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
				return FALSE
			end if

			dtype -= FB_SYMBTYPE_POINTER

			'' incomplete type?
			if( (dtype = FB_SYMBTYPE_VOID) or (dtype = FB_SYMBTYPE_FWDREF) ) then
				hReportError( FB_ERRMSG_INCOMPLETETYPE, TRUE )
				return FALSE
			end if

			'' null pointer checking
			if( env.clopt.extraerrchk ) then
				varexpr = astNewPTRCHK( varexpr, lexLineNum( ) )
			end if

			varexpr = astNewPTR( sym, elm, 0, varexpr, dtype, subtype )

			cnt -= 1
		loop

		function = TRUE
	loop

end function

'':::::
''FuncPtrOrDeref	=   FuncPtr '(' Args? ')'
''					|   DerefFields .
''
function cFuncPtrOrDerefFields( byref sym as FBSYMBOL ptr, _
					      		byref elm as FBSYMBOL ptr, _
					      		byval typ as integer, _
					      		byval subtype as FBSYMBOL ptr, _
					      		byref varexpr as ASTNODE ptr, _
					      		byval isfuncptr as integer, _
					      		byval checkarray as integer ) as integer

	dim as ASTNODE ptr funcexpr

	function = FALSE

	''
	if( not isfuncptr ) then
		'' DerefFields?
		cDerefFields( sym, elm, typ, subtype, varexpr, checkarray )

		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

   		'' check for functions called through pointers
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( typ = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if
	end if

	'' function pointer dref? call it
	if( isfuncptr ) then

		sym 	= subtype
		elm 	= NULL

		'' function?
		if( symbGetType( sym ) <> FB_SYMBTYPE_VOID ) then
			if( not cFunctionCall( sym, elm, funcexpr, varexpr ) ) then
				exit function
			end if
		'' sub..
		else
			if( not cProcCall( sym, funcexpr, varexpr ) ) then
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
    						   			  NULL, _
    								  	  FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_LBOUNDOFS, _
    								  	  IR_DATATYPE_INTEGER ), _
    						   astNewVAR( desc, _
    						   			  NULL, _
    								  	  FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_UBOUNDOFS, _
    								  	  IR_DATATYPE_INTEGER ), _
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

    if( not symbIsCommon( sym ) ) then
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
		if( not cExpression( dimexpr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> IR_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, dimexpr )
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
    		expr = astNewBOP( IR_OP_ADD, expr, dimexpr )
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
    						 NULL, _
    						 FB_ARRAYDESCLEN + i*FB_ARRAYDESC_DIMLEN, _
    						 IR_DATATYPE_INTEGER )
    	expr = astNewBOP( IR_OP_MUL, expr, varexpr )
	loop

	'' times length
	constexpr = astNewCONSTi( symbGetLen( sym ), IR_DATATYPE_INTEGER )
	expr = astNewBOP( IR_OP_MUL, expr, constexpr )

    '' check dimensions, if not common
    if( maxdims <> INVALID ) then
    	if( dims < maxdims ) then
			hReportError( FB_ERRMSG_WRONGDIMENSIONS )
			exit function
    	end if
    end if

   	'' plus dsc->data (= ptr + diff)
    varexpr = astNewVAR( d, NULL, FB_ARRAYDESC_DATAOFFS, IR_DATATYPE_INTEGER )
    expr = astNewBOP( IR_OP_ADD, expr, varexpr )

    idxexpr = expr

    ''
    function = TRUE

end function

'':::::
private function hArgArrayBoundChk( byval expr as ASTNODE ptr, _
									byval desc as FBSYMBOL ptr, _
									byval idx as integer ) as ASTNODE ptr

    function = astNewBOUNDCHK( expr, _
    						   astNewPTR( desc, _
    						   			  NULL, _
    								  	  FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_LBOUNDOFS, _
    								  	  astNewVAR( desc, NULL, 0, IR_DATATYPE_INTEGER ), _
    								  	  IR_DATATYPE_INTEGER, _
    								  	  NULL ), _
    						   astNewPTR( desc, _
    						   			  NULL, _
    								  	  FB_ARRAYDESCLEN + idx*FB_ARRAYDESC_DIMLEN + FB_ARRAYDESC_UBOUNDOFS, _
    								  	  astNewVAR( desc, NULL, 0, IR_DATATYPE_INTEGER ), _
    								  	  IR_DATATYPE_INTEGER, _
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
		if( not cExpression( dimexpr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> IR_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, dimexpr )
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
    		expr = astNewBOP( IR_OP_ADD, expr, dimexpr )
    	end if

    	'' separator
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if

    	i += 1

    	'' it's a descriptor pointer, dereference (only with DAG this will be optimized)
    	t = astNewVAR( sym, NULL, 0, IR_DATATYPE_INTEGER )
    	'' times desc[i].elements
    	varexpr = astNewPTR( sym, _
    						 NULL, _
    						 FB_ARRAYDESCLEN + i*FB_ARRAYDESC_DIMLEN, _
    						 t, _
    						 IR_DATATYPE_INTEGER, _
    						 NULL )
    	expr = astNewBOP( IR_OP_MUL, expr, varexpr )
	loop

	'' times length
	constexpr = astNewCONSTi( symbGetLen( sym ), IR_DATATYPE_INTEGER )
	expr = astNewBOP( IR_OP_MUL, expr, constexpr )

   	'' plus dsc->data (= ptr + diff)
    t = astNewVAR( sym, NULL, 0, IR_DATATYPE_INTEGER )
    varexpr = astNewPTR( sym, NULL, FB_ARRAYDESC_DATAOFFS, t, IR_DATATYPE_INTEGER, NULL )
    expr = astNewBOP( IR_OP_ADD, expr, varexpr )

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
		if( not cExpression( dimexpr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> IR_DATACLASS_INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB_INTEGERSIZE) ) then
			dimexpr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, dimexpr )
			if( dimexpr = NULL ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				exit function
			end if
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
    		dimexpr = astNewBOUNDCHK( dimexpr, _
    								  astNewCONSTi( d->lower, IR_DATATYPE_INTEGER ), _
    								  astNewCONSTi( d->upper, IR_DATATYPE_INTEGER ), _
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
    		expr = astNewBOP( IR_OP_ADD, expr, dimexpr )
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

    	constexpr = astNewCONSTi( (d->upper - d->lower) + 1, IR_DATATYPE_INTEGER )
    	expr = astNewBOP( IR_OP_MUL, expr, constexpr )
	loop

    ''
    if( dims < maxdims ) then
		hReportError( FB_ERRMSG_WRONGDIMENSIONS )
		exit function
    end if

	'' times length (this will be optimized if len < 10 and there's
	'' no arrays on following fields)
	constexpr = astNewCONSTi( symbGetLen( s ), IR_DATATYPE_INTEGER )
	expr = astNewBOP( IR_OP_MUL, expr, constexpr )

	idxexpr = expr

	''
	function = TRUE

end function

'':::::
function hVarAddUndecl( byval id as string, _
						byval typ as integer ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
	dim as integer alloctype

	function = NULL

	if( env.isprocstatic ) then
		alloctype = FB_ALLOCTYPE_STATIC
	else
		alloctype = 0
	end if

    s = symbAddVar( @id, typ, NULL, 0, 0, dTB(), alloctype )
    if( s = NULL ) then
		exit function
	end if

	function = s

end function

'':::::
''Variable        =   ID ArrayIdx? TypeField? FuncPtrOrDerefFields? .
''
function cVariable( byref varexpr as ASTNODE ptr, _
					byref sym as FBSYMBOL ptr, _
					byref elm as FBSYMBOL ptr, _
					byval checkarray as integer = TRUE ) as integer

	dim as zstring ptr id
	dim as integer typ, deftyp, ofs
	dim as ASTNODE ptr idxexpr
	dim as FBSYMBOL ptr subtype
	dim as integer isbyref, isfuncptr, isbydesc, isimport, isarray

	function = FALSE

	'' ID
	if( lexGetToken( ) <> FB_TK_ID ) then
		exit function
	end if

    isfuncptr 	= FALSE

	''
	'' lookup
	ofs 		= 0
	elm			= NULL
	subtype 	= NULL
	typ			= lexGetType( )
	id			= lexGetText( )

    '' no suffix? lookup the default type (last DEF###) in the
    '' case symbol could not be found..
    if( typ = INVALID ) then
    	deftyp = hGetDefType( *id )
    else
    	deftyp = INVALID
    end if

    sym = symbFindBySuffix( lexGetSymbol( ), typ, deftyp )
	if( sym <> NULL ) then
		typ 	= sym->typ
		subtype = sym->subtype

	else

		'' it can be also an UDT, as periods can be part of symbol names..
		sym = symbLookupUDTElm( id, lexGetPeriodPos( ), typ, ofs, elm, subtype )
		if( sym = NULL ) then
			'' add undeclared variable
			if( hGetLastError( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			'' add undeclared var
			if( not env.opt.explicit ) then
				if( typ = INVALID ) then
					typ = hGetDefType( *id )
				end if

				sym = hVarAddUndecl( *id, typ )
				if( sym = NULL ) then
					hReportError( FB_ERRMSG_DUPDEFINITION )
					exit function
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
    			if( not hMatch( CHAR_RPRNT ) ) then
    				hReportError( FB_ERRMSG_EXPECTEDRPRNT )
    				exit function
    			end if

    		else
   				'' check if calling functions through pointers
   				if( typ = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_FUNCTION ) then
	   				isfuncptr = TRUE
    			end if

    			'' using (...) w/ scalars?
    			if( elm = NULL ) then
    				if( not isarray and not isfuncptr ) then
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
   	if( not isfuncptr ) then

   		'' TypeField?
   		cTypeField( elm, typ, subtype, idxexpr, FALSE, checkarray )

		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

   		'' check for calling functions through pointers
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( typ = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_FUNCTION ) then
	   			isfuncptr = TRUE
   			end if
   		end if
   	end if

	'' AST will handle descriptor pointers
	if( isbyref or isimport ) then
		'' byref or import? by now it's a pointer var, the real type will be set bellow
		varexpr = astNewVAR( sym, elm, 0, IR_DATATYPE_POINTER, NULL )
	else
		varexpr = astNewVAR( sym, elm, ofs, typ, subtype )
	end if

	'' has index?
	if( idxexpr <> NULL ) then
		'' byref or import's are already pointers
		if( isbyref or isimport ) then
			varexpr = astNewBOP( IR_OP_ADD, varexpr, idxexpr )
		else
			varexpr = astNewIDX( varexpr, idxexpr, typ, subtype )
		end if
	else
		'' array and no index?
		if( not isbydesc ) then
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
   		varexpr = astNewPTR( sym, elm, ofs, varexpr, typ, subtype )
	end if

    '' FuncPtrOrDerefFields?
	cFuncPtrOrDerefFields( sym, elm, typ, subtype, varexpr, isfuncptr, checkarray )

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
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR, AST_NODECLASS_FUNCT

			case AST_NODECLASS_ADDR, AST_NODECLASS_OFFSET
				if( not checkaddrof ) then
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
