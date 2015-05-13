''
''
'' Drawing -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Drawing_bi__
#define __Drawing_bi__

type Pixel as uinteger

declare sub XmuFillRoundedRectangle cdecl alias "XmuFillRoundedRectangle" (byval dpy as Display ptr, byval draw as Drawable, byval gc as GC, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval ew as integer, byval eh as integer)
declare sub XmuDrawLogo cdecl alias "XmuDrawLogo" (byval dpy as Display ptr, byval drawable as Drawable, byval gcFore as GC, byval gcBack as GC, byval x as integer, byval y as integer, byval width as uinteger, byval height as uinteger)
declare function XmuCreatePixmapFromBitmap cdecl alias "XmuCreatePixmapFromBitmap" (byval dpy as Display ptr, byval d as Drawable, byval bitmap as Pixmap, byval width as uinteger, byval height as uinteger, byval depth as uinteger, byval fore as uinteger, byval back as uinteger) as Pixmap
declare function XmuCreateStippledPixmap cdecl alias "XmuCreateStippledPixmap" (byval screen as Screen ptr, byval fore as Pixel, byval back as Pixel, byval depth as uinteger) as Pixmap
declare sub XmuReleaseStippledPixmap cdecl alias "XmuReleaseStippledPixmap" (byval screen as Screen ptr, byval pixmap as Pixmap)
declare function XmuReadBitmapData cdecl alias "XmuReadBitmapData" (byval fstream as FILE ptr, byval width_return as uinteger ptr, byval height_return as uinteger ptr, byval datap_return as ubyte ptr ptr, byval xhot_return as integer ptr, byval yhot_return as integer ptr) as integer

#endif
