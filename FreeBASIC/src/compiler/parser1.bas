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


'' parser part 1 - main parser, including interface and declarations (DECLARE, CONST, etc)
''
'' a deterministic, top-down, linear directional (LL(1)), recursive (no table-driven) descent
'' parser (syntax analyser)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\emit.bi'

declare function cConstExprValue			( littext as string ) as integer

'' globals
	dim shared incfiles as integer			'' can't be on ENV as it is restored on recursion

	redim shared envcopyTB( 0 ) as FBENV
	redim shared incpathTB( 0 ) as string
	redim shared incfileTB( 0 ) as string


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' interface
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

deflibsdata:
data "fb"
#ifdef TARGET_WIN32
data "crtdll"
data "kernel32"
data "user32"
#elseif defined(TARGET_LINUX)
data "c"
data "m"
data "ncurses"
#elseif defined(TARGET_DOS)
data "c"
data "gcc"
#endif
data ""

'':::::
sub fbcAddIncPath( path as string )

	if( env.incpaths < FB.MAXINCPATHS ) then
		incpathTB( env.incpaths ) = path

#ifdef TARGET_WIN32
const PATHDIV = "\\"
#elseif TARGET_DOS
const PATHDIV = "\\"
#else
const PATHDIV = "/"
#endif
		if( right$( path, 1 ) <> PATHDIV ) then
			incpathTB( env.incpaths ) = incpathTB( env.incpaths ) + PATHDIV
		end if

		env.incpaths = env.incpaths + 1
	end if

end sub

'':::::
sub fbcAddDefine( dname as string, dtext as string )

    symbAddDefine( dname, dtext )

end sub

'':::::
function fbcFindIncFile( filename as string ) as integer
	dim i as integer
	dim fname as string

	fbcFindIncFile = FALSE

	fname = ucase$( filename )

	for i = 0 to incfiles-1
		if( incfileTB( i ) = fname ) then
			fbcFindIncFile = TRUE
			exit function
		end if
	next i

end function

'':::::
sub fbcAddIncFile( filename as string )
    dim fname as string

	fname = ucase$( filename )

	if( incfiles < FB.MAXINCFILES ) then
		if( not fbcFindIncFile( fname ) ) then
			incfileTB( incfiles ) = fname
			incfiles = incfiles + 1
		end if
	end if

end sub

'':::::
sub hSetCtx

	env.scope			= 0
	env.reclevel		= 0
	env.currproc 		= NULL

	env.dbglname 		= ""
	env.dbglnum 		= 0
	env.dbgpos 			= 0

	env.optbase			= 0
	env.optargmode		= FB.ARGMODE.BYREF
	env.optexplicit		= FALSE
	env.optprocpublic	= TRUE
	env.optescapestr	= FALSE
	env.optdynamic		= FALSE

	env.compoundcnt 	= 0
	env.lastcompound	= INVALID
	env.isprocstatic	= FALSE
	env.procerrorhnd 	= NULL
	env.withtextidx		= INVALID

	''
	env.forstmt.endlabel	= NULL
	env.forstmt.cmplabel	= NULL
	env.dostmt.endlabel		= NULL
	env.dostmt.cmplabel		= NULL
	env.whilestmt.endlabel	= NULL
	env.whilestmt.cmplabel	= NULL
	env.procstmt.endlabel	= NULL
	env.procstmt.cmplabel	= NULL


	''
	env.incpaths		= 0
	incfiles			= 0

	fbcAddIncPath exepath$ + FB.INCPATH

end sub

'':::::
function fbcInit as integer static

	''
	fbcInit = FALSE

	''
	strpInit

	symbInit

	hlpInit

	astInit

	irInit

	rtlInit

	lexInit

	emitInit

	''
	redim envcopyTB( 0 to FB.MAXINCRECLEVEL-1 ) as FBENV

	redim incpathTB( 0 to FB.MAXINCPATHS-1 ) as string

	redim incfileTB( 0 to FB.MAXINCFILES-1 ) as string

	''
	hSetCtx

	''
	fbcInit = TRUE

end function

'':::::
sub fbcSetDefaultOptions

	env.clopt.debug			= FALSE
	env.clopt.cputype 		= FB.DEFAULTCPUTYPE
	env.clopt.errorcheck	= FALSE
	env.clopt.resumeerr 	= FALSE
	env.clopt.nostdcall 	= FALSE
	env.clopt.outtype		= FB_OUTTYPE_EXECUTABLE
	env.clopt.warninglevel 	= 0

end sub

'':::::
sub fbcSetOption ( byval opt as integer, byval value as integer )

	select case opt
	case FB.COMPOPT.DEBUG
		env.clopt.debug = value
	case FB.COMPOPT.CPUTYPE
		env.clopt.cputype = value
	case FB.COMPOPT.ERRORCHECK
		env.clopt.errorcheck = value
	case FB.COMPOPT.NOSTDCALL
		env.clopt.nostdcall = value
	case FB.COMPOPT.OUTTYPE
		env.clopt.outtype = value
	case FB.COMPOPT.RESUMEERROR
		env.clopt.resumeerr = value
	case FB.COMPOPT.WARNINGLEVEL
		env.clopt.warninglevel = value
	end select

end sub

'':::::
function fbcGetOption ( byval opt as integer ) as integer
    dim res as integer

	res = FALSE

	select case opt
	case FB.COMPOPT.DEBUG
		res = env.clopt.debug
	case FB.COMPOPT.CPUTYPE
		res = env.clopt.cputype
	case FB.COMPOPT.ERRORCHECK
		res = env.clopt.errorcheck
	case FB.COMPOPT.NOSTDCALL
		res = env.clopt.nostdcall
	case FB.COMPOPT.OUTTYPE
		res = env.clopt.outtype
	case FB.COMPOPT.RESUMEERROR
		res = env.clopt.resumeerr
	case FB.COMPOPT.WARNINGLEVEL
		res = env.clopt.warninglevel
	end select

	fbcGetOption = res

end function

'':::::
sub fbcEnd

	''
	erase incpathTB

	erase incfileTB

	erase envcopyTB

	''
	emitEnd

	lexEnd

	rtlEnd

	irEnd

	astEnd

	hlpEnd

	symbEnd

	strpEnd

end sub

'':::::
function fbcCompile ( infname as string, outfname as string )
    dim res as integer, l as FBSYMBOL ptr

	fbcCompile = FALSE

	''
	env.infile	= infname
	env.outfile	= outfname

	'' open source file
	if( not hFileExists( infname ) ) then
		hReportErrorEx FB.ERRMSG.FILENOTFOUND, infname, -1
		exit function
	end if

	env.inf = freefile
	open infname for binary as #env.inf

	''
	if( not emitOpen ) then
		hReportErrorEx FB.ERRMSG.FILEACCESSERROR, infname, -1
		exit function
	end if

	'' parse
	res = cProgram

	irFlush

	'' save
	emitClose

	'' close src
	close #env.inf

	'' check if any label undefined was used
	if( res = TRUE ) then
		l = symbCheckLabels
		if( l <> NULL ) then
			hReportErrorEx FB.ERRMSG.UNDEFINEDLABEL, symbGetLabelName( l ), -1
			res = FALSE
		else
			res = TRUE
		end if
	end if

	fbcCompile = res

end function

'':::::
function fbcListLibs( namelist() as string, byval index as integer ) as integer

	fbcListLibs = symbListLibs( namelist(), index )

end function

'':::::
sub fbcAddDefaultLibs
    dim lname as string

	restore deflibsdata

	do
		read lname
		if( len( lname ) = 0 ) then
			exit do
		end if

		symbAddLib lname
	loop

end sub

''::::
function fbcIncludeFile( filename as string, byval isonce as integer ) as integer
    dim incfile as string
    dim i as integer

	fbcIncludeFile = FALSE

	if( env.reclevel >= FB.MAXINCRECLEVEL ) then
		hReportError FB.ERRMSG.RECLEVELTOODEPTH
		exit function
	end if

	'' open include file
	if( not hFileExists( filename ) ) then

		'' try finding it at the inc paths
		for i = env.incpaths-1 to 0 step -1
			incfile = incpathTB(i) + filename
			if( hFileExists( incfile ) ) then
				exit for
			end if
		next i

	else
		incfile = filename
	end if

	''
	if( not hFileExists( incfile ) ) then
		hReportErrorEx FB.ERRMSG.FILENOTFOUND, "\"" + incfile + "\""

	else

		''
		if( isonce ) then
        	if( fbcFindIncFile( filename ) ) then
        		fbcIncludeFile = TRUE
        		exit function
        	end if
		end if

		''
		fbcAddIncFile filename

		''
		envcopyTB(env.reclevel) = env
		lexSaveCtx env.reclevel
    	env.reclevel	= env.reclevel + 1

		env.infile		= filename

		''
		lexInit

		''
		env.inf = freefile
		open incfile for binary as #env.inf

		'' parse
		fbcIncludeFile = cProgram

		'' close it
		close #env.inf

		''
		lexRestoreCtx env.reclevel-1
		env = envcopyTB(env.reclevel-1)
	end if

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' parser
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function hIsSttSeparatorOrComment( byval token as integer ) as integer static

	select case token
	case FB.TK.STATSEPCHAR, FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
		hIsSttSeparatorOrComment = TRUE
	case else
		hIsSttSeparatorOrComment = FALSE
	end select

end function


'':::::
''Program         =   Line* EOF .
''
function cProgram
    dim res as integer

    do
    	res = cLine
    loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

    if( res ) then
    	if( not hMatch( FB.TK.EOF ) ) then
    		'hReportError FB.ERRMSG.EXPECTEDEOF
    		res = FALSE
    	else
    		res = TRUE
    	end if
    end if

    cProgram = res

end function

