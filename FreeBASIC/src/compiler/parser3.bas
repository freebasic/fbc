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
''				   complex that a whole module was needed..
''
'' chng: sep/2004 written [v1ctor]
''		 oct/2004 arrays on fields [v1c]

option explicit
option escape

defint a-z
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\parser.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\emit.bi'


'':::::
''FieldArray    =   '(' Expression (',' Expression)* ')' .
''
function cFieldArray( byval elm as FBSYMBOL ptr, _
					  byval typ as integer, _
					  idxexpr as ASTNODE ptr ) as integer

    dim as FBVARDIM ptr d
    dim as integer maxdims, dims
    dim as ASTNODE ptr expr, dimexpr, constexpr
    dim as integer diff, lgt

    function = FALSE

    ''
    maxdims = symbGetArrayDimensions( elm )
    dims = 0
    d = symbGetArrayFirstDim( elm )
    expr = NULL
    do
    	dims += 1
    	if( dims > maxdims ) then
			hReportError FB.ERRMSG.WRONGDIMENSIONS
			exit function
    	end if

    	'' Expression
		if( not cExpression( dimexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB.POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, dimexpr )
			if( dimexpr = NULL ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				exit function
			end if
		end if

    	if( expr = NULL ) then
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

    	constexpr = astNewCONSTi( (d->upper - d->lower)+1, IR.DATATYPE.INTEGER )
    	expr = astNewBOP( IR.OP.MUL, expr, constexpr )
	loop


    ''
    if( dims < maxdims ) then
		hReportError FB.ERRMSG.WRONGDIMENSIONS
		exit function
    end if


	'' times length
	lgt = symbGetLen( elm )
	constexpr = astNewCONSTi( lgt, IR.DATATYPE.INTEGER )
	expr = astNewBOP( IR.OP.MUL, expr, constexpr )

    '' plus difference
    diff = symbGetArrayDiff( elm )
    if( diff <> 0 ) then
    	constexpr = astNewCONSTi( diff, IR.DATATYPE.INTEGER )
    	expr = astNewBOP( IR.OP.ADD, expr, constexpr )
    end if

    '' plus initial expression
    if( idxexpr = NULL ) then
    	idxexpr = expr
    else
    	idxexpr = astNewBOP( IR.OP.ADD, idxexpr, expr )
    end if

    ''
    function = TRUE

end function

'':::::
''TypeField       =   ArrayIdx? ('.' ID ArrayIdx?)*
''
function cTypeField( elm as FBSYMBOL ptr, _
					 typ as integer, _
					 subtype as FBSYMBOL ptr, _
					 idxexpr as ASTNODE ptr, _
					 byval isderef as integer, _
					 byval checkarray as integer ) as integer

    dim as zstring ptr fields
    dim as ASTNODE ptr constexpr
    dim as integer ofs

	function = FALSE

	do
		if( lexCurrentToken( ) <> CHAR_LPRNT ) then

			if( typ <> FB.SYMBTYPE.USERDEF ) then
				exit function
			end if

			fields = lexTokenText( )
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

    		ofs = symbGetUDTElmOffset( elm, typ, subtype, *fields )
    		if( ofs < 0 ) then
    			hReportError( FB.ERRMSG.ELEMENTNOTDEFINED )
    			return FALSE
    		else
				lexSkipToken( )
    		end if

    		if( ofs <> 0 ) then
    			constexpr = astNewCONSTi( ofs, IR.DATATYPE.INTEGER )
    			if( idxexpr = NULL ) then
    				idxexpr = constexpr
    			else
	    			idxexpr = astNewBOP( IR.OP.ADD, idxexpr, constexpr )
    			end if
    		end if

		end if

    	function = TRUE

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
    				hReportError FB.ERRMSG.EXPECTEDINDEX
   					return FALSE
    			end if
			end if

    		exit do
    	end if

    	if( not cFieldArray( elm, typ, idxexpr ) ) then
    		exit function
    	end if

    	if( not hMatch( CHAR_RPRNT ) ) then
    		hReportError FB.ERRMSG.EXPECTEDRPRNT
   			return FALSE
    	end if

    loop

end function

'':::::
''DerefFields	=   ((FIELDDEREF DREF* | '[' Expression ']') TypeField)* .
''
function cDerefFields( byval sym as FBSYMBOL ptr, _
					   elm as FBSYMBOL ptr, _
					   dtype as integer, _
					   subtype as FBSYMBOL ptr, _
					   varexpr as ASTNODE ptr, _
					   byval isderef as integer, _
					   byval checkarray as integer ) as integer

	dim as integer cnt, lgt
	dim as ASTNODE ptr expr, idxexpr
	dim as integer isfieldderef

	function = FALSE

	do

		idxexpr = NULL
		isfieldderef = FALSE
		cnt	= 0

        select case lexCurrentToken
        '' (FIELDDEREF DREF* TypeField)*
        case FB.TK.FIELDDEREF
        	lexSkipToken
        	isfieldderef = TRUE

        	'' DREF*
			do while( lexCurrentToken = FB.TK.DEREFCHAR )
				lexSkipToken
				cnt += 1
			loop

		'' '['
		case CHAR_LBRACKET
			lexSkipToken

			'' Expression
			if( not cExpression( idxexpr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if

			'' if index isn't an integer, convert
			if( (astGetDataClass( idxexpr ) <> IR.DATACLASS.INTEGER) or _
				(astGetDataSize( idxexpr ) <> FB.POINTERSIZE) ) then
				idxexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, idxexpr )
				if( idxexpr = NULL ) then
					hReportError FB.ERRMSG.INVALIDDATATYPES
					exit function
				end if
			end if

			'' ']'
			if( not hMatch( CHAR_RBRACKET ) ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				return FALSE
			end if

			'' string, fixstr, zstring?
			if( dtype < FB.SYMBTYPE.POINTER ) then

				select case dtype
				case FB.SYMBTYPE.STRING, FB.SYMBTYPE.FIXSTR, FB.SYMBTYPE.CHAR

					if( dtype = FB.SYMBTYPE.STRING ) then
						'' deref
						varexpr = astNewADDR( IR.OP.DEREF, varexpr, sym, elm )
					else
						'' address of
						varexpr = astNewADDR( IR.OP.ADDROF, varexpr, sym, elm )
					end if

					'' add index
					varexpr = astNewBOP( IR.OP.ADD, varexpr, idxexpr )
					'' make a pointer
					varexpr = astNewPTR( NULL, NULL, 0, varexpr, IR.DATATYPE.UBYTE, NULL )

					'' reset type
					dtype = IR.DATATYPE.UBYTE
					subtype = NULL
					elm = NULL

					return TRUE

				case else
					hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
					return FALSE
				end select

			end if

			'' times length
			lgt = symbCalcLen( dtype - FB.SYMBTYPE.POINTER, subtype )

			if( lgt = 0 ) then
				hReportError FB.ERRMSG.INCOMPLETETYPE, TRUE
				exit function
			end if

			idxexpr = astNewBOP( IR.OP.MUL, idxexpr, astNewCONSTi( lgt, IR.DATATYPE.INTEGER ) )

		case else

			if( not isderef ) then
				exit do
			end if

		end select

		if( dtype < FB.SYMBTYPE.POINTER ) then
			hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
			return FALSE
		end if

		dtype -= FB.SYMBTYPE.POINTER

		'' incomplete type?
		if( (dtype = FB.SYMBTYPE.VOID) or (dtype = FB.SYMBTYPE.FWDREF) ) then
			hReportError FB.ERRMSG.INCOMPLETETYPE, TRUE
			return FALSE
		end if

		'' TypeField
		expr = NULL
		if( not cTypeField( elm, dtype, subtype, expr, isfieldderef, checkarray ) ) then
			if( idxexpr = NULL ) then
				if( not isderef ) then
					hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
					return FALSE
				end if

				dtype += FB.SYMBTYPE.POINTER
				exit function
			end if
		end if

		'' this should be optimized by AST, when expr is a constant and varexpr is a scalar var
		if( expr <> NULL ) then
			varexpr = astNewBOP( IR.OP.ADD, varexpr, expr )
		end if

		''
		if( idxexpr <> NULL ) then
			varexpr = astNewBOP( IR.OP.ADD, varexpr, idxexpr )
		end if

		''
		varexpr = astNewPTR( sym, elm, 0, varexpr, dtype, subtype )

		''
		do while( cnt > 0 )
			if( dtype < FB.SYMBTYPE.POINTER ) then
				hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
				return FALSE
			end if

			dtype -= FB.SYMBTYPE.POINTER

			'' incomplete type?
			if( (dtype = FB.SYMBTYPE.VOID) or (dtype = FB.SYMBTYPE.FWDREF) ) then
				hReportError FB.ERRMSG.INCOMPLETETYPE, TRUE
				return FALSE
			end if

			varexpr = astNewPTR( sym, elm, 0, varexpr, dtype, subtype )

			cnt -= 1
		loop

		isderef = FALSE
		function = TRUE
	loop

end function

'':::::
''FuncPtrOrDeref	=   FuncPtr '(' Args? ')'
''					|   DerefFields .
''
function cFuncPtrOrDerefFields( sym as FBSYMBOL ptr, _
					      		elm as FBSYMBOL ptr, _
					      		byval typ as integer, _
					      		byval subtype as FBSYMBOL ptr, _
					      		varexpr as ASTNODE ptr, _
					      		byval isfuncptr as integer, _
					      		byval checkarray as integer ) as integer

	dim as ASTNODE ptr funcexpr

	function = FALSE

	''
	if( not isfuncptr ) then
		'' DerefFields?
		cDerefFields( sym, elm, typ, subtype, varexpr, FALSE, checkarray )

		if( hGetLastError <> FB.ERRMSG.OK ) then
			exit function
		end if

   		'' check for calling functions through pointers
   		if( lexCurrentToken = CHAR_LPRNT ) then
   			if( typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if
	end if

	'' function pointer dref? call it
	if( isfuncptr ) then

		if( elm <> NULL ) then
			sym = elm
		end if

		sym 	= sym->subtype
		elm 	= NULL
		typ 	= sym->typ
		subtype = sym->subtype

		''
		if( symbGetType( sym ) <> FB.SYMBTYPE.VOID ) then
			if( not cFunctionCall( sym, elm, funcexpr, varexpr ) ) then
				exit function
			end if
			varexpr = funcexpr

		else
			if( not cProcCall( sym, funcexpr, varexpr ) ) then
				exit function
			end if
		    varexpr = funcexpr
		end if

	end if

	function = TRUE

end function

'':::::
''DynArrayIdx     =   '(' Expression (',' Expression)* ')' .
''
function cDynArrayIdx( byval sym as FBSYMBOL ptr, _
					   idxexpr as ASTNODE ptr ) as integer

    dim as FBSYMBOL ptr d
    dim as integer lgt, i, dims, maxdims
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
				hReportError FB.ERRMSG.WRONGDIMENSIONS
				exit function
    		end if
    	end if

    	'' Expression
		if( not cExpression( dimexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB.POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, dimexpr )
			if( dimexpr = NULL ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				exit function
			end if
		end if

    	if( expr = NULL ) then
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

    	i += 1

    	varexpr = astNewVAR( d, NULL, FB.ARRAYDESCSIZE + i*(FB.INTEGERSIZE*2), IR.DATATYPE.INTEGER )
    	expr = astNewBOP( IR.OP.MUL, expr, varexpr )
	loop

	'' times length
	lgt = symbGetLen( sym )
	constexpr = astNewCONSTi( lgt, IR.DATATYPE.INTEGER )
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
    function = TRUE

end function

'':::::
''ArgArrayIdx     =   '(' Expression (',' Expression)* ')' .
''
function cArgArrayIdx( byval sym as FBSYMBOL ptr, _
					   idxexpr as ASTNODE ptr ) as integer

    dim as integer i, lgt
    dim as ASTNODE ptr expr, dimexpr, constexpr, varexpr, t

    function = FALSE

    ''
    i = 0
    expr = NULL
    do
    	'' Expression
		if( not cExpression( dimexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB.POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, dimexpr )
			if( dimexpr = NULL ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				exit function
			end if
		end if

    	if( expr = NULL ) then
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

    	i += 1

    	'' it's a descriptor pointer, dereference (only with DAG this will be optimized)
    	t = astNewVAR( sym, NULL, 0, IR.DATATYPE.INTEGER )
    	varexpr = astNewPTR( sym, NULL, FB.ARRAYDESCSIZE + i*(FB.INTEGERSIZE*2), t, IR.DATATYPE.INTEGER, NULL )
    	expr = astNewBOP( IR.OP.MUL, expr, varexpr )
	loop

	'' times length
	lgt = symbGetLen( sym )
	constexpr = astNewCONSTi( lgt, IR.DATATYPE.INTEGER )
	expr = astNewBOP( IR.OP.MUL, expr, constexpr )

   	'' plus dsc->data (= ptr + diff)
    t = astNewVAR( sym, NULL, 0, IR.DATATYPE.INTEGER )
    varexpr = astNewPTR( sym, NULL, FB.ARRAYDESC.DATAOFFS, t, IR.DATATYPE.INTEGER, NULL )
    expr = astNewBOP( IR.OP.ADD, expr, varexpr )

    idxexpr = expr

	''
	function = TRUE

end function

'':::::
''ArrayIdx        =   '(' Expression (',' Expression)* ')' .
''
function cArrayIdx( byval s as FBSYMBOL ptr, _
					idxexpr as ASTNODE ptr ) as integer

    dim as FBVARDIM ptr d
    dim as integer dtype, lgt, dims, maxdims
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
			hReportError FB.ERRMSG.WRONGDIMENSIONS
			exit function
    	end if

    	'' Expression
		if( not cExpression( dimexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( dimexpr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( dimexpr ) <> FB.POINTERSIZE) ) then
			dimexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, dimexpr )
			if( dimexpr = NULL ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				exit function
			end if
		end if

    	if( expr = NULL ) then
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
    	if( d = NULL ) then
			hReportError FB.ERRMSG.WRONGDIMENSIONS
			exit function
    	end if

    	constexpr = astNewCONSTi( (d->upper - d->lower) + 1, IR.DATATYPE.INTEGER )
    	expr = astNewBOP( IR.OP.MUL, expr, constexpr )
	loop

    ''
    if( dims < maxdims ) then
		hReportError FB.ERRMSG.WRONGDIMENSIONS
		exit function
    end if

	'' times length (this will be optimized if len < 10 and there's no arrays on following fields)
	lgt = symbGetLen( s )
	constexpr = astNewCONSTi( lgt, IR.DATATYPE.INTEGER )
	expr = astNewBOP( IR.OP.MUL, expr, constexpr )

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
		alloctype = FB.ALLOCTYPE.STATIC
	else
		alloctype = 0
	end if

    s = symbAddVar( id, typ, NULL, 0, 0, dTB(), alloctype )
    if( s = NULL ) then
		exit function
	end if

	function = s

end function

'':::::
''Variable        =   ID ArrayIdx? ((TypeField|FuncPtrOrDerefFields) FieldIdx?)* .
''
function cVariable( varexpr as ASTNODE ptr, _
					sym as FBSYMBOL ptr, _
					elm as FBSYMBOL ptr, _
					byval checkarray as integer = TRUE ) as integer

	dim as zstring ptr id
	dim as integer typ, deftyp, ofs, dtype
	dim as ASTNODE ptr idxexpr
	dim as FBSYMBOL ptr subtype
	dim as integer isbyref, isfuncptr, isbydesc, isimport, isarray

	function = FALSE

	'' ID
	if( lexCurrentToken( ) <> FB.TK.ID ) then
		exit function
	end if

    isfuncptr 	= FALSE

	''
	'' lookup
	ofs 		= 0
	elm			= NULL
	subtype 	= NULL
	typ			= lexTokenType( )
	id			= lexTokenText( )
    if( typ = INVALID ) then
    	deftyp = hGetDefType( *id )
    else
    	deftyp = INVALID
    end if

	sym = symbFindBySuffix( lexTokenSymbol( ), typ, deftyp )
	if( sym = NULL ) then
		'' QB quirk: fixed-len strings referenced using '$' as suffix..
		if( typ = FB.SYMBTYPE.STRING ) then
			sym = symbFindBySuffix( lexTokenSymbol( ), FB.SYMBTYPE.FIXSTR, deftyp )
			'' check zstrings too..
			if( sym = NULL ) then
				sym = symbFindBySuffix( lexTokenSymbol( ), FB.SYMBTYPE.CHAR, deftyp )
			end if

		elseif( deftyp = FB.SYMBTYPE.STRING ) then
			sym = symbFindBySuffix( lexTokenSymbol( ), INVALID, FB.SYMBTYPE.FIXSTR )
			'' check zstrings too..
			if( sym = NULL ) then
				sym = symbFindBySuffix( lexTokenSymbol( ), INVALID, FB.SYMBTYPE.CHAR )
			end if
		end if
	end if

	if( sym <> NULL ) then
		typ 	= sym->typ
		subtype = sym->subtype

	else

		'' it can be also an UDT, as dots can be part of symbol names..
		sym = symbLookupUDTVar( *id, lexTokenDotPos, typ, ofs, elm, subtype )
		if( sym = NULL ) then
			'' add undeclared variable
			if( hGetLastError( ) <> FB.ERRMSG.OK ) then
				exit function
			end if

			'' add undeclared var
			if( not env.optexplicit ) then
				if( typ = INVALID ) then
					typ = hGetDefType( *id )
				end if

				sym = hVarAddUndecl( *id, typ )
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
	end if

    ''
	lexSkipToken( )

	if( typ = INVALID ) then
		typ = symbGetType( sym )
	end if

    ''
    isbyref = symbIsArgByRef( sym )

#ifdef TARGET_WIN32
	isimport = symbIsImport( sym )
#else
	isimport = FALSE
#endif

    ''
    idxexpr  = NULL
    isbydesc = FALSE
    isarray  = symbIsArray( sym )

    '' check for '('')', it's not an array, just passing by desc
    if( lexCurrentToken = CHAR_LPRNT ) then
    	if( lexLookahead(1) <> CHAR_RPRNT ) then

    		'' ArrayIdx?
    		if( (elm = NULL) and isarray ) then
    			'' '('
    			lexSkipToken

    			cArrayIdx( sym, idxexpr )

				'' ')'
    			if( not hMatch( CHAR_RPRNT ) ) then
    				hReportError FB.ERRMSG.EXPECTEDRPRNT
    				exit function
    			end if

    		else
   				'' check if calling functions through pointers
   				if( typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
	   				isfuncptr = TRUE
    			end if

    			'' using (...) w/ scalars?
    			if( elm = NULL ) then
    				if( not isarray and not isfuncptr ) then
    					hReportError FB.ERRMSG.ARRAYNOTALLOCATED, TRUE
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

		if( hGetLastError <> FB.ERRMSG.OK ) then
			exit function
		end if

   		'' check for calling functions through pointers
   		if( lexCurrentToken = CHAR_LPRNT ) then
   			if( typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
	   			isfuncptr = TRUE
   			end if
   		end if
   	end if

   	''
	dtype = typ

	'' AST will handle descriptor pointers
	if( isbyref or isimport ) then
		'' byref or import? by now it's a pointer var, the real type will be set bellow
		varexpr = astNewVAR( sym, elm, 0, IR.DATATYPE.UINT, NULL )
	else
		varexpr = astNewVAR( sym, elm, ofs, dtype, subtype )
	end if

	'' has index?
	if( idxexpr <> NULL ) then
		'' byref or import's are already pointers
		if( isbyref or isimport ) then
			varexpr = astNewBOP( IR.OP.ADD, varexpr, idxexpr )
		else
			varexpr = astNewIDX( varexpr, idxexpr, dtype, subtype )
		end if
	else
		'' array and no index?
		if( not isbydesc ) then
  			if( isarray ) then
  				if( checkarray ) then
   					hReportError FB.ERRMSG.EXPECTEDINDEX, TRUE
   					exit function
   				end if
   			end if
    	end if
	end if

	'' check arguments passed by reference (implicity pointer's)
	if( isbyref or isimport ) then
   		varexpr = astNewPTR( sym, elm, ofs, varexpr, dtype, subtype )
	end if

    '' FuncPtrOrDerefFields?
	cFuncPtrOrDerefFields( sym, elm, typ, subtype, varexpr, isfuncptr, checkarray )

	function = (hGetLastError() = FB.ERRMSG.OK)

end function

'':::::
''cVarOrDeref		= 	Deref | AddrOf | Variable
''
function cVarOrDeref( varexpr as ASTNODE ptr, _
					  byval checkarray as integer, _
					  byval checkaddrof as integer ) as integer

	dim as FBSYMBOL ptr sym, elm
	dim as integer res

	res = cDerefExpression( varexpr )
	if( not res ) then
		if( checkaddrof ) then
			res = cAddrOfExpression( varexpr, sym, elm )
		end if
		if( not res ) then
			res = cVariable( varexpr, sym, elm, checkarray )
		end if
	end if

	function = res

end function
