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
function cFieldArray( byval elm as FBSYMBOL ptr, byval typ as integer, idxexpr as integer ) as integer
    dim d as FBVARDIM ptr, maxdims as integer, dims as integer
    dim expr as integer, dimexpr as integer, constexpr as integer
    dim diff as integer, lgt as integer

    cFieldArray = FALSE

    ''
    maxdims = symbGetArrayDimensions( elm )
    dims = 0
    d = symbGetArrayFirstDim( elm )
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
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB.POINTERSIZE) ) then
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

        '' next
        d = d->r

    	constexpr = astNewCONST( (d->upper - d->lower)+1, IR.DATATYPE.INTEGER )
    	expr = astNewBOP( IR.OP.MUL, expr, constexpr )
	loop


    ''
    if( dims < maxdims ) then
		hReportError FB.ERRMSG.WRONGDIMENSIONS
		exit function
    end if


	'' times length
	lgt = symbGetLen( elm )
	constexpr = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	expr = astNewBOP( IR.OP.MUL, expr, constexpr )

    '' plus difference
    diff = symbGetArrayDiff( elm )
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
function cTypeField( elm as FBSYMBOL ptr, typ as integer, subtype as FBSYMBOL ptr, idxexpr as integer, _
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

    		ofs = symbGetUDTElmOffset( elm, typ, subtype, fields )
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
			if( symbGetArrayDimensions( elm ) = 0 ) then
				exit do
			end if

    		lexSkipToken
    	else
			'' array and no index?
			if( symbGetArrayDimensions( elm ) <> 0 ) then
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
''DerefFields	=   ((FIELDDEREF DREF* | '[' Expression ']') TypeField)* .
''
function cDerefFields( byval sym as FBSYMBOL ptr, elm as FBSYMBOL ptr, _
					   typ as integer, subtype as FBSYMBOL ptr, _
					   varexpr as integer, _
					   byval isderef as integer, byval checkarray as integer ) as integer

	dim cnt as integer, lgt as integer
	dim expr as integer, idxexpr as integer
	dim isfieldderef as integer

	cDerefFields = FALSE

	do

		idxexpr = INVALID
		cnt		= 0

        select case lexCurrentToken
        '' (FIELDDEREF DREF* TypeField)*
        case FB.TK.FIELDDEREF
        	lexSkipToken
        	isfieldderef = TRUE

        	'' DREF*
			do while( lexCurrentToken = FB.TK.DEREFCHAR )
				lexSkipToken
				cnt = cnt + 1
			loop

		'' '['
		case CHAR_LBRACKET
			lexSkipToken
			isfieldderef = FALSE

			'' Expression
			if( not cExpression( idxexpr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if

			'' if index isn't an integer, convert
			astUpdNodeResult idxexpr
			if( (astGetDataClass( idxexpr ) <> IR.DATACLASS.INTEGER) or _
				(astGetDataSize( idxexpr ) <> FB.POINTERSIZE) ) then
				idxexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, idxexpr )
			end if

			'' ']'
			if( not hMatch( CHAR_RBRACKET ) ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				cDerefFields = FALSE
				exit function
			end if

			'' times length
			lgt = symbCalcLen( typ - FB.SYMBTYPE.POINTER, subtype )

			idxexpr = astNewBOP( IR.OP.MUL, idxexpr, astNewCONST( lgt, IR.DATATYPE.INTEGER ) )

		case else
			if( not isderef ) then
				exit do
			end if

			isfieldderef = FALSE

		end select

		if( typ < FB.SYMBTYPE.POINTER ) then
			hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
			cDerefFields = FALSE
			exit function
		end if
		typ = typ - FB.SYMBTYPE.POINTER

		'' TypeField
		expr = INVALID
		if( not cTypeField( elm, typ, subtype, expr, isfieldderef, checkarray ) ) then
			if( idxexpr = INVALID ) then
				if( not isderef ) then
					hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
				end if
				exit function
			end if
		end if

		'' this should be optimized by AST, when expr is a constant and varexpr is a scalar var
		if( expr <> INVALID ) then
			varexpr = astNewBOP( IR.OP.ADD, varexpr, expr )
		end if

		''
		if( idxexpr <> INVALID ) then
			varexpr = astNewBOP( IR.OP.ADD, varexpr, idxexpr )
		end if

		''
		varexpr = astNewPTR( sym, elm, 0, varexpr, typ, subtype )

		''
		do while( cnt > 0 )
			if( typ < FB.SYMBTYPE.POINTER ) then
				hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
				cDerefFields = FALSE
				exit function
			end if
			typ = typ - FB.SYMBTYPE.POINTER

			varexpr = astNewPTR( sym, elm, 0, varexpr, typ, subtype )
			cnt = cnt - 1
		loop

		isderef = FALSE
		cDerefFields = TRUE
	loop

end function

'':::::
''DynArrayIdx     =   '(' Expression (DECL_SEPARATOR Expression)* ')' .
''
function cDynArrayIdx( byval sym as FBSYMBOL ptr, idxexpr as integer ) as integer
    dim i as integer, dims as integer, maxdims as integer, d as FBSYMBOL ptr
    dim lgt as integer
    dim expr as integer, dimexpr as integer, constexpr as integer, varexpr as integer

    cDynArrayIdx = FALSE

    d = symbGetArrayDescriptor( sym )
    dims = 0

    if( (symbGetAllocType( sym ) and FB.ALLOCTYPE.COMMON) = 0 ) then
    	maxdims = symbGetArrayDimensions( sym )
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
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB.POINTERSIZE) ) then
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

    	varexpr = astNewVAR( d, NULL, FB.ARRAYDESCSIZE + i*(FB.INTEGERSIZE*2), IR.DATATYPE.INTEGER )
    	expr = astNewBOP( IR.OP.MUL, expr, varexpr )
	loop

	'' times length
	lgt = symbGetLen( sym )
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
    varexpr = astNewVAR( d, NULL, FB.ARRAYDESC.DATAOFFS, IR.DATATYPE.INTEGER )
    expr = astNewBOP( IR.OP.ADD, expr, varexpr )

    idxexpr = expr

    ''
    cDynArrayIdx = TRUE

end function

'':::::
''ArgArrayIdx     =   '(' Expression (DECL_SEPARATOR Expression)* ')' .
''
function cArgArrayIdx( byval sym as FBSYMBOL ptr, idxexpr as integer ) as integer
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
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB.POINTERSIZE) ) then
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
    	t = astNewVAR( sym, NULL, 0, IR.DATATYPE.INTEGER )
    	varexpr = astNewPTR( sym, NULL, FB.ARRAYDESCSIZE + i*(FB.INTEGERSIZE*2), t, IR.DATATYPE.INTEGER, NULL )
    	expr = astNewBOP( IR.OP.MUL, expr, varexpr )
	loop

	'' times length
	lgt = symbGetLen( sym )
	constexpr = astNewCONST( lgt, IR.DATATYPE.INTEGER )
	expr = astNewBOP( IR.OP.MUL, expr, constexpr )

   	'' plus dsc->data (= ptr + diff)
    t = astNewVAR( sym, NULL, 0, IR.DATATYPE.INTEGER )
    varexpr = astNewPTR( sym, NULL, FB.ARRAYDESC.DATAOFFS, t, IR.DATATYPE.INTEGER, NULL )
    expr = astNewBOP( IR.OP.ADD, expr, varexpr )

    idxexpr = expr

	''
	cArgArrayIdx = TRUE

