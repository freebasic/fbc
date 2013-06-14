'' quirk file statements and functions (PRINT, WRITE, OPEN, ...) parsing
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'':::::
'' PrintStmt	  =   (PRINT|'?') ('#' Expression ',')? (USING Expression{str} ';')? (Expression? ';'|"," )*
''
function cPrintStmt  _
	( _
		byval tk as FB_TOKEN _
	) as integer

	dim as ASTNODE ptr usingexpr, filexpr, filexprcopy, expr
	dim as integer expressions, issemicolon, iscomma, istab, isspc, islprint

	function = FALSE

	'' (PRINT|'?')
	select case tk
	case FB_TK_PRINT, CHAR_QUESTION
		islprint = FALSE

	case FB_TK_LPRINT
		if( fbLangOptIsSet( FB_LANG_OPT_OPTION ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_OPTION )
		else
			islprint = TRUE
		end if

	case else
		exit function
	end select

	lexSkipToken( )

	if( islprint ) then
		filexpr = astNewCONSTi( -1 )
	else
		'' ('#' Expression)?
		if( hMatch( CHAR_SHARP ) ) then
			hMatchExpressionEx( filexpr, FB_DATATYPE_INTEGER )
			hMatchCOMMA( )
		else
			filexpr = astNewCONSTi( 0 )
		end if
	end if

	'' side-effect?
	'' (vars may also cause side-effects if modified by printed expressions)
	if( astIsCONST( filexpr ) = FALSE ) then
		astAdd( astRemSideFx( filexpr ) )
	end if

	usingexpr = NULL

	'' (Expression?|SPC(Expression)|TAB(Expression) ';'|"," )*
	expressions = 0
	do

		'' (USING Expression{str} ';')?
		if( hMatch( FB_TK_USING ) ) then

			if( usingexpr <> NULL ) then
#if 1 '' remove this to allow multiple USINGs on one line
				errReport( FB_ERRMSG_EXPECTEDEOL )
#endif
				filexprcopy = astCloneTree( filexpr )
				if( rtlPrintUsingEnd( filexprcopy, _
				                      islprint ) = FALSE ) then
					exit function
				end if
			end if

			hMatchExpressionEx( usingexpr, FB_DATATYPE_STRING )

			if( hMatch( CHAR_SEMICOLON ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTEDSEMICOLON )
			end if

			if( rtlPrintUsingInit( usingexpr, islprint ) = FALSE ) then
				exit function
			end if
		end if

		'' (Expression?|SPC(Expression)|TAB(Expression)
		isspc = FALSE
		istab = FALSE
		if( hMatch( FB_TK_SPC ) ) then
			isspc = TRUE
			hMatchLPRNT( )
			hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
			hMatchRPRNT( )
		elseif( hMatch( FB_TK_TAB ) ) then
			istab = TRUE
			hMatchLPRNT( )
			hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
			hMatchRPRNT( )
		else
			expr = cExpression( )
		end if

		iscomma = FALSE
		issemicolon = FALSE
		if( hMatch( CHAR_COMMA ) ) then
            if( usingexpr <> NULL ) then
				'' QB automatically converted them to semi-colons in the editor.
                errReport( FB_ERRMSG_EXPECTEDSEMICOLON )
            end if
			iscomma = TRUE
		elseif( hMatch( CHAR_SEMICOLON ) ) then
			issemicolon = TRUE
		end if

		'' handle PRINT w/o expressions
		if( (iscomma = FALSE) and _
			(issemicolon = FALSE) and _
			(expr = NULL) ) then
			exit do
		end if

		if( isspc ) then
			filexprcopy = astCloneTree( filexpr )
			if( rtlPrintSPC( filexprcopy, _
							 expr, _
							 islprint ) = FALSE ) then
				exit function
			end if

		elseif( istab ) then
			filexprcopy = astCloneTree( filexpr )
			if( rtlPrintTab( filexprcopy, _
							 expr, _
							 islprint ) = FALSE ) then
				exit function
			end if

		else
			if( usingexpr = NULL /'or expr = NULL'/ ) then
			/' (commented check allows multiple consecutive commas/semicolons in USING statements.
			   QB doesn't support it though, so I'm not sure we should. '/
				filexprcopy = astCloneTree( filexpr )
				if( rtlPrint( filexprcopy, _
							  iscomma, _
							  issemicolon, _
							  expr, _
							  islprint ) = FALSE ) then
					errReport( FB_ERRMSG_INVALIDDATATYPES )
				end if

			else
				filexprcopy = astCloneTree( filexpr )
				if( rtlPrintUsing( filexprcopy, _
								   expr, _
								   iscomma, _
								   issemicolon, _
								   islprint ) = FALSE ) then
					errReport( FB_ERRMSG_INVALIDDATATYPES )
				end if
			end if
		end if

		expressions += 1
	loop while( iscomma or issemicolon )

	if( usingexpr = NULL ) then
		if( expressions = 0 ) then
			filexprcopy = astCloneTree( filexpr )
			if( rtlPrint( filexprcopy, _
						  FALSE, _
						  FALSE, _
						  NULL, _
						  islprint ) = FALSE ) then
				exit function
			end if
		end if
	else
		filexprcopy = astCloneTree( filexpr )
		if( rtlPrintUsingEnd( filexprcopy, _
							  islprint ) = FALSE ) then
			exit function
		end if
	end if

	''
	astDelTree( filexpr )

	function = TRUE

end function

'':::::
'' WriteStmt	  =   WRITE ('#' Expression)? (Expression? "," )*
''
function cWriteStmt() as integer
    dim as ASTNODE ptr filexpr, filexprcopy, expr
    dim as integer expressions, iscomma

	function = FALSE

	'' WRITE
	lexSkipToken( )

	'' ('#' Expression)?
	if( hMatch( CHAR_SHARP ) ) then
		hMatchExpressionEx( filexpr, FB_DATATYPE_INTEGER )

		hMatchCOMMA( )

    else
		filexpr = astNewCONSTi( 0 )
	end if

	'' side-effect?
	'' (vars may also cause side-effects if modified by printed expressions)
	if( astIsCONST( filexpr ) = FALSE ) then
		astAdd( astRemSideFx( filexpr ) )
	end if

    '' (Expression? "," )*
    expressions = 0
    do
		expr = cExpression( )
		if( expr = NULL ) then
        	expr = NULL
        end if

		iscomma = FALSE
		if( hMatch( CHAR_COMMA ) ) then
			iscomma = TRUE
		end if

    	filexprcopy = astCloneTree( filexpr )

    	'' handle WRITE w/o expressions
    	if( (iscomma = FALSE) and (expr = NULL) ) then
    		if( expressions = 0 ) then
    			rtlWrite( filexprcopy, FALSE, NULL )
    		end if

    		exit do
    	end if

    	if( rtlWrite( filexprcopy, iscomma, expr ) = FALSE ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
    	end if

    	expressions += 1
    loop while( iscomma )

    ''
    astDelTree( filexpr )

	function = TRUE
end function

'':::::
'' LineInputStmt	  =   LINE INPUT ';'? ('#' Expression| Expression{str}?) (','|';')? Variable? .
''
function cLineInputStmt _
	( _
		_
	) as integer

    dim as ASTNODE ptr expr, dstexpr
    dim as integer isfile, addnewline, issep, addquestion

	function = FALSE

	'' INPUT
	if( lexGetLookAhead( 1 ) <> FB_TK_INPUT ) then
		exit function
	end if

	lexSkipToken( )
	lexSkipToken( )

	'' ';'?
	addnewline = (hMatch( CHAR_SEMICOLON ) = FALSE)

	'' '#'?
	isfile = FALSE
	if( hMatch( CHAR_SHARP ) ) then
		isfile = TRUE
	end if

	'' Expression?
	expr = cExpression( )
	if( expr = NULL ) then
		if( isfile ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			expr = astNewCONSTi( 0 )
		else
			expr = NULL
		end if
	end if

	'' ','|';'?
	issep = TRUE
	if( hMatch( CHAR_COMMA ) = FALSE ) then
		if( hMatch( CHAR_SEMICOLON ) = FALSE ) then
			issep = FALSE
			if( (expr = NULL) or (isfile) ) then
				errReport( FB_ERRMSG_EXPECTEDCOMMA )
			end if
        else
        	addquestion = TRUE
		end if
    else
        addquestion = FALSE
	end if

    '' Variable?
	dstexpr = cVarOrDeref( )
	if( dstexpr = NULL ) then
		if( (expr = NULL) or (isfile) ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			hSkipStmt( )
			return TRUE
		else
			dstexpr = expr
			expr = NULL
		end if
	else
		if( issep = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDCOMMA )
		end if
	end if

	'' dest can't be a top-level const
	if( typeIsConst( astGetFullType( dstexpr ) ) ) then
		errReport( FB_ERRMSG_CONSTANTCANTBECHANGED )
	end if

    select case astGetDataType( dstexpr )
    case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
    	function = rtlFileLineInput( isfile, expr, dstexpr, addquestion, addnewline )

    case FB_DATATYPE_WCHAR
    	function = rtlFileLineInputWstr( isfile, expr, dstexpr, addquestion, addnewline )

    '' not a string?
    case else
		astDelTree( dstexpr )
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		return TRUE
    end select

end function

'':::::
'' InputStmt	  =   INPUT ';'? (('#' Expression| STRING_LIT) (','|';'))? Variable (',' Variable)*
''
function cInputStmt _
	( _
		_
	) as integer

    dim as ASTNODE ptr filestrexpr, dstexpr
	dim as integer islast, isfile, addnewline, addquestion

	function = FALSE

	'' INPUT
	lexSkipToken( )

	'' ';'?
	addnewline = (hMatch( CHAR_SEMICOLON ) = FALSE)

	'' '#'?
	addquestion = FALSE
	if( hMatch( CHAR_SHARP ) ) then
		isfile = TRUE
		'' Expression
		hMatchExpressionEx( filestrexpr, FB_DATATYPE_INTEGER )

    else
    	isfile = FALSE
    	'' STRING_LIT?
    	if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
			filestrexpr = astNewVAR( symbAllocStrConst( *lexGetText( ), lexGetTextLen( ) ) )
			lexSkipToken( )
    	else
    		filestrexpr = NULL
			addquestion = TRUE
    	end if
	end if

	'' ','|';'
	if( (isfile) or (filestrexpr <> NULL) ) then
		if( hMatch( CHAR_COMMA ) = FALSE ) then
			if( hMatch( CHAR_SEMICOLON ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTEDCOMMA )
			else
				addquestion = TRUE
			end if
		end if
	end if

	''
	if( rtlFileInput( isfile, filestrexpr, addquestion, addnewline ) = FALSE ) then
		exit function
	end if

    '' Variable (',' Variable)*
    do
		dstexpr = cVarOrDeref( )
		if( dstexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			dstexpr = NULL
			hSkipUntil( CHAR_COMMA )
		end if

		if( hMatch( CHAR_COMMA ) ) then
			islast = FALSE
		else
			islast = TRUE
		end if

		if( dstexpr <> NULL ) then
			'' dest can't be a top-level const
			if( typeIsConst( astGetFullType( dstexpr ) ) ) then
				errReport( FB_ERRMSG_CONSTANTCANTBECHANGED )
			end if

			if( rtlFileInputGet( dstexpr ) = FALSE ) then
				exit function
			end if
		end if

    loop until( islast )

    function = TRUE

end function

'':::::
private function hFileClose _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as integer cnt
	dim as ASTNODE ptr filenum, proc

	function = NULL

	'' CLOSE
	lexSkipToken( )

	if( isfunc ) then
		'' '('
		hMatchLPRNT( )
	end if

	cnt = 0
	do
		hMatch( CHAR_SHARP )

    	filenum = cExpression( )
    	if( filenum = NULL ) then
			if( cnt = 0 ) then
				'' pass NULL to rtlFileClose to get close-all function
			else
				errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				filenum = astNewCONSTi( 0 )
			end if
		end if

		proc = rtlFileClose( filenum, isfunc )
		if( proc = NULL ) then
			exit function
		end if

		if( isfunc ) then
			exit do
		end if

		cnt += 1

	loop while( hMatch( CHAR_COMMA ) )

	if( isfunc ) then
		'' ')'
		hMatchRPRNT( )
	end if

	function = proc

end function

'':::::
'' Put			= PUT '#' Expression ',' Expression? ',' Expression{str|int|float|array} (',' Expression)?
''
private function hFilePut _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr fileexpr, posexpr, srcexpr, elmexpr
	dim as integer isarray
	dim as FBSYMBOL ptr s

	function = NULL

	'' '#'?
	if( lexGetToken( ) = CHAR_SHARP ) then
		lexSkipToken( )
	end if

	hMatchExpressionEx( fileexpr, FB_DATATYPE_INTEGER )

	'' ',' offset
	hMatchCOMMA( )

	posexpr = cExpression( )
	if( posexpr = NULL ) then
		posexpr = NULL
	end if

	'' ',' source
	hMatchCOMMA( )

	hMatchExpressionEx( srcexpr, FB_DATATYPE_INTEGER )

	'' don't allow literal values, due the way "byref as
	'' any" args work (ie, the VB-way: literals are passed by value)
	if( astIsCONST( srcexpr ) or astIsOFFSET( srcexpr ) ) then
		astDelTree( srcexpr )
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER, TRUE )
		if( isfunc ) then
			hSkipUntil( CHAR_RPRNT )
		else
			hSkipStmt( )
		end if
		return astNewCONSTi( 0 )
	end if

	isarray = FALSE
	if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then

    		s = astGetSymbol( srcexpr )
    		if( s <> NULL ) then
    			isarray = symbIsArray( s )
    			if( isarray ) then

    				'' don't allow var-len strings
    				if( symbGetType( s ) = FB_DATATYPE_STRING ) then
						astDelTree( srcexpr )
						errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
						if( isfunc ) then
							hSkipUntil( CHAR_RPRNT )
						else
							hSkipStmt( )
						end if
						return astNewCONSTi( 0 )
    				end if

    				lexSkipToken( )
    				lexSkipToken( )

				end if
    		end if
    	end if
	end if

	'' (',' elements)?
	if( hMatch( CHAR_COMMA ) ) then
		if( isarray ) then
			errReport( FB_ERRMSG_ELEMENTSMUSTBEEMPTY )
			'' error recovery: skip elements
			elmexpr = cExpression( )
			if( elmexpr <> NULL ) then
				astDelTree( elmexpr )
				elmexpr = NULL
			end if
		else
			'' don't allow elements if source is string type
			select case astGetDataType( srcexpr )
			case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR
				errReport( FB_ERRMSG_ELEMENTSMUSTBEEMPTY )
				'' error recovery: skip elements
				elmexpr = cExpression( )
				if( elmexpr <> NULL ) then
					astDelTree( elmexpr )
					elmexpr = NULL
				end if
			case else
				elmexpr = cExpression( )
				if( elmexpr = NULL ) then
					errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				end if
			end select
		end if

		'' elems has to be an integer or able to be converted
		if( elmexpr ) then
			if( typeIsPtr( astGetDatatype( elmexpr ) ) ) then
				errReportWarn( FB_WARNINGMSG_PASSINGPTRTOSCALAR )
			end if
			if( astGetDatatype( elmexpr ) <> FB_DATATYPE_INTEGER ) then
				elmexpr = astNewCONV( FB_DATATYPE_INTEGER, NULL, elmexpr )
				if( elmexpr = NULL ) then
					errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
				end if
			end if
		end if
	else
		elmexpr = NULL
	end if

	if( isarray = FALSE ) then
		function = rtlFilePut( fileexpr, posexpr, srcexpr, elmexpr, isfunc )
	else
		function = rtlFilePutArray( fileexpr, posexpr, srcexpr, isfunc )
	end if

end function

'':::::
'' Get			= GET '#' Expression ',' Expression? ',' Variable{str|int|float|array}
''                (',' Expression)? (',' variable)?
''
private function hFileGet _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr fileexpr, posexpr, dstexpr, elmexpr, iobexpr
	dim as integer isarray
	dim as FBSYMBOL ptr s

	function = NULL

	'' '#'?
	if( lexGetToken( ) = CHAR_SHARP ) then
		lexSkipToken( )
	end if

	hMatchExpressionEx( fileexpr, FB_DATATYPE_INTEGER )

	'' ',' offset
	hMatchCOMMA( )

	posexpr = cExpression( )

	'' ',' destine
	hMatchCOMMA( )

	dstexpr = cVarOrDeref( )
	if( dstexpr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		if( isfunc ) then
			hSkipUntil( CHAR_RPRNT )
		else
			hSkipStmt( )
		end if
		return astNewCONSTi( 0 )
	end if

	isarray = FALSE
	if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
    		s = astGetSymbol( dstexpr )
    		if( s <> NULL ) then
    			isarray = symbIsArray( s )
    			if( isarray ) then
    				'' don't allow var-len strings
    				if( symbGetType( s ) = FB_DATATYPE_STRING ) then
						errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
						if( isfunc ) then
							hSkipUntil( CHAR_RPRNT )
						else
							hSkipStmt( )
						end if
						return astNewCONSTi( 0 )
    				end if
    				lexSkipToken( )
    				lexSkipToken( )
    			end if
    		end if
    	end if
	end if

	'' (',' elements)?
	if( hMatch( CHAR_COMMA ) ) then
		elmexpr = cExpression( )
		if( isarray ) then
			'' elems must be NULL
			if( elmexpr <> NULL ) then
				errReport( FB_ERRMSG_ELEMENTSMUSTBEEMPTY )
				astDelTree( elmexpr )
				elmexpr = NULL
			end if
		else
			if( elmexpr ) then
				'' don't allow elements if destine is string type
				select case astGetDataType( dstexpr )
				case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR
					errReport( FB_ERRMSG_ELEMENTSMUSTBEEMPTY )
					'' error recovery: skip elements
					astDelTree( elmexpr )
					elmexpr = NULL
				case else
					'' elems has to be an integer or able to be converted
					if( typeIsPtr( astGetDatatype( elmexpr ) ) ) then
						errReportWarn( FB_WARNINGMSG_PASSINGPTRTOSCALAR )
					end if
					if( astGetDatatype( elmexpr ) <> FB_DATATYPE_INTEGER ) then
						elmexpr = astNewCONV( FB_DATATYPE_INTEGER, NULL, elmexpr )
						if( elmexpr = NULL ) then
							errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
						end if
					end if
				end select
			end if
		end if
	else
		elmexpr = NULL
	end if

	'' (',' iobytes)?
	if( hMatch( CHAR_COMMA ) ) then
		iobexpr = cVarOrDeref( )
		if( iobexpr <> NULL ) then
			s = astGetSymbol( iobexpr )
			if( s <> NULL ) then
				dim isint as integer = FALSE

				'' must be integer
				select case symbGetType( s )
				case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT
					isint = TRUE
				case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
					isint = ( FB_LONGSIZE = FB_INTEGERSIZE )
				end select

				if( isint = FALSE ) then
					errReport( FB_ERRMSG_INVALIDDATATYPES )
				end if
			end if
		else
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		end if
	else
		iobexpr = NULL
	end if

	'' dest can't be a top-level const
	if( typeIsConst( astGetFullType( dstexpr ) ) ) then
		errReport( FB_ERRMSG_CONSTANTCANTBECHANGED )
	end if

	'' iobytes can't be a top-level const
	if( iobexpr ) then
		if( typeIsConst( astGetFullType( iobexpr ) ) ) then
			errReport( FB_ERRMSG_CONSTANTCANTBECHANGED )
		end if
	end if

	if( isarray = FALSE ) then
		function = rtlFileGet( fileexpr, posexpr, dstexpr, elmexpr, iobexpr, isfunc )
	else
		function = rtlFileGetArray( fileexpr, posexpr, dstexpr, iobexpr, isfunc )
	end if

end function

'':::::
'' FileOpen		=	OPEN Expression{str}
''						 (FOR Expression)? (ENCODING Expression)?
''						 (ACCESS Expression)?
''						 (SHARED|LOCK (READ|WRITE|READ WRITE))?
''						 AS '#'? Expression
''						 (LEN '=' Expression)?
''
'' 					OPEN ("O"|"I"|"B"|"R"|"A")',' '#'? Expression{int}',' Expression{str} (',' Expression{int})?
''
private function hFileOpen _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr filenum, filename, fmode, faccess, flock, flen, fencoding
    dim as integer short_form
	dim as integer file_mode, access_mode, lock_mode, record_len
    dim as FBOPENKIND open_kind

	function = NULL

    open_kind = FB_FILE_TYPE_FILE

    short_form = FALSE

    '' if it's a qb-style open, we only get an identifier, or a literal
    if( fbLangIsSet( FB_LANG_QB ) = FALSE ) then
		'' special devices
		select case ucase( *lexGetText( ) )
	    case "CONS"
			'' not a symbol?
			if( lexGetSymChain( ) = NULL ) then
				lexSkipToken( )
	    		open_kind = FB_FILE_TYPE_CONS
	    	end if

	    case "ERR"
			lexSkipToken( )
	        open_kind = FB_FILE_TYPE_ERR

	    case "PIPE"
			'' not a symbol?
			if( lexGetSymChain( ) = NULL ) then
				lexSkipToken( )
	        	open_kind = FB_FILE_TYPE_PIPE
	        end if

	    case "SCRN"
			'' not a symbol?
			if( lexGetSymChain( ) = NULL ) then
				lexSkipToken( )
	        	open_kind = FB_FILE_TYPE_SCRN
	        end if

	    case "LPT"
			'' not a symbol?
			if( lexGetSymChain( ) = NULL ) then
				lexSkipToken( )
	    		open_kind = FB_FILE_TYPE_LPT
	    	end if

	    case "COM"
			'' not a symbol?
			if( lexGetSymChain( ) = NULL ) then
				lexSkipToken( )
	    		open_kind = FB_FILE_TYPE_COM
	    	end if
	    end select

	end if

	if( isfunc ) then
		'' '('
		hMatchLPRNT( )
	end if

    '' if it's a qb-style open, we only get an identifier, or a literal
    if( fbLangIsSet( FB_LANG_QB ) ) then
    	open_kind = FB_FILE_TYPE_QB
	end if

    select case as const open_kind
    case FB_FILE_TYPE_FILE, FB_FILE_TYPE_PIPE, FB_FILE_TYPE_LPT, _
    	 FB_FILE_TYPE_COM, FB_FILE_TYPE_QB

        '' a filename is only valid for some file types

		hMatchExpressionEx( filename, FB_DATATYPE_STRING )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        ' only test for short OPEN form when using the "normal" OPEN
        select case open_kind
        case FB_FILE_TYPE_FILE, FB_FILE_TYPE_QB
	        if( isfunc ) then
                select case lexGetToken( )
                case FB_TK_FOR, FB_TK_ACCESS, FB_TK_AS
                case else
                    short_form = TRUE
                end select
	        else
	            if( hMatch( CHAR_COMMA ) ) then
	                '' ',' -> indicates the short form
	                short_form = TRUE
	            end if
            end if
        end select

    case else

        ' no file name provided for this kind of OPEN statmenets
    	filename = astNewCONSTstr( "" )

    end select

    if( short_form ) then
        '' file mode ("I"|"O"|"A"|"B"|"R")
        fmode = filename
        filename = NULL

        '' '#'? file number
        hMatch( CHAR_SHARP )
        hMatchExpressionEx( filenum, FB_DATATYPE_INTEGER )

        hMatchCOMMA( )
        '' file name
        hMatchExpressionEx( filename, FB_DATATYPE_STRING )

        '' record length
        if( hMatch( CHAR_COMMA ) ) then
            if( lexGetToken( ) <> CHAR_COMMA ) then
            	hMatchExpressionEx( flen, FB_DATATYPE_INTEGER )
            end if
            '' access mode
            if( hMatch( CHAR_COMMA ) ) then
                if( lexGetToken( ) <> CHAR_COMMA ) then
                    hMatchExpressionEx( faccess, FB_DATATYPE_STRING )
                end if
                '' lock mode
                if( hMatch( CHAR_COMMA ) ) then
                	hMatchExpressionEx( flock, FB_DATATYPE_STRING )
                end if
            end if
        end if

        if( flen = NULL ) then
			flen = astNewCONSTi( 0 )
        end if

        if( faccess = NULL ) then
        	faccess = astNewCONSTstr( "" )
        end if

        if( flock = NULL ) then
        	flock = astNewCONSTstr( "" )
        end if

    	if( isfunc ) then
        	'' ')'
        	hMatchRPRNT( )
    	end if

		return rtlFileOpenShort( filename, fmode, faccess, flock, _
								 filenum, flen, isfunc )
    end if

    '' long form..

	'' (FOR (INPUT|OUTPUT|BINARY|RANDOM|APPEND))?
	if( hMatch( FB_TK_FOR ) ) then
		select case ucase( *lexGetText( ) )
		case "INPUT"
			file_mode = FB_FILE_MODE_INPUT
		case "OUTPUT"
			file_mode = FB_FILE_MODE_OUTPUT
		case "BINARY"
			file_mode = FB_FILE_MODE_BINARY
		case "RANDOM"
			file_mode = FB_FILE_MODE_RANDOM
		case "APPEND"
			file_mode = FB_FILE_MODE_APPEND
		case else
			exit function
		end select

		lexSkipToken( )

	else
		file_mode = FB_FILE_MODE_RANDOM
	end if

	fmode = astNewCONSTi( file_mode )

	if( isfunc ) then
		'' ','?
		hMatch( CHAR_COMMA )
	end if

	fencoding = NULL

	if( fbLangIsSet( FB_LANG_QB ) ) = FALSE then
		'' ENCODING is only allowed in text-mode
		select case file_mode
		case FB_FILE_MODE_INPUT, FB_FILE_MODE_OUTPUT, FB_FILE_MODE_APPEND
			'' (ENCODING Expression)?
			if( hMatch( FB_TK_ENCODING ) ) then
				hMatchExpressionEx( fencoding, FB_DATATYPE_STRING )

				if( isfunc ) then
					'' ','?
					hMatch( CHAR_COMMA )
				end if
			end if
		end select
	end if

	'' (ACCESS (READ|WRITE|READ WRITE))?
	if( hMatchText( "ACCESS" ) ) then
		select case ucase( *lexGetText( ) )
		case "WRITE"
			lexSkipToken( )
			access_mode = FB_FILE_ACCESS_WRITE

		case "READ"
			lexSkipToken( )
			if( hMatch( FB_TK_WRITE ) ) then
				access_mode = FB_FILE_ACCESS_READWRITE
			else
				access_mode = FB_FILE_ACCESS_READ
			end if
		end select
	else
		access_mode = FB_FILE_ACCESS_ANY
	end if

	faccess = astNewCONSTi( access_mode )

	if( isfunc ) then
		'' ','?
		hMatch( CHAR_COMMA )
	end if

	'' (SHARED|LOCK (READ|WRITE|READ WRITE))?
	if( hMatch( FB_TK_SHARED ) ) then
		lock_mode = FB_FILE_LOCK_SHARED

	elseif( hMatchText( "LOCK" ) ) then
		select case ucase( *lexGetText( ) )
		case "WRITE"
			lexSkipToken( )
			lock_mode = FB_FILE_LOCK_WRITE

		case "READ"
			lexSkipToken( )
			if( hMatch( FB_TK_WRITE ) ) then
				lock_mode = FB_FILE_LOCK_READWRITE
			else
				lock_mode = FB_FILE_LOCK_READ
			end if
		end select
	else
		lock_mode = FB_FILE_LOCK_SHARED
	end if

	flock = astNewCONSTi( lock_mode )

	if( isfunc ) then
		'' ','?
		hMatch( CHAR_COMMA )
	end if

	'' AS '#'? Expression
	if( hMatch( FB_TK_AS ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTINGAS )
	end if

	hMatch( CHAR_SHARP )

	hMatchExpressionEx( filenum, FB_DATATYPE_INTEGER )

	if( isfunc ) then
		'' ','?
		hMatch( CHAR_COMMA )
	end if

	'' (LEN '=' Expression)?
	if( hMatchText( "LEN" ) ) then
		if( cAssignToken( ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDEQ )
			flen = astNewCONSTi( 0 )
		else
			hMatchExpressionEx( flen, FB_DATATYPE_INTEGER )
		end if
	else
		flen = astNewCONSTi( 0 )
	end if

    if( isfunc ) then
        '' ')'
        hMatchRPRNT( )
    end if

	''
	function = rtlFileOpen( filename, fmode, faccess, flock, _
							filenum, flen, fencoding, isfunc, open_kind )

end function

'':::::
private function hFileRename _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr filename_old, filename_new
	dim as integer matchprnt

	function = NULL

	'' '('
    if( isfunc ) then
		hMatchLPRNT( )
    else
		'' '('?
       	matchprnt = hMatch( CHAR_LPRNT )
    end if

	hMatchExpressionEx( filename_old, FB_DATATYPE_STRING )

	if( isfunc ) then
		'' ','?
		hMatchCOMMA( )
	else
		if( hMatch( FB_TK_AS ) = FALSE ) then
			if( hMatch( CHAR_COMMA ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTINGAS )
			end if
		end if
	end if

	hMatchExpressionEx( filename_new, FB_DATATYPE_STRING )

	if( isfunc or matchprnt ) then
		'' ')'
		hMatchRPRNT( )
	end if

	''
	function = rtlFileRename( filename_new, filename_old, isfunc )

end function

'':::::
'' FileStmt		  =	   OPEN ...
''				  |	   CLOSE ...
''				  |	   SEEK ...
''				  |    LOCK ...
''				  |	   ...
function cFileStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

    dim as ASTNODE ptr filenum, expr1, expr2
    dim as integer islock

	function = FALSE

	select case as const tk
	case FB_TK_OPEN
		lexSkipToken( )

		function = (hFileOpen( FALSE ) <> NULL)


	'' CLOSE ('#'? Expression)*
	case FB_TK_CLOSE

		function = (hFileClose( FALSE ) <> NULL)

	'' SEEK '#'? Expression ',' Expression
	case FB_TK_SEEK
		lexSkipToken( )
		hMatch( CHAR_SHARP )

		hMatchExpressionEx( filenum, FB_DATATYPE_INTEGER )

		hMatchCOMMA( )

		hMatchExpressionEx( expr1, FB_DATATYPE_INTEGER )

		function = rtlFileSeek( filenum, expr1 )

	'' PUT '#' Expression ',' Expression? ',' Expression{str|int|float|array}
	case FB_TK_PUT
		if( lexGetLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if

		lexSkipToken( )

        function = (hFilePut( FALSE ) <> NULL)

	'' GET '#' Expression ',' Expression? ',' Variable{str|int|float|array}
	case FB_TK_GET
		if( lexGetLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if

		lexSkipToken( )

		function = (hFileGet( FALSE ) <> NULL)

	'' (LOCK|UNLOCK) '#'? Expression, Expression (TO Expression)?
	case FB_TK_LOCK, FB_TK_UNLOCK
		if( tk = FB_TK_LOCK ) then
			islock = TRUE
		else
			islock = FALSE
		end if

		lexSkipToken( )

		hMatch( CHAR_SHARP )

		hMatchExpressionEx( filenum, FB_DATATYPE_INTEGER )

		hMatchCOMMA( )

		hMatchExpressionEx( expr1, FB_DATATYPE_INTEGER )

		if( hMatch( FB_TK_TO ) ) then
			hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )
		else
			expr2 = astNewCONSTi( 0 )
		end if

		function = rtlFileLock( islock, filenum, expr1, expr2 )

    '' NAME oldfilespec$ AS newfilespec$
    case FB_TK_NAME
		lexSkipToken( )

		function = (hFileRename( FALSE ) <> NULL)

	end select

end function

'':::::
'' FileFunct =   SEEK '(' Expression ')' |
''				 INPUT '(' Expr, (',' '#'? Expr)? ')'.
''
function cFileFunct(byval tk as FB_TOKEN) as ASTNODE ptr
	dim as ASTNODE ptr filenum, expr

	function = NULL

	'' SEEK '(' Expression ')'
	select case as const tk
	case FB_TK_SEEK
		lexSkipToken( )
		hMatchLPRNT( )
		hMatchExpressionEx( filenum, FB_DATATYPE_INTEGER )
		hMatchRPRNT( )
		function = rtlFileTell( filenum )

	'' INPUT|WINPUT '(' Expr (',' '#'? Expr)? ')'
	case FB_TK_INPUT, FB_TK_WINPUT
		lexSkipToken( )
		hMatchLPRNT( )
		hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
		if( hMatch( CHAR_COMMA ) ) then
			hMatch( CHAR_SHARP )
			hMatchExpressionEx( filenum, FB_DATATYPE_INTEGER )
		else
			filenum = astNewCONSTi( 0 )
		end if
		hMatchRPRNT( )
		function = rtlFileStrInput( expr, filenum, tk )

	'' OPEN '(' ... ')'
	case FB_TK_OPEN
		lexSkipToken( )
		function = hFileOpen( TRUE )

	'' CLOSE '(' '#'? Expr? ')'
	case FB_TK_CLOSE
		function = hFileClose( TRUE )

	'' PUT '(' '#'? Expr, Expr?, Expr ')'
	case FB_TK_PUT
		lexSkipToken( )
		hMatchLPRNT( )
		function = hFilePut( TRUE )
		hMatchRPRNT( )

	'' GET '(' '#'? Expr, Expr?, Expr ')'
	case FB_TK_GET
		lexSkipToken( )
		hMatchLPRNT( )
		function = hFileGet( TRUE )
		hMatchRPRNT( )

	'' NAME '(' oldfilespec$ ',' newfilespec$ ')'
	case FB_TK_NAME
		lexSkipToken( )
		function = hFileRename( TRUE )

	end select
end function
