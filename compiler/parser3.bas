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


'' parser part 3 - just variables parsing.. QB quirks make it so damn
''				   complex that a module just for it was needed..
''
'' chng: sep/2004 written [v1ctor]
''		 oct/2004 arrays on fields [v1c]

option explicit
option escape

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\emit.bi'


'':::::
function cFieldArray( byval elm as FBTYPELEMENT ptr, byval typ as integer, idxexpr as integer ) as integer
    dim d as FBVARDIM ptr, maxdims as integer, dims as integer, l as integer, u as integer
    dim expr as integer, dimexpr as integer, constexpr as integer
    dim diff as integer, lgt as integer

    cFieldArray = FALSE

    ''
    maxdims = symbGetUDTElmDimensions( elm )
    dims = 0
    d = symbGetFirstUDTElmDim( elm )
    expr = INVALID
    do
    	dims = dims + 1
    	if( dims > maxdims ) then
			hReportError FB.ERRMSG.WRONGDIMENSIONS
			exit function
    	end if

    	'' Expression
		if( not cExpression( dimexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		end if

		'' if index isn't an integer, convert
		astUpdNodeResult dimexpr
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or (astGetDataSize( dimexpr ) <> 4) ) then
			dimexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, dimexpr )
		end if

    	if( expr = INVALID ) then
    		expr = dimexpr
    	else
    		expr = astNewBOP( IR.OP.ADD, expr, dimexpr )
    	end if

    	'' separator
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if

        d = symbGetNextUDTElmDim( elm, d )

        symbGetUDTElmDims elm, d, l, u
    	constexpr = astNewCONST( (u-l)+1, IR.DATATYPE.INTEGER )
    	expr = astNewBOP( IR.OP.MUL, expr, constexpr )
	loop


    ''
    if( dims < maxdims ) then
		hReportError FB.ERRMSG.WRONGDIMENSIONS
		exit function
    end if


	'' times length
	lgt = symbGetUDTElmLen( elm )
	constexpr = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	expr = astNewBOP( IR.OP.MUL, expr, constexpr )

    '' plus difference
    diff = symbGetUDTElmDiff( elm )
    if( diff <> 0 ) then
    	constexpr = astNewCONST( diff, IR.DATATYPE.INTEGER )
    	idxexpr = astNewBOP( IR.OP.ADD, idxexpr, constexpr )
    end if

    '' plus initial expression
    if( idxexpr = INVALID ) then
    	idxexpr = expr
    else
    	idxexpr = astNewBOP( IR.OP.ADD, idxexpr, expr )
    end if

    ''
    cFieldArray = TRUE

end function

'':::::
''TypeField       =   ArrayIdx? ('.' ID ArrayIdx?)*
''
function cTypeField( elm as FBTYPELEMENT ptr, typesymbol as FBSYMBOL ptr, typ as integer, idxexpr as integer, _
					 byval isderef as integer, byval checkarray as integer ) as integer
    dim fields as string, ofs as integer
    dim constexpr as integer
    dim res as integer

	res = FALSE

	do
		cTypeField = res

		if( lexCurrentToken <> CHAR_LPRNT ) then

			if( typ <> FB.SYMBTYPE.USERDEF ) then
				exit function
			end if

			if( len( lexTokenText ) = 0 ) then
				exit function
			end if

			if( isderef = FALSE ) then
				if( asc( left$( lexTokenText, 1 ) ) <> CHAR_DOT ) then
					exit function
				end if

				fields = mid$( lexTokenText, 2 )

			else
				isderef = FALSE
				fields = lexTokenText
			end if

    		ofs = symbGetUDTElmOffset( elm, typesymbol, typ, fields )
    		if( ofs = INVALID ) then
    			hReportError FB.ERRMSG.ELEMENTNOTDEFINED
    			cTypeField = FALSE
    			exit function
    		else
				lexSkipToken
    		end if

    		if( ofs <> 0 ) then
    			constexpr = astNewCONST( ofs, IR.DATATYPE.INTEGER )
    			if( idxexpr = INVALID ) then
    				idxexpr = constexpr
    			else
	    			idxexpr = astNewBOP( IR.OP.ADD, idxexpr, constexpr )
    			end if
    		end if

		end if

    	res = TRUE

		''
		if( elm = NULL ) then
			exit function
		end if

    	'' ArrayIdx?
    	if( lexCurrentToken = CHAR_LPRNT ) then
    		'' '('')'?
    		if( lexLookahead(1) = CHAR_RPRNT ) then
    			exit do
    		end if

			'' if field isn't an array, it can be function field, exit
			if( symbGetUDTElmDimensions( elm ) = 0 ) then
				exit do
			end if

    		lexSkipToken
    	else
			'' array and no index?
			if( symbGetUDTElmDimensions( elm ) <> 0 ) then
    			if( checkarray ) then
    				hReportError FB.ERRMSG.EXPECTEDLPRNT
   					cTypeField = FALSE
    				exit function
    			end if
			end if

    		exit do
    	end if

    	if( not cFieldArray( elm, typ, idxexpr ) ) then
    		exit function
    	end if

    	if( not hMatch( CHAR_RPRNT ) ) then
    		hReportError FB.ERRMSG.EXPECTEDRPRNT
   			cTypeField = FALSE
    		exit function
    	end if

    loop

    cTypeField = res

