''
''
'' numbersInternals -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_numbersInternals_bi__
#define __xslt_numbersInternals_bi__

#include once "xsltexports.bi"
#include once "libxml/tree.bi"

type xsltNumberData as _xsltNumberData
type xsltNumberDataPtr as xsltNumberData ptr

type _xsltNumberData
	level as zstring ptr
	count as zstring ptr
	from as zstring ptr
	value as zstring ptr
	format as zstring ptr
	has_format as integer
	digitsPerGroup as integer
	groupingCharacter as integer
	groupingCharacterLen as integer
	doc as xmlDocPtr
	node as xmlNodePtr
end type

type xsltFormatNumberInfo as _xsltFormatNumberInfo
type xsltFormatNumberInfoPtr as xsltFormatNumberInfo ptr

type _xsltFormatNumberInfo
	integer_hash as integer
	integer_digits as integer
	frac_digits as integer
	frac_hash as integer
	group as integer
	multiplier as integer
	add_decimal as byte
	is_multiplier_set as byte
	is_negative_pattern as byte
end type

#endif
