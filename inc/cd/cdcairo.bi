''
''
'' cdcairo -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cdcairo_bi__
#define __cdcairo_bi__

#inclib "cdcairo"

declare function cdContextCairoNativeWindow cdecl alias "cdContextCairoNativeWindow" () as cdContext ptr
declare function cdContextCairoImage cdecl alias "cdContextCairoImage" () as cdContext ptr
declare function cdContextCairoDBuffer cdecl alias "cdContextCairoDBuffer" () as cdContext ptr
declare function cdContextCairoPrinter cdecl alias "cdContextCairoPrinter" () as cdContext ptr
declare function cdContextCairoPS cdecl alias "cdContextCairoPS" () as cdContext ptr
declare function cdContextCairoPDF cdecl alias "cdContextCairoPDF" () as cdContext ptr
declare function cdContextCairoSVG cdecl alias "cdContextCairoSVG" () as cdContext ptr
declare function cdContextCairoImageRGB cdecl alias "cdContextCairoImageRGB" () as cdContext ptr
declare function cdContextCairoEMF cdecl alias "cdContextCairoEMF" () as cdContext ptr

#endif
