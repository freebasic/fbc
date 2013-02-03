'' declarations top-level parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

'':::::
''Declaration     =   ConstDecl | TypeDecl | VariableDecl | ProcDecl | DefDecl | OptDecl.
''
function cDeclaration _
	( _
	) as integer

	dim as FB_SYMBATTRIB attrib = FB_SYMBATTRIB_NONE
	dim as integer tk = any

	function = FALSE

    '' QB mode?
    if( env.clopt.lang = FB_LANG_QB ) then
    	if( lexGetType() <> FB_DATATYPE_INVALID ) then
    		return FALSE
    	end if
    end if

	select case as const lexGetToken( )
	case FB_TK_PUBLIC
		 if( hCheckScope( ) ) then
		 	attrib = FB_SYMBATTRIB_PUBLIC
		 end if

		 lexSkipToken( )

	case FB_TK_PRIVATE
		if( hCheckScope( ) ) then
			attrib = FB_SYMBATTRIB_PRIVATE
		end if

		lexSkipToken( )

	case FB_TK_DECLARE
		cProcDecl( )
		return TRUE

	case FB_TK_DEFBYTE, FB_TK_DEFUBYTE, FB_TK_DEFSHORT, FB_TK_DEFUSHORT, _
		 FB_TK_DEFINT, FB_TK_DEFUINT, FB_TK_DEFLNG, FB_TK_DEFULNG, _
		 FB_TK_DEFSNG, FB_TK_DEFDBL, FB_TK_DEFSTR, _
		 FB_TK_DEFLNGINT, FB_TK_DEFULNGINT
		cDefDecl( )
		return TRUE

	case FB_TK_OPTION
		cOptDecl( )
		return TRUE

	end select

	tk = lexGetToken( )

	select case as const( tk )
	case FB_TK_STATIC, FB_TK_CONST, FB_TK_VIRTUAL, FB_TK_ABSTRACT
		'' STATIC? SUB|FUNCTION|...
		'' CONST? (ABSTRACT|VIRTUAL)? SUB|FUNCTION|...
		'' Note: ABSTRACT doesn't make sense on bodies, but it's still
		'' allowed here to let cProcStmtBegin() show a nice error.
		select case as const lexGetLookAhead( 1 )
		case FB_TK_FUNCTION, FB_TK_SUB, FB_TK_OPERATOR, _
		     FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR, FB_TK_PROPERTY, _
		     FB_TK_VIRTUAL, FB_TK_ABSTRACT
			cProcStmtBegin( attrib )
			function = TRUE
		case else
			select case( tk )
			case FB_TK_CONST
				cConstDecl( attrib )
				function = TRUE
			case FB_TK_STATIC
				function = cVariableDecl( attrib )
			case else
				errReport( FB_ERRMSG_SYNTAXERROR )
			end select
		end select

	case FB_TK_FUNCTION, FB_TK_SUB, FB_TK_DESTRUCTOR, FB_TK_PROPERTY
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			cProcStmtBegin( attrib )
			function = TRUE
		else
			'' not a FUNCTION|PROPERTY '=' ?
			if( lexGetLookAhead( 1 ) <> FB_TK_ASSIGN ) then
				cProcStmtBegin( )
				function = TRUE
			end if
		end if

	case FB_TK_CONSTRUCTOR
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			cProcStmtBegin( attrib )
			function = TRUE
		else
			'' ambiguity: it could be a constructor chain
			if( fbIsModLevel( ) ) then
				cProcStmtBegin( )
				function = TRUE
			end if
		end if

	case FB_TK_OPERATOR
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			cProcStmtBegin( attrib )
			function = TRUE
		else
			'' ambiguity: it could be the operator '=' body
			if( fbIsModLevel( ) ) then
				cProcStmtBegin( )
				function = TRUE
			else
				'' not OPERATOR '=' ?
				if( lexGetLookAhead( 1 ) <> FB_TK_ASSIGN ) then
					cProcStmtBegin( )
					function = TRUE
				end if
			end if
		end if

	case FB_TK_TYPE, FB_TK_UNION
		cTypeDecl( attrib )
		function = TRUE

	case FB_TK_ENUM
		cEnumDecl( attrib )
		function = TRUE

	case FB_TK_DIM, FB_TK_REDIM, FB_TK_COMMON, FB_TK_EXTERN
		function = cVariableDecl( attrib )

	case FB_TK_VAR
		cAutoVarDecl( attrib )
		function = TRUE

	case else
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
			hSkipStmt( )
			function = TRUE
		end if
	end select

end function
