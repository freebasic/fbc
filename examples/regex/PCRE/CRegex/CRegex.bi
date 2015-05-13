#inclib "CRegex"

#include once "pcre.bi"

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

	declare constructor _
		( _
			byval pattern as zstring ptr, _
			byval opt as options = NONE _
		)

	declare function getMaxMatches() as integer

	declare function search _
		( _
			byval subject as zstring ptr, _
			byval lgt as integer = -1, _
			byval opt as options = NONE _
		) as integer

	declare function searchNext _
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

	declare destructor()

private:
	declare sub clearSubstrlist()

	as pcre ptr reg
	as pcre_extra_ ptr extra
	as integer ptr vectb
	as zstring ptr subject
	as integer sublen
	as integer substrcnt
	as zstring ptr ptr substrlist
end type
