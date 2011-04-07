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

#include once "xmlversion.bi"

type xmlChar as byte

extern "c"
declare function xmlStrdup (byval cur as zstring ptr) as zstring ptr
declare function xmlStrndup (byval cur as zstring ptr, byval len as integer) as zstring ptr
declare function xmlCharStrndup (byval cur as zstring ptr, byval len as integer) as zstring ptr
declare function xmlCharStrdup (byval cur as zstring ptr) as zstring ptr
declare function xmlStrsub (byval str as zstring ptr, byval start as integer, byval len as integer) as zstring ptr
declare function xmlStrchr (byval str as zstring ptr, byval val as xmlChar) as zstring ptr
declare function xmlStrstr (byval str as zstring ptr, byval val as zstring ptr) as zstring ptr
declare function xmlStrcasestr (byval str as zstring ptr, byval val as zstring ptr) as zstring ptr
declare function xmlStrcmp (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function xmlStrncmp (byval str1 as zstring ptr, byval str2 as zstring ptr, byval len as integer) as integer
declare function xmlStrcasecmp (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function xmlStrncasecmp (byval str1 as zstring ptr, byval str2 as zstring ptr, byval len as integer) as integer
declare function xmlStrEqual (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function xmlStrQEqual (byval pref as zstring ptr, byval name as zstring ptr, byval str as zstring ptr) as integer
declare function xmlStrlen (byval str as zstring ptr) as integer
declare function xmlStrcat (byval cur as zstring ptr, byval add as zstring ptr) as zstring ptr
declare function xmlStrncat (byval cur as zstring ptr, byval add as zstring ptr, byval len as integer) as zstring ptr
declare function xmlStrncatNew (byval str1 as zstring ptr, byval str2 as zstring ptr, byval len as integer) as zstring ptr
declare function xmlStrPrintf (byval buf as zstring ptr, byval len as integer, byval msg as zstring ptr, ...) as integer
''''''' declare function xmlStrVPrintf (byval buf as zstring ptr, byval len as integer, byval msg as zstring ptr, byval ap as va_list) as integer
declare function xmlGetUTF8Char (byval utf as ubyte ptr, byval len as integer ptr) as integer
declare function xmlCheckUTF8 (byval utf as ubyte ptr) as integer
declare function xmlUTF8Strsize (byval utf as zstring ptr, byval len as integer) as integer
declare function xmlUTF8Strndup (byval utf as zstring ptr, byval len as integer) as zstring ptr
declare function xmlUTF8Strpos (byval utf as zstring ptr, byval pos as integer) as zstring ptr
declare function xmlUTF8Strloc (byval utf as zstring ptr, byval utfchar as zstring ptr) as integer
declare function xmlUTF8Strsub (byval utf as zstring ptr, byval start as integer, byval len as integer) as zstring ptr
declare function xmlUTF8Strlen (byval utf as zstring ptr) as integer
declare function xmlUTF8Size (byval utf as zstring ptr) as integer
declare function xmlUTF8Charcmp (byval utf1 as zstring ptr, byval utf2 as zstring ptr) as integer
end extern

#endif
