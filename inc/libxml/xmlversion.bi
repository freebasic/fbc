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

#inclib "xml2"

#include once "libxml/xmlexports.bi"

extern "C"

#define __XML_VERSION_H__
declare sub xmlCheckVersion(byval version as long)
#define LIBXML_DOTTED_VERSION "2.9.2"
const LIBXML_VERSION = 20902
#define LIBXML_VERSION_STRING "20902"
#define LIBXML_VERSION_EXTRA "-GITv2.9.2-rc2-10-gbe2a7ed"
#define LIBXML_TEST_VERSION xmlCheckVersion(20902)
#define WITHOUT_TRIO
#define LIBXML_THREAD_ENABLED
#define LIBXML_TREE_ENABLED
#define LIBXML_OUTPUT_ENABLED
#define LIBXML_PUSH_ENABLED
#define LIBXML_READER_ENABLED
#define LIBXML_PATTERN_ENABLED
#define LIBXML_WRITER_ENABLED
#define LIBXML_SAX1_ENABLED
#define LIBXML_FTP_ENABLED
#define LIBXML_HTTP_ENABLED
#define LIBXML_VALID_ENABLED
#define LIBXML_HTML_ENABLED
#define LIBXML_LEGACY_ENABLED
#define LIBXML_C14N_ENABLED
#define LIBXML_CATALOG_ENABLED
#define LIBXML_DOCB_ENABLED
#define LIBXML_XPATH_ENABLED
#define LIBXML_XPTR_ENABLED
#define LIBXML_XINCLUDE_ENABLED
#define LIBXML_ICONV_ENABLED
#define LIBXML_ISO8859X_ENABLED
#define LIBXML_DEBUG_ENABLED
#define LIBXML_UNICODE_ENABLED
#define LIBXML_REGEXP_ENABLED
#define LIBXML_AUTOMATA_ENABLED
#define LIBXML_EXPR_ENABLED
#define LIBXML_SCHEMAS_ENABLED
#define LIBXML_SCHEMATRON_ENABLED
#define LIBXML_MODULES_ENABLED

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	#define LIBXML_MODULE_EXTENSION ".dll"
#else
	#define LIBXML_MODULE_EXTENSION ".so"
#endif

#define LIBXML_ZLIB_ENABLED
#define LIBXML_LZMA_ENABLED

end extern