end function

'':::::
''ArrayIdx        =   '(' Expression (DECL_SEPARATOR Expression)* ')' .
''
function cArrayIdx( byval s as FBSYMBOL ptr, idxexpr as integer ) as integer
    dim d as FBVARDIM ptr, dims as integer, maxdims as integer
    dim dtype as integer, lgt as integer
    dim expr as integer, dimexpr as integer, constexpr as integer, varexpr as integer

    cArrayIdx = FALSE

    ''  argument passed by descriptor?
    if( (symbGetAllocType( s ) and FB.ALLOCTYPE.ARGUMENTBYDESC) > 0 ) then
    	cArrayIdx = cArgArrayIdx( s, idxexpr )
    	exit function

    '' dynamic array? (will handle common's too)
    elseif( symbGetIsDynamic( s ) ) then
    	cArrayIdx = cDynArrayIdx( s, idxexpr )
    	exit function

    end if

    ''
    maxdims = symbGetArrayDimensions( s )
    dims = 0

    ''
    d = symbGetArrayFirstDim( s )
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
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB.POINTERSIZE) ) then
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

        '' next
        d = d->r

    	constexpr = astNewCONST( (d->upper - d->lower) + 1, IR.DATATYPE.INTEGER )
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
''Variable        =   ID ArrayIdx? ((TypeField|DerefField) FieldIdx?)*
''				  |   ID{Function} ProcParamList .
''
function cVariable( varexpr as integer, sym as FBSYMBOL ptr, elm as FBSYMBOL ptr, _
					byval checkarray as integer = TRUE )
	dim typ as integer, ofs as integer, idxexpr as integer, funcexpr as integer
	dim subtype as FBSYMBOL ptr
	dim id as string, dtype as integer
	dim isbyref as integer, isfunctionptr as integer, isbydesc as integer, isimport as integer

	cVariable = FALSE

	'' ID
	if( lexCurrentToken <> FB.TK.ID ) then
		exit function
	end if

	id 	= lexTokenText
	typ	= lexTokenType

    isfunctionptr 	= FALSE

	''
	'' lookup
	ofs 		= 0
	elm			= NULL
	subtype 	= NULL

	sym = symbLookupVar( id, typ, ofs, elm, subtype )

	'' add undeclared variable
	if( sym = NULL ) then
		if( hGetLastError <> FB.ERRMSG.OK ) then
			exit function
		end if

		if( not env.optexplicit ) then

			if( typ = INVALID ) then
				typ = hGetDefType( id )
			end if

			sym = hVarAddUndecl( id, typ )
			if( sym = NULL ) then
				hReportError FB.ERRMSG.DUPDEFINITION
				exit function
			end if
			subtype = symbGetSubtype( sym )
		else
			hReportError FB.ERRMSG.VARIABLENOTDECLARED
			exit function
		end if
	end if

    ''
	lexSkipToken

	if( typ = INVALID ) then
		typ = symbGetType( sym )
	end if

    ''
    isbyref = (symbGetAllocType( sym ) and FB.ALLOCTYPE.ARGUMENTBYREF) > 0

