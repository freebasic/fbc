'' complex (scoped with namespace and/or class) identifiers parsing
''
'' chng: may/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

'':::::
private sub hSkipSymbol( )

	do
		lexSkipToken( LEXCHECK_NOPERIOD )  '' should this have LEXCHECK_POST_SUFFIX?

		'' '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			exit do
		end if

		select case as const lexGetClass()
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

		case else
			exit do
		end select
	loop

end sub

'':::::
private function hGlobalId _
	( _
		byval options as FB_IDOPT = FB_IDOPT_SHOWERROR, _
		byref base_parent as FBSYMBOL ptr = NULL _
	) as FBSYMCHAIN ptr

	function = NULL

	'' another '.'?
	if( lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) = CHAR_DOT ) then
		'' skip the first '.'
		lexSkipToken( LEXCHECK_NOPERIOD )

	else
		'' inside a WITH block, a single '.' is ambiguous..
		if( parser.stmt.with ) then
			exit function
		end if
	end if

	if( (options and FB_IDOPT_ISDECL) <> 0 ) then
		'' different name spaces?
		if( symbIsGlobalNamespc( ) = FALSE ) then
			errReport( FB_ERRMSG_DECLOUTSIDENAMESPC )
		end if
	end if

	'' skip the '.'
	lexSkipToken( LEXCHECK_NOPERIOD )

	'' not an ID?
	select case lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

	case else
		if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		end if
		exit function
	end select

	base_parent = @symbGetGlobalNamespc( )

	function = symbLookupAt( base_parent, _
							 lexGetText( ), _
							 FALSE, _
							 TRUE )

end function

'':::::
'' !!!TODO!!! combine with or re-use symb.bas:hGetNamespacePrefix
private function hGetChainNames( byval chain_ as FBSYMCHAIN ptr ) as string
	dim as FBSYMBOL ptr ns = any
	dim as string names
	do
		dim s as string
		ns = symbGetNamespace( chain_->sym )
		while( ns <> @symbGetGlobalNamespc( ) )
			if( (symbGetAttrib( ns ) and FB_SYMBATTRIB_ANONYMOUS) <> 0 ) then
				if( symbIsEnum( ns ) ) then
					s = "<enum>." + s
				else
					s = "<enum>." + s
				end if
			else
				s = *symbGetName( ns ) + "." + s
			end if
			if( symbGetHashtb( ns ) = NULL ) then
				exit while
			end if
			ns = symbGetNamespace( ns )
		wend
		if( (symbGetAttrib( chain_->sym ) and FB_SYMBATTRIB_ANONYMOUS) <> 0 ) then
			names += s + "<unnamed>"
		else
			names += s + *symbGetName( chain_->sym )
		end if

		chain_ = chain_->next
		if( chain_ = NULL ) then
			exit do
		end if
		names &= ", "
	loop
	return names
end function

