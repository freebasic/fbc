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

declare function 	hUDTInit			( byval tree as ASTNODE ptr, _
					  	   				  byval sym as FBSYMBOL ptr, _
					   	   				  byval isarray as integer ) as integer

'':::::
private function hElmInit _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval isarray as integer _
	) as integer

    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr oldsym

    function = FALSE

    '' set the context symbol to allow taking the address of overloaded
    '' procs and also to allow anonymous UDT's
    oldsym = env.ctxsym
    env.ctxsym = symbGetSubType( sym )

	if( cExpression( expr ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until ',' and create a fake expression
			hSkipUntil( CHAR_COMMA )
			expr = astNewCONSTz( symbGetType( sym ) )
		end if
	end if

	env.ctxsym = oldsym

    ''
    static as ASTNODE lside

    astBuildVAR( @lside, NULL, 0, symbGetType( sym ), symbGetSubtype( sym ) )

    '' don't build a FIELD node if it's an UDTElm symbol,
    '' that doesn't matter with checkASSIGN

    if( astCheckASSIGN( @lside, expr ) = FALSE ) then
		if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
        	exit function
        else
        	'' error recovery: create a fake expression
        	astDelTree( expr )
        	expr = astNewCONSTz( symbGetType( sym ) )
        end if
	end if

	''
	astTypeIniAddExpr( tree, expr, sym, astTypeIniGetOfs( tree ) )

	astTypeIniGetOfs( tree ) += symbGetLen( sym )

	function = TRUE

end function

'':::::
private function hArrayInit _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval isarray as integer _
	) as integer

    dim as integer dimensions, dimcnt, elements, elm_cnt
    dim as integer isopen, lgt, pad_lgt
    dim as FBVARDIM ptr d, ld

	function = FALSE

	dimensions = symbGetArrayDimensions( sym )
    dimcnt = 0

	if( isarray ) then
		d = symbGetArrayFirstDim( sym )
	else
		d = NULL
	end if

	lgt = 0

	'' for each array dimension..
	do
		'' '{'?
		isopen = FALSE
		if( isarray ) then
			if( hMatch( CHAR_LBRACE ) ) then
				dimcnt += 1
				if( dimcnt > dimensions ) then
					if( errReport( FB_ERRMSG_TOOMANYEXPRESSIONS ) = FALSE ) then
						exit function
					else
						'' error recovery: skip until next '}'
						hSkipUntil( CHAR_RBRACE, TRUE )
						d = NULL
					end if

				else
					ld = d
					d = d->next
				end if

				isopen = TRUE
			end if
		end if

		if( d <> NULL ) then
			elements = (d->upper - d->lower) + 1
		else
			elements = 1
		end if

		'' for each array element..
		elm_cnt = 0
		do
			if( symbGetType( sym ) <> FB_DATATYPE_USERDEF ) then
				if( hElmInit( tree, sym, isarray ) = FALSE ) then
					exit function
				end if

			else
				if( hUDTInit( tree, sym, isarray ) = FALSE ) then
					exit function
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
			astTypeIniAddPad( tree, (elements - elm_cnt) * symbGetLen( sym ) )
		end if
		lgt += elements * symbGetLen( sym )

		if( isopen = FALSE ) then
			exit do
		end if

		if( isarray ) then
			'' '}'?
			if( hMatch( CHAR_RBRACE ) = FALSE ) then
				if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
					exit function
				else
					'' error recovery: skip until next '}'
					hSkipUntil( CHAR_RBRACE, TRUE )
				end if
			end if

			dimcnt -= 1
			d = ld
		end if

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	'' pad
	pad_lgt = (symbGetLen( sym ) * symbGetArrayElements( sym )) - lgt
	if( pad_lgt > 0 ) then
		astTypeIniAddPad( tree, pad_lgt )
		astTypeIniGetOfs( tree ) += pad_lgt
	end if

	function = TRUE

end function

'':::::
private function hUDTInit _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval isarray as integer _
	) as integer

	dim as integer elements, elm_cnt, elm_ofs, lgt, baseofs, pad_lgt
    dim as FBSYMBOL ptr elm, udt

    function = FALSE

	'' '('
	if( hMatch( CHAR_LPRNT ) = FALSE ) then
		'' it can be a function returning an UDT or another UDT
		'' variable for non-static symbols..
		return hElmInit( tree, sym, isarray )
	end if

	udt = symbGetSubtype( sym )
	elm = symbGetUDTFirstElm( udt )

	elements = symbGetUDTElements( udt )
	elm_cnt = 0

	lgt = 0
	baseofs = astTypeIniGetOfs( tree )

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

		'' '{'?
		isarray = hMatch( CHAR_LBRACE )

		elm_ofs = elm->ofs
		if( lgt > 0 ) then
			pad_lgt = elm_ofs - lgt
			if( pad_lgt > 0 ) then
				astTypeIniAddPad( tree, pad_lgt )
				lgt += pad_lgt
			end if
		end if

		astTypeIniGetOfs( tree ) = baseofs + elm_ofs

        if( hArrayInit( tree, elm, isarray ) = FALSE ) then
          	exit function
        end if

        lgt += symbGetLen( elm ) * symbGetArrayElements( elm )

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
		end if

		'' next
		elm = symbGetUDTNextElm( elm )

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

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
	pad_lgt = symbGetLen( sym ) - lgt
	if( pad_lgt > 0 ) then
		astTypeIniAddPad( tree, pad_lgt )
	end if

	astTypeIniGetOfs( tree ) = baseofs + symbGetLen( sym )

	function = TRUE

end function

'':::::
function cVariableInit _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isinitializer as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr tree
    dim as integer isarray

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

	'' '{'?
	isarray = hMatch( CHAR_LBRACE )

	tree = astTypeIniBegin( symbGetType( sym ), symbGetSubtype( sym ) )

	if( hArrayInit( tree, sym, isarray ) = FALSE ) then
		exit function
	end if

	astTypeIniEnd( tree, isinitializer )

    if( isarray ) then
		'' '}'
		if( hMatch( CHAR_RBRACE ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until new '}'
				hSkipUntil( CHAR_RBRACE, TRUE )
			end if
		end if
	end if

	''
	if( symbIsVar( sym ) ) then
		symbSetIsInitialized( sym )
	end if

	''
	function = tree

end function


