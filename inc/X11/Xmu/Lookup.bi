''
''
'' Lookup -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Lookup_bi__
#define __Lookup_bi__

#define included_xmu_lookup_h 1

declare function XmuLookupString cdecl alias "XmuLookupString" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr, byval keysymSet as uinteger) as integer
declare function XmuLookupLatin1 cdecl alias "XmuLookupLatin1" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupLatin2 cdecl alias "XmuLookupLatin2" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupLatin3 cdecl alias "XmuLookupLatin3" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupLatin4 cdecl alias "XmuLookupLatin4" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupKana cdecl alias "XmuLookupKana" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupJISX0201 cdecl alias "XmuLookupJISX0201" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupArabic cdecl alias "XmuLookupArabic" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupCyrillic cdecl alias "XmuLookupCyrillic" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupGreek cdecl alias "XmuLookupGreek" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupAPL cdecl alias "XmuLookupAPL" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer
declare function XmuLookupHebrew cdecl alias "XmuLookupHebrew" (byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as integer, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as integer

#endif
