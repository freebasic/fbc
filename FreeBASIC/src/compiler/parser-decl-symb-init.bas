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


'' symbol initializers
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\symb.bi"

type FB_INITCTX
	sym			as FBSYMBOL ptr
	dim_ 		as FBVARDIM ptr
	dimcnt		as integer
	tree		as ASTNODE ptr
	options		as FB_INIOPT
end type

declare function hUDTInit _
	( _
		byref ctx as FB_INITCTX, _
		byval expr_in as ASTNODE ptr = NULL, _
		byval is_auto as integer = FALSE _
	) as integer

private function hBackpatchAutoSymbol _ 
	( _
		byref ctx as FB_INITCTX, _
		byref expr as ASTNODE ptr, _
		byref dtype as integer _
	) as integer
    
    function = TRUE
    
    '' take type from initializer
	dtype = astGetDataType( expr )
	
	'' wstrings not allowed...
	if dtype = FB_DATATYPE_WCHAR then
		if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
	    	return FALSE
	    else
	    	'' error recovery: create a fake expression
	    	astDelTree( expr )
	    	expr = astNewCONSTz( dtype )
	    end if
	end if
	
	'' backpatching...
	symbGetSubType( ctx.sym )  = astGetSubtype( expr )
	symbGetType( ctx.sym )     = dtype
	astGetDataType( ctx.tree ) = dtype
	astGetSubtype( ctx.tree )  = astGetSubtype( expr )
	
	'' zstring... convert to string
	if dtype = FB_DATATYPE_CHAR then
		dtype = FB_DATATYPE_STRING
	end if
	
	'' len( symbol )...
	ctx.sym->lgt = symbCalcLen( dtype, symbGetSubtype( ctx.sym ) )

end function

'':::::
private function hDoAssign _
	( _
		byref ctx as FB_INITCTX, _
		byval expr as ASTNODE ptr _
	) as integer

    dim as ASTNODE lside = any
	dim as integer dtype = any

    if ctx.options and FB_INIOPT_AUTO then
    	if hBackpatchAutoSymbol( ctx, expr, dtype ) = FALSE then
    		return FALSE
    	end if
    	ctx.options and= (not FB_INIOPT_AUTO)
    else
		dtype = symbGetType( ctx.sym )
	end if
	
	if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype -= FB_DATATYPE_POINTER
	end if

    astBuildVAR( @lside, NULL, 0, dtype, symbGetSubtype( ctx.sym ) )

    '' don't build a FIELD node if it's an UDTElm symbol,
    '' that doesn't matter with checkASSIGN

    if( astCheckASSIGN( @lside, expr ) = FALSE ) then
		if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
        	return FALSE
        else
        	'' error recovery: create a fake expression
        	astDelTree( expr )
        	expr = astNewCONSTz( dtype )
        end if
	end if

	''
	astTypeIniAddAssign( ctx.tree, expr, ctx.sym )

	function = TRUE

end function

'':::::
private function hCheckDuplicateAutoSymbol _ 
	( _
		byref ctx as FB_INITCTX, _
		byref expr as ASTNODE ptr _
	) as integer
	
	function = TRUE
	
	'' auto var was found in the initializer?
	if astSymbolInInitializer( ctx.sym, expr ) then
		if( errReport( FB_ERRMSG_UNDEFINEDSYMBOL, TRUE, " '" + *symbGetName( ctx.sym ) + "'" ) = FALSE ) then
			return FALSE
		else
	        '' generate an expression matching the symbol's type
			dim as integer dtype = symbGetType( ctx.sym )
			if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
				dtype -= FB_DATATYPE_POINTER
			end if
			expr = astNewCONSTz( dtype )
	
		end if
	end if
	
end function

