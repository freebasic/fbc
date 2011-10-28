#ifndef __HELP_BI__
#define __HELP_BI__

#ifndef INVALID
const INVALID = -1
#endif

''
'' helper module protos
''

declare sub hlpInit _
	( _
	)

declare sub hlpEnd _
	( _
	)

declare function hMatchText _
	( _
		byval txt as zstring ptr _
	) as integer

declare function hMatch _
	( _
		byval token as integer _
	) as integer

declare function hMakeProfileLabelName _
	( _
	) as zstring ptr

declare function hFBrelop2IRrelop _
	( _
		byval tk as integer _
	) as integer

declare function hFileExists _
	( _
		byval filename as zstring ptr _
	) as integer

declare sub hClearName _
	( _
		byval src as zstring ptr _
	)

declare sub hUcase _
	( _
		byval src as zstring ptr, _
		byval dst as zstring ptr _
	)

declare function hStripUnderscore _
	( _
		byval symbol as zstring ptr _
	) as string

declare function hStripExt _
	( _
		byval filename as zstring ptr _
	) as string

declare function hStripPath _
	( _
		byval filename as zstring ptr _
	) as string

declare function hStripFilename _
	( _
		byval filename as zstring ptr _
	) as string

declare function hGetFileExt _
	( _
		byval fname as zstring ptr _
	) as string

declare function hRevertSlash _
	( _
		byval s as zstring ptr, _
		byval allocnew as integer, _
		byval repchar as integer _
	) as zstring ptr

declare function pathStripDiv(byref path as string) as string

declare function hToPow2 _
	( _
		byval value as uinteger _
	) as uinteger

declare function hJumpTbAllocSym _
	( _
	) as any ptr

declare function hFloatToStr _
	( _
		byval value as double, _
		byref typ as integer _
	) as string

declare function hCheckFileFormat _
	( _
		byval f as integer _
	) as integer

declare function hCurDir _
	( _
	) as string

declare function hEnvDir _
	( _
	) as string

declare function hHexUInt _
	( _
		byval value as uinteger _
	) as zstring ptr

declare function hIsValidSymbolName( byval sym as zstring ptr ) as integer

declare function strUnquote(byref s as string) as string

#include once "hlp-str.bi"

#define hIsCharLower(_c) ( (_c >= asc("a")) andalso (_c <= asc("z")) )
#define hIsCharUpper(_c) ( (_c <= asc("Z")) andalso (_c >= asc("A")) )
#define hIsChar(_c) ( hIsCharLower(_c) orelse hIsCharUpper(_c) )
#define hIsCharNumeric(_c) ( (_c <= asc("9")) andalso (_c >= asc("0")) )

#endif ''__HELP_BI__
