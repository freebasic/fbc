''
''
'' xmlversion -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlversion_bi__
#define __xml_xmlversion_bi__

#inclib "xml2"

#ifndef FILE
type FILE as any
#endif

#include once "xmlexports.bi"

extern "c"
declare sub xmlCheckVersion (byval version as integer)
end extern

#define LIBXML_DOTTED_VERSION "2.6.17"
#define LIBXML_VERSION 20617
#define LIBXML_VERSION_STRING "20617"
#define LIBXML_VERSION_EXTRA "CVS2313"
#define LIBXML_MODULE_EXTENSION ".dll"

#define LIBXML_TEST_VERSION( ) xmlCheckVersion( LIBXML_VERSION )

#endif
