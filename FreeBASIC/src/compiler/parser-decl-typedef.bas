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


'' typedef (TYPE foo AS bar) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
'' Typedef		= TYPE ((symbol AS DataType (',')?)+
''					   AS DataType (symbol (',')?)+
''
function cTypedefDecl _
	( _
		byval pid as zstring ptr _				'' can be changed if not a NULL
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id, tname, tname_uc
    dim as zstring ptr ptname
    dim as integer dtype, lgt, ptrcnt, isfwd, ismult
    dim as FBSYMBOL ptr parent, subtype

    function = FALSE

    ismult = (pid = NULL)

    if( ismult ) then
    	isfwd = (cSymbolType( dtype, subtype, lgt, ptrcnt, FB_SYMBTYPEOPT_NONE ) = NULL)
    	if( isfwd ) then
    		if( errGetLast( ) <> FB_ERRMSG_OK ) then
    			exit function
    		end if

			tname = *lexGetText( )
			lexSkipToken( )
    		ptname = @tname

			if( ptrcnt = 0 ) then
				'' (PTR|POINTER)*
				do
					select case lexGetToken( )
					case FB_TK_PTR, FB_TK_POINTER
						lexSkipToken( )
						dtype += FB_DATATYPE_POINTER
						ptrcnt += 1
					case else
						exit do
					end select
				loop
			end if
    	end if
    end if

    do
		if( ismult = FALSE ) then
    		isfwd = (cSymbolType( dtype, subtype, lgt, ptrcnt, FB_SYMBTYPEOPT_NONE ) = NULL)
    		if( isfwd ) then
    			if( errGetLast( ) <> FB_ERRMSG_OK ) then
    				exit function
    			end if
    			tname = *lexGetText( )
    			ptname = @tname
    		end if

    	else
			'' don't allow explicit namespaces
			parent = cParentId( )
    		if( parent <> NULL ) then
				if( hDeclCheckParent( parent ) = FALSE ) then
					exit function
    			end if
    		else
    			if( errGetLast( ) <> FB_ERRMSG_OK ) then
    				exit function
    			end if
    		end if

    		select case as const lexGetClass( )
    		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

				if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
					'' if inside a namespace, symbols can't contain periods (.)'s
					if( symbIsGlobalNamespc( ) = FALSE ) then
  						if( lexGetPeriodPos( ) > 0 ) then
  							if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
	  							exit function
							end if
						end if
					end if
				end if

				id = *lexGetText( )
				lexSkipToken( )

    		case else
    			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: fake an id
    				id = *hMakeTmpStr( )
    			end if
		    end select

			pid = @id
    	end if

    	if( isfwd ) then
    		'' pointing to itself? then it's a void..
   			hUcase( ptname, @tname_uc )
			hUcase( pid, pid )
    		if( tname_uc = *pid ) then
    			dtype = FB_DATATYPE_VOID
    			subtype = NULL
    			lgt = 0

    		'' else, create a forward reference (or lookup one)
    		else
    			dtype = FB_DATATYPE_FWDREF
    			subtype = symbAddFwdRef( ptname )
				lgt = -1
				if( subtype = NULL ) then
					subtype = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
														ptname, _
														FB_SYMBCLASS_FWDREF )
					if( subtype = NULL ) then
						if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
							exit function
						else
							'' error recovery: fake a symbol
							subtype = symbAddFwdRef( hMakeTmpStr( ) )
						end if
					end if
				end if
    		end if

			if( ismult = FALSE ) then
    			lexSkipToken( )

				if( ptrcnt = 0 ) then
					'' (PTR|POINTER)*
					do
						select case lexGetToken( )
						case FB_TK_PTR, FB_TK_POINTER
							lexSkipToken( )
							dtype += FB_DATATYPE_POINTER
							ptrcnt += 1
						case else
							exit do
						end select
					loop
				end if

			else
				dtype += ptrcnt * FB_DATATYPE_POINTER
			end if
    	end if

        ''
    	if( symbAddTypedef( pid, dtype, subtype, ptrcnt, lgt ) = NULL ) then

			'' check if the dup definition is different
			dim as integer isdup
			isdup = TRUE

			dim as FBSYMBOL ptr sym
			sym = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
											pid, FB_SYMBCLASS_TYPEDEF )

			if( sym <> NULL ) then
				if( symbGetType( sym ) = dtype ) then
					if( symbGetSubType( sym ) = subtype ) then
						isdup = FALSE
					end if
				end if
			end if

			if( isdup ) then
				if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
					exit function
				end if
			end if
    	end if

    	'' ','?
    	if( lexGetToken( ) <> CHAR_COMMA ) then
    		exit do
    	end if

    	lexSkipToken( )
    loop

	function = TRUE

end function

