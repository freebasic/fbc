'' FreeBASIC binding for cd-5.8.2
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "cdcairo"

extern "C"

#define __CD_CAIRO_H
declare function cdContextCairoNativeWindow() as cdContext ptr
declare function cdContextCairoImage() as cdContext ptr
declare function cdContextCairoDBuffer() as cdContext ptr
declare function cdContextCairoPrinter() as cdContext ptr
declare function cdContextCairoPS() as cdContext ptr
declare function cdContextCairoPDF() as cdContext ptr
declare function cdContextCairoSVG() as cdContext ptr
declare function cdContextCairoImageRGB() as cdContext ptr
declare function cdContextCairoEMF() as cdContext ptr

#define CD_CAIRO_NATIVEWINDOW cdContextCairoNativeWindow()
#define CD_CAIRO_IMAGE cdContextCairoImage()
#define CD_CAIRO_DBUFFER cdContextCairoDBuffer()
#define CD_CAIRO_PRINTER cdContextCairoPrinter()
#define CD_CAIRO_PS cdContextCairoPS()
#define CD_CAIRO_PDF cdContextCairoPDF()
#define CD_CAIRO_SVG cdContextCairoSVG()
#define CD_CAIRO_IMAGERGB cdContextCairoImageRGB()
#define CD_CAIRO_EMF cdContextCairoEMF()

end extern