#ifdef TARGET_WIN32
	isimport = (symbGetAllocType( sym ) and FB.ALLOCTYPE.IMPORT) > 0
#else
	isimport = FALSE
#endif

    ''
    '' check for '('')', it's not an array, just passing by desc
    idxexpr  = INVALID
    isbydesc = FALSE
    if( lexCurrentToken = FB.TK.IDXOPENCHAR ) then
    	if( lexLookahead(1) <> FB.TK.IDXCLOSECHAR ) then

    		'' ArrayIdx?
    		if( (elm = NULL) and (symbIsArray( sym )) ) then
    			'' '('
    			lexSkipToken

    			cArrayIdx( sym, idxexpr )

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
   		cTypeField( elm, typ, subtype, idxexpr, FALSE, checkarray )

   		'' check for calling functions through pointers
   		if( lexCurrentToken = CHAR_LPRNT ) then
   			if( typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
	   			isfunctionptr = TRUE
   			end if
   		end if
   	end if

   	''
	dtype = typ

	'' AST will handle descriptor pointers
	if( not isbyref and not isimport ) then
		varexpr = astNewVAR( sym, elm, ofs, dtype, subtype )
	else
		varexpr = astNewVAR( sym, elm, 0, dtype, subtype )
	end if

	if( idxexpr <> INVALID ) then
		if( isbyref or isimport ) then
			varexpr = astNewBOP( IR.OP.ADD, varexpr, idxexpr )
		else
			varexpr = astNewIDX( varexpr, idxexpr, dtype, subtype )
		end if
	else
		'' array and no index?
		if( not isbydesc ) then
  			if( symbIsArray( sym ) ) then
  				if( checkarray ) then
   					hReportError FB.ERRMSG.EXPECTEDLPRNT
   					exit function
   				end if
   			end if
    	end if
	end if

	'' check arguments passed by reference (implicity pointer's)
	if( isbyref or isimport ) then
   		dtype = astGetDataType( varexpr )
   		varexpr = astNewPTR( sym, elm, ofs, varexpr, dtype, subtype )
	end if

	''
	if( not isfunctionptr ) then
		'' DerefFields?
		cDerefFields( sym, elm, typ, subtype, varexpr, FALSE, checkarray )

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
		if( elm <> NULL ) then
			sym = elm
		end if

		sym = symbGetSubtype( sym )
		elm = NULL

		''
		if( symbGetType( sym ) <> FB.SYMBTYPE.VOID ) then
			if( not cFunctionCall( sym, funcexpr, varexpr ) ) then
				exit function
			end if
			varexpr = funcexpr

		else
			if( not cProcCall( sym, varexpr ) ) then
				exit function
			end if
		    varexpr = INVALID
		end if
	end if

	cVariable = TRUE

end function

'':::::
''cVarOrDeref		= 	Deref | AddrOf | Variable
''
function cVarOrDeref( varexpr as integer, _
					  byval checkarray as integer, byval checkaddrof as integer )
	dim sym as FBSYMBOL ptr, elm as FBSYMBOL ptr
	dim res as integer

	res = cDerefExpression( varexpr )
	if( not res ) then
		if( checkaddrof ) then
			res = cAddrOfExpression( varexpr, sym, elm )
		end if
		if( not res ) then
			res = cVariable( varexpr, sym, elm, checkarray )
		end if
	end if

	cVarOrDeref = res

end function
