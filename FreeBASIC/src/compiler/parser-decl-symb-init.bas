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


'' symbol initializers
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\symb.bi"

type FB_INITCTX
	sym			as FBSYMBOL ptr
	dim 		as FBVARDIM ptr
	dimcnt		as integer
	tree		as ASTNODE ptr
end type

declare function 	hUDTInit			( _
											byref ctx as FB_INITCTX _
					  	   				) as integer


'':::::
private function hElmInit _
	( _
		byref ctx as FB_INITCTX _
	) as integer

    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr oldsym

    function = FALSE

    '' set the context symbol to allow taking the address of overloaded
    '' procs and also to allow anonymous UDT's
    oldsym = env.ctxsym
    env.ctxsym = symbGetSubType( ctx.sym )

	if( cExpression( expr ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until ',' and create a fake expression
			hSkipUntil( CHAR_COMMA )
			expr = astNewCONSTz( symbGetType( ctx.sym ) )
		end if
	end if

	env.ctxsym = oldsym

    ''
    static as ASTNODE lside

    astBuildVAR( @lside, NULL, 0, symbGetType( ctx.sym ), symbGetSubtype( ctx.sym ) )

    '' don't build a FIELD node if it's an UDTElm symbol,
    '' that doesn't matter with checkASSIGN

    if( astCheckASSIGN( @lside, expr ) = FALSE ) then
		if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
        	exit function
        else
        	'' error recovery: create a fake expression
        	astDelTree( expr )
        	expr = astNewCONSTz( symbGetType( ctx.sym ) )
        end if
	end if

	''
	astTypeIniAddExpr( ctx.tree, expr, ctx.sym )

	function = TRUE

end function

'':::::
private function hArrayInit _
	( _
		byref ctx as FB_INITCTX _
	) as integer

    dim as integer dimensions, elements, elm_cnt, pad_lgt, isarray
    dim as FBVARDIM ptr old_dim

	function = FALSE

	dimensions = symbGetArrayDimensions( ctx.sym )
	old_dim = ctx.dim

	'' '{'?
	isarray = FALSE
	if( hMatch( CHAR_LBRACE ) ) then
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
				ctx.dim = NULL
			end if

		else
			'' first dim?
			if( ctx.dim = NULL ) then
				ctx.dim = symbGetArrayFirstDim( ctx.sym )

			'' next..
			else
				ctx.dim = ctx.dim->next
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
				if( ctx.dim = NULL ) then
					ctx.dim = symbGetArrayFirstDim( ctx.sym )
				else
					ctx.dim = ctx.dim->next
				end if
			end if
		end if
	end if

	if( ctx.dim <> NULL ) then
		elements = (ctx.dim->upper - ctx.dim->lower) + 1
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
			if( symbGetType( ctx.sym ) <> FB_DATATYPE_USERDEF ) then
				if( hElmInit( ctx ) = FALSE ) then
					exit function
				end if

			else
				if( hUDTInit( ctx ) = FALSE ) then
					exit function
				end if
			end if
		end if

		elm_cnt += 1
		if( elm_cnt >= elements ) then
			exit do
		end if

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	'' pad
	if( elm_cnt < elements ) then
		pad_lgt = (elements - elm_cnt) * symbGetLen( ctx.sym )

		'' not the last dimension?
		if( ctx.dim->next ) then
			pad_lgt *= symbCalcArrayElements( ctx.sym, ctx.dim->next )
		end if

		astTypeIniAddPad( ctx.tree, pad_lgt )
		astTypeIniGetOfs( ctx.tree ) += pad_lgt
	end if

	if( isarray ) then
		'' '}'
		if( hMatch( CHAR_RBRACE ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next '}'
				hSkipUntil( CHAR_RBRACE, TRUE )
			end if
		end if

		ctx.dim = old_dim
		ctx.dimcnt -= 1
	end if

	function = TRUE

end function

'':::::
private function hUDTInit _
	( _
		byref ctx as FB_INITCTX _
	) as integer

	dim as integer elements, elm_cnt, elm_ofs, lgt, baseofs, pad_lgt
    dim as FBSYMBOL ptr elm, udt
    dim as FB_INITCTX old_ctx = any

    function = FALSE

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
		ctx.dim = NULL
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
function cVariableInit _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isinitializer as integer _
	) as ASTNODE ptr

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
	end if

	ctx.sym = sym
	ctx.dim = NULL
	ctx.dimcnt = 0
	ctx.tree = astTypeIniBegin( symbGetType( sym ), symbGetSubtype( sym ) )

	if( hArrayInit( ctx ) = FALSE ) then
		exit function
	end if

	astTypeIniEnd( ctx.tree, isinitializer )

	''
	if( symbIsVar( ctx.sym ) ) then
		symbSetIsInitialized( ctx.sym )
	end if

	''
	function = ctx.tree

end function


