'' FreeBASIC binding for libxml2-2.9.2
''
'' based on the C header files:
''    Copyright (C) 1998-2012 Daniel Veillard.  All Rights Reserved.
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
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
''   THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "libxml/xmlversion.bi"
#include once "libxml/xmlstring.bi"

extern "C"

#define __XML_CHVALID_H__
type xmlChSRange as _xmlChSRange
type xmlChSRangePtr as xmlChSRange ptr

type _xmlChSRange
	low as ushort
	high as ushort
end type

type xmlChLRange as _xmlChLRange
type xmlChLRangePtr as xmlChLRange ptr

type _xmlChLRange
	low as ulong
	high as ulong
end type

type xmlChRangeGroup as _xmlChRangeGroup
type xmlChRangeGroupPtr as xmlChRangeGroup ptr

type _xmlChRangeGroup
	nbShortRange as long
	nbLongRange as long
	shortRange as const xmlChSRange ptr
	longRange as const xmlChLRange ptr
end type

declare function xmlCharInRange(byval val as ulong, byval group as const xmlChRangeGroup ptr) as long
#define xmlIsBaseChar_ch(c) ((((((&h41 <= (c)) andalso ((c) <= &h5a)) orelse ((&h61 <= (c)) andalso ((c) <= &h7a))) orelse ((&hc0 <= (c)) andalso ((c) <= &hd6))) orelse ((&hd8 <= (c)) andalso ((c) <= &hf6))) orelse (&hf8 <= (c)))
#define xmlIsBaseCharQ(c) iif((c) < &h100, xmlIsBaseChar_ch((c)), xmlCharInRange((c), @xmlIsBaseCharGroup))

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlIsBaseCharGroup as const xmlChRangeGroup
#else
	extern xmlIsBaseCharGroup as const xmlChRangeGroup
#endif

#define xmlIsBlank_ch(c) ((((c) = &h20) orelse ((&h9 <= (c)) andalso ((c) <= &ha))) orelse ((c) = &hd))
#define xmlIsBlankQ(c) iif((c) < &h100, xmlIsBlank_ch((c)), 0)
#define xmlIsChar_ch(c) ((((&h9 <= (c)) andalso ((c) <= &ha)) orelse ((c) = &hd)) orelse (&h20 <= (c)))
#define xmlIsCharQ(c) iif((c) < &h100, xmlIsChar_ch((c)), -((((&h100 <= (c)) andalso ((c) <= &hd7ff)) orelse ((&he000 <= (c)) andalso ((c) <= &hfffd))) orelse ((&h10000 <= (c)) andalso ((c) <= &h10ffff))))

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlIsCharGroup as const xmlChRangeGroup
#else
	extern xmlIsCharGroup as const xmlChRangeGroup
#endif

#define xmlIsCombiningQ(c) iif((c) < &h100, 0, xmlCharInRange((c), @xmlIsCombiningGroup))

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlIsCombiningGroup as const xmlChRangeGroup
#else
	extern xmlIsCombiningGroup as const xmlChRangeGroup
#endif

#define xmlIsDigit_ch(c) ((&h30 <= (c)) andalso ((c) <= &h39))
#define xmlIsDigitQ(c) iif((c) < &h100, xmlIsDigit_ch((c)), xmlCharInRange((c), @xmlIsDigitGroup))

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlIsDigitGroup as const xmlChRangeGroup
#else
	extern xmlIsDigitGroup as const xmlChRangeGroup
#endif

#define xmlIsExtender_ch(c) ((c) = &hb7)
#define xmlIsExtenderQ(c) iif((c) < &h100, xmlIsExtender_ch((c)), xmlCharInRange((c), @xmlIsExtenderGroup))

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlIsExtenderGroup as const xmlChRangeGroup
#else
	extern xmlIsExtenderGroup as const xmlChRangeGroup
#endif

#define xmlIsIdeographicQ(c) iif((c) < &h100, 0, -((((&h4e00 <= (c)) andalso ((c) <= &h9fa5)) orelse ((c) = &h3007)) orelse ((&h3021 <= (c)) andalso ((c) <= &h3029))))

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlIsIdeographicGroup as const xmlChRangeGroup
	extern import xmlIsPubidChar_tab(0 to 255) as const ubyte
#else
	extern xmlIsIdeographicGroup as const xmlChRangeGroup
	extern xmlIsPubidChar_tab(0 to 255) as const ubyte
#endif

#define xmlIsPubidChar_ch(c) xmlIsPubidChar_tab[(c)]
#define xmlIsPubidCharQ(c) iif((c) < &h100, xmlIsPubidChar_ch((c)), 0)
declare function xmlIsBaseChar(byval ch as ulong) as long
declare function xmlIsBlank(byval ch as ulong) as long
declare function xmlIsChar(byval ch as ulong) as long
declare function xmlIsCombining(byval ch as ulong) as long
declare function xmlIsDigit(byval ch as ulong) as long
declare function xmlIsExtender(byval ch as ulong) as long
declare function xmlIsIdeographic(byval ch as ulong) as long
declare function xmlIsPubidChar(byval ch as ulong) as long

end extern
