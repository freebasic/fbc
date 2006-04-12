''
''
'' xmlstring -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlstring_bi__
#define __xml_xmlstring_bi__

#include once "libxml/xmlversion.bi"

type xmlChar as byte

declare function xmlStrdup cdecl alias "xmlStrdup" (byval cur as zstring ptr) as zstring ptr
declare function xmlStrndup cdecl alias "xmlStrndup" (byval cur as zstring ptr, byval len as integer) as zstring ptr
declare function xmlCharStrndup cdecl alias "xmlCharStrndup" (byval cur as zstring ptr, byval len as integer) as zstring ptr
declare function xmlCharStrdup cdecl alias "xmlCharStrdup" (byval cur as zstring ptr) as zstring ptr
declare function xmlStrsub cdecl alias "xmlStrsub" (byval str as zstring ptr, byval start as integer, byval len as integer) as zstring ptr
declare function xmlStrchr cdecl alias "xmlStrchr" (byval str as zstring ptr, byval val as xmlChar) as zstring ptr
declare function xmlStrstr cdecl alias "xmlStrstr" (byval str as zstring ptr, byval val as zstring ptr) as zstring ptr
declare function xmlStrcasestr cdecl alias "xmlStrcasestr" (byval str as zstring ptr, byval val as zstring ptr) as zstring ptr
declare function xmlStrcmp cdecl alias "xmlStrcmp" (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function xmlStrncmp cdecl alias "xmlStrncmp" (byval str1 as zstring ptr, byval str2 as zstring ptr, byval len as integer) as integer
declare function xmlStrcasecmp cdecl alias "xmlStrcasecmp" (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function xmlStrncasecmp cdecl alias "xmlStrncasecmp" (byval str1 as zstring ptr, byval str2 as zstring ptr, byval len as integer) as integer
declare function xmlStrEqual cdecl alias "xmlStrEqual" (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function xmlStrQEqual cdecl alias "xmlStrQEqual" (byval pref as zstring ptr, byval name as zstring ptr, byval str as zstring ptr) as integer
declare function xmlStrlen cdecl alias "xmlStrlen" (byval str as zstring ptr) as integer
declare function xmlStrcat cdecl alias "xmlStrcat" (byval cur as zstring ptr, byval add as zstring ptr) as zstring ptr
declare function xmlStrncat cdecl alias "xmlStrncat" (byval cur as zstring ptr, byval add as zstring ptr, byval len as integer) as zstring ptr
declare function xmlStrncatNew cdecl alias "xmlStrncatNew" (byval str1 as zstring ptr, byval str2 as zstring ptr, byval len as integer) as zstring ptr
declare function xmlStrPrintf cdecl alias "xmlStrPrintf" (byval buf as zstring ptr, byval len as integer, byval msg as zstring ptr, ...) as integer
''''''' declare function xmlStrVPrintf cdecl alias "xmlStrVPrintf" (byval buf as zstring ptr, byval len as integer, byval msg as zstring ptr, byval ap as va_list) as integer
declare function xmlGetUTF8Char cdecl alias "xmlGetUTF8Char" (byval utf as ubyte ptr, byval len as integer ptr) as integer
declare function xmlCheckUTF8 cdecl alias "xmlCheckUTF8" (byval utf as ubyte ptr) as integer
declare function xmlUTF8Strsize cdecl alias "xmlUTF8Strsize" (byval utf as zstring ptr, byval len as integer) as integer
declare function xmlUTF8Strndup cdecl alias "xmlUTF8Strndup" (byval utf as zstring ptr, byval len as integer) as zstring ptr
declare function xmlUTF8Strpos cdecl alias "xmlUTF8Strpos" (byval utf as zstring ptr, byval pos as integer) as zstring ptr
declare function xmlUTF8Strloc cdecl alias "xmlUTF8Strloc" (byval utf as zstring ptr, byval utfchar as zstring ptr) as integer
declare function xmlUTF8Strsub cdecl alias "xmlUTF8Strsub" (byval utf as zstring ptr, byval start as integer, byval len as integer) as zstring ptr
declare function xmlUTF8Strlen cdecl alias "xmlUTF8Strlen" (byval utf as zstring ptr) as integer
declare function xmlUTF8Size cdecl alias "xmlUTF8Size" (byval utf as zstring ptr) as integer
declare function xmlUTF8Charcmp cdecl alias "xmlUTF8Charcmp" (byval utf1 as zstring ptr, byval utf2 as zstring ptr) as integer

#endif
