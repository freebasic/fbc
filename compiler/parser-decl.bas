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
		return cProcDecl( )

	case FB_TK_DEFBYTE, FB_TK_DEFUBYTE, FB_TK_DEFSHORT, FB_TK_DEFUSHORT, _
		 FB_TK_DEFINT, FB_TK_DEFUINT, FB_TK_DEFLNG, FB_TK_DEFULNG, _
		 FB_TK_DEFSNG, FB_TK_DEFDBL, FB_TK_DEFSTR, _
		 FB_TK_DEFLNGINT, FB_TK_DEFULNGINT
		return cDefDecl( )

	case FB_TK_OPTION
		return cOptDecl( )

	end select

	select case as const lexGetToken( )
	case FB_TK_STATIC
		select case as const lexGetLookAhead( 1 )
		case FB_TK_FUNCTION, FB_TK_SUB, FB_TK_OPERATOR, _
			 FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR, FB_TK_PROPERTY
			function = cProcStmtBegin( attrib )

		case else
			function = cVariableDecl( attrib )
		end select

	case FB_TK_FUNCTION, FB_TK_SUB, FB_TK_DESTRUCTOR, FB_TK_PROPERTY
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			function = cProcStmtBegin( attrib )
		else
			'' not a FUNCTION|PROPERTY '=' ?
			if( lexGetLookAhead( 1 ) <> FB_TK_ASSIGN ) then
				function = cProcStmtBegin( )
			end if
		end if

	case FB_TK_CONSTRUCTOR
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			function = cProcStmtBegin( attrib )
		else
			'' ambiguity: it could be a constructor chain
			if( fbIsModLevel( ) ) then
				function = cProcStmtBegin( )
			end if
		end if

	case FB_TK_OPERATOR
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			function = cProcStmtBegin( attrib )
		else
			'' ambiguity: it could be the operator '=' body
			if( fbIsModLevel( ) ) then
				function = cProcStmtBegin( )
			else
				'' not OPERATOR '=' ?
				if( lexGetLookAhead( 1 ) <> FB_TK_ASSIGN ) then
					function = cProcStmtBegin( )
				end if
			end if
		end if

	case FB_TK_CONST
		function = cConstDecl( attrib )

	case FB_TK_TYPE, FB_TK_UNION
		function = cTypeDecl( attrib )

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
		end if

		function = FALSE
	end select

end function

sub hDeclCheckParent(byval s as FBSYMBOL ptr)
	select case symbGetClass( s )
	case FB_SYMBCLASS_NAMESPACE
		if( s <> symbGetCurrentNamespc( ) ) then
			errReport( FB_ERRMSG_DECLOUTSIDENAMESPC )
		end if

	case FB_SYMBCLASS_CLASS
		if( s <> symbGetCurrentNamespc( ) ) then
			errReport( FB_ERRMSG_DECLOUTSIDECLASS )
		end if

	end select
end sub