'':::::
sub cDebugLineBegin

    if( env.clopt.debug and (env.reclevel = 0) ) then
    	if( env.dbglnum > 0 ) then
    		irFlush
    		env.dbgpos = emitGetPos - env.dbgpos
    		if( env.dbgpos > 0 ) then
    			emitDbgLine env.dbglnum, env.dbglname
    		end if
    	end if
    	irFlush
    	env.dbgpos	 = emitGetPos
    	env.dbglnum  = lexLineNum
    	env.dbglname = hMakeTmpStr
    	emitLABEL env.dbglname, TRUE
    end if

end sub

'':::::
sub cDebugLineEnd

    if( env.clopt.debug and (env.reclevel = 0) ) then
    	if( env.dbglnum > 0 ) then
    		irFlush
     		env.dbgpos = emitGetPos - env.dbgpos
    		if( env.dbgpos > 0 ) then
   				emitDbgLine env.dbglnum, env.dbglname
   			end if
    		env.dbglnum = 0
    	end if
    end if

end sub

'':::::
''Line            =   Label? Statement? Comment? EOL .
''
function cLine
    dim res as integer

	cDebugLineBegin

    res = cLabel
    res = cStatement
    res = cComment

	if( hGetLastError = FB.ERRMSG.OK ) then
		if( not hMatch( FB.TK.EOL ) ) then
			if( lexCurrentToken <> FB.TK.EOF ) then
				hReportError FB.ERRMSG.EXPECTEDEOL
				res = FALSE
			else
				res = TRUE
			end if
		else
			res = TRUE
    	end if
    else
    	res = FALSE
    end if

    if( res = TRUE ) then
    	cDebugLineEnd
    end if

    cLine = res

end function

'':::::
''SimpleLine      =   Label? SimpleStatement? Comment? EOL .
''
function cSimpleLine
    dim res as integer, stmtres as integer

    cDebugLineBegin

    res = cLabel
    stmtres = cSimpleStatement

    res = cComment

	if( hGetLastError = FB.ERRMSG.OK ) then
		if( not hMatch( FB.TK.EOL ) ) then
			if( (stmtres = FALSE) and (lexCurrentToken <> FB.TK.EOF) ) then
				hReportError FB.ERRMSG.EXPECTEDEOL
				res = FALSE
			else
				if( stmtres ) then
					res = FALSE
				else
					res = TRUE
				end if
			end if
		else
			res = TRUE
    	end if
    else
    	res = FALSE
    end if

    if( res = TRUE ) then
    	cDebugLineEnd
    end if

    cSimpleLine = res

end function


'':::::
''Label           =   NUM_LIT
''                |   ID ':' .
''
function cLabel
    dim token as integer, l as FBSYMBOL ptr, lname as string

    cLabel = FALSE

    token = lexCurrentToken

    l = NULL

    '' NUM_LIT
    if( lexCurrentTokenClass = FB.TKCLASS.NUMLITERAL ) then
		l = symbAddLabel( lexTokenText )
		if( l = NULL ) then
			hReportError FB.ERRMSG.DUPDEFINITION
			exit function
		else
			lexSkipToken
		end if

	'' ID
	elseif( token = FB.TK.ID ) then
		'' ':'
		if( lexLookAhead(1) = CHAR_COLON ) then

			'' ambiguity: it could be a proc call followed by a ':' stmt separator..
			if( symbIsProc( lexTokenText ) ) then
				exit function
			end if

			l = symbAddLabel( lexTokenText )
			if( l = NULL ) then
				hReportError FB.ERRMSG.DUPDEFINITION
				exit function
			else
				lexSkipToken
			end if

			'' skip ':'
			lexSkipToken

		end if
    end if

    if( l <> NULL ) then

    	lname = symbGetLabelName( l )
    	irEmitLABEL l, (env.scope = 0)

    	symbSetLastLabel l

    	cLabel = TRUE
    end if

end function

'':::::
''Comment         =   (COMMENT_CHAR | REM) ((DIRECTIVE_CHAR Directive)
''				                              |   (any_char_but_EOL*)) .
''
function cComment
    dim res as integer, token as integer

	res = FALSE

	select case lexCurrentToken
	case FB.TK.COMMENTCHAR, FB.TK.REM
    	lexSkipToken FALSE
    	res = TRUE
    	if( lexCurrentToken( FALSE ) = FB.TK.DIRECTIVECHAR ) then
    		lexSkipToken
    		res = cDirective
    	else
    		lexSkipLine
    	end if
	end select

	cComment = res

end function

