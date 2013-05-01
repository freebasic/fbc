''
''
'' im_complex -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_complex_bi__
#define __im_complex_bi__

declare function imcfloat cdecl alias "imcfloat" (byval R as C.real ptr, byval R as C.imag ptr) as return
declare function cpxreal cdecl alias "cpxreal" (byval C as r.q(const).imcfloat) as single
declare function cpximag cdecl alias "cpximag" (byval C as r.q(const).imcfloat) as single
declare function cpxmag cdecl alias "cpxmag" (byval C as r.q(const).imcfloat) as single
declare function cpxphase cdecl alias "cpxphase" (byval C as r.q(const).imcfloat) as single

#endif
