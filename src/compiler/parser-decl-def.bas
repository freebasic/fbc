'' DEF### declarations
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

'' DefDecl  =  (DEFINT|DEFLNG|DEFSNG|DEFDBL|DEFSTR) (CHAR '-' CHAR ','?)* .
sub cDefDecl( )
	static as zstring * 32+1 char
	dim as integer dtype = any, ichar = any, echar = any

	if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_DEFTYPE )
		'' error recovery: skip stmt
		hSkipStmt( )
		exit sub
	end if

	'' QBASIC allows DEF___ in procs/compound statements, though even then
	'' it's still disallowed between SELECT and CASE
	if( cCompStmtIsAllowed( iif( fbLangIsSet( FB_LANG_QB ), _
				FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE, _
				FB_CMPSTMT_MASK_DECL ) ) = FALSE ) then
		hSkipStmt( )
		exit sub
	end if

	dtype = FB_DATATYPE_INVALID

	select case as const lexGetToken( )
	case FB_TK_DEFBYTE
		dtype = FB_DATATYPE_BYTE

	case FB_TK_DEFUBYTE
		dtype = FB_DATATYPE_UBYTE

	case FB_TK_DEFSHORT
		dtype = FB_DATATYPE_SHORT

	case FB_TK_DEFUSHORT
		dtype = FB_DATATYPE_USHORT

	case FB_TK_DEFINT
		dtype = env.lang.integerkeyworddtype

	case FB_TK_DEFUINT
		dtype = FB_DATATYPE_UINT

	case FB_TK_DEFLNG
		dtype = FB_DATATYPE_LONG

	case FB_TK_DEFULNG
		dtype = FB_DATATYPE_ULONG

	case FB_TK_DEFLNGINT
		dtype = FB_DATATYPE_LONGINT

	case FB_TK_DEFULNGINT
		dtype = FB_DATATYPE_ULONGINT

	case FB_TK_DEFSNG
		dtype = FB_DATATYPE_SINGLE

	case FB_TK_DEFDBL
		dtype = FB_DATATYPE_DOUBLE

	case FB_TK_DEFSTR
		dtype = FB_DATATYPE_STRING
	end select

	assert( dtype <> FB_DATATYPE_INVALID )
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' (CHAR '-' CHAR ','?)*
	do
		'' CHAR
		char = ucase( *lexGetText( ) )
		if( len( char ) <> 1 ) then
			errReport( FB_ERRMSG_EXPECTEDCOMMA )
		end if
		ichar = asc( char )
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' '-'
		if( lexGetToken( ) = CHAR_MINUS ) then
			lexSkipToken( )

			'' CHAR
			char = ucase( *lexGetText( ) )
			if( len( char ) <> 1 ) then
				errReport( FB_ERRMSG_EXPECTEDCOMMA )
			end if
			echar = asc( char )
			lexSkipToken( LEXCHECK_POST_SUFFIX )

		else
			echar = ichar
		end if

		symbSetDefType( ichar, echar, dtype )

		'' ','
		if( lexGetToken( ) <> CHAR_COMMA ) then
			exit do
		end if

		lexSkipToken( )
	loop
end sub
