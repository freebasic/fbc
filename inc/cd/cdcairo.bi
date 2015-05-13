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

extern "C"

declare function cdContextCairoNativeWindow () as cdContext ptr
declare function cdContextCairoImage () as cdContext ptr
declare function cdContextCairoDBuffer () as cdContext ptr
declare function cdContextCairoPrinter () as cdContext ptr
declare function cdContextCairoPS () as cdContext ptr
declare function cdContextCairoPDF () as cdContext ptr
declare function cdContextCairoSVG () as cdContext ptr
declare function cdContextCairoImageRGB () as cdContext ptr
declare function cdContextCairoEMF () as cdContext ptr

end extern

#define CD_CAIRO_NATIVEWINDOW cdContextCairoNativeWindow()
#define CD_CAIRO_IMAGE cdContextCairoImage()
#define CD_CAIRO_DBUFFER cdContextCairoDBuffer()
#define CD_CAIRO_PRINTER cdContextCairoPrinter()
#define CD_CAIRO_PS cdContextCairoPS()
#define CD_CAIRO_PDF cdContextCairoPDF()
#define CD_CAIRO_SVG cdContextCairoSVG()
#define CD_CAIRO_IMAGERGB cdContextCairoImageRGB()
#define CD_CAIRO_EMF cdContextCairoEMF()

#endif
