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
			if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
    	end if

    	'' Expression
		dimexpr = cExpression( )
		if( dimexpr = NULL ) then
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

    	expr = astNewBOP( AST_OP_MUL, expr, astNewCONSTi( (d->upper - d->lower)+1 ) )
	loop

    ''
    if( dims < maxdims ) then
		if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
			exit function
		end if
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
'' UdtMember       =   (ID ArrayIdx? '.')*
''
function cUdtMember _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byref expr as ASTNODE ptr, _
		byref method_sym as FBSYMBOL ptr, _
		byval checkarray as integer _
	) as FBSYMBOL ptr

    dim as ASTNODE ptr constexpr = any
    dim as FBSYMBOL ptr fld = any

	function = NULL

	fld = NULL
	method_sym = NULL

	do while( dtype = FB_DATATYPE_STRUCT )

		'' ID?
		select case as const lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

		case else
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' no error recovery: caller will take care
			exit function
		end select

    	dim as FBSYMCHAIN ptr chain_ = symbLookupCompField( subtype, lexGetText( ) )
    	if( chain_ = NULL ) then
    		if( errReportUndef( FB_ERRMSG_ELEMENTNOTDEFINED, _
    							lexGetText( ) ) <> FALSE ) then
    			'' no error recovery: caller will take care
    			lexSkipToken( )
    		end if
    		exit function
    	end if

		''
		dim as FBSYMBOL ptr sym = any
		do
			sym = chain_->sym
			do
    			'' since methods don't start a new hash, params and local
    			'' symbol dups will also be found
    			if( symbGetScope( sym ) = symbGetScope( subtype ) ) then
    				goto exit_search
    			end if

				sym = sym->hash.next
			loop while( sym <> NULL )

			chain_ = chain_->next
    	loop while( chain_ <> NULL )

    	'' nothing found..
    	if( errReportUndef( FB_ERRMSG_ELEMENTNOTDEFINED, _
    						lexGetText( ) ) <> FALSE ) then
    		'' no error recovery: caller will take care
    		lexSkipToken( )
    	end if
    	exit function

exit_search:
		'' not a data field?
		if( symbIsField( sym ) = FALSE ) then

			'' const? (enum, too)
			if( symbIsConst( sym ) ) then

    			'' check visibility
				if( symbCheckAccess( subtype, sym ) = FALSE ) then
					if( errReport( FB_ERRMSG_ILLEGALMEMBERACCESS ) = FALSE ) then
						exit function
					end if
				end if

				lexSkipToken( )

				astDelTree( expr )
				expr = astNewCONST( @symbGetConstVal( sym ), _
									symbGetType( sym ), _
									symbGetSubType( sym ) )
                fld = sym

			else
				method_sym = sym
			end if

			exit do
		end if

    	'' check visibility (note: can't check methods because they can
    	'' be overloaded and each can have a different access mode)
		if( symbCheckAccess( subtype, sym ) = FALSE ) then
			if( errReport( FB_ERRMSG_ILLEGALMEMBERACCESS ) = FALSE ) then
	    		exit function
			end if
		end if

		'' data field..
		lexSkipToken( )

		fld = sym

    	if( symbGetOfs( fld ) <> 0 ) then
    		constexpr = astNewCONSTi( symbGetOfs( fld ), FB_DATATYPE_INTEGER )
    		if( expr = NULL ) then
    			expr = constexpr
    		else
	    		expr = astNewBOP( AST_OP_ADD, expr, constexpr )
    		end if
    	end if

    	dtype = symbGetType( fld )
    	subtype = symbGetSubType( fld )

		'' '('?
		if( lexGetToken( ) = CHAR_LPRNT ) then

			'' if field isn't an array, it can be function field, exit
			if( symbGetArrayDimensions( fld ) = 0 ) then
				exit do
			end if

    		'' '('')'?
    		if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
    			exit do
    		end if

    		lexSkipToken( )

			expr = hFieldArray( fld, expr )
			if( expr = NULL ) then
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
			if( symbGetArrayDimensions( fld ) <> 0 ) then
				if( checkarray ) then
    				if( errReport( FB_ERRMSG_EXPECTEDINDEX ) = FALSE ) then
	    				exit function
    				end if
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

   				exit do
   			end if
        end if

		'' '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			exit do
		end if

		lexSkipToken( LEXCHECK_NOPERIOD )
    loop

    function = fld

end function

