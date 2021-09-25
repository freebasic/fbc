'' symbol table module for labels
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "lex.bi"

'':::::
function symbAddLabel _
	( _
		byval symbol as zstring ptr, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr

	dim as zstring ptr id = any, id_alias = any
	dim as FBSYMBOL ptr l = any
	dim as FBSYMBOLTB ptr symtb = any
	dim as FBHASHTB ptr hashtb = any
	dim as integer isglobal = any

	function = NULL

	if( symbol <> NULL ) then
		'' check if label already exists
		l = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
			symbol, _
			FB_SYMBCLASS_LABEL, _
			FALSE )
		if( l <> NULL ) then
			if( (options and FB_SYMBOPT_DECLARING) <> 0 ) then
				'' dup definition?
				if( l->lbl.declared ) then
					exit function
				end if

				'' set the right values
				l->lbl.declared = TRUE
				l->lbl.parent = parser.currblock
				l->lbl.stmtnum = parser.stmt.cnt
				l->scope = parser.scope
				return l

			else
				return l
			end if
		end if

		'' add the new label
		if( (options and FB_SYMBOPT_CREATEALIAS) = 0 ) then
			id_alias = symbol
		else
			id_alias = symbUniqueLabel( )
		end if

		id = symbol
	else
		id = NULL
		id_alias = symbUniqueLabel( )
	end if

	if( (options and FB_SYMBOPT_MOVETOGLOB) <> 0 ) then
		isglobal = TRUE

		symtb = @symbGetGlobalTb( )
		hashtb = @symbGetGlobalHashTb( )

	else
		'' parsing main? add to global tb
		if( fbIsModLevel( ) ) then
			isglobal = TRUE

			'' unless inside a namespace..
			if( symbIsGlobalNamespc() = FALSE ) then
				symtb = symb.symtb
				hashtb = symb.hashtb
			else
				symtb = @symbGetGlobalTb( )
				hashtb = @symbGetGlobalHashTb( )
			end if

		'' otherwise the current proc sym table must be used, not the
		'' current scope because labels inside scopes are unique,
		'' and branching to them from other scopes must be allowed
		else
			isglobal = FALSE

			symtb = @parser.currproc->proc.symtb
			hashtb = symb.hashtb
		end if
	end if

	l = symbNewSymbol( iif( symbol = NULL, FB_SYMBOPT_NONE, FB_SYMBOPT_DOHASH ), _
		NULL, _
		symtb, hashtb, _
		FB_SYMBCLASS_LABEL, _
		id, id_alias, _
		FB_DATATYPE_INVALID, NULL, _
		iif( isglobal, FB_SYMBATTRIB_NONE, FB_SYMBATTRIB_LOCAL ), FB_PROCATTRIB_NONE )
	if( l = NULL ) then
		exit function
	end if

	if( (options and FB_SYMBOPT_DECLARING) <> 0 ) then
		'' label parent won't be the current proc block as
		'' it's been defined inside a scope block
		l->lbl.parent = parser.currblock
		l->lbl.stmtnum = parser.stmt.cnt

		l->lbl.declared = TRUE
	else
		l->lbl.declared = FALSE
	end if
	''for gas64
	l->lbl.gosub = false

	function = l

end function

'':::::
function symbCloneLabel _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	function = symbAddLabel( NULL )

end function

'':::::
sub symbDelLabel _
	( _
		byval s as FBSYMBOL ptr _
	)

	if( s = NULL ) then
		exit sub
	end if

	symbFreeSymbol( s )

end sub

function symbCheckLabels _
	( _
		byval symtbhead as FBSYMBOL ptr _
	) as integer

	dim as integer count = 0

	'' Check for any undeclared labels
	dim as FBSYMBOL ptr s = symtbhead
	while (s)
		if (s->class = FB_SYMBCLASS_LABEL) then
			if (s->lbl.declared = FALSE) then
				if (symbGetName(s)) then
					errReportEx(FB_ERRMSG_UNDEFINEDLABEL, *symbGetName(s), -1)
					count += 1
				end if
			end if
		end if
		s = s->next
	wend

	return count
end function
