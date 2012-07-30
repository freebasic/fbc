''
''
'' lbxbufstr -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lbxbufstr_bi__
#define __lbxbufstr_bi__

type _zlibbuffer
	bufbase as zstring ptr
	bufend as zstring ptr
	bufptr as zstring ptr
	bufcnt as integer
end type

type ZlibBuffer as _zlibbuffer

#endif