'':::::
function cMemberAccess _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr fld = any, method_sym = any
	dim as ASTNODE ptr fldexpr = NULL

	fld = cUdtMember( dtype, subtype, fldexpr, method_sym, TRUE )
	if( fld = NULL ) then
		if( method_sym = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			return NULL
		end if

	else
		'' constant? exit..
		if( symbIsConst( fld ) ) then
			astDeltree( expr )
			return fldexpr
		end if

		dtype = symbGetType( fld )
		subtype = symbGetSubType( fld )

		'' it's a proc call, but was it originally returning an UDT?
		if( astIsCALL( expr ) ) then
			if( symbGetUDTRetType( astGetSubtype( expr ) ) <> _
								FB_DATATYPE_POINTER+FB_DATATYPE_STRUCT ) then

				'' it's returning the result in registers, move to a temp var
				'' (note: if it's being returned in regs, there's no DTOR)
				dim as FBSYMBOL ptr tmp = any

				tmp = symbAddTempVar( FB_DATATYPE_STRUCT, _
							  	  	  astGetSubtype( expr ), _
							  	  	  FALSE, _
							  	  	  FALSE )

				expr = astNewASSIGN( astBuildVarField( tmp ), _
							  	  	 expr, _
							  	  	 AST_OPOPT_DONTCHKOPOVL )

        		expr = astNewLINK( astBuildVarField( tmp ), expr )

        	'' returning result in a hidden arg..
        	else
        		expr = astBuildCallHiddenResVar( expr )
        	end if
        end if

 		'' build: cast( udt ptr, (cast( byte ptr, @udt) + fldexpr))->field
 		expr = astNewADDROF( expr )

 		'' can't be 0, or PTR will remove the ADDROF, and we are taking the
 		'' address-of a LINK node that can't be changed
 		if( fldexpr = NULL ) then
 			fldexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
 		end if

 		expr = astNewDEREF( astNewBOP( AST_OP_ADD, expr, fldexpr ), _
 						    dtype, _
 						    subtype )

 		expr = astNewFIELD( expr, fld, dtype, subtype )
	end if

	'' method call?
	if( method_sym <> NULL ) then
		expr = cMethodCall( method_sym, expr )
		if( expr = NULL ) then
			return NULL
		end if
	end if

	function = expr

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
		if( errReport( FB_ERRMSG_SYNTAXERROR, TRUE ) = FALSE ) then
			return NULL
		end if
	end if

	if( dtype = FB_DATATYPE_STRING ) then
		'' deref
		varexpr = astBuildStrPtr( varexpr )
	else
		'' address of
		varexpr = astNewADDROF( varexpr )
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
		byval checkarray as integer _
	) as ASTNODE ptr

#macro hCheckDeref( cnt, expr, dtype, subtype )
	if( cnt > 0 ) then
		expr = astBuildMultiDeref( cnt, expr, dtype, subtype )
		if( expr = NULL ) then
			exit function
		end if

    	dtype = astGetDataType( expr )
    	subtype = astGetSubType( expr )
	end if