'':::::
private function hElmInit _
	( _
		byref ctx as FB_INITCTX, _
		byval expr_in as ASTNODE ptr = NULL, _
		byval is_auto as integer = FALSE _
	) as integer

    dim as ASTNODE ptr expr = any
    dim as FBSYMBOL ptr oldsym = any

    function = FALSE

    '' auto?
    if( is_auto ) then
    	expr = expr_in
    	if hCheckDuplicateAutoSymbol( ctx, expr ) = FALSE then
    		exit function
    	end if

    '' to be parsed...
    else
	    '' set the context symbol to allow taking the address of overloaded
	    '' procs and also to allow anonymous UDT's
	    oldsym = parser.ctxsym
	    parser.ctxsym = symbGetSubType( ctx.sym )
        
        '' parse expression
		expr = cExpression( )
		
	end if
	
	'' invalid expression
	if( expr = NULL ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until ',' and create a fake expression
			hSkipUntil( CHAR_COMMA )
            
            '' generate an expression matching the symbol's type
			dim as integer dtype = symbGetType( ctx.sym )
			if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
				dtype -= FB_DATATYPE_POINTER
			end if
			expr = astNewCONSTz( dtype )

		end if
	end if
    
    '' restore context if needed
    if( is_auto = FALSE ) then
		parser.ctxsym = oldsym
	end if

	function = hDoAssign( ctx, expr )

end function

'':::::
private function hArrayInit _
	( _
		byref ctx as FB_INITCTX _
	) as integer

    dim as integer dimensions = any, elements = any, elm_cnt = any
    dim as integer isarray = any, dtype = any
    dim as FBVARDIM ptr old_dim = any
    dim as FBSYMBOL ptr subtype = any

	function = FALSE

	dimensions = symbGetArrayDimensions( ctx.sym )
	old_dim = ctx.dim_

	'' '{'?
	isarray = FALSE
	if( lexGetToken( ) = CHAR_LBRACE ) then
		lexSkipToken( )

		ctx.dimcnt += 1
		'' too many dimensions?
		if( ctx.dimcnt > dimensions ) then
			if( errReport( iif( dimensions > 0, _
								FB_ERRMSG_TOOMANYEXPRESSIONS, _
								FB_ERRMSG_EXPECTEDARRAY ) ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next '}'
				hSkipUntil( CHAR_RBRACE, TRUE )
				ctx.dim_ = NULL
			end if

		else
			'' first dim?
			if( ctx.dim_ = NULL ) then
				ctx.dim_ = symbGetArrayFirstDim( ctx.sym )

			'' next..
			else
				ctx.dim_ = ctx.dim_->next
			end if

			isarray = TRUE
		end if

	else
		'' not the last dimension?
		if( ctx.dimcnt < dimensions ) then
			if( errReport( FB_ERRMSG_EXPECTEDLBRACKET ) = FALSE ) then
				exit function
			else
				ctx.dimcnt += 1
				if( ctx.dim_ = NULL ) then
					ctx.dim_ = symbGetArrayFirstDim( ctx.sym )
				else
					ctx.dim_ = ctx.dim_->next
				end if
			end if
		end if
	end if

	if( ctx.dim_ <> NULL ) then
		elements = (ctx.dim_->upper - ctx.dim_->lower) + 1
	else
		elements = 1
	end if

	''
	dtype = symbGetType( ctx.sym )
	if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype -= FB_DATATYPE_POINTER
	end if

	subtype = symbGetSubtype( ctx.sym )

	'' for each array element..
	elm_cnt = 0
	do
		'' not the last dimension?
		if( ctx.dimcnt < dimensions ) then
			if( hArrayInit( ctx ) = FALSE ) then
				exit function
			end if

		else
			dim as integer is_auto
			dim as ASTNODE ptr expr
            
            '' auto var?
			if( ctx.options and FB_INIOPT_AUTO ) then
                
                '' parse rhs
				expr = cExpression( )

				is_auto = TRUE
				
				if( expr <> NULL ) then
					dtype = astGetDataType( expr )

					if dtype = FB_DATATYPE_STRUCT then
						if( symbGetHasCtor( astGetSubType( expr ) ) ) then
							ctx.options or= FB_INIOPT_ISOBJ
						end if
					end if
					
				end if
				
			end if

			select case dtype
			case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
				if( hUDTInit( ctx, expr, is_auto ) = FALSE ) then
					exit function
				end if

			case else
				if( hElmInit( ctx, expr, is_auto ) = FALSE ) then
					exit function
				end if
			end select
		end if

		elm_cnt += 1
		if( elm_cnt >= elements ) then
			exit do
		end if

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	'' pad
	elements -= elm_cnt
	if( elements > 0 ) then
		'' not the last dimension?
		if( ctx.dim_->next ) then
			elements *= symbCalcArrayElements( ctx.sym, ctx.dim_->next )
		end if

		dim as FBSYMBOL ptr ctor = NULL
		if( (ctx.options and FB_INIOPT_ISOBJ) <> 0 ) then
			ctor = symbGetCompDefCtor( subtype )
			if( ctor = NULL ) then
				errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
			else
    			'' check visibility
	    		if( symbCheckAccess( subtype, ctor ) = FALSE ) then
					errReport( FB_ERRMSG_NOACCESSTODEFAULTCTOR )
				end if
			end if
		end if

		if( ctor <> NULL ) then
			astTypeIniAddCtorList( ctx.tree, ctx.sym, elements )
		else
			dim as integer pad_lgt = any
			'' calc len.. handle fixed-len strings
			select case as const dtype
			case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				pad_lgt = symbGetLen( ctx.sym )
			case else
				pad_lgt = symbCalcLen( dtype, subtype )
			end select

			pad_lgt *= elements

			astTypeIniAddPad( ctx.tree, pad_lgt )
			astTypeIniGetOfs( ctx.tree ) += pad_lgt
		end if

	end if

	if( isarray ) then
		'' '}'
		if( lexGetToken( ) <> CHAR_RBRACE ) then
			if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next '}'
				hSkipUntil( CHAR_RBRACE, TRUE )
			end if

		else
			lexSkipToken( )
		end if

		ctx.dim_ = old_dim
		ctx.dimcnt -= 1
	end if

	function = TRUE

end function

'':::::
private function hUDTInit _
	( _
		byref ctx as FB_INITCTX, _
		byval expr_in as ASTNODE ptr = NULL, _
		byval is_auto as integer = FALSE _
	) as integer

	dim as integer elements = any, elm_cnt = any, elm_ofs = any
	dim as integer lgt = any, baseofs = any, pad_lgt = any, dtype = any
    dim as FBSYMBOL ptr elm = any, subtype = any
    dim as FB_INITCTX old_ctx = any

    function = FALSE

    '' ctor?
    if( (ctx.options and FB_INIOPT_ISOBJ) <> 0 ) then
    	dim as ASTNODE ptr expr = any
        
        if is_auto then
        	expr = expr_in
	    	if hCheckDuplicateAutoSymbol( ctx, expr ) = FALSE then
	    		exit function
	    	end if
        else
	    	'' Expression
	    	expr = cExpression( )
	    	if( expr = NULL ) then
				if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
	    	end if
	    end if
        
        if (ctx.options and FB_INIOPT_AUTO) then
	    	if hBackpatchAutoSymbol( ctx, expr, dtype ) = FALSE then
	    		return FALSE
	    	end if
	    	ctx.options and= (not FB_INIOPT_AUTO)
	    end if

    	dim as integer is_ctorcall = any
    	expr = astBuildImplicitCtorCallEx( ctx.sym, expr, is_ctorcall )
        if( expr = NULL ) then
        	exit function
        end if
        
    	if( is_ctorcall ) then
    		return astTypeIniAddCtorCall( ctx.tree, ctx.sym, expr ) <> NULL
    	else
    		'' try to assign it (do a shallow copy)
        	return hDoAssign( ctx, expr )
        end if
    end if

	'' '('
	if( hMatch( CHAR_LPRNT ) = FALSE ) then
		'' it can be a function returning an UDT or another UDT
		'' variable for non-static symbols..
		return hElmInit( ctx, expr_in, is_auto )
	end if

	''
	dtype = symbGetType( ctx.sym )
	if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype -= FB_DATATYPE_POINTER
	end if

	subtype = symbGetSubtype( ctx.sym )

	''
	elm = symbGetUDTFirstElm( subtype )
	elements = symbGetUDTElements( subtype )
	elm_cnt = 0

	lgt = 0
	baseofs = astTypeIniGetOfs( ctx.tree )

	'' save parent
	old_ctx = ctx

	''
	ctx.options and= not FB_INIOPT_DODEREF
	ctx.dim_ = NULL
	ctx.dimcnt = 0

	'' for each UDT element..
	do
		elm_cnt += 1
		if( elm_cnt > elements ) then
			if( errReport( FB_ERRMSG_TOOMANYEXPRESSIONS ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
				exit do
			end if
		end if

		elm_ofs = elm->ofs
		if( lgt > 0 ) then
			pad_lgt = elm_ofs - lgt
			if( pad_lgt > 0 ) then
				astTypeIniAddPad( ctx.tree, pad_lgt )
				lgt += pad_lgt
			end if
		end if

		astTypeIniGetOfs( ctx.tree ) = baseofs + elm_ofs

        ctx.sym = elm

		'' has ctor?
		ctx.options and= not FB_INIOPT_ISOBJ
		select case symbGetType( elm )
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			if( symbGetHasCtor( symbGetSubtype( elm ) ) ) then
				ctx.options or= FB_INIOPT_ISOBJ
			end if
		end select

        if( hArrayInit( ctx ) = FALSE ) then
          	exit function
        end if

        lgt += symbGetLen( elm ) * symbGetArrayElements( elm )

		'' next
		elm = symbGetUDTNextElm( elm )

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	'' restore parent
	ctx = old_ctx

	'' ')'
	if( hMatch( CHAR_RPRNT ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	end if

	''
	dim as integer sym_len = symbCalcLen( dtype, subtype )

	'' pad
	pad_lgt = sym_len - lgt
	if( pad_lgt > 0 ) then
		astTypeIniAddPad( ctx.tree, pad_lgt )
	end if

	astTypeIniGetOfs( ctx.tree ) = baseofs + sym_len

	function = TRUE

end function

'':::::
function cInitializer _
	( _
		byval sym as FBSYMBOL ptr, _
		byval options as FB_INIOPT _
	) as ASTNODE ptr

    dim as integer is_local = any, dtype = any
    dim as FBSYMBOL ptr subtype = any
    dim as FB_INITCTX ctx = any

	function = NULL

	if( symbIsVar( sym ) ) then
		'' cannot initialize dynamic vars
		if( symbGetIsDynamic( sym ) ) then
			errReport( FB_ERRMSG_CANTINITDYNAMICARRAYS, TRUE )
			exit function
		end if

		'' common?? impossible but..
		if( symbIsCommon( sym ) ) then
			errReport( FB_ERRMSG_CANTINITDYNAMICARRAYS, TRUE )
			exit function
		end if

		is_local = symbIsLocal( sym )

	'' param, struct/class field or anon-udt
	else
		is_local = FALSE
	end if

	dtype = symbGetType( sym )
	if( (options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype -= FB_DATATYPE_POINTER
	end if

	subtype = symbGetSubtype( sym )

	''
	ctx.options = options
	ctx.sym = sym
	ctx.dim_ = NULL
	ctx.dimcnt = 0

	ctx.tree = astTypeIniBegin( dtype, subtype, is_local )

	'' has ctor?
	select case dtype
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		if( symbGetHasCtor( subtype ) ) then
			ctx.options or= FB_INIOPT_ISOBJ
		end if
	end select

	dim as integer res = hArrayInit( ctx )

	astTypeIniEnd( ctx.tree, (options and FB_INIOPT_ISINI) <> 0 )

	''
	if( symbIsVar( ctx.sym ) ) then
		symbSetIsInitialized( ctx.sym )
	end if

	''
	function = iif( res, ctx.tree, NULL )

end function


