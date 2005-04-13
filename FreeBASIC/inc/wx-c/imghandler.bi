''
''
'' imghandler -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __imghandler_bi__
#define __imghandler_bi__

#include once "wx-c/wx.bi"
#include once "wx-c/image.bi"

declare function CSharp_new_BMPHandler cdecl alias "CSharp_new_BMPHandler" () as any ptr
declare function CSharp_new_ICOHandler cdecl alias "CSharp_new_ICOHandler" () as any ptr
declare function CSharp_new_CURHandler cdecl alias "CSharp_new_CURHandler" () as any ptr
declare function CSharp_new_ANIHandler cdecl alias "CSharp_new_ANIHandler" () as any ptr
declare function CSharp_new_PNGHandler cdecl alias "CSharp_new_PNGHandler" () as any ptr
declare function CSharp_new_GIFHandler cdecl alias "CSharp_new_GIFHandler" () as any ptr
declare function CSharp_new_PCXHandler cdecl alias "CSharp_new_PCXHandler" () as any ptr
declare function CSharp_new_JPEGHandler cdecl alias "CSharp_new_JPEGHandler" () as any ptr
declare function CSharp_new_PNMHandler cdecl alias "CSharp_new_PNMHandler" () as any ptr
declare function CSharp_new_XPMHandler cdecl alias "CSharp_new_XPMHandler" () as any ptr
declare function CSharp_new_TIFFHandler cdecl alias "CSharp_new_TIFFHandler" () as any ptr

#endif