#endmacro

	dim as integer derefcnt = any, is_field = any, lgt = any
	dim as ASTNODE ptr fldexpr = any, idxexpr = any
	dim as FBSYMBOL ptr fld = any, method_sym = any

	function = NULL

	do
		idxexpr = NULL
		derefcnt = 0

        select case lexGetToken( )
        '' ('->' DREF* UdtMember)*
        case FB_TK_FIELDDEREF
        	is_field = TRUE

			dim as integer is_ovl = FALSE
			if( dtype < FB_DATATYPE_POINTER ) then
				'' check op overloading
    			if( symb.globOpOvlTb(AST_OP_FLDDEREF).head = NULL ) then
					if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
						exit function
					else
						exit do
					end if
				end if

    			dim as FBSYMBOL ptr proc = any
    			dim as FB_ERRMSG err_num = any

				proc = symbFindUopOvlProc( AST_OP_FLDDEREF, varexpr, @err_num )
				if( proc <> NULL ) then
    				'' build a proc call
					varexpr = astBuildCall( proc, 1, varexpr )
					if( varexpr = NULL ) then
						exit function
					end if

    				lexSkipToken( LEXCHECK_NOPERIOD )

    				varexpr = cMemberAccess( astGetDataType( varexpr ), _
    										 astGetSubType( varexpr ), _
    										 varexpr )
					if( varexpr = NULL ) then
						exit function
					end if

    				dtype = astGetDataType( varexpr )
    				subtype = astGetSubType( varexpr )
    				is_ovl = TRUE

				else
					if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
						exit function
					else
						exit do
					end if
				end if

			else
       			lexSkipToken( LEXCHECK_NOPERIOD )
				dtype -= FB_DATATYPE_POINTER
			end if

       		'' DREF*
			do while( lexGetToken( ) = FB_TK_DEREFCHAR )
				lexSkipToken( LEXCHECK_NOPERIOD )
				derefcnt += 1
			loop

			if( is_ovl ) then
				hCheckDeref( derefcnt, varexpr, dtype, subtype )
				continue do
			end if

		'' '['
		case CHAR_LBRACKET
			lexSkipToken( )

			'' Expression
			idxexpr = cExpression( )
			if( idxexpr = NULL ) then
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

					varexpr = hStrIndexing( dtype, varexpr, idxexpr )
					exit do
				end select

				if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
					exit function
				else
					exit do
				end if

			else
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
			end if

			'' '.'?
			is_field = (lexGetToken( ) = CHAR_DOT)
			if( is_field ) then
				lexSkipToken( LEXCHECK_NOPERIOD )
			end if

		'' exit..
		case else
			exit do

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

		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS

		case else
			if( is_field ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
					exit function
				else
					exit do
				end if
			end if

		end select

		fldexpr = NULL
		if( is_field ) then
			'' UdtMember
			fld = cUdtMember( dtype, subtype, fldexpr, method_sym, checkarray )
			if( fld = NULL ) then
				if( method_sym = NULL ) then
					if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
						exit function
					else
						exit do
					end if
				end if
			else
    			dtype = symbGetType( fld )
    			subtype = symbGetSubType( fld )
			end if
		else
			fld = NULL
			method_sym = NULL
		end if

		'' constant? exit..
		if( fld <> NULL ) then
			if( symbIsConst( fld ) ) then
				astDeltree( idxexpr )
				astDeltree( varexpr )
				varexpr = fldexpr
				exit do
			end if
		end if

		'' null pointer checking
		if( env.clopt.extraerrchk ) then
			varexpr = astNewPTRCHK( varexpr, lexLineNum( ) )
		end if

		'' fields at ofs 0 aren't returned as expressions by cUdtMember()
		dim as integer is_nidxarray = FALSE
		if( fldexpr <> NULL ) then
			'' ugly hack to deal with arrays w/o indexes
			if( astIsNIDXARRAY( fldexpr ) ) then
				dim as ASTNODE ptr tmpexpr = astGetLeft( fldexpr )
				astDelNode( fldexpr )
				fldexpr = tmpexpr
				is_nidxarray = TRUE
			end if

			'' this should be optimized by AST, when expr is a constant and
			'' varexpr is a scalar var
			varexpr = astNewBOP( AST_OP_ADD, varexpr, fldexpr )
		end if

		''
		if( idxexpr <> NULL ) then
			varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )
		end if

		''
		varexpr = astNewDEREF( varexpr, dtype, subtype )

        ''
		if( fld <> NULL ) then
			varexpr = astNewFIELD( varexpr, fld, dtype, subtype )
 		end if

		'' non-indexed array?
		if( is_nidxarray ) then
        	varexpr = astNewNIDXARRAY( varexpr )

			if( derefcnt > 0 ) then
				if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
					exit function
				end if
			end if

			exit do
		end if

		'' method call?
		if( method_sym <> NULL ) then
			varexpr = cMethodCall( method_sym, varexpr )
			if( varexpr = NULL ) then
				return FALSE
			else
    			dtype = astGetDataType( varexpr )
    			subtype = astGetSubType( varexpr )
			end if
		end if

		''
		hCheckDeref( derefcnt, varexpr, dtype, subtype )
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
		expr = cMemberDeref( dtype, subtype, expr, checkarray )

		if( expr = NULL ) then
			exit function
		end if

		dtype = astGetDataType( expr )
		subtype = astGetSubType( expr )

   		'' check for functions called through pointers
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
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
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
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
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				return NULL
			else
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )
		if( dimexpr = NULL ) then
			return NULL
		end if

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
			if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
				return NULL
			end if
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
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				return NULL
			else
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )
		if( dimexpr = NULL ) then
			return NULL
		end if

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
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				return NULL
			else
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
			end if
		end if

		'' convert index if needed
		dimexpr = hCheckIndex( dimexpr )
		if( dimexpr = NULL ) then
			return NULL
		end if

    	'' bounds checking
    	if( env.clopt.extraerrchk ) then
    		dimexpr = astNewBOUNDCHK( dimexpr, _
    								  astNewCONSTi( d->lower, FB_DATATYPE_INTEGER ), _
    								  astNewCONSTi( d->upper, FB_DATATYPE_INTEGER ), _
    								  lexLineNum( ) )

			if( dimexpr = NULL ) then
				if( errReport( FB_ERRMSG_ARRAYOUTOFBOUNDS ) = FALSE ) then
					return NULL
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
				return NULL
			else
				exit do
			end if
    	end if

    	expr = astNewBOP( AST_OP_MUL, _
    					  expr, _
    					  astNewCONSTi( (d->upper - d->lower) + 1 ) )
	loop

    ''
    if( dims < maxdims ) then
		if( errReport( FB_ERRMSG_WRONGDIMENSIONS ) = FALSE ) then
			return NULL
		end if
    end if

	'' times length (this will be optimized if len < 10 and there's
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

	options = FB_SYMBOPT_ADDSUFFIX

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
		var_ = astNewDECL( FB_SYMBCLASS_VAR, s, NULL )

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
function cVariableEx _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

	dim as zstring ptr id = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr sym = any, subtype = any
	dim as ASTNODE ptr varexpr = any, idxexpr = any

	''
	id = lexGetText( )
	dtype = lexGetType( )
	subtype = NULL

	if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) ) then
    	'' no suffix? lookup the default type (last DEF###) in the
    	'' case symbol could not be found..
    	if( dtype = INVALID ) then
    		sym = symbFindVarByDefType( chain_, symbGetDefType( id ) )
    	else
    		sym = symbFindVarBySuffix( chain_, dtype )
    	end if

	else
		if( dtype <> INVALID ) then
			errReportNotAllowed( FB_LANG_OPT_SUFFIX, FB_ERRMSG_SUFFIXONLYVALIDINLANG )
		end if

		sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
	end if

	if( sym <> NULL ) then
		dtype = sym->typ
		subtype = sym->subtype

	else
		if( env.opt.explicit ) then
			if( errReportUndef( FB_ERRMSG_VARIABLENOTDECLARED, id ) = FALSE ) then
				return NULL
			end if
		end if

		'' don't allow explicit namespaces
    	if( chain_ <> NULL ) then
    		if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) ) then
    			'' variable?
    			sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
    			if( sym <> NULL ) then
    				'' from a different namespace?
    				if( symbGetNamespace( sym ) <> symbGetCurrentNamespc( ) ) then
    					if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
    						return NULL
    					end if
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
			return NULL
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
	dim as integer is_byref = any, is_funcptr = any
	dim as integer is_array = any, checkfields = any, is_nidxarray = any
	dim as FBSYMBOL ptr fld = any, method_sym = any

	fld	= NULL
	method_sym = NULL

    is_byref = symbIsParamByRef( sym ) or symbIsImport( sym )
	is_array = symbIsArray( sym )
	is_funcptr = FALSE
	is_nidxarray = FALSE

    varexpr = NULL
    idxexpr = NULL
	checkfields = TRUE

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
    				if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
    					return NULL
    				else
    					'' error recovery: skip until next ')'
    					hSkipUntil( CHAR_RPRNT, TRUE )
    				end if
    			end if

    		else
   				'' check if calling functions through pointers
   				is_funcptr = (dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION)

    			'' using (...) with scalars?
    			if( (is_array = FALSE) and (is_funcptr = FALSE) ) then
    				if( errReport( FB_ERRMSG_ARRAYNOTALLOCATED, TRUE ) = FALSE ) then
    					return NULL
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
   			'' ('.' UdtMember)?
   			if( lexGetToken( ) = CHAR_DOT ) then
    			lexSkipToken( LEXCHECK_NOPERIOD )

   				fld = cUdtMember( dtype, subtype, idxexpr, method_sym, checkarray )

				if( fld = NULL ) then
					if( errGetLast( ) <> FB_ERRMSG_OK ) then
						exit function
					end if

				else
					'' constant? exit..
					if( symbIsConst( fld ) ) then
						astDeltree( varexpr )
						return idxexpr
					end if

    				dtype = symbGetType( fld )
    				subtype = symbGetSubType( fld )

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

   				if( method_sym = NULL ) then
   					'' check if calling functions through pointers
   					if( lexGetToken( ) = CHAR_LPRNT ) then
   						is_funcptr = (dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION)
   					end if
   				end if
			end if
   		end if
   	end if

	'' AST will handle descriptor pointers
	if( is_byref ) then
		'' byref or import? by now it's a pointer var, the real type will be set bellow
		varexpr = astNewVAR( sym, 0, FB_DATATYPE_POINTER + dtype, subtype )
	else
		varexpr = astNewVAR( sym, 0, dtype, subtype )
	end if

	'' has index?
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

    if( fld <> NULL ) then
    	varexpr = astNewFIELD( varexpr, fld, dtype, subtype )
    end if

	'' method call?
	if( method_sym <> NULL ) then
		varexpr = cMethodCall( method_sym, varexpr )
		if( varexpr = NULL ) then
			exit function
		else
    		dtype = astGetDataType( varexpr )
    		subtype = astGetSubType( varexpr )
		end if
	end if

    if( checkfields ) then
    	'' FuncPtrOrMemberDeref?
		function = cFuncPtrOrMemberDeref( dtype, _
										  subtype, _
										  varexpr, _
										  is_funcptr, _
										  checkarray )

	'' non-indexed array?
	elseif( is_nidxarray ) then
        function = astNewNIDXARRAY( varexpr )

	else
		function = varexpr
	end if

