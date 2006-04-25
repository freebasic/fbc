#ifndef __CREGEX_BI__
#define __CREGEX_BI__

#inclib "CRegex"
#inclib "pcre"

#ifndef NULL
#define NULL 0
#endif

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

enum REGEX_OPT
	REGEX_OPT_CASELESS			= &h0001
	REGEX_OPT_MULTILINE			= &h0002
	REGEX_OPT_DOTALL			= &h0004
	REGEX_OPT_EXTENDED			= &h0008
	REGEX_OPT_ANCHORED			= &h0010
	REGEX_OPT_DOLLAR_ENDONLY	= &h0020
	REGEX_OPT_EXTRA_			= &h0040
	REGEX_OPT_NOTBOL			= &h0080
	REGEX_OPT_NOTEOL			= &h0100
	REGEX_OPT_UNGREEDY			= &h0200
	REGEX_OPT_NOTEMPTY			= &h0400
	REGEX_OPT_UTF8				= &h0800
	REGEX_OPT_NO_AUTO_CAPTURE	= &h1000
	REGEX_OPT_NO_UTF8_CHECK		= &h2000
	REGEX_OPT_AUTO_CALLOUT		= &h4000
	REGEX_OPT_PARTIAL			= &h8000
end enum

type CRegex as CRegex_


declare function 	CRegex_New 							( _
															byval pattern as zstring ptr, _
															byval options as REGEX_OPT = 0, _
															byval _this as CRegex ptr = NULL _
														) as CRegex ptr

declare sub 		CRegex_Delete 						( _
															byval _this as CRegex ptr, _
															byval isstatic as integer = FALSE _
														)

declare function 	CRegex_GetMaxMatches 				( _
															byval _this as CRegex ptr _
														) as integer

declare function 	CRegex_Search 						( _
															byval _this as CRegex ptr, _
															byval subject as zstring ptr, _
															byval lgt as integer = -1, _
															byval options as REGEX_OPT = 0 _
														) as integer


declare function 	CRegex_SearchNext					( _
															byval _this as CRegex ptr, _
															byval options as REGEX_OPT = 0 _
														) as integer


declare function 	CRegex_GetStr 						( _
															byval _this as CRegex ptr, _
															byval i as integer = 1 _
														) as zstring ptr

declare function 	CRegex_GetOfs 						( _
															byval _this as CRegex ptr, _
															byval i as integer = 1 _
														) as integer

declare function 	CRegex_GetLen 						( _
															byval _this as CRegex ptr, _
															byval i as integer = 1 _
														) as integer


#endif