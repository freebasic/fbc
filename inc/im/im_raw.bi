''
''
'' im_raw -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_raw_bi__
#define __im_raw_bi__

declare function imFileOpenRaw cdecl alias "imFileOpenRaw" (byval file_name as zstring ptr, byval error as integer ptr) as imFile ptr
declare function imFileNewRaw cdecl alias "imFileNewRaw" (byval file_name as zstring ptr, byval error as integer ptr) as imFile ptr

#endif