end function

'':::::
''WithVariable        =   '.' UdtMember FuncPtrOrMemberDeref? .
''
function cWithVariable _
	( _
		byval sym as FBSYMBOL ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

	dim as integer dtype = any, isfuncptr = any, is_nidxarray = any
	dim as FBSYMBOL ptr fld = any, subtype = any, method_sym = any
	dim as ASTNODE ptr varexpr = any

   	dtype = symbGetType( sym )
   	subtype = symbGetSubtype( sym )

   	varexpr = astNewVAR( sym, 0, dtype, subtype )

   	'' UdtMember
   	dtype -= FB_DATATYPE_POINTER

    '' '.'
    lexSkipToken( LEXCHECK_NOPERIOD )

   	'' UdtMember
   	fld = cUdtMember( dtype, subtype, varexpr, method_sym, checkarray )

	is_nidxarray = FALSE
	if( fld = NULL ) then
		if( method_sym = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' no error recovery: caller will take care
			return NULL
		end if
	else
		'' constant? exit..
		if( symbIsConst( fld ) ) then
			return varexpr
		end if

    	dtype = symbGetType( fld )
    	subtype = symbGetSubType( fld )

		if( varexpr <> NULL ) then
			'' ugly hack to deal with arrays w/o indexes
			if( astIsNIDXARRAY( varexpr ) ) then
				dim as ASTNODE ptr expr = astGetLeft( varexpr )
				astDelNode( varexpr )
				varexpr = expr
				is_nidxarray = TRUE
			end if
		end if
	end if

	'' deref the with temp pointer
	varexpr = astNewDEREF( varexpr, dtype, subtype )

    if( fld <> NULL ) then
    	varexpr = astNewFIELD( varexpr, fld, dtype, subtype )
    end if

   	isfuncptr = FALSE

	'' method call?
	if( method_sym <> NULL ) then
		varexpr = cMethodCall( method_sym, varexpr )
		if( varexpr = NULL ) then
			return NULL
		else
    		dtype = astGetDataType( varexpr )
    		subtype = astGetSubType( varexpr )
		end if
	else
   		'' check if calling functions through pointers
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			isfuncptr = (dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION)
   		end if
	end if

    if( is_nidxarray = FALSE ) then
    	'' FuncPtrOrMemberDeref?
		function = cFuncPtrOrMemberDeref( dtype, _
									 	  subtype, _
									 	  varexpr, _
									 	  isfuncptr, _
									 	  checkarray )


	'' non-indexed array?
	else
        function = astNewNIDXARRAY( varexpr )
	end if

end function

'':::::
''Variable        =   '.'? ID ArrayIdx? UdtMember? FuncPtrOrMemberDeref? .
''
function cVariable _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval checkarray as integer = TRUE _
	) as ASTNODE ptr

	'' ID
    select case lexGetClass( )
    case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD
	    return cVariableEx( chain_, checkarray )

	case else
		if( parser.stmt.with.sym = NULL ) then
			return FALSE
		end if

		'' '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			return FALSE
		end if

		return cWithVariable( parser.stmt.with.sym, checkarray )
	end select

end function

'':::::
''DataMember    =   UdtMember? FuncPtrOrMemberDeref? .
''
function cDataMember _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr, _
		byval checkarray as integer _
	) as ASTNODE ptr

	dim as integer dtype = any, isfuncptr = any, is_nidxarray = any
	dim as FBSYMBOL ptr fld = any, subtype = any, method_sym = any
	dim as ASTNODE ptr varexpr = NULL, fldexpr = NULL

	if( this_ = NULL ) then
		dim as FBSYMBOL ptr param = symbGetProcHeadParam( parser.currproc )
		if( symbIsMethod( parser.currproc ) and (param <> NULL) ) then
			this_ = symbGetParamVar( param )
		end if

		if( this_ = NULL ) then
			errReport( FB_ERRMSG_STATICMEMBERHASNOINSTANCEPTR )
			return NULL
		end if
	end if

   	dtype = symbGetType( this_ )
   	subtype = symbGetSubtype( this_ )

   	'' UdtMember
   	fld = cUdtMember( dtype, subtype, fldexpr, method_sym, checkarray )

	is_nidxarray = FALSE
	if( fld = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' no error recovery: caller will take care
		return NULL

	else
		'' constant? exit..
		if( symbIsConst( fld ) ) then
			return fldexpr
		end if

    	dtype = symbGetType( fld )
    	subtype = symbGetSubType( fld )

		if( fldexpr <> NULL ) then
			'' ugly hack to deal with arrays w/o indexes
			if( astIsNIDXARRAY( fldexpr ) ) then
				dim as ASTNODE ptr expr = astGetLeft( fldexpr )
				astDelNode( fldexpr )
				fldexpr = expr
				is_nidxarray = TRUE
			end if
		end if
	end if

   	'' build this.field
   	varexpr = astNewVAR( this_, 0, FB_DATATYPE_POINTER + FB_DATATYPE_VOID, NULL )

	if( fldexpr <> NULL ) then
		varexpr = astNewBOP( AST_OP_ADD, varexpr, fldexpr )
	end if

	'' deref the instance pointer
	varexpr = astNewDEREF( varexpr, dtype, subtype )

    if( fld <> NULL ) then
    	varexpr = astNewFIELD( varexpr, fld, dtype, subtype )
    end if

   	isfuncptr = FALSE

	'' method call?
	if( method_sym <> NULL ) then
		varexpr = cMethodCall( method_sym, varexpr )
		if( varexpr = NULL ) then
			return NULL
		else
    		dtype = astGetDataType( varexpr )
    		subtype = astGetSubType( varexpr )
		end if

	else
   		'' check if calling functions through pointers
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			isfuncptr = (dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION)
   		end if
	end if

    if( is_nidxarray = FALSE ) then
    	'' FuncPtrOrMemberDeref?
		function = cFuncPtrOrMemberDeref( dtype, _
									 	  subtype, _
									 	  varexpr, _
									 	  isfuncptr, _
									 	  TRUE )

	'' non-indexed array?
	else
        function = astNewNIDXARRAY( varexpr )
	end if

end function

'':::::
''cVarOrDeref		= 	Deref | PtrTypeCasting | AddrOf | Variable
''
function cVarOrDeref _
	( _
		byval check_array as integer, _
		byval allow_addrof as integer _
	) as ASTNODE ptr

'':::
#macro hInvalidType( )
	astDelTree( expr )
	errReport( FB_ERRMSG_INVALIDDATATYPES )
#endmacro

	dim as integer res = any
	dim as FB_PARSEROPT options = any
	dim as ASTNODE ptr expr = any

	options = parser.options
	fbSetCheckArray( check_array )

	expr = cHighestPrecExpr( NULL, NULL )

	parser.options = options

	if( expr <> NULL ) then
		'' skip any casting if they won't do any conversion
		dim as ASTNODE ptr t = expr
		if( astIsCAST( expr ) ) then
			if( astGetCASTDoConv( expr ) = FALSE ) then
				t = astGetLeft( expr )
			end if
		end if

		select case as const astGetClass( t )
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FIELD, _
			 AST_NODECLASS_DEREF, AST_NODECLASS_CALL, AST_NODECLASS_NIDXARRAY

		case AST_NODECLASS_ADDROF, AST_NODECLASS_OFFSET
			if( allow_addrof = FALSE ) then
				hInvalidType( )
				'' no error recovery: caller will take care
				return NULL
			end if

		case AST_NODECLASS_BOP
			'' allow addresses?
			if( allow_addrof ) then
				'' not a pointer? (@foo[bar] will be converted to foo + bar)
				if( astGetDataType( expr ) < FB_DATATYPE_POINTER ) then
					hInvalidType( )
					return NULL
				end if
			else
				hInvalidType( )
				return NULL
			end if

		case else
			hInvalidType( )
			return NULL
		end select
	end if

	function = expr

end function
