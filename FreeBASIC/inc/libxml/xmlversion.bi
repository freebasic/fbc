''
''
'' xmlversion -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xmlversion_bi__
#define __xmlversion_bi__

#inclib "xml2"

#ifndef FILE
type FILE as any
#endif

#include once "libxml/xmlexports.bi"

declare sub xmlCheckVersion cdecl alias "xmlCheckVersion" (byval version as integer)

#define LIBXML_DOTTED_VERSION "2.6.17"
#define LIBXML_VERSION 20617
#define LIBXML_VERSION_STRING "20617"
#define LIBXML_VERSION_EXTRA "CVS2313"
#define LIBXML_MODULE_EXTENSION ".dll"

#define LIBXML_TEST_VERSION xmlCheckVersion( 20617 )

#endif
