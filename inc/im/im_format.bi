''
''
'' im_format -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_format_bi__
#define __im_format_bi__

declare function imFileFormatBaseOpen cdecl alias "imFileFormatBaseOpen" (byval file_name as zstring ptr, byval error as integer ptr) as imFileFormatBase ptr
declare function imFileFormatBaseOpenAs cdecl alias "imFileFormatBaseOpenAs" (byval file_name as zstring ptr, byval format as zstring ptr, byval error as integer ptr) as imFileFormatBase ptr
declare function imFileFormatBaseNew cdecl alias "imFileFormatBaseNew" (byval file_name as zstring ptr, byval format as zstring ptr, byval error as integer ptr) as imFileFormatBase ptr
declare sub imFormatRegister cdecl alias "imFormatRegister" (byval iformat as imFormat ptr)

#endif
