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


'' parser part 8 - pre-processor
''
'' chng: dec/2004 written [v1ctor]

option explicit

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'

declare function cPreProcessIF 				( ) as integer

declare function cPPLogExpression			( logexpr as integer ) as integer
declare function cPPRelExpression			( relexpr as integer, rellit as string ) as integer
declare function cPPParentExpr				( parexpr as integer, atom as string ) as integer


'' globals
	dim shared iflevel as integer


'':::::
function hLiteral as string
    dim text as string

    text = ""
    do
    	select case lexCurrentToken
		case FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
			exit do
		end select

    	text = text + lexEatToken
    loop

	hLiteral = text

end function

'':::::
'' PreProcess    =   '#'DEFINE ID LITERAL+
''               |   '#'UNDEF ID
''               |   '#'IFDEF ID
''               |   '#'IFNDEF ID
''               |   '#'IF Expression
''				 |	 '#'ELSE
''               |   '#'ENDIF
''               |   '#'PRINT LITERAL* .
''
function cPreProcess
	dim id as string

	cPreProcess = FALSE

	'' '#'
	if( not hMatch( CHAR_SHARP ) ) then
		exit function
	end if

    select case lexCurrentToken

    '' DEFINE ID LITERAL+
    case FB.TK.DEFINE
    	lexSkipToken , FALSE

    	'' ID
    	if( symbLookupDefine( lexTokenText ) <> INVALID ) then
    		hReportError FB.ERRMSG.DUPDEFINITION
    		exit function
    	else
    		id = lexEatToken
    	end if

    	'' LITERAL+
    	symbAddDefine( id, hLiteral )


	'' UNDEF ID
    case FB.TK.UNDEF
    	lexSkipToken , FALSE

    	if( not symbDelDefine( lexTokenText ) ) then
    		hReportError FB.ERRMSG.VARIABLENOTDECLARED
    		exit function
    	else
    		lexSkipToken
    	end if


	'' IFDEF ID
	'' IFNDEF ID
	'' IF ID '=' LITERAL
    case FB.TK.IFDEF, FB.TK.IFNDEF, FB.TK.IF

    	cPreProcess = cPreProcessIF
    	exit function


	'' ELSE
	'' ENDIF
	case FB.TK.ELSE, FB.TK.ENDIF
		if( iflevel = 0 ) then
            hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
			exit function
		end if

		'' cPreProcessIF will take care

	'' PRINT LITERAL*
	case FB.TK.PRINT
		lexSkipToken

		print hLiteral

	case else
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end select


	cPreProcess = TRUE

end function

'':::::
function cPreProcessIF as integer
    dim istrue as integer, elsecnt as integer, level as integer
    dim res as integer

    cPreProcessIF = FALSE

	istrue = FALSE

	select case lexCurrentToken
	'' IFDEF ID
	case FB.TK.IFDEF
        lexSkipToken , FALSE

		if( symbLookupDefine( lexEatToken ) <> INVALID ) then
			istrue = TRUE
		end if

	'' IFNDEF ID
	case FB.TK.IFNDEF
        lexSkipToken , FALSE

		if( symbLookupDefine( lexEatToken ) = INVALID ) then
			istrue = TRUE
		end if

	'' IF Expression
	case FB.TK.IF
        lexSkipToken

		if( not cPPLogExpression( istrue ) ) then
			exit function
		end if

	end select

	'' Comment?
	res = cComment

	'' separator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	iflevel = iflevel + 1
	level = iflevel
	elsecnt = 0

	do
		'' loop body
		if( istrue ) then
			do
				res = cLine
			loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

		'' skip lines until a #ENDIF or #ELSE at same level is found
		else
        	do
        		select case lexCurrentToken
        		case CHAR_SHARP
        			lexSkipToken

        			select case lexCurrentToken
        			case FB.TK.IF, FB.TK.IFDEF, FB.TK.IFNDEF
        				iflevel = iflevel + 1

        			case FB.TK.ELSE
        				if( iflevel = level ) then
        					exit do
						elseif( iflevel = 0 ) then
            				hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
							exit function
        				end if

        			case FB.TK.ENDIF
        				if( iflevel = level ) then
        					exit do
						elseif( iflevel = 0 ) then
	            			hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
							exit function
						else
        					iflevel = iflevel - 1
        				end if
        			end select

        		case FB.TK.EOF
        			exit do
        		end select

				lexSkipLine
				if( lexCurrentToken = FB.TK.EOL ) then
					lexSkipToken
				end if
        	loop

		end if

    	'' ELSE?
    	if( not hMatch( FB.TK.ELSE ) ) then
    		exit do
    	end if

        if( elsecnt > 0 ) then
	       	hReportError FB.ERRMSG.SYNTAXERROR
    	   	exit function
        else
        	elsecnt = elsecnt + 1
        end if

        istrue = not istrue

    loop

    '' ENDIF
	if( not hMatch( FB.TK.ENDIF ) ) then
		hReportError FB.ERRMSG.EXPECTEDENDIF
		exit function
	end if

	iflevel = iflevel - 1

	cPreProcessIF = TRUE

