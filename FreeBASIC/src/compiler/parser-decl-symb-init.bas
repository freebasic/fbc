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
	isobj		as integer
end type

declare function 	hUDTInit			( _
											byref ctx as FB_INITCTX _
					  	   				) as integer

'':::::
private function hDoAssign _
	( _
		byref ctx as FB_INITCTX, _
		byval expr as ASTNODE ptr _
	) as integer static

    dim as ASTNODE lside

    astBuildVAR( @lside, NULL, 0, symbGetType( ctx.sym ), symbGetSubtype( ctx.sym ) )

    '' don't build a FIELD node if it's an UDTElm symbol,
    '' that doesn't matter with checkASSIGN

    if( astCheckASSIGN( @lside, expr ) = FALSE ) then
		if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
        	return FALSE
        else
        	'' error recovery: create a fake expression
        	astDelTree( expr )
        	expr = astNewCONSTz( symbGetType( ctx.sym ) )
        end if
	end if

	''
	astTypeIniAddAssign( ctx.tree, expr, ctx.sym )

	function = TRUE

end function

'':::::
private function hElmInit _
	( _
		byref ctx as FB_INITCTX _
	) as integer

    dim as ASTNODE ptr expr = any
    dim as FBSYMBOL ptr oldsym = any

    function = FALSE

    '' set the context symbol to allow taking the address of overloaded
    '' procs and also to allow anonymous UDT's
    oldsym = parser.ctxsym
    parser.ctxsym = symbGetSubType( ctx.sym )

	if( cExpression( expr ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until ',' and create a fake expression
			hSkipUntil( CHAR_COMMA )
			expr = astNewCONSTz( symbGetType( ctx.sym ) )
		end if
	end if

	parser.ctxsym = oldsym

	function = hDoAssign( ctx, expr )

end function

'':::::
private function hArrayInit _
	( _
		byref ctx as FB_INITCTX _
	) as integer

    dim as integer dimensions = any, elements = any, elm_cnt = any
    dim as integer pad_lgt = any, isarray = any
    dim as FBVARDIM ptr old_dim = any

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

	'' for each array element..
	elm_cnt = 0
	do
		'' not the last dimension?
		if( ctx.dimcnt < dimensions ) then
			if( hArrayInit( ctx ) = FALSE ) then
				exit function
			end if

		else
			select case symbGetType( ctx.sym )
			case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
				if( hUDTInit( ctx ) = FALSE ) then
					exit function
				end if

			case else
				if( hElmInit( ctx ) = FALSE ) then
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
		if( ctx.isobj ) then
			ctor = symbGetCompDefCtor( symbGetSubtype( ctx.sym ) )
			if( ctor = NULL ) then
				errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
			end if
		end if

		if( ctor <> NULL ) then
			astTypeIniAddCtorList( ctx.tree, ctx.sym, elements )
		else
			pad_lgt = elements * symbGetLen( ctx.sym )
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
		byref ctx as FB_INITCTX _
	) as integer

	dim as integer elements = any, elm_cnt = any, elm_ofs = any
	dim as integer lgt = any, baseofs = any, pad_lgt = any
    dim as FBSYMBOL ptr elm = any, udt = any
    dim as FB_INITCTX old_ctx = any

    function = FALSE

    '' ctor?
    if( ctx.isobj ) then
    	dim as ASTNODE ptr expr = any

    	'' Expression
    	if( cExpression( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
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
		return hElmInit( ctx )
	end if

	udt = symbGetSubtype( ctx.sym )
	elm = symbGetUDTFirstElm( udt )

	elements = symbGetUDTElements( udt )
	elm_cnt = 0

	lgt = 0
	baseofs = astTypeIniGetOfs( ctx.tree )

	'' save parent
	old_ctx = ctx

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
		ctx.dim_ = NULL
		ctx.dimcnt = 0
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

	'' pad
	pad_lgt = symbGetLen( ctx.sym ) - lgt
	if( pad_lgt > 0 ) then
		astTypeIniAddPad( ctx.tree, pad_lgt )
	end if

	astTypeIniGetOfs( ctx.tree ) = baseofs + symbGetLen( ctx.sym )

	function = TRUE

end function

'':::::
function cInitializer _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isinitializer as integer _
	) as ASTNODE ptr

    dim as FB_INITCTX ctx = any
    dim as FBSYMBOL ptr subtype = any
    dim as integer is_local = any

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

	subtype = symbGetSubtype( sym )

	ctx.sym = sym
	ctx.dim_ = NULL
	ctx.dimcnt = 0
	ctx.tree = astTypeIniBegin( symbGetType( sym ), subtype, is_local )
	ctx.isobj = FALSE

	if( subtype <> NULL ) then
		select case symbGetType( sym )
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			ctx.isobj = symbGetHasCtor( subtype )
		end select
	end if

	dim as integer res = hArrayInit( ctx )

	astTypeIniEnd( ctx.tree, isinitializer )

	''
	if( symbIsVar( ctx.sym ) ) then
		symbSetIsInitialized( ctx.sym )
	end if

	''
	function = iif( res, ctx.tree, NULL )

end function