end function

'':::::
''DerefFields	=   (FIELDDEREF DREF* TypeField)* .
''
function cDerefFields( s as FBSYMBOL ptr, elm as FBTYPELEMENT ptr, typesymbol as FBSYMBOL ptr, _
					   typ as integer, _
					   varexpr as integer, byval checkarray as integer ) as integer
	dim cnt as integer
	dim expr as integer

	cDerefFields = FALSE

	'' (FIELDDEREF DREF* TypeField)*
	do while( lexCurrentToken = FB.TK.FIELDDEREF )
        lexSkipToken

        '' DREF*
        cnt = 0
		do while( lexCurrentToken = FB.TK.DEREFCHAR )
			lexSkipToken
			cnt = cnt + 1
		loop

		if( typ < FB.SYMBTYPE.POINTER ) then
			hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
			exit function
		end if
		typ = typ - FB.SYMBTYPE.POINTER

		expr = INVALID
		if( not cTypeField( elm, typesymbol, typ, expr, TRUE, checkarray ) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

		'' this should be optimized by AST, when expr is a constant and varexpr is a scalar var
		if( expr <> INVALID ) then
			varexpr = astNewBOP( IR.OP.ADD, varexpr, expr )
		end if

		varexpr = astNewPTREx( NULL, elm, 0, hStyp2Dtype( typ ), varexpr )

		do while( cnt > 0 )
			if( typ < FB.SYMBTYPE.POINTER ) then
				hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
				exit function
			end if
			typ = typ - FB.SYMBTYPE.POINTER

			varexpr = astNewPTREx( NULL, elm, 0, hStyp2Dtype( typ ), varexpr )
			cnt = cnt - 1
		loop

		cDerefFields = TRUE
	loop

end function

'':::::
''DynArrayIdx     =   '(' Expression (DECL_SEPARATOR Expression)* ')' .
''
function cDynArrayIdx( byval s as FBSYMBOL ptr, idxexpr as integer ) as integer
    dim i as integer, dims as integer, maxdims as integer, d as FBSYMBOL ptr
    dim lgt as integer
    dim expr as integer, dimexpr as integer, constexpr as integer, varexpr as integer

    cDynArrayIdx = FALSE

    d = symbGetVarDescriptor( s )
    dims = 0

    if( (symbGetAllocType( s ) and FB.ALLOCTYPE.COMMON) = 0 ) then
    	maxdims = symbGetVarDimensions( s )
    else
    	maxdims = INVALID
    end if

    ''
    i = 0
    expr = INVALID
    do
    	dims = dims + 1

    	'' check dimensions, if not common
    	if( maxdims <> INVALID ) then
    		if( dims > maxdims ) then
				hReportError FB.ERRMSG.WRONGDIMENSIONS
				exit function
    		end if
    	end if

    	'' Expression
		if( not cExpression( dimexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		end if

		'' if index isn't an integer, convert
		astUpdNodeResult dimexpr
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or (astGetDataSize( dimexpr ) <> 4) ) then
			dimexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, dimexpr )
		end if

    	if( expr = INVALID ) then
    		expr = dimexpr
    	else
    		expr = astNewBOP( IR.OP.ADD, expr, dimexpr )
    	end if

    	'' separator
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if

    	i = i + 1

    	varexpr = astNewVAR( d, FB.ARRAYDESCSIZE + i*(FB.INTEGERSIZE*2), IR.DATATYPE.INTEGER )
    	expr = astNewBOP( IR.OP.MUL, expr, varexpr )
	loop

	'' times length
	lgt = symbGetLen( s )
	constexpr = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	expr = astNewBOP( IR.OP.MUL, expr, constexpr )

    '' check dimensions, if not common
    if( maxdims <> INVALID ) then
    	if( dims < maxdims ) then
			hReportError FB.ERRMSG.WRONGDIMENSIONS
			exit function
    	end if
    end if

   	'' plus dsc->data (= ptr + diff)
    varexpr = astNewVAR( d, FB.ARRAYDESC.DATAOFFS, IR.DATATYPE.INTEGER )
    expr = astNewBOP( IR.OP.ADD, expr, varexpr )

    idxexpr = expr

    ''
    cDynArrayIdx = TRUE

end function

'':::::
''ArgArrayIdx     =   '(' Expression (DECL_SEPARATOR Expression)* ')' .
''
function cArgArrayIdx( byval s as FBSYMBOL ptr, idxexpr as integer ) as integer
    dim i as integer, t as integer
    dim lgt as integer
    dim expr as integer, dimexpr as integer, constexpr as integer, varexpr as integer

    cArgArrayIdx = FALSE

    ''
    i = 0
    expr = INVALID
    do
    	'' Expression
		if( not cExpression( dimexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		end if

		'' if index isn't an integer, convert
		astUpdNodeResult dimexpr
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or (astGetDataSize( dimexpr ) <> 4) ) then
			dimexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, dimexpr )
		end if

    	if( expr = INVALID ) then
    		expr = dimexpr
    	else
    		expr = astNewBOP( IR.OP.ADD, expr, dimexpr )
    	end if

    	'' separator
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if

    	i = i + 1

    	'' it's a descriptor pointer, dereference (only with DAG this will be optimized)
    	t = astNewVAR( s, 0, IR.DATATYPE.INTEGER )
    	varexpr = astNewPTR( FB.ARRAYDESCSIZE + i*(FB.INTEGERSIZE*2), IR.DATATYPE.INTEGER, t )
    	expr = astNewBOP( IR.OP.MUL, expr, varexpr )
	loop

	'' times length
	lgt = symbGetLen( s )
	constexpr = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	expr = astNewBOP( IR.OP.MUL, expr, constexpr )

   	'' plus dsc->data (= ptr + diff)
    t = astNewVAR( s, 0, IR.DATATYPE.INTEGER )
    varexpr = astNewPTR( FB.ARRAYDESC.DATAOFFS, IR.DATATYPE.INTEGER, t )
    expr = astNewBOP( IR.OP.ADD, expr, varexpr )

    idxexpr = expr

	''
	cArgArrayIdx = TRUE

end function

'':::::
''ArrayIdx        =   '(' Expression (DECL_SEPARATOR Expression)* ')' .
''
function cArrayIdx( byval s as FBSYMBOL ptr, idxexpr as integer ) as integer
    dim d as FBVARDIM ptr, dims as integer, maxdims as integer, l as integer, u as integer
    dim dtype as integer, lgt as integer
    dim expr as integer, dimexpr as integer, constexpr as integer, varexpr as integer

    cArrayIdx = FALSE

    ''  argument passed by descriptor or common array?
    if( (symbGetAllocType( s ) and FB.ALLOCTYPE.ARGUMENTBYDESC) > 0 ) then
    	cArrayIdx = cArgArrayIdx( s, idxexpr )
    	exit function

    '' dynamic array? (will handle common's too)
    elseif( symbGetVarIsDynamic( s ) ) then
    	cArrayIdx = cDynArrayIdx( s, idxexpr )
    	exit function

    end if

    ''
    maxdims = symbGetVarDimensions( s )
    dims = 0

    ''
    d = symbGetFirstVarDim( s )
    expr = INVALID
    do
    	dims = dims + 1
    	if( dims > maxdims ) then
			hReportError FB.ERRMSG.WRONGDIMENSIONS
			exit function
    	end if

    	'' Expression
		if( not cExpression( dimexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		end if

		'' if index isn't an integer, convert
		astUpdNodeResult dimexpr
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or (astGetDataSize( dimexpr ) <> 4) ) then
			dimexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, dimexpr )
		end if

    	if( expr = INVALID ) then
    		expr = dimexpr
    	else
    		expr = astNewBOP( IR.OP.ADD, expr, dimexpr )
    	end if

    	'' separator
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if

        d = symbGetNextVarDim( s, d )

        symbGetVarDims s, d, l, u
    	constexpr = astNewCONST( (u-l)+1, IR.DATATYPE.INTEGER )
    	expr = astNewBOP( IR.OP.MUL, expr, constexpr )
	loop

    ''
    if( dims < maxdims ) then
		hReportError FB.ERRMSG.WRONGDIMENSIONS
		exit function
    end if

	'' times length (this will be optimized if len < 10 and there's no arrays on following fields)
	lgt = symbGetLen( s )
	constexpr = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	expr = astNewBOP( IR.OP.MUL, expr, constexpr )

	idxexpr = expr

	''
	cArrayIdx = TRUE

end function

'':::::
function hVarLookup( id as string, s as FBSYMBOL ptr, typ as integer, ofs as integer, _
					 elm as FBTYPELEMENT ptr, typesymbol as FBSYMBOL ptr ) as integer

	hVarLookup = FALSE

	s   		= NULL
	ofs 		= 0
	elm			= NULL
	typesymbol 	= NULL

	if( typ = INVALID ) then
		'' check first for declared vars w/o suffixes
		s = symbLookupVar( id, typ, ofs, elm, typesymbol )
		if( s = NULL ) then
			if( typesymbol <> NULL ) then
				exit function
			end if
			'' now with suffixes
			typ = hGetDefType( id )
			s = symbLookupVar( id, typ, ofs, elm, typesymbol )
		end if

	else
		'' check first for declared vars w/ suffixes
		s = symbLookupVar( id, typ, ofs, elm, typesymbol )
		if( s = NULL ) then
			if( typesymbol <> NULL ) then
				exit function
			end if
			'' now w/o suffixes
			s = symbLookupVar( id, INVALID, ofs, elm, typesymbol )
			if( s <> NULL ) then
				'' same type?
				if( typ <> symbGetType( s ) ) then
					exit function
				end if
			end if
	    end if
	end if

	hVarLookup = TRUE

end function

'':::::
function hVarAddUndecl( id as string, byval typ as integer ) as FBSYMBOL ptr
	dim s as FBSYMBOL ptr
	dim dTB(0) as FBARRAYDIM, alloctype as integer

	hVarAddUndecl = NULL

	'if( symbIsProc( id ) ) then
	'	exit function
	'end if

	if( env.isprocstatic ) then
		alloctype = FB.ALLOCTYPE.STATIC
	else
		alloctype = 0
	end if

    s = symbAddVar( id, typ, NULL, 0, dTB(), alloctype )
    if( s = NULL ) then
		exit function
	end if

	hVarAddUndecl = s

end function

'':::::
function hVarDeref( byval cnt as integer, varexpr as integer, _
					byval symb as FBSYMBOL ptr, byval elm as FBTYPELEMENT ptr, _
					byval typ as integer ) as integer
	dim dtype as integer

	hVarDeref = FALSE

	if( (varexpr = INVALID) or (cnt <= 0) ) then
		exit function
	end if

	dtype = hStyp2Dtype( typ )

	do while( cnt > 1 )
		if( dtype < IR.DATATYPE.POINTER ) then
			exit function
		end if
		dtype = dtype - IR.DATATYPE.POINTER

		varexpr = astNewPTR( 0, dtype, varexpr )
		cnt = cnt - 1
	loop

	if( dtype < IR.DATATYPE.POINTER ) then
		exit function
	end if
    dtype = dtype - FB.SYMBTYPE.POINTER

    varexpr = astNewPTREx( symb, elm, 0, dtype, varexpr )

    hVarDeref = TRUE

end function

'':::::
''Variable        =   DREF* ID ArrayIdx? ((TypeField|DerefField) FieldIdx?)*
''				  |   DREF* ID{Function} ProcParamList .
''
function cVariable( varexpr as integer, byval checkarray as integer = TRUE, _
					byval isassign as integer = FALSE )
	dim typ as integer, ofs as integer, idxexpr as integer, funcexpr as integer
	dim s as FBSYMBOL ptr, res as integer
	dim id as string, dtype as integer, derefcnt as integer
	dim isbyref as integer, isfunctionptr as integer, isbydesc as integer
	dim elm as FBTYPELEMENT ptr, typesymbol as FBSYMBOL ptr

	cVariable = FALSE

	'' DREF*
    derefcnt = 0
	do while( lexCurrentToken = FB.TK.DEREFCHAR )
		lexSkipToken
		derefcnt = derefcnt + 1
	loop

	'' ID
	if( lexCurrentToken <> FB.TK.ID ) then
		exit function
	end if

	id 	= lexTokenText
	typ	= lexTokenType

	'' check for if dereferencing a function call
	if( derefcnt > 0 ) then
		s = symbLookupProc( id )
		if( s <> NULL ) then
			lexSkipToken
			if( not cFunctionCall( s, varexpr, INVALID ) ) then
				exit function
			end if

			typ = symbGetType( s )
			elm = NULL
			goto varderef
       	end if
	end if

    isfunctionptr 	= FALSE

	''
	'' lookup
	if( not hVarLookup( id, s, typ, ofs, elm, typesymbol ) ) then
	   	if( typesymbol = NULL ) then
	   		hReportError FB.ERRMSG.DUPDEFINITION
       	else
       		hReportError FB.ERRMSG.ELEMENTNOTDEFINED
       	end if

       	exit function
	end if

	'' add undeclared variable
	if( s = NULL ) then
		if( not env.optexplicit ) then
			s = hVarAddUndecl( id, typ )
			if( s = NULL ) then
				hReportError FB.ERRMSG.DUPDEFINITION
				exit function
			end if
			typesymbol = symbGetSubtype( s )
		else
			hReportError FB.ERRMSG.VARIABLENOTDECLARED
			exit function
		end if
	end if

    ''
	lexSkipToken

    ''
    if( typ = INVALID ) then typ = symbGetType( s )

    isbyref = (symbGetAllocType( s ) and FB.ALLOCTYPE.ARGUMENTBYREF) > 0

    ''
    '' check for '('')', it's not an array, just passing by desc
    idxexpr  = INVALID
    isbydesc = FALSE
    if( lexCurrentToken = FB.TK.IDXOPENCHAR ) then
    	if( lexLookahead(1) <> FB.TK.IDXCLOSECHAR ) then

    		'' ArrayIdx?
    		if( (elm = NULL) and (symbIsArray( s )) ) then
    			'' '('
    			lexSkipToken

    			res = cArrayIdx( s, idxexpr )

				'' ')'
    			if( not hMatch( FB.TK.IDXCLOSECHAR ) ) then
    				hReportError FB.ERRMSG.EXPECTEDRPRNT
    				exit function
    			end if

    		else
   				'' check if calling functions through pointers
   				if( typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
	   				isfunctionptr = TRUE
    			end if

    		end if

    	else
    		isbydesc = TRUE
    	end if
    end if

   	''
   	if( not isfunctionptr ) then

   		'' TypeField?
   		cTypeField( elm, typesymbol, typ, idxexpr, FALSE, checkarray )

   		'' check for calling functions through pointers
   		if( lexCurrentToken = CHAR_LPRNT ) then
   			if( typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
	   			isfunctionptr = TRUE
   			end if
   		end if
   	end if

   	''
	dtype = hStyp2Dtype( typ )

	'' AST will handle descriptor pointers
	if( not isbyref ) then
		varexpr = astNewVAREx( s, elm, ofs, dtype )
	else
		varexpr = astNewVAREx( s, elm, 0, dtype )
	end if

	if( idxexpr <> INVALID ) then
		varexpr = astNewIDX( varexpr, idxexpr, dtype )
	else
		'' array and no index?
		if( not isbydesc ) then
  				if( symbIsArray( s ) ) then
  					if( checkarray ) then
   					hReportError FB.ERRMSG.EXPECTEDLPRNT
   					exit function
   				end if
   			end if
    	end if
	end if

	'' check arguments passed by reference (implicity pointer's)
	if( isbyref ) then
   		dtype = astGetDataType( varexpr )
   		varexpr = astNewPTREx( s, elm, ofs, dtype, varexpr )
	end if

	''
	if( not isfunctionptr ) then
		'' DerefFields?
		cDerefFields( s, elm, typesymbol, typ, varexpr, checkarray )

   		'' check for calling functions through pointers
   		if( lexCurrentToken = CHAR_LPRNT ) then
   			if( typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
	  			isfunctionptr = TRUE
   			end if
   		end if
	end if

	'' call function, pushing params on stack
	if( isfunctionptr ) then
		''
		if( elm = NULL ) then
			s = symbGetSubtype( s )
		else
			s = symbGetUDTElmSubtype( elm )
		end if

		''
		if( not isassign ) then
			if( not cFunctionCall( s, funcexpr, varexpr ) ) then
				exit function
			end if
			varexpr = funcexpr

		else
			if( not cProcCall( s, varexpr ) ) then
				exit function
			end if
		    varexpr = INVALID					'' cAssignment will catch this
		end if

		typ = symbGetType( s )
		elm = NULL
	end if

varderef:
	'' dereference
	if( derefcnt > 0 ) then
		if( not hVarDeref( derefcnt, varexpr, s, elm, typ ) ) then
			hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
			exit function
		end if
	end if

	cVariable = TRUE

end function