end function

'':::::
''LogExpression      =   NOT? RelExpression ( (AND | OR) NOT? RelExpression )* .
''
function cPPLogExpression( logexpr as integer )
    dim donot as integer, op as integer
    dim loglit as string
    dim relexpr as integer, rellit as string

    logexpr = FALSE

    '' NOT?
    donot = FALSE
    if( hMatch( FB.TK.NOT ) ) then
    	donot = TRUE
    end if

    '' RelExpression
    if( not cPPRelExpression( logexpr, loglit ) ) then
    	cPPLogExpression = FALSE
    	exit function
    end if

    '' exec not
    if( donot ) then
    	logexpr = not logexpr
    end if

	cPPLogExpression = TRUE

    '' ( ... )*
    do
    	'' Logical operator
    	op = lexCurrentToken
    	select case op
    	case FB.TK.AND, FB.TK.OR
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' NOT?
    	donot = FALSE
    	if( hMatch( FB.TK.NOT ) ) then
    		donot = TRUE
    	end if

    	'' RelExpression
    	if( not cPPRelExpression( relexpr, rellit ) ) then
    		cPPLogExpression = FALSE
    		exit function
    	end if

    	'' exec not
    	if( donot ) then
    		relexpr = not relexpr
    	end if

    	'' do operation
    	select case op
    	case FB.TK.AND
    		logexpr = logexpr and relexpr
    	case FB.TK.OR
    		logexpr = logexpr or relexpr
    	end select
    loop

end function

'':::::
''RelExpression   =   ParentExpr ( (EQ | GT | LT | NE | LE | GE) ParentExpr )* .
''
function cPPRelExpression( relexpr as integer, rellit as string )
    dim op as integer, ops as integer
    dim parexpr as integer, parlit as string

   	cPPRelExpression = FALSE

    '' Atom
    if( not cPPParentExpr( relexpr, rellit ) ) then
    	exit function
    end if

    '' ( ... )*
    ops = 0
    do
    	'' Relational operator
    	op = lexCurrentToken
    	select case op
    	case FB.TK.EQ, FB.TK.GT, FB.TK.LT, FB.TK.NE, FB.TK.LE, FB.TK.GE
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' Atom
    	if( not cPPParentExpr( parexpr, parlit ) ) then
    		exit function
    	end if

   		'' both literals?
   		if( relexpr <= 0 or parexpr <= 0 ) then
   			hReportError FB.ERRMSG.SYNTAXERROR
   			exit function
   		end if

   		'' do operation
   		select case op
   		case FB.TK.EQ
   			relexpr = rellit = parlit
   		case FB.TK.GT
   			relexpr = rellit > parlit
   		case FB.TK.LT
   			relexpr = rellit < parlit
   		case FB.TK.NE
   			relexpr = rellit <> parlit
   		case FB.TK.LE
   			relexpr = rellit <= parlit
   		case FB.TK.GE
   			relexpr = rellit >= parlit
   		end select

   		ops = ops + 1
    loop

    ''
    if( (ops = 0) and (relexpr > 0) ) then
    	relexpr = TRUE
    end if

    cPPRelExpression = TRUE

end function

'':::::
'' ParentExpr  =   '(' Expression ')'
''			   |   DEFINED'(' ID ')'
''             |   LITERAL .
function cPPParentExpr( parexpr as integer, atom as string ) as integer
    dim res as integer

  	cPPParentExpr = FALSE
  	res = FALSE

  	atom = ""

  	'' '(' Expression ')'
  	if( hMatch( CHAR_LPRNT ) ) then
  		res = cPPLogExpression( parexpr )
  		if( not res ) then
  			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
  			exit function
  		end if

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError FB.ERRMSG.EXPECTEDRPRNT
  			exit function
  		end if

  	'' DEFINED'(' ID ')'
  	elseif( hMatch( FB.TK.DEFINED ) ) then

    	if( lexCurrentToken <> CHAR_LPRNT ) then
    		hReportError FB.ERRMSG.EXPECTEDLPRNT
    		exit function
    	else
    		lexSkipToken , FALSE
    	end if

		if( symbLookupDefine( lexEatToken ) <> INVALID ) then
			parexpr = TRUE
		else
			parexpr = FALSE
		end if

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError FB.ERRMSG.EXPECTEDRPRNT
  			exit function
  		end if

  		res = TRUE

  	'' LITERAL
  	else
  		atom = lexEatToken
  		parexpr = len( atom )
  		if( parexpr = 0 ) then
  			res = FALSE
  		else
  			res = TRUE
  		end if
  	end if

	cPPParentExpr = res

end function
