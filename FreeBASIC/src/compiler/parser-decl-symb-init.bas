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

declare function 	cSymbUDTInit			( byval basesym as FBSYMBOL ptr, _
											  byval sym as FBSYMBOL ptr, _
											  byref ofs as integer, _
					   						  byval islocal as integer ) as integer


'':::::
function cSymbElmInit( byval basesym as FBSYMBOL ptr, _
					   byval sym as FBSYMBOL ptr, _
					   byref ofs as integer, _
					   byval islocal as integer ) as integer static

	dim as integer dtype
	dim as ASTNODE ptr expr, assgexpr
    dim as FBSYMBOL ptr litsym

    '' set the context symbol to allow taking the address of overloaded procs
    if( symbGetType( sym ) >= IR_DATATYPE_POINTER+IR_DATATYPE_FUNCTION ) then
    	env.ctxsym = symbGetSubType( sym )
    end if

	if( not cExpression( expr ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		return 0
	end if

	env.ctxsym = NULL

    dtype = astGetDataType( expr )

	'' if static or at module level, only constants can be used as initializers
	if( not islocal ) then

		'' check if it's a literal string
		litsym = NULL
		select case dtype
		case IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR
			litsym = astGetStrLitSymbol( expr )
		end select

		'' not a literal string?
		if( litsym = NULL ) then

			'' string?
			if( hIsString( symbGetType( sym ) ) ) then
				if( hIsString( dtype ) ) then
					hReportError( FB_ERRMSG_EXPECTEDCONST )
				else
					hReportError( FB_ERRMSG_INVALIDDATATYPES )
				end if
				return 0

			elseif( hIsString( dtype ) ) then
			    hReportError( FB_ERRMSG_INVALIDDATATYPES )
				return 0
			end if

			'' offset?
			if( astIsOFFSET( expr ) ) then

				'' different types?
				if( (irGetDataClass( symbGetType( sym ) ) <> IR_DATACLASS_INTEGER) or _
					(irGetDataSize( symbGetType( sym ) ) <> FB_POINTERSIZE) ) then
					hReportError( FB_ERRMSG_INVALIDDATATYPES )
					return 0
				end if

				irEmitVARINIOFS( astGetSymbol( expr ) )

			else
				'' not a constant?
				if( not astIsCONST( expr ) ) then
					hReportError( FB_ERRMSG_EXPECTEDCONST )
					return 0
				end if

				'' different types?
				if( dtype <> symbGetType( sym ) ) then
					expr = astNewCONV( INVALID, _
									   symbGetType( sym ), _
									   symbGetSubtype( sym ), _
									   expr )
				end if

				select case as const symbGetType( sym )
				case FB_SYMBTYPE_LONGINT, FB_SYMBTYPE_ULONGINT
					irEmitVARINI64( symbGetType( sym ), astGetValLong( expr ) )
				case FB_SYMBTYPE_SINGLE, FB_SYMBTYPE_DOUBLE
					irEmitVARINIf( symbGetType( sym ), astGetValFloat( expr ) )
				case else
					irEmitVARINIi( symbGetType( sym ), astGetValInt( expr ) )
				end select

			end if

		else

			'' not a string?
			if( not hIsString( symbGetType( sym ) ) ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				return 0
			end if

			'' can't be a variable-len string
			if( symbGetType( sym ) = FB_SYMBTYPE_STRING ) then
				hReportError( FB_ERRMSG_CANTINITDYNAMICSTRINGS )
				return 0
			end if

			'' not a wstring?
			if( symbGetType( sym ) <> FB_SYMBTYPE_WCHAR ) then

				'' convert?
				if( dtype <> IR_DATATYPE_WCHAR ) then
					'' less the null-char
					irEmitVARINISTR( symbGetStrLen( sym ) - 1, _
							 	 	 symbGetVarText( litsym ), _
							 	 	 symbGetStrLen( litsym ) - 1 )
				else
					'' ditto
					irEmitVARINISTR( symbGetStrLen( sym ) - 1, _
							 	 	 str( *symbGetVarTextW( litsym ) ), _
							 	 	 symbGetWstrLen( litsym ) - 1 )
				end if


			'' wstring..
			else

				'' convert?
				if( dtype <> IR_DATATYPE_WCHAR ) then
					'' less the null-char
					irEmitVARINIWSTR( symbGetWstrLen( sym ) - 1, _
							 	  	  wstr( symbGetVarText( litsym ) ), _
							 	  	  symbGetStrLen( litsym ) - 1 )
				else
					'' ditto
					irEmitVARINIWSTR( symbGetWstrLen( sym ) - 1, _
							 	  	  symbGetVarTextW( litsym ), _
							 	  	  symbGetWstrLen( litsym ) - 1 )
				end if

			end if

		end if

		astDel( expr )

	else

        assgexpr = astNewVAR( basesym, ofs, symbGetType( sym ), symbGetSubtype( sym ) )

        assgexpr = astNewASSIGN( assgexpr, expr )

        if( assgexpr = NULL ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
            return FALSE
        end if

        astAdd( assgexpr )

	end if

	ofs += symbGetLen( sym )

	function = symbGetLen( sym )

end function

'':::::
function cSymbArrayInit( byval basesym as FBSYMBOL ptr, _
						 byval sym as FBSYMBOL ptr, _
					     byref ofs as integer, _
					     byval islocal as integer, _
					     byval isarray as integer ) as integer

    dim as integer dimensions, dimcnt, elements, elmcnt
    dim as integer isopen, lgt, pad
    dim as FBVARDIM ptr d, ld

	function = 0

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
					hReportError( FB_ERRMSG_TOOMANYEXPRESSIONS )
					exit function
				end if

				ld = d
				d = d->next

				isopen = TRUE
			end if
		end if

		if( d <> NULL ) then
			elements = (d->upper - d->lower) + 1
		else
			elements = 1
		end if

		'' for each array element..
		elmcnt = 0
		do

			if( symbGetType( sym ) <> FB_SYMBTYPE_USERDEF ) then
				if( cSymbElmInit( basesym, sym, ofs, islocal ) = 0 ) then
					exit function
				end if
			else
				if( cSymbUDTInit( basesym, sym, ofs, islocal ) = 0 ) then
					exit function
				end if
			end if

			elmcnt += 1
			if( elmcnt >= elements ) then
				exit do
			end if

		'' ','
		loop while( hMatch( CHAR_COMMA ) )

		'' pad
		if( not islocal ) then
			if( elmcnt < elements ) then
				irEmitVARINIPAD( (elements - elmcnt) * symbGetLen( sym ) )
			end if
			lgt += elements * symbGetLen( sym )
		else
			lgt += elmcnt * symbGetLen( sym )
		end if

		if( not isopen ) then
			exit do
		end if

		if( isarray ) then
			'' '}'?
			if( not hMatch( CHAR_RBRACE ) ) then
				hReportError( FB_ERRMSG_EXPECTEDRBRACKET )
				exit function
			end if

			dimcnt -= 1
			d = ld
		end if

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	'' pad
	pad = (symbGetLen( sym ) * symbCalcArrayElements( sym )) - lgt
	if( pad > 0 ) then
		if( not islocal ) then
			irEmitVARINIPAD( pad )
		else
			ofs += pad
		end if
	end if

	function = lgt + pad

end function

'':::::
function cSymbUDTInit( byval basesym as FBSYMBOL ptr, _
					   byval sym as FBSYMBOL ptr, _
					   byref ofs as integer, _
					   byval islocal as integer ) as integer

	dim as integer elements, elmcnt, isarray, elmofs, lgt, pad
    dim as FBSYMBOL ptr elm, udt

    function = 0

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError( FB_ERRMSG_EXPECTEDLPRNT )
		exit function
	end if

	udt = symbGetSubtype( sym )
	elm = symbGetUDTFirstElm( udt )

	elements = symbGetUDTElements( udt )
	elmcnt = 0

	lgt = 0

	'' for each UDT element..
	do
		elmcnt += 1
		if( elmcnt > elements ) then
			hReportError( FB_ERRMSG_TOOMANYEXPRESSIONS )
			exit function
		end if

		'' '{'?
		isarray = hMatch( CHAR_LBRACE )

		elmofs = elm->var.elm.ofs
		if( not islocal ) then
			if( lgt > 0 ) then
				pad = elmofs - lgt
				if( pad > 0 ) then
					irEmitVARINIPAD( pad )
					lgt += pad
				end if
			end if
		end if

		elmofs += ofs

        pad = cSymbArrayInit( basesym, elm, elmofs, islocal, isarray )
        if( pad = 0 ) then
          	exit function
        end if

        lgt += pad

        if( isarray ) then
			'' '}'
			if( not hMatch( CHAR_RBRACE ) ) then
				hReportError( FB_ERRMSG_EXPECTEDRBRACKET )
				exit function
			end if
		end if

		'' next
		elm = symbGetUDTNextElm( elm )

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	ofs += symbGetLen( sym )

	'' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
		exit function
	end if

	'' pad
	if( not islocal ) then
		pad = symbGetLen( sym ) - lgt
		if( pad > 0 ) then
			irEmitVARINIPAD( pad )
		end if
	else
		pad = 0
	end if

	function = lgt + pad

end function

'':::::
function cSymbolInit( byval sym as FBSYMBOL ptr ) as integer
    dim as integer islocal, isarray, ofs

	function = FALSE

	'' cannot initialize dynamic vars
	if( symbGetIsDynamic( sym ) ) then
		hReportError( FB_ERRMSG_CANTINITDYNAMICARRAYS, TRUE )
		exit function
	end if

	'' common?? impossible but..
	if( symbIsCommon( sym ) ) then
		hReportError( FB_ERRMSG_CANTINITDYNAMICARRAYS, TRUE )
		exit function
	end if

	'' already emited?? impossible but..
	if( symbGetVarEmited( sym ) ) then
		hReportError( FB_ERRMSG_SYNTAXERROR, TRUE )
		exit function
	end if

	symbSetVarEmited( sym, TRUE )

	islocal = (not symbIsStatic( sym )) and fbIsLocal( )

	''
	if( not islocal ) then
		irEmitVARINIBEGIN( sym )
	end if

	'' '{'?
	isarray = hMatch( CHAR_LBRACE )

	ofs = 0

	if( cSymbArrayInit( sym, sym, ofs, islocal, isarray ) = 0 ) then
		exit function
	end if

    if( isarray ) then
		'' '}'
		if( not hMatch( CHAR_RBRACE ) ) then
			hReportError( FB_ERRMSG_EXPECTEDRBRACKET )
			exit function
		end if
	end if

	''
	if( not islocal ) then
		irEmitVARINIEND( sym )
	end if

	''
	function = TRUE

end function

