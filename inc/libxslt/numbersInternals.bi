'' FreeBASIC binding for libxslt-1.1.28
''
'' based on the C header files:
''    Copyright (C) 2001-2002 Daniel Veillard.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is fur-
''   nished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FIT-
''   NESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   DANIEL VEILLARD BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON-
''   NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Daniel Veillard shall not
''   be used in advertising or otherwise to promote the sale, use or other deal-
''   ings in this Software without prior written authorization from him.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "libxml/tree.bi"
#include once "xsltexports.bi"

#define __XML_XSLT_NUMBERSINTERNALS_H__
type xsltNumberData as _xsltNumberData
type xsltNumberDataPtr as xsltNumberData ptr
type _xsltCompMatch as _xsltCompMatch_

type _xsltNumberData
	level as const xmlChar ptr
	count as const xmlChar ptr
	from as const xmlChar ptr
	value as const xmlChar ptr
	format as const xmlChar ptr
	has_format as long
	digitsPerGroup as long
	groupingCharacter as long
	groupingCharacterLen as long
	doc as xmlDocPtr
	node as xmlNodePtr
	countPat as _xsltCompMatch ptr
	fromPat as _xsltCompMatch ptr
end type

type xsltFormatNumberInfo as _xsltFormatNumberInfo
type xsltFormatNumberInfoPtr as xsltFormatNumberInfo ptr

type _xsltFormatNumberInfo
	integer_hash as long
	integer_digits as long
	frac_digits as long
	frac_hash as long
	group as long
	multiplier as long
	add_decimal as byte
	is_multiplier_set as byte
	is_negative_pattern as byte
end type
