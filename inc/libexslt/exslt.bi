'' FreeBASIC binding for libxslt-1.1.28
''
'' based on the C header files:
''    Copyright (C) 2001-2002 Thomas Broyer, Charlie Bozeman and Daniel Veillard.
''    All Rights Reserved.
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
''   AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON-
''   NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of the authors shall not
''   be used in advertising or otherwise to promote the sale, use or other deal-
''   ings in this Software without prior written authorization from him.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "libxml/tree.bi"
#include once "libxml/xpath.bi"
#include once "exsltexports.bi"
#include once "libexslt/exsltconfig.bi"

extern "C"

#define __EXSLT_H__
extern exsltLibraryVersion as const zstring ptr
extern exsltLibexsltVersion as const long
extern exsltLibxsltVersion as const long
extern exsltLibxmlVersion as const long

#define EXSLT_COMMON_NAMESPACE cptr(const xmlChar ptr, @"http://exslt.org/common")
#define EXSLT_CRYPTO_NAMESPACE cptr(const xmlChar ptr, @"http://exslt.org/crypto")
#define EXSLT_MATH_NAMESPACE cptr(const xmlChar ptr, @"http://exslt.org/math")
#define EXSLT_SETS_NAMESPACE cptr(const xmlChar ptr, @"http://exslt.org/sets")
#define EXSLT_FUNCTIONS_NAMESPACE cptr(const xmlChar ptr, @"http://exslt.org/functions")
#define EXSLT_STRINGS_NAMESPACE cptr(const xmlChar ptr, @"http://exslt.org/strings")
#define EXSLT_DATE_NAMESPACE cptr(const xmlChar ptr, @"http://exslt.org/dates-and-times")
#define EXSLT_DYNAMIC_NAMESPACE cptr(const xmlChar ptr, @"http://exslt.org/dynamic")
#define SAXON_NAMESPACE cptr(const xmlChar ptr, @"http://icl.com/saxon")

declare sub exsltCommonRegister()
declare sub exsltCryptoRegister()
declare sub exsltMathRegister()
declare sub exsltSetsRegister()
declare sub exsltFuncRegister()
declare sub exsltStrRegister()
declare sub exsltDateRegister()
declare sub exsltSaxonRegister()
declare sub exsltDynRegister()
declare sub exsltRegisterAll()
declare function exsltDateXpathCtxtRegister(byval ctxt as xmlXPathContextPtr, byval prefix as const xmlChar ptr) as long
declare function exsltMathXpathCtxtRegister(byval ctxt as xmlXPathContextPtr, byval prefix as const xmlChar ptr) as long
declare function exsltSetsXpathCtxtRegister(byval ctxt as xmlXPathContextPtr, byval prefix as const xmlChar ptr) as long
declare function exsltStrXpathCtxtRegister(byval ctxt as xmlXPathContextPtr, byval prefix as const xmlChar ptr) as long

end extern
