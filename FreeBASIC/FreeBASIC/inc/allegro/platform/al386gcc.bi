''
''
'' allegro\platform\al386gcc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_platform_al386gcc_bi__
#define __allegro_platform_al386gcc_bi__

declare function _default_ds cdecl alias "_default_ds" () as integer
declare function bmp_write_line cdecl alias "bmp_write_line" (byval bmp as BITMAP ptr, byval line as integer) as uinteger
declare function bmp_read_line cdecl alias "bmp_read_line" (byval bmp as BITMAP ptr, byval line as integer) as uinteger
declare sub bmp_unwrite_line cdecl alias "bmp_unwrite_line" (byval bmp as BITMAP ptr)

#endif
