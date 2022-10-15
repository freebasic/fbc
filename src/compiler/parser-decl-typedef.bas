'' typedef (TYPE foo AS bar) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

private sub hPtrDecl(byref dtype as integer)
	dim as integer ptr_cnt = 0

	'' (CONST (PTR|POINTER) | (PTR|POINTER))*
	do
		select case as const lexGetToken( )
		'' CONST PTR?
		case FB_TK_CONST
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			select case lexGetToken( )
			case FB_TK_PTR, FB_TK_POINTER
				if( ptr_cnt >= FB_DT_PTRLEVELS ) then
					errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS )
				else
					dtype = typeSetIsConst( typeAddrOf( dtype ) )
					ptr_cnt += 1
				end if

				lexSkipToken( LEXCHECK_POST_SUFFIX )

			case else
				errReport( FB_ERRMSG_EXPECTEDPTRORPOINTER )
				exit do
			end select

		'' PTR|POINTER?
		case FB_TK_PTR, FB_TK_POINTER
			if( ptr_cnt >= FB_DT_PTRLEVELS ) then
				errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS )
			else
				dtype = typeAddrOf( dtype )
				ptr_cnt += 1
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )

		case else
			exit do
		end select
	loop
end sub

private function hReadType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint, _
		byref is_fixlenstr as integer _
	) as zstring ptr

	static as zstring * FB_MAXNAMELEN+1 tname

	if( cSymbolType( dtype, subtype, lgt, is_fixlenstr, FB_SYMBTYPEOPT_ALLOWFORWARD ) ) then
		return NULL
	end if

	'' Everything not recognized by cSymbolType() is either still undefined,
	'' so we'll make it a forward ref, or it's an existing forward ref, and
	'' we'll look it up.
	'' Note: cSymbolType() could have parsed a CONST before the unknown typname

	'' Get the forward ref's name
	'' The forward reference identifier can be anything that's valid for
	'' UDTs. The UDT must be declared to resolve the forward reference, and
	'' there's no point allowing names that couldn't be used then.
	select case( lexGetClass( ) )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD
		tname = *lexGetText( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		tname = *symbUniqueId( )
		hSkipStmt( )
	end select

	'' Parse any PTR's since cSymbolType() didn't handle it
	'' dtype is modified as needed
	hPtrDecl( dtype )

	function = @tname
end function

private sub hAddForwardRef _
	( _
		byval pid as zstring ptr, _
		byval pfwdname as zstring ptr, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint, _
		byref is_fixlenstr as integer, _
		byval attrib as FB_SYMBATTRIB _
	)

	dim as integer ptrcount = typeGetPtrCnt( dtype )
	dim as integer constmask = typeGetConstMask( dtype )

	'' Pointing to itself (TYPE X AS X)? Then it's a void...
	hUcase( pfwdname, pfwdname )
	hUcase( pid, pid )
	if( *pfwdname = *pid ) then

		''dtype = typeJoin( dtype, FB_DATATYPE_VOID )
		dtype = FB_DATATYPE_VOID

		/'
		dtype = (dtype and not FB_DT_TYPEMASK) or FB_DATATYPE_VOID
		'/

		subtype = NULL
		lgt = 0
		is_fixlenstr = FALSE
	else

		'' The typeJoin()'s will remove the PTR's off the typedef's type, but we
		'' want to preserve them, so we need to restore them later.
		'' But typeJoin() doesn't adjust the CONST mask -- that seems wrong...
		'' (if PTR's are removed, their CONST should be removed aswell, if set)
		'' Because of that the type will seem to be const even though it isn't
		'' (CONST bits are set but ptrcount is 0),
		'' and the typeMultAddrOf() will preserve this error when adding back the
		'' pointer count...
		''dtype = typeJoin( dtype, FB_DATATYPE_FWDREF )

		'' So how about that: (dtype will be FB_DATATYPE_INVALID for fwdref's
		'' anyways, at best cSymbolType() and/or hPtrDecl() added CONST's/PTR's)
		dtype = FB_DATATYPE_FWDREF

		/'
		'' Or this way: Replace only the type but preserve everything else
		dtype = (dtype and not FB_DT_TYPEMASK) or FB_DATATYPE_FWDREF
		'/

		'' Create a forward reference
		subtype = symbAddFwdRef( pfwdname )
		lgt = -1

		if( subtype ) then
			'' set visibility flags
			subtype->attrib or= (attrib and FB_SYMBATTRIB_VIS_PRIVATE)
			subtype->attrib or= (attrib and FB_SYMBATTRIB_VIS_PROTECTED)
		end if

		'' Already exists? (happens e.g. with the multiple declaration syntax)
		if( subtype = NULL ) then
			'' Lookup the existing one
			subtype = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
			                                    pfwdname, _
			                                    FB_SYMBCLASS_FWDREF, _
			                                    TRUE, _
			                                    FALSE )

			if( subtype = NULL ) then
				errReport( FB_ERRMSG_DUPDEFINITION )
				'' error recovery: fake a symbol
				subtype = symbAddFwdRef( symbUniqueLabel( ) )

			end if
		end if
	end if

	'' Restore the PTR's & CONST's on the type
	dtype = typeMultAddrOf( dtype, ptrcount ) or constmask
end sub

private sub hAddTypedef _
	( _
		byval pid as zstring ptr, _
		byval pfwdname as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as longint, _
		byval is_fixlenstr as integer, _
		byval attrib as FB_SYMBATTRIB _
	)

	'' Forward ref? Note: may update dtype & co
	if( pfwdname <> NULL ) then
		hAddForwardRef( pid, pfwdname, dtype, subtype, lgt, is_fixlenstr, attrib )
	end if

	dim as FBSYMBOL ptr typedef = symbAddTypedef( pid, dtype, subtype, lgt )
	if( typedef ) then
		if( is_fixlenstr ) then
			symbSetIsFixLenStr( typedef )
		end if

		'' set visibility flags
		typedef->attrib or= (attrib and FB_SYMBATTRIB_VIS_PRIVATE)
		typedef->attrib or= (attrib and FB_SYMBATTRIB_VIS_PROTECTED)
	else
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
			errReport( FB_ERRMSG_DUPDEFINITION, TRUE )
		end if
	end if
end sub

private function hReadId( ) as zstring ptr

	static as zstring * FB_MAXNAMELEN+1 id

	'' Namespace identifier if it matches the current namespace
	cCurrentParentId()

	select case as const lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
				if( lexGetPeriodPos( ) > 0 ) then
					errReport( FB_ERRMSG_CANTINCLUDEPERIODS )
				end if
			end if
		end if

		id = *lexGetText( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake an id
		id = *symbUniqueLabel( )
	end select

	function = @id

end function

'' MultipleTypedef  =  TYPE AS SymbolType symbol (',' symbol)*
sub cTypedefMultDecl( byval attrib as FB_SYMBATTRIB )
	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
		exit sub
	end if

	'' AS
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' SymtolType
	dim as integer dtype, is_fixlenstr
	dim as longint lgt
	dim as FBSYMBOL ptr subtype
	var pfwdname = hReadType( dtype, subtype, lgt, is_fixlenstr )

	do
		'' Parse the ID
		var pid = hReadId( )

		hAddTypedef( pid, pfwdname, dtype, subtype, lgt, is_fixlenstr, attrib )

		'' ','?
	loop while( hMatch( CHAR_COMMA ) )
end sub

'' SingleTypedef  =  TYPE symbol AS SymbolType (',' symbol AS SymbolType)*
sub cTypedefSingleDecl( byval attrib as FB_SYMBATTRIB, byval pid as zstring ptr )
	'' note: given id can be Ucase()'d

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
		exit sub
	end if

	do
		'' AS?
		if( hMatch( FB_TK_AS, LEXCHECK_POST_SUFFIX ) = FALSE ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if

		'' SymtolType
		dim as integer dtype, is_fixlenstr
		dim as longint lgt
		dim as FBSYMBOL ptr subtype
		var pfwdname = hReadType( dtype, subtype, lgt, is_fixlenstr )

		hAddTypedef( pid, pfwdname, dtype, subtype, lgt, is_fixlenstr, attrib )

		'' ','?
		if( hMatch( CHAR_COMMA ) = FALSE ) then
			exit do
		end if

		'' Parse the next ID
		pid = hReadId( )
	loop
end sub
