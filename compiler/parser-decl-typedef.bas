'' typedef (TYPE foo AS bar) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

'':::::
private function hPtrDecl _
	( _
		byref dtype as integer _
	) as integer

    function = FALSE

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
						exit function
					end if
				else
					dtype = typeSetIsConst( typeAddrOf( dtype ) )
					ptr_cnt += 1
				end if

				lexSkipToken( )

			case else
				if( errReport( FB_ERRMSG_EXPECTEDPTRORPOINTER ) = FALSE ) then
                    exit function
				end if

				exit do
			end select

		'' PTR|POINTER?
		case FB_TK_PTR, FB_TK_POINTER
			if( ptr_cnt >= FB_DT_PTRLEVELS ) then
				if( errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS ) = FALSE ) then
                    exit function
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

	function = TRUE

end function

private function hReadType _
    ( _
        byref dtype as integer, _
        byref subtype as FBSYMBOL ptr, _
        byref lgt as integer _
    ) as zstring ptr

    static as zstring * FB_MAXNAMELEN+1 tname
    dim as zstring ptr pfwdname = any

    function = NULL

    if( cSymbolType( dtype, subtype, lgt, FB_SYMBTYPEOPT_NONE ) = FALSE ) then
        if( errGetLast( ) <> FB_ERRMSG_OK ) then
            exit function
        end if

        '' Everything not recognized by cSymbolType() is either still undefined,
        '' so we'll make it a forward ref, or it's an existing forward ref, and
        '' we'll look it up.
        '' Note: cSymbolType() could have parsed a CONST before the unknown typname

        '' Get the forward ref's name
        tname = *lexGetText( )
        pfwdname = @tname

        lexSkipToken( )

        '' Parse any PTR's since cSymbolType() didn't handle it
        '' dtype is modified as needed
        if( hPtrDecl( dtype ) = FALSE ) then
            exit function
        end if

        function = pfwdname
    end if

end function

private function hAddForwardRef _
    ( _
        byval pid as zstring ptr, _
        byval pfwdname as zstring ptr, _
        byref dtype as integer, _
        byref subtype as FBSYMBOL ptr, _
        byref lgt as integer _
    ) as integer

    function = FALSE

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

        '' Already exists? (happens e.g. with the multiple declaration syntax)
        if( subtype = NULL ) then
            '' Lookup the existing one
            subtype = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
                                                pfwdname, _
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

    '' Restore the PTR's & CONST's on the type
    dtype = typeMultAddrOf( dtype, ptrcount ) or constmask

    function = TRUE

end function

private function hAddTypedef _
    ( _
        byval pid as zstring ptr, _
        byval pfwdname as zstring ptr, _
        byval dtype as integer, _
        byval subtype as FBSYMBOL ptr, _
        byval lgt as integer _
    ) as integer

    function = FALSE

    '' Forward ref? Note: may update dtype & co
    if( pfwdname <> NULL ) then
        if( hAddForwardRef( pid, pfwdname, dtype, subtype, lgt ) = FALSE ) then
            exit function
        end if
    end if

    dim as FBSYMBOL ptr typedef = symbAddTypedef( pid, dtype, subtype, lgt )
    if( typedef = NULL ) then
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

    function = TRUE

end function

private function hReadId( ) as zstring ptr

    static as zstring * FB_MAXNAMELEN+1 id
    dim as FBSYMBOL ptr parent = any

    function = NULL

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

    function = @id

end function

'':::::
'' MultipleTypedef = TYPE AS SymbolType symbol (',' symbol)*
''
function cTypedefMultDecl _
    ( _
    ) as integer

    dim as zstring ptr pfwdname = any, pid = any
    dim as integer dtype = any, lgt = any
    dim as FBSYMBOL ptr subtype = any

    function = FALSE

    '' AS
    lexSkipToken( )

    '' SymtolType
    pfwdname = hReadType( dtype, subtype, lgt )

    do
        '' Parse the ID
        pid = hReadId( )
        if( pid = NULL ) then
            exit function
        end if

        if( hAddTypedef( pid, pfwdname, dtype, subtype, lgt ) = FALSE ) then
            exit function
        end if

    	'' ','?
    	if( lexGetToken( ) <> CHAR_COMMA ) then
    		exit do
    	end if

    	lexSkipToken( )
    loop

	function = TRUE

end function

'':::::
'' SingleTypedef = TYPE symbol AS SymbolType (',' symbol AS SymbolType)*
''
function cTypedefSingleDecl _
	( _
		byval pid as zstring ptr _				'' note: it can be Ucase()'d
	) as integer

    dim as zstring ptr pfwdname = any
    dim as integer dtype = any, lgt = any
    dim as FBSYMBOL ptr subtype = any

    function = FALSE

    do
        '' AS?
        if( lexGetToken( ) <> FB_TK_AS ) then
            if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
                exit function
            end if
        else
            lexSkipToken( )
        end if

        '' SymtolType
        pfwdname = hReadType( dtype, subtype, lgt )

        if( hAddTypedef( pid, pfwdname, dtype, subtype, lgt ) = FALSE ) then
            exit function
        end if

    	'' ','?
    	if( lexGetToken( ) <> CHAR_COMMA ) then
    		exit do
    	end if

    	lexSkipToken( )

        '' Parse the next ID
        pid = hReadId( )
        if( pid = NULL ) then
            exit function
        end if
    loop

	function = TRUE

end function
