#ifndef __HELP_STR_BI__
#define __HELP_STR_BI__

declare sub ZstrAssign _
	( _
		byval dst as zstring ptr ptr, _
		byval src as zstring ptr _
	)

declare sub ZstrAssignW _
	( _
		byval dst as zstring ptr ptr, _
		byval src as wstring ptr _
	)

declare sub ZstrConcatAssign _
	( _
		byval dst as zstring ptr ptr, _
		byval src as zstring ptr _
	)

declare sub ZstrConcatAssignW _
	( _
		byval dst as zstring ptr ptr, _
		byval src as wstring ptr _
	)

declare function ZstrDup _
	( _
		byval s as zstring ptr _
	) as zstring ptr

declare sub WstrAssign _
	( _
		byval dst as wstring ptr ptr, _
		byval src as wstring ptr _
	)

declare sub WstrAssignA _
	( _
		byval dst as wstring ptr ptr, _
		byval src as zstring ptr _
	)

declare sub WstrConcatAssign _
	( _
		byval dst as wstring ptr ptr, _
		byval src as wstring ptr _
	)

declare sub WstrConcatAssignW _
	( _
		byval dst as wstring ptr ptr, _
		byval src as zstring ptr _
	)

declare function WstrDup _
	( _
		byval s as wstring ptr _
	) as wstring ptr


declare function hReEscape _
	( _
		byval text as zstring ptr, _
		byref textlen as integer, _
		byref isunicode as integer _
	) as zstring ptr

declare function hReEscapeW _
	( _
		byval text as wstring ptr, _
		byref textlen as integer _
	) as wstring ptr

declare function hEscape _
	( _
		byval text as const zstring ptr _
	) as const zstring ptr

declare function hEscapeW _
	( _
		byval text as const wstring ptr _
	) as zstring ptr

declare function hUnescape _
	( _
		byval text as zstring ptr, _
		byref textlen as integer = 0 _
	) as zstring ptr

declare function hUnescapeW _
	( _
		byval text as wstring ptr, _
		byref textlen as integer = 0 _
	) as wstring ptr

declare function hHasEscape _
	( _
		byval text as zstring ptr _
	) as integer

declare function hHasEscapeW _
	( _
		byval text as wstring ptr _
	) as integer

declare function hReplace _
	( _
		byval text as zstring ptr, _
		byval oldtext as zstring ptr, _
		byval newtext as zstring ptr _
	) as string

declare function hReplaceW _
	( _
		byval orgtext as wstring ptr, _
		byval oldtext as wstring ptr, _
		byval newtext as wstring ptr _
	) as wstring ptr

declare function hReplaceChar _
	( _
		byval orgtext as zstring ptr, _
		byval oldchar as integer, _
		byval newchar as integer _
	) as zstring ptr

declare function hCharNeedsEscaping _
	( _
		byval ch as integer, _
		byval quotechar as integer _
	) as integer

declare function hIsValidHexDigit( byval ch as integer ) as integer

declare function hStr2long( byref txt as string, byref value as long ) as integer

declare sub hSplitStr(byref txt as string, byref del as string, res() as string)

declare function hStr2Tok(byval txt as const zstring ptr, res() as string) as integer

declare function hStr2Args(byval txt as const zstring ptr, res() as string) as integer

'':::::
#define ZstrAllocate(chars) xallocate( chars + 1 )

#define ZstrFree(p) if( p <> NULL ) then : deallocate( p ) : end if

#define WstrAllocate(chars) xallocate( (chars + 1) * len( wstring ) )

#define WstrFree(p) if( p <> NULL ) then : deallocate( p ) : end if

#endif ''__HELP_STR_BI__
