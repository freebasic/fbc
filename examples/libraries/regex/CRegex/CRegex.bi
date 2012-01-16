#ifndef __CREGEX_BI__
#define __CREGEX_BI__

#inclib "CRegex"

#include once "pcre/pcre.bi"

#ifndef NULL
#define NULL 0
#endif

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

type CRegex
	enum options
		NONE			= &h0000
		CASELESS		= &h0001
		MULTILINE		= &h0002
		DOTALL			= &h0004
		EXTENDED		= &h0008
		ANCHORED		= &h0010
		DOLLAR_ENDONLY	= &h0020
		EXTRA_			= &h0040
		NOTBOL			= &h0080
		NOTEOL			= &h0100
		UNGREEDY		= &h0200
		NOTEMPTY		= &h0400
		UTF8			= &h0800
		NO_AUTO_CAPTURE	= &h1000
		NO_UTF8_CHECK	= &h2000
		AUTO_CALLOUT	= &h4000
		PARTIAL			= &h8000
	end enum

	declare constructor	_
		( _
			byval pattern as zstring ptr, _
			byval opt as options = NONE _
		) 
	
	declare destructor _
		( _
			_
		)
	
	declare function getMaxMatches _
		( _
			_
			) as integer
	
	declare function search _
		( _
			byval subject as zstring ptr, _
			byval lgt as integer = -1, _
			byval opt as options = NONE _
		) as integer
	
	declare function searchNext	_
		( _
			byval opt as options = NONE _
		) as integer
	
	
	declare function getStr _
		( _
			byval i as integer = 1 _
		) as zstring ptr
	
	declare function getOfs _
		( _
			byval i as integer = 1 _
		) as integer
	
	declare function getLen _
		( _
			byval i as integer = 1 _
		) as integer

private:
	declare sub clearSubstrlist _
		( _
			_
		)

	dim as pcre ptr reg = any
	dim as pcre_extra ptr extra = any
    dim as integer ptr vectb = any
    dim as zstring ptr subject = any
	dim as integer sublen = any
	dim as integer substrcnt = any
	dim as zstring ptr ptr substrlist = any
end type

#endif