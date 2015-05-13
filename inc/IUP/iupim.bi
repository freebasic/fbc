''
''
'' iupim -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupim_bi__
#define __iupim_bi__

declare function IupLoadImage cdecl alias "IupLoadImage" (byval file_name as zstring ptr) as Ihandle ptr
declare function IupSaveImage cdecl alias "IupSaveImage" (byval ih as Ihandle ptr, byval file_name as zstring ptr, byval format as zstring ptr) as integer

#endif
