''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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
private function hPtrDecl _
	( _
		byval dtype as FB_DATATYPE _
	) as FB_DATATYPE

	dim as integer ptr_cnt = 0

	'' (CONST (PTR|POINTER) | (PTR|POINTER))*
	do
		select case as const lexGetToken( )
		'' CONST PTR?
		case FB_TK_CONST
			lexSkipToken( )

			select case lexGetToken( )
			case FB_TK_PTR, FB_TK_POINTER
				if( ptr_cnt >= FB_DT_PTRLEVELS ) then
					if( errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS ) = FALSE ) then
						return FB_DATATYPE_INVALID
					end if
				else
					dtype = typeSetIsConst( typeAddrOf( dtype ) )
					ptr_cnt += 1
				end if

				lexSkipToken( )

			case else
				if( errReport( FB_ERRMSG_EXPECTEDPTRORPOINTER ) = FALSE ) then
					return FB_DATATYPE_INVALID
				end if

				exit do
			end select

		'' PTR|POINTER?
		case FB_TK_PTR, FB_TK_POINTER
			if( ptr_cnt >= FB_DT_PTRLEVELS ) then
				if( errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS ) = FALSE ) then
					return FB_DATATYPE_INVALID
				end if
			else
				dtype = typeAddrOf( dtype )
				ptr_cnt += 1
			end if

			lexSkipToken( )

		case else
			exit do
		end select
	loop

	function = dtype

end function

'':::::
'' Typedef		= TYPE ((symbol AS DataType (',')?)+
''					   AS DataType (symbol (',')?)+
''
function cTypedefDecl _
	( _
		byval pid as zstring ptr _				'' note: it can be Ucase()'d if not NULL
	) as integer

    static as zstring * FB_MAXNAMELEN+1 id, tname
    dim as zstring ptr ptname = any
    dim as integer dtype = any, lgt = any, isfwd = any, ismult = any
    dim as FBSYMBOL ptr parent = any, subtype = any

    function = FALSE

    ismult = (pid = NULL)

    if( ismult ) then
    	isfwd = (cSymbolType( dtype, subtype, lgt, FB_SYMBTYPEOPT_NONE ) = FALSE)
    	if( isfwd ) then
    		if( errGetLast( ) <> FB_ERRMSG_OK ) then
    			exit function
    		end if

			tname = *lexGetText( )
			lexSkipToken( )
    		ptname = @tname

			if( typeGetPtrCnt( dtype ) = 0 ) then
				dtype = hPtrDecl( dtype )
				if( dtype = FB_DATATYPE_INVALID ) then
					exit function
				end if
			end if
    	end if
    end if

    do
		if( ismult = FALSE ) then
    		isfwd = (cSymbolType( dtype, subtype, lgt, FB_SYMBTYPEOPT_NONE ) = FALSE)
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
    		dim as integer ptrcnt = typeGetPtrCnt( dtype )

    		'' pointing to itself? then it's a void..
   			hUcase( ptname, ptname )
			hUcase( pid, pid )
    		if( *ptname = *pid ) then
    			dtype = typeJoin( dtype, FB_DATATYPE_VOID )
    			subtype = NULL
    			lgt = 0

    		'' else, create a forward reference (or lookup one)
    		else
    			dtype = typeJoin( dtype, FB_DATATYPE_FWDREF )
    			subtype = symbAddFwdRef( ptname )
				lgt = -1
				if( subtype = NULL ) then
					subtype = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
														ptname, _
														FB_SYMBCLASS_FWDREF, _
														TRUE, _
														FALSE )
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
					dtype = hPtrDecl( dtype )
					if( dtype = FB_DATATYPE_INVALID ) then
						exit function
					end if
				end if

			else
				dtype = typeMultAddrOf( dtype, ptrcnt )
			end if
    	end if

        ''
    	if( symbAddTypedef( pid, dtype, subtype, lgt ) = NULL ) then

			'' check if the dup definition is different
			dim as integer isdup = TRUE

			dim as FBSYMBOL ptr sym = any

			sym = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
											pid, _
											FB_SYMBCLASS_TYPEDEF, _
											FALSE, _
											FALSE )

			if( sym <> NULL ) then
				if( symbGetFullType( sym ) = dtype ) then
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

