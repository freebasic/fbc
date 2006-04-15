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


'' symbol table module for constants
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"

'':::::
function symbAddConst( byval symbol as zstring ptr, _
					   byval typ as integer, _
					   byval subtype as FBSYMBOL ptr, _
					   byval value as FBVALUE ptr _
					 ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr c
    dim as FBSYMBOLTB ptr symtb
    dim as integer isglobal

    function = NULL

    isglobal = TRUE
    '' enum?
    if( typ = FB_DATATYPE_ENUM ) then
    	symtb = @subtype->enum.elmtb

    else
    	'' if parsing main, all consts must go to the global table
    	if( fbIsModLevel( ) ) then
    		'' unless it's inside a scope block..
    		if( env.scope > FB_MAINSCOPE ) then
    			symtb = symb.loctb
    			isglobal = FALSE

    		else
    			symtb = @symb.globtb
    		end if

    	else
    		symtb = symb.loctb
    		isglobal = FALSE
    	end if
    end if

    c = symbNewSymbol( NULL, symtb, isglobal, FB_SYMBCLASS_CONST, _
    				   TRUE, symbol, NULL, typ, subtype )
	if( c = NULL ) then
		exit function
	end if

	c->con.val = *value

	function = c

end function

'':::::
function symbAllocFloatConst( byval value as double, _
						   	  byval typ as integer _
						 	) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 cname, aname
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
	dim as string svalue

	function = NULL

	'' can't use STR() because GAS doesn't support the 1.#INF notation
	svalue = hFloatToStr( value, typ )

	cname = "{fbnc}"
	cname += svalue

	s = symbFindByNameAndSuffix( @cname, typ, FALSE )
	if( s <> NULL ) then
		return s
	end if

	aname = *hMakeTmpStr( FALSE )

	'' it must be declare as SHARED, because even if currently inside an
	'' proc, the global symbol tb should be used, so just one constant
	'' will be ever allocated over the module
	s = symbAddVarEx( @cname, @aname, typ, NULL, 0, 0, 0, dTB(), _
					  FB_SYMBATTRIB_SHARED, TRUE, FALSE, FALSE )

	''
	symbSetIsLiteral( s )

	s->var.littext = ZstrAllocate( len( svalue ) )
	*s->var.littext = svalue

	function = s

end function

'':::::
function symbAllocStrConst( byval sname as zstring ptr, _
							byval lgt as integer _
						  ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 cname, aname
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
	dim as integer strlen

	function = NULL

	'' the lgt passed isn't the real one because it doesn't
	'' take into acount the escape characters
	strlen = len( *sname )
	if( lgt < 0 ) then
		lgt = strlen
	end if

	if( strlen <= FB_MAXNAMELEN-6 ) then
		cname = "{fbsc}"
		cname += *sname
	else
		cname = *hMakeTmpStr( FALSE )
	end if

	''
	s = symbFindByNameAndClass( @cname, FB_SYMBCLASS_VAR, TRUE )
	if( s <> NULL ) then
		return s
	end if

	aname = *hMakeTmpStr( FALSE )

	'' lgt += the null-char (rtlib wrappers will take it into account)

	'' it must be declare as SHARED, see symbAllocFloatConst()
	s = symbAddVarEx( @cname, @aname, FB_DATATYPE_CHAR, NULL, _
					  0, lgt + 1, 0, dTB(), _
					  FB_SYMBATTRIB_SHARED, FALSE, TRUE, FALSE )

	''
	symbSetIsLiteral( s )

	s->var.littext = ZstrAllocate( strlen )
	*s->var.littext = *sname

	function = s

end function

'':::::
function symbAllocWStrConst( byval sname as wstring ptr, _
						  	 byval lgt as integer _
						   ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 cname, aname
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
	dim as integer strlen

	function = NULL

	'' the lgt passed isn't the real one because it doesn't
	'' take into acount the escape characters
	strlen = len( *sname )
	if( lgt < 0 ) then
		lgt = strlen
	end if

	'' hEscapeWstr() can use up to 4 chars p/ unicode char (\ooo)
	if( strlen * (3+1) <= FB_MAXNAMELEN-6 ) then
		cname = "{fbwc}"
		cname += *hEscapeWstr( sname )
	else
		cname = *hMakeTmpStr( FALSE )
	end if

	''
	s = symbFindByNameAndClass( @cname, FB_SYMBCLASS_VAR, TRUE )
	if( s <> NULL ) then
		return s
	end if

	aname = *hMakeTmpStr( FALSE )

	'' lgt = (lgt + null-char) * sizeof( wstring ) (see parser-decl-symbinit.bas)
	'' it must be declare as SHARED, see symbAllocFloatConst()
	s = symbAddVarEx( @cname, @aname, FB_DATATYPE_WCHAR, NULL, _
					  0, (lgt+1) * len( wstring ), 0, dTB(), _
					  FB_SYMBATTRIB_SHARED, FALSE, TRUE, FALSE )

	''
	symbSetIsLiteral( s )

	s->var.littextw = WstrAllocate( strlen )
	*s->var.littextw = *sname

	function = s

end function

'':::::
sub symbDelConst( byval s as FBSYMBOL ptr, _
				  byval dolookup as integer )

    if( dolookup ) then
    	s = symbFindByClass( s, FB_SYMBCLASS_CONST )
    end if

    if( s = NULL ) then
    	exit sub
    end if

    '' if it's a string, the symbol attached will be deleted be delVar()

	symbFreeSymbol( s )

end sub

'':::::
function symbGetConstValueAsStr( byval s as FBSYMBOL ptr ) as string

  	select case as const symbGetType( s )
  	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
  		function = *symbGetConstValStr( s )->var.littext

  	case FB_DATATYPE_LONGINT
  		function = str( symbGetConstValLong( s ) )

  	case FB_DATATYPE_ULONGINT
  	    function = str( cunsg( symbGetConstValLong( s ) ) )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = str( symbGetConstValFloat( s ) )

  	case FB_DATATYPE_UBYTE, FB_DATATYPE_USHORT, FB_DATATYPE_UINT
  		function = str( cunsg( symbGetConstValInt( s ) ) )

  	case else
  		function = str( symbGetConstValInt( s ) )
  	end select

end function