'':::::
private function hCheckDecl _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr, _
		byval options as FB_IDOPT _
	) as integer

	if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
		'' declaration?
		if( (options and FB_IDOPT_ISDECL) <> 0 ) then
			if( base_parent <> NULL ) then
				'' different parents?
				if( base_parent <> @symbGetGlobalNamespc() ) then
					if( symbGetParent( base_parent ) <> symbGetCurrentNamespc( ) ) then
						errReport( FB_ERRMSG_DECLOUTSIDENAMESPC )
						return FALSE
					end if
				end if
			end if

		'' not a decl..
		else
			'' check for ambiguous access (dup symbols in different imported namespaces)
			if( chain_ <> NULL ) then
				'' same symbol found in more than one hash tb?
				if( chain_->next <> NULL ) then
					'' imported namespace?
					if( chain_->isimport ) then
						dim as FBSYMBOL ptr ns = symbGetNamespace( chain_->sym ), ns2 = symbGetNamespace( chain_->next->sym )
						'' first symbol declared in other namespace?
						if( iif( parent, ns <> parent, ns <> ns2 ) ) then
							'' more than one imported symbol
							errReport( FB_ERRMSG_AMBIGUOUSSYMBOLACCESS, FALSE, " for " & hGetChainNames(chain_) )
							'' (don't return NULL or a new variable would be implicitly created)
						end if
					end if
				end if
			end if
		end if
	end if

	function = TRUE

end function

private function hIsStructAllowed _
	( _
		byval sym as FBSYMBOL ptr, _
		byval options as FB_IDOPT _
	) as integer

	if( (options and FB_IDOPT_ALLOWSTRUCT) = 0 ) then
		return FALSE
	end if

	'' Ordinary/non-class struct? Won't ever be used as namespace prefix,
	'' since it doesn't have any methods/static member vars
	if( symbGetIsUnique( sym ) = FALSE ) then
		return FALSE
	end if

	'' If it's a variable declaration, then the UDT must have STATIC member
	'' vars, otherwise it couldn't be used as namespace prefix here.
	'' (this allows any other UDTs to be used as var names)
	if( options and FB_IDOPT_ISVAR ) then
		return symbGetUdtHasStaticVar( sym )
	end if

	function = TRUE
end function

'':::::
'' Identifier   = (ID{namespace|class} '.')* ID
''              |  ID ('.' ID)* .
''
function cIdentifier _
	( _
		byref base_parent as FBSYMBOL ptr, _
		byval options as FB_IDOPT _
	) as FBSYMCHAIN ptr

	assert((options and FB_IDOPT_DONTCHKPERIOD) = 0)

	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr parent = any

	base_parent = NULL

	'' use the saved namespace prefix if cTypeOrExpression() saved it.
	if( parser.nsprefix ) then
		chain_ = parser.nsprefix
		parser.nsprefix = NULL
	else
		chain_ = lexGetSymChain( )
	end if

	if( fbLangOptIsSet( FB_LANG_OPT_NAMESPC ) = FALSE ) then
		return chain_
	end if

	if( chain_ = NULL ) then
		'' '.'?

		if( lexGetToken( ) <> CHAR_DOT ) then
			return NULL
		end if

		chain_ = hGlobalId( options, base_parent )
		if( chain_ = NULL ) then
			if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
				errReportUndef( FB_ERRMSG_UNDEFINEDSYMBOL, lexGetText( ) )
			else
				hSkipSymbol( )
			end if

			return NULL
		end if
	end if

	parent = NULL

	do
		dim as FBSYMBOL ptr sym = chain_->sym

		'' explicit base_parent? don't access local variables
		'' we are assuming that the logic is correct that any symbol with the local
		'' attribute can't be accessed through an explicit namespace.  If we later find
		'' out that is not the case, then we will need to add a new symbol attribute that
		'' decides if symbols can be accessed through an explicit namespace or not
		'' !!!TODO!!! - we should be able to rewrite this logic more effeciently.  In theory,
		'' if an explicit namespace is not given SymbLookup() should have returned an appropriate
		'' symbol chain.
		if( base_parent ) then
			while( sym )
				if( symbIsLocal( sym ) and symbIsVar( sym ) ) then
					sym = sym->hash.next
				else
					chain_ = symbNewChainpool( sym )
					exit while
				end if
			wend
			if( sym = NULL ) then
				if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
					errReportUndef( FB_ERRMSG_UNDEFINEDSYMBOL, lexGetText( ) )
				else
					hSkipSymbol( )
				end if

				return NULL
			end if
		end if

		select case as const symbGetClass( sym )
		case FB_SYMBCLASS_NAMESPACE, FB_SYMBCLASS_CLASS, FB_SYMBCLASS_ENUM

		case FB_SYMBCLASS_STRUCT
			if( hIsStructAllowed( sym, options ) = FALSE ) then
				exit do
			end if

		case FB_SYMBCLASS_TYPEDEF
			'' typedef of a TYPE/CLASS?
			select case( symbGetType( sym ) )
			case FB_DATATYPE_STRUCT
				sym = symbGetSubtype( sym )

				if( hIsStructAllowed( sym, options ) = FALSE ) then
					exit do
				end if

			case FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS
				sym = symbGetSubtype( sym )

			case else
				exit do
			end select

		case else
			exit do
		end select

		'' check visibility (of the UDT only, because symbols can be
		'' overloaded or the names duplicated, so that check can only
		'' be done by specific functions)
		if( parent <> NULL ) then
			if( symbCheckAccess( sym ) = FALSE ) then
				if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
					errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
				end if
			end if
		end if

		'' '.'?
		if( lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) <> CHAR_DOT ) then
			'' if it's a namespace, the '.' is obligatory, the
			'' namespace itself isn't a composite type
			'' The only exception to that is namespaces appearing
			'' in preprocessor expressions in #ifdef or #undef etc.
			'' Those don't pass FB_IDOPT_SHOWERROR, and they skip
			'' this last namespace id manually (like any other id),
			'' because for them, this is not a syntax error.
			if( symbGetClass( sym ) = FB_SYMBCLASS_NAMESPACE ) then
				if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
					'' skip id
					lexSkipToken( LEXCHECK_NOPERIOD or LEXCHECK_POST_SUFFIX )
					errReport( FB_ERRMSG_EXPECTEDPERIOD )
				end if
			end if

			exit do
		end if

		if( symbIsEnum( sym ) ) then
			if( symbEnumHasHashTb( sym ) = FALSE ) then
				if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
					errReport( FB_ERRMSG_NONSCOPEDENUM )
				end if
				exit do
			end if
		end if

		'' skip id
		lexSkipToken( LEXCHECK_NOPERIOD or LEXCHECK_POST_SUFFIX )

		'' skip '.'
		lexSkipToken( LEXCHECK_NOPERIOD )

		parent = sym

		if( base_parent = NULL ) then
			base_parent = parent
		end if

		'' ID
		select case as const lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

		case FB_TKCLASS_OPERATOR, FB_TKCLASS_KEYWORD
			if( (options and FB_IDOPT_ISOPERATOR ) <> 0 ) then
				exit do
			end if

			if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
				errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			end if

			return NULL

		case else
			'' Allow '[' for '[]' operator overloads, it's not part
			'' of FB_TKCLASS_OPERATOR since it's not a real op.
			if( lexGetToken( ) = CHAR_LBRACKET ) then
				if( (options and FB_IDOPT_ISOPERATOR ) <> 0 ) then
					exit do
				end if
			end if

			if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
				errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			end if

			return NULL
		end select

		'' look up
		chain_ = symbLookupAt( parent, lexGetText( ), FALSE )
		if( chain_ = NULL ) then
			if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
				errReportUndef( FB_ERRMSG_UNDEFINEDSYMBOL, lexGetText( ) )
			else
				hSkipSymbol( )
			end if

			return NULL
		end if

		'' check access to non-static members
		if( (options and FB_IDOPT_CHECKSTATIC) <> 0 ) then
			'' struct or class?
			select case symbGetClass( parent )
			case FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_CLASS
				'' for each symbol (because dups..)
				dim as FBSYMCHAIN ptr iter = chain_
				do
					dim as FBSYMBOL ptr sym = iter->sym
					do
						'' field, never static..
						if( symbGetClass( sym ) = FB_SYMBCLASS_FIELD ) then
							errReport( FB_ERRMSG_ACCESSTONONSTATICMEMBER )
							exit do, do
						end if

						sym = sym->hash.next
					loop while( sym <> NULL )

					iter = symbChainGetNext( iter )
				loop while( iter <> NULL )
			end select
		end if
	loop

	''
	if( hCheckDecl( base_parent, parent, chain_, options ) = FALSE ) then
		return NULL
	end if

	function = chain_