'':::::
''Directive       =   INCLUDE ONCE? ':' '\'' STR_LIT '\''
''				  |   DYNAMIC
''				  |   STATIC .
''
function cDirective
    dim res as integer
    dim incfile as string, isonce as integer
    dim token as integer

	res = FALSE

	select case lexCurrentToken
	case FB.TK.DYNAMIC
		lexSkipToken
		env.optdynamic = TRUE
		res = TRUE

	case FB.TK.STATIC
		lexSkipToken
		env.optdynamic = FALSE
		res = TRUE

	case FB.TK.INCLUDE, FB.TK.INCLIB

		token = lexCurrentToken
		lexSkipToken

		'' ONCE?
		isonce = FALSE
		if( ucase$( lexTokenText ) = "ONCE" ) then
			lexSkipToken
			isonce = TRUE
		end if

		'' ':'
		if( not hMatch( CHAR_COLON ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		incfile = ""

		'' "STR_LIT"
		if( lexCurrentTokenClass = FB.TKCLASS.STRLITERAL ) then
			incfile = hUnescapeStr( lexEatToken )

		else
			'' '\''
			if( not hMatch( CHAR_APOST ) ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if

			lexReadLine CHAR_APOST, incfile

			'' '\''
			if( not hMatch( CHAR_APOST ) ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if
		end if

		select case token
		case FB.TK.INCLUDE
			res = fbcIncludeFile( incfile, isonce )
		case FB.TK.INCLIB
			if( symbAddLib( incfile ) <> NULL ) then
				res = TRUE
			else
				res = FALSE
			end if
		end select

	end select

	do until( (lexCurrentToken = FB.TK.EOL) or (lexCurrentToken = FB.TK.EOF) )
		lexSkipToken
	loop

	cDirective = res

end function

'':::::
''Statement       =   (Declaration | ProcCall | CompoundStmt | cProcStatement | QuirkStmt | Assignment)
''                    (STT_SEPARATOR Statement)* .
''
function cStatement
    dim res as integer

	do
        res = cDeclaration
		if( not res ) then
			res = cProcCallOrAssign
			if( not res ) then
				res = cCompoundStmt
				if( not res ) then
					res = cProcStatement
					if( not res ) then
						res = cQuirkStmt
						if( not res ) then
							res = cAsmBlock
							if( not res ) then
								res = cAssignment
							end if
						end if
					end if
				end if
			end if
		end if

		if( not res ) then
			exit do
		end if

		if( lexCurrentToken <> FB.TK.STATSEPCHAR ) then
			exit do
		end if

		lexSkipToken
	loop

	cStatement = res

end function

'':::::
''SimpleStatement =   (ConstDecl | SymbolDecl | ProcCall | CompoundStmt | QuirkStmt | Assignment)
''                    (STT_SEPARATOR SimpleStatement)* .
''
function cSimpleStatement
    dim res as integer

	do
        res = cConstDecl
		if( not res ) then
        	res = cSymbolDecl
			if( not res ) then
				res = cProcCallOrAssign
				if( not res ) then
					res = cCompoundStmt
					if( not res ) then
						res = cQuirkStmt
						if( not res ) then
							res = cAsmBlock
							if( not res ) then
								res = cAssignment
							end if
						end if
					end if
				end if
			end if
		end if

		if( not res ) then
			exit do
		end if

		if( lexCurrentToken <> FB.TK.STATSEPCHAR ) then
			exit do
		end if

		lexSkipToken
	loop

	cSimpleStatement = res

end function

'':::
''SttSeparator    =   (STT_SEPARATOR | EOL)+ .
''
function cSttSeparator
    dim res as integer, token as integer

	res = FALSE

	do
		token = lexCurrentToken
		if( (token <> FB.TK.STATSEPCHAR) and (token <> FB.TK.EOL) ) then
			exit do
		end if
		lexSkipToken
		res = TRUE
	loop

	cSttSeparator = res

end function

'':::::
''Declaration     =   ConstDecl | TypeDecl | SymbolDecl | ProcDecl | DefDecl | OptDecl.
''
function cDeclaration
    dim res as integer

	res = cConstDecl
	if( not res ) then
		res = cProcDecl
		if( not res ) then
			res = cTypeDecl
			if( not res ) then
				res = cEnumDecl
				if( not res ) then
					res = cSymbolDecl
					if( not res ) then
						res = cDefDecl
						if( not res ) then
							res = cOptDecl
						end if
					end if
				end if
			end if
		end if
	end if

	cDeclaration = res

end function

'':::::
''ConstDecl       =   CONST ConstAssign (DECL_SEPARATOR ConstAssign)* .
''
function cConstDecl
    dim res as integer

    res = FALSE

    '' CONST
    if( lexCurrentToken <> FB.TK.CONST ) then
    	cConstDecl = res
    	exit function
    else
    	lexSkipToken
    end if

	do
		'' ConstAssign
		res = cConstAssign
		if( not res ) then
			exit do
		end if

    	'' ','
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if
	loop

	cConstDecl = res

end function

'':::
''ConstAssign     =   ID (AS SymbolType)? ASSIGN (ConstExpression | STR_LITERAL) .
''
function cConstAssign
    dim id as string, typ as integer, subtype as FBSYMBOL ptr, lgt as integer
    dim value as double, text as string, c as integer
    dim expr as integer

	cConstAssign = FALSE

	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	'' ID
	typ = lexTokenType
	id = lexEatToken

	'' (AS SymbolType)?
	if( hMatch( FB.TK.AS ) ) then
		if( typ <> INVALID ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		if( not cSymbolType( typ, subtype, lgt ) ) then
			exit function
		end if
	end if

	'' '='
	if( not hMatch( FB.TK.ASSIGN ) ) then
		hReportError FB.ERRMSG.EXPECTEDEQ
		exit function
	end if

	'' STR_LITERAL
	if( lexCurrentTokenClass = FB.TKCLASS.STRLITERAL ) then

		lgt = lexTokenTextLen
		if( symbAddConst( id, FB.SYMBTYPE.STRING, lexEatToken, lgt ) = NULL ) then
    		hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    		exit function
		end if

	'' ConstExpression
	else
		if( not cExpression( expr ) ) then
			hReportErrorEx FB.ERRMSG.EXPECTEDCONST, id
			exit function
		else
			if( astGetType( expr ) <> AST.NODETYPE.CONST ) then
				hReportErrorEx FB.ERRMSG.EXPECTEDCONST, id
				exit function
			end if
		end if

		'' QB quirks..
		value = astGetValue( expr )
		astDel expr

		if( value - int( value ) <> 0 ) then
			if( typ = INVALID ) then
				typ = FB.SYMBTYPE.DOUBLE
			else
				if( typ = FB.SYMBTYPE.INTEGER ) then
					value = int( value )
				end if
			end if
		else
			if( typ = INVALID ) then typ = hGetDefType( id )
		end if

		text = ltrim$( str$( value ) )

		if( symbAddConst( id, typ, text, 0 ) = NULL ) then
    		hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    		exit function
		end if

    end if

	cConstAssign = TRUE

end function

'':::::
''ElementDecl     =   ID ArrayDecl? AS SymbolType
''
function cElementDecl( id as string, typ as integer, subtype as FBSYMBOL ptr, lgt as integer, _
					   dimensions as integer, dTB() as FBARRAYDIM )
	dim res as integer

	cElementDecl = FALSE

	'' allow keywords as field names
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		if( lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    	end if
    end if

	'' ID
	typ = lexTokenType
	subtype = NULL
	id = lexEatToken

	'' ArrayDecl?
	res = cStaticArrayDecl( dimensions, dTB() )

    '' AS SumbolType
    if( not hMatch( FB.TK.AS ) or (typ <> INVALID) ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
    end if

    if( not cSymbolType( typ, subtype, lgt ) ) then
    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    	exit function
    end if

	cElementDecl = TRUE

end function

'':::::
''TypeLine      =   (UNION Comment? SttSeparator
''					 (ElementDecl? Comment? SttSeparator)+
''					END UNION)
''              |   (ElementDecl? Comment? SttSeparator)+ .
''
function cTypeLine as integer
    dim typ as integer, subtype as FBSYMBOL ptr, lgt as integer
    dim dimensions as integer, dTB(0 to FB.MAXARRAYDIMS-1) as FBARRAYDIM
    dim ename as string

	cTypeLine = FALSE

	'' Comment? SttSeparator?
	do while( (cComment <> FALSE) or (cSttSeparator <> FALSE) )
	loop

	select case lexCurrentToken
	case FB.TK.END
		if( env.typectx.innercnt = 0 ) then
			exit function
		else
			lexSkipToken
		end if

		if( not hMatch( FB.TK.UNION ) ) then
    		hReportError FB.ERRMSG.EXPECTEDENDTYPE
    		exit function
		end if

		env.typectx.innercnt = env.typectx.innercnt - 1

		if( env.typectx.innercnt = 0 ) then
			symbRecalcUDTSize env.typectx.symbol
		end if

	case FB.TK.UNION
		if( env.typectx.isunion = TRUE ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		else
			lexSkipToken
		end if

		env.typectx.innercnt = env.typectx.innercnt + 1

	case else
		env.typectx.elements = env.typectx.elements + 1

		if( cElementDecl( ename, typ, subtype, lgt, dimensions, dTB() ) ) then
			if( symbAddUDTElement( env.typectx.symbol, ename, dimensions, dTB(), _
								   typ, subtype, lgt, env.typectx.innercnt > 0 ) = NULL ) then
				hReportErrorEx FB.ERRMSG.DUPDEFINITION, ename
				exit function
			end if
		end if
	end select


	'' Comment? SttSeparator
	cComment

    if( not cSttSeparator ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
	end if

    cTypeLine = TRUE

end function

'':::::
''TypeDecl        =   (TYPE|UNION) ID (FIELD '=' Expression)? Comment? SttSeparator
''						TypeLine+
''					  END (TYPE|UNION) .
function cTypeDecl
    dim id as string, align as integer, expr as integer
    dim res as integer

	cTypeDecl = FALSE

	'' TYPE | UNION
	select case lexCurrentToken
	case FB.TK.TYPE
		env.typectx.isunion = FALSE
		lexSkipToken
	case FB.TK.UNION
		env.typectx.isunion = TRUE
		lexSkipToken
	case else
		exit function
	end select

	'' ID
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    	exit function
    end if

	id = lexEatToken

	'' (FIELD '=' Expression)?
	if( hMatch( FB.TK.FIELD ) ) then
		if( not hMatch( FB.TK.ASSIGN ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

    	if( not cExpression( expr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

		if( astGetType( expr ) <> AST.NODETYPE.CONST ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		end if

  		align = cint( astGetValue( expr ) )
  		astDel expr

	else
		align = FB.INTEGERSIZE
	end if

	env.typectx.symbol = symbAddUDT( id, env.typectx.isunion, align )
	if( env.typectx.symbol = NULL ) then
    	hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    	exit function
	end if

	'' Comment? SttSeparator
	res = cComment

	if( not cSttSeparator ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
	end if

	'' TypeLine+
	env.typectx.elements = 0
	env.typectx.innercnt = 0
	do
		res = cTypeLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

	''
	if( env.typectx.elements = 0 ) then
		hReportError FB.ERRMSG.ELEMENTNOTDEFINED
		exit function
	end if

	'' align to multiple of sizeof( int )
	symbRoundUDTSize env.typectx.symbol

	'' END
	if( not hMatch( FB.TK.END ) ) then
    	hReportError FB.ERRMSG.EXPECTEDENDTYPE
    	exit function
	end if

	'' TYPE | UNION
	select case lexCurrentToken
	case FB.TK.TYPE, FB.TK.UNION
		lexSkipToken
	case else
    	hReportError FB.ERRMSG.EXPECTEDENDTYPE
    	exit function
    end select

    ''
	cTypeDecl = TRUE

end function

'':::
''EnumConstDecl     =   ID (ASSIGN ConstExpression)? .
''
function cEnumConstDecl( id as string )
    dim expr as integer

	cEnumConstDecl = FALSE

	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		exit function
	end if

	'' ID
	id = lexEatToken

	'' ASSIGN
	if( hMatch( FB.TK.ASSIGN ) ) then

		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		else
			if( astGetType( expr ) <> AST.NODETYPE.CONST ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			end if
		end if

		env.enumctx.value = cint( astGetValue( expr ) )
		astDel expr

    end if

	cEnumConstDecl = TRUE

end function

'':::::
''EnumLine      =   (EnumDecl? Comment? SttSeparator) .
''
function cEnumLine as integer
	dim ename as string

	cEnumLine = FALSE

	'' Comment? SttSeparator?
	do while( (cComment <> FALSE) or (cSttSeparator <> FALSE) )
	loop

	if( lexCurrentToken = FB.TK.END ) then
		exit function
	end if

	env.enumctx.elements = env.enumctx.elements + 1

	if( cEnumConstDecl( ename ) ) then
		if( symbAddConst( ename, FB.SYMBTYPE.INTEGER, str$( env.enumctx.value ), 0 ) = NULL ) then
			hReportErrorEx FB.ERRMSG.DUPDEFINITION, ename
			exit function
		end if
	end if

	''
	env.enumctx.value = env.enumctx.value + 1

	'' Comment? SttSeparator
	cComment

	if( not cSttSeparator ) then
    	hReportError FB.ERRMSG.EXPECTEDEOL
    	exit function
	end if

	cEnumLine = TRUE

end function

'':::::
''EnumDecl        =   ENUM ID Comment? SttSeparator
''                        EnumLine+
''					  END ENUM .
function cEnumDecl
    dim id as string, e as integer
    dim res as integer

	cEnumDecl = FALSE

	'' ENUM
	if( not hMatch( FB.TK.ENUM ) ) then
		exit function
	end if

	'' ID
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    	exit function
    end if

	id = lexEatToken

	e = symbAddEnum( id )
	if( e = NULL ) then
    	hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    	exit function
	end if

	'' Comment? SttSeparator
	res = cComment

	if( not cSttSeparator ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
	end if

	'' EnumLine+
	env.enumctx.elements = 0
	env.enumctx.value = 0
	do
		res = cEnumLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

	''
	if( env.enumctx.elements = 0 ) then
		hReportError FB.ERRMSG.ELEMENTNOTDEFINED
		exit function
	end if

	'' END ENUM
	if( not hMatch( FB.TK.END ) ) then
    	hReportError FB.ERRMSG.EXPECTEDENDTYPE
    	exit function
	elseif( not hMatch( FB.TK.ENUM ) ) then
    	hReportError FB.ERRMSG.EXPECTEDENDTYPE
    	exit function
	end if

    ''
	cEnumDecl = TRUE

end function

'':::::
''SymbolDecl      =   (REDIM PRESERVE?|DIM|COMMON) SHARED? SymbolDef
''				  |   EXTERN SymbolDef ALIAS STR_LIT
''                |   STATIC SymbolDef .							// ambiguity w/ STATIC SUB|FUNCTION
''
function cSymbolDecl
	dim res as integer, alloctype as integer
	dim dopreserve as integer

	cSymbolDecl = FALSE

	select case lexCurrentToken
	case FB.TK.DIM, FB.TK.REDIM, FB.TK.COMMON, FB.TK.EXTERN

		alloctype = 0
		dopreserve = FALSE

		select case lexCurrentToken
		'' REDIM
		case FB.TK.REDIM
			lexSkipToken
			alloctype = alloctype or FB.ALLOCTYPE.DYNAMIC

			'' PRESERVE?
			if( hMatch( FB.TK.PRESERVE ) ) then
				dopreserve = TRUE
			end if

		'' COMMON
		case FB.TK.COMMON
			'' can't use COMMON inside a proc
			if( env.scope > 0 ) then
    			hReportError FB.ERRMSG.ILLEGALINSIDEASUB
    			exit function
			end if

			lexSkipToken

			alloctype = alloctype or FB.ALLOCTYPE.COMMON or FB.ALLOCTYPE.DYNAMIC

		'' EXTERN
		case FB.TK.EXTERN
			'' can't use EXTERN inside a proc
			if( env.scope > 0 ) then
    			hReportError FB.ERRMSG.ILLEGALINSIDEASUB
    			exit function
			end if

			lexSkipToken

			alloctype = alloctype or FB.ALLOCTYPE.EXTERN or FB.ALLOCTYPE.SHARED

		case else
			lexSkipToken
		end select

		''
		if( env.optdynamic ) then
			alloctype = alloctype or FB.ALLOCTYPE.DYNAMIC
		end if

		'' SHARED
		if( (alloctype and FB.ALLOCTYPE.EXTERN) = 0 ) then
			if( lexCurrentToken = FB.TK.SHARED ) then

				'' can't use SHARED inside a proc
				if( env.scope > 0 ) then
    				hReportError FB.ERRMSG.ILLEGALINSIDEASUB
    				exit function
				end if

				lexSkipToken
				alloctype = alloctype or FB.ALLOCTYPE.SHARED
			end if
		end if

		''
		if( env.isprocstatic ) then
			alloctype = alloctype or FB.ALLOCTYPE.STATIC
		end if

		''
		cSymbolDecl = cSymbolDef( alloctype, dopreserve )

	'' STATIC
	case FB.TK.STATIC

		'' check ambiguity with STATIC SUB|FUNCTION
		select case lexLookAhead( 1 )
		case FB.TK.SUB, FB.TK.FUNCTION
			exit function
		end select

		'' can't use STATIC outside a proc
		if( env.scope = 0 ) then
   			hReportError FB.ERRMSG.ILLEGALOUTSIDEASUB
   			exit function
		end if

		lexSkipToken

		cSymbolDecl = cSymbolDef( FB.ALLOCTYPE.STATIC )

	end select

end function

'':::::
function hIsDynamic( byval dimensions as integer, exprTB() as integer ) as integer
    dim i as integer

	hIsDynamic = TRUE

	if( dimensions = -1 ) then
		exit function
	end if

	for i = 0 to dimensions-1
		if( astGetType( exprTB(i, 0) ) <> AST.NODETYPE.CONST ) then
			exit function
		elseif( astGetType( exprTB(i, 1) ) <> AST.NODETYPE.CONST ) then
			exit function
		end if
	next i

	hIsDynamic = FALSE

end function

''::::
sub hMakeArrayDimTB( byval dimensions as integer, exprTB() as integer, dTB() as FBARRAYDIM )
    dim i as integer

	if( dimensions = -1 ) then
		exit function
	end if

	for i = 0 to dimensions-1
		dTB(i).lower = cint( astGetValue( exprTB(i, 0) ) )
		dTB(i).upper = cint( astGetValue( exprTB(i, 1) ) )
		astDel exprTB(i, 0)
		astDel exprTB(i, 1)
	next i

end sub

'':::::
function hDeclExternVar( id as string, byval typ as integer, byval subtype as FBSYMBOL ptr, _
						 byval alloctype as integer, byval addsuffix as integer ) as FBSYMBOL ptr
	dim symbol as FBSYMBOL ptr
	dim ofs as integer, elm as FBTYPELEMENT ptr

    hDeclExternVar = NULL

    '' dup extern?
    if( (alloctype and FB.ALLOCTYPE.EXTERN) > 0 ) then
    	exit function
    end if

    symbol = symbLookupVar( id, typ, ofs, elm, subtype )
    if( symbol <> NULL ) then
    	if( (symbGetAllocType( symbol ) and FB.ALLOCTYPE.EXTERN) = 0 ) then
    		exit function
    	else
    		symbSetAllocType symbol, (alloctype and not FB.ALLOCTYPE.EXTERN) or _
    								 FB.ALLOCTYPE.PUBLIC or _
    								 FB.ALLOCTYPE.SHARED
    	end if
    end if

    hDeclExternVar = symbol

end function

'':::::
''SymbolDef       =   ID ('('')' | ArrayDecl)? (AS SymbolType)? ('=' VarInitializer)?
''                       (DECL_SEPARATOR SymbolDef)* .
''
function cSymbolDef( byval alloctype as integer, byval dopreserve as integer = FALSE )
    dim id as string, idalias as string, symbol as FBSYMBOL ptr
    dim addsuffix as integer, atype as integer, isdynamic as integer
    dim typ as integer, subtype as FBSYMBOL ptr, lgt as integer, ofs as integer
    dim dimensions as integer, dTB(0 to FB.MAXARRAYDIMS-1) as FBARRAYDIM
    dim exprTB(0 to FB.MAXARRAYDIMS-1, 0 to 1) as integer

    cSymbolDef = FALSE

    do
    	'' ID
    	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    		exit function
    	end if

    	typ 		= lexTokenType
    	subtype 	= NULL
    	lgt			= 0
    	id 			= lexEatToken
    	idalias		= ""
    	addsuffix 	= TRUE

    	'' ('('')' | ArrayDecl)?
		dimensions = 0
		if( (lexCurrentToken = CHAR_LPRNT) and (lexLookAhead(1) = CHAR_RPRNT) ) then
			lexSkipToken
			lexSkipToken
			dimensions = -1 				'' fake it
		else
    		if( cArrayDecl( dimensions, exprTB() ) ) then
    		end if
    	end if

		'' ALIAS LIT_STR
		if( (alloctype and (FB.ALLOCTYPE.PUBLIC or FB.ALLOCTYPE.EXTERN)) > 0 ) then
			if( hMatch( FB.TK.ALIAS ) ) then
				if( lexCurrentTokenClass <> FB.TKCLASS.STRLITERAL ) then
					hReportError FB.ERRMSG.SYNTAXERROR
					exit function
				end if
				idalias = lexEatToken
			end if
		end if

    	'' dynamic?
    	isdynamic = FALSE
    	if( dimensions <> 0 ) then
			if( (alloctype and FB.ALLOCTYPE.DYNAMIC) > 0 ) then
				isdynamic = TRUE
			else
				if( (dimensions = -1) or hIsDynamic( dimensions, exprTB() ) ) then
    				isdynamic = TRUE
				end if
			end if
		end if

    	'' (AS SymbolType)?
    	if( lexCurrentToken = FB.TK.AS ) then

    		if( typ <> INVALID ) then
    			hReportError FB.ERRMSG.SYNTAXERROR
    			exit function
    		end if

    		lexSkipToken

    		if( not cSymbolType( typ, subtype, lgt ) ) then
    			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    			exit function
    		end if

    		addsuffix = FALSE

    	else

			if( typ = INVALID ) then
				typ = hGetDefType( id )
			end if
    		lgt	= symbCalcLen( typ, subtype )

    	end if

    	''
    	if( isdynamic ) then

    		symbol = cDynArrayDef( id, idalias, typ, subtype, lgt, addsuffix, alloctype, dopreserve, dimensions, exprTB() )
    		if( symbol = NULL ) then
    			exit function
    		end if

    	else

            hMakeArrayDimTB dimensions, exprTB(), dTB()

            atype = alloctype and (not FB.ALLOCTYPE.DYNAMIC)

    		symbol = symbAddVarEx( id, idalias, typ, subtype, lgt, dimensions, dTB(), atype, addsuffix, FALSE, TRUE )
    		if( symbol = NULL ) then

                symbol = hDeclExternVar( id, typ, subtype, atype, addsuffix )

    			if( symbol = NULL ) then
    				hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    				exit function
    			end if
			end if

			'' another quirk: if array is local (ie, inside a proc) and it's not dynamic, it's
			'' descriptor won't will be filled ever, so a call to another rtl routine is needed,
			'' or that array coulnd't be passed by descriptor to other procs (allocating a static
			'' descriptor won't help, as that would break recursion)
			if( env.scope > 0 ) then
				if( dimensions > 0 ) then
					if( (alloctype and (FB.ALLOCTYPE.SHARED or FB.ALLOCTYPE.STATIC)) = 0 ) then
						rtlArraySetDesc symbol, lgt, dimensions, dTB()
					end if
				end if
			end if

		end if

		'' ('=' SymbolInitializer)?
		if( hMatch( FB.TK.EQ ) ) then
        	if( not cSymbolInit( symbol ) ) then
        		exit function
        	end if
		end if

		'' (DECL_SEPARATOR SymbolDef)*
		if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
			exit do
		end if

		lexSkipToken

    loop

    cSymbolDef = TRUE

end function

'':::::
function cDynArrayDef( id as string, idalias as string, byval typ as integer, _
					   byval subtype as FBSYMBOL ptr, byval lgt as integer, _
					   byval addsuffix as integer, byval alloctype as integer, byval dopreserve as integer, _
					   byval dimensions as integer, exprTB() as integer ) as FBSYMBOL ptr
    dim s as FBSYMBOL ptr
    dim res as integer
    dim atype as integer
    dim dTB(0 to FB.MAXARRAYDIMS-1) as FBARRAYDIM

    cDynArrayDef = NULL

    atype = (alloctype or FB.ALLOCTYPE.DYNAMIC) and (not FB.ALLOCTYPE.STATIC)

    ''
  	s = symbLookupVar( id, typ, 0, NULL, NULL )
   	if( s = NULL ) then
   		s = symbAddVarEx( id, idalias, typ, subtype, lgt, dimensions, dTB(), atype, addsuffix, FALSE, TRUE )
   		if( s = NULL ) then
   			hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
   			exit function
   		end if
	else

		if( not symbGetVarIsDynamic( s ) ) then

   			s = hDeclExternVar( id, typ, subtype, atype, addsuffix )

   			if( s = NULL ) then
   				hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
				exit function
			end if

		else

			if( (symbGetAllocType( s ) and FB.ALLOCTYPE.EXTERN) > 0 ) then
				if( (atype and FB.ALLOCTYPE.EXTERN) > 0 ) then
   					hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
					exit function
				end if

				symbSetAllocType s, (atype and not FB.ALLOCTYPE.EXTERN) or _
    					            FB.ALLOCTYPE.PUBLIC or _
    					            FB.ALLOCTYPE.SHARED
			end if
		end if
	end if

	alloctype = symbGetAllocType( s )

	''
	if( (alloctype and FB.ALLOCTYPE.EXTERN) > 0 ) then
		cDynArrayDef = TRUE
		exit function
	end if

	'' not an argument passed by descriptor or a common array?
	if( (alloctype and (FB.ALLOCTYPE.ARGUMENTBYDESC or FB.ALLOCTYPE.COMMON)) = 0 ) then

		if( (typ <> symbGetType( s )) or (subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    		exit function
		end if

		if( symbGetVarDimensions( s ) > 0 ) then
			if( dimensions <> symbGetVarDimensions( s ) ) then
    			hReportErrorEx FB.ERRMSG.WRONGDIMENSIONS, id
    			exit function
    		end if
		end if

	'' else, can't check it's dimensions at compile-time
	else
		if( (typ <> symbGetType( s )) or (subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    		exit function
		end if
	end if

	'' if it isn't a common array, redim it
	if( ((alloctype and FB.ALLOCTYPE.COMMON) = 0) and (dimensions > 0) ) then
		rtlArrayRedim s, lgt, dimensions, exprTB(), dopreserve
	end if

	'' if common, check for max dimensions used
	if( (alloctype and FB.ALLOCTYPE.COMMON) > 0 ) then
		if( dimensions > symbGetVarDimensions( s ) ) then
			symbSetVarDimensions s, dimensions
		end if

	'' or if dims = -1 (cause of "redim|dim array()")
	elseif( symbGetVarDimensions( s ) = -1 ) then
		symbSetVarDimensions s, dimensions
	end if

    cDynArrayDef = s

end function

'':::::
function cSymbolInit( byval s as FBSYMBOL ptr ) as integer
    dim expr as integer
    dim litstr as integer, islitstring as integer
    dim dimensions as integer, subtype as FBSYMBOL ptr
    dim istatic as integer
    dim cnt as integer

	cSymbolInit = FALSE

	'' cannot initialize dynamic vars
	if( symbGetVarIsDynamic( s ) ) then
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

	istatic = (symbGetAllocType( s ) and FB.ALLOCTYPE.STATIC) > 0

	'' - types are known too, must be checked
	'' - var-len strings can't be accepted on static/mod-level
	'' - fix-len strings must be padded by emit if static/mod-level
	'' - the same goes with same with user types *and* arrays!

	'' impossible to save as trees, they can get really complex with udt with udts inside,
	'' just emit the current vars on a .data seg and restore the .code seg, as DATA does,
	'' emit must be aware that the var was already initialized..

	'' '{'
	if( not hMatch( CHAR_LBRACKET ) ) then
		hReportError FB.ERRMSG.EXPECTEDLBRACKET
		exit function
	end if

	cnt = 0
	dimensions = symbGetVarDimensions( s )
	do

		if( cnt > dimensions ) then
			hReportError FB.ERRMSG.TOOMANYEXPRESSIONS
			exit function
		end if

		islitstring = FALSE
		if( istatic or env.scope = 0 ) then
			if( lexCurrentTokenClass = FB.TKCLASS.STRLITERAL ) then
				islitstring = TRUE
				litstr = strpAdd( lexEatToken )
			end if
		end if

		if( not islitstring ) then
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		end if

		'' if static or at module level, only constants can be used as initializers
		if( istatic or env.scope = 0 ) then

			if( not islitstring ) then
				if( astGetType( expr ) <> AST.NODETYPE.CONST ) then
					hReportError FB.ERRMSG.EXPECTEDCONST
					exit function
				end if

				'symbVarAddInitScalar s, astGetValue( expr )
				astDel expr

			else

				'symbVarAddInitString s, litstr

			end if

		else

			'symbVarAddInitExpression s, expr

		end if

		cnt = cnt + 1

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	'' '}'
	if( not hMatch( CHAR_RBRACKET ) ) then
		hReportError FB.ERRMSG.EXPECTEDRBRACKET
		exit function
	end if


end function

'':::::
''ArrayDecl       =   IDX_OPEN Expression (TO Expression)?
''                             (DECL_SEPARATOR Expression (TO Expression)?)*
''				      IDX_CLOSE .
''
function cStaticArrayDecl( dimensions as integer, dTB() as FBARRAYDIM )
    dim res as integer
    dim i as integer, expr as integer

    res = FALSE
    cStaticArrayDecl = FALSE

    dimensions = 0

    '' IDX_OPEN
    if( not hMatch( FB.TK.IDXOPENCHAR ) ) then
    	exit function
    end if

    i = 0
    do
    	'' Expression
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		else
			if( astGetType( expr ) <> AST.NODETYPE.CONST ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			end if
		end if

		dTB(i).lower = astGetValue( expr )
		astDel expr

        '' TO
    	if( lexCurrentToken = FB.TK.TO ) then
    		lexSkipToken

    		'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			else
				if( astGetType( expr ) <> AST.NODETYPE.CONST ) then
					hReportError FB.ERRMSG.EXPECTEDCONST
					exit function
				end if
			end if

			dTB(i).upper = astGetValue( expr )
			astDel expr

    	else
    	    dTB(i).upper = dTB(i).lower
    		dTB(i).lower = env.optbase
    	end if

    	dimensions = dimensions + 1
    	i = i + 1

    	'' separator
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if

		if( i >= FB.MAXARRAYDIMS ) then
			hReportError FB.ERRMSG.TOOMANYDIMENSIONS
			exit function
		end if
	loop

	'' IDX_CLOSE
    res = TRUE
    if( not hMatch( FB.TK.IDXCLOSECHAR ) ) then
    	hReportError FB.ERRMSG.EXPECTEDRPRNT
    	res = FALSE
    end if

	cStaticArrayDecl = res

end function

'':::::
''ArrayDecl    	  =   IDX_OPEN Expression (TO Expression)?
''                             (DECL_SEPARATOR Expression (TO Expression)?)*
''				      IDX_CLOSE .
''
function cArrayDecl( dimensions as integer, exprTB() as integer )
    dim i as integer, expr as integer

    cArrayDecl = FALSE

    dimensions = 0

    '' IDX_OPEN
    if( not hMatch( FB.TK.IDXOPENCHAR ) ) then
    	exit function
    end if

    i = 0
    do
    	'' Expression
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		exprTB(i,0) = expr

        '' TO
    	if( lexCurrentToken = FB.TK.TO ) then
    		lexSkipToken

    		'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if

			exprTB(i,1) = expr

    	else
    	    exprTB(i,1) = exprTB(i,0)
    		exprTB(i,0) = astNewCONST( env.optbase, IR.DATATYPE.INTEGER )
    	end if

    	dimensions = dimensions + 1
    	i = i + 1

    	'' separator
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if

		if( i >= FB.MAXARRAYDIMS ) then
			hReportError FB.ERRMSG.TOOMANYDIMENSIONS
			exit function
		end if
	loop

	'' IDX_CLOSE
    if( not hMatch( FB.TK.IDXCLOSECHAR ) ) then
    	hReportError FB.ERRMSG.EXPECTEDRPRNT
    	exit function
    end if

	cArrayDecl = TRUE

end function

''::::
function cConstExprValue( littext as string ) as integer
    dim expr as integer

    cConstExprValue = FALSE

    if( not cExpression( expr ) ) then
    	hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    	exit function
    end if

	if( astGetType( expr ) <> AST.NODETYPE.CONST ) then
		hReportError FB.ERRMSG.EXPECTEDCONST
		exit function
	end if

  	littext = ltrim$( str$( astGetValue( expr ) ) )
  	astDel expr

  	cConstExprValue = TRUE

end function

'':::::
function cSymbolTypeFuncPtr as FBSYMBOL ptr
	dim typ as integer, subtype as FBSYMBOL ptr, lgt as integer, mode as integer
	dim argc as integer, argv(0 to FB_MAXPROCARGS-1) as FBPROCARG
	dim res as integer

	cSymbolTypeFuncPtr = NULL

	'' mode
	mode = cFunctionMode

	'' ('(' Argument? ')')
	if( hMatch( CHAR_LPRNT ) ) then
		res = cArguments( argc, argv(), TRUE )

    	if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

	else
		argc = 0
	end if

	'' (AS SymbolType)?
	if( hMatch( FB.TK.AS ) ) then
		if( not cSymbolType( typ, subtype, lgt ) ) then
			exit function
		end if
	else
		typ = FB.SYMBTYPE.VOID
		subtype = NULL
	end if

	cSymbolTypeFuncPtr = symbAddPrototype( hMakeTmpStr, "", "", typ, subtype, mode, argc, argv(), TRUE )

end function


'':::::
''SymbolType      =   UNSIGNED? (
''				      ANY
''				  |   CHAR|BYTE
''				  |	  SHORT|WORD
''				  |	  INTEGER|LONG|DWORD
''				  |   SINGLE
''				  |   DOUBLE
''                |   STRING ('*' NUM_LIT)?
''                |   USERDEFTYPE
''				  |   (FUNCTION|SUB) ('(' args ')') (AS SymbolType)?
''				      (PTR|POINTER)* .
''
function cSymbolType( typ as integer, subtype as FBSYMBOL ptr, lgt as integer )
    dim isunsigned as integer
    dim res as integer, s as FBSYMBOL ptr
    dim littext as string
    dim ptrcnt as integer

	res = FALSE

	lgt = 0
	typ = INVALID
	subtype = NULL

	'' UNSIGNED?
	isunsigned = hMatch( FB.TK.UNSIGNED )

	''
	select case lexCurrentToken
	case FB.TK.ANY
		typ = FB.SYMBTYPE.VOID
		lgt = 0
		lexSkipToken

	case FB.TK.BYTE
		typ = FB.SYMBTYPE.BYTE
		lgt = 1
		lexSkipToken
	case FB.TK.UBYTE
		typ = FB.SYMBTYPE.UBYTE
		lgt = 1
		lexSkipToken

	case FB.TK.SHORT
		typ = FB.SYMBTYPE.SHORT
		lgt = 2
		lexSkipToken
	case FB.TK.USHORT
		typ = FB.SYMBTYPE.USHORT
		lgt = 2
		lexSkipToken

	case FB.TK.INTEGER, FB.TK.LONG
		typ = FB.SYMBTYPE.INTEGER
		lgt = FB.INTEGERSIZE
		lexSkipToken
	case FB.TK.UINT
		typ = FB.SYMBTYPE.UINT
		lgt = FB.INTEGERSIZE
		lexSkipToken

	case FB.TK.SINGLE
		typ = FB.SYMBTYPE.SINGLE
		lgt = 4
		lexSkipToken

	case FB.TK.DOUBLE
		typ = FB.SYMBTYPE.DOUBLE
		lgt = 8
		lexSkipToken

	case FB.TK.STRING
		if( lexLookAhead(1) = CHAR_STAR ) then
			lexSkipToken
			lexSkipToken
			typ = FB.SYMBTYPE.FIXSTR
			if( not cConstExprValue( littext ) ) then
				exit function
			end if
			lgt = val( littext ) + 1
			if( lgt = 1 ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if
		else
			typ = FB.SYMBTYPE.STRING
			lgt = FB.STRSTRUCTSIZE
			lexSkipToken
		end if

	case FB.TK.FUNCTION, FB.TK.SUB
	    lexSkipToken

		typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION
		lgt = FB.POINTERSIZE

		subtype = cSymbolTypeFuncPtr
		if( subtype = NULL ) then
			exit function
		end if

	case else
		s = symbLookupUDT( lexTokenText, lgt )
		if( s <> NULL ) then
			typ = FB.SYMBTYPE.USERDEF
			subtype = s
			lexSkipToken
		else
			s = symbLookupEnum( lexTokenText )
			if( s <> NULL ) then
				typ = FB.SYMBTYPE.UINT
				lgt = FB.INTEGERSIZE
				lexSkipToken
			end if
		end if
	end select

	''
	if( typ <> INVALID ) then

		res = TRUE

		if( isunsigned ) then
			select case typ
			case FB.SYMBTYPE.BYTE
				typ = FB.SYMBTYPE.UBYTE
			case FB.SYMBTYPE.SHORT
				typ = FB.SYMBTYPE.USHORT
			case FB.SYMBTYPE.INTEGER
				typ = FB.SYMBTYPE.UINT
			case else
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end select
		end if

		'' (PTR|POINTER)*
		ptrcnt = 0
		do
			select case lexCurrentToken
			case FB.TK.PTR, FB.TK.POINTER
				lexSkipToken
				typ = FB.SYMBTYPE.POINTER + typ
				ptrcnt = ptrcnt + 1
			case else
				exit do
			end select
		loop

        if( ptrcnt > 0 ) then
			'' can't be a fixed-len string
			if( typ = FB.SYMBTYPE.FIXSTR ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if

			lgt = FB.POINTERSIZE
		end if

	else
		if( isunsigned ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
	end if

	cSymbolType = res

end function

'':::::
''ProcDecl        =   DECLARE (SUB SubDecl) |
''                            (FUNCTION FuncDecl) .
''
function cProcDecl

    cProcDecl = FALSE

    if( lexCurrentToken <> FB.TK.DECLARE ) then
    	exit function
    else
    	lexSkipToken
    end if

	select case lexCurrentToken
	case FB.TK.SUB
		lexSkipToken
		cProcDecl = cSubOrFuncDecl( TRUE )

	case FB.TK.FUNCTION
		lexSkipToken
		cProcDecl = cSubOrFuncDecl( FALSE )

	case else
		hReportError FB.ERRMSG.SYNTAXERROR
	end select

end function

'':::::
function cFunctionMode as integer

	'' (CDECL|STDCALL|PASCAL)?
	select case lexCurrentToken
	case FB.TK.CDECL
		cFunctionMode = FB.FUNCMODE.CDECL
		lexSkipToken
	case FB.TK.STDCALL
		cFunctionMode = FB.FUNCMODE.STDCALL
		lexSkipToken
	case FB.TK.PASCAL
		cFunctionMode = FB.FUNCMODE.PASCAL
		lexSkipToken
	case else
		cFunctionMode = FB.DEFAULT.FUNCMODE
	end select

end function


'':::::
''SubOrFuncDecl      =  ID (CDECL|STDCALL|PASCAL)? (ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')?
''					 |	ID (CDECL|STDCALL|PASCAL)? (ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')? (AS SymbolType)? .
''
function cSubOrFuncDecl( byval isSub as integer ) static
    dim res as integer
    dim id as string, typ as integer, subtype as FBSYMBOL ptr, mode as integer, lgt as integer
    dim libname as string, aliasname as string
    dim f as FBSYMBOL ptr, argc as integer, argv(0 to FB_MAXPROCARGS-1) as FBPROCARG

	cSubOrFuncDecl = FALSE

	'' ID
	if( lexCurrentToken <> FB.TK.ID ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	typ = lexTokenType
	id = lexEatToken
	subtype = NULL

	if( (isSub) and (typ <> INVALID) ) then
    	hReportError FB.ERRMSG.INVALIDCHARACTER
    	exit function
	end if

	''
	mode = cFunctionMode

	'' (LIB STR_LIT)?
	if( hMatch( FB.TK.LIB ) ) then
		if( lexCurrentTokenClass <> FB.TKCLASS.STRLITERAL ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
		libname = lexEatToken
	else
		libname = ""
	end if

	'' (ALIAS STR_LIT)?
	if( hMatch( FB.TK.ALIAS ) ) then
		if( lexCurrentTokenClass <> FB.TKCLASS.STRLITERAL ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
		aliasname = lexEatToken
	else
		aliasname = ""
	end if

	'' ('(' Arguments? ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		res = cArguments( argc, argv(), TRUE )
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	else
		argc = 0
	end if

    '' (AS SymbolType)?
    if( hMatch( FB.TK.AS ) ) then

    	if( (typ <> INVALID) or (isSub) ) then
    		hReportError FB.ERRMSG.SYNTAXERROR
    		exit function
    	end if

    	if( not cSymbolType( typ, subtype, lgt ) ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    		exit function
    	end if

    	'' check for invalid types
    	select case typ
    	case FB.SYMBTYPE.USERDEF
    		hReportError FB.ERRMSG.CANNOTRETURNSTRUCTSFROMFUNCTS
    		exit function
    	case FB.SYMBTYPE.FIXSTR
    		hReportError FB.ERRMSG.CANNOTRETURNFIXLENFROMFUNCTS
    		exit function
    	end select
    end if

    if( issub ) then
    	typ = FB.SYMBTYPE.VOID
    	subtype = NULL
    end if

	''
	if( typ = INVALID ) then
		typ = hGetDefType( id )
	end if

    ''
    f = symbAddPrototype( id, aliasname, libname, typ, subtype, mode, argc, argv(), FALSE )
    if( f = NULL ) then
    	hReportError FB.ERRMSG.DUPDEFINITION
    	exit function
    end if

    cSubOrFuncDecl = TRUE

end function

'':::::
''Arguments       =   ArgDecl (DECL_SEPARATOR ArgDecl)* .
''
function cArguments( argc as integer, argv() as FBPROCARG, byval isproto as integer )

	cArguments = FALSE

	argc = 0
	do
		if( not cArgDecl( argc, argv(argc), isproto ) ) then
			exit function
		end if

		argc = argc + 1

		if( not hMatch( CHAR_COMMA ) ) then
			cArguments = TRUE
			exit do
		end if
	loop

end function

'':::::
private sub hReportParamError( byval argnum as integer, id as string )

	hReportErrorEx FB.ERRMSG.ILLEGALPARAMSPECAT, "at parameter " + str$( argnum+1 ) + ": " + id

end sub

'':::::
''ArgDecl         =   (BYVAL|BYREF|SEG)? ID (('(' ')')? (AS SymbolType)?)? ('=" NUM_LIT)? .
''
function cArgDecl( byval argc as integer, arg as FBPROCARG, byval isproto as integer ) as integer
	dim id as string
	dim expr as integer, dclass as integer

	cArgDecl = FALSE

	'' (BYVAL|SEG)?
	arg.mode = env.optargmode
	select case lexCurrentToken
	case FB.TK.BYVAL
		arg.mode = FB.ARGMODE.BYVAL
		lexSkipToken
	case FB.TK.BYREF, FB.TK.SEG
		arg.mode = FB.ARGMODE.BYREF
		lexSkipToken
	end select

	'' only allow keywords as arg names on prototypes
	if( lexCurrentToken <> FB.TK.ID ) then
		if( not isproto ) then
			'' anything but keywords will be catch by parser (could be a ')' too)
			if( lexCurrentTokenClass = FB.TKCLASS.KEYWORD ) then
				hReportError FB.ERRMSG.ILLEGALPARAMSPEC
				exit function
			end if
		end if

		if(	lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
			exit function
		end if
	end if

	'' ID
	arg.typ = lexTokenType
	id = lexEatToken

	'' don't save arg's name if it's just a prototype
	if( not isproto ) then
		arg.nameidx = strpAdd( id )
	else
		arg.nameidx = INVALID
	end if

	'' ('('')')
	if( hMatch( CHAR_LPRNT ) ) then
		if( arg.mode <> FB.ARGMODE.BYREF ) then
			exit function
		end if
		if( not hMatch( CHAR_RPRNT ) ) then
			exit function
		end if

		arg.mode = FB.ARGMODE.BYDESC
	end if

    '' (AS SymbolType)?
    if( hMatch( FB.TK.AS ) ) then
    	if( arg.typ <> INVALID ) then
    		hReportParamError argc, id
    		exit function
    	end if
    	if( not cSymbolType( arg.typ, arg.subtype, arg.lgt ) ) then
    		hReportParamError argc, id
    		exit function
    	end if

    	arg.suffix = INVALID
    else
    	arg.subtype = NULL
    	arg.suffix = arg.typ
    end if

    ''
    if( arg.typ = INVALID ) then
        arg.typ = hGetDefType( id )
        arg.suffix = arg.typ
    end if

    '' check for invalid args
    select case arg.typ
    '' can't be a fixed-len string
    case FB.SYMBTYPE.FIXSTR
    	hReportParamError argc, id
    	exit function

	'' can't be as ANY on non-prototypes
    case FB.SYMBTYPE.VOID
    	if( not isproto ) then
    		hReportParamError argc, id
    		exit function
    	end if
    end select

    ''
    select case arg.mode
    case FB.ARGMODE.BYREF, FB.ARGMODE.BYDESC
    	arg.lgt = FB.POINTERSIZE

    case FB.ARGMODE.BYVAL

    	'' check for invalid args
    	if( isproto ) then
    		select case arg.typ
    		case FB.SYMBTYPE.VOID
    			hReportParamError argc, id
    			exit function
    		end select
    	else
    		select case arg.typ
    		case FB.SYMBTYPE.STRING
    			hReportParamError argc, id
    			exit function
    		end select
    	end if

    	select case arg.typ
    	case FB.SYMBTYPE.STRING
    		arg.lgt  = FB.POINTERSIZE
    	case else
    		arg.lgt = symbCalcLen( arg.typ, arg.subtype, TRUE )
    	end select
    end select

    '' if not a prototype, check if args are not dup-defined -- already done at hDeclareArgs()
    '''''if( not isproto ) then
    '''''	if( symbLookupSentinel( id, FB.SYMBCLASS.VAR, TRUE ) <> NULL ) then
    '''''		hReportParamError argc, id
    '''''		exit function
    '''''	end if
    '''''end if

    '' ('=' NUM_LIT)?
    if( hMatch( FB.TK.ASSIGN ) ) then
    	dclass = irGetDataClass( hStyp2Dtype( arg.typ ) )

    	if( (dclass <> IR.DATACLASS.INTEGER) and (dclass <> IR.DATACLASS.FPOINT) ) then
 	   		hReportParamError argc, id
    		exit function
    	end if

    	if( not cExpression( expr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDCONST
    		exit function
    	end if

    	if( astGetType( expr ) <> AST.NODETYPE.CONST ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		end if

    	arg.optional = TRUE
    	arg.defvalue = astGetValue( expr )
    	astDel expr

    else
    	arg.optional = FALSE
        arg.defvalue = 0.0
    end if

    cArgDecl = TRUE

end function

'':::::
''DefDecl         =   (DEFINT|DEFLNG|DEFSNG|DEFDBL|DEFSTR) (CHAR '-' CHAR ','?)* .
''
function cDefDecl
    dim res as integer, typ as integer
    dim ichar as integer, echar as integer, char as string

	res = FALSE

	typ = INVALID

	select case lexCurrentToken
	case FB.TK.DEFBYTE
		typ = FB.SYMBTYPE.BYTE
	case FB.TK.DEFUBYTE
		typ = FB.SYMBTYPE.UBYTE
	case FB.TK.DEFSHORT
		typ = FB.SYMBTYPE.SHORT
	case FB.TK.DEFUSHORT
		typ = FB.SYMBTYPE.USHORT
	case FB.TK.DEFINT, FB.TK.DEFLNG
		typ = FB.SYMBTYPE.INTEGER
	case FB.TK.DEFUINT
		typ = FB.SYMBTYPE.UINT
	case FB.TK.DEFSNG
		typ = FB.SYMBTYPE.SINGLE
	case FB.TK.DEFDBL
		typ = FB.SYMBTYPE.DOUBLE
	case FB.TK.DEFSTR
		typ = FB.SYMBTYPE.STRING
	end select

	if( typ <> INVALID ) then
		lexSkipToken

		'' (CHAR '-' CHAR ','?)*
		do
			'' CHAR
			char = ucase$( lexTokenText )
			if( len( char ) <> 1 ) then
				hReportError FB.ERRMSG.EXPECTEDCOMMA
				exit do
			end if
			ichar = asc( char )
			lexSkipToken

			'' '-'
			if( not hMatch( CHAR_MINUS ) ) then
				hReportError FB.ERRMSG.EXPECTEDMINUS
				exit do
			end if

			'' CHAR
			char = ucase$( lexTokenText )
			if( len( char ) <> 1 ) then
				hReportError FB.ERRMSG.EXPECTEDCOMMA
				exit do
			end if
			echar = asc( char )
			lexSkipToken

			''
			hSetDefType	ichar, echar, typ

      		'' ','
      		if( lexCurrentToken <> CHAR_COMMA ) then
      			exit do
      		else
      			lexSkipToken
      		end if

		loop

		res = TRUE
	end if

	cDefDecl = res

end function

'':::::
''OptDecl         =   OPTION (EXPLICIT|BASE NUM_LIT|BYVAL|PRIVATE|ESCAPE|DYNAMIC|STATIC)
''
function cOptDecl

	cOptDecl = FALSE

	'' OPTION
	if( not hMatch( FB.TK.OPTION ) ) then
		exit function
	end if

	select case lexCurrentToken
	case FB.TK.EXPLICIT
		lexSkipToken
		env.optexplicit = TRUE

	case FB.TK.BASE
		lexSkipToken
		if( lexCurrentTokenClass <> FB.TKCLASS.NUMLITERAL ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
		env.optbase = val( lexEatToken )

	case FB.TK.BYVAL
		lexSkipToken
		env.optargmode = FB.ARGMODE.BYVAL

	case FB.TK.PRIVATE
		lexSkipToken
		env.optprocpublic = FALSE

	case FB.TK.DYNAMIC
		lexSkipToken
		env.optdynamic = TRUE

	case FB.TK.STATIC
		lexSkipToken
		env.optdynamic = FALSE

	case else

		'' ESCAPE (it's not a reserved word, there are too many already..)
		if( ucase$( lexTokenText ) = "ESCAPE" ) then
			lexSkipToken
			env.optescapestr = TRUE
		else
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

	end select

	cOptDecl = TRUE

end function

'':::::
''ProcParam         =   (BYREF|BYVAL|SEG)? (ID(('(' ')')? | Expression) .
''
function cProcParam( byval proc as FBSYMBOL ptr, byval arg as FBPROCARG ptr, expr as integer, pmode as integer, _
					 byval optonly as integer ) as integer
	dim amode as integer

	cProcParam = FALSE

	'' (BYVAL|SEG)?
	amode = symbGetArgMode( proc, arg )
	pmode = INVALID

	select case lexCurrentToken
	case FB.TK.BYVAL
		pmode = FB.ARGMODE.BYVAL
		lexSkipToken
	case FB.TK.BYREF, FB.TK.SEG
		pmode = FB.ARGMODE.BYREF
		lexSkipToken
	end select

	'' Expression
	expr = INVALID
	if( not optonly ) then
		if( not cExpression( expr ) ) then
			expr = INVALID
		end if
	end if

	if( expr = INVALID ) then

		'' check if argument is optional
		if( not symbGetArgOptional( proc, arg ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		'' create an arg
		expr = astNewCONST( symbGetArgDefvalue( proc, arg ), _
							hStyp2Dtype( symbGetArgType( proc, arg ) ) )

	else

		'' '('')'?
		if( amode = FB.ARGMODE.BYDESC ) then
			if( lexCurrentToken = CHAR_LPRNT ) then
				if( lexLookahead(1) = CHAR_RPRNT ) then
					lexSkipToken
					lexSkipToken
					pmode = FB.ARGMODE.BYDESC
				end if
			end if
    	end if

    end if

	''
	if( pmode <> INVALID ) then
		if( amode <> pmode ) then
            '' allow BYVAL param passed to BYREF arg (to pass NULL to pointers and so on)
            if( (amode <> FB.ARGMODE.BYREF) or (pmode <> FB.ARGMODE.BYVAL) ) then
				hReportError FB.ERRMSG.PARAMTYPEMISMATCH
				exit function
			end if
		end if
	end if

	cProcParam = TRUE

end function

'':::::
''ProcParamList     =    ProcParam (DECL_SEPARATOR ProcParam)* .
''
function cProcParamList( byval proc as FBSYMBOL ptr, byval procexpr as integer ) as integer
    dim p as integer, arg as FBPROCARG ptr
    dim res as integer, dtype as integer
    dim args as integer, elist(0 to FB_MAXPROCARGS-1) as integer, mlist(0 to FB_MAXPROCARGS-1) as integer

	args = symbGetProcArgs( proc )

	'' proc has no args?
	if( args = 0 ) then
		cProcParamList = TRUE
		exit function
	end if

	cProcParamList = FALSE

	p = 0
	arg = symbGetProcLastArg( proc )
	do
		if( p >= args ) then
			hReportError FB.ERRMSG.ARGCNTMISMATCH
			exit function
		end if

		if( not cProcParam( proc, arg, elist(p), mlist(p), FALSE ) ) then
			exit function
		end if

		p = p + 1
		arg = symbGetProcPrevArg( proc, arg )

	loop while( hMatch( CHAR_COMMA ) )

	''
	if( p < args ) then

		do while( p < args )

			if( not cProcParam( proc, arg, elist(p), mlist(p), TRUE ) ) then
				exit function
			end if

			p = p + 1
			arg = symbGetProcPrevArg( proc, arg )
		loop

	end if

    ''
	for p = 0 to args-1

		if( astNewPARAM( procexpr, elist(p), INVALID, mlist(p) ) = INVALID ) then
			hReportError FB.ERRMSG.PARAMTYPEMISMATCH
			exit function
		end if

	next p


	cProcParamList = TRUE

end function

'':::::
function hAssignFunctResult( byval proc as FBSYMBOL ptr, byval expr as integer ) as integer static
    dim s as FBSYMBOL ptr
    dim assg as integer, typ as integer, dtype as integer
    dim vr as integer

    hAssignFunctResult = FALSE

    s = symbLookupFunctionResult( proc )
    if( s = NULL ) then
    	exit function
    end if

    typ = symbGetType( s )
    dtype = hStyp2Dtype( typ )
    assg = astNewVAR( s, 0, dtype )

    assg = astNewASSIGN( assg, expr )

    astFlush assg, vr

    hAssignFunctResult = TRUE

end function

'':::::
function cProcCall( byval proc as FBSYMBOL ptr, byval ptrexpr as integer, _
					byval checkparents as integer = FALSE ) as integer
	dim procexpr as integer
	dim vr as integer
	dim typ as integer, dtype as integer
	dim isfunc as integer, isopened as integer

	cProcCall = FALSE

	if( ptrexpr = INVALID ) then
		procexpr = astNewFUNCT( proc, IR.DATATYPE.VOID, symbGetProcArgs( proc ) )
    else
    	procexpr = astNewFUNCTPTR( ptrexpr, proc, IR.DATATYPE.VOID, symbGetProcArgs( proc ) )
    end if

	isfunc = FALSE
	if( checkparents = TRUE ) then
		if( symbGetProcArgs( proc ) = 0 ) then
			checkparents = FALSE
		end if
	elseif( ptrexpr <> INVALID ) then
		checkparents = TRUE
	elseif( symbGetType( proc ) <> FB.SYMBTYPE.VOID ) then
		isfunc = TRUE
		'' function has args?
		if( symbGetProcArgs( proc ) > 0 ) then
			checkparents = TRUE
		end if
	end if

	'' '('
	isopened = FALSE
	if( checkparents ) then
		if( not hMatch( CHAR_LPRNT ) ) then
			if( not isfunc ) then
				hReportError FB.ERRMSG.EXPECTEDLPRNT
				exit function
			end if
		else
			isopened = TRUE
		end if
	end if

	'' ProcParamList
	if( not cProcParamList( proc, procexpr ) ) then
		exit function
	end if

	'' ')'
	if( checkparents ) then
		if( isopened ) then
			if( not hMatch( CHAR_RPRNT ) ) then
				hReportError FB.ERRMSG.EXPECTEDRPRNT
				exit function
			end if
		end if
	end if

	'' can proc's result be skipped?
	typ = symbGetType( proc )
	dtype = hStyp2Dtype( typ )
	if( typ <> FB.SYMBTYPE.VOID ) then
		if( (irGetDataClass( dtype ) = IR.DATACLASS.FPOINT) or hIsString( dtype ) ) then
			hReportError FB.ERRMSG.VARIABLEREQUIRED
			exit function
		end if
	end if

	''
	astFlush procexpr, vr


	cProcCall = TRUE

end function

'':::::
''ProcCallOrAssign=   (CALL|CALLS) ID ('(' ProcParamList ')')?
''                |   ID ProcParamList?
''				  |	  ID '=' Expression .						!!QB quirk!!
''
function cProcCallOrAssign
	dim proc as FBSYMBOL ptr, expr as integer

	cProcCallOrAssign = FALSE

	select case lexCurrentToken
	'' (CALL|CALLS)
	case FB.TK.CALL, FB.TK.CALLS
		lexSkipToken

		'' ID
		if( lexCurrentToken = FB.TK.ID ) then
			proc = symbLookupProc( lexTokenText )
			if( proc <> NULL ) then
				lexSkipToken

				cProcCallOrAssign = cProcCall( proc, INVALID, TRUE )
                exit function
		    else
				hReportError FB.ERRMSG.PROCNOTDECLARED
				exit function
		    end if
		end if

	case FB.TK.ID

		proc = symbLookupProc( lexTokenText )
		if( proc <> NULL ) then
			lexSkipToken

			'' ID ProcParamList?
			if( not hMatch( FB.TK.ASSIGN ) ) then
				cProcCallOrAssign = cProcCall( proc, INVALID )
            	exit function

			'' ID '=' Expression
			else
				if( not cExpression( expr ) ) then
					hReportError FB.ERRMSG.EXPECTEDEXPRESSION
					exit function
				end if

        		if( not hAssignFunctResult( proc, expr ) ) then
        			hReportError FB.ERRMSG.SYNTAXERROR
        			exit function
        		end if

        		cProcCallOrAssign = TRUE
        		exit function
			end if

		end if

	end select

end function

'':::::
''Assignment      =   LET? Variable '=' Expression
''				  |	  Variable{function ptr} '(' ProcParamList ')' .
''
function cAssignment
	dim islet as integer
	dim assg as integer, expr as integer
	dim vr as integer

	cAssignment = FALSE

	if( hMatch( FB.TK.LET ) ) then
		islet = TRUE
	else
		islet = FALSE
	end if

	'' Variable
	if( cVariable( assg, , TRUE ) ) then

        '' '='
        if( not hMatch( FB.TK.ASSIGN ) ) then

    		if( not islet ) then
    			'' check if not a function call through pointers
    			if( assg = INVALID ) then
    				cAssignment = TRUE
    				exit function
    			end if
    		end if

    		hReportError FB.ERRMSG.EXPECTEDEQ
    		exit function

    	end if

        '' Expression
        if( not cExpression( expr ) ) then
        	hReportError FB.ERRMSG.EXPECTEDEXPRESSION
        	exit function
        end if

        '' do assign
        assg = astNewASSIGN( assg, expr )

        if( assg = INVALID ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
            exit function
        end if

        astFlush assg, vr

	else
		if( islet ) then
        	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
        	exit function
		end if
	end if

	cAssignment = TRUE

end function

'':::::
''AsmCode         =   (Text !(Comment|NEWLINE))*
''
function cAsmCode
	dim asmline as string, text as string
	dim ofs as integer, elm as FBTYPELEMENT ptr, subtype as FBSYMBOL ptr, s as FBSYMBOL ptr

	cAsmCode = FALSE

	asmline = ""
	do
		'' !(Comment|NEWLINE)
		select case lexCurrentToken
		case FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
			exit do
		end select

		text = lexTokenText

		if( lexCurrentToken = FB.TK.ID ) then
			if( not emitIsKeyword( text ) ) then
				'' lookup functions
				s = symbLookupProc( text )
				if( s <> NULL ) then
					text = symbGetProcName( s )
				else
					'' lookup var's
					s = symbLookupVar( text, lexTokenType, ofs, elm, subtype )
					if( s <> NULL ) then
						text = symbGetVarName( s )
        			else
						'' and const's
						s = symbLookupConst( text, lexTokenType )
						if( s <> NULL ) then
							text = symbGetConstText( s )
						end if
					end if
				end if
			end if
		end if

		lexSkipToken

		asmline = asmline + text + " "

	loop

	irFlush
	emitASM asmline

	cAsmCode = TRUE

end function

'':::::
''AsmBlock        =   ASM Comment? SttSeparator
''                        (AsmCode Comment? Newline)+
''					  END ASM .
function cAsmBlock
    dim res as integer

	cAsmBlock = FALSE

	'' ASM
	if( not hMatch( FB.TK.ASM ) ) then
		exit function
	end if

	'' Comment? SttSeparator
	res = cComment

	if( not cSttSeparator ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
	end if

	'' (AsmCode Comment? Newline)+
	do
		'' Comment? Newline?
		do while( (cComment <> FALSE) or hMatch( FB.TK.EOL ) )
		loop

		if( lexCurrentToken = FB.TK.END ) then
			exit do
		end if

		if( not cAsmCode ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		'' Comment? Newline
		res = cComment

		if( not hMatch( FB.TK.EOL ) ) then
    		hReportError FB.ERRMSG.SYNTAXERROR
    		exit function
		end if

	loop

	'' END ASM
	if( not hMatch( FB.TK.END ) ) then
    	hReportError FB.ERRMSG.EXPECTEDENDASM
    	exit function
	elseif( not hMatch( FB.TK.ASM ) ) then
    	hReportError FB.ERRMSG.EXPECTEDENDASM
    	exit function
	end if


	cAsmBlock = TRUE

end function