end function

'':::::
'' ParentId     = ID{namespace|class} ('.' ID{namespace|class})* .
''
function cParentId _
	( _
		byval options as FB_IDOPT _
	) as FBSYMBOL ptr

	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr sym = any, parent = any, base_parent = any

	if( fbLangOptIsSet( FB_LANG_OPT_NAMESPC ) = FALSE ) then
		return NULL
	end if

	sym = NULL
	base_parent = NULL
	parent = NULL

	chain_ = lexGetSymChain( )
	if( chain_ = NULL ) then
		'' '.'?
		if( lexGetToken( ) = CHAR_DOT ) then
			chain_ = hGlobalId( , base_parent )
		end if
	end if

	'' explicit base parent?
	if( base_parent ) then
		parent = base_parent
	end if

	do while( chain_ <> NULL )

		sym = chain_->sym
		select case as const symbGetClass( sym )
		case FB_SYMBCLASS_NAMESPACE, FB_SYMBCLASS_CLASS, FB_SYMBCLASS_ENUM

		case FB_SYMBCLASS_STRUCT
			if( hIsStructAllowed( sym, options ) = FALSE ) then
				sym = parent
				exit do
			end if

		case FB_SYMBCLASS_TYPEDEF
			'' typedef of a TYPE/CLASS?
			select case( symbGetType( sym ) )
			case FB_DATATYPE_STRUCT
				sym = symbGetSubtype( sym )

				if( hIsStructAllowed( sym, options ) = FALSE ) then
					sym = parent
					exit do
				end if

			case FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS
				sym = symbGetSubtype( sym )

			case else
				sym = parent
				exit do
			end select

		case else
			sym = parent
			exit do
		end select

		'' check visibility
		if( parent <> NULL ) then
			if( symbCheckAccess( sym ) = FALSE ) then
				errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
			end if
		end if

		'' '.'?
		if( lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) <> CHAR_DOT ) then
			'' skip id
			lexSkipToken( LEXCHECK_NOPERIOD )

			if( (options and FB_IDOPT_DONTCHKPERIOD) <> 0 ) then
				exit do
			end if

			errReport( FB_ERRMSG_EXPECTEDPERIOD )
			exit do
		end if

		if( symbIsEnum( sym ) ) then
			if( symbEnumHasHashTb( sym ) = FALSE ) then
				errReport( FB_ERRMSG_NONSCOPEDENUM )
				exit do
			end if
		end if

		'' skip id
		lexSkipToken( LEXCHECK_NOPERIOD or LEXCHECK_POST_SUFFIX )

		'' skip '.'
		lexSkipToken( LEXCHECK_NOPERIOD )

		parent = sym

		if( base_parent = NULL ) then
			base_parent = parent
		end if

		'' ID
		select case as const lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

		case FB_TKCLASS_OPERATOR, FB_TKCLASS_KEYWORD
			if( (options and FB_IDOPT_ISOPERATOR ) <> 0 ) then
				exit do
			end if

			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			exit do

		case else
			'' Allow '[' for '[]' operator overloads, it's not part
			'' of FB_TKCLASS_OPERATOR since it's not a real op.
			if( lexGetToken( ) = CHAR_LBRACKET ) then
				if( (options and FB_IDOPT_ISOPERATOR ) <> 0 ) then
					exit do
				end if
			end if

			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
				exit do
		end select

		chain_ = symbLookupAt( sym, lexGetText( ), FALSE )
	loop

	''
	if( hCheckDecl( base_parent, parent, chain_, options ) = FALSE ) then
		return NULL
	end if

	function = sym

end function

sub cCurrentParentId()
	'' Parse namespace prefix(es) on an identifier in a declaration,
	'' then complain if it doesn't match the current namespace.
	'' This is part of requiring declarations to be written inside a
	'' namespace block in order to add them to a namespace.

	dim as FBSYMBOL ptr s = cParentId()
	if( s = NULL ) then
		return
	end if

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
